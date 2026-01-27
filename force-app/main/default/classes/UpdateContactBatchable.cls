global class UpdateContactBatchable implements Database.Batchable<sObject>, Database.stateful{

   Integer i=0;
   Integer succeedToUpdated=0;
   Datetime startProcess;
   Boolean isFromUpload = false;
   public String userId='';
   Map<String, CustomerSegmentation> cusSegMap = new Map<String, CustomerSegmentation>();
   List<Contact> tempCTList;
   String header='Policy No, Cust Segmentation, Remarks \n';
   String validStrAttachment=header;
   String invalidStrAttachment=header;
   String[] emailAddress = System.LABEL.Email_Address_Notif.split('\\|\\|');
   Call_List__c campaign;
    
   // variable for call liner
   List<String> listOfPolicy = new LIST<String>();
   List<Contact> CLContactList = new List<Contact>();
   Set<Id> contactIds = new Set<Id>();

  	public UpdateContactBatchable(Map<String, CustomerSegmentation> csMap, Boolean isFromUpload, Id userId, 
                                  Call_List__c campaign){
        cusSegMap = csMap == null ? new Map<String, CustomerSegmentation>() : csMap;
        this.isFromUpload = isFromUpload ? isFromUpload : false;
        this.userId = userId;
        this.startProcess = Datetime.now();
		this.campaign = campaign == null ? new Call_List__c() : campaign;
        tempCTList = new List<Contact>();
    }
   
   global Database.QueryLocator start(Database.BatchableContext BC){
       String query='';
       if(!isFromUpload){
           query = 'Select id, Cust_Segmentation__c, policy_no__c from Contact where Entity__c = \'AMFS\' AND Cust_Segmentation__c != \'Regular\'';
       } else {
           Set<String> policyNo = new Set<String>(cusSegMap.keySet());
           query = 'Select id, Cust_Segmentation__c, policy_no__c, MobilePhone, HomePhone, Phone, entity__c ' +
               ' from Contact where policy_No__c in : policyNo';
       }
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Contact> scope){
       List<Database.SaveResult> savedResult = new List<Database.SaveResult>();
       listOfPolicy = new LIST<String>();
       CLContactList = new List<Contact>();
       try{
           //tempCTList.addAll(scope);
           for(Contact ct : scope){
                if(!isFromUpload){
                 ct.Cust_Segmentation__c = 'Regular';
                } else {
                    try{
                        CustomerSegmentation custSeg = cusSegMap.get(ct.Policy_No__c);
                        custSeg.contactId = ct.Id;
                       	ct.Cust_Segmentation__c = custSeg.custSegmentation.trim();
                        
                        listOfPolicy.add(ct.Policy_No__c);
                        CLContactList.add(ct);
                    } catch (Exception e){
                        System.debug('ERROR LOG : '+e);
                        CustomerSegmentation custSeg = cusSegMap.get(ct.Policy_No__c);
						custSeg.errorMessage = (custSeg.errorMessage == null ? '' : custSeg.errorMessage) + e.getMessage();
                        cusSegMap.put(ct.Policy_No__c, custSeg);
                    }
                }
               tempCTList.add(ct);
           }
           
       	   i = i + scope.size();
           savedResult = Database.update(scope, false);
            for(Database.SaveResult result : savedResult){
                if(!result.isSuccess()){
                    System.debug('failed '+result);
                } else {
                    succeedToUpdated = succeedToUpdated + 1;
                   	System.debug('success '+result);
                }
            }
           
           if(isFromUpload){
               // populate then save/update call liner;
               System.debug('===call liner processing===');
               populateCallLiner();
           }
       } catch(Exception e){
           System.debug('===ERROR LOG=== '+e);
       }
    }

   global void finish(Database.BatchableContext BC){
       try {
           
           //count open cases.
       if(isFromUpload){
            RmToolsCall rc = new RmToolsCall();
            rc.populateAndUpdateCallLiner(contactIds);
       }
           
           if(!cusSegMap.isEmpty()){
               i = cusSegMap.size();
           }
           
           User userLogin = [Select id, name, Email from User where id =: userId];
           sendMail(userLogin);
           System.debug('size datas '+i);
           
       } catch( Exception e){
           System.debug('===ERROR LOG==='+e);
       }
   }
    //construct string for a csv
    private void createAttachment(){
        System.debug('tempCTList '+tempCTList);
        for(Contact ct: tempCTList) {
               CustomerSegmentation cseg = cusSegMap.get(ct.policy_no__c);
            if(cseg != null && cseg.errorMessage == null){
               string recordString = '"'+ct.policy_no__c+'","'+ct.Cust_Segmentation__c+'","'+'Success'+'"\n';
               validStrAttachment = validStrAttachment +recordString;
               cusSegMap.remove(ct.policy_no__c);
            }
		}
        for(CustomerSegmentation cseg : cusSegMap.values()){
            String remarks = '';
            if(cseg.contactId == null){
                remarks = cseg.policyNo + ' does not have contact data.';
            } else {
                remarks = 'bad value for restricted picklist field : '+cseg.custSegmentation;
            }
           string recordString = '"'+cseg.policyNo+'","'+cseg.custSegmentation+'","'+remarks+'"\n';
           invalidStrAttachment = invalidStrAttachment +recordString;        
        }
    }
    
    // Method to construct Email with file attachment
    public void sendMail( User usr){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] to = new String[] {usr.Email};
        String subject = '';
        String strStartProcess = startProcess.format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
        
        if(isFromUpload){
            subject = 'Upload Customer Segmentation ';
            //construct string attachment to email file attachment
            createAttachment();
            Messaging.EmailFileAttachment csvCt = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(validStrAttachment);
            string csvname= 'Valid.csv';
            csvCt.setFileName(csvname);
            csvCt.setBody(csvBlob);
            
            Messaging.EmailFileAttachment invAtt = new Messaging.EmailFileAttachment();
            blob invAttBlob = Blob.valueOf(invalidStrAttachment);
            string invAttname= 'Invalid.csv';
            invAtt.setFileName(invAttname);
            invAtt.setBody(invAttBlob);
            
            email.setHtmlBody('Hello '+usr.Name +', <br/><br/>'+
                              +' Customer Segmentation process has been finished. <br/>'+
                              +' Here\'s the details : <br/>'+
                              +'       # Total Contact 				: '+i+'<br/>'+
                              +'       # Updated Contact 			: '+succeedToUpdated+'<br/>'+
                              +'       # Failed to update Contact 	: '+(i-succeedToUpdated)+
                              +'<br/><br/>Regards<br/> Developer');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvCt, invAtt});
        } else {
            subject = 'Reset Customer Segmentation ';
            email.setHtmlBody('Hello '+usr.Name +', <br/><br/>'+
                              +' Reset Customer Segmentation become REGULAR process has been finished. <br/>'+
                              +' Here\'s the details : <br/>'+
                              +'       # Total Contact 				: '+i+'<br/>'+
                              +'       # Updated Contact 			: '+succeedToUpdated+'<br/>'+
                              +'       # Failed to update Contact 	: '+(i-succeedToUpdated)+
                              +'<br/><br/>Regards<br/> Developer');
        }
        
        email.setToAddresses(to);
        if(!emailAddress.isEmpty()){
            email.setCCAddresses(emailAddress);
        }
        email.setSubject(subject+strStartProcess);
        
        try{
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }catch(exception e){
            apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
        }
    }
    
    // Create or update call liner 
    private void populateCallLiner(){
        try{
            ID rtCallLinerRmId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Call Line Customer Segmentation').getRecordTypeId();
           List<Call_Line__c> newOrUpdatedCLList = new List<Call_Line__c>();
            
           List<Call_Line__c> existingCallLineList = [select id, Policy_No__c, Entity__c 
                                                       from Call_Line__c where Policy_No__c in :listOfPolicy 
                                                       and Call_List__c = : campaign.Id 
                                                       and createddate > 2014-01-01T00:00:01Z];
            for(Contact ct : CLContactList){
                Call_Line__c call_Liner = new Call_Line__c();
                for(Call_line__c CL : existingCallLineList){
                    if(CL.Policy_No__c == ct.Policy_No__c){
                        //existing call liner will be updated;
                        call_liner = CL;
                        break;
                    }
                }
                call_liner.Contact__c = ct.id;
                call_liner.Policy_No__c = ct.Policy_No__c;
                call_liner.Contacted_Number__c = ct.MobilePhone;
                call_liner.Home_Phone__c = ct.HomePhone;
                call_liner.Phone__c = ct.Phone;
                call_liner.Entity__c = ct.Entity__c;
                call_liner.Call_List__c = campaign.Id;
                call_liner.Activity__c = campaign.Activity__c;
                call_liner.Case_Type__c = campaign.Case_Type__c; 
                call_liner.Case_Type_Config__c = campaign.Case_Type_Config__c;
                call_Liner.RecordTypeId = rtCallLinerRmId;
            
            	newOrUpdatedCLList.add(call_liner);
                contactIds.add(ct.Id);
            }
            upsert (newOrUpdatedCLList);
        } catch(Exception e){
            System.debug('===Exception when create/update call liner=== '+e);
        }
    }
}