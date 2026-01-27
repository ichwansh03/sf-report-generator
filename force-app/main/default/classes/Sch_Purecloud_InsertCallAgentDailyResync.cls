global class Sch_Purecloud_InsertCallAgentDailyResync implements Schedulable{
  global void execute(SchedulableContext ctx) {
        Date yesterday = Date.today().addDays(-1);
        String tgl = String.valueof(yesterday.day());
        String bln = String.valueof(yesterday.month());
        String thn = String.valueof(yesterday.year());
        
        Date newtgl = yesterday.addDays(-1);
        String newhri = String.valueof(newtgl.day());
        String newbln = String.valueOf(newtgl.month());
        
        String s = thn+'-'+newbln+'-'+newhri+'T17:00.000Z';
        String e = thn+'-'+bln+'-'+tgl+'T17:00.000Z';
        
        // Query Data yang gagal
        string CheckSIP = '';
        list<PureCloud__c> pc = [SELECT id, SIP__c FROM PureCloud__c WHERE Date__c =: yesterday AND API_Check_Resync__c = TRUE ];
        //list<PureCloud__c> pc = [SELECT id, SIP__c FROM PureCloud__c WHERE SIP__c != '' LIMIT 3];
        
        for (integer i=0; i < pc.size(); i++) {
            if (i == 0 && i == pc.size()-1 ) CheckSIP += ' AND SIP__c = '+'\''+pc[i].SIP__c+'\''+' ';
            else if (i == 0) CheckSIP += ' AND ( SIP__c = '+'\''+pc[i].SIP__c+'\''+' ';
            else if (i == pc.size()-1) CheckSIP += ' OR SIP__c = '+'\''+pc[i].SIP__c+'\''+') ';
            else CheckSIP += ' OR SIP__c = '+'\''+pc[i].SIP__c+'\''+' ';
        }
        
        system.debug('CheckSIP : '+CheckSIP);
        
        String q;
        if (test.isRunningTest()) q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and isActive = TRUE LIMIT 1';
        else q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and isActive = TRUE  ';
        
        if (CheckSIP != '') q += CheckSIP;
        
        system.debug('q : '+q);
                
        Purecloud_InsertCallAgent bb = new Purecloud_InsertCallAgent(q,s,e);
        Database.executeBatch(bb,1);
        
    }
}