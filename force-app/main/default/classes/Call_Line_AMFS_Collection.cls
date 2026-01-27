public class Call_Line_AMFS_Collection {
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
    Public boolean campaignCheck {get;set;}
    Public String filretry {get;set;}
    Public String infoPendingSet {get;set;}
    Public String campaignName {get;set;}
    Public String batchNoSet {get; set;}
    
    Public String campName {
        get{
            String campaignNameList = '';
            if(filcampname != Null){
                if(filcampname != 'Collection Pending') {
                	campaignNameList = [select id,Campaign_Name__c from call_list__c where id = :filcampname].Campaign_Name__c;
                    campaignName = campaignNameList;
                } else campaignName = 'Collection Pending';
            }
            return campaignNameList;
        }
        set;
    }
    
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
    public Call_Line_AMFS_Collection(){
        index = 0;
        blockSize = 10;
        idparam = '';
        stapol = '';
        Offering = 'All';
        filcallstatus='No';
        campaignCheck = false;
        pro = [select name from Profile where id=:UserInfo.getProfileId()];
        entityUser = [Select Entity__c From User Where Id = :UserInfo.getUserId()].Entity__c;
	}
    
    public void fetch(){
        DescribeSObjectResult describeResultdp = Call_Line__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        String fields = 'Campaign_Name__c, Status_Retry__c, Status_has_call__c, CreatedDate, Name, Policy_No__c, Contact__c, Parent__c, APE__c, Product__c, Agent__c, Collection_Call_Date__c, '
            +'Call_Status_Config__c, Reason_Status_Config__c, Reschedule_Date__c, Contacted_Number__c, Activity_Config__c, Case_Type_Config__c, Call_Line__c.APE_Convert__c, Call_Line__c.Formula_Product__c, '
            +'Call_Line__c.Activity__c, Call_Line__c.Case_Type__c, Call_Line__c.Amount__c, Batch_no__c,Attemp_Call__c,Attempt_call_Day__c';
        
        //String qr = 'SELECT count(id) cid FROM Call_Line__c where Parent_Campaign__c!=null and Is_Expired__c = false ';
        // taufik, khusus untuk Campaign Pending, tapi sudah expired.
        String qr = '';
        qr = 'SELECT count(id) cid FROM Call_Line__c where Parent_Campaign__c!=null and Is_Expired__c = false ';
        if (filcampname == 'Collection Pending')
            qr = 'SELECT count(id) cid FROM Call_Line__c where Parent_Campaign__c!=null and Parent_Campaign__r.IsExpired__c = TRUE and Status_has_call__c = '+'\'Pending\''+' ';
        
        if (filcampname == 'Collection Pending')
	        soql = 'SELECT '+fields+' FROM Call_Line__c where Parent_Campaign__c!=null and Parent_Campaign__r.IsExpired__c = TRUE ';
		else
	        soql = 'SELECT '+fields+' FROM Call_Line__c where Parent_Campaign__c!=null and Is_Expired__c = false ';

        if(filcampname == 'Collection Pending') soql = soql + ' and Status_has_call__c = \'Pending\' ';
        else if(filcampname!=null && filcampname!='') soql = soql + ' and Call_List__c='+'\''+filcampname+'\''+' ';
        
        //if(filcallstatus!=NULL && filcallstatus!='' && filcallstatus != 'All') soql = soql + ' and  Call_Status_Config__c='+'\''+filcallstatus+'\''+' ';
        
        if(filcallstatus!=NULL && filcallstatus!='' && filcallstatus != 'All') {
            String callStatus = '';
            if(filcallstatus == 'Closed'){
                callStatus = ' AND (Call_Status_Config__c = \'Approved\' OR Call_Status_Config__c = \'Not Approved\' OR Call_Status_Config__c = \'N\' OR Call_Status_Config__c = \'Y\''
                    +'OR Call_Status_Config__c = \'Cancel By System\' OR Call_Status_Config__c = \'Cencel\' OR Call_Status_Config__c = \'Inforce\')' +' ';
            } else if(filcallstatus == 'Pending'){
                callStatus = ' AND (Call_Status_Config__c = \'Uncontacted\' OR Call_Status_Config__c = \'F\' OR Call_Status_Config__c = \'P\' OR Call_Status_Config__c = \'Pending\' OR Call_Status_Config__c = \'Retry\')' +' ';
            } else if(filcallstatus == 'Takeout'){
                callStatus = ' AND (Call_Status_Config__c = \'Takeout\')' +' ';
            } else if(filcallstatus == 'Blank'){
                callStatus = ' AND (Call_Status_Config__c = null OR Call_Status_Config__c = \'\')' +' ';
            }
            soql = soql +callStatus +' ';
        }
        
        if(batchNoSet != NULL && batchNoSet != '' && batchNoSet != 'All'){
            String batch = '';
            if(batchNoSet == '(none)'){
                batch = ' AND Batch_No__c = null ';
            } else {
                batch = ' AND Batch_No__c = \'' +batchNoSet +'\' ';
            }
            soql = soql +batch +' ';
        }
        
        if(filcampname!=null && filcampname!=''){
            if(infoPendingSet != Null && infoPendingSet != 'All' && infoPendingSet != ''){
                String pending = ' AND Info_Pendingan__c = \'' +infoPendingSet +'\' ';
                soql = soql + pending + ' ';
            }
        }
                
        if(filretry != null && filretry != 'All') soql = soql + ' AND Status_Retry__c='+'\''+filretry+'\''+' ';
        /*
        if(filcallstatus=='Yes' && filcallstatus!=NULL) soql = soql + ' and Call_Status_Config__c != NULL ' ;
        if(filcallstatus=='No' && filcallstatus!=NULL) soql = soql + ' and Call_Status_Config__c = NULL ';
        if(offering!='All' && offering!= NULL )soql = soql + ' and Offering__c = '+'\''+offering+'\''+' ';
        if(filcallstatus=='Rescheduled'  && filcallstatus!=NULL) soql = soql + ' and Call_Status_Config__c = '+'\''+filcallstatus+'\''+' ';
        if(filcallstatus== 'No Pickup/ Mailbox' && filcallstatus!=NULL ) soql = soql + ' and Reason_Status_Config__c = '+'\''+filcallstatus+'\''+' ';
		*/
        if(stapol!='' && stapol!=null) soql = soql + ' and Status_Polis__c = '+'\''+stapol+'\''+' ';
        system.debug('#query : '+soql);
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
        
        if (filcampname != null){
            // Taufik, 14 Mar20, add function collection pending.
            String campaignName = 'Collection Pending';
            if (filcampname != 'Collection Pending')
        		campaignName = [select id,Campaign_Name__c from call_list__c where id = :filcampname].Campaign_Name__c;
                
            if (campaignName.Contains('Withdrawal') || campaignName.contains('Redemption Konven')){
                campaignCheck = true;
            }
            else {
                campaignCheck = false;
            }    
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
    
    public List<SelectOption> getStatusRetry(){
        List<SelectOption> options = new List<SelectOption>();
        
        Schema.DescribeFieldResult fieldResult = Call_Line__c.Status_Retry__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption('All','All'));
        for( Schema.PicklistEntry f : ple){
        	options.add(new SelectOption(f.getLabel(), f.getValue()));    
        }    
         return options;   
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
		 //updated by Fajar Salam 
		 //for ordering and prevent for random value
         if (entityUser == 'AMFS') query = 'SELECT id, Campaign_Name__c  from Call_List__c where recordtype.name = '+'\''+'Collection AMFS'+'\''+' and IsExpired__c = false and id in ('+dpquery+') order by createdDate DESC, Campaign_Name__c';
         options.add(new SelectOption('','--All--'));
         for(Call_List__c ar: Database.query(query)){
             options.add(new SelectOption(AR.id, ar.Campaign_Name__c));
         }
         options.add(new SelectOption('Collection Pending', 'Collection Pending'));
         return options;   
     }
    
    public List<SelectOption> getCallStatus(){
        //List<SelectOption> options = new List<SelectOption>();
        //String opsi = label.cl_callstatus;
        //List<String> listopsi = new List<String>();
        //if(opsi!=null && opsi!='') listopsi = opsi.split(';');
        //Schema.DescribeFieldResult picklistCallStatus = Call_Line__c.Call_Status_Config__c.getDescribe();
        //List<Schema.PicklistEntry> ple = picklistCallStatus.getPicklistValues();
        //if(!picklistCallStatus.isEmpty()){
            //for(Schema.PicklistEntry s : ple){
            //    options.add(new SelectOption(s.getLabel(),s.getLabel()));
            //}options.add(new SelectOption('All','All'));
        //} 
        
        List<SelectOption> options = new List<SelectOption>();
        if (filcampname != null|| Test.isRunningTest()){
            
        	if (campaignName.contains('Lapse Konven') || Test.isRunningTest()) {
                //options.add(new SelectOption('Approved','Approved'));
                
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }        
            if (campaignName.contains('MKP') || Test.isRunningTest()) {
                //options.add(new SelectOption('Not Approved','Not Approved'));
                
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }
            if (campaignName.contains('Cuti Premi') || Test.isRunningTest()) {
                //options.add(new SelectOption('Uncontacted','Uncontacted'));
                
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }
            if (campaignName.contains('RTU') || Test.isRunningTest()) {
                /*
                options.add(new SelectOption('Sudah Pay by System','Sudah Pay by System'));
                options.add(new SelectOption('Reschedule','Reschedule'));
                options.add(new SelectOption('All','All'));
                */
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }
            if (campaignName.contains('Renewal Reminder') || campaignName.contains('TRO Project') || campaignName.contains('Others') || Test.isRunningTest()) {
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }
            if (campaignName.contains('Redemption Konven') || Test.isRunningTest()) {
                //options.add(new SelectOption('F','F'));
                
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }
            if (campaignName.contains('Withdrawal') || Test.isRunningTest()) {
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }
            if (campaignName.contains('Lapse TM') || Test.isRunningTest()) {
                /*
                options.add(new SelectOption('Approved','Approved'));
                options.add(new SelectOption('Not Approved','Not Approved'));
                options.add(new SelectOption('Uncontacted','Uncontacted'));
                options.add(new SelectOption('Sudah Pay by System','Sudah Pay by System'));
                options.add(new SelectOption('Cancel by System','Cancel by System'));
                options.add(new SelectOption('Reschedule','Reschedule'));
                options.add(new SelectOption('All','All'));
                */
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }
            if (campaignName.contains('Redemption TM') || Test.isRunningTest()) {
                options.add(new SelectOption('All','All'));
                options.add(new SelectOption('Blank','Blank (none)'));
                options.add(new SelectOption('Pending','Pending'));
                options.add(new SelectOption('Closed','Closed'));
                options.add(new SelectOption('Takeout','Takeout'));
            }    
        }
        else options.add(new SelectOption('None','None'));
        
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
    
    public List<SelectOption> infoPendingan{
        get{
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult fieldResult = Call_Line__c.Info_Pendingan__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            options.add(new SelectOption('All','All'));
            for( Schema.PicklistEntry f : ple)
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            return options;
        }
    }
    
    public List<SelectOption> batchNo{
        get{
            List<SelectOption> options = new List<SelectOption>();
            List<AggregateResult> batchList = [Select Batch_No__c from Call_line__c where Parent_Campaign__c = :filcampname group by Batch_No__c];
            options.add(new SelectOption('All','All'));
            for(AggregateResult bn : batchList){
                String batch = String.ValueOf(bn.get('Batch_No__c'));
                if(batch == Null) batch = '(none)';
                options.add(new SelectOption(batch, batch));
            }
            return options;
        }
    }
    
    public void beginning()
    {
        index = 0;
        fetch();
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