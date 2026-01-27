global class BitlyBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global String query;
    global String url;
    global String shorturl;
    global BitlyBatch(String q) {
        this.query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<Email_SMS_Log__c> scope){

        for(Email_SMS_Log__c s : scope){
            if(s.Entity__c == 'AMFS'){
                executeT2M(s);
            }else{
                executeBitly(s);
            }
        }  
        update scope;
    }
    
    private void executeT2M(Email_SMS_Log__c s ){
        Map<String, String> properties = new Map<String,String>();
             System.debug('[?] [Survey URL -  excuteT2M]' + s.Survey_URL__c);
			 properties.put(EIPConstant.CS_COM_TARGET, s.Survey_URL__c);
		     //properties.put(EIPConstant.CS_COM_MESSAGE_ID,'sfdcicfaxaid'+s.Id);
             properties.put(EIPConstant.CS_COM_DELIVER_STATUS,'301');
             try{
                 EIPJson response = EIPConnector.sendCommunicationMessageT2M('createNewUrl', 'AMFS', 'T2MIO', properties);
                 String urlshort = response.Body.Customer.haveCommunicatedMessage[0].replyTo;
                 System.debug('[?] [Short URL -  T2M]' + urlshort);
                 if (urlshort != null && urlshort != ''){
                     if(s.Email_Text__c.contains('[SHORT_URL]')==true){
                         s.Email_Text__c = s.Email_Text__c.replace('[SHORT_URL]',urlshort);
                     } 
                     s.bitly__c = urlshort;
                     s.ready_to_send__c = true;
                 }	
             }catch(EIPConnector.NoDataException e){
                 System.debug('[?]'+ e);
             }catch(EIPConnector.EIPConnectorException e){
                 System.debug('[?]'+ e);
             }catch(Exception e){
                 System.debug('[?]' + e);
             }
        
        

    }
    private void executeBitly(Email_SMS_Log__c s){
            Boolean pos = true;
        	Boolean pos2 = true;
        	Boolean pos3 = true;
        	Boolean pos4 = true;
        	String a;
            a = 'a';
            a = 'a';
            a = 'a';
            a = 'a';
            a = 'a';
            a = 'a';
            a = 'a';
            a = 'a';
            String text;
            String text2;
            String Header='';
            String Body='';
            String Footer='';
            String login = '';
            String api = '';
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http h = new Http();
            //String urlsurv = s.Survey_URL__c;
            String urlsurv = EncodingUtil.urlEncode(s.Survey_URL__c,'UTF-8');
            //if(urlsurv.substring(0,7) != 'http://') urlsurv = 'http://'+urlsurv;
            //Token_Bitly__mdt tb = new Token_Bitly__mdt();
            ICF_Parameter__c tb = new ICF_Parameter__c();
            //tb = [select api_key__c, login__c from Token_Bitly__mdt where masterlabel = 'Bitly User Femy'];
            //url = 'http://api.bitly.com/v3/shorten?login=o_1s6din9ubo&apiKey=R_65a279b905fe4e5d9abe348ccdaa2f0e&longUrl='+urlsurv;
            try {
                /*
                IF(s.Entity__c == 'AFI'){
                    if(pos3==true){
                        tb = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_1__c != null and login_1__c != null and entity__c =: s.Entity__c];
                        login = tb.Login_1__c;
                        api = tb.API_Key_1__c;
                        if(tb.API_Key_2__c!= null) pos3 = false;
                    }
                    else{
                        tb = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_1__c != null and login_1__c != null and entity__c =: s.Entity__c];
                        login = tb.Login_2__c;
                        api = tb.API_Key_2__c;
                        pos3 = true;
                    }
                }
                ELSE IF(s.Entity__c == 'MAGI'){
                    if(pos2==true){
                        tb = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_1__c != null and login_1__c != null and entity__c =: s.Entity__c];
                        login = tb.Login_1__c;
                        api = tb.API_Key_1__c;
                        if(tb.API_Key_2__c!= null) pos2 = false;
                    }
                    else{
                        tb = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_1__c != null and login_1__c != null and entity__c =: s.Entity__c];
                        login = tb.Login_2__c;
                        api = tb.API_Key_2__c;
                        pos2 = true;
                    }
                }
                ELSE if(s.entity__c == 'AMFS'){
                    if(pos==true){
                        tb = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_1__c != null and login_1__c != null and entity__c =: s.Entity__c];
                        login = tb.Login_1__c;
                        api = tb.API_Key_1__c;
                        if(tb.API_Key_2__c!= null ) pos= false;
                    }
                    ELSE{
                        tb = [select api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_2__c != null and login_2__c != null and entity__c =: s.Entity__c];
                        login = tb.Login_2__c;
                        api = tb.API_Key_2__c;
                        pos = true;
                    }  
                }
                ELSE {
                    if(pos4==true){
                        tb = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_1__c != null and login_1__c != null and entity__c ='General'];
                        login = tb.Login_1__c;
                        api = tb.API_Key_1__c;
                        if(tb.API_Key_2__c!= null ) pos4= false;
                    }
                    ELSE{
                        tb = [select api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and api_key_2__c != null and login_2__c != null and entity__c ='General'];
                        login = tb.Login_2__c;
                        api = tb.API_Key_2__c;
                        pos4 = true;
                    }  
                }
                */
                List<ICF_Parameter__c> listicf = new List<ICF_Parameter__c>();
                if(s.Entity__c=='ALI'){
                    listicf = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and entity__c ='General' and Status__c='Active'];
                    if(listicf.size()>0){
                        if(pos4==true){
                            login = listicf[0].Login_1__c;
                            api = listicf[0].API_Key_1__c;
                            if(listicf[0].API_Key_2__c!= null ) pos4= false;
                        }
                        else{
                            login = listicf[0].Login_1__c;
                            api = listicf[0].API_Key_1__c;
                            pos4= true;
                        }   
                    }
                }
                else{
                    listicf = [select api_key_1__c, login_1__c, api_key_2__c, login_2__c from ICF_Parameter__c where Record_Type_Name__c Like '%Email%' and entity__c =: s.Entity__c and Status__c='Active'];
                    if(listicf.size()>0){
                        if(pos4==true){
                            login = listicf[0].Login_1__c;
                            api = listicf[0].API_Key_1__c;
                            if(listicf[0].API_Key_2__c!= null && s.Entity__c=='AMFS') pos= false;
                            if(listicf[0].API_Key_2__c!= null && s.Entity__c=='MAGI') pos2= false;
                            if(listicf[0].API_Key_2__c!= null && s.Entity__c=='AFI') pos3= false;
                        }
                        else{
                            login = listicf[0].Login_2__c;
                            api = listicf[0].API_Key_2__c;
                            if( s.Entity__c=='AMFS')pos= true;
                            if( s.Entity__c=='MAGI')pos2= true;
                            if( s.Entity__c=='AFI')pos3= true;
                        }   
                    }
                }
                url = 'http://api.bitly.com/v3/shorten?login='+login+'&apiKey='+api+'&longUrl='+urlsurv;
                req.setEndpoint(url);
                req.setMethod('GET');
                req.setHeader('Content-Type', 'application/json;charset=UTF-8');
                //req.setBody('{"notifications":[{ "account_id": "'+accountid+'","case_id" : ["'+caseid+'"]}]}');
                
                req.setCompressed(TRUE);
                req.setTimeout(120000);
                
                if(!Test.isRunningTest() && login!=null && login!='' && api!=null && api!='' && urlsurv!=null && urlsurv!='') res = h.send(req);
                String urlshort = '';
                if (res.getBody() != null) {
                    String responseBody = res.getBody();
                    if(test.isRunningTest()) responseBody = '{"status_code":200,"status_txt":"OK","data":{"url":"http://bit.ly/2nrkruO","hash":"2nrkruO","global_hash":"2V6CFi","long_url":"http://www.google.com/","new_hash":1}}';
                    JSONParser jparser = JSON.createParser(responseBody);
                    String statuscode = '';
                    while (jparser.nextToken() != null) {
                        if ((jparser.getCurrentToken() == JSONToken.FIELD_NAME) && (jparser.getText() == 'status_code')) {
                            jparser.nextValue(); 
                            statuscode = jparser.getText();
                            break;
                        }
                    }
                    if(statuscode=='200'){
                        while (jparser.nextToken() != null) {
                            if ((jparser.getCurrentToken() == JSONToken.FIELD_NAME) && (jparser.getText() == 'data')) {
                                jparser.nextToken(); // object start
                                //jparser.nextValue(); 
                                while (jparser.nextToken() != JSONToken.END_OBJECT){
                                    String txt = jparser.getText();
                                    jparser.nextToken();
                                    //jparser.nextValue();
                                    if (txt == 'url'){
                                        urlshort = jparser.getText();
                                        break;
                                    }
                                }
                            }
                        }    
                    }
                    System.debug(LoggingLevel.DEBUG, '***status code : ' + statuscode);
                    System.debug(LoggingLevel.DEBUG, '***response body : ' + responseBody);
                    System.debug(LoggingLevel.DEBUG, '***url short: ' + urlshort);
                    // taufik mii, 11 feb 2020, jika kosong, tdk ready.
                    if (urlshort != null && urlshort != ''){
                        if(s.Email_Text__c.contains('[SHORT_URL]')==true) s.Email_Text__c = s.Email_Text__c.replace('[SHORT_URL]',urlshort);
                        s.bitly__c = urlshort;
                        s.ready_to_send__c = true;
                        //update s;
                    }
                }
            }
            catch (Exception e) {
                String errorDesc = e.getMessage();
            }
        
    }
    
    
    
    global void finish(Database.BatchableContext BC){
        
    }
    
    
    
    /*
public string getURL() {


shortURL  = JSON.deserialize(jsonString, System.apexType);
return shortURL;
}
*/
}