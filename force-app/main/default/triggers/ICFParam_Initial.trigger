trigger ICFParam_Initial on ICF_Parameterized_Filter_Criteria__c (Before Insert, Before Update) {
    for (ICF_Parameterized_Filter_Criteria__c param : trigger.new) {
        if (trigger.isBefore){
            if (Param.Type__c == 'Exclude - I Buy') {
                param.Exclude_I_Buy__c = param.Parameterized__c;
                param.Exclude_I_Renew__c = null;
                param.Exclude_I_Ask__c = null;
                param.Exclude_I_Claim__c = null;
                
                param.Schedule_I_Buy__c = null;
                param.Schedule_I_Renew__c = null;
                param.Schedule_I_Ask__c = null;
                param.Schedule_I_Claim__c = null;
                
            }
            else if (Param.Type__c == 'Exclude - I Renew'){
                param.Exclude_I_Buy__c = null;
                param.Exclude_I_Renew__c = param.Parameterized__c;
                param.Exclude_I_Ask__c = null;
                param.Exclude_I_Claim__c = null;
                
                param.Schedule_I_Buy__c = null;
                param.Schedule_I_Renew__c = null;
                param.Schedule_I_Ask__c = null;
                param.Schedule_I_Claim__c = null;
            }
            else if (Param.Type__c == 'Exclude - I Ask'){
                param.Exclude_I_Buy__c = null;
                param.Exclude_I_Renew__c = null;
                param.Exclude_I_Ask__c = param.Parameterized__c;
                param.Exclude_I_Claim__c = null;
                
                param.Schedule_I_Buy__c = null;
                param.Schedule_I_Renew__c = null;
                param.Schedule_I_Ask__c = null;
                param.Schedule_I_Claim__c = null;
            }
            else if (Param.Type__c == 'Exclude - I Claim') {
                param.Exclude_I_Buy__c = null;
                param.Exclude_I_Renew__c = null;
                param.Exclude_I_Ask__c = null;
                param.Exclude_I_Claim__c = param.Parameterized__c;

                param.Schedule_I_Buy__c = null;
                param.Schedule_I_Renew__c = null;
                param.Schedule_I_Ask__c = null;
                param.Schedule_I_Claim__c = null;
            }
            else if (Param.Type__c == 'Schedule - I Buy') {
                param.Exclude_I_Buy__c = null;
                param.Exclude_I_Renew__c = null;
                param.Exclude_I_Ask__c = null;
                param.Exclude_I_Claim__c = null;
                
                param.Schedule_I_Buy__c = param.Parameterized__c;
                param.Schedule_I_Renew__c = null;
                param.Schedule_I_Ask__c = null;
                param.Schedule_I_Claim__c = null;
                
            }
            else if (Param.Type__c == 'Schedule - I Renew'){
                param.Exclude_I_Buy__c = null;
                param.Exclude_I_Renew__c = null;
                param.Exclude_I_Ask__c = null;
                param.Exclude_I_Claim__c = null;
                
                param.Schedule_I_Buy__c = null;
                param.Schedule_I_Renew__c = param.Parameterized__c;
                param.Schedule_I_Ask__c = null;
                param.Schedule_I_Claim__c = null;
            }
            else if (Param.Type__c == 'Schedule - I Ask'){
                param.Exclude_I_Buy__c = null;
                param.Exclude_I_Renew__c = null;
                param.Exclude_I_Ask__c = null;
                param.Exclude_I_Claim__c = null;
                
                param.Schedule_I_Buy__c = null;
                param.Schedule_I_Renew__c = null;
                param.Schedule_I_Ask__c = param.Parameterized__c;
                param.Schedule_I_Claim__c = null;
            }
            else if (Param.Type__c == 'Schedule - I Claim') {
                param.Exclude_I_Buy__c = null;
                param.Exclude_I_Renew__c = null;
                param.Exclude_I_Ask__c = null;
                param.Exclude_I_Claim__c = null;

                param.Schedule_I_Buy__c = null;
                param.Schedule_I_Renew__c = null;
                param.Schedule_I_Ask__c = null;
                param.Schedule_I_Claim__c = param.Parameterized__c;
            }  
            
            // Operator 
            /*
            IF (Param.Field__c != '') {
                IF (param.Operator__c == 'Equal') {                
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                }
                IF (param.Operator__c == 'Not Equal to') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Contains') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Not Contains') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Less than') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Greater than') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Less or equal') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Greater or equal') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Starts With') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
                IF (param.Operator__c == 'Not Starts With') {
                    param.Result_1__c = param.Field_F__c + ' = \'' + param.Value_Custom__c + '\'';
                
                }
            }
            */                            
            param.Result_Final__c = '';
            param.Result_Final__c += param.Result_1__c;
            IF (Param.Result_2__c != '' && Param.Result_2__c != NULL) {
                param.Result_Final__c += ' '+param.Logic__c;
                param.Result_Final__c += ' '+param.Result_2__c;

                IF (Param.Result_3__c != '' && Param.Result_3__c != NULL) {
                    param.Result_Final__c += ' '+param.Logic_2__c;
                    param.Result_Final__c += ' '+param.Result_3__c;

                    IF (Param.Result_4__c != '' && Param.Result_4__c != NULL) {
                        param.Result_Final__c += ' '+param.Logic_3__c;
                        param.Result_Final__c += ' '+param.Result_4__c;
                    }
    
                }
            }
            //*/
        }
    }
}