package edu.arizona.kfs.fp.businessobject;

import java.math.BigDecimal;
import java.util.LinkedHashMap;

import org.kuali.rice.core.api.util.type.KualiDecimal;
import org.kuali.rice.krad.bo.PersistableBusinessObjectBase;

public class ProcurementCardTranAddItem extends PersistableBusinessObjectBase {

	private Integer transactionSequenceRowNumber;
	private Integer sequenceRowNumber;
	private String itemCommodityCode;
	private String itemProductCode;
	private String itemDescription;
	private BigDecimal itemQuantity;
	private String itemUnitCode;
	private KualiDecimal itemAmount;
	private String itemDebitCreditCode;
	private KualiDecimal itemTaxRate;
	private KualiDecimal itemTaxAmount;
	private KualiDecimal itemDiscountAmount;
	private KualiDecimal itemExtendedAmount;
	
	public Integer getTransactionSequenceRowNumber() {
		return transactionSequenceRowNumber;
	}
	
	public void setTransactionSequenceRowNumber(Integer transactionSequenceRowNumber) {
		this.transactionSequenceRowNumber = transactionSequenceRowNumber;
	}
	
	public Integer getSequenceRowNumber() {
		return sequenceRowNumber;
	}
	
	public void setSequenceRowNumber(Integer sequenceRowNumber) {
		this.sequenceRowNumber = sequenceRowNumber;
	}
	
	public String getItemCommodityCode() {
		return itemCommodityCode;
	}
	
	public void setItemCommodityCode(String itemCommodityCode) {
		this.itemCommodityCode = itemCommodityCode;
	}
	
	public String getItemProductCode() {
		return itemProductCode;
	}
	
	public void setItemProductCode(String itemProductCode) {
		this.itemProductCode = itemProductCode;
	}
	
	public String getItemDescription() {
		return itemDescription;
	}
	
	public void setItemDescription(String itemDescription) {
		this.itemDescription = itemDescription;
	}
	
	public BigDecimal getItemQuantity() {
		return itemQuantity;
	}
	
	public void setItemQuantity(BigDecimal itemQuantity) {
		this.itemQuantity = itemQuantity;
	}
	
	public String getItemUnitCode() {
		return itemUnitCode;
	}
	
	public void setItemUnitCode(String itemUnitCode) {
		this.itemUnitCode = itemUnitCode;
	}
	
	public KualiDecimal getItemAmount() {
		return itemAmount;
	}
	
	public void setItemAmount(KualiDecimal itemAmount) {
		this.itemAmount = itemAmount;
	}
	
	public String getItemDebitCreditCode() {
		return itemDebitCreditCode;
	}
	
	public void setItemDebitCreditCode(String itemDebitCreditCode) {
		this.itemDebitCreditCode = itemDebitCreditCode;
	}
	
	public KualiDecimal getItemTaxRate() {
		return itemTaxRate;
	}
	
	public void setItemTaxRate(KualiDecimal itemTaxRate) {
		this.itemTaxRate = itemTaxRate;
	}
	
	public KualiDecimal getItemTaxAmount() {
		return itemTaxAmount;
	}
	
	public void setItemTaxAmount(KualiDecimal itemTaxAmount) {
		this.itemTaxAmount = itemTaxAmount;
	}
	
	public KualiDecimal getItemDiscountAmount() {
		return itemDiscountAmount;
	}
	
	public void setItemDiscountAmount(KualiDecimal itemDiscountAmount) {
		this.itemDiscountAmount = itemDiscountAmount;
	}
	
	public KualiDecimal getItemExtendedAmount() {
		return itemExtendedAmount;
	}
	
	public void setItemExtendedAmount(KualiDecimal itemExtendedAmount) {
		this.itemExtendedAmount = itemExtendedAmount;
	}
	
	protected LinkedHashMap<String, Integer> toStringMapper() {
		LinkedHashMap<String, Integer> m = new LinkedHashMap<String, Integer>();
		m.put("transactionSquenceRowNumber", getTransactionSequenceRowNumber());
		m.put("sequenceRowNumber", getSequenceRowNumber());
		return m;
	}
}
