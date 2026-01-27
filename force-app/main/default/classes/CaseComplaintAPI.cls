@RestResource(urlMapping='/SmartCHS/v1/*')
global class CaseComplaintAPI {

    private static final String AMFS = 'AMFS';
    private static final String COMPLAINT = 'Complaint';
    private static final String ANONYMOUS_AMFS = 'Anonymous AMFS';
    private static final String ENTITLEMENT_AMFS = 'Entitlement AMFS';

    global class CaseModel {
        public Contact contactObj {get;set;}
        public Account accountObj {get;set;}
        public List<Case> cases {get;set;}
        public List<CaseComment> caseComments {get;set;}
        public String entitlementIdAMFS {get;set;}
    }

    global class CaseRequest {
        public Map<String, Object> existing_case {get;set;}
    }

    global class CaseResponse {
        public Boolean success {get;set;}
        public List<String> errors {get;set;}
        public String case_number {get;set;}
        public String case_id {get;set;}
    }

    global class SyncAttachmentRequest {
        public String parent_id{get;set;}
    }

    global class SyncAttachmentResponse {
        public Boolean success {get;set;}
        public List<String> errors {get;set;}
        public String parent_id {get;set;}
    }
    
    @HttpGet
    global static CaseModel getCaseHistory() {
        CaseModel cm = new CaseModel();
        String policyNo = RestContext.request.params.get('policy_no');
        Map<String, Object> cMap = getCases(policyNo);
        cm.contactObj = getContact(policyNo);
        cm.accountObj = getAccount();
        cm.cases = (List<Case>) cMap.get('case-list');
        cm.caseComments = (List<CaseComment>) cMap.get('comment-list');
        cm.entitlementIdAMFS = getEntitlement();
        return cm;
    }

    @HttpPost
    global static CaseResponse addCase(Case new_case) {
        CaseResponse cr;
        if (new_case != null) {
            cr = new CaseResponse();
            try {
                if (String.isNotBlank(new_case.Id)) {
                    update new_case;
                }
                else {
                    if (new_case.Entity__c == AMFS && new_case.Type == COMPLAINT) {
                        new_case.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
                        // 18 Aug 2021, Assign to CMU Queue
						ID OwnerTemp = id.valueof(label.AMFS_CMU_QueueID);
                        new_case.ownerid = OwnerTemp;
                    }
                    insert new_case;
                }
                Case insertedCase = getCaseById(new_case.Id);
                cr.success = true;
                cr.errors = null;
                cr.case_number = insertedCase.CaseNumber;
                cr.case_id = insertedCase.Id;
            }
            catch (Exception e) {
                cr.success = false; cr.errors = new List<String>{e.getMessage() + '. ' + e.getStackTraceString()}; cr.case_number = null; cr.case_id = null;
            }
        }
        return cr;
    }

    public static Contact getContact(String policyNo) {
        Contact ct;
        DescribeSObjectResult dr = Contact.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM Contact WHERE Policy_No__c = :policyNo';
        q += ' ORDER BY CreatedDate DESC';
        List<Contact> ctList = Database.query(q);
        if (ctList != null && ctList.size() > 0) ct = ctList.get(0);
        if (ct == null) {
            ct = getAnonymousContact();
        }
        return ct;
    }

    public static Account getAccount() {
        Account acc;
        DescribeSObjectResult dr = Account.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM Account WHERE Entity__c = :AMFS';
        q += ' ORDER BY CreatedDate DESC';
        List<Account> accList = Database.query(q);
        if (accList != null && accList.size() > 0) acc = accList.get(0);
        return acc;
    }

    public static Contact getAnonymousContact() {
        Contact ct;
        DescribeSObjectResult dr = Contact.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM Contact WHERE Name = :ANONYMOUS_AMFS';
        q += ' ORDER BY CreatedDate DESC';
        List<Contact> ctList = Database.query(q);
        if (ctList != null && ctList.size() > 0) ct = ctList.get(0);
        return ct;
    }

    public static Map<String, Object> getCases(String policyNo) {
        String contactId;
        Contact ct;
        DescribeSObjectResult dr0 = Contact.getSObjectType().getDescribe();
        List<String> fieldList0 = new List<String>(dr0.fields.getMap().keySet());
        String fields0 = String.join(fieldList0, ',');
        String q0 = 'SELECT ' + fields0 + ' FROM Contact WHERE Policy_No__c = :policyNo';
        q0 += ' ORDER BY CreatedDate DESC';
        List<Contact> ctList = Database.query(q0);
        if (ctList != null && ctList.size() > 0) ct = ctList.get(0);
        if (ct != null) contactId = ct.Id;
        
        Map<String, Object> resultMap = new Map<String, Object>();
        List<Case> caseList = new List<Case>();
        DescribeSObjectResult dr = Case.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ', Contact.Policy_No__c, PIC__r.Name, Owner.Name, Back_Office_PIC__r.Name FROM Case WHERE Type = :COMPLAINT';
        if (String.isNotBlank(contactId)) {
            q += ' AND (ContactId = :contactId OR Policy_Number__c = :policyNo)';
        }
        else {
            q += ' AND Policy_Number__c = :policyNo';
        }
        q += ' ORDER BY CreatedDate DESC';
        caseList = Database.query(q);

        Map<String, Case> caseMap = new Map<String, Case>();
        Map<String, List<CaseComment>> commentMap = new Map<String, List<CaseComment>>();
        List<String> caseIdList = new List<String>();
        for (Case caseObj : caseList) {
            caseMap.put(caseObj.Id, caseObj);
            caseIdList.add(caseObj.Id);
        }
        DescribeSObjectResult dr2 = CaseComment.getSObjectType().getDescribe();
        List<String> fieldList2 = new List<String>(dr2.fields.getMap().keySet());
        String fields2 = String.join(fieldList2, ',');
        String q2 = 'SELECT ' + fields2 + ', CreatedBy.Name FROM CaseComment WHERE ParentId IN :caseIdList';
        q2 += ' ORDER BY CreatedDate ASC';
        List<CaseComment> commentList = Database.query(q2);
        for (Case caseObj : caseList) {
            List<CaseComment> caseCommentPerCaseList = new List<CaseComment>();
            for (CaseComment caseCommentObj : commentList) {
                if (caseCommentObj.ParentId == caseObj.Id) {
                    caseCommentPerCaseList.add(caseCommentObj);
                }
            }
            commentMap.put(caseObj.Id, caseCommentPerCaseList);
        }
        resultMap.put('case-map', caseMap);
        resultMap.put('case-list', caseList);
        resultMap.put('comment-map', commentMap);
        resultMap.put('comment-list', commentList);
        return resultMap;
    }

    public static String getEntitlement() {
        String result;
        Entitlement et;
        DescribeSObjectResult dr = Entitlement.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM Entitlement WHERE Name = :ENTITLEMENT_AMFS';
        q += ' ORDER BY CreatedDate DESC';
        List<Entitlement> etList = Database.query(q);
        if (etList != null && etList.size() > 0) et = etList.get(0);
        if (et != null) result = et.Id;
        return result;
    }

    public static Case getCaseById(String caseId) {
        Case cs;
        DescribeSObjectResult dr = Case.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(dr.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        String q = 'SELECT ' + fields + ' FROM Case WHERE Id = :caseId';
        q += ' ORDER BY CreatedDate DESC';
        List<Case> csList = Database.query(q);
        if (csList != null && csList.size() > 0) cs = csList.get(0);
        return cs;
    }
}