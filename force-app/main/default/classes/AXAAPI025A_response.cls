public class AXAAPI025A_response {

    public class Data {
        Public Datetime event_time {get;set;}
        Public String agentId {get;set;}
        Public String agentName{get;set;}
        Public String event_type {get;set;}
        Public String detail {get;set;}
        

        
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						IF (text == 'time') { event_time = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'agentId') { 
                            agentId = parser.getText();
                         	if (agentId != null) agentName = AXAAPI_UtilityClass.getsObjectNameById(agentId, 'User', 'name');
                        }
                        ELSE IF (text == 'type') { event_type = parser.getText();}
                        ELSE IF (text == 'detail') { detail = parser.getText();}
						ELSE{
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
	public Integer counts {get;set;}
    
	public AXAAPI025A_response(JSONParser parser) {
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
                        counts = parser.getIntegerValue();
					}else {
						System.debug(LoggingLevel.WARN, 'AXAAPI025A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI025A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI025A_response(parser);
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