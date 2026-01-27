/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Convert Json parse to data
*  @Class   AXAAPI020B_response 
*  @Return  Array
*/ 
public class AXAAPI020B_response {
    
    public AXAAPI020B_response() {}

	public class Data { 
        Public Data(){} 
        public string id {get;set;}
        public integer ACD_Count_c {get;set;}
        public string Acd_SUM_c {get;set;}
        public integer ACW_Count_c {get;set;}
        public integer ACW_Sum_c {get;set;}
        public string Admin_Sum_c {get;set;}
        public string Agent_c {get;set;}
        public string Agent_Name_c {get;set;}
        public string agentName {get;set;}
        public string Agent_Role_c {get;set;}
        public string AHT_c {get;set;}
        public string AHT_Outbound_c {get;set;}
        public integer AHT_Outbound_Sum_c {get;set;}
        public integer AHT_Sum_c {get;set;}
        public string API_Check_API1_c {get;set;}
        public datetime API_Check_API1_Date_c {get;set;}
        public string API_Check_API1_Status_c {get;set;}
        public string API_Check_API2_c {get;set;}
        public datetime API_Check_API2_Date_c {get;set;}
        public string API_Check_API2_Status_c {get;set;}
        public string API_CHeck_API3_c {get;set;}
        public datetime API_CHeck_API3_Date_c {get;set;}
        public string API_CHeck_API3_Status_c {get;set;}
        public string API_Check_Resync_c {get;set;}
        public string Attend_c {get;set;}
        public integer Available_Admin_Count_c {get;set;}
        public integer Available_Admin_Sum_c {get;set;}
        public string Available_Admin_Minute_c {get;set;}
        public integer Available_Follow_Up_Count_c {get;set;}
        public integer Available_Follow_Up_Sum_c {get;set;}
        public string Available_Follow_Up_Minute_c {get;set;}
        public integer Available_Other_Sum_c {get;set;}
        public integer Available_Outbound_Count_c {get;set;}
        public integer Available_Outbound_Sum_c {get;set;}
        public string Available_Outbound_Minute_c {get;set;}
        public integer Available_Sum_c {get;set;}
        public string Total_Available_Sum_c {get;set;}
        public integer Available_Walk_IN_Count_c {get;set;}
        public integer Available_Walk_IN_Sum_c {get;set;}
        public string Available_Walk_IN_Minute_c {get;set;}
        public integer AVG_ACW_c {get;set;}
        public string AVG_ACW_Time_c {get;set;}
        public string AVG_Hold_c {get;set;}
        public string AVG_Talk_c {get;set;}
        public integer Away_Count_c {get;set;}
        public integer Away_Sum_c {get;set;}
        public string Away_Minute_c {get;set;}
        public string Break_Sum_c {get;set;}
        public integer Break_Lunch_Count_c {get;set;}
        public integer Break_Lunch_Sum_c {get;set;}
        public string Break_Lunch_Minute_c {get;set;}
        public integer Break_Other_Count_c {get;set;}
        public integer Break_Other_Sum_c {get;set;}
        public string Break_Other_Minute_c {get;set;}
        public integer Break_Pray_Count_c {get;set;}
        public integer Break_Pray_Sum_c {get;set;}
        public string Break_Pray_Minute_c {get;set;}
        public integer Break_Rest_Count_c {get;set;}
        public integer Break_Rest_Sum_c {get;set;}
        public string Break_Rest_Minute_c {get;set;}
        public integer Busy_Count_c {get;set;}
        public integer Busy_Sum_c {get;set;}
        public string Busy_Minute_c {get;set;}
        public string Coaching_Sum_c {get;set;}
        public date Date_c {get;set;}
        public string End_Login_c {get;set;}
        public string Entity_c {get;set;}
        public string External_ID_c {get;set;}
        public string Follow_Up_Sum_c {get;set;}
        public string Formula_c {get;set;}
        public integer Handle_Count_c {get;set;}
        public integer Handle_Sum_c {get;set;}
        public string Hari_c {get;set;}
        public integer Hold_Count_c {get;set;}
        public integer Hold_Sum_c {get;set;}
        public string isActive_c {get;set;}
        public string Late_Duration_Minute_c {get;set;}
        public string Meal_Sum_c {get;set;}
        public integer Meeting_count_c {get;set;}
        public integer Meeting_Sum_c {get;set;}
        public string Meeting_Minute_c {get;set;}
        public string Offline_Sum_c {get;set;}
        public string On_Queue_Sum_c {get;set;}
        public string Outbound_Sum_c {get;set;}
        public string Outsource_Type_c {get;set;}
        public string Periode_c {get;set;}
        public string Primary_c {get;set;}
        public integer Productivity_c {get;set;}
        public string Queue_Group_c {get;set;}
        public string Queue_Percent_c {get;set;}
        public string Queue_PureCloud_c {get;set;}
        public String Schedule_Login_c {get;set;}
        public datetime Schedule_Login_F_c {get;set;}
        public string SIP_c {get;set;}
        public integer Staffed_Sum_c {get;set;}
        public string Start_Login_c {get;set;}
        public string Status_Login_c {get;set;}
        public integer Talk_Count_c {get;set;}
        public integer Talk_Sum_c {get;set;}
        public string temp_aux_c {get;set;}
        public string Total_Available_Time_c {get;set;}
        public string Total_Time_Staffed_c {get;set;}
        public integer Training_count_c {get;set;}
        public integer Training_Sum_c {get;set;}
        public string Training_Minute_c {get;set;}
        public integer Training_Coaching_Count_c {get;set;}
        public integer Training_Coaching_Sum_c {get;set;}
        public string Training_Coaching_Minute_c {get;set;}
        public integer Training_Training_Count_c {get;set;}
        public integer Training_Training_Sum_c {get;set;}
        public string Training_Training_Minute_c {get;set;}
        public string Type_c {get;set;}
        public string Walk_In_Sum_c {get;set;}
        public string CreatedById {get;set;}
        public string LastModifiedById {get;set;}
        public string CreatedByName {get;set;}
        public datetime CreatedDate {get;set;}
        public string LastModifiedByName {get;set;}
        public datetime LastModifiedDate {get;set;}
        public string OwnerId {get;set;}
        public string OwnerName {get;set;}
        public string Name {get;set;}
        //public string schedule_Login_c {get;set;}
                
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) { 
                        if (text == 'id') {
                            id = parser.getText();
                        }else if (text == 'ACD_Count__c') {
                            acd_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Acd_SUM__c') {
                            Acd_SUM_c = parser.getText();
                        }else if (text == 'ACW_Count__c') {
                            acw_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'ACW_Sum__c') {
                            acw_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Admin_Sum__c') {
                            Admin_Sum_c = parser.getText();
                        }else if (text == 'Agent__c') {
                            Agent_c = parser.getText();
                        }else if (text == 'Agent_Name__c') {
                            Agent_Name_c = parser.getText();
                            if (Agent_Name_c != null) agentName = AXAAPI_UtilityClass.getsObjectNameById(Agent_Name_c, 'User', 'Name');
                        }else if (text == 'Agent_Role__c') {
                            Agent_Role_c = parser.getText();
                        }else if (text == 'AHT__c') {
                            AHT_c = parser.getText();
                        }else if (text == 'AHT_Outbound__c') {
                            AHT_Outbound_c = parser.getText();
                        }else if (text == 'AHT_Outbound_Sum__c') {
                            aht_outbound_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'AHT_Sum__c') {
                            aht_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'API_Check_API1__c') {
                            API_Check_API1_c = parser.getText();
                        }else if (text == 'API_Check_API1_Date__c') {
                            API_Check_API1_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }else if (text == 'API_Check_API1_Status__c') {
                            API_Check_API1_Status_c = parser.getText();
                        }else if (text == 'API_Check_API2__c') {
                            API_Check_API2_c = parser.getText();
                        }else if (text == 'API_Check_API2_Date__c') {
                            API_Check_API2_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }else if (text == 'API_Check_API2_Status__c') {
                            API_Check_API2_Status_c = parser.getText();
                        }else if (text == 'API_CHeck_API3__c') {
                            API_CHeck_API3_c = parser.getText();
                        }else if (text == 'API_CHeck_API3_Date__c') {
                            API_CHeck_API3_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }else if (text == 'API_CHeck_API3_Status__c') {
                            API_CHeck_API3_Status_c = parser.getText();
                        }else if (text == 'API_Check_Resync__c') {
                            API_Check_Resync_c = parser.getText();
                        }else if (text == 'Attend__c') {
                            Attend_c = parser.getText();
                        }else if (text == 'Available_Admin_Count__c') {
                            Available_Admin_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Admin_Sum__c') {
                            Available_Admin_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Admin_Minute__c') {
                            Available_Admin_Minute_c = parser.getText();
                        }else if (text == 'Available_Follow_Up_Count__c') {
                            available_follow_up_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Follow_Up_Sum__c') {
                            Available_Follow_Up_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Follow_Up_Minute__c') {
                            Available_Follow_Up_Minute_c = parser.getText();
                        }else if (text == 'Available_Other_Sum__c') {
                            available_other_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Outbound_Count__c') {
                            Available_Outbound_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Outbound_Sum__c') {
                            Available_Outbound_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Outbound_Minute__c') {
                            Available_Outbound_Minute_c = parser.getText();
                        }else if (text == 'Available_Sum__c') {
                            Available_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Total_Available_Sum__c') {
                            Total_Available_Sum_c = parser.getText();
                        }else if (text == 'Available_Walk_IN_Count__c') {
                            available_walk_in_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Walk_IN_Sum__c') {
                            available_walk_in_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Available_Walk_IN_Minute__c') {
                            Available_Walk_IN_Minute_c = parser.getText();
                        }else if (text == 'AVG_ACW__c') {
                            avg_acw_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'AVG_ACW_Time__c') {
                            AVG_ACW_Time_c = parser.getText();
                        }else if (text == 'AVG_Hold__c') {
                            AVG_Hold_c = parser.getText();
                        }else if (text == 'AVG_Talk__c') {
                            AVG_Talk_c = parser.getText();
                        }else if (text == 'Away_Count__c') {
                            Away_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Away_Sum__c') {
                            Away_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Away_Minute__c') {
                            Away_Minute_c = parser.getText();
                        }else if (text == 'Break_Sum__c') {
                            Break_Sum_c = parser.getText();
                        }else if (text == 'Break_Lunch_Count__c') {
                            Break_Lunch_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Lunch_Sum__c') {
                            Break_Lunch_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Lunch_Minute__c') {
                            Break_Lunch_Minute_c = parser.getText();
                        }else if (text == 'Break_Other_Count__c') {
                            Break_Other_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Other_Sum__c') {
                            Break_Other_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Other_Minute__c') {
                            Break_Other_Minute_c = parser.getText();
                        }else if (text == 'Break_Pray_Count__c') {
                            Break_Pray_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Pray_Sum__c') {
                            Break_Pray_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Pray_Minute__c') {
                            Break_Pray_Minute_c = parser.getText();
                        }else if (text == 'Break_Rest_Count__c') {
                            Break_Rest_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Rest_Sum__c') {
                            Break_Rest_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Break_Rest_Minute__c') {
                            Break_Rest_Minute_c = parser.getText();
                        }else if (text == 'Busy_Count__c') {
                            Busy_Count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Busy_Sum__c') {
                            Busy_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Busy_Minute__c') {
                            Busy_Minute_c = parser.getText();
                        }else if (text == 'Coaching_Sum__c') {
                            Coaching_Sum_c = parser.getText();
                        }else if (text == 'Date__c') {
                            Date_c = AXAAPI_UtilityClass.stringToDate(parser.getText());
                        }else if (text == 'End_Login__c') {
                            End_Login_c = parser.getText();
                        }else if (text == 'Entity__c') {
                            Entity_c = parser.getText();
                        }else if (text == 'External_ID__c') {
                            External_ID_c = parser.getText();
                        }else if (text == 'Follow_Up_Sum__c') {
                            Follow_Up_Sum_c = parser.getText();
                        }else if (text == 'Formula__c') {
                            Formula_c = parser.getText();
                        }else if (text == 'Handle_Count__c') {
                            handle_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Handle_Sum__c') {
                            handle_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Hari__c') {
                            Hari_c = parser.getText();
                        }else if (text == 'Hold_Count__c') {
                            hold_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Hold_Sum__c') {
                            hold_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'isActive__c') {
                            isActive_c = parser.getText();
                        }else if (text == 'Late_Duration_Minute__c') {
                            Late_Duration_Minute_c = parser.getText();
                        }else if (text == 'Meal_Sum__c') {
                            Meal_Sum_c = parser.getText();
                        }else if (text == 'Meeting_count__c') {
                            Meeting_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Meeting_Sum__c') {
                            Meeting_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Meeting_Minute__c') {
                            Meeting_Minute_c = parser.getText();
                        }else if (text == 'Offline_Sum__c') {
                            Offline_Sum_c = parser.getText();
                        }else if (text == 'On_Queue_Sum__c') {
                            On_Queue_Sum_c = parser.getText();
                        }else if (text == 'Outbound_Sum__c') {
                            Outbound_Sum_c = parser.getText();
                        }else if (text == 'Outsource_Type__c') {
                            Outsource_Type_c = parser.getText();
                        }else if (text == 'Periode__c') {
                            Periode_c = parser.getText();
                        }else if (text == 'Primary__c') {
                            Primary_c = parser.getText();
                        }else if (text == 'Productivity__c') { 
                            string nilaiProd = parser.getText();
                            if (nilaiProd != '') {
                                productivity_c = Integer.valueOf(nilaiProd);
                            } else {
                                productivity_c = 0;
                            }  
                        }else if (text == 'Queue_Group__c') {
                            Queue_Group_c = parser.getText();
                        }else if (text == 'Queue_Percent__c') {
                            Queue_Percent_c = parser.getText();
                            if (Queue_Percent_c != '') Queue_Percent_c = Queue_Percent_c+'%';
                        }else if (text == 'Queue_PureCloud__c') {
                            Queue_PureCloud_c = parser.getText();
                        }else if (text == 'schedule_Login__c') {
                            Schedule_Login_c = parser.getText();
                        }else if (text == 'Schedule_Login_F__c') {
                            Schedule_Login_F_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }else if (text == 'SIP__c') {
                            SIP_c = parser.getText();
                        }else if (text == 'Staffed_Sum__c') {
                            string nilaiStaff = parser.getText();
                            if (nilaiStaff != '') {
                                staffed_sum_c = Integer.valueOf(nilaiStaff);
                            } else {
                                staffed_sum_c = 0;
                            } 
                        }else if (text == 'Start_Login__c') {
                            Start_Login_c = parser.getText();
                        }else if (text == 'Status_Login__c') {
                            Status_Login_c = parser.getText();
                        }else if (text == 'Talk_Count__c') {
                            talk_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Talk_Sum__c') {
                            talk_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'temp_aux__c') {
                            temp_aux_c = parser.getText();
                        }else if (text == 'Total_Available_Time__c') {
                            Total_Available_Time_c = parser.getText();
                        }else if (text == 'Total_Time_Staffed__c') {
                            Total_Time_Staffed_c = parser.getText();
                        }else if (text == 'Training_count__c') {
                            Training_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Training_Sum__c') {
                            Training_Sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Training_Minute__c') {
                            Training_Minute_c = parser.getText();
                        }else if (text == 'Training_Coaching_Count__c') {
                            training_coaching_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Training_Coaching_Sum__c') {
                            training_coaching_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Training_Coaching_Minute__c') {
                            Training_Coaching_Minute_c = parser.getText();
                        }else if (text == 'Training_Training_Count__c') {
                            training_training_count_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Training_Training_Sum__c') {
                            training_training_sum_c = integer.valueOf(parser.getIntegerValue());
                        }else if (text == 'Training_Training_Minute__c') {
                            Training_Training_Minute_c = parser.getText();
                        }else if (text == 'Type__c') {
                            Type_c = parser.getText();
                        }else if (text == 'Walk_In_Sum__c') {
                            Walk_In_Sum_c = parser.getText();
                        }else if ( text == 'CreatedById') {
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

	public AXAAPI020B_response(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'status') {
						status = parser.getText();
					} else if (text == 'message') {
						message = parser.getText();
					} else if (text == 'data') {
						data = New Data(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI020B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI020B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI020B_response(parser);
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