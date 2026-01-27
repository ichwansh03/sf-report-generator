@istest
public class DistributeNegativeFeedbackTest {
    @testSetup
    static void setup() { 
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = 'AMFS';
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.phone = '0891667363';
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = 'AMFS';
        contact1.AccountId = ac1.Id;
        insert contact1; 
        
        Master_Case_Type_Regional__c setCaseType = new Master_Case_Type_Regional__c();
        setCaseType.name = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Case_Type__c = 'Inquiry_CS Info Manfaat Polis';
        setCaseType.Entity__c = 'AMFS';
        setCaseType.MOT__c = 'I Ask';
        setCaseType.Qualtrics__c  = true;
        INSERT setCaseType;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        case setCase = new case();
        setCase.type = 'Inquiry';
        setcase.status ='new';
        setCase.contactid = contact1.id;
        insert setCase;
        
        User_detail__c setUserDetail = new User_detail__c();
        setUserDetail.User__c = userinfo.getUserId();
        setUserDetail.RecordTypeId = Schema.SObjectType.User_detail__c.getRecordTypeInfosByName().get(System.label.User_Detail_Qualtrics).getRecordTypeId();
        insert setUserDetail;
        
        
        
        User_detail__c setUserDetailPrio = new User_detail__c();
        setUserDetailPrio.User__c = userinfo.getUserId();
        setUserDetailPrio.RecordTypeId = Schema.SObjectType.User_detail__c.getRecordTypeInfosByName().get(System.label.User_Detail_Priority).getRecordTypeId();
        insert setUserDetailPrio;
        
        
        Master_Holiday__c mh = new Master_Holiday__c();
        mh.Name = 'Tes Master Holiday 1';
        mh.Entity__c = 'AMFS'; 
        mh.Type__c = 'Holiday';
        mh.Description_ID__c = 'Tes Master Holiday 1';
        mh.Description_EN__c = 'Tes Master Holiday 1';  
        mh.Start_Date_Time__c = system.today();
        mh.End_Date_Time__c = system.today()+1;
        mh.Active_Date__c = date.valueOf(system.today()+2); 
        mh.Description_ID__c = 'Selamat Berlibur';
        mh.Description_ID__c = 'Happy Holiday';
        insert mh;
        
        
        String RTTeleServiceCampaign = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('TeleService ICF').getRecordTypeId();
        Call_List__c dataCampaign = new Call_List__c();
        dataCampaign.Entity__c = 'AMFS';
        dataCampaign.RecordTypeId = RTTeleServiceCampaign;
        
        Date currDate = System.today();
        // Get the first day of the month
        Date firstDayOfMonth = Date.newInstance(currDate.year(), currDate.month(), 1);
        // Calculate the last day of the month
        Date lastDayOfMonth = firstDayOfMonth.addMonths(1).addDays(-1);
        // Get end of day
        DateTime endOfDayTime = Datetime.newInstance(lastDayOfMonth,Time.newInstance(23, 59, 59, 999));
        system.debug('endOfDayTime:'+endOfDayTime);
        Date endofDay = Date.newInstance(endOfDayTime.year(), endOfDayTime.month(), endOfDayTime.Day());
        system.debug('endOfDay:'+endOfDay);
        dataCampaign.Activity__c = 'Teleservices';
        dataCampaign.Activity_Config__c = 'Teleservices';
        dataCampaign.Expired_Date__c = endofDay;
        dataCampaign.Case_Type__c = 'ICF Survey Inquiry';
        dataCampaign.Case_Type_Config__c = 'ICF Survey Inquiry';
        insert dataCampaign;
    }
    
    @isTest
    static void distributionNonPrio() {
        Test.StartTest();

        Contact contact1 = [select id from contact limit 1];
        Call_List__c dataCampaign = [select id from Call_List__c limit 1];
        Case setCase = [select id from Case where type = 'Inquiry' limit 1];
        String RTTeleServiceCallLine =  Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TeleService').getRecordTypeId();

        Call_Line__c setCallLine = new Call_Line__c();
        setCallLine.Call_List__c = dataCampaign.id;
        setCallLine.Entity__c = 'AMFS';
        setCallLine.contact__c = contact1.id;
        setCallLine.Case__c = setCase.id;
        setCallLine.RecordTypeId = RTTeleServiceCallLine;
        insert setCallLine;
        
        Database.executeBatch(new DistributeNegativeFeedback(), 200);
        test.StopTest();
    }

    
    @isTest
    static void distributionPrio() {
        Test.StartTest();

        Contact contact1 = [select id from contact limit 1];
        Call_List__c dataCampaign = [select id from Call_List__c limit 1];
        Case setCase = [select id from Case where type = 'Inquiry' limit 1];
        String RTTeleServiceCallLine =  Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TeleService').getRecordTypeId();

        Call_Line__c setCallLine = new Call_Line__c();
        setCallLine.Call_List__c = dataCampaign.id;
        setCallLine.Entity__c = 'AMFS';
        setCallLine.contact__c = contact1.id;
        setCallLine.Priority__c = 'Yes';
        setCallLine.Case__c = setCase.id;
        setCallLine.RecordTypeId = RTTeleServiceCallLine;
        insert setCallLine;
        
        Database.executeBatch(new DistributeNegativeFeedback(), 200);
        test.StopTest();
    }
}