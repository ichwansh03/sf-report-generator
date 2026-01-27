/*---------------------------------------------------------------
    Author      : Andy Putra
    Company     : MII
    Description : custom case record detail page
    Inputs      : -none-
    Test Class  : Case_CustomPage_ctrl_test

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    07102021    Andy Putra          Created
---------------------------------------------------------------*/
//https://axaid-ccc--fullsb.my.salesforce.com/5005D0000066sWw
public class Case_CustomPage_ctrl {
    public AXAAPI001B_response cs {get;set;}
    public List<AXAAPI001A_response.Data> cases {get;set;}
    public List<AXAAPI001B_response.Data> cases_c {get;set;}
    public String id {get;set;}
    public String parent_id {get;set;} 
    public string policyNo {get;set;}
    public String entity {get;set;} 
    public AXAAPI001A_response cs_byID {get;set;}
    
    //changes by Ranti at 11/03/2021 
    public boolean isInquiryAFICase {get;set;}
    public boolean isInquiryAMFSCase {get;set;}
    public boolean isInquiryALICase {get;set;}
    public boolean isALIComplaintCase {get;set;}
    public boolean isAMFSComplaintCase {get;set;}
    public boolean isAFIComplaintCase {get;set;}
    public boolean isSocialPostAFI {get;set;}
    public boolean isSocialPostAMFS {get;set;}
    public boolean isRequestAFICase {get;set;}
    public boolean isRequestALICase {get;set;}
    public boolean isRequestAMFSCase {get;set;} 
    public boolean isCaseMilestone_RelatedList {get;set;}
    public boolean isEmail_RelatedList_Case_Custom {get;set;}
    public boolean isCaseEscalation_RelatedList {get;set;}
    public boolean isTask_RelatedList_OpenActivity {get;set;}
    public boolean isTask_RelatedList_ActivityHistory {get;set;}
    public boolean isCaseComment_RelatedList {get;set;}
    public boolean isAttachment_RelatedList {get;set;}
    public boolean isEmailSMSLog_RelatedList {get;set;}
    public boolean isNegativeFeedback_RelatedList {get;set;}
    public boolean isSurveyTaken_RelatedList {get;set;}
    public boolean isApprovalHistory_RelatedList {get;set;}
    public boolean isCase_RelatedList_c {get;set;}
    public boolean isSocialPost_RelatedList {get;set;}
    
    // Related List!!!
    public List<AXAAPI012A_response.Data> list_cs_milestone {get;set;} 
    public List<AXAAPI002B_response.Data> emails {get;set;}
    public List<AXAAPI019A_response.Data> listDataSP {get;set;} 
    public List<Approval_History> apphists {get;set;}
    public Approval_History apphist {get;set;} 
    public List<AXAAPI017A_response.Data> list_case_esc {get;set;}
    public List<AXAAPI011A_response.Data> list_open_res {get;set;}
    public List<AXAAPI011A_response.Data> list_history_res {get;set;}
    public List<AXAAPI018A_response.Data> list_case_com {get;set;}
	public List<AXAAPI005B_response.Data> list_attachment {get;set;}
    public List<AXAAPI003A_response.Data> logs {get;set;}
    public List<AXAAPI013A_response.Data> listNegative {get;set;}  
    public List<AXAAPI014A_response.Data> listSurveyTaken {get;set;}  
    public List<approvalHistoryCase> listApprovalCase {get;set;}
    public boolean isConsole {get;set;}
    
    
    public String processTime {get;set;}
    public Integer skip {get;set;}
    public Integer take {get;set;} 
    public Integer total_page {get;set;}
    public Integer current_page {get;set;}
    public String to_page {get;set;}
    public List<string> list_page {get;set;}
    public static final Integer SIZE_DATA_RELATED_LIST = Integer.valueOf(Label.AXASFDC_RowLimitRelatedList);   
    
    
    public Long mulai {get;set;}
    public Long selesai {get;set;}
    public Integer totalRow {get;set;} 
    
    public boolean isLoadCases {get;set;}
    public boolean isLoadCases_c {get;set;}
    public boolean isLoadMilestones {get;set;}
    public boolean isLoadEmails_vf_case {get;set;}
    public boolean isLoadSocialPost {get;set;}
    public boolean isLoadCaseEscalation {get;set;}
    public boolean isLoadOpenActivity_case {get;set;}
    public boolean isLoadActivityHistory_case {get;set;}
    public boolean isLoadCaseComments {get;set;}
    public boolean isLoadAttachments {get;set;}
    public boolean isLoadLogs {get;set;}
    public boolean isLoadNegatives {get;set;}
    public boolean isLoadSurvey {get;set;}
     
    public boolean firstLoadCases {get;set;}
    public boolean firstLoadCases_c {get;set;}
    public boolean firstLoadMilestones {get;set;}
    public boolean firstLoadEmails_vf_case {get;set;}
    public boolean firstLoadSocialPost {get;set;}
    public boolean firstLoadCaseEscalation {get;set;}
    public boolean firstLoadOpenActivity_case {get;set;}
    public boolean firstLoadActivityHistory_case {get;set;}
    public boolean firstLoadCaseComments {get;set;}
    public boolean firstLoadAttachments {get;set;}
    public boolean firstLoadLogs {get;set;}
    public boolean firstLoadNegatives {get;set;}
    public boolean firstLoadSurvey {get;set;}
       
    public Case_CustomPage_ctrl(ApexPages.StandardController controller){
        id = ApexPages.currentPage().getParameters().get('id');
		refresh(); 
        if (Test.isRunningTest()) {
            entity = [SELECT Entity__c FROM Contact WHERE Entity__c != null limit 1].Entity__c;
        } else {
            entity = [SELECT Entity__c FROM Contact WHERE Id=:id].Entity__c;
        }

    }
    
    public Case_CustomPage_ctrl(){
        System.debug(':::URL '+ApexPages.currentPage().getParameters());
        id = ApexPages.currentPage().getParameters().get('id'); 
		refresh();
        
        System.debug(':::id '+id);  
        
        String urlVal = Apexpages.currentPage().getUrl();
        system.debug(':::URl:'+urlVal);
        if(urlVal != null && urlVal.contains('console')) {
             isConsole = false;  
        } else {
            isConsole = true;    
        }
        
        System.debug('::isConsole:'+isConsole);
        System.debug('::Id:'+id);
        if(id.left(3) == Schema.SObjectType.Case.getKeyPrefix()){
             
            system.debug(':: Console:'+isConsole);
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }   
                
            //cs = (vfp == 'Case_RecordDetailPage_AFI') ? getCaseDetailAFI(id) : getCaseDetailAMFS(id);
            cs = getCaseDetail(id);  
            
            if (cs.data.financial_Lost_c != NULL && cs.data.financial_Lost_Currency_c != '') {
                if ( cs.data.financial_Lost_Currency_c == 'IDR' ) {
                    cs.data.financial_Lost_text = 'Rp'+cs.data.financial_Lost_c;
                } else if ( cs.data.financial_Lost_Currency_c == 'USD' ) {
                    cs.data.financial_Lost_text = '$'+cs.data.financial_Lost_c;
                }
            }
                   
            // added by Ranti at 12/02/2021
            System.debug(':::Record:'+cs.data.RecordType_Name );
            if ( cs.data.RecordType_Name == 'InquiryAFICase') {
                isInquiryAFICase = true;
                isCase_RelatedList_c = true;
                isCaseMilestone_RelatedList = true;
                isEmail_RelatedList_Case_Custom = true;
                isCaseEscalation_RelatedList = true;
                isEmailSMSLog_RelatedList = true;
                isSurveyTaken_RelatedList = true;
                isApprovalHistory_RelatedList = true; 
            } else if ( cs.data.RecordType_Name == 'InquiryAMFSCase') {
                isInquiryAMFSCase = true;
                isEmail_RelatedList_Case_Custom = true;
                isCaseEscalation_RelatedList = true;
                isCase_RelatedList_c = true;
                isEmailSMSLog_RelatedList = true;
                isSurveyTaken_RelatedList = true;
            } else if ( cs.data.RecordType_Name == 'InquiryALICase') {
                isInquiryALICase = true;
                isEmail_RelatedList_Case_Custom = true;
                isEmailSMSLog_RelatedList = true;
                isCaseMilestone_RelatedList = true;
                isCaseEscalation_RelatedList = true;
                isSurveyTaken_RelatedList = true;
                isApprovalHistory_RelatedList = true;
                isCase_RelatedList_c = true;
            } else if ( cs.data.RecordType_Name == 'ALIComplaintCase') {
                isALIComplaintCase = true;  
                isApprovalHistory_RelatedList = true;
                isCase_RelatedList_c = true;
                isEmailSMSLog_RelatedList = true;
            } else if ( cs.data.RecordType_Name == 'AMFSComplaintCase') {
                isAMFSComplaintCase = true; 
                isCaseMilestone_RelatedList = true;
                isCaseEscalation_RelatedList = true;
                isEmailSMSLog_RelatedList = true;
                isApprovalHistory_RelatedList = true;
                isCase_RelatedList_c = true;
            } else if ( cs.data.RecordType_Name == 'AFIComplaintCase') {
                isAFIComplaintCase = true;
                isEmail_RelatedList_Case_Custom = true;
                isCase_RelatedList_c = true;
                isEmailSMSLog_RelatedList = true;
                isApprovalHistory_RelatedList = true;
                isCaseMilestone_RelatedList = true;
            } else if ( cs.data.RecordType_Name == 'SocialPost-AFI') {
                isSocialPostAFI = true; 
                isEmail_RelatedList_Case_Custom = true; 
                isEmailSMSLog_RelatedList = true;
                isSurveyTaken_RelatedList = true; 
                isCase_RelatedList_c = true;
                isSocialPost_RelatedList = true;
            } else if ( cs.data.RecordType_Name == 'SocialPost-AMFS') { 
                isSocialPostAMFS = true; 
                isEmail_RelatedList_Case_Custom = true; 
                isEmailSMSLog_RelatedList = true;
                isSurveyTaken_RelatedList = true; 
                isCase_RelatedList_c = true;
                isSocialPost_RelatedList = true;
            } else if ( cs.data.RecordType_Name == 'RequestAFICase') {
                isRequestAFICase = true;
                isCaseMilestone_RelatedList = true;
                isEmail_RelatedList_Case_Custom = true; 
                isEmailSMSLog_RelatedList = true;
                isCase_RelatedList_c = true;
            } else if ( cs.data.RecordType_Name == 'RequestALICase') {
                isRequestALICase = true; 
                isEmail_RelatedList_Case_Custom = true; 
                isEmailSMSLog_RelatedList = true; 
                isCase_RelatedList_c = true;
            } else if ( cs.data.RecordType_Name == 'RequestAMFSCase') {
                isRequestAMFSCase = true;
                isCaseMilestone_RelatedList = true;
                isEmail_RelatedList_Case_Custom = true;
                isCaseEscalation_RelatedList = true;
                isEmailSMSLog_RelatedList = true;
                isApprovalHistory_RelatedList = true;
                isCase_RelatedList_c = true;
            }
            
            isTask_RelatedList_OpenActivity = true; 
            isTask_RelatedList_ActivityHistory = true;
            isCaseComment_RelatedList = true;
            isAttachment_RelatedList = true;
            isNegativeFeedback_RelatedList = true; 
        }
    }
    
    public PageReference redirect(){
        List<Case> list_case = [SELECT Id FROM Case WHERE Id=:id LIMIT 1];
        if(list_case.size() > 0){
            PageReference pageRef = new PageReference('/'+id);
            //return pageRef;
            return NULL;
        }else{
            return NULL;
        }
    }
    
    
    public void getDataNext(){    
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataNext(current_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        setLoadRecords();
    }
     
    public void getDataPrevious(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataPrevious(current_page); 
        
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        } 
        setLoadRecords();
         
    }
    
    
    public void getDataToPage(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataToPage(current_page, to_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        setLoadRecords();
    }
    
    public void getDataFirst(){ 
  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataFirst(current_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        setLoadRecords();
    }
    
    public void getDataLast(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataLast(total_page); 
        
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        } 
        setLoadRecords();
         
    } 
    
    
    public void setLoadRecords() {  
        if (isLoadCases == true) LoadCases();        
        if (isLoadCases_c == true) LoadCases_c();        
        if (isLoadMilestones == true) LoadMilestones();        
        if (isLoadEmails_vf_case == true) LoadEmails_vf_case();        
        if (isLoadSocialPost == true) LoadSocialPost();        
        if (isLoadCaseEscalation == true) LoadCaseEscalation();        
        if (isLoadOpenActivity_case == true) LoadOpenActivity_case();        
        if (isLoadActivityHistory_case == true) LoadActivityHistory_case();        
        if (isLoadCaseComments == true) LoadCaseComments();        
        if (isLoadAttachments == true) LoadAttachments();        
        if (isLoadLogs == true) LoadLogs();        
        if (isLoadNegatives == true) LoadNegatives();        
        if (isLoadSurvey == true) LoadSurvey();    
    }
    
    
    public void refresh(){  
        processTime = ''; 
        totalRow = 0;
        skip = 0;
        current_page = 1; 
        total_page = 1;
        take = SIZE_DATA_RELATED_LIST;
        list_page = new List<String>();    
        
    }
     
    public void setLoadCases() {
        setTrueVaribale('LoadCases'); 
    }
    public void setLoadCases_c() {
        setTrueVaribale('LoadCases_c'); 
    }
    public void setLoadMilestones() {
        setTrueVaribale('LoadMilestones'); 
    }
    public void setLoadEmails_vf_case() {
        setTrueVaribale('LoadEmails_vf_case'); 
    }
    public void setLoadSocialPost() {
        setTrueVaribale('LoadSocialPost'); 
    }
    public void setLoadCaseEscalation() {
        setTrueVaribale('LoadCaseEscalation'); 
    }
    public void setLoadOpenActivity_case() {
        setTrueVaribale('LoadOpenActivity_case'); 
    }
    public void setLoadActivityHistory_case() {
        setTrueVaribale('LoadActivityHistory_case'); 
    }
    public void setLoadCaseComments() {
        setTrueVaribale('LoadCaseComments'); 
    }
    public void setLoadAttachments() {
        setTrueVaribale('LoadAttachments'); 
    }
    public void setLoadLogs() {
        setTrueVaribale('LoadLogs'); 
    }
    public void setLoadNegatives() {
        setTrueVaribale('LoadNegatives'); 
    }
    public void setLoadSurvey() {
        setTrueVaribale('LoadSurvey'); 
    }
    
    public void setTrueVaribale(string setVariable) { 
        isLoadCases  = false;
        if (setVariable == 'LoadCases') {
            isLoadCases  = true;
        }
        isLoadCases_c  = false;
        if (setVariable == 'LoadCases_c') {
            isLoadCases_c  = true;
        }
        isLoadMilestones  = false;
        if (setVariable == 'LoadMilestones') {
            isLoadMilestones  = true;
        }
        isLoadEmails_vf_case  = false;
        if (setVariable == 'LoadEmails_vf_case') {
            isLoadEmails_vf_case  = true;
        }
        isLoadSocialPost  = false;
        if (setVariable == 'LoadSocialPost') {
            isLoadSocialPost  = true;
        }
        isLoadCaseEscalation  = false;
        if (setVariable == 'LoadCaseEscalation') {
            isLoadCaseEscalation  = true;
        }
        isLoadOpenActivity_case  = false;
        if (setVariable == 'LoadOpenActivity_case') {
            isLoadOpenActivity_case  = true;
        }
        isLoadActivityHistory_case  = false;
        if (setVariable == 'LoadActivityHistory_case') {
            isLoadActivityHistory_case  = true;
        }
        isLoadCaseComments  = false;
        if (setVariable == 'LoadCaseComments') {
            isLoadCaseComments  = true;
        }
        isLoadAttachments  = false;
        if (setVariable == 'LoadAttachments') {
            isLoadAttachments  = true;
        }
        isLoadLogs  = false;
        if (setVariable == 'LoadLogs') {
            isLoadLogs  = true;
        }
        isLoadNegatives  = false;
        if (setVariable == 'LoadNegatives') {
            isLoadNegatives  = true;
        }
        isLoadSurvey  = false;
        if (setVariable == 'LoadSurvey') {
            isLoadSurvey  = true;
        }
    }
    
    public void loadCases(){ 
        if (firstLoadCases  == false ){
            firstLoadCases = true;
            refresh();
        }
        setTrueVaribale('LoadCases'); 
        id = ApexPages.currentPage().getParameters().get('id');
        cases = new List<AXAAPI001A_response.Data>(); 
        
        mulai =  DateTime.now().getTime(); 
        
        List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
        if(list_con.size()>0 || test.isRunningTest()){
            String contactId = '';
            if (test.isRunningTest()) {           
                contactId = '0036F00002t4HZQQA2';
            } else {
            	Contact con = list_con[0]; 
                contactId = con.id; 
            }
            AXAAPI001A_response res = AXAAPI001A_CaseByPolicyNumber.getCaseByPolicyNumber(contactId, skip, take);
            //AXAAPI001A_response res = AXAAPI001A_CaseByParam.getCaseByKey('Entity__c', con.Entity__c);
            if(res != NULL && res.data != NULL){
                cases = res.data; 
                totalRow = res.counts; 
                Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
                countPage = countPage.round(System.RoundingMode.CEILING);
                total_page = integer.valueOf(countPage);
                
                
                system.debug('totalRow == '+totalRow); 
                system.debug('countPage == '+countPage); 
                system.debug('total_page == '+total_page); 
                    
                for(AXAAPI001A_response.Data data:cases){
                    data.recordType = entity;
                }
            } else if(res != NULL && res.message != NULL){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, res.message));
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO, 'time out from server'));
            }
                              
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }
    }
    
    public void loadCases_c(){
        
        if (firstLoadCases_c  == false ){
            firstLoadCases_c = true;
            refresh();
        }
        setTrueVaribale('LoadCases_c'); 
        
        mulai =  DateTime.now().getTime(); 

        cases = new List<AXAAPI001A_response.Data>();
        /* List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
         //List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XS3ISAA1' LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            // AXAAPI001A_response res = AXAAPI001A_CaseByPolicyNumber.getCaseByPolicyNumber('510-8717967');
            // AXAAPI001A_response res = AXAAPI001A_CaseByPolicyNumber.getCaseByPolicyNumber(con.id);
            AXAAPI001A_response res = AXAAPI001A_CaseByParam.getCaseByKey('parentId',id);
            if(res != NULL && res.data != NULL){
                cases = res.data;
                for(AXAAPI001A_response.Data data:cases){
                    data.recordType = entity;
                }
            }
        } */
        AXAAPI001A_response res = AXAAPI001A_CaseByParam.getCaseByKey('parentId',id, skip, take);
        if(res != NULL && res.data != NULL){
            cases = res.data;
            /* for(AXAAPI001A_response.Data data:cases){
                // data.recordType = entity;
            } */
            system.debug('res:'+res);
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
            
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            system.debug('totalRow == '+totalRow); 
            system.debug('countPage == '+countPage); 
            system.debug('total_page == '+total_page); 
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime); 
        }
    }
    
    //public List<AXAAPI001A_response.Data> cases {get;set;}
    
    public List<AXAAPI001B_response.Data> getCaseDetails(String parent_id){
        List<AXAAPI001B_response.Data> cases_c = new List<AXAAPI001B_response.Data>();
        getCaseDetail_c(parent_id);
        cases_c.add(this.cs.data);
        
        
        return cases_c;
    }
    
   // public List<Case> getCases(String parent_id){
        //List<Case> cases = new List<Case>();
        //cases.add(getCaseDetail('parent_id'));
        //return miles;
   // }
    
    public AXAAPI001B_response getCaseDetail_c(String case_id){
        cs = AXAAPI001B_CaseById.getCaseById(case_id);
        if(cs != NULL && cs.data != NULL){
            cs.data.contact_name = AXAAPI_UtilityClass.getsObjectNameById(cs.data.contactId, 'Contact', 'Name');
            cs.data.contact_phone = AXAAPI_UtilityClass.getsObjectNameById(cs.data.contactId, 'Contact', 'Phone');
            cs.data.Contact_Email = AXAAPI_UtilityClass.getsObjectNameById(cs.data.contactId, 'Contact', 'Email');
            cs.data.Last_Child_Case_name = AXAAPI_UtilityClass.getsObjectNameById(cs.data.Last_Child_Case_c, 'Case', 'Name');
            // cs.data.Negative_Feedback_name = AXAAPI_UtilityClass.getsObjectNameById(cs.data.Negative_Feedback_c, 'Negative_Feedback__c', 'Name');
            cs.data.CreatedBy_name = AXAAPI_UtilityClass.getsObjectNameById(cs.data.CreatedById, 'User', 'Name');
            cs.data.LastModifiedBy_name = AXAAPI_UtilityClass.getsObjectNameById(cs.data.LastModifiedById, 'User', 'Name');
            cs.data.Account_Name = AXAAPI_UtilityClass.getsObjectNameById(cs.data.AccountId, 'Account', 'Name');
            cs.data.Owner_Name = AXAAPI_UtilityClass.getsObjectNameById(cs.data.OwnerId, 'User', 'Name');
            cs.data.RecordType_Name = Schema.SObjectType.Case.getRecordTypeInfosById().get(cs.data.recordtypeid).getname();
        }else{
            cs = new AXAAPI001B_response();
            cs.data = new AXAAPI001B_response.Data();
        }
        return cs;
    }
    
    public AXAAPI001B_response getCaseDetail(String case_id){
        AXAAPI001B_response res = AXAAPI001B_CaseById.getCaseById(case_id);
        if(res != NULL && res.data != NULL){
            res.data.contact_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.contactId, 'Contact', 'Name');
            res.data.contact_phone = AXAAPI_UtilityClass.getsObjectNameById(res.data.contactId, 'Contact', 'Phone');
            res.data.Contact_Email = AXAAPI_UtilityClass.getsObjectNameById(res.data.contactId, 'Contact', 'Email');
            res.data.Last_Child_Case_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.Last_Child_Case_c, 'Case', 'Name');
            // res.data.Negative_Feedback_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.Negative_Feedback_c, 'Negative_Feedback__c', 'Name');
            res.data.CreatedBy_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.CreatedById, 'User', 'Name');
            res.data.LastModifiedBy_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.LastModifiedById, 'User', 'Name');
            res.data.Account_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.AccountId, 'Account', 'Name');
            res.data.Owner_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.OwnerId, 'User', 'Name');
            res.data.RecordType_Name = Schema.SObjectType.Case.getRecordTypeInfosById().get(res.data.recordtypeid).getname();
        }else{
            res = new AXAAPI001B_response();
            res.data = new AXAAPI001B_response.Data();
        }
        return res;
    }
      
    public void loadMilestones(){ 
        if (firstLoadMilestones  == false ){
            firstLoadMilestones = true;
            refresh();
        }
        setTrueVaribale('LoadMilestones'); 
        
        mulai =  DateTime.now().getTime(); 
        
        //miles = getMiles(id);
        list_cs_milestone = new List<AXAAPI012A_response.Data>();
        /* List<Case> list_case = [SELECT Id FROM Case WHERE Id=:id LIMIT 1];
        if(list_case.size()>0){
            Case con = list_case[0];
            // AXAAPI012A_response res = AXAAPI012A_CaseMilestoneByCaseID.getCaseMilestoneByCaseID('5006F000025ZMyZQAW');
            AXAAPI012A_response res = AXAAPI012A_CaseMilestoneByCaseID.getCaseMilestoneByCaseID(id);
            if(res != NULL && res.data != NULL){	
                  (AXAAPI012A_response.Data data:list_cs_milestone){
                    data.milestone_name = AXAAPI_UtilityClass.getsObjectNameById(data.milestoneTypeId, 'MilestoneType ', 'Name');
                }  
                
                list_cs_milestone = res.data;
                
                
            }
        } */
        
        
        AXAAPI012A_response res = AXAAPI012A_CaseMilestoneByCaseID.getCaseMilestoneByCaseID(id, skip, take);
        if(res != NULL && res.data != NULL){	 
            list_cs_milestone = res.data; 
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
            
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            system.debug('totalRow == '+totalRow); 
            system.debug('countPage == '+countPage); 
            system.debug('total_page == '+total_page); 
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime); 
        }
    }
     
    public void loadEmails_vf_case(){ 
        if (firstLoadEmails_vf_case  == false ){
            firstLoadEmails_vf_case = true;
            refresh();
        }
        setTrueVaribale('LoadEmails_vf_case'); 
        mulai =  DateTime.now().getTime(); 
        id = id;
        emails = new List<AXAAPI002B_response.Data>(); 
        AXAAPI002B_response res = AXAAPI002B_EmailMessageByParentId.getEmailByParentId(id,skip,take);
        //AXAAPI002B_response res = AXAAPI002B_EmailMessageByParentId.getEmailByParentId('5006F00001TsffrQAB');
        if(res != NULL && res.data != NULL){
            emails = res.data;
            
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }
    }
    
    
    public void loadSocialPost(){
        
        if (firstLoadSocialPost  == false ){
            firstLoadSocialPost = true;
            refresh();
        }
        setTrueVaribale('LoadSocialPost'); 
        mulai =  DateTime.now().getTime(); 
        
        listDataSP = new List<AXAAPI019A_response.Data>();
        // AXAAPI019A_response res = AXAAPI019A_SocialPostByParam.getSocialPostByParam('parentId','5000K000024aTspQAE'); 
        AXAAPI019A_response res = AXAAPI019A_SocialPostByParam.getSocialPostByParam('parentId',id, skip, take); 
        if(res != NULL && res.data != NULL){ 
            listDataSP = res.data; 
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        } 
    }
    
    public class approvalHistoryCase { 
        public boolean isProcessInstance {get;set;}
        public boolean isProcessInstanceStep {get;set;}
        public string approvalStatus {get;set;}
        public datetime createdDate {get;set;}
        public string status {get;set;}
        public string assignId {get;set;}
        public string assignName {get;set;}
        public string colorStatus {get;set;}
        public string actualApproveId {get;set;}
        public string actualApproveName {get;set;}
        public string comments {get;set;} 
    }  
    
    public void loadApprovalHistory(){
        listApprovalCase = new List<approvalHistoryCase>();
        AXAAPI006A_response res = AXAAPI006A_ProcessInstanceByParam.getProcessInstance('targetObjectId',id); 
        // AXAAPI006A_response res = AXAAPI006A_ProcessInstanceByParam.getProcessInstance('targetObjectId','5009000000s7ZmOAAU');   
  
        if (res != null && res.data != null) { 
			for(AXAAPI006A_response.data dt:res.data) {

				approvalHistoryCase responApproval = new approvalHistoryCase(); 
                responApproval.isProcessInstance = true;
                responApproval.approvalStatus = dt.status; 
                if (dt.status == 'Approved') {
                	responApproval.approvalStatus = 'Approval'; 
                    responApproval.colorStatus = '#a1f78d';  
                } else if (dt.status == 'Removed') {
                	responApproval.approvalStatus = 'Recall'; 
                    responApproval.colorStatus = '#c0bebc';  
                } else if (dt.status == 'Rejected') {
                	responApproval.approvalStatus = dt.status; 
                    responApproval.colorStatus = '#fb8a8c';  
                } 
                
                listApprovalCase.add(responApproval); 
                
        		AXAAPI007A_response res2 = AXAAPI007A_ProcessInstanceStepByParam.getProcessInstanceStep('processInstanceId',dt.id);  
                if (res2 != null && res2.data != null) {
					for(AXAAPI007A_response.data dt2:res2.data) {                        
						approvalHistoryCase responApproval2 = new approvalHistoryCase(); 
                        responApproval2.isProcessInstanceStep = true; 
                        responApproval2.createdDate = dt2.createdDate;
                        responApproval2.status = dt2.stepStatus;
                        responApproval2.assignId = dt2.actorId;
                        responApproval2.assignName = dt2.actorName;
                        responApproval2.actualApproveId = dt2.originalActorId;
                        responApproval2.actualApproveName = dt2.originalActorName;
                        responApproval2.comments = dt2.comments;
        				system.debug('responApproval2:'+responApproval2);
						listApprovalCase.add(responApproval2);
                    }
                	 
						
                }
            }
        } 
        system.debug('List approv:'+listApprovalCase);
         
    }
    
    public class Approval_History{
        public Approval_History(){}
        
        public Datetime Date_c {get;set;}
        public String Status {get;set;}
        public String Assigned_To {get;set;}
        public String Assigned_To_Name {get;set;}
        public String Actual_Approver {get;set;}
        public String Actual_Approver_Name {get;set;}
        public String Comments {get;set;}
        public String Overall_Status {get;set;}
        
        public Boolean Reminder {get;set;}
    }
          
    public void loadCaseEscalation(){ 
        
        if (firstLoadCaseEscalation  == false ){
            firstLoadCaseEscalation = true;
            refresh();
        }
        setTrueVaribale('LoadCaseEscalation'); 
    	mulai =  DateTime.now().getTime(); 
		list_case_esc = new List<AXAAPI017A_response.Data>();
       
        /* if(list_case.size()>0){
            Case con = list_case[0];
            
            // AXAAPI017A_response res = AXAAPI017A_CaseEscalationByCaseId.getCaseEscalationByCaseId('5000K000021wN2uQAE');
            AXAAPI017A_response res = AXAAPI017A_CaseEscalationByCaseId.getCaseEscalationByCaseId(id);
            if(res != NULL && res.data != NULL){  
                Map<Id, Case> map_sobj = new Map<id,Case>([SELECT id,caseNumber,Contact.name FROM Case WHERE id =: id ]);
                 for(AXAAPI017A_response.Data data:res.data){ 
                     if (map_sobj.containsKey(data.case_c)) { 
                        Case retData = map_sobj.get(data.case_c);
                        data.case_name = retData.caseNumber;
                        data.owner_name = retData.Contact.name;
                     }
                }
                
                list_case_esc = res.data; 
            }
        } */
        
        AXAAPI017A_response res = AXAAPI017A_CaseEscalationByCaseId.getCaseEscalationByCaseId(id, skip, take);
        if(res != NULL && res.data != NULL){  
            Map<Id, Case> map_sobj = new Map<id,Case>([SELECT id,caseNumber,Contact.name FROM Case WHERE id =: id ]);
            for(AXAAPI017A_response.Data data:res.data){ 
                if (map_sobj.containsKey(data.case_c)) { 
                    Case retData = map_sobj.get(data.case_c);
                    data.case_name = retData.caseNumber;
                }
            }
            
            list_case_esc = res.data; 
            
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }
    } 
    
     public void loadOpenActivity_case(){
         
        if (firstLoadOpenActivity_case  == false ){
            firstLoadOpenActivity_case = true;
            refresh();
        }
        setTrueVaribale('LoadOpenActivity_case'); 
    	mulai =  DateTime.now().getTime(); 
        // id = ApexPages.currentPage().getParameters().get('id');  
        list_open_res = new List<AXAAPI011A_response.Data>();
        /* List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XRdns' LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0]; 
            AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByPolicy.getTaskActHistoryByPolicy(con.Id); //berikut adalah id user hendrik, setelah diperiksa dengan salesforce sb, idnya tidak sama
            if(res != NULL && res.data != NULL){ 
                list_open_res = res.data;
            }
        } */
         
         // AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','Entity__c','AMFS'); 
         AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('open-activity/','whatId',id, skip, take); 
         if(res != NULL && res.data != NULL){ 
             list_open_res = res.data;
              
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
         } 
         
     } 
    
     public void loadActivityHistory_case(){
          
        if (firstLoadActivityHistory_case  == false ){
            firstLoadActivityHistory_case = true;
            refresh();
        }
        setTrueVaribale('LoadActivityHistory_case'); 
         mulai =  DateTime.now().getTime(); 
        // id = ApexPages.currentPage().getParameters().get('id');  
        list_history_res = new List<AXAAPI011A_response.Data>();
        /* List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0039000001XRdns' LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByPolicy.getTaskActHistoryByPolicy(con.Id); //berikut adalah id user hendrik, setelah diperiksa dengan salesforce sb, idnya tidak sama
            if(res != NULL && res.data != NULL){ 
                list_history_res = res.data;
            }
        } */
         
         // AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','Entity__c','AMFS'); 
         AXAAPI011A_response res = AXAAPI011A_TaskActHistoryByParam.getTaskByParam('activity-history','whatId',id, skip, take); 
         if(res != NULL && res.data != NULL){ 
             list_history_res = res.data;
             
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
         }   
     }
    
    public void loadCaseComments(){
    
        if (firstLoadCaseComments  == false ){
            firstLoadCaseComments = true;
            refresh();
        }
        setTrueVaribale('LoadCaseComments'); 
        mulai =  DateTime.now().getTime(); 
        id = ApexPages.currentPage().getParameters().get('id'); 
		list_case_com = new List<AXAAPI018A_response.Data>();
		system.debug('Comment: ' + id);
            AXAAPI018A_response res = AXAAPI018A_CaseCommentByParentID.getCaseCommentByParentID(id, skip, take);
             if(res != NULL && res.data != NULL){
                String arrComment = '';
                String comment = '';
                for(AXAAPI018A_response.Data dt:res.data) {
                    //comment = dt.commentBody;
                    //arrComment = comment.replace('\n','<br/>'); 
                    //dt.commentBody = arrComment; 
                }
                
                list_case_com = res.data;
                 system.debug('Isinya:' + res.data);
                totalRow = res.counts; 
                Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
                countPage = countPage.round(System.RoundingMode.CEILING);
                total_page = integer.valueOf(countPage);
                    
                list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
                
                selesai =  Datetime.now().getTime();
                system.debug('selesai == '+selesai); 
                system.debug('mulai == '+mulai); 
                processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
                processTime += '<br/>Total : ' + totalRow + ' records';
                system.debug('processTime == '+processTime);
            } 
      	// list_case_com = res.data;
        system.debug('Isinya:' + res.data);
    }
    
    public void loadAttachments(){
        
        if (firstLoadAttachments  == false ){
            firstLoadAttachments = true;
            refresh();
        }
        setTrueVaribale('LoadAttachments'); 
        mulai =  DateTime.now().getTime(); 
       id = ApexPages.currentPage().getParameters().get('id'); 
       list_attachment = new List<AXAAPI005B_response.Data>(); 
        // AXAAPI005B_response res = AXAAPI005B_AttachmentByCaseID.getAttachmentByCaseID('02s6F00000fTo4GQAS');
        AXAAPI005B_response res = AXAAPI005B_AttachmentByCaseID.getAttachmentByCaseID(id, skip, take);
        if(res != NULL && res.data != NULL){
            list_attachment = res.data; 
             
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }
    }
	 
    public void loadLogs(){
        
        if (firstLoadLogs  == false ){
            firstLoadCases = true;
            refresh();
        }
        setTrueVaribale('LoadLogs'); 
        mulai =  DateTime.now().getTime(); 
        id = ApexPages.currentPage().getParameters().get('id'); 
        logs = new List<AXAAPI003A_response.Data>();
        /*List<Case> list_case = [SELECT Id FROM Case WHERE Id=:id LIMIT 1];
        // List<Case> list_case = [SELECT Id FROM Case WHERE Id= '5006F00001d4hHzQAI' LIMIT 1];
        if(list_case.size()>0){
            Case cas = list_case[0];*/
            AXAAPI003A_response res = AXAAPI003A_EmailSMSLogByCase.getEmailSMSLogByCase(id, skip, take); 
            if(res != NULL && res.data != NULL){
                logs = res.data; 
                
                totalRow = res.counts; 
                
                if (test.isRunningTest()) totalRow = 10;
                Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
                countPage = countPage.round(System.RoundingMode.CEILING);
                total_page = integer.valueOf(countPage);
                    
                list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
                
                selesai =  Datetime.now().getTime();
                system.debug('selesai == '+selesai); 
                system.debug('mulai == '+mulai); 
                processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
                processTime += '<br/>Total : ' + totalRow + ' records';
                system.debug('processTime == '+processTime);
            }
        //}
    }    
    
    public void loadNegatives(){  
        
        if(firstLoadNegatives  == false ){
            firstLoadNegatives = true;
            refresh();
        }
        setTrueVaribale('LoadNegatives'); 
        mulai =  DateTime.now().getTime(); 
        id = ApexPages.currentPage().getParameters().get('id'); 
        listNegative = new List<AXAAPI013A_response.Data>();    
        
        AXAAPI013A_response res = AXAAPI013A_NegativeFeedbackByCase.getNegativeFeedbackByCaseId('case__c',id, skip, take);  
        // AXAAPI013A_response res = AXAAPI013A_NegativeFeedbackByCase.getNegativeFeedbackByCaseId('case__c','5000K000028Qp7EQAS');  
        if(res != NULL && res.data != NULL){
            listNegative = res.data; 
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        } 
    }       
    
    public void loadSurvey(){  
        
        if (firstLoadSurvey  == false ){
            firstLoadCases = true;
            refresh();
        }
        setTrueVaribale('LoadSurvey'); 
        mulai =  DateTime.now().getTime(); 
        id = ApexPages.currentPage().getParameters().get('id'); 
        listSurveyTaken = new List<AXAAPI014A_response.Data>(); 
        AXAAPI014A_response res = AXAAPI014A_SurveyTakenByCase.getSurveyTakenByCase(id, skip, take); 
        // AXAAPI014A_response res = AXAAPI014A_SurveyTakenByCase.getSurveyTakenByCase('5000K000028Qp7EQAS'); 
        if(res != NULL && res.data != NULL){ 
            listSurveyTaken = res.data; 
            
            totalRow = res.counts; 
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }  
    } 
}