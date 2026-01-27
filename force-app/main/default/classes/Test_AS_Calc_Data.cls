@isTest (seeAllData=true)
private class Test_AS_Calc_Data{
    static testMethod void myTest(){
        
        Test.startTest();
        
        Agent_Scheduling__c ags = [SELECT id, Calc_Data__c, Agent_SIP__c, Document_Date__c, Entity__c FROM Agent_Scheduling__c limit 1];
        ags.Calc_Data__c = TRUE;
        update ags;
       
        Test.stopTest();
        
    }
}