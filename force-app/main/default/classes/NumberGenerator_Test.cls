@isTest(seeAllData = true)
public class NumberGenerator_Test {
	public static testmethod void numberGeneratorTest() {
        Test.startTest();
        NumberGenerator ng = new NumberGenerator();
        ng.getNumber('MAGI');
        
        Test.stopTest();
    }
}