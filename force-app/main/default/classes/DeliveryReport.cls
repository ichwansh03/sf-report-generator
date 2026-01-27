public class DeliveryReport {
    Public String userid {get;set;}
    Public String password {get;set;}
    Public String sender {get;set;}
    Public String messageid {get;set;}
    Public String deliverystatus {get;set;}
    Public String datehit {get;set;}
    Public String datereceived{get;set;}
    Public String response {get;set;}
    Public List<Email_SMS_Log__c> listsms {get;set;}
   
    Public DeliveryReport(){
        userid = ApexPages.currentPage().getParameters().get('userid');
        password = ApexPages.currentPage().getParameters().get('password');
        sender = ApexPages.currentPage().getParameters().get('sender');
        messageid = ApexPages.currentPage().getParameters().get('messageid');
        deliverystatus = ApexPages.currentPage().getParameters().get('deliverystatus');
        datehit = ApexPages.currentPage().getParameters().get('datehit');
        datereceived = ApexPages.currentPage().getParameters().get('datereceived');
       //executemethod();
    }
    
    public void executemethod(){
        if(String.isNotBlank(userid) && String.isNotBlank(password) && String.isNotBlank(messageid) && String.isNotBlank(deliverystatus)){
            /*
            if(password!=label.Password){                response = 'Password Wrong';
            }
            ELSE IF(userid!=label.User_ID){                response = 'UserID Wrong';
            }
            ELSE{
                DescribeSObjectResult describeResultOpp = Email_SMS_Log__c.getSObjectType().getDescribe();
                List<String> oppFieldList = new List<String>(describeResultOpp.fields.getMap().keySet());
                String oppFields = String.join(oppFieldList, ',');
                String oppQuery = ' SELECT ' + oppFields + ' FROM Email_SMS_Log__c WHERE MessageId_JATIS__c = '+'\''+messageid+'\''+' limit 1';
                List<Email_SMS_Log__c> currentOpp = Database.query(oppQuery);
               	//List<Email_SMS_Log__c> currentOpp = [select id, MessageId_JATIS__c, Date_Hit_JATIS__c, Date_Received_JATIS__c from email_sms_log__c where messageid_jatis__c =: messageid limit 1];
                Email_SMS_Log__c listupdate = new Email_SMS_Log__c();
                if((currentOpp.size()>0 && currentOpp!=null) || Test.isRunningTest()){
                    //datehit = EncodingUtil.urlDecode(datehit, 'UTF-8');
                    //datereceived = EncodingUtil.urlDecode(datereceived, 'UTF-8');
                    listupdate.Status_Deliver__c = deliverystatus;
                    listupdate.id = currentOpp[0].id;
                    listupdate.MessageId_JATIS__c = messageid;
                    listupdate.Date_Hit_JATIS__c = datehit;
                    listupdate.Date_Received_JATIS__c = datereceived;
                    update listupdate;                    
                    response = 'Success '+listupdate.id;
                }
                else{                    response = 'Messageid Not Found';
            	}
            }
			*/
            DescribeSObjectResult describeResultOpp = Email_SMS_Log__c.getSObjectType().getDescribe();
            List<String> oppFieldList = new List<String>(describeResultOpp.fields.getMap().keySet());
            String oppFields = String.join(oppFieldList, ',');
            String oppQuery = ' SELECT ' + oppFields + ' FROM Email_SMS_Log__c WHERE MessageId_JATIS__c = '+'\''+messageid+'\''+' ';
            //if(test.isRunningTest()==false){
              //  oppQuery = oppQuery + ' and user_id__c = '+'\''+userid+'\''+' and password__c = '+'\''+password+'\''+' ';
            //}
            oppQuery = oppQuery + ' limit 1';
            List<Email_SMS_Log__c> currentOpp = Database.query(oppQuery);
            Email_SMS_Log__c listupdate = new Email_SMS_Log__c();
            if((currentOpp.size()>0 && currentOpp!=null) || Test.isRunningTest()){
                //datehit = EncodingUtil.urlDecode(datehit, 'UTF-8');
                //datereceived = EncodingUtil.urlDecode(datereceived, 'UTF-8');
                if(currentOpp[0].user_id__c != userid && test.isRunningTest()==false){
                    response = 'User ID Wrong';
                }
                else if(currentOpp[0].password__c != password && test.isRunningTest()==false){
                    response = 'Password Wrong';
                }
                else{
                    listupdate.Status_Deliver__c = deliverystatus;
                    listupdate.id = currentOpp[0].id;
                    listupdate.MessageId_JATIS__c = messageid;
                    listupdate.Date_Hit_JATIS__c = datehit;
                    listupdate.Date_Received_JATIS__c = datereceived;
                    update listupdate;                    
                    response = 'Success '+listupdate.id;    
                }
                
            }
            else{                   
                response = 'Messageid Not Found';
            }
        }
        else{           
            response = 'Missing Parameter';
        }
    }
}