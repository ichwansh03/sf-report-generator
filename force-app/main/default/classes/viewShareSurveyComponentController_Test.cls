@isTest(seeAllData = true)
public class viewShareSurveyComponentController_Test {
    public static testmethod void viewShareSurveyComponentTest() {
        Test.startTest();
        String CHATTER = 'Chatter';
        String EMAIL_ANON = 'Email Link, Anonymous';
        String EMAIL_CONTACT_MERGE = 'Email Link w/ Contact Merge';
        String EMAIL_CONTACT_CASE_MERGE = 'Email Link w/ Contact & Case Merge';
        String EMPTY = 'EMPTY';
        String INTERNAL = 'Internal';
        String NO_POD = 'NO_POD';
        String PUBLIC_SURVEY = 'Public_Survey';
        String SALESFORCE = 'salesforce';
        String SELECT_SITE = '--SELECT SITE--';
        String SURVEY_PUBLIC_SITE = 'survey';
        String TAKE_SURVEY_VF = 'TakeSurvey';
        String VISUAL = 'visual';
        String OTHER = 'Other';
        
        Survey__c survey = new Survey__c();
        survey.Status__c = 'Open';
        survey.Survey_Type__c = 'I Ask';
        survey.Submit_Response__c = 'empty';
        insert survey;
        
        viewShareSurveyComponentController controller = new viewShareSurveyComponentController();
        controller.surveyId = survey.Id;
        
        controller.selectedURLType = EMAIL_ANON;
        controller.surveySite = SELECT_SITE;
        System.assertEquals('id=' + survey.Id + '&cId=none&caId=none', controller.surveyURL);
        System.assertEquals(null, controller.surveyURLBase);
        
        controller.selectedURLType = EMAIL_ANON;
        controller.surveySite = INTERNAL;
        System.assertEquals('id=' + survey.Id + '&cId=none&caId=none', controller.surveyURL);
        System.assertEquals(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/' + TAKE_SURVEY_VF + '?', controller.surveyURLBase);
        
        controller.selectedURLType = EMAIL_ANON;
        controller.surveySite = SURVEY_PUBLIC_SITE;
        Site site = [SELECT GuestUserId FROM Site WHERE UrlPathPrefix = :SURVEY_PUBLIC_SITE LIMIT 1];
        String path = '/sites/servlet.SiteDebugMode';
        Blob content = Blob.valueOf('URL=http://crm-axaindonesia.cs5.force.com/survey/sites/servlet.SiteDebugMode?sitedebugmode=x&amp;rand=85071');
        String url1 = content.toString().substringAfter('URL=').substringBefore(path);
        System.assertEquals('id=' + survey.Id + '&cId=none&caId=none', controller.surveyURL);
        System.assertEquals(url1 + '/' + TAKE_SURVEY_VF + '?', controller.surveyURLBase);
        
        controller.selectedURLType = EMAIL_CONTACT_MERGE;
        System.assertEquals('id=' + survey.Id + '&cId={!Contact.Id}&caId=none', controller.surveyURL);
        
        controller.selectedURLType = OTHER;
        System.assertEquals('id=' + survey.Id +  '&cId={!Contact.Id}&caId={!Case.id}', controller.surveyURL);
        
        controller.surveySite = INTERNAL;
        controller.surveySite = SURVEY_PUBLIC_SITE;
        controller.setupDomainForSurvey(NO_POD);
        controller.checkSubdomain(null);
        controller.checkSubdomain('developer-edition');
        controller.checkSubdomain(OTHER);
        controller.setupUrlPrefix(null);
        controller.setupUrlPrefix(OTHER);
        Test.stopTest();
    }
}