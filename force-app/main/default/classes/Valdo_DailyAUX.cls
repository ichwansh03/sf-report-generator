public class Valdo_DailyAUX {
	@future (callout=true)  // future method needed to run callouts from Triggers
    static public void getDailyAUX(String tgl, String bln, String thn){
        Date harival = date.newInstance(integer.valueOf(thn), integer.valueOf(bln), integer.valueOf(tgl));
        String bsk = String.valueof(integer.valueOf(tgl)+1);
        if(tgl.length()<2) tgl = '0'+tgl;
        if(bln.length()<2) bln = '0'+bln;
        if(bsk.length()<2) bsk = '0'+bsk;
        String url = Label.API_Valdo+'daily-aux?date='+tgl+'/'+bln+'/'+thn;
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
        List<Agent_Status__c> listagent_status = new List<Agent_Status__c>();
        List<User> listagent = [select id, sip__c from user where sip__c != null];
        String SIP = '';
        String SERVICE_TIME = '';
        String AVERAGE_TALK_TIME = '';
        String AUX_TIME = '';
        String LOGIN_TIME = '';
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setTimeout(120000);
        //req.setHeader('content-type','application/json');
        try{
            HttpResponse res = new HttpResponse();
            if(test.isRunningTest()==false) res = h.send(req);
            if(res.getBody()!=null || test.isRunningTest()){
                JSONParser parser;
                if(test.isRunningTest()==false) parser = JSON.createParser(res.getBody());
                if(test.isRunningTest()) parser = JSON.createParser(label.JSON_DailyAUX);
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Aux')){
                        parser.nextToken(); 
                        while (parser.nextToken() != JSONToken.END_ARRAY) {
                            if (parser.getText() == 'SIP'){
                                parser.nextToken(); 
                                sip = parser.getText();
                            }
                            else if (parser.getText() == 'SERVICE_TIME'){
                                parser.nextToken(); 
                                SERVICE_TIME = parser.getText();
                            }
                            else if (parser.getText() == 'AVERAGE_TALK_TIME'){
                                parser.nextToken(); 
                                AVERAGE_TALK_TIME = parser.getText();
                            }
                            else if (parser.getText() == 'AUX'){
                                parser.nextToken(); 
                            	AUX_TIME = parser.getText();    
                            }
                            else if (parser.getText() == 'LOGIN_TIME'){
                                parser.nextToken(); 
                                LOGIN_TIME = parser.getText();
                            }
                            
                            if(sip!='' && SERVICE_TIME!='' && AVERAGE_TALK_TIME!='' && AUX_TIME!='' && LOGIN_TIME!=''){
                                //system.debug('*lewat*');
                                Agent_Status__c ag = new Agent_Status__c();
                                if(listagent.size()>0){
                                    for(User us:listagent){
                                        if(us.sip__c == sip){
                                			ag.Agent__c = us.id;
                                            break;
                                        }
                                    }
                                }
                                ag.Date__c = harival;
                                ag.SIP__c = SIP;
                                if(AUX_TIME!='null') ag.Duration_AUX_Time__c = Integer.valueOf(AUX_TIME);
                                if(AVERAGE_TALK_TIME!='null') ag.Duration_Average_Talk_Time__c = Integer.valueOf(AVERAGE_TALK_TIME);
                                if(SERVICE_TIME!='null') ag.Duration_Service_Time__c = Integer.valueOf(SERVICE_TIME);
                                ag.external_id__c = sip+'-'+tgl+'-'+bln+'-'+thn;
                                ag.Login_Time__c = datetime.valueOf(LOGIN_TIME);
                                listagent_status.add(ag);
                                SIP = '';
                                SERVICE_TIME = '';
                                AVERAGE_TALK_TIME = '';
                                AUX_TIME = '';
                                LOGIN_TIME = '';
                            }
                        }
                        break;
                    }
                }
                
                if(listagent_status.size()>0) upsert listagent_status external_id__c;
                system.debug(LoggingLevel.INFO,'*listagent_status*'+listagent_status.size());
            }  
        }
        catch(exception e){
            system.debug('*error*'+e);
        }
    	
    }
}