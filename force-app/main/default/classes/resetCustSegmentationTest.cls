@isTest
public class resetCustSegmentationTest {
    
    @testSetup
    static void setupRecord() {
        Profile p2 = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u2 = new User(
            LastName='Testing2',
            Alias = 'standt2', 
            Email='standarduser1@axa.com', 
            EmailEncodingKey='UTF-8', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US',
            ProfileId = p2.Id,
            TimeZoneSidKey='America/Los_Angeles',
            Entity__c ='AMFS',
            UserName='standarduser1@axa.com'
        );
        insert u2;
    }
	
    public static testMethod void resetCust() {
        User u = [SELECT Id FROM User WHERE UserName = 'standarduser1@axa.com' LIMIT 1];
        Contact ct = new Contact();
        ct.Policy_No__c='123-12345';
        ct.Cust_Segmentation__c='Private';
        ct.LastName ='TestCT';
        ct.Entity__c='AMFS';
        insert ct;
        
        Test.startTest();
            UpdateContactBatchable be = new UpdateContactBatchable(null, false, u.Id, null);
			database.executeBatch(be, 30);
        
        Test.setCurrentPage(Page.resetCustSegmentationPage);
        ApexPages.StandardController con = new ApexPages.StandardController(ct);
        resetCustSegmentationCtrl rCust = new resetCustSegmentationCtrl(con);
        rCust.resetValueToRegular();
        Test.stopTest();
    }
}