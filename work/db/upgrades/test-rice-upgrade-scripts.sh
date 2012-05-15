set -e -x
# Control Variables for Testing Parts of Scripts
IMPORT_OLD_PROJECT=${IMPORT_OLD_PROJECT:-true}
RUN_UPGRADE_SCRIPTS=${RUN_UPGRADE_SCRIPTS:-true}
EXPORT_UPGRADED_PROJECT=${EXPORT_UPGRADED_PROJECT:-true}
PERFORM_COMPARISON=${PERFORM_COMPARISON:-true}
REBUILD_SCHEMA=${REBUILD_SCHEMA:-true}

# Check for WORKSPACE (a Jenkins variable) and set if necessary so this script 
# can run outside of Hudson
if [[ -z "$WORKSPACE" ]]; then
	# Standard Variables from Jenkins
	ABSPATH=$(cd ${0%/*} && echo $PWD/${0##*/})
	WORKSPACE=`dirname $ABSPATH`
	echo Working Directory: $WORKSPACE
fi

ORACLE_TEST_DB_URL=${ORACLE_TEST_DB_URL:-jdbc:oracle:thin:@oraclerds.kfs.kuali.org:1521:KFS}
#MYSQL_TEST_DB_URL=jdbc:mysql://test.db.kfs.kuali.org:3306
MYSQL_TEST_DB_URL=${MYSQL_TEST_DB_URL:-jdbc:mysql://localhost:3306}

# Ensure we are in the right directory
cd $WORKSPACE

# Parameters to job
UPGRADE_SCRIPT_DIR=$WORKSPACE/kfs/work/db/upgrades/${UPGRADE_SCRIPT_DIR:-4.1.1_5.0}

DB_TYPE=${DB_TYPE:-MYSQL}
DB_USER=${DB_USER:-dbtest}
DB_SCHEMA=${DB_SCHEMA:-$DB_USER}
DB_ADMIN_USER=${DB_ADMIN_USER:-root}
DB_PASSWORD=${DB_PASSWORD:-$DB_USER}
DB_ADMIN_PASSWORD=${DB_ADMIN_PASSWORD:-}

# Set some properties based on the database type
if [[ "$DB_TYPE" == "MYSQL" ]]; then
  DATASOURCE=$MYSQL_TEST_DB_URL/$DB_SCHEMA
  ADMIN_DATASOURCE=$MYSQL_TEST_DB_URL
  DRIVER=com.mysql.jdbc.Driver
  OJB_PLATFORM=MySQL
  TORQUE_PLATFORM=mysql
else
  DATASOURCE=$ORACLE_TEST_DB_URL
  ADMIN_DATASOURCE=$ORACLE_TEST_DB_URL
  DRIVER=oracle.jdbc.OracleDriver
  OJB_PLATFORM=Oracle9i
  TORQUE_PLATFORM=oracle
fi

set $WORKSPACE/kfs/build/drivers/*.jar
DRIVER_CLASSPATH=$(IFS=:; echo "$*")
cd $WORKSPACE

# create the needed liquibase.properties file
(
cat <<-EOF
	classpath=$DRIVER_CLASSPATH
	driver=$DRIVER
	url=$DATASOURCE
	username=$DB_USER
	password=$DB_PASSWORD		
EOF
) > $WORKSPACE/liquibase.properties

if [[ "$IMPORT_OLD_PROJECT" == "true" ]]; then
	
	# Prepare a tomcat directory that can be written to
	rm -rf $WORKSPACE/tomcat
	mkdir -p $WORKSPACE/tomcat/common/lib
	mkdir -p $WORKSPACE/tomcat/common/classes
	
	# Lower-case the table names in case we are running against MySQL on Amazon RDS
	perl -pi -e 's/dbTable="([^"]*)"/dbTable="\U\1"/g' $WORKSPACE/old_data/development/graphs/*.xml

	(
	cat <<-EOF
		import.torque.database.user=$DB_USER
		import.torque.database.schema=$DB_SCHEMA
		import.torque.database.password=$DB_PASSWORD

		torque.project=kfs
		torque.schema.dir=$WORKSPACE/old_data/rice
		torque.sql.dir=\${torque.schema.dir}/sql
		torque.output.dir=\${torque.schema.dir}/sql

		import.torque.database=$TORQUE_PLATFORM
		import.torque.database.driver=$DRIVER
		import.torque.database.url=$DATASOURCE

		import.admin.user=$DB_ADMIN_USER
		import.admin.password=$DB_ADMIN_PASSWORD
		import.admin.url=$ADMIN_DATASOURCE

		oracle.usermaint.user=kulusermaint
		
		post.import.liquibase.project=kfs
		post.import.liquibase.xml.directory=$WORKSPACE/old_kfs/work/db/rice-data
		post.import.liquibase.contexts=bootstrap,demo
		
		post.import.workflow.project=kfs
		post.import.workflow.xml.directory=$WORKSPACE/old_kfs/work/workflow
		post.import.workflow.ingester.launcher.ant.script=$WORKSPACE/old_kfs/build.xml
		post.import.workflow.ingester.launcher.ant.target=import-workflow-xml
		post.import.workflow.ingester.launcher.ant.xml.directory.property=workflow.dir
		
		post.import.workflow.ingester.jdbc.url.property=datasource.url
		post.import.workflow.ingester.username.property=datasource.username
		post.import.workflow.ingester.password.property=datasource.password
		post.import.workflow.ingester.additional.command.line=-Ddatasource.ojb.platform=$OJB_PLATFORM -Dbase.directory=$WORKSPACE -Dappserver.home=$WORKSPACE/tomcat -Dexternal.config.directory=$WORKSPACE/opt -Dis.local.build= -Ddev.mode= -Drice.dev.mode=true -Drice.ksb.batch.mode=true -Ddont.filter.project.rice= -Ddont.filter.project.spring.ide=

EOF
	) > $WORKSPACE/impex-build.properties

	if [[ "$DB_TYPE" == "MYSQL" ]]; then
		perl -pi -e 's/dbTable="([^"]*)"/dbTable="\U\1"/g' $WORKSPACE/old_data/rice/graphs/*.xml
		perl -pi -e 's/viewdefinition="([^"]*)"/viewdefinition="\U\1"/g' $WORKSPACE/old_data/rice/schema.xml
		perl -pi -e 's/&#[^;]*;/ /gi' $WORKSPACE/old_data/rice/schema.xml
	fi
	
	pushd $WORKSPACE/kfs/work/db/kfs-db/db-impex/impex
	#ant "-Dimpex.properties.file=$WORKSPACE/impex-build.properties" drop-schema create-schema import
	if [[ "$REBUILD_SCHEMA" == "true" ]]; then
		ant "-Dimpex.properties.file=$WORKSPACE/impex-build.properties" drop-schema create-schema create-ddl apply-ddl import-data apply-constraint-ddl
	fi
	ant "-Dimpex.properties.file=$WORKSPACE/impex-build.properties" run-liquibase-post-import
	ant "-Dimpex.properties.file=$WORKSPACE/impex-build.properties" import-workflow
	popd
	cp $WORKSPACE/old_data/rice/schema.xml $WORKSPACE/old_schema.xml
	
fi

if [[ "$RUN_UPGRADE_SCRIPTS" == "true" ]]; then
	pushd $UPGRADE_SCRIPT_DIR/rice_server

	rm -f $WORKSPACE/upgrade.sql
	touch $WORKSPACE/upgrade.sql
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=kim_upgrade_pre_rice_20.xml updateSQL >> $WORKSPACE/upgrade.sql
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=rice-server-script.xml updateSQL >> $WORKSPACE/upgrade.sql
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=kew_upgrade.xml updateSQL > $WORKSPACE/upgrade.sql
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=kim_upgrade.xml updateSQL >> $WORKSPACE/upgrade.sql
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=parameter_updates.xml updateSQL >> $WORKSPACE/upgrade.sql

	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=kim_upgrade_pre_rice_20.xml update
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=rice-server-script.xml update
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=kew_upgrade.xml update
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=kim_upgrade.xml update
	java -jar ../liquibase*.jar --defaultsFile=$WORKSPACE/liquibase.properties --logLevel=finest --changeLogFile=parameter_updates.xml update
	popd
fi



# run the export target
if [[ "$EXPORT_UPGRADED_PROJECT" == "true" ]]; then
	mkdir -p $WORKSPACE/upgraded_data
	(
	cat <<-EOF
		export.torque.database.user=$DB_USER
		export.torque.database.schema=$DB_SCHEMA
		export.torque.database.password=$DB_PASSWORD

		torque.project=kfs
		torque.schema.dir=$WORKSPACE/upgraded_data
		torque.sql.dir=\${torque.schema.dir}/sql
		torque.output.dir=\${torque.schema.dir}/sql

		export.torque.database=$TORQUE_PLATFORM
		export.torque.database.driver=$DRIVER
		export.torque.database.url=$DATASOURCE
		
		export.table.name.filter=^(?!.*(_BKUP)).*\$
	EOF
	) > $WORKSPACE/impex-build.properties
	pushd $WORKSPACE/kfs/work/db/kfs-db/db-impex/impex
	ant "-Dimpex.properties.file=$WORKSPACE/impex-build.properties" jdbc-to-xml
	popd
	cp $WORKSPACE/upgraded_data/schema.xml $WORKSPACE/upgraded_schema.xml
fi

# Compare the schema.xml files

if [[ "$PERFORM_COMPARISON" == "true" ]]; then
	cd $WORKSPACE
	cp $WORKSPACE/kfs/work/db/kfs-db/rice/schema.xml $WORKSPACE/new_schema.xml
	# Sanitize the sequence next values
	perl -pi -e 's/nextval="[^"]*"/nextval="0"/g' upgraded_schema.xml
	perl -pi -e 's/nextval="[^"]*"/nextval="0"/g' new_schema.xml

	# Remove some extra control characters from the view
	perl -pi -e 's/&#xa;//g' upgraded_schema.xml
	perl -pi -e 's/&#xa;//g' new_schema.xml

	if [[ "$DB_TYPE" == "MYSQL" ]]; then
		# MySQL exports timestamps as timestamps, and Oracle does them as dates
		perl -pi -e 's/type="TIMESTAMP"/type="DATE"/g' new_schema.xml

		# remove columm defaults, they are handled differently
		perl -pi -e 's/ default=".+?"//g' upgraded_schema.xml
		perl -pi -e 's/ default=".+?"//g' new_schema.xml

		# Views come out *completely* differently - need to exclude them
		perl -pi -e 's/<view .+?\/>//g' upgraded_schema.xml
		perl -pi -e 's/<view .+?\/>//g' new_schema.xml
	fi

	diff -b -i -B -U 3 upgraded_schema.xml new_schema.xml > compare-results.txt || true
fi
exit 0
