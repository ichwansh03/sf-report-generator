public class Call_Line_Retention {
    Public String idparam {get;set;}
    public integer index {get;set;}
    public integer blockSize {get;set;}
    public integer totalRecs {get;set;}
    public integer totalAllRecs {get;set;}
    public Boolean fetchCalled;
    public String owner_cl {get;set;}
    public String reason_status {get;set;}
    public String call_status {get;set;}
    Public String has_cases {get;set;}
    Public Profile pro {get;set;}
    PUBLIC String SOQL {get;set;}
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
    public Call_Line_Retention(){
        index = 0;
        blockSize = 10;
        idparam = '';
        owner_cl = 'All';
        has_cases = 'All';
        reason_status = '';
        call_status = '';
        pro = [select name from Profile where id=:UserInfo.getProfileId()];
    }
    
    public void fetch(){
        DescribeSObjectResult describeResultdp = Call_Line__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        // taufik, 24 okt 2018, filter Call_Status_Config__c Takeout Contacted dan Uncontacted
        String qr = '';
        if(call_status!=null && call_status!='') qr = 'SELECT count(id) cid FROM Call_Line__c where CreatedDate = THIS_MONTH and Call_Status_Config__c = '+'\''+call_status+'\''+' and recordtype.name =  '+'\''+'ALI 10'+'\''+' ';
        else qr = 'SELECT count(id) cid FROM Call_Line__c where Call_Status_Config__c != '+'\''+'Contacted'+'\''+' and Call_Status_Config__c != '+'\''+'Uncontacted'+'\''+' and recordtype.name =  '+'\''+'ALI 10'+'\''+' ';
        soql = 'SELECT '+dpFields+' FROM Call_Line__c where recordtype.name =  '+'\''+'ALI 10'+'\''+' ';
        if(owner_cl=='My') soql = soql + ' and ownerid = '+'\''+UserInfo.getUserId()+'\''+' ';
        if(has_cases=='Yes') soql = soql + ' and case__c != null ';
        if(has_cases=='No') soql = soql + ' and case__c = null ';
        if(reason_status!=null && reason_status!='') soql = soql + ' and Reason_Status_Config__c = '+'\''+reason_status+'\''+' ';
        if(call_status!=null && call_status!='') soql = soql + ' and CreatedDate = THIS_MONTH and Call_Status_Config__c = '+'\''+call_status+'\''+' ';
        else soql = soql + ' and Call_Status_Config__c != '+'\''+'Contacted'+'\''+' and Call_Status_Config__c != '+'\''+'Uncontacted'+'\''+' ';
        /*
        if(pro.Name=='System Administrator'){
        
        }
        else{
            qr = qr + ' and agent__c ='+'\''+UserInfo.getUserId()+'\''+' ';
        }
        */
        AggregateResult ar = Database.query(qr);
        totalAllRecs = Integer.valueOf(ar.get('cid'));
        soql = soql + ' order by '+SortField+' '+sortDir;
        soql = soql + ' limit 40000 ';
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
        return listcl;
    }
    
    public List<SelectOption> getCall_Status_Config(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','None'));
        Schema.DescribeFieldResult fieldResult = call_line__c.Call_Status_Config__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }
        return options;   
     }
    
     public List<SelectOption> getReason_Status_Config(){
         List<SelectOption> options = new List<SelectOption>();
         options.add(new SelectOption('','None'));
         List<String> listoption = new List<String>();
         if(Call_Status=='Contacted'){
            listoption = label.CLR_Resaon_Contacted.split(',');
         }
         else if(Call_Status=='Uncontacted'){
            listoption = label.CLR_Reason_Uncontacted.split(',');    
         }
         else{
            listoption = label.CLR_Reason.split(',');    
         }
         
         for(String f:listoption){
             options.add(new SelectOption(f, f));
         } 
        /*
        Schema.DescribeFieldResult fieldResult =  call_line__c.Reason_Status_Config__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple)
        {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }
         */
        return options;   
     }
    
    public List<SelectOption> getOwner_Call(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('My','My'));
        return options;   
    }
    
    public List<SelectOption> getcases_Call(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All','All'));
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;   
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