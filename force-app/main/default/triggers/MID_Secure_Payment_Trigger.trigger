trigger MID_Secure_Payment_Trigger on MID_Secure_Payment__c (After Insert, after Update) {
    for (MID_Secure_Payment__c mid : trigger.new){
        try {
            MID_Custom_History__c midH = new MID_Custom_History__c();
            
            midH.Name = mid.Name+'-'+mid.SFDC_Order_Id__c;
            midH.Account_Name__c = mid.Account_Name__c;
            midH.Account_Number__c = mid.Account_Number__c;
            midH.Bank_Name__c = mid.Bank_Name__c;
            midH.Bank_Name_Other__c = mid.Bank_Name_Other__c;
            midH.Beneficial_Owner__c = mid.Beneficial_Owner__c;
            midH.Beneficial_Owner_KYC__c = mid.Beneficial_Owner_KYC__c;
            midH.Card_Holder_Name__c = mid.Card_Holder_Name__c;
            midH.Card_Number__c = mid.Card_Number__c;
            midH.Change_Name__c = mid.Change_Name__c;
            midH.Contact__c = mid.Contact__c;
            midH.Email__c = mid.Email__c;
            midH.Email_Subject__c = mid.Email_Subject__c;
            midH.Entity__c = mid.Entity__c;
            midH.Expiry_Date_MMYY__c = mid.Expiry_Date_MMYY__c;
            midH.flagVsnap__c = mid.flagVsnap__c;
            midH.Interaction_Id__c = mid.Interaction_Id__c;
            midH.mid_account_number2__c = mid.mid_account_number2__c;
            midH.mid_approval_code__c = mid.mid_approval_code__c;
            midH.mid_bank__c = mid.mid_bank__c;
            midH.mid_bank_name2__c = mid.mid_bank_name2__c;
            midH.mid_card_number2__c = mid.mid_card_number2__c;
            midH.mid_channel_response_code__c = mid.mid_channel_response_code__c;
            midH.mid_channel_response_code2__c = mid.mid_channel_response_code2__c;
            midH.mid_channel_response_message__c = mid.mid_channel_response_message__c;
            midH.mid_channel_response_message2__c = mid.mid_channel_response_message2__c;
            midH.mid_currency__c = mid.mid_currency__c;
            midH.mid_custom_field1__c = mid.mid_custom_field1__c;
            midH.mid_custom_field2__c = mid.mid_custom_field2__c;
            midH.mid_custom_field3__c = mid.mid_custom_field3__c;
            midH.mid_custom_field3_temp__c = mid.mid_custom_field3_temp__c;
            midH.mid_EIPtokenApp_Status__c = mid.mid_EIPtokenApp_Status__c;
            midH.mid_expiry_date2__c = mid.mid_expiry_date2__c;
            midH.mid_fraud_status__c = mid.mid_fraud_status__c;
            midH.mid_gross_amount__c = mid.mid_gross_amount__c;
            midH.mid_masked_card__c = mid.mid_masked_card__c;
            midH.mid_order_id__c = mid.mid_order_id__c;
            midH.mid_order_id2__c = mid.mid_order_id2__c;
            midH.mid_payment_type__c = mid.mid_payment_type__c;
            midH.mid_policy_apps__c = mid.mid_policy_apps__c;
            midH.mid_policy_apps2__c = mid.mid_policy_apps2__c;
            midH.mid_saved_token_id__c = mid.mid_saved_token_id__c;
            midH.mid_saved_token_id_expired_at__c = mid.mid_saved_token_id_expired_at__c;
            midH.MID_Secure_Payment__c = mid.id;
            midH.mid_signature_key__c = mid.mid_signature_key__c;
            midH.mid_status_code__c = mid.mid_status_code__c;
            midH.mid_status_code2__c = mid.mid_status_code2__c;
            midH.mid_status_message__c = mid.mid_status_message__c;
            midH.mid_status_message2__c = mid.mid_status_message2__c;
            midH.mid_token_payment__c = mid.mid_token_payment__c;
            midH.mid_token_payment2__c = mid.mid_token_payment2__c;
            midH.mid_transaction_id__c = mid.mid_transaction_id__c;
            midH.mid_transaction_status__c = mid.mid_transaction_status__c;
            midH.mid_transaction_time__c = mid.mid_transaction_time__c;
            midH.mid_transaction_time2__c = mid.mid_transaction_time2__c;
            midH.Midtrans_Token__c = mid.Midtrans_Token__c;
            midH.Non_Perorangan__c = mid.Non_Perorangan__c;
            midH.Origin__c = mid.Origin__c;
            midH.Payment_Frequency__c = mid.Payment_Frequency__c;
            midH.Payment_Type__c = mid.Payment_Type__c;
            midH.Policy_App__c = mid.Policy_App__c;
            midH.Registration_Id__c = mid.Registration_Id__c;
            midH.Save__c = mid.Save__c;
            midH.Send_Email__c = mid.Send_Email__c;
            midH.Send_Email_Type__c = mid.Send_Email_Type__c;
            midH.SFDC_Order_Id__c = mid.SFDC_Order_Id__c;
            midH.SFDC_Order_Id_Child__c = mid.SFDC_Order_Id_Child__c;
            midH.Status__c = mid.Status__c;
            
            upsert midH SFDC_Order_Id__c;

        } 
        catch(exception e) {
        }
    }
}