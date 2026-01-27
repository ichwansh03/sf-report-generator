// Sch Email & SMS dari Object Email & SMS Log
Global class SchEmailSMSLogDaily implements Schedulable {

  public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    Global void execute(SchedulableContext ctx) {

        OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE IsAllowAllProfiles = TRUE LIMIT 1];

        // ICF Parameter
        map<String,ICF_Parameter__c> mapICFParam = new map<String,ICF_Parameter__c>();
        
        String MASTER_EMAIL_SMS = 'Master_Email_SMS';
        String ACTIVE = 'Active';
        DescribeSObjectResult describeResultIcfParam = ICF_Parameter__c.getSObjectType().getDescribe();
        List<String> icfParamFieldList = new List<String>(describeResultIcfParam.fields.getMap().keySet());
        String icfParamFields = String.join(icfParamFieldList, ',');
        String icfParamQuery = ' SELECT ' + icfParamFields + ' FROM ICF_Parameter__c WHERE Record_Type_Name__c = :MASTER_EMAIL_SMS AND Status__c = :ACTIVE ';
        List<ICF_Parameter__c> icfParamList = Database.query(icfParamQuery);

        for (ICF_Parameter__c icf : icfParamList) {
            mapICFParam.put(icf.Entity__c, icf);
        }
        
        List<Messaging.SingleEmailMessage> listmail = new List<Messaging.SingleEmailMessage>();
        // EmailTemplate et = [SELECT Id, Subject, HtmlValue FROM EmailTemplate WHERE developerName  = 'ET_Task_Call_Control_Reminder'];

        // data 7 Hari ganti today.
        Date MyDate = Date.Today(); //+ 7;
        
        list<Email_SMS_Log__c> updatetsk = new list<Email_SMS_Log__c>();
        
        // load data Email_SMS_Log__c
        //Integer limitmanual = integer.valueof(label.SendICFLimit);
        Integer limitmanual = 1000;
        list<Email_SMS_Log__c> tsk2;
        if (label.ICFManualSend == 'TRUE')
            tsk2 = [SELECT id, Name, 
            Account__c, 
            Case__c, Case__r.Type, Case__r.NonPP__c,
            Contact__c, Contact__r.Email, 
            Email_SMS_Template__c, Email_SMS_Template__r.Subject__c, Email_SMS_Template__r.Email_Body__c, 
            Survey__c, Email_Text__c,
            Survey_URL__c, Survey_Type__c, Type__c,
            Description__c,
            Send_Admin_Flag__c, Use_Contact_Email__c, 
            Category__c, Email__c, End_Date__c, Entity__c, Policy_Number__c, Request_Date__c,
            Send_Flag__c, Start_Date__c, Status__c
                FROM Email_SMS_Log__c 
                WHERE Method__c = 'Email' and Send_Flag__c = TRUE and End_Date__c = NULL 
                    and Status__c != 'Cancel' 
                    and Status__c != 'Hold' and // added by MII at 17 05 24 
                Request_Date__c <=: MyDate //and Survey_URL__c != NULL
                //and Use_Contact_Email__c = TRUE
                order by Contact__c
                LIMIT :limitmanual
                ];
        else
            tsk2 = [SELECT id, Name, 
            Account__c, 
            Case__c, Case__r.Type, Case__r.NonPP__c,
            Contact__c, Contact__r.Email, 
            Email_SMS_Template__c, Email_SMS_Template__r.Subject__c, Email_SMS_Template__r.Email_Body__c, 
            Survey__c, Email_Text__c,
            Survey_URL__c, Survey_Type__c, Type__c,
            Description__c,
            Send_Admin_Flag__c, Use_Contact_Email__c,
            Category__c, Email__c, End_Date__c, Entity__c, Policy_Number__c, Request_Date__c,
            Send_Flag__c, Start_Date__c, Status__c
                FROM Email_SMS_Log__c 
                WHERE Method__c = 'Email' and Send_Flag__c = TRUE and End_Date__c = NULL 
                    and Status__c != 'Cancel' 
                    and Status__c != 'Hold' and // added by MII at 17 05 24
                Request_Date__c <=: MyDate //and Survey_URL__c != NULL
                //and Use_Contact_Email__c = TRUE
                order by Contact__c
        ];
        
        List<ID> ContactID = new List<ID>();
        string temp = '';
        for (integer i=0; i < tsk2.size(); i++){
            
            if (temp != string.valueof(tsk2[i].Contact__c)) {
                ContactID.add(tsk2[i].Contact__c);
                temp = string.valueof(tsk2[i].Contact__c);
            }
        }

        Map<Id, Integer> MapContactCase = new Map<Id, Integer>();
        for (AggregateResult aggRes : [
              SELECT COUNT(ID) numApps, ContactId userId
              FROM Case
              WHERE Status != 'Closed' and 
              //Type != 'Inquiry' and 
              ContactID IN :ContactID 
              GROUP BY ContactId
        ]) {
            Id userId = (Id) aggRes.get('userId');
            Integer numApps = (Integer) aggRes.get('numApps');
            MapContactCase.put(userId, numApps);
        }
        
        boolean flagSendEmail = FALSE;
        String DescCancel = '';
        String ExcludeFrom = '';
        
        for (Email_SMS_Log__c tsk : tsk2)
        {
            system.debug('#tsk : '+tsk);
            flagSendEmail = TRUE;
            DescCancel = '';
            ExcludeFrom = '';

            // check ICF Parameter.
            if (mapICFParam.get(tsk.Entity__c) != NULL) {
                System.debug(LoggingLevel.DEBUG, '***ICF PARAM: ' + mapICFParam.get(tsk.Entity__c));
            
                // maret 2017, surveytype tidak dipakai, karena menggunakan Priority thanks note.
                /*
                String SurveyType = '';
                SurveyType = mapICFParam.get(tsk.Entity__c).Exclude_Survey_Type__c;
                //tsk.AddError('Test '+SurveyType);
                if (SurveyType != NULL && tsk.Survey_Type__c != NULL)
                if (SurveyType.contains(tsk.Survey_Type__c) && tsk.Category__c == 'Thanks Note') {
                    flagSendEmail = FALSE;
                    DescCancel += 'ICF Parameter '+tsk.Survey_Type__c+' is Exclude; ';
                    ExcludeFrom = tsk.Survey_Type__c;
                }
                */
                // Taufik, 14 June 2021, update != 'Thanks Note, menjadi == 'ICF'
                // if ((tsk.Category__c != 'Thanks Note') && (mapICFParam.get(tsk.Entity__c).Dont_Send_if_Have_any_Case_Open__c) && (tsk.Case__r.NonPP__c != TRUE))
                if ((tsk.Category__c == 'ICF') && (mapICFParam.get(tsk.Entity__c).Dont_Send_if_Have_any_Case_Open__c) && (tsk.Case__r.NonPP__c != TRUE)) {
                    if (MapContactCase.get(tsk.Contact__c) != NULL) {
                        if (MapContactCase.get(tsk.Contact__c) > 0) {
                            DescCancel += 'Policy have '+MapContactCase.get(tsk.Contact__c)+' open Case; '; ExcludeFrom = 'Have Open Case'; flagSendEmail = FALSE;
                        }
                    }
                }
                
                // priority Thanks note.
                if ((tsk.Category__c == 'Thanks Note') && (tsk.Case__r.Type != mapICFParam.get(tsk.Entity__c).Case_Priority__c) && (mapICFParam.get(tsk.Entity__c).Case_Priority__c != '')) {
                            DescCancel += 'Case Priority TN; '; ExcludeFrom = 'Case Priority TN'; flagSendEmail = FALSE;
                }
            }
            else {
                ICF_Parameter__c icfParam = mapICFParam.get('General');
                if (icfParam != null) {
                    if (mapICFParam.get('General').Exclude_Survey_Type__c.contains(tsk.Survey_Type__c) ) {
                        flagSendEmail = FALSE; DescCancel += 'ICF Parameter '+tsk.Survey_Type__c+' is Exclude; '; ExcludeFrom = tsk.Survey_Type__c;
                    }
                    
                    // Taufik, 14 June 2021, update != 'Thanks Note, menjadi == 'ICF'
                    // if ((tsk.Category__c != 'Thanks Note') &&
                    if ((tsk.Category__c == 'ICF') &&
                        (mapICFParam.get('General').Dont_Send_if_Have_any_Case_Open__c) ) {
                        if (MapContactCase.get(tsk.Contact__c) != NULL) {
                            if (MapContactCase.get(tsk.Contact__c) > 0) {
                                DescCancel += 'Policy have '+MapContactCase.get(tsk.Contact__c)+' open Case; '; ExcludeFrom = 'Have Open Case'; flagSendEmail = FALSE;
                            }
                        }
                    }
                }
                
            }
            
            //if (tsk.Category__c != 'ICF' && tsk.Category__c != 'Thanks Note') flagSendEmail = TRUE;
            // all ICF di kirim, hanya thanks note yang tidak dikirim.
            //if (tsk.Category__c != 'Thanks Note') flagSendEmail = TRUE;
            
            // check ThanksNote, hanya di kirim yang Priority saja.
            
            if (flagSendEmail) {
//*
        // Kirim Opportunity yang sudah lewat 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          
            // // process the merge fields
            String subject = tsk.Email_SMS_Template__r.Subject__c;
                                         
            //String htmlBody = tsk.Email_SMS_Template__r.Email_Body__c;
            String htmlBody = tsk.email_text__c;
            System.debug('#htmlbody : '+htmlBody);
            
            //if (tsk.Survey_URL__c != NULL)
                //htmlBody = htmlBody.replace('[SURVEY_LINK]', tsk.Survey_URL__c );
            //Date DatePrev = Date.Today()-1;
            //htmlBody = htmlBody.replace('{!TanggalKunjungan}',  String.ValueOf(DatePrev.Day())+' '+Utils.ToNamaBulan(DatePrev.Month())+' '+String.ValueOf(DatePrev.Year()) );

     
            // Step : Set who the email is sent from
//            mail.setReplyTo(us.Email);
//            mail.setReplyTo('sirdavid@bankofnigeria.com');
//            mail.setSenderDisplayName('Official Bank of Nigeria');
//            mail.setSenderDisplayName('Administrator');
//            mail.setSenderDisplayName(us.Name);
            // jika pakai Wide Email address, setSenderDisplayName di hide, karena nama berdasarkan Wide Email Address
            
                id tempOwe = owe.Id;
                
                //Add condition entity = 'ALI' - AFDAL
                //if (tsk.Entity__c == 'ALI') sendemail = Label.Email_Schedule_BCC;
                if ((tsk.Entity__c == 'AFI' || tsk.Entity__c == 'ALI') && label.SendOWEEntity != 'FALSE') tempOwe= id.valueof(label.EmailOWE_AFI);
                //END-AFDAL
                if (tsk.Entity__c == 'MAGI' && label.SendOWEEntity_MAGI != 'FALSE') tempOwe= id.valueof(label.EmailOWE_MAGI);
                if (tsk.Entity__c == 'AMFS' && label.SendOWEEntity_AMFS != 'FALSE') tempOwe= id.valueof(label.EmailOWE_AMFS);
                mail.setOrgWideEmailAddressId(tempOwe);
            //mail.setOrgWideEmailAddressId(owe.Id);

//            if (us.Marketing__c == NULL)
//                mail.setTargetObjectId(us2.Id); //recipient
//            else
//                mail.setTargetObjectId(us.Marketing__r.id); //recipient
//            mail.setTargetObjectId(us2.id); //recipient
//            mail.setTargetObjectId(OwnerLast); //recipient
            list<string> EmailTo = new list<string>();
            if (tsk.Send_Admin_Flag__c) {
                // tambahkan TO ke admin
                string sendemailtoadm;
                
                //Add condition entity = 'ALI' - AFDAL
                //if (tsk.Entity__c == 'ALI') sendemailtoadm = Label.Email_Schedule_To_Admin;
                if (tsk.Entity__c == 'AFI' || tsk.Entity__c == 'ALI') sendemailtoadm = Label.Email_Schedule_To_Admin;
                //END-AFDAL
                if (tsk.Entity__c == 'MAGI') sendemailtoadm = Label.Email_Schedule_To_Admin_MAGI;
                if (tsk.Entity__c == 'AMFS') sendemailtoadm = Label.Email_Schedule_To_Admin_AMFS;
                    
                if (sendemailtoadm != 'FALSE') {
                    //sendemail = sendemail.left(sendemail.length()-1);
                    //sendemail = sendemail.replace('null','');
                    EmailTo = sendemailtoadm.split(',');
                }     
    
            }
            else
                EmailTo.add(tsk.Email__c);
            
            if (Test.isRunningTest()) mail.setToAddresses(EmailTo);
            else if (tsk.Use_Contact_Email__c) mail.setTargetObjectId(tsk.Contact__c);
            else mail.setToAddresses(EmailTo);
            
/*                        
            String AddCcAdd1 = '';
            String AddCcAdd2 = '';
            String AddCcAdd3 = '';

            // tambahkan CC, untuk check apakah sudah sesuai atau belum
            sendemail = Label.Email_Schedule_CC;

            if (sendemail != 'FALSE') {
                sendemail = sendemail.left(sendemail.length()-1);
                //sendemail = sendemail.replace('null','');
                String[] CCEmails = sendemail.split(',');
                mail.setCcAddresses(CCEmails);
            }
            // END == tambahkan CC, untuk check apakah sudah sesuai atau belum
*/           
            // tambahkan CC, untuk check apakah sudah sesuai atau belum
            string sendemail;
            //Add condition entity = 'ALI' - AFDAL
            //if (tsk.Entity__c == 'ALI') sendemail = Label.Email_Schedule_BCC;
            if (tsk.Entity__c == 'AFI' || tsk.Entity__c == 'ALI') sendemail = Label.Email_Schedule_BCC;
            //END-AFDAL
            if (tsk.Entity__c == 'MAGI') sendemail = Label.Email_Schedule_BCC_MAGI;
            if (tsk.Entity__c == 'AMFS') sendemail = Label.Email_Schedule_BCC_AMFS;
            
            if (sendemail != 'FALSE') {
                //sendemail = sendemail.left(sendemail.length()-1);
                //sendemail = sendemail.replace('null','');
                String[] CCEmails = sendemail.split(',');
                mail.setBCcAddresses(CCEmails);
            }    
            //updated 9 Dec 2019    
            if(Test.isRunningTest()) {
                String[] bccAddress = new String[]{'contact@testcompany.com' , 'contact1@testcompany.com'};
                mail.setBCcAddresses(bccAddress);
            }
            //END-updated 9 Dec 2019
                
            mail.setSubject(subject);
            mail.setHtmlBody(htmlBody);
            //mail.setTemplateId(et.Id);
            mail.setSaveAsActivity(false); 
     
            //Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            listmail.add(mail);
//*/
            tsk.End_Date__c = MyDate;
            tsk.Status__c = 'Send';
            updatetsk.add(tsk);
            } //flagSendEmail
            else {
                tsk.Status__c = 'Cancel';
                tsk.Description__c = DescCancel;
                tsk.Exclude_From__c = ExcludeFrom;
                updatetsk.add(tsk);
            }
        } // end for
        
        //disable for testing
        //try {   
            Messaging.sendEmail(listmail);
/*
        }catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            System.debug('listmail: ' + listmail);
        }        
*/                
        if (updatetsk.size() > 0) update updatetsk;
        
        //update contact freeze date
        if (updatetsk.size() > 0 || Test.isRunningTest()) {
            Map<String, Integer> intervalMap = new Map<String, Integer>();
            Map<String, String> surveyTypeMap = new Map<String, String>();
            for (Email_SMS_Log__c esl : updatetsk) {
                if (mapICFParam.get(esl.Entity__c) != null) {
                    ICF_Parameter__c icfParam = mapICFParam.get(esl.Entity__c);
                    system.debug('Test 1');
                    String I_ASK = 'I Ask';
                    String I_ASK_INQUIRY = 'I Ask - Inquiry';
                    String I_ASK_REQUEST = 'I Ask - Request';
                    String intervalUnit = 'MONTH';
                    String cId = esl.Contact__c;
                    String surveyType = (esl.Survey_Type__c == I_ASK_INQUIRY || esl.Survey_Type__c == I_ASK_REQUEST ? I_ASK : esl.Survey_Type__c);
                    Integer interval = Integer.valueOf(icfParam.Interval_Completed_Month__c != null ? icfParam.Interval_Completed_Month__c : '1');
                    intervalMap.put(esl.Contact__c, interval);
                    surveyTypeMap.put(esl.Contact__c, surveyType);
                }
                else {
                    ICF_Parameter__c icfParam = mapICFParam.get('General');
                    system.debug('Test 2');
                    String I_ASK = 'I Ask';
                    String I_ASK_INQUIRY = 'I Ask - Inquiry';
                    String I_ASK_REQUEST = 'I Ask - Request';
                    String intervalUnit = 'MONTH';
                    String cId = esl.Contact__c;
                    String surveyType = (esl.Survey_Type__c == I_ASK_INQUIRY || esl.Survey_Type__c == I_ASK_REQUEST ? I_ASK : esl.Survey_Type__c);
                    Integer interval = Integer.valueOf(icfParam.Interval_Completed_Month__c != null ? icfParam.Interval_Completed_Month__c : '1');
                    intervalMap.put(esl.Contact__c, interval);
                    surveyTypeMap.put(esl.Contact__c, surveyType);
                }
            }
            
            System.debug(LoggingLevel.DEBUG, '***intervalMap: ' + intervalMap);
            System.debug(LoggingLevel.DEBUG, '***surveyTypeMap: ' + surveyTypeMap);
            String SEND = 'Send';
            String ICF = 'ICF';
            DescribeSObjectResult describeResultEsl = Email_SMS_Log__c.getSObjectType().getDescribe();
            List<String> eslFieldList = new List<String>(describeResultEsl.fields.getMap().keySet());
            String eslFields = String.join(eslFieldList, ',');
            String querySelectEslTodaySend = '';
            if (Test.isRunningTest()) {
                querySelectEslTodaySend = ' SELECT ' + eslFields + ' FROM Email_SMS_Log__c WHERE Category__c = :ICF AND Status__c = :SEND AND End_Date__c = :MyDate AND Updated_Contact_Flag__c = false LIMIT 100 ';
            }
            else {
                querySelectEslTodaySend = ' SELECT ' + eslFields + ' FROM Email_SMS_Log__c WHERE Category__c = :ICF AND Status__c = :SEND AND End_Date__c = :MyDate AND Updated_Contact_Flag__c = false ';
            }
            //apex batch
            UpdateContactAfterSendLog ucasl = new UpdateContactAfterSendLog(intervalMap, surveyTypeMap, querySelectEslTodaySend);
            Database.executeBatch(ucasl, 100);
        }
    } // end execute
} // end class