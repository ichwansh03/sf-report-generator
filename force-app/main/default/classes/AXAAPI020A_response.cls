/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Convert Json parse to data
*  @Class   AXAAPI020A_response 
*  @Return  Array
*/ 
public class AXAAPI020A_response {

	public class Data { 
        public string id {get;set;}  
        public string entity_c {get;set;}
        public string ACD_Count_c {get;set;}
        public string Agent_c {get;set;} 
        public string Agent_Name_c {get;set;}
        public string agentName {get;set;}
        public string Total_Available_Sum_c {get;set;}
        public string AHT_c {get;set;}
        public string AHT_Sum_c {get;set;}
        public string AVG_ACW_c {get;set;}
        public string AVG_Hold_c {get;set;}
        public string AVG_Talk_c {get;set;}
        public datetime End_Login_c {get;set;}
        public string Handle_Sum_c {get;set;}
        public string Hold_Sum_c {get;set;}
        public string Queue_PureCloud_c {get;set;}
        public datetime Start_Login_c {get;set;}
        public string Talk_Sum_c {get;set;}
        public string Total_Available_Time_c {get;set;}
        public string Total_Time_Staffed_c {get;set;}
        public string CreatedById {get;set;}
        public string LastModifiedById {get;set;}
        public string LastModifiedByName {get;set;}
        public string CreatedByName {get;set;}
        public datetime CreatedDate {get;set;}
        public datetime LastModifiedDate {get;set;}
        public string OwnerId {get;set;}
        public string OwnerName {get;set;}
        public string Name {get;set;}
 
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'id') {
                        id = parser.getText(); 
                    } 
                     else if ( text == 'CreatedById') {
                        CreatedById = parser.getText(); 
                        if (CreatedById != null) CreatedByName = AXAAPI_UtilityClass.getsObjectNameById(CreatedById, 'User', 'Name');
                    }else if ( text == 'LastModifiedById') {
                        LastModifiedById = parser.getText();
                        if (LastModifiedById != null) LastModifiedByName = AXAAPI_UtilityClass.getsObjectNameById(LastModifiedById, 'User', 'Name');
                    }else if ( text == 'CreatedDate') {
                        CreatedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    }else if ( text == 'LastModifiedDate') {
                        LastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    }else if ( text == 'OwnerId') {
                        OwnerId = parser.getText();
                        if (OwnerId != null) {
                            if (OwnerId.left(3) == Schema.SObjectType.user.getKeyPrefix()) {
                                OwnerName = AXAAPI_UtilityClass.getsObjectNameById(OwnerId, 'User', 'Name');
                            } else if (OwnerId.left(3) == Schema.SObjectType.Group.getKeyPrefix()) {
                                OwnerName = AXAAPI_UtilityClass.getsObjectNameById(OwnerId, 'Group', 'Name');
                            }
                        }
                    }else if ( text == 'Name') {
                        Name = parser.getText();
                    } else If(text == 'entity__c') {
                        entity_c = parser.getText();
                    } else If(text == 'ACD_Count__c') {
                        ACD_Count_c = parser.getText();
                    } else If(text == 'Agent__c') {
                        Agent_c = parser.getText();
                    }  else If(text == 'Agent_Name__c') {
                        Agent_Name_c = parser.getText();
                    } else If(text == 'agentName') {
                        agentName = parser.getText();
                    } else If(text == 'Total_Available_Sum__c') {
                        Total_Available_Sum_c = parser.getText();
                    } else If(text == 'AHT__c') {
                        AHT_c = parser.getText();
                    } else If(text == 'AHT_Sum__c') {
                        AHT_Sum_c = parser.getText();
                    } else If(text == 'AVG_ACW__c') {
                        AVG_ACW_c = parser.getText();
                    } else If(text == 'AVG_Hold__c') {
                        AVG_Hold_c = parser.getText();
                    } else If(text == 'AVG_Talk__c') {
                        AVG_Talk_c = parser.getText();
                    } else If(text == 'End_Login__c') {
                        End_Login_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else If(text == 'Handle_Sum__c') {
                        Handle_Sum_c = parser.getText();
                    } else If(text == 'Hold_Sum__c') {
                        Hold_Sum_c = parser.getText();
                    } else If(text == 'Queue_PureCloud__c') {
                        Queue_PureCloud_c = parser.getText();
                    } else If(text == 'Start_Login__c') {
                        Start_Login_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else If(text == 'Talk_Sum__c') {
                        Talk_Sum_c = parser.getText();
                    } else If(text == 'Total_Available_Time__c') {
                        Total_Available_Time_c = parser.getText();
                    } else If(text == 'Total_Time_Staffed__c') {
                        Total_Time_Staffed_c = parser.getText();
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
    public Integer counts {get;set;}

	public AXAAPI020A_response(JSONParser parser) {
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
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI020A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI020A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI020A_response(parser);
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