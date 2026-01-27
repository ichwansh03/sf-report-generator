public class Redirect_Contact {
    List<Contact> listcontact{get;set;}
    Public String urlval{get;set;}
    Public String strval{get;set;}
    Public String ids {get;set;}
    Public String contact_name {get;set;}
    public Redirect_Contact(ApexPages.StandardController controller){
        strval ='';        urlval='';        contact_name='';        ids = ApexPages.CurrentPage().getParameters().get('id');
        system.debug('*ids*'+ids);
    }
    
    public Redirect_Contact(){
        if(test.isRunningTest()){
            strval ='';
            urlval='';
            contact_name='';
            //Log_CTI_Valdo__c lcti =  [select id from Log_CTI_Valdo__c limit 1];
            //ids = lcti.id;
            system.debug('*ids*'+ids);    
        }
    }

    
    public void actionfunction(){
        if(ids!=null || test.isRunningTest()){
            Log_CTI_Valdo__c lcti = new Log_CTI_Valdo__c();
            /*
            if(test.isRunningTest()){
                lcti.sip__c = '703';
                lcti.to__c = '703';
                lcti.from__c = '12345678';
                lcti.Status__c = 'Inbound';
                lcti.Mode__c = 'API Call In';
                insert lcti;
            }
            else{
*/
                lcti = [select sip__c, from__c, to__c, contact__c, case__c, mode__c, call_line__c , agent__c
                        from Log_CTI_Valdo__c 
                        where id=:ids];    
  //          }
            
            if(lcti.SIP__c!=null && lcti.Agent__c==null){
                List<User> listuser = [select id from user where sip__c=:lcti.SIP__c];
                if(listuser.size()>0) lcti.Agent__c = listuser[0].id;
            }
            
            if(lcti.Mode__c=='API Call In'){
                listcontact = [select id, name, phone, homephone, mobilephone, otherphone, assistantphone from contact where Entity__c = 'ALI' and (phone =:lcti.from__c OR 
                               homephone =:lcti.from__c OR mobilephone =:lcti.from__c OR otherphone =:lcti.from__c OR 
                               Mobile_F__c =: lcti.From__c ) limit 2];

//                listcontact = [select id, name, phone, homephone, mobilephone, otherphone, assistantphone from contact where Entity__c = 'ALI' and (phone =:lcti.from__c OR 
//                               homephone =:lcti.from__c OR mobilephone =:lcti.from__c OR otherphone =:lcti.from__c OR assistantphone =:lcti.from__c OR 
//                               Mobile_F__c =: lcti.From__c OR other_phone__c includes (:lcti.From__c) ) limit 10];
                               
                if(listcontact.size()==1){
                    lcti.Contact__c = listcontact[0].id; strval = listcontact[0].id; urlval = '/'+listcontact[0].id; contact_name = listcontact[0].name; 
                }
                else{
                    strval = lcti.From__c;
                    contact_name = lcti.From__c;
                    urlval = '/_ui/search/ui/UnifiedSearchResults?str=';
                    urlval = urlval+lcti.From__c;
                }    
                
            }
            else If(lcti.Mode__c=='API Call Out' && lcti.call_line__c!=null){
                strval = lcti.call_line__c;
                urlval = '/'+lcti.call_line__c;
            }
            update lcti;
            system.debug('*urlval*'+urlval);
        }
    }
}