public class AXAAPI012A_response {

	public class Data {
        //public String recordType {get;set;} 
        
		public String businessHoursId {get;set;} 
		public String caseId {get;set;} 
		public Datetime completionDate {get;set;} 
		public String createdById {get;set;} 
		public Datetime createdDate {get;set;} 
		public String elapsedTimeInDays {get;set;} 
		public String elapsedTimeInHrs {get;set;} 
		public String elapsedTimeInMins {get;set;} 
		public String id {get;set;} 
		public String isCompleted {get;set;} 
        public String isDeleted {get;set;}
        public String isViolated {get;set;}
        public String lastModifiedById {get;set;}
        public Datetime lastModifiedDate {get;set;}
        public String milestoneTypeId {get;set;} 
		public Datetime startDate {get;set;} 
        public String systemModstamp {get;set;}
        public Datetime targetDate {get;set;}
        public String targetResponseInDays {get;set;}
        public String targetResponseInHrs {get;set;}
        public String targetResponseInMins {get;set;}
        public String timeRemainingInMins {get;set;}
        public String timeSinceTargetInMins {get;set;}
        public String milestone_name {get;set;}


		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'businessHoursId') {
							businessHoursId = parser.getText();
						} else if (text == 'caseId') {
							caseId = parser.getText();
						} else if (text == 'completionDate') {
							completionDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'createdById') {
							createdById = parser.getText();
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'elapsedTimeInDays') {
							elapsedTimeInDays = parser.getText();
						} else if (text == 'elapsedTimeInHrs') {
							elapsedTimeInHrs = parser.getText();
						} else if (text == 'elapsedTimeInMins') {
							elapsedTimeInMins = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'isCompleted') {
                            isCompleted = parser.getText();
                        } else if (text == 'isDeleted') {
                            isDeleted = parser.getText();
                        } else if (text == 'isViolated') {
                            isViolated = parser.getText();
                        } else if (text == 'lastModifiedById') {
                            lastModifiedById = parser.getText();
                        } else if (text == 'lastModifiedDate') {
                            lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'milestoneTypeId') {
							milestoneTypeId = parser.getText();
                            if(milestoneTypeId != null) milestone_name = AXAAPI_UtilityClass.getsObjectNameById(milestoneTypeId, 'MilestoneType','name');
						} else if (text == 'startDate') {
							startDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'systemModstamp') {
							systemModstamp = parser.getText();
						} else if (text == 'targetDate') {
							targetDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'targetResponseInDays') {
							targetResponseInDays = parser.getText();
						} else if (text == 'targetResponseInHrs') {
							targetResponseInHrs = parser.getText();
						} else if (text == 'targetResponseInMins') {
							targetResponseInMins = parser.getText();
						} else if (text == 'timeRemainingInMins') {
							timeRemainingInMins = parser.getText();
						} else if (text == 'timeSinceTargetInMins') {
							timeSinceTargetInMins = parser.getText();
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

	public AXAAPI012A_response(JSONParser parser) {
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
	
	
	public static AXAAPI012A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI012A_response(parser);
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