public class RDSBoxController {

    public String searchRDS {get; set;}
    public String selectEntries {get; set;}
    public Integer pageNumber {get; set;}
    public Integer resultSize {get; set;}
    public String firstId {get; set;}
    public String lastId {get; set;}
    public Boolean showExport {get; set;}
    public transient List <RDS_Box__c> findRDS {get; set;}
    public List<RDS_Box__c> exportRDS {get; set;}
    public ApexPages.StandardSetController listRDS {get; private set;}
    
    public RDSBoxController() {
        showExport = false;
        selectEntries = '25';
        
        resultSize = [SELECT count() FROM RDS_Box__c];
        
        showExport = true;
        
        searchRDSBox();
        entries();
    }
    
    public PageReference searchRDSBox() {
        listRDS = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, No_Box__c, Policy_No__c, Queue_No__c FROM RDS_Box__c ORDER BY CreatedDate DESC LIMIT 10000]));

        if (String.isNotBlank(searchRDS)) {
            String searchs = '%'+searchRDS.trim()+'%';
            listRDS = new ApexPages.StandardSetController([SELECT No_Box__c, Policy_No__c, Queue_No__c FROM RDS_Box__c WHERE Policy_No__c LIKE :searchs OR Queue_No__c LIKE :searchs]);
        }
        return null;
    }
    
    public PageReference exportRDS() {
     
        Report r = [SELECT Id, Name FROM Report WHERE Name = 'RDS No.Box Document'];
        
        return new PageReference('/'+r.Id+Label.Export_Report_to_Excel);
    }
    
    public List<RDS_Box__c> getBoxs() {
        return listRDS.getRecords();
    }
    
    public void entries(){
        listRDS.setPageSize(Integer.valueOf(selectEntries));
        pageNumber = listRDS.getPageNumber();
    }
    
    public void next(){
        listRDS.next();
        pageNumber = listRDS.getPageNumber();
    }
    
    public void previous(){
        listRDS.previous();
        pageNumber = listRDS.getPageNumber();
    }
    
    public void first(){
        listRDS.first();
        pageNumber = 1;
    }
    
    public void last(){
        listRDS.last();
        pageNumber = listRDS.getPageNumber();
    }
}