@isTest
public class Trigger_CallLineTest {  
    @isTest
    Public static void testAFI() {  
        UserRole agentRoleAFI = [SELECT Id FROM UserRole WHERE Name like 'Outbound Agent%AFI' limit 1]; 
        User agentUserAFI = [Select id, managerId from User where isactive = true and managerId != null and userRoleId =: agentRoleAFI.id Limit 1];
        
        System.runAs(agentUserAFI){     
            //Insert Account
            Account acc = new Account();
            acc.Name = 'Test Account AFI';
            acc.Entity__c = 'AFI';
            Insert acc;
            
            Contact con = new Contact();
            con.FirstName = 'Testing';
            con.LastName = '123';
            con.AccountId = acc.Id;
            con.Policy_No__c = '500-12345';
            con.MobilePhone = '081122334455';
            con.Entity__c = 'AFI';  
            Insert con;
            
            //Insert Campaign
            Call_List__c cmp = new Call_List__c(); 
            cmp.Campaign_Name__c = 'Redemption Konven';
            cmp.Activity__c = 'Collection';
            cmp.Case_Type_Config__c = 'Redemption Konven';
            cmp.Expired_Date__c = System.today() + 100000;
            cmp.Entity__c = 'AFI';
            cmp.IsExpired__c = false;
            Insert cmp;
            
            //Insert Call Line
            Call_Line__c cl = new Call_Line__c();
            cl.Call_Status_Config__c = 'Hold';
            cl.Policy_No__c = '500-12345';
            cl.Contact__c = con.Id;
            cl.Remark_Hold_Debet__c = 'test';
            cl.Call_List__c = cmp.Id;
            cl.OwnerId = agentUserAFI.Id;
            cl.Agent__c = agentUserAFI.Id;
            cl.APE_Total_Child__c = 1000000;
            cl.Entity__c = 'AFI';
            cl.Activity__c = 'Collection';
            cl.Policy_No__c = 'test';
            cl.Contacted_Number__c = '123456789';
            cl.Home_Phone__c = '1234567';
            Insert cl;
            
            //Insert Call Line
            Call_Line__c cl2 = new Call_Line__c();
            cl2.Call_Status_Config__c = 'Hold';
            cl2.Policy_No__c = '500-12345';
            cl2.Contact__c = con.Id;
            cl2.Remark_Hold_Debet__c = 'test';
            cl2.Call_List__c = cmp.Id;
            cl2.OwnerId = agentUserAFI.Id;
            cl2.APE_Total_Child__c = 1000000;
            cl2.Entity__c = 'AFI';
            cl2.Activity__c = 'Collection';
            cl2.Policy_No__c = 'test';
            cl2.Contacted_Number__c = '123456789';
            cl2.Home_Phone__c = '1234567';
            cl2.Parent_Call_Line__c = cl.Id;
            Insert cl2; 
        }
        Call_line__c getCallLine = [Select id, ownerId, Activity_Result__c,Update_Child__c,Date_Reschedule__c,Verification__c,Reschedule_Date__c,
                                    Reason_Status_Config__c, Time_Reschedule__c,Call_Status_Config__c,Call_Remarks__c,Message__c 
                                    from Call_line__c limit 1 ]; 
        
        System.runAs(agentUserAFI) {
            getCallLine.Activity_Result__c = 'Contacted';
            getCallLine.Date_Reschedule__c = system.today(); 
                getCallLine.Call_Status_Config__c = 'Contacted';
            getCallLine.Call_Remarks__c = 'test';
            getCallLine.Verification__c = 'Agree';   
            getCallLine.Reschedule_Date__c = system.now().addHours(1);
            getCallLine.Reason_Status_Config__c = 'Agree';    
            getCallLine.Message__c = 'test';
            
            update getCallLine;
        }
         
        System.schedule('Test ReminderTaskAFISch','0 10 * * * ?', new ReminderTaskAFISch()); 
        Database.executeBatch(new ReminderTaskAFIBatch(),10); 
        
    }
    
    @isTest
    Public static void testAMFS() {  
        UserRole agentRoleAMFS = [SELECT Id FROM UserRole WHERE Name like 'Outbound Agent%AMFS' limit 1]; 
        User agentUserAMFS = [Select id, managerId from User where isactive = true and managerId != null and userRoleId =: agentRoleAMFS.id Limit 1];
        
        System.runAs(agentUserAMFS){     
            //Insert Account
            Account acc = new Account();
            acc.Name = 'Test Account AMFS';
            acc.Entity__c = 'AMFS';
            Insert acc;
            
            Contact con = new Contact();
            con.FirstName = 'Testing';
            con.LastName = '123';
            con.AccountId = acc.Id;
            con.Policy_No__c = '500-12345';
            con.MobilePhone = '081122334455';
            con.Entity__c = 'AMFS';  
            Insert con;
            
            //Insert Campaign
            //Call_List__c cmp = new Call_List__c
            //cmp.Campaign_Name__c = 'Redemption Konven
            //cmp.Activity__c = 'Collection';
            //cmp.Case_Type_Config__c = 'Redemption Konven';
            //cmp.Expired_Date__c = System.today() + 100000;
            //cmp.Entity__c = 'AMFS';
            //cmp.IsExpired__c = false;
            //Insert cmp;
            
            //Insert Call Line
            Call_Line__c cl = new Call_Line__c();
            cl.Call_Status_Config__c = 'Hold';
            cl.Policy_No__c = '500-12345';
            cl.Contact__c = con.Id;
            cl.Remark_Hold_Debet__c = 'test';
            //cl.Call_List__c = cmp.Id;
            cl.OwnerId = agentUserAMFS.Id;
            cl.Agent__c = agentUserAMFS.Id;
            cl.APE_Total_Child__c = 1000000;
            cl.Entity__c = 'AMFS';
            cl.Activity__c = 'Collection';
            cl.Policy_No__c = 'test';
            cl.Contacted_Number__c = '123456789';
            cl.Home_Phone__c = '1234567';
            Insert cl; 
        }
        Call_line__c getCallLine = [Select id, ownerId, Activity_Result__c,Update_Child__c,Date_Reschedule__c,Verification__c,Reschedule_Date__c,
                                    Reason_Status_Config__c, Time_Reschedule__c,Call_Status_Config__c,Call_Remarks__c,Message__c 
                                    from Call_line__c limit 1 ]; 
        
        System.runAs(agentUserAMFS) {
            getCallLine.Call_Remarks__c = 'Test';
            getCallLine.Activity_Result__c = 'Contacted'; 
            getCallLine.Call_Status_Config__c = 'Contacted'; 
            getCallLine.Verification__c = 'Agree';      
            
            update getCallLine;
        }
    }
}