public class InteractionStatistic_Controller {
    public List<Case> listCase{get;set;}
    public List<pieDatas> PieData{get;set;}
    public Integer dataCount {get; set;}
    public Integer modCount {get; set;}
    String contactId = ApexPages.currentPage().getParameters().get('Id');
    
    public InteractionStatistic_Controller(ApexPages.StandardController controller){
        PieData = new List<pieDatas>();
        //listCase = [select Id, Origin, Status, CaseNumber, Case_Type__c, CreatedDate from Case where ContactId =:contactId ORDER BY CreatedDate DESC LIMIT 50000];
        listCase = getQueryCase(contactId);
        dataCount = listCase.size();
        
        modCount = 0;
        if(dataCount >= 10 && Math.mod(dataCount,10) != 0) {
            modCount = 10 - Math.mod(dataCount,10);
        }
        
        listPieData();
    }
    
    @ReadOnly
    @RemoteAction
    public static List<Case> getQueryCase(Id contactId) {
        List<Case> lc = [select Id, Origin, Status, CaseNumber, Case_Type__c, CreatedDate from Case where ContactId =:contactId ORDER BY CreatedDate DESC];
        return lc;
    }
    
    public void listPieData(){
        for(AggregateResult ar : [Select Count(Id) ids, Origin ori from Case where ContactId =:ContactId GROUP BY Origin]){
            Integer i = (Integer) ar.get('ids'); 
            Integer dec = i * 100 / dataCount ;
            String s = String.valueOf(dec) + '%';
            PieData.add(new pieDatas((String) ar.get('ori'), (Integer) ar.get('ids'), (String) s));
        }
    }
    
    public class pieDatas{
        public String name{get;set;}
        public Integer data{get;set;}
        public String percent {get;set;}
        public pieDatas(String nameValue, Integer dataValue, String percentValue){
            this.name = nameValue;
            this.data = DataValue;
            this.percent = percentValue;
        }
    }
}