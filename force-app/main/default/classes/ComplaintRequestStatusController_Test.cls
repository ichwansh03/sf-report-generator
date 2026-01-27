@isTest 
public class ComplaintRequestStatusController_Test{

     public static testMethod void Email2CaseControllerTest(){
     	List<Case> caseList = new List<Case>();
     	
     	Case cs1 = new Case();
     	cs1.Entity_Backup__c = 'AFI';
     	cs1.Status = 'New';
     	cs1.CHS_Status__c = 'New';
     	caseList.add(cs1);
     	
     	Case cs2 = new Case();
     	cs2.Entity_Backup__c = 'AMFS';
     	cs2.Status = 'New';
     	cs2.CHS_Status__c = 'New';
     	caseList.add(cs2);
     	
     	insert caseList;
     	
     	ApexPages.StandardController sc = new ApexPages.StandardController(cs1);
 		ComplaintRequestStatusController crs = new ComplaintRequestStatusController(sc);	
     }
}