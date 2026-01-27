public without sharing class ViewSurveyLiveChatController {
/* 
 * Controller associated with pages rendering the survey.
 * Used by SurveyPage, ResultsPage, TakeSurvey
 * 
 * Used by public site survey, therefore:
 * old: global virtual with sharing
 * new: public without sharing
 */
    public List<SelectOption> singleOptions {get; set;} 
    public List<SelectOption> anonymousOrUser {get;set;}  
    public List<question> allQuestions {get; set;}
    public List<String> responses {get; set;}
    public List<String> newOrder {get;set;}
    public String qQuestion {get; set;}
    public Boolean qRequired {get; set;}
    public String qChoices {get; set;}
    public String surveyName {get; set;}
    public String surveyHeader {get; set;}
    public String renderSurveyPreview {get; set;}  
    public String questionName {get; set;}  
    public String questionType {get; set;}
    public Boolean questionRequired {get; set;}
    public Integer allQuestionsSize {get; set;}
    public String templateURL {get; set;}
    public String surveyThankYouText {get; set;}
    public String surveyContainerCss {get; set;}
    public String surveyThankYouURL {get; set;}
    public String caseId {get; set;}
    public String contactId {get;set;}
    public String EmailSMSLogId {get;set;}
    public String NonCCCId {get;set;}
    public String anonymousAnswer {get;set;}
    public Boolean isInternal {get;set;}
    public String baseURL {get;set;}
    public String userId {get;set;}
    public String AnswerCount {get;set;}
    public String userName{get;set;}
    public String surveyTakerId {get;set;}
    public Boolean thankYouRendered{get;set;}
    public Boolean isAnswerImage{get;set;}

    public Integer checksoql{get;set;}
    public Profile PFirst {get;set;}
    public List<Survey__c> surveyListFirst {get;set;}
    
    public Integer ansImageIndex1{get;set;}
    public Integer ansImageIndex2{get;set;}
    public Integer ansImageIndex3{get;set;}
    public Integer ansImageIndex4{get;set;}
    public Integer ansImageIndex5{get;set;}
    public Integer ansImageIndex6{get;set;}
    public Integer ansImageIndex7{get;set;}
    public Integer ansImageIndex8{get;set;}
    public Integer ansImageIndex9{get;set;}
    public Integer ansImageIndex10{get;set;}
    public Integer ansImageIndex11{get;set;}
    public String imgURL1{get; set;}
    public String imgURL2{get; set;}
    public String imgURL3{get; set;}
    public String imgURL4{get; set;}
    public String imgURL5{get; set;}
    public String imgURL6{get; set;}
    public String imgURL7{get; set;}
    public String imgURL8{get; set;}
    public String imgURL9{get; set;}
    public String imgURL10{get; set;}
    public String imgURL11{get; set;}
    public String FormatSkala{get; set;}
    
    private static final String ACTIVE = 'Active';
    private static final String ANONYMOUS = 'Anonymous';
    private static final String NOT_ANONYMOUS = 'Not Anonymous';
    private static final String ERROR_REQUIRED_MSG = 'Please fill out all required fields';
    private static final String ERROR_NO_QUESTION = 'Question is empty';
    private static final String GUEST = 'Guest';
    private static final String ICF = 'ICF';
    private static final String I_ASK = 'I Ask';
    private static final String I_BUY = 'I Buy';
    private static final String I_CLAIM = 'I Claim';
    private static final String I_COMPLAIN = 'I Complain';
    private static final String I_RENEW = 'I Renew';
    private static final String MASTER_FEEDBACK = 'Master - Feedback';
    private static final String MASTER_EMAIL_SMS = 'Master - Email & SMS';
    private static final String NO_RESPONSE = 'NO RESPONSE';
    private static final String NONE = 'none';
    private static final String RESULT_PAGE_VF = 'ResultsPage';
    private static final String USER = 'User';
    private static final String IMAGE = 'Image';
    
    public String surveyId {
        get;
        set {
            this.surveyId = value;
            init();
        }
    }
    
    /* 
     * Retrieves the list of questions, the survey name, after retrieving the necessary parameters from the url.
     */ 
    //------------------------------------------------------------------------------// 
    public ViewSurveyLiveChatController(ApexPages.StandardController stdController) {
        if (checksoql == NULL) checksoql = 0;
        else checksoql += 1;
system.debug('104 - checksoql : '+ checksoql);
        // Get url parameters
        surveyId = Apexpages.currentPage().getParameters().get('id');
        caseId = Apexpages.currentPage().getParameters().get('caId');
        contactId = Apexpages.currentPage().getParameters().get('cId'); 

        EmailSMSLogId = Apexpages.currentPage().getParameters().get('eId'); 
        NonCCCId = Apexpages.currentPage().getParameters().get('nonId'); 
        
        if(caseId == null || caseId.length() < 5){
            caseId = NONE;
        }
        if(contactId == null || contactId.length() < 5){
            contactId = NONE;
        }
        if(EmailSMSLogId == null || EmailSMSLogId.length() < 5){
            EmailSMSLogId = NONE;
        }
        if(NonCCCId == null || NonCCCId.length() < 5){
            NonCCCId = NONE;
        }
        
        // By default the preview is not showing up
        renderSurveyPreview = 'false';
        init();
    }
    
    public ViewSurveyLiveChatController(viewShareSurveyComponentController controller) {
        if (checksoql == NULL) checksoql = 0;
        else checksoql += 1;
system.debug('141 - checksoql : '+ checksoql);

        surveyId = Apexpages.currentPage().getParameters().get('id');
        caseId = Apexpages.currentPage().getParameters().get('caId');
        contactId = Apexpages.currentPage().getParameters().get('cId'); 

        EmailSMSLogId = Apexpages.currentPage().getParameters().get('eId'); 
        NonCCCId = Apexpages.currentPage().getParameters().get('nonId'); 
        
        if(caseId == null || caseId.length() < 5) {
            caseId = NONE;
        }
        if(contactId == null || contactId.length() < 5) {
            contactId = NONE;
        }
        if(EmailSMSLogId == null || EmailSMSLogId.length() < 5){
            EmailSMSLogId = NONE;
        }
        if(NonCCCId == null || NonCCCId.length() < 5){
            NonCCCId = NONE;
        }
        // By default the preview is not showing up
        renderSurveyPreview = 'false';
        init();
    }
    
    public void init() {
        if (surveyId != null) {
            // Retrieve all necessary information to be displayed on the page
            allQuestions = new List<question>();
            setupQuestionList();
            setSurveyNameAndThankYou(surveyId);
            anonymousOrUser = new List<SelectOption>();
            anonymousOrUser.add(new SelectOption(ANONYMOUS, System.Label.LABS_SF_Anonymous));
            anonymousOrUser.add(new SelectOption(USER,'User: ' + UserInfo.getFirstName() + ' ' + UserInfo.getLastName()));
            anonymousAnswer = ANONYMOUS;
            isInternal = true;
            newOrder = new List<String>();
            String urlBase = URL.getSalesforceBaseUrl().toExternalForm();
            baseURL = urlBase;
            userId = UserInfo.getUserId();
            userName = UserInfo.getName();
            
            //String profileId = UserInfo.getProfileId();
            try {
                //Profile p = [select Id, UserType from Profile where Id=:profileId]; // PFirst; //
system.debug('196 - Non checksoql : '+ checksoql + ' UserInfo.getUserType : '+UserInfo.getUserType());
                String PUserType = UserInfo.getUserType();
                
                if (PUserType == GUEST) { //p.UserType
                    isInternal = false;
                }
                else {
                    isInternal = true;
                }
            }
            catch (Exception e) {
                isInternal = false;
            }
            
            thankYouRendered = false;
            
            List<Survey__c> surveyList = [SELECT Id, Answer_Count__c FROM Survey__c WHERE Id = :surveyId];

            DescribeSObjectResult describeResultSurvey = Survey__c.getSObjectType().getDescribe();
            List<String> surveyFieldList = new List<String>(describeResultSurvey.fields.getMap().keySet());
            String surveyFields = String.join(surveyFieldList, ',');
            String surveyQuery = ' SELECT ' + surveyFields + ' FROM Survey__c WHERE Id = :surveyId ';
            Survey__c surveyCheck = null;
            if (surveyList.size() > 0) {
                AnswerCount = surveyList[0].Answer_Count__c;
                surveyCheck = Database.query(surveyQuery);
checksoql += 1;
system.debug('209 - checksoql : '+ checksoql);

            }
            
            isAnswerImage = false;
            if (surveyCheck != null) {
                if ((IMAGE).equals(surveyCheck.Answer_Type__c)) {
                    isAnswerImage = true;
                }
                if (surveyCheck.Format_Skala__c == '10 to 0')
                    FormatSkala = 'true';
                else 
                    FormatSkala = 'false';
            }
            
            ansImageIndex1 = 0;
            ansImageIndex2 = 1;
            ansImageIndex3 = 2;
            ansImageIndex4 = 3;
            ansImageIndex5 = 4;
            ansImageIndex6 = 5;
            ansImageIndex7 = 6;
            ansImageIndex8 = 7;
            ansImageIndex9 = 8;
            ansImageIndex10 = 9;
            ansImageIndex11 = 10;
            
            if (surveyCheck != null) {
                if (surveyCheck.Answer_Image_1__c != null) {
                    String url1 = 'data:image;base64,' + surveyCheck.Answer_Image_1__c;
                    imgURL1 = url1;
                }
                if (surveyCheck.Answer_Image_2__c != null) {
                    String url2 = 'data:image;base64,' + surveyCheck.Answer_Image_2__c;
                    imgURL2 = url2;
                }
                if (surveyCheck.Answer_Image_3__c != null) {
                    String url3 = 'data:image;base64,' + surveyCheck.Answer_Image_3__c;
                    imgURL3 = url3;
                }
                if (surveyCheck.Answer_Image_4__c != null) {
                    String url4 = 'data:image;base64,' + surveyCheck.Answer_Image_4__c;
                    imgURL4 = url4;
                }
                if (surveyCheck.Answer_Image_5__c != null) {
                    String url5 = 'data:image;base64,' + surveyCheck.Answer_Image_5__c;
                    imgURL5 = url5;
                }
                if (surveyCheck.Answer_Image_6__c != null) {
                    String url6 = 'data:image;base64,' + surveyCheck.Answer_Image_6__c;
                    imgURL6 = url6;
                }
                if (surveyCheck.Answer_Image_7__c != null) {
                    String url7 = 'data:image;base64,' + surveyCheck.Answer_Image_7__c;
                    imgURL7 = url7;
                }
                if (surveyCheck.Answer_Image_8__c != null) {
                    String url8 = 'data:image;base64,' + surveyCheck.Answer_Image_8__c;
                    imgURL8 = url8;
                }
                if (surveyCheck.Answer_Image_9__c != null) {
                    String url9 = 'data:image;base64,' + surveyCheck.Answer_Image_9__c;
                    imgURL9 = url9;
                }
                if (surveyCheck.Answer_Image_10__c != null) {
                    String url10 = 'data:image;base64,' + surveyCheck.Answer_Image_10__c;
                    imgURL10 = url10;
                }
                if (surveyCheck.Answer_Image_11__c != null) {
                    String url11 = 'data:image;base64,' + surveyCheck.Answer_Image_11__c;
                    imgURL11 = url11;
                }
            }
        }
    }
    
    /* 
     * Called during the setup of the page. Retrieve questions and responses from DB and inserts them in 2 lists.
     */
    public Integer setupQuestionList() {
        getAQuestion();
        return allQuestions.size();
    }
    
   /*  
    * Sets the survey's name variable
    * param: sID   The survey ID as specified in the DB
    */
    public void setSurveyNameAndThankYou(String sId) {
        List<Survey__c> surveyList = [SELECT Name, Id, URL__c, Thank_You_Text__c, thankYouText__c, thankYouLink__c, Survey_Header__c, Survey_Container_CSS__c FROM Survey__c WHERE Id =:sId];
checksoql += 1;
system.debug('300 - checksoql : '+ checksoql);

        if (surveyList.size() > 0) {
            Survey__c s = surveyList[0];
            surveyName = s.Name;
            surveyHeader = s.Survey_Header__c;
            templateURL = s.URL__c+'id='+sId;//+'&cId={!Contact.Id}'+'&caId='+'{!Case.id}';
            surveyThankYouText = s.Thank_You_Text__c;
            if (surveyThankYouText == null) {
                surveyThankYouText = System.Label.LABS_SF_Survey_Submitted_Thank_you;
            }
            surveyThankYouURL = s.thankYouLink__c;
            surveyContainerCss = s.Survey_Container_CSS__c;
        }
    }
     
    /*
     * When requested from the page - 
     * when the user clicks on 'Update Order' -this function will reorganize the list so that it is displayed in the new order
     */
    public Pagereference refreshQuestionList(){
        setupQuestionList();
        return null;
    }
    
    /*
     * Redirects the page that displays the detailed results of the survey, from all users who took the survey.
     */
    public PageReference resultPage() {
        return new PageReference('/apex/' + RESULT_PAGE_VF + '?id=' + surveyId);
    }
    
    public List<String> getResponses() {
        List<SurveyQuestionResponse__c> qr = [Select Survey_Question__c, SurveyTaker__c, Response__c, Name From SurveyQuestionResponse__c limit 100];
checksoql += 1;
system.debug('334 - checksoql : '+ checksoql);

        List<String> resp = new List<String>();
        for (SurveyQuestionResponse__c r : qr) {
            resp.add(r.Response__c);
        }
        return resp;
    }  
    
    /*
     * Class: question
     * Retrieves the question information and puts it in the question object
     */ 
    public class question implements Comparable {
        public List<SelectOption> singleOptions {get; set;}
        public List<SelectOption> multiOptions {get; set;}
        public List<SelectOption> rowOptions {get; set;}
        public List<String> selectedOptions {get;set;}
        public List<String> responses {get; set;}
        public List<String> strList {get; set;} // The question's option as a list of string
        public List<Integer> resultsCounts {get; set;} // The count of each response to a question's choices
        public String name {get; set;}
        public String id {get; set;}
        public String question {get; set;}
        public String questionTranslate {get; set;}
        public String orderNumber {get; set;}
        public String choices {get; set;}
        public String selectedOption {get;set;}
        public Boolean required {get; set;}
        public String questionType {get; set;}
        public String surveyName {get; set;}
        public String renderFreeText {get; set;}
        public String renderSelectRadio {get; set;}
        public String renderSelectCheckboxes {get; set;}
        public String renderSelectRow {get; set;}
        public String singleOptionsForChart {get; set;}
        public String qResultsForChart {get; set;}
        public boolean noData {get; set;}
        
        private final String MULTI_SELECT_VERTICAL = 'Multi-Select--Vertical';
        private final String SINGLE_SELECT_VERTICAL = 'Single Select--Vertical';
        private final String SINGLE_SELECT_HORIZONTAL = 'Single Select--Horizontal';
        private final String FREE_TEXT = 'Free Text';
        
        /*
         * Fills up the question object
         * param:    Survey_Question__c 
         */ 
        public question(Survey_Question__c sq) {
            name = sq.Name;
            id = sq.Id;
            question = sq.Question__c;
            orderNumber = String.valueOf(sq.OrderNumber__c+1);
            choices = sq.Choices__c;
            required = sq.Required__c;
            questionType = sq.Type__c;
            singleOptionsForChart = ' ';
            selectedOption = '';
            selectedOptions = new List<String>();
            
            /*
             * split the question using new line character
             */
            if (sq.Question__c != null) {
                List<String> qArr = sq.Question__c.split('\n');
                if (qArr.size() > 1) {
                    question = qArr[0];
                    questionTranslate = qArr[1];
                }
            }
            
            if (sq.Type__c == SINGLE_SELECT_VERTICAL) {
                renderSelectRadio='true';
                singleOptions = stringToSelectOptions(choices);
                renderSelectCheckboxes='false';
                renderFreeText='false';
                renderSelectRow = 'false';
                selectedOption = '';
                selectedOptions = new List<String>();
            }
            else if (sq.Type__c == MULTI_SELECT_VERTICAL) {        
                renderSelectCheckboxes='true';
                multiOptions = stringToSelectOptions(choices);
                renderSelectRadio='false';
                renderFreeText='false';
                renderSelectRow = 'false';
                selectedOption = '';
                selectedOptions = new List<String>();
            }
            else if (sq.Type__c == SINGLE_SELECT_HORIZONTAL) {   
                renderSelectCheckboxes='false';
                rowOptions = stringToSelectOptions(choices);
                renderSelectRadio='false';
                renderFreeText='false';
                renderSelectRow = 'true';
                selectedOption = '';
                selectedOptions = new List<String>();     
            }
            else if (sq.Type__c == FREE_TEXT) {
                renderFreeText='true';
                renderSelectRadio='false';
                renderSelectCheckboxes='false';
                renderSelectRow = 'false';
                choices='';
            }
            //responses= getResponses();
        }
      
        /** Splits up the string as given by the user and adds each option
        *  to a list to be displayed as option on the Visualforce page
        *  param: str   String as submitted by the user
        *  returns the List of SelectOption for the visualforce page
        */  
        private List<SelectOption> stringToSelectOptions(String str) {
            if (str == '') {
                return new List<SelectOption>();
            }
            strList = str.split('\n');
            List<SelectOption> returnVal = new List<SelectOption>();
            Integer i = 0;
            
            for (String s : strList) {
                if (s != '') {
                    if (s != 'null' && s != null) {
                        String sBis = s.replace(' ', '%20');
                        singleOptionsForChart += s.trim()+'|';
                        
                        /*RSC2012-02-20
                        String st = s.replace (' ', '&nbsp;');
                        returnVal.add(new SelectOption(String.valueOf(i),st));
                        */
                        returnVal.add(new SelectOption(String.valueOf(i),s));
                        System.debug(LoggingLevel.DEBUG, '*****VALUES: ' + s);
                        i++;
                    }
                }
            }
            singleOptionsForChart = singleOptionsForChart.substring(0, singleOptionsForChart.length()-1);
            return returnVal;
        }
        
        public Integer compareTo(Object obj) {
            question qObj = (question) obj;
            
            Integer result = 0;
            if (this.orderNumber > qObj.orderNumber) {
                return 1;
            }
            else if (this.orderNumber < qObj.orderNumber) {
                return -1;
            }
            return result;
        }
    }
    
    /*
     * Fills up the List of questions to be displayed on the Visualforce page
     */
    public List<question> getAQuestion() {
        qQuestion = '';
        qChoices = '';
        List<Survey_Question__c> allQuestionsObject = 
                                        [Select s.Type__c, s.Id, s.Survey__c, s.Required__c, 
                                        s.Question__c, 
                                        s.OrderNumber__c, s.Name, s.Choices__c 
                                        From Survey_Question__c s 
                                        WHERE s.Survey__c =: surveyId ORDER BY s.OrderNumber__c];
checksoql += 1;
system.debug('503 - checksoql : '+ checksoql);

        allQuestions = new List<question>();
        
        Double old_OrderNumber = 0;
        Double new_OrderNumber;
        Double difference = 0;
        /* Make sure that the order number follow each other (after deleting a question, orders might not do so) */
        for (Survey_Question__c q : allQuestionsObject){ 
            new_OrderNumber = q.OrderNumber__c;
            difference = new_OrderNumber - old_OrderNumber - 1;
            if (difference > 0) {
                Double dd = double.valueOf(difference);
                Integer newOrderInt = dd.intValue();
                q.OrderNumber__c -= Integer.valueOf(newOrderInt); 
            }
            old_OrderNumber = q.OrderNumber__c;
            question theQ = new question(q);
            if (theQ.renderSelectRadio == 'TRUE') theQ.selectedOption = '4';
            allQuestions.add(theQ);
        }
        allQuestionsSize = allQuestions.size();
        return allQuestions;
    }
    
    /*
     * Rival - 2016/12/15 - API: 23
     * Fix survey response table structure. Save it as 1 row per survey, not per question
     * Object to store: Survey_Response__c
     */ 
    public void submitResults() {
        Survey_Response__c responseObj = new Survey_Response__c();
        allQuestions.sort();
        Integer seq = 1;
        
        if (allQuestions.size() < 1) {
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ERROR_NO_QUESTION));
            return;
        }
        
        for (question q : allQuestions) {
            System.debug(LoggingLevel.DEBUG, '*** QUESTIONS: ' + q.orderNumber + '. ' + q.question);
            String qNameFieldStr = 'Question_' + seq + '__c';
            String answerFieldStr = 'Answer_' + seq + '__c';
            String questionFieldStr = 'Question_Id_' + seq + '__c';
            String answerIdxFieldStr = 'Answer_Index_' + seq + '__c';
            
            //SINGLE SELECT VERTICAL
            if (q.renderSelectRadio == 'true') {
                System.debug(LoggingLevel.ERROR, '***SINGLE SELECT VERTICAL: ' + q.required + ' ' + q.selectedOption);
                if (q.required &&  (q.selectedOption == null || q.selectedOption == '')) {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ERROR_REQUIRED_MSG));
                    return;
                }
                
                if (q.selectedOption == null || q.selectedOption == '') {
                    responseObj.put(answerFieldStr, '');
                }
                else {
                    responseObj.put(answerFieldStr, q.singleOptions.get(Integer.valueOf(q.selectedOption)).getLabel());
                    responseObj.put(answerIdxFieldStr, q.selectedOption);
                }
                responseObj.put(questionFieldStr, q.Id);
                responseObj.put(qNameFieldStr, q.question);
                responseObj.Survey__c = surveyId;
            }
            //FREE TEXT
            else if (q.renderFreeText == 'true') {
                System.debug(LoggingLevel.ERROR, '***FREE TEXT: ' + q.required + ' ' + q.choices);
                if (q.required && q.choices == '') {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ERROR_REQUIRED_MSG));
                    return;
                }
                System.debug(LoggingLevel.DEBUG, '*****FREE TEXT ' + q.choices);
                
                responseObj.put(answerFieldStr, q.choices);
                responseObj.put(questionFieldStr, q.Id);
                responseObj.put(qNameFieldStr, q.question);
                responseObj.Survey__c = surveyId;
            }
            //MULTI SELECT VERTICAL
            else if (q.renderSelectCheckboxes == 'true') {
                System.debug(LoggingLevel.ERROR, '***MULTI SELECT VERTICAL: ' + q.required + ' ' + q.selectedOptions);
                if (q.required && (q.selectedOptions == null || q.selectedOptions.size() == 0)) {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ERROR_REQUIRED_MSG));
                    return;
                }
                                
                List<String> valueList = new List<String>();
                for (String s : q.selectedOptions) {
                    valueList.add(q.multiOptions.get(Integer.valueOf(s)).getLabel());
                }
                String value = String.join(valueList, ';');
                String valueIdx = String.join(q.selectedOptions, ';');
                
                responseObj.put(answerFieldStr, value);
                responseObj.put(questionFieldStr, q.Id);
                responseObj.put(qNameFieldStr, q.question);
                responseObj.put(answerIdxFieldStr, valueIdx);
                responseObj.Survey__c = surveyId;
            }
            //SINGLE SELECT HORIZONTAL
            else if (q.renderSelectRow == 'true') {
                System.debug(LoggingLevel.ERROR, '***SINGLE SELECT HORIZONTAL: ' + q.required + ' ' + q.selectedOption);
                if (q.required && (q.selectedOption == null || q.selectedOption == '')) {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ERROR_REQUIRED_MSG));
                    return;
                }
                
                if (q.selectedOption == null || q.selectedOption == '') {
                    responseObj.put(answerFieldStr, '');
                }
                else {
                    String ansIndex = q.selectedOption;
                    //swap negative
                    /*
                    if (ansIndex == '0') {
                        ansIndex = '4';
                    }
                    else if (ansIndex == '1') {
                        ansIndex = '3';
                    }
                    else if (ansIndex == '3') {
                        ansIndex = '1';
                    }
                    else if (ansIndex == '4') {
                        ansIndex = '0';
                    }
                    */

                    //change negative to the right side
                    if (AnswerCount == '10 Answer') {
                        if (ansIndex == '0') ansIndex = label.ICF_Ans_00; //5; //5;
                        else if (ansIndex == '1') ansIndex = label.ICF_Ans_01; //4; //5;
                        else if (ansIndex == '2') ansIndex = label.ICF_Ans_02; //4; //4;
                        else if (ansIndex == '3') ansIndex = label.ICF_Ans_03; //4; //4;
                        else if (ansIndex == '4') ansIndex = label.ICF_Ans_04; //3; //3;
                        else if (ansIndex == '5') ansIndex = label.ICF_Ans_05; //3; //3;
                        else if (ansIndex == '6') ansIndex = label.ICF_Ans_06; //3; //2;
                        else if (ansIndex == '7') ansIndex = label.ICF_Ans_07; //2; //2;
                        else if (ansIndex == '8') ansIndex = label.ICF_Ans_08; //2; //1;
                        else if (ansIndex == '9') ansIndex = label.ICF_Ans_09; //1; //1;
                        else if (ansIndex == '10') ansIndex = label.ICF_Ans_10; //1; //1;
                    }

                    responseObj.put(answerIdxFieldStr, ansIndex);
                    responseObj.put(answerFieldStr, q.rowOptions.get(Integer.valueOf(q.selectedOption)).getLabel());
                }
                responseObj.put(questionFieldStr, q.Id);
                responseObj.put(qNameFieldStr, q.question);
                responseObj.Survey__c = surveyId;
            }
            seq++;
        }
        
        if(AddSurveyTaker()) {
            EmailSmsLogUtil emailSmsLogUtil = new EmailSmsLogUtil();
            ICF_Parameter__c icfParamFeedback = null;
            
            responseObj.SurveyTaker__c = surveyTakerId;
            icfParamFeedback = emailSmsLogUtil.getICFParamByRecordType(MASTER_FEEDBACK, null);
            
            Integer negativeQ = 1;
            Integer negativeA = 1;
            Boolean result = false;
            //question number
            String ansNumberField = 'Answer_Index_' + negativeQ + '__c';
            //index of answer
            Integer ans = Integer.valueOf(responseObj.get(ansNumberField));
            //change negative to the right side
            if (AnswerCount == '10 Answer') {
                if (ans == 0) ans = integer.valueof(label.ICF_Ans_00); //5; //5;
                else if (ans == 1) ans = integer.valueof(label.ICF_Ans_01); //4; //5;
                else if (ans == 2) ans = integer.valueof(label.ICF_Ans_02); //4; //4;
                else if (ans == 3) ans = integer.valueof(label.ICF_Ans_03); //4; //4;
                else if (ans == 4) ans = integer.valueof(label.ICF_Ans_04); //3; //3;
                else if (ans == 5) ans = integer.valueof(label.ICF_Ans_05); //3; //3;
                else if (ans == 6) ans = integer.valueof(label.ICF_Ans_06); //3; //2;
                else if (ans == 7) ans = integer.valueof(label.ICF_Ans_07); //2; //2;
                else if (ans == 8) ans = integer.valueof(label.ICF_Ans_08); //2; //1;
                else if (ans == 9) ans = integer.valueof(label.ICF_Ans_09); //1; //1;
                else if (ans == 10) ans = integer.valueof(label.ICF_Ans_10); //1; //1;
            }
            
            //index start from 0, using < instead of <=
            if (ans < negativeA) {
                result = true;
            }
            
            responseObj.Negative_Flag__c = result;
            responseObj.Negative_Question__c = '1';
            responseObj.Negative_Answer__c = '1';
                        
            // Taufik, 22 Mei 2019. Skip insert dari test.class
            if (!Test.isRunningTest()) insert responseObj;
            thankYouRendered = true;
        }
        else {
            thankYouRendered = false;
        }
    }
    
    private Boolean AddSurveyTaker() {
        String userId;
        
        if (surveyId == null) {
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid survey form'));
            return false;
        }
        else {
            List<Survey__c> surveyChecks = [SELECT Id FROM Survey__c WHERE Id = :surveyId];
checksoql += 1;
system.debug('739 - checksoql : '+ checksoql);

            if (surveyChecks.size() < 1) {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid parameters'));
                return false;
            }
        }
        
        system.debug('Contact id (726) : '+contactId); 
        if (contactId != null) {
            if(contactId.toUpperCase().equals('NONE') || contactId.length() < 5) {
                contactId = null;
                anonymousAnswer = ANONYMOUS;
            }
            else {
                anonymousAnswer = NOT_ANONYMOUS;
                List<Contact> contactChecks = [SELECT Id FROM Contact WHERE Id = :contactId];
checksoql += 1;
system.debug('787 - checksoql : '+ checksoql);

                if (contactChecks.size() < 1) {
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid parameters'));
                    return false;
                }
            }
        }
        system.debug('Contact id (741) : '+contactId);
        
        if (anonymousAnswer != null ? (!anonymousAnswer.equals(ANONYMOUS) ? true : false) : false) {
            userId = UserInfo.getUserId();
        }
        else {
            userId = null;
        }
        
        if (anonymousAnswer != ANONYMOUS && contactId != null ) {
            List<SurveyTaker__c> check = [Select Contact__c, Survey__c, Case__c, User__c From SurveyTaker__c Where Contact__c=:contactId and Survey__c=:surveyId and User__c=:userId];
checksoql += 1;
system.debug('807 - checksoql : '+ checksoql);

            if (check != null && check.size() > 0) {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.LABS_SF_You_have_already_taken_this_survey));
                return false;
            }

        }

                
        SurveyTaker__c st = new SurveyTaker__c();
        st.Contact__c = contactId != null ? Id.valueOf(contactId) : null;
        st.Survey__c = surveyId != null ? Id.valueOf(surveyId) : null;
        st.Taken__c = 'true';
        st.User__c = userId != null ? Id.valueOf(userId) : null;
                
        insert st;
        surveyTakerId = st.Id;
        
        return true; 
    }
}