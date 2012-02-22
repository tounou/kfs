/*
 * Copyright 2011 The Kuali Foundation.
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
package org.kuali.kfs.module.cam.businessobject;

import java.util.LinkedHashMap;

import org.kuali.kfs.sys.context.SpringContext;
import org.kuali.rice.kew.doctype.bo.DocumentTypeEBO;
import org.kuali.rice.kew.service.impl.KEWModuleService;
import org.kuali.rice.kns.bo.Inactivateable;
import org.kuali.rice.kns.bo.PersistableBusinessObjectBase;
import org.kuali.rice.kns.util.ObjectUtils;

/**
 * 
 * This class is to store document type use by the asset global document - Asset Payment tab.
 */

public class AssetPaymentDocumentType extends PersistableBusinessObjectBase implements Inactivateable {
    private Long documentTypeId;
    private String expenditureFinancialDocumentTypeCode;
    private String label;
    private boolean active;
    
    private DocumentTypeEBO financialSystemDocumentTypeCode;
    
    
    
    public Long getDocumentTypeId() {
        return documentTypeId;
    }




    public void setDocumentTypeId(Long documentTypeId) {
        this.documentTypeId = documentTypeId;
    }






    public String getExpenditureFinancialDocumentTypeCode() {
        return expenditureFinancialDocumentTypeCode;
    }




    public void setExpenditureFinancialDocumentTypeCode(String expenditureFinancialDocumentTypeCode) {
        this.expenditureFinancialDocumentTypeCode = expenditureFinancialDocumentTypeCode;
    }




    public String getLabel() {
        if(!ObjectUtils.isNull(getFinancialSystemDocumentTypeCode())) {
            return  getFinancialSystemDocumentTypeCode().getLabel();
        }
        return "";
    }




    public void setLabel(String label) {
        this.label = label;
    }


    public boolean isActive() {
        return active;
    }


    public void setActive(boolean active) {
        this.active = active;
    }




    /**
     * Gets the financialSystemDocumentTypeCode attribute. 
     * @return Returns the financialSystemDocumentTypeCode.
     */
    public DocumentTypeEBO getFinancialSystemDocumentTypeCode() {
        return financialSystemDocumentTypeCode = SpringContext.getBean(KEWModuleService.class).retrieveExternalizableBusinessObjectIfNecessary(this, financialSystemDocumentTypeCode, "financialSystemDocumentTypeCode");
    }

    @Override
    protected LinkedHashMap toStringMapper() {
        LinkedHashMap m = new LinkedHashMap();
        if (this.documentTypeId != null) {
            m.put("documentTypeId", this.documentTypeId.toString());
        }
        return m;
            
    }
    
    
    
}
