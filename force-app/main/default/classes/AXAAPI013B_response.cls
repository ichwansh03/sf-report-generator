/*
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Class Response Negative Feedback Detai;
*/

public class AXAAPI013B_response {
	
    public AXAAPI013B_response(){}
    
	public String status {get;set;} 
	public String message {get;set;} 
	public Data data {get;set;} 

	public class Data {
        
        public Data(){}
        
        //public String recordType {get;set;}  
        public String accountid_c {get;set;} 
        public String case_c {get;set;} 
        public String case_Owner_c {get;set;} 
        public String complaint_RecordType_c {get;set;} 
        public String contact_c {get;set;} 
        public String createdById {get;set;} 
        public Datetime createdDate {get;set;} 
        public String description_c {get;set;} 
        public String entity_c {get;set;} 
        public String ext_Id_c {get;set;} 
        public String id {get;set;}
        public String inquiry_RecordTypeId_c {get;set;}
        public Boolean isDeleted {get;set;}
        public String lastModifiedById {get;set;}
        public Datetime lastModifiedDate {get;set;} 
        public Datetime lastReferencedDate {get;set;} 
        public Datetime lastViewedDate {get;set;}
        public String name {get;set;}
        public String new_Case_c {get;set;}
        public String ownerId {get;set;}
        public String request_RecordTypeId_c {get;set;}
        public Datetime send_Survey_c {get;set;}
        public String survey_Form_c {get;set;}
        public String survey_Response_c {get;set;}
        public Datetime systemModstamp {get;set;}           
        public String ownerName {get;set;}
        public String feedBack_text {get;set;}
        public String User_Id_Customer_Portal_c {get;set;}
        public String origin {get;set;}
        public String ownerNamed {get;set;}
        public string caseNumber {get;set;}
        public string ContactName {get;set;}
        public string SurveyForm {get;set;}
        public string SurveyResponse {get;set;}
        public string createdName {get;set;}
        public string modifiedName {get;set;}
        
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'accountid__c') {
							accountid_c = parser.getText();
						} else if (text == 'case__c') {
							case_c = parser.getText();                 
                            if (case_c != null) {   
                                AXAAPI001B_response cs_byID = new AXAAPI001B_response();
                                cs_byID = AXAAPI001B_CaseById.getCaseById(case_c);  
        						if(cs_byID != null && cs_byID.data != null ) caseNumber = cs_byID.data.caseNumber;  
                            } 
						} else if (text == 'case_Owner__c') {
							case_Owner_c = parser.getText();
						} else if (text == 'complaint_RecordType__c') {
							complaint_RecordType_c = parser.getText();
						}  else if (text == 'contact__c') {
							contact_c = parser.getText();
                            if (contact_c != null) ContactName = AXAAPI_UtilityClass.getsObjectNameById(contact_c, 'Contact', 'Name');
						} else if (text == 'createdById') {
							createdById = parser.getText();
                            if (createdById != null) createdName = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'description__c') {
							description_c = parser.getText();
						} else if (text == 'entity__c') {
                            entity_c = parser.getText();
                        } else if (text == 'ext_Id__c') {
                            ext_Id_c = parser.getText();
                        } else if (text == 'id') {
                            id = parser.getText();
                            // feedBack_text = AXAAPI_UtilityClass.getsObjectNameById(Id, 'negative_Feedback__c', 'Feedback_Text__c');
                            User_Id_Customer_Portal_c = AXAAPI_UtilityClass.getsObjectNameById(Id, 'negative_Feedback__c', 'User_Id_Customer_Portal__c');
                            // origin = AXAAPI_UtilityClass.getsObjectNameById(Id, 'negative_Feedback__c', 'Origin__c');
                        } else if (text == 'Origin__c') {
                            origin = parser.getText();
                        } else if (text == 'Feedback_Text__c') {
                            feedBack_text = parser.getText();
                        } else if (text == 'inquiry_RecordTypeId__c') {
                            inquiry_RecordTypeId_c = parser.getText();
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
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'new_Case__c') {
							new_Case_c = parser.getText();
						} else if (text == 'ownerId') {
							ownerId = parser.getText();
                            if (ownerId != null) ownerName = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'User', 'Name');
						} else if (text == 'request_RecordTypeId__c') {
							request_RecordTypeId_c = parser.getText();
						} else if (text == 'send_Survey__c') {
							send_Survey_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'survey_Form__c') {
							survey_Form_c = parser.getText(); 
                            if (survey_Form_c != null) SurveyForm = AXAAPI_UtilityClass.getsObjectNameById(survey_Form_c, 'survey__c', 'Name');
						} else if (text == 'survey_Response__c') {
							survey_Response_c = parser.getText();
                            if (survey_Response_c != null) SurveyResponse = AXAAPI_UtilityClass.getsObjectNameById(survey_Response_c, 'survey_Response__c', 'Name');
						} else if (text == 'systemModstamp') {
							systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
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

	public AXAAPI013B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI013B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	 
    
	public static AXAAPI013B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI013B_response(parser);
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