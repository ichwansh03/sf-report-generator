@isTest
public class RevokeAssesmentServiceErrorTriggerTest {
    
    @testSetup
    public static void setup(){
        ID rtCollectionAMFS = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        ID rtClRedemp = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Collection AMFS 8').getRecordTypeId();
        Date dtNow = Date.today();
        Date cpgExpDate = dtNow.addDays(19);
        
        Contact con = new Contact();
        con.Lastname = 'someone';
        con.Policy_No__c = '939939';
        con.Entity__c = 'AMFS';
        insert con;
        
        Call_List__c cpg = new Call_List__c();
        cpg.RecordTypeId = rtCollectionAMFS;
        cpg.Entity__c = 'AMFS';
        cpg.Activity__c = 'Collection';
        cpg.Case_Type__c = 'Redemption TM';
        cpg.Campaign_Name__c = 'Collection-Redemption TM-Test#20240718';
        cpg.Expired_Date__c = cpgExpDate; 
        insert cpg;
        
        Call_line__c cl = new Call_Line__c();
        cl.RecordTypeId = rtClRedemp;
        cl.Contact__c = con.Id;
        cl.Call_List__c = cpg.Id;
        cl.Case_Type__c = 'Redemption TM';
        cl.policy_no__c = con.Policy_No__c;
        cl.Call_Remarks__c = 'Remarks';
        cl.Notes__c = 'Notes';
        cl.Entity__c = 'AMFS';
        cl.Contacted_Number__c = '085156080110';
        cl.Call_Status_Config__c = 'Retry';
        cl.Reason_Status_Config__c = 'Busy Line';
        insert cl;
    }
    
    public static testMethod void testRevokeAssesmentTrigger(){
        
        Contact con = [SELECT Id, Entity__c, Policy_No__c FROM Contact LIMIT 1];
        Call_Line__c cl = [SELECT Id FROM Call_Line__c LIMIT 1];
        
        AppLog__c log = new AppLog__c();
        log.id__c = con.id;
        log.Log_Call_Line__c = cl.Id;
        log.StartLongTime__c = system.now().getTime();
        log.EndLongTime__c = system.now().getTime();
        log.entity__c = con.Entity__c;
        log.Status__c = 'Error';
        log.Report_Name__c = 'AMFS Collection Robot DMTM';
        log.policy_no__c = con.Policy_No__c ;
        insert log;    
    }
    
    public static testMethod void testNonRevokeAssesmentTrigger(){
        
        DateTime dt = DateTime.now().addMinutes(Integer.valueOf(System.Label.SchNotificationServiceError_Minute));
        String sch = '0 '+dt.minute()+' '+System.Label.SchNotificationServiceError_Hour.toString();
        System.schedule('SchNotificationServiceError', sch, new SchCoreServiceNotification());
        
        Contact con = [SELECT Id, Entity__c, Policy_No__c FROM Contact LIMIT 1];
        Call_Line__c cl = [SELECT Id FROM Call_Line__c LIMIT 1];
        
        AppLog__c log = new AppLog__c();
        log.id__c = con.id;
        log.Log_Call_Line__c = cl.Id;
        log.StartLongTime__c = system.now().getTime();
        log.EndLongTime__c = system.now().getTime();
        log.entity__c = con.Entity__c;
        log.Status__c = 'Success';
        log.Report_Name__c = 'AMFS Collection Robot DMTM';
        log.policy_no__c = con.Policy_No__c ;
        insert log;
    }
    
}