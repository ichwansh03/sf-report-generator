@IsTest
private class ViewSurveyDynamicController_Test3 {

	@TestSetup
    static void setupTestData(){
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = userObj.Entity__c;
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest2';
        ac1.Entity__c = entity;
        insert ac1;
            
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.MobilePhone = '0891667363';
        contact1.Policy_No__c = '77700140';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Case closedCase1 = new Case();
        closedCase1.ContactId = contact1.Id;
        closedCase1.Type = 'Request';
        closedCase1.Status = 'Closed';
        closedCase1.Priority = 'Medium';
        closedCase1.Origin = 'Phone';
        closedCase1.Case_Type__c = 'Request_POS_Withdrawal Test';
        closedCase1.Case_Type_Config__c = 'Request_POS_Withdrawal Test' ;
        closedCase1.Subject = 'Case Subject';
        closedCase1.AccountId = contact1.AccountId;
        closedCase1.Entity_Backup__c = 'AFI';
        closedCase1.PIC_Department_LU__c = userObj.Id;
        closedCase1.CreatedDate = Date.today().addDays(-362);
        closedCase1.ClosedDate = Date.today().addDays(-360);
        insert closedCase1;
    }
    
    @IsTest
    static void viewSurveyTestExpired() {
        String viewSurveyVF = '/apex/TakeSurveyDynamic';
        String INQUIRY = 'Inquiry';
        String REQUEST = 'Request';
        String COMPLAINT = 'Complaint';
        String NEW_STATUS = 'New';
        String CLOSED = 'Closed';
        String MASTER_EMAIL_SMS = 'Master - Email & SMS';
        String MASTER_CCC = 'Master - CCC';
        String OPEN = 'Open';
        String ICF = 'ICF';
        String MULTI_SELECT_VERTICAL = 'Multi-Select--Vertical';
        String SINGLE_SELECT_VERTICAL = 'Single Select--Vertical';
        String SINGLE_SELECT_HORIZONTAL = 'Single Select--Horizontal';
        String FREE_TEXT = 'Free Text';
        Date todayDate = Date.today();
        
        Test.startTest();
        Contact contact = [SELECT Id FROM Contact WHERE Email = 'billgates@email.com' LIMIT 1];
        Case closedCase = [SELECT Id, ClosedDate, Entity_Backup__c FROM Case WHERE Type = 'Request' AND Entity_Backup__c = 'AFI' LIMIT 1];
        
        Survey__c survey = new Survey__c();
        survey.Name = 'Survey POS/Request';
        survey.Survey_Header__c = 'Header';
        survey.URL__c = 'http://crm-axaindonesia.cs5.force.com/survey/TakeSurveyDynamic?';
        survey.Thank_You_Text__c = null;
        survey.thankYouLink__c = 'http://www.salesforce.com';
        survey.Status__c = 'Open';
        survey.Survey_Type__c = 'I Buy';
        survey.Submit_Response__c = 'empty';
        survey.Answer_Image_1__c = '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';
        survey.Answer_Image_2__c = survey.Answer_Image_1__c;
        survey.Answer_Image_3__c = survey.Answer_Image_1__c;
        survey.Answer_Image_4__c = survey.Answer_Image_1__c;
        survey.Answer_Image_5__c = survey.Answer_Image_1__c;
        survey.Answer_Image_6__c = survey.Answer_Image_1__c;
        survey.Answer_Image_7__c = survey.Answer_Image_1__c;
        survey.Answer_Image_8__c = survey.Answer_Image_1__c;
        survey.Answer_Image_9__c = survey.Answer_Image_1__c;
        survey.Answer_Image_10__c = survey.Answer_Image_1__c;
        survey.Answer_Image_11__c = survey.Answer_Image_1__c;
        survey.Answer_Count__c = '10 Answer';
        insert survey;
        
        PageReference pageRef = new PageReference(viewSurveyVF);
        pageRef.getParameters().put('id', survey.Id);
        pageRef.getParameters().put('caId', closedCase.Id);
        pageRef.getParameters().put('cId', contact.Id);
        Test.setCurrentPage(pageRef);
        
        viewShareSurveyComponentController component = new viewShareSurveyComponentController();
        ViewSurveyDynamicController controllerWithComp = new ViewSurveyDynamicController(component);
        controllerWithComp.imgURL1 = '';
        controllerWithComp.imgURL2 = '';
        controllerWithComp.imgURL3 = '';
        controllerWithComp.imgURL4 = '';
        controllerWithComp.imgURL5 = '';
        controllerWithComp.imgURL6 = '';
        controllerWithComp.imgURL7 = '';
        controllerWithComp.imgURL8 = '';
        controllerWithComp.imgURL9 = '';
        controllerWithComp.imgURL10 = '';
        controllerWithComp.imgURL11 = '';
        
        controllerWithComp.surveyId = survey.Id;
        controllerWithComp.setupQuestionList();
        controllerWithComp.setSurveyNameAndThankYou(survey.Id);
        controllerWithComp.refreshQuestionList();
        controllerWithComp.resultPage();
        controllerWithComp.getResponses();
        controllerWithComp.getAQuestion();
        controllerWithComp.submitResults();
        controllerWithComp.passValueToController();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(survey);
        ViewSurveyDynamicController controller = new ViewSurveyDynamicController(sc);
        controller.surveyId = survey.Id;
        controller.setupQuestionList();
        controller.setSurveyNameAndThankYou(survey.Id);
        controller.refreshQuestionList();
        controller.resultPage();
        // controller.getResponses();
        controller.submitResults();
        
        Survey_Question__c sq1 = new Survey_Question__c();
        sq1.Name = 'Question Name1';
        sq1.Choices__c = 'Choices1';
        sq1.OrderNumber__c = 0;
        sq1.Question__c = 'Question1';
        sq1.Required__c = true;
        sq1.Survey__c = survey.Id;
        sq1.Type__c = MULTI_SELECT_VERTICAL;
        insert sq1;
        
        Survey_Question__c sq2 = new Survey_Question__c();
        sq2.Name = 'Question Name2';
        sq2.Choices__c = 'Choices2';
        sq2.OrderNumber__c = 1;
        sq2.Question__c = 'Question2';
        sq2.Required__c = true;
        sq2.Survey__c = survey.Id;
        sq2.Type__c = SINGLE_SELECT_VERTICAL;
        insert sq2;
        
        Survey_Question__c sq3 = new Survey_Question__c();
        sq3.Name = 'Question Name3';
        sq3.Choices__c = '0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10';
        sq3.OrderNumber__c = 2;
        sq3.Question__c = 'Question3';
        sq3.Required__c = true;
        sq3.Survey__c = survey.Id;
        sq3.Type__c = SINGLE_SELECT_HORIZONTAL;
        insert sq3;
        
        Survey_Question__c sq4 = new Survey_Question__c();
        sq4.Name = 'Question Name4';
        sq4.Choices__c = 'Choices4';
        sq4.OrderNumber__c = 3;
        sq4.Question__c = 'Question4';
        sq4.Required__c = true;
        sq4.Survey__c = survey.Id;
        sq4.Type__c = FREE_TEXT;
        insert sq4;
        
        
        Survey_Question__c sq5 = new Survey_Question__c();
        sq5.Name = 'Question Name5';
        sq5.Choices__c = '1\n2\n3\n4\n5';
        sq5.OrderNumber__c = 4;
        sq5.Question__c = 'Question5';
        sq5.Required__c = true;
        sq5.Survey__c = survey.Id;
        sq5	.Type__c = 'Star';
        insert sq5;
        
        ViewSurveyDynamicController.question innerQuestion1 = new ViewSurveyDynamicController.question(sq1);
        ViewSurveyDynamicController.question innerQuestion2 = new ViewSurveyDynamicController.question(sq2);
        ViewSurveyDynamicController.question innerQuestion3 = new ViewSurveyDynamicController.question(sq3);
        ViewSurveyDynamicController.question innerQuestion4 = new ViewSurveyDynamicController.question(sq4);
        ViewSurveyDynamicController.question innerQuestion5 = new ViewSurveyDynamicController.question(sq5);
        innerQuestion1.compareTo(innerQuestion2);
        
        controller.getAQuestion();
        controller.submitResults();
        
        List<ViewSurveyDynamicController.question> allQuestionList = new List<ViewSurveyDynamicController.question>();
        List<String> selectedQ1 = new List<String>();
        selectedQ1.add('0');
        innerQuestion1.selectedOptions = selectedQ1;
        allQuestionList.add(innerQuestion1);
        allQuestionList.add(innerQuestion2);
        allQuestionList.add(innerQuestion3);
        allQuestionList.add(innerQuestion4);
        controller.allQuestions = allQuestionList;
        controller.submitResults();
        
        String selectedQ2 = '0';
        innerQuestion2.selectedOption = selectedQ2;
        allQuestionList.clear();
        allQuestionList.add(innerQuestion1);
        allQuestionList.add(innerQuestion2);
        allQuestionList.add(innerQuestion3);
        allQuestionList.add(innerQuestion4);
        controller.allQuestions = allQuestionList;
        controller.submitResults();
        
        String selectedQ3 = '10';
        innerQuestion3.selectedOption = selectedQ3;
        allQuestionList.clear();
        allQuestionList.add(innerQuestion1);
        allQuestionList.add(innerQuestion2);
        allQuestionList.add(innerQuestion3);
        allQuestionList.add(innerQuestion4);
        controller.allQuestions = allQuestionList;
        controller.submitResults();
        
        String selectedQ4 = '10';
        innerQuestion4.choices = selectedQ4;
        allQuestionList.clear();
        allQuestionList.add(innerQuestion1);
        allQuestionList.add(innerQuestion2);
        allQuestionList.add(innerQuestion3);
        allQuestionList.add(innerQuestion4);
        controller.allQuestions = allQuestionList;
        controller.submitResults();
        Test.stopTest();
    }
}