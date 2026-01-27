@IsTest(SeeAllData=true)
public class TrainingPlanAssignmentExtensionNew_Test {
	static testmethod void myMethodTest(){
        Test.StartTest();
        
        Profile agentProfileAFI = [SELECT Id FROM Profile WHERE Name like 'Inbound Agent%AFI' limit 1];
        
        User u = new User();
        u.LastName = 'AFI Agent';
        u.Alias = 'afiAgent';
        u.Email = 'afiAgent1@axa.co.id';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        u.ProfileId = agentProfileAFI.Id;
        u.TimeZoneSidKey = 'Asia/Jakarta';
        u.UserName= 'afiAgent1@axa.co.id';
        u.isActive = TRUE;
        u.Entity__c = 'AFI';
        insert u;
        
        Training_Plan__c tp = new Training_Plan__c();
        tp.Name = 'Quiz 1';
        tp.Start_Date__c = Date.newInstance(2020, 4, 1);
        tp.End_Date__c = Date.newInstance(2020, 6, 30);
        tp.Status__c = 'Active';
        tp.Chatter_Notifications_Enabled__c = TRUE;
        insert tp;
        
        Training_Plan_Assignment__c tpa = new Training_Plan_Assignment__c();
        tpa.User__c = u.Id;
        tpa.Status__c = 'Completed';
        tpa.Training_Plan__c = tp.Id;
        tpa.Completed_On__c = system.today();
        insert tpa;
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(tp);
        TrainingPlanAssignmentExtensionNew testAccPlan = new TrainingPlanAssignmentExtensionNew(sc);
        testAccPlan.getProfiles();
        testAccPlan.getRoles();
        testAccPlan.searchUsers();
        testAccPlan.assignUsers();
        testAccPlan.assignSingleUser();
        testAccPlan.goToImportAssignments();
        testAccPlan.getCommunities();
        
        PageReference pageRef = Page.TrainingPlanAssignmentNew; //VF Page Name
        pageRef.getParameters().put('id', String.valueOf(tp.Id));
        Test.setCurrentPage(pageRef);
        
        Test.stopTest();
    }
}