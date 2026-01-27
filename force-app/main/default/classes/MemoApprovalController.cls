public without sharing class MemoApprovalController {
    public Case chsCase {get;set;}
    public String numberCounter {get;set;}
    public Integer month {get;set;}
    public Integer year {get;set;}
    public String entitas {get;set;}
    //public String estimatedLoss {get;set;}
    public String Manager {get;set;}
    public String DeputyCOO {get;set;}
    public String CFO {get;set;}
    public String Dirut {get;set;}
 	         
    public String getPrintView(){
        return
        '<!--[if gte mso 9]>' +
            '<xml>' +
            '<w:WordDocument>' +
            '<w:View>Print</w:View>' +
            '<w:Zoom>100</w:Zoom>' +
            '<w:DoNotOptimizeForBrowser/>' +
            '</w:WordDocument>' +
            '</xml>' +
        '<![endif]>';
    }
             
    public MemoApprovalController(ApexPages.StandardController stdCtrl) {
        chsCase = new Case();

        try{
	        Case complaintCase = (Case)stdCtrl.getRecord();
	        month = Date.Today().Month();
	        year = Date.Today().Year();
	        
	        chsCase = [SELECT CreatedDate, Lampiran__c, Subject, ContactId, Contact.Name, Entity__c, Insured_Name__c, Policy_Numbers__c, Policy_Effective_Date__c,
						Policy_Status__c, Premium__c, Product__c, Agent_Name__c, Agent_Code__c, Agent_Status__c, Region__c, Segment_Name__c, Recommendation__c,
						Branch_Name__c, Description__c, Demand__c, Chronological__c, Financial_Lost__c, Financial_Lost_Currency__c 
			            FROM Case WHERE Id = :complaintCase.Id];
	        
	        entitas = chsCase.Entity__c;
	        
	        //estimatedLoss = chsCase.Financial_Lost_Currency__c+ ' ' +chsCase.Financial_Lost__c;
	        
	        //Query for MAGI memo approval
	       	List<User> usrManager =  [SELECT id, name, UserRole.name FROM User WHERE userRole.name = 'CCC Manager MAGI' AND entity__c = 'MAGI'];
	        if(usrManager.size() > 0){
	        	Manager = usrManager[0].Name;
	        }
	        else{
	        	Manager = '...............';
	        }
	        
	       	List<User> usrDeputy =  [SELECT id, name, UserRole.name FROM User WHERE userRole.name = 'Deputy COO MAGI' AND entity__c = 'MAGI'];
	        if(usrDeputy.size() > 0){
	        	DeputyCOO = usrDeputy[0].Name;
	        }
	        else{
	        	DeputyCOO = '...............';
	        }
	        /*
	        List<User> usrCFO =  [SELECT id, name, UserRole.name FROM User WHERE userRole.name = 'Finance Head MAGI' AND entity__c = 'MAGI'];
	        if(usrCFO.size() > 0){
	        	CFO = usrCFO[0].Name;
	        }
	        else{
	        	CFO = '...............';
	        }
	        
	        List<User> usrDirut =  [SELECT id, name, UserRole.name FROM User WHERE userRole.name = 'CEO MAGI' AND entity__c = 'MAGI'];
	        if(usrDirut.size() > 0){
	        	Dirut = usrDirut[0].Name;
	        }
	        else{
	        	Dirut = '...............';
	        }
	        */
	        CFO = system.label.CFO_Magi;
	        Dirut = system.label.CEO_Magi;
	    }catch(Exception e){
	    	system.debug('Error message: ' + e.getMessage());
	    }
    }
    
    public void dmlOperation() {
        
        if(entitas=='AMFS'){
        	NumberGenerator numGen = new NumberGenerator();
        	numberCounter = numGen.getNumber('AMFS');
        }
        if(entitas=='AFI'){
        	NumberGenerator numGen = new NumberGenerator();
        	numberCounter = numGen.getNumber('AFI');
        }      
    }
    
    public void dmlOperationMAGI() {
        NumberGenerator numGen = new NumberGenerator();
        numberCounter = numGen.getNumber('MAGI');      
    }
}