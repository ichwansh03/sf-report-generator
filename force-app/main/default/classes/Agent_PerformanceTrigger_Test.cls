@isTest
private class Agent_PerformanceTrigger_Test{
  static testMethod void test_Agent_PerformanceTrigger(){
   test.startTest();
      User_Detail__c ud = new User_Detail__c(name = UserInfo.getName(), user__c = userinfo.getUserId(), Entity__c = 'ALI' , Team__c = 'Reinstate');
      insert ud;
    Agent_Performance__c agent_performance_Obj = new Agent_Performance__c(name='nama', agent__c = userinfo.getUserId(),agent_detail__c = ud.id, document_date__c = date.today());
    Insert agent_performance_Obj; 
      update agent_performance_Obj;
   test.stopTest();
  }
}