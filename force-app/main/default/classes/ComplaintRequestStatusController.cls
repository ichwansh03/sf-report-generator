public class ComplaintRequestStatusController {
	public Case chsCase {get;set;}
	public List <String> requestStatusList {get; set;}
	public List <String> StatusList {get; set;}
	public String requestStatus {get; set;}
	public String Status {get; set;} 
	public String requestStatusListJSON {get; set;}
	public String StatusListJSON {get; set;}
	
    public ComplaintRequestStatusController(ApexPages.StandardController controller) {
    	
    	//caseId = controller.getID();
    	chsCase = new Case();
    	Case complaintCase = (Case)controller.getRecord();
    	
    	try {
    	chsCase = [SELECT CHS_Status__c, Entity__c, Status FROM Case WHERE Id = :complaintCase.Id];
			            
    	requestStatus = chsCase.CHS_Status__c;
    	status = chsCase.Status;
    	
    	Schema.DescribeFieldResult fieldResult = Case.CHS_Status__c.getDescribe();    
        List<Schema.picklistEntry> ple = fieldResult.getPicklistValues();    
        
        requestStatusList = new List <String>();
        for(Schema.picklistEntry f:ple)    
        {    
            //options.add(new selectOption(f.getLabel(),f.getValue()));  
            requestStatusList.add (f.getValue()) ;
        }
        
        requestStatusListJSON = JSON.serialize(requestStatusList);
        
        //Get alll Status picklist for Case Request (added by Hamfry)
        Schema.DescribeFieldResult fieldResult2 = Case.Status.getDescribe();    
        List<Schema.picklistEntry> plEntry = fieldResult2.getPicklistValues();    
        
        StatusList = new List <String>();
        
        for(Schema.picklistEntry f: plEntry){    
            StatusList.add (f.getValue()) ;
        }
        
        StatusListJSON = JSON.serialize(StatusList);
        
        system.debug('============ requestStatusList : ' + requestStatusList);
    	}
    	catch (Exception e) {
    		system.debug('============ errorMessage : ' + e.getMessage());
    	}
    	system.debug('============ requestStatus : ' + requestStatus);
    }
    
}