@isTest
public class callLineReport_TestClass {
    @isTest static void callreport(){
        CallLineReport_c cReport = new CallLineReport_c();
        cReport.filter();
        cReport.startDate = date.today();
        cReport.endDate = date.today()-1;
        
        cReport.getListOfAgentbySVP();
    }
    
    @isTest static void detailReport(){
        ProductivityDetail_Ctrl productivityDetail_Ctrl = new ProductivityDetail_Ctrl();
        
        PageReference pg = Page.ProductivityDetail_vf;
        pg.getParameters().put('act','Contacted');
        pg.getParameters().put('st',Date.today().format());
        pg.getParameters().put('en',Date.today().format());
        pg.getParameters().put('own','123');
        Test.setCurrentPage(pg);
        productivityDetail_Ctrl.getDetails();
        
        pg.getParameters().put('act','Closed');
        Test.setCurrentPage(pg);
        productivityDetail_Ctrl.getDetails();
        
        
        pg.getParameters().put('act','Attempt');
        Test.setCurrentPage(pg);
        productivityDetail_Ctrl.getDetails();
    }
}