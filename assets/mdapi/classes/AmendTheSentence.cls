/**
        * @author           Accenture
        * @version          1.5B
        * @date             11/21/2016
        * @description      This class is a controller class for Upload Invoice
        */
    public with sharing class CCME_UploadAllocationController{
         public String uploadJson{get;set;}
         public Boolean noInvoice{get;set;}
         public Boolean noElement{get;set;}
         public Set<String> invacIds{get;set;}
         public Set<String> eleacIds{get;set;}
         public Boolean validationError{get;set;}
         public String seletedManagingId{get;set;}
         public List<invExpWrapper> selectedInvWrapList{get;set;} 
         public Map<String,invExpWrapper> selectedInvWrapMap{get;set;}
         public Map<String,Decimal> selectedInvMap{get;set;}
         public Boolean hassaveError{get;set;}
         public Boolean hassownershipIdError{get;set;}
         public Boolean showuploadPreview{get;set;}
         public Boolean hasPayments{get;set;}
         public String errMsg{get;set;}
         public String errMsg1{get;set;}
         public String commonerrmsg{get;set;}
         public String finalerrMsg{get;set;}
         public CCME_InvoiceAllocationController invAllocation{get;set;}
         public Boolean associatePayeeId{get;set;}
         public Map<String,InvoicePaymentWrapper> successPaymentWrapperMap{get;set;}
         public Map<String,CCME_InvoiceAllocationController.InvoicePaymentWrapper> uploadsuccessPaymentWrapperMap{get;set;}
         public Map<String,CCME_InvoiceAllocationController.ElementWrapper> uploadEleWrapperMap{get;set;}
         public Map<String,CCME_InvoiceAllocationController.InvoiceWrapper> uploadInvWrapperMap{get;set;}
         public Map<String,Boolean> invRsnCodeMap{get;set;}
         public Map<String,String> eleIdInternalIdMap{get;set;}
         public Map<String,Set<String>> eleCINpayeeMap{get;set;}
         public Set<String> payeeIdSet{get;set;}
         public Map<String,Set<String>> eleCINpayeeFinalMap{get;set;}
         public Set<String> payeeIdFinalSet{get;set;}
         public Map<String,String> elePayeeIdpayeeNameMap{get;set;}
         public Map<String,CCME_InvoiceAllocationController.InvoicePaymentWrapper> addAllocPaymentWrapperMap{get;set;}
         public Map<String,CCME_InvoiceAllocationController.ElementWrapper> addAllocEleWrapperMap{get;set;}
         public Map<String,CCME_InvoiceAllocationController.InvoiceWrapper> addAllocInvWrapperMap{get;set;}
         public Boolean showReviewAllocationSummary{get;set;}
         /* for navigation titles */
         public String activeStep{get;set;}
         public String step1Title{get;set;}
         public String step2Title{get;set;}
         public String step3Title{get;set;}
         public String step1SubDetails{get;set;}
         public String step2SubDetails{get;set;}
         public String step2SubStepName{get;set;}
         public boolean showButtons{get;set;}
         public boolean isFrmAddAlloc{get;set;}
         public boolean uploadErr{get;set;}
         public boolean isUpFrmPaymentDash{get;set;}
    /**
 * @author           Accenture
 * @version          1.5B
 * @date             11/21/2016
 * @description      This class is a controller class for Upload Invoice
 */
public CCME_UploadAllocationController() {
  uploadJson = CCME_Constants.BLANK_STR;
  selectedInvWrapList = new List < invExpWrapper > ();
  selectedInvWrapMap = new Map < String, invExpWrapper > ();
  selectedInvMap = new Map < String, Decimal > ();
  invacIds = new Set < String > ();
  eleacIds = new Set < String > ();
  hassaveError = false;
  successPaymentWrapperMap = new Map < String, InvoicePaymentWrapper > ();
  uploadsuccessPaymentWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoicePaymentWrapper > ();
  showReviewAllocationSummary = false;
  hasPayments = false;
  invAllocation = new CCME_InvoiceAllocationController();
  showuploadPreview = false;
  noInvoice = false;
  noElement = false;
  hassownershipIdError = false;
  validationError = false;
  showButtons = true;
  /* for navigation titles */
  activeStep = 'step2';
  step1Title = 'Add Invoices';
  step2Title = 'Allocate Invoices';
  step3Title = 'Create Approval Groups';
  step1SubDetails = CCME_Constants.BLANK_STR;
  step2SubDetails = '(3 of 5)';
  step2SubStepName = 'Upload Allocations';
  addAllocPaymentWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoicePaymentWrapper > ();
  addAllocEleWrapperMap = new Map < String, CCME_InvoiceAllocationController.ElementWrapper > ();
  addAllocInvWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoiceWrapper > ();
  isFrmAddAlloc = false;
  uploadErr=false;
  isUpFrmPaymentDash=false;
 }
 /**
  * @author           Accenture
  * @version          1.0
  * @date             07/25/2016
  * @description      This method is to show upload preview
  * @param            String jsonStr - JSON String
  * @return           String 
  */
public pageReference showUploadpreview() {
  showuploadPreview = true;
  return null;
 }
 /**
  * @author           Accenture
  * @version          1.0
  * @date             06/25/2018
  * @description      This method is to redirect to Payment Home Page
  * @param            null
  * @return           PageReference
  */
 //added by PSB 
public pageReference cancelAllocationsAndGoback() {
  PageReference retPage = null;
  try {
   if (isFrmAddAlloc) {
    //.setRedirect(true)
    retPage = Page.CCME_ContinueAllocation.setRedirect(false);
   } else {
    retPage = Page.CCME_PaymentHome.setRedirect(true);
   }
  } catch (Exception e) {
   ApexPages.addMessages(e);
  }
  return retPage;
 }
 /**
  * @author           Accenture
  * @version          1.0
  * @date             06/25/2018
  * @description      This method is to redirect to Previous Page from Current Page
  * @param            null
  * @return           PageReference
  */
public pageReference backToPrevStep() {
   PageReference retPage = null;
  try {
   if (isFrmAddAlloc) {
    //.setRedirect(true)
    retPage = Page.CCME_ContinueAllocation.setRedirect(false);
   } else {
    retPage = Page.CCME_PaymentHome.setRedirect(true);
   }
  } catch (Exception e) {
   ApexPages.addMessages(e);
  }
  return retPage;
 }
 /**
  * @author           Accenture
  * @version          1.0
  * @date             06/25/2018
  * @description      This method is to Create Invoice, Element and Payment Wrapper
  * @param            null
  * @return           None
  */
public void setWrapperMaps(Map < String, CCME_InvoiceAllocationController.InvoicePaymentWrapper > successPaymentWrapper, Map < String, CCME_InvoiceAllocationController.ElementWrapper > EleWrapperMap, Map < String, CCME_InvoiceAllocationController.InvoiceWrapper > InvWrapperMap) {
 try {
  isFrmAddAlloc = true;
  addAllocPaymentWrapperMap = successPaymentWrapper;
  addAllocEleWrapperMap = EleWrapperMap;
  addAllocInvWrapperMap = InvWrapperMap;
  }catch (Exception e) {
   ApexPages.addMessages(e);
  }
 }
 /**
  * @author           Accenture
  * @version          1.0
  * @date             07/25/2016
  * @description      This method is to remove the escape & wrapping double quotes character from JSON
  * @param            String jsonStr - JSON String
  * @return           String 
  */
 public pageReference uploadCSV() {
   try {
    String payeeString = CCME_Constants.BLANK_STR;
    selectedInvWrapMap = new Map < String, invExpWrapper > ();
    selectedInvMap = new Map < String, Decimal > ();
    invRsnCodeMap = new Map < String, Boolean > ();
    eleIdInternalIdMap = new Map < String, String > ();
    eleCINpayeeMap = new Map < String, Set < String >> ();
    payeeIdSet = new Set < String > ();
    eleCINpayeeFinalMap = new Map < String, Set < String >> ();
    payeeIdFinalSet = new Set < String > ();
    elePayeeIdpayeeNameMap = new Map < String, String > ();
    invAllocation = new CCME_InvoiceAllocationController();
    invAllocation.elementWrapperMap = new Map < String, CCME_InvoiceAllocationController.ElementWrapper > ();
    invAllocation.invoiceWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoiceWrapper > ();
    invAllocation.showReviewAllocationSummary = false;
    uploadsuccessPaymentWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoicePaymentWrapper > ();
    successPaymentWrapperMap = new Map < String, InvoicePaymentWrapper > ();
    Set < String > invIds = new Set < String > ();
    Set < String > eleIds = new Set < String > ();
    Set < String > managingIds = new Set < String > ();
    invacIds = new Set < String > ();
    eleacIds = new Set < String > ();
    validationError = false;
    hassownershipIdError = false;
    errMsg = CCME_Constants.BLANK_STR;
    finalerrMsg = CCME_Constants.BLANK_STR;
    errMsg1 = CCME_Constants.BLANK_STR;
    commonerrmsg = CCME_Constants.BLANK_STR;
    Set < String > ManagingOwnIds = new Set < String > ();
    Boolean rsnCodeerror = false;
    Set < String > payeeIdownershipIdSet = new Set < String > ();
    selectedInvWrapList = new List < invExpWrapper > ();
    uploadJson = desanitizeJson(uploadJson);
    try {
     selectedInvWrapList = (List < invExpWrapper > ) JSON.deserialize(uploadJson, List < invExpWrapper > .class);
    } catch (Exception e) {
     errMsg = Label.CCME_Upload_Allocation_generic_validation;
    }
    finalerrMsg = Label.CCME_Upload_Allocation_generic_combination;
    for (CCME_User_Bottler__c userBottler: [SELECT Id, Name, Ownership_ID__c, User__c FROM CCME_User_Bottler__c WHERE User__c = : userInfo.getUserId()
      ORDER BY Ownership_ID__c ASC LIMIT 1000
     ]) {
     ManagingOwnIds.add(String.ValueOf(userBottler.Ownership_ID__c));
    }
    for (invExpWrapper invEle: selectedInvWrapList) {
     errMsg = CCME_Constants.BLANK_STR;
     //added below condition for INC6093650
     if(!CCME_Utilities.nullOrEmpty(invEle.Allocated_Amount))
      {
       if((((invEle.Remaining_Invoice_Amount)>0) && ((invEle.Allocated_Amount)<0)) || (((invEle.Remaining_Invoice_Amount)<0) && ((invEle.Allocated_Amount)>0))){
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,Label.CCME_Invalid_Payment));                       
      } 
     } 
     if (CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_generic_Invoice_Validation;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_generic_Invoice_Validation));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Element_Id)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_generic_Element_Validation;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_generic_Element_Validation));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Element_Description)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_desc_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_desc_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Year)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_year_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_year_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Number)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_number_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_number_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Description)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_desc_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_desc_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Date)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_date_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_date_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Total_Invoice_Amount)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_total_amnt_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_total_amnt_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Remaining_Invoice_Amount)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_remaining_inv_amnt_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_remaining_inv_amnt_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Allocated_Amount)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_alc_amnt_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_alc_amnt_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Payee_Id)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_Payee_Id_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_Payee_Id_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Payee_Name)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_payee_name_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_payee_name_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Transaction_Type)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_transaction_type_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_transaction_type_error));
      validationError = true;
     }
     if (CCME_Utilities.nullOrEmpty(invEle.Managing_Ownership_Id)) {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_managing_ownId_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_managing_ownId_error));
      validationError = true;
     }
     if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
      invIds.add(invEle.MARS_Invoice_Id);
     }
     if (!CCME_Utilities.nullOrEmpty(invEle.Element_Id) && !CCME_Utilities.nullOrEmpty(invEle.Year)) {
      eleIds.add(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year);
     }
     if (!CCME_Utilities.nullOrEmpty(invEle.Payee_Id)) {
      String payeeIdString = invEle.Payee_Id;
      payeeString = payeeIdString.leftPad(10).replace(' ', '0');
     }
     if (!CCME_Utilities.nullOrEmpty(invEle.Managing_Ownership_Id) && !CCME_Utilities.nullOrEmpty(payeeString)) {
      payeeIdownershipIdSet.add(String.ValueOf(payeeString) + CCME_Constants.UNDERSCORE + String.ValueOf(invEle.Managing_Ownership_Id));
      managingIds.add(invEle.Managing_Ownership_Id);
     }
     if ((managingIds.size() > 1) && (managingIds.size() == 2)) {
      hassownershipIdError = true;
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_multiple_ownership_ids_error;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_multiple_ownership_ids_error));
     }
     if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
      if (selectedInvMap.containsKey(invEle.MARS_Invoice_Id)) {
       Decimal AllocatedAmount = selectedInvMap.get(invEle.MARS_Invoice_Id);
       AllocatedAmount = math.abs(AllocatedAmount) + math.abs(invEle.Allocated_Amount);
       selectedInvMap.put(invEle.MARS_Invoice_Id, AllocatedAmount);
      } else {
       selectedInvMap.put(invEle.MARS_Invoice_Id, invEle.Allocated_Amount);
      }
     }
     if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id) && !CCME_Utilities.nullOrEmpty(invEle.Element_Id) && !CCME_Utilities.nullOrEmpty(invEle.Year)) {
      if (selectedInvWrapMap.containsKey(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) {
       if (!hassownershipIdError && (validationError == false)) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_ele_combo_error));
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_ele_combo_error;
       }
      } else if (Math.abs(invEle.Total_Invoice_Amount) < Math.abs(invEle.Remaining_Invoice_Amount)) {
       if (!hassownershipIdError && (validationError == false)) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_total_amnt_remaining_amnt_error;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_total_amnt_remaining_amnt_error));
       }
      } else {
       selectedInvWrapMap.put(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year, invEle);
      }
     }
     if (!(String.isBlank(errMsg))) {
      if (!hassownershipIdError && (validationError == false)) {
       commonerrmsg += '<br></br>' + invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year;
       errMsg1 = finalerrMsg + commonerrmsg;
      }
     }
    }
    //errMsg=CCME_Constants.BLANK_STR;
    List < CCME_Multi_Vendor__c > multiList = [Select Id, Name, Ownership_ID_Display__c, PayeeName_OwnershipId__c FROM CCME_Multi_Vendor__c where PayeeName_OwnershipId__c IN: payeeIdownershipIdSet LIMIT 10000];
    List < CCME_Local_Vendor__c > localList = [Select Id, Name, Ownership_ID_Display__c, PayeeName_OwnershipId__c FROM CCME_Local_Vendor__c where PayeeName_OwnershipId__c IN: payeeIdownershipIdSet LIMIT 10000];
    List < CCME_Manual_Invoice__c > manList = [Select Id, Managing_Partner_Ownership_Id__c,Allocated_Amount__c,Paper_Invoice_Number__c, Payee_Id__c, Payee_Name__c, Invoice_Value__c, Invoice_Date__c, Managing_Ownership_Id_Display__c, Transaction_Type__c, Remaining_Invoice_Amount__c, Reason_Code__c, Name, Invoice_Description__c from CCME_Manual_Invoice__c where Name IN: invIds LIMIT 10000];
    List < CCME_Contract_Element__c > coneleList = [Select Accounting_Type_Description__c, Total_Budget_Report__c, Id, Active_Chk__c, Contract_Description__c, Approval_Status__c, User_Description__c, Element_Year__c, Name, Managing_Ownership_ID__c, CCME_Contract_Id__c, Contract_Element_Internal_Id_Display__c, Element_Id_Year__c, Accounting_Prepay_Chk__c, Element_Year_Display__c, CCME_Contract__c, Element_Type__c, Element_Id__c, End_Date__c, Element_Version_Number__c, Managing_Partner_Ownership_Id__c, Start_Date__c from CCME_Contract_Element__c where Element_Id_Year__c IN: eleIds and Approval_Status__c = 'Approved'
     and Active_Chk__c = true LIMIT 10000
    ];
    List < CCME_Contract_Element_Cust_Sel_Payee__c > payeeList = [Select Id, Contract_Element_Internal_Id_Display__c, AP_Vendor_Number__c,
     CCME_Customer_Selection__r.CCME_Contract_Element__r.Element_Id_Year__c
     FROM CCME_Contract_Element_Cust_Sel_Payee__c
     where CCME_Customer_Selection__r.CCME_Contract_Element__r.Element_Id_Year__c IN: eleIds LIMIT 10000
    ];
    for (CCME_Contract_Element_Cust_Sel_Payee__c payee: payeeList) {
     payeeIdSet = new Set < String > ();
     if (eleCINpayeeMap.containsKey(payee.Contract_Element_Internal_Id_Display__c)) {
      payeeIdSet = eleCINpayeeMap.get(payee.Contract_Element_Internal_Id_Display__c);
     }
     payeeIdSet.add(payee.AP_Vendor_Number__c);
     eleCINpayeeMap.put(payee.Contract_Element_Internal_Id_Display__c, payeeIdSet);
    }
    if (!hassownershipIdError && (validationError == false)) {
     if ((!(manList.size() > 0)) || (CCME_Utilities.nullOrEmpty(manList))) //Uncomment
     {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_uploaded_inv_notexist_error;
      noInvoice = true;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_uploaded_inv_notexist_error));
     } else {
      for (CCME_Manual_Invoice__c inv: manList) {
       errMsg = CCME_Constants.BLANK_STR;
       invacIds.add(inv.Name);
       if (!invAllocation.invoiceWrapperMap.containsKey(inv.Name)) {
        CCME_InvoiceAllocationController.InvoiceWrapper invoiceWrapper = new CCME_InvoiceAllocationController.InvoiceWrapper(inv);
        invAllocation.invoiceWrapperMap.put(inv.name, invoiceWrapper);
       }
       if (selectedInvMap.containsKey(String.ValueOf(inv.Name))) {
        if (math.abs(selectedInvMap.get(String.ValueOf(inv.Name))) < math.abs(inv.Remaining_Invoice_Amount__c)) {
         if (CCME_Utilities.nullOrEmpty(inv.Reason_Code__c)) {
          if (invRsnCodeMap.containsKey(String.ValueOf(inv.Name))) {
           if (!invRsnCodeMap.get(String.ValueOf(inv.Name))) {
            invRsnCodeMap.put(String.ValueOf(inv.Name), true);
           }
          } else {
           invRsnCodeMap.put(String.ValueOf(inv.Name), true);
          }
         }
        } else if (math.abs(selectedInvMap.get(String.ValueOf(inv.Name))) > math.abs(inv.Remaining_Invoice_Amount__c)) {
         errMsg += '<br></br>' + Label.CCME_Upload_Allocation_allocated_amount_exceeds_error + inv.Name;
         Decimal allocatedamnt = selectedInvMap.get(String.ValueOf(inv.Name));
         Decimal allocatedfinalamnt = allocatedamnt.setScale(2);
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'For the Invoice : ' + inv.Name + ' Allocated Amount : ' + ' ' + ' $' + allocatedfinalamnt + ' ' + 'is greater than Remaining Invoice Amount : ' + ' ' + '$' + inv.Remaining_Invoice_Amount__c + '.' + 'Please reallocate Remaining Invoice Amount and try again'));
        }
       }
      }
     }
    }
    if (!hassownershipIdError && (validationError == false)) {
     if ((!(coneleList.size() > 0)) || (CCME_Utilities.nullOrEmpty(coneleList))) //Uncomment
     {
      errMsg += '<br></br>' + Label.CCME_Upload_Allocation_uploaded_element_notexists_error;
      noElement = true;
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_uploaded_element_notexists_error));
     } else {
      for (CCME_Contract_Element__c ele: coneleList) {
       errMsg = CCME_Constants.BLANK_STR;
       eleacIds.add(ele.Element_Id__c + CCME_Constants.UNDERSCORE + ele.Element_Year__c);
       if (!invAllocation.elementWrapperMap.containsKey(ele.Contract_Element_Internal_Id_Display__c)) {
        CCME_InvoiceAllocationController.ElementWrapper eleWrapper = new CCME_InvoiceAllocationController.ElementWrapper(ele);
        invAllocation.elementWrapperMap.put(ele.Contract_Element_Internal_Id_Display__c, eleWrapper);
       }
       if (!eleIdInternalIdMap.containsKey(ele.Element_Id_Year__c)) {
        eleIdInternalIdMap.put(ele.Element_Id_Year__c, ele.Contract_Element_Internal_Id_Display__c);
       }
      }
     }
    }
    if (((String.isBlank(errMsg1)) && (String.isBlank(errMsg))) && (!hassownershipIdError && (validationError == false))) {
     for (invExpWrapper invEle: selectedInvWrapMap.values()) {
      errMsg = CCME_Constants.BLANK_STR;
      if ((eleacIds.contains(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) && (invacIds.contains(invEle.MARS_Invoice_Id))) {
       if (invRsnCodeMap.containsKey(invEle.MARS_Invoice_Id)) {
        if (CCME_Utilities.nullOrEmpty(invEle.Reason_Code)) {
         errMsg += '<br></br>' + Label.CCME_Upload_Allocation_reason_code_enter_error;
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_reason_code_enter_error));
        } else if (!((invEle.Reason_Code == CCME_Constants.WRITE_OFF) || (invEle.Reason_Code == CCME_Constants.PAY_LATER))) {
         errMsg += '<br></br>' + Label.CCME_Upload_Allocation_reason_code_error;
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_reason_code_error));
        }
       }
       if (String.isBlank(errMsg)) {
        if (invAllocation.invoiceWrapperMap.containsKey(invEle.MARS_Invoice_Id)) {
         if (invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c.equals(invAllocation.elementWrapperMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).element.Managing_Ownership_ID__c)) {
          if (!(invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c.equals(invEle.Managing_Ownership_Id))) {
           errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ownershipId_mismatch_error;
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ownershipId_mismatch_error));
          } else if (!(invAllocation.elementWrapperMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).element.Managing_Ownership_ID__c.equals(invEle.Managing_Ownership_Id))) {
           errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ownershipId_ele_mismatch_error;
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ownershipId_ele_mismatch_error));
          }
          if (!ManagingOwnIds.contains(invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c)) {
           errMsg += '<br></br>' + Label.CCME_Upload_Allocation_user_ownershipId_associated_error + invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c;
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_user_ownershipId_associated_error + invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c));
          }
         } else {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_ele_ownershipId_mismatch_error;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_ele_ownershipId_mismatch_error));
         }
         if (String.isBlank(errMsg)) {
          invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).remainingAmount =
           invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).remainingAmount - invEle.Allocated_Amount;
          if ((invEle.Reason_Code == CCME_Constants.WRITE_OFF) || (invEle.Reason_Code == CCME_Constants.PAY_LATER)) {
           invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Reason_Code__c = invEle.Reason_Code;
          }
          invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Transaction_Type__c = invEle.Transaction_Type;
          invAllocation.invoiceWrapperMap.put(invEle.MARS_Invoice_Id, invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id));
         }
        }
       }
       if (String.isBlank(errMsg)) {
        if (eleCINpayeeMap.containsKey(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
         String payeeIdString = invEle.Payee_Id;
         payeeString = payeeIdString.leftPad(10).replace(' ', '0');
         if (!eleCINpayeeMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).contains(payeeString)) {
          if (associatePayeeId) {
           payeeIdFinalSet = new Set < String > ();
           if (eleCINpayeeFinalMap.containsKey(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
            payeeIdFinalSet = eleCINpayeeFinalMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year));
           }
           payeeIdFinalSet.add(payeeString);
           eleCINpayeeFinalMap.put(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year), payeeIdFinalSet);
           if (!elePayeeIdpayeeNameMap.containsKey(payeeString)) {
            elePayeeIdpayeeNameMap.put(payeeString, invEle.Payee_Name);
           }
          } else {
           errMsg += '<br></br>' + Label.CCME_Upload_Allocation_payee_id_association_error;
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_payee_id_association_error));
          }
         }
        }
       }
       if (!uploadsuccessPaymentWrapperMap.containsKey(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
        CCME_InvoiceAllocationController.InvoicePaymentWrapper paymntWrapper = new CCME_InvoiceAllocationController.InvoicePaymentWrapper();
        paymntWrapper.invoiceId = invEle.MARS_Invoice_Id;
        paymntWrapper.elementId = invEle.Element_Id;
        paymntWrapper.elementCIN = eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year);
        paymntWrapper.allocatedAmount = invEle.Allocated_Amount;
        paymntWrapper.isElementValid = true;
        paymntWrapper.isInvoiceValid = true;
        uploadsuccessPaymentWrapperMap.put(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year), paymntWrapper);
       }
      } else {
       if (!invacIds.contains(invEle.MARS_Invoice_Id)) //UnComment
       {
        if (!noInvoice) {
         errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_notpresent_validation;
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_notpresent_validation));
        }
       }
       if (!eleacIds.contains(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) {
        if (!noElement) {
         errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_notpresent_validation;
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_notpresent_validation));
        }
       }
      }
      if (!(String.isBlank(errMsg))) {
       commonerrmsg += '<br></br>' + invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year;
       errMsg1 = finalerrMsg + commonerrmsg;
      }
     }
    }
    if ((String.isBlank(errMsg1))) {
     List < CCME_Contract_Element_Cust_Sel_Payee__c > newPayeeList = new List < CCME_Contract_Element_Cust_Sel_Payee__c > ();
     List < CCME_Customer_Selection__c > custSelectionList = [Select Id, Name, Contract_Element_Internal_Id_Display__c
      FROM CCME_Customer_Selection__c where Contract_Element_Internal_Id_Display__c IN: eleCINpayeeFinalMap.keySet() LIMIT 10000
     ];
     for (CCME_Customer_Selection__c cs: custSelectionList) {
      for (String payeeId: eleCINpayeeFinalMap.get(cs.Contract_Element_Internal_Id_Display__c)) {
       CCME_Contract_Element_Cust_Sel_Payee__c newPayee = new CCME_Contract_Element_Cust_Sel_Payee__c();
       newPayee.CCME_Customer_Selection__c = cs.Id;
       newPayee.AP_Vendor_Number__c = payeeId;
       newPayee.Payee_Name__c = elePayeeIdpayeeNameMap.get(payeeId);
       newPayee.Is_Primary_Payment__c = false;
       newPayeeList.add(newPayee);
      }
     }
     if (!CCME_Utilities.nullOrEmpty(newPayeeList) || !newPayeeList.IsEmpty()) {
      try {
       database.insert(newPayeeList);
      } catch (DMLException e) {
       errMsg += '<br></br>' + e.getDMLMessage(0);
      }
     }
    }
    ApexPages.Message[] pageMessages = ApexPages.getMessages();
    if ((String.isBlank(errMsg1)) && (pageMessages.size() == 0)) {
     hassaveError = true;
     invAllocation.showReviewAllocationSummary = true;
     showReviewAllocationSummary = true;
     showButtons = true;
     invAllocation.successPaymentWrapperMap = uploadsuccessPaymentWrapperMap;
    } else {
     hassaveError = false;
     invAllocation.showReviewAllocationSummary = false;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errMsg1));
     errMsg1 = CCME_Constants.BLANK_STR;
     errMsg = CCME_Constants.BLANK_STR;
     finalerrMsg = CCME_Constants.BLANK_STR;
     selectedInvWrapMap.clear();
    }
    //showButtons=false;    
    errMsg = CCME_Constants.BLANK_STR;
    finalerrMsg = CCME_Constants.BLANK_STR;
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return null;
  }
  
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      This method is to achieve to upload Invoice Allocation CSV file
   * @param            null
   * @return           PageReference
   */
  //added by PSB
 public pageReference uploadCSV1() {
   PageReference retPage;
   String payeeString = CCME_Constants.BLANK_STR;
   selectedInvWrapMap = new Map < String, invExpWrapper > ();
   selectedInvMap = new Map < String, Decimal > ();
   invRsnCodeMap = new Map < String, Boolean > ();
   eleIdInternalIdMap = new Map < String, String > ();
   eleCINpayeeMap = new Map < String, Set < String >> ();
   payeeIdSet = new Set < String > ();
   eleCINpayeeFinalMap = new Map < String, Set < String >> ();
   payeeIdFinalSet = new Set < String > ();
   elePayeeIdpayeeNameMap = new Map < String, String > ();
   invAllocation = new CCME_InvoiceAllocationController();
   invAllocation.elementWrapperMap = new Map < String, CCME_InvoiceAllocationController.ElementWrapper > ();
   invAllocation.invoiceWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoiceWrapper > ();
   invAllocation.showReviewAllocationSummary = false;
   uploadsuccessPaymentWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoicePaymentWrapper > ();
   successPaymentWrapperMap = new Map < String, InvoicePaymentWrapper > ();
   uploadEleWrapperMap = new Map < String, CCME_InvoiceAllocationController.ElementWrapper > ();
   uploadInvWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoiceWrapper > ();
   Set < String > invIds = new Set < String > ();
   Set < String > eleIds = new Set < String > ();
   Set < String > managingIds = new Set < String > ();
   invacIds = new Set < String > ();
   eleacIds = new Set < String > ();
   validationError = false;
   hassownershipIdError = false;
   errMsg = CCME_Constants.BLANK_STR;
   finalerrMsg = CCME_Constants.BLANK_STR;
   errMsg1 = CCME_Constants.BLANK_STR;
   commonerrmsg = CCME_Constants.BLANK_STR;
   Set < String > ManagingOwnIds = new Set < String > ();
   Boolean rsnCodeerror = false;
   Set < String > payeeIdownershipIdSet = new Set < String > ();
   selectedInvWrapList = new List < invExpWrapper > ();
   uploadJson = desanitizeJson(uploadJson);
   try {
    selectedInvWrapList = (List < invExpWrapper > ) JSON.deserialize(uploadJson, List < invExpWrapper > .class);
   } catch (Exception e) {
    errMsg = Label.CCME_Upload_Allocation_generic_validation;
   }
   finalerrMsg = Label.CCME_Upload_Allocation_generic_combination;
   for (CCME_User_Bottler__c userBottler: [SELECT Id, Name, Ownership_ID__c, User__c FROM CCME_User_Bottler__c WHERE User__c = : userInfo.getUserId()
     ORDER BY Ownership_ID__c ASC LIMIT 1000
    ]) {
    ManagingOwnIds.add(String.ValueOf(userBottler.Ownership_ID__c));
   }
   for (invExpWrapper invEle: selectedInvWrapList) {
    errMsg = CCME_Constants.BLANK_STR;
    //added below condition for INC6093650
     if(!CCME_Utilities.nullOrEmpty(invEle.Allocated_Amount))
      {
       if((((invEle.Remaining_Invoice_Amount)>0) && ((invEle.Allocated_Amount)<0)) || (((invEle.Remaining_Invoice_Amount)<0) && ((invEle.Allocated_Amount)>0))){
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,Label.CCME_Invalid_Payment));                       
      } 
     } 
    if (CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_generic_Invoice_Validation;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_generic_Invoice_Validation));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Element_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_generic_Element_Validation;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_generic_Element_Validation));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Element_Description)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_desc_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_desc_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Year)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_year_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_year_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Number)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_number_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_number_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Description)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_desc_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_desc_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Date)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_date_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_date_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Total_Invoice_Amount)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_total_amnt_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_total_amnt_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Remaining_Invoice_Amount)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_remaining_inv_amnt_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_remaining_inv_amnt_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Allocated_Amount)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_alc_amnt_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_alc_amnt_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Payee_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_Payee_Id_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_Payee_Id_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Payee_Name)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_payee_name_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_payee_name_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Transaction_Type)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_transaction_type_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_transaction_type_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Managing_Ownership_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_managing_ownId_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_managing_ownId_error));
     validationError = true;
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
     invIds.add(invEle.MARS_Invoice_Id);
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.Element_Id) && !CCME_Utilities.nullOrEmpty(invEle.Year)) {
     eleIds.add(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year);
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.Payee_Id)) {
     String payeeIdString = invEle.Payee_Id;
     payeeString = payeeIdString.leftPad(10).replace(' ', '0');
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.Managing_Ownership_Id) && !CCME_Utilities.nullOrEmpty(payeeString)) {
     payeeIdownershipIdSet.add(String.ValueOf(payeeString) + CCME_Constants.UNDERSCORE + String.ValueOf(invEle.Managing_Ownership_Id));
     managingIds.add(invEle.Managing_Ownership_Id);
    }
    if ((managingIds.size() > 1) && (managingIds.size() == 2)) {
     hassownershipIdError = true;
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_multiple_ownership_ids_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_multiple_ownership_ids_error));
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
     if (selectedInvMap.containsKey(invEle.MARS_Invoice_Id)) {
      Decimal AllocatedAmount = selectedInvMap.get(invEle.MARS_Invoice_Id);
      AllocatedAmount = math.abs(AllocatedAmount) + math.abs(invEle.Allocated_Amount);
      selectedInvMap.put(invEle.MARS_Invoice_Id, AllocatedAmount);
     } else {
      selectedInvMap.put(invEle.MARS_Invoice_Id, invEle.Allocated_Amount);
     }
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id) && !CCME_Utilities.nullOrEmpty(invEle.Element_Id) && !CCME_Utilities.nullOrEmpty(invEle.Year)) {
     if (selectedInvWrapMap.containsKey(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) {
      if (!hassownershipIdError && (validationError == false)) {
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_ele_combo_error));
       errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_ele_combo_error;
      }
     } else if (Math.abs(invEle.Total_Invoice_Amount) < Math.abs(invEle.Remaining_Invoice_Amount)) {
      if (!hassownershipIdError && (validationError == false)) {
       errMsg += '<br></br>' + Label.CCME_Upload_Allocation_total_amnt_remaining_amnt_error;
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_total_amnt_remaining_amnt_error));
      }
     } else {
      selectedInvWrapMap.put(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year, invEle);
     }
    }
    if (!(String.isBlank(errMsg))) {
     if (!hassownershipIdError && (validationError == false)) {
      commonerrmsg += '<br></br>' + invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year;
      errMsg1 = finalerrMsg + commonerrmsg;
     }
    }
   }
   //errMsg=CCME_Constants.BLANK_STR;
   List < CCME_Multi_Vendor__c > multiList = [Select Id, Name, Ownership_ID_Display__c, PayeeName_OwnershipId__c FROM CCME_Multi_Vendor__c where PayeeName_OwnershipId__c IN: payeeIdownershipIdSet LIMIT 10000];
   List < CCME_Local_Vendor__c > localList = [Select Id, Name, Ownership_ID_Display__c, PayeeName_OwnershipId__c FROM CCME_Local_Vendor__c where PayeeName_OwnershipId__c IN: payeeIdownershipIdSet LIMIT 10000];
   List < CCME_Manual_Invoice__c > manList = [Select Id, Managing_Partner_Ownership_Id__c, Allocated_Amount__c,Paper_Invoice_Number__c, Payee_Id__c, Payee_Name__c, Invoice_Value__c, Invoice_Date__c, Managing_Ownership_Id_Display__c, Transaction_Type__c, Remaining_Invoice_Amount__c, Reason_Code__c, Name, Invoice_Description__c from CCME_Manual_Invoice__c where Name IN: invIds LIMIT 10000];
   List < CCME_Contract_Element__c > coneleList = [Select Accounting_Type_Description__c, Total_Budget_Report__c, Id, Active_Chk__c, Contract_Description__c, Approval_Status__c, User_Description__c, Element_Year__c, Name, Managing_Ownership_ID__c, CCME_Contract_Id__c, Contract_Element_Internal_Id_Display__c, Element_Id_Year__c, Accounting_Prepay_Chk__c, Element_Year_Display__c, CCME_Contract__c, Element_Type__c, Element_Id__c, End_Date__c, Element_Version_Number__c, Managing_Partner_Ownership_Id__c, Start_Date__c from CCME_Contract_Element__c where Element_Id_Year__c IN: eleIds and Approval_Status__c = 'Approved'
    and Active_Chk__c = true LIMIT 10000
   ];
   List < CCME_Contract_Element_Cust_Sel_Payee__c > payeeList = [Select Id, Contract_Element_Internal_Id_Display__c, AP_Vendor_Number__c,
    CCME_Customer_Selection__r.CCME_Contract_Element__r.Element_Id_Year__c
    FROM CCME_Contract_Element_Cust_Sel_Payee__c
    where CCME_Customer_Selection__r.CCME_Contract_Element__r.Element_Id_Year__c IN: eleIds LIMIT 10000
   ];
   for (CCME_Contract_Element_Cust_Sel_Payee__c payee: payeeList) {
    payeeIdSet = new Set < String > ();
    if (eleCINpayeeMap.containsKey(payee.Contract_Element_Internal_Id_Display__c)) {
     payeeIdSet = eleCINpayeeMap.get(payee.Contract_Element_Internal_Id_Display__c);
    }
    payeeIdSet.add(payee.AP_Vendor_Number__c);
    eleCINpayeeMap.put(payee.Contract_Element_Internal_Id_Display__c, payeeIdSet);
   }
   if (!hassownershipIdError && (validationError == false)) {
    if ((!(manList.size() > 0)) || (CCME_Utilities.nullOrEmpty(manList))) //Uncomment
    {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_uploaded_inv_notexist_error;
     noInvoice = true;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_uploaded_inv_notexist_error));
    } else {
     for (CCME_Manual_Invoice__c inv: manList) {
      errMsg = CCME_Constants.BLANK_STR;
      invacIds.add(inv.Name);
      if (!invAllocation.invoiceWrapperMap.containsKey(inv.Name)) {
       CCME_InvoiceAllocationController.InvoiceWrapper invoiceWrapper = new CCME_InvoiceAllocationController.InvoiceWrapper(inv);
       invAllocation.invoiceWrapperMap.put(inv.name, invoiceWrapper);
      }
      if (selectedInvMap.containsKey(String.ValueOf(inv.Name))) {
       if (math.abs(selectedInvMap.get(String.ValueOf(inv.Name))) < math.abs(inv.Remaining_Invoice_Amount__c)) {
        if (CCME_Utilities.nullOrEmpty(inv.Reason_Code__c)) {
         if (invRsnCodeMap.containsKey(String.ValueOf(inv.Name))) {
          if (!invRsnCodeMap.get(String.ValueOf(inv.Name))) {
           invRsnCodeMap.put(String.ValueOf(inv.Name), true);
          }
         } else {
          invRsnCodeMap.put(String.ValueOf(inv.Name), true);
         }
        }
       } else if (math.abs(selectedInvMap.get(String.ValueOf(inv.Name))) > math.abs(inv.Remaining_Invoice_Amount__c)) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_allocated_amount_exceeds_error + inv.Name;
        Decimal allocatedamnt = selectedInvMap.get(String.ValueOf(inv.Name));
        Decimal allocatedfinalamnt = allocatedamnt.setScale(2);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'For the Invoice : ' + inv.Name + ' Allocated Amount : ' + ' ' + ' $' + allocatedfinalamnt + ' ' + 'is greater than Remaining Invoice Amount : ' + ' ' + '$' + inv.Remaining_Invoice_Amount__c + '.' + 'Please reallocate Remaining Invoice Amount and try again'));
       }
      }
     }
    }
   }
   if (!hassownershipIdError && (validationError == false)) {
    if ((!(coneleList.size() > 0)) || (CCME_Utilities.nullOrEmpty(coneleList))) //Uncomment
    {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_uploaded_element_notexists_error;
     noElement = true;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_uploaded_element_notexists_error));
    } else {
     for (CCME_Contract_Element__c ele: coneleList) {
      errMsg = CCME_Constants.BLANK_STR;
      eleacIds.add(ele.Element_Id__c + CCME_Constants.UNDERSCORE + ele.Element_Year__c);
      if (!invAllocation.elementWrapperMap.containsKey(ele.Contract_Element_Internal_Id_Display__c)) {
       CCME_InvoiceAllocationController.ElementWrapper eleWrapper = new CCME_InvoiceAllocationController.ElementWrapper(ele);
       invAllocation.elementWrapperMap.put(ele.Contract_Element_Internal_Id_Display__c, eleWrapper);
      }
      if (!eleIdInternalIdMap.containsKey(ele.Element_Id_Year__c)) {
       eleIdInternalIdMap.put(ele.Element_Id_Year__c, ele.Contract_Element_Internal_Id_Display__c);
      }
     }
    }
   }
   if (((String.isBlank(errMsg1)) && (String.isBlank(errMsg))) && (!hassownershipIdError && (validationError == false))) {
    for (invExpWrapper invEle: selectedInvWrapMap.values()) {
     errMsg = CCME_Constants.BLANK_STR;
     if ((eleacIds.contains(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) && (invacIds.contains(invEle.MARS_Invoice_Id))) {
      if (invRsnCodeMap.containsKey(invEle.MARS_Invoice_Id)) {
       if (CCME_Utilities.nullOrEmpty(invEle.Reason_Code)) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_reason_code_enter_error;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_reason_code_enter_error));
       } else if (!((invEle.Reason_Code == CCME_Constants.WRITE_OFF) || (invEle.Reason_Code == CCME_Constants.PAY_LATER))) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_reason_code_error;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_reason_code_error));
       }
      }
      if (String.isBlank(errMsg)) {
       if (invAllocation.invoiceWrapperMap.containsKey(invEle.MARS_Invoice_Id)) {
        if (invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c.equals(invAllocation.elementWrapperMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).element.Managing_Ownership_ID__c)) {
         if (!(invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c.equals(invEle.Managing_Ownership_Id))) {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ownershipId_mismatch_error;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ownershipId_mismatch_error));
         } else if (!(invAllocation.elementWrapperMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).element.Managing_Ownership_ID__c.equals(invEle.Managing_Ownership_Id))) {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ownershipId_ele_mismatch_error;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ownershipId_ele_mismatch_error));
         }
         if (!ManagingOwnIds.contains(invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c)) {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_user_ownershipId_associated_error + invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_user_ownershipId_associated_error + invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c));
         }
        } else {
         errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_ele_ownershipId_mismatch_error;
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_ele_ownershipId_mismatch_error));
        }
        if (String.isBlank(errMsg)) {
         invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).remainingAmount =
          invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).remainingAmount - invEle.Allocated_Amount;
         if ((invEle.Reason_Code == CCME_Constants.WRITE_OFF) || (invEle.Reason_Code == CCME_Constants.PAY_LATER)) {
          invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Reason_Code__c = invEle.Reason_Code;
         }
         invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Transaction_Type__c = invEle.Transaction_Type;
         invAllocation.invoiceWrapperMap.put(invEle.MARS_Invoice_Id, invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id));
        }
       }
      }
      if (String.isBlank(errMsg)) {
       if (eleCINpayeeMap.containsKey(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
        String payeeIdString = invEle.Payee_Id;
        payeeString = payeeIdString.leftPad(10).replace(' ', '0');
        if (!eleCINpayeeMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).contains(payeeString)) {
         if (associatePayeeId) {
          payeeIdFinalSet = new Set < String > ();
          if (eleCINpayeeFinalMap.containsKey(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
           payeeIdFinalSet = eleCINpayeeFinalMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year));
          }
          payeeIdFinalSet.add(payeeString);
          eleCINpayeeFinalMap.put(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year), payeeIdFinalSet);
          if (!elePayeeIdpayeeNameMap.containsKey(payeeString)) {
           elePayeeIdpayeeNameMap.put(payeeString, invEle.Payee_Name);
          }
         } else {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_payee_id_association_error;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_payee_id_association_error));
         }
        }
       }
      }
      if (!uploadsuccessPaymentWrapperMap.containsKey(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
       CCME_InvoiceAllocationController.InvoicePaymentWrapper paymntWrapper = new CCME_InvoiceAllocationController.InvoicePaymentWrapper();
       paymntWrapper.invoiceId = invEle.MARS_Invoice_Id;
       paymntWrapper.elementId = invEle.Element_Id;
       paymntWrapper.elementCIN = eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year);
       paymntWrapper.allocatedAmount = invEle.Allocated_Amount;
       paymntWrapper.isElementValid = true;
       paymntWrapper.isInvoiceValid = true;
       uploadsuccessPaymentWrapperMap.put(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year), paymntWrapper);
      }
     } else {
      if (!invacIds.contains(invEle.MARS_Invoice_Id)) //UnComment
      {
       if (!noInvoice) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_notpresent_validation;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_notpresent_validation));
       }
      }
      if (!eleacIds.contains(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) {
       if (!noElement) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_notpresent_validation;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_notpresent_validation));
       }
      }
     }
     if (!(String.isBlank(errMsg))) {
      commonerrmsg += '<br></br>' + invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year;
      errMsg1 = finalerrMsg + commonerrmsg;
     }
    }
   }
   if ((String.isBlank(errMsg1))) {
    List < CCME_Contract_Element_Cust_Sel_Payee__c > newPayeeList = new List < CCME_Contract_Element_Cust_Sel_Payee__c > ();
    List < CCME_Customer_Selection__c > custSelectionList = [Select Id, Name, Contract_Element_Internal_Id_Display__c
     FROM CCME_Customer_Selection__c where Contract_Element_Internal_Id_Display__c IN: eleCINpayeeFinalMap.keySet() LIMIT 10000
    ];
    for (CCME_Customer_Selection__c cs: custSelectionList) {
     for (String payeeId: eleCINpayeeFinalMap.get(cs.Contract_Element_Internal_Id_Display__c)) {
      CCME_Contract_Element_Cust_Sel_Payee__c newPayee = new CCME_Contract_Element_Cust_Sel_Payee__c();
      newPayee.CCME_Customer_Selection__c = cs.Id;
      newPayee.AP_Vendor_Number__c = payeeId;
      newPayee.Payee_Name__c = elePayeeIdpayeeNameMap.get(payeeId);
      newPayee.Is_Primary_Payment__c = false;
      newPayeeList.add(newPayee);
     }
    }
    if (!CCME_Utilities.nullOrEmpty(newPayeeList) || !newPayeeList.IsEmpty()) {
     try {
      database.insert(newPayeeList);
     } catch (DMLException e) {
      errMsg += '<br></br>' + e.getDMLMessage(0);
     }
    }
   }
   ApexPages.Message[] pageMessages = ApexPages.getMessages();
   if ((String.isBlank(errMsg1)) && (pageMessages.size() == 0)) {
    hassaveError = true;
    invAllocation.showReviewAllocationSummary = true;
    showReviewAllocationSummary = true;
    showButtons = true;
    invAllocation.successPaymentWrapperMap = uploadsuccessPaymentWrapperMap;
    uploadEleWrapperMap = invAllocation.elementWrapperMap;
    uploadInvWrapperMap = invAllocation.invoiceWrapperMap;
    retPage = Page.CCME_ContinueAllocation.setRedirect(false);
   } else {
    hassaveError = false;
    invAllocation.showReviewAllocationSummary = false;
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errMsg1));
    uploadErr=true;
    errMsg1 = CCME_Constants.BLANK_STR;
    errMsg = CCME_Constants.BLANK_STR;
    finalerrMsg = CCME_Constants.BLANK_STR;
    selectedInvWrapMap.clear();
    retPage = null;
   }
   //showButtons=false;    
   errMsg = CCME_Constants.BLANK_STR;
   finalerrMsg = CCME_Constants.BLANK_STR;
   return retPage;
  }
  
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      This method is to achieve to upload Invoice Allocation CSV file
   * @param            null
   * @return           PageReference
   */
  //added by PSB
 public pageReference uploadCSVSearch() {
   PageReference retPage;
   String payeeString = CCME_Constants.BLANK_STR;
   isUpFrmPaymentDash=true;
   selectedInvWrapMap = new Map < String, invExpWrapper > ();
   selectedInvMap = new Map < String, Decimal > ();
   invRsnCodeMap = new Map < String, Boolean > ();
   eleIdInternalIdMap = new Map < String, String > ();
   eleCINpayeeMap = new Map < String, Set < String >> ();
   payeeIdSet = new Set < String > ();
   eleCINpayeeFinalMap = new Map < String, Set < String >> ();
   payeeIdFinalSet = new Set < String > ();
   elePayeeIdpayeeNameMap = new Map < String, String > ();
   invAllocation = new CCME_InvoiceAllocationController();
   invAllocation.elementWrapperMap = new Map < String, CCME_InvoiceAllocationController.ElementWrapper > ();
   invAllocation.invoiceWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoiceWrapper > ();
   invAllocation.showReviewAllocationSummary = false;
   uploadsuccessPaymentWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoicePaymentWrapper > ();
   successPaymentWrapperMap = new Map < String, InvoicePaymentWrapper > ();
   uploadEleWrapperMap = new Map < String, CCME_InvoiceAllocationController.ElementWrapper > ();
   uploadInvWrapperMap = new Map < String, CCME_InvoiceAllocationController.InvoiceWrapper > ();
   Set < String > invIds = new Set < String > ();
   Set < String > eleIds = new Set < String > ();
   Set < String > managingIds = new Set < String > ();
   invacIds = new Set < String > ();
   eleacIds = new Set < String > ();
   validationError = false;
   hassownershipIdError = false;
   errMsg = CCME_Constants.BLANK_STR;
   finalerrMsg = CCME_Constants.BLANK_STR;
   errMsg1 = CCME_Constants.BLANK_STR;
   commonerrmsg = CCME_Constants.BLANK_STR;
   Set < String > ManagingOwnIds = new Set < String > ();
   Boolean rsnCodeerror = false;
   Set < String > payeeIdownershipIdSet = new Set < String > ();
   selectedInvWrapList = new List < invExpWrapper > ();
   uploadJson = desanitizeJson(uploadJson);
   try {
    selectedInvWrapList = (List < invExpWrapper > ) JSON.deserialize(uploadJson, List < invExpWrapper > .class);
   } catch (Exception e) {
    errMsg = Label.CCME_Upload_Allocation_generic_validation;
   }
   finalerrMsg = Label.CCME_Upload_Allocation_generic_combination;
   for (CCME_User_Bottler__c userBottler: [SELECT Id, Name, Ownership_ID__c, User__c FROM CCME_User_Bottler__c WHERE User__c = : userInfo.getUserId()
     ORDER BY Ownership_ID__c ASC LIMIT 1000
    ]) {
    ManagingOwnIds.add(String.ValueOf(userBottler.Ownership_ID__c));
   }
   for (invExpWrapper invEle: selectedInvWrapList) {
    errMsg = CCME_Constants.BLANK_STR;
    //added below condition for INC6093650
     if(!CCME_Utilities.nullOrEmpty(invEle.Allocated_Amount))
      {
       if((((invEle.Remaining_Invoice_Amount)>0) && ((invEle.Allocated_Amount)<0)) || (((invEle.Remaining_Invoice_Amount)<0) && ((invEle.Allocated_Amount)>0))){
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,Label.CCME_Invalid_Payment));                       
      } 
     } 
    if (CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_generic_Invoice_Validation;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_generic_Invoice_Validation));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Element_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_generic_Element_Validation;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_generic_Element_Validation));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Element_Description)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_desc_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_desc_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Year)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_year_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_year_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Number)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_number_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_number_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Description)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_desc_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_desc_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Invoice_Date)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_date_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_date_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Total_Invoice_Amount)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_total_amnt_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_total_amnt_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Remaining_Invoice_Amount)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_remaining_inv_amnt_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_remaining_inv_amnt_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Allocated_Amount)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_alc_amnt_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_alc_amnt_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Payee_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_Payee_Id_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_Payee_Id_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Payee_Name)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_payee_name_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_payee_name_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Transaction_Type)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_transaction_type_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_transaction_type_error));
     validationError = true;
    }
    if (CCME_Utilities.nullOrEmpty(invEle.Managing_Ownership_Id)) {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_managing_ownId_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_managing_ownId_error));
     validationError = true;
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
     invIds.add(invEle.MARS_Invoice_Id);
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.Element_Id) && !CCME_Utilities.nullOrEmpty(invEle.Year)) {
     eleIds.add(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year);
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.Payee_Id)) {
     String payeeIdString = invEle.Payee_Id;
     payeeString = payeeIdString.leftPad(10).replace(' ', '0');
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.Managing_Ownership_Id) && !CCME_Utilities.nullOrEmpty(payeeString)) {
     payeeIdownershipIdSet.add(String.ValueOf(payeeString) + CCME_Constants.UNDERSCORE + String.ValueOf(invEle.Managing_Ownership_Id));
     managingIds.add(invEle.Managing_Ownership_Id);
    }
    if ((managingIds.size() > 1) && (managingIds.size() == 2)) {
     hassownershipIdError = true;
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_multiple_ownership_ids_error;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_multiple_ownership_ids_error));
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id)) {
     if (selectedInvMap.containsKey(invEle.MARS_Invoice_Id)) {
      Decimal AllocatedAmount = selectedInvMap.get(invEle.MARS_Invoice_Id);
      AllocatedAmount = math.abs(AllocatedAmount) + math.abs(invEle.Allocated_Amount);
      selectedInvMap.put(invEle.MARS_Invoice_Id, AllocatedAmount);
     } else {
      selectedInvMap.put(invEle.MARS_Invoice_Id, invEle.Allocated_Amount);
     }
    }
    if (!CCME_Utilities.nullOrEmpty(invEle.MARS_Invoice_Id) && !CCME_Utilities.nullOrEmpty(invEle.Element_Id) && !CCME_Utilities.nullOrEmpty(invEle.Year)) {
     if (selectedInvWrapMap.containsKey(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) {
      if (!hassownershipIdError && (validationError == false)) {
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_ele_combo_error));
       errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_ele_combo_error;
      }
     } else if (Math.abs(invEle.Total_Invoice_Amount) < Math.abs(invEle.Remaining_Invoice_Amount)) {
      if (!hassownershipIdError && (validationError == false)) {
       errMsg += '<br></br>' + Label.CCME_Upload_Allocation_total_amnt_remaining_amnt_error;
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_total_amnt_remaining_amnt_error));
      }
     } else {
      selectedInvWrapMap.put(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year, invEle);
     }
    }
    if (!(String.isBlank(errMsg))) {
     if (!hassownershipIdError && (validationError == false)) {
      commonerrmsg += '<br></br>' + invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year;
      errMsg1 = finalerrMsg + commonerrmsg;
     }
    }
   }
   //errMsg=CCME_Constants.BLANK_STR;
   List < CCME_Multi_Vendor__c > multiList = [Select Id, Name, Ownership_ID_Display__c, PayeeName_OwnershipId__c FROM CCME_Multi_Vendor__c where PayeeName_OwnershipId__c IN: payeeIdownershipIdSet LIMIT 10000];
   List < CCME_Local_Vendor__c > localList = [Select Id, Name, Ownership_ID_Display__c, PayeeName_OwnershipId__c FROM CCME_Local_Vendor__c where PayeeName_OwnershipId__c IN: payeeIdownershipIdSet LIMIT 10000];
   List < CCME_Manual_Invoice__c > manList = [Select Id, Managing_Partner_Ownership_Id__c, Allocated_Amount__c,Paper_Invoice_Number__c, Payee_Id__c, Payee_Name__c, Invoice_Value__c, Invoice_Date__c, Managing_Ownership_Id_Display__c, Transaction_Type__c, Remaining_Invoice_Amount__c, Reason_Code__c, Name, Invoice_Description__c from CCME_Manual_Invoice__c where Name IN: invIds LIMIT 10000];
   List < CCME_Contract_Element__c > coneleList = [Select Accounting_Type_Description__c, Total_Budget_Report__c, Id, Active_Chk__c, Contract_Description__c, Approval_Status__c, User_Description__c, Element_Year__c, Name, Managing_Ownership_ID__c, CCME_Contract_Id__c, Contract_Element_Internal_Id_Display__c, Element_Id_Year__c, Accounting_Prepay_Chk__c, Element_Year_Display__c, CCME_Contract__c, Element_Type__c, Element_Id__c, End_Date__c, Element_Version_Number__c, Managing_Partner_Ownership_Id__c, Start_Date__c from CCME_Contract_Element__c where Element_Id_Year__c IN: eleIds and Approval_Status__c = 'Approved'
    and Active_Chk__c = true LIMIT 10000
   ];
   List < CCME_Contract_Element_Cust_Sel_Payee__c > payeeList = [Select Id, Contract_Element_Internal_Id_Display__c, AP_Vendor_Number__c,
    CCME_Customer_Selection__r.CCME_Contract_Element__r.Element_Id_Year__c
    FROM CCME_Contract_Element_Cust_Sel_Payee__c
    where CCME_Customer_Selection__r.CCME_Contract_Element__r.Element_Id_Year__c IN: eleIds LIMIT 10000
   ];
   for (CCME_Contract_Element_Cust_Sel_Payee__c payee: payeeList) {
    payeeIdSet = new Set < String > ();
    if (eleCINpayeeMap.containsKey(payee.Contract_Element_Internal_Id_Display__c)) {
     payeeIdSet = eleCINpayeeMap.get(payee.Contract_Element_Internal_Id_Display__c);
    }
    payeeIdSet.add(payee.AP_Vendor_Number__c);
    eleCINpayeeMap.put(payee.Contract_Element_Internal_Id_Display__c, payeeIdSet);
   }
   if (!hassownershipIdError && (validationError == false)) {
    if ((!(manList.size() > 0)) || (CCME_Utilities.nullOrEmpty(manList))) //Uncomment
    {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_uploaded_inv_notexist_error;
     noInvoice = true;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_uploaded_inv_notexist_error));
    } else {
     for (CCME_Manual_Invoice__c inv: manList) {
      errMsg = CCME_Constants.BLANK_STR;
      invacIds.add(inv.Name);
      if (!invAllocation.invoiceWrapperMap.containsKey(inv.Name)) {
       CCME_InvoiceAllocationController.InvoiceWrapper invoiceWrapper = new CCME_InvoiceAllocationController.InvoiceWrapper(inv);
       invAllocation.invoiceWrapperMap.put(inv.name, invoiceWrapper);
      }
      if (selectedInvMap.containsKey(String.ValueOf(inv.Name))) {
       if (math.abs(selectedInvMap.get(String.ValueOf(inv.Name))) < math.abs(inv.Remaining_Invoice_Amount__c)) {
        if (CCME_Utilities.nullOrEmpty(inv.Reason_Code__c)) {
         if (invRsnCodeMap.containsKey(String.ValueOf(inv.Name))) {
          if (!invRsnCodeMap.get(String.ValueOf(inv.Name))) {
           invRsnCodeMap.put(String.ValueOf(inv.Name), true);
          }
         } else {
          invRsnCodeMap.put(String.ValueOf(inv.Name), true);
         }
        }
       } else if (math.abs(selectedInvMap.get(String.ValueOf(inv.Name))) > math.abs(inv.Remaining_Invoice_Amount__c)) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_allocated_amount_exceeds_error + inv.Name;
        Decimal allocatedamnt = selectedInvMap.get(String.ValueOf(inv.Name));
        Decimal allocatedfinalamnt = allocatedamnt.setScale(2);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'For the Invoice : ' + inv.Name + ' Allocated Amount : ' + ' ' + ' $' + allocatedfinalamnt + ' ' + 'is greater than Remaining Invoice Amount : ' + ' ' + '$' + inv.Remaining_Invoice_Amount__c + '.' + 'Please reallocate Remaining Invoice Amount and try again'));
       }
      }
     }
    }
   }
   if (!hassownershipIdError && (validationError == false)) {
    if ((!(coneleList.size() > 0)) || (CCME_Utilities.nullOrEmpty(coneleList))) //Uncomment
    {
     errMsg += '<br></br>' + Label.CCME_Upload_Allocation_uploaded_element_notexists_error;
     noElement = true;
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_uploaded_element_notexists_error));
    } else {
     for (CCME_Contract_Element__c ele: coneleList) {
      errMsg = CCME_Constants.BLANK_STR;
      eleacIds.add(ele.Element_Id__c + CCME_Constants.UNDERSCORE + ele.Element_Year__c);
      if (!invAllocation.elementWrapperMap.containsKey(ele.Contract_Element_Internal_Id_Display__c)) {
       CCME_InvoiceAllocationController.ElementWrapper eleWrapper = new CCME_InvoiceAllocationController.ElementWrapper(ele);
       invAllocation.elementWrapperMap.put(ele.Contract_Element_Internal_Id_Display__c, eleWrapper);
      }
      if (!eleIdInternalIdMap.containsKey(ele.Element_Id_Year__c)) {
       eleIdInternalIdMap.put(ele.Element_Id_Year__c, ele.Contract_Element_Internal_Id_Display__c);
      }
     }
    }
   }
   if (((String.isBlank(errMsg1)) && (String.isBlank(errMsg))) && (!hassownershipIdError && (validationError == false))) {
    for (invExpWrapper invEle: selectedInvWrapMap.values()) {
     errMsg = CCME_Constants.BLANK_STR;
     if ((eleacIds.contains(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) && (invacIds.contains(invEle.MARS_Invoice_Id))) {
      if (invRsnCodeMap.containsKey(invEle.MARS_Invoice_Id)) {
       if (CCME_Utilities.nullOrEmpty(invEle.Reason_Code)) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_reason_code_enter_error;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_reason_code_enter_error));
       } else if (!((invEle.Reason_Code == CCME_Constants.WRITE_OFF) || (invEle.Reason_Code == CCME_Constants.PAY_LATER))) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_reason_code_error;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_reason_code_error));
       }
      }
      if (String.isBlank(errMsg)) {
       if (invAllocation.invoiceWrapperMap.containsKey(invEle.MARS_Invoice_Id)) {
        if (invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c.equals(invAllocation.elementWrapperMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).element.Managing_Ownership_ID__c)) {
         if (!(invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c.equals(invEle.Managing_Ownership_Id))) {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ownershipId_mismatch_error;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ownershipId_mismatch_error));
         } else if (!(invAllocation.elementWrapperMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).element.Managing_Ownership_ID__c.equals(invEle.Managing_Ownership_Id))) {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ownershipId_ele_mismatch_error;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ownershipId_ele_mismatch_error));
         }
         if (!ManagingOwnIds.contains(invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c)) {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_user_ownershipId_associated_error + invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_user_ownershipId_associated_error + invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Managing_Ownership_Id_Display__c));
         }
        } else {
         errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_ele_ownershipId_mismatch_error;
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_ele_ownershipId_mismatch_error));
        }
        if (String.isBlank(errMsg)) {
         invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).remainingAmount =
          invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).remainingAmount - invEle.Allocated_Amount;
         if ((invEle.Reason_Code == CCME_Constants.WRITE_OFF) || (invEle.Reason_Code == CCME_Constants.PAY_LATER)) {
          invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Reason_Code__c = invEle.Reason_Code;
         }
         invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id).invoice.Transaction_Type__c = invEle.Transaction_Type;
         invAllocation.invoiceWrapperMap.put(invEle.MARS_Invoice_Id, invAllocation.invoiceWrapperMap.get(invEle.MARS_Invoice_Id));
        }
       }
      }
      if (String.isBlank(errMsg)) {
       if (eleCINpayeeMap.containsKey(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
        String payeeIdString = invEle.Payee_Id;
        payeeString = payeeIdString.leftPad(10).replace(' ', '0');
        if (!eleCINpayeeMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)).contains(payeeString)) {
         if (associatePayeeId) {
          payeeIdFinalSet = new Set < String > ();
          if (eleCINpayeeFinalMap.containsKey(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
           payeeIdFinalSet = eleCINpayeeFinalMap.get(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year));
          }
          payeeIdFinalSet.add(payeeString);
          eleCINpayeeFinalMap.put(eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year), payeeIdFinalSet);
          if (!elePayeeIdpayeeNameMap.containsKey(payeeString)) {
           elePayeeIdpayeeNameMap.put(payeeString, invEle.Payee_Name);
          }
         } else {
          errMsg += '<br></br>' + Label.CCME_Upload_Allocation_payee_id_association_error;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_payee_id_association_error));
         }
        }
       }
      }
      if (!uploadsuccessPaymentWrapperMap.containsKey(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year))) {
       CCME_InvoiceAllocationController.InvoicePaymentWrapper paymntWrapper = new CCME_InvoiceAllocationController.InvoicePaymentWrapper();
       paymntWrapper.invoiceId = invEle.MARS_Invoice_Id;
       paymntWrapper.elementId = invEle.Element_Id;
       paymntWrapper.elementCIN = eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year);
       paymntWrapper.allocatedAmount = invEle.Allocated_Amount;
       paymntWrapper.isElementValid = true;
       paymntWrapper.isInvoiceValid = true;
       uploadsuccessPaymentWrapperMap.put(invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + eleIdInternalIdMap.get(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year), paymntWrapper);
      }
     } else {
      if (!invacIds.contains(invEle.MARS_Invoice_Id)) //UnComment
      {
       if (!noInvoice) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_inv_notpresent_validation;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_inv_notpresent_validation));
       }
      }
      if (!eleacIds.contains(invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year)) {
       if (!noElement) {
        errMsg += '<br></br>' + Label.CCME_Upload_Allocation_ele_notpresent_validation;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.CCME_Upload_Allocation_ele_notpresent_validation));
       }
      }
     }
     if (!(String.isBlank(errMsg))) {
      commonerrmsg += '<br></br>' + invEle.MARS_Invoice_Id + CCME_Constants.UNDERSCORE + invEle.Element_Id + CCME_Constants.UNDERSCORE + invEle.Year;
      errMsg1 = finalerrMsg + commonerrmsg;
     }
    }
   }
   if ((String.isBlank(errMsg1))) {
    List < CCME_Contract_Element_Cust_Sel_Payee__c > newPayeeList = new List < CCME_Contract_Element_Cust_Sel_Payee__c > ();
    List < CCME_Customer_Selection__c > custSelectionList = [Select Id, Name, Contract_Element_Internal_Id_Display__c
     FROM CCME_Customer_Selection__c where Contract_Element_Internal_Id_Display__c IN: eleCINpayeeFinalMap.keySet() LIMIT 10000
    ];
    for (CCME_Customer_Selection__c cs: custSelectionList) {
     for (String payeeId: eleCINpayeeFinalMap.get(cs.Contract_Element_Internal_Id_Display__c)) {
      CCME_Contract_Element_Cust_Sel_Payee__c newPayee = new CCME_Contract_Element_Cust_Sel_Payee__c();
      newPayee.CCME_Customer_Selection__c = cs.Id;
      newPayee.AP_Vendor_Number__c = payeeId;
      newPayee.Payee_Name__c = elePayeeIdpayeeNameMap.get(payeeId);
      newPayee.Is_Primary_Payment__c = false;
      newPayeeList.add(newPayee);
     }
    }
    if (!CCME_Utilities.nullOrEmpty(newPayeeList) || !newPayeeList.IsEmpty()) {
     try {
      database.insert(newPayeeList);
     } catch (DMLException e) {
      errMsg += '<br></br>' + e.getDMLMessage(0);
     }
    }
   }
   ApexPages.Message[] pageMessages = ApexPages.getMessages();
   if ((String.isBlank(errMsg1)) && (pageMessages.size() == 0)) {
    hassaveError = true;
    invAllocation.showReviewAllocationSummary = true;
    showReviewAllocationSummary = true;
    showButtons = true;
    invAllocation.successPaymentWrapperMap = uploadsuccessPaymentWrapperMap;
    uploadEleWrapperMap = invAllocation.elementWrapperMap;
    uploadInvWrapperMap = invAllocation.invoiceWrapperMap;
    retPage = Page.CCME_ContinueAllocation.setRedirect(false);
   } else {
    hassaveError = false;
    invAllocation.showReviewAllocationSummary = false;
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errMsg1));
    uploadErr=true;
    errMsg1 = CCME_Constants.BLANK_STR;
    errMsg = CCME_Constants.BLANK_STR;
    finalerrMsg = CCME_Constants.BLANK_STR;
    selectedInvWrapMap.clear();
    retPage = null;
   }
   //showButtons=false;    
   errMsg = CCME_Constants.BLANK_STR;
   finalerrMsg = CCME_Constants.BLANK_STR;
   return retPage;
  }
  
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      This method is to hide button dispalyed in the Page
   * @param            null
   * @return           PageReference
   */
 public PageReference hideButtons() {
   try {
    if (!hassaveError) {
     showButtons = false;
    }
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return null;
  }
  /**
   * @author            Accenture
   * @version           1.0
   * @date              11/28/2016
   * @description       method to return the size of successPaymentWrapperMap.
   * @param             none
   * @return            null
   */
 public Integer getSuccessPaymentWrapperMapSize() {
   return successPaymentWrapperMap.size();
  }
  /**   * @author            Accenture
   * @version           1.0
   * @date              12/03/2015
   * @description       Method to get select option for Managing Ownership Id filtering
   * @param             none
   * @return            List<SelectOption>
   */
 public List < SelectOption > getOwnershipIdValues() {
   Map < String, SelectOption > idMap = new Map < String, SelectOption > ();
   try {
    idMap.put(CCME_Constants.ALL_PAYEEID, new SelectOption(CCME_Constants.ALL_PAYEEID, CCME_Constants.ALL_PAYEEID));
    //SelectOption tempOption = null;
    for (CCME_User_Bottler__c userBottler: [SELECT Id, Name, Ownership_ID__c, User__c FROM CCME_User_Bottler__c WHERE User__c = : userInfo.getUserId() ORDER BY Ownership_ID__c ASC LIMIT 1000]) {
     idMap.put(string.valueOf(userBottler.Ownership_id__c), new SelectOption(string.valueOf(userBottler.Ownership_id__c), string.valueOf(userBottler.Ownership_id__c)));
    }
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return idMap.values();
  }
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      This method is to redirect to Payment Page
   * @param            null
   * @return           PageReference
   */
 public PageReference backToPayment() {
   try {
    invAllocation.showReviewAllocationSummary = false;
    showReviewAllocationSummary = false;
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return null;
  }
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      This method is to rerender Navigation block in the Payment Flow
   * @param            null
   * @return           PageReference
   */
 public PageReference renderNavigation() {
   try {
    step2SubDetails = '(4 of 5)';
    step2SubStepName = 'Upload Preview ';
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return null;
  }
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      This method is to redirect to Payment Page
   * @param            null
   * @return           PageReference
   */
 public PageReference close() {
   PageReference nextpage = Page.CCME_PaymentHome;
   try {
    nextpage.setRedirect(true);
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return nextpage;
  }
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      This method is to redirect the user to New Payment Home Page
   * @param            null
   * @return           PageReference
   */
 public PageReference goToNewPayHome() {
   PageReference retPage = Page.CCME_PaymentHome;
   try {
    retPage.setRedirect(true);
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return retPage;
  }
  /**   * @author            Accenture
   * @version           1.0
   * @date              12/03/2015
   * @description       Method to show table after filter based on the Managing Ownership Id
   * @param             none
   * @return            PageReference
   */
 public pageReference showTableAfterFilter() {
   try {
    for (Integer i = 0; i < invAllocation.managingOwnerShipIdPaymentIdsMap.size(); i++) {
     if (!invAllocation.managingOwnerShipIdPaymentIdsMap.containsKey(Decimal.ValueOf(seletedManagingId))) {
      invAllocation.managingOwnerShipIdPaymentIdsMap.remove(i);
     }
    }
    if (!CCME_Utilities.nullOrEmpty(seletedManagingId)) {
     invAllocation.paymentHeaderIds = invAllocation.managingOwnerShipIdPaymentIdsMap.get(Decimal.ValueOf(seletedManagingId));
    }
    if (CCME_Utilities.nullOrEmpty(invAllocation.paymentHeaderIds)) {
     hasPayments = true;
    }
   } catch (Exception e) {
    ApexPages.addMessages(e);
   }
   return null;
  }
  /**
   * @author           Accenture
   * @version          1.0
   * @date             06/25/2018
   * @description      Wrapper Class for Invoice Payment Wrapper
   */
 public with Sharing class InvoicePaymentWrapper {
  public String invoiceId {
   get;
   set;
  }
  public String elementId {
   get;
   set;
  }
  public String elementCIN {
   get;
   set;
  }
  public Decimal allocatedAmount {
   get;
   set;
  }
  public Boolean isElementValid {
   get;
   set;
  }
  public Boolean isInvoiceValid {
   get;
   set;
  }
  /**
   * @author            Accenture
   * @version           1.0
   * @date              11/28/2016
   * @description       method to initialize invoice payment details.
   * @param             none
   * @return            pageReference
   */
  public InvoicePaymentWrapper() {
   invoiceId = CCME_Constants.BLANK_STR;
   elementId = CCME_Constants.BLANK_STR;
   elementCIN = CCME_Constants.BLANK_STR;
   allocatedAmount = 0.0;
  }
 }
 /**
  * @author           Accenture
  * @version          1.0
  * @date             06/25/2018
  * @description      Wrapper Class Upload Invoice Allocation Flow
  */
 public with sharing class invExpWrapper {
  public String MARS_Invoice_Id {
   get;
   set;
  }
  public String Element_Id {
   get;
   set;
  }
  public String Element_Description {
   get;
   set;
  }
  public String Year {
   get;
   set;
  }
  public String Invoice_Number {
   get;
   set;
  }
  public String Invoice_Description {
   get;
   set;
  }
  public String Invoice_Date {
   get;
   set;
  }
  public Double Total_Invoice_Amount {
   get;
   set;
  }
  public Double Remaining_Invoice_Amount {
   get;
   set;
  }
  public Double Allocated_Amount {
   get;
   set;
  }
  public String Payee_Id {
   get;
   set;
  }
  public String Payee_Name {
   get;
   set;
  }
  public String Reason_Code {
   get;
   set;
  }
  public String Transaction_Type {
   get;
   set;
  }
  public String Managing_Ownership_Id {
   get;
   set;
  }
  // public invExpWrapper(){}
 }
 /**
  * @author           Accenture
  * @version          1.0
  * @date             07/25/2016
  * @description      This method is to remove the escape & wrapping double quotes character from JSON
  * @param            String jsonStr - JSON String
  * @return           String 
  */
 public String desanitizeJson(String jsonStr) {
  jsonStr = jsonStr.replace('\\"', '"');
  jsonStr = jsonStr.replace('"{', '{');
  jsonStr = jsonStr.replace('}"', '}');
  jsonStr = jsonStr.replace('"[', '[');
  jsonStr = jsonStr.replace(']"', ']');
  return jsonStr;
 }
}