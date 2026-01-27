global class ScheduleSendSMSLog implements Schedulable{
    global void execute(SchedulableContext ctx){
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
        
        // data 7 Hari ganti today.
        Date MyDate = Date.Today(); //+ 7;
        
        // taufik, 2 Feb 2019, tambahi Limit SMS.
        integer limitsms = integer.valueof(label.ICF_SMS_Limit);
        
        list<Email_SMS_Log__c> updatetsk = new list<Email_SMS_Log__c>();
        list<Email_SMS_Log__c> updatetskBatch = new list<Email_SMS_Log__c>();
        
        // load data Email_SMS_Log__c
        list<Email_SMS_Log__c> tsk2 = [SELECT id, Name, 
            Account__c, 
            Case__c, Case__r.Type, 
            Contact__c,
            Email_SMS_Template__c, Email_SMS_Template__r.Subject__c, Email_SMS_Template__r.Email_Body__c, mobile__c, 
            Survey__c, Email_Text__c, messageid_jatis__C, status_jatis__C, Status_Deliver__c,
            Survey_URL__c, Survey_Type__c, Type__c,
            Description__c,
            Send_Admin_Flag__c, FlagTestClass__c, 
            Category__c, Email__c, End_Date__c, Entity__c, Policy_Number__c, Request_Date__c,
            Send_Flag__c, Start_Date__c, Status__c
                FROM Email_SMS_Log__c 
                WHERE Method__c = 'SMS' and Send_Flag__c = TRUE and End_Date__c = NULL and Status__c = 'Draft' and Ready_to_send__c = true and
                Bitly__c != '' and // taufik mii, 11 Feb 2020, jika bitly kosong, tidak di kirim.
                Request_Date__c <=: MyDate //and Survey_URL__c != NULL 
                order by Contact__c
                limit :limitsms
        ];
        system.debug(LoggingLevel.DEBUG, '*tsk2*'+tsk2);
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
        
        boolean flagSendSMS = FALSE;
        String DescCancel = '';
        String ExcludeFrom = '';
        integer checkdata = 0;
        List<Id> listsms = new List<Id>();
        for (Email_SMS_Log__c tsk : tsk2)
        {
            // taufik 20 Feb20, tambahi flag, untuk ganti menjadi 
            if (Test.isRunningTest() && checkdata == 1) tsk.FlagTestClass__c = 'Thanks Note';
            
            if (Test.isRunningTest() && checkdata == 2) tsk.FlagTestClass__c = 'Nothing';
			
            checkdata += 1;
            
            flagSendSMS = TRUE;
            DescCancel = '';
            ExcludeFrom = '';

            // check ICF Parameter.
            if ((mapICFParam.get(tsk.Entity__c) != NULL && tsk.FlagTestClass__c == NULL) || (tsk.FlagTestClass__c == 'Thanks Note') ) {
                System.debug(LoggingLevel.DEBUG, '***ICF PARAM: ' + mapICFParam.get(tsk.Entity__c));
            
                if ((tsk.Category__c != 'Thanks Note') && (mapICFParam.get(tsk.Entity__c).Dont_Send_if_Have_any_Case_Open__c) ) {
                    if (MapContactCase.get(tsk.Contact__c) != NULL) {
                        if (MapContactCase.get(tsk.Contact__c) > 0) {
                            DescCancel += 'Policy have '+MapContactCase.get(tsk.Contact__c)+' open Case; ';                            ExcludeFrom = 'Have Open Case';                            flagSendSMS = FALSE;
                        }
                    }
                }
                
                // priority Thanks note.
                if ( 
                    ((tsk.Category__c == 'Thanks Note') && (tsk.Case__r.Type != mapICFParam.get(tsk.Entity__c).Case_Priority__c) && (mapICFParam.get(tsk.Entity__c).Case_Priority__c != ''))  
                    || (tsk.FlagTestClass__c =='Thanks Note')
                    )
                {
                            DescCancel += 'Case Priority TN; ';
                            ExcludeFrom = 'Case Priority TN';
                            flagSendSMS = FALSE;
                }
            }
            else {
                ICF_Parameter__c icfParam = mapICFParam.get('General');
                if (icfParam != null) {
                    if (mapICFParam.get('General').Exclude_Survey_Type__c.contains(tsk.Survey_Type__c) ) {
                        flagSendSMS = FALSE;                        DescCancel += 'ICF Parameter '+tsk.Survey_Type__c+' is Exclude; ';                        ExcludeFrom = tsk.Survey_Type__c;
                    }
                    
                    if ((tsk.Category__c != 'Thanks Note') && (mapICFParam.get(tsk.Entity__c).Dont_Send_if_Have_any_Case_Open__c) ) {
                        if (MapContactCase.get(tsk.Contact__c) != NULL) {
                            if (MapContactCase.get(tsk.Contact__c) > 0) {                                DescCancel += 'Policy have '+MapContactCase.get(tsk.Contact__c)+' open Case; ';                                ExcludeFrom = 'Have Open Case';                                flagSendSMS = FALSE;
                            }
                        }
                    }
                }                
            }
            if (flagSendSMS==true) {
                listsms.add(tsk.Id);
                // Taufik, 20 Feb20, update status = Batch, untuk menandakan sudah di kirim.
                tsk.Status__c = 'Batch';
                updatetskBatch.add(tsk);                
            }
            else{
                tsk.Status__c = 'Cancel';
                tsk.Description__c = DescCancel;
                tsk.Exclude_From__c = ExcludeFrom;
                updatetsk.add(tsk);
            }
        }
            // Taufik, 20 Feb20, update status = Batch, untuk menandakan sudah di kirim.
        if(updatetskBatch.size()>0) update updatetskBatch;
        if(updatetsk.size()>0) update updatetsk;
        
        system.debug(LoggingLevel.DEBUG, '**listsms'+listsms);
        if(listsms.size()>0){
            JatisBatch jb = new JatisBatch(listsms);

            if (!Test.isRunningTest())
                Database.executeBatch(jb, 10);                

        }
        //update contact freeze date
        if (updatetsk.size() > 0) {
            Map<String, Integer> intervalMap = new Map<String, Integer>();
            Map<String, String> surveyTypeMap = new Map<String, String>();
            for (Email_SMS_Log__c esl : updatetsk) {
                if (mapICFParam.get(esl.Entity__c) != null && esl.FlagTestClass__c == NULL) {
                    ICF_Parameter__c icfParam = mapICFParam.get(esl.Entity__c);
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
                    String I_ASK = 'I Ask'; String I_ASK_INQUIRY = 'I Ask - Inquiry'; String I_ASK_REQUEST = 'I Ask - Request'; String intervalUnit = 'MONTH'; String cId = esl.Contact__c;
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
            
            if (!Test.isRunningTest())
                Database.executeBatch(ucasl, 100);
        
        }
    }
}