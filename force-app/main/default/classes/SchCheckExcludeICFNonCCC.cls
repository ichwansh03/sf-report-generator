global class SchCheckExcludeICFNonCCC implements Database.Batchable<sObject> {
	global List<ICF_Parameterized_Filter_Criteria__c> start(Database.BatchableContext BC) {
        List<ICF_Parameterized_Filter_Criteria__c> listParam = [SELECT id, RecordType.Name, Type__c, Result_Final__c, Send_Field__c, Send_Value__c,
                    Parameterized__c, Parameterized__r.Entity__c, MOT__c
                FROM ICF_Parameterized_Filter_Criteria__c
                WHERE Parameterized__r.Record_Type_Name__c = 'Master_Non_CCC' and Type__c like 'Exclude%' and Result_Final__c != NULL //and Parameterized__r.Entity__c = 'MAGI'
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
        	query = 'SELECT id, Status__c, ICF_Status__c, Status_Check__c, ICF_Survey_Template__c, ICF_Email_Template__c, ICF_SMS_Template__c, ICF_ExcludeFrom__c, ICF_Send_Field__c, ICF_Send_Value__c, ';
            query += 'Claim_Acc_Name__c, Claim_Acc_No__c, Claim_Bank_Name__c, Claim_Tr_Date__c, Claim_Tr_Status__c, Claim_Tr_Desc__c, MOT__c, Entity__c';
            query += ' FROM ICF_Non_CCC__c WHERE MOT__c = \''+ipfc.MOT__c+'\' and Entity__c = \''+ipfc.Parameterized__r.Entity__c+'\' and (Status__c = \'Draft\' or (Status__c = \'Check\' and Status_Check__c LIKE \'%schedule%\' and (NOT Status_Check__c LIKE \'%exclude%\'))) and '+ipfc.Result_Final__c+ ' and id not in :TempID'; // and createddate >= 2023-01-01T00:00:00.000+0000';
            System.Debug('query Exclude : '+query);
            
            for (ICF_Non_CCC__c icfnon : Database.query(query)) {
                String mot = icfnon.MOT__c;
                String entity = icfnon.Entity__c;
                String claimStatus = icfnon.Claim_Tr_Status__c == null ? 'In Progress' : icfnon.Claim_Tr_Status__c;
                String claimBankName = icfnon.Claim_Bank_Name__c == null ? '' : icfnon.Claim_Bank_Name__c;
                Date claimTransferDate = icfnon.Claim_Tr_Date__c;
                Date today = Date.today();
                tempID.add(string.valueof(icfnon.id));
                icfnon.Status__c = 'Check';
                icfnon.ICF_Status__c = 'Cancel';
                icfnon.ICF_ExcludeFrom__c = ipfc.Result_Final__c;
                icfnon.Status_Check__c += 'exclude-';
                
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