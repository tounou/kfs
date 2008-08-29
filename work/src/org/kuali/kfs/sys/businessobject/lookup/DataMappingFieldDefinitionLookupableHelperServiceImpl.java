/*
 * Copyright 2007 The Kuali Foundation.
 * 
 * Licensed under the Educational Community License, Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.opensource.org/licenses/ecl1.php
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.kfs.sys.businessobject.lookup;

import java.util.ArrayList;
import java.util.List;

import org.apache.ojb.broker.metadata.DescriptorRepository;
import org.kuali.kfs.sys.KFSPropertyConstants;
import org.kuali.kfs.sys.businessobject.DataMappingFieldDefinition;
import org.kuali.kfs.sys.businessobject.FunctionalFieldDescription;
import org.kuali.rice.kns.bo.BusinessObject;

public class DataMappingFieldDefinitionLookupableHelperServiceImpl extends FunctionalFieldDescriptionLookupableHelperServiceImpl {

    private DescriptorRepository ojbRepository;

    @Override
    public List<? extends BusinessObject> getSearchResults(java.util.Map<String, String> fieldValues) {
        fieldValues.put(KFSPropertyConstants.BUSINESS_OBJECT_PROPERTY_COMPONENT_LABEL, fieldValues.get(KFSPropertyConstants.FUNCTIONAL_FIELD_DESCRIPTION_BUSINESS_OBJECT_PROPERTY_COMPONENT_LABEL));
        fieldValues.remove(KFSPropertyConstants.FUNCTIONAL_FIELD_DESCRIPTION_BUSINESS_OBJECT_PROPERTY_COMPONENT_LABEL);
        fieldValues.put(KFSPropertyConstants.BUSINESS_OBJECT_PROPERTY_LABEL, fieldValues.get(KFSPropertyConstants.FUNCTIONAL_FIELD_DESCRIPTION_BUSINESS_OBJECT_PROPERTY_LABEL));
        fieldValues.remove(KFSPropertyConstants.FUNCTIONAL_FIELD_DESCRIPTION_BUSINESS_OBJECT_PROPERTY_LABEL);
        List<FunctionalFieldDescription> functionalFieldDescriptions = (List<FunctionalFieldDescription>) super.getSearchResults(fieldValues);
        fieldValues.put(KFSPropertyConstants.FUNCTIONAL_FIELD_DESCRIPTION_BUSINESS_OBJECT_PROPERTY_COMPONENT_LABEL, fieldValues.get(KFSPropertyConstants.BUSINESS_OBJECT_PROPERTY_COMPONENT_LABEL));
        fieldValues.remove(KFSPropertyConstants.BUSINESS_OBJECT_PROPERTY_COMPONENT_LABEL);
        fieldValues.put(KFSPropertyConstants.FUNCTIONAL_FIELD_DESCRIPTION_BUSINESS_OBJECT_PROPERTY_LABEL, fieldValues.get(KFSPropertyConstants.BUSINESS_OBJECT_PROPERTY_LABEL));
        fieldValues.remove(KFSPropertyConstants.BUSINESS_OBJECT_PROPERTY_LABEL);

        List<DataMappingFieldDefinition> dataMappingFieldDefinitions = new ArrayList<DataMappingFieldDefinition>();
        for (FunctionalFieldDescription functionalFieldDescription : functionalFieldDescriptions) {
            DataMappingFieldDefinition dataMappingFieldDefinition = new DataMappingFieldDefinition(functionalFieldDescription, getDataDictionaryService().getDataDictionary().getBusinessObjectEntry(functionalFieldDescription.getComponentClass()), getOjbRepository().getDescriptorFor(functionalFieldDescription.getComponentClass()), getDataDictionaryService().getDataDictionary().getBusinessObjectEntry(functionalFieldDescription.getComponentClass()).getAttributeDefinition(functionalFieldDescription.getPropertyName()));
            dataMappingFieldDefinitions.add(dataMappingFieldDefinition);
        }
        return dataMappingFieldDefinitions;
    }

    private DescriptorRepository getOjbRepository() {
        if (ojbRepository == null) {
            ojbRepository = org.apache.ojb.broker.metadata.MetadataManager.getInstance().getGlobalRepository();
        }
        return ojbRepository;
    }
}
