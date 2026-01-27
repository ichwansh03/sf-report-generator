public class NotifyAssignTaskAMFS { 
    Public static List<String> SendEmail (String taskId, string typeCase) {  
        List<String> returnEmail = new List<String>();  
 
        List<Messaging.SingleEmailMessage> listEmail = new List<Messaging.SingleEmailMessage>(); 
        EmailTemplate et = new EmailTemplate();
		// EmailTemplate et = [SELECT Id, HtmlValue, Subject FROM EmailTemplate WHERE name = 'ET - AMFS - Reminder Task Welcome Call &  CR'];
        // template email
       if(taskId != NULL && taskId.left(3) == Schema.SObjectType.Call_Line__c.getKeyPrefix()){  
            et = [SELECT Id, name, HtmlValue, Subject FROM EmailTemplate  where name = 'ET - AMFS - Reminder Task Welcome Call &  CR']; 
        } 
        
        if(taskId != NULL && taskId.left(3) == Schema.SObjectType.Case.getKeyPrefix()){ 
            et = [SELECT Id, name, HtmlValue, Subject FROM EmailTemplate WHERE name = 'ET - AMFS - Reminder Task Welcome Call &  CR 2'];
        }
        
        Boolean isAlreadySet = false;
        //replace htmlbody email
        String htmlbody = et.HtmlValue;
        String subject = et.Subject;
                
        string convertDate = '';
        List<string> convertDateArr = new List<string>();
        
        System.debug('convertDateArr:'+convertDateArr);
        string getDate = '';
        string getTime = '';
        
        List<string> getDateArr = new List<string>();
        List<string> getTimeArr = new List<string>();
        
        System.debug('getDateArr:'+getDateArr);
        System.debug('getTimeArr:'+getTimeArr);
        string getDay = '';
        string getMonth = '';
        string getYear = '';
         
        string getHour  = '';
        string getMinute = '';
        
        String convertDateStr = '';
        String convertTimeStr = '';
        
        String receiptMail = '';
        
        DateTime setDateTime = System.now(); 
        
        system.debug('et:'+et); 
          
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'noreply.general@axa-mandiri.co.id'];
        system.debug('owea:'+owea);
        
        List<Case> getDetails = new List<Case>();
        List<Call_Line__c> getDetail = new List<Call_Line__c>();
        if(taskId != NULL && taskId.left(3) == Schema.SObjectType.Call_Line__c.getKeyPrefix()){  
            
            system.debug('taskId:'+taskId);
            if (Test.isRunningTest()) {
                getDetail = [SELECT Id, Name, OwnerId, Owner.Name, owner.Email, case__c, case__r.Createddate, Contact__c, Contact__r.Policy_No__c, createdDate, WelcomeCall_Schedule_Date__c   FROM Call_Line__c Limit 1];
            } else {
                getDetail = [SELECT Id, Name, OwnerId, Owner.Name, owner.Email, case__c, case__r.Createddate, Contact__c, Contact__r.Policy_No__c, createdDate, WelcomeCall_Schedule_Date__c FROM Call_Line__c where id =: taskId limit 1];
            }   
            
            Call_Line__c detailCL = getDetail[0];
            
            receiptMail = detailCL.owner.Email;
            
            if (typeCase == 'Request') { 
                setDateTime = detailCL.case__r.Createddate;
            } else { 
                setDateTime = detailCL.WelcomeCall_Schedule_Date__c;
            }
              
            if (setDateTime != null) { 
                convertDate = String.valueOf(setDateTime);
                convertDateArr = convertDate.split(' ');
                
                System.debug('convertDateArr:'+convertDateArr);
                getDate = convertDateArr[0];
                getTime = convertDateArr[1];
                
                getDateArr = getDate.split('-'); 
                getTimeArr = getTime.split(':');
                
                System.debug('getDateArr:'+getDateArr);
                System.debug('getTimeArr:'+getTimeArr);
                getDay = getDateArr[2];
                getMonth = getDateArr[1];
                getYear = getDateArr[0];
                
                getHour  = getTimeArr[0];
                getMinute = getTimeArr[1];
                
                convertDateStr = getDay+'/'+getMonth+'/'+getYear;
                convertTimeStr = getHour+':'+getMinute; 
                
                
                System.debug('Detail:'+detailCL); 
                System.debug('Owner:'+detailCL.Owner.Name); 
                
                htmlbody = htmlbody.replace('[owner_name]', String.isnotblank(detailCL.Owner.Name) ? detailCL.Owner.Name : '');
                htmlbody = htmlbody.replace('[contact_policy_no]',  String.isnotblank(detailCL.Contact__r.Policy_No__c) ? detailCL.Contact__r.Policy_No__c : '' );
                htmlbody = htmlbody.replace('[callline_datecreated]',  convertDateStr);
                htmlbody = htmlbody.replace('[callline_timecreated]',  convertTimeStr);
                htmlbody = htmlbody.replace('[callline_url]',  System.label.SFDC_URL_AXA+taskId );
                htmlbody = htmlbody.replace('[callline_name]',  String.isnotblank(detailCL.Name) ? detailCL.Name : '' );
                isAlreadySet = true;
                
            }
        }  
        if (isAlreadySet == true) {
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject(subject);
            mail.setHtmlBody(htmlbody);
            mail.setTreatTargetObjectAsRecipient(false);
            mail.setTemplateId(et.Id); 
            mail.setOrgWideEmailAddressId(owea.get(0).Id);                                         
            list<string> toMail = new list<string>();  
            toMail.add(receiptMail);
            mail.setToAddresses(toMail);
            
            /* list<string> ccEmail = new list<string>();
            
            ccEmail.add('tesssmailproject@gmail.com');
            ccEmail.add('Ranggi.rakashiwi@axa-mandiri.co.id'); 
            mail.setCcAddresses(ccEmail);  */
            mail.setSaveAsActivity(false);
            listEmail.add(mail);
            system.debug('listEmail = '+listEmail); 
            
            if(!Test.isRunningTest()) Messaging.sendEmail(listEmail);  
        } 
        
        return returnEmail;
    }  
}