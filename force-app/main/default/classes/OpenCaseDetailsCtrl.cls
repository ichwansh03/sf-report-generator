public class OpenCaseDetailsCtrl {
    private String contactId;
    public String strStartProcess {get; set;}
    public Contact ct {get; set;}
   	integer totalRecs = 0;
   	public Integer count {get; set;}
   	public Integer LimitSize {get; set;} 
    public Integer tot { get; set; }
    public Integer currentTot { get; set; }
    Integer lastSizeData=0;
    
    public OpenCaseDetailsCtrl(){
        contactId = ApexPages.CurrentPage().getParameters().get('ct');
        strStartProcess = Datetime.now().format('dd-MM-yyyy HH:mm:ss', 'Asia/Jakarta');
        if(contactId != null){
        	ct = [select id, name from Contact where id =: contactId];   
        }
        LimitSize = System.LABEL.rowPerPage.Isnumeric() ? Integer.valueOf(System.LABEL.rowPerPage): 5;
        count = 0;
        currentTot=getCases().size();
    }
    
    public List<Case> getCases(){
        LIST<Case> cases = new LIST<Case>();
        if(contactId != null){
            cases = [Select id, casenumber, subject, contactid, contact.name, contact.policy_no__c, priority, status, 
                     createddate, lastmodifieddate from CASE
                    where contactid =: contactId and (not status like '%Closed%')
                    order by lastmodifieddate, status desc LIMIT:limitsize OFFSET:count];
            tot = totalRecs = [select count() FROM CASE where contactid =: contactId and (not status like '%Closed%')];
        }
        
        lastSizeData= cases.size();
        return cases;
    }
    
     public PageReference Firstbtn() {
     	count=0;
        currentTot = getCases().size();
        return null;
    }
      public PageReference prvbtn() {
      	count=count-limitsize;
        currentTot = currentTot - lastSizeData;
        getCases();
        return null;
    }
   
 	public PageReference Nxtbtn() {
 		count=count+limitsize;
        currentTot = currentTot +getCases().size();
        
        return null;
    }
 	public PageReference lstbtn() {
 		count= totalrecs - math.mod(totalRecs,LimitSize);
        getCases();
        currentTot=totalrecs;
        return null;
    }

    public Boolean getNxt() {
        if((count+ LimitSize) > totalRecs)
       return true;
     	else
       return false;
    }
     public Boolean getPrv() {
      if(count== 0)
          return true;
        else
          return false;
     }
}