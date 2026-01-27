@isTest
public class setDurationTriggerTest{
    public static testMethod void testsetDurationTrigger(){
        Contact con = new Contact();
        con.Lastname = 'someone';
        con.Policy_No__c = '939939';
        con.Entity__c = 'AFI';
        insert con;
        
        AppLog__c log = new AppLog__c();
        log.id__c = con.id;
        log.StartLongTime__c = system.now().getTime();
        log.EndLongTime__c = system.now().getTime();
        log.method__c = 'call webservice';
        log.entity__c = con.Entity__c;
        log.policy_no__c = con.Policy_No__c ;
        insert log;    
    }
}