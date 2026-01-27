public class AXAAPI017B_response {
	public AXAAPI017B_response(){}
	public class Data {
        Public Data() {}
        //public String recordType {get;set;} 
        Public String division_c {get; set;}	
        Public String end_By_c {get; set;}			
        Public Datetime end_Datetime_c {get; set;}			
        Public String entity_c {get; set;}		
        Public String id {get; set;}	
        Public Boolean isDeleted	{get; set;}	
        Public Boolean last_Escalation_c	{get; set;}			
        Public String lastModifiedById {get; set;}		
        Public Datetime lastModifiedDate {get; set;}		
        Public String lead_Time_c {get; set;}	
        Public String lead_Time_F_c	{get; set;}		
        Public String name {get; set;}	
        Public String named_User_c {get; set;}		
        Public String ownerId {get; set;}	
        Public Datetime start_Datetime_c {get; set;}			
        Public String status_c {get; set;}	
        Public String systemModstamp {get; set;}			
        Public Datetime target_Datetime_c	{get; set;}			
        Public String target_Status_c {get; set;}		
        Public String target_TAT_c {get; set;}	
        public String case_c {get; set;}
        public String case_name {get; set;}
        public String owner_name {get; set;}
        public String last_modified_name {get; set;}
        public String Created_by_name {get; set;}
        public String createdById {get;set;}
        public String day_Name_c {get;set;}
        public String case_Escalation_c {get;set;}
        public Datetime createddate {get; set;}  
       
        
        
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'division__c') {
							division_c = parser.getText();
                        } else if(text == 'case_Escalation__c'){
                          	case_Escalation_c = parser.getText();  
                        } else if (text == 'createdById'){
                            createdById = parser.getText();
                            if(createdById != null) Created_by_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
                        } else if (text == 'createddate') {
                            createddate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'day_Name__c') {
							day_Name_c = parser.getText();
						} else if (text == 'case__c') {
							case_c = parser.getText();
                            /* if (case_c != null) {                                     
                                AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(case_c);   
                                if(getData != null && getData.data != null ) case_name = getData.data.caseNumber;  
                            }*/
                            if(case_c != null) case_name = AXAAPI_UtilityClass.getsObjectNameById(case_c, 'Case', 'caseNumber');
						} else if (text == 'end_By__c') {
							end_By_c = parser.getText();
						} else if (text == 'end_Datetime__c') {
							end_Datetime_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'entity__c') {
							entity_c = parser.getText();
						}  else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'isDeleted') {
                            String a = parser.getText();
							isDeleted = Boolean.valueOf(a);
						} else if (text == 'last_Escalation__c') {
                            String a = parser.getText();
							last_Escalation_c = Boolean.valueOf(a);
						} else if (text == 'lastModifiedById') {
							lastModifiedById = parser.getText();
                            if(lastModifiedByid != null) last_modified_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
						} else if (text == 'lastModifiedDate') {
                            lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'lead_Time__c') {
                            lead_Time_c = parser.getText();
                        } else if (text == 'lead_Time_F__c') {
                            lead_Time_F_c = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'named_User__c') {
                            named_User_c = parser.getText();
						} else if (text == 'ownerId') {
							ownerId = parser.getText();
                            if(ownerid != null) owner_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'User', 'Name');
						} else if (text == 'start_Datetime__c') {
							start_Datetime_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'status__c') {
							status_c = parser.getText();
						} else if (text == 'systemModstamp') {
							systemModstamp = parser.getText();
						} else if (text == 'target_Datetime__c') {
							target_Datetime_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'target_Status__c') {
							target_Status_c = parser.getText();
						} else if (text == 'target_TAT__c') {
							target_TAT_c = parser.getText();
						} else {
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

	public AXAAPI017B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI017B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI017B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI017B_response(parser);
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