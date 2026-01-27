@isTest
public class RDSBoxController_Test {

    @testSetup
    static void setupData() {
        List<RDS_Box__c> rdsBoxes = new List<RDS_Box__c>();
        for (Integer i = 0; i < 150; i++) {
            rdsBoxes.add(new RDS_Box__c(Box_Key__c = '156-IMGO-16'+i+'_30909150452_515-7179'+i, No_Box__c = '156-IMGO-16'+i));
        }
        insert rdsBoxes;
    }
    
    @isTest
    static void controllerTest() { 
        Test.startTest();
        RDSBoxController controller = new RDSBoxController();
        controller.entries();
        controller.getBoxs();
        controller.searchRDSBox();
        Test.stopTest();
    }
    
    @isTest
    static void paginationTest() {
        Test.startTest();
        RDSBoxController controller = new RDSBoxController();
        controller.first();
        controller.last();
        controller.next();
        controller.previous();
        System.assertEquals(25, controller.listRDS.getPageSize());

        System.assertEquals(5, controller.pageNumber);
        System.assertEquals(150, controller.resultSize);
        System.assertEquals(true, controller.showExport);
        
        controller.selectEntries = '50';
        controller.listRDS.setPageSize(50);
        System.assertEquals(Integer.valueof(controller.selectEntries), controller.listRDS.getPageSize());
        
        controller.selectEntries = '100';
        controller.listRDS.setPageSize(100);
        System.assertEquals(100, controller.listRDS.getPageSize());
        Test.stopTest();
    }
}