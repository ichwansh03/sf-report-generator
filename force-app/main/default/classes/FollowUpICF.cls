global class FollowUpICF {
    
    @InvocableMethod(label='send Survey ICF' description='Send Survey Follow up.')
    public static List<String>  sendSurveyICF(List<String> recordId){
        system.debug('#### CaseId:'+recordId);
        // add/update Support MII at 15 03 24
        List<String> result = new List<String>();
        if (recordId.size() > 0) {
            try{
                String caseId = recordId[0];
                case cases = new case();
                cases.id = caseId;
                cases.isSurvey__c = false;
                cases.Follow_Up_ICF__c = 1;
                
                Update Cases;
                
                List<Negative_Feedback__c > updateNegativeFeedback = new  List<Negative_Feedback__c >();
                List<Negative_Feedback__c > checkNegativeFeedback = [select id, Case__c, Ext_Id__c from Negative_Feedback__c where Case__c = :caseId order by Createddate asc];
                
                List<SurveyTaker__c> checkSurveyTaken = [select id, Case__c, Ext_Id__c from SurveyTaker__c where Case__c = :caseId order by Createddate asc];
                List<SurveyTaker__c > updateSurveytaken = new  List<SurveyTaker__c >();
                
                processSurveyAndFeedback(updateNegativeFeedback, checkNegativeFeedback, checkSurveyTaken, updateSurveytaken);
                
                Map<String, Schema.SObjectField> schemaFieldMap = Schema.SObjectType.Case.fields.getMap();
                list <String> queriedFieldValues = new list <String>();
                
                for (String fieldName: schemaFieldMap.keySet()) {
                    queriedFieldValues.add(fieldName);
                }
                String queriedFieldJoin = String.join(queriedFieldValues, ',');
                Case getCase = Database.query('Select '+queriedFieldJoin+', contact.Email, contact.MobilePhone  from case where id = \''+caseid+'\'');
                CreateEmailSmsLogQueue caseQueue = new CreateEmailSmsLogQueue(getCase);
                System.enqueueJob(caseQueue);
                
                ICF_Parameter__c getDetail = [Select ICF_SMS_Template__c, ICF_Email_Template__c from ICF_Parameter__c where RecordType.Name = 'Master - Qualtrics'  AND Entity__c = 'AMFS' AND Status__c='Active'  ];
                
                
                List<Survey__c> listSurvey = [Select id, URL__c  from  Survey__c where recordType.Name = 'Master Qualtrics'];
                String getSurvey = '';
                if (listSurvey.size() > 0) getSurvey = listSurvey[0].Id;
                
                Email_SMS_Log__c esl = new Email_SMS_Log__c();
                esl.OwnerId = UserInfo.getUserId();
                esl.Account__c = getCase.AccountId;
                esl.Case__c = getCase.Id;
                esl.Category__c = 'ICF';
                esl.Contact__c = getCase.ContactId;
                esl.Email_SMS_Template__c = getDetail.ICF_Email_Template__c;
                esl.Email__c =  getCase.contact.Email;
                esl.Entity__c = getCase.Entity__c;
                esl.Method__c = 'Email';
                esl.Mobile__c = getCase.contact.MobilePhone;
                esl.Request_Date__c = system.Today();
                esl.Send_Flag__c = true;
                esl.Start_Date__c = system.Today();
                esl.End_Date__c = system.Today();
                esl.Status__c = 'Draft';
                esl.Survey__c = getSurvey;
                esl.Survey_Type__c = (getCase.type.equals('Inquiry') ? 'I Ask - Inquiry' : (getCase.type.equals('Request') ? 'I Ask - Request' : getCase.mot__c));
                esl.Type__c = 'CCC';
                esl.Case_List__c = getCase.CaseNumber;
                esl.Template_Email__c = getDetail.ICF_Email_Template__c;
                esl.Template_SMS__c = getDetail.ICF_SMS_Template__c;
                esl.Department_Owner__c = 'ICF';
                esl.Topic__c = 'ICF';
                esl.MOT__c = getCase.mot__c;
                esl.Follow_Up_ICF__c = true;
                
                insert esl;
                result.add('success');
            }catch(exception err){
                system.debug('error');
                system.debug('error:'+err.getMessage());
                system.debug('error:'+err.getLineNumber());
                result.add('error:'+err.getMessage());
            }
        } 
        
        return result;
    }
    
    @TestVisible
    private static void processSurveyAndFeedback(List<Negative_Feedback__c > updateNegativeFeedback, List<Negative_Feedback__c > checkNegativeFeedback, List<SurveyTaker__c> checkSurveyTaken, List<SurveyTaker__c > updateSurveytaken){
        if (checkNegativeFeedback.size() > 0) {
            integer num = 0;
            for (Negative_Feedback__c row : checkNegativeFeedback) {
                system.debug('row:'+row);
                String extId = row.Case__c;
                extId += '-';
                extId += string.valueof(num++);
                system.debug('extId:'+extId);
                
                updateNegativeFeedback.add(new Negative_Feedback__c(id= row.Id, Ext_Id__c = extId));
            }
            
            
            system.debug('#### num:'+num);
            system.debug('#### updateNegativeFeedback:'+updateNegativeFeedback);
            
            update updateNegativeFeedback;
        }
        
        
        if (checkSurveyTaken.size() > 0) {
            integer num = 0;
            for (SurveyTaker__c row : checkSurveyTaken) {
                system.debug('row:'+row);
                String extId = row.Case__c;
                extId += '-';
                extId += string.valueof(num++);
                
                system.debug('extId 2:'+extId);
                
                
                updateSurveytaken.add(new SurveyTaker__c(id= row.Id, Ext_Id__c = extId));
            }
            
            
            system.debug('#### num:'+num);
            system.debug('#### updateSurveytaken:'+updateSurveytaken);
            
            update updateSurveytaken;
        }   
    }
    
}