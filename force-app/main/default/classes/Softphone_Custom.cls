public class Softphone_Custom {
    Public String iduser {get;set;}
    Public Integer countval {get;set;}
    Public List<Log_CTI_Valdo__c> lcv {get;set;}
    Public List<Contact> con {get;set;}
    Public String warna {get;set;}
    Public List<User> objuser {get;set;}
    Public String Status {get;set;}
    
    Public String idupdate {get;set;}
    Public String urlFire{get;set;}
    
    public String phone_incoming {get;set;}
    Public String Phone_Number{get;set;}
    public String requestLabel;
    public String result {get;set;}
    private static final String LONG_RUNNING_SERVICE_URL = 'https://axasales.valdo-intl.com/API/call?dari=SIP/';

    public String sip {get;set;}
    public string idlog {get;set;}
    public boolean cancall {get;set;}
    public Softphone_Custom(){        
        countval = 0;
        iduser = UserInfo.getUserId();
        if(warna==null) warna = 'green';
        if(status==null) Status = 'Available';
        objuser =[select sip__c, Call_From_Contact__c from user where id =:iduser];
        if(objuser.size()>0) {
            sip = objuser[0].sip__c;
            cancall = objuser[0].Call_From_Contact__c;
        }
        //checkfire();
        //if(objuser.size()>0){
        	
            /*
            lcv = [select id, name, answer__c, to__c, from__c from Log_CTI_Valdo__c where answer__c = false and sip__c =: objuser[0].sip__c  order by createddate desc limit 1];    
        	countval = lcv.size();
            if(lcv.size()>0){
             	warna = 'red';
                Status = 'Incoming';
                phone_incoming = lcv[0].from__c;
                //Phone_Number = lcv[0].from__c;
            }
			*/
        //}
		
        if(phone_incoming==null) Phone_incoming = '';
        if(phone_number==null)Phone_Number = '';
    }
    public void num0(){
        Phone_Number = Phone_Number+'0';
    }
    public void num1(){
        Phone_Number = Phone_Number+'1';
    }
    public void num2(){
        Phone_Number = Phone_Number+'2';
    }
    public void num3(){
        Phone_Number = Phone_Number+'3';
    }
    public void num4(){
        Phone_Number = Phone_Number+'4';
    }
    public void num5(){
        Phone_Number = Phone_Number+'5';
    }
    public void num6(){
        Phone_Number = Phone_Number+'6';
    }
    public void num7(){
        Phone_Number = Phone_Number+'7';
    }
    public void num8(){
        Phone_Number = Phone_Number+'8';
    }
    public void num9(){
        Phone_Number = Phone_Number+'9';
    }
    public void numbintang(){
        Phone_Number = Phone_Number+'*';
    }
    public void numpagar(){
        Phone_Number = Phone_Number+'#';
    }
    public void remove(){
        Integer long_val = Phone_Number.length();
        if(long_val>0) Phone_Number = Phone_Number.substring(0,Phone_Number.length()-1);
        system.debug('*phone*'+phone_number);
    }
    public void number_get(){
        phone_number = phone_number;
    }
    
    public Void Btn_Green(){
        //if(Status=='Available'){
       if(Phone_Number!=null && Phone_Number!=''){
       		User us = [select sip__c from user where id=:userinfo.getUserId()];
            //create log
            Log_CTI_Valdo__c lcti = new Log_CTI_Valdo__c();
            lcti.SIP__c = us.SIP__c;
            lcti.To__c = phone_number;
            lcti.Mode__c = 'API Call Out';
            lcti.Status__c = 'Outbound';
            insert lcti;
            idlog = lcti.id;
            sip = us.SIP__c; 
            
            //startRequest();
        }
       
        //}
        /*
        else if(Status=='Incoming'){
            getanswer();
        }
		*/
    }
    
    public Void Btn_Red(){
        if(Status=='Available'){
            Phone_Number='';
            Phone_incoming = '';
            warna = 'green';
        }
        else if(Status=='Incoming'){
            getreject();
            warna = 'green';
        }
    }
    
    public void getstatus(){
        iduser = UserInfo.getUserId();
        objuser =[select sip__c from user where sip__c !=null and id =:iduser];
        if(objuser.size()>0){
        	lcv = [select id, name, answer__c, to__c, from__c from Log_CTI_Valdo__c where answer__c = false and sip__c =: objuser[0].sip__c  order by createddate desc limit 1];    
        	countval = lcv.size();
            if(lcv.size()>0){
                Status = 'Incoming';
                warna = 'red';
            } 
        }
    }
    /*
    public void getanswer(){
        iduser = UserInfo.getUserId();
        lcv[0].answer__c = true;
        update lcv;
        system.debug('lewat sini');
        objuser =[select sip__c from user where sip__c !=null and id =:iduser];
        if(objuser.size()>0){
            lcv = [select id, name, answer__c, to__c, from__c from Log_CTI_Valdo__c where answer__c = false and sip__c =: objuser[0].sip__c  order by createddate desc limit 1];    
            countval = lcv.size();
            if(lcv.size()==0){
                warna = 'Orange';
                Status = 'Dialing';
            } 
        }
    }
    */
    public void getreject(){
        iduser = UserInfo.getUserId();
        //lcv[0].answer__c = true;
        //update lcv;
        objuser =[select sip__c from user where sip__c !=null and id =:iduser];
        if(objuser.size()>0){
            lcv = [select id, name, answer__c, to__c, from__c from Log_CTI_Valdo__c where answer__c = false and sip__c =: objuser[0].sip__c  order by createddate desc limit 1];    
            countval = lcv.size();
            if(lcv.size()==0){
                warna = 'Green';
                Status = 'Available';
                Phone_Number = '';
                Phone_incoming = '';
            } 
        }
    }
    
    public void getStop(){
        warna='Green';
        Status='Available';
    }
    /*
    // Action method
    public Object startRequest() {
      // Create continuation with a timeout
      Continuation con = new Continuation(120);
      // Set callback method
      con.continuationMethod='processResponse';
      
      // Create callout request
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      //  if(Phone_Number==null) Phone_Number='081218625912';
     if(idlog==null) idlog='001';
     if(sip==null) sip='700';
     String nomor = LONG_RUNNING_SERVICE_URL+sip+'&custname='+Phone_Number+'&to='+Phone_Number+'&idsfdc='+idlog;
     system.debug('*nomor*'+nomor);
        req.setEndpoint(nomor);
      
      // Add callout request to continuation
      this.requestLabel = con.addHttpRequest(req);
      //system.debug('*response*'+con.addHttpRequest(req));
      // Return the continuation
      return con;  
    }
    
    // Callback method 
    public Object processResponse() {   
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(this.requestLabel);
      // Set the result variable that is displayed on the Visualforce page
        if(response.getBody()!=null){
          this.result = response.getBody();  
        } 
        else{
            this.result = 'failed';
        } 
          
      // Return null to re-render the original Visualforce page
      return null;
    }
    */
    
    public void checkfire(){
        String sipfire = '%'+sip+'%';
        iduser = UserInfo.getUserId();
        List<Log_CTI_Valdo__c> logcti = [select id, sip__c, ownerid from Log_CTI_Valdo__c where owner.name Like :sipfire limit 1];
        //PageReference pr;
        if(logcti.size()>0){
            List<User> listuserfire = [select id from user where sip__c =:logcti[0].sip__c];
            urlfire= '/'+logcti[0].id;
            if(listuserfire.size()>0){
              	logcti[0].ownerid = listuserfire[0].id;
                idupdate = logcti[0].id;
            } 
            //update logcti;
            //pr = new PageReference('/apex/redirect_contact_fire?id='+logcti[0].id);
        }
        else{
            urlfire='';
        }
        //return pr;
    }
}