/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Convert Json parse to data
*  @Class   AXAAPI006A_response 
*  @Return  Array
*/ 
public class AXAAPI006A_response {
    
	public class Data { 
        public datetime completedDate {get;set;}
        public string createdById {get;set;}
        public datetime createdDate {get;set;}
        public string elapsedTimeInDays {get;set;}
        public string elapsedTimeInHours {get;set;}
        public string elapsedTimeInMinutes {get;set;}
        public string id {get;set;}
        public string isDeleted {get;set;}
        public string lastActorId {get;set;}
        public string lastModifiedById {get;set;}
        public datetime lastModifiedDate {get;set;}
        public string processDefinitionId {get;set;}
        public string status {get;set;}
        public string submittedById {get;set;}
        public datetime systemModstamp {get;set;}
        public string targetObjectId {get;set;}

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'completedDate') {
                            completedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'createdById') {
                            createdById = parser.getText();
                        } else if (text == 'createdDate') {
                            createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'elapsedTimeInDays') {
                            elapsedTimeInDays = parser.getText();
                        } else if (text == 'elapsedTimeInHours') {
                            elapsedTimeInHours = parser.getText();
                        } else if (text == 'elapsedTimeInMinutes') {
                            elapsedTimeInMinutes = parser.getText();
                        } else if (text == 'id') {
                            id = parser.getText();
                        } else if (text == 'isDeleted') {
                            isDeleted = parser.getText();
                        } else if (text == 'lastActorId') {
                            lastActorId = parser.getText();
                        } else if (text == 'lastModifiedById') {
                            lastModifiedById = parser.getText();
                        } else if (text == 'lastModifiedDate') {
                            lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'processDefinitionId') {
                            processDefinitionId = parser.getText();
                        } else if (text == 'status') {
                            status = parser.getText();
                        } else if (text == 'submittedById') {
                            submittedById = parser.getText();
                        } else if (text == 'systemModstamp') {
                            systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'targetObjectId') {
                            targetObjectId = parser.getText();
                        }else {
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

	public AXAAPI006A_response(JSONParser parser) {
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
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI006A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI006A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI006A_response(parser);
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