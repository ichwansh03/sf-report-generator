@isTest
public class LogCallLineServiceBatchTest {
    
    @testSetup
    static void setup(){
        
        ID rtContact = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        ID rtCollectionAMFS = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        ID rtClRedemp = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Collection AMFS 8').getRecordTypeId();
        
        Date dtNow = Date.today();
        Date cpgExpDate = dtNow.addDays(19);
        
        Profile agentProfileAMFS = [SELECT Id FROM Profile WHERE Name like 'Outbound Agent%AMFS' limit 1];
        UserRole agentRoleAMFS = [SELECT Id FROM UserRole WHERE Name like 'Outbound Agent%AMFS' limit 1];
        
        //Insert user
        User usr = new User(
            ProfileId = agentProfileAMFS.Id,
            LastName = 'Test',
            Email = 'test@mail.com',
            Username = 'test@mail.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = agentRoleAMFS.Id,
            Entity__c = 'AMFS',
            ID_User_DMTM__c = 'test',
            isActive = true,
            Agent__c = true
        );
        Insert usr;
        
        system.runAs(usr) {
            
            CallLine_Reason_Type__c reasonType = new CallLine_Reason_Type__c();
            reasonType.Name = 'Cause Of Death';
            reasonType.Type_ID__c = 'COD';
            reasonType.Value__c = 'Cause Of Death-[Claim Investigation]';
            insert reasonType;
            
            Call_Status_Type__c statusType = new Call_Status_Type__c();
            statusType.Name = 'Pending';
            statusType.Status_ID__c = 'PE';
            insert statusType;
            
            Account acc = new Account();
            acc.Name = 'Test Account';
            acc.Entity__c = 'AMFS';
            Insert acc;
            
            //Insert Contact
            Contact con = new Contact();
            con.LastName = 'test mus';
            con.AccountId = acc.Id;
            con.Policy_No__c = '300-107-5561401';
            con.Entity__c = 'AMFS';
            con.Email = 'test@gmail.com';
            con.MobilePhone = '123456789';
            con.HomePhone = '123456789';
            con.PolicyApp__c = 'DMTM';
            Insert con;
            
            Call_List__c cpg = new Call_List__c();
            cpg.RecordTypeId = rtCollectionAMFS;
            cpg.Entity__c = 'AMFS';
            cpg.Activity__c = 'Collection';
            cpg.Case_Type__c = 'Redemption TM';
            cpg.Campaign_Name__c = 'Collection-Redemption TM-Test#20240718';
            cpg.Expired_Date__c = cpgExpDate; 
            insert cpg;
            
            Call_line__c cl = new Call_Line__c();
            cl.RecordTypeId = rtClRedemp;
            cl.Contact__c = con.Id;
            cl.Call_List__c = cpg.Id;
            cl.Case_Type__c = 'Redemption TM';
            cl.policy_no__c = con.Policy_No__c;
            cl.Notes__c = 'Notes';
            cl.Entity__c = 'AMFS';
            cl.Contacted_Number__c = '085156080110';
            cl.Call_Status_Config__c = 'Pending';
            cl.Reason_Status_Config__c = 'Busy Line';
            cl.Call_Remarks__c = 'Remarks';
            cl.Confirm__c = true;
            insert cl;
            
        }
        
    }
    
    @isTest
    public static void triggerCallLineHistoryTest(){
        Test.startTest();
        
        String caseType = 'Redemption TM';
        DescribeSObjectResult describeResultCl = Call_Line__c.getSObjectType().getDescribe();
        List<String> clFieldList = new List<String>(describeResultCl.fields.getMap().keySet());
        String clFields = String.join(clFieldList, ',');
        String clQuery = ' SELECT ' + clFields + ' FROM Call_Line__c WHERE Case_Type__c = :caseType AND Policy_No__c = \'300-107-5561401\' ORDER BY CreatedDate DESC LIMIT 1 ';
        Call_Line__c cl = Database.query(clQuery);
        cl.Call_Remarks__c = 'Update Remarks';
        cl.Notes__c = 'Update notes';
        cl.Confirm__c = true;
        update cl;
        system.debug('**cl: '+cl);        
        
        /*Call_Line_History__c clh = new Call_Line_History__c();
        clh.Call_Line__c = cl.Id;
        clh.Call_Status__c = cl.Activity_Result__c;
        clh.Reason_Status__c = cl.Reason_Status_Config__c;
        clh.Call_Remarks__c = cl.Call_Remarks__c;
        clh.Policy_App__c = cl.Contact_Policy_App__c;
        clh.Policy_No__c = cl.Policy_No__c;
        insert clh;
        
        List<Call_Line_History__c> clines = new List<Call_Line_History__c>{clh};*/
        
        List<Call_Line__c> clines = new List<Call_Line__c>{cl};
        Database.executeBatch(new LogCallLineServiceBatch(clines), 20);
        Test.stopTest();
    }
    
}