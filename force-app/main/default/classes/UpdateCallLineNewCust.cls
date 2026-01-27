public class UpdateCallLineNewCust {
    @future(callout=true)
    public static void UpdateCallLine(Set<Id> idSurveyResp){
        DescribeSObjectResult describeResult = Survey_Response__c.getSObjectType().getDescribe();
        List<String> FieldList = new List<String>(describeResult.fields.getMap().keySet());
        String Fields = String.join(FieldList, ',');
        String query = ' SELECT ' + Fields + ' from Survey_Response__c where SurveyTaker__c in:idSurveyResp ';
        String wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
        String TelRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
        
        List<Survey_Response__c> list_sr = Database.query(query);
        List<Call_Line__c> updt_list_cl = new List<Call_Line__c>();
        List<SurveyTaker__c> updt_list_sr = new List<SurveyTaker__c>();
        
        for(Survey_Response__c sr: list_sr){
            
            Email_SMS_Log__c esl = [select id, contact__c from Email_SMS_Log__c where id =: sr.Email_Sms_Log__c limit 1];
            List<Call_Line__c> list_cl = [select id, WelcomeCall_Customer_Satisfaction__c 
                                          from Call_Line__c where RecordTypeId =:wcRtId and Contact__c =:esl.contact__c limit 1]; 
            SurveyTaker__c st = [select id, Update_Call_Line__c from surveyTaker__c where id =: sr.SurveyTaker__c];
            if(list_cl.size() > 0){
                list_cl[0].WelcomeCall_Customer_Satisfaction__c = sr.Answer_1__c;
                updt_list_cl.add(list_cl[0]);
                st.Update_Call_Line__c = true;
            }else{
                list_cl = [select id, WelcomeCall_Customer_Satisfaction__c 
                           from Call_Line__c where RecordTypeId =:TelRtId and Contact__c =:esl.contact__c limit 1]; 
                if(list_cl.size() > 0){
                    list_cl[0].WelcomeCall_Customer_Satisfaction__c = sr.Answer_1__c;
                    updt_list_cl.add(list_cl[0]);
                    st.Update_Call_Line__c = true;
                }
            }
            
            updt_list_sr.add(st);
        }
        update updt_list_sr;
        update updt_list_cl;
    }

}