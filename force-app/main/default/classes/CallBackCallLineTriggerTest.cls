@isTest(seeAllData = true)
public class CallBackCallLineTriggerTest {
     
    public static testmethod void testUpdateCase() { 
        Test.startTest();        
        List<String> caseTypeCriteria = new List<String>();
        caseTypeCriteria.add('Request_CR_Redemption');
        caseTypeCriteria.add('Request_CR_Withdrawal Big Amount');
        caseTypeCriteria.add('Request_Collection CR_Redemption');
         
        Call_Line__c checkCallLine = [SELECT id,contact__c, case__c, createdDate, Policy_No__c  FROM Call_Line__c  WHERE entity__c = 'AMFS' AND Status_has_call__c not in('Closed', 'Takeout') and case__c != null  AND case__r.Case_Type__c =:caseTypeCriteria  AND case__r.Type = 'Request' limit 1];
        Case checkCase = [Select id from Case where Case_Type__c in :caseTypeCriteria AND Type = 'Request' AND id !=  :checkCallLine.case__c limit 1];
         
        
       Master_Case_Type_Regional__c  mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c, Current_User__c 
                    FROM Master_Case_Type_Regional__c 
                    WHERE    Entity__c = 'AMFS'  AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) 
                    LIMIT 1];
        
        Case cs1 = new Case();
        cs1.ContactId = checkCallLine.contact__c;
        cs1.Status = 'New';
        cs1.type = 'Request';
        cs1.Priority = 'Simple Case';
        //cs1.Service_Type__c = 'Helpline';
        cs1.origin = 'Email';
        cs1.Entity_Backup__c = 'AMFS'; 
        cs1.Case_Type_Config__c = 'Request_Collection CR_Redemption';
        cs1.Case_type__c = 'Request_Collection CR_Redemption';
        cs1.Subject = 'Testing only';
        cs1.Description = 'Not for Sale'; 
        //cs1.accountId = acc.Id;
        cs1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RequestAMFSCase').getRecordTypeId();
        cs1.Non_Inquiry__c = true;
        cs1.Follow_Hold_Date__c = Date.today(); 
        cs1.PIC_Department_LU__c = mctr.PIC_Department__c; 
        insert cs1;        
        
        Call_Line__c updateCl = new Call_Line__c();
        updateCl.id = checkCallLine.id;
        updateCl.Case__c = cs1.id; 
        update updateCl;  
        
        Test.stopTest();
    } 
    
    
    public static testmethod void testSaveCaseComment() {
        
        Test.startTest();        
        List<String> caseTypeCriteria = new List<String>();
        caseTypeCriteria.add('Request_CR_Redemption');
        caseTypeCriteria.add('Request_CR_Withdrawal Big Amount');
        caseTypeCriteria.add('Request_Collection CR_Redemption');
        
        User usr = [Select Id From User Where id =:UserInfo.getUserId() limit 1];
        System.runAs(usr){   
            Call_Line__c checkCallLine = [SELECT id, case__c, createdDate, Policy_No__c  FROM Call_Line__c  WHERE entity__c = 'AMFS' AND Status_has_call__c not in('Closed', 'Takeout') and case__c != null  AND case__r.Case_Type__c =:caseTypeCriteria  AND case__r.Type = 'Request' limit 1];
             Call_Line__c updateCl = new Call_Line__c();
            updateCl.id = checkCallLine.id; 
            updateCl.Call_Remarks__c = 'Test';
            update updateCl; 
        } 
        
        Test.stopTest();
    } 
    
    public static testmethod void testWelcomecallHistory() {
        Test.startTest();
        Call_Line__c checkCallLine = [SELECT Id, OwnerId, Owner.Name, Name, RecordType.Name, CreatedDate, LastModifiedDate, Call_List__c, Policy_No__c, Campaign_Type__c, Entity__c, Campaign_Name__c, activity__c, Notes__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c FROM Call_Line__c where entity__c = 'AMFS' AND Status_has_call__c not in('Closed', 'Takeout') and recordtype.name = 'Welcome Call' order by createddate desc limit 1];
        User usr = [Select Id From User Where id = :checkCallLine.OwnerId limit 1];
        
        System.runAs(usr){  
            Call_Line__c callLine = [SELECT Id, Owner.Name, Name, RecordType.Name, CreatedDate, LastModifiedDate, Call_List__c, Policy_No__c, Campaign_Type__c, Entity__c, Campaign_Name__c, activity__c, Notes__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c FROM Call_Line__c where Id = :checkCallLine.Id limit 1];
            Call_Line__c updateCl = new Call_Line__c();
            updateCl.id = callLine.id;
            updateCl.Notes__c = 'Testing call line history creation';
            updateCl.WelcomeCall_Call_Line_Status__c = 'Progress';
            updateCl.Activity_Result__c = 'Uncontacted';
            updateCl.Verification__c = 'Busy Line';
            update updateCl; 
        } 
        Test.stopTest();
    }
    
    public static testmethod void testWelcomecallHistoryWithSameNotes() {
        Test.startTest();
        Call_Line__c checkCallLine = [SELECT Id, OwnerId, Owner.Name, Name, RecordType.Name, CreatedDate, LastModifiedDate, Call_List__c, Policy_No__c, Campaign_Type__c, Entity__c, Campaign_Name__c, activity__c, Notes__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c FROM Call_Line__c where entity__c = 'AMFS' AND Status_has_call__c not in('Closed', 'Takeout') and recordtype.name = 'Welcome Call' order by createddate desc limit 1];
        User usr = [Select Id From User Where id = :checkCallLine.OwnerId limit 1];
        
        System.runAs(usr){  
            Call_Line__c callLine = [SELECT Id, Owner.Name, Name, RecordType.Name, CreatedDate, LastModifiedDate, Call_List__c, Policy_No__c, Campaign_Type__c, Entity__c, Campaign_Name__c, activity__c, Notes__c, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c FROM Call_Line__c where Id = :checkCallLine.Id limit 1];
            Call_Line__c updateCl = new Call_Line__c();
            updateCl.id = callLine.id;
            updateCl.WelcomeCall_Call_Line_Status__c = 'Progress';
            updateCl.Activity_Result__c = 'Uncontacted';
            updateCl.Verification__c = 'Busy Line';
            update updateCl; 
        } 
        Test.stopTest();
    }
}