@isTest
public class RelatedPolicyControllerTest {
/*
* This test class was edited by Hamfry A. L on Jun 9, 2015 to be re-deployed to production
*
*/
    public static testMethod void testRelatedPolicyController() {
    	Profile profil = [SELECT Id FROM Profile WHERE Name='CMU-AFI'];
    	User usr  = [SELECT id, Entity__c FROM user WHERE ProfileId = :profil.id AND IsActive = true limit 1];
    	
    	System.runAs(usr) {
    		Call_List__c clist = new Call_List__c();
	    	clist.Expired_Date__c = system.today();
	    	insert clist;  	
	    	
	    	Contact c = new Contact();
	    	c.LastName = 'Frys';
	    	c.Policy_No__c = '123-5555';
	    	c.Entity__c = 'AFI';
	    	insert c;
	    	    	
	    	Call_Line__c cl = new Call_Line__c();
	    	cl.Call_List__c = clist.id;
	    	cl.Used_Phone__c = '0811223344';
	    	cl.Preferred_Phone__c = '0822334455';
	    	cl.Date_When_Customer_Call__c = system.today();
	    	cl.Entity__c = 'AFI';
	    	cl.Contact__c = c.Id;
	    	insert cl;
	    	
	    	Related_Policy__c relPol = new Related_Policy__c();
	    	relPol.Call_Back__c = cl.id;
	    	relPol.Contact_ID__c = c.id;
	    	relPol.Customer_Name__c = 'frys';
	    	relPol.Policy_No__c = '123-5555';
	    	insert relPol;
	    	
	    	ApexPages.StandardController sc = new ApexPages.StandardController(cl);
	    	RelatedPolicyController testRelatedPolicyController = new RelatedPolicyController(sc);
	    	List<RelatedPolicyController.RelatedPolicyView> list_rpv = new List<RelatedPolicyController.RelatedPolicyView>();
	        RelatedPolicyController.RelatedPolicyView rpv = new RelatedPolicyController.RelatedPolicyView();
	        rpv.isSelected = true;
	        rpv.customerName = 'testing';
	        rpv.policyNo = '123-666';
	        list_rpv.add(rpv);
	        List<Related_Policy__c> lst_relatedPlc = new List<Related_Policy__c>();
	        testRelatedPolicyController.selectPolicy();
	        testRelatedPolicyController.cancel();
	        testRelatedPolicyController.runclick();
    	}
    }
}