@isTest
public class PureCloudOrderIdResultTest {
    @testSetup
    public static void testSetup() {
        Date dtToday = Date.today();
        
        MID_Secure_Payment__c midRecord = new MID_Secure_Payment__c();
        midRecord.External_Id_SFDC__c = 'SFIFY_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.SFDC_Order_Id__c = 'SFIFY_5071234567_9876543210';
        midRecord.Entity__c = '';
        midRecord.SFDC_Order_Id_Child__c = 'SFIFY_5071234567_' + String.valueOf(dtToday) + '_P';
        midRecord.mid_custom_field1__c = '';
        midRecord.mid_custom_field2__c = '';
        midRecord.mid_custom_field3__c = '';
        //midRecord.mid_custom_field3_temp__c = 'RLS_507-1234567_10000_AFI;DMTM_507-1234567_0_AMFS;';
        midRecord.mid_custom_field3_temp__c = 'RLS_123-456789_0_AFI;DMTM_210-308-0000106__0_ALI;';
        
        midRecord.Payment_Type__c = '';
        midRecord.Bank_Name__c = 'BCA';
        midRecord.mid_transaction_status__c = '';
        insert midRecord;
    }
    
    public static testMethod void orderIdResult() {
        String body = '{';
        body += '"order_id":"SFIFY_5071234567_9876543210",';
        body += '"interaction_id":"4b09aed2-ec82-4e2d-b99e-d581c9a5fc49",';
        body += '"transaction":[{';
        body += '"policy_apps" : "RLS",';
        body += '"token_payment" : "1394770c-df3d-4cbd-4195-0d0696231f12",';
        body += '"order_response_code" : "200",';
        body += '"bank_name" : "BCA",';
        body += '"account_number" : "",';
        body += '"card_number" : "5668900012123000",';
        body += '"expiry_date" : "1219",';
        body += '"status_message" : "status_message",';
        body += '"channel_response_code" : "20",';
        body += '"channel_response_message" : "channel_response_message",';
        body += '"policy_apps2" : "DMTM",';
        body += '"token_payment2" : "73d71394-0cdf-c441-d59b-2962310d06f1",';
        body += '"order_response_code2" : "200",';
        body += '"bank_name2" : "BCA",';
        body += '"account_number2" : "123",';
        body += '"card_number2" : "5668900012123000",';
        body += '"expiry_date2" : "1219",';
        body += '"status_message2" : "status_message",';
        body += '"channel_response_code2" : "20",';
        body += '"channel_response_message2" : "channel_response_message"';
        //body += '"token_payment":"A3",';
        //body += '"order_response_code":"200"';
        body += '}]}';
            
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/MIDSecurePayment';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(body);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        PureCloudOrderIdResult.postOrderResult();
        Test.stopTest();
    }
}