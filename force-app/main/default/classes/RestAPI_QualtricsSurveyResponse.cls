/****************************************************************************************
 * Controller	: RestAPI_QualtricsSurveyResponse
 * Class 		: Apex Controller API Handler
 * Test Class 	: RestAPI_QualtricsSurveyResponse_Test
 * =====================================================================================
 * ------------------------------------ Log --------------------------------------------
 * ===================================================================================== 
 * MII           	- Created Apex  									- 28 03 24
 * **************************************************************************************/
public without sharing class RestAPI_QualtricsSurveyResponse {    
    @future(callout=true)
    public static void sendSurvey(String caseId, string surveyResponseId) {
        Case getdetailCase = [Select id, Casenumber, mot__c, type, case_type__c,  Contact.Agent_Role_Code__c, Entity__c, CHS_Status__c, Complaint_Decision_AMFS__c from Case where id =: caseId];
        Survey_Response__c getDetailSurvey = [SELECT Id, CreatedDate, LastModifiedDate, Answer_1__c, Answer_2__c, Answer_3__c, Answer_4__c, 
                                              Answer_5__c, Answer_6__c, Answer_7__c, Answer_8__c, Answer_9__c, Answer_10__c, Email_Sms_Log__c,
                                              Email_Sms_Log__r.Type__c, SurveyTaker__c , SurveyTaker__r.Name
                                              FROM Survey_Response__c where id =: surveyResponseId];
        
        String message = '';
        String url = '';
        string body  = '';
        String response = '';
        string responseCode = '';
        
        try {
            
            String baseUrl = label.AMFS_Qualtrics_baseUrl;
            string idpSource = label.AMFS_Qualtrics_idpsourceid;
            if(getdetailCase.case_type__c == 'Request_Claim_Payment'){
                idpSource = label.AMFS_Qualtrics_Claim_idpsourceid ;
            }
            if(getdetailCase.type == 'Complaint' && (getdetailCase.CHS_Status__c == 'Closed - Invalid' || getdetailCase.CHS_Status__c == 'Closed - Valid') && (getdetailCase.Complaint_Decision_AMFS__c == 'Invalid & Paid' || getdetailCase.Complaint_Decision_AMFS__c == 'Approve & Paid')){
                idpSource = label.AMFS_Qualtrics_Complaint_Approve_idpsourceid ;
            } else if(getdetailCase.type == 'Complaint' && (getdetailCase.CHS_Status__c == 'Closed - Invalid' || getdetailCase.CHS_Status__c == 'Closed - Valid') && getdetailCase.Complaint_Decision_AMFS__c == 'Invalid & Reject'){
                idpSource = label.AMFS_Qualtrics_Complaint_Reject_idpsourceid ;
            }
            if(getdetailCase.case_type__c == 'Request_POS_Withdrawal' || getdetailCase.case_type__c == 'Request_POS_Redemption' || getdetailCase.case_type__c == 'Request_POS_Surrender_Non_UL' || getdetailCase.case_type__c == 'Request_POS_Surrender_Endowment'){
                idpSource = label.AMFS_Qualtrics_Request_idpsourceid ;
            }
            if(getdetailCase.type == 'Inquiry' && getdetailCase.Entity__c == 'AMFS'){
                idpSource = label.AMFS_Qualtrics_Inquiry_idpsourceid ;
            }
            string endpoint = label.AMFS_Qualtrics_import_survey;
            string token = label.AMFS_Qualtrics_apiKey;
            
            endpoint = endpoint.replace( '[IDPSOURCE]', idpSource);
             
            url = label.AMFS_Qualtrics_baseUrl+endpoint;
            
            //Added by Dimas Support MII 17/04/2025
            Boolean configSendQualtrics = Boolean.valueof(System.Label.Config_Send_Qualtrics);
            
            system.debug('endpoint:'+endpoint);
            HTTP h = new HTTP();
            HTTPRequest req = new HTTPRequest();
            req.setEndPoint(url);
            req.setMethod('POST'); 
            
            // header
            req.setHeader('X-API-TOKEN',token); 
            req.setHeader('Content-Type','application/json'); 
            req.setHeader('Accept','application/json'); 
            
            
            // body
            JSONGenerator theBodyJSON = JSON.createGenerator(true); 
            theBodyJSON.writeStartObject();
            // get survey
            theBodyJSON.writeObjectField('Created_Date',convertDate(getDetailSurvey.CreatedDate)); 
            theBodyJSON.writeObjectField('Start_Date',convertDate(getDetailSurvey.CreatedDate)); 
            theBodyJSON.writeObjectField('End_Date',convertDate(getDetailSurvey.CreatedDate)); 
            theBodyJSON.writeObjectField('Recorded_Date',convertDate(getDetailSurvey.CreatedDate)); 
            
            // response
            // 
            if(getdetailCase.Entity__c == 'AMFS' && (getdetailCase.case_type__c == 'Request_POS_Withdrawal' || getdetailCase.case_type__c == 'Request_POS_Redemption' || getdetailCase.case_type__c == 'Request_POS_Surrender_Non_UL' || getdetailCase.case_type__c == 'Request_POS_Surrender_Endowment')){
                theBodyJSON.writeObjectField('Q1',string.isnotblank(getDetailSurvey.Answer_1__c) ? getDetailSurvey.Answer_1__c : '');
                theBodyJSON.writeObjectField('Q2',string.isnotblank(getDetailSurvey.Answer_2__c) ? getDetailSurvey.Answer_2__c : '');
                theBodyJSON.writeObjectField('Q3',string.isnotblank(getDetailSurvey.Answer_3__c) ? getDetailSurvey.Answer_3__c : '');
                theBodyJSON.writeObjectField('Q4',string.isnotblank(getDetailSurvey.Answer_4__c) ? getDetailSurvey.Answer_4__c : '');
                theBodyJSON.writeObjectField('Q5',string.isnotblank(getDetailSurvey.Answer_5__c) && (getDetailSurvey.Answer_1__c == 'Financial Advisor' || getDetailSurvey.Answer_1__c == 'Life Planner') ? getDetailSurvey.Answer_5__c : '');
                theBodyJSON.writeObjectField('Q6',string.isnotblank(getDetailSurvey.Answer_6__c) ? getDetailSurvey.Answer_6__c : '');
                theBodyJSON.writeObjectField('Q7',string.isnotblank(getDetailSurvey.Answer_7__c) ? getDetailSurvey.Answer_7__c : '');
                theBodyJSON.writeObjectField('Agent_Code', getdetailCase.Contact.Agent_Role_Code__c);
            }else if(getdetailCase.Entity__c == 'AMFS' && getdetailCase.Type == 'Complaint'){
                theBodyJSON.writeObjectField('Q1',string.isnotblank(getDetailSurvey.Answer_1__c) ? getDetailSurvey.Answer_1__c : '');
                theBodyJSON.writeObjectField('Q2',string.isnotblank(getDetailSurvey.Answer_2__c) ? getDetailSurvey.Answer_2__c : '');
                theBodyJSON.writeObjectField('Q3',string.isnotblank(getDetailSurvey.Answer_3__c) ? getDetailSurvey.Answer_3__c : '');
                theBodyJSON.writeObjectField('Q4',string.isnotblank(getDetailSurvey.Answer_4__c) ? getDetailSurvey.Answer_4__c : '');
                theBodyJSON.writeObjectField('Q5',string.isnotblank(getDetailSurvey.Answer_5__c) ? getDetailSurvey.Answer_5__c : '');
            }else if(getdetailCase.Entity__c == 'AMFS' && getdetailCase.Type == 'Inquiry'){
                theBodyJSON.writeObjectField('Q1',string.isnotblank(getDetailSurvey.Answer_1__c) ? getDetailSurvey.Answer_1__c : '');
                theBodyJSON.writeObjectField('Q2',string.isnotblank(getDetailSurvey.Answer_2__c) ? getDetailSurvey.Answer_2__c : '');
                theBodyJSON.writeObjectField('Q3',string.isnotblank(getDetailSurvey.Answer_3__c) ? getDetailSurvey.Answer_3__c : '');
                theBodyJSON.writeObjectField('Q4',string.isnotblank(getDetailSurvey.Answer_4__c) ? getDetailSurvey.Answer_4__c : '');
                theBodyJSON.writeObjectField('Q5',string.isnotblank(getDetailSurvey.Answer_5__c) ? getDetailSurvey.Answer_5__c : '');
                theBodyJSON.writeObjectField('Q6',string.isnotblank(getDetailSurvey.Answer_6__c) ? getDetailSurvey.Answer_6__c : '');
            }else{
                theBodyJSON.writeObjectField('Q1',string.isnotblank(getDetailSurvey.Answer_1__c) ? getDetailSurvey.Answer_1__c : '');
                theBodyJSON.writeObjectField('Q2_0_Kemudahan',string.isnotblank(getDetailSurvey.Answer_2__c) ? getDetailSurvey.Answer_2__c : '');
                theBodyJSON.writeObjectField('Q2_11_Kecepatan',string.isnotblank(getDetailSurvey.Answer_3__c) ? getDetailSurvey.Answer_3__c : '');
                theBodyJSON.writeObjectField('Q3',string.isnotblank(getDetailSurvey.Answer_4__c) ? getDetailSurvey.Answer_4__c : '');
                theBodyJSON.writeObjectField('Q4',string.isnotblank(getDetailSurvey.Answer_5__c) ? getDetailSurvey.Answer_5__c : '');
                if(getdetailCase.case_type__c != 'Request_Claim_Payment'  ||  getdetailCase.type == 'Complaint') theBodyJSON.writeObjectField('Q5',string.isnotblank(getDetailSurvey.Answer_6__c) ? getDetailSurvey.Answer_6__c : '');
            }
            // get information user
            theBodyJSON.writeObjectField('Channel',string.isnotblank(getDetailSurvey.Email_Sms_Log__c) ? getDetailSurvey.Email_Sms_Log__r.Type__c : '');
            // theBodyJSON.writeObjectField('Type','0');
            theBodyJSON.writeObjectField('Type',string.isnotblank(getdetailCase.type) ? getdetailCase.type : '');
            theBodyJSON.writeObjectField('MoT',string.isnotblank(getdetailCase.mot__c) ? getdetailCase.mot__c : '');
            theBodyJSON.writeObjectField('Case_Type',string.isnotblank(getdetailCase.case_type__c) ? getdetailCase.case_type__c : '');
            // theBodyJSON.writeObjectField('Case_Id',getdetailCase.Casenumber);
            //theBodyJSON.writeObjectField('Response_ID',getdetailCase.Casenumber);
            theBodyJSON.writeObjectField('Response_ID', string.isnotblank(getDetailSurvey.SurveyTaker__c) ? getDetailSurvey.SurveyTaker__r.Name : '');
            theBodyJSON.writeObjectField('External_Reference',getdetailCase.Casenumber);
            //theBodyJSON.writeObjectField('ICF_Id', string.isnotblank(getDetailSurvey.SurveyTaker__c ) ? getDetailSurvey.SurveyTaker__r.Name : '');
            //theBodyJSON.writeObjectField('External_Reference', string.isnotblank(getDetailSurvey.SurveyTaker__c) ? getDetailSurvey.SurveyTaker__r.Name : '');
            
            theBodyJSON.writeObjectField('User_Language','ID');
            theBodyJSON.writeObjectField('Response_Type','');  
            theBodyJSON.writeObjectField('IP_Address','');  
            theBodyJSON.writeObjectField('Progress','');  
            theBodyJSON.writeObjectField('Location_Latitude','');   
            theBodyJSON.writeObjectField('Location_Longitude','');              
            theBodyJSON.writeObjectField('Finished',true); 
            theBodyJSON.writeObjectField('Duration',0); 
            
            // get data contact
            theBodyJSON.writeObjectField('Recipient_Last_Name',''); 
            theBodyJSON.writeObjectField('Recipient_First_Name',''); 
            theBodyJSON.writeObjectField('Recipient_Email','');  
            
            theBodyJSON.writeEndObject();
            body = theBodyJSON.getAsString();
            req.setBody(body); 
            system.debug('body:'+body);  
            httpResponse res = new httpResponse();
            //Updated by Dimas Support MII 17/04/2025, added condition to able/disable send JSON to Qualtrics
            if (configSendQualtrics == true){
                if (!System.Test.isrunningtest()) res = h.send(req);   
                responseCode = string.valueof(res.getStatusCode());
                response = res.getBody(); 
                message = responseCode == '200' ? 'Success' : 'Error';
            } else {
                responseCode = '0';
                response = 'Send Request to Qualtrics is disabled. Please contact System Administration for more info!';
                message = 'Cancelled';
            }
        } catch (exception err) { 
            message = 'Error: '+err.getMessage();
            message += ', Line: '+err.getLineNumber();
        }
        
        if (String.isnotblank(getDetailSurvey.Email_Sms_Log__c)) {
            Email_Sms_Log__c getDetailLog = [SELECT Id, Qualtrics_URL__c, Qualtrics_Request__c, Qualtrics_Body__c, Qualtrics_Message__c, Qualtrics_Code__c FROM Email_SMS_Log__c where id =: getDetailSurvey.Email_Sms_Log__c];
            
            getDetailLog.Qualtrics_URL__c = url;
            getDetailLog.Qualtrics_Request__c = body;
            getDetailLog.Qualtrics_Body__c = response;
            getDetailLog.Qualtrics_Code__c = responseCode;
            getDetailLog.Qualtrics_Message__c = message;
            
            update getDetailLog;
       
        }
        
    }
    
    @future(callout=true)
    public static void sendSurveyNewCustomer(string esl_id, string surveyResponseId, string AgentCode) {
        Survey_Response__c getDetailSurvey = [SELECT Id, CreatedDate, LastModifiedDate, Answer_1__c, Answer_2__c, Answer_3__c, Answer_4__c, 
                                              Answer_5__c, Answer_6__c, Answer_7__c, Answer_8__c, Answer_9__c, Answer_10__c, Email_Sms_Log__c,
                                              Email_Sms_Log__r.Type__c, SurveyTaker__c , SurveyTaker__r.Name 
                                              FROM Survey_Response__c where id =: surveyResponseId];
        
        String message = '';
        String url = '';
        string body  = '';
        String response = '';
        string responseCode = '';
        
        try {
            
            String baseUrl = label.AMFS_Qualtrics_baseUrl;
            string idpSource = label.AMFS_Qualtrics_NewCust_idpsourceid;
            string endpoint = label.AMFS_Qualtrics_import_survey;
            string token = label.AMFS_Qualtrics_apiKey;
            
            endpoint = endpoint.replace( '[IDPSOURCE]', idpSource);
             
            url = label.AMFS_Qualtrics_baseUrl+endpoint;
            
            //Added by Dimas Support MII 17/04/2025
            Boolean configSendQualtrics = Boolean.valueof(System.Label.Config_Send_Qualtrics);
            
            system.debug('endpoint:'+endpoint);
            HTTP h = new HTTP();
            HTTPRequest req = new HTTPRequest();
            req.setEndPoint(url);
            req.setMethod('POST'); 
            
            // header
            req.setHeader('X-API-TOKEN',token); 
            req.setHeader('Content-Type','application/json'); 
            req.setHeader('Accept','application/json'); 
            
            
            // body
            JSONGenerator theBodyJSON = JSON.createGenerator(true); 
            theBodyJSON.writeStartObject();
            // get survey
            theBodyJSON.writeObjectField('Created_Date',convertDate(getDetailSurvey.CreatedDate)); 
            theBodyJSON.writeObjectField('Start_Date',convertDate(getDetailSurvey.CreatedDate)); 
            theBodyJSON.writeObjectField('End_Date',convertDate(getDetailSurvey.CreatedDate)); 
            theBodyJSON.writeObjectField('Recorded_Date',convertDate(getDetailSurvey.CreatedDate)); 
            
            // response
            theBodyJSON.writeObjectField('Q1',string.isnotblank(getDetailSurvey.Answer_1__c) ? getDetailSurvey.Answer_1__c : '');
            theBodyJSON.writeObjectField('Q2',string.isnotblank(getDetailSurvey.Answer_2__c) ? getDetailSurvey.Answer_2__c : '');
            theBodyJSON.writeObjectField('Q2_lainnya',string.isnotblank(getDetailSurvey.Answer_3__c) ? getDetailSurvey.Answer_3__c : '');
            theBodyJSON.writeObjectField('Q3',string.isnotblank(getDetailSurvey.Answer_4__c) ? getDetailSurvey.Answer_4__c : '');
            theBodyJSON.writeObjectField('Q4',string.isnotblank(getDetailSurvey.Answer_5__c) ? getDetailSurvey.Answer_5__c : '');
            theBodyJSON.writeObjectField('Q5',string.isnotblank(getDetailSurvey.Answer_6__c) ? getDetailSurvey.Answer_6__c : '');
            theBodyJSON.writeObjectField('Q6',string.isnotblank(getDetailSurvey.Answer_7__c) ? getDetailSurvey.Answer_7__c : '');

            
            // get information user
            theBodyJSON.writeObjectField('Channel',string.isnotblank(getDetailSurvey.Email_Sms_Log__c) ? getDetailSurvey.Email_Sms_Log__r.Type__c : '');
            theBodyJSON.writeObjectField('Type','Request');
            theBodyJSON.writeObjectField('MoT','I Buy');
            theBodyJSON.writeObjectField('Agent_code', AgentCode);
            theBodyJSON.writeObjectField('Response_ID', string.isnotblank(getDetailSurvey.SurveyTaker__c) ? getDetailSurvey.SurveyTaker__r.Name : '');
            
            theBodyJSON.writeObjectField('User_Language','ID');
            theBodyJSON.writeObjectField('Response_Type','');  
            theBodyJSON.writeObjectField('IP_Address','');  
            theBodyJSON.writeObjectField('Progress','');  
            theBodyJSON.writeObjectField('Location_Latitude','');   
            theBodyJSON.writeObjectField('Location_Longitude','');              
            theBodyJSON.writeObjectField('Finished',true); 
            theBodyJSON.writeObjectField('Duration',0); 
            
            // get data contact
            theBodyJSON.writeObjectField('Recipient_Last_Name',''); 
            theBodyJSON.writeObjectField('Recipient_First_Name',''); 
            theBodyJSON.writeObjectField('Recipient_Email','');  
            
            theBodyJSON.writeEndObject();
            body = theBodyJSON.getAsString();
            req.setBody(body); 
            system.debug('body:'+body);  
            httpResponse res = new httpResponse(); 
            //Updated by Dimas Support MII 17/04/2025, added condition to able/disable send JSON to Qualtrics
            if (configSendQualtrics == true){
                if (!System.Test.isrunningtest()) res = h.send(req);   
                responseCode = string.valueof(res.getStatusCode());
                response = res.getBody(); 
                message = responseCode == '200' ? 'Success' : 'Error';
            } else {
                responseCode = '0';
                response = 'Send Request to Qualtrics is disabled. Please contact System Administration for more info!';
                message = 'Cancelled';
            }
        } catch (exception err) { 
            message = 'Error: '+err.getMessage();
            message += ', Line: '+err.getLineNumber();
        }
        
        Email_SMS_Log__c esl  = [Select id, mot__c, Qualtrics_URL__c, Qualtrics_Request__c, Qualtrics_Body__c, Qualtrics_Message__c, Qualtrics_Code__c, contact__r.Agent_Role_Code__c from Email_SMS_Log__c where id =: esl_id];
        if (String.isnotblank(esl.Id)) {
            
            esl.Qualtrics_URL__c = url;
            esl.Qualtrics_Request__c = body;
            esl.Qualtrics_Body__c = response;
            esl.Qualtrics_Code__c = responseCode;
            esl.Qualtrics_Message__c = message;
            
            update esl;
       
        }
        
    }
    
    public static string convertDate(datetime dateVal) { 
		string convertDate = '';
        System.debug('dateVal:'+dateVal);
        if (dateVal != null) { 
            dateVal = dateVal.addHours(7);
            System.debug('dateVal:'+dateVal);
            
            convertDate = dateVal.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''); 
        }        
        
        return convertDate;
    }
}