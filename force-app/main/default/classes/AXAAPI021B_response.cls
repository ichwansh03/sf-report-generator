public class AXAAPI021B_response {
	//public AXAAPI021B_response(){}	
	public class Data {
        Public Data() {}
        //public String recordType {get;set;} 
        public String abandoned {get;set;}
        public String accountId {get;set;}
        public String averageResponseTimeOperator {get;set;}
        public String averageResponseTimeVisitor {get;set;}
        public String body {get;set;}
        public String body_Custom_c {get;set;}
        public String browser {get;set;}
        public String browserLanguage {get;set;}
        public String caseId {get;set;}
        public String channel_Type_c {get;set;}
        public String chatDuration {get;set;}
        public String chatKey {get;set;}
        public String check_Status_c {get;set;}
        public String contactId {get;set;}
        public Datetime created_Date_c {get;set;}
        public String createdById {get;set;}
        public Datetime createdDate {get;set;}
        public Datetime createdDateTime_c {get;set;}
        public String endedBy {get;set;}
        public Datetime endTime {get;set;}
        public String endTimeOnly_c {get;set;}
        public String entity_c {get;set;}
        public String entity_Backup_c {get;set;}
        public String id {get;set;}
        public String interval_c {get;set;}
         public String interval_chat_c {get;set;}
        
        public String ipAddress {get;set;}
        public Boolean isDeleted {get;set;}
        public String lastModifiedById {get;set;}
        public Datetime lastModifiedDate {get;set;}
        public Datetime lastReferencedDate {get;set;}
        public Datetime lastViewedDate {get;set;}
        public String lead_Time_c {get;set;}
        public String leadId {get;set;}
        public String list_Agent_c {get;set;}
        public String live_Chat_Transcript_in_Hours_c {get;set;}
        public String liveChatButtonId {get;set;}
        public String liveChatDeploymentId {get;set;}
        public String liveChatVisitorId {get;set;}
		public String liveChatVisitorName {get;set;}
        public String location {get;set;}
        public String maxResponseTimeOperator {get;set;}
        public String maxResponseTimeVisitor {get;set;}
        public String name {get;set;}
        public String operatorMessageCount {get;set;}
        public String ownerId {get;set;}
        public String platform {get;set;}
        public Boolean ready_to_Send_c {get;set;}
        public String referrerUri {get;set;}
        public String refresh_Manual_c {get;set;}
        public Datetime requestTime {get;set;}
        public String screenResolution {get;set;}
        public Boolean send_Email_c {get;set;}
        public String skillId {get;set;}
        public String skill_name {get;set;}
        public String start_Eng_c {get;set;}
        public String start_Ind_c {get;set;}
        public Datetime startTime {get;set;}
        public Datetime startTimeOnly_c {get;set;}
        public String status {get;set;}
        public String supervisorTranscriptBody {get;set;}
        public Datetime systemModstamp {get;set;}
        public String ticket_Number_c {get;set;}
        public Boolean triggerOff_c {get;set;}
        public String userAgent {get;set;}
        public String visitor_Email_c {get;set;}
        public String visitor_KodeAgent_c {get;set;}
        public String visitor_Name_c {get;set;}
        public String visitor_Phone_Number_c {get;set;}
        public String visitorMessageCount {get;set;}
        public String waitTime {get;set;}
        public String VisitorNetwork {get;set;} 
        //public String VisitorNetwork_c {get;set;} 
        public String account_name {get;set;}
        public String contact_name {get;set;}
        public String case_name {get;set;}
        public String lead_name {get;set;}
        public String deployement_name {get;set;}
        public String chatbutton_name {get;set;}
        public String primaryskill_name {get;set;}
        public String chatvisitor_name {get; set;}
        public String owner_name {get;set;}
        public String createdby_name {get;set;}
        public String lastmodifiedby_name {get;set;}
        public String History_Chatbot_c {get;set;}
        
      
        
            public Data(JSONParser parser) {
                while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                    if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                        String text = parser.getText();
                        if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                            if (text == 'abandoned') {
                               abandoned = parser.getText();
                            } else if (text == 'accountId') {
                               accountId = parser.getText();
                                if (accountId != null) account_name = AXAAPI_UtilityClass.getsObjectNameById(accountId, 'Account', 'name');
                            } else if (text == 'averageResponseTimeOperator') {
                               averageResponseTimeOperator = parser.getText();
                               if(averageResponseTimeOperator != '') {
                                   averageResponseTimeOperator = averageResponseTimeOperator+' Seconds';
                               }
                            } else if (text == 'averageResponseTimeVisitor') {
                               averageResponseTimeVisitor = parser.getText();
                               if(averageResponseTimeVisitor != '') {
                                   averageResponseTimeVisitor = averageResponseTimeVisitor+' Seconds';
                               }
                            } else if (text == 'body') {
                               body = parser.getText();
                            } else if (text == 'body_Custom__c') {
                               body_Custom_c = parser.getText();
                            } else if (text == 'browser') {
                               browser = parser.getText();
                            } else if (text == 'browserLanguage') {
                               browserLanguage = parser.getText();
                            } else if (text == 'caseId') {
                               caseId = parser.getText();
                                
                                /* if (caseId != null) {                                     
                                    AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(caseId);   
                                    if(getData != null && getData.data != null ) case_name = getData.data.caseNumber;  
                                }*/
                               if (caseId != null) case_name = AXAAPI_UtilityClass.getsObjectNameById(caseId, 'Case', 'caseNumber');
                            } else if (text == 'channel_Type__c') {
                               channel_Type_c = parser.getText();
                            } else if (text == 'chatDuration') {
                               chatDuration = parser.getText();
                               if(chatDuration != '') {
                                   chatDuration = chatDuration+' Seconds';
                               }
                            } else if (text == 'chatKey') {
                               chatKey = parser.getText();
                            } else if (text == 'check_Status__c') {
                               check_Status_c = parser.getText();
                            } else if (text == 'contactId') {
                               contactId = parser.getText();
                               if (contactId != null) contact_name = AXAAPI_UtilityClass.getsObjectNameById(contactId, 'Contact', 'name'); 
                            } else if (text == 'created_Date__c') {
                               created_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'createdById') {
                               createdById = parser.getText();
                               if (createdById != null) createdby_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'name');
                            } else if (text == 'createdDate') {
                               createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'createdDateTime__c') {
                               createdDateTime_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'endedBy') {
                               endedBy = parser.getText();
                            } else if (text == 'endTime') {
                               endTime = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'endTimeOnly__c') {
                               endTimeOnly_c = parser.getText();
                            } else if (text == 'entity__c') {
                               entity_c = parser.getText();
                            } else if (text == 'entity_Backup__c') {
                               entity_Backup_c = parser.getText();
                            } else if (text == 'id') {
                               id = parser.getText();
                            } else if (text == 'interval__c') {
                               interval_c = parser.getText();
                            }else if (text == 'interval_chat__c') {
                               interval_chat_c = parser.getText();
                            } else if (text == 'ipAddress') {
                               ipAddress = parser.getText();
                            } else if (text == 'isDeleted') {
                               String a = parser.getText();
                               isDeleted = Boolean.valueOf(a);
                            } else if (text == 'lastModifiedById') {
                               lastModifiedById = parser.getText();
                                if (lastModifiedById != null) lastmodifiedby_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'name');
                            } else if (text == 'lastModifiedDate') {
                               lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'lastReferencedDate') {
                               lastReferencedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'lastViewedDate') {
                               lastViewedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'lead_Time__c') {
                               lead_Time_c = parser.getText();
                            } else if (text == 'leadId') {
                               leadId = parser.getText();
                               if (leadId != null) lead_name = AXAAPI_UtilityClass.getsObjectNameById(leadId, 'Lead', 'Name');
                            } else if (text == 'list_Agent__c') {
                               list_Agent_c = parser.getText();
                            } else if (text == 'live_Chat_Transcript_in_Hours__c') {
                               live_Chat_Transcript_in_Hours_c = parser.getText();
                            } else if (text == 'liveChatButtonId') {
                               liveChatButtonId = parser.getText();
                                if (liveChatButtonId != null) chatbutton_name = AXAAPI_UtilityClass.getsObjectNameById(liveChatButtonId, 'LiveChatButton', 'DeveloperName');
                            } else if (text == 'liveChatDeploymentId') {
                               liveChatDeploymentId = parser.getText();
                                if (liveChatDeploymentId != null) deployement_name = AXAAPI_UtilityClass.getsObjectNameById(liveChatDeploymentId, 'LiveChatDeployment', 'DeveloperName');
                            } else if (text == 'liveChatVisitorId') {
                               liveChatVisitorId = parser.getText();
                                if (liveChatVisitorId != null) liveChatVisitorName = AXAAPI_UtilityClass.getsObjectNameById(liveChatVisitorId, 'livechatvisitor', 'name');
                                
                            } else if (text == 'location') {
                               location = parser.getText();
                            } else if (text == 'maxResponseTimeOperator') {
                               maxResponseTimeOperator = parser.getText();
                               if(maxResponseTimeOperator != '') {
                                   maxResponseTimeOperator = maxResponseTimeOperator+' Seconds';
                               }
                            } else if (text == 'maxResponseTimeVisitor') {
                               maxResponseTimeVisitor = parser.getText();
                               if(maxResponseTimeVisitor != '') {
                                   maxResponseTimeVisitor = maxResponseTimeVisitor+' Seconds';
                               }
                            } else if (text == 'name') {
                               name = parser.getText();
                            } else if (text == 'operatorMessageCount') {
                               operatorMessageCount = parser.getText();
                            } else if (text == 'ownerId') {
                               ownerId = parser.getText();
                               if (ownerId != null) owner_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'User', 'name');
                            } else if (text == 'platform') {
                               platform = parser.getText();
                            } else if (text == 'ready_to_Send__c') {
                                String a = parser.getText();
                               ready_to_Send_c = Boolean.valueOf(a);
                            } else if (text == 'referrerUri') {
                               referrerUri = parser.getText();
                            } else if (text == 'refresh_Manual__c') {
                               refresh_Manual_c = parser.getText();
                            } else if (text == 'requestTime') {
                               requestTime = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'screenResolution') {
                               screenResolution = parser.getText();
                            } else if (text == 'send_Email__c') {
                               String a = parser.getText();
                               send_Email_c = Boolean.valueOf(a);
                            } else if (text == 'skillId') {
                               skillId = parser.getText();
                                if (skillId != null) skill_name = AXAAPI_UtilityClass.getsObjectNameById(skillId, 'Skill', 'DeveloperName');
                            } else if (text == 'start_Eng__c') {
                               start_Eng_c = parser.getText();
                            } else if (text == 'start_Ind__c') {
                               start_Ind_c = parser.getText();
                            } else if (text == 'startTime') {
                               startTime = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'startTimeOnly__c') {
                               startTimeOnly_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'status') {
                               status = parser.getText();
                            } else if (text == 'supervisorTranscriptBody') {
                               supervisorTranscriptBody = parser.getText();
                            } else if (text == 'systemModstamp') {
                               systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                            } else if (text == 'ticket_Number__c') {
                               ticket_Number_c = parser.getText();
                            } else if (text == 'triggerOff__c') {
                               String a = parser.getText();
                               triggerOff_c = Boolean.valueOf(a);
                            } else if (text == 'userAgent') {
                               userAgent = parser.getText();
                            } else if (text == 'visitor_Email__c') {
                               visitor_Email_c = parser.getText();
                            } else if (text == 'visitor_KodeAgent__c') {
                               visitor_KodeAgent_c = parser.getText();
                            } else if (text == 'visitor_Name__c') {
                               visitor_Name_c = parser.getText();
                            } else if (text == 'visitor_Phone_Number__c') {
                               visitor_Phone_Number_c = parser.getText();
                            } else if (text == 'visitorMessageCount') {
                               visitorMessageCount = parser.getText();
                            } else if (text == 'waitTime') {
                               waitTime = parser.getText();
                               if(waitTime != '') {
                                   waitTime = waitTime+' Seconds';
                               }
                            } /*else if (text == 'VisitorNetwork') {
                               VisitorNetwork = parser.getText();
                            }*/
                            else if (text == 'visitorNetwork') {
                               VisitorNetwork = parser.getText();
                            }
                            else if (text == 'History_Chatbot__c') {
                               History_Chatbot_c = parser.getText();
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

	public AXAAPI021B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI021B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI021B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI021B_response(parser);
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