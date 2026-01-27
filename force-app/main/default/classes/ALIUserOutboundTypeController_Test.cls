@isTest(seeAllData=true)
public class ALIUserOutboundTypeController_Test {
    private static testMethod void setupTestData() {
        Test.startTest();
        
        PageReference pageRef = new PageReference('/apex/Outbound_Activity_Case_type');
        pageRef.getParameters().put('FieldDocument', ',');
        pageRef.getParameters().put('FieldBrandId', ',');
        pageRef.getParameters().put('FieldMatGroupId', ',');
        pageRef.getParameters().put('FieldModelId', ',');
        pageRef.getParameters().put('FieldMaterialId', ',');
        pageRef.getParameters().put('FieldBCId', ',');
        pageRef.getParameters().put('FieldAreaId', ',');
        pageRef.getParameters().put('FieldCabangId', ',');
        Test.setCurrentPage(pageRef);
        
        ALIUserOutboundTypeController auot = new ALIUserOutboundTypeController();
        String sPeriode1 = auot.sPeriode;
        Date dateFrom1 = auot.dateFrom;
        Date dateTo1 = auot.dateTo;
        String sortDir1 = auot.sortDir;
        String sortField1 = auot.sortField;
        Id username1 = auot.username;
        String valueperiod1 = auot.valueperiod;
        
        auot.runSearch();
        auot.Save();
        
        Test.stopTest();
    }
}