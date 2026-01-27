@isTest
public class UpdateCaseInfoTriggerHandlerTest {
    @isTest
    static void testTriggerHandler() {
         Profile profile = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User testUser = new User(
            ProfileId = profile.Id,
            FirstName = 'Naxema123',
            LastName = 'Xema',
            Email = 'Naxema123@test.com',
            Username = 'Naxema123@test.com',
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
        insert ca;
        
        List<SproutSocialApp__Sprout_Social_Post__c> socialPosts = new List<SproutSocialApp__Sprout_Social_Post__c>();
        
        SproutSocialApp__Sprout_Social_Post__c outboundPost = new SproutSocialApp__Sprout_Social_Post__c(
            Name = 'Outbound Post',
            SproutSocialApp__IsOutbound__c = true,
            SproutSocialApp__ParentId__c = ca.Id,
            SproutSocialApp__Posted__c = Datetime.now().addHours(-1)
        );
        socialPosts.add(outboundPost);
        
        SproutSocialApp__Sprout_Social_Post__c inboundPost = new SproutSocialApp__Sprout_Social_Post__c(
            Name = 'Inbound Post',
            SproutSocialApp__IsOutbound__c = false,
            SproutSocialApp__ParentId__c = ca.Id,
            SproutSocialApp__Posted__c = Datetime.now().addHours(1)
        );
        socialPosts.add(inboundPost);

        insert socialPosts;

        Test.startTest();
        UpdateCaseInfoTriggerHandler.onBeforeInsert(socialPosts);
        Test.stopTest();
    }
     /*@isTest
    public static void testOnBeforeInsert() {
        // Create test data
        List<SproutSocialApp__Sprout_Social_Post__c> newSocialPosts = new List<SproutSocialApp__Sprout_Social_Post__c>();
		
        
        // Create test User record and related data
        Profile standardProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1]; // Adjust the profile name if needed
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser_' + String.valueOf(Datetime.now().getTime()) + '@example.com', // Use a unique username
            Alias = 'tuser',
            TimeZoneSidKey = 'GMT',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            Entity__c = 'Test Entity', // Make sure to set this value based on your test scenario
            ProfileId = standardProfile.Id // Assign the Standard User profile Id
        );
        insert testUser;

        // Create test data for SproutSocialApp__Sprout_Social_Post__c object
        Id parentId = '5005D000009P4Mo'; // Replace '001XXXXXXXXXXXX' with a valid Salesforce record Id
        SproutSocialApp__Sprout_Social_Post__c testPost = new SproutSocialApp__Sprout_Social_Post__c(
            SproutSocialApp__IsOutbound__c = false,
            SproutSocialApp__Posted__c = Datetime.now().addDays(-1), // Ensure this falls within business hours
            SproutSocialApp__ParentId__c = parentId
        );
        newSocialPosts.add(testPost);

        // Call the trigger handler method
        Test.startTest();
        UpdateCaseInfoTriggerHandler.onBeforeInsert(newSocialPosts);
        Test.stopTest();

        // Perform your assertions here based on the expected behavior of the trigger handler
        System.assertEquals(Datetime.now().addDays(-1), testPost.PostDate_Temporary__c);
    }

    @isTest
    public static void testOnBeforeInsert_BeforeBusinessHours() {
        // Create test data for a case where the post is before business hours
        // Add your test data here

        // Call the trigger handler method
        Test.startTest();
        // Call the trigger handler with the test data created above
        Test.stopTest();

        // Perform your assertions here based on the expected behavior of the trigger handler
    }

    @isTest
    public static void testOnBeforeInsert_AfterBusinessHours() {
        // Create test data for a case where the post is after business hours
        // Add your test data here

        // Call the trigger handler method
        Test.startTest();
        // Call the trigger handler with the test data created above
        Test.stopTest();

        // Perform your assertions here based on the expected behavior of the trigger handler
    }

    // Write more test methods to cover other scenarios, edge cases, and negative scenarios.*/
}