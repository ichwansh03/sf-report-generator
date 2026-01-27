@isTest
private class CallLineTelUWHelperTest {

    static testMethod void testRequestTelUW() {
        // Setup mock request
        CLTelUWWrapper.Request req = generateMockRequest();
        setAccount();
        Test.startTest();
        CLTelUWWrapper.TelUWCallLineDataResponse response = RestCallLineTelUWSubmit.requestTelUW(req);
        Test.stopTest();

    }
    
    static testMethod void testRequestTelUW2() {
        // Setup mock request
        CLTelUWWrapper.Request req = new CLTelUWWrapper.Request();
        setAccount();
        Test.startTest();
        CLTelUWWrapper.TelUWCallLineDataResponse response = RestCallLineTelUWSubmit.requestTelUW(req);
        Test.stopTest();

    }

    static testMethod void testRescheduleTelUW() {
        // Setup mock request
        CLTelUWWrapper.Request req = generateMockRequest();
        req.policyNo = '521-1610430';
        req.scheduleDate = String.valueOf(DateTime.now().addDays(3));
        req.note = 'Reschedule Note';
        req.source = 'Banca';
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.Response response = RestCallLineTelUWSubmit.rescheduleTelUW(req);
        Test.stopTest();

    }
    
    static testMethod void testRescheduleTelUW2() {
        // Setup mock request
        CLTelUWWrapper.Request req = generateMockRequest();
        req.policyNo = '521-1610430';
        req.scheduleDate = String.valueOf(DateTime.now().addDays(3));
        req.note = 'Reschedule Note';
        req.source = 'Banca';
        setAccount();

        Test.startTest();
        CLTelUWWrapper.Response response = RestCallLineTelUWSubmit.rescheduleTelUW(req);
        Test.stopTest();

    }
    
    static testMethod void testRescheduleTelUW3() {
        // Setup mock request
        CLTelUWWrapper.Request req = generateMockRequest();
        req.policyNo = '521-1610430';
        req.scheduleDate = String.valueOf(DateTime.now().addDays(3));
        req.note = 'Reschedule Note';
        req.source = 'Banca';
        setAllData();

        Test.startTest();
        CLTelUWWrapper.Response response = RestCallLineTelUWSubmit.rescheduleTelUW(req);
        Test.stopTest();

    }
    
    static testMethod void testRescheduleTelUW4() {
        // Setup mock request
        CLTelUWWrapper.Request req = new CLTelUWWrapper.Request();
        setAccount();

        Test.startTest();
        CLTelUWWrapper.Response response = RestCallLineTelUWSubmit.rescheduleTelUW(req);
        Test.stopTest();

    }

    static testMethod void testGetCallLine() {
        CLTelUWWrapper.Request req = generateMockRequest();
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.TelUWCallLineDataResponse response = RestCallLineTelUWCheck.getCallLine(req);
        Test.stopTest();

    }
    
    static testMethod void testGetCallLine2() {
        CLTelUWWrapper.Request req = generateMockRequest();
        setAccount();

        Test.startTest();
        CLTelUWWrapper.TelUWCallLineDataResponse response = RestCallLineTelUWCheck.getCallLine(req);
        Test.stopTest();

    }
    
    static testMethod void testGetCallLine3() {
        CLTelUWWrapper.Request req = new CLTelUWWrapper.Request();
        setAllData();

        Test.startTest();
        CLTelUWWrapper.TelUWCallLineDataResponse response = RestCallLineTelUWCheck.getCallLine(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime() {
        CLTelUWWrapper.Request req = generateMockRequest();
        req.scheduleDate = String.valueOf(Date.today().addDays(1));
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime2() {
        CLTelUWWrapper.Request req = generateMockRequest();
        req.scheduleDate = String.valueOf(Date.today().addDays(2));
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime3() {
        CLTelUWWrapper.Request req = generateMockRequest();
        req.scheduleDate = String.valueOf(Date.today().addDays(3));
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime4() {
        CLTelUWWrapper.Request req = generateMockRequest();
        req.scheduleDate = String.valueOf(Date.today().addDays(4));
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime5() {
        CLTelUWWrapper.Request req = generateMockRequest();
        req.scheduleDate = String.valueOf(Date.today().addDays(5));
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime6() {
        CLTelUWWrapper.Request req = generateMockRequest();
        req.scheduleDate = String.valueOf(Date.today().addDays(6));
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime7() {
        CLTelUWWrapper.Request req = generateMockRequest();
        req.scheduleDate = String.valueOf(Date.today().addDays(7));
        setAllDataResch();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime8() {
        CLTelUWWrapper.Request req = new CLTelUWWrapper.Request();
        req.scheduleDate = String.valueOf(Date.today().addDays(7));
        setAccount();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testGetAvailTime9() {
        CLTelUWWrapper.Request req = new CLTelUWWrapper.Request();
        setAllAccountandContact();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse response = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();

    }
    
    static testMethod void testAvailTimeGenericException() {
        CLTelUWWrapper.Request req = new CLTelUWWrapper.Request();
        req.policyNo = 'POL123456';
        req.scheduleDate = 'invalid-date-format';
        setAllAccountandContact();

        Test.startTest();
        CLTelUWWrapper.CheckTimeAvailabilityResponse res = RestCallLineTelUWCheck.getAvailTime(req);
        Test.stopTest();
    }

    
    static testMethod void testGetAvailTimeNew() {
        setAccount();
        Test.startTest();
        CallLineTeluwHelper callLineTeluwHelper = new CallLineTeluwHelper();
        CallLineTeluwHelper.getAllTimeRescheduleNew();
        Test.stopTest();
    }

    // Helper method to generate mock request
    private static CLTelUWWrapper.Request generateMockRequest() {
        CLTelUWWrapper.Request req = new CLTelUWWrapper.Request();
        req.scheduleDate = String.valueOf(Date.today().addDays(2));
        req.note = 'Test Note';
        req.source = 'Banca';
        
        req.lastName = 'Adi Wijaya';
        req.policyNo = '521-1610430';
        req.policyNoNumeric = '5211610430';
        req.entity = 'AMFS';
        req.phone = '085716222996';
        req.mobilePhone = '085716222996';
        req.email = 'test@example.com';
        req.insuredName = 'Test Insured';
        req.insuredEmail = 'insured@example.com';
        req.policyApp = 'RLS';
        req.productCodePlan = 'M812N2D';
        req.totalPremium = '441379';
        req.premium = '441379';
        req.paymentType = 'M';
        req.gender = 'M';
        req.campaignType = 'TelUW';
        req.issuedDate = String.valueOf(Date.today());
        req.ape = '500000';
        req.contactCurrency = 'RP';
        return req;
    }
    
    private static void setAccount(){
        Account amfsTest = new Account();
        amfsTest.Name = 'Account AMFS';
        amfsTest.Entity__c = 'AMFS';
        insert amfsTest;
    }
    
    private static void setAllData(){
        Account amfsTest = new Account();
        amfsTest.Name = 'Account AMFS';
        amfsTest.Entity__c = 'AMFS';
        insert amfsTest;
        
        Contact cont = new Contact();
        cont.AccountId = amfsTest.Id;
        cont.LastName = 'Adi Wijaya';
        cont.Policy_No__c = '521-1610430';
        cont.Policy_No_Numeric__c = '5211610430';
        cont.Entity__c = 'AMFS';
        cont.Phone = '085716222996';
        cont.MobilePhone = '085716222996';
        cont.Email = 'test@example.com';
        cont.Insured_Name__c = 'Adi Wijaya';
        cont.Insured_Email__c = 'test@example.com';
        cont.PolicyApp__c = 'RLS';
        cont.Product_Code_Plant_TelUW__c = 'M812N2D';
        cont.Total_Premium__c = Decimal.valueOf('441379');
        cont.Premium__c = Decimal.valueOf('441379');
        cont.WelcomeCall_Payment_Type__c = 'M';
        cont.WelcomeCall_Gender__c = 'M';
        cont.Campaign_Type__c = 'TelUW';
        cont.Issued_Date_TelUw__c = Date.valueOf(String.valueOf(Date.today()));
        cont.APE_TelUW__c = Decimal.valueOf('441379');
        cont.Currency_TelUW__c = 'RP';
        insert cont;
    }
    
    private static void setAllAccountandContact(){
        Account amfsTest = new Account();
        amfsTest.Name = 'Account AMFS';
        amfsTest.Entity__c = 'AMFS';
        insert amfsTest;
        
        Contact cont = new Contact();
        cont.AccountId = amfsTest.Id;
        cont.LastName = 'Adi Wijaya';
        cont.Policy_No__c = '521-1610430';
        cont.Policy_No_Numeric__c = '5211610430';
        cont.Entity__c = 'AMFS';
        cont.Phone = '085716222996';
        cont.MobilePhone = '085716222996';
        cont.Email = 'test@example.com';
        cont.Insured_Name__c = 'Adi Wijaya';
        cont.Insured_Email__c = 'test@example.com';
        cont.PolicyApp__c = 'RLS';
        cont.Product_Code_Plant_TelUW__c = 'M812N2D';
        cont.Total_Premium__c = Decimal.valueOf('441379');
        cont.Premium__c = Decimal.valueOf('441379');
        cont.WelcomeCall_Payment_Type__c = 'M';
        cont.WelcomeCall_Gender__c = 'M';
        cont.Campaign_Type__c = 'TelUW';
        cont.Issued_Date_TelUw__c = Date.valueOf(String.valueOf(Date.today()));
        cont.APE_TelUW__c = Decimal.valueOf('441379');
        cont.Currency_TelUW__c = 'RP';
        insert cont;
        
        ID cliId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Confirmation AMFS').getRecordTypeId();
        Call_List__c cli = new Call_List__c();
        cli.Activity__c = 'Confirmation';
        cli.Campaign_Name__c = 'TelUW202507Automatic';
        cli.Case_Type_Config__c = 'TelUW';
        cli.Expired_Date__c = Date.valueOf(Date.today().addDays(30));
        cli.Entity__c = 'AMFS';
        cli.RecordTypeId = cliId;
        cli.WelcomeCall_Fg_Automatic__c = true;
        insert cli;
        
        ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
        Call_Line__c cl = new Call_Line__c();
        cl.RecordTypeId = wcRtId;
        cl.Contact__c = cont.Id;
        cl.Call_List__c = cli.Id;
        cl.Call_Line_Status_TelUW__c = 'Open';
        cl.WelcomeCall_Call_Line_Status__c = 'Open';
        cl.Case_Type__c = 'TelUW';
        cl.Case_Type_Config__c = 'TelUW';
        cl.Contacted_Number__c = cont.mobilePhone;
        cl.Phone__c = cont.phone;
        cl.Activity__c = cli.Activity__c;
        cl.Policy_no__c = cont.Policy_No__c;
        cl.WelcomeCall_Schedule_Date__c = Date.today().addDays(2);
        cl.call_date__c = Date.today().addDays(2);
        cl.Entity__c = cont.Entity__c;
        insert cl;
    }
    
    private static void setAllDataResch(){
        Account amfsTest = new Account();
        amfsTest.Name = 'Account AMFS';
        amfsTest.Entity__c = 'AMFS';
        insert amfsTest;
        
        Contact cont = new Contact();
        cont.AccountId = amfsTest.Id;
        cont.LastName = 'Adi Wijaya';
        cont.Policy_No__c = '521-1610430';
        cont.Policy_No_Numeric__c = '5211610430';
        cont.Entity__c = 'AMFS';
        cont.Phone = '085716222996';
        cont.MobilePhone = '085716222996';
        cont.Email = 'test@example.com';
        cont.Insured_Name__c = 'Adi Wijaya';
        cont.Insured_Email__c = 'test@example.com';
        cont.PolicyApp__c = 'RLS';
        cont.Product_Code_Plant_TelUW__c = 'M812N2D';
        cont.Total_Premium__c = Decimal.valueOf('441379');
        cont.Premium__c = Decimal.valueOf('441379');
        cont.WelcomeCall_Payment_Type__c = 'M';
        cont.WelcomeCall_Gender__c = 'M';
        cont.Campaign_Type__c = 'TelUW';
        cont.Issued_Date_TelUw__c = Date.valueOf(String.valueOf(Date.today()));
        cont.APE_TelUW__c = Decimal.valueOf('441379');
        cont.Currency_TelUW__c = 'RP';
        insert cont;
        
        ID cliId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Confirmation AMFS').getRecordTypeId();
        Call_List__c cli = new Call_List__c();
        cli.Activity__c = 'Confirmation';
        cli.Campaign_Name__c = 'TelUW202507Automatic';
        cli.Case_Type_Config__c = 'TelUW';
        cli.Expired_Date__c = Date.valueOf(Date.today().addDays(30));
        cli.Entity__c = 'AMFS';
        cli.RecordTypeId = cliId;
        cli.WelcomeCall_Fg_Automatic__c = true;
        insert cli;
        
        User adminUser = new User(
            Alias = 'adminusr',
            Email = 'adminuser@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Admin',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = UserInfo.getProfileId(),
            TimeZoneSidKey = 'Asia/Jakarta',
            Username = 'adminuser' + DateTime.now().getTime() + '@example.com',
            Entity__c = 'AMFS'
        );
        insert adminUser;

        
        ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
        Call_Line__c cl = new Call_Line__c();
        cl.RecordTypeId = wcRtId;
        cl.Contact__c = cont.Id;
        cl.Call_List__c = cli.Id;
        cl.Call_Line_Status_TelUW__c = 'Progress';
        cl.WelcomeCall_Call_Line_Status__c = 'Progress';
        cl.Case_Type__c = 'TelUW';
        cl.Case_Type_Config__c = 'TelUW';
        cl.Contacted_Number__c = cont.mobilePhone;
        cl.Phone__c = cont.phone;
        cl.Activity__c = cli.Activity__c;
        cl.Policy_no__c = cont.Policy_No__c;
        cl.WelcomeCall_Schedule_Date__c = Date.today().addDays(2);
        cl.call_date__c = Date.today().addDays(2);
        cl.Entity__c = cont.Entity__c;
        cl.OwnerId = adminUser.id;
        insert cl;
    }
    
    private static void setAllDataReschAgentFull(){
        Account amfsTest = new Account();
        amfsTest.Name = 'Account AMFS';
        amfsTest.Entity__c = 'AMFS';
        insert amfsTest;
        
        Contact cont = new Contact();
        cont.AccountId = amfsTest.Id;
        cont.LastName = 'Adi Wijaya';
        cont.Policy_No__c = '521-1610430';
        cont.Policy_No_Numeric__c = '5211610430';
        cont.Entity__c = 'AMFS';
        cont.Phone = '085716222996';
        cont.MobilePhone = '085716222996';
        cont.Email = 'test@example.com';
        cont.Insured_Name__c = 'Adi Wijaya';
        cont.Insured_Email__c = 'test@example.com';
        cont.PolicyApp__c = 'RLS';
        cont.Product_Code_Plant_TelUW__c = 'M812N2D';
        cont.Total_Premium__c = Decimal.valueOf('441379');
        cont.Premium__c = Decimal.valueOf('441379');
        cont.WelcomeCall_Payment_Type__c = 'M';
        cont.WelcomeCall_Gender__c = 'M';
        cont.Campaign_Type__c = 'TelUW';
        cont.Issued_Date_TelUw__c = Date.valueOf(String.valueOf(Date.today()));
        cont.APE_TelUW__c = Decimal.valueOf('441379');
        cont.Currency_TelUW__c = 'RP';
        insert cont;
        
        ID cliId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Confirmation AMFS').getRecordTypeId();
        Call_List__c cli = new Call_List__c();
        cli.Activity__c = 'Confirmation';
        cli.Campaign_Name__c = 'TelUW202507Automatic';
        cli.Case_Type_Config__c = 'TelUW';
        cli.Expired_Date__c = Date.valueOf(Date.today().addDays(30));
        cli.Entity__c = 'AMFS';
        cli.RecordTypeId = cliId;
        cli.WelcomeCall_Fg_Automatic__c = true;
        insert cli;
        
        User adminUser = new User(
            Alias = 'adminusr',
            Email = 'adminuser@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Admin',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = UserInfo.getProfileId(),
            TimeZoneSidKey = 'Asia/Jakarta',
            Username = 'adminuser' + DateTime.now().getTime() + '@example.com',
            Entity__c = 'AMFS'
        );
        insert adminUser;

        
        ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
        Call_Line__c cl = new Call_Line__c();
        cl.RecordTypeId = wcRtId;
        cl.Contact__c = cont.Id;
        cl.Call_List__c = cli.Id;
        cl.Call_Line_Status_TelUW__c = 'Progress';
        cl.WelcomeCall_Call_Line_Status__c = 'Progress';
        cl.Case_Type__c = 'TelUW';
        cl.Case_Type_Config__c = 'TelUW';
        cl.Contacted_Number__c = cont.mobilePhone;
        cl.Phone__c = cont.phone;
        cl.Activity__c = cli.Activity__c;
        cl.Policy_no__c = cont.Policy_No__c;
        cl.WelcomeCall_Schedule_Date__c = Date.today().addDays(2);
        cl.call_date__c = Date.today().addDays(2);
        cl.Entity__c = cont.Entity__c;
        cl.OwnerId = adminUser.id;
        insert cl;
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.RecordTypeId = wcRtId;
        cl2.Contact__c = cont.Id;
        cl2.Call_List__c = cli.Id;
        cl2.Call_Line_Status_TelUW__c = 'Progress';
        cl2.WelcomeCall_Call_Line_Status__c = 'Progress';
        cl2.Case_Type__c = 'TelUW';
        cl2.Case_Type_Config__c = 'TelUW';
        cl2.Contacted_Number__c = cont.mobilePhone;
        cl2.Phone__c = cont.phone;
        cl2.Activity__c = cli.Activity__c;
        cl2.Policy_no__c = cont.Policy_No__c;
        cl2.WelcomeCall_Schedule_Date__c = Date.today().addDays(3);
        cl2.call_date__c = Date.today().addDays(3);
        cl2.Entity__c = cont.Entity__c;
        cl2.OwnerId = adminUser.id;
        insert cl2;
    }
    
}