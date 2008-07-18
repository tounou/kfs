<%--
 Copyright 2006-2007 The Kuali Foundation.
 
 Licensed under the Educational Community License, Version 1.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.opensource.org/licenses/ecl1.php
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
--%>
<%@ include file="/jsp/kfs/kfsTldHeader.jsp"%>

<c:set var="readOnly" value="${!empty KualiForm.editingMode['viewOnly']}" />
<c:set var="paymentApplicationDocumentAttributes" value="${DataDictionary['PaymentApplicationDocument'].attributes}" />
<c:set var="invoiceAttributes" value="${DataDictionary['CustomerInvoiceDocument'].attributes}" />
<c:set var="customerAttributes" value="${DataDictionary['Customer'].attributes}" />
<c:set var="unappliedAttributes" value="${DataDictionary['NonAppliedHolding'].attributes}" />
<c:set var="readOnly" value="${!empty KualiForm.editingMode['viewOnly']}" />
<c:set var="hasRelatedCashControlDocument" value="${null != KualiForm.cashControlDocumentForPaymentApplicationDocument}" />
<c:set var="cashControlDocument" value="${KualiForm.cashControlDocumentForPaymentApplicationDocument}" />
<c:set var="isCustomerSelected" value="${!empty KualiForm.customerNumber}" />

<kul:documentPage showDocumentInfo="true"
  documentTypeName="PaymentApplicationDocument"
  htmlFormAction="arPaymentApplicationDocument" renderMultipart="true"
  showTabButtons="true">

  <kfs:hiddenDocumentFields />

  <kfs:documentOverview editingMode="${KualiForm.editingMode}" />

  <kul:tab tabTitle="Control Information" defaultOpen="${hasRelatedCashControlDocument}"
    tabErrorKey="${KFSConstants.CASH_CONTROL_DOCUMENT_ERRORS}">
    
    <div class="tab-container" align="center">
    	
    	<c:choose>
    		<c:when test="${!hasRelatedCashControlDocument}">
    			No related Cash Control Document.
    		</c:when>
    		<c:otherwise>
		      <div style='text-align: right; margin-top: 20px; padding: 2px 6px; width: 98%;'>
		      	<style type='text/css'>
		      		#ctrl-info th { text-align: right; }
		      		#ctrl-info th, #ctrl-info td { width: 50%; }
		      	</style>
		        <table id='ctrl-info' width="100%" cellpadding="0" cellspacing="0" class="datatable">
		          <tr>
		          	<th>Org Doc #</th>
		          	<td>${cashControlDocument.documentNumber}</td>
		          </tr>
		          <tr>
		          	<th>Customer</th>
		          	<td>${KualiForm.customer.customerNumber}</td>
		          </tr>
		          <tr>
		          	<th>Control Total</th>
		          	<td>${cashControlDocument.cashControlTotalAmount}</td>
		          </tr>
		          <tr>
		          	<th>Balance</th>
		          	<td>TODO</td>
		          </tr>
		          <tr>
		          	<th>Payment #</th>
		          	<td>TODO</td>
		          </tr>
		        </table>
		      </div>
      		</c:otherwise>
    	</c:choose>
   </div>
  </kul:tab>
  
  <script type='text/javascript'>
    function toggle(id) {
      var v=document.getElementById(id); 
      if('none' != v.style.display) {
        v.style.display='none';
      } else {
        v.style.display='';
      }
    }
  </script>

	<kul:tab tabTitle="Summary of Applied Funds" defaultOpen="${isCustomerSelected}"
		tabErrorKey="${KFSConstants.PAYMENT_APPLICATION_DOCUMENT_ERRORS}">
	    <div class="tab-container" align="center">
		    <c:choose>
		    	<c:when test="${!isCustomerSelected}">
		    		No Customer Selected
		    	</c:when>
	    		<c:otherwise>
					<table width="100%" cellpadding="0" cellspacing="0" class="datatable">
						<tr>
							<td style='vertical-align: top;' colspan='2'>
								<c:choose>
									<c:when test="${empty KualiForm.document.appliedPayments}">
								   		No applied payments.
								   	</c:when>
								   	<c:otherwise>
							           <table width="100%" cellpadding="0" cellspacing="0" class="datatable">
							             <tr>
							               <td colspan='4' class='tab-subhead'>Unapplied Funds</td>
							             </tr>
							             <tr>
							               <th>Invoice Nbr</th>
							               <th>Item #</th>
							               <th>Inv Item Desc</th>
							               <th>Applied Amount</th>
							             </tr>
							            <logic:iterate id="appliedPayment" name="KualiForm" property="document.appliedPayments" indexId="ctr">
                   
                
				    		               <tr>
				    		               		<html:hidden property="document.appliedPayment[${ctr}].documentNumber" />
		                                        <html:hidden property="document.appliedPayment[${ctr}].versionNumber" />
		                                        <html:hidden property="document.appliedPayment[${ctr}].objectId" />
				    			              <td><c:out value="${appliedPayment.financialDocumentReferenceInvoiceNumber}"/>
				    			              <html:hidden property="document.appliedPayment[${ctr}].financialDocumentReferenceInvoiceNumber" /></td>
				    			              <td><c:out value="${appliedPayment.invoiceItemNumber}"/>
				    			              <html:hidden property="document.appliedPayment[${ctr}].invoiceItemNumber" />
				    			              </td>
				    			              <td><c:out value="${appliedPayment.invoiceItem.financialDocumentLineDescription}"/>
				    			              <html:hidden property="document.appliedPayment[${ctr}].invoiceItem.financialDocumentLineDescription" />
				    			              </td>
				    			              <td>$<c:out value="${appliedPayment.invoiceItemAppliedAmount}"/>
				    			              <html:hidden property="document.appliedPayment[${ctr}].invoiceItemAppliedAmount" />
				    			              </td>
				    		               </tr>
				    		               </logic:iterate>
				    	                 
							           </table>	    	
							     	</c:otherwise>
							   </c:choose>
							</td>
							<td valign='top'>
					        	<table class='datatable'>
									<tr>
										<c:if test="${!hasRelatedCashControlDocument and 0 lt KualiForm.document.totalUnappliedFunds}">
											<th class='tab-subhead'>Total Unapplied Funds</th>
											<th class='tab-subhead'>Unapplied Funds to be Applied</th>
										</c:if>
										<c:if test="${hasRelatedCashControlDocument}">
											<th class='tab-subhead'>Cash Control</th>
											<th class='tab-subhead'>Total to be Applied</th>
										</c:if>
										<th class='tab-subhead'>Applied Amount</th>
									</tr>
									<tr>
										<c:if test="${!hasRelatedCashControlDocument and 0 lt KualiForm.document.totalUnappliedFunds}">
											<td>$<c:out value="${KualiForm.document.totalUnappliedFunds}"/></td>
											<td>$<c:out value="${KualiForm.document.totalUnappliedFundsToBeApplied}"/></td>
										</c:if>
										<c:if test="${hasRelatedCashControlDocument}">
											<td>$<c:out value="${KualiForm.cashControlTotalForPaymentApplicationDocument}"/></td>
											<td>$<c:out value="${KualiForm.document.totalToBeApplied}"/></td>
										</c:if>
										<td>$<c:out value="${KualiForm.document.totalAppliedAmount}"/></td>
									</tr>
								</table>
							<td>
						</tr>
					</table>
				</c:otherwise>
			</c:choose>
	    </div>
	</kul:tab>
  
	<kul:tab tabTitle="Quick Apply to Invoice" defaultOpen="${isCustomerSelected}"
		tabErrorKey="${KFSConstants.PAYMENT_APPLICATION_DOCUMENT_ERRORS}">
		<div class="tab-container" align="center">
		
			<c:choose>
		      	<c:when test="${null == KualiForm.customer}">
		      		No Customer Selected
		      	</c:when>
		      	<c:otherwise>
					<table width="100%" cellpadding="0" cellspacing="0" class="datatable">
						<tr>
					   		<th>Invoice Number</th>
					   		<th>Open Amount</th>
					   		<th>Quick Apply</th>
						</tr>
				    	<c:forEach items="${KualiForm.invoices}" var="invoice">
				    		<tr>
				    			<td><c:out value="${invoice.documentNumber}"/></td>
				    			<td>$<c:out value="${invoice.balance}"/></td>
				    			<td><input type="checkbox" name="quickApply" value="${invoice.documentNumber}" /></td>
				    		</tr>
				    	</c:forEach>
						<tr>
							<td colspan='3' style='text-align: right;'>
								<html:image property="methodToCall.quickApply"
									src="${ConfigProperties.externalizable.images.url}tinybutton-load.gif"
									alt="Quick Apply"
									title="Quick Apply"
									styleClass="tinybutton" />
							</td>
						</tr>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</kul:tab>
  
	<kul:tab tabTitle="Apply to Invoice Detail" defaultOpen="true"
		tabErrorKey="${KFSConstants.PAYMENT_APPLICATION_DOCUMENT_ERRORS}">
		<div class="tab-container" align="center">
			<table width="100%" cellpadding="0" cellspacing="0" class="datatable">
		        <tr>
		        	<th>Customer</th>
					<td>
						<kul:htmlControlAttribute
							attributeEntry="${customerAttributes.customerNumber}"
							property="customerNumber"/>
						<kul:lookup boClassName="org.kuali.kfs.module.ar.businessobject.Customer" 
							fieldConversions="customerNumber:customer.customerNumber" />
					</td>
				</tr>
		        <tr>
		        	<th width='50%'>Invoice</th>
					<td>
						<kul:htmlControlAttribute
							attributeEntry="${invoiceAttributes.organizationInvoiceNumber}"
							property="selectedInvoiceDocumentNumber"/>
					</td>
				</tr>
				<tr>
					<td colspan='2'>
						<center>
							<html:image property="methodToCall.setCustomer"
								src="${ConfigProperties.externalizable.images.url}tinybutton-load.gif"
								alt="Load Invoices"
								title="Load Invoices"
								styleClass="tinybutton" />
						</center>
					</td>
				</tr>
			</table>
			<c:choose>
		      	<c:when test="${null == KualiForm.customer}">
		      	</c:when>
		      	<c:otherwise>
					<table width="100%" cellpadding="0" cellspacing="0" class="datatable">
					  <tr id='beta_zeta'>
					    <td>
					      <table width="100%" cellpadding="0" cellspacing="0" class="datatable">
					        <tr>
					          <td colspan='2' class='tab-subhead'>
					            Invoices
					            <select name="goToInvoiceDocumentNumber">
					            	<c:forEach items="${KualiForm.invoices}" var="invoice">
					            		<c:choose>
						            		<c:when test="${invoice.documentNumber eq KualiForm.selectedInvoiceDocumentNumber}">
							            		<option selected><c:out value="${invoice.documentNumber}" /></option>
						            		</c:when>
						            		<c:otherwise>
							            		<option><c:out value="${invoice.documentNumber}" /></option>
						            		</c:otherwise>
					            		</c:choose>
					            	</c:forEach>
					            </select>
								<html:image property="methodToCall.goToInvoice"
									src="${ConfigProperties.externalizable.images.url}tinybutton-load.gif"
									alt="Go To Invoice"
									title="Go To Invoice"
									styleClass="tinybutton" />
					          </td>
					        </tr>
					        <tr>
					        	<th colspan='2' class='tab-subhead'>
					        		<c:out value="Invoice ${KualiForm.selectedInvoiceDocumentNumber}" />&nbsp;
					        		<c:if test="${!empty KualiForm.previousInvoiceDocumentNumber}">
										<c:out escapeXml="false" value="<a href='arPaymentApplicationDocument.do?methodToCall=setCustomer&selectedInvoiceDocumentNumber=${KualiForm.previousInvoiceDocumentNumber}&document.documentNumber=${KualiForm.document.documentNumber}'><- Previous Invoice</a>" />
						        	</c:if>
						        	<c:if test="${!empty KualiForm.previousInvoiceDocumentNumber && !empty KualiForm.nextInvoiceDocumentNumber}">|</c:if>
					        		<c:if test="${!empty KualiForm.nextInvoiceDocumentNumber}">
										<c:out escapeXml="false" value="<a href='arPaymentApplicationDocument.do?methodToCall=setCustomer&selectedInvoiceDocumentNumber=${KualiForm.nextInvoiceDocumentNumber}&document.documentNumber=${KualiForm.document.documentNumber}'>Next Invoice -></a>" />
						        	</c:if>
					        	</th>
					        </tr>
					        <tr>
					          <td colspan='2'>
					            <table width='100%' cellpadding='0' cellspacing='0' class='datatable'>
					              <tr>
					                <th>Invoice Number</th>
					                <th>Invoice Header/Custom Name</th>
					                <th>Balance/Total</th>
					                <th>Amount Applied to Invoice</th>
					              </tr>
					              <tr>
					                <td>${KualiForm.selectedInvoiceDocumentNumber}</td>
					                <td><input type='text' value='${KualiForm.selectedInvoiceDocument.accountsReceivableDocumentHeader.financialDocumentExplanationText}'></td>
					                <td><input type='text' value='${KualiForm.balanceForSelectedInvoiceDocument}'></td>
					                <td rowspan='2' style='vertical-align: top;'>${KualiForm.amountAppliedDirectlyToInvoice}</td>
					              </tr>
					              <tr>
					                <td>&nbsp;</td>
					                <td><input type='text' value='${KualiForm.selectedInvoiceDocument.accountsReceivableDocumentHeader.customer.customerName}'></td>
					                <td><input type='text' value='${KualiForm.totalAmountForSelectedInvoiceDocument}'></td>
					              </tr>
					              <tr>
					                <td colspan='4' class='tab-subhead'>Invoice Detail</td>
					              </tr>
					              <tr>
					                <td colspan='4'>
					                  <table width='100%' cellpadding='0' cellspacing='0' class='datatable'>
					                    <tr>
					                      <th>&nbsp;</th>
					                      <th>Chart</th>
					                      <th>Account</th>
					                      <th>Item Desc</th>
					                      <th>Item Tot Amt</th>
					                      <th>Dtl Balance</th>
					                      <th>Apply Amount</th>
					                      <th>Apply Full Amount</th>
					                    </tr>
					                    <c:forEach items="${KualiForm.customerInvoiceDetailsForSelectedCustomerInvoiceDocument}" var="customerInvoiceDetail">
						                    <tr>
						                      <td><input type='text' size='2' value='${customerInvoiceDetail.sequenceNumber}'></td>
						                      <td>${customerInvoiceDetail.chartOfAccountsCode}</td>
						                      <td>${customerInvoiceDetail.accountNumber}</td>
						                      <td><input type='text' value='${customerInvoiceDetail.invoiceItemDescription}'></td>
						                      <td><input type='text' value='${customerInvoiceDetail.amount}'></td>
						                      <td><input type='text' value='${customerInvoiceDetail.balance}'></td>
						                      <td><input type='text' name="amountToBeApplied_${customerInvoiceDetail.sequenceNumber}" value="${customerInvoiceDetail.appliedAmount}"></td>
						                      <td><input type='checkbox' name="fullApply" value="${customerInvoiceDetail.sequenceNumber}"></td>
						                    </tr>
					                    </c:forEach>
					                  </table>
					                </td>
					              </tr>
					              <tr>
					              	<td style='text-align: right;' colspan='4'>
										<html:image property="methodToCall.apply"
											src="${ConfigProperties.externalizable.images.url}tinybutton-load.gif"
											alt="Apply"
											title="Apply"
											styleClass="tinybutton" />
					              	</td>
					              </tr>
					            </table>
					          </td>
					        </tr>
					      </table>
					    </td>
					  </tr>
					  <tr style='display: none;'>
					    <td class="subhead">
					      <span class="subhead-left">VELIZ COMPANY (ALA17234)</span>
					      <span class="subhead-right">
					        <c:set var="toggle" value="hide"/>
					        <html:image property="methodToCall.${toggle}Details" 
					          src="${ConfigProperties.kr.externalizable.images.url}det-${toggle}.gif"
					          onclick="toggle('veliz'); return false;" alt="${toggle} transaction details" 
					          title="${toggle} transaction details" styleClass="tinybutton"/>
					      </span>
					    </td>
					  </tr>
					  <tr id='veliz' style='display: none;'>
					    <td>
					      <table width="100%" cellpadding="0" cellspacing="0" class="datatable">
					        <tr>
					          <td style='vertical-align: top;'>
					            <table width="100%" cellpadding="0" cellspacing="0" class="datatable">
					              <tr>
					                <td colspan='4' class='tab-subhead'>Unapplied</td>
					              </tr>
					              <tr>
					                <th>Sequence</th>
					                <th>Doc Nbr</th>
					                <th>Type</th>
					                <th>Amount Available</th>
					              </tr>
					            </table>
					          </td>
					          <td>
					            <table class='datatable'>
					              <tr>
					                <th class='tab-subhead'>Cash Control</th>
					              </tr>
					              <tr>
					                <td><input type='text'/></td>
					              </tr>
					              <tr>
					                <th class='tab-subhead'>Non-AR</th>
					              </tr>
					              <tr>
					                <td><input type='text'/></td>
					              </tr>
					            </table>
					          </td>
					        </tr>
					        <tr>
					          <td colspan='2' class='tab-subhead'>
					            Invoice
					          </td>
					        </tr>
					        <tr>
					          <td colspan='2'>
					            <table width='100%' cellpadding='0' cellspacing='0' class='datatable'>
					              <tr>
					                <th>Sequence</th>
					                <th>Invoice Number</th>
					                <th>Invoice Header/Custom Name</th>
					                <th>Balance/Total</th>
					              </tr>
					              <tr>
					                <td>01</td>
					                <td>AB1234567</td>
					                <td><input type='text' value='INVOICE HEADER TEXT'></td>
					                <td><input type='text' value='115.00'></td>
					              </tr>
					              <tr>
					                <td>&nbsp;</td>
					                <td>&nbsp;</td>
					                <td><input type='text' value='ABBOTT NORTHWESTERN H'></td>
					                <td><input type='text' value='115.00'></td>
					              </tr>
					              <tr>
					                <td colspan='4' class='tab-subhead'>Invoice Detail</td>
					              </tr>
					              <tr>
					                <td colspan='4'>
					                  <table width='100%' cellpadding='0' cellspacing='0' class='datatable'>
					                    <tr>
					                      <th>&nbsp;</th>
					                      <th>Chart</th>
					                      <th>Account</th>
					                      <th>Item Desc</th>
					                      <th>Item Tot Amt</th>
					                      <th>Dtl Balance</th>
					                    </tr>
					                    <tr>
					                      <td><input type='text' size='2' value='1'></td>
					                      <td>BL</td>
					                      <td>1043200</td>
					                      <td><input type='text' value='Seminar for Nurse'></td>
					                      <td><input type='text' value='100.00'></td>
					                      <td><input type='text' value='100.00'></td>
					                    </tr>
					                    <tr>
					                      <td><input type='text' size='2' value='2'></td>
					                      <td>BL</td>
					                      <td>1043200</td>
					                      <td><input type='text' value='Books for Seminar'></td>
					                      <td><input type='text' value='15.00'></td>
					                      <td><input type='text' value='15.00'></td>
					                    </tr>
					                  </table>
					                </td>
					              </tr>
					            </table>
					          </td>
					        </tr>
					      </table>
					    </td>
					  </tr>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
	</kul:tab>

	<kul:tab tabTitle="Non-AR" defaultOpen="true"
		tabErrorKey="${KFSConstants.PAYMENT_APPLICATION_DOCUMENT_ERRORS}">
    
		<div class="tab-container" align="center">
			<table width="100%" cellpadding="0" cellspacing="0" class="datatable">
				<tr>
					<th>Chart</th>
					<th>Account</th>
					<th>Sacc</th>
					<th>Object</th>
					<th>Sobj</th>
					<th>Project</th>
					<th>Amount</th>
					<th>Action</th>
				</tr>
				<tr>
					<td><input type='text' size=''></td>
					<td><input type='text' size=''></td>
					<td><input type='text' size=''></td>
					<td><input type='text' size=''></td>
					<td><input type='text' size=''></td>
					<td><input type='text' size=''></td>
					<td><input type='text' size=''></td>
					<td><html:image property="methodToCall.addNonAr"
									src="${ConfigProperties.externalizable.images.url}tinybutton-add1.gif"
									alt="Add"
									title="Add"
									styleClass="tinybutton" /></td>
				</tr>
				<tr>
					<td colspan='5'>&nbsp;</td>
					<th>Non-AR Total</th>
					<td> <input type='text' name='nonartotal'></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div>
	</kul:tab>

	<kul:tab tabTitle="Unapplied" defaultOpen="true"
		tabErrorKey="${KFSConstants.CASH_CONTROL_DOCUMENT_ERRORS}">
		<div class="tab-container" align="center">
			<table width="100%" cellpadding="0" cellspacing="0" class="datatable">
				<tr>
					<th><label for=''>Customer</label></th>
					<td>
						<kul:htmlControlAttribute
							attributeEntry="${customerAttributes.customerNumber}"
							property="document.nonAppliedHolding.customerNumber"/>
						<kul:lookup boClassName="org.kuali.kfs.module.ar.businessobject.Customer" 
							fieldConversions="document.nonAppliedHolding.customerNumber:customer.customerNumber" />
					</td>
					<th><label for=''>Amount</label></th>
					<td>
						<kul:htmlControlAttribute
							attributeEntry="${unappliedAttributes.financialDocumentLineAmount}"
							property="document.nonAppliedHolding.financialDocumentLineAmount"
							readOnly="${readOnly}" />
					</td>
				</tr>
			</table>
		</div>
	</kul:tab>

	<kul:notes notesBo="${KualiForm.document.documentBusinessObject.boNotes}" 
		noteType="${Constants.NoteTypeEnum.BUSINESS_OBJECT_NOTE_TYPE}"  allowsNoteFYI="true"/> 

	<kul:adHocRecipients />
	
	<kul:routeLog />
	
	<kul:panelFooter />
	
	<kfs:documentControls transactionalDocument="true" />

</kul:documentPage>
