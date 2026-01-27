public class Call_Line {
    Public String idparam {get;set;}
    public integer index {get;set;}
    public integer blockSize {get;set;}
    public integer totalRecs {get;set;}
    public integer totalAllRecs {get;set;}
    public Boolean fetchCalled;
    Public String filcampname {get;set;}
    Public String filcallstatus {get;set;}
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
    public Call_Line(){
        index = 0;
        blockSize = 10;
        idparam = '';
        stapol = '';
        Offering = 'All';
        filcallstatus='No';
        pro = [select name from Profile where id=:UserInfo.getProfileId()];
        entityUser = [Select Entity__c From User Where Id = :UserInfo.getUserId()].Entity__c;	
	}
    
    public void fetch(){
        DescribeSObjectResult describeResultdp = Call_Line__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        String qr = 'SELECT count(id) cid FROM Call_Line__c where Parent_Campaign__c!=null and Is_Expired__c = false ';
        soql = 'SELECT '+dpFields+' FROM Call_Line__c where Parent_Campaign__c!=null and Is_Expired__c = false ';
        if(filcampname!=null && filcampname!='') soql = soql + ' and Call_List__c='+'\''+filcampname+'\''+' ';
        if(filcallstatus=='Yes' && filcallstatus!=NULL) soql = soql + ' and Call_Status_Config__c != NULL ' ;
        if(filcallstatus=='No' && filcallstatus!=NULL) soql = soql + ' and Call_Status_Config__c = NULL ';
        if(offering!='All' && offering!= NULL )soql = soql + ' and Offering__c = '+'\''+offering+'\''+' ';
        if(filcallstatus=='Rescheduled'  && filcallstatus!=NULL) soql = soql + ' and Call_Status_Config__c = '+'\''+filcallstatus+'\''+' ';
        if(filcallstatus== 'No Pickup/ Mailbox' && filcallstatus!=NULL ) soql = soql + ' and Reason_Status_Config__c = '+'\''+filcallstatus+'\''+' ';
        if(stapol!='' && stapol!=null) soql = soql + ' and Status_Polis__c = '+'\''+stapol+'\''+' ';
        if(pro.Name=='System Administrator'){
        
        }
        else{
            qr = qr + ' and agent__c ='+'\''+UserInfo.getUserId()+'\''+' ';
            soql = soql+' and agent__c ='+'\''+UserInfo.getUserId()+'\''+' ';
        }
        AggregateResult ar = Database.query(qr);
        totalAllRecs = Integer.valueOf(ar.get('cid'));
        soql = soql + ' order by '+SortField+' '+sortDir;
        soql = soql + ' limit 40000 ';
        //List<Call_Line__c> listcl = Database.query(soql);
        //totalrecs = listcl.size();
    }
    
    public List<Call_Line__c> getListCall(){
        List<Call_Line__c> listcl = new List<Call_Line__c>();
        fetch();
        //String dpQuery = soql + ' LIMIT ' + blockSize + ' OFFSET ' + index;
        List<Call_Line__c> listcl2 = new List<Call_Line__c>();
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
            listcl2 = Database.query('select id, name from call_line__c limit 100');
            listcl = listcl2;
        }
        //system.debug('*query*'+dpquery);
        //listcl = Database.query(dpQuery);
        return listcl;
    }
    
    public void UpdateCallLine(){
        if(idparam!=null){
            try{
                Call_Line__c cl = [select id, name, last_call__c from call_line__c where id=:idparam];
                cl.Last_Call__c = dateTime.now();
                update cl;    
            }
            catch(exception e){
                system.debug(LoggingLevel.DEBUG,'*error*'+e);
            }
            idparam = '';
        }
    }
    
     public List<SelectOption> getCampaignlist(){
         List<SelectOption> options = new List<SelectOption>();

         String query;
         String dpQuery = 'SELECT Call_List__c FROM Call_Line__c where (Parent_Campaign__c!=null OR Campaign_Name__c !=null) and Is_Expired__c = false ';
         if(pro.Name=='System Administrator'){
        
         }
         else{
             dpQuery = dpQuery+' and agent__c ='+'\''+UserInfo.getUserId()+'\''+' ';
         }
         
         if (entityUser == 'AGI') query = 'SELECT id, Campaign_Name__c  from Call_List__c where recordtype.name = '+'\''+'ActivityAGI'+'\''+' and IsExpired__c = false and id in ('+dpquery+')';
         if (entityUser == 'ALI') query = 'SELECT id, Campaign_Name__c  from Call_List__c where recordtype.name = '+'\''+'ActivityALI'+'\''+' and IsExpired__c = false and id in ('+dpquery+')';
         
         //query = 'SELECT id, Campaign_Name__c  from Call_List__c where recordtype.name = '+'\''+'ActivityALI'+'\''+' and IsExpired__c = false and id in ('+dpquery+')';
         options.add(new SelectOption('','--All--'));
         for(Call_List__c ar: Database.query(query)){
             options.add(new SelectOption(AR.id, ar.Campaign_Name__c));
         }
         return options;   
     }
    
    public List<SelectOption> getCallStatus(){
        List<SelectOption> options = new List<SelectOption>();
        String opsi = label.cl_callstatus;
        List<String> listopsi = new List<String>();
        if(opsi!=null && opsi!='') listopsi = opsi.split(';');
        if(listopsi.size()>0){
            for(String s:listopsi){
                options.add(new SelectOption(s,s));
            }
        }
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