@isTest
public class DependentPicklistController_Test {

    @isTest
    static void testPicklistController() {
        Test.startTest();
        Map<Object, List<String>> result = DependentPicklistController.getDependentPicklistValues('Call_List__c', 'Todo_List_Config__c');
        Test.stopTest();
        List<String> resultList = result.get('Renewal Reminder');
        system.assert(resultList != null);
        system.assert(resultList[0] == 'Verifikasi');
    }
}