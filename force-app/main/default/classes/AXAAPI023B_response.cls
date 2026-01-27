public class AXAAPI023B_response {
	
	public class Data {
        Public Data() {}
        Public String activity_c{get;set;}
        Public String activity_Config_c{get;set;}
        Public String call_Line_RecordTypeID_c{get;set;}
        Public String campaign_Name_c{get;set;}
        Public String campaign_Temp_c{get;set;}
        Public String case_Type_c{get;set;}
        Public String case_Type_Config_c{get;set;}
        Public String count_Data_c{get;set;}
        Public String count_Failed_Upload_c{get;set;}
        Public String count_Invalid_c{get;set;}
        Public String count_Upload_c{get;set;}
        Public String createdById{get;set;}
        Public Datetime createdDate{get;set;}
        Public Boolean delete_Call_Line_c{get;set;}
        Public String entity_c{get;set;}
        Public Datetime expired_Date_c{get;set;}
        Public Boolean freeze_Update_Status_Paid_c{get;set;}
        Public Datetime generated_Date_c{get;set;}
        Public String id{get;set;}
        Public Boolean is_Expired_F_c{get;set;}
        Public Boolean isDeleted{get;set;}
        Public Boolean isExpired_c{get;set;}
        Public String lastModifiedById{get;set;}
        Public Datetime lastModifiedDate{get;set;}
        Public Datetime lastReferencedDate{get;set;}
        Public Datetime lastViewedDate{get;set;}
        Public Datetime list_Date_c{get;set;}
        Public String max_Count_Coll_AMFS_c{get;set;}
        Public String name{get;set;}
        Public String ownerId{get;set;}
        Public Boolean queue_c{get;set;}
        Public String recordTypeId{get;set;}
        Public String recordTypeName{get;set;}
        Public Boolean refresh_Parent_c{get;set;}
        Public String report_ID_c{get;set;}
        Public Datetime systemModstamp{get;set;}
        Public Boolean update_Agent_Child_c{get;set;}
        Public Boolean welcomeCall_Fg_Automatic_c{get;set;}
        Public String Owner_name {get;set;}
        Public String CreatedBy_name {get;set;}
		Public String LastModified_name {get;set;}
        
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						IF (text == 'activity__c') { activity_c = parser.getText();}
                        ElSE IF (text == 'activity_Config__c') { activity_Config_c = parser.getText();}
                        ElSE IF (text == 'call_Line_RecordTypeID__c') { call_Line_RecordTypeID_c = parser.getText();}
                        ElSE IF (text == 'campaign_Name__c') { campaign_Name_c = parser.getText();}
                        ElSE IF (text == 'campaign_Temp__c') { campaign_Temp_c = parser.getText();}
                        ElSE IF (text == 'case_Type__c') { case_Type_c = parser.getText();}
                        ElSE IF (text == 'case_Type_Config__c') { case_Type_Config_c = parser.getText();}
                        ElSE IF (text == 'count_Data__c') { count_Data_c = parser.getText();}
                        ElSE IF (text == 'count_Failed_Upload__c') { count_Failed_Upload_c = parser.getText();}
                        ElSE IF (text == 'count_Invalid__c') { count_Invalid_c = parser.getText();}
                        ElSE IF (text == 'count_Upload__c') { count_Upload_c = parser.getText();}
                        ElSE IF (text == 'createdById') { 
                            createdById = parser.getText();
                        	if (createdById != null) Createdby_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'user', 'name');
                        }
                        ElSE IF (text == 'createdDate') { createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'delete_Call_Line__c') { 
                        			String a = parser.getText();
                                    delete_Call_Line_c = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'entity__c') { entity_c = parser.getText();}
                        ElSE IF (text == 'expired_Date__c') { expired_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'freeze_Update_Status_Paid__c') { 
                        			String a = parser.getText();
                                    freeze_Update_Status_Paid_c = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'generated_Date__c') { generated_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'id') { id = parser.getText();}
                        ElSE IF (text == 'is_Expired_F__c') { 
                            		String a = parser.getText();
                                    is_Expired_F_c = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'isDeleted') { 
                        			String a = parser.getText();
                                    isDeleted = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'isExpired__c') { 
                        			String a = parser.getText();
                                    isExpired_c = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'lastModifiedById') { 
                            lastModifiedById = parser.getText();
                        	if (lastModifiedById != null) LastModified_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'user', 'name');
                        }
                        ElSE IF (text == 'lastModifiedDate') { lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'lastReferencedDate') { lastReferencedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'lastViewedDate') { lastViewedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'list_Date__c') { list_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'max_Count_Coll_AMFS__c') { max_Count_Coll_AMFS_c = parser.getText();}
                        ElSE IF (text == 'name') { name = parser.getText();}
                        ElSE IF (text == 'ownerId') { 
                            ownerId = parser.getText();
                        	if (ownerId != null) owner_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'user', 'name');
                        }
                        ElSE IF (text == 'queue__c') { 
                        			String a = parser.getText();
                                    queue_c = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'recordTypeId') {
                            recordTypeId = parser.getText();
                            if (recordTypeId != null) recordTypeName = AXAAPI_UtilityClass.getsObjectNameById(recordTypeId, 'recordType', 'name');
                        }
                        ElSE IF (text == 'refresh_Parent__c') { 
                        			String a = parser.getText();
                                    refresh_Parent_c = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'report_ID__c') { report_ID_c = parser.getText();}
                        ElSE IF (text == 'systemModstamp') { systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'update_Agent_Child__c') { 
                        			String a = parser.getText();
                                    refresh_Parent_c = Boolean.valueOf(a);
                        }
                        ElSE IF (text == 'welcomeCall_Fg_Automatic__c') { 
                        			String a = parser.getText();
                                    refresh_Parent_c = Boolean.valueOf(a);

                        }ELSE{
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
 

	public AXAAPI023B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI023B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI023B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI023B_response(parser);
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