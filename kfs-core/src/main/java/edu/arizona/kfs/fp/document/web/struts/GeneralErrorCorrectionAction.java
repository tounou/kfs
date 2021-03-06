package edu.arizona.kfs.fp.document.web.struts;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.kuali.kfs.fp.document.GeneralErrorCorrectionDocument;
import org.kuali.kfs.gl.businessobject.Entry;
import org.kuali.kfs.sys.KFSPropertyConstants;
import org.kuali.kfs.sys.businessobject.AccountingLine;
import org.kuali.kfs.sys.businessobject.SourceAccountingLine;
import org.kuali.kfs.sys.context.SpringContext;
import org.kuali.kfs.sys.document.AccountingDocument;
import org.kuali.kfs.sys.document.service.DebitDeterminerService;
import org.kuali.kfs.sys.service.SegmentedLookupResultsService;
import org.kuali.kfs.sys.web.struts.KualiAccountingDocumentFormBase;
import org.kuali.rice.core.api.config.property.ConfigurationService;
import org.kuali.rice.core.api.util.type.KualiDecimal;
import org.kuali.rice.kns.web.struts.form.KualiForm;
import org.kuali.rice.krad.service.BusinessObjectService;
import org.kuali.rice.krad.util.GlobalVariables;
import org.kuali.rice.krad.util.KRADConstants;
import org.kuali.rice.krad.util.UrlFactory;

import edu.arizona.kfs.gl.businessobject.lookup.GecEntryHelperServiceImpl;
import edu.arizona.kfs.sys.KFSConstants;

/**
 * This class is the UA modification of the GeneralErrorCorrectionAction.
 *
 * @author Adam Kost <kosta@email.arizona.edu> with some code adapted from UCI
 */
@SuppressWarnings("deprecation")
public class GeneralErrorCorrectionAction extends org.kuali.kfs.fp.document.web.struts.GeneralErrorCorrectionAction {

    private static transient volatile SegmentedLookupResultsService segmentedLookupResultsService;
    private static transient volatile DebitDeterminerService debitDeterminerService;
    private static transient volatile BusinessObjectService businessObjectService;

    private static SegmentedLookupResultsService getSegmentedLookupResultsService() {
        if (segmentedLookupResultsService == null) {
            segmentedLookupResultsService = SpringContext.getBean(SegmentedLookupResultsService.class);
        }
        return segmentedLookupResultsService;
    }

    protected static DebitDeterminerService getDebitDeterminerService() {
        if (debitDeterminerService == null) {
            debitDeterminerService = SpringContext.getBean(DebitDeterminerService.class);
        }
        return debitDeterminerService;
    }

    protected BusinessObjectService getBusinessObjectService() {
        if (businessObjectService == null) {
            businessObjectService = SpringContext.getBean(BusinessObjectService.class);
        }
        return businessObjectService;
    }

    @Override
    public ActionForward performLookup(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // parse out the important strings from our methodToCall parameter
        String fullParameter = (String) request.getAttribute(KFSConstants.METHOD_TO_CALL_ATTRIBUTE);

        // determine what the action path is
        String actionPath = StringUtils.substringBetween(fullParameter, KFSConstants.METHOD_TO_CALL_PARM4_LEFT_DEL, KFSConstants.METHOD_TO_CALL_PARM4_RIGHT_DEL);
        if (StringUtils.isBlank(actionPath)) {
            return super.performLookup(mapping, form, request, response);
        }

        GeneralErrorCorrectionForm financialDocumentForm = (GeneralErrorCorrectionForm) form;

        // when we return from the lookup, our next request's method to call is going to be refresh
        financialDocumentForm.registerEditableProperty(KRADConstants.DISPATCH_REQUEST_PARAMETER);

        String basePath = SpringContext.getBean(ConfigurationService.class).getPropertyValueAsString(KFSConstants.APPLICATION_URL_KEY);

        // parse out business object class name for lookup
        String boClassName = StringUtils.substringBetween(fullParameter, KFSConstants.METHOD_TO_CALL_BOPARM_LEFT_DEL, KFSConstants.METHOD_TO_CALL_BOPARM_RIGHT_DEL);
        if (StringUtils.isBlank(boClassName)) {
            throw new RuntimeException("Illegal call to perform lookup, no business object class name specified.");
        }

        // build the parameters for the lookup url
        Properties parameters = new Properties();
        String conversionFields = StringUtils.substringBetween(fullParameter, KFSConstants.METHOD_TO_CALL_PARM1_LEFT_DEL, KFSConstants.METHOD_TO_CALL_PARM1_RIGHT_DEL);
        if (StringUtils.isNotBlank(conversionFields)) {
            parameters.put(KFSConstants.CONVERSION_FIELDS_PARAMETER, conversionFields);
        }

        // pass values from form that should be pre-populated on lookup search
        String parameterFields = StringUtils.substringBetween(fullParameter, KFSConstants.METHOD_TO_CALL_PARM2_LEFT_DEL, KFSConstants.METHOD_TO_CALL_PARM2_RIGHT_DEL);
        if (StringUtils.isNotBlank(parameterFields)) {
            String[] lookupParams = parameterFields.split(KFSConstants.FIELD_CONVERSIONS_SEPERATOR);

            for (int i = 0; i < lookupParams.length; i++) {
                String[] keyValue = lookupParams[i].split(KFSConstants.FIELD_CONVERSION_PAIR_SEPERATOR);

                // hard-coded passed value
                if (StringUtils.contains(keyValue[0], KRADConstants.SINGLE_QUOTE)) {
                    parameters.put(keyValue[1], StringUtils.replace(keyValue[0], KRADConstants.SINGLE_QUOTE, KRADConstants.EMPTY_STRING));
                }
                // passed value should come from property
                else if (StringUtils.isNotBlank(request.getParameter(keyValue[0]))) {
                    parameters.put(keyValue[1], request.getParameter(keyValue[0]));
                }
            }
        }

        // grab whether or not the "return value" link should be hidden or not
        String hideReturnLink = StringUtils.substringBetween(fullParameter, KFSConstants.METHOD_TO_CALL_PARM3_LEFT_DEL, KFSConstants.METHOD_TO_CALL_PARM3_RIGHT_DEL);
        if (StringUtils.isNotBlank(hideReturnLink)) {
            parameters.put(KFSConstants.HIDE_LOOKUP_RETURN_LINK, hideReturnLink);
        }

        // anchor, if it exists
        if (form instanceof KualiForm && StringUtils.isNotEmpty(((KualiForm) form).getAnchor())) {
            parameters.put(KFSConstants.LOOKUP_ANCHOR, ((KualiForm) form).getAnchor());
        }

        // now add required parameters
        parameters.put(KFSConstants.DISPATCH_REQUEST_PARAMETER, KFSConstants.SEARCH_METHOD);
        parameters.put(KFSConstants.DOC_FORM_KEY, GlobalVariables.getUserSession().addObjectWithGeneratedKey(form));
        parameters.put(KFSConstants.BUSINESS_OBJECT_CLASS_ATTRIBUTE, boClassName);
        parameters.put(KFSConstants.RETURN_LOCATION_PARAMETER, basePath + mapping.getPath() + KFSConstants.ACTION_EXTENSION_DOT_DO);

        String lookupUrl = UrlFactory.parameterizeUrl(basePath + KFSConstants.PATH_SEPERATOR + actionPath, parameters);

        return new ActionForward(lookupUrl, true);
    }

    @Override
    public ActionForward refresh(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.refresh(mapping, form, request, response);

        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        Collection<Entry> rawValues = null;

        // If multiple asset lookup was used to select the assets, then....
        if (StringUtils.equals(KFSConstants.MULTIPLE_VALUE, gecForm.getRefreshCaller())) {
            String lookupResultsSequenceNumber = gecForm.getLookupResultsSequenceNumber();

            if (StringUtils.isNotBlank(lookupResultsSequenceNumber)) {
                // actually returning from a multiple value lookup
                Set<String> objectIds = getSegmentedLookupResultsService().retrieveSetOfSelectedObjectIds(lookupResultsSequenceNumber, GlobalVariables.getUserSession().getPerson().getPrincipalId());
                boolean isEntryObjectIds = isEntryObjectIds(objectIds);
                // if the ID starts with GL_ENTRY_T, this object is a General Ledger Entry. These
                // objects do not have a static Id and need to be acquired via special methods.
                if (isEntryObjectIds) {

                    // Retrieving selected data from table.
                    rawValues = retrieveSelectedResultBOs(objectIds);

                    if (rawValues == null || rawValues.isEmpty()) {
                        return mapping.findForward(KFSConstants.MAPPING_BASIC);
                    }
                    GeneralErrorCorrectionDocument gecDoc = (GeneralErrorCorrectionDocument) gecForm.getDocument();
                    for (Entry entry : rawValues) {
                        SourceAccountingLine line = copyEntryToAccountingLine(entry);
                        line.setDocumentNumber(gecDoc.getDocumentNumber());
                        insertAccountingLine(true, (KualiAccountingDocumentFormBase) form, line);
                    }
                    // next refresh should not attempt to retrieve these objects.
                    gecForm.setLookupResultsSequenceNumber(KFSConstants.EMPTY_STRING);
                }
            }
        }

        resequenceAccountingLines(gecForm);
        return mapping.findForward(KFSConstants.MAPPING_BASIC);
    }

    private boolean isEntryObjectIds(Set<String> objectIds) {
        for (String objectId : objectIds) {
            if (objectId.startsWith(KFSConstants.ENTRY_IDENTIFIER)) {
                return true;
            }
        }
        return false;
    }

    /**
     * This method is used to transform a retrieved Entry to a Source Accounting Line, reversing the debit/credit code in the process.
     * 
     * @param entry
     * @return
     */
    private SourceAccountingLine copyEntryToAccountingLine(Entry entry) {
        SourceAccountingLine retval = new SourceAccountingLine();
        retval.setFinancialDocumentLineTypeCode(KFSConstants.SOURCE_ACCT_LINE_TYPE_CODE);
        retval.setChartOfAccountsCode(entry.getChartOfAccountsCode());
        retval.setAccountNumber(entry.getAccountNumber());
        if (!entry.getSubAccountNumber().equals(KFSConstants.BLANK_SUBACCOUNT)) {
            retval.setSubAccountNumber(entry.getSubAccountNumber());
        }
        retval.setFinancialObjectCode(entry.getFinancialObjectCode());
        if (!entry.getFinancialSubObjectCode().equals(KFSConstants.BLANK_SUBOBJECT)) {
            retval.setFinancialSubObjectCode(entry.getFinancialSubObjectCode());
        }
        if (!entry.getProjectCode().equals(KFSConstants.BLANK_PROJECT_CODE)) {
            retval.setProjectCode(entry.getProjectCode());
        }
        retval.setOrganizationReferenceId(entry.getOrganizationReferenceId());
        retval.setAmount(entry.getTransactionLedgerEntryAmount());
        retval.setReferenceOriginCode(entry.getFinancialSystemOriginationCode());
        retval.setReferenceNumber(entry.getDocumentNumber());
        retval.setFinancialDocumentLineDescription(entry.getTransactionLedgerEntryDescription());
        String debitCreditCode = reverseDebitCreditCode(entry.getTransactionDebitCreditCode());
        retval.setDebitCreditCode(debitCreditCode);
        retval.setBalanceTypeCode(entry.getFinancialBalanceTypeCode());
        // copy helper objects
        retval.setChart(entry.getChart());
        retval.setAccount(entry.getAccount());
        retval.setObjectCode(entry.getFinancialObject());
        retval.setReferenceOrigin(entry.getReferenceOriginationCode());
        retval.setBalanceTyp(entry.getBalanceType());

        retval.refreshReferenceObject(KFSPropertyConstants.SUB_ACCOUNT_NUMBER);
        retval.refreshReferenceObject(KFSPropertyConstants.SUB_OBJECT_CODE);
        retval.refreshReferenceObject(KFSPropertyConstants.PROJECT_CODE);
        return retval;
    }

    private String reverseDebitCreditCode(String transactionDebitCreditCode) {
        if (transactionDebitCreditCode.equals(KFSConstants.GL_DEBIT_CODE)) {
            return KFSConstants.GL_CREDIT_CODE;
        }
        if (transactionDebitCreditCode.equals(KFSConstants.GL_CREDIT_CODE)) {
            return KFSConstants.GL_DEBIT_CODE;
        }
        /*
         * the transaction Debit/Credit Code should always be either Debit (D) or
         * Credit (C). If for some reason it's not, we're just going to pass
         * that value back.
         */
        return transactionDebitCreditCode;
    }

    /**
     * Custom retrieve for Entry - Entry table does not have an objectId field.
     *
     * @param setOfSelectedObjectIds
     * @return
     */
    private Collection<Entry> retrieveSelectedResultBOs(Set<String> setOfSelectedObjectIds) {
        ArrayList<Entry> retvals = new ArrayList<Entry>();

        for (String selectedObjectId : setOfSelectedObjectIds) {
            if (selectedObjectId == null || selectedObjectId.equals(KFSConstants.NULL_STRING)) {
                continue;
            }
            Entry result = GecEntryHelperServiceImpl.getEntry(selectedObjectId);
            if (result != null) {
                retvals.add(result);
            }
        }

        return retvals;
    }

    /**
     * Copies content from one accounting line to the other. Ignores Source or Target information.
     *
     * @param source
     *            line to copy from
     * @param target
     *            new line to copy data to
     */
    protected void copyAccountingLine(AccountingLine source, AccountingLine target) {
        target.copyFrom(source);
    }

    /**
     * Copies content from one accounting line to the other, but reverses debit/credit code and changes the line type from source to target.
     *
     * @param source
     *            line to copy from
     * @param target
     *            new line to copy data to
     */
    protected void reverseAccountingLine(AccountingLine source, AccountingLine target) {
        target.copyFrom(source);
        target.setFinancialDocumentLineTypeCode(KFSConstants.TARGET_ACCT_LINE_TYPE_CODE);
        String debitCreditCode = reverseDebitCreditCode(source.getDebitCreditCode());
        target.setDebitCreditCode(debitCreditCode);
    }

    @SuppressWarnings("unchecked")
    private void resequenceAccountingLines(GeneralErrorCorrectionForm gecForm) {
        AccountingDocument document = gecForm.getFinancialDocument();

        int newIndex = 0;
        List<AccountingLine> sourceLines = document.getSourceAccountingLines();
        for (AccountingLine line : sourceLines) {
            newIndex++;
            line.setSequenceNumber(newIndex);
        }

        newIndex = 0;
        List<AccountingLine> targetLines = document.getTargetAccountingLines();
        for (AccountingLine line : targetLines) {
            newIndex++;
            line.setSequenceNumber(newIndex);
        }
    }

    // Action buttons:

    public ActionForward copyAllAccountingLines(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        for (Object line : gecForm.getFinancialDocument().getSourceAccountingLines()) {
            AccountingLine sourceLine = (AccountingLine) line;
            AccountingLine targetLine = (AccountingLine) gecForm.getFinancialDocument().getTargetAccountingLineClass().newInstance();
            reverseAccountingLine(sourceLine, targetLine);
            insertAccountingLine(false, gecForm, targetLine);
            processAccountingLineOverrides(targetLine);
        }

        resequenceAccountingLines(gecForm);
        return mapping.findForward(KFSConstants.MAPPING_BASIC);
    }

    public ActionForward deleteAllSourceAccountingLines(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        gecForm.getFinancialDocument().getSourceAccountingLines().clear();

        resequenceAccountingLines(gecForm);
        return mapping.findForward(KFSConstants.MAPPING_BASIC);
    }

    public ActionForward deleteAllTargetAccountingLines(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        gecForm.getFinancialDocument().getTargetAccountingLines().clear();

        resequenceAccountingLines(gecForm);
        return mapping.findForward(KFSConstants.MAPPING_BASIC);
    }

    @Override
    public ActionForward performBalanceInquiryForSourceLine(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ActionForward forward = super.performBalanceInquiryForSourceLine(mapping, form, request, response);
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;

        resequenceAccountingLines(gecForm);
        return forward;
    }

    @Override
    public ActionForward performBalanceInquiryForTargetLine(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        ActionForward forward = super.performBalanceInquiryForTargetLine(mapping, form, request, response);

        resequenceAccountingLines(gecForm);
        return forward;
    }

    @Override
    public ActionForward deleteSourceLine(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        int deleteIndex = getLineToDelete(request);
        deleteAccountingLine(true, gecForm, deleteIndex);

        resequenceAccountingLines(gecForm);
        return mapping.findForward(KFSConstants.MAPPING_BASIC);
    }

    @Override
    public ActionForward deleteTargetLine(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        ActionForward forward = super.deleteTargetLine(mapping, form, request, response);

        resequenceAccountingLines(gecForm);
        return forward;
    }

    public ActionForward copyAccountingLine(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        GeneralErrorCorrectionDocument gecDocument = (GeneralErrorCorrectionDocument) gecForm.getDocument();

        int index = getSelectedLine(request);
        AccountingLine sourceLine = gecDocument.getSourceAccountingLine(index);
        AccountingLine targetLine = (AccountingLine) gecForm.getFinancialDocument().getTargetAccountingLineClass().newInstance();

        reverseAccountingLine(sourceLine, targetLine);
        insertAccountingLine(false, gecForm, targetLine);
        processAccountingLineOverrides(targetLine);

        resequenceAccountingLines(gecForm);
        return mapping.findForward(KFSConstants.MAPPING_BASIC);
    }

    @Override
    public ActionForward insertTargetLine(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        GeneralErrorCorrectionForm gecForm = (GeneralErrorCorrectionForm) form;
        GeneralErrorCorrectionDocument gecDocument = (GeneralErrorCorrectionDocument) gecForm.getDocument();

        int index = getSelectedLine(request);
        AccountingLine originalLine = gecDocument.getTargetAccountingLine(index);
        AccountingLine targetLine = (AccountingLine) gecForm.getFinancialDocument().getTargetAccountingLineClass().newInstance();

        copyAccountingLine(originalLine, targetLine);
        targetLine.setAmount(KualiDecimal.ZERO);
        insertAccountingLine(false, gecForm, targetLine);
        processAccountingLineOverrides(targetLine);

        resequenceAccountingLines(gecForm);
        return mapping.findForward(KFSConstants.MAPPING_BASIC);
    }
}
