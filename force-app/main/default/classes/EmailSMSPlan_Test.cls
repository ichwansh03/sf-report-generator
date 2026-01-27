@isTest //(seeAllData=true)
private class EmailSMSPlan_Test{
    static testMethod void myTest(){
        ApexPages.CurrentPage().getParameters().put('FieldDocument','');
        ApexPages.CurrentPage().getParameters().put('FieldBrandId','');
        ApexPages.CurrentPage().getParameters().put('FieldMatGroupId','');
        ApexPages.CurrentPage().getParameters().put('FieldModelId','');
        ApexPages.CurrentPage().getParameters().put('FieldMaterialId','');
        ApexPages.CurrentPage().getParameters().put('FieldBCId','');
        ApexPages.CurrentPage().getParameters().put('FieldAreaId','');
        ApexPages.CurrentPage().getParameters().put('FieldCabangId','');
        
        EmailSMSPlan b = new EmailSMSPlan();
        Test.startTest();
        //List<SelectOption> al = b.documentOption;
        String a = b.sPeriode;
        Date c = b.dateFrom;
        Date d = b.dateTo;
        Id f = b.username;
        //String g = b.sPosisi;
        String h = b.sStatus;
        b.runSearch();
        b.Save();
        List<SelectOption> z = b.dperiod;
        b.GetData();
        boolean xc = b.onOff;
        Test.stopTest();
        
    }
}