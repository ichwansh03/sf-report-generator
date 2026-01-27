public class HyperlinkController {
    public List<Hyperlink_Config__c> hyperlinkObj {get;set;}
             
    public HyperlinkController() {
        hyperlinkObj = new List<Hyperlink_Config__c>();

        try{
	        hyperlinkObj = [SELECT Name, Entity__c, Link__c, Link_Formula__c, Is_Active__c, Type__c From Hyperlink_Config__c WHERE Is_Active__c = true];
	        
	    }catch(Exception e){
	    	system.debug('Error message: ' + e.getMessage());
	    }
    }
}