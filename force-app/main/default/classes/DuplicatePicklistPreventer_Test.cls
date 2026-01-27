@isTest
public class DuplicatePicklistPreventer_Test {

     public static testMethod void myTest(){
     	List<SLA_Setting__c> slaList1 = new List<SLA_Setting__c>();
     	SLA_Setting__c sla1 = new SLA_Setting__c();
     	sla1.Case_Type__c = 'Testing123';
     	sla1.Entity__c = 'AMFS';
     	sla1.Type__c = 'Request';
     	sla1.Is_Calendar__c = false;
     	sla1.Service_SLA__c = 1;
     	sla1.Unit__c = 'Day';
     	slaList1.add(sla1);
     	
     	/*
     	SLA_Setting__c sla2 = new SLA_Setting__c();
     	sla2.Entity__c = 'AMFS';
     	sla2.Type__c = 'Complaint';
     	sla2.Complaint_Type__c = 'Simple';
     	sla2.Nature__c = 'Claim';
     	sla2.Category__c = 'Claim Delay';
     	sla2.Is_Calendar__c = false;
     	sla2.Service_SLA__c = 2;
     	sla2.Unit__c = 'Day';
     	slaList.add(sla2);
     	*/
     	insert slaList1;
     	
     	List<SLA_Setting__c> slaList2 = new List<SLA_Setting__c>();
     	SLA_Setting__c sla3 = new SLA_Setting__c();
     	sla3.Case_Type__c = 'Testing123';
     	sla3.Entity__c = 'AMFS';
     	sla3.Type__c = 'Request';
     	sla3.Is_Calendar__c = false;
     	sla3.Service_SLA__c = 2;
     	sla3.Unit__c = 'Day';
     	slaList2.add(sla3);
     	
     	insert slaList2;
     }
}