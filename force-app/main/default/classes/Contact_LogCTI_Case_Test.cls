@isTest (seealldata = true)
private class Contact_LogCTI_Case_Test{
  static testMethod void test_getMappingAction_UseCase1(){
    Contact_LogCTI_Case obj01 = new Contact_LogCTI_Case();
    //obj01.listcs = new List<Case>();
    //obj01.listcti = new List<Log_CTI_Valdo__c>();
    //obj01.thisdate = Date.today();
    obj01.getMappingAction();
  }
}