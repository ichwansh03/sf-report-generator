public class CaseEscalation_CustomPage_ctrl {
    public String id {get;set;}
    public String parent_id {get;set;} 
   
    
    // public List<AXAAPI017A_response.Data> list_case_esc {get;set;}
    public AXAAPI017B_response case_esc {get;set;}
    
    public CaseEscalation_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');
        String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
        if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
               id = id+uniqueId;
        } 
        
        
        system.debug(id+'|'+ Schema.SObjectType.Case_Escalation__c.getKeyPrefix());
        if(id != NULL && id.left(3) == Schema.SObjectType.Case_Escalation__c.getKeyPrefix()) case_esc = getEscalationDetail(id);
    }
    
    public AXAAPI017B_response getEscalationDetail(String id){
         AXAAPI017B_response res = AXAAPI017B_CaseEscalationByID.getCaseEscalationByID(id);
         //res.data.case_Name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.case_c, 'Case', 'caseNumber');
         //res.data.owner_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.ownerid, 'User', 'Name');
         //res.data.Created_by_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.createdById, 'User', 'Name');
         //res.data.last_modified_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.lastModifiedById, 'User', 'Name');
         
        return res;
        /*esc = new Case_Escalation();
        esc.id = 'a1q5D000001ofoO';
        esc.name = '00573619';
        esc.Owner = 'AMFS - POS Non Financial Queue';
        esc.Division = 'POS Non Financial';
        esc.Start_Datetime = system.now();
        esc.End_Datetime = system.now();
        esc.Lead_Time = '';
        esc.End_By = '';
        esc.Status = 'New';
        esc.Target_Datetime = system.now();
        esc.Target_Status = 'Late';
        
        esc.Created_By = 'Admin SFDC';
        esc.Created_By_Id = '0056F000004TDzz';
        esc.Created_Date = system.now();
        esc.Last_Modified_By = 'Admin SFDC';
        esc.Last_Modified_By_Id = '0056F000004TDzz';
        esc.Last_Modified_Date = system.now();
        
        esc.Reminder = true;*/
    }
    
    /* public void loadCaseEscalation(){
        //escalations = new List<Case_Escalation>();
        //getEscalationDetail(parent_id);
        //escalations.add(esc);
        //
		list_case_esc = new List<AXAAPI017A_response.Data>();
        List<Case> list_case = [SELECT Id FROM Case WHERE Id=:id LIMIT 1];
        if(list_case.size()>0){
            Case con = list_case[0];
            AXAAPI017A_response res = AXAAPI017A_CaseEscalationByCaseId.getCaseEscalationByCaseId('5000K000021wN2uQAE');
            if(res != NULL && res.data != NULL){
                 for(AXAAPI017A_response.Data data:list_case_esc){
                    data.case_name = AXAAPI_UtilityClass.getsObjectNameById(data.case_c, 'Case', 'caseNumber');
                    data.owner_name = AXAAPI_UtilityClass.getsObjectNameById(data.ownerid, 'Contact', 'name');
                }
                
                list_case_esc = res.data;
                
                
            }
        }
    } */
    
   /* public class Case_Escalation{
        public Case_Escalation(){}
        
        public String id {get;set;}
        public String name {get;set;}
        public String Owner {get;set;}
        public String Division {get;set;}
        public Datetime Start_Datetime {get;set;}
        public Datetime End_Datetime {get;set;}
        public String Lead_Time {get;set;}
        public String End_By {get;set;}
        public String Status {get;set;}
        public Datetime Target_Datetime {get;set;}
        public String Target_Status {get;set;}
        
        public String Created_By {get;set;}
        public String Created_By_Id {get;set;}
        public Datetime Created_Date {get;set;}
        public String Last_Modified_By {get;set;}
        public String Last_Modified_By_Id {get;set;}
        public Datetime Last_Modified_Date {get;set;}
        
        public Boolean Reminder {get;set;}
    }*/
}