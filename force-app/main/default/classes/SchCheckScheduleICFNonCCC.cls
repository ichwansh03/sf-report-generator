global class SchCheckScheduleICFNonCCC implements Database.Batchable<sObject> {
	global List<ICF_Parameterized_Filter_Criteria__c> start(Database.BatchableContext BC) {
        List<ICF_Parameterized_Filter_Criteria__c> listParam = [SELECT id, Parameterized__r.Entity__c, RecordType.Name, Type__c, Result_Final__c, Send_Field__c, Send_Value__c,
                    Parameterized__c, ICF_Survey_Template__c, ICF_Email_Template__c, ICF_SMS_Template__c, MOT__c, Delay_Send_Formula__c
                FROM ICF_Parameterized_Filter_Criteria__c
                WHERE Parameterized__r.Record_Type_Name__c = 'Master_Non_CCC' and Type__c like 'Schedule%' and Send_Field__c != NULL //and Parameterized__r.Entity__c = 'AMFS' and MOT__c = 'I Claim'
                Order by RecordType.Name, Type__c, Seq__c
           ];
        System.debug('Number of Param : ' + listParam.size());
        return listParam;
    }
    global void execute(Database.BatchableContext BC, List<ICF_Parameterized_Filter_Criteria__c> scope) {
        List<ICF_Non_CCC__c> listicfnon = new List<ICF_Non_CCC__c>();
        List<String> tempID = new List<String>();
    	String query = '';
        System.debug('Scope Size : ' + scope.size());
        
        for(ICF_Parameterized_Filter_Criteria__c ipfc : scope) {
            String dt = ipfc.Delay_Send_Formula__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ', 'GMT'); //String dt = Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ', 'GMT');
        	query = 'SELECT id, CreatedDate, Status__c, ICF_Status__c, Status_Check__c, ICF_Survey_Template__c, ICF_Email_Template__c, ICF_SMS_Template__c, ICF_ExcludeFrom__c, ICF_Send_Field__c, ICF_Send_Value__c, ';
            query += 'Claim_Acc_Name__c, Claim_Acc_No__c, Claim_Bank_Name__c, Claim_Tr_Date__c, Claim_Tr_Status__c, Claim_Tr_Desc__c, MOT__c, Entity__c';
            //query += ' FROM ICF_Non_CCC__c WHERE CreatedDate <= '+ dt +' and MOT__c = \''+ipfc.MOT__c+'\' and Entity__c = \''+ipfc.Parameterized__r.Entity__c+'\' and Status__c = \'Draft\' and '+ipfc.Result_Final__c+ ' and createddate >= 2023-01-01T00:00:00.000+0000 and id not in :TempID LIMIT 10000';
            query += ' FROM ICF_Non_CCC__c WHERE  CreatedDate <= '+ dt +' and MOT__c = \''+ipfc.MOT__c+'\' and Entity__c = \''+ipfc.Parameterized__r.Entity__c+'\' and Status__c = \'Draft\' and '+ipfc.Result_Final__c+ ' and id not in :TempID LIMIT 10000';
            System.Debug('query schedule : '+query);
            
            for (ICF_Non_CCC__c icfnon : Database.query(query)) {
                System.Debug('icfnon: ' + icfnon);
                String mot = icfnon.MOT__c;
                String entity = icfnon.Entity__c;
                String claimStatus = icfnon.Claim_Tr_Status__c == null ? 'In Progress' : icfnon.Claim_Tr_Status__c;
                String claimBankName = icfnon.Claim_Bank_Name__c == null ? '' : icfnon.Claim_Bank_Name__c;
                Date claimTransferDate = icfnon.Claim_Tr_Date__c;
                Date today = Date.today();
                tempID.add(string.valueof(icfnon.id));
                icfnon.Status__c = 'Check';
                icfnon.ICF_Status__c = 'Ready to Send';
                icfnon.ICF_Send_Field__c = ipfc.Send_Field__c;
                icfnon.ICF_Send_Value__c = ipfc.Send_Value__c;
                icfnon.ICF_Survey_Template__c = ipfc.ICF_Survey_Template__c;
                icfnon.ICF_Email_Template__c = ipfc.ICF_Email_Template__c;
                icfnon.ICF_SMS_Template__c = ipfc.ICF_SMS_Template__c;
                icfnon.Status_Check__c += 'schedule-';
                
                if (mot.equalsIgnoreCase('I Claim')) {
                    if (entity.equalsIgnoreCase('AMFS')) {
                        if (claimStatus.equalsIgnoreCase('Success')) {
                            listicfnon.add(icfnon);
                        }
                    } else {
                        listicfnon.add(icfnon);
                    }
                } else {
                    listicfnon.add(icfnon);
                }
            }
            System.debug('Current Scope Detail : ' + ipfc.MOT__c + ',' + ipfc.Parameterized__r.Entity__c + ',' + ipfc.Result_Final__c);
        }
        update listicfnon;
        //update scope;
    }
    global void finish(Database.BatchableContext BC) {
          
    }
}