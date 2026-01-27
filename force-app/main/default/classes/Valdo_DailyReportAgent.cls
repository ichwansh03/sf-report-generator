public class Valdo_DailyReportAgent {
	@future (callout=true)  // future method needed to run callouts from Triggers
    static public void getDailyReport(String tgl, String bln, String thn){
        integer bulan = integer.valueOf(bln);
        integer tahun = integer.valueOf(thn);
    	Date harival = date.newInstance(integer.valueOf(thn), integer.valueOf(bln), integer.valueOf(tgl));
        String bsk = String.valueof(integer.valueOf(tgl)+1);
        if(tgl.length()<2) tgl = '0'+tgl;
        if(bln.length()<2) bln = '0'+bln;
        if(bsk.length()<2) bsk = '0'+bsk;
        String url = Label.API_Valdo+'daily-report?start='+thn+'-'+bln+'-'+tgl+'&end='+thn+'-'+bln+'-'+tgl;
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
        List<Inbound_Call_Monthly_Agent__c> listicma = new List<Inbound_Call_Monthly_Agent__c>();
        List<User> listagent = [select id, sip__c from user where sip__c != null];
        String SIP = '';
        String ACD_Calls = '';
        String AHT = '';
        String TAT = '';
        String TTS = '';
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setTimeout(120000);
        try{
            HttpResponse res = new HttpResponse();
            if(test.isRunningTest()==false) res = h.send(req);
            if(res.getBody()!=null || test.isRunningTest()){
                JSONParser parser;
                if(test.isRunningTest()==false) parser = JSON.createParser(res.getBody());
                if(test.isRunningTest()==true) parser = JSON.createParser(label.JSON_ReportAgent);
                system.debug('*json*'+res.getBody());
                while (parser.nextToken() != null) {
                	if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Summary Data')){
                        parser.nextToken();
                        integer i = 0;
                        while (parser.nextToken() != JSONToken.END_ARRAY) {
                            if (parser.getText() == 'SIP'){
                                parser.nextToken(); 
                                SIP = parser.getText();
                            }
                            else if (parser.getText() == 'AHT'){
                                parser.nextToken(); 
                                AHT = parser.getText();
                            }
                            else if (parser.getText() == 'TOTAL_ACD'){
                                parser.nextToken(); 
                                ACD_Calls = parser.getText();
                            }
                            else if (parser.getText() == 'avaltime'){
                                parser.nextToken(); 
                                TAT = parser.getText();
                            }
                            else if (parser.getText() == 'Total_time_Staff'){
                                parser.nextToken(); 
                                TTS = parser.getText();
                                integer x = 0;
                                Integer waktu = 0;
                                
                                if(SIP!='' && AHT!='' && ACD_Calls!='' && TAT!='' && TTS!='' && parser.nextToken() == JSONToken.END_OBJECT){
                                	Inbound_Call_Monthly_Agent__c icma = new Inbound_Call_Monthly_Agent__c();
                                    icma.SIP__c = SIP;
                                    if(ACD_Calls!='null') {
                                        if(listagent.size()>0){
                                            for(User us:listagent){
                                                if(us.sip__c == SIP){
                                                    icma.Agent_Name__c = us.id;
                                                    break;
                                                }
                                            }
                                        }
                                        icma.Date__c = harival;
                                        icma.External_ID__c = harival+'-'+SIP;
                                        icma.AHT__c = AHT;
                                        List<String> listaht = AHT.split(':');
                                        if(listaht.size()>1){
                                            for(String st:listaht){
                                               x++;
                                                if(x==1){
                                                    waktu = (integer.valueOf(st)*3600)+waktu;
                                                }
                                                else if(x==2){
                                                    waktu = (integer.valueOf(st)*60)+waktu;
                                                }
                                                else{
                                                    waktu = (integer.valueOf(st))+waktu;
                                                }
                                            }
                                        }
                                    }
                                    icma.Type__c = 'Daily';
                                    if(ACD_Calls!='null')icma.ACD_Calls__c = integer.valueof(ACD_Calls);
                                    if(TAT!='null')icma.Total_Available_Seconds__c = integer.valueof(TAT);
                                    if(TTS!='null')icma.Total_Time_Staffed_Seconds__c = integer.valueof(TTS);
                                    //listicma.add(icma);
                                    upsert icma External_ID__c;
                                    system.debug('*icma*'+icma);
                                }
                                SIP=''; 
                                AHT=''; 
                                ACD_Calls=''; 
                                TAT=''; 
                                TTS='';
                            }
                        }
                    }
                }
                
                List<AggregateResult> listag = [SELECT SUM(AHT_Second__c) a, SUM(Total_Available_Seconds__c) b, SUM(Total_Time_Staffed_Seconds__c) c, 
                                                SUM(ACD_Calls__c) d, Agent_Name__c e, SIP__c f FROM Inbound_Call_Monthly_Agent__c 
                                                WHERE CALENDAR_MONTH(DATE__C) =: bulan AND CALENDAR_YEAR(DATE__C) =: tahun  
                                                GROUP BY Agent_Name__c, SIP__c];
                List<Inbound_Call_Monthly_Agent__c> sdmc = [SELECT  date__c FROM Inbound_Call_Monthly_Agent__c where calendar_month(date__C) =: bulan 
                                          	 	and calendar_year(date__c)=: tahun order by date__c desc limit 1];
                for(AggregateResult ar:listag){
                    Inbound_Call_Monthly_Agent__c iccccc = new Inbound_Call_Monthly_Agent__c();
                    iccccc.Agent_Name__c = string.valueOf(ar.get('e'));
                    iccccc.sip__c = string.valueOf(ar.get('f'));
                    iccccc.AHT_Second__c = integer.valueOf(ar.get('a'));
                    iccccc.Total_Available_Seconds__c = integer.valueOf(ar.get('b'));
                    iccccc.Total_Time_Staffed_Seconds__c = integer.valueOf(ar.get('c'));
                    iccccc.ACD_Calls__c = integer.valueOf(ar.get('d'));
                    iccccc.Type__c = 'Monthly';
                    iccccc.External_ID__c = string.valueOf(ar.get('f'))+'-'+bulan+'-'+tahun;
                    system.debug('*exter*'+string.valueOf(ar.get('f'))+'-'+bulan+'-'+tahun);
                    String valtimeaht = '00:00:00';
                    integer valaht = integer.valueOf(ar.get('a'));
                    integer valjam = integer.valueof(math.floor(valaht/3600));
                    integer valmenit = integer.valueof(math.floor((math.mod(valaht, 3600))/60));
                    integer valdetik = math.MOD(math.MOD(valaht,3600),60);
                    if(valjam<10) valtimeaht = '0'+valjam+':';
                    else valtimeaht = string.valueOf(valjam)+':';
                    if(valmenit<10) valtimeaht = valtimeaht+'0'+valmenit+':';
                    else valtimeaht = valtimeaht+string.valueOf(valmenit)+':';
                    if(valdetik<10) valtimeaht = valtimeaht+'0'+valdetik;
                    else valtimeaht = valtimeaht+string.valueOf(valdetik);
                    iccccc.AHT__c = valtimeaht;
                    if(sdmc.size()>0)iccccc.Date__c = sdmc[0].Date__c;
                    else iccccc.Date__c = harival;
                   	upsert iccccc External_ID__c;
                }
				
                //if(listicma.size()>0) upsert listicma External_ID__c;
            }
        }
        catch(exception e){
            system.debug('*error*'+e);
        }
    }
}