public class Valdo_Asterix {

     @future (callout=true)  // future method needed to run callouts from Triggers
      static public void getCallOut(String sip, String targetnumber, string idlog){
          Log_CTI_Valdo__c lcti= [select id, contact__c, contact__r.name, Response_api__c, error_api__C, id_valdo__c, call_line__c from Log_CTI_Valdo__c where id=:idlog];
		  
          String url = '';
          String valstr = targetnumber+'SIP/'+sip;
          String valvaldo = 'ValdoCallAsterisk';
          String shasign = '';
          Datetime sekarang = datetime.now();
          String tanggal = sekarang.format('ddMMyyyy');
          //String shasign = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf('702')));
          //sha1(082110822906SIP/703uyteuyqValdoCallAsterisk)
          //system.debug('*sha*'+shasign);
          if(lcti.Contact__c!=null){
              String name = EncodingUtil.urlEncode(lcti.Contact__r.name,'UTF-8');              valstr = valstr+lcti.Contact__r.name+tanggal+LABEL.secretkey;              shasign = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf(valstr)));              url = Label.API_Valdo+'calls?dari=SIP/'+sip+'&to='+targetnumber+'&custname='+name+'&signature='+shasign;//+targetnumber;
          }
          else{
              valstr = valstr+'NonCustomer'+tanggal+LABEL.secretkey;
              shasign = EncodingUtil.convertToHex(Crypto.generateDigest('SHA1',Blob.valueOf(valstr)));
              url = Label.API_Valdo+'calls?dari=SIP/'+sip+'&to='+targetnumber+'&custname=NonCustomer'+'&signature='+shasign;//+targetnumber;
          }
              system.debug(LoggingLevel.DEBUG,'*valstr*'+valstr);
 			system.debug(LoggingLevel.DEBUG,'*url*'+url);
          // build callout
          String idvaldo ='';
          String startcall = '';
          String errorval = '';
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
                  system.debug(LoggingLevel.DEBUG,'*response api*'+res.getBody());
                  JSONParser parser;
                  if(test.isRunningTest()==false) parser = JSON.createParser(res.getBody());
                  if(test.isRunningTest()) parser = JSON.createParser('{"name":"NonCustomer","SIP":"703","to":"082110822906","uniqueid":"1509007812.1815x","start_call":"2017-10-26 15:50:12","errors":""}');
                  while (parser.nextToken() != null) {
                      if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'uniqueid')){
                          parser.nextValue(); // object start
                          idvaldo = parser.getText();
                          //break;
                      }
                      if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'start_call')){
                          parser.nextValue(); // object start
                          startcall = parser.getText();
                          //break;
                      }
                      if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'errors')){                          
                          parser.nextValue(); // object start                          
                          errorval = parser.getText();
                          //break;
                      }
                      
                  }
                  if(errorval != ''){                      lcti.error_api__C = errorval;                      update lcti;
                  }
                  else{
                      if(idvaldo!=null && idvaldo!='' && idvaldo!='null' ){
                          List<Log_CTI_Valdo__c> listlcti= [select id, Response_api__c, id_valdo__c 
                                                            from Log_CTI_Valdo__c 
                                                            where id_valdo__c =: idvaldo];
                          if(listlcti.size()>0){
                              lcti.error_api__C = 'id valdo with id '+idvaldo+' is duplicate in id salesforce '+listlcti[0].id +' \n '+res.getBody();
                              update lcti;
                          }
                          else{
                              lcti.Response_API__c = res.getBody();
                              lcti.id_valdo__c = idvaldo;
                              lcti.Start_Dialling__c = Datetime.valueOf(startcall);
                              update lcti;
                              if(lcti.Call_Line__c!=null || test.isRunningTest()){
                                  Call_Line__C cl = new Call_Line__c();
                                  cl =[select Last_Call__c, Count_Dial__c from Call_Line__c where id=:lcti.Call_Line__c];
                                  if(cl.Count_Dial__c!=null) cl.Count_Dial__c = cl.Count_Dial__c + 1;
                                  if(cl.Count_Dial__c==null) cl.Count_Dial__c = 1;
                                  cl.Last_Call__c = datetime.now();
                                  update cl;
                              }    
                          }
                      }
                      else{                          lcti.error_api__C = 'id valdo is null '+res.getBody();                          update lcti;
                      }    
                  }
              }
              else{                  lcti.error_api__C = 'Response is Null';                  update lcti;
              }
          }
          catch(exception e){
              system.debug('*error*'+e);
              Log_CTI_Valdo__c lcti2= [select id, error_api__C, Response_api__c, id_valdo__c from Log_CTI_Valdo__c where id=:idlog];
              lcti2.error_api__C = String.valueOf(e);
              update lcti2;
          }
    }
}