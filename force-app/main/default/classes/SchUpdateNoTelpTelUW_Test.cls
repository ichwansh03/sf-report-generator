@isTest(seeAllData = true)
public class SchUpdateNoTelpTelUW_Test {

    static testMethod void test_execute_UseCase1(){
        SchUpdateNoTelpTelUW obj01 = new SchUpdateNoTelpTelUW();
        obj01.execute(null);
    }
    
public static testmethod void test2() {
        Test.startTest();
        
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
    
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
		String polis='520-6350141';
        
		List<Contact> contList = [select id, policy_no__c, mobilephone from Contact where policy_no__c = :polis limit 1];
        Contact cont = contList[0];
        
        // update mobile phone on contact;
        cont.MobilePhone = '082119787243';
        update cont;
        
        String jobId = System.schedule('SchSendWhatsappLog Test', Label.SchSendWhatssapLog_Cron, new SchUpdateNoTelpTelUW());
        Test.stopTest();
    }    
}