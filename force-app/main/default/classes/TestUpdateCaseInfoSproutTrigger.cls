@isTest
public class TestUpdateCaseInfoSproutTrigger {
    @isTest static void UpdateCaseInfoSprout1() {
        List<SproutSocialApp__Sprout_Social_Post__c> testSocialPosts = new List<SproutSocialApp__Sprout_Social_Post__c>();
        
        Case testCase = new Case(Subject = 'Testing');
        insert testCase;

        testSocialPosts.add(new SproutSocialApp__Sprout_Social_Post__c(
            SproutSocialApp__ParentId__c = testCase.Id,
            SproutSocialApp__IsOutbound__c = true,
            SproutSocialApp__Content__c = 'Testing',
            SproutSocialApp__Posted__c = DateTime.now()
        ));
        Test.startTest();
        insert testSocialPosts;
        Test.stopTest();
        
        Case updatedCase = [SELECT Id, Post_Status__c, Last_Post_By__c, Last_Post_Message__c FROM Case WHERE Id = :testCase.Id];
        System.assertEquals('Replied', updatedCase.Post_Status__c);
        System.assertEquals('Testing', updatedCase.Last_Post_Message__c);
    }

    @isTest static void UpdateCaseInfoSprout2() {
        List<SproutSocialApp__Sprout_Social_Post__c> testSocialPosts = new List<SproutSocialApp__Sprout_Social_Post__c>();
        
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User userWithAgentRole = new User(
            Alias = 'user1',
            Email = 'user1@testing.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'User1267',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = profile.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'user123457@testing.com',
            Entity__c = 'AFI', // Set the Entity__c value as needed
            Agent__c = true,
            Agent_Queue_ID_Email_Reply_Customer__c = 'Queue_ID' // Set the Queue ID as needed
        );
        insert userWithAgentRole;
        
        Case ca = new Case();
        ca.Subject = 'Testing';
        ca.Entity_Backup__c = 'AFI';
        ca.OwnerId = userWithAgentRole.Id;
        insert ca;
        
        testSocialPosts.add(new SproutSocialApp__Sprout_Social_Post__c(
            SproutSocialApp__ParentId__c = ca.Id,
            SproutSocialApp__IsOutbound__c = true,
            SproutSocialApp__Content__c = 'Testing',
            SproutSocialApp__Posted__c = DateTime.now()
        ));
        
        Test.startTest();
        insert testSocialPosts;
        Test.stopTest();
        
        Case updatedCase = [SELECT Id, Post_Status__c, Last_Post_By__c, Last_Post_Message__c FROM Case WHERE Id = :ca.Id];
        System.assertEquals('Replied', updatedCase.Post_Status__c);
        System.assertEquals('Testing', updatedCase.Last_Post_Message__c);
    }

}