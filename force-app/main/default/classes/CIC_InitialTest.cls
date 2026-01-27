@isTest
public class CIC_InitialTest {
    public static testMethod void initRecord() {
        Case cs = new Case();
        cs.Case_Type__c = 'MV Claim Report 2';
        cs.Internal_Comment__c = 'Internal Comment';
        cs.Last_Comment__c = null;
        cs.OwnerId = UserInfo.getUserId();
        cs.Escalated_to_History__c = 'Escalated';
        cs.IsEscalated = true;
        cs.Division__c = 'CS';
        cs.Escalated_Step__c = 1;
        cs.named_user__c ='Taufik';
        cs.last_named_user__c ='Taufik';
        cs.Status = 'New';
        cs.Entity_Backup__c = 'AFI';
        cs.Escalated_Flow__c = '{"1":"Agency","2":"null","3":"null","4":"null","5":"null"}';
        cs.Escalated_Flow_TAT__c = '{"1":"3","2":"0","3":"0","4":"0","5":"0"}';
        insert cs;
        
        Case_Internal_Comment__c cic = new Case_Internal_Comment__c();
        cic.Case__c = cs.Id;
		cic.Division__c = 'CS';
        cic.Internal_Comment__c = 'CIC Internal Comment';
        cic.Escalated_Step__c = 2;
        cic.Auto_Next_Step__c = true;
        cic.TAT__c = 3;
        
        insert cic;
    }
}