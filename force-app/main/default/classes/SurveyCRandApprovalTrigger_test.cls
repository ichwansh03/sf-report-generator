@isTest(seeAllData = true)
class SurveyCRandApprovalTrigger_test {

   static testmethod void test() {
   Test.startTest();
      Survey__c ip = new Survey__c();

      RecordType rt = [SELECT id FROM RecordType WHERE DeveloperName = 'Change_Request' and SobjectType = 'Survey__c'];      

      ip.name = 'test survey';
      ip.RecordTypeId = rt.id;
      ip.Submit_Response__c = 'empty';
      ip.Survey_Type__c = 'I Ask';
      ip.Status__c = 'Active';
      insert ip;
 

        Survey_Question__c newipc = new Survey_Question__c(
            name = 'testing question',
            Survey__c = ip.id,
            Choices__c = 'choices',
            OrderNumber__c = 1,
            Question__c = 'testing'
    
        );
        insert newipc;
    
     
    // ParameterChangeRequest
      ip.Change_Request__c = TRUE;
      update ip;
        
      Survey__c ip2 = [SELECT id, Status__c FROM Survey__c WHERE Master_Survey__c =: ip.id];
      
    // ParameterApproved
      ip2.Status__c = 'Approved';
      update ip2;
   Test.stopTest();

   }
}