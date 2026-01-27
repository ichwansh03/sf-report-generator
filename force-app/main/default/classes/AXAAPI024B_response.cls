public class AXAAPI024B_response {
	
	public class Data {
        Public Data() {}
        Public String abandon_Count_20_Sec_c {get;set;}
        Public String abandon_Count_5_Sec_c {get;set;}
        Public integer abandon_Count_5_Sec_High_c {get;set;}
        Public Integer abandon_Count_c {get;set;}
        Public integer abandon_Sum_c {get;set;}
        Public String acD_Count_10_Secs_c {get;set;}
        Public String acD_Count_20_Sec_c {get;set;}
        Public integer acD_Count_20_Secs_c {get;set;}
        Public String acD_Count_30_Sec_c {get;set;}
        Public String acD_Count_5_Secs_c {get;set;}
        Public Integer acD_Count_c {get;set;}
        Public String acD_Sum_c {get;set;}
        Public integer acW_Count_c {get;set;}
        Public integer acW_Sum_c {get;set;}
        Public String ahT_c {get;set;}
        Public String ans_Calls_c {get;set;}
        Public String avg_Abandon_c {get;set;}
        Public String avG_ACD_c {get;set;}
        Public String avG_ACD_P_c {get;set;}
        Public integer avG_ACW_c {get;set;}
        Public String avG_Hold_c {get;set;}
        Public String avg_Speed_of_Answer_c {get;set;}
        Public integer avg_Talk_Time_c {get;set;}
        Public integer balance_c {get;set;}
        Public integer call_Offered_c {get;set;}
        Public integer callback_Count_c {get;set;}
        Public integer calls_Answered_Sum_c {get;set;}
        Public String createdById {get;set;}
        Public Datetime  createdDate {get;set;}
        Public Datetime  date_c {get;set;}
        Public String entity_c {get;set;}
        Public String external_ID_c {get;set;}
        Public integer extn_Out_Calls_c {get;set;}
        Public Integer flowOut_Count_c {get;set;}
        Public integer handle_Count_c {get;set;}
        Public integer handle_Sum_c {get;set;}
        Public integer hold_Count_c {get;set;}
        Public integer hold_Sum_c {get;set;}
        Public String id {get;set;}
        Public String interval_c {get;set;}
        Public Boolean isDeleted {get;set;}
        Public Datetime  lastActivityDate {get;set;}
        Public String lastModifiedById {get;set;}
        Public Datetime  lastModifiedDate {get;set;}
        Public Datetime  lastReferencedDate {get;set;}
        Public Datetime  lastViewedDate {get;set;}
        Public String name {get;set;}
        Public integer outbound_Call_c {get;set;}
        Public String ownerId {get;set;}
        Public String queue_Name_c {get;set;}
        Public String queueId_c {get;set;}
        Public String sL_80_20_c {get;set;}
        Public String sL_80_30_c {get;set;}
        Public String sL_90_20_c {get;set;}
        Public Datetime  systemModstamp {get;set;}
        Public integer talk_Count_c {get;set;}
        Public integer talk_Sum_c {get;set;}
        Public String temp_aux_c {get;set;}
        Public integer transferred_Out_c {get;set;}
        
        
        public String Ownerid_name {get;set;}
        public String CreatedBy_name {get;set;}
        public String lastmodifiedby_name {get;set;}

        

        
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						IF (text == 'abandon_Count_20_Sec__c') { abandon_Count_20_Sec_c= parser.getText();}
                        ElSE IF (text == 'abandon_Count_5_Sec__c') { abandon_Count_5_Sec_c= parser.getText();}
                        ElSE IF (text == 'abandon_Count_5_Sec_High__c') { abandon_Count_5_Sec_High_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'abandon_Count__c') { abandon_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'abandon_Sum__c') { abandon_Sum_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'acD_Count_10_Secs__c') { acD_Count_10_Secs_c= parser.getText();}
                        ElSE IF (text == 'acD_Count_20_Sec__c') { acD_Count_20_Sec_c= parser.getText();}
                        ElSE IF (text == 'acD_Count_20_Secs__c') { acD_Count_20_Secs_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'acD_Count_30_Sec__c') { acD_Count_30_Sec_c= parser.getText();}
                        ElSE IF (text == 'acD_Count_5_Secs__c') { acD_Count_5_Secs_c= parser.getText();}
                        ElSE IF (text == 'acD_Count__c') { acD_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'acD_Sum__c') { acD_Sum_c= parser.getText();}
                        ElSE IF (text == 'acW_Count__c') { acW_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'acW_Sum__c') { acW_Sum_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'ahT__c') { ahT_c= parser.getText();}
                        ElSE IF (text == 'ans_Calls__c') { 
                            ans_Calls_c= parser.getText();
                        	ans_Calls_c = ans_Calls_c +'%';
                        }
                        ElSE IF (text == 'avg_Abandon__c') { avg_Abandon_c= parser.getText();}
                        ElSE IF (text == 'avG_ACD__c') { 
                            avG_ACD_c= parser.getText();
                            avG_ACD_c = avG_ACD_c + '%';
                        }
                        ElSE IF (text == 'avG_ACD_P__c') { 
                            avG_ACD_P_c= parser.getText();
                        	avG_ACD_P_c = avG_ACD_P_c + '%';	
                        }
                        ElSE IF (text == 'avG_ACW__c') { avG_ACW_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'avG_Hold__c') { avG_Hold_c= parser.getText();}
                        ElSE IF (text == 'avg_Speed_of_Answer__c') { avg_Speed_of_Answer_c= parser.getText();}
                        ElSE IF (text == 'avg_Talk_Time__c') { avg_Talk_Time_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'balance__c') { balance_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'call_Offered__c') { call_Offered_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'callback_Count__c') { callback_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'calls_Answered_Sum__c') { calls_Answered_Sum_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'createdById') { 
                            createdById= parser.getText();
                        	if (createdById != null) createdby_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'user', 'name');
                        }
                        ElSE IF (text == 'createdDate') { createdDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'date__c') { date_c= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'entity__c') { entity_c= parser.getText();}
                        ElSE IF (text == 'external_ID__c') { external_ID_c= parser.getText();}
                        ElSE IF (text == 'extn_Out_Calls__c') { extn_Out_Calls_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'flowOut_Count__c') { flowOut_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'handle_Count__c') { handle_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'handle_Sum__c') { handle_Sum_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'hold_Count__c') { hold_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'hold_Sum__c') { hold_Sum_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'id') { id = parser.getText();}
                        ElSE IF (text == 'interval__c') { interval_c= parser.getText();}
                        ElSE IF (text == 'isDeleted') {      
                            		String a = parser.getText();
                                    isDeleted = Boolean.valueOf(a);}
                        ElSE IF (text == 'lastActivityDate') { lastActivityDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'lastModifiedById') { 
                            lastModifiedById= parser.getText();
                        	if (lastModifiedById != null) lastmodifiedby_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'user', 'name');
                        }
                        ElSE IF (text == 'lastModifiedDate') { lastModifiedDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'lastReferencedDate') { lastReferencedDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'lastViewedDate') { lastViewedDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'name') { name= parser.getText();}
                        ElSE IF (text == 'outbound_Call__c') { outbound_Call_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'ownerId') { 
                            ownerId= parser.getText();
                            if (ownerId != null) ownerId_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'user', 'name');
                        }
                        ElSE IF (text == 'queue_Name__c') { queue_Name_c= parser.getText();}
                        ElSE IF (text == 'queueId__c') { queueId_c= parser.getText();}
                        ElSE IF (text == 'sL_80_20__c') { 
                            sL_80_20_c= parser.getText();
                            sL_80_20_c=sL_80_20_c+'%';
                        }
                        ElSE IF (text == 'sL_80_30__c') { 
                            sL_80_30_c= parser.getText();
                            sL_80_30_c=sL_80_30_c+'%';                           
                                                        }
                        ElSE IF (text == 'sL_90_20__c') { 
                            sL_90_20_c= parser.getText();
                        	sL_90_20_c=sL_90_20_c+'%'; 
                        }
                        ElSE IF (text == 'systemModstamp') { systemModstamp= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'talk_Count__c') { talk_Count_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'talk_Sum__c') { talk_Sum_c= integer.valueOf(parser.getText());}
                        ElSE IF (text == 'temp_aux__c') { temp_aux_c= parser.getText();}
                        ElSE IF (text == 'transferred_Out__c') { transferred_Out_c= integer.valueOf(parser.getText());}
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
	public Data data {get;set;} 
 

	public AXAAPI024B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI024B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI024B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI024B_response(parser);
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