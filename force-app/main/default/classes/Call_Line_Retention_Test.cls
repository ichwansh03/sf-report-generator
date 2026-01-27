@isTest (seealldata=true)
private class Call_Line_Retention_Test{
  static testMethod void test_toggleSort_UseCase1(){
    Call_Line_Retention obj01 = new Call_Line_Retention();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.toggleSort();
      obj01.getBlock_Size();
      obj01.getCall_Status_config();
      obj01.getReason_Status_Config();
      obj01.getOwner_Call();
      obj01.getcases_Call();
  }
  static testMethod void test_fetch_UseCase1(){
    Call_Line_Retention obj01 = new Call_Line_Retention();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.fetch();
  }
  static testMethod void test_getListCall_UseCase1(){
    Call_Line_Retention obj01 = new Call_Line_Retention();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getListCall();
  }
  static testMethod void test_UpdateCallLine_UseCase1(){
    Call_Line_Retention obj01 = new Call_Line_Retention();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.UpdateCallLine();
  }
  
  static testMethod void test_getBlock_Size_UseCase1(){
    Call_Line_Retention obj01 = new Call_Line_Retention();
    obj01.idparam = 'test data';
    obj01.index = 10;
    obj01.blockSize = 10;
    obj01.totalRecs = 10;
    obj01.pro = new Profile();
    obj01.SOQL = 'test data';
    obj01.sortDir = 'test data';
    obj01.sortField = 'test data';
    obj01.fetchCalled = false;
    obj01.getBlock_Size();
      obj01.getnxt();
      obj01.beginning();
      obj01.end();
      obj01.previous();
      obj01.getprev();
      obj01.next();
  }
  
}