@isTest (seealldata=true)
private class Search_LogCTI_Test{
  static testMethod void test_getDataLog_UseCase1(){
    Search_LogCTI obj01 = new Search_LogCTI();
    obj01.srclcti = new Log_CTI_Valdo__c();
    obj01.fromdate = Date.today();
    obj01.todate = Date.today();
    obj01.getDataLog();
  }
}