public class AXAAPI022B_response {

    public class Data {
        Public Data() {}
        //added for view only createdById_Name
		/*Public String a1_c{get;set;}
        Public String a1_Point_c{get;set;}
        Public String a2_c{get;set;}
        Public String a2_Point_c{get;set;}
        Public String a3_c{get;set;}
        Public String a3_Point_c{get;set;}
        Public String a4_c{get;set;}
        Public String a4_Point_c{get;set;}
        Public String a5_c{get;set;}
        Public String a5_Point_c{get;set;}
        Public String activity_c{get;set;}
        Public String activity_Config_c{get;set;}
        Public String activity_Result_c{get;set;}
        
        Public String agent_c{get;set;}
        Public String agent_ID_c{get;set;}
        
        Public String amount_Approved_c{get;set;}
        Public String amount_Cancel_c{get;set;}
        Public String amount_Conserved_c{get;set;}
        Public String amount_Contacted_c{get;set;}
        Public String amount_Not_Approved_c{get;set;}
        Public String amount_Paid_c{get;set;}
        Public String amount_Paid_Approved_c{get;set;}
        Public String amount_Paid_Bio_c{get;set;}
        Public String amount_Paid_Contacted_c{get;set;}
        Public String amount_Paid_Uncontacted_c{get;set;}
        Public String amount_Retain_Redemption_c{get;set;}
        Public String amount_Retain_Withdrawal_c{get;set;}
        Public String amount_Uncontacted_c{get;set;}
        
        Public String apE_Amount_Bio_c{get;set;}
        Public String apE_Contact_c{get;set;}
        
        
       
       
        
        
        Public String call_Attempt_c{get;set;}
        PUBLIC DATETIME call_Date_c{get;set;}
        Public String call_Duration_Minutes_c{get;set;}
        Public String call_End_Datetime_c{get;set;}
        Public String call_Generated_Counter_c{get;set;}
        
        
        Public String call_Remarks_c{get;set;}
        Public String call_Result_c{get;set;}
        Public String call_Start_Datetime_c{get;set;}
        Public String call_Status_Config_c{get;set;}
        PUBLIC DATETIME call_Status_History_c{get;set;}
        Public String call_Status_Label_c{get;set;}
        PUBLIC BOOLEAN call_status_old_new_not_equal_c{get;set;}
        
       
               
        Public String case_Type_c{get;set;}
        Public String case_Type_Config_c{get;set;}
        
        Public String chanel_c{get;set;}
        
        
        
        Public String child_Count_Formula_c{get;set;}
        
        Public String claim_No_c{get;set;}
        
        Public String collection_Call_Date_F_c{get;set;}
        Public String collection_Target_c{get;set;}
        
        Public String contact_c{get;set;}
        
        Public String contact_Policy_App_c{get;set;}
        Public String contacted_Number_c{get;set;}
        
        Public String count_Agent_Validation_c{get;set;}
        
        Public String count_Cancel_ALI_c{get;set;}
        Public String count_Complaint_ALI_c{get;set;}
        Public String count_Contacted_c{get;set;}
        Public String count_Data2_c{get;set;}
        Public String count_Data_c{get;set;}
        
        Public String count_Done_ALI_c{get;set;}
        Public String count_Eksternal_Error_Alamat_c{get;set;}
        Public String count_Eksternal_Error_DOB_c{get;set;}
        Public String count_Eksternal_Error_Email_c{get;set;}
        Public String count_Eksternal_Error_Nama_PP_TT_c{get;set;}
        Public String count_Eksternal_Error_Telepon_c{get;set;}
        Public String count_Follow_Up_ALI_c{get;set;}
        Public String count_Hard_Contact_ALI_c{get;set;}
        Public String count_Inforce_ALI_c{get;set;}
        Public String count_Internal_Error_Alamat_c{get;set;}
        Public String count_Internal_Error_DOB_c{get;set;}
        Public String count_Internal_Error_Email_c{get;set;}
        Public String count_Internal_Error_Nama_PP_TT_c{get;set;}
        Public String count_Internal_Error_Telepon_c{get;set;}
        Public String count_Keterangan_Data_KYC_c{get;set;}
        Public String count_No_Follow_Up_ALI_c{get;set;}
        Public String count_No_Interest_ALI_c{get;set;}
        Public String count_No_Pickup_Mailbox_ALI_c{get;set;}
        Public String count_Redebet_ALI_c{get;set;}
        Public String count_Redemption_c{get;set;}
        Public String count_Uncontacted_c{get;set;}
        Public String count_Understand_Product_c{get;set;}
        Public String count_Withdrawal_c{get;set;}
        Public String count_Wrong_Number_ALI_c{get;set;}
        
       
        
        Public String custom_Remarks_c{get;set;}
        Public String customer_Segmentation_c{get;set;}
        PUBLIC BOOLEAN data_Salah_c{get;set;}
        
        Public String date_Time_c{get;set;}
        Public String date_When_Customer_Call_c{get;set;}
        Public String dateline_c{get;set;}
        
        
        
       
        Public String emoticon_c{get;set;}
        Public String endCall_c{get;set;}
        
        
       
        Public String exchange_Rate_c{get;set;}
        
        
        Public String ext_ID_F_c{get;set;}
        
        
        Public String follow_Up_Information_c{get;set;}
        Public String follow_Up_Result_c{get;set;}
        Public String follow_Up_Status_AGI_c{get;set;}
        
        
        Public String generate_Date_c{get;set;}
        Public String grand_Total_Collection_Task_ALI_c{get;set;}
        Public String grand_Total_Premium_Reminder_ALI_c{get;set;}
        Public String grand_Total_Reinstate_ALI_c{get;set;}
        
        Public String grand_Total_Update_Data_ALI_c{get;set;}
        Public String home_Phone_c{get;set;}
        
        Public String id{get;set;}
        Public String iD_User_RLS_DMTM_c{get;set;}
        Public String identity_No_c{get;set;}
        Public String inception_Date_c{get;set;}
        Public String info_Pendingan_c{get;set;}
        Public String insured_Name_c{get;set;}
        PUBLIC BOOLEAN is_Allowed_c{get;set;}
        PUBLIC BOOLEAN is_Already_Assigned_c{get;set;}
        PUBLIC BOOLEAN is_Calledback_Already_c{get;set;}
        
        Public String isCallBack_c{get;set;}
        Public String isContacted_c{get;set;}
        PUBLIC BOOLEAN isDeleted{get;set;}
        Public String isFresh_c{get;set;}
        Public String isNotStarted_c{get;set;}
        PUBLIC BOOLEAN isOwnerQueue_c{get;set;}
        Public String issued_Date_Contact_c{get;set;}
        Public String isUnwilling_c{get;set;}
        PUBLIC BOOLEAN isWelcomeCallPeriod_c{get;set;}
        
        
        Public String keterangan_c{get;set;}
        
        Public String last_Answer_c{get;set;}
        
        PUBLIC DATETIME last_Modified_Date_Time_c{get;set;}
        Public String last_Response_Date_c{get;set;}
        
        Public String last_Status_Date_Field_c{get;set;}
        Public String last_Status_Field_c{get;set;}
        Public String last_Survey_Type_c{get;set;}
        Public String lastActivityDate{get;set;}
        
        
        PUBLIC DATETIME lastModifiedDateOnly_c{get;set;}
        Public String lastReferencedDate{get;set;}
        Public String lastViewedDate{get;set;}
       
        Public String loB_AGI_c{get;set;}
        
        
        
        
        
        Public String monthsPaid_c{get;set;}
        
        
        Public String name{get;set;}
       
        
        Public String nilai_Conservation_c{get;set;}
        Public String nilai_Withdrawal_c{get;set;}
        Public String no_c{get;set;}
        PUBLIC BOOLEAN no_Interaction_ICF_c{get;set;}
        
       
       
        Public String number_Of_Call_c{get;set;}
        Public String number_of_Outbound_FTE_c{get;set;}
        Public String offering2_c{get;set;}
        
        Public String offering_Retain_c{get;set;}
               
        
        Public String open_Cases_c{get;set;}
        Public String open_Cases_Fml_c{get;set;}
        
        Public String owner_c{get;set;}
        Public String owner_Entity_c{get;set;}
        Public String owner_Profile_c{get;set;}
        Public String ownerId{get;set;}
        Public String paidToDate_c{get;set;}
        Public String parent_c{get;set;}
       
        
        Public String parent_Name_Mobile_c{get;set;}
        
        Public String phone_2_c{get;set;}
        Public String phone_3_c{get;set;}
        Public String phone_c{get;set;}
        
        Public String piC_Travel_AGI_c{get;set;}
        Public String policy_Effective_Date_c{get;set;}
        
        Public String policy_No_c{get;set;}
        
        Public String polis_Batch_c{get;set;}
        
        Public String preferred_Phone_c{get;set;}
        Public String premi_Ke_c{get;set;}
        
        
        Public String prev_Acc_Balance_c{get;set;}
       
        Public String priority_Customer_c{get;set;}
      
        
        Public String q1_c{get;set;}
        Public String q2_c{get;set;}
        Public String q3_c{get;set;}
        Public String q4_c{get;set;}
        Public String q5_c{get;set;}
        Public String reason_Status_Config_c{get;set;}
        Public String recordTypeId{get;set;}
        
        Public String related_Policy_Counter_c{get;set;}
        
        
        Public Datetime request_Date_c{get;set;}
        PUBLIC BOOLEAN request_No_Interaction_ICF_c{get;set;}
        Public String reschedule_Date_c{get;set;}
        
        Public String result_Verification_c{get;set;}
       
        Public String s1_c{get;set;}
        Public String s2_c{get;set;}
        Public String s3_c{get;set;}
        Public String s4_c{get;set;}
        Public String s5_c{get;set;}
        Public String selisih_c{get;set;}
        Public String sisa_Waktu_Follow_Up_c{get;set;}
        Public String smS_Date_c{get;set;}
        Public String source_AGI_c{get;set;}
        Public String source_Collection_c{get;set;}
        Public String status_has_call_c{get;set;}
       
        
        Public String status_Request_No_Interaction_c{get;set;}
        Public String status_Retry_c{get;set;}
        Public String success_Case_c{get;set;}
        Public String survey_ID_c{get;set;}
        Public String survey_Method_c{get;set;}
        Public String survey_Name_c{get;set;}
        Public String survey_Submethod_c{get;set;}
        Public String survey_Type_c{get;set;}
        Public String survey_URL_c{get;set;}
        PUBLIC DATETIME systemModstamp{get;set;}
        Public String talk_Time_c{get;set;}
        Public String tanggal_Closed_AGI_c{get;set;}
        
        Public String tanggal_Email_Complaint_AGI_c{get;set;}
        Public String tanggal_Eskalasi_AGI_1_c{get;set;}
        Public String tanggal_Eskalasi_AGI_2_c{get;set;}
        Public String tanggal_Eskalasi_AGI_3_c{get;set;}
        
        Public String tanggal_Pengajuan_AGI_c{get;set;}
       
        
        
        Public String topic_c{get;set;}
        Public String total_Acc_Balance_c{get;set;}
        Public String total_Answer_by_Other_c{get;set;}
        Public String total_Approved_c{get;set;}
        Public String total_Busy_Line_c{get;set;}
        Public String total_Cancel_c{get;set;}
        Public String total_Conserved_c{get;set;}
        Public String total_Contact_Collection_Task_ALI_c{get;set;}
        Public String total_Contact_Premium_Reminder_ALI_c{get;set;}
        Public String total_Contact_Reinstate_ALI_c{get;set;}
        Public String total_Contact_Retention_ALI_c{get;set;}
        Public String total_Disconnected_c{get;set;}
        Public String total_Follow_Up_c{get;set;}
        Public String total_Inforce_c{get;set;}
        Public String total_Invalid_Number_c{get;set;}
        Public String total_Mailbox_c{get;set;}
        Public String total_No_Answer_c{get;set;}
        Public String total_No_Follow_Up_c{get;set;}
        Public String total_No_Number_c{get;set;}
        Public String total_Not_Approved_c{get;set;}
        Public String total_Not_Reachable_3x_c{get;set;}
        Public String total_Not_Reachable_c{get;set;}
        Public String total_Paid_c{get;set;}
        Public String total_Paid_Approved_c{get;set;}
        Public String total_Paid_Contacted_c{get;set;}
        Public String total_Paid_Uncontacted_c{get;set;}
        Public String total_Rescheduled_c{get;set;}
        Public String total_Retain_Redemption_c{get;set;}
        Public String total_Retain_Withdrawal_c{get;set;}
        Public String total_Uncontacted_c{get;set;}
        
        Public String total_Voice_Mail_c{get;set;}
        Public String total_Withdrawn_c{get;set;}
        Public String total_Wrong_Number_c{get;set;}
        Public String totalNCB_c{get;set;}
        Public String transaction_Date_c{get;set;}
        Public String uncontacted_Reason_c{get;set;}
        
        Public String update_Email_c{get;set;}
        
        Public String used_Phone_c{get;set;}
        
       
        
        Public String welcomeCall_Cooling_Off2_c{get;set;}
        
        
        Public String welcomeCall_Customer_Satisfaction_c{get;set;}
        Public String welcomeCall_Days_c{get;set;}
        
        PUBLIC BOOLEAN welcomeCall_Fg_Round_Robin_c{get;set;}
        
        
       
        Public String welcomeCall_Period_Day_c{get;set;}
        
       
        Public String welcomeCall_Reschedule_Source_c{get;set;}
        
        PUBLIC DATETIME welcomeCall_Today_c{get;set;}*/
        Public String tidak_Bersedia_Diverifikasi_c{get;set;}
        Public String bersedia_Diverivikasi_c{get;set;}
        Public String entity_c{get;set;}
        Public String periode_Terdebet_c{get;set;}
        Public String nominal_c{get;set;}
        Public String nama_Bank_c{get;set;}
        Public String retur_Payment_c{get;set;}
        Public String fU_c{get;set;}
        Public String assigN_c{get;set;}
        Public String birthday_c{get;set;}
        Public String title_c{get;set;}
        Public String total_Uncontacted_New_c{get;set;}
        Public String zipcodE_c{get;set;}
        Public String reporT_POLICY_DELIVERY_c{get;set;}
        Public String description_c{get;set;}
        PUBLIC BOOLEAN welcomeCall_Fg_Schedule_c{get;set;}
        Public String Call_status_config_c {get;set;}
        Public String policy_No_c{get;set;}
        Public String Contact_c {get;set;}
        Public String Contact_name {get;set;}
        Public String call_Remarks_c{get;set;}
        Public String call_List_c{get;set;}
        Public String call_List_name{get;set;}
        Public String campaign_name{get;set;} 
        Public String total_Retain_Withdrawal_c{get;set;}
        Public String amount_Retain_Redemption_c{get;set;}
        Public String amount_Retain_Withdrawal_c{get;set;}
        PUBLIC DATETIME campaign_Generated_Date_c{get;set;}
        Public String welcomeCall_Reschedule_Source_c{get;set;}
        PUBLIC BOOLEAN isWelcomeCallPeriod_c{get;set;}
        Public String apE_Contact_c{get;set;}
        Public String welcomeCall_Period_Day_c{get;set;}
        Public String APE_Convert_MPS_c{get;set;}
        Public String reason_Status_Config_c{get;set;}
        Public String contacted_Number_c{get;set;}
        Public String home_Phone_c{get;set;}
        Public String phone_c{get;set;}
        Public String preferred_Phone_c{get;set;}
        Public Datetime reschedule_Date_c{get;set;}
        Public Datetime date_reschedule_c{get;set;}
        Public String total_Uncontacted_c{get;set;}
        Public String survey_Method_c{get;set;}
        PUBLIC BOOLEAN request_No_Interaction_ICF_c{get;set;}
        Public String survey_Submethod_c{get;set;}
        PUBLIC BOOLEAN no_Interaction_ICF_c{get;set;}
        Public String status_Request_No_Interaction_c{get;set;} 
        Public String last_Survey_Type_c{get;set;}
        Public String last_Answer_c{get;set;}
        Public String emoticon_c{get;set;} 
        PUBLIC DATETIME call_Date_c{get;set;}
        Public String nilai_Conservation_c{get;set;}
        Public String nilai_Withdrawal_c{get;set;}
        Public String selisih_c{get;set;}
        Public String offering_Retain_c{get;set;}
        Public String last_Case_c{get;set;}
        Public DATETIME last_Response_Date_c{get;set;}
        Public String name{get;set;}
        Public String activity_Result_c{get;set;}
        Public String verification_c{get;set;}
        Public String campaign_Name_c{get;set;}
        Public String jawaban_Nama_PP_TT_c{get;set;}
        Public String remarks_Nama_PP_TT_c{get;set;}
        Public String error_Nama_PP_TT_c{get;set;}
        Public String remarks_DOB_c{get;set;}
 		Public String error_DOB_c{get;set;}
 		Public String jawaban_DOB_c{get;set;}
        Public String remarks_Alamat_c{get;set;}
        Public String jawaban_Alamat_c{get;set;}
        Public String error_Alamat_c{get;set;}
        Public String remarks_Agent_Validation_c{get;set;}
        Public String remarks_Email_c{get;set;}
        Public String remarks_ePolicy_Buku_Polis_c{get;set;}
        Public String remarks_Telepon_c{get;set;}
        Public String jawaban_Agent_Validation_c{get;set;}
        Public String jawaban_Email_c{get;set;}
        Public String jawaban_ePolicy_Buku_Polis_c{get;set;}
        Public String jawaban_Telepon_c{get;set;}
        Public String error_Agent_Validation_c{get;set;}
        Public String error_Email_c{get;set;}
        Public String error_ePolicy_Buku_Polis_c{get;set;}
        Public String error_Telepon_c{get;set;}
        Public String error_Understand_Product_c{get;set;}
        Public String jawaban_Understand_Product_c{get;set;}
        Public String remark_Hold_Debet_c{get;set;}
        Public String remarks_Understand_Product_c{get;set;}
        Public String apE_Convert_c{get;set;}
        Public String recordTypeId{get;set;}
        Public String recordType_name {get;set;}
        Public String owner_c{get;set;}
        Public String owner_name {get;set;}
        Public String agent_c{get;set;}
        Public String agent_name{get;set;}
        Public String customer_Segmentation_c{get;set;}
        Public String parent_Call_Line_c{get;set;}
        Public String parent_Call_Line_name{get;set;}
        Public String status_Retry_c{get;set;}
        Public String collection_Call_Date_c{get;set;}
        Public String status_has_call_c{get;set;}
		Public String status_Paid_Not_Paid_c{get;set;}        
        Public String call_Notes_1_c{get;set;}
        Public String call_Notes_2_c{get;set;}
        Public String call_Notes_3_c{get;set;}
        Public String apE_c{get;set;}
        Public Datetime tanggal_Hold_Debet_c{get;set;}
        Public String currency_c{get;set;}
        Public String phone_Sending_SMS_c{get;set;}
        Public String message_c{get;set;}
        Public String time_Reschedule_c{get;set;}
        Public String createdById{get;set;}
        Public String createdById_name{get;set;}
        Public String lastModifiedById{get;set;}
        Public String lastModifiedById_name{get;set;}
        PUBLIC DATETIME createdDate{get;set;}
        PUBLIC DATETIME lastModifiedDate{get;set;}
        Public String ext_ID_c{get;set;}
        Public String ext_ID_Temp_c{get;set;}
        Public String nomor_Rekening_c{get;set;}
        Public Datetime tanggal_Debet_c{get;set;}
        Public String jumlah_yang_didebet_c{get;set;}
        Public String case_c{get;set;}
        Public String case_number{get;set;}
        Public String amount_c{get;set;}
		Public String apE_Total_Child_c{get;set;}  
        Public String f_User_Detail_c{get;set;}
        Public String product_c{get;set;}
        Public String formula_Product_c{get;set;}
        Public String progress_c{get;set;}
        PUBLIC BOOLEAN confirm_c{get;set;}
        Public String child_Count_c{get;set;}
        Public String Year_of_Policy_Effective_Date_c {get;set;}
        PUBLIC BOOLEAN isOwnerQueue_c{get;set;}
        Public String batch_No_c{get;set;}
        Public String change_of_Email_c{get;set;}
        Public String change_of_Financial_c{get;set;}
        Public String change_of_Non_Financal_c{get;set;}
        Public String contact_Email_c{get;set;}
        Public String update_Email_c{get;set;}
        Public String nama_Pemilik_CC_c{get;set;}
        Public String nama_Pemilik_Rekening_c{get;set;}
        Public String nomor_CC_c{get;set;}
        Public Datetime cC_Expired_Date_c{get;set;}
        Public String mcM_c{get;set;}
        Public String new_Plan_Value_c{get;set;}
        Public String old_Plan_Value_c{get;set;}
        Public String address_1_c{get;set;}
        Public String address_2_c{get;set;}
        Public String address_3_c{get;set;}
        Public String address_4_c{get;set;}
        Public String postCode_c{get;set;}
        Public String city_c{get;set;}
        Public String notes_c{get;set;}
        PUBLIC DATETIME expired_Date_c{get;set;}
        Public Datetime welcomeCall_Cooling_Off2_c{get;set;}
        Public datetime welcomeCall_First_Call_Date_c{get;set;}
        Public String welcomeCall_Criteria_c{get;set;}
        Public String welcomeCall_Attempt_c{get;set;}
        Public Datetime welcomeCall_Schedule_Date_c{get;set;}
        Public String welcomeCall_Reference_c{get;set;}
        Public String welcomeCall_Hour_Schedule_Date_c{get;set;}
        Public String welcomeCall_Call_Line_Status_c{get;set;}
        Public String welcomeCall_Detail_Status_c{get;set;}
        Public String welcomeCall_Reason_Detail_Status_c{get;set;}
        PUBLIC BOOLEAN is_Expired_c{get;set;}
        Public String other_Phone_c{get;set;}
        Public String count_Dial_c{get;set;}
		PUBLIC BOOLEAN update_Child_c{get;set;}
		Public String result_c{get;set;}
		Public String campaign_Type_c{get;set;}
        Public String grand_Total_Retention_ALI_c{get;set;}
        Public String parent_Campaign_c{get;set;}
		Public String parent_Campaign_Name{get;set;}
        Public String count_Blank_ALI_c{get;set;}
        Public Datetime last_Call_c{get;set;}
        Public Datetime last_SMS_c{get;set;}
        Public String poliS_c{get;set;}
        Public String changes_c{get;set;}
        Public String update_KTP_c{get;set;}
        Public String updateEmail_c{get;set;}
        Public Datetime effective_Date_c{get;set;}
        Public String effective_Date_string{get;set;}
        Public String name_1_c{get;set;}
        Public String name_2_c{get;set;}
        Public String method_c{get;set;}
        Public String correspondencetypeiD_c{get;set;}
        Public String line11_c{get;set;}
        Public String line12_c{get;set;}
        Public String line13_c{get;set;}
        Public String line1_c{get;set;}
        Public String mobilePhone2_Upload_c{get;set;}
        Public String mobilePhone_Upload_c{get;set;}
        Public String officephonE2_c{get;set;}
        Public String officephonE_c{get;set;}
		Public String homephonE2_c{get;set;}
        Public String homephonE_c{get;set;}
        Public String email_upload_c{get;set;}
        Public Datetime delivereddate_c{get;set;}
        Public String refference_No_c{get;set;}
        Public String rejReason_c{get;set;}
        Public String month_c{get;set;}
        Public String offering_c{get;set;}
        Public String priority_c{get;set;}
        Public String old_Result_c{get;set;}
        Public String status_Polis_c{get;set;}
        Public Integer premium_c{get;set;}
        Public String premium2_c{get;set;}
        Public String policy_Holder_Name_c{get;set;}
        Public String ktp_c{get;set;}
        Public String retention_Alasan_Pembatalan_c{get;set;}
        Public String retention_FC_c{get;set;}
        PUBLIC DATETIME retention_Follow_Up_Date_c{get;set;}
        Public String retention_Note_c{get;set;}
        Public String retention_Program_c{get;set;}
        Public String retention_Remark_c{get;set;}
        PUBLIC DATETIME retention_Request_Date_c{get;set;}
        Public String retention_Result_c{get;set;}
        Public String retention_Result_Status_c{get;set;}
       
        
        
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						/*IF (text == 'a1__c') { a1_c = parser.getText();}
                        ELSE IF (text == 'a1_Point__c') { a1_Point_c = parser.getText();}
                        ELSE IF (text == 'a2__c') { a2_c = parser.getText();}
                        ELSE IF (text == 'a2_Point__c') { a2_Point_c = parser.getText();}
                        ELSE IF (text == 'a3__c') { a3_c = parser.getText();}
                        ELSE IF (text == 'a3_Point__c') { a3_Point_c = parser.getText();}
                        ELSE IF (text == 'a4__c') { a4_c = parser.getText();}
                        ELSE IF (text == 'a4_Point__c') { a4_Point_c = parser.getText();}
                        ELSE IF (text == 'a5__c') { a5_c = parser.getText();}
                        ELSE IF (text == 'a5_Point__c') { a5_Point_c = parser.getText();}
                        ELSE IF (text == 'activity__c') { activity_c = parser.getText();}
                        ELSE IF (text == 'activity_Config__c') { activity_Config_c = parser.getText();}
                       
                      
                        ELSE IF (text == 'agent_ID__c') { agent_ID_c = parser.getText();}
                        
                        ELSE IF (text == 'amount_Approved__c') { amount_Approved_c = parser.getText();}
                        ELSE IF (text == 'amount_Cancel__c') { amount_Cancel_c = parser.getText();}
                        ELSE IF (text == 'amount_Conserved__c') { amount_Conserved_c = parser.getText();}
                        ELSE IF (text == 'amount_Contacted__c') { amount_Contacted_c = parser.getText();}
                        ELSE IF (text == 'amount_Not_Approved__c') { amount_Not_Approved_c = parser.getText();}
                        ELSE IF (text == 'amount_Paid__c') { amount_Paid_c = parser.getText();}
                        ELSE IF (text == 'amount_Paid_Approved__c') { amount_Paid_Approved_c = parser.getText();}
                        ELSE IF (text == 'amount_Paid_Bio__c') { amount_Paid_Bio_c = parser.getText();}
                        ELSE IF (text == 'amount_Paid_Contacted__c') { amount_Paid_Contacted_c = parser.getText();}
                        ELSE IF (text == 'amount_Paid_Uncontacted__c') { amount_Paid_Uncontacted_c = parser.getText();}*/
                        IF (text == 'amount_Retain_Redemption__c') { amount_Retain_Redemption_c = parser.getText();}
                        ELSE IF (text == 'address_1__c') { address_1_c = parser.getText();}
                        ELSE IF (text == 'address_2__c') { address_2_c = parser.getText();}
                        ELSE IF (text == 'address_3__c') { address_3_c = parser.getText();}
                        ELSE IF (text == 'address_4__c') { address_4_c = parser.getText();}
                       
                        ELSE IF (text == 'amount__c') { amount_c = parser.getText();}
                        ELSE IF (text == 'amount_Retain_Withdrawal__c') { amount_Retain_Withdrawal_c = parser.getText();}
                        ELSE IF (text == 'activity_Result__c') { activity_Result_c = parser.getText();}
                        ELSE IF (text == 'agent__c') { 
                            agent_c = parser.getText();
                            if(agent_c != null) agent_name =  AXAAPI_UtilityClass.getsObjectNameById(agent_c, 'User', 'Name');
                        }
                        ELSE IF (text == 'apE__c') { apE_c = parser.getText();}
                       /* ELSE IF (text == 'amount_Uncontacted__c') { amount_Uncontacted_c = parser.getText();}
                        
                        ELSE IF (text == 'apE_Amount_Bio__c') { apE_Amount_Bio_c = parser.getText();}*/
                        ELSE IF (text == 'apE_Contact__c') { apE_Contact_c = parser.getText();}
                        ELSE IF (text == 'apE_Convert__c') { apE_Convert_c = parser.getText();}
                        ELSE IF (text == 'apE_Total_Child__c') { apE_Total_Child_c = parser.getText();}
                        ELSE IF (text == 'batch_No__c') { batch_No_c = parser.getText();}
                        ELSE IF (text == 'assigN__c') { assigN_c = parser.getText();}
                        ELSE IF (text == 'bersedia_Diverivikasi__c') { bersedia_Diverivikasi_c = parser.getText();}
                         /*
                        
                        ELSE IF (text == 'call_Attempt__c') { call_Attempt_c = parser.getText();}*/
                        ELSE IF (text == 'birthday__c') { birthday_c = parser.getText();}
                        ELSE IF (text == 'call_Date__c') { call_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        /*ELSE IF (text == 'call_Duration_Minutes__c') { call_Duration_Minutes_c = parser.getText();}
                        ELSE IF (text == 'call_End_Datetime__c') { call_End_Datetime_c = parser.getText();}
                        ELSE IF (text == 'call_Generated_Counter__c') { call_Generated_Counter_c = parser.getText();}*/
                        ELSE IF (text == 'call_List__c') { 
                            call_List_c = parser.getText();
                             	
                            /* if (call_List_c != null) {                                     
                                AXAAPI023B_response getData  = AXAAPI023B_CallListByID.getCallListByID(call_List_c);   
                                if(getData != null && getData.data != null ) call_List_name = getData.data.Name;  
                            }*/
                            if (call_List_c != null) call_List_name = AXAAPI_UtilityClass.getsObjectNameById(call_List_c, 'Call_List__C', 'Name');
                        }
                        ELSE IF (text == 'call_Notes_1__c') { call_Notes_1_c = parser.getText();}
                        ELSE IF (text == 'call_Notes_2__c') { call_Notes_2_c = parser.getText();}
                        ELSE IF (text == 'call_Notes_3__c') { call_Notes_3_c = parser.getText();}
                        ELSE IF (text == 'call_Remarks__c') { 
                            call_Remarks_c = parser.getText();
                            call_Remarks_c = call_Remarks_c.replace('\n','<br/>'); 
                        }
                        /*ELSE IF (text == 'call_Result__c') { call_Result_c = parser.getText();}
                        ELSE IF (text == 'call_Start_Datetime__c') { call_Start_Datetime_c = parser.getText();}*/
                        ELSE IF (text == 'call_Status_Config__c') { call_Status_Config_c = parser.getText();}
                        /*ELSE IF (text == 'call_Status_History__c') { call_Status_History_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'call_Status_Label__c') { call_Status_Label_c = parser.getText();}*/
                        /*ELSE IF (text == 'call_status_old_new_not_equal__c') { 
                            String a = parser.getText();
                            call_status_old_new_not_equal_c = Boolean.valueOf(a);
                        }*/
                        ELSE IF (text == 'campaign_Generated_Date__c') { campaign_Generated_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'campaign_Name__c') { campaign_Name_c = parser.getText();}
                        ELSE IF (text == 'case__c') { 
                            case_c = parser.getText(); 
                            /* if (case_c != null) {                                     
                                AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(case_c);   
                                if(getData != null && getData.data != null ) case_number = getData.data.caseNumber;  
                            } */
                            if(case_c != null) case_number = AXAAPI_UtilityClass.getsObjectNameById(case_c, 'Case', 'CaseNumber');
                        }
                        ELSE IF (text == 'change_of_Email__c') { change_of_Email_c = parser.getText();}
                        ELSE IF (text == 'change_of_Financial__c') { change_of_Financial_c = parser.getText();}
                        ELSE IF (text == 'change_of_Non_Financal__c') { change_of_Non_Financal_c = parser.getText();}
                        ELSE IF (text == 'cC_Expired_Date__c') { cC_Expired_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'campaign_Type__c') { campaign_Type_c = parser.getText();}
                        ELSE IF (text == 'changes__c') { changes_c = parser.getText();}
                        /*
                        
                       
                        ELSE IF (text == 'case_Type__c') { case_Type_c = parser.getText();}
                        ELSE IF (text == 'case_Type_Config__c') { case_Type_Config_c = parser.getText();}
                        
                        ELSE IF (text == 'chanel__c') { chanel_c = parser.getText();}
                        
                       
                        
                        ELSE IF (text == 'child_Count_Formula__c') { child_Count_Formula_c = parser.getText();}
                       
                        ELSE IF (text == 'claim_No__c') { claim_No_c = parser.getText();}
                        
                        ELSE IF (text == 'collection_Call_Date_F__c') { collection_Call_Date_F_c = parser.getText();}
                        ELSE IF (text == 'collection_Target__c') { collection_Target_c = parser.getText();}*/
                        /*
                        
                       
                        ELSE IF (text == 'contact_Policy_App__c') { contact_Policy_App_c = parser.getText();}*/
                        ELSE IF (text == 'city__c') { city_c = parser.getText();}
                        ELSE IF (text == 'contact_Email__c') { contact_Email_c = parser.getText();}
                        ELSE IF (text == 'child_Count__c') { child_Count_c = parser.getText();}
                        ELSE IF (text == 'confirm__c') { 
                            String a = parser.getText();
                            confirm_c = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'collection_Call_Date__c') { collection_Call_Date_c = parser.getText();}
                        ELSE IF (text == 'contacted_Number__c') { contacted_Number_c = parser.getText();}
                        ELSE IF (text == 'contact__c') { 
                            contact_c = parser.getText();
                        	if (contact_c != null) contact_name = AXAAPI_UtilityClass.getsObjectNameById(contact_c, 'Contact', 'Name');
                        }
                        ELSE IF (text == 'createdDate') { createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'currency__c') { currency_c = parser.getText();}
                        ELSE IF (text == 'count_Dial__c') { count_Dial_c = parser.getText();}
                        ELSE IF (text == 'count_Blank_ALI__c') { count_Blank_ALI_c = parser.getText();}
                        ELSE IF (text == 'correspondencetypeiD__c') { correspondencetypeiD_c = parser.getText();}
                        /*ELSE IF (text == 'count_Agent_Validation__c') { count_Agent_Validation_c = parser.getText();}
                        
                        ELSE IF (text == 'count_Cancel_ALI__c') { count_Cancel_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Complaint_ALI__c') { count_Complaint_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Contacted__c') { count_Contacted_c = parser.getText();}
                        ELSE IF (text == 'count_Data2__c') { count_Data2_c = parser.getText();}
                        ELSE IF (text == 'count_Data__c') { count_Data_c = parser.getText();}
                        
                        ELSE IF (text == 'count_Done_ALI__c') { count_Done_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Eksternal_Error_Alamat__c') { count_Eksternal_Error_Alamat_c = parser.getText();}
                        ELSE IF (text == 'count_Eksternal_Error_DOB__c') { count_Eksternal_Error_DOB_c = parser.getText();}
                        ELSE IF (text == 'count_Eksternal_Error_Email__c') { count_Eksternal_Error_Email_c = parser.getText();}
                        ELSE IF (text == 'count_Eksternal_Error_Nama_PP_TT__c') { count_Eksternal_Error_Nama_PP_TT_c = parser.getText();}
                        ELSE IF (text == 'count_Eksternal_Error_Telepon__c') { count_Eksternal_Error_Telepon_c = parser.getText();}
                        ELSE IF (text == 'count_Follow_Up_ALI__c') { count_Follow_Up_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Hard_Contact_ALI__c') { count_Hard_Contact_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Inforce_ALI__c') { count_Inforce_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Internal_Error_Alamat__c') { count_Internal_Error_Alamat_c = parser.getText();}
                        ELSE IF (text == 'count_Internal_Error_DOB__c') { count_Internal_Error_DOB_c = parser.getText();}
                        ELSE IF (text == 'count_Internal_Error_Email__c') { count_Internal_Error_Email_c = parser.getText();}
                        ELSE IF (text == 'count_Internal_Error_Nama_PP_TT__c') { count_Internal_Error_Nama_PP_TT_c = parser.getText();}
                        ELSE IF (text == 'count_Internal_Error_Telepon__c') { count_Internal_Error_Telepon_c = parser.getText();}
                        ELSE IF (text == 'count_Keterangan_Data_KYC__c') { count_Keterangan_Data_KYC_c = parser.getText();}
                        ELSE IF (text == 'count_No_Follow_Up_ALI__c') { count_No_Follow_Up_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_No_Interest_ALI__c') { count_No_Interest_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_No_Pickup_Mailbox_ALI__c') { count_No_Pickup_Mailbox_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Redebet_ALI__c') { count_Redebet_ALI_c = parser.getText();}
                        ELSE IF (text == 'count_Redemption__c') { count_Redemption_c = parser.getText();}
                        ELSE IF (text == 'count_Uncontacted__c') { count_Uncontacted_c = parser.getText();}
                        ELSE IF (text == 'count_Understand_Product__c') { count_Understand_Product_c = parser.getText();}
                        ELSE IF (text == 'count_Withdrawal__c') { count_Withdrawal_c = parser.getText();}
                        ELSE IF (text == 'count_Wrong_Number_ALI__c') { count_Wrong_Number_ALI_c = parser.getText();}
                        
                        
                        
                        ELSE IF (text == 'custom_Remarks__c') { custom_Remarks_c = parser.getText();}
                        
                        ELSE IF (text == 'data_Salah__c') { 
                        	String a = parser.getText();
                            data_Salah_c = Boolean.valueOf(a);
                        }
                        
                        ELSE IF (text == 'date_Time__c') { date_Time_c = parser.getText();}
                        ELSE IF (text == 'date_When_Customer_Call__c') { date_When_Customer_Call_c = parser.getText();}
                        ELSE IF (text == 'dateline__c') { dateline_c = parser.getText();}
                        
                       */
                        ELSE IF (text == 'delivereddate__c') { delivereddate_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'email_upload__c') { email_upload_c = parser.getText();} 
                        ELSE IF (text == 'effective_Date__c') { 
                            effective_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        	effective_Date_string = parser.getText();
                        }
                        ELSE IF (text == 'description__c') { description_c = parser.getText();}
                        ELSE IF (text == 'createdById') { 
                            createdById = parser.getText();
                        	if(createdById != null) createdById_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
                        }
                        ELSE IF (text == 'date_Reschedule__c') { date_Reschedule_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'customer_Segmentation__c') { customer_Segmentation_c = parser.getText();}
                        ELSE IF (text == 'emoticon__c') { emoticon_c = parser.getText();}
                        ELSE IF (text == 'error_Nama_PP_TT__c') { error_Nama_PP_TT_c = parser.getText();}
                        ELSE IF (text == 'error_DOB__c') { error_DOB_c = parser.getText();}
                        ELSE IF (text == 'error_Alamat__c') { error_Alamat_c = parser.getText();}
                        ELSE IF (text == 'error_Agent_Validation__c') { error_Agent_Validation_c = parser.getText();} 
                        ELSE IF (text == 'error_Email__c') { error_Email_c = parser.getText();}
                        ELSE IF (text == 'error_ePolicy_Buku_Polis__c') { error_ePolicy_Buku_Polis_c = parser.getText();}
                        ELSE IF (text == 'error_Telepon__c') { error_Telepon_c = parser.getText();}
                        ELSE IF (text == 'error_Understand_Product__c') { error_Understand_Product_c = parser.getText();}
                        ELSE IF (text == 'ext_ID__c') { ext_ID_c = parser.getText();}
                        ELSE IF (text == 'ext_ID_Temp__c') { ext_ID_Temp_c = parser.getText();}
                        ELSE IF (text == 'f_User_Detail__c') { f_User_Detail_c = parser.getText();}
                        ELSE IF (text == 'formula_Product__c') { formula_Product_c = parser.getText();}
                        ELSE IF (text == 'expired_Date__c') { expired_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'entity__c') { entity_c = parser.getText();}
                        /*ELSE IF (text == 'endCall__c') { endCall_c = parser.getText();}
                        
                        
                       
                        ELSE IF (text == 'exchange_Rate__c') { exchange_Rate_c = parser.getText();}
                       
                        
                        ELSE IF (text == 'ext_ID_F__c') { ext_ID_F_c = parser.getText();}
                       
                        
                        ELSE IF (text == 'follow_Up_Information__c') { follow_Up_Information_c = parser.getText();}
                        ELSE IF (text == 'follow_Up_Result__c') { follow_Up_Result_c = parser.getText();}
                        ELSE IF (text == 'follow_Up_Status_AGI__c') { follow_Up_Status_AGI_c = parser.getText();}
                        
                        
                        ELSE IF (text == 'generate_Date__c') { generate_Date_c = parser.getText();}
                        ELSE IF (text == 'grand_Total_Collection_Task_ALI__c') { grand_Total_Collection_Task_ALI_c = parser.getText();}
                        ELSE IF (text == 'grand_Total_Premium_Reminder_ALI__c') { grand_Total_Premium_Reminder_ALI_c = parser.getText();}
                        ELSE IF (text == 'grand_Total_Reinstate_ALI__c') { grand_Total_Reinstate_ALI_c = parser.getText();}
                        
                        ELSE IF (text == 'grand_Total_Update_Data_ALI__c') { grand_Total_Update_Data_ALI_c = parser.getText();}*/
                        ELSE IF (text == 'fU__c') { fU_c = parser.getText();}
                        ELSE IF (text == 'home_Phone__c') { home_Phone_c = parser.getText();}
                        ELSE IF (text == 'grand_Total_Retention_ALI__c') { grand_Total_Retention_ALI_c = parser.getText();}
                        ELSE IF (text == 'homephonE2__c') { homephonE2_c = parser.getText();}
                        ELSE IF (text == 'homephonE__c') { homephonE_c = parser.getText();}
                        /*
                        ELSE IF (text == 'id') { id = parser.getText();}
                        ELSE IF (text == 'iD_User_RLS_DMTM__c') { iD_User_RLS_DMTM_c = parser.getText();}
                        ELSE IF (text == 'identity_No__c') { identity_No_c = parser.getText();}
                        ELSE IF (text == 'inception_Date__c') { inception_Date_c = parser.getText();}
                        ELSE IF (text == 'info_Pendingan__c') { info_Pendingan_c = parser.getText();}
                        ELSE IF (text == 'insured_Name__c') { insured_Name_c = parser.getText();}
                        ELSE IF (text == 'is_Allowed__c') { 
                            String a = parser.getText();
                            is_Allowed_c = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'is_Already_Assigned__c') { 
                            String a = parser.getText();
                            is_Already_Assigned_c = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'is_Calledback_Already__c') { 
                        	String a = parser.getText();
                            is_Calledback_Already_c = Boolean.valueOf(a);    
                        }
                        
                        ELSE IF (text == 'isCallBack__c') { isCallBack_c = parser.getText();}
                        ELSE IF (text == 'isContacted__c') { isContacted_c = parser.getText();}
                        ELSE IF (text == 'isDeleted') { 
                            String a = parser.getText();
                            isDeleted = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'isFresh__c') { isFresh_c = parser.getText();}
                        ELSE IF (text == 'isNotStarted__c') { isNotStarted_c = parser.getText();}
                        
                        ELSE IF (text == 'issued_Date_Contact__c') { issued_Date_Contact_c = parser.getText();}
                        ELSE IF (text == 'isUnwilling__c') { isUnwilling_c = parser.getText();}*/
                        ELSE IF (text == 'is_Expired__c') {  
                            String a = parser.getText();
                            is_Expired_c = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'isOwnerQueue__c') { 
                         	String a = parser.getText();
                            isOwnerQueue_c = Boolean.valueOf(a);    
                        }
                        ELSE IF (text == 'isWelcomeCallPeriod__c') { 
                            String a = parser.getText();
                            isWelcomeCallPeriod_c = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'jawaban_Nama_PP_TT__c') { jawaban_Nama_PP_TT_c = parser.getText();}
                        ELSE IF (text == 'jawaban_DOB__c') { jawaban_DOB_c = parser.getText();}
                        ELSE IF (text == 'jawaban_Alamat__c') { jawaban_Alamat_c = parser.getText();}
                        ELSE IF (text == 'jawaban_Agent_Validation__c') { jawaban_Agent_Validation_c = parser.getText();}
                        ELSE IF (text == 'jawaban_DOB__c') { jawaban_DOB_c = parser.getText();}
                        ELSE IF (text == 'jawaban_Email__c') { jawaban_Email_c = parser.getText();}
                        ELSE IF (text == 'jawaban_Telepon__c') { jawaban_Telepon_c = parser.getText();}
                        ELSE IF (text == 'jawaban_Understand_Product__c') { jawaban_Understand_Product_c = parser.getText();}
                        ELSE IF (text == 'jawaban_ePolicy_Buku_Polis__c') { jawaban_ePolicy_Buku_Polis_c = parser.getText();}
                        ELSE IF (text == 'jumlah_yang_didebet__c') { jumlah_yang_didebet_c = parser.getText();}
                        /*
                        
                        
                        
                        ELSE IF (text == 'keterangan__c') { keterangan_c = parser.getText();}*/
                        ELSE IF (text == 'ktP__c') { ktP_c = parser.getText();}
                        ELSE IF (text == 'last_Answer__c') { last_Answer_c = parser.getText();}
                        ELSE IF (text == 'last_Call__c') { last_Call_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'last_SMS__c') { last_SMS_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'last_Case__c') { last_Case_c = parser.getText();}
                        /*ELSE IF (text == 'last_Modified_Date_Time__c') { last_Modified_Date_Time_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}*/
                        ELSE IF (text == 'last_Response_Date__c') { last_Response_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'message__c') { message_c = parser.getText();}
                        ELSE IF (text == 'lastModifiedById') { 
                            lastModifiedById = parser.getText();
                        	if(lastModifiedById != null) lastModifiedById_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
                        }
                        ELSE IF (text == 'lastModifiedDate') { lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'line11__c') { line11_c = parser.getText();}
                        ELSE IF (text == 'line12__c') { line12_c = parser.getText();}
                        ELSE IF (text == 'line13__c') { line13_c = parser.getText();}
                        ELSE IF (text == 'line1__c') { line1_c = parser.getText();}
                        /*
                        ELSE IF (text == 'last_Status_Date_Field__c') { last_Status_Date_Field_c = parser.getText();}
                        ELSE IF (text == 'last_Status_Field__c') { last_Status_Field_c = parser.getText();}
                        ELSE IF (text == 'last_Survey_Type__c') { last_Survey_Type_c = parser.getText();}
                        ELSE IF (text == 'lastActivityDate') { lastActivityDate = parser.getText();}
                        
                        
                        ELSE IF (text == 'lastModifiedDateOnly__c') { lastModifiedDateOnly_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'lastReferencedDate') { lastReferencedDate = parser.getText();}
                        ELSE IF (text == 'lastViewedDate') { lastViewedDate = parser.getText();}
                        
                        ELSE IF (text == 'loB_AGI__c') { loB_AGI_c = parser.getText();}
                        
                        
                        
                       
                        
                        ELSE IF (text == 'monthsPaid__c') { monthsPaid_c = parser.getText();}
                        
                          */ 
                        ELSE IF (text == 'nama_Bank__c') { nama_Bank_c = parser.getText();}
                        ELSE IF (text == 'month__c') { month_c = parser.getText();}
                        ELSE IF (text == 'mobilePhone2_Upload__c') { mobilePhone2_Upload_c = parser.getText();}
                        ELSE IF (text == 'mobilePhone_Upload__c') { mobilePhone_Upload_c = parser.getText();}
                        ELSE IF (text == 'method__c') { method_c = parser.getText();}
                        ELSE IF (text == 'name_1__c') { name_1_c = parser.getText();}
                        ELSE IF (text == 'name_2__c') { name_2_c = parser.getText();}
                        ELSE IF (text == 'mcM__c') { mcM_c = parser.getText();}
                        ELSE IF (text == 'new_Plan_Value__c') { new_Plan_Value_c = parser.getText();}
                        ELSE IF (text == 'nama_Pemilik_CC__c') { nama_Pemilik_CC_c = parser.getText();}
                        ELSE IF (text == 'nama_Pemilik_Rekening__c') { nama_Pemilik_Rekening_c = parser.getText();}

                        ELSE IF (text == 'nilai_Conservation__c') { nilai_Conservation_c = parser.getText();}
                        ELSE IF (text == 'nilai_Withdrawal__c') { nilai_Withdrawal_c = parser.getText();}
                        ELSE IF (text == 'name') { name = parser.getText();}
                        /*ELSE IF (text == 'no__c') { no_c = parser.getText();}*/
                        ELSE IF (text == 'no_Interaction_ICF__c') { 
                         	String a = parser.getText();
                            no_Interaction_ICF_c = Boolean.valueOf(a);
                        }
                         ELSE IF (text == 'nomor_Rekening__c') { nomor_Rekening_c = parser.getText();}
                         ELSE IF (text == 'nomor_CC__c') { nomor_CC_c = parser.getText();}
                        ELSE IF (text == 'notes__c') { notes_c = parser.getText();}
                        ELSE IF (text == 'nominal__c') { nominal_c = parser.getText();}
                        /*
                       
                       
                        
                        ELSE IF (text == 'number_Of_Call__c') { number_Of_Call_c = parser.getText();}
                        ELSE IF (text == 'number_of_Outbound_FTE__c') { number_of_Outbound_FTE_c = parser.getText();}
                        ELSE IF (text == 'offering2__c') { offering2_c = parser.getText();}
                        */
                        ELSE IF (text == 'offering__c') { offering_c = parser.getText();}
                        ELSE IF (text == 'offering_Retain__c') { offering_Retain_c = parser.getText();}
                        ELSE IF (text == 'ownerId') { 
                            owner_c = parser.getText();
                        	if(owner_c != null) owner_name = AXAAPI_UtilityClass.getsObjectNameById(owner_c, 'User', 'Name');
                        }
                        ELSE IF (text == 'old_Plan_Value__c') { old_Plan_Value_c = parser.getText();}
                        ELSE IF (text == 'other_Phone__c') { other_Phone_c = parser.getText();}
                        ELSE IF (text == 'officephonE2__c') { officephonE2_c = parser.getText();}
                        ELSE IF (text == 'officephonE__c') { officephonE_c = parser.getText();}
                        ELSE IF (text == 'old_Result__c') { old_Result_c = parser.getText();}
                        /*
                       
                        
                        ELSE IF (text == 'open_Cases__c') { open_Cases_c = parser.getText();}
                        ELSE IF (text == 'open_Cases_Fml__c') { open_Cases_Fml_c = parser.getText();}
                        
                       
                        ELSE IF (text == 'owner_Entity__c') { owner_Entity_c = parser.getText();}
                        ELSE IF (text == 'owner_Profile__c') { owner_Profile_c = parser.getText();}
                        ELSE IF (text == 'ownerId') { ownerId = parser.getText();}
                        ELSE IF (text == 'paidToDate__c') { paidToDate_c = parser.getText();}
                        ELSE IF (text == 'parent__c') { parent_c = parser.getText();}
						
                        ELSE IF (text == 'parent_Name_Mobile__c') { parent_Name_Mobile_c = parser.getText();}
                        
                        ELSE IF (text == 'phone_2__c') { phone_2_c = parser.getText();}
                        ELSE IF (text == 'phone_3__c') { phone_3_c = parser.getText();}*/
                        ELSE IF (text == 'periode_Terdebet__c') { periode_Terdebet_c = parser.getText();}
                        ELSE IF (text == 'phone__c') { phone_c = parser.getText();}
                        ELSE IF (text == 'parent_Campaign__c') { 
                            parent_Campaign_c = parser.getText();
                        	if(parent_Campaign_c != null) parent_Campaign_name = AXAAPI_UtilityClass.getsObjectNameById(parent_Campaign_c, 'Call_List__c', 'Name');
                        }
                        ELSE IF (text == 'parent_Call_Line__c') {
                            parent_Call_Line_c = parser.getText();
                        	if(parent_Call_Line_c != null) parent_Call_Line_name = AXAAPI_UtilityClass.getsObjectNameById(parent_Call_Line_c, 'Call_Line__c', 'Name');
                        }ELSE IF (text == 'phone_Sending_SMS__c') { phone_Sending_SMS_c = parser.getText();}
                        ELSE IF (text == 'policy_Holder_Name__c') { policy_Holder_Name_c = parser.getText();}
                        /*
                        ELSE IF (text == 'piC_Travel_AGI__c') { piC_Travel_AGI_c = parser.getText();}
                        ELSE IF (text == 'policy_Effective_Date__c') { policy_Effective_Date_c = parser.getText();}
                        */
                        ELSE IF (text == 'policy_No__c') { policy_No_c = parser.getText();}
                        ELSE IF (text == 'poliS__c') { poliS_c = parser.getText();}
                        /*
                        ELSE IF (text == 'polis_Batch__c') { polis_Batch_c = parser.getText();}
                       */
                        ELSE IF (text == 'preferred_Phone__c') { preferred_Phone_c = parser.getText();}
                        ELSE IF (text == 'postCode__c') { postCode_c = parser.getText();}
                        ELSE IF (text == 'priority__c') { priority_c = parser.getText();}
                        ELSE IF (text == 'premium__c') { 
                            string a = parser.getText();
                            premium_c = integer.valueOf(a);
                        }
                        ELSE IF (text == 'premium2__c') { premium2_c = parser.getText();}
                        /*ELSE IF (text == 'premi_Ke__c') { premi_Ke_c = parser.getText();}
                        
                        
                        ELSE IF (text == 'prev_Acc_Balance__c') { prev_Acc_Balance_c = parser.getText();}
                        
                        ELSE IF (text == 'priority_Customer__c') { priority_Customer_c = parser.getText();}
                        
                        
                        ELSE IF (text == 'q1__c') { q1_c = parser.getText();}
                        ELSE IF (text == 'q2__c') { q2_c = parser.getText();}
                        ELSE IF (text == 'q3__c') { q3_c = parser.getText();}
                        ELSE IF (text == 'q4__c') { q4_c = parser.getText();}
                        ELSE IF (text == 'q5__c') { q5_c = parser.getText();}*/
                        ELSE IF (text == 'progress__c') { progress_c = parser.getText();}
                        ELSE IF (text == 'product__c') { product_c = parser.getText();}
                        ELSE IF (text == 'reason_Status_Config__c') { reason_Status_Config_c = parser.getText();}
                        ELSE IF (text == 'remarks_Nama_PP_TT__c') { remarks_Nama_PP_TT_c = parser.getText();}
                        ELSE IF (text == 'remarks_Alamat__c') { remarks_Alamat_c = parser.getText();}
                        ELSE IF (text == 'remarks_Agent_Validation__c') { remarks_Agent_Validation_c = parser.getText();}                      
                        ELSE IF (text == 'remarks_Email__c') { remarks_Email_c = parser.getText();}
                        ELSE IF (text == 'remarks_ePolicy_Buku_Polis__c') { remarks_ePolicy_Buku_Polis_c = parser.getText();}
                        ELSE IF (text == 'remarks_Telepon__c') { remarks_Telepon_c = parser.getText();}
                        ELSE IF (text == 'remarks_Understand_Product__c') { remarks_Understand_Product_c = parser.getText();}
                        ELSE IF (text == 'recordTypeId') { 
                            recordTypeId = parser.getText();
                        	if(recordTypeId != null) recordType_name = AXAAPI_UtilityClass.getsObjectNameById(recordTypeId, 'Recordtype', 'Name');
                        }
                        ELSE IF (text == 'remark_Hold_Debet__c') { remark_Hold_Debet_c = parser.getText();}
                        ELSE IF (text == 'refference_No__c') { refference_No_c = parser.getText();}
                        ELSE IF (text == 'rejReason__c') { rejReason_c = parser.getText();}
                        /*
                        ELSE IF (text == 'related_Policy_Counter__c') { related_Policy_Counter_c = parser.getText();}
                       
                        
                        
                       
                        ELSE IF (text == 'request_Date__c') { request_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}*/
                        ELSE IF (text == 'reporT_POLICY_DELIVERY__c') { reporT_POLICY_DELIVERY_c = parser.getText();}
                        ELSE IF (text == 'request_No_Interaction_ICF__c') { 
                         	String a = parser.getText();
                            request_No_Interaction_ICF_c = Boolean.valueOf(a);    
                        }
                        ELSE IF (text == 'reschedule_Date__c') { reschedule_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'remarks_DOB__c') { remarks_DOB_c = parser.getText();}
                        ELSE IF (text == 'result__c') { result_c = parser.getText();}
                        ELSE IF (text == 'retur_Payment__c') { retur_Payment_c = parser.getText();}
                        ELSE IF (text == 'retention_FC__c') { retention_FC_c = parser.getText();}
                        ELSE IF (text == 'retention_Follow_Up_Date__c') { retention_Follow_Up_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'retention_Note__c') { retention_Note_c = parser.getText();}
                        ELSE IF (text == 'retention_Program__c') { retention_Program_c = parser.getText();}
                        ELSE IF (text == 'retention_Remark__c') { retention_Remark_c = parser.getText();}
                        ELSE IF (text == 'retention_Request_Date__c') { retention_Request_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'retention_Result__c') { retention_Result_c = parser.getText();}
                        ELSE IF (text == 'retention_Result_Status__c') { retention_Result_Status_c = parser.getText();}
                        
                        /*
                        ELSE IF (text == 'result_Verification__c') { result_Verification_c = parser.getText();}
                        ELSE IF (text == 'retention_Alasan_Pembatalan__c') { retention_Alasan_Pembatalan_c = parser.getText();}
                        
                       
                        ELSE IF (text == 's1__c') { s1_c = parser.getText();}
                        ELSE IF (text == 's2__c') { s2_c = parser.getText();}
                        ELSE IF (text == 's3__c') { s3_c = parser.getText();}
                        ELSE IF (text == 's4__c') { s4_c = parser.getText();}
                        ELSE IF (text == 's5__c') { s5_c = parser.getText();}*/
                        ELSE IF (text == 'selisih__c') { selisih_c = parser.getText();}
                        ELSE IF (text == 'total_Uncontacted__c') { total_Uncontacted_c = parser.getText();}
                        ELSE IF (text == 'status_Retry__c') { status_Retry_c = parser.getText();}
                        ELSE IF (text == 'status_has_call__c') { status_has_call_c = parser.getText();}
                        ELSE IF (text == 'status_Paid_Not_Paid__c') { status_Paid_Not_Paid_c = parser.getText();}
                        ELSE IF (text == 'tanggal_Hold_Debet__c') { tanggal_Hold_Debet_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'time_Reschedule__c') { time_Reschedule_c = parser.getText();}
                        ELSE IF (text == 'tanggal_Debet__c') { tanggal_Debet_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                         ELSE IF (text == 'update_Child__c') { 
                        	String a = parser.getText();
                            update_Child_c = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'status_Polis__c') { status_Polis_c = parser.getText();}
                        ELSE IF (text == 'status_Request_No_Interaction__c') { status_Request_No_Interaction_c = parser.getText();}
                        ELSE IF (text == 'title__c') { title_c = parser.getText();}
                        ELSE IF (text == 'tidak_Bersedia_Diverifikasi__c') { tidak_Bersedia_Diverifikasi_c = parser.getText();}
                       /* ELSE IF (text == 'sisa_Waktu_Follow_Up__c') { sisa_Waktu_Follow_Up_c = parser.getText();}
                        ELSE IF (text == 'smS_Date__c') { smS_Date_c = parser.getText();}
                        ELSE IF (text == 'source_AGI__c') { source_AGI_c = parser.getText();}
                        ELSE IF (text == 'source_Collection__c') { source_Collection_c = parser.getText();}
                       
                        
                        
                        
                        ELSE IF (text == 'success_Case__c') { success_Case_c = parser.getText();}
                        ELSE IF (text == 'survey_ID__c') { survey_ID_c = parser.getText();}
                        ELSE IF (text == 'survey_Method__c') { survey_Method_c = parser.getText();}
                        ELSE IF (text == 'survey_Name__c') { survey_Name_c = parser.getText();}
                        ELSE IF (text == 'survey_Submethod__c') { survey_Submethod_c = parser.getText();}
                        ELSE IF (text == 'survey_Type__c') { survey_Type_c = parser.getText();}
                        ELSE IF (text == 'survey_URL__c') { survey_URL_c = parser.getText();}
                        ELSE IF (text == 'systemModstamp') { systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'talk_Time__c') { talk_Time_c = parser.getText();}
                        ELSE IF (text == 'tanggal_Closed_AGI__c') { tanggal_Closed_AGI_c = parser.getText();}
                        
                        ELSE IF (text == 'tanggal_Email_Complaint_AGI__c') { tanggal_Email_Complaint_AGI_c = parser.getText();}
                        ELSE IF (text == 'tanggal_Eskalasi_AGI_1__c') { tanggal_Eskalasi_AGI_1_c = parser.getText();}
                        ELSE IF (text == 'tanggal_Eskalasi_AGI_2__c') { tanggal_Eskalasi_AGI_2_c = parser.getText();}
                        ELSE IF (text == 'tanggal_Eskalasi_AGI_3__c') { tanggal_Eskalasi_AGI_3_c = parser.getText();}
                        
                        ELSE IF (text == 'tanggal_Pengajuan_AGI__c') { tanggal_Pengajuan_AGI_c = parser.getText();}
                       
                        
                        
                        ELSE IF (text == 'topic__c') { topic_c = parser.getText();}
                        ELSE IF (text == 'total_Acc_Balance__c') { total_Acc_Balance_c = parser.getText();}
                        ELSE IF (text == 'total_Answer_by_Other__c') { total_Answer_by_Other_c = parser.getText();}
                        ELSE IF (text == 'total_Approved__c') { total_Approved_c = parser.getText();}
                        ELSE IF (text == 'total_Busy_Line__c') { total_Busy_Line_c = parser.getText();}
                        ELSE IF (text == 'total_Cancel__c') { total_Cancel_c = parser.getText();}
                        ELSE IF (text == 'total_Conserved__c') { total_Conserved_c = parser.getText();}
                        ELSE IF (text == 'total_Contact_Collection_Task_ALI__c') { total_Contact_Collection_Task_ALI_c = parser.getText();}
                        ELSE IF (text == 'total_Contact_Premium_Reminder_ALI__c') { total_Contact_Premium_Reminder_ALI_c = parser.getText();}
                        ELSE IF (text == 'total_Contact_Reinstate_ALI__c') { total_Contact_Reinstate_ALI_c = parser.getText();}
                        ELSE IF (text == 'total_Contact_Retention_ALI__c') { total_Contact_Retention_ALI_c = parser.getText();}
                        ELSE IF (text == 'total_Disconnected__c') { total_Disconnected_c = parser.getText();}
                        ELSE IF (text == 'total_Follow_Up__c') { total_Follow_Up_c = parser.getText();}
                        ELSE IF (text == 'total_Inforce__c') { total_Inforce_c = parser.getText();}
                        ELSE IF (text == 'total_Invalid_Number__c') { total_Invalid_Number_c = parser.getText();}
                        ELSE IF (text == 'total_Mailbox__c') { total_Mailbox_c = parser.getText();}
                        ELSE IF (text == 'total_No_Answer__c') { total_No_Answer_c = parser.getText();}
                        ELSE IF (text == 'total_No_Follow_Up__c') { total_No_Follow_Up_c = parser.getText();}
                        ELSE IF (text == 'total_No_Number__c') { total_No_Number_c = parser.getText();}
                        ELSE IF (text == 'total_Not_Approved__c') { total_Not_Approved_c = parser.getText();}
                        ELSE IF (text == 'total_Not_Reachable_3x__c') { total_Not_Reachable_3x_c = parser.getText();}
                        ELSE IF (text == 'total_Not_Reachable__c') { total_Not_Reachable_c = parser.getText();}
                        ELSE IF (text == 'total_Paid__c') { total_Paid_c = parser.getText();}
                        ELSE IF (text == 'total_Paid_Approved__c') { total_Paid_Approved_c = parser.getText();}
                        ELSE IF (text == 'total_Paid_Contacted__c') { total_Paid_Contacted_c = parser.getText();}
                        ELSE IF (text == 'total_Paid_Uncontacted__c') { total_Paid_Uncontacted_c = parser.getText();}
                        ELSE IF (text == 'total_Rescheduled__c') { total_Rescheduled_c = parser.getText();}
                        ELSE IF (text == 'total_Retain_Redemption__c') { total_Retain_Redemption_c = parser.getText();}
                        ELSE IF (text == 'total_Retain_Withdrawal__c') { total_Retain_Withdrawal_c = parser.getText();}
                        ELSE IF (text == 'total_Uncontacted__c') { total_Uncontacted_c = parser.getText();}
                        
                        ELSE IF (text == 'total_Voice_Mail__c') { total_Voice_Mail_c = parser.getText();}
                        ELSE IF (text == 'total_Withdrawn__c') { total_Withdrawn_c = parser.getText();}
                        ELSE IF (text == 'total_Wrong_Number__c') { total_Wrong_Number_c = parser.getText();}
                        ELSE IF (text == 'totalNCB__c') { totalNCB_c = parser.getText();}
                        ELSE IF (text == 'transaction_Date__c') { transaction_Date_c = parser.getText();}
                        ELSE IF (text == 'uncontacted_Reason__c') { uncontacted_Reason_c = parser.getText();}
                       
                        
                        
                        ELSE IF (text == 'used_Phone__c') { used_Phone_c = parser.getText();}
                        
                        ELSE IF (text == 'welcomeCall_Attempt__c') { welcomeCall_Attempt_c = parser.getText();}
                        
                        ELSE IF (text == 'welcomeCall_Cooling_Off2__c') { welcomeCall_Cooling_Off2_c = parser.getText();}
                        
                        
                        ELSE IF (text == 'welcomeCall_Customer_Satisfaction__c') { welcomeCall_Customer_Satisfaction_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Days__c') { welcomeCall_Days_c = parser.getText();}
                        
                        ELSE IF (text == 'welcomeCall_Fg_Round_Robin__c') { 
                            String a = parser.getText();
                            welcomeCall_Fg_Round_Robin_c = Boolean.valueOf(a);
                        }
                        
                        
                        
                        
                       
                        
                        
                        
                        ELSE IF (text == 'welcomeCall_Today__c') { welcomeCall_Today_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
						*/
                        ELSE IF (text == 'total_Uncontacted_New__c') { total_Uncontacted_New_c = parser.getText();}
                        ELSE IF (text == 'zipcodE__c') { zipcodE_c = parser.getText();}
                        ELSE IF (text == 'update_KTP__c') { update_KTP_c = parser.getText();}
                        ELSE IF (text == 'updateEmail__c') { updateEmail_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Reason_Detail_Status__c') { welcomeCall_Reason_Detail_Status_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Detail_Status__c') { welcomeCall_Detail_Status_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Call_Line_Status__c') { welcomeCall_Call_Line_Status_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Hour_Schedule_Date__c') { welcomeCall_Hour_Schedule_Date_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Reference__c') { welcomeCall_Reference_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Schedule_Date__c') { welcomeCall_Schedule_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'welcomeCall_Fg_Schedule__c') { 
                        	String a = parser.getText();
                            welcomeCall_Fg_Schedule_c = Boolean.valueOf(a);
                        }
                        ELSE IF (text == 'welcomeCall_Period_Day__c') { welcomeCall_Period_Day_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Attempt__c') { welcomeCall_Attempt_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_Criteria__c') { welcomeCall_Criteria_c = parser.getText();}
                        ELSE IF (text == 'welcomeCall_First_Call_Date__c') { welcomeCall_First_Call_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'welcomeCall_Cooling_Off2__c') { welcomeCall_Cooling_Off2_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE IF (text == 'verification__c') { verification_c = parser.getText();}
                        ELSE IF (text == 'update_Email__c') { update_Email_c = parser.getText();}
                        ELSE IF (text == 'Year_of_Policy_Effective_Date__c') { Year_of_Policy_Effective_Date_c = parser.getText();}
                        
                        ELSE IF (text == 'welcomeCall_Reschedule_Source__c') { welcomeCall_Reschedule_Source_c = parser.getText();}
                        
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

	public AXAAPI022B_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI022B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI022B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI022B_response(parser);
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