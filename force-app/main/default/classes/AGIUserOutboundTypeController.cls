public without sharing class AGIUserOutboundTypeController{
    private String soql_salesplan {get;set;}
    public List<User_Detail__c> datalist_userdetail {get;set;}
    public List<User_Detail__c> WelcomeCall {get;set;}
    public List<User_Detail__c> UpdateData {get;set;}
    public List<User_Detail__c> Claim {get;set;}
    public List<User_Detail__c> CollectionTask {get;set;}
    public List<User_Detail__c> Renewal {get;set;}
    public List<User_Detail__c> iAsk {get;set;}
    public List<User_Detail__c> iBuy {get;set;}
    public List<User_Detail__c> iClaim {get;set;}
    public List<User_Detail__c> SMSPullConfirmation {get;set;}
    public List<User_Detail__c> ComplaintFollowUp {get;set;}

    public string valueperiod {get;set;}
    
    public String sPeriode {
        get { return System.now().formatGMT('MMMM') + ' ' + String.valueOf(System.today().year()); }
        set;
    } 
    
    public Date dateFrom {
        get { return Date.newInstance(Date.today().year(), Date.today().month(), 1); }
        set;
    }
    
    public Date dateTo {
        get { return Date.newInstance(Date.today().year(), Date.today().month(), date.daysInMonth(Date.today().year(),Date.today().month()));}
        set;
    }
    
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }

    public String sortField {
        get  { if (sortField == null) {sortField = 'Name'; } return sortField;  }
        set;
    }
      
    public id username {
        get { return UserInfo.getUserId(); }
        set;
    }
            
    public AGIUserOutboundTypeController(){
        query('');
        
    }

    public void runQuerySalesplan() {
        try {
            datalist_userdetail = Database.query(soql_salesplan + ' order by ' + sortField + ' ' + sortDir);

                WelcomeCall = new List<User_Detail__c>();
                UpdateData = new List<User_Detail__c>();
                Claim = new List<User_Detail__c>();
                Renewal = new List<User_Detail__c>();
                iAsk = new List<User_Detail__c>();
                iClaim = new List<User_Detail__c>();
                iBuy = new List<User_Detail__c>();
                SMSPullConfirmation = new List<User_Detail__c>();
                ComplaintFollowUp = new List<User_Detail__c>();

                            
            for (User_Detail__c temp : datalist_userdetail ){                
                if (temp.Outbound_Activity_Case_type__c != NULL) {
                    if (temp.Outbound_Activity_Case_type__c.contains('Confirmation - Welcome Call') ) WelcomeCall.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Confirmation - Update Data') ) UpdateData.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Confirmation - Claim') ) Claim.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Conservation - Renewal') ) Renewal.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Survey Feedback - Survey - I Ask') ) iAsk.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Survey Feedback - Survey - I Claim') ) iClaim.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Survey Feedback - Survey - I Buy') ) iBuy.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Confirmation - SMS Pull Confirmation') ) SMSPullConfirmation.add(temp);
                    if (temp.Outbound_Activity_Case_type__c.contains('Confirmation - Complaint Follow Up') ) ComplaintFollowUp.add(temp);
                }
            }
            
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }
    
    public PageReference runSearch() {
        String FieldDocument = Apexpages.currentPage().getParameters().get('FieldDocument');
        String FieldBrandId = Apexpages.currentPage().getParameters().get('FieldBrandId');
        String FieldMatGroupId = Apexpages.currentPage().getParameters().get('FieldMatGroupId');
        String FieldModelId = Apexpages.currentPage().getParameters().get('FieldModelId');
        String FieldMaterialId = Apexpages.currentPage().getParameters().get('FieldMaterialId');
        String FieldBCId = Apexpages.currentPage().getParameters().get('FieldBCId');
        String FieldAreaId = Apexpages.currentPage().getParameters().get('FieldAreaId');
        String FieldCabangId = Apexpages.currentPage().getParameters().get('FieldCabangId');

        String sParameter = '';
        
        FieldBrandId = FieldBrandId.removeEnd(',');
        FieldMatGroupId = FieldMatGroupId.removeEnd(',');
        FieldModelId = FieldModelId.removeEnd(',');
        FieldMaterialId = FieldMaterialId.removeEnd(',');
        FieldBCId  = FieldBCId.removeEnd(',');
        FieldAreaId = FieldAreaId.removeEnd(',');
        FieldCabangId = FieldCabangId.removeEnd(',');
        
        if (!FieldDocument.equals('')){ sParameter += ' and Document__c LIKE \''+String.escapeSingleQuotes(FieldDocument)+'\'';}
        if (!FieldBrandId.equals('')){ sParameter += ' and Brand__c in ('+ FieldBrandId +')';}
        if (!FieldMatGroupId.equals('')){ sParameter += ' and Material_Group__c in ('+ FieldMatGroupId +')';}
        if (!FieldModelId.equals('')){sParameter += ' and Model__c in ('+ FieldModelId +')';}
        if (!FieldMaterialId.equals('')){sParameter += ' and Material__c in ('+ FieldMaterialId +')';}
        if (!FieldBCId.equals('')){sParameter += ' and Sales_Plan__r.Owner.Name in ('+ FieldBCId +')';}
        if (!FieldAreaId.equals('')){sParameter += ' and Sales_Plan__r.Area__c in ('+ FieldAreaId +')';}
        if (!FieldCabangId.equals('')){sParameter += ' and Sales_Plan__r.Cabang__c in ('+ FieldCabangId +')';}
        
        query(sParameter);
           
        return null;
    }
    
    private void query(String sParameter){    
        //soql_salesplan = ' select id, Name, Outbound_Activity_Case_type__c from User ' + sParameter;
        User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        String Entity = 'AGI';  //userObj.Entity__c;
        soql_salesplan = ' select id, Name, Outbound_Activity_Case_type__c, F_Entity__c, Entity__c from User_Detail__c where User__r.Profile.Name != \'System Administrator\' and User__r.Entity__c = \'' + Entity + '\'' + sParameter;
        //soql_salesplan = 'select id, Name, Outbound_Activity_Case_Type__c, F_Entity__c,Entity__c from User_Detail__c where User__r.Entity__c = \'' + Entity + '\'';   //*Created by Arief MII for testing purpose using admin user 
        system.debug('SOQL ==>'+soql_salesplan);
        runQuerySalesplan();
    }
            
    public Pagereference Save(){
        Savepoint spoint = Database.setSavepoint();
        try{
            Integer check = 0;
            List<User_Detail__c> newsales = new List<User_Detail__c>();
            
            for(User_Detail__c pp : datalist_userdetail){                    
                check +=1;
                if (pp.Outbound_Activity_Case_type__c != NULL)
                newsales.add(pp);  
            }
            if(newsales.size()>0) update newsales;
            
                PageReference pageRef = Page.Outbound_Activity_Case_type_AGI;
                pageRef.setRedirect(true);
                return pageRef;
                //return null;
        }catch(System.DmlException e){ 
            Database.rollback(spoint);
            return null; 
        }
        
    }
    
}