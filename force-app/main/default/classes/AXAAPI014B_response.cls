/*
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Class Response Negative Feedback Detai;
*/

public class AXAAPI014B_response {

    public AXAAPI014B_response(){}
    
	public class Data {
        
        public Data() {}
        //public String recordType {get;set;} 
        
		public String agent_Name_c {get;set;} 
		public String case_c {get;set;} 
		public String case_Origin_c {get;set;} 
		public String contact_c {get;set;} 
		public String count_Response_c {get;set;} 
		public String createdById {get;set;} 
		public Datetime createdDate {get;set;} 
		public String email_SMS_Log_c {get;set;} 
		public Datetime email_SMS_Log_Created_Date_c {get;set;} 
		public String entity_c {get;set;} 
        public String ext_Id_c {get;set;}
        public String icF_Non_CCC_c {get;set;}
        public String id {get;set;}
        public String insurance_Type_c {get;set;}
        public Boolean isDeleted {get;set;} 
		public String lastModifiedById {get;set;} 
        public Datetime lastModifiedDate {get;set;}
        public Datetime lastReferencedDate {get;set;}
        public Datetime lastViewedDate {get;set;}
        public String log_Book_Activitiy_Detail_c {get;set;}
        public String moT_c {get;set;}
        public String name {get;set;}
        public String negative_Feedback_c {get;set;}
        public String ownerId {get;set;}
        public String policy_No_c {get;set;} 
        public String positive_Feedback_c {get;set;}
        public String status_Response_c {get;set;}
        public String survey_c {get;set;}
        public Datetime systemModstamp {get;set;}
        public String taken_c {get;set;}
        public String type_c {get;set;}
        public String user_c {get;set;}
        public String welcomeCall_CallLine_c {get;set;}  
        
               
        public String ownerName {get;set;} 
        public String User_Id_Customer_Portal_c {get;set;} 
        public String ICFNonCCCName {get;set;}
        public string caseNumber {get;set;}
        public string ContactName {get;set;}
        public string logBookDetail {get;set;}
        public string surveyName {get;set;}
        public string createdName {get;set;}
        public string modifiedName {get;set;}
        public string email_SMS_Log_name {get;set;}
        public datetime email_SMS_Log_date {get;set;}


		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        system.debug('text:'+text);
						if (text == 'agent_Name__c') {
							agent_Name_c = parser.getText();
						} else if (text == 'case__c') {
							case_c = parser.getText();                            
                            /* if (case_c != null) {                                     
                                AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(case_c);   
                                if(getData != null && getData.data != null ) caseNumber = getData.data.caseNumber;  
                            } */
                            if (case_c != null && case_c.left(3) == Schema.SObjectType.case.getKeyPrefix()) caseNumber = AXAAPI_UtilityClass.getsObjectNameById(case_c, 'Case', 'CaseNumber');
						} else if (text == 'case_Origin__c') {
							case_Origin_c = parser.getText();
						} else if (text == 'contact__c') {
							contact_c = parser.getText();
                            if (contact_c != null && contact_c.left(3) == Schema.SObjectType.Contact.getKeyPrefix()) ContactName = AXAAPI_UtilityClass.getsObjectNameById(contact_c, 'Contact', 'Name');
						}  else if (text == 'count_Response__c') {
							count_Response_c = parser.getText();
						} else if (text == 'createdById') {
							createdById = parser.getText(); 
                            if (createdById != null) createdName = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'email_SMS_Log__c') {
							email_SMS_Log_c = parser.getText();
                            if (email_SMS_Log_c != null && email_SMS_Log_c.left(3) == Schema.SObjectType.Email_SMS_Log__c.getKeyPrefix()) {
                                /* AXAAPI003B_response getEmailSMSLog = AXAAPI003B_EmailSMSLogById.getEmailSMSLogById(email_SMS_Log_c); 
                                 
                                if(getEmailSMSLog != null && getEmailSMSLog.data != null ) {
                                    email_SMS_Log_name = getEmailSMSLog.data.Name;  
                                } */
                                
                                email_SMS_Log_name = AXAAPI_UtilityClass.getsObjectNameById(email_SMS_Log_c, 'Email_SMS_Log__c', 'Name');  
                                 
                                /* system.debug('case_c:'+case_c);
                                system.debug('cs_byID:'+cs_byID);
                                Email_SMS_Log__c getEmail = [select id,Name,createdDate from Email_SMS_Log__c where id =:email_SMS_Log_c limit 1 ];
                                if (getEmail != null) { 
                                    email_SMS_Log_name = getEmail.Name;
                                    email_SMS_Log_date = getEmail.createdDate;
                                } */
                            }
						} else if (text == 'email_SMS_Log_Created_Date__c') {
                            email_SMS_Log_Created_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'entity__c') {
                            entity_c = parser.getText();
                        } else if (text == 'ext_Id__c') {
                            ext_Id_c = parser.getText();
                        } else if (text == 'icF_Non_CCC__c') {
                            icF_Non_CCC_c = parser.getText();
                            if (icF_Non_CCC_c != null) ICFNonCCCName = AXAAPI_UtilityClass.getsObjectNameById(icF_Non_CCC_c, 'icF_Non_CCC__c', 'Name');
                        } else if (text == 'id') {
                            id = parser.getText();
						} else if (text == 'insurance_Type__c') {
							insurance_Type_c = parser.getText();
						} else if (text == 'isDeleted') {
							// isDeleted = parser.getBooleanValue();
						} else if (text == 'lastModifiedById') {
							lastModifiedById = parser.getText();
                            if (lastModifiedById != null) modifiedName = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
						} else if (text == 'lastModifiedDate') {
							lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'lastReferencedDate') {
							lastReferencedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'lastViewedDate') {
							lastViewedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'log_Book_Activitiy_Detail__c') {
							log_Book_Activitiy_Detail_c = parser.getText();
                            if (log_Book_Activitiy_Detail_c != null) logBookDetail = AXAAPI_UtilityClass.getsObjectNameById(log_Book_Activitiy_Detail_c, 'log_Book_Activitiy_Detail__c', 'Name');
						} else if (text == 'moT__c') {
							moT_c = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'negative_Feedback__c') {
							negative_Feedback_c = parser.getText();
						} else if (text == 'ownerId') {
							ownerId = parser.getText();
                            if (ownerId != null && ownerId.left(3) == Schema.SObjectType.User.getKeyPrefix()) ownerName = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'User', 'Name');
						} else if (text == 'policy_No__c') {
							policy_No_c = parser.getText();
						} else if (text == 'positive_Feedback__c') {
							positive_Feedback_c = parser.getText();
						} else if (text == 'status_Response__c') {
							status_Response_c = parser.getText();
						} else if (text == 'survey__c') {
							survey_c = parser.getText();
                            if(survey_c != null) surveyName = AXAAPI_UtilityClass.getsObjectNameById(survey_c, 'survey__c', 'Name');
						} else if (text == 'systemModstamp') {
							systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'taken__c') {
							taken_c = parser.getText(); 
						} else if (text == 'type__c') {
							type_c = parser.getText();
						} else if (text == 'user__c') {
							user_c = parser.getText();
						} else if (text == 'welcomeCall_CallLine__c') {
							welcomeCall_CallLine_c = parser.getText();
						} 
                        else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public String status {get;set;} 
	public String message {get;set;} 
	public Data data {get;set;} 
  
	public static AXAAPI014B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI014B_response(parser);
	}
    
    
	public AXAAPI014B_response(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'status') {
						status = parser.getText();
					} else if (text == 'message') {
						message = parser.getText();
					} else if (text == 'data') {
						data = new Data(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI014B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	
}