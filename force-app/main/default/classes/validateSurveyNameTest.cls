@isTest
public class validateSurveyNameTest {
    public static testMethod void testValidateSurveyName(){
         List<Survey__c> surveyList = new List<Survey__c>();
         Survey__c sur1 = new Survey__c();
         sur1.name = 'test survey 1';
         sur1.Submit_Response__c = 'xx';
         surveyList.add(sur1);

         Survey__c sur2 = new Survey__c();
         sur2.name = 'test survey 2';
         sur2.Submit_Response__c = 'xx';
         surveyList.add(sur2);
         insert surveyList;

         try{
             List<Survey__c> newSurveyList = new List<Survey__c>();
             Survey__c sur3 = new Survey__c();
             sur3.name = 'test survey 3';
             sur3.Submit_Response__c = 'xx';
             newSurveyList.add(sur3);
    
             Survey__c sur4 = new Survey__c();
             sur4.name = 'test survey 2';
             sur4.Submit_Response__c = 'xx';
             newSurveyList.add(sur4);
             
             insert newSurveyList;
         } catch(DmlException e){
             string msg = e.getMessage();
             system.assert(msg.contains('Insert failed'));         
         }
    
    }
}