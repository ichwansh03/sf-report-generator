global class OutboundCallICF {
        
    @InvocableMethod(label='Send Survey Outbound Call ICF' description='Send Survey Outbound Call.')
    public static List<String>  sendSurveyICF(List<String> recordId){
        system.debug('#### CaseId:'+recordId);
        // add 02 July 2025
        List<String> result = new List<String>();
        if (recordId.size() > 0) {
            try{
                String caseId = recordId[0];
                case cases = new case();
                cases.id = caseId;
                //cases.isSurvey__c = false;
                //cases.Follow_Up_ICF__c = 1;
                
                //Update Cases;
                
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
                esl.Outbound_Call__c = true;
                
                insert esl;
                result.add('Success Send Survey');
            }catch(exception err){
                system.debug('error');
                system.debug('error:'+err.getMessage());
                system.debug('error:'+err.getLineNumber());
                result.add('Send Survey Error:'+err.getMessage());
            }
        } 
        
        return result;
    }

}