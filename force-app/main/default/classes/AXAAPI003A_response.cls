public class AXAAPI003A_response {

    public class Data{
        
        Public String account_c {get;set;}
        Public String agent_Name_c {get;set;}
        Public String all_Status_Jatis_c {get;set;}
        Public String bitly_c {get;set;}
        Public Boolean blank_Short_URL_c {get;set;}
        Public String case_c {get;set;}
        Public String case_List_c {get;set;}
        Public String case_Number_c {get;set;}
        Public Datetime case_Open_Date_c {get;set;}
        Public String case_Type_c {get;set;}
        Public String category_c {get;set;}
        Public String contact_c {get;set;}
        Public String contact_Name_c {get;set;}
        Public String contact_Short_Name_c {get;set;}
        Public String createdById {get;set;}
        Public Datetime createdDate {get;set;}
        Public String date_Hit_c {get;set;}
        Public String date_Hit_JATIS_c {get;set;}
        Public String date_Received_c {get;set;}
        Public String date_Received_JATIS_c {get;set;}
        Public String department_Owner_c {get;set;}
        Public String description_c {get;set;}
        Public String description_Status_Deliver_c {get;set;}
        Public String description_Status_JATIS_c {get;set;}
        Public String division_c {get;set;}
        Public String email_c {get;set;}
        Public String email_SMS_Length_c {get;set;}
        Public String email_SMS_Template_c {get;set;}
        Public String email_Text_c {get;set;}
        Public Datetime  end_Date_c {get;set;}
        Public String entity_c {get;set;}
        Public String exclude_From2_c {get;set;}
        Public String exclude_From_c {get;set;}
        Public String ext_ID_IDAS_c {get;set;}
        Public String external_ID_c {get;set;}
        Public Boolean fg_Update_Contact_c {get;set;}
        Public String first_Send_c {get;set;}
        Public String first_Send_F_c {get;set;}
        Public String flagTestClass_c {get;set;}
        Public String have_Email_SMS_Log_c {get;set;}
        Public String icF_Non_CCC_c {get;set;}
        Public String icF_Walk_IN_c {get;set;}
        Public String id {get;set;}
        public String lastId {get;set;} 
        Public String insurance_Type_c {get;set;}
        Public Boolean isDeleted {get;set;}
        Public String lastModifiedById {get;set;}
        Public Datetime lastModifiedDate {get;set;}
        Public String lastReferencedDate {get;set;}
        Public String lastViewedDate {get;set;}
        Public Boolean loop_c {get;set;}
        Public String loop_Date_1_c {get;set;}
        Public String loop_Date_2_c {get;set;}
        Public String loop_Date_3_c {get;set;}
        Public String messageId_JATIS_c {get;set;}
        Public String method_c {get;set;}
        Public String mobile_c {get;set;}
        Public String mobile_Fix_c {get;set;}
        Public Boolean mobile_Fix_Check_c {get;set;}
        Public String moT_c {get;set;}
        Public String name {get;set;}
        Public String negative_Feedback_c {get;set;}
        Public Boolean not_Response_c {get;set;}
        Public String ownerId {get;set;}
        Public String password_c {get;set;}
        Public String policy_No_c {get;set;}
        Public String policy_Number_c {get;set;}
        Public Boolean ready_To_Send_c {get;set;}
        Public Datetime request_Date_c {get;set;}
        Public Datetime response_Date_c {get;set;}
        Public String retry_status_delivery_c {get;set;}
        Public Boolean send_Admin_Flag_c {get;set;}
        Public Boolean send_Flag_c {get;set;}
        Public Datetime start_Date_c {get;set;}
        Public String status_c {get;set;}
        Public String status_Deliver_c {get;set;}
        Public String status_JATIS_c {get;set;}
        Public String status_Response_c {get;set;}
        Public String subject_c {get;set;}
        Public String subject_New_Value_c {get;set;}
        Public String subject_Old_Value_c {get;set;}
        Public String survey_c {get;set;}
        Public String survey_Taken_c {get;set;}
        
        public String surveyTakenName {get;set;}
        Public String survey_Type_c {get;set;}
        Public String survey_URL_c {get;set;}
        Public Datetime systemModstamp {get;set;}
        Public Boolean taken_c {get;set;}
        Public String template_Email_c {get;set;}
        Public String template_SMS_c {get;set;}
        Public String topic_c {get;set;}
        Public String type_c {get;set;}
        Public Boolean updated_Contact_Flag_c {get;set;}
        Public Boolean use_Contact_Email_c {get;set;}
        Public String user_ID_c {get;set;}
        Public String walkIN_Survey_URL_c {get;set;}


        public string case_name {get;set;}

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'account__c') {
							account_c = parser.getText();
						}
                        else if (text == 'agent_Name__c') {
							agent_Name_c = parser.getText();
						}
                        else if (text == 'all_Status_Jatis__c') {
							all_Status_Jatis_c = parser.getText();
						}
                        else if (text == 'bitly__c') {
							bitly_c = parser.getText();
						}
                        else if (text == 'blank_Short_URL__c') {
                             	String a = parser.getText();
                        		blank_Short_URL_c = Boolean.valueOf(a);                           						
						}
                        else if (text == 'case__c') {
                        	case_c = parser.getText(); 
                            /* if (case_c != null) {                                     
                                AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(case_c);   
                                if(getData != null && getData.data != null ) case_name = getData.data.caseNumber;  
                            } */
                            if (case_c != null) case_name = AXAAPI_UtilityClass.getsObjectNameById(case_c, 'Case', 'CaseNumber');
                        }
                        else if (text == 'case_List__c') {
							case_List_c = parser.getText();
						}
                        else if (text == 'case_Number__c') {
							case_Number_c = parser.getText();
						}
                        else if (text == 'case_Open_Date__c') {
							case_Open_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						}
                        else if (text == 'case_Type__c') {
							case_Type_c = parser.getText();
						}
                        else if (text == 'category__c') {
                        category_c = parser.getText();
                        }
                        else if (text == 'contact__c') {
                        contact_c = parser.getText();
                        }
                        else if (text == 'contact_Name__c') {
                        contact_Name_c = parser.getText();
                        }
                        else if (text == 'contact_Short_Name__c') {
                        contact_Short_Name_c = parser.getText();
                        }
                        else if (text == 'createdById') {
                        createdById = parser.getText();
                        }
                        else if (text == 'createdDate') {
                        createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }
                        else if (text == 'date_Hit__c') {
                        date_Hit_c = parser.getText();
                        }
                        else if (text == 'date_Hit_JATIS__c') {
                        date_Hit_JATIS_c = parser.getText();
                        }
                        else if (text == 'date_Received__c') {
                        date_Received_c = parser.getText();
                        }
                        else if (text == 'date_Received_JATIS__c') {
                        date_Received_JATIS_c = parser.getText();
                        }
                        else if (text == 'department_Owner__c') {
                        department_Owner_c = parser.getText();
                        }
                        else if (text == 'description__c') {
                        description_c = parser.getText();
                        }
                        else if (text == 'description_Status_Deliver__c') {
                        description_Status_Deliver_c = parser.getText();
                        }
                        else if (text == 'description_Status_JATIS__c') {
                        description_Status_JATIS_c = parser.getText();
                        }
                        else if (text == 'division__c') {
                        division_c = parser.getText();
                        }
                        else if (text == 'email__c') {
                        email_c = parser.getText();
                        }
                        else if (text == 'email_SMS_Length__c') {
                        email_SMS_Length_c = parser.getText();
                        }
                        else if (text == 'email_SMS_Template__c') {
                        email_SMS_Template_c = parser.getText();
                        }
                        else if (text == 'email_Text__c') {
                        email_Text_c = parser.getText();
                        }
                        else if (text == 'end_Date__c') {
                        end_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }
                        else if (text == 'entity__c') {
                        entity_c = parser.getText();
                        }
                        else if (text == 'exclude_From2__c') {
                        exclude_From2_c = parser.getText();
                        }
                        else if (text == 'exclude_From__c') {
                        exclude_From_c = parser.getText();
                        }
                        else if (text == 'ext_ID_IDAS__c') {
                        ext_ID_IDAS_c = parser.getText();
                        }
                        else if (text == 'external_ID__c') {
                        external_ID_c = parser.getText();
                        }
                        else if (text == 'fg_Update_Contact__c') {
                        String a = parser.getText();
                        fg_Update_Contact_c = Boolean.valueOf(a);
                        }
                        else if (text == 'first_Send__c') {
                        first_Send_c = parser.getText();
                        }
                        else if (text == 'first_Send_F__c') {
                        first_Send_F_c = parser.getText();
                        }
                        else if (text == 'flagTestClass__c') {
                        flagTestClass_c = parser.getText();
                        }
                        else if (text == 'have_Email_SMS_Log__c') {
                        have_Email_SMS_Log_c = parser.getText();
                        }
                        else if (text == 'icF_Non_CCC__c') {
                        icF_Non_CCC_c = parser.getText();
                        }
                        else if (text == 'icF_Walk_IN__c') {
                        icF_Walk_IN_c = parser.getText();
                        }
                        else if (text == 'id') {
                            id = parser.getText(); 
                            lastId = id.SubString(id.length() - 3);  
                        }
                        else if (text == 'insurance_Type__c') {
                        insurance_Type_c = parser.getText();
                        }
                        else if (text == 'isDeleted') {
                        String a = parser.getText();
                        isDeleted = Boolean.valueOf(a);
                        }
                        else if (text == 'lastModifiedById') {
                        lastModifiedById = parser.getText();
                        }
                        else if (text == 'lastModifiedDate') {
                        lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }
                        else if (text == 'lastReferencedDate') {
                        lastReferencedDate = parser.getText();
                        }
                        else if (text == 'lastViewedDate') {
                        lastViewedDate = parser.getText();
                        }
                        else if (text == 'loop__c') {
                        String a = parser.getText();
                        loop_c = Boolean.valueOf(a);
                        }
                        else if (text == 'loop_Date_1__c') {
                        loop_Date_1_c = parser.getText();
                        }
                        else if (text == 'loop_Date_2__c') {
                        loop_Date_2_c = parser.getText();
                        }
                        else if (text == 'loop_Date_3__c') {
                        loop_Date_3_c = parser.getText();
                        }
                        else if (text == 'messageId_JATIS__c') {
                        messageId_JATIS_c = parser.getText();
                        }
                        else if (text == 'method__c') {
                        method_c = parser.getText();
                        }
                        else if (text == 'mobile__c') {
                        mobile_c = parser.getText();
                        }
                        else if (text == 'mobile_Fix__c') {
                        mobile_Fix_c = parser.getText();
                        }
                        else if (text == 'mobile_Fix_Check__c') {
                        String a = parser.getText();
                        mobile_Fix_Check_c = Boolean.valueOf(a);
                        }
                        else if (text == 'moT__c') {
                        moT_c = parser.getText();
                        }
                        else if (text == 'name') {
                        name = parser.getText();
                        }
                        else if (text == 'negative_Feedback__c') {
                        negative_Feedback_c = parser.getText();
                        }
                        else if (text == 'not_Response__c') {
                        String a = parser.getText();
                        not_Response_c = Boolean.valueOf(a);
                        }
                        else if (text == 'ownerId') {
                        ownerId = parser.getText();
                        }
                        else if (text == 'password__c') {
                        password_c = parser.getText();
                        }
                        else if (text == 'policy_No__c') {
                        policy_No_c = parser.getText();
                        }
                        else if (text == 'policy_Number__c') {
                        policy_Number_c = parser.getText();
                        }
                        else if (text == 'ready_To_Send__c') {
                        String a = parser.getText();
                        ready_To_Send_c = Boolean.valueOf(a);
                        }
                        else if (text == 'request_Date__c') {
                        request_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }
                        else if (text == 'response_Date__c') {
                        response_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }
                        else if (text == 'retry_status_delivery__c') {
                        retry_status_delivery_c = parser.getText();
                        }
                        else if (text == 'send_Admin_Flag__c') {
                        String a = parser.getText();
                        send_Admin_Flag_c = Boolean.valueOf(a);
                        }
                        else if (text == 'send_Flag__c') {
                        String a = parser.getText();
                        send_Flag_c = Boolean.valueOf(a);
                        }
                        else if (text == 'start_Date__c') {
                        start_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }
                        else if (text == 'status__c') {
                        status_c = parser.getText();
                        }
                        else if (text == 'status_Deliver__c') {
                        status_Deliver_c = parser.getText();
                        }
                        else if (text == 'status_JATIS__c') {
                        status_JATIS_c = parser.getText();
                        }
                        else if (text == 'status_Response__c') {
                        status_Response_c = parser.getText();
                        }
                        else if (text == 'subject__c') {
                        subject_c = parser.getText();
                        }
                        else if (text == 'subject_New_Value__c') {
                        subject_New_Value_c = parser.getText();
                        }
                        else if (text == 'subject_Old_Value__c') {
                        subject_Old_Value_c = parser.getText();
                        }
                        else if (text == 'survey__c') {
                        survey_c = parser.getText();
                        }
                        else if (text == 'survey_Taken__c') {
                        	survey_Taken_c = parser.getText();
                            
                            /* if (survey_Taken_c != null) {                                     
                                AXAAPI014B_response getData  = AXAAPI014B_SurveyTakenById.getSurveyTakenById(survey_Taken_c);   
                                if(getData != null && getData.data != null ) surveyTakenName = getData.data.name;  
                            } */
                            if (survey_Taken_c != null && survey_Taken_c != '') surveyTakenName = AXAAPI_UtilityClass.getsObjectNameById(case_c, 'surveytaker__c', 'name');
                        }
                        else if (text == 'survey_Type__c') {
                        survey_Type_c = parser.getText();
                        }
                        else if (text == 'survey_URL__c') {
                        survey_URL_c = parser.getText();
                        }
                        else if (text == 'systemModstamp') {
                        systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }
                        else if (text == 'taken__c') {
                        String a = parser.getText();
                        taken_c = Boolean.valueOf(a);
                        }
                        else if (text == 'template_Email__c') {
                        template_Email_c = parser.getText();
                        }
                        else if (text == 'template_SMS__c') {
                        template_SMS_c = parser.getText();
                        }
                        else if (text == 'topic__c') {
                        topic_c = parser.getText();
                        }
                        else if (text == 'type__c') {
                        type_c = parser.getText();
                        }
                        else if (text == 'updated_Contact_Flag__c') {
                        String a = parser.getText();
                        updated_Contact_Flag_c = Boolean.valueOf(a);
                        }
                        else if (text == 'use_Contact_Email__c') {
                        String a = parser.getText();
                        use_Contact_Email_c = Boolean.valueOf(a);
                        }
                        else if (text == 'user_ID__c') {
                        user_ID_c = parser.getText();
                        }
                        else if (text == 'walkIN_Survey_URL__c') {
                        walkIN_Survey_URL_c = parser.getText();
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

	public AXAAPI003A_response(JSONParser parser) {
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
					}else if (text == 'counts') {
						counts = integer.valueOf(parser.getText());
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI003A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI003A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI003A_response(parser);
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