// Sch Email & SMS dari Object Email & SMS Log
global class SchCheckICFNonCCC implements Schedulable {
    global void execute(SchedulableContext ctx) {
    	SchCheckExcludeICFNonCCC excBatch = new SchCheckExcludeICFNonCCC();
        Database.executeBatch(excBatch, 1);
        
        SchCheckScheduleICFNonCCC schBatch = new SchCheckScheduleICFNonCCC();
        Database.executeBatch(schBatch, 1);
        
        /*
        String query = '';
        String Status = 'Draft';
        String ExcludeFrom = '';
        Date Datetoday = date.today();
        List<string> TempID = new List<string>();

        List<ICF_Non_CCC__c> listicfnon = new List<ICF_Non_CCC__c>();
        //List<sObject> sobjList = Database.query(string);
        
        // Exclude
        for (ICF_Parameterized_Filter_Criteria__c ipfc : [SELECT id, RecordType.Name, Type__c, Result_Final__c, Send_Field__c, Send_Value__c,
                    Parameterized__c, Parameterized__r.Entity__c, MOT__c
                FROM ICF_Parameterized_Filter_Criteria__c
                WHERE Parameterized__r.Record_Type_Name__c = 'Master_Non_CCC' and Type__c like 'Exclude%' and Result_Final__c != NULL //and Parameterized__r.Entity__c = 'MAGI'
                Order by RecordType.Name, Type__c, Seq__c
            ]) {
            
            query = 'SELECT id, Status__c, ICF_Status__c, ICF_Survey_Template__c, ICF_Email_Template__c, ICF_SMS_Template__c, ICF_ExcludeFrom__c, ICF_Send_Field__c, ICF_Send_Value__c ';
            //query += ' FROM ICF_Non_CCC__c WHERE MOT__c = \''+ipfc.MOT__c+'\' and Entity__c = \''+ipfc.Parameterized__r.Entity__c+'\' and Status__c = \'Draft\' and '+ipfc.Result_Final__c+ ' and id not in :TempID';
            query += ' FROM ICF_Non_CCC__c WHERE MOT__c = \''+ipfc.MOT__c+'\' and Entity__c = \''+ipfc.Parameterized__r.Entity__c+'\' and Status__c = \'Draft\' and '+ipfc.Result_Final__c+ ' and (Owner.Name LIKE \'Taufik Susanto\' or Owner.Name LIKE \'Suryono Santoso\') and id not in :TempID'; //UAT query
            // List<ICF_Non_CCC__c> icfnon = Database.query(query);
            System.Debug('query Exclude : '+query);
            
            for (ICF_Non_CCC__c icfnon : Database.query(query)) {
                TempID.add(string.valueof(icfnon.id));
                icfnon.Status__c = 'Check';
                icfnon.ICF_Status__c = 'Cancel';
                icfnon.ICF_ExcludeFrom__c = ipfc.Result_Final__c;
                listicfnon.add(icfnon);
            }
            if (listicfnon.size() > 0) update listicfnon;
        }

        listicfnon = new List<ICF_Non_CCC__c>();
        TempID = new List<string>();

        // Schedule
        for (ICF_Parameterized_Filter_Criteria__c ipfc : [SELECT id, Parameterized__r.Entity__c, RecordType.Name, Type__c, Result_Final__c, Send_Field__c, Send_Value__c,
                    Parameterized__c, ICF_Survey_Template__c, ICF_Email_Template__c, ICF_SMS_Template__c, MOT__c
                FROM ICF_Parameterized_Filter_Criteria__c
                WHERE Parameterized__r.Record_Type_Name__c = 'Master_Non_CCC' and Type__c like 'Schedule%' and Send_Field__c != NULL //and Parameterized__r.Entity__c = 'MAGI'
                Order by RecordType.Name, Type__c, Seq__c
            ]) {
            
            query = 'SELECT id, Status__c, ICF_Status__c, ICF_Survey_Template__c, ICF_Email_Template__c, ICF_SMS_Template__c, ICF_ExcludeFrom__c, ICF_Send_Field__c, ICF_Send_Value__c ';
            //query += ' FROM ICF_Non_CCC__c WHERE MOT__c = \''+ipfc.MOT__c+'\' and Entity__c = \''+ipfc.Parameterized__r.Entity__c+'\' and Status__c = \'Draft\' and '+ipfc.Result_Final__c+ ' and id not in :TempID';
            query += ' FROM ICF_Non_CCC__c WHERE MOT__c = \''+ipfc.MOT__c+'\' and Entity__c = \''+ipfc.Parameterized__r.Entity__c+'\' and Status__c = \'Draft\' and '+ipfc.Result_Final__c+ ' and (Owner.Name LIKE \'Taufik Susanto\' or Owner.Name LIKE \'Suryono Santoso\') and id not in :TempID';  //UAT query
            // List<ICF_Non_CCC__c> icfnon = Database.query(query);
            System.Debug('query schedule : '+query);
            
            for (ICF_Non_CCC__c icfnon : Database.query(query)) {
                TempID.add(string.valueof(icfnon.id));
                icfnon.Status__c = 'Check';
                icfnon.ICF_Status__c = 'Ready to Send';
                //icfnon.ICF_ExcludeFrom__c = ipfc.Result_Final__c;
                icfnon.ICF_Send_Field__c = ipfc.Send_Field__c;
                icfnon.ICF_Send_Value__c = ipfc.Send_Value__c;
                icfnon.ICF_Survey_Template__c = ipfc.ICF_Survey_Template__c;
                icfnon.ICF_Email_Template__c = ipfc.ICF_Email_Template__c;
                icfnon.ICF_SMS_Template__c = ipfc.ICF_SMS_Template__c;
                listicfnon.add(icfnon);
            }
            if (listicfnon.size() > 0) update listicfnon;
        }
	*/
        
    } // end execute
} // end class