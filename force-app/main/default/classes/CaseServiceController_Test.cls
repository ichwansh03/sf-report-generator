@isTest
public class CaseServiceController_Test {
    private final static String RECORD_TYPE_REQUEST_CASE = 'RequestAMFSCase';
    private final static String RECORD_TYPE_INQUIRY_CASE = 'InquiryAMFSCase';
    private final static String RECORD_TYPE_COMPLAINT_CASE = 'AMFSComplaintCase';
    
	@testSetup static void setup() {
        List<Contact> contList = new List<Contact>();
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '500-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP KONV';
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '300-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP SYA';
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '801-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP CORP';
        contList.add(cont);
        Insert contList;
    }
    
    static testmethod void testCreateTypeInquiry(){
        Case cs = new Case();
        cs.recordTypeId = getRecordTypeCaseId(RECORD_TYPE_INQUIRY_CASE);
        cs.ContactId = getContactIDbyPolicyNo('500-1110001');
        cs.Subject = 'Subject Dummy Inquiry';
        cs.Origin = 'Walk-In';
        cs.NonPP__c = false;
        cs.General_Attitude__c = 'Normal';
        cs.Case_Type__c = cs.Case_Type_Config__c = '';
        cs.Type = 'Inquiry';
        cs.Description = 'Description Dummy Inquiry';
        
        CaseServiceController caseService = new CaseServiceController();
        List<Case> resultSave = caseService.processInquirySaveWithClosedStatus(cs, new String[]{''});
        for(Integer i=0; i<resultSave.size(); i++){
            Case resultCase = resultSave[i];
            System.assertEquals(true, resultSave != null);
        }
    }
    
    static testmethod void testCreateTypeRequest(){
        Case cs = new Case();
        cs.recordTypeId = getRecordTypeCaseId(RECORD_TYPE_REQUEST_CASE);
        cs.ContactId = getContactIDbyPolicyNo('500-1110001');
        cs.Subject = 'Subject Dummy Request';
        cs.Origin = 'Walk-In';
        cs.NonPP__c = false;
        cs.General_Attitude__c = 'Normal';
        cs.Case_Type__c = cs.Case_Type_Config__c = '';
        cs.Type = 'Request';
        cs.Description = 'Description Dummy Request';
        cs.Status = 'Closed';
        
        CaseServiceController caseService = new CaseServiceController();
        caseService.getCekCourierCase(cs);
        Case resultSave = caseService.processRequestSave(cs, 'AMFS');
        if(resultSave != null){
            System.assertEquals(true,resultSave.id != null);
        }
	}
    
    static testmethod void testCreateTypeComplaint(){
        Case cs = new Case();
        cs.recordTypeId = getRecordTypeCaseId(RECORD_TYPE_COMPLAINT_CASE);
        cs.ContactId = getContactIDbyPolicyNo('100-000-1110001');
        cs.Subject = 'Subject Dummy Complaint';
        cs.Origin = cs.Channel__c = 'Walk-In';
        cs.NonPP__c = false;
        cs.General_Attitude__c = 'Normal';
        cs.Case_Type__c = cs.Case_Type_Config__c = '';
        cs.Type = 'Complaint';
        cs.Nature_Config__c = 'Administrative procedures';
        cs.Category_Config__c = 'CS-Missing document';
        cs.Business_channel__c = cs.Product__c = 'TM';
        cs.Customer__c = cs.Complainant__c = 'Customer';
        cs.Customer_type__c = 'Regular';
        cs.Complaint_type__c = 'Simple';
        cs.Priority = 'Medium';
        cs.Description__c = 'Description Dummy Complaint';
        cs.Received_date__c = Date.today();
        
        CaseServiceController caseService = new CaseServiceController();
        caseService.getCekCourierCase(cs);
        Case resultSave = caseService.processComplaintSave(cs, 'AMFS');
        if(resultSave != null){
            System.assertEquals(true,resultSave.id != null);
        }
	}
    
    private static ID getContactIDbyPolicyNo(String policyNo){
        id contId = null;
        Contact[] resultContact = [SELECT id FROM Contact WHERE Policy_No__c = :policyNo LIMIT 1];
        if(resultContact.size() > 0){
            contId = resultContact[0].id;
        }
        
        return contId;
    }
    
    private static ID getRecordTypeCaseId(String Recordtype){
        return Schema.SObjectType.Case.getRecordTypeInfosByName().get(Recordtype).getRecordTypeId();
    }
}