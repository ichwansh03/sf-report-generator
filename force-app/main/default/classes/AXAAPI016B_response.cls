public class AXAAPI016B_response {
	public AXAAPI016B_response(){}

	public class Data {
        //public String recordType {get;set;} 
        Public Data() {}
        
        public string contact_name {get;set;}
 		public string createdbyid_name  {get;set;}
        public string case_name {get; set;}
        
		public string account_Name_c {get;set;}
        public string account_Number_c {get;set;}
        public string bank_Name_c {get;set;}
        public string bank_Name_Other_c {get;set;}
        public Boolean beneficial_Owner_c {get;set;}
        public string beneficial_Owner_KYC_c {get;set;}
        public string card_Holder_Name_c {get;set;}
        public string card_Number_c {get;set;}
        public string case_c {get;set;}
        public Boolean change_Name_c {get;set;}
        public string check_c {get;set;}
        public string checklist_c {get;set;}
        public string contact_c {get;set;}
        public Datetime create_Date_c {get;set;}
        public string createdById {get;set;}
        public Datetime createdDate {get;set;}
        public string email_c {get;set;}
        public string email_Subject_c {get;set;}
        public string entity_c {get;set;}
        public string expiry_Date_MMYY_c {get;set;}
        public string external_Id_SFDC_c {get;set;}
        public string flagVsnap_c {get;set;}
        public string id {get;set;}
        public string interaction_Id_c {get;set;}
        public string isDeleted {get;set;}
        public string jsonBackEndError_c {get;set;}
        public string jsonErrorMessage_c {get;set;}
        public string jsonRequestBody_c {get;set;}
        public string lastModifiedById {get;set;}
        public Datetime lastModifiedDate {get;set;}
        public Datetime lastReferencedDate {get;set;}
        public Datetime lastViewedDate {get;set;}
        public string log_a_Case_c {get;set;}
        public string mid_account_number2_c {get;set;}
        public string mid_approval_code_c {get;set;}
        public string mid_bank_c {get;set;}
        public string mid_bank_name2_c {get;set;}
        public string mid_card_number2_c {get;set;}
        public string mid_channel_response_code2_c {get;set;}
        public string mid_channel_response_code_c {get;set;}
        public string mid_channel_response_message2_c {get;set;}
        public string mid_channel_response_message_c {get;set;}
        public string mid_currency_c {get;set;}
        public string mid_custom_field1_c {get;set;}
        public string mid_custom_field2_c {get;set;}
        public string mid_custom_field3_c {get;set;}
        public string mid_custom_field3_temp_c {get;set;}
        public string mid_EIPtokenApp_Status_c {get;set;}
        public string mid_expiry_date2_c {get;set;}
        public string mid_fraud_status_c {get;set;}
        public string mid_gross_amount_c {get;set;}
        public string mid_masked_card_c {get;set;}
        public string mid_order_id2_c {get;set;}
        public string mid_order_id_c {get;set;}
        public string mid_payment_type_c {get;set;}
        public string mid_policy_apps2_c {get;set;}
        public string mid_policy_apps_c {get;set;}
        public string mid_saved_token_id_c {get;set;}
        public string mid_saved_token_id_expired_at_c {get;set;}
        public string mid_signature_key_c {get;set;}
        public string mid_status_code2_c {get;set;}
        public string mid_status_code_c {get;set;}
        public string mid_status_message2_c {get;set;}
        public string mid_status_message_c {get;set;}
        public string mid_token_payment2_c {get;set;}
        public string mid_token_payment_c {get;set;}
        public string mid_transaction_id_c {get;set;}
        public string mid_transaction_status_c {get;set;}
        public Datetime mid_transaction_time2_c {get;set;}
        public string mid_transaction_time_c {get;set;}
        public string midtrans_Token_c {get;set;}
        public string name {get;set;}
        public string non_Perorangan_c {get;set;}
        public string origin_c {get;set;}
        public string ownerId {get;set;}
        public Boolean parent_c {get;set;}
        public string payment_Frequency_c {get;set;}
        public string payment_Type_c {get;set;}
        public string policy_App_c {get;set;}
        public string policy_No_c {get;set;}
        public string registration_Id_c {get;set;}
        public string request_Date_c {get;set;}
        public Boolean save_c {get;set;}
        public Boolean send_Email_c {get;set;}
        public string send_Email_Type_c {get;set;}
        public string sfdC_Order_Id_c {get;set;}
        public string sfdC_Order_Id_Child_c {get;set;}
        public string status_c {get;set;}
        public string status_DoOrderEIP_c {get;set;}
        public Datetime systemModstamp {get;set;}

        public String ownerid_name {get;set;}
 		Public string CreatedBy_name {get;set;}
        Public string LastModifiedBy_name {get;set;}

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'account_Name__c') {
							account_Name_c = parser.getText();
						} else if (text == 'account_Number__c') {
							account_Number_c = parser.getText();
						} else if (text == 'bank_Name__c') {
							bank_Name_c = parser.getText();
						} else if (text == 'bank_Name_Other__c') {
							bank_Name_Other_c = parser.getText();
						}  else if (text == 'beneficial_Owner__c') {
                            // String beneficial_Owner_text = parser.getText();
							beneficial_Owner_c = AXAAPI_UtilityClass.stringToBoolean(parser.getText());
						} else if (text == 'beneficial_Owner_KYC__c') {
							beneficial_Owner_KYC_c = parser.getText();
						} else if (text == 'card_Holder_Name__c') {
							card_Holder_Name_c = parser.getText();
						} else if (text == 'card_Number__c') {
							card_Number_c = parser.getText();
						} else if (text == 'case__c') {
                            case_c = parser.getText();
                        } else if (text == 'change_Name__c') {
                            //String change_name_text = parser.getText();
                            change_Name_c = AXAAPI_UtilityClass.stringToBoolean(parser.getText());
                        } else if (text == 'check__c') {
                            check_c = parser.getText();
                        } else if (text == 'checklist__c') {
                            checklist_c = parser.getText();
                        } else if (text == 'contact__c') {
                            contact_c = parser.getText();
                            if (contact_c != null) contact_name = AXAAPI_UtilityClass.getsObjectNameById(contact_c, 'Contact', 'name');
						} else if (text == 'create_Date__c') {
							create_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'createdById') {
							createdById = parser.getText();
                            if (createdById != null) CreatedBy_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'email__c') {
							email_c = parser.getText();
						} else if (text == 'email_Subject__c') {
							email_Subject_c = parser.getText();
						} else if (text == 'entity__c') {
							entity_c = parser.getText();
						} else if (text == 'expiry_Date_MMYY__c') {
							expiry_Date_MMYY_c = parser.getText();
						} else if (text == 'external_Id_SFDC__c') {
							external_Id_SFDC_c = parser.getText();
						} else if (text == 'flagVsnap__c') {
							flagVsnap_c = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'interaction_Id__c') {
							interaction_Id_c = parser.getText();
						} else if (text == 'isDeleted') {
							isDeleted = parser.getText();
						} else if (text == 'jsonBackEndError__c') {
							jsonBackEndError_c = parser.getText();
						} else if (text == 'jsonErrorMessage__c') {
							jsonErrorMessage_c = parser.getText();
						} else if (text == 'jsonRequestBody__c') {
							jsonRequestBody_c = parser.getText();
						} else if (text == 'lastModifiedById') {
							lastModifiedById = parser.getText();
                            if (lastModifiedById != null) LastModifiedBy_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
						} else if (text == 'lastModifiedDate') {
							lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'lastReferencedDate') {
							lastReferencedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'lastViewedDate') {
							lastViewedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'log_a_Case__c') {
							log_a_Case_c = parser.getText();
						} else if (text == 'mid_account_number2__c') {
							mid_account_number2_c = parser.getText();
						} else if (text == 'mid_approval_code__c') {
							mid_approval_code_c = parser.getText();
						} else if (text == 'mid_bank__c') {
							mid_bank_c = parser.getText();
						} else if (text == 'mid_bank_name2__c') {
							mid_bank_name2_c = parser.getText();
						}  else if (text == 'mid_card_number2__c') {
							mid_card_number2_c = parser.getText();
						} else if (text == 'mid_channel_response_code2__c') {
							mid_channel_response_code2_c = parser.getText();
						} else if (text == 'mid_channel_response_code__c') {
							mid_channel_response_code_c = parser.getText();
						} else if (text == 'mid_channel_response_message2__c') {
							mid_channel_response_message2_c = parser.getText();
						} else if (text == 'mid_channel_response_message__c') {
                            mid_channel_response_message_c = parser.getText();
                        } else if (text == 'mid_currency__c') {
                            mid_currency_c = parser.getText();
                        } else if (text == 'mid_custom_field1__c') {
                            mid_custom_field1_c = parser.getText();
                        } else if (text == 'mid_custom_field2__c') {
                            mid_custom_field2_c = parser.getText();
                        } else if (text == 'mid_custom_field3__c') {
                            mid_custom_field3_c = parser.getText();
						} else if (text == 'mid_custom_field3_temp__c') {
							mid_custom_field3_temp_c = parser.getText();
						} else if (text == 'mid_EIPtokenApp_Status__c') {
							mid_EIPtokenApp_Status_c = parser.getText();
						} else if (text == 'mid_expiry_date2__c') {
							mid_expiry_date2_c = parser.getText();
						} else if (text == 'mid_fraud_status__c') {
							mid_fraud_status_c = parser.getText();
						} else if (text == 'mid_gross_amount__c') {
							mid_gross_amount_c =parser.getText();
						} else if (text == 'mid_masked_card__c') {
							mid_masked_card_c = parser.getText();
						} else if (text == 'mid_order_id2__c') {
							mid_order_id2_c = parser.getText();
						} else if (text == 'mid_order_id__c') {
							mid_order_id_c = parser.getText();
						} else if (text == 'mid_payment_type__c') {
							mid_payment_type_c = parser.getText();
						} else if (text == 'mid_policy_apps2__c') {
							mid_policy_apps2_c = parser.getText();
						} else if (text == 'mid_policy_apps__c') {
							mid_policy_apps_c = parser.getText();
						} else if (text == 'mid_saved_token_id__c') {
							mid_saved_token_id_c = parser.getText();
						} else if (text == 'mid_saved_token_id_expired_at__c') {
							mid_saved_token_id_expired_at_c = parser.getText();
						} else if (text == 'mid_signature_key__c') {
							mid_signature_key_c = parser.getText();
						} else if (text == 'mid_status_code2__c') {
							mid_status_code2_c = parser.getText();
						} else if (text == 'mid_status_code__c') {
							mid_status_code_c = parser.getText();
						} else if (text == 'mid_status_message2__c') {
							mid_status_message2_c = parser.getText();
						} else if (text == 'mid_status_message__c') {
							mid_status_message_c = parser.getText();
						} else if (text == 'mid_token_payment2__c') {
							mid_token_payment2_c = parser.getText();
						} else if (text == 'mid_token_payment__c') {
							mid_token_payment_c = parser.getText();
						} else if (text == 'mid_transaction_id__c') {
                            mid_transaction_id_c = parser.getText();
						} else if (text == 'mid_transaction_status__c') {
							mid_transaction_status_c = parser.getText();
						} else if (text == 'mid_transaction_time2__c') {
							mid_transaction_time2_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'mid_transaction_time__c') {
							mid_transaction_time_c = parser.getText();
						} else if (text == 'midtrans_Token__c') {
							midtrans_Token_c = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'non_Perorangan__c') {
							non_Perorangan_c = parser.getText();
						} else if (text == 'origin__c') {
							origin_c = parser.getText();
						} else if (text == 'ownerId') {
							ownerId = parser.getText();
                            if (ownerId != null) ownerid_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'user', 'name');
						} else if (text == 'parent__c') {
                            //string parent_text = parser.getText();
							parent_c = AXAAPI_UtilityClass.stringToBoolean(parser.getText());
						} else if (text == 'payment_Frequency__c') {
							payment_Frequency_c = parser.getText();
						} else if (text == 'payment_Type__c') {
							payment_Type_c = parser.getText();
						} else if (text == 'policy_App__c') {
							policy_App_c = parser.getText();
						} else if (text == 'policy_No__c') {
							policy_No_c = parser.getText();
						} else if (text == 'registration_Id__c') {
							registration_Id_c = parser.getText();
						} else if (text == 'request_Date__c') {
							request_Date_c = parser.getText();
						} else if (text == 'save__c') {
                            //String save_text = parser.getText();
							save_c = AXAAPI_UtilityClass.stringToBoolean(parser.getText());
						} else if (text == 'send_Email__c') {
                            //String send_email_text = parser.getText();
							send_Email_c = AXAAPI_UtilityClass.stringToBoolean(parser.getText());
						} else if (text == 'send_Email_Type__c') {
                            //String send_email_type = parser.getText();
							send_Email_Type_c = parser.getText();
						} else if (text == 'sfdC_Order_Id__c') {
							sfdC_Order_Id_c = parser.getText();
						} else if (text == 'sfdC_Order_Id_Child__c') {
							sfdC_Order_Id_Child_c = parser.getText();
						} else if (text == 'status__c') {
							status_c = parser.getText();
						} else if (text == 'status_DoOrderEIP__c') {
							status_DoOrderEIP_c = parser.getText();
						} else if (text == 'systemModstamp') {
							systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());						} 
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

	public AXAAPI016B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI016B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI016B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI016B_response(parser);
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