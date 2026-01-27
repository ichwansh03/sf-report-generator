trigger ParameterChangeRequest on ICF_Parameter__c (Before Update) {
    for (ICF_Parameter__c ip : trigger.new){
        if (ip.Change_request__c){
            ip.Change_request__c = FALSE;
            
            //create change request 
            string RTChangeRequest = ip.Record_Type_Name__c;
            RTChangeRequest = RTChangeRequest.replace('Master','Change_Request');
            
            RecordType rt = [SELECT id FROM RecordType WHERE DeveloperName = :RTChangeRequest and SobjectType = 'ICF_Parameter__c']; //'Change_Request' 
            
            ID RTID;
            RTID = rt.id;
            /*
            if (ip.Record_Type_Name__c == 'Master_CCC')
                RTID = id.valueof(label.Parameter_CCC);
            if (ip.Record_Type_Name__c == 'Master_Email_SMS')
                RTID = id.valueof(label.Parameter_Email);
            if (ip.Record_Type_Name__c == 'Master_Feedback')
                RTID = id.valueof(label.Parameter_Feedback);
            if (ip.Record_Type_Name__c == 'Master_IDAS')
                RTID = id.valueof(label.Parameter_IDAS);
            if (ip.Record_Type_Name__c == 'Master_Non_CCC')
                RTID = id.valueof(label.Parameter_NonCCC);
            */
            
            ICF_Parameter__c newparam = new ICF_Parameter__c(
                RecordTypeId = RTID,//rt.id,
                Master__c = ip.id,
                Case_Priority__c = ip.Case_Priority__c,
                CCC_I_Ask_Exculde__c = ip.CCC_I_Ask_Exculde__c,
                CCC_I_Complain_Exculde__c = ip.CCC_I_Complain_Exculde__c,
                Entity__c = ip.Entity__c,
                Frequency__c = ip.Frequency__c,
                ICF_Method__c = ip.ICF_Method__c,
                Exclude_Survey_Type__c = ip.Exclude_Survey_Type__c,
                Dont_Send_if_Have_any_Case_Open__c = ip.Dont_Send_if_Have_any_Case_Open__c,
                ICF_Email_Template__c = ip.ICF_Email_Template__c,
                ICF_SMS_Template__c = ip.ICF_SMS_Template__c,
                Interval_Completed_Month__c = ip.Interval_Completed_Month__c,
                Interval_No_Response_Month__c = ip.Interval_No_Response_Month__c,
                Interval_Max_Loop__c = ip.Interval_Max_Loop__c,
                Negative_feedback__c = ip.Negative_feedback__c,
                Negative_Feedback_Row__c = ip.Negative_Feedback_Row__c,
                Non_CCC_I_Ask_Exculde__c = ip.Non_CCC_I_Ask_Exculde__c,
                Non_CCC_I_Buy_Exculde__c = ip.Non_CCC_I_Buy_Exculde__c,
                Non_CCC_I_Claim_Exculde__c = ip.Non_CCC_I_Claim_Exculde__c,
                Non_CCC_I_Renew_Exculde__c = ip.Non_CCC_I_Renew_Exculde__c,
                Non_CCC_Status_Cases__c = ip.Non_CCC_Status_Cases__c,
                Send_ICF_Flag__c = ip.Send_ICF_Flag__c,
                Send_ICF_Day__c = ip.Send_ICF_Day__c,
                Send_Thanks_Note_Flag__c = ip.Send_Thanks_Note_Flag__c,
                Send_Thanks_Note_Day__c = ip.Send_Thanks_Note_Day__c,
                Send_Thanks_Note_When_Case__c = ip.Send_Thanks_Note_When_Case__c,
                Send_to_Case_Contacting__c = ip.Send_to_Case_Contacting__c,
                Status_Cases__c = ip.Status_Cases__c,
                Thanks_Email_Template__c = ip.Thanks_Email_Template__c,
                Thanks_SMS_Template__c = ip.Thanks_SMS_Template__c,
                Type__c = ip.Type__c
            );
            
            insert newparam;
            
            if (ip.Record_Type_Name__c == 'Master_Non_CCC'){
                list<ICF_Parameterized_Filter_Criteria__c> listnewipc = new List<ICF_Parameterized_Filter_Criteria__c>();
                for (ICF_Parameterized_Filter_Criteria__c ipc : [SELECT id, Category__c, 
                        Exclude_I_Ask__c, Exclude_I_Buy__c, Exclude_I_Claim__c, Exclude_I_Renew__c, 
                        Ext_Id__c, 
                        Field__c, Field_2__c, Field_3__c, Field_4__c, 
                        ICF_Email_Template__c, ICF_SMS_Template__c, ICF_Survey_Template__c, 
                        Logic__c, Logic_2__c, Logic_3__c, 
                        Operator__c, Operator_2__c, Operator_3__c, Operator_4__c, 
                        Parameterized__c, 
                        Result_1__c, Result_2__c, Result_3__c, Result_4__c, Result_Final__c, 
                        Schedule_I_Ask__c, Schedule_I_Buy__c, Schedule_I_Claim__c, Schedule_I_Renew__c, 
                        Send_Field__c, Send_Value__c, 
                        Seq__c, Type__c, Value__c, 
                        Value_Custom__c, Value_Custom_2__c, Value_Custom_3__c, Value_Custom_4__c
                                        
                    FROM ICF_Parameterized_Filter_Criteria__c
                    WHERE Parameterized__c =:ip.id
                ]){
                    ICF_Parameterized_Filter_Criteria__c newipc = new ICF_Parameterized_Filter_Criteria__c();
                        newipc.Parameterized__c = newparam.id;
                        
                        newipc.Category__c = ipc.Category__c;
                        newipc.Exclude_I_Ask__c = ipc.Exclude_I_Ask__c;
                        newipc.Exclude_I_Buy__c = ipc.Exclude_I_Buy__c;
                        newipc.Exclude_I_Claim__c = ipc.Exclude_I_Claim__c;
                        newipc.Exclude_I_Renew__c = ipc.Exclude_I_Renew__c;
                        newipc.Field__c = ipc.Field__c;
                        newipc.Field_2__c = ipc.Field_2__c;
                        newipc.Field_3__c = ipc.Field_3__c;
                        newipc.Field_4__c = ipc.Field_4__c;
                        newipc.ICF_Email_Template__c = ipc.ICF_Email_Template__c;
                        newipc.ICF_SMS_Template__c = ipc.ICF_SMS_Template__c;
                        newipc.ICF_Survey_Template__c = ipc.ICF_Survey_Template__c;
                        newipc.Logic__c = ipc.Logic__c;
                        newipc.Logic_2__c = ipc.Logic_2__c;
                        newipc.Logic_3__c = ipc.Logic_3__c;
                        newipc.Operator__c = ipc.Operator__c;
                        newipc.Operator_2__c = ipc.Operator_2__c;
                        newipc.Operator_3__c = ipc.Operator_3__c;
                        newipc.Operator_4__c = ipc.Operator_4__c;
                        newipc.Result_1__c = ipc.Result_1__c;
                        newipc.Result_2__c = ipc.Result_2__c;
                        newipc.Result_3__c = ipc.Result_3__c;
                        newipc.Result_4__c = ipc.Result_4__c;
                        newipc.Result_Final__c = ipc.Result_Final__c;
                        newipc.Schedule_I_Ask__c = ipc.Schedule_I_Ask__c;
                        newipc.Schedule_I_Buy__c = ipc.Schedule_I_Buy__c;
                        newipc.Schedule_I_Claim__c = ipc.Schedule_I_Claim__c;
                        newipc.Schedule_I_Renew__c = ipc.Schedule_I_Renew__c;
                        newipc.Send_Field__c = ipc.Send_Field__c;
                        newipc.Send_Value__c = ipc.Send_Value__c;
                        newipc.Seq__c = ipc.Seq__c;
                        newipc.Type__c = ipc.Type__c;
                        newipc.Value__c = ipc.Value__c;
                        newipc.Value_Custom__c = ipc.Value_Custom__c;
                        newipc.Value_Custom_2__c = ipc.Value_Custom_2__c;
                        newipc.Value_Custom_3__c = ipc.Value_Custom_3__c;
                        newipc.Value_Custom_4__c = ipc.Value_Custom_4__c;
                      
                    listnewipc.add(newipc);
                }
                if (listnewipc.size() > 0) insert listnewipc;
            }
        }
    } // end for
} // end trigger