public class CaseMilestone_CustomPage_ctrl {
	public String id {get;set;}
    public String parent_id {get;set;}
    /*public List<CaseMilestone> miles {get;set;}
    public CaseMilestone mile {get;set;} */
    
    // public List<AXAAPI012A_response.Data> list_cs_milestone {get;set;}
    public AXAAPI012B_response cs_milestone {get;set;}

    public CaseMilestone_CustomPage_ctrl(){
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.CaseMilestone.getKeyPrefix());
        if(id != NULL && id.left(3) == Schema.SObjectType.CaseMilestone.getKeyPrefix()) {
            cs_milestone = getMileDetail(id);
        }
    }
    
       
    public AXAAPI012B_response getMileDetail(String id){
         AXAAPI012B_response res = AXAAPI012B_CaseMilestoneByID.getCaseMilestoneByID(id);
         // res.data.caseName  = AXAAPI_UtilityClass.getsObjectNameById(res.data.caseId, 'Case', 'caseNumber');
         res.data.MileStoneName  = AXAAPI_UtilityClass.getsObjectNameById(res.data.milestoneTypeId, 'MilestoneType ', 'Name');
         res.data.businessHoursName  = AXAAPI_UtilityClass.getsObjectNameById(res.data.businessHoursId, 'BusinessHours  ', 'Name');
        // res.data.template_sms_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_sms_c, 'Email_SMS_Template__c', 'Name');
        
        /*mile.Id = id;
        mile.Name = '03261781';
        mile.Target_Date = system.now();
        mile.Completion_Date = system.now();
        mile.Time_Remaining = '00:00';
        mile.isviolated = true;
        mile.iscompleted = false;
        
        mile.Created_By = 'Admin SFDC';
        mile.Created_By_Id = '0056F000004TDzz';
        mile.Created_Date = system.now();
        mile.Last_Modified_By = 'Admin SFDC';
        mile.Last_Modified_By_Id = '0056F000004TDzz';
        mile.Last_Modified_Date = system.now();
        */
        return res;
    }
    
    /* public void loadMilestones(){
        //miles = getMiles(parent_id);
        list_cs_milestone = new List<AXAAPI012A_response.Data>();
        List<Case> list_case = [SELECT Id FROM Case WHERE Id=:id LIMIT 1];
        if(list_case.size()>0){
            Case con = list_case[0];
            AXAAPI012A_response res = AXAAPI012A_CaseMilestoneByCaseID.getCaseMilestoneByCaseID('5006F000025ZMyZQAW');
            if(res != NULL && res.data != NULL){	
                  (AXAAPI012A_response.Data data:list_cs_milestone){
                    data.milestone_name = AXAAPI_UtilityClass.getsObjectNameById(data.milestoneTypeId, 'MilestoneType ', 'Name');
                } 
                
                list_cs_milestone = res.data;
                
                
            }
        }
    } */
    
   /* public List<CaseMilestone> getMiles(String parent_id){
        List<CaseMilestone> miles = new List<CaseMilestone>();
        miles.add(getMileDetail('5550K000006SfCT'));
        return miles;
    }*/

    /* public class CaseMilestone{
        public CaseMilestone(){}
        
        public String Id {get;set;}
        public String Name {get;set;}
        public Datetime Target_Date {get;set;}
        public Datetime Completion_Date {get;set;}
        public String Time_Remaining {get;set;}
        public Boolean isviolated {get;set;}
        public Boolean iscompleted {get;set;}
        
        public String Created_By {get;set;}
        public String Created_By_Id {get;set;}
        public Datetime Created_Date {get;set;}
        //public String Last_Modified_By {get;set;}
        public String Last_Modified_By_Id {get;set;}
        public Datetime Last_Modified_Date {get;set;}
    } */
}