trigger ContactTrigger on Contact (after update) {
    if (trigger.isAfter) {
        List<Contact> conList = new List<Contact>();
        Set<String> policies = new Set<String>();
        for(Contact x:trigger.new){
            if (x.Entity__c == 'AMFS') {
                conList.add(x);
                policies.add(x.Policy_No__c);
            }
        }
        system.debug('conList: ' + conList);
        system.debug('policies: ' + policies);
        List<Call_Line__c> clList = [SELECT Id, Name, Policy_No__c, Contacted_Number__c, WelcomeCall_Call_Line_Status__c, Call_Line_Status_TelUW__c, Campaign_Type__c FROM Call_Line__c where Policy_No__c in :policies and entity__c = 'AMFS'];
		List<Call_Line__c> clListTbu = new List<Call_Line__c>();
        system.debug('clList before: ' + clList);
        system.debug('clListTbu before: ' + clListTbu);
        for (Contact cont : conList) {
        	for (Integer i=0;i<clList.size();i++) {
                Call_line__c cl = clList.get(i);
                if (cl.Policy_No__c != cont.Policy_no__c) continue;
                if (cl.Contacted_Number__c != cont.MobilePhone) {
                    if ((cl.Campaign_Type__c).contains('TelUW')) {
                        if (cl.Call_Line_Status_TelUW__c != null && cl.Call_Line_Status_TelUW__c != 'Closed') {
                            cl.Contacted_Number__c = cont.MobilePhone;
                       		clListTbu.add(cl);
                            clList.remove(i);
                        	continue;
                        }
                    } else if ((cl.Campaign_Type__c).contains('Welcome Call')) {
                        if (cl.WelcomeCall_Call_Line_Status__c != null && cl.WelcomeCall_Call_Line_Status__c != 'Closed') {
                            cl.Contacted_Number__c = cont.MobilePhone;
                       		clListTbu.add(cl);
                            clList.remove(i);
                        	continue;
                        }
                    } 
            	}
        	}
        }
        system.debug('clList after: ' + clList);
        system.debug('clListTbu after: ' + clListTbu);
        update clListTbu;
    }
}