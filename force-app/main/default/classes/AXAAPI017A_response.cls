public class AXAAPI017A_response {

	public class Data {
        //public String recordType {get;set;} 
        Public String division_c {get; set;}	
        Public String end_By_c {get; set;}			
        Public Datetime end_Datetime_c {get; set;}			
        Public String entity_c {get; set;}		
        Public String id {get; set;}	
        Public Boolean isDeleted	{get; set;}	
        Public String last_Escalation_c	{get; set;}			
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
        public String lastId {get;set;}
			
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'division__c') {
							division_c = parser.getText();
						} else if (text == 'case__c') {
							case_c = parser.getText();
						} else if (text == 'end_By__c') {
							end_By_c = parser.getText();
						} else if (text == 'end_Datetime__c') {
							end_Datetime_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'entity__c') {
							entity_c = parser.getText();
						}  else if (text == 'id') {
							id = parser.getText();
                            if(id != null){
                                lastId = id.SubString(id.length() - 3);  
                            }
						} else if (text == 'isDeleted') {
                            String a = parser.getText();
							isDeleted = Boolean.valueOf(a);
						} else if (text == 'last_Escalation__c') {
							last_Escalation_c = parser.getText();
						} else if (text == 'lastModifiedById') {
							lastModifiedById = parser.getText();
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
                            if (ownerId != null) owner_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'user', 'name');
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
	public List<Data> data {get;set;} 
    public integer counts {get;set;} 

	public AXAAPI017A_response(JSONParser parser) {
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
					}else if (text == 'counts') {
						counts = integer.valueOf(parser.getText());
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI017A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI017A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI017A_response(parser);
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