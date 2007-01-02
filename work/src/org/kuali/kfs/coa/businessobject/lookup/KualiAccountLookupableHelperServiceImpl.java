/*
 * Copyright 2006 The Kuali Foundation.
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
package org.kuali.module.chart.lookup;

import org.kuali.core.bo.PersistableBusinessObject;
import org.kuali.core.lookup.KualiLookupableHelperServiceImpl;
import org.kuali.core.util.GlobalVariables;
import org.kuali.module.chart.bo.Account;
import org.kuali.module.chart.bo.ChartUser;

public class KualiAccountLookupableHelperServiceImpl extends KualiLookupableHelperServiceImpl {
    /**
     * @returns links to edit and copy maintenance action for the current maintenance record.
     */
    @Override
    public String getActionUrls(PersistableBusinessObject bo) {
        StringBuffer actions = new StringBuffer();
        Account theAccount = (Account)bo;
        ChartUser user = (ChartUser)GlobalVariables.getUserSession().getUniversalUser().getModuleUser( ChartUser.MODULE_ID );
        if (!theAccount.isAccountClosedIndicator()||user.isAdministratorUser()){
            actions.append(getMaintenanceUrl(bo, "edit"));
        }else{
            actions.append("&nbsp;&nbsp;&nbsp;&nbsp;");
        }
        actions.append("&nbsp;&nbsp;");
        actions.append(getMaintenanceUrl(bo, "copy"));
        return actions.toString();
    }
}