// Jatis Missing DR Report
Global class SchJAtisMissingDR implements Schedulable {

  public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    Global void execute(SchedulableContext ctx) {

        //OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE Address = 'noreply@axa-financial.co.id' LIMIT 1];
        OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE Address = 'catur.yuwono@axa.co.id' LIMIT 1];
        
        //DateTime myDate = DateTime.valueOf(String.Valueof(Date.Today().Year())+'-'+String.Valueof(Date.Today().Month())+'-01 05:04:25');
        
        List<Messaging.SingleEmailMessage> listmail = new List<Messaging.SingleEmailMessage>();
        EmailTemplate et = [SELECT Id, Subject, HtmlValue FROM EmailTemplate WHERE developerName  = 'ET_Reminder_Jatis_Missing_DR'];

        map<String,ICF_Parameter__c> jatisfield = new map<String,ICF_Parameter__c>();
        for (ICF_Parameter__c mt : [select id, name, entity__c, sender__c, division__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and sender__C != null]) {
            jatisfield.put(mt.entity__c, mt);
        }
        
        // data 7 Hari
        Date MyDate = Date.Today() - integer.valueof(label.Reminder_Interval);

//*
            //us = String.ValueOf(ar.get('Sales_Name_Incharge_Invoice__c'));
        // Kirim Opportunity yang sudah lewat 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          
            // // process the merge fields
            String subject = et.Subject;                                         
            String htmlBody = et.HtmlValue;

            Date DatePrev = Date.Today()-1;
            Date PeriodReminder = Date.Today();
            subject = subject.replace('{!Periode}',  String.ValueOf(PeriodReminder.Day())+'-'+String.valueof(PeriodReminder.Month())+'-'+String.ValueOf(PeriodReminder.Year()) );
            //htmlBody = htmlBody.replace('{!TanggalKunjungan}',  String.ValueOf(DatePrev.Day())+' '+Utils.ToNamaBulan(DatePrev.Month())+' '+String.ValueOf(DatePrev.Year()) );

            // header table.
            String temphargaagent ='';
            string temp;
            temp = '<table border="1">';
            temp = temp+'<tr><th>MessageID Jatis</th><th>Date Hit</th><th>Sender</th><th>Entity</th><th>Division</th><th>Upload By</th></tr>';

            String tempEmail = '';
            id OwnerLast;
            String sendemail = '';
        List<Email_SMS_Log__c> listdata = new List<Email_SMS_Log__c>();
        if(Test.isRunningTest()){
            //listdata = [SELECT Id, MessageId_JATIS__c, Date_Hit_JATIS__c, Name, Entity__c FROM Email_SMS_Log__c WHERE Request_Date__c <: MyDate and MessageId_JATIS__c != NULL and Status_Deliver__c = NULL LIMIT 1];
            listdata = [SELECT Id, MessageId_JATIS__c, Date_Hit_JATIS__c, Name, Entity__c FROM Email_SMS_Log__c LIMIT 1];
        }else{
            listdata = [SELECT Id, MessageId_JATIS__c, Date_Hit_JATIS__c, Name, Entity__c FROM Email_SMS_Log__c WHERE Request_Date__c <: MyDate and MessageId_JATIS__c != NULL and Status_Deliver__c = NULL LIMIT 50000];
        }
        
        if(listdata.size()>0){
            
            for (Email_SMS_Log__c data : listdata) {
//                subject = subject.replace('{!Task.Daily_Number__c}',  data.Daily_Number__c);
                // jika awal,  
                string sender2 = '';
                if (jatisfield.get(data.Entity__c) == NULL) sender2 = label.Sender;
                else sender2 = jatisfield.get(data.Entity__c).Sender__c;

                string division2 = '';
                if (jatisfield.get(data.Entity__c) == NULL) division2 = label.Division;
                else Division2 = jatisfield.get(data.Entity__c).Division__c;
                
                temp = temp+'<tr><td>'+data.MessageId_JATIS__c+'</td><td>'+data.Date_Hit_JATIS__c+'</td><td>'+sender2+'</td><td>'+data.Entity__c+'</td><td>'+division2+'</td><td>'+label.Uploadby+'</td></tr>';
            }
                temp = temp+'</table>';
            htmlBody = htmlBody.replace('{!DataTable}',temp);

            // jika pakai Wide Email address, setSenderDisplayName di hide, karena nama berdasarkan Wide Email Address
            mail.setOrgWideEmailAddressId(owe.Id);

//            if (us.Marketing__c == NULL)
//                mail.setTargetObjectId(us2.Id); //recipient
//            else
//                mail.setTargetObjectId(us.Marketing__r.id); //recipient
//            mail.setTargetObjectId(us2.Id); //recipient
            mail.setTargetObjectId(OwnerLast); //recipient

            // tambahkan CC, untuk check apakah sudah sesuai atau belum
            sendemail = Label.sendemailto;

            if (sendemail != 'FALSE') {
                sendemail = sendemail.left(sendemail.length()-1);
                //sendemail = sendemail.replace('null','');
                String[] CCEmails = sendemail.split(',');
                mail.setToAddresses(CCEmails);
            }
            // END == tambahkan CC, untuk check apakah sudah sesuai atau belum
            
            // tambahkan CC, untuk check apakah sudah sesuai atau belum
            sendemail = Label.sendemailcc;

            if (sendemail != 'FALSE') {
                sendemail = sendemail.left(sendemail.length()-1);
                //sendemail = sendemail.replace('null','');
                String[] CCEmails = sendemail.split(',');
                mail.setCcAddresses(CCEmails);
            }
            // END == tambahkan CC, untuk check apakah sudah sesuai atau belum
                        
            mail.setSubject(subject);
            mail.setHtmlBody(htmlBody);
            //mail.setTemplateId(et.Id);
            mail.setSaveAsActivity(false); 
     
            //Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            listmail.add(mail);
//*/
                
            Messaging.sendEmail(listmail);
        }
        
        system.debug('## Send '+listdata.size());
        
    } // end execute
} // end class