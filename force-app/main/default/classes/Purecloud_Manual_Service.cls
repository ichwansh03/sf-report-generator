public class Purecloud_Manual_Service {
    public Date tgl {get;set;}
    public String Pilihan {get;set;}
    public Named_User__c ChooseUser {get;set;}
    //public String conversationId {get;set;}
    public Purecloud_Manual_Service(){
        ChooseUser = new Named_User__c();
    }
    
    public List<SelectOption> getCategoryService(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','None'));
        options.add(new SelectOption('Call Agent Status','Call Agent Status'));
        options.add(new SelectOption('Daily Call Service Interval 30M','Daily Call Service Interval 30M'));
        options.add(new SelectOption('Call Summary Daily','Call Summary Daily'));
        options.add(new SelectOption('Purecloud Access Token','Purecloud Access Token'));
        options.add(new SelectOption('Purecloud IVR Survey Result','Purecloud IVR Survey Result'));
        return options;   
     }
    
    public void action(){
        if(tgl!=null && (Pilihan!=null || Pilihan != '')){
            String hri = String.valueof(tgl.day());
            String bln = String.valueof(tgl.month());
            String thn = String.valueof(tgl.year());
            Date newtgl = tgl.addDays(-1);
            String newhri = String.valueof(newtgl.day());
            String newbln = String.valueof(newtgl.month());
            String newthn = String.valueof(newtgl.year());
            String startInterval; 
            String endInterval; 
            
            system.debug('#Pilihan : '+Pilihan);
            if(Pilihan == 'Call Agent Status' || test.isRunningTest()){
                String s = newthn+'-'+newbln+'-'+newhri+'T17:00.000Z';
                String e = thn+'-'+bln+'-'+hri+'T17:00.000Z';
                String q;
                system.debug('FORMAT DATE S ==>'+s);
                system.debug('FORMAT DATE E ==>'+e);
                system.debug('Choose User ==>'+ChooseUser.User__c);
                system.debug('Choose Entity ==>'+ChooseUser.Entity__c);
                
                if (test.isRunningTest()) q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and isActive = TRUE LIMIT 1';
                else if (ChooseUser.User__c != NULL) q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE ID = '+'\''+ChooseUser.User__c+'\''+' and isActive = TRUE';
                else if (ChooseUser.Entity__c != NULL) q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and Entity__c = '+'\''+ChooseUser.Entity__c+'\''+' and isActive = TRUE';
                else q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = '+'\''+'Purecloud'+'\''+' and isActive = TRUE';
                
                //else q = 'SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c = '+'\''+'2f728212-ff4a-4ccb-b7b6-da884da58983'+'\''+'';
                
                Purecloud_InsertCallAgent bb = new Purecloud_InsertCallAgent(q,s,e);
                Database.executeBatch(bb,1);
                System.debug('#'+Pilihan+' : OK - Call Agent Status - '+tgl);
            }
            if(Pilihan == 'Daily Call Service Interval 30M'){
                startInterval = newthn+'-'+newbln+'-'+newhri+'T17:00.000Z';
                endInterval = thn+'-'+bln+'-'+hri+'T17:00.000Z';
                Purecloud_InsertCallService.getTest(startInterval, endInterval);
                Purecloud_InsertCallService_Callback.getTest(startInterval, endInterval);
                System.debug('#'+Pilihan+' : OK - Daily Call Service Interval 30M');
            }
            if(Pilihan == 'Call Summary Daily'){
                startInterval = newthn+'-'+newbln+'-'+newhri+'T17:00.000Z';
                endInterval = thn+'-'+bln+'-'+hri+'T17:00.000';
                Purecloud_InsertDailySummary.getTest(startInterval, endInterval);
                Purecloud_InsertDailySummary_Callback.getTest(startInterval, endInterval);
                System.debug('#'+Pilihan+' : OK - Call Summary Daily');
            }
            if(Pilihan == 'Purecloud Access Token'){
                Purecloud_Connector.execute();
                System.debug('#'+Pilihan+' : OK - Purecloud Access Token');
            }
            if(Pilihan == 'Purecloud IVR Survey Result' || test.isRunningTest()){
                String createdDate = String.valueof(tgl);
                //String q = 'SELECT Id,CallObject FROM Task WHERE DAY_ONLY(CreatedDate) = '+ createdDate +' AND PureCloud_Question1__c = '+'\''+'-'+'\'';
                String q = 'SELECT Id, CallObject, CreatedDate, LastModifiedDate FROM Task WHERE ( Call_Type__c != NULL OR Start_Calling__c != NULL OR Start_Dialing__c != NULL )' +
                    // 'and DAY_ONLY(CreatedDate) = ' + createdDate + 'AND PureCloud_Question1__c = ' + '\' ' + '-' + '\' order by lastmodifieddate asc limit 10000';      //new query
                    //' AND Duration_Call__c > '+label.PurecloudDurationCall+' AND (PureCloud_Question1__c = NULL OR PureCloud_Question1__c = '+'\''+'-'+'\''+') and DAY_ONLY(CreatedDate) = ' + createdDate + ' order by LastModifiedDate ASC limit 10000';    //new query - Taufik 4 Nov 2020
                    ' AND Duration_Call__c > '+label.PurecloudDurationCall+' AND API_Status__c != '+'\''+'Okay'+'\''+' AND (PureCloud_Question1__c = NULL OR PureCloud_Question1__c = '+'\''+'-'+'\''+') and DAY_ONLY(CreatedDate) = ' + createdDate + ' order by LastModifiedDate ASC limit 10000';    //new query - Taufik 4 Nov 2020
                
                Purecloud_GetSurveyResult_Batch bb = new Purecloud_GetSurveyResult_Batch(q);
                Database.executeBatch(bb,20);
                System.debug('#'+Pilihan+' : OK - Purecloud IVR Survey Result');
            }
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'OK - '+Pilihan+' - '+Tgl));
        }
    }
}