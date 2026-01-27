@isTest
public class RowIteratorUtil_Test {
	private static testMethod void setupTestData() {
        Test.startTest();
        RowIteratorUtil riu = new RowIteratorUtil('test,test,test', ',');
        RowIteratorUtil riu2 = new RowIteratorUtil('test,test,test');
        riu.Iterator();
        List<String> bodyList = new List<String>();
        while (riu.hasNext()) {
            bodyList.add(riu.next());
        }
        Test.stopTest();
    }
}