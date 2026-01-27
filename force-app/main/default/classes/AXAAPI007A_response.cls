/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Convert Json parse to data
*  @Class   AXAAPI007A_response 
*  @Return  Array
*/ 
public class AXAAPI007A_response {
    
	public class Data { 
        public string actorId {get;set;}
        public string actorName {get;set;}
        public string comments {get;set;}
        public string createdById {get;set;}
        public string createdByName {get;set;}
        public datetime createdDate {get;set;}
        public string elapsedTimeInDays {get;set;}
        public string elapsedTimeInHours {get;set;}
        public string elapsedTimeInMinutes {get;set;}
        public string id {get;set;}
        public string originalActorId {get;set;}
        public string originalActorName {get;set;}
        public string processInstanceId {get;set;}
        public string stepStatus {get;set;}
        public datetime systemModstamp {get;set;}

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'actorId') {
                            actorId = parser.getText();
                            if (actorId != null) actorName = AXAAPI_UtilityClass.getsObjectNameById(actorId, 'user', 'name'); 
                        } else if (text == 'comments') {
                            comments = parser.getText();
                        } else if (text == 'createdById') {
                            createdById = parser.getText();
                            if (createdById != null) createdByName = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'user', 'name'); 
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
                        } else if (text == 'originalActorId') {
                            originalActorId = parser.getText();
                            if (originalActorId != null) originalActorName = AXAAPI_UtilityClass.getsObjectNameById(originalActorId, 'user', 'name'); 
                        } else if (text == 'processInstanceId') {
                            processInstanceId = parser.getText();
                        } else if (text == 'stepStatus') {
                            stepStatus = parser.getText();
                        } else if (text == 'systemModstamp') {
                            systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
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

	public AXAAPI007A_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI007A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI007A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI007A_response(parser);
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