trigger Trigger_CTI on Log_CTI_Valdo__c (after insert, before insert, after update, before update) {
    List<User> userali = [select id, sip__c from user where entity__c = 'ALI' and SIP__C !=null and isactive = true];
    FOR(Log_CTI_Valdo__c x:trigger.new){
        if(trigger.isafter){
            if(trigger.isinsert){
                if(x.Mode__c=='API Call Out' && x.ValdoDailyData__c == false){
                    //if(system.isFuture() == FALSE){
                    Valdo_Asterix.getCallOut(x.SIP__c, x.To__c, x.id);
                    //}
                }
            }
            else{
                if(x.Contact__c!=null && trigger.oldMap.get(x.id).contact__c == null && x.from__c!=null && x.Status__c == 'Inbound'){
                    Contact con = [select id, other_phone__c from contact where id=:x.Contact__c  ];
                    if(con.Other_Phone__c==null)con.Other_Phone__c = x.from__c;
                    if(con.Other_Phone__c!=null && con.Other_Phone__c.contains(x.from__c)==false)con.Other_Phone__c = con.Other_Phone__c+';'+x.from__c;
                    if(test.isRunningTest()==false) update con;
                }
                else if(x.Contact__c!=null && trigger.oldMap.get(x.id).contact__c == null && x.to__c!=null && x.Status__c == 'Outbound'){
                    Contact con = [select id, other_phone__c from contact where id=:x.Contact__c  ];
                    if(con.Other_Phone__c==null)con.Other_Phone__c = x.to__c;
                    if(con.Other_Phone__c!=null && con.Other_Phone__c.contains(x.to__c)==false)con.Other_Phone__c = con.Other_Phone__c+';'+x.to__c;
                    if(test.isRunningTest()==false) update con;
                }
            }    
        }
        else{
            if(x.sip__c!=null && x.Agent__c==null) {
                for(User us:userali){
                    if(x.SIP__c==us.sip__C) {
                        x.agent__c = us.id;
                        if(x.Status__c!='Inbound' && us.id != x.ownerid) x.ownerid = us.id;
                        break;
                    }
                }
            }
            if(trigger.isinsert){
                if(x.sip__C == null && x.sip__c == '' && test.isRunningTest()==false)  x.adderror('cannot get Outbound Not From Salesforce'); 
                
                if(x.Status__c == 'Outbound'){
                    x.Current_Phone__c = x.to__c;    
                }
                else if(x.Status__c=='Inbound') {
                    x.Current_Phone__c = x.From__c;
                }
                else{
                    if((x.Transfer_From__c!=null && x.SIP__c!=null) ){
                        List<Log_CTI_Valdo__c> lcti;
                        if(x.Recording_ID__c!=null){
                            lcti = [select id, from__c, to__c, Related_Call__c, Current_Phone__c, transfer_to__c from Log_CTI_Valdo__c where (Recording_File__c =: x.Recording_File__c) and id!=:x.id order by createddate desc limit 1];    
                            if(lcti.size()>0){
                                for(Log_CTI_Valdo__c log:lcti){
                                    x.Related_Call__c = log.Id; x.Current_Phone__c = log.from__c; if(x.SIP__c!=null)log.transfer_to__c = x.SIP__c;  log.status__c = 'Inbound' ; 
                                }
                               //update lcti;
                            }
                            else{
                                lcti = [select id, from__c, to__c, Related_Call__c, Current_Phone__c, transfer_to__c from Log_CTI_Valdo__c where ((sip__c =:x.Transfer_From__c /*and transfer_to__c=:x.SIP__c*/  and status__c='Inbound') ) and id!=:x.id order by createddate desc limit 1];
                                if(lcti.size()>0){
                                    for(Log_CTI_Valdo__c log:lcti){
                                        x.Related_Call__c = log.Id;  x.Current_Phone__c = log.from__c; if(x.sip__c!=null) log.transfer_to__c = x.SIP__c; log.status__c = 'Inbound' ;  
                                    }
                                  // update lcti;
                                }
                            }
                        }
                        else{
                            lcti = [select id, from__c, to__c, Related_Call__c, Current_Phone__c, transfer_to__c from Log_CTI_Valdo__c 
                                    where ((sip__c =:x.Transfer_From__c /*and transfer_to__c=:x.SIP__c*/  and status__c='Inbound') ) and id!=:x.id
                                    order by createddate desc limit 1];
                            if(lcti.size()>0){
                                for(Log_CTI_Valdo__c log:lcti){
                                    x.Related_Call__c = log.Id;                                
                                    x.Current_Phone__c = log.from__c;
                                    if(x.sip__c!=null) log.transfer_to__c = x.SIP__c;    
                                    log.status__c='Inbound';
                                }
                                //update lcti;
                            }   
                        }
                         
                    }    
                }
                if(x.Transfer_From__c!=null) x.Status__c = 'Transfer';
                if(x.Contact__c!=null) x.Policy_Status__c = 'Customer';
                if(x.Contact__c==null) x.Policy_Status__c = 'Non Customer';
            }
            else{
                if(x.Contact__c!=null) x.Policy_Status__c = 'Customer';
                if(x.Contact__c==null) x.Policy_Status__c = 'Non Customer';
                //if(x.Transfer_From__c!=null) x.Status__c = 'Transfer';
                if(x.Status__c=='Inbound') x.Current_Phone__c = x.From__c;
                if(x.Status__c=='Outbound') x.Current_Phone__c = x.to__c;
                if(x.Status__c=='Transfer'){
                    if((x.Transfer_From__c!=null && x.SIP__c!=null) ){
                        List<Log_CTI_Valdo__c> lcti ;
                        if(x.Related_Call__c!=null){
                            lcti = [select id, from__c, to__c, Related_Call__c, Current_Phone__c, transfer_to__c from Log_CTI_Valdo__c 
                                    where id=:x.Related_Call__c
                                    order by createddate desc limit 1];
                            if(lcti.size()>0){
                                for(Log_CTI_Valdo__c log:lcti){
                                    x.Related_Call__c = log.Id;                                
                                    x.Current_Phone__c = log.from__c;
                                    if(x.sip__c!=null) log.transfer_to__c = x.SIP__c;    
                                    log.status__c='Inbound';
                                }
                              //update lcti;
                            }
                        }                      
                        else if(x.Recording_ID__c!=null){
                            lcti = [select id, from__c, to__c, Related_Call__c, Current_Phone__c, transfer_to__c from Log_CTI_Valdo__c where (Recording_File__c =: x.Recording_File__c) and id!=:x.id order by createddate desc limit 1];    
                            if(lcti.size()>0){
                                for(Log_CTI_Valdo__c log:lcti){
                                    x.Related_Call__c = log.Id; x.Current_Phone__c = log.from__c; if(x.SIP__c!=null)log.transfer_to__c = x.SIP__c;  log.status__c = 'Inbound' ; 
                                }
                               //update lcti;
                            }
                            else{
                                lcti = [select id, from__c, to__c, Related_Call__c, Current_Phone__c, transfer_to__c from Log_CTI_Valdo__c where ((sip__c =:x.Transfer_From__c /*and transfer_to__c=:x.SIP__c*/  and status__c='Inbound') ) and id!=:x.id order by createddate desc limit 1];
                                if(lcti.size()>0){
                                    for(Log_CTI_Valdo__c log:lcti){
                                        x.Related_Call__c = log.Id;  x.Current_Phone__c = log.from__c; if(x.sip__c!=null) log.transfer_to__c = x.SIP__c; log.status__c = 'Inbound' ;  
                                    }
                                //    update lcti;
                                }
                            }
                        }
                        
                    }
                }
                //break;
            }
        }
    }
}