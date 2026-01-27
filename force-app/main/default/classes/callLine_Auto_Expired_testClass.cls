@isTest
public class callLine_Auto_Expired_testClass {
    static Id rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    
    @isTest static void autoExpired(){
        CallLine_Auto_expired deltest = new CallLine_Auto_expired();
        String sch = '20 30 8 10 2 ?';
		String jobID = System.schedule('Account Updates', sch, deltest); 
        
        Call_List__c cc = new Call_List__c();
        cc.Expired_Date__c = date.today()-1;
        insert cc;
        
        Call_Line__c cLine = new Call_Line__c();
        cLine.Call_Remarks__c = 'Test';
        cLine.Call_List__c = cc.id;
        cLine.WelcomeCall_Call_Line_Status__c = 'Open';
        cLine.Entity__c = 'AMFS';
        cLine.RecordTypeId =rtCallLineWC;
        insert cLine;
    }

}