@isTest (seealldata=true)
private class Call_Line_Test{
  static testMethod void test_toggleSort_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.toggleSort();
      obj01.getOffering_pick();
      obj01.getStatus_Polis();
  }
  static testMethod void test_fetch_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.fetch();
  }
  static testMethod void test_getListCall_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'select id, name from call_line__c limit 100';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getListCall();
  }
  static testMethod void test_UpdateCallLine_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.UpdateCallLine();
  }
  static testMethod void test_getCampaignlist_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getCampaignlist();
  }
  static testMethod void test_getCallStatus_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getCallStatus();
  }
  static testMethod void test_getBlock_Size_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getBlock_Size();
  }
  static testMethod void test_beginning_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.beginning();
  }
  static testMethod void test_previous_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.previous();
  }
  static testMethod void test_next_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.next();
  }
  static testMethod void test_end_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.end();
  }
  static testMethod void test_getprev_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getprev();
  }
  static testMethod void test_getnxt_UseCase1(){
    Call_Line obj01 = new Call_Line();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.filcampname = 'test data';
    obj01.filcallstatus = 'test data';
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getnxt();
  }
}