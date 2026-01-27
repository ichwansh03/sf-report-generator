trigger ParameterApproved on ICF_Parameter__c (After Update) {
    for (ICF_Parameter__c ip : trigger.new){
        //if (ip.Status__c == 'Approved' && trigger.old[0].Status__c != ip.Status__c)
        if(ip.Status__c == 'Approved' && trigger.OldMap.get(ip.id).Status__c != trigger.NewMap.get(ip.id).Status__c)
        {
        
            String ipIdMaster = ip.Master__c;
            
            DescribeSObjectResult describeResultIcfParam = ICF_Parameter__c.getSObjectType().getDescribe();
            List<String> icfParamFieldList = new List<String>(describeResultIcfParam.fields.getMap().keySet());
            String icfParamFields = String.join(icfParamFieldList, ',');
            String icfParamQuery = ' SELECT ' + icfParamFields + ' FROM ICF_Parameter__c WHERE Id = :ipIdMaster ';
            ICF_Parameter__c masterparam = Database.query(icfParamQuery);
            
                masterparam.Current_Document__c = ip.id;
            	masterparam.Case_Priority__c = ip.Case_Priority__c;
                masterparam.CCC_I_Ask_Exculde__c = ip.CCC_I_Ask_Exculde__c;
                masterparam.CCC_I_Complain_Exculde__c = ip.CCC_I_Complain_Exculde__c;
                masterparam.Entity__c = ip.Entity__c;
                masterparam.Frequency__c = ip.Frequency__c;
                masterparam.ICF_Method__c = ip.ICF_Method__c;
                masterparam.Exclude_Survey_Type__c = ip.Exclude_Survey_Type__c;
                masterparam.Dont_Send_if_Have_any_Case_Open__c = ip.Dont_Send_if_Have_any_Case_Open__c;
                masterparam.ICF_Email_Template__c = ip.ICF_Email_Template__c;
                masterparam.ICF_SMS_Template__c = ip.ICF_SMS_Template__c;
                masterparam.Interval_Completed_Month__c = ip.Interval_Completed_Month__c;
                masterparam.Interval_No_Response_Month__c = ip.Interval_No_Response_Month__c;
                masterparam.Interval_Max_Loop__c = ip.Interval_Max_Loop__c;
                masterparam.Negative_feedback__c = ip.Negative_feedback__c;
                masterparam.Negative_Feedback_Row__c = ip.Negative_Feedback_Row__c;
                masterparam.Non_CCC_I_Ask_Exculde__c = ip.Non_CCC_I_Ask_Exculde__c;
                masterparam.Non_CCC_I_Buy_Exculde__c = ip.Non_CCC_I_Buy_Exculde__c;
                masterparam.Non_CCC_I_Claim_Exculde__c = ip.Non_CCC_I_Claim_Exculde__c;
                masterparam.Non_CCC_I_Renew_Exculde__c = ip.Non_CCC_I_Renew_Exculde__c;
                masterparam.Non_CCC_Status_Cases__c = ip.Non_CCC_Status_Cases__c;
                masterparam.Send_ICF_Flag__c = ip.Send_ICF_Flag__c;
                masterparam.Send_ICF_Day__c = ip.Send_ICF_Day__c;
                masterparam.Send_Thanks_Note_Flag__c = ip.Send_Thanks_Note_Flag__c;
                masterparam.Send_Thanks_Note_Day__c = ip.Send_Thanks_Note_Day__c;
                masterparam.Send_Thanks_Note_When_Case__c = ip.Send_Thanks_Note_When_Case__c;
                masterparam.Send_to_Case_Contacting__c = ip.Send_to_Case_Contacting__c;
                masterparam.Status_Cases__c = ip.Status_Cases__c;
                masterparam.Thanks_Email_Template__c = ip.Thanks_Email_Template__c;
                masterparam.Thanks_SMS_Template__c = ip.Thanks_SMS_Template__c;
                masterparam.Type__c = ip.Type__c;
                
                update masterparam;
            
            if (ip.Record_Type_Name__c == 'Change_Request_IDAS'){
                List<ICF_Parameterized_Filter_Criteria__c> ipc2 = [SELECT id, Category__c, Field__c, Logic__c, Operator__c, Seq__c, Type__c, Value__c
                    FROM ICF_Parameterized_Filter_Criteria__c
                    WHERE Parameterized__c =:ip.Master__c];
                
                delete ipc2;
                
                list<ICF_Parameterized_Filter_Criteria__c> listnewipc = new List<ICF_Parameterized_Filter_Criteria__c>();
                for (ICF_Parameterized_Filter_Criteria__c ipc : [SELECT id, Category__c, Field__c, Logic__c, Operator__c, Seq__c, Type__c, Value__c
                    FROM ICF_Parameterized_Filter_Criteria__c
                    WHERE Parameterized__c =:ip.id
                ]){
                    ICF_Parameterized_Filter_Criteria__c newipc = new ICF_Parameterized_Filter_Criteria__c(
                        Parameterized__c = ip.Master__c,
                        Category__c = ipc.Category__c, 
                        Field__c = ipc.Field__c, 
                        Logic__c = ipc.Logic__c, 
                        Operator__c = ipc.Operator__c, 
                        Seq__c = ipc.Seq__c, 
                        Type__c = ipc.Type__c, 
                        Value__c = ipc.Value__c
                    );
                    listnewipc.add(newipc);
                }
                if (listnewipc.size() > 0) insert listnewipc;
            }
        }
    } // end for
} // end trigger