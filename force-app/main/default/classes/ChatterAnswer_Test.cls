@isTest(seeAllData = true)
public class ChatterAnswer_Test {
    public static testmethod void chatterAnswerTest() {
        Test.startTest();
        String firstName = 'Bill';
        String lastName = 'Gates';
        String userId = UserInfo.getUserId();
        
        ChatterAnswers ca = new ChatterAnswers();
        ca.createAccount(firstName, lastName, userId);
        
        Test.stopTest();
    }
}