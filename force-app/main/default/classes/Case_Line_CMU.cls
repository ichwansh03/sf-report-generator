public class Case_Line_CMU {
    Public String idparam {get;set;}
    public integer index {get;set;}
    public integer blockSize {get;set;}
    public integer totalRecs {get;set;}
    public integer totalAllRecs {get;set;}
    public Boolean fetchCalled;
    Public String nameduser {get;set;}
    Public String filrequeststatus {get;set;}
    Public Profile pro {get;set;}
    PUBLIC String SOQL {get;set;}
    Public String offering {get;set;}
    Public String stapol {get;set;}
    Public String entityUser {get;set;}
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }
    public void toggleSort() {
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        fetch();
    }
    public String sortField {
        get  { if (sortField == null) {sortField = 'Createddate'; } return sortField;  }
        set;
    }
    public Case_Line_CMU(){
        index = 0;
        blockSize = 10;
        idparam = '';
        stapol = '';
        Offering = 'All';
        filrequeststatus='All';
        pro = [select name from Profile where id=:UserInfo.getProfileId()];
        entityUser = [Select Entity__c From User Where Id = :UserInfo.getUserId()].Entity__c;   
    }
    
    public void fetch(){
        DescribeSObjectResult describeResultdp = Case.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        date cutoffdate = date.newInstance(2020, 01, 01); // 2020-01-01T00:00:00.000+0000

        String qr = 'SELECT count(id) cid FROM Case where CreatedDate > 2020-01-01T00:00:00.000+0000 AND Status != \'Closed\' AND Type = \'Complaint\' and entity_backup__c = \'AMFS\'';
        soql = 'SELECT '+dpFields+', Contact.MobilePhone, Contact.Policy_No__c FROM Case where CreatedDate > 2020-01-01T00:00:00.000+0000 AND Status != \'Closed\' AND Type = \'Complaint\' and entity_backup__c = \'AMFS\'' ;
        if(nameduser != 'Blank' && nameduser != 'All' && nameduser != NULL) soql = soql + ' and Named_User__c = \''+nameduser+'\' ' ;
        if(nameduser == 'Blank') soql = soql + ' and (Named_User__c = NULL OR Named_User__c = \'\') ' ;
        if(filrequeststatus =='All' && filrequeststatus !=NULL) soql = soql + ' and CHS_Status__c != NULL ' ;
        if(filrequeststatus !='All'  && filrequeststatus !=NULL) soql = soql + ' and CHS_Status__c = '+'\''+filrequeststatus+'\''+' ';
        system.debug('#query : '+soql);
        if(pro.Name=='System Administrator' || pro.Name=='SPV CMU-AMFS'){
        
        }
        else{
            qr = qr + ' and OwnerId ='+'\''+UserInfo.getUserId()+'\''+' ';
            soql = soql+' and OwnerId ='+'\''+UserInfo.getUserId()+'\''+' ';
        }
        AggregateResult ar = Database.query(qr);
        totalAllRecs = Integer.valueOf(ar.get('cid'));
        soql = soql + ' order by '+SortField+' '+sortDir;
        soql = soql + ' limit 40000 ';
        //List<Case> listcl = Database.query(soql);
        //totalrecs = listcl.size();
    }
    
    public List<Case> getListCall(){
        List<Case> listcl = new List<Case>();
        fetch();
        //String dpQuery = soql + ' LIMIT ' + blockSize + ' OFFSET ' + index;
        List<Case> listcl2 = new List<Case>();
        if(test.isRunningTest()==false){
            listcl2 = Database.query(soql);
            totalrecs = listcl2.size();
            Integer endblock = blockSize + index;
            if(endblock>=totalRecs) endblock = totalRecs;
            for(Integer i = index ; i < endblock ; i++){
                listcl.add(listcl2.get(i));
            }
        }
        else{
            listcl2 = Database.query('select id, caseNumber from Case limit 100');
            listcl = listcl2;
        }
        //system.debug('*query*'+dpquery);
        //listcl = Database.query(dpQuery);
        return listcl;
    }
    
    public void UpdateCallLine(){
        if(idparam!=null){
            try{
                Case cl = [select id, casenumber, last_call__c from Case where id=:idparam];
                cl.Last_Call__c = dateTime.now();
                update cl;    
            }
            catch(exception e){
                system.debug(LoggingLevel.DEBUG,'*error*'+e);
            }
            idparam = '';
        }
    }
    
     public List<SelectOption> getNamedUserlist(){
         List<SelectOption> options = new List<SelectOption>();
         
         options.add(new SelectOption('All','--All--'));
         options.add(new SelectOption('Blank','--Blank--'));
         for (Named_User__c nu : [SELECT id, Name, User__c FROM Named_User__c WHERE Entity__c = 'AMFS' and Division__c = 'CMU' ]){ // and (Status__c = 'Active' OR Status__c = '')
             if(pro.Name=='System Administrator' || pro.Name=='SPV CMU-AMFS'){
                 options.add(new SelectOption(nu.Name,nu.Name));    
             }
             else{
                 if (nu.User__c == UserInfo.getUserId())
                     options.add(new SelectOption(nu.Name,nu.Name));
             }
                          
         }

         return options;   
     }
    
    public List<SelectOption> getRequestStatus(){
        List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('All','All'));
		options.add(new SelectOption('New','New'));
        options.add(new SelectOption('Incomplete Information','Incomplete Information'));
        options.add(new SelectOption('Revised','Revised'));
        options.add(new SelectOption('In Progress CMU','In Progress CMU'));
        options.add(new SelectOption('Assigned to Back Office','Assigned to Back Office'));
        options.add(new SelectOption('In Progress Back Office','In Progress Back Office'));
        options.add(new SelectOption('Resolved','Resolved'));
        options.add(new SelectOption('Escalated','Escalated'));
        options.add(new SelectOption('Escalation Rejected','Escalation Rejected'));
        options.add(new SelectOption('Escalation Approved','Escalation Approved'));
        options.add(new SelectOption('BOD Approval','BOD Approval'));
        options.add(new SelectOption('Closed - Invalid','Closed - Invalid'));
        options.add(new SelectOption('Closed - Valid','Closed - Valid'));

        return options;   
     }
    
    public List<SelectOption> getBlock_Size(){
        List<SelectOption> options = new List<SelectOption>();
        String opsi = label.CL_BlockSize;
        List<String> listopsi = new List<String>();
        if(opsi!=null && opsi!='') listopsi = opsi.split(';');
        if(listopsi.size()>0){
            for(String s:listopsi){
                options.add(new SelectOption(s,s));
            }
        }
        return options;   
     }
    
    public List<SelectOption> getOffering_pick(){
        List<SelectOption> options = new List<SelectOption>();
        String opsi = label.CL_Offering;
        List<String> listopsi = new List<String>();
        if(opsi!=null && opsi!='') listopsi = opsi.split(';');
        if(listopsi.size()>0){
            for(String s:listopsi){
                options.add(new SelectOption(s,s));
            }
        }
        return options;   
     }
    
    public List<SelectOption> getStatus_Polis(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','None'));
        String opsi = label.CL_StatusPolis;
        List<String> listopsi = new List<String>();
        if(opsi!=null && opsi!='') listopsi = opsi.split(';');
        if(listopsi.size()>0){
            for(String s:listopsi){
                options.add(new SelectOption(s,s));
            }
        }
        return options;   
     }
    
    public void beginning()
    {
        index = 0;
    }
    
    public void previous()
    {
        index = index - blockSize;
    }
    
    public void next()
    {
        index = index + blockSize;
        system.debug(LoggingLevel.DEBUG, '*index*'+index);
    }
    
    public void end()
    {
        index = totalrecs - math.mod(totalRecs,blockSize);
    }
    
    public boolean getprev()
    {
        if(index == 0)
        return true;
        else
        return false;
    }
    
     public boolean getnxt()
    {
        if((index + blockSize) >= totalRecs)
        return true;
        else
        return false;
    }
}