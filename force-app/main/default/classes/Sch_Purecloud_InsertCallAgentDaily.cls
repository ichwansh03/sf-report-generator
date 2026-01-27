global class Sch_Purecloud_InsertCallAgentDaily implements Schedulable{
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
		
        // 9 May 2023, fix record login null
        Map<String, String> pcMapRetry = new Map<String, String>(); 
        for (PureCloud__c pc : [SELECT id, SIP__c FROM PureCloud__c 
                                WHERE Date__c =: yesterday and API_Check_API1_Status__c like '%Okay. Available%' and API_Check_API3_Status__c like '%Okay. Conversation Aggregate Sum%' and Start_Login__c=null and End_Login__c=null and SIP__c!=null]){
            pcMapRetry.put(pc.SIP__c, pc.SIP__c);
        }
        
        // 30 Sept 2021, Taufik, Running, != OK.
        list<string> ListSIP_OK = new list<string>();
        for (PureCloud__c pc : [SELECT id, SIP__c FROM PureCloud__c WHERE Date__c =: yesterday and API_Check_API1_Status__c like '%Okay%' and API_Check_API3_Status__c like '%Okay%']){
            //if (pc.SIP__c != NULL) ListSIP_Ok.add(pc.SIP__c);
            if (pc.SIP__c != NULL) {
                if(!pcMapRetry.containsKey(pc.SIP__c)) {
                    ListSIP_Ok.add(pc.SIP__c);
                }
            }
        }
        
    	String q;
        if (test.isRunningTest()) q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and isActive = TRUE LIMIT 1';
        else q = Label.Purecloud_InsertCallAgent_Query;
        //else q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and isActive = TRUE and entity__c= '+'\''+'AMFS'+'\'';
        
        if (ListSIP_Ok.size() > 0) for (integer i = 0; i < ListSIP_OK.Size(); i++) q += ' AND SIP__c != '+'\''+ListSIP_OK[i]+'\''+' ';

        Purecloud_InsertCallAgent bb = new Purecloud_InsertCallAgent(q,s,e);
		Database.executeBatch(bb,1);
    }
}