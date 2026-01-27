@istest
public class NegativeFeedbackTriggerHandlerTest {
    @isTest
    static void negativeFeedback1() {
     	Test.StartTest();
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'testing';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master Qualtrics').getRecordTypeId();
        insert setSurvey;
        
        
        case setCase = new case();
            setCase.type = 'Inquiry';
            setcase.status ='new';
        insert setCase;
        
        Negative_Feedback__c setNegative = new Negative_Feedback__c();
            setNegative.Case__c = setCase.id;
            setNegative.Survey_Form__c  = setSurvey.id;
            setNegative.Entity__c = 'AMFS';
        insert setNegative;
        
        test.StopTest();
    }
}