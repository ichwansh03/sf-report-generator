@isTest(seeAllData = True)
private class DeliveryReport_Test{
 
  static testMethod void test_executemethod_UseCase1(){
      DescribeSObjectResult describeResultOpp = Email_SMS_Log__c.getSObjectType().getDescribe();
      List<String> oppFieldList = new List<String>(describeResultOpp.fields.getMap().keySet());
      String oppFields = String.join(oppFieldList, ',');
      String oppQuery = ' SELECT ' + oppFields + ' FROM Email_SMS_Log__c WHERE MessageId_JATIS__c != null limit 1';
    List<Email_SMS_Log__c> email_sms_log_Obj  =  Database.query(oppQuery);
   // System.assertEquals(true,email_sms_log_Obj.size()>0);
   Email_SMS_Log__c esl = new Email_SMS_Log__c();
      esl.User_ID__c = 'ASI';
      esl.Password__c = 'ASI789';
      esl.MessageId_JATIS__c = '001';
      esl.Status_Deliver__c = '1';
      insert esl;
    DeliveryReport obj01 = new DeliveryReport();
    obj01.userid = 'ASI';
    obj01.password = 'ASI789';
    obj01.sender = 'test data';
      //if(email_sms_log_Obj.size()>0 && email_sms_log_Obj!=null){obj01.messageid = email_sms_log_Obj[0].MessageId_JATIS__c;}
      //else {obj01.messageid = '1';}
    obj01.messageid = '001';
    obj01.deliverystatus = '1';
    obj01.datehit = '12/2/2014 10:40:49 AM';
    obj01.datereceived = '12/2/2014 10:40:49 AM';
    obj01.response = 'test data';
    obj01.listsms = email_sms_log_Obj;
    obj01.executemethod();
  }
}