@isTest
public class DuplicateActiveLeaveTest {
    @isTest static void DuplicateActiveLeave(){
        Test.startTest();
        DuplicateActiveLeave sh1 = new DuplicateActiveLeave();
        String sch = '0 0 2 * * ?'; 
        system.schedule('Test Duplicate Active Leave', sch, sh1); 
        Test.stopTest();
        // add system asserts to check your expected behaviour
    }
}