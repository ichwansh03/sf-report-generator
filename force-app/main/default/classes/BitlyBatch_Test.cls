@isTest(SeeAllData=true)
private class BitlyBatch_Test{
    static testMethod void testBatch(){
    //List<Email_SMS_Log__c> scope = [select ready_to_send__c, mobile__c, entity__c, email_text__c, Survey_URL__c, Status_Deliver__c, messageid_jatis__C from email_sms_log__c where Survey_URL__c !=null and entiTy__c ='AFI' limit 2];
    //List<Email_SMS_Log__c> scope2 = [select ready_to_send__c, mobile__c, entity__c, email_text__c, Survey_URL__c, Status_Deliver__c, messageid_jatis__C from email_sms_log__c where Survey_URL__c !=null and entiTy__c ='MAGI' limit 2];
    //List<Email_SMS_Log__c> scope3 = [select ready_to_send__c, mobile__c, entity__c, email_text__c, Survey_URL__c, Status_Deliver__c, messageid_jatis__C from email_sms_log__c where Survey_URL__c !=null and entiTy__c ='AMFS' limit 2];
    
    /*Sync DEV*/
    List<Email_SMS_Log__c> scope1 = [select ready_to_send__c, mobile__c, entity__c, email_text__c, Survey_URL__c, Status_Deliver__c, messageid_jatis__C from email_sms_log__c where  Survey_URL__c !=null and entiTy__c ='AFI' limit 2];
    
    List<Email_SMS_Log__c> scope3 = [select ready_to_send__c, mobile__c, entity__c, email_text__c, Survey_URL__c, Status_Deliver__c, messageid_jatis__C from email_sms_log__c where  Survey_URL__c !=null and entiTy__c ='AMFS' limit 2];    
 	System.debug('[?] scope3 size data = '+scope3.size());
    String q = 'select ready_to_send__c, mobile__c, entity__c, email_text__c, Status_Deliver__c, Survey_URL__c, messageid_jatis__C from email_sms_log__c where  Survey_URL__c !=null limit 4';

        
    Database.BatchableContext BC;
    BitlyBatch obj01 = new BitlyBatch(q);
    //obj01.execute(BC, scope1);
    //obj01.execute(BC, scope2);
	Test.setMock(HttpCalloutMock.class, new BitlyBatch_TestMock());
    test.startTest();    
    obj01.execute(BC, scope1);
    obj01.execute(BC, scope3);
    Database.executeBatch(obj01, 10);
    test.stopTest();    
    }  
   
}