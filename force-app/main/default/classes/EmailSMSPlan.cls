public with sharing class EmailSMSPlan{
//public without sharing class EmailSMSPlan{
    private String soql_EmailSMSPlan {get;set;}
    public List<Email_SMS_Log__c> datalist_dataplan {get;set;}
    public string valueperiod {get;set;}
    public string valueEntity {get;set;}
    Public String sStatus{get;set;}

    public List<SelectOption> dperiod{
        get{
             list<selectOption> objectsList = new list<selectOption>();
                 
             objectsList.add(new SelectOption('Today','Today' ));
             objectsList.add(new SelectOption('Today & H+1','H_1' ));
             objectsList.add(new SelectOption('Today & H+3','H+3' ));
             objectsList.add(new SelectOption('This_Week','This Week' ));
             objectsList.add(new SelectOption('This_Month','This_Month' ));
             return objectsList;
        }
        set;
    }
    
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
        get  { if (sortField == null) {sortField = 'Send_Flag__c DESC, name '; } return sortField;  }
        set;
    }
      
    public id username {
        get { return UserInfo.getUserId(); }
        set;
    }

/*    
    Public String sPosisi{
        get{
            User u = [SELECT Entity__c FROM User WHERE id =:UserInfo.getUserId()];
            return u.Entity__c;
        }
        set;
    }
*/

    public List<SelectOption> sPosisi{
        get{
             list<selectOption> objectsList = new list<selectOption>();

            User u = [SELECT Entity__c FROM User WHERE id =:UserInfo.getUserId()];
            
            if (u.Entity__c == 'MAGI') {
                 objectsList.add(new SelectOption('MAGI','MAGI' ));
                 objectsList.add(new SelectOption('AMFS','AMFS' ));
                 objectsList.add(new SelectOption('AFI','AFI' ));
            }
            if (u.Entity__c == 'AFI') {
                 objectsList.add(new SelectOption('AFI','AFI' ));
                 objectsList.add(new SelectOption('MAGI','MAGI' ));
                 objectsList.add(new SelectOption('AMFS','AMFS' ));
            }
            if (u.Entity__c == 'AMFS') {
                 objectsList.add(new SelectOption('AMFS','AMFS' ));
                 objectsList.add(new SelectOption('MAGI','MAGI' ));
                 objectsList.add(new SelectOption('AFI','AFI' ));
            }
                 return objectsList;
        }
        set;
    }

    Public Boolean onOff{
        get{
            //if(list_sales.size()>0 && list_sales[0].Status__c == 'Approved') return FALSE;
            //else return TRUE;
            return FALSE;
        }
        set;
    }
    
    public EmailSMSPlan(){
        //query('');

        date hariini = date.today();
        
        string txtmonth = '';
        string txtday = '';
        
        if (hariini.day() < 10 ) txtday = '0'+hariini.day();
        else txtday = ''+hariini.day();

        if (hariini.month() < 10 ) txtmonth = '0'+hariini.month();
        else txtmonth = ''+hariini.month();
        
        //string hariini2 = hariini.year()+'-'+hariini.month()+'-'+hariini.day() ;
        string hariini2 = hariini.year()+'-'+txtmonth+'-'+txtday ;

        //query(' and Start_Date__c = \'' + namaperiod + '\'');
        query(' and Request_Date__c = '+ hariini2 +' ');
        
    }

    public void runQueryEmailSMSPlan() {
        try {
            datalist_dataplan = Database.query(soql_EmailSMSPlan + ' order by ' + sortField + ' ' + sortDir);
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
        String sToday = String.valueOf(System.today().month()) + String.valueOf(System.today().year());
        User u = [SELECT Entity__c FROM User WHERE id =:UserInfo.getUserId()];
        string sNewPosisi = u.Entity__c;
        string sQueryParam = '';
        
        string sEntity = ' and Entity__c = \''+valueEntity+'\' ';

        //total_size_EmailSMSPlan = Database.countQuery('select count() from Email_SMS_Log__c WHERE id != null AND Sales_Plan__r.Periode__c = \'' + sToday + '\'' + sParameter + sQueryParam);
        //filter by request date
        soql_EmailSMSPlan = 'SELECT id, Account__c, Account__r.Name, '+
                            'Case__c, Case__r.CaseNumber, '+
                            'Contact__c, Contact__r.Name, '+
                            'Email_SMS_Template__c, Email_SMS_Template__r.Name, '+
                            'Email__c, Start_Date__c, End_Date__c, Entity__c, Ext_ID_IDAS__c, Method__c, Mobile__c, Policy_Number__c, ' + 
                            'Send_Flag__c, Status__c, Type__c, Category__c, Request_Date__c '+
                            'FROM Email_SMS_Log__c WHERE id != null '+sEntity+' '+sParameter ;
                            //'FROM Email_SMS_Log__c WHERE id != null AND EmailSMSPlan__r.Period__c = \'' + sToday + '\'' + sParameter + sQueryParam;

        datetime dt2 = datetime.now();
        sStatus = string.valueof(dt2);

        runQueryEmailSMSPlan();

    }

    public PageReference GetData() {
        date paramday = date.today();
        date thisday = date.today();
        
        string sParameter = '';
             if (valueperiod == 'Today' || valueperiod == 'Today')
                 paramday = date.today();
             if (valueperiod == 'Today & H+1' || valueperiod == 'H_1' )
                paramday = thisday+1;
             if (valueperiod == 'Today & H+3' || valueperiod == 'H+3' )
                paramday = thisday+3;


        string txtmonth = '';
        string txtday = '';
        
        if (paramday.day() < 10 ) txtday = '0'+paramday.day();
        else txtday = ''+paramday.day();
        if (paramday.month() < 10 ) txtmonth = '0'+paramday.month();
        else txtmonth = ''+paramday.month();

        //string paramday2 = paramday.year()+'-'+paramday.month()+'-'+paramday.day() ;
        string paramday2 = paramday.year()+'-'+txtmonth+'-'+txtday ;

        if (thisday.day() < 10 ) txtday = '0'+thisday.day();
        else txtday = ''+thisday.day();
        if (thisday.month() < 10 ) txtmonth = '0'+thisday.month();
        else txtmonth = ''+thisday.month();

        //string thisday2 = thisday.year()+'-'+thisday.month()+'-'+thisday.day() ;
        string thisday2 = thisday.year()+'-'+txtmonth+'-'+txtday ;

        sParameter = ' and Request_Date__c >= '+thisday2+' and Request_Date__c <= '+paramday2+' ';

             if (valueperiod == 'This_Week' || valueperiod == 'This Week' )
                sParameter = ' and Request_Date__c = this_week ';
             if (valueperiod == 'This_Month' || valueperiod == 'This_Month')
                sParameter = ' and Request_Date__c = this_month ';


        query(sParameter);

        //query(' and Plan_Period__c = \'' + dperiod + '\'');

        //runQueryEmailSMSPlan(); //getDataList();
        return null;
    }
            
    public Pagereference Save(){
        Savepoint spoint = Database.setSavepoint();
        try{
            Integer check = 0;
            List<Email_SMS_Log__c> newsales = new List<Email_SMS_Log__c>();
            User u = [SELECT Entity__c FROM User WHERE id =:UserInfo.getUserId()];
            string sNewPosisi = u.Entity__c;
            
            for(Email_SMS_Log__c pp : datalist_dataplan){                    
                check +=1;
                newsales.add(pp);  
            }
            if(newsales.size()>0) update newsales;
            
            if(check == 0)
            { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Check ' + sPosisi + ' harus dichecklist'));
                Database.rollback(spoint);
                return null;
            }else{
                PageReference pageRef = Page.EmailSMSPlan;
                pageRef.setRedirect(true);
                return pageRef;
                //return null;
            }
        }catch(System.DmlException e){ 
            Database.rollback(spoint);
            return null; 
        }
        
    }
    
}