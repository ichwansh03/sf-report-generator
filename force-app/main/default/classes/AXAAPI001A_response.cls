public class AXAAPI001A_response {

	public class Data {
        public String recordType {get;set;} 
        
		public String id {get;set;} 
		public String lastId {get;set;} 
		public String caseNumber {get;set;} 
		public String type {get;set;} 
		public String case_Type_Config {get;set;} 
		public String subject {get;set;} 
		public Datetime createdDate {get;set;}  
		public Datetime closedDate {get;set;} 
		public String case_Owner {get;set;} 
		public String ownerId {get;set;} 
		public String status {get;set;} 
        public String origin {get;set;}
        public String source {get;set;}
        public String parentId {get;set;}
        public String Parent_Case_Number {get;set;}
		public String policy_Numbers {get;set;} 
		public String Priority {get;set;} 
        
        public string case_Type_c {get;set;}

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
                            if (id != null) {
                              	lastId = id.SubString(id.length() - 3);  
                                
                                Priority = AXAAPI_UtilityClass.getsObjectNameById(id, 'case', 'Priority');
                                parentId = AXAAPI_UtilityClass.getsObjectNameById(id, 'case', 'parentId');
                                if (parentId != null) { 
                                	Parent_Case_Number = AXAAPI_UtilityClass.getsObjectNameById(parentId, 'case', 'caseNumber');
                                }
                                /* AXAAPI001B_response cs_byID = new AXAAPI001B_response();
                                cs_byID = AXAAPI001B_CaseById.getCaseById(id); 
                                
                                if(cs_byID != null && cs_byID.data != null ) { 
                                    Priority = cs_byID.data.Priority; 
                                    parentId = cs_byID.data.parentId; 
                                    if (cs_byID.data.parent_Case_Number_c != '0') Parent_Case_Number = cs_byID.data.parent_Case_Number_c; 
                                }   */                                 
                            }
						} else if (text == 'caseNumber') {
							caseNumber = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'case_Type_Config__c') {
							case_Type_Config = parser.getText();
						} else if (text == 'subject') {
							subject = parser.getText();
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'closedDate') {
							closedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'case_Owner__c') {
							case_Owner = parser.getText();
						} else if (text == 'ownerId') {
							ownerId = parser.getText();
						} else if (text == 'status') {
                            status = parser.getText();
                        } else if (text == 'origin') {
                            origin = parser.getText();
                        } else if (text == 'source') {
                            source = parser.getText();
                        } else if (text == 'parentId') {
                            parentId = parser.getText();
                        /* } else if (text == 'parent_Case_Number__c') {
                            Parent_Case_Number = parser.getText(); */
						} else if (text == 'policy_Numbers__c') {
							policy_Numbers = parser.getText();
						} else if (text == 'case_Type__c') {
							case_Type_c = parser.getText();
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
	public integer counts {get;set;} 
	public List<Data> data {get;set;} 

	public AXAAPI001A_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI001A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI001A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI001A_response(parser);
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