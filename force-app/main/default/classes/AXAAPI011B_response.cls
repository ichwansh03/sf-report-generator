public class AXAAPI011B_response {

	public class Data {
        //public String recordType {get;set;} 
         Public Data() {}
        
		public string accountId {get;set;}
        public Datetime activityDate {get;set;}
        public string aeS_SFConnector_AgentType_c {get;set;}
        public string aeS_SFConnector_Called_c {get;set;}
        public string aeS_SFConnector_Caller_c {get;set;}
        public string aeS_SFConnector_UCID_c {get;set;}
        public string aeS_SFConnector_UUI_c {get;set;}
        public string agI_Send_Survey_c {get;set;}
        public string apI_Status_c {get;set;}
        public string call_Duration_Second_c {get;set;}
        public string call_Type_c {get;set;}
        public Boolean callback_c {get;set;}
        public string callDisposition {get;set;}
        public string callDurationInSeconds {get;set;}
        public string callObject {get;set;}
        public string callType {get;set;}
        public string createdById {get;set;}
        public Datetime createdDate {get;set;}
        public string customer_IVR_c {get;set;}
        public string description {get;set;}
        public string des_c {get;set;}
        public string duration_Call_c {get;set;}
        public string duration_Dial_c {get;set;}
        public string duration_Hold_c {get;set;}
        public string duration_in_Minute_c {get;set;}
        public string duration_Wait_c {get;set;}
        public Datetime end_Calling_c {get;set;}
        public string end_Calling_Text_c {get;set;}
        public string entity_c {get;set;}
        public string Email {get;set;}
        public string external_ID_c {get;set;}
        public string from_c {get;set;}
        public string hari_c {get;set;}
        public string id {get;set;}
        public string interval_c {get;set;}
        public Boolean isArchived {get;set;}
        public Boolean isClosed {get;set;}
        public Boolean isDeleted {get;set;}
        public Boolean isHighPriority {get;set;}
        public Boolean isRecurrence {get;set;}
        public Boolean isReminderSet {get;set;}
        public string languange_c {get;set;}
        public string lastModifiedById {get;set;}
        public Datetime lastModifiedDate {get;set;}
        public Boolean manual_Insert_c {get;set;}
        public string owner_Entity_c {get;set;}
        public string ownerId {get;set;}
        public string policy_No_c {get;set;}
        public Boolean pQ_1_No_c {get;set;}
        public Boolean pQ_1_Yes_c {get;set;}
        public Boolean pQ_2_No_c {get;set;}
        public Boolean pQ_2_Yes_c {get;set;}
        public Boolean pQ_3_No_c {get;set;}
        public Boolean pQ_3_Yes_c {get;set;}
        public Boolean pQ_4_No_c {get;set;}
        public Boolean pQ_4_Yes_c {get;set;}
        public Boolean pQ_5_No_c {get;set;}
        public Boolean pQ_5_Yes_c {get;set;}
        public string priority {get;set;}
        public string purecloud_Call_ID_c {get;set;}
        public Datetime purecloud_Created_Date_c {get;set;}
        public string pureCloud_Hold_API_c {get;set;}
        public string pureCloud_Interaction_Link_c {get;set;}
        public string purecloud_Participant_ID_c {get;set;}
        public string pureCloud_Question1_c {get;set;}
        public string pureCloud_Question2_c {get;set;}
        public string pureCloud_Question3_c {get;set;}
        public string pureCloud_Question4_c {get;set;}
        public string pureCloud_Question5_c {get;set;}
        public string pureCloud_Survey_c {get;set;}
        public string pureCloud_Verint_Link_c {get;set;}
        public string queue_ID_c {get;set;}
        public string queue_PureCloud_c {get;set;}
        public string recording_URL_c {get;set;}
        public string recordTypeId {get;set;}
        public string recurrenceActivityId {get;set;}
        public string recurrenceDayOfMonth {get;set;}
        public string recurrenceDayOfWeekMask {get;set;}
        public Datetime recurrenceEndDateOnly {get;set;}
        public string recurrenceInstance {get;set;}
        public string recurrenceInterval {get;set;}
        public string recurrenceMonthOfYear {get;set;}
        public string recurrenceRegeneratedType {get;set;}
        public Datetime recurrenceStartDateOnly {get;set;}
        public string recurrenceTimeZoneSidKey {get;set;}
        public string recurrenceType {get;set;}
        public string running_By_c {get;set;}
        public string siP_c {get;set;}
        public string skill_c {get;set;}
        public string softphone_Type_c {get;set;}
        public Datetime start_Calling_c {get;set;}
        public string start_Calling_Text_c {get;set;}
        public Datetime start_Dialing_c {get;set;}
        public string start_Dialing_Text_c {get;set;}
        public string status {get;set;}
        public string subject {get;set;}
        public Datetime systemModstamp {get;set;}
        public Datetime tanggal_c {get;set;}
        public string taskSubtype {get;set;}
        public string to_c {get;set;}
        public Datetime transfer_Date_c {get;set;}
        public string transfer_From_c {get;set;}
        public string transfer_To_c {get;set;}
        public string whatId {get;set;}
        public string whoId {get;set;}
        
        Public string Owner_name {get;set;}
        Public string Who_name {get;set;}
        Public string whoPhone {get;set;}
        Public string whoEmail {get;set;}
        Public string What_name {get;set;}
        Public string CreatedBy_name {get;set;}
        Public string LastModifiedBy_name {get;set;}
       	Public string phone_number {get;set;}
        Public String relatedto_name {get;set;}
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'accountId') {
                        accountId = parser.getText();
                    } else if (text == 'activityDate') {
                        activityDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'aeS_SFConnector__AgentType__c') {
                        aeS_SFConnector_AgentType_c = parser.getText();
                    } else if (text == 'aeS_SFConnector__Called__c') {
                        aeS_SFConnector_Called_c = parser.getText();
                    } else if (text == 'aeS_SFConnector__Caller__c') {
                        aeS_SFConnector_Caller_c = parser.getText();
                    } else if (text == 'aeS_SFConnector__UCID__c') {
                        aeS_SFConnector_UCID_c = parser.getText(); 
                    } else if (text == 'aeS_SFConnector__UUI__c') {
                        aeS_SFConnector_UUI_c = parser.getText();
                    } else if (text == 'agI_Send_Survey__c') {
                        agI_Send_Survey_c = parser.getText();
                    } else if (text == 'apI_Status__c') {
                        apI_Status_c = parser.getText();
                    } else if (text == 'call_Duration_Second__c') {
                        call_Duration_Second_c = parser.getText();
                    }else if (text == 'phone') {
                        phone_number = parser.getText();
                    }
                                            
                    else if (text == 'call_Type__c') {
                        call_Type_c = parser.getText();
                    } else if (text == 'callback__c') {
                        String a = parser.getText();
                        callback_c = Boolean.valueOf(a);
                    } else if (text == 'callDisposition') {
                        callDisposition = parser.getText();
                    } else if (text == 'callDurationInSeconds') {
                        callDurationInSeconds = parser.getText();
                    } else if (text == 'callObject') {
                        callObject = parser.getText();
                    } else if (text == 'callType') {
                        callType = parser.getText();   
                    } else if (text == 'createdById') {
                        createdById = parser.getText();
                         if (createdById != null) CreatedBy_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
                    } else if (text == 'createdDate') {
                        createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'customer_IVR__c') {
                        customer_IVR_c = parser.getText();
                    } else if (text == 'description') {
                        description = parser.getText();
                        
                        des_c = description.replace('\n','<br/>'); 
                        //des_c = description.replace
                    } else if (text == 'email') {
                        email = parser.getText();
                    }					                  
                    else if (text == 'duration_Call__c') {
                        duration_Call_c = parser.getText();
                    } else if (text == 'duration_Dial__c') {
                        duration_Dial_c = parser.getText();
                    } else if (text == 'duration_Hold__c') {
                        duration_Hold_c = parser.getText();
                    } else if (text == 'duration_in_Minute__c') {
                        duration_in_Minute_c = parser.getText();
                    } else if (text == 'duration_Wait__c') {
                        duration_Wait_c = parser.getText();
                    } else if (text == 'end_Calling__c') {
                        end_Calling_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText()); 
                    } else if (text == 'end_Calling_Text__c') {
                        end_Calling_Text_c = parser.getText();
                    } else if (text == 'entity__c') {
                        entity_c = parser.getText();
                    } else if (text == 'external_ID__c') {
                        external_ID_c = parser.getText();
                    } else if (text == 'from__c') {
                        from_c = parser.getText();
                    }
                    
                    
                    else if (text == 'hari__c') {
                        hari_c = parser.getText();
                    } else if (text == 'id') {
                        id = parser.getText();
                    } else if (text == 'interval__c') {
                        interval_c = parser.getText();
                    } else if (text == 'isArchived') {
                        String a = parser.getText();
                        isArchived = Boolean.valueOf(a);
                    } else if (text == 'isClosed') {
                        String a = parser.getText();
                        isClosed = Boolean.valueOf(a);
                    } else if (text == 'isDeleted') {
                        String a = parser.getText();
                        isDeleted = Boolean.valueOf(a);    
                    } else if (text == 'isHighPriority') {
                        String a = parser.getText();
                        isHighPriority = Boolean.valueOf(a);
                    } else if (text == 'isRecurrence') {
                        String a = parser.getText();
                        isRecurrence = Boolean.valueOf(a);
                    } else if (text == 'isReminderSet') {
                        String a = parser.getText();
                        isReminderSet = Boolean.valueOf(a);
                    } else if (text == 'languange__c') {
                        languange_c = parser.getText();
                    }
                    
                    else if (text == 'lastModifiedById') {
                        lastModifiedById = parser.getText(); 
                         if (lastModifiedById != null) LastModifiedBy_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
                    } else if (text == 'lastModifiedDate') {
                        lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'manual_Insert__c') {
                        String a = parser.getText();
                        manual_Insert_c = Boolean.valueOf(a);
                    } else if (text == 'owner_Entity__c') {
                        owner_Entity_c = parser.getText();
                    } else if (text == 'ownerId') {
                        ownerId = parser.getText();
                        if (ownerId != null) owner_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'User', 'Name');
                    } else if (text == 'policy_No__c') {
                        policy_No_c = parser.getText();   
                    } else if (text == 'pQ_1_No__c') {
                        String a = parser.getText();
                        pQ_1_No_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_1_Yes__c') {
                        String a = parser.getText();
                        pQ_1_Yes_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_2_No__c') {
                        String a = parser.getText();
                        pQ_2_No_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_2_Yes__c') {
                        String a = parser.getText();
                        pQ_2_Yes_c = Boolean.valueOf(a);
                    }
                        
                    
                    else if (text == 'pQ_3_No__c') {
                        String a = parser.getText();
                        pQ_3_No_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_3_Yes__c') {
                        String a = parser.getText();
                        pQ_3_Yes_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_4_No__c') {
                        String a = parser.getText();
                        pQ_4_No_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_4_Yes__c') {
                        String a = parser.getText();
                        pQ_4_Yes_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_5_No__c') {
                        String a = parser.getText();
                        pQ_5_No_c = Boolean.valueOf(a);
                    } else if (text == 'pQ_5_Yes__c') {
                        String a = parser.getText();
                        pQ_5_Yes_c = Boolean.valueOf(a);
                    } else if (text == 'priority') {
                        priority = parser.getText();
                    } else if (text == 'purecloud_Call_ID__c') {
                        purecloud_Call_ID_c = parser.getText();
                    } else if (text == 'purecloud_Created_Date__c') {
                        purecloud_Created_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'pureCloud_Hold_API__c') {
                        pureCloud_Hold_API_c = parser.getText();
                    }
                    
                    else if (text == 'pureCloud_Interaction_Link__c') {
                        pureCloud_Interaction_Link_c = parser.getText();
                    } else if (text == 'purecloud_Participant_ID__c') {
                        purecloud_Participant_ID_c = parser.getText();
                    } else if (text == 'pureCloud_Question1__c') {
                        pureCloud_Question1_c = parser.getText();
                    } else if (text == 'pureCloud_Question2__c') {
                        pureCloud_Question2_c = parser.getText(); 
                    } else if (text == 'pureCloud_Question3__c') {
                        pureCloud_Question3_c = parser.getText();
                    } else if (text == 'pureCloud_Question4__c') {
                        pureCloud_Question4_c = parser.getText();    
                    } else if (text == 'pureCloud_Question5__c') {
                        pureCloud_Question5_c = parser.getText();
                    } else if (text == 'pureCloud_Survey__c') {
                        pureCloud_Survey_c = parser.getText();
                    } else if (text == 'pureCloud_Verint_Link__c') {
                        pureCloud_Verint_Link_c = parser.getText();
                    } else if (text == 'queue_ID__c') {
                        queue_ID_c = parser.getText();
                    }
                    
                    else if (text == 'queue_PureCloud__c') {
                        queue_PureCloud_c = parser.getText();
                    } else if (text == 'recording_URL__c') {
                        recording_URL_c = parser.getText();
                    } else if (text == 'recordTypeId') {
                        recordTypeId = parser.getText();
                    } else if (text == 'recurrenceActivityId') {
                        recurrenceActivityId = parser.getText();
                    } else if (text == 'recurrenceDayOfMonth') {
                        recurrenceDayOfMonth = parser.getText();
                    } else if (text == 'recurrenceDayOfWeekMask') {
                        recurrenceDayOfWeekMask = parser.getText(); 
                    } else if (text == 'recurrenceEndDateOnly') {
                        recurrenceEndDateOnly = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'recurrenceInstance') {
                        recurrenceInstance = parser.getText();
                    } else if (text == 'recurrenceInterval') {
                        recurrenceInterval = parser.getText();
                    } else if (text == 'recurrenceMonthOfYear') {
                        recurrenceMonthOfYear = parser.getText();
                    }
                    
                    else if (text == 'recurrenceRegeneratedType') {
                        recurrenceRegeneratedType = parser.getText();
                    } else if (text == 'recurrenceStartDateOnly') {
                        recurrenceStartDateOnly = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'recurrenceTimeZoneSidKey') {
                        recurrenceTimeZoneSidKey = parser.getText();
                    } else if (text == 'recurrenceType') {
                        recurrenceType = parser.getText(); 
                    } else if (text == 'running_By__c') {
                        running_By_c = parser.getText();
                    } else if (text == 'siP__c') {
                        siP_c = parser.getText();   
                    } else if (text == 'skill__c') {
                        skill_c = parser.getText();
                    } else if (text == 'softphone_Type__c') {
                        softphone_Type_c = parser.getText();
                    } else if (text == 'start_Calling__c') {
                        start_Calling_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'start_Calling_Text__c') {
                        start_Calling_Text_c = parser.getText();
                    }
                    
                    else if (text == 'start_Dialing__c') {
                        start_Dialing_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'start_Dialing_Text__c') {
                        start_Dialing_Text_c = parser.getText();
                    } else if (text == 'status') {
                        status = parser.getText();
                    } else if (text == 'subject') {
                        subject = parser.getText();
                    } else if (text == 'systemModstamp') {
                        systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'tanggal__c') {
                        tanggal_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'taskSubtype') {
                        taskSubtype = parser.getText();
                    } else if (text == 'to__c') {
                        to_c = parser.getText();
                    } else if (text == 'transfer_Date__c') {
                        transfer_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                    } else if (text == 'transfer_From__c') {
                        transfer_From_c = parser.getText();
                    }						
                    
                    else if (text == 'transfer_To__c') {
                        transfer_To_c = parser.getText();
                    } else if (text == 'whatId') {
                        whatId = parser.getText();
                        if(whatId != NULL && whatId.left(3) == Schema.SObjectType.Case.getKeyPrefix()){ 
                            if (whatId != null) {                                     
                                AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(whatId);   
                                if(getData != null && getData.data != null ) relatedto_name = getData.data.caseNumber;  
                            }  
                         	// relatedto_name = AXAAPI_UtilityClass.getsObjectNameById(whatId, 'Case', 'CaseNumber');
                        }ELSE if(whatId != NULL && whatId.left(3) == Schema.SObjectType.Contact.getKeyPrefix()){
                         	relatedto_name = AXAAPI_UtilityClass.getsObjectNameById(whatId, 'Contact', 'Name');
                        }ELSE if(whatId != NULL && whatId.left(3) == Schema.SObjectType.User.getKeyPrefix()){
                         	relatedto_name = AXAAPI_UtilityClass.getsObjectNameById(whatId, 'User', 'Name');
                        }ELSE if(whatId != NULL && whatId.left(3) == Schema.SObjectType.Call_Line__c.getKeyPrefix()){
                         	// relatedto_name = AXAAPI_UtilityClass.getsObjectNameById(whatId, 'Call_Line__c', 'Name');
                            
                            if (whatId != null) {                                     
                                AXAAPI023B_response getData  = AXAAPI023B_CallListByID.getCallListByID(whatId);   
                                if(getData != null && getData.data != null ) relatedto_name = getData.data.Name;  
                            }
                        }  
                        
                        
                    } else if (text == 'whoId') {
                        whoId = parser.getText();
                        if (whoId != null) {
                            who_name = AXAAPI_UtilityClass.getsObjectNameById(whoId, 'Contact', 'Name');
                            whoPhone = AXAAPI_UtilityClass.getsObjectNameById(whoId, 'Contact', 'phone');
                            whoEmail = AXAAPI_UtilityClass.getsObjectNameById(whoId, 'Contact', 'email');
                        }
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
	public Data data {get;set;} 

	public AXAAPI011B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI011A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI011B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI011B_response(parser);
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