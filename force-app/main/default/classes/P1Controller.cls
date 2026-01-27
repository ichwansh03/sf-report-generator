public class P1Controller {
    public string policyNo{get;set;}
    public string policyApp{get;set;}
    public string entity{get;set;}
    public string token{get;set;}


    public P1Controller(ApexPages.StandardController controller){
         CreateToken ct = new CreateToken();
         token = ct.getToken();
         
         List<Contact> contactList = [SELECT Id, Policy_No__c, Entity__c, PolicyApp__c, Phone, MobilePhone, HomePhone, Policy_Status__c, Policy_Effective_Date__c, Agent_Name__c, Agent_Code__c, Agent_Status__c, Premium__c, Segment_Name__c, Branch_Name__c, Branch_Code__c, Date_of_Accident__c, Driver__c, Accident_Place__c, Detail_of_Damage__c, Production_Year__c, Licence_Number__c, Machine_No__c, Chassis_no__c, Vehicle_Type__c, Color__c, Machine_Capacity__c FROM Contact WHERE ID =: controller.getID()];      
         if(contactList !=null && contactList.size()>0){
             policyNo = contactList[0].policy_no__c;
             policyApp = contactList[0].PolicyApp__c;
             entity = contactList[0].entity__c;
         }
    }
}