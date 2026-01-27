@RestResource(urlMapping='/MIDSecurePayment')
global class PureCloudOrderIdResult {
    
    @HttpPost
    global static void postOrderResult() {
        DateTime dtStart = DateTime.now();
        // Catur (20210303), init for response eipjson
        EIPJson responseEip;
        
        /*Map<String, Object> mapObj = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());

        String s = '';
        RestContext.response.addHeader('Content-Type', 'application/json');
        if(mapObj.size() > 0) {
            s = JSON.serialize(mapObj);
        } else {
            s = '{"Error" : "No data!"}';
        }
        RestContext.response.responseBody = Blob.valueOf(s);*/
        
        String responseMessage = '';
        String StatusMessage = '';
        String ErrorMessage = '';
        
        String Status1 = '';
        String Status2 = '';
        string policy_apps = '';
        string policy_apps2 = '';

        
        Boolean flagOrderId = false;
        Map<String, Object> mapObj = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());
        System.debug('request body : '+mapObj);
        Set<String> setObjKey = mapObj.keyset();
        if(setObjKey.contains('order_id')) {
            flagOrderId = true;
        }
        
        if(mapObj.size() > 0) {
            if(flagOrderId) {
                system.debug('mapObj : '+mapObj);
                system.debug('order_id : '+mapObj.get('order_id'));
                string order_id = string.valueof(mapObj.get('order_id'));
                
                system.debug('interaction_id : '+mapObj.get('interaction_id'));
                List<Object> data = (List<Object>)mapObj.get('transaction');
                
                string dataid = '';
                MID_Secure_Payment__c dataMID;
                string orderidtemp = '';
                
                // Query Mid Master
                map<string,string> OrderCode = new map<string,string>();
                // AFI & ALI
                OrderCode.put('SFIFX-RLS', 'SFIF1');                
                OrderCode.put('SFIFY-RLS', 'SFIF2');                
                OrderCode.put('SFIFZ-RLS', 'SFIF3');                
                OrderCode.put('SFIFX-DMTM', 'SFIFA');                
                OrderCode.put('SFIFY-DMTM', 'SFIFB');                
                OrderCode.put('SFIFZ-DMTM', 'SFIFC');                
                
                // AMFS
                OrderCode.put('SFIBX-RLS', 'SFIB1');                
                OrderCode.put('SFIBY-RLS', 'SFIB2');                
                OrderCode.put('SFIBZ-RLS', 'SFIB3');                
                OrderCode.put('SFIBX-DMTM', 'SFIBA');                
                OrderCode.put('SFIBY-DMTM', 'SFIBB');                
                OrderCode.put('SFIBZ-DMTM', 'SFIBC');                
                
                map<string,string> PCToken = new map<string,string>();
                map<string,string> PCOrderID = new map<string,string>();
                String OrderIdTemp2 = '';
                dataMID = [SELECT id, Interaction_Id__c, SFDC_Order_Id_Child__c, Payment_Type__c, 
                           SFDC_Order_Id__c, Entity__c, 
                           mid_custom_field1__c, mid_custom_field2__c, mid_custom_field3__c, mid_custom_field3_temp__c, 
                           Bank_Name__c, mid_transaction_status__c, Status__c, Status_DoOrderEIP__c,
                           mid_saved_token_id__c, mid_order_id__c, 
                           Expiry_Date_MMYY__c, // 18 Feb 2021
                           mid_transaction_time__c, mid_payment_type__c, mid_transaction_time2__c, 
               mid_policy_apps__c, mid_policy_apps2__c, mid_token_payment__c, mid_token_payment2__c, mid_status_code2__c, 
                           mid_bank_name2__c, mid_account_number2__c, mid_card_number2__c, mid_expiry_date2__c,
                           JsonBackEndError__c, // Taufik, 29 Jan21, Request dari pak Catur, untuk capture Error dari doOrder (backEndError)
                           JsonRequestBody__c, JsonErrorMessage__c // Taufik 5 Aug20, for debug log on UI SFDC
                           FROM MID_Secure_Payment__c WHERE SFDC_Order_Id__c =: order_id ]; //and Policy_App__c =: policy_apps
                
                for (integer i=0; i < data.size(); i++) {
                    Map<String, Object> data2 = (Map<String, Object>)data[i];
                    
                    system.debug('transaction.policy_apps : '+data2.get('policy_apps'));
                    policy_apps = string.valueof(data2.get('policy_apps'));
                    policy_apps2 = string.valueof(data2.get('policy_apps2'));
                    
                    system.debug('policy_apps : '+data2.get('policy_apps'));
                    system.debug('transaction.token_payment : '+data2.get('token_payment'));
                    system.debug('transaction.order_response_code : '+data2.get('order_response_code'));
                    system.debug('transaction.bank_name : '+data2.get('bank_name'));
                    system.debug('transaction.account_number : '+data2.get('account_number'));
                    system.debug('transaction.card_number : '+data2.get('card_number'));
                    system.debug('transaction.expiry_date : '+data2.get('expiry_date'));
                    system.debug('transaction.status_message : '+data2.get('status_message'));
                    system.debug('transaction.channel_response_code : '+data2.get('channel_response_code'));
                    system.debug('transaction.channel_response_message : '+data2.get('channel_response_message'));
                    system.debug('transaction.transaction_time : '+data2.get('transaction_time'));
                    PCToken.put(policy_apps,string.valueof(data2.get('token_payment')));

                    system.debug('## Token 2 ##');
                    system.debug('policy_apps2 : '+data2.get('policy_apps2'));
                    system.debug('transaction.token_payment2 : '+data2.get('token_payment2'));
                    system.debug('transaction.order_response_code2 : '+data2.get('order_response_code2'));
                    system.debug('transaction.bank_name2 : '+data2.get('bank_name2'));
                    system.debug('transaction.account_number2 : '+data2.get('account_number2'));
                    system.debug('transaction.card_number2 : '+data2.get('card_number2'));
                    system.debug('transaction.expiry_date2 : '+data2.get('expiry_date2'));
                    system.debug('transaction.status_message2 : '+data2.get('status_message2'));
                    system.debug('transaction.channel_response_code2 : '+data2.get('channel_response_code2'));
                    system.debug('transaction.channel_response_message2 : '+data2.get('channel_response_message2'));
                    system.debug('transaction.transaction_time2 : '+data2.get('transaction_time2'));
                    PCToken.put(policy_apps2,string.valueof(data2.get('token_payment2')));

                    // Taufik, update OrderID 
                    {
                        dataMID.JsonRequestBody__c = RestContext.request.requestBody.toString(); // Taufik 5 Aug20, for debug log on UI SFDC
                        dataMID.Interaction_Id__c = string.valueof(mapObj.get('interaction_id'));
                        string token_payment_temp = '';
                        if (data2.get('token_payment') != NULL) token_payment_temp = string.valueof(data2.get('token_payment'));
                        else token_payment_temp = 'N-U-L-L';
                        
                        dataMID.Midtrans_Token__c = token_payment_temp;
                        dataMID.mid_token_payment__c = token_payment_temp;
                        
                        if (i==0)
                        dataMID.mid_saved_token_id__c = policy_apps+'_'+token_payment_temp+';';
                      else
                            dataMID.mid_saved_token_id__c += policy_apps+'_'+token_payment_temp+';';
            
                        //dataMID.mid_saved_token_id__c += policy_apps+'_'+string.valueof(data2.get('token_payment'))+';';
                        system.debug('line 99 - order_id : '+order_id);
                        system.debug('line 99 - policy_apps : '+policy_apps);
                        system.debug('line 99 - OrderCode : '+OrderCode);

                        if (OrderCode.get(order_id.left(5)+'-'+policy_apps) == NULL) OrderIdTemp2 = order_id;
                        else OrderIdTemp2 = order_id.replace(order_id.left(5), OrderCode.get(order_id.left(5)+'-'+policy_apps));//OrderCode.get(order_id.left(5)+'-'+policy_apps) ;
                        PCOrderID.put(policy_apps, OrderIdTemp2);
                        system.debug('#PCOrderID : '+policy_apps+'+'+OrderIdTemp2);
                        /* 2 Jun20, Hide
                        if (i==0)
                          dataMID.mid_order_id__c = OrderIdTemp2 +';';
                        else
                            dataMID.mid_order_id__c += OrderIdTemp2 +';';
                        */
                        dataMID.mid_order_id__c = OrderIdTemp2;
                        
                        dataMID.mid_policy_apps__c = string.valueof(data2.get('policy_apps'));
                        dataMID.mid_status_code__c = string.valueof(data2.get('order_response_code'));
                        dataMID.Account_Number__c = string.valueof(data2.get('account_number'));
                        dataMID.Card_Number__c = string.valueof(data2.get('card_number'));
                        dataMID.Expiry_Date_MMYY__c = string.valueof(data2.get('expiry_date'));
                        dataMID.mid_status_message__c = string.valueof(data2.get('status_message'));
                        dataMID.mid_channel_response_code__c = string.valueof(data2.get('channel_response_code'));
                        dataMID.mid_channel_response_message__c = string.valueof(data2.get('channel_response_message'));
                        dataMID.mid_transaction_time__c = string.valueof(data2.get('transaction_time'));

                        if (dataMID.mid_status_code__c == '200')
                          dataMID.Status__c = 'Accepted';
                        else //if (dataMID.mid_status_code__c == '401')
                          dataMID.Status__c = 'Failed PureCloud';

                        Status1 = dataMID.Status__c;

                        //update dataMID; // pindah ke paling bawah.
                        if (dataMID.SFDC_Order_Id_Child__c == order_id) dataid = string.valueof(dataMID.Id);
                    }
          
                    // Save Token 2
                    if (data2.get('policy_apps2') != NULL){
                        dataMID.Interaction_Id__c = string.valueof(mapObj.get('interaction_id'));
                        string token_payment_temp = '';
                        if (data2.get('token_payment2') != NULL) token_payment_temp = string.valueof(data2.get('token_payment2'));
                        else token_payment_temp = 'N-U-L-L';
                        
                        dataMID.Midtrans_Token__c = token_payment_temp;
                        dataMID.mid_token_payment2__c = token_payment_temp;
                        
                        dataMID.mid_saved_token_id__c += policy_apps2+'_'+token_payment_temp+';';
            
                        //dataMID.mid_saved_token_id__c += policy_apps+'_'+string.valueof(data2.get('token_payment'))+';';
                        system.debug('line 99 - order_id2 : '+order_id);
                        system.debug('line 99 - policy_apps2 : '+policy_apps2);
                        system.debug('line 99 - OrderCode2 : '+OrderCode);

                        if (OrderCode.get(order_id.left(5)+'-'+policy_apps2) == NULL) OrderIdTemp2 = order_id;
                        else OrderIdTemp2 = order_id.replace(order_id.left(5), OrderCode.get(order_id.left(5)+'-'+policy_apps2));//OrderCode.get(order_id.left(5)+'-'+policy_apps) ;
                        PCOrderID.put(policy_apps2, OrderIdTemp2);
                        system.debug('#PCOrderID2 : '+policy_apps2+'+'+OrderIdTemp2);
                        /* // 2 Jun20, Hide
                        if (i==0)
                          dataMID.mid_order_id__c = OrderIdTemp2 +';';
                        else
                            dataMID.mid_order_id__c += OrderIdTemp2 +';';
                        */
                        dataMID.mid_order_id2__c = OrderIdTemp2;
                        
                        dataMID.mid_policy_apps2__c = string.valueof(data2.get('policy_apps2'));
                        dataMID.mid_bank_name2__c = string.valueof(data2.get('bank_name2'));
                        dataMID.mid_status_code2__c = string.valueof(data2.get('order_response_code2'));
                        dataMID.mid_Account_Number2__c = string.valueof(data2.get('account_number2'));
                        dataMID.mid_Card_Number2__c = string.valueof(data2.get('card_number2'));
                        dataMID.mid_Expiry_Date2__c = string.valueof(data2.get('expiry_date2'));
                        dataMID.mid_status_message2__c = string.valueof(data2.get('status_message2'));
                        dataMID.mid_channel_response_code2__c = string.valueof(data2.get('channel_response_code2'));
                        dataMID.mid_channel_response_message2__c = string.valueof(data2.get('channel_response_message2'));
                        dataMID.mid_transaction_time2__c = string.valueof(data2.get('transaction_time2'));

                        if (dataMID.mid_status_code2__c == '200')
                          dataMID.Status__c += ';Accepted';
                        else //if (dataMID.mid_status_code__c == '401')
                          dataMID.Status__c += ';Failed PureCloud';
                        
                        if (dataMID.mid_status_code2__c == '200')
                          Status2 = 'Accepted';
                        else //if (dataMID.mid_status_code__c == '401')
                          Status2 = 'Failed PureCloud';


                        //update dataMID; // pindah ke paling bawah.
                        if (dataMID.SFDC_Order_Id_Child__c == order_id) dataid = string.valueof(dataMID.Id);
                    }

                }
                StatusMessage = 'Success';
                // call doOrderSubmitEIP
                //ChangePaymentController call = new ChangePaymentController();
                //call.DoOrderSubmitDataEIP();
                // Token1 - hit to EIPTokenApps
                String PolicyEntity1 = '';
                String PolicyEntity2 = '';
                dataMID.mid_EIPtokenApp_Status__c = '';

                // Query 
                system.debug('#Before');
                
                list<string> ArrTemp = new list<string>(); // untuk menampung all info : DMTM_PolicyNo_Payment
                list<string> ArrPolicyNo = new list<string>(); // untuk menampung 1 info policyNo
                list<string> ArrPolicyApp = new list<string>(); // untuk menampung 1 info PolicyApp
                list<string> ArrPolicyPayment = new list<string>(); // untuk menampung 1 info Payment
                list<string> ArrPolicyEntity = new list<string>(); // untuk menampung 1 info Entity
                list<string> ArrData = new list<string>(); // untuk menampung PolicyNo, Policy App, Payment, Entity.
                String DataTemp = dataMID.mid_custom_field3_temp__c;
                system.debug('#DataTemp : '+DataTemp);
                
                DataTemp = DataTemp.left(DataTemp.length()-1);
                DataTemp = DataTemp.replace('null','');
                ArrTemp = DataTemp.split(';');
                
                if (ArrTemp.size() > 0) {
                    for (integer i = 0; i < ArrTemp.size(); i++){
                        ArrData = ArrTemp[i].split('_');
                        if (ArrData.size() > 0) {
                            ArrPolicyApp.add(ArrData[0]);
                            ArrPolicyNo.add(ArrData[1]);
                            ArrPolicyPayment.add(ArrData[2]);
                            ArrPolicyEntity.add(ArrData[3]);
                            
                            if (PolicyEntity1 == '' && policy_apps == ArrData[0]) PolicyEntity1 = ArrData[3];
                            if (PolicyEntity1 != '' && PolicyEntity2 == '' && policy_apps2 == ArrData[0]) PolicyEntity2 = ArrData[3];
                            
                        }
                    }
                }

                if (Status1 == 'Accepted'){
                    try{
                        
                        // Loop hit to EIP
                        string tempPolicyApps = '';
                        string temp_mid_transaction_time = '';
                        system.debug('#Start Loop ');
                         // Taufik, 2 Jun20, No need Loop.
                        //for (integer i = 0; i < ArrTemp.size(); i++)
                        {
                            //system.debug('#Start Loop 0 - '+i);
                            system.debug('#Start Loop 0 - '+policy_apps);
            
                            String method = dataMID.Payment_Type__c; //'saving'; // pindah kebawah
                            String status = 'accept';
            
                            String oldOrderId = dataMID.SFDC_Order_Id_Child__c;
                            List<String> parser = oldOrderId.split('_');
                            
                            //String newOrderId = parser[0] + '_' + ArrPolicyNo[i].replace('-', '') + '_' + parser[2];
                            String newOrderId = '';
                            /* // 2 Jun20, hide.
                            if (OrderCode.get(parser[0]+'-'+ArrPolicyApp[i]) == NULL)
                                newOrderId = parser[0] + '_' + ArrPolicyNo[i].replace('-', '') + '_' + parser[2];
                            else 
                              newOrderId = OrderCode.get(parser[0]+'-'+ArrPolicyApp[i]) + '_' + ArrPolicyNo[i].replace('-', '') + '_' + parser[2];
                            */
                            newOrderId = dataMID.mid_order_id__c;
                            system.debug('newOrderId : '+newOrderId);
            
                            String trxRefNo = newOrderId;//TempOrder.SFDC_Order_Id_Child__c;//'SFDC_TEST20191217000001';
                        
                            Map<String, String> params = new Map<String, String>();
                            params.put(EIPConstant.STATUS_CODE, dataMID.mid_status_code__c);
                            system.debug('#EIPConstant.STATUS_CODE : '+dataMID.mid_status_code__c);
                            system.debug('#Entity : '+ PolicyEntity1); //ArrPolicyEntity[i]
                            
                            datetime datetimenow = datetime.now();
                            if (dataMID.mid_transaction_time__c == NULL) dataMID.mid_transaction_time__c = datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta');
                            //if (dataMID.mid_transaction_time2__c == NULL) dataMID.mid_transaction_time2__c = datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta');
                            
                            /* // 2 Jun20, Hide
                            // jika blank, seq 1, jika isi, seq 2
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps == '') temp_mid_transaction_time = dataMID.mid_transaction_time__c;
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps == '') tempPolicyApps = ArrPolicyApp[i];

                            // jika isi, seq 2
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps != '') temp_mid_transaction_time = dataMID.mid_transaction_time2__c;
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps != '') tempPolicyApps = ArrPolicyApp[i];
                            */
                            
                            temp_mid_transaction_time = dataMID.mid_transaction_time__c;
                            tempPolicyApps = policy_apps;

                            params.put(EIPConstant.TRANSACTION_TIME, temp_mid_transaction_time); //'2019-12-17 19:10:10' // dataMID.mid_transaction_time__c
                            system.debug('#EIPConstant.TRANSACTION_TIME : '+temp_mid_transaction_time); // dataMID.mid_transaction_time__c
                            //params.put(EIPConstant.TRANSACTION_TIME, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); //'2019-12-17 19:10:10'
                            //system.debug('#EIPConstant.TRANSACTION_TIME : '+datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                            params.put(EIPConstant.SIGANTURE_KEY, ''); //saioduhalskdjiqmaslkcioqewiqejdio12j8eu398
                            system.debug('#EIPConstant.SIGANTURE_KEY : ');
                            params.put(EIPConstant.BANK, dataMID.Bank_Name__c); // bca
                            system.debug('#EIPConstant.BANK : '+dataMID.Bank_Name__c);
                            //params.put(EIPConstant.VA_NUMBER, '41000');
                            params.put(EIPConstant.CUSTOM_FIELD_1, dataMID.mid_custom_field1__c); //'cobaaaaa'
                            system.debug('#EIPConstant.CUSTOM_FIELD_1 : '+dataMID.mid_custom_field1__c);
                            params.put(EIPConstant.CUSTOM_FIELD_2, dataMID.mid_custom_field2__c); // 'testing'
                            system.debug('#EIPConstant.CUSTOM_FIELD_2 : '+dataMID.mid_custom_field2__c);

                            string tempCustomField3 = '';
                            for (integer i = 0; i < ArrTemp.size(); i++){
                                 if (ArrTemp[i].contains(policy_apps) )
                                     tempCustomField3 += ArrTemp[i]+';';
                            }
                            system.debug('#EIPConstant.CUSTOM_FIELD_3 (NEW) : '+ tempCustomField3);
                            params.put(EIPConstant.CUSTOM_FIELD_3, tempCustomField3); // New 2 Jun20, update menjadi RLS_515-3977680_0_AMFS;DMTM_100-7575000_0_AMFS;

                            params.put(EIPConstant.STATUS_MESSAGE, 'veritrans payment notification');
                            system.debug('#EIPConstant.STATUS_MESSAGE : veritrans payment notification');
                            params.put(EIPConstant.ORDER_ID, trxRefNo); //PCOrderId.get(ArrPolicyApp[i])
                            system.debug('#EIPConstant.ORDER_ID : '+trxRefNo);
                            params.put(EIPConstant.TRANSACTION_ID, ''); // 20191217000001
                            system.debug('#EIPConstant.TRANSACTION_ID : ');
                            
                            // Taufik MII - 4 Feb 2020, 
                            string mid_saved_token_id_temp = '';
                            if (dataMID.Payment_Type__c == 'credit_card') mid_saved_token_id_temp = PCToken.get(policy_apps);
                            if (dataMID.Payment_Type__c == 'private') mid_saved_token_id_temp = dataMID.Card_Number__c;
                            if (dataMID.Payment_Type__c == 'saving') mid_saved_token_id_temp = dataMID.Account_Number__c;
                            
                            params.put(EIPConstant.SAVED_TOKEN_ID, mid_saved_token_id_temp); //test-token
                            system.debug('#EIPConstant.SAVED_TOKEN_ID : '+mid_saved_token_id_temp);

                           // Taufik MII - 5 Jun 2020, 
                            string mid_masked_card_temp = '';
                            if (dataMID.Payment_Type__c == 'credit_card') mid_masked_card_temp = dataMID.Card_Number__c;
                            if (dataMID.Payment_Type__c == 'private') mid_masked_card_temp = dataMID.Card_Number__c;
                            if (dataMID.Payment_Type__c == 'saving') mid_masked_card_temp = dataMID.Account_Number__c;
                            
                            params.put(EIPConstant.MASKED_CARD, mid_masked_card_temp); //test-token
                            system.debug('#EIPConstant.MASKED_CARD : '+mid_masked_card_temp);
                            
                            //Daniel, 12 Juni 2020
                            if (dataMID.Payment_Type__c == 'private') { params.put(EIPConstant.CARD_TYPE, 'private'); system.debug('#EIPConstant.CARD_TYPE : private'); }
                            else { params.put(EIPConstant.CARD_TYPE, 'others'); system.debug('#EIPConstant.CARD_TYPE : others'); }
                            //END - Daniel, 12 Juni 2020
                            
                            //params.put(EIPConstant.SAVED_TOKEN_ID, PCToken.get(ArrPolicyApp[i])); //test-token
                            //system.debug('#EIPConstant.SAVED_TOKEN_ID : '+PCToken.get(ArrPolicyApp[i]));
                            // 10 June, Expired sesuai dengan inputan
                            string Expiry_Date_MMYY = dataMID.Expiry_Date_MMYY__c;
                            if (dataMID.Expiry_Date_MMYY__c != NULL && dataMID.Expiry_Date_MMYY__c != '')
                              datetimenow = Date.newInstance(2000+integer.valueof(Expiry_Date_MMYY.right(2)), integer.valueof(Expiry_Date_MMYY.left(2)), 1);
                            else datetimenow = datetimenow.addYears(5);

			                // 22 Feb 2021, taufik update
                            if (dataMID.Expiry_Date_MMYY__c != '') params.put(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); // '2020-09-01 23:00:00'
                            if (dataMID.Expiry_Date_MMYY__c != '') system.debug('#EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT : '+ datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                                                        
                            params.put(EIPConstant.GROSS_AMOUNT, '10000.00');
                            system.debug('#EIPConstant.GROSS_AMOUNT : 10000');
                            params.put(EIPConstant.TRANSACTION_STATUS, dataMID.mid_transaction_status__c); //'expire'
                            system.debug('#EIPConstant.TRANSACTION_STATUS : '+dataMID.mid_transaction_status__c);
                            //params.put(EIPConstant.PAYMENT_TYPE, dataMID.Payment_Type__c); //'bank_transfer'
                            //system.debug('#EIPConstant.PAYMENT_TYPE : '+dataMID.Payment_Type__c);
                            
                            if (dataMID.Payment_Type__c == 'credit_card') dataMID.mid_payment_type__c = 'credit_card';
                            if (dataMID.Payment_Type__c == 'private') dataMID.mid_payment_type__c = 'private';
                            if (dataMID.Payment_Type__c == 'saving') dataMID.mid_payment_type__c = 'saving';

                            method = dataMID.mid_payment_type__c;
                            
                            params.put(EIPConstant.PAYMENT_TYPE, dataMID.mid_payment_type__c); //'bank_transfer'
                            system.debug('#EIPConstant.PAYMENT_TYPE : '+dataMID.mid_payment_type__c);
                            
                            // check condition, jika Status gagal. tidak jalan.
                            //EIPJson result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.ENTITY_AMFS, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                            EIPJson result;
                            String resultStatus;

                            //system.debug('#IF : '+ArrPolicyApp[i]+ ' == ' +policy_apps+ ' && ' +Status1+ ' == Accepted || ' +ArrPolicyApp[i]+ ' == '+policy_apps2+ ' && ' +Status2+ ' == Accepted');
                            system.debug('#IF : '+policy_apps+ ' == ' +policy_apps+ ' && ' +Status1+ ' == Accepted');
                            
                            //if ((ArrPolicyApp[i] == policy_apps && Status1 == 'Accepted') || (ArrPolicyApp[i] == policy_apps2 && Status2 == 'Accepted')) 
                            if (Status1 == 'Accepted' ) {
                                //result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, ArrPolicyEntity[i], EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                                result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, PolicyEntity1, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                                resultStatus = result.Body.status; // example to get result response
                                responseEip = result;
                            }
                            else 
                                resultStatus = '0';
                            
                            if(resultStatus == '1'){ // IF SUCCESS
                                // TODO
                            } else if(resultStatus == '0'){ // IF Not Success, 29 Jan 2021
                                // Capture error from doOder
                                dataMID.JsonBackEndError__c = result.Body.exceptionObj != NULL ? result.Body.exceptionObj.BackEndError : '-';
							}

                            dataMID.mid_EIPtokenApp_Status__c += resultStatus+';';
                            system.debug('#resultStatus : '+resultStatus);
                            
                        } // end loop to EIP
                        
                        system.debug('#End Loop 0');
                        //if (dataMID.Id != NULL)
                        //    update dataMID;
                        
                    } catch(EIPConnector.NoDataException e){
                        StatusMessage = 'Error';
                        ErrorMessage = e.getMessage();
                        System.debug('NoDataException - '+e.getMessage());
                    } catch(EIPConnector.EIPConnectorException e){
                        StatusMessage = 'Error';
                        ErrorMessage = e.getMessage();
                        System.debug('EIPConnectorException - '+e.getMessage());
                    } catch (Exception e){
                        StatusMessage = 'Error';
                        ErrorMessage = e.getMessage();
                        System.debug('Exception - '+e.getMessage());
                    }        

                }
        
                // New 2 June20, Split API to TokenApp
                if (Status2 == 'Accepted'){
                    try{
                        
                        // Loop hit to EIP
                        string tempPolicyApps = '';
                        string temp_mid_transaction_time = '';
                        system.debug('#Start Loop ');
                         // Taufik, 2 Jun20, No need Loop.
                        //for (integer i = 0; i < ArrTemp.size(); i++)
                        {
                            //system.debug('#Start Loop 0 - '+i);
                            system.debug('#Start Loop 1 - '+policy_apps2);
            
                            String method = dataMID.Payment_Type__c; //'saving'; // pindah kebawah
                            String status = 'accept';
            
                            String oldOrderId = dataMID.SFDC_Order_Id_Child__c;
                            List<String> parser = oldOrderId.split('_');
                            
                            //String newOrderId = parser[0] + '_' + ArrPolicyNo[i].replace('-', '') + '_' + parser[2];
                            String newOrderId = '';
                            /* // 2 Jun20, hide.
                            if (OrderCode.get(parser[0]+'-'+ArrPolicyApp[i]) == NULL)
                                newOrderId = parser[0] + '_' + ArrPolicyNo[i].replace('-', '') + '_' + parser[2];
                            else 
                              newOrderId = OrderCode.get(parser[0]+'-'+ArrPolicyApp[i]) + '_' + ArrPolicyNo[i].replace('-', '') + '_' + parser[2];
                            */
                            newOrderId = dataMID.mid_order_id2__c;
                            system.debug('newOrderId : '+newOrderId);
            
                            String trxRefNo = newOrderId;//TempOrder.SFDC_Order_Id_Child__c;//'SFDC_TEST20191217000001';
                        
                            Map<String, String> params = new Map<String, String>();
                            params.put(EIPConstant.STATUS_CODE, dataMID.mid_status_code2__c);
                            system.debug('#EIPConstant.STATUS_CODE : '+dataMID.mid_status_code2__c);
                            system.debug('#Entity : '+ PolicyEntity2); //ArrPolicyEntity[i]
                            
                            datetime datetimenow = datetime.now();
                            if (dataMID.mid_transaction_time2__c == NULL) dataMID.mid_transaction_time2__c = datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta');
                            
                            /* // 2 Jun20, Hide
                            // jika blank, seq 1, jika isi, seq 2
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps == '') temp_mid_transaction_time = dataMID.mid_transaction_time__c;
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps == '') tempPolicyApps = ArrPolicyApp[i];

                            // jika isi, seq 2
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps != '') temp_mid_transaction_time = dataMID.mid_transaction_time2__c;
                            if (tempPolicyApps != ArrPolicyApp[i] && tempPolicyApps != '') tempPolicyApps = ArrPolicyApp[i];
                            */
                            
                            temp_mid_transaction_time = dataMID.mid_transaction_time2__c;
                            tempPolicyApps = policy_apps2;

                            params.put(EIPConstant.TRANSACTION_TIME, temp_mid_transaction_time); //'2019-12-17 19:10:10' // dataMID.mid_transaction_time__c
                            system.debug('#EIPConstant.TRANSACTION_TIME : '+temp_mid_transaction_time); // dataMID.mid_transaction_time__c
                            //params.put(EIPConstant.TRANSACTION_TIME, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); //'2019-12-17 19:10:10'
                            //system.debug('#EIPConstant.TRANSACTION_TIME : '+datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                            params.put(EIPConstant.SIGANTURE_KEY, ''); //saioduhalskdjiqmaslkcioqewiqejdio12j8eu398
                            system.debug('#EIPConstant.SIGANTURE_KEY : ');
                            params.put(EIPConstant.BANK, dataMID.Bank_Name__c); // bca
                            system.debug('#EIPConstant.BANK : '+dataMID.Bank_Name__c);
                            //params.put(EIPConstant.VA_NUMBER, '41000');
                            params.put(EIPConstant.CUSTOM_FIELD_1, dataMID.mid_custom_field1__c); //'cobaaaaa'
                            system.debug('#EIPConstant.CUSTOM_FIELD_1 : '+dataMID.mid_custom_field1__c);
                            params.put(EIPConstant.CUSTOM_FIELD_2, dataMID.mid_custom_field2__c); // 'testing'
                            system.debug('#EIPConstant.CUSTOM_FIELD_2 : '+dataMID.mid_custom_field2__c);

                            string tempCustomField3 = '';
                            for (integer i = 0; i < ArrTemp.size(); i++){
                                 if (ArrTemp[i].contains(policy_apps2) )
                                     tempCustomField3 += ArrTemp[i]+';';
                            }
                            system.debug('#EIPConstant.CUSTOM_FIELD_3 (NEW) : '+ tempCustomField3);
                            params.put(EIPConstant.CUSTOM_FIELD_3, tempCustomField3); // New 2 Jun20, update menjadi RLS_515-3977680_0_AMFS;DMTM_100-7575000_0_AMFS;

                            params.put(EIPConstant.STATUS_MESSAGE, 'veritrans payment notification');
                            system.debug('#EIPConstant.STATUS_MESSAGE : veritrans payment notification');
                            params.put(EIPConstant.ORDER_ID, trxRefNo); //PCOrderId.get(ArrPolicyApp[i])
                            system.debug('#EIPConstant.ORDER_ID : '+trxRefNo);
                            params.put(EIPConstant.TRANSACTION_ID, ''); // 20191217000001
                            system.debug('#EIPConstant.TRANSACTION_ID : ');
                            
                            // Taufik MII - 4 Feb 2020, 
                            string mid_saved_token_id_temp = '';
                            if (dataMID.Payment_Type__c == 'credit_card') mid_saved_token_id_temp = PCToken.get(policy_apps2);
                            if (dataMID.Payment_Type__c == 'private') mid_saved_token_id_temp = dataMID.Card_Number__c;
                            if (dataMID.Payment_Type__c == 'saving') mid_saved_token_id_temp = dataMID.Account_Number__c;
                            
                            params.put(EIPConstant.SAVED_TOKEN_ID, mid_saved_token_id_temp); //test-token
                            system.debug('#EIPConstant.SAVED_TOKEN_ID : '+mid_saved_token_id_temp);

                           // Taufik MII - 5 Jun 2020, 
                            string mid_masked_card_temp = '';
                            if (dataMID.Payment_Type__c == 'credit_card') mid_masked_card_temp = dataMID.Card_Number__c;
                            if (dataMID.Payment_Type__c == 'private') mid_masked_card_temp = dataMID.Card_Number__c;
                            if (dataMID.Payment_Type__c == 'saving') mid_masked_card_temp = dataMID.Account_Number__c;
                            
                            params.put(EIPConstant.MASKED_CARD, mid_masked_card_temp); //test-token
                            system.debug('#EIPConstant.MASKED_CARD : '+mid_masked_card_temp);
                            
                            //Daniel, 12 Juni 2020
                            if (dataMID.Payment_Type__c == 'private') { params.put(EIPConstant.CARD_TYPE, 'private'); system.debug('#EIPConstant.CARD_TYPE : private'); }
                            else { params.put(EIPConstant.CARD_TYPE, 'others'); system.debug('#EIPConstant.CARD_TYPE : others'); }
                            //END - Daniel, 12 Juni 2020
                            
                            //params.put(EIPConstant.SAVED_TOKEN_ID, PCToken.get(ArrPolicyApp[i])); //test-token
                            //system.debug('#EIPConstant.SAVED_TOKEN_ID : '+PCToken.get(ArrPolicyApp[i]));
                            // 10 June, Expired sesuai dengan inputan
                            string Expiry_Date_MMYY = dataMID.Expiry_Date_MMYY__c;
                            if (dataMID.Expiry_Date_MMYY__c != NULL && dataMID.Expiry_Date_MMYY__c != '')
                              datetimenow = Date.newInstance(2000+integer.valueof(Expiry_Date_MMYY.right(2)), integer.valueof(Expiry_Date_MMYY.left(2)), 1);
                            else datetimenow = datetimenow.addYears(5);

                            // 22 Feb 2021, taufik update
                            if (dataMID.Expiry_Date_MMYY__c != '') params.put(EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT, datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta')); // '2020-09-01 23:00:00'
                            if (dataMID.Expiry_Date_MMYY__c != '') system.debug('#EIPConstant.SAVED_TOKEN_ID_EXPIRED_AT : '+ datetimenow.format('yyyy-MM-dd HH:mm:ss','Asia/Jakarta'));
                            
                            params.put(EIPConstant.GROSS_AMOUNT, '10000.00');
                            system.debug('#EIPConstant.GROSS_AMOUNT : 10000');
                            params.put(EIPConstant.TRANSACTION_STATUS, dataMID.mid_transaction_status__c); //'expire'
                            system.debug('#EIPConstant.TRANSACTION_STATUS : '+dataMID.mid_transaction_status__c);
                            //params.put(EIPConstant.PAYMENT_TYPE, dataMID.Payment_Type__c); //'bank_transfer'
                            //system.debug('#EIPConstant.PAYMENT_TYPE : '+dataMID.Payment_Type__c);
                            
                            if (dataMID.Payment_Type__c == 'credit_card') dataMID.mid_payment_type__c = 'credit_card';
                            if (dataMID.Payment_Type__c == 'private') dataMID.mid_payment_type__c = 'private';
                            if (dataMID.Payment_Type__c == 'saving') dataMID.mid_payment_type__c = 'saving';

                            method = dataMID.mid_payment_type__c;
                            
                            params.put(EIPConstant.PAYMENT_TYPE, dataMID.mid_payment_type__c); //'bank_transfer'
                            system.debug('#EIPConstant.PAYMENT_TYPE : '+dataMID.mid_payment_type__c);
                            
                            // check condition, jika Status gagal. tidak jalan.
                            //EIPJson result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.ENTITY_AMFS, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                            EIPJson result;
                            String resultStatus;

                            //system.debug('#IF : '+ArrPolicyApp[i]+ ' == ' +policy_apps+ ' && ' +Status1+ ' == Accepted || ' +ArrPolicyApp[i]+ ' == '+policy_apps2+ ' && ' +Status2+ ' == Accepted');
                            system.debug('#IF : '+policy_apps2+ ' == ' +policy_apps2+ ' && ' +Status2+ ' == Accepted');
                            
                            //if ((ArrPolicyApp[i] == policy_apps && Status1 == 'Accepted') || (ArrPolicyApp[i] == policy_apps2 && Status2 == 'Accepted')) 
                            if (Status2 == 'Accepted' ) {
                                //result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, ArrPolicyEntity[i], EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                                result = EIPConnector.doOrder(EIPConstant.OPERATION_SUBMIT_DATA, PolicyEntity2, EIPConstant.APP_TOKEN, trxRefNo, method, status, params);
                                resultStatus = result.Body.status; // example to get result response
                            }
                            else 
                                resultStatus = '0';
                            
                            if(resultStatus == '1'){ // IF SUCCESS
                                // TODO
                            } else if(resultStatus == '0'){ // IF Not Success, 29 Jan 2021
                                // Capture error from doOder
                                dataMID.JsonBackEndError__c = result.Body.exceptionObj != NULL ? result.Body.exceptionObj.BackEndError : '-';
							}

                            dataMID.mid_EIPtokenApp_Status__c += resultStatus+';';
                            system.debug('#resultStatus : '+resultStatus);
                            
                        } // end loop to EIP
                        
                        system.debug('#End Loop 0');
                        //if (dataMID.Id != NULL)
                        //    update dataMID;
                        
                    } catch(EIPConnector.NoDataException e){
                        StatusMessage = 'Error';
                        ErrorMessage = e.getMessage();
                        System.debug('NoDataException - '+e.getMessage());
                    } catch(EIPConnector.EIPConnectorException e){
                        StatusMessage = 'Error';
                        ErrorMessage = e.getMessage();
                        System.debug('EIPConnectorException - '+e.getMessage());
                    } catch (Exception e){
                        StatusMessage = 'Error';
                        ErrorMessage = e.getMessage();
                        System.debug('Exception - '+e.getMessage());
                    }        

                }

                responseMessage = '{"id": "'+dataid+'", "message" : "'+StatusMessage+'", "errors" : "'+ErrorMessage+'"}';
                if (ErrorMessage != '') dataMID.Status__c = 'Error EIP TokenApps';
        
                if (dataMID.Id != NULL) dataMID.JsonErrorMessage__c = responseMessage; // Taufik 5 Aug20, for debug log on UI SFDC
                // Update Status PureCloud to SFDC
                if (dataMID.Id != NULL)
                    update dataMID;
                system.debug('#Update dataMID');
                
                // catur (20210303), added logger for pcidss
                DateTime dtEnd = DateTime.now();
                if(responseEip == NULL && dataMID.Id != NULL){
                    EIPConnector.insertLogPcidss(dtStart, dtEnd, dataMID.JsonRequestBody__c, dataMID.mid_status_code__c + ' - ' + dataMID.mid_status_message__c,
                                                 dataMID.SFDC_Order_Id__c, EIPConstant.APP_TOKEN, dataMID.Entity__c, 
                                                 EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.SERVICE_GET_TOKEN);
                }else{
                    EIPConnector.insertLogPcidss(dtStart, dtEnd, dataMID.JsonRequestBody__c, System.JSON.serialize(responseEip, true),
                                                 dataMID.SFDC_Order_Id__c, EIPConstant.APP_TOKEN, dataMID.Entity__c, 
                                                 EIPConstant.OPERATION_SUBMIT_DATA, EIPConstant.SERVICE_GET_TOKEN);
                }
                
                
            } else {
                RestContext.response.statusCode = 400;
                responseMessage = '{"message" : "body does not contain order id"}';   
                system.debug('#Error 400 - '+responseMessage);
            }
        } else {
            RestContext.response.statusCode = 400;
            responseMessage = '{"error" : "No data!"}';
            system.debug('#Error 400 - '+responseMessage);
        }
        
        
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf(responseMessage);
    }

}