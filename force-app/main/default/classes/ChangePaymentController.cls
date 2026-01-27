public class ChangePaymentController {
    
    //--Var ChangePaymentPage
    public String paramContactId {get; set;}
    public String paramEntity {get; set;}
    public String paramOrigin {get; set;}
    public String paramPaymentType {get; set;}
    public String paramSendEmail {get; set;}
    public String paramKYC {get; set;}
    public Boolean EnablePaymentType {get; set;} // AMFS, for PureCloud
    public Boolean TestValidateTrue {get; set;} // AMFS, enable validate for testclass
    
    public List<SelectOption> listOfPaymentType;                //Store picklist value for Payment Type
    public String selectedOrigin {get; set;}
    public String selectedItem {get; set;}                      //Selected value from picklist Payment Type
    public String selectedPaymentFrequency {get; set;}                      //Selected value from picklist Payment Frequency
    public Boolean changeName {get; set;}
    public Boolean beneficialOwner {get; set;}
    public Boolean sendEmail {get; set;}
    public Boolean BothApps {get; set;}
    public Boolean RenderUpdateBoth {get; set;}    
    public MID_Secure_Payment__c bankNamePrivate {get; set;}
    public MID_Master_Parameter__c MIDParameter {get; set;}
    public String otherBankNamePrivate {get; set;}
    public String cardNumberPrivate {get; set;}
    public String expiryDatePrivate {get; set;}
    public String cardHolderName {get; set;}
    public MID_Secure_Payment__c bankNameSaving {get; set;}
    public String otherBankNameSaving {get; set;}
    public String accountNumberSaving {get; set;}
    public String accountNameSaving {get; set;}
    public MID_Secure_Payment__c cLookup {get; set;}            //Initial lookup for first contact to get contactId
    public MID_Secure_Payment__c PCIDSSStatus {get; set;}            //to see the status PCIDSS, after Save data or Generate OrderID
    public String contactEmail {get; set;}
    public String contactMobilePhone {get; set;}
    public String contactName {get; set;}
    public String contactPolicyNo {get; set;}
    public String contactPolicyApp {get; set;}
    public String contactEntity {get; set;}
    public String contactStatus {get; set;}
    public String firstContactId {get; set;}                    //Store current selected contactId from Initial lookup
    public MID_Secure_Payment__c TempOrder {get;set;}
    public Contact firstContact {get; set;}                     //Single first contact
    public List<Contact> contactList {get; set;}                //List secondary contact
    public String initialOrderId {get; set;}                    //Store Order Id for transaction other than (WalkIN with VISA/Master/JCB)
    public String initialOrderId2 {get; set;}                    //Store Order Id for transaction other than (WalkIN with VISA/Master/JCB)
    public String selectedContactId {get; set;}                 //Store datatable selectedContact
    public String selectedMidChildId {get; set;}                 //Store datatable selectedContact
    public MID_Secure_Payment__c addLookup {get; set;}          //Additional contact lookup
    public String captionMessage {get; set;}                    //Placeholder message error duplicate
    public Boolean lockPage {get; set;}
    public Boolean flagVsnap {get; set;}
    public Boolean saveDataResult {get; set;}
    public String CheckLuhnText {get; set;}    
    public Boolean CheckLuhnBoolean {get; set;}
    public String EmailListAttachment {get; set;}    
    public String errMsgInsuredDtl {get; set;}    
    
    //--Var TermsAndConditionsPage
    public Boolean termsCheck {get; set;}
    public String policyNumber {get; set;}                  //Retrieve from page parameter
    public String policyEntity {get; set;}                  //Retrieve from page parameter
    public String policyEntityAMFS2 {get; set;}                  //Retrieve from page parameter    khusus untuk RLS=AMFS2
    public String policyApp {get; set;}                  //Retrieve from page parameter
    public String policyOrderCode {get; set;}                  //Retrieve from page parameter
    public Double policygross_amount {get; set;}                  //Retrieve from page parameter
    public String thisRecordOrderId {get; set;}             //Return custom object order id SFDC
    public String snapJs {get; set;}                        //Store url to call snapJs
    public String dataClientKey {get; set;}                 //Store value of client key
    
    //--Var OrderStatusPage
    public String orderId {get; set;}
    public String statusCode {get; set;}
    public String transactionId {get; set;}
    
    //--Var PolicySelectorPage
    public String paramSelector {get; set;}             //Store param sent by ChangePaymentPage for query
    
    //--Value used in switch payment
    public String vsnapToken {get; set;}
    public String trxRefNo {get; set;}
    public String transactionStatus {get; set;}
    public String transactionTime {get; set;}
    
    // create custom object
    public class MidNotification {
        public string mid_order_id {get; set;}
        public string mid_masked_card    {get; set;}
        public string mid_approval_code  {get; set;}
        public string mid_bank  {get; set;}
        public string mid_transaction_time  {get; set;}
        public string mid_custom_field1  {get; set;}
        public string mid_custom_field2  {get; set;}
        public string mid_custom_field3  {get; set;}
        public string mid_gross_amount   {get; set;}
        public string mid_payment_type {get; set;}
        public string mid_signature_key   {get; set;}
        public string mid_status_code {get; set;}
        public string mid_transaction_id {get; set;}
        public string mid_transaction_status {get; set;}
        public string mid_fraud_status {get; set;}
        public string mid_status_message {get; set;}
        public string mid_saved_token_id {get; set;}
        public string mid_saved_token_id_expired_at {get; set;}

        public MidNotification(){
        }       
    }    
    
    public MidNotification MidNotification {get;set;}
    
    //--Constructor controller
    public ChangePaymentController() {
        
    }
    
    //--Init for ChangePaymentPage
    public void ChangePaymentInit() {
        paramContactId = ApexPages.currentPage().getParameters().get('contact_id');
        paramEntity = ApexPages.currentPage().getParameters().get('Entity');
        paramOrigin = ApexPages.currentPage().getParameters().get('Origin');
        paramPaymentType = ApexPages.currentPage().getParameters().get('PaymentType');
        paramSendEmail = ApexPages.currentPage().getParameters().get('SendEmail');
        string tempparamKYC = ApexPages.currentPage().getParameters().get('ContactKYC');
        if (tempparamKYC != NULL)
            paramKYC = tempparamKYC;
        
        string EnablePaymentTypeText = ApexPages.currentPage().getParameters().get('EnablePaymentType');
        if (EnablePaymentTypeText == 'TRUE')
            EnablePaymentType = TRUE;
        
        lockPage = false;
        flagVsnap = false;
        saveDataResult = false;
        cLookup = new MID_Secure_Payment__c();
        if(String.isNotEmpty(paramContactId)) {
            cLookup.Contact__c = paramContactId;
            storeContactId();
        }
        addLookup = new MID_Secure_Payment__c();
        bankNamePrivate = new MID_Secure_Payment__c();
        bankNameSaving = new MID_Secure_Payment__c();
        firstContact = new Contact();
        contactList = new List<Contact>();
        
        // set Picklist
        bankNamePrivate.Entity__c = paramEntity;
        bankNameSaving.Entity__c = paramEntity;
        
        // default
        RenderUpdateBoth = TRUE;
        if (BothApps == NULL) BothApps = FALSE;

        User us = [SELECT id, UserRole.Name FROM User WHERE id =: UserInfo.getUserId()];
        //string myString1 = us.UserRole.Name;
        if (us.UserRole.Name != NULL) {
            selectedOrigin = 'PureCloud';
            if (us.UserRole.Name.contains('Walk-In')) {
                RenderUpdateBoth = FALSE;        
                selectedOrigin = 'WalkIN';
            }
            else if (us.UserRole.Name.contains('Inbound')) {
                RenderUpdateBoth = TRUE;        
                selectedOrigin = 'PureCloud';
            }
            else if (us.UserRole.Name.contains('Outbound')) {
                RenderUpdateBoth = TRUE;        
                selectedOrigin = 'PureCloud';
            }
        }
        
        
        if (paramEntity == 'AMFS' && paramOrigin != NULL) selectedOrigin = paramOrigin;
        if (paramEntity == 'AMFS' && paramPaymentType != NULL) selectedItem = paramPaymentType;
        //initialOrderId = 'SMART_5001234567_20191126'; //test data
        if (paramEntity == 'AMFS' && paramSendEmail != NULL && paramSendEmail !='')
            if (paramSendEmail == 'FALSE') 
                sendEmail = FALSE;
            else
                sendEmail = TRUE;
        
        beneficialOwner = FALSE;
        if (paramEntity == 'AMFS' && paramKYC != NULL && paramKYC !='')
            if (paramKYC == 'Perorangan' || paramKYC == 'Non-Perorangan') beneficialOwner = TRUE;

    }
    
    //--Init for TermsAndConditionsPage
    public void TermsAndConditionsInit() {
        policyNumber = ApexPages.currentPage().getParameters().get('PolicyNo');
        policyEntity = ApexPages.currentPage().getParameters().get('Entity');
        policyApp = ApexPages.currentPage().getParameters().get('PolicyApp');
        if (policyEntity == 'AMFS' && policyApp == 'RLS') policyEntityAMFS2 = 'AMFS2';
        beneficialOwner = Boolean.valueOf(ApexPages.currentPage().getParameters().get('Beneficialowner'));
        snapJs = 'https://app.sandbox.midtrans.com/snap/snap.js';
        dataClientKey = 'VT-client-irDmirouNS5xbPjV';
        
        // Check Master Parameter        
        //string policyEntity2 = policyEntity;
        //if (policyEntity == 'ALI') policyEntity2 = 'AFI';
        MIDParameter = [SELECT id, PolicyApp__c, Payment_Type__c, Order_Code__c, gross_amount__c, Entity__c,
                RTC_01__c, 
                TC_01__c, TC_02__c, TC_03__c, TC_04__c, TC_05__c,
                TC_06__c, TC_07__c, TC_08__c, TC_09__c, TC_10__c, snapJs__c, dataClientKey__c
            FROM MID_Master_Parameter__c WHERE Entity__c =: policyEntity AND PolicyApp__c =: policyApp AND Payment_Type__c = 'credit_card' LIMIT 1];
        PolicyOrderCode = MIDParameter.Order_Code__c;
        policygross_amount = MIDParameter.gross_amount__c;

        if (MIDParameter.snapJs__c != NULL) snapJs = MIDParameter.snapJs__c;
        if (MIDParameter.dataClientKey__c != NULL) dataClientKey = MIDParameter.dataClientKey__c;

        /*
        String currentExternalId = generateExternalId(MIDParameter.Order_Code__c, policyNumber, 'P');
        list<MID_Secure_Payment__c> listcreateOrder = [SELECT Id, External_Id_SFDC__c, SFDC_Order_Id__c, SFDC_Order_Id_Child__c, 
                    mid_masked_card__c, mid_approval_code__c, mid_bank__c, mid_transaction_time__c, mid_custom_field1__c, mid_custom_field2__c, mid_custom_field3__c, mid_gross_amount__c, 
                    mid_order_id__c, mid_payment_type__c, mid_signature_key__c, mid_status_code__c, mid_transaction_id__c, mid_transaction_status__c, mid_fraud_status__c, mid_status_message__c, mid_saved_token_id__c, mid_saved_token_id_expired_at__c, 
                    Midtrans_Token__c, Status__c 
                    FROM MID_Secure_Payment__c WHERE External_Id_SFDC__c = :currentExternalId LIMIT 1];
        if (listcreateOrder.size() > 0) thisRecordOrderId = listcreateOrder[0].Id;
        else {
            MID_Secure_Payment__c createOrder = new MID_Secure_Payment__c();
            //createOrder.External_Id_SFDC__c = 'SMART_'+ policyNumber.replace('-', '') + '_' + String.valueOf(Date.today());
            //createOrder.External_Id_SFDC__c = generateExternalId('SMART', policyNumber, 'P');
            createOrder.External_Id_SFDC__c = generateExternalId(PolicyOrderCode, policyNumber, 'P');
            upsert createOrder External_Id_SFDC__c;

            thisRecordOrderId = createOrder.Id;
        }
        */
    }
    
    //--Init for OrderStatusPage
    public void OrderStatusInit() {
        orderId = ApexPages.currentPage().getParameters().get('orderId');
        statusCode = ApexPages.currentPage().getParameters().get('statusCode');
        transactionId = ApexPages.currentPage().getParameters().get('transactionId');
        doOrderStatus();
    }

    //--Init for OrderStatusPageEIP
    public void OrderStatusInitEIP() {
        policyNumber = ApexPages.currentPage().getParameters().get('PolicyNo');
        policyEntity = ApexPages.currentPage().getParameters().get('Entity');
        policyApp = ApexPages.currentPage().getParameters().get('PolicyApp');
        selectedItem = ApexPages.currentPage().getParameters().get('selectedItem');
        String BothAppsTemp = ApexPages.currentPage().getParameters().get('BothApps');
        
        BothApps = boolean.valueof(BothAppsTemp);
        
        string paramPolicyApp = contactPolicyApp;
        if (BothApps) paramPolicyApp = 'Both';
        else paramPolicyApp = policyApp;
        MIDParameter = [SELECT id, PolicyApp__c, Payment_Type__c, Order_Code__c, gross_amount__c, Entity__c, 
                TC_01__c, TC_02__c, TC_03__c, TC_04__c, TC_05__c,
                TC_06__c, TC_07__c, TC_08__c, TC_09__c, TC_10__c
            FROM MID_Master_Parameter__c WHERE Entity__c =: policyEntity AND PolicyApp__c =: paramPolicyApp AND Payment_Type__c =: selectedItem LIMIT 1]; // PolicyApp__c =: policyApp, // 7 Jun20, check Both
        PolicyOrderCode = MIDParameter.Order_Code__c;
        policygross_amount = MIDParameter.gross_amount__c;

        String currentExternalId = generateExternalId(PolicyOrderCode, policyNumber, 'P');
        
        MID_Secure_Payment__c initialTransaction = [SELECT Id, Account_Name__c, Account_Number__c, 
            Bank_Name__c, Bank_Name_Other__c, Beneficial_Owner__c, 
            Card_Holder_Name__c, Card_Number__c, Change_Name__c, Contact__c, 
            Email__c, Email_Subject__c, Entity__c, Expiry_Date_MMYY__c, External_Id_SFDC__c, 
            flagVsnap__c, Interaction_Id__c, 
            mid_approval_code__c, mid_bank__c, mid_channel_response_code__c, mid_channel_response_message__c, 
            mid_currency__c, mid_custom_field1__c, mid_custom_field2__c, mid_custom_field3__c, 
            mid_custom_field3_temp__c, mid_EIPtokenApp_Status__c, mid_fraud_status__c, 
            mid_gross_amount__c, mid_masked_card__c, mid_order_id__c, mid_payment_type__c, 
            mid_saved_token_id__c, mid_saved_token_id_expired_at__c, mid_signature_key__c, 
            mid_status_code__c, mid_status_message__c, mid_transaction_id__c, mid_transaction_status__c, 
            mid_transaction_time__c, Midtrans_Token__c, 
            Origin__c, Parent__c, Payment_Frequency__c, Payment_Type__c, Policy_App__c, Policy_No__c, 
            Registration_Id__c, Request_Date__c, Save__c, Send_Email__c, 
            SFDC_Order_Id__c, SFDC_Order_Id_Child__c, Status__c, Status_DoOrderEIP__c

            FROM MID_Secure_Payment__c WHERE External_Id_SFDC__c = :currentExternalId LIMIT 1];

        orderId = initialTransaction.SFDC_Order_Id__c; 
        doOrderStatusEIP();
    }
    
    //--Init for PolicySelectorPage --> not used
    public void PolicySelectorInit() {
        paramSelector = ApexPages.currentPage().getParameters().get('firstContactId');
    }
    
    //--Generate picklist origin
    public List<SelectOption> getListOfOrigin() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('0', '--None--'));
        tempList.add(new SelectOption('WalkIN', 'WalkIN'));
        tempList.add(new SelectOption('PureCloud', 'PureCloud'));
        return tempList;
    }

    //--Generate picklist Payment Frequency
    public List<SelectOption> getListOfPaymentFrequency() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('Bulanan', 'Bulanan'));
        tempList.add(new SelectOption('Triwulan', 'Triwulan'));
        tempList.add(new SelectOption('Semester', 'Semester'));
        tempList.add(new SelectOption('Tahunan', 'Tahunan'));
        return tempList;
    }
    
    //--Generate picklist payment type
    public List<SelectOption> getListOfPaymentType() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('0', '--None--'));
        tempList.add(new SelectOption('saving', 'Saving Account'));
        //tempList.add(new SelectOption('credit_card', 'credit_card'));
        if (paramEntity == 'AMFS')
            tempList.add(new SelectOption('credit_card', 'Visa / Master'));
        else 
            tempList.add(new SelectOption('credit_card', 'Visa / Master / JCB'));

        if (paramEntity != 'AMFS') tempList.add(new SelectOption('private', 'Private'));
        
        return tempList;
    }

    //--Generate picklist KYC (for AMFS)
    public List<SelectOption> getListOfKYC() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('Perorangan', 'Perorangan'));
        tempList.add(new SelectOption('Non-Perorangan', 'Non-Perorangan'));
        return tempList;
    }
    
    //--Store first contact id
    public void storeContactId() {
        firstContactId = cLookup.Contact__c;
        if(firstContactId != NULL) {
            firstContact = [SELECT Id, Entity__c, Name, Email, MobilePhone, Policy_No__c, Policy_No_PCIDSS__c, PolicyApp__c FROM Contact WHERE Id = :firstContactId LIMIT 1];
            contactEmail = firstContact.Email;
            contactPolicyNo = firstContact.Policy_No_PCIDSS__c; //firstContact.Policy_no__c;
            contactPolicyApp = firstContact.PolicyApp__c;
            contactEntity = firstContact.Entity__c;
            contactMobilePhone = firstContact.MobilePhone;
            contactName = firstContact.Name;
            
        }
    }
    
    public void generateSecondaryContact() {
        if(String.isNotEmpty(firstContactId) &&  String.isNotEmpty(contactPolicyApp)) {
            List<Contact> querySecondaryContact = [SELECT Id, Name, Email, MobilePhone, Policy_No__c, PolicyApp__c, Policy_No_PCIDSS__c, Entity__c, WelcomeCall_Payment_Type__c FROM Contact 
            WHERE Entity__c =: contactEntity AND 
                PolicyApp__c = :contactPolicyApp AND 
                ((Email =: contactEmail AND Email != NULL) OR 
                Name =: contactName OR
                (MobilePhone = : contactMobilePhone AND MobilePhone != NULL)) AND
                (NOT Id = :firstContactId)];
            contactList = new List<Contact>();
            contactList.addAll(querySecondaryContact);
                        
        } else {
            captionMessage = 'No suggestion available.';
        }
    }
    
    public void addContact() {
        if(addLookup.Contact__c != NULL) {
            Contact c = [SELECT Id, Name, Email, MobilePhone, Policy_No__c, Policy_No_PCIDSS__c, PolicyApp__c, Entity__c, WelcomeCall_Payment_Type__c FROM Contact WHERE Id = :addLookup.Contact__c];
            Boolean duplicate = false;
            Map<Id, Contact> contactMap = new Map<Id, Contact>();
            contactMap.putAll(contactList);
            for(String key : contactMap.keySet()) {
                if(addLookup.Contact__c == key) {
                    duplicate = true;
                }
            }
            if(addLookup.Contact__c == firstContactId) duplicate=true;
            if(duplicate==false) {
                if (!BothApps && contactPolicyApp != c.PolicyApp__c) {
                    captionMessage = 'Policy Number must same Policy App  "'+contactPolicyApp+'"';
                }
                else {
                    contactList.add(c);
                    captionMessage = '';
                }
            } else {
                captionMessage = 'Policy Number is already selected!';
            }
        }
    }
    
    public void removeContact() {
        Map<Id, Contact> contactMap = new Map<Id, Contact>();
        contactMap.putAll(contactList);
        contactMap.remove(selectedContactId);
        contactList = new List<Contact>();
        for(String key : contactMap.keySet()) {
            contactList.add(contactMap.get(key));
        }
        captionMessage = '';
    }
    
    public String generateExternalId(String trxCode, String policyNo, String position) {
        String result = trxCode + '_' + policyNo.replace('-', '') + '_' + String.valueOf(Date.today()) + '_' + position;
        return result;
    }
    
    public String generateOrderId(String trxCode, String policyNo) {
        String result = trxCode + '_' + policyNo.replace('-', '') + '_' + String.valueOf(DateTime.now().getTime());
        return result;
    }
    
    public boolean checkvalidate(){
        boolean validate = true;
        captionMessage = '';
        if (BothApps) {
            boolean checkRLS = FALSE;
            boolean checkDMTM = FALSE;
            if (contactPolicyApp == 'DMTM') checkDMTM = TRUE;
            if (contactPolicyApp == 'RLS') checkRLS = TRUE;
            
            if (contactList == NULL) contactList = new List<Contact>();
            
            if (contactList.size() > 0) {
                for (contact ct2 : contactList ) {
                    if (ct2.PolicyApp__c == 'DMTM') checkDMTM = TRUE;
                    if (ct2.PolicyApp__c == 'RLS') checkRLS = TRUE;
                }
            }
            
            if (checkDMTM && checkRLS) validate = TRUE;
            else validate = FALSE;
        }
        
        if (TestValidateTrue == NULL) TestValidateTrue = FALSE;
        
        if (test.isRunningTest() && !TestValidateTrue)
            return TRUE;
        else return validate;
    }
    
    public void initVsnap() {        
        // save data.
        //saveInitialOrder();
        boolean validate = checkvalidate();

        if (validate) {
            flagVsnap = true;
            lockPage = true;
            saveInitialOrder();    
        }
        else {
            captionMessage = 'must have 2 Policy Apps';
        }

    }

    public void initSecureIVR() {        
        //flagVsnap = true;
        //lockPage = true;
        // validation untuk dual
        boolean validate = checkvalidate();

        if (validate)
            saveInitialOrder();
        else {
            captionMessage = 'must have 2 Policy Apps';
        }
    }

    public void saveDataOrder() {        
        lockPage = true;
        // save data.
        saveInitialOrder();
        // running doOrderStatus Submit Data.
        if (contactStatus == 'Accepted') {
            //TempOrder
            //DoOrderSubmitDataSFDC();
            //DoOrderSubmitDataEIP(); //==> Pindah ke VP OrderStatusPageEIP
        }
    }

    public void initSendEmail() {
        if (selectedOrigin == 'PureCloud') SendEmail = TRUE;
        else SendEmail = FALSE;
    }
    
    //--DML upsert only for All (Web, Non-Web and PureCloud)
    public void saveInitialOrder() {
        if (paramEntity == 'AMFS' && paramKYC != NULL && paramKYC !='')
            if (paramKYC == 'Perorangan' || paramKYC == 'Non-Perorangan') beneficialOwner = TRUE;

        // Check Master Parameter        
        system.debug('policyEntity : '+contactEntity);
        system.debug('policyApp : '+contactPolicyApp);
        system.debug('selectedItem : '+selectedItem);
        string paramPolicyApp = contactPolicyApp;
        if (BothApps) paramPolicyApp = 'Both';
        MIDParameter = [SELECT id, PolicyApp__c, Payment_Type__c, Order_Code__c, gross_amount__c, Entity__c, 
                TC_01__c, TC_02__c, TC_03__c, TC_04__c, TC_05__c,
                TC_06__c, TC_07__c, TC_08__c, TC_09__c, TC_10__c
            FROM MID_Master_Parameter__c WHERE Entity__c =: contactEntity AND PolicyApp__c =: paramPolicyApp AND Payment_Type__c =: selectedItem LIMIT 1];
        PolicyOrderCode = MIDParameter.Order_Code__c;
        policygross_amount = MIDParameter.gross_amount__c;

        MID_Secure_Payment__c createOrder = new MID_Secure_Payment__c();
        //createOrder.External_Id_SFDC__c = generateExternalId('SMART', contactPolicyNo, 'P');
        createOrder.External_Id_SFDC__c = generateExternalId(PolicyOrderCode, contactPolicyNo, 'P');
        //String theOrderId = generateOrderId('SMART', contactPolicyNo);
        String theOrderId = generateOrderId(PolicyOrderCode, contactPolicyNo);
        system.debug('theOrderId : '+theOrderId);
        
        createOrder.flagVsnap__c = flagVsnap;
        createOrder.SFDC_Order_Id__c = theOrderId;
        createOrder.SFDC_Order_Id_Child__c = theOrderId;
        createOrder.Contact__c = firstContactId;
        createOrder.Origin__c = selectedOrigin;
        createOrder.Payment_Frequency__c = selectedPaymentFrequency;        
        if (beneficialOwner)
            createOrder.mid_custom_field1__c = 'switchingBO';
        else
            createOrder.mid_custom_field1__c = 'switching';
        //createOrder.mid_custom_field3__c = selectedPaymentFrequency;
        // query child (without primary), primary only 
        string payf = '0';
        if (selectedPaymentFrequency == 'Bulanan') payf = 'M';
        if (selectedPaymentFrequency == 'Triwulan') payf = 'Q';
        if (selectedPaymentFrequency == 'Semester') payf = 'S';
        if (selectedPaymentFrequency == 'Tahunan') payf = 'A';
        createOrder.mid_custom_field3__c = payf;
        createOrder.mid_custom_field3_temp__c = contactPolicyApp+'_'+contactPolicyNo+'_'+payf+'_'+contactEntity+';';
        if(contactList.size() > 0) {
            for(Contact c : contactList) {
            payf = '0';
            if (c.WelcomeCall_Payment_Type__c == 'Bulanan') payf = 'M';
            if (c.WelcomeCall_Payment_Type__c == 'Triwulan') payf = 'Q';
            if (c.WelcomeCall_Payment_Type__c == 'Semester') payf = 'S';
            if (c.WelcomeCall_Payment_Type__c == 'Tahunan') payf = 'A';
                createOrder.mid_custom_field3_temp__c += c.PolicyApp__c+'_'+c.Policy_No__c+'_'+payf+'_'+c.Entity__c+';';
            }
        }
        
        // Set Default Status
        if (selectedOrigin == 'WalkIN' && selectedItem == 'private') createOrder.Status__c = 'Accepted';
        if (selectedOrigin == 'WalkIN' && selectedItem == 'saving') createOrder.Status__c = 'Accepted';
        if (selectedOrigin == 'WalkIN' && selectedItem == 'credit_card') createOrder.Status__c = 'Start Snap';
        if (selectedOrigin == 'PureCloud' && selectedItem == 'private') createOrder.Status__c = 'Waiting PureCloud';
        if (selectedOrigin == 'PureCloud' && selectedItem == 'saving') createOrder.Status__c = 'Waiting PureCloud';
        if (selectedOrigin == 'PureCloud' && selectedItem == 'credit_card') createOrder.Status__c = 'Waiting PureCloud';
        contactStatus = createOrder.Status__c;
        
        createOrder.Payment_Type__c = selectedItem;
        if (selectedItem == 'credit_card') createOrder.mid_payment_type__c = 'credit_card';
        if (selectedItem == 'private') createOrder.mid_payment_type__c = 'private';
        if (selectedItem == 'saving') createOrder.mid_payment_type__c = 'saving';
        
        datetime datetimenow = Datetime.now();
        createOrder.mid_transaction_time__c = datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta');

        createOrder.Card_Holder_Name__c = cardHolderName;
        if (selectedItem == 'saving') createOrder.mid_custom_field2__c = accountNameSaving;
        else createOrder.mid_custom_field2__c = cardHolderName;
        
        createOrder.Change_Name__c = TRUE;//changeName;
        createOrder.Beneficial_Owner__c = beneficialOwner;
        createOrder.Send_Email__c = sendEmail;
        if(bankNamePrivate.Bank_Name__c != NULL) {
            createOrder.Bank_Name__c = bankNamePrivate.Bank_Name__c;
        } else if(bankNameSaving.Bank_Name__c != NULL) {
            createOrder.Bank_Name__c = bankNameSaving.Bank_Name__c;
        }
        if(otherBankNamePrivate != '') {
            createOrder.Bank_Name_Other__c = otherBankNamePrivate;
        } else if(otherBankNameSaving != '') {
            createOrder.Bank_Name_Other__c = otherBankNameSaving;
        }
        createOrder.Card_Number__c = cardNumberPrivate;
        createOrder.Expiry_Date_MMYY__c = expiryDatePrivate;
        createOrder.Account_Number__c = accountNumberSaving;
        createOrder.Account_Name__c = accountNameSaving;
        createOrder.Policy_App__c = contactPolicyApp;
        createOrder.Policy_No__c = contactPolicyNo;
        createOrder.Entity__c = contactEntity; //policyEntity
        createOrder.Email__c = contactEmail;
        
        if (paramEntity == 'AMFS' && paramKYC != NULL && paramKYC !='')
            if (paramKYC == 'Perorangan' ) createOrder.Beneficial_Owner_KYC__c = 'Perorangan';
            else if (paramKYC == 'Non-Perorangan') createOrder.Beneficial_Owner_KYC__c = 'Non-Perorangan';

        
        createOrder.Save__c = true;
        upsert createOrder External_Id_SFDC__c;
        cLookup.Check__c = createOrder.id;
        PCIDSSStatus = createOrder;
        
        TempOrder = createOrder;
        if(createOrder.Id != NULL) {   
            initialOrderId = createOrder.SFDC_Order_Id__c;
            //- SFIF1_109000002_1574998772234|switchingBO|Taufik Susanto| RLS_109-000004_M;RLS_309-3269649_Q;RLS_109-000001_S;RLS_21347588112_A;RLS_209-000099_A;RLS_109-000006_0;RLS_509-1096130_0;RLS_12347588111_0;RLS_209-000097_0;
            initialOrderId2 = createOrder.SFDC_Order_Id__c+'|'+createOrder.mid_custom_field1__c+'|'+createOrder.mid_custom_field2__c+'|'+createOrder.mid_custom_field3__c;
            lockPage = true;
        }
    }
    
    //--DML upsert parent and child
    public void saveData() {
        if(String.isNotEmpty(initialOrderId) || flagVsnap == true) {
            try {
                List<MID_Secure_Payment__c> saveList = new List<MID_Secure_Payment__c>();
                //String currentOrderId = 'SMART_'+ firstContact.Policy_No__c.replace('-', '') + '_' + String.valueOf(Date.today());
                //String currentExternalId = generateExternalId('SMART', contactPolicyNo, 'P');
                String currentExternalId = generateExternalId(PolicyOrderCode, contactPolicyNo, 'P');
                
                MID_Secure_Payment__c initialTransaction = [SELECT Id, External_Id_SFDC__c, SFDC_Order_Id__c, SFDC_Order_Id_Child__c, 
                    mid_masked_card__c, mid_approval_code__c, mid_bank__c, mid_transaction_time__c, mid_custom_field1__c, mid_custom_field2__c, mid_custom_field3__c, mid_gross_amount__c, 
                    mid_order_id__c, mid_payment_type__c, mid_signature_key__c, mid_status_code__c, mid_transaction_id__c, mid_transaction_status__c, mid_fraud_status__c, mid_status_message__c, mid_saved_token_id__c, mid_saved_token_id_expired_at__c, 
                    Midtrans_Token__c, Status__c 
                    FROM MID_Secure_Payment__c WHERE External_Id_SFDC__c = :currentExternalId LIMIT 1];
                /*
                initialTransaction.Contact__c = firstContactId;
                initialTransaction.Origin__c = selectedOrigin;
                initialTransaction.Payment_Frequency__c = selectedPaymentFrequency;
                initialTransaction.Payment_Type__c = selectedItem;
                initialTransaction.Card_Holder_Name__c = cardHolderName;
                initialTransaction.Change_Name__c = TRUE; //changeName;
                initialTransaction.Beneficial_Owner__c = beneficialOwner;
                initialTransaction.Send_Email__c = sendEmail;
                if(bankNamePrivate.Bank_Name__c != NULL) {
                    initialTransaction.Bank_Name__c = bankNamePrivate.Bank_Name__c;
                } else if(bankNameSaving.Bank_Name__c != NULL) {
                    initialTransaction.Bank_Name__c = bankNameSaving.Bank_Name__c;
                }
                if(otherBankNamePrivate != '') {
                    initialTransaction.Bank_Name_Other__c = otherBankNamePrivate;
                } else if(otherBankNameSaving != '') {
                    initialTransaction.Bank_Name_Other__c = otherBankNameSaving;
                }
                initialTransaction.Card_Number__c = cardNumberPrivate;
                initialTransaction.Expiry_Date_MMYY__c = expiryDatePrivate;
                initialTransaction.Account_Number__c = accountNumberSaving;
                initialTransaction.Account_Name__c = accountNameSaving;
                */
                initialTransaction.Save__c = true;

                system.debug('initialTransaction.SFDC_Order_Id_Child__c : '+initialTransaction.SFDC_Order_Id_Child__c);
                //DoOrderSubmitData(initialTransaction.SFDC_Order_Id_Child__c);
                                
                update initialTransaction;
                System.debug('initial id : ' + initialTransaction.Id);
                
                if(contactList.size() > 0) {
                    for(Contact c : contactList) {
                        String oldOrderId = initialTransaction.SFDC_Order_Id_Child__c;
                        List<String> parser = oldOrderId.split('_');
                        String newOrderId = parser[0] + '_' + c.Policy_No__c.replace('-', '') + '_' + parser[2];
                        DoOrderSubmitData(newOrderId);
                        
                        String ext = initialTransaction.External_Id_SFDC__c;
                        List<String> extArray = ext.split('_');
                        String extChild = extArray[0] + '_' + extArray[1] + '_' + extArray[2] + '_C';
                        
                        /*
                        MID_Secure_Payment__c trx = new MID_Secure_Payment__c();
                        trx.External_Id_SFDC__c = extChild;
                        trx.SFDC_Order_Id__c = initialTransaction.SFDC_Order_Id__c;
                        trx.SFDC_Order_Id_Child__c = newOrderId;
                        trx.Midtrans_Token__c = initialTransaction.Midtrans_Token__c;
                        trx.Status__c = initialTransaction.Status__c;
                        trx.mid_status_code__c = initialTransaction.mid_status_code__c;
                        trx.Contact__c = c.Id;
                        trx.Policy_No__c = c.Policy_No__c;
                        trx.Policy_App__c = c.PolicyApp__c;
                        trx.Entity__c = c.Entity__c;
                        trx.Origin__c = initialTransaction.Origin__c;
                        trx.Payment_Type__c = initialTransaction.Payment_Type__c;
                        trx.Card_Holder_Name__c = initialTransaction.Card_Holder_Name__c;
                        trx.Change_Name__c = TRUE; //initialTransaction.Change_Name__c;
                        trx.Beneficial_Owner__c = initialTransaction.Beneficial_Owner__c;
                        trx.Send_Email__c = initialTransaction.Send_Email__c;
                        if(bankNamePrivate.Bank_Name__c != NULL) {
                            trx.Bank_Name__c = bankNamePrivate.Bank_Name__c;
                        } else if(bankNameSaving.Bank_Name__c != NULL) {
                            trx.Bank_Name__c = bankNameSaving.Bank_Name__c;
                        }
                        if(otherBankNamePrivate != '') {
                            trx.Bank_Name_Other__c = otherBankNamePrivate;
                        } else if(otherBankNameSaving != '') {
                            trx.Bank_Name_Other__c = otherBankNameSaving;
                        }
                        trx.Card_Number__c = cardNumberPrivate;
                        trx.Expiry_Date_MMYY__c = expiryDatePrivate;
                        trx.Account_Number__c = accountNumberSaving;
                        saveList.add(trx);
                        */

                    }
                    //upsert saveList External_Id_SFDC__c;
                    System.debug('save list size : ' + saveList.size());
                }
                saveDataResult = true;
                System.debug('saveDataResult : ' + saveDataResult);
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Save Successful!'));
            } catch (Exception e) {
                System.debug('Error : ' + e);
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            }
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Please generate Order Id or Go to Secure Payment first.'));
        }
    }
    
    public PageReference resetPage() {
        PageReference pr = ApexPages.currentPage();
        pr.setRedirect(true);
        return pr;
    }
    
    //--EIP service to get token midtrans
    public void getVSnapTokenMidtrans() {
        try {
            DateTime dtStart = DateTime.now();
            // trxRefNo = orderid to midtrans
            
            //--adding temp data
            //String policyNumber = '111-1234567';
            
            Integer amount = integer.valueof(Policygross_amount); //10000;

            // Query MID Secure Payment Existing
            String currentExternalId = generateExternalId(MIDParameter.Order_Code__c, policyNumber, 'P');
            list<MID_Secure_Payment__c> listcreateOrder = [SELECT Id, External_Id_SFDC__c, SFDC_Order_Id__c, SFDC_Order_Id_Child__c, 
                        mid_masked_card__c, mid_approval_code__c, mid_bank__c, mid_transaction_time__c, mid_custom_field1__c, mid_custom_field2__c, mid_custom_field3__c, mid_gross_amount__c, 
                        mid_order_id__c, mid_payment_type__c, mid_signature_key__c, mid_status_code__c, mid_transaction_id__c, mid_transaction_status__c, mid_fraud_status__c, mid_status_message__c, mid_saved_token_id__c, mid_saved_token_id_expired_at__c, 
                        Midtrans_Token__c, Status__c, Entity__c
                        FROM MID_Secure_Payment__c WHERE External_Id_SFDC__c = :currentExternalId LIMIT 1];
            if (listcreateOrder.size() > 0) thisRecordOrderId = listcreateOrder[0].Id;      
            if (listcreateOrder.size() > 0) policyEntity = listcreateOrder[0].Entity__c;
            //trxRefNo = 'SMART_'+ policyNumber.replace('-', '') + '_' + String.valueOf(DateTime.now().getTime());
            trxRefNo = PolicyOrderCode+'_'+ policyNumber.replace('-', '') + '_' + String.valueOf(DateTime.now().getTime());
            string transaction_time = '';
            
            Map<String,String> mapParamMidtrans = new Map<String,String>();
            //if (beneficialOwner)
            //    mapParamMidtrans.put(EIPConstant.CUSTOM_FIELD_1, 'switchingBO'); //switching|switchingBO
            //else
            //    mapParamMidtrans.put(EIPConstant.CUSTOM_FIELD_1, 'switching'); //switching|switchingBO
            mapParamMidtrans.put(EIPConstant.CUSTOM_FIELD_1, listcreateOrder[0].mid_custom_field1__c); //switching|switchingBO
            mapParamMidtrans.put(EIPConstant.CUSTOM_FIELD_2, listcreateOrder[0].mid_custom_field2__c); //cardHolderName
            mapParamMidtrans.put(EIPConstant.CUSTOM_FIELD_3, listcreateOrder[0].mid_custom_field3__c); //OrderIDPrimary_PaymentFrequency;{OrderIDSecondary_PaymentFrequecny}
            mapParamMidtrans.put(EIPConstant.FINISH, 'TermsAndConditionsPage'); // callback class/visualforce
            mapParamMidtrans.put(EIPConstant.SAVE_CARD, 'true'); // show option to save card
            //mapParamMidtrans.put(EIPConstant.SAVE_CARD, 'true'); // show option to save card
            
            //EIPJson tokenMidtransEIP = EIPConnector.getToken(EIPConstant.OPERATION_VSNAP_TOKEN, EIPConstant.ENTITY_AMFS, EIPConstant.APP_MIDTRANS, String.valueOf(amount), trxRefNo, mapParamMidtrans);
            //EIPJson tokenMidtransEIP = EIPConnector.getToken(EIPConstant.OPERATION_VSNAP_TOKEN, 'AFI', EIPConstant.APP_MIDTRANS, String.valueOf(amount), trxRefNo, mapParamMidtrans);
            system.debug('EIPConstant.OPERATION_VSNAP_TOKEN : ' + EIPConstant.OPERATION_VSNAP_TOKEN);
            
            IF (policyEntityAMFS2 == '' || policyEntityAMFS2 == NULL) system.debug('policyEntity : ' + policyEntity);
            else system.debug('policyEntityAMFS2 : ' + policyEntityAMFS2);
            system.debug('EIPConstant.APP_MIDTRANS : ' + EIPConstant.APP_MIDTRANS); // 23 July 2020 ganti dari APP_MIDTRANS jadi EIPConstant.APP_VERITRANS, request dari pak Faizir
            system.debug('trxRefNo : ' + trxRefNo);
            system.debug('mapParamMidtrans : ' + mapParamMidtrans);
            
            EIPJson tokenMidtransEIP;
            IF (policyEntityAMFS2 == '' || policyEntityAMFS2 == NULL)
                tokenMidtransEIP = EIPConnector.getToken(EIPConstant.OPERATION_VSNAP_TOKEN, policyEntity, EIPConstant.APP_MIDTRANS, String.valueOf(amount), trxRefNo, mapParamMidtrans);
            else 
                tokenMidtransEIP = EIPConnector.getToken(EIPConstant.OPERATION_VSNAP_TOKEN, policyEntityAMFS2, EIPConstant.APP_MIDTRANS, String.valueOf(amount), trxRefNo, mapParamMidtrans);

            if (!test.isrunningtest()) vsnapToken = tokenMidtransEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].canBeIndividual.hasPartyAccountDetailsIn.cardTokenNumber;
            if (!test.isrunningtest()) system.debug('tokenMidtransEIP : ' + tokenMidtransEIP);
            if (!test.isrunningtest()) system.debug('token from midtrans : ' + vsnapToken);
            
            //--Store information after getTokenMidtrans
            MID_Secure_Payment__c updateOrder = new MID_Secure_Payment__c();
            updateOrder.Id = thisRecordOrderId;
            updateOrder.SFDC_Order_Id__c = trxRefNo;
            updateOrder.SFDC_Order_Id_Child__c = trxRefNo;
            updateOrder.Midtrans_Token__c = vsnapToken;
            //updateOrder.mid_transaction_time__c = '2016-06-28 09:42:20'; // Taufik, need replace to field.
            //updateOrder.mid_transaction_time__c =
            update updateOrder;
            
            // catur (20210303), added logger for pcidss
            DateTime dtEnd = DateTime.now();
            EIPConnector.insertLogPcidss(dtStart, dtEnd, '', System.JSON.serialize(tokenMidtransEIP, true),
                                         trxRefNo, EIPConstant.APP_MIDTRANS, policyEntity, 
                                         EIPConstant.OPERATION_VSNAP_TOKEN, EIPConstant.SERVICE_GET_TOKEN);
        } catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        } catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        } catch (Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        }
    }
    
    //--EIP service to get midtrans order status
    public void doOrderStatus() {
        DateTime dtStart = DateTime.now();
        MID_Secure_Payment__c payment = [SELECT Id, SFDC_Order_Id__c, Entity__c, Policy_App__c, 
        SFDC_Order_Id_Child__c, mid_custom_field1__c, mid_custom_field2__c, mid_custom_field3__c, mid_custom_field3_temp__c, 
        mid_transaction_time__c, mid_payment_type__c, mid_saved_token_id__c, mid_masked_card__c,
		mid_saved_token_id_expired_at__c, JsonBackEndError__c, // 18 Feb 2021, Taufik Update
        Payment_Type__c, Bank_Name__c, mid_transaction_status__c, Card_Number__c
            FROM MID_Secure_Payment__c WHERE SFDC_Order_Id__c = :orderId];
        contactEntity = payment.Entity__c;
        contactPolicyApp = payment.Policy_App__c;
        
        // catur, 20210303, init move berfore try
        EIPJson getStatus;
        try{
            //EIPJson getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, 'AMFS', EIPConstant.APP_VERITRANS, orderId);
            system.debug('contactEntity : '+contactEntity);
            system.debug('contactPolicyApp : '+contactPolicyApp);
            //EIPJson getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, 'AFI', EIPConstant.APP_VERITRANS, orderId);
            
            // catur, 20210303, init move berfore try
            //EIPJson getStatus;
            if (contactEntity == 'AMFS' && payment.Policy_App__c == 'RLS')
                getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, contactEntity+'2', EIPConstant.APP_VERITRANS, orderId);
            else 
                getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, contactEntity, EIPConstant.APP_VERITRANS, orderId);
            String saveTokenId = '';
            if (!test.isrunningtest()) saveTokenId = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.save_token_id;
            payment.mid_saved_token_id__c = saveTokenId;
            String saveMaskedCard = '';
            if (!test.isrunningtest()) saveMaskedCard = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].maskedCard; //added by suryono 13 jun 2020
            //payment.mid_masked_card__c = saveMaskedCard; //added by suryono 13 jun 2020
            payment.Card_Number__c = saveMaskedCard; //added by suryono 13 jun 2020
            if (!test.isrunningtest()) transactionStatus = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].transactionStatus;
            system.debug('transactionStatus = '+ transactionStatus);
            payment.mid_transaction_status__c = transactionStatus;
            
            if (!test.isrunningtest()) transactionTime = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].transactionTime;
            system.debug('transactionTime = '+ transactionTime);
            payment.mid_transaction_time__c = transactionTime;
            
            if (!test.isrunningtest()) payment.mid_bank__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].bank;
            system.debug('bank = '+ payment.mid_bank__c);
            
            // 18 Feb 2021 - Taufik, mid_saved_token_id_expired_at__c
			payment.mid_saved_token_id_expired_at__c = '';
            EIPJson.EIP_IcAx_AXAAsiaPaymentHistory paymentHistoryDetails = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0];
            for (EIPJson.EIP_AgSa_NameValue hasNameValue : paymentHistoryDetails.hasNameValue) {
                if (hasNameValue.Name.equals(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT)){
					payment.mid_saved_token_id_expired_at__c = hasNameValue.value;
		            system.debug('SAVED_TOKEN_ID_EXPIRED_AT = '+ hasNameValue.value);
                }
            }

            /*
                payment.mid_order_id__c = orderId;
                payment.mid_masked_card__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].maskedCard; //'';
                system.debug('3');
                payment.mid_approval_code__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].approvalCode;
                system.debug('4');
                payment.mid_bank__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].bank;
                system.debug('5');
                payment.mid_transaction_time__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].transactionTime;
                system.debug('6');
                //payment.mid_custom_field1__c = 'switching';
                system.debug('7');
                payment.mid_gross_amount__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.grossAmount;
                system.debug('8');
                payment.mid_payment_type__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].paymentType;
                system.debug('9');
                payment.mid_signature_key__c = '[Tidak ada Data]';//getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.;
                system.debug('10');
                payment.mid_status_code__c = statusCode; //'';
                system.debug('11');
                payment.mid_transaction_status__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].transactionStatus;
                system.debug('12');
                payment.mid_fraud_status__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].fraudStatus;
                system.debug('13');
                payment.mid_status_message__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].statusMessage;
                system.debug('14');
                payment.mid_saved_token_id__c = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.save_token_id;
                system.debug('15');
                payment.mid_saved_token_id_expired_at__c = '[Tidak ada Data]'; //getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.;
                system.debug('16');
            */
            
            if(String.isEmpty(saveTokenId) || saveTokenId == 'null'){
                payment.Status__c = 'Declined';
                if (payment.Entity__c == 'AMFS') {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'<font color="red"> Anda Belum Menyimpan Data Kartu Kredit Untuk Proses Autodebet.</font>'));
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'<font color="red"> Mohon aktifkan pilihan "Save payment details for future transactions"</font>'));
                }
                else
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'<font color="red"> Anda Belum Menyimpan Data Kartu Kredit Untuk Transaksi Berikutnya.</font>'));
            }else{
                payment.Status__c = 'Accepted';
                TempOrder = payment;
                DoOrderSubmitDataEIP();
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,'<font color="blue"> Anda Sudah Berhasil Menyimpan Data Kartu Kredit Untuk Transaksi Berikutnya.</font>'));
            }
        } catch(EIPConnector.NoDataException e){
            payment.Status__c = 'Pending - No Data';
        } catch(EIPConnector.EIPConnectorException e){
            payment.Status__c = 'Pending - EIP Connector';
        } catch (Exception e){
            payment.Status__c = 'Pending';
        }
        
        
        if(!String.isEmpty(statusCode)){
            try{
                payment.mid_status_code__c = statusCode;
                payment.mid_transaction_id__c = transactionId;
                
                switch on statusCode{
                    when '200'{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Transaksi Sukses'));
                    }
                    when '201'{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Transaksi Pending. status code = ' + statusCode));           
                    }
                    when '202'{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Transaksi ditolak oleh provider'));
                    }
                    when else{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Transaksi gagal silakan hubungi 8787 dan capture screen ini'));
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Kode Status : '+statusCode));
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Status Transaksi : '+transactionStatus));
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Order ID : '+orderId));
                    }
                }
                update payment;
                // catur (20210303), added logger for pcidss
                DateTime dtEnd = DateTime.now();
                EIPConnector.insertLogPcidss(dtStart, dtEnd, '', System.JSON.serialize(getStatus, true),
                                             orderId, EIPConstant.APP_VERITRANS, contactEntity, 
                                             EIPConstant.OPERATION_STATUS, EIPConstant.SERVICE_DO_ORDER);
            }catch(DMLException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Failed to update'));
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
        }
    }

    public void doOrderStatusEIP() {
        MID_Secure_Payment__c payment = [SELECT Id, SFDC_Order_Id__c, Entity__c, Policy_App__c, 
        SFDC_Order_Id_Child__c, mid_custom_field1__c, mid_custom_field2__c, mid_custom_field3__c, mid_custom_field3_temp__c, mid_payment_type__c, mid_transaction_time__c, 
        mid_saved_token_id__c, Account_Number__c, Card_Number__c, 
        Payment_Type__c, Bank_Name__c, mid_transaction_status__c, Status__c, Status_DoOrderEIP__c
            FROM MID_Secure_Payment__c WHERE SFDC_Order_Id__c = :orderId];
        contactEntity = payment.Entity__c;
        contactPolicyApp = payment.Policy_App__c;
        statusCode = '200';
        try{
            //EIPJson getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, 'AMFS', EIPConstant.APP_VERITRANS, orderId);
            system.debug('contactEntity : '+contactEntity);
            system.debug('contactPolicyApp : '+contactPolicyApp);
            //EIPJson getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, 'AFI', EIPConstant.APP_VERITRANS, orderId);
            system.debug('transactionStatus = '+ transactionStatus);
            payment.mid_transaction_status__c = transactionStatus;
            
            if(payment.Status__c == 'Accepted'){
                TempOrder = payment;
                payment.Status_DoOrderEIP__c = 'Success';
                DoOrderSubmitDataEIP();
                
                if (selectedItem == 'private')
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Anda Sudah Berhasil Menyimpan Data Kartu Kredit Untuk Transaksi Berikutnya.'));
                else
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Anda Sudah Berhasil Menyimpan Data Rekening Untuk Transaksi Berikutnya.'));
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Submit to EIP - '+payment.Status__c));
            }
        } catch (Exception e){
            payment.Status_DoOrderEIP__c = 'Failed';
        }
        
        
        if(!String.isEmpty(statusCode)){
            try{
                payment.mid_status_code__c = statusCode;
                payment.mid_transaction_id__c = transactionId;
                
                switch on statusCode{
                    when '200'{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Transaksi Sukses'));
                    }
                    when '201'{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Transaksi Pending. status code = ' + statusCode));           
                    }
                    when '202'{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Transaksi ditolak oleh provider'));
                    }
                    when else{
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Transaksi gagal silakan hubungi 8787 dan capture screen ini'));
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Kode Status : '+statusCode));
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Status Transaksi : '+transactionStatus));
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Order ID : '+orderId));
                    }
                }
                update payment;
            }catch(DMLException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Failed to update'));
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
        }
    }

    // Taufik, 26 Des, hit to TokenApp
    public void DoOrderSubmitDataEIP() {
        DateTime dtStart = DateTime.now();
        try{
            // catur (20210303), intial move to root
            EIPJson result;
            // Query 
            system.debug('#Before');
            
            list<string> ArrTemp = new list<string>(); // untuk menampung all info : DMTM_PolicyNo_Payment
            list<string> ArrPolicyNo = new list<string>(); // untuk menampung 1 info policyNo
            list<string> ArrPolicyApp = new list<string>(); // untuk menampung 1 info PolicyApp
            list<string> ArrPolicyPayment = new list<string>(); // untuk menampung 1 info Payment
            list<string> ArrPolicyEntity = new list<string>(); // untuk menampung 1 info Entity
            list<string> ArrData = new list<string>(); // untuk menampung PolicyNo, Policy App, Payment, Entity.
            String DataTemp = TempOrder.mid_custom_field3_temp__c;
            system.debug('#DataTemp : '+DataTemp);
            
            DataTemp = DataTemp.left(DataTemp.length()-1);
            DataTemp = DataTemp.replace('null','');
            ArrTemp = DataTemp.split(';');
            String PolicyEntity1 = '';
            String PolicyEntity2 = '';
            
            if (ArrTemp.size() > 0) {
                for (integer i = 0; i < ArrTemp.size(); i++){
                    ArrData = ArrTemp[i].split('_');
                    if (ArrData.size() > 0) {
                        ArrPolicyApp.add(ArrData[0]);
                        ArrPolicyNo.add(ArrData[1]);
                        ArrPolicyPayment.add(ArrData[2]);
                        //if (ArrData[3] == 'AMFS' && ArrData[0] == 'RLS') ArrPolicyEntity.add(ArrData[3]+'2');
                        //else 
                        ArrPolicyEntity.add(ArrData[3]);
                        
                    }
                }
            }

            // Query Mid Master
            map<string,string> OrderCode = new map<string,string>();
            // AFI & ALI
            OrderCode.put('SFIFX-RLS', 'SFIF1');                
            OrderCode.put('SFIFY-RLS', 'SFIF2');                
            OrderCode.put('SFIFZ-RLS', 'SFIF3');                
            OrderCode.put('SFIFX-DMTM', 'SFIFA');                
            OrderCode.put('SFIFY-DMTM', 'SFIFB');                
            OrderCode.put('SFIFZ-DMTM', 'SFIFC');                
            
            // AMFS
            OrderCode.put('SFIBX-RLS', 'SFIB1');                
            OrderCode.put('SFIBY-RLS', 'SFIB2');                
            OrderCode.put('SFIBZ-RLS', 'SFIB3');                
            OrderCode.put('SFIBX-DMTM', 'SFIBA');                
            OrderCode.put('SFIBY-DMTM', 'SFIBB');                
            OrderCode.put('SFIBZ-DMTM', 'SFIBC');                
            
            // Check jika ada 2 PolicyApp, atau hanya 1
            string policy_apps = '';
            string policy_apps2 = '';
            
            integer count_policyapps = 0;
            for (integer i = 0; i < ArrPolicyApp.size(); i++){
                if (policy_apps == '') count_policyapps += 1;
                if (policy_apps == '') PolicyEntity1 = ArrPolicyEntity[i];
                if (policy_apps == '') policy_apps = ArrPolicyApp[i];

                if (policy_apps != ArrPolicyApp[i] && policy_apps2 == '') count_policyapps += 1;
                if (policy_apps != ArrPolicyApp[i] && policy_apps2 == '') PolicyEntity2 = ArrPolicyEntity[i];
                if (policy_apps != ArrPolicyApp[i] && policy_apps2 == '') policy_apps2 = ArrPolicyApp[i];
                
            }
                        
            // Loop hit to EIP
            TempOrder.mid_EIPtokenApp_Status__c = '';
            system.debug('#Start Loop ');
            // Taufik, 2 Jun20, No need Loop.            
            //for (integer i = 0; i < ArrTemp.size(); i++)
            {
                //system.debug('#Start Loop '+i);
                system.debug('#Start Loop 0 - '+policy_apps);

                //String method = TempOrder.Payment_Type__c; //'saving';
                String method = TempOrder.mid_payment_type__c; //'saving';
                String status = 'accept';

                String oldOrderId = TempOrder.SFDC_Order_Id_Child__c;
                List<String> parser = oldOrderId.split('_');
                String OrderCodeTemp = parser[0];

                if ( OrderCode.get(OrderCodeTemp+'-'+policy_apps) != NULL) OrderCodeTemp = OrderCode.get(OrderCodeTemp+'-'+policy_apps);
                    
                String newOrderId = OrderCodeTemp + '_' + parser[1] + '_' + parser[2];

                String trxRefNo = newOrderId;//TempOrder.SFDC_Order_Id_Child__c;//'SFDC_TEST20191217000001';
            
                Map<String, String> params = new Map<String, String>();
                params.put(EIPConstant.STATUS_CODE, '200');
                system.debug('#EIPConstant.STATUS_CODE : 200 ');
                
                datetime datetimenow = datetime.now();
                
                params.put(EIPConstant.TRANSACTION_TIME, TempOrder.mid_transaction_time__c); //'2019-12-17 19:10:10'
                system.debug('#EIPConstant.TRANSACTION_TIME : '+TempOrder.mid_transaction_time__c);
                //params.put(EIPConstant.TRANSACTION_TIME, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); //'2019-12-17 19:10:10'
                //system.debug('#EIPConstant.TRANSACTION_TIME : '+datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                params.put(EIPConstant.SIGANTURE_KEY, ''); //saioduhalskdjiqmaslkcioqewiqejdio12j8eu398
                system.debug('#EIPConstant.SIGANTURE_KEY : ');
                if (TempOrder.mid_payment_type__c == 'credit_card') params.put(EIPConstant.BANK, TempOrder.mid_bank__c); // bca
                else params.put(EIPConstant.BANK, TempOrder.Bank_Name__c); // bca
                if (TempOrder.mid_payment_type__c == 'credit_card') system.debug('#EIPConstant.BANK : '+TempOrder.mid_bank__c);
                else system.debug('#EIPConstant.BANK : '+TempOrder.Bank_Name__c);
                
                //params.put(EIPConstant.VA_NUMBER, '41000');
                params.put(EIPConstant.CUSTOM_FIELD_1, TempOrder.mid_custom_field1__c); //'cobaaaaa'
                system.debug('#EIPConstant.CUSTOM_FIELD_1 : '+TempOrder.mid_custom_field1__c);
                params.put(EIPConstant.CUSTOM_FIELD_2, TempOrder.mid_custom_field2__c); // 'testing'
                system.debug('#EIPConstant.CUSTOM_FIELD_2 : '+TempOrder.mid_custom_field2__c);

                string tempCustomField3 = '';
                for (integer i = 0; i < ArrTemp.size(); i++){
                    if (ArrTemp[i].contains(policy_apps) )
                        tempCustomField3 += ArrTemp[i]+';';
                }
                system.debug('#EIPConstant.CUSTOM_FIELD_3 (NEW) : '+ tempCustomField3);
                params.put(EIPConstant.CUSTOM_FIELD_3, tempCustomField3); // New 2 Jun20, update menjadi RLS_515-3977680_0_AMFS;DMTM_100-7575000_0_AMFS;

                params.put(EIPConstant.STATUS_MESSAGE, 'veritrans payment notification');
                system.debug('#EIPConstant.STATUS_MESSAGE : veritrans payment notification');
                params.put(EIPConstant.ORDER_ID, trxRefNo);
                system.debug('#EIPConstant.ORDER_ID : '+trxRefNo);
                params.put(EIPConstant.TRANSACTION_ID, ''); // 20191217000001
                system.debug('#EIPConstant.TRANSACTION_ID : ');

                // Taufik MII - 4 Feb 2020, 
                //if (dataMID.Payment_Type__c == 'credit_card') TempOrder.mid_saved_token_id__c = TempOrder.mid_saved_token_id__c;
                if (TempOrder.Payment_Type__c == 'private') TempOrder.mid_saved_token_id__c = TempOrder.Card_Number__c;
                if (TempOrder.Payment_Type__c == 'saving') TempOrder.mid_saved_token_id__c = TempOrder.Account_Number__c;
                
                params.put(EIPConstant.SAVED_TOKEN_ID, TempOrder.mid_saved_token_id__c); //test-token
                system.debug('#EIPConstant.SAVED_TOKEN_ID : '+TempOrder.mid_saved_token_id__c);

                // Taufik MII - 5 Jun 2020, 
                string mid_masked_card_temp = '';
                if (TempOrder.Payment_Type__c == 'credit_card') mid_masked_card_temp = TempOrder.Card_Number__c;
                if (TempOrder.Payment_Type__c == 'private') mid_masked_card_temp = TempOrder.Card_Number__c;
                if (TempOrder.Payment_Type__c == 'saving') mid_masked_card_temp = TempOrder.Account_Number__c;
                TempOrder.mid_masked_card__c = mid_masked_card_temp;
                
                params.put(EIPConstant.MASKED_CARD, mid_masked_card_temp); //test-token
                system.debug('#EIPConstant.MASKED_CARD : '+mid_masked_card_temp);
                
                //Daniel, 12 Juni 2020
                if (TempOrder.Payment_Type__c == 'private') { params.put(EIPConstant.CARD_TYPE, 'private'); system.debug('#EIPConstant.CARD_TYPE : private'); }
                else { params.put(EIPConstant.CARD_TYPE, 'others'); system.debug('#EIPConstant.CARD_TYPE : others'); }
                //END - Daniel, 12 Juni 2020

                //params.put(EIPConstant.SAVED_TOKEN_ID, ''); //test-token
                //system.debug('#EIPConstant.SAVED_TOKEN_ID : ');
                
                // 18 Feb 2021, taufik Update, 22 Feb 2021, Hide datetime (5)
                //datetimenow = datetimenow.addYears(5);
                //if (TempOrder.mid_saved_token_id_expired_at__c == '') 
                //	params.put(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); // '2020-09-01 23:00:00'
                //else 
                //    params.put(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT, TempOrder.mid_saved_token_id_expired_at__c); // '2020-09-01 23:00:00'
                //system.debug('#EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT : '+ datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                
                // 22 Feb 2021, taufik update
                if (TempOrder.mid_saved_token_id_expired_at__c != '') params.put(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT, TempOrder.mid_saved_token_id_expired_at__c); // '2020-09-01 23:00:00'
                system.debug('#EIPConstant.mid_saved_token_id_expired_at__c : '+ TempOrder.mid_saved_token_id_expired_at__c);
                
                params.put(EIPConstant.GROSS_AMOUNT, '1.00');
                system.debug('#EIPConstant.GROSS_AMOUNT : 1');
                params.put(EIPConstant.TRANSACTION_STATUS, TempOrder.mid_transaction_status__c); //'expire'
                system.debug('#EIPConstant.TRANSACTION_STATUS : '+TempOrder.mid_transaction_status__c);
                params.put(EIPConstant.PAYMENT_TYPE, TempOrder.mid_payment_type__c); //'bank_transfer' //TempOrder.Payment_Type__c
                system.debug('#EIPConstant.PAYMENT_TYPE : '+TempOrder.mid_payment_type__c); //TempOrder.Payment_Type__c
                
                //EIPJson result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.ENTITY_AMFS, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                //EIPJson result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, ArrPolicyEntity[i], EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                // catur (20210303), intial move to root
                //EIPJson result;
                if (PolicyEntity1 == 'AMFS' && policy_apps == 'RLS')
                    result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, PolicyEntity1+'2', EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                else 
                    result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, PolicyEntity1, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
            
                String resultStatus = result.Body.status; // example to get result response
                if(resultStatus == '1'){ // IF SUCCESS
                    // TODO
            	} else if(resultStatus == '0'){ // IF Not Success, 29 Jan 2021
                	// Capture error from doOder
                	TempOrder.JsonBackEndError__c = result.Body.exceptionObj != NULL ? result.Body.exceptionObj.BackEndError : '-';
            	}

                TempOrder.mid_EIPtokenApp_Status__c += resultStatus+';';
                system.debug('#resultStatus : '+resultStatus);
            } // end loop to EIP

            // if Dual & PolicyApps2 && PolicyEntity2
            if (policy_apps2 != '') {
                //system.debug('#Start Loop '+i);
                system.debug('#Start Loop 1 - '+policy_apps2);

                //String method = TempOrder.Payment_Type__c; //'saving';
                String method = TempOrder.mid_payment_type__c; //'saving';
                String status = 'accept';

                String oldOrderId = TempOrder.SFDC_Order_Id_Child__c;
                List<String> parser = oldOrderId.split('_');
                String OrderCodeTemp = parser[0];

                if ( OrderCode.get(OrderCodeTemp+'-'+policy_apps) != NULL) OrderCodeTemp = OrderCode.get(OrderCodeTemp+'-'+policy_apps2);
                    
                String newOrderId = OrderCodeTemp + '_' + parser[1] + '_' + parser[2];

                String trxRefNo = newOrderId;//TempOrder.SFDC_Order_Id_Child__c;//'SFDC_TEST20191217000001';
            
                Map<String, String> params = new Map<String, String>();
                params.put(EIPConstant.STATUS_CODE, '200');
                system.debug('#EIPConstant.STATUS_CODE : 200 ');
                
                datetime datetimenow = datetime.now();
                
                params.put(EIPConstant.TRANSACTION_TIME, TempOrder.mid_transaction_time__c); //'2019-12-17 19:10:10'
                system.debug('#EIPConstant.TRANSACTION_TIME : '+TempOrder.mid_transaction_time__c);
                //params.put(EIPConstant.TRANSACTION_TIME, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); //'2019-12-17 19:10:10'
                //system.debug('#EIPConstant.TRANSACTION_TIME : '+datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                params.put(EIPConstant.SIGANTURE_KEY, ''); //saioduhalskdjiqmaslkcioqewiqejdio12j8eu398
                system.debug('#EIPConstant.SIGANTURE_KEY : ');
                if (TempOrder.mid_payment_type__c == 'credit_card') params.put(EIPConstant.BANK, TempOrder.mid_bank__c); // bca
                else params.put(EIPConstant.BANK, TempOrder.Bank_Name__c); // bca
                if (TempOrder.mid_payment_type__c == 'credit_card') system.debug('#EIPConstant.BANK : '+TempOrder.mid_bank__c);
                else system.debug('#EIPConstant.BANK : '+TempOrder.Bank_Name__c);
                
                //params.put(EIPConstant.VA_NUMBER, '41000');
                params.put(EIPConstant.CUSTOM_FIELD_1, TempOrder.mid_custom_field1__c); //'cobaaaaa'
                system.debug('#EIPConstant.CUSTOM_FIELD_1 : '+TempOrder.mid_custom_field1__c);
                params.put(EIPConstant.CUSTOM_FIELD_2, TempOrder.mid_custom_field2__c); // 'testing'
                system.debug('#EIPConstant.CUSTOM_FIELD_2 : '+TempOrder.mid_custom_field2__c);

                string tempCustomField3 = '';
                for (integer i = 0; i < ArrTemp.size(); i++){
                    if (ArrTemp[i].contains(policy_apps2) )
                        tempCustomField3 += ArrTemp[i]+';';
                }
                system.debug('#EIPConstant.CUSTOM_FIELD_3 (NEW) : '+ tempCustomField3);
                params.put(EIPConstant.CUSTOM_FIELD_3, tempCustomField3); // New 2 Jun20, update menjadi RLS_515-3977680_0_AMFS;DMTM_100-7575000_0_AMFS;

                params.put(EIPConstant.STATUS_MESSAGE, 'veritrans payment notification');
                system.debug('#EIPConstant.STATUS_MESSAGE : veritrans payment notification');
                params.put(EIPConstant.ORDER_ID, trxRefNo);
                system.debug('#EIPConstant.ORDER_ID : '+trxRefNo);
                params.put(EIPConstant.TRANSACTION_ID, ''); // 20191217000001
                system.debug('#EIPConstant.TRANSACTION_ID : ');

                // Taufik MII - 4 Feb 2020, 
                //if (dataMID.Payment_Type__c == 'credit_card') TempOrder.mid_saved_token_id__c = TempOrder.mid_saved_token_id__c;
                if (TempOrder.Payment_Type__c == 'private') TempOrder.mid_saved_token_id__c = TempOrder.Card_Number__c;
                if (TempOrder.Payment_Type__c == 'saving') TempOrder.mid_saved_token_id__c = TempOrder.Account_Number__c;
                
                params.put(EIPConstant.SAVED_TOKEN_ID, TempOrder.mid_saved_token_id__c); //test-token
                system.debug('#EIPConstant.SAVED_TOKEN_ID : '+TempOrder.mid_saved_token_id__c);

                // Taufik MII - 5 Jun 2020, 
                string mid_masked_card_temp = '';
                if (TempOrder.Payment_Type__c == 'credit_card') mid_masked_card_temp = TempOrder.Card_Number__c;
                if (TempOrder.Payment_Type__c == 'private') mid_masked_card_temp = TempOrder.Card_Number__c;
                if (TempOrder.Payment_Type__c == 'saving') mid_masked_card_temp = TempOrder.Account_Number__c;
                
                params.put(EIPConstant.MASKED_CARD, mid_masked_card_temp); //test-token
                system.debug('#EIPConstant.MASKED_CARD : '+mid_masked_card_temp);
                
                //Daniel, 12 Juni 2020
                if (TempOrder.Payment_Type__c == 'private') { params.put(EIPConstant.CARD_TYPE, 'private'); system.debug('#EIPConstant.CARD_TYPE : private'); }
                else { params.put(EIPConstant.CARD_TYPE, 'others'); system.debug('#EIPConstant.CARD_TYPE : others'); }
                //END - Daniel, 12 Juni 2020

                //params.put(EIPConstant.SAVED_TOKEN_ID, ''); //test-token
                //system.debug('#EIPConstant.SAVED_TOKEN_ID : ');
                
                datetimenow = datetimenow.addYears(5);
                params.put(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); // '2020-09-01 23:00:00'
                system.debug('#EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT : '+ datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                params.put(EIPConstant.GROSS_AMOUNT, '1.00');
                system.debug('#EIPConstant.GROSS_AMOUNT : 1');
                params.put(EIPConstant.TRANSACTION_STATUS, TempOrder.mid_transaction_status__c); //'expire'
                system.debug('#EIPConstant.TRANSACTION_STATUS : '+TempOrder.mid_transaction_status__c);
                params.put(EIPConstant.PAYMENT_TYPE, TempOrder.mid_payment_type__c); //'bank_transfer' //TempOrder.Payment_Type__c
                system.debug('#EIPConstant.PAYMENT_TYPE : '+TempOrder.mid_payment_type__c); //TempOrder.Payment_Type__c
                
                //EIPJson result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.ENTITY_AMFS, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                //EIPJson result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, ArrPolicyEntity[i], EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                // catur (20210303) init move to root try
                //EIPJson result;
                if (PolicyEntity2 == 'AMFS' && policy_apps2 == 'RLS')
                    result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, PolicyEntity2+'2', EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                else 
                    result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, PolicyEntity2, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
            
                String resultStatus = result.Body.status; // example to get result response
                if(resultStatus == '1'){ // IF SUCCESS
                    // TODO
                }
                TempOrder.mid_EIPtokenApp_Status__c += resultStatus+';';
                system.debug('#resultStatus : '+resultStatus);
            } // end loop to EIP

            
            system.debug('#End Loop ');
            if (TempOrder.Id != NULL)
                update TempOrder;
            
            // catur (20210303), added logger for pcidss
            DateTime dtEnd = DateTime.now();
            EIPConnector.insertLogPcidss(dtStart, dtEnd, '', System.JSON.serialize(result, true),
                                         orderId, EIPConstant.APP_TOKEN, contactEntity, 
                                         EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.SERVICE_DO_ORDER);
            system.debug('#Update TempOrder');
            
        } catch(EIPConnector.NoDataException e){
            errMsgInsuredDtl = e.getMessage();
            System.debug('NoDataException - '+e.getMessage());
        } catch(EIPConnector.EIPConnectorException e){
            errMsgInsuredDtl = e.getMessage();
            System.debug('EIPConnectorException - '+e.getMessage());
        } catch (Exception e){
            errMsgInsuredDtl = EIPConstant.ERROR_MSG_UNKNOWN;
            System.debug('Exception - '+e.getMessage());
        }        
    }
    
    // Taufik, 26 Des, hit to TokenApp
    public void DoOrderSubmitDataSFDC() {
        
        TempOrder.mid_order_id__c = TempOrder.SFDC_Order_Id_Child__c;
        if (TempOrder.Payment_Type__c == 'Private')
            TempOrder.mid_masked_card__c = TempOrder.Card_Number__c; 
        else         
            TempOrder.mid_masked_card__c = TempOrder.Account_Number__c; 
        
        system.debug('3');
        TempOrder.mid_approval_code__c = '123456';
        system.debug('4');
        TempOrder.mid_bank__c = TempOrder.Bank_Name__c;
        system.debug('5');
        //2019-12-26 20:09:46
        datetime datetimenow = datetime.now();
        TempOrder.mid_transaction_time__c = datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta');
        system.debug('6');
        system.debug('7');
        TempOrder.mid_gross_amount__c = '0';
        system.debug('8');
        if (TempOrder.Payment_Type__c == 'credit_card') TempOrder.mid_payment_type__c = 'credit_card';
        if (TempOrder.Payment_Type__c == 'private') TempOrder.mid_payment_type__c = 'private';
        if (TempOrder.Payment_Type__c == 'saving') TempOrder.mid_payment_type__c = 'saving';
        //TempOrder.mid_payment_type__c = TempOrder.Payment_Type__c;
        system.debug('9');
        TempOrder.mid_signature_key__c = '[Tidak ada Data]';//getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.;
        system.debug('10');
        TempOrder.mid_status_code__c = '200'; //'';
        system.debug('11');
        TempOrder.mid_transaction_status__c = 'capture';
        system.debug('12');
        TempOrder.mid_fraud_status__c = 'accept';
        system.debug('13');
        TempOrder.mid_status_message__c = 'Success';
        system.debug('14');
        TempOrder.mid_saved_token_id__c = '';
        system.debug('15');
        TempOrder.mid_saved_token_id_expired_at__c = '[Tidak ada Data]'; //getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.;
        system.debug('16');
        
        update TempOrder;
    }

    // Taufik, 10 Des, hit to TokenApp
    public void DoOrderSubmitData(string SFDCOrderIdChild) {
        MidNotification = new MidNotification();
        MidNotification.mid_order_id = SFDCOrderIdChild; //'';        
        system.debug('flagVsnap : '+flagVsnap);
        if (FALSE) {
            try{
                system.debug('before getStatus');
                //EIPJson getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, 'AMFS', EIPConstant.APP_VERITRANS, orderId);
                EIPJson getStatus = EIPConnector.doOrder(EIPConstant.OPERATION_STATUS, contactEntity, EIPConstant.APP_VERITRANS, orderId);
                system.debug('#getStatus : '+getStatus);
                
                MidNotification.mid_custom_field2 = cardHolderName;
                system.debug('1');
                //MidNotification.mid_custom_field3 = selectedPaymentFrequency;
                system.debug('2');
                MidNotification.mid_order_id = orderId;

                MidNotification.mid_masked_card = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].maskedCard; //'';
                system.debug('3');
                MidNotification.mid_approval_code = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].approvalCode;
                system.debug('4');
                MidNotification.mid_bank = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].bank;
                system.debug('5');
                MidNotification.mid_transaction_time = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].transactionTime;
                system.debug('6');
                //MidNotification.mid_custom_field1 = 'switching';
                system.debug('7');
                MidNotification.mid_gross_amount = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.grossAmount;
                system.debug('8');
                MidNotification.mid_payment_type = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].paymentType;
                system.debug('9');
                MidNotification.mid_signature_key = '[Tidak ada Data]';//getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.;
                system.debug('10');
                MidNotification.mid_status_code = statusCode; //'';
                system.debug('11');
                MidNotification.mid_transaction_status = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].transactionStatus;
                system.debug('12');
                MidNotification.mid_fraud_status = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].fraudStatus;
                system.debug('13');
                MidNotification.mid_status_message = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.hasPaymentHistoryDetails[0].statusMessage;
                system.debug('14');
                MidNotification.mid_saved_token_id = getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.save_token_id;
                system.debug('15');
                MidNotification.mid_saved_token_id_expired_at = '[Tidak ada Data]'; //getStatus.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasBilling.;
                system.debug('16');
                
                /*
                {
                    initialTransaction.mid_masked_card__c = MidNotification.mid_masked_card;
                    system.debug('MidNotification.mid_masked_card : '+MidNotification.mid_masked_card);
                    initialTransaction.mid_approval_code__c = MidNotification.mid_approval_code;
                    system.debug('MidNotification.mid_masked_card : '+MidNotification.mid_approval_code);
                    initialTransaction.mid_bank__c = MidNotification.mid_bank;
                    system.debug('MidNotification.mid_bank : '+MidNotification.mid_bank);
                    initialTransaction.mid_transaction_time__c = MidNotification.mid_transaction_time;
                    system.debug('MidNotification.mid_transaction_time : '+MidNotification.mid_transaction_time);
                    initialTransaction.mid_custom_field1__c = MidNotification.mid_custom_field1;
                    system.debug('MidNotification.mid_custom_field1 : '+MidNotification.mid_custom_field1);
                    initialTransaction.mid_custom_field2__c = MidNotification.mid_custom_field2;
                    system.debug('MidNotification.mid_custom_field2 : '+MidNotification.mid_custom_field2);
                    initialTransaction.mid_custom_field3__c = MidNotification.mid_custom_field3;
                    system.debug('MidNotification.mid_custom_field3 : '+MidNotification.mid_custom_field3);
                    initialTransaction.mid_gross_amount__c = MidNotification.mid_gross_amount;
                    system.debug('MidNotification.mid_gross_amount : '+MidNotification.mid_gross_amount);
                    initialTransaction.mid_order_id__c = MidNotification.mid_order_id;
                    system.debug('MidNotification.mid_order_id : '+MidNotification.mid_order_id);
                    initialTransaction.mid_payment_type__c = MidNotification.mid_payment_type;
                    system.debug('MidNotification.mid_payment_type : '+MidNotification.mid_payment_type);
                    initialTransaction.mid_signature_key__c = MidNotification.mid_signature_key;
                    system.debug('MidNotification.mid_signature_key : '+MidNotification.mid_signature_key);
                    initialTransaction.mid_status_code__c = MidNotification.mid_status_code;
                    system.debug('MidNotification.mid_status_code : '+MidNotification.mid_status_code);
                    initialTransaction.mid_transaction_id__c = MidNotification.mid_transaction_id;
                    system.debug('MidNotification.mid_transaction_id : '+MidNotification.mid_transaction_id);
                    initialTransaction.mid_transaction_status__c = MidNotification.mid_transaction_status;
                    system.debug('MidNotification.mid_transaction_status : '+MidNotification.mid_transaction_status);
                    initialTransaction.mid_fraud_status__c = MidNotification.mid_fraud_status;
                    system.debug('MidNotification.mid_fraud_status : '+MidNotification.mid_fraud_status);
                    initialTransaction.mid_status_message__c = MidNotification.mid_status_message;
                    system.debug('MidNotification.mid_status_message : '+MidNotification.mid_status_message);
                    initialTransaction.mid_saved_token_id__c = MidNotification.mid_saved_token_id;
                    system.debug('MidNotification.mid_saved_token_id : '+MidNotification.mid_saved_token_id);
                    initialTransaction.mid_saved_token_id_expired_at__c = MidNotification.mid_saved_token_id_expired_at;
                    system.debug('MidNotification.mid_saved_token_id_expired_at : '+MidNotification.mid_saved_token_id_expired_at);
                }

                */
            } catch(EIPConnector.NoDataException e){
            } catch(EIPConnector.EIPConnectorException e){
            } catch (Exception e){
            }

        } else {
            if (cardHolderName == NULL || cardHolderName == '') MidNotification.mid_custom_field2 = accountNameSaving;
            else MidNotification.mid_custom_field2 = cardHolderName;
            //MidNotification.mid_custom_field3 = selectedPaymentFrequency;

            MidNotification.mid_masked_card = '[Tidak ada Data]';
            MidNotification.mid_approval_code = '[Tidak ada Data]';
            if(bankNamePrivate.Bank_Name__c != NULL) {
                MidNotification.mid_bank = bankNamePrivate.Bank_Name__c;
            } else if(bankNameSaving.Bank_Name__c != NULL) {
                MidNotification.mid_bank = bankNameSaving.Bank_Name__c;
            }

            MidNotification.mid_transaction_time = string.valueOf(Datetime.now());
            //MidNotification.mid_custom_field1 = 'switching';
            MidNotification.mid_gross_amount = '0';
            MidNotification.mid_payment_type = selectedItem;
            MidNotification.mid_signature_key = '[Tidak Ada Data]';
            MidNotification.mid_status_code = statusCode; //'';
            MidNotification.mid_transaction_id = '[Tidak Ada Data]';
            MidNotification.mid_transaction_status = '[Tidak Ada Data]';
            MidNotification.mid_fraud_status = '[Tidak Ada Data]';
            MidNotification.mid_status_message = '[Tidak Ada Data]';
            MidNotification.mid_saved_token_id = SFDCOrderIdChild; //'';
            MidNotification.mid_saved_token_id_expired_at = '[Tidak Ada Data]';
        }
        
        try{
            // hit to Token App
        } catch(EIPConnector.NoDataException e){
        } catch(EIPConnector.EIPConnectorException e){
        } catch (Exception e){
        }
        
        
    }

    public void CheckSendEmail() {
        
        if (sendEmail) {
            if (paramEntity == 'AMFS' && paramKYC != NULL && paramKYC !='')
                if (paramKYC == 'Perorangan' || paramKYC == 'Non-Perorangan') beneficialOwner = TRUE;
            
            if (selectedItem == 'private') {
                if (beneficialOwner)
                    EmailListAttachment = 'Send SKDKK + BO';
                else
                    EmailListAttachment = 'Send SKDKK Only';
            }
            else if (selectedItem == 'saving') {
                if (beneficialOwner)
                    EmailListAttachment = 'Send SKDR + BO';
                else
                    EmailListAttachment = 'Send SKDR Only';
            }
            else if (selectedItem == 'credit_card') {
                if (beneficialOwner)
                    EmailListAttachment = 'Send BO Only';
                else
                    EmailListAttachment = 'Not Send Anything';
            }           
        }
        else
            EmailListAttachment = '';

    }

    public void FCheckLuhn() {
        if (cardNumberPrivate.length() > 0) {
            //CheckLuhnBoolean = checkLuhn(cardNumberPrivate);
            CheckLuhnBoolean = checkLuhnExcel(cardNumberPrivate);
            if (CheckLuhnBoolean)
                CheckLuhnText = 'This is a valid card - ' + CheckLuhnText;
            else
                CheckLuhnText = 'This is not a valid card - '+CheckLuhnText;
        }
        //CheckLuhnText = cardNumberPrivate;
    }

    // Excel pak andy
    public Boolean checkLuhnExcel(String purportedCC) {
        list<string> ArraypurportedCC = new list<string>();
        Boolean Digit16 = TRUE;
        string temp = '';

        // add to ArraypurportedCC
        for (integer i = 0; i < 16; i++) {
            system.debug('purportedCC : '+purportedCC+' '+i);

            if (i > (purportedCC.length()-1)) {
                ArraypurportedCC.add('0');
                Digit16 = FALSE;
            }
            else {
                temp = '';
                temp = purportedCC.left(i+1); 
                system.debug('temp : '+temp);
                ArraypurportedCC.add(temp.right(1));                
            }
            system.debug('Data - '+i+' : value - '+temp);
        }
        integer sum = 0;//integer.valueof(ArraypurportedCC[purportedCC.length()-1]);
        integer nDigits = 16;//purportedCC.length();
        integer lastdigit = integer.valueof(ArraypurportedCC[15]);
        for (integer i = 0; i < (nDigits/2); i++) {
            integer digit = integer.valueof(ArraypurportedCC[(i*2)]);
            
            //= A2 * 2 - IF(A2 * 2 > 9, 9, 0)
            integer sumtemp = digit * 2;
            if (sumtemp > 9) sum += sumtemp - 9;
            else sum += sumtemp - 0;
            
            if ((i*2)+1 <> 15)
            sum += integer.valueof(ArraypurportedCC[(i*2)+1]);
        }
        
        //= MOD(SUM(A3:O3) * 9, 10)
        //sum = math.mod(sum*9, 10);
        
        //CheckLuhnText = nDigits+' Digit - Result : '+math.mod(sum*9, 10)+' vs Last Digit : '+lastdigit;
        CheckLuhnText = nDigits+' Digit ';
        
        if (Digit16)
            return (math.mod(sum*9, 10) == lastdigit);
        else
            return FALSE;
    }

    //https://en.wikipedia.org/wiki/Luhn_algorithm
    public Boolean checkLuhn(String purportedCC) {
        list<string> ArraypurportedCC = new list<string>();
        Boolean Digit16 = TRUE;
        string temp = '';

        // add to ArraypurportedCC
        for (integer i = 0; i < 16; i++) {
            system.debug('purportedCC : '+purportedCC+' '+i);

            if (i > (purportedCC.length()-1)) {
                ArraypurportedCC.add('0');
                Digit16 = FALSE;
            }
            else {
                temp = '';
                temp = purportedCC.left(i+1); 
                system.debug('temp : '+temp);
                ArraypurportedCC.add(temp.right(1));                
            }
            system.debug('Data - '+i+' : value - '+temp);
        }
        integer sum = integer.valueof(ArraypurportedCC[purportedCC.length()-1]);
        integer nDigits = purportedCC.length();
        integer parity = math.mod(nDigits, 2);
        for (integer i = 0; i < (nDigits-2); i++) {
            integer digit = integer.valueof(ArraypurportedCC[i]);
            if (math.mod(i,2) ==  parity)
                digit = digit * 2;
            if (digit > 9)
                digit = digit - 9;
            sum = sum + digit;
        }
        
        //CheckLuhnText = nDigits+' Digit - Result : '+math.mod(sum, 10);
        CheckLuhnText = nDigits+' Digit';
        
        if (Digit16)
            return (math.mod(sum, 10) == 0);
        else
            return FALSE;
    }
/*
function checkLuhn(string purportedCC) {
    int sum := integer(purportedCC[length(purportedCC)-1])
    int nDigits := length(purportedCC)
    int parity := nDigits modulus 2
    for i from 0 to nDigits - 2 {
        int digit := integer(purportedCC[i])
        if i modulus 2 = parity
            digit := digit × 2
        if digit > 9
            digit := digit - 9 
        sum := sum + digit
    }
    return (sum modulus 10) = 0
}
*/   
}