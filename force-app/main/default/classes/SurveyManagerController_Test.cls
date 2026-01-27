@isTest(seeAllData = true)
public class SurveyManagerController_Test {
    public static testmethod void surveyManagerTest() {
        Test.startTest();
        String surveyManagerVF = '/apex/SurveyManagerPage';
        
        Survey__c survey = new Survey__c();
        survey.Status__c = 'Open';
        survey.Survey_Type__c = 'I Ask';
        survey.Submit_Response__c = 'empty';
        survey.Answer_Image_1__c = 'image1';
        survey.Answer_Image_2__c = 'image1';
        survey.Answer_Image_3__c = 'image1';
        survey.Answer_Image_4__c = 'image1';
        survey.Answer_Image_5__c = 'image1';
        survey.Answer_Image_6__c = 'image1';
        survey.Answer_Image_7__c = 'image1';
        survey.Answer_Image_8__c = 'image1';
        survey.Answer_Image_9__c = 'image1';
        survey.Answer_Image_10__c = 'image1';
        survey.Answer_Image_11__c = 'image1';
        insert survey;
        
        PageReference pageRef = new PageReference(surveyManagerVF);
        pageRef.getParameters().put('id', survey.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(survey);
        SurveyManagerController controller = new SurveyManagerController(sc);
        controller.refreshMasterSurvey();
        controller.getEditCSS();
        controller.save();
        
        Test.stopTest();
    }
}