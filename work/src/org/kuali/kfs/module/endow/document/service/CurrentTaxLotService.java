/*
 * Copyright 2010 The Kuali Foundation.
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
package org.kuali.kfs.module.endow.document.service;

import java.math.BigDecimal;

import org.kuali.kfs.module.endow.businessobject.CurrentTaxLotBalance;
import org.kuali.kfs.module.endow.businessobject.HoldingTaxLot;
import org.kuali.rice.kns.util.KualiInteger;

public interface CurrentTaxLotService {

    /**
     * Gets a current tax lot based on primary keys: kemid, security id, registration code, lot number and IP indicator.
     * 
     * @param kemid
     * @param securityId
     * @param registrationCode
     * @param lotNumber
     * @param ipIndicator
     * @return the corresponding tax lot
     */
    public CurrentTaxLotBalance getByPrimaryKey(String kemid, String securityId, String registrationCode, KualiInteger lotNumber, String ipIndicator);

    /**
     * updates a current tax lot
     * 
     * @param currentTaxLotBalance
     */
    public void updateCurrentTaxLotBalance(CurrentTaxLotBalance currentTaxLotBalance);  
    
    /**
     * clears all the records from the CurrentTaxLotBalance table.
     */
    public void clearAllCurrentTaxLotRecords();
    
    /**
     * Method to copy HoldingTaxLot record to currentTaxLotBalance record
     * @param holdingTaxLot
     * @return currentTaxLotBalance
     */
    public CurrentTaxLotBalance copyHoldingTaxLotToCurrentTaxLotBalance(HoldingTaxLot holdingTaxLot);
    
    /**
     * Method to get the security unit value for the current balance tax lot record
     * @param securityId
     * @return securityUnitValue
     */
    public BigDecimal getCurrentTaxLotBalanceSecurityUnitValue(String securityId);
    
    /**
     * Method to calculate Next Twelve Months Estimated value
     * @param securityId
     * @return nextTwelveMonthsEstimatedValue
     */
    public BigDecimal getNextTwelveMonthsEstimatedValue(HoldingTaxLot holdingTaxLot, String securityId);
    
    /**
     * Method to calculate remainder of fiscal year estimated income
     * @param securityId
     * @return remainderOfFiscalYearEstimatedIncome
     */
    public BigDecimal getRemainderOfFiscalYearEstimatedIncome(HoldingTaxLot holdingTaxLot, String securityId);
    
    /**
     * Method to calculate next fiscal year investment income
     * @param securityId
     * @return nextFiscalyearInvestmentIncome
     */
    public BigDecimal getNextFiscalYearInvestmentIncome(HoldingTaxLot holdingTaxLot, String securityId);    
}
