@isTest
public class ChangePaymentControllerTest {
    @testSetup
    public static void testSetup() {
        Date dtToday = Date.today();
        
        Account acc = new Account();
        acc.Name = 'Dummy Account';
        insert acc;
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.FirstName = 'First Name';
        con.LastName = 'Last Name';
        con.Entity__c = 'AFI';
        con.PolicyApp__c = 'RLS';
        insert con;
        
        Contact con2nd = new Contact();
        con2nd.AccountId = acc.Id;
        con2nd.FirstName = 'First Name 2nd';
        con2nd.LastName = 'Last Name 2nd';
        con2nd.Entity__c = 'AFI';
        con2nd.PolicyApp__c = 'RLS';
        insert con2nd;
        
        MID_Master_Parameter__c midMaster = new MID_Master_Parameter__c();
        midMaster.PolicyApp__c = 'RLS';
        midMaster.Payment_Type__c = 'credit_card';
        midMaster.Order_Code__c = 'SFIF1';
        midMaster.gross_amount__c = 10000;
        midMaster.Entity__c = 'AFI';
        midMaster.TC_01__c = '';
        midMaster.TC_02__c = '';
        midMaster.TC_03__c = '';
        midMaster.TC_04__c = '';
        midMaster.TC_05__c = '';
        midMaster.TC_06__c = '';
        midMaster.TC_07__c = '';
        midMaster.TC_08__c = '';
        midMaster.TC_09__c = '';
        midMaster.TC_10__c = '';
        midMaster.snapJs__c = '';
        midMaster.dataClientKey__c = '';
        insert midMaster;
        
        MID_Secure_Payment__c midRecord = new MID_Secure_Payment__c();
        midRecord.External_Id_SFDC__c = 'SFIF1_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.SFDC_Order_Id__c = 'SFIF1';
        midRecord.Entity__c = '';
        midRecord.SFDC_Order_Id_Child__c = 'SFIF1_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.mid_custom_field1__c = '';
        midRecord.mid_custom_field2__c = '';
        midRecord.mid_custom_field3__c = '';
        midRecord.mid_custom_field3_temp__c = 'RLS_507-1234567_10000_AFI;RLS_507-1234567_0_AMFS;';
        midRecord.Payment_Type__c = '';
        midRecord.Bank_Name__c = 'BCA';
        midRecord.mid_transaction_status__c = '';
        insert midRecord;

        // ========================= BOTH / DUAL Charging ==============
        midMaster = new MID_Master_Parameter__c();
        midMaster.PolicyApp__c = 'Both';
        midMaster.Payment_Type__c = 'credit_card';
        midMaster.Order_Code__c = 'SFIFX';
        midMaster.gross_amount__c = 10000;
        midMaster.Entity__c = 'AFI';
        midMaster.TC_01__c = '';
        midMaster.TC_02__c = '';
        midMaster.TC_03__c = '';
        midMaster.TC_04__c = '';
        midMaster.TC_05__c = '';
        midMaster.TC_06__c = '';
        midMaster.TC_07__c = '';
        midMaster.TC_08__c = '';
        midMaster.TC_09__c = '';
        midMaster.TC_10__c = '';
        midMaster.snapJs__c = '';
        midMaster.dataClientKey__c = '';
        insert midMaster;
        
        midRecord = new MID_Secure_Payment__c();
        midRecord.External_Id_SFDC__c = 'SFIFX_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.SFDC_Order_Id__c = 'SFIFX';
        midRecord.Entity__c = '';
        midRecord.SFDC_Order_Id_Child__c = 'SFIFX_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.mid_custom_field1__c = '';
        midRecord.mid_custom_field2__c = '';
        midRecord.mid_custom_field3__c = '';
        midRecord.mid_custom_field3_temp__c = 'RLS_507-1234567_10000_AFI;RLS_507-1234567_0_AMFS;DMTM_507-1234567_10000_AFI;DMTM_507-1234567_0_AMFS;';
        midRecord.Payment_Type__c = '';
        midRecord.Bank_Name__c = 'BCA';
        midRecord.mid_transaction_status__c = '';
        insert midRecord;

        
        // =========================  AMFS  =========================
        con = new Contact();
        con.AccountId = acc.Id;
        con.FirstName = 'First Name';
        con.LastName = 'Last Name';
        con.Entity__c = 'AMFS';
        con.PolicyApp__c = 'RLS';
        insert con;
        
        con2nd = new Contact();
        con2nd.AccountId = acc.Id;
        con2nd.FirstName = 'First Name 2nd';
        con2nd.LastName = 'Last Name 2nd';
        con2nd.Entity__c = 'AMFS';
        con2nd.PolicyApp__c = 'RLS';
        insert con2nd;
        
        midMaster = new MID_Master_Parameter__c();
        midMaster.PolicyApp__c = 'RLS';
        midMaster.Payment_Type__c = 'credit_card';
        midMaster.Order_Code__c = 'SFIB1';
        midMaster.gross_amount__c = 10000;
        midMaster.Entity__c = 'AMFS';
        midMaster.TC_01__c = '';
        midMaster.TC_02__c = '';
        midMaster.TC_03__c = '';
        midMaster.TC_04__c = '';
        midMaster.TC_05__c = '';
        midMaster.TC_06__c = '';
        midMaster.TC_07__c = '';
        midMaster.TC_08__c = '';
        midMaster.TC_09__c = '';
        midMaster.TC_10__c = '';
        midMaster.snapJs__c = '';
        midMaster.dataClientKey__c = '';
        insert midMaster;
        
        midRecord = new MID_Secure_Payment__c();
        midRecord.External_Id_SFDC__c = 'SFIB1_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.SFDC_Order_Id__c = 'SFIB1';
        midRecord.Entity__c = '';
        midRecord.SFDC_Order_Id_Child__c = 'SFIB1_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.mid_custom_field1__c = '';
        midRecord.mid_custom_field2__c = '';
        midRecord.mid_custom_field3__c = '';
        midRecord.mid_custom_field3_temp__c = 'RLS_507-1234567_10000_AMFS;RLS_507-1234567_0_AMFS;';
        midRecord.Payment_Type__c = '';
        midRecord.Bank_Name__c = 'BCA';
        midRecord.mid_transaction_status__c = '';
        insert midRecord;

        // ========================= BOTH / DUAL Charging ==============
        midMaster = new MID_Master_Parameter__c();
        midMaster.PolicyApp__c = 'Both';
        midMaster.Payment_Type__c = 'credit_card';
        midMaster.Order_Code__c = 'SFIBX';
        midMaster.gross_amount__c = 10000;
        midMaster.Entity__c = 'AMFS';
        midMaster.TC_01__c = '';
        midMaster.TC_02__c = '';
        midMaster.TC_03__c = '';
        midMaster.TC_04__c = '';
        midMaster.TC_05__c = '';
        midMaster.TC_06__c = '';
        midMaster.TC_07__c = '';
        midMaster.TC_08__c = '';
        midMaster.TC_09__c = '';
        midMaster.TC_10__c = '';
        midMaster.snapJs__c = '';
        midMaster.dataClientKey__c = '';
        insert midMaster;
        
        midRecord = new MID_Secure_Payment__c();
        midRecord.External_Id_SFDC__c = 'SFIBX_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.SFDC_Order_Id__c = 'SFIBX';
        midRecord.Entity__c = '';
        midRecord.SFDC_Order_Id_Child__c = 'SFIBX_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.mid_custom_field1__c = '';
        midRecord.mid_custom_field2__c = '';
        midRecord.mid_custom_field3__c = '';
        midRecord.mid_custom_field3_temp__c = 'RLS_507-1234567_10000_AMFS;RLS_507-1234567_0_AMFS;DMTM_507-1234567_10000_AMFS;DMTM_507-1234567_0_AMFS;';
        midRecord.Payment_Type__c = '';
        midRecord.Bank_Name__c = 'BCA';
        midRecord.mid_transaction_status__c = '';
        insert midRecord;
        
    }
    
    // AFI
    public static testMethod void testCase0() {
        Test.startTest();
        ChangePaymentController page1ctrl = new ChangePaymentController();
        page1ctrl.paramKYC = '';
        page1ctrl.EnablePaymentType = TRUE;
        page1ctrl.changeName = FALSE;
        page1ctrl.otherBankNameSaving = '';
        page1ctrl.selectedMidChildId = '';
        page1ctrl.termsCheck = FALSE;
        page1ctrl.paramSelector = '';
        page1ctrl.vsnapToken = '';
        page1ctrl.transactionTime = '';
        page1ctrl.PolicySelectorInit();
        page1ctrl.getListOfKYC();
        Test.stopTest();
    
    }
    
    public static testMethod void testCase1() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        Contact con = [SELECT Id, PolicyApp__c FROM Contact WHERE FirstName = 'First Name' and Entity__c = 'AFI' LIMIT 1];
        Contact con2nd = [SELECT Id, PolicyApp__c FROM Contact WHERE FirstName = 'First Name 2nd' and Entity__c = 'AFI' LIMIT 1];
        PageReference page1 = Page.ChangePaymentPage;
    Test.setCurrentPage(page1);
        ApexPages.currentPage().getParameters().put('contact_id', con.Id);
        
        Test.startTest();
        ChangePaymentController page1ctrl = new ChangePaymentController();        
        
        page1ctrl.firstContactId = con.Id;
        page1ctrl.contactPolicyApp = con.PolicyApp__c;
        page1ctrl.ChangePaymentInit();
        page1ctrl.addLookup.Contact__c = con2nd.Id;
        page1ctrl.getListOfOrigin();
        page1ctrl.getListOfPaymentFrequency();
        page1ctrl.getListOfPaymentType();
        page1ctrl.contactEntity = 'AFI';
        page1ctrl.contactPolicyApp = 'RLS';
        page1ctrl.contactPolicyNo = '507-1234567';
        page1ctrl.selectedItem = 'credit_card';
        page1ctrl.beneficialOwner = false;
        page1ctrl.sendEmail = false;
        page1ctrl.initVsnap();
        page1ctrl.generateSecondaryContact();
        page1ctrl.addContact();
        page1ctrl.removeContact();
        page1ctrl.saveDataOrder();
        page1ctrl.saveData();
        page1ctrl.resetPage();
        Test.stopTest();
    }
    
    public static testMethod void testCase2() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        PageReference page2 = Page.TermsAndConditionsPage;
        Test.setCurrentPage(page2);
        ApexPages.currentPage().getParameters().put('PolicyNo', '507-1234567');
        ApexPages.currentPage().getParameters().put('Entity', 'AFI');
        ApexPages.currentPage().getParameters().put('PolicyApp', 'RLS');
        ApexPages.currentPage().getParameters().put('Beneficialowner', 'MrOwner');
        
        Test.startTest();
        ChangePaymentController page2ctrl = new ChangePaymentController();
        page2ctrl.TermsAndConditionsInit();
        page2ctrl.getVSnapTokenMidtrans();
        Test.stopTest();
    }
    
    public static testMethod void testCase3() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        PageReference page3 = Page.OrderStatusPage;
        Test.setCurrentPage(page3);
        ApexPages.currentPage().getParameters().put('orderId', 'SFIF1');
        ApexPages.currentPage().getParameters().put('statusCode', '200');
        ApexPages.currentPage().getParameters().put('transactionId', '1');
        
        Test.startTest();
        ChangePaymentController page3ctrl = new ChangePaymentController();
        page3ctrl.OrderStatusInit();
        Test.stopTest();
    }
    
    public static testMethod void testCase4() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIFX'];
        if (checkmaster.size() == 0) testSetup();

        MID_Secure_Payment__c tempMid = [SELECT Id, SFDC_Order_Id_Child__c, Payment_Type__c, Card_Number__c, Account_Number__c, Bank_Name__c,
                                         mid_masked_card__c, mid_approval_code__c, mid_bank__c, mid_transaction_time__c, mid_gross_amount__c, 
                                         mid_payment_type__c, mid_signature_key__c, mid_status_code__c, mid_transaction_status__c, mid_fraud_status__c, 
                                         mid_status_message__c, mid_saved_token_id__c, mid_saved_token_id_expired_at__c, mid_custom_field1__c,
                                         mid_custom_field2__c, mid_custom_field3__c, mid_custom_field3_temp__c FROM MID_Secure_Payment__c WHERE SFDC_Order_Id__c = 'SFIFX'];
        PageReference page4 = Page.OrderStatusPageEIP;
        Test.setCurrentPage(page4);
        ApexPages.currentPage().getParameters().put('PolicyNo', '507-1234567');
        ApexPages.currentPage().getParameters().put('Entity', 'AFI');
        ApexPages.currentPage().getParameters().put('PolicyApp', 'RLS');
        ApexPages.currentPage().getParameters().put('selectedItem', 'credit_card');
        ApexPages.currentPage().getParameters().put('BothApps', 'true');
        
        Test.startTest();
        ChangePaymentController page4ctrl = new ChangePaymentController();
        page4ctrl.OrderStatusInitEIP();
        page4ctrl.TempOrder = tempMid;
        page4ctrl.DoOrderSubmitDataEIP();
        page4ctrl.DoOrderSubmitDataSFDC();
        page4ctrl.bankNamePrivate = tempMid;
        page4ctrl.DoOrderSubmitData(tempMid.SFDC_Order_Id_Child__c);
        Test.stopTest();
    }
    
    public static testMethod void testCase5() {        
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        Test.startTest();
        ChangePaymentController page5ctrl = new ChangePaymentController();
        page5ctrl.cardNumberPrivate = '5543002151892020';
        page5ctrl.initSendEmail();
        page5ctrl.sendEmail = true;
        page5ctrl.selectedItem = 'private';
        page5ctrl.beneficialOwner = true;
        page5ctrl.CheckSendEmail();
        page5ctrl.FCheckLuhn();
        page5ctrl.checkLuhnExcel('5543002151892020');
        page5ctrl.checkLuhn('5543002151892020');
        Test.stopTest();
    }
    
    // AMFS
    public static testMethod void testCase6() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        Contact con = [SELECT Id, PolicyApp__c FROM Contact WHERE FirstName = 'First Name' and Entity__c = 'AMFS' LIMIT 1];
        Contact con2nd = [SELECT Id, PolicyApp__c FROM Contact WHERE FirstName = 'First Name 2nd' and Entity__c = 'AMFS' LIMIT 1];
        PageReference page1 = Page.ChangePaymentPage;
    Test.setCurrentPage(page1);
        ApexPages.currentPage().getParameters().put('contact_id', con.Id);
        
        Test.startTest();
        ApexPages.currentPage().getParameters().put('paramEntity', 'AMFS');
        ApexPages.currentPage().getParameters().put('paramSendEmail', 'TRUE');
        ApexPages.currentPage().getParameters().put('paramKYC', 'Perorangan');

        ChangePaymentController page1ctrl = new ChangePaymentController();
        page1ctrl.firstContactId = con.Id;
        page1ctrl.contactPolicyApp = con.PolicyApp__c;
        page1ctrl.ChangePaymentInit();
        page1ctrl.addLookup.Contact__c = con2nd.Id;
        page1ctrl.getListOfOrigin();
        page1ctrl.getListOfPaymentFrequency();
        page1ctrl.getListOfPaymentType();
        page1ctrl.contactEntity = 'AMFS';
        page1ctrl.contactPolicyApp = 'RLS';
        page1ctrl.contactPolicyNo = '507-1234567';
        page1ctrl.selectedItem = 'credit_card';
        page1ctrl.beneficialOwner = false;
        page1ctrl.sendEmail = false;
        
        page1ctrl.initVsnap();
        page1ctrl.generateSecondaryContact();
        page1ctrl.addContact();
        page1ctrl.removeContact();
        page1ctrl.saveDataOrder();
        page1ctrl.saveData();
        page1ctrl.resetPage();
        Test.stopTest();
    }
    
    public static testMethod void testCase7() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        PageReference page2 = Page.TermsAndConditionsPage;
        Test.setCurrentPage(page2);
        ApexPages.currentPage().getParameters().put('PolicyNo', '507-1234567');
        ApexPages.currentPage().getParameters().put('Entity', 'AMFS');
        ApexPages.currentPage().getParameters().put('PolicyApp', 'RLS');
        ApexPages.currentPage().getParameters().put('Beneficialowner', 'MrOwner');
        
        Test.startTest();
        ChangePaymentController page2ctrl = new ChangePaymentController();
        page2ctrl.TermsAndConditionsInit();
        page2ctrl.getVSnapTokenMidtrans();
        Test.stopTest();
    }
    
    public static testMethod void testCase8() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        PageReference page3 = Page.OrderStatusPage;
        Test.setCurrentPage(page3);
        ApexPages.currentPage().getParameters().put('orderId', 'SFIB1');
        ApexPages.currentPage().getParameters().put('statusCode', '200');
        ApexPages.currentPage().getParameters().put('transactionId', '1');
        
        Test.startTest();
        ChangePaymentController page3ctrl = new ChangePaymentController();
        page3ctrl.OrderStatusInit();
        Test.stopTest();
    }
    
    public static testMethod void testCase9() {
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIBX'];
        if (checkmaster.size() == 0) testSetup();

        MID_Secure_Payment__c tempMid = [SELECT Id, SFDC_Order_Id_Child__c, Payment_Type__c, Card_Number__c, Account_Number__c, Bank_Name__c,
                                         mid_masked_card__c, mid_approval_code__c, mid_bank__c, mid_transaction_time__c, mid_gross_amount__c, 
                                         mid_payment_type__c, mid_signature_key__c, mid_status_code__c, mid_transaction_status__c, mid_fraud_status__c, 
                                         mid_status_message__c, mid_saved_token_id__c, mid_saved_token_id_expired_at__c, mid_custom_field1__c,
                                         mid_custom_field2__c, mid_custom_field3__c, mid_custom_field3_temp__c FROM MID_Secure_Payment__c WHERE SFDC_Order_Id__c = 'SFIBX'];
        PageReference page4 = Page.OrderStatusPageEIP;
        Test.setCurrentPage(page4);
        ApexPages.currentPage().getParameters().put('PolicyNo', '507-1234567');
        ApexPages.currentPage().getParameters().put('Entity', 'AMFS');
        ApexPages.currentPage().getParameters().put('PolicyApp', 'RLS');
        ApexPages.currentPage().getParameters().put('selectedItem', 'credit_card');
        ApexPages.currentPage().getParameters().put('BothApps', 'true');
        
        Test.startTest();
        ChangePaymentController page4ctrl = new ChangePaymentController();
        page4ctrl.OrderStatusInitEIP();
        page4ctrl.TempOrder = tempMid;
        page4ctrl.DoOrderSubmitDataEIP();
        page4ctrl.DoOrderSubmitDataSFDC();
        page4ctrl.bankNamePrivate = tempMid;
        page4ctrl.DoOrderSubmitData(tempMid.SFDC_Order_Id_Child__c);
        Test.stopTest();
    }
    
    public static testMethod void testCase10() {        
        list<MID_Master_Parameter__c> checkmaster = [SELECT id FROM MID_Master_Parameter__c WHERE Order_Code__c = 'SFIF1'];
        if (checkmaster.size() == 0) testSetup();

        Test.startTest();
        ChangePaymentController page5ctrl = new ChangePaymentController();
        page5ctrl.cardNumberPrivate = '5543002151892020';
        page5ctrl.initSendEmail();
        page5ctrl.sendEmail = true;
        page5ctrl.selectedItem = 'private';
        page5ctrl.beneficialOwner = true;
        page5ctrl.CheckSendEmail();
        page5ctrl.FCheckLuhn();
        page5ctrl.checkLuhnExcel('5543002151892020');
        page5ctrl.checkLuhn('5543002151892020');
        Test.stopTest();
    }

    // Entity AMFS & SecureIVR
    public static testMethod void testCase11() {
        MID_Master_Parameter__c midMaster = new MID_Master_Parameter__c();
        midMaster.PolicyApp__c = 'RLS';
        midMaster.Payment_Type__c = 'credit_card';
        midMaster.Order_Code__c = 'SFIFX';
        midMaster.gross_amount__c = 10000;
        midMaster.Entity__c = 'AFI';
        midMaster.TC_01__c = '';
        midMaster.TC_02__c = '';
        midMaster.TC_03__c = '';
        midMaster.TC_04__c = '';
        midMaster.TC_05__c = '';
        midMaster.TC_06__c = '';
        midMaster.TC_07__c = '';
        midMaster.TC_08__c = '';
        midMaster.TC_09__c = '';
        midMaster.TC_10__c = '';
        midMaster.snapJs__c = '';
        midMaster.dataClientKey__c = '';
        insert midMaster;


        MID_Secure_Payment__c tempMid = [SELECT Id, SFDC_Order_Id_Child__c, Payment_Type__c, Card_Number__c, Account_Number__c, Bank_Name__c,
                                         mid_masked_card__c, mid_approval_code__c, mid_bank__c, mid_transaction_time__c, mid_gross_amount__c, 
                                         mid_payment_type__c, mid_signature_key__c, mid_status_code__c, mid_transaction_status__c, mid_fraud_status__c, 
                                         mid_status_message__c, mid_saved_token_id__c, mid_saved_token_id_expired_at__c, mid_custom_field1__c,
                                         mid_custom_field2__c, mid_custom_field3__c, mid_custom_field3_temp__c FROM MID_Secure_Payment__c WHERE SFDC_Order_Id__c = 'SFIFX'];
        PageReference page4 = Page.OrderStatusPageEIP;
        Test.setCurrentPage(page4);
        ApexPages.currentPage().getParameters().put('PolicyNo', '507-1234567');
        ApexPages.currentPage().getParameters().put('Entity', 'AFI');
        ApexPages.currentPage().getParameters().put('PolicyApp', 'RLS');
        ApexPages.currentPage().getParameters().put('selectedItem', 'credit_card');
        ApexPages.currentPage().getParameters().put('BothApps', 'true');
        
        Test.startTest();
        ChangePaymentController page4ctrl = new ChangePaymentController();
        page4ctrl.TestValidateTrue = TRUE;
        page4ctrl.OrderStatusInitEIP();
        page4ctrl.TempOrder = tempMid;
        page4ctrl.initVsnap();
        page4ctrl.checkvalidate();
        //page4ctrl.saveDataOrder();
        page4ctrl.initSecureIVR();
        //page4ctrl.DoOrderSubmitData(tempMid.SFDC_Order_Id_Child__c);
        Test.stopTest();
    }

}