public class AXAAPI012B_response {

	public class Data {
        //public String recordType {get;set;} 
        Public Data() {}
        
        public String caseName {get;set;}
        public String MileStoneName {get;set;}
        public String businessHoursName {get;set;}

		public String businessHoursId {get;set;} 
		public String caseId {get;set;} 
		public Datetime completionDate {get;set;} 
		public String createdById {get;set;} 
		public Datetime createdDate {get;set;} 
		public String elapsedTimeInDays {get;set;} 
		public String elapsedTimeInHrs {get;set;} 
		public integer elapsedTimeInMins {get;set;} 
		public String id {get;set;} 
		public Boolean isCompleted {get;set;} 
        public Boolean isDeleted {get;set;}
        public Boolean isViolated {get;set;}
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


		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'businessHoursId') {
							businessHoursId = parser.getText();
						} else if (text == 'caseId') {
							caseId = parser.getText();
                            if (caseId != null) {                                     
                                /* AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(caseId);   
                                if(getData != null && getData.data != null ) caseName = getData.data.caseNumber;  */
                                caseName  = AXAAPI_UtilityClass.getsObjectNameById(caseId, 'Case', 'caseNumber');
                            }
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
							elapsedTimeInMins = integer.valueOf(parser.getText());
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'isCompleted') {
                            string x = parser.getText();
                            isCompleted = Boolean.valueOf(x);
                        } else if (text == 'isDeleted') {
                            string y = parser.getText();
                            isDeleted = Boolean.valueOf(y);
                        } else if (text == 'isViolated') {
                            string z = parser.getText();
                            isViolated = Boolean.valueOf(z);
                        } else if (text == 'lastModifiedById') {
                            lastModifiedById = parser.getText();
                        } else if (text == 'lastModifiedDate') {
                            lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'milestoneTypeId') {
							milestoneTypeId = parser.getText();
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
	public Data data {get;set;} 

	public AXAAPI012B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI012B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI012B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI012B_response(parser);
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