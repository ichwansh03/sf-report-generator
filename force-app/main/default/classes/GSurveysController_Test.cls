@isTest(seeAllData = true)
public class GSurveysController_Test {
    public static testmethod void gSurveysControllerTest() {
        Test.startTest();
        String gSurveysVF = '/apex/GSurveys';
        String EMPTY = 'EMPTY';
		String INTERNAL = 'Internal';
		String PUBLIC_SURVEY = 'Public_Survey';
		String SELECT_SITE = '--SELECT SITE--';
		String SURVEY_MANAGER_PAGE_VF = 'SurveyManagerPage';
		String SURVEY_PUBLIC_SITE = 'survey';
		String TAKE_SURVEY_VF = 'TakeSurvey';
		String THANK_YOU_LINK_SF = 'http://www.salesforce.com';
		String THANK_YOU_LINK_AXA = 'http://www.axa.co.id';
        
        Survey__c survey = new Survey__c();
        survey.Status__c = 'Open';
        survey.Survey_Type__c = 'I Ask';
        survey.Submit_Response__c = 'empty';
        insert survey;
        
        PageReference pageRef = new PageReference(gSurveysVF);
        pageRef.getParameters().put('id', survey.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(survey);
        GSurveysController controller = new GSurveysController(sc);
        
        controller.makeNewSurvey();
        
        controller.newSurveyName = 'New Survey Name';
        controller.surveySite = SELECT_SITE;
        controller.makeNewSurvey();
        
        controller.newSurveyName = 'New Survey Name';
        controller.surveySite = INTERNAL;
        controller.makeNewSurvey();
        
        controller.newSurveyName = 'New Survey Name';
        controller.surveySite = SURVEY_PUBLIC_SITE;
        controller.makeNewSurvey();
        
        controller.doSurveyReset();
        GSurveysController.deleteSurvey(survey.Id);
        
        Test.stopTest();
    }
}