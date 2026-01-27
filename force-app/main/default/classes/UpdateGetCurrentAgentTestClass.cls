@isTest
public class UpdateGetCurrentAgentTestClass {
static testMethod void testController1() {
        // Create a test Case
        Case testCase = new Case();
        testCase.Subject = 'Test Case';
        insert testCase;

        // Set up the standard controller with the test Case
        ApexPages.StandardController stdController = new ApexPages.StandardController(testCase);

        // Create an instance of the controller
        UpdateGetCurrentAgentController controller = new UpdateGetCurrentAgentController(stdController);

        // Simulate a user context
        System.runAs(new User(Id = UserInfo.getUserId())) {
            // Verify the initial state
            System.assertEquals(false, controller.isButtonDisabled);

            // Update the Case's GetInfo__c field
            controller.updateGetInfo();

            // Verify the updated state
            System.assertEquals(true, controller.updated);
            System.assertEquals(false, controller.isButtonDisabled); // Assuming UserInfo.getName() is the same as caseUserName
        }
    }
    
   
    
    /*static testMethod void testController2() {
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User testUser = new User(
            ProfileId = profile.Id,
            FirstName = 'Testing',
            LastName = 'User18',
            Email = 'testinguser18@test.com',
            Username = 'testinguser18@test.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            Entity__c = 'AFI'
        );
        insert testUser;
        
        Case ca = new Case();
        ca.Subject = 'Testing';
        ca.Entity_Backup__c = 'AFI';
        ca.OwnerId = testUser.Id;
        ca.GetInfo__c = testUser.Name;
        insert ca;

        // Set up the standard controller with the test Case
        ApexPages.StandardController stdController = new ApexPages.StandardController(ca);

        // Create an instance of the controller
        UpdateGetCurrentAgentController controller = new UpdateGetCurrentAgentController(stdController);

        // Simulate a user context
        System.runAs(testUser) {
            // Verify the initial state
            System.assertEquals(true, controller.isButtonDisabled);

            // Update the Case's GetInfo__c field
            controller.updateGetInfo();

            // Verify the updated state
            System.assertEquals(true, controller.updated);
            System.assertEquals(true, controller.isButtonDisabled); // Assuming UserInfo.getName() is the same as caseUserName
        }
    }*/
    
    
}