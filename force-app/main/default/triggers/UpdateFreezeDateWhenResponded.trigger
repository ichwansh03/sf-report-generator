trigger UpdateFreezeDateWhenResponded on Survey_Response__c (after insert) {
    EmailSmsLogUtil emailSmsLogUtil = new EmailSmsLogUtil();
    Date todayDate = Date.today();
    private static final String MASTER_EMAIL_SMS = 'Master - Email & SMS';
    private static final String MASTER_EMAIL_Qualtrics = 'Master - Qualtrics';
    private static final String INTERVAL_COMPLETE = 'MONTH';
    
    if(!CallLineTriggerControl.skipResponseTrigger && Trigger.isInsert){
        
        for (Survey_Response__c response : Trigger.new) {
            // taufik, hide, 22 Mei 2019, SOQL 101
            //Survey__c survey = emailSmsLogUtil.getSurveyById(response.Survey__c);
            //SurveyTaker__c st = emailSmsLogUtil.getSurveyTakerById(response.SurveyTaker__c);
            String surveyTakerId = response.SurveyTaker__c;
            
            DescribeSObjectResult describeResultSt = SurveyTaker__c.getSObjectType().getDescribe();
            List<String> stFieldList = new List<String>(describeResultSt.fields.getMap().keySet());
            String stFields = String.join(stFieldList, ',');
            
            String stQuery = ' SELECT Survey__c, Contact__c, Case__c, Survey__r.Survey_Type__c, Survey__r.name FROM SurveyTaker__c WHERE Id = :surveyTakerId ';
            SurveyTaker__c st = Database.query(stQuery);
            
            //2 oct 2025, survey claim not set freeze period
            Boolean surveyClaim = false;
            if(st.Survey__r.name == 'Survey Request I Claim Individu Reimbursement' || st.Survey__r.name == 'Survey Request I Claim Individu Cashless' ) surveyClaim = true;
            
            Survey__c survey = new Survey__c();
            survey.id = st.Survey__c;
            survey.Survey_Type__c = st.Survey__r.Survey_Type__c;
                
            if (st.Contact__c != null) {
                Contact contactObj = emailSmsLogUtil.getContactById(st.Contact__c);
                
                // added by Support MII at 16 04 24
                string RecordType = response.isQualtrics__c ? MASTER_EMAIL_Qualtrics : MASTER_EMAIL_SMS;
                
                system.debug('RecordType:'+RecordType);
                ICF_Parameter__c icfParam = emailSmsLogUtil.getICFParamByRecordType(RecordType, contactObj.Entity__c);
                
                
                system.debug('icfParam:'+icfParam);
                Integer intervalComplete = Integer.valueOf(icfParam.Interval_Completed_Month__c != null ? icfParam.Interval_Completed_Month__c : '1');
                
                if (icfParam.Extend_Freeze_Date_When_Responded__c && !surveyClaim) {
                    emailSmsLogUtil.updateContactFreezeDate(contactObj, todayDate, intervalComplete, survey.Survey_Type__c, INTERVAL_COMPLETE);
                }
                
                contactObj.Last_Answer__c = response.Answer_1__c;
                contactObj.Last_Answer_Index__c = response.Answer_Index_1__c;
                contactObj.Last_Case__c = st.Case__c;
                contactObj.Last_Response_Date__c = response.CreatedDate.date();
                contactObj.Last_Survey_Type__c = survey.Survey_Type__c;
                update contactObj;
                
                Email_SMS_Log__c eslTaken = new Email_SMS_Log__c();
                eslTaken.Id = response.Email_Sms_Log__c;
                eslTaken.Taken__c = true;
                update eslTaken;
            }
            
        }
    
    }
}