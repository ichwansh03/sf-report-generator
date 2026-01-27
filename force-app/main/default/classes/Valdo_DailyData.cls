public class Valdo_DailyData {
	@future (callout=true)  // future method needed to run callouts from Triggers
    static public void getDailyCall(String tgl, String bln, String thn){
        String bsk = String.valueof(integer.valueOf(tgl)+1);
        if(tgl.length()<2) tgl = '0'+tgl;
        if(bln.length()<2) bln = '0'+bln;
        if(bsk.length()<2) bsk = '0'+bsk;
        String url = Label.API_Valdo+'daily-data?date='+thn+'/'+bln+'/'+tgl;
        List<Log_CTI_Valdo__c> listlog = new List<Log_CTI_Valdo__c>();
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
        String idvaldo = '';
        String duration_call = '';
        String duration_wait = '';
        String duration_dialling = '';
        String Start_Call_date = '';
        String Start_Dial_date = '';
        String End_Call_date = '';
        String sip = '';
        String recording_file = '';
        String status = '';
        String transfer_from = '';
        String transfer_to = '';
        String DESTINATION_NUMBER = '';
        DescribeSObjectResult describeResultdp = Log_CTI_Valdo__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        //String query = 'SELECT '+dpFields+' from Log_CTI_Valdo__c where createddate >= '+thn+'-'+bln+'-'+tgl+'T00:00:00Z AND createddate<= '+thn+'-'+bln+'-'+bsk+'T00:00:00Z order by createddate desc';
		String query = 'SELECT '+dpFields+' from Log_CTI_Valdo__c where DAY_ONLY(CreatedDate) >= '+thn+'-'+bln+'-'+tgl+' order by createddate desc';
        //List<Log_CTI_Valdo__c> listlogcti = Database.query(query);
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
                if(test.isRunningTest()) parser = JSON.createParser(label.JSON_DailyData);
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Data')){
                        parser.nextToken(); 
                        while (parser.nextToken() != JSONToken.END_ARRAY) {
                            if (parser.getText() == 'ID_VALDO'){
                                parser.nextToken(); 
                                idvaldo = parser.getText();
                            }
                            else if (parser.getText() == 'SIP'){
                                parser.nextToken(); 
                                sip = parser.getText();
                            }
                            else if (parser.getText() == 'DESTINATION_NUMBER'){
                                parser.nextToken(); 
                                DESTINATION_NUMBER = parser.getText();
                            }
                            else if (parser.getText() == 'RECORDING_FILE'){
                                parser.nextToken(); 
                                recording_file = parser.getText();
                            }
                            else if (parser.getText() == 'START_DIALING_DATE'){
                                parser.nextToken(); 
                                Start_Dial_date = parser.getText();
                            }
                            else if (parser.getText() == 'START_CALL_DATE'){
                                parser.nextToken(); 
                                Start_Call_date = parser.getText();
                            }
                            else if (parser.getText() == 'END_CALL_DATE'){
                                parser.nextToken(); 
                                End_Call_date = parser.getText();
                            }
                            else if (parser.getText() == 'DURATION_WAIT'){
                                parser.nextToken(); 
                            	duration_wait = parser.getText();    
                            }
                            else if (parser.getText() == 'DURATION_CALL'){
                                parser.nextToken(); 
                            	duration_call = parser.getText();    
                            }
                            else if (parser.getText() == 'DURATION_DIAL'){
                                parser.nextToken(); 
                            	duration_dialling = parser.getText();    
                            }
                            else if (parser.getText() == 'STATUS'){
                                parser.nextToken(); 
                                status = parser.getText();
                            }
                            else if (parser.getText() == 'TRANSFER_FROM'){
                                parser.nextToken(); 
                                transfer_from = parser.getText();
                            }
                            else if (parser.getText() == 'TRANSFER_TO'){
                                parser.nextToken(); 
                                transfer_to = parser.getText();
                             	
                                if(idvaldo!='' && sip!='' && Start_Call_date!='' && Start_Dial_date!='' && End_Call_date!='' && duration_call!='' && duration_wait!='' 
                                   && duration_dialling!='' && status!='' && DESTINATION_NUMBER!='' && recording_file!='' && parser.nextToken() == JSONToken.END_OBJECT){
                                       //if(parser.nextToken() == JSONToken.END_OBJECT){
                                       //system.debug('*lewat*');
                                       //if(listlogcti.size()>0){
                                       //  for(Log_CTI_Valdo__c log:listlogcti){
                                       //    if(log.id_valdo__C==idvaldo){
                                       Log_CTI_Valdo__c lcti = new Log_CTI_Valdo__c();
                                       lcti.ID_Valdo__c = idvaldo;
                                       lcti.SIP__c = sip;
                                       lcti.Start_Calling__c = datetime.valueOf(Start_Call_date);
                                       lcti.Start_Dialling__c = datetime.valueOf(Start_Dial_date);
                                       lcti.End_Calling__c = datetime.valueOf(End_Call_date);
                                       lcti.Duration_Wait__c = Integer.valueOf(duration_wait);
                                       lcti.Duration_Call__c = Integer.valueOf(duration_call);
                                       lcti.Duration_Dialing__c = Integer.valueOf(duration_dialling);
                                       lcti.Recording_ID__c = Recording_file;
                                       lcti.Status__c = status;
                                       lcti.Transfer_From__c = transfer_from;
                                       lcti.Transfer_To__c = transfer_to;
                                       lcti.ValdoDailyData__c = true;
                                       if(status=='OUTBOUND') LCTI.To__c = DESTINATION_NUMBER;
                                       ELSE LCTI.From__c = DESTINATION_NUMBER;
                                       listlog.add(lcti);
                                       //break;
                                       //  }
                                       //}   
                                       //}
                                       
                                   }
                                idvaldo = '';
                                Start_Call_date = '';
                                Start_Dial_date = '';
                                End_Call_date = '';
                                duration_wait = '';
                                duration_call = '';
                                duration_dialling = '';
                                recording_file = '';
                                status ='';
                                transfer_from = '';
                                transfer_to ='';
                                sip = '';
                                DESTINATION_NUMBER = '';
                            }
                        }
                        break;
                    }
                }
                
                if(listlog.size()>0) upsert listlog id_valdo__c;
                system.debug(LoggingLevel.INFO,'*listlog*'+listlog.size());
            }  
        }
        catch(exception e){
            system.debug('*error*'+e);
        }
    }
}