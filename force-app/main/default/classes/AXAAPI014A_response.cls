public class AXAAPI014A_response {

	public class Data {
        
        public String recordTypeName {get;set;} 
		public String agent_Name_c {get;set;} 
		public String case_c {get;set;} 
		public String caseNumber {get;set;} 
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
        public String lastId {get;set;}
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
        public string surveyName  {get;set;}
        public string createdByName  {get;set;}
        public string contactName  {get;set;}


		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'agent_Name__c') {
							agent_Name_c = parser.getText();
						} else if (text == 'case__c') {
							case_c = parser.getText(); 
                            if (case_c != null) {  
                                AXAAPI001B_response cs_byID = new AXAAPI001B_response();
                                cs_byID = AXAAPI001B_CaseById.getCaseById(case_c); 
                                
        						if(cs_byID != null && cs_byID.data != null ) caseNumber = cs_byID.data.caseNumber; 
                                system.debug('case_c:'+case_c);
                                system.debug('cs_byID:'+cs_byID);
                            }
						} else if (text == 'case_Origin__c') {
							case_Origin_c = parser.getText();
						} else if (text == 'contact__c') {
							contact_c = parser.getText();
                            if (contact_c != null) contactName = AXAAPI_UtilityClass.getsObjectNameById(contact_c, 'contact', 'Name');
						}  else if (text == 'count_Response__c') {
							count_Response_c = parser.getText();
						} else if (text == 'createdById') {
							createdById = parser.getText();
                            if (createdById != null) createdByName = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'user', 'Name');
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'email_SMS_Log__c') {
							email_SMS_Log_c = parser.getText();
						} else if (text == 'email_SMS_Log_Created_Date__c') {
                            email_SMS_Log_Created_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'entity__c') {
                            entity_c = parser.getText();
                        } else if (text == 'ext_Id__c') {
                            ext_Id_c = parser.getText();
                        } else if (text == 'icF_Non_CCC__c') {
                            icF_Non_CCC_c = parser.getText();
                        } else if (text == 'id') {
                            id = parser.getText();
                            lastId = id.SubString(id.length() - 3);  
                            if (id != null) {                              
                                /* AXAAPI014B_response getData  = AXAAPI014B_SurveyTakenById.getSurveyTakenById(id);   
                                if(getData != null && getData.data != null ) taken_c = getData.data.taken_c;   */
								taken_c = AXAAPI_UtilityClass.getsObjectNameById(id, 'SurveyTaker__c', 'taken__c');
                                /* survey_c = AXAAPI_UtilityClass.getsObjectNameById(id, 'SurveyTaker__c', 'Survey__c');
                                if (survey_c != null) surveyName = AXAAPI_UtilityClass.getsObjectNameById(survey_c, 'Survey__c', 'Name'); */
                            }
						} else if (text == 'insurance_Type__c') {
							insurance_Type_c = parser.getText();
						} else if (text == 'isDeleted') {
							// isDeleted = parser.getBooleanValue();
						} else if (text == 'lastModifiedById') {
							lastModifiedById = parser.getText();
						} else if (text == 'lastModifiedDate') {
							lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'lastReferencedDate') {
							lastReferencedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'lastViewedDate') {
							lastViewedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'log_Book_Activitiy_Detail__c') {
							log_Book_Activitiy_Detail_c = parser.getText();
						} else if (text == 'moT__c') {
							moT_c = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'negative_Feedback__c') {
							negative_Feedback_c = parser.getText();
						} else if (text == 'ownerId') {
							ownerId = parser.getText();
						} else if (text == 'policy_No__c') {
							policy_No_c = parser.getText();
						} else if (text == 'positive_Feedback__c') {
							positive_Feedback_c = parser.getText();
						} else if (text == 'status_Response__c') {
							status_Response_c = parser.getText();
						} else if (text == 'survey__c') {
							survey_c = parser.getText();
                            if (survey_c != null) surveyName = AXAAPI_UtilityClass.getsObjectNameById(survey_c, 'Survey__c', 'Name');
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
						} else if (text == 'recordTypeId') {
							recordTypeName = AXAAPI_UtilityClass.getsObjectNameById(parser.getText(), 'RecordType', 'Name');
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
	public List<Data> data {get;set;} 
    public integer counts {get;set;} 

	public AXAAPI014A_response(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'status') {
						status = parser.getText();
					} else if (text == 'message') {
						message = parser.getText();
					} else if (text == 'data') {
						data = arrayOfData(parser);
					} else if (text == 'counts') {
						counts = integer.valueOf(parser.getText());
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI011A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI014A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI014A_response(parser);
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
	

    private static List<Data> arrayOfData(System.JSONParser p) {
        List<Data> res = new List<Data>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Data(p));
        }
        return res;
    }




}