public class Valdo_SummaryDaily {
	@future (callout=true)  // future method needed to run callouts from Triggers
    static public void getSummaryDaily(String tgl, String bln, String thn){
        Date harival = date.newInstance(integer.valueOf(thn), integer.valueOf(bln), integer.valueOf(tgl));
        integer bulan = integer.valueOf(bln);
        integer tahun = integer.valueOf(thn);
        String bsk = String.valueof(integer.valueOf(tgl)+1);
        if(tgl.length()<2) tgl = '0'+tgl;
        if(bln.length()<2) bln = '0'+bln;
        if(bsk.length()<2) bsk = '0'+bsk;
        String url = Label.API_Valdo+'summary-daily?date='+thn+'-'+bln+'-'+tgl;
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
		Summary_Daily__c sd = new Summary_Daily__c();        
        decimal	Call_Offered = 0	;
        decimal	ACD = 0	;
        decimal	ACD_D = 0	;
        decimal	Abandon = 0	;
        decimal	A_Less = 0	;
        decimal	A_More = 0	;
        Decimal	A_Drop = 0	;
        decimal	Abandon_p = 0	;
        String	AHT	= '00:00:00';
        decimal	Service_Level = 0	;
        decimal	People = 0	;
        decimal	People_all = 0	;
		String 	description = '';
        String 	total = '';
        Integer jam = 0;
        Integer menit = 0;
        Integer detik = 0;
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
                if(test.isRunningTest()==true) parser = JSON.createParser(label.JSON_SummaryDaily);
                while (parser.nextToken() != null) {
                	if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Summary Data')){
                        parser.nextToken();
                         while (parser.nextToken() != JSONToken.END_ARRAY) {
                             if (parser.getText() == 'descr'){
                                 parser.nextToken(); 
                                 description = parser.getText();
                             }
                             else if (parser.getText() == 'total'){
                                 parser.nextToken(); 
                                 total = parser.getText();
                             } 
                             if(description!='' && total!=''){
                                 if(description== 'Call Offered'){
                                     if(total!='null') Call_Offered = decimal.valueOf(total);
                                 }
                                 else if(description== 'Answered Call Distribution'){
                                     if(total!='null') ACD = decimal.valueOf(total);
                                 }
                                 else if(description== 'Answered Call Distribution (<20sec)'){
                                     if(total!='null') ACD_D = decimal.valueOf(total);
                                 }
                                 else if(description== 'Abandon'){
                                     if(total!='null') Abandon = decimal.valueOf(total);
                                 }
                                 else if(description== '- Less than 5 second'){
                                     if(total!='null') A_Less = decimal.valueOf(total);
                                 }
                                 else if(description== '- More than 5 second'){
                                     if(total!='null') A_More = decimal.valueOf(total);
                                 }
                                 /*
                                 else if(description== '% Abandon'){
                                     Abandon_p = decimal.valueOf(total);
                                 }
                                 */
                                 else if(description== 'AHT'){
                                     if(total!='null') AHT = total;
                                 }
								/*
                                 else if(description== 'Service Level'){
                                     Service_Level = decimal.valueof(total);
                                 }
								*/
                                 else if(description== 'People Standby'){
                                     if(total!='null') People_all = decimal.valueof(total);
                                 }
                                 description = '';
                                 total = '';
                             }
                         }
                    }
                }
                sd.Call_Offered__c = Call_Offered;
                sd.Answered_Call_Distribution__c = acd;
                sd.Answered_Call_Distribution_20sec__c =acd_d;
                sd.Abandon__c = Abandon;
                sd.Abandon_Less_than_5_second__c = A_Less;
                sd.Abandon_More_than_5_second__c = A_More;
                //sd.Abandon_Percent__c = abandon_p;
                sd.People_Available_Staff_Back_Up__c = people_all;
                //sd.Service_Level__c = service_level;
                //sd.People_standby__c = People_standby;
				sd.Date__c = harival;
                sd.aht_time__c = AHT;
                List<String> timeaht  = AHT.split(':');
                Integer i = 0;
                for(String ta:timeaht){
                    i++;
                    String nilai = ta;
                    if(ta.substring(0, 1)=='0') nilai = ta.substring(1,2); 
                    if(i==1){
                        jam = integer.valueof(nilai);
                    }
                    else if(i==2){
                        menit = integer.valueOf(nilai);
                    }
                    else{
                        detik = integer.valueOf(nilai);
                    }
                }
                sd.type__c = 'Daily';
                sd.AHT__c = (jam*3600)+(menit*60)+(detik);
                sd.external_id__c = 'SD-'+thn+'-'+bln+'-'+tgl;
                upsert sd External_ID__c;
                
                List<AggregateResult> listag = [SELECT  sum(Abandon_Less_than_5_second__c) a, sum(Abandon_More_than_5_second__c) b, avg(AHT__c) c, 
                                                sum(Abandon_Drop_By_System__c) d, sum(Answered_Call_Distribution__c) e, sum(Answered_Call_Distribution_20sec__c) f, 
                                                sum(Abandon__c) g, sum(Call_Offered__c) h FROM Summary_Daily__c where calendar_month(date__C) =: bulan 
                                          	 	and calendar_year(date__c)=: tahun AND TYPE__C = 'Daily'];
                List<Summary_Daily__c> sdmc = [SELECT  date__c FROM Summary_Daily__c where calendar_month(date__C) =: bulan 
                                          	 	and calendar_year(date__c)=: tahun order by date__c desc limit 1];
                    for(AggregateResult ag:listag){
                        Summary_Daily__c sdmonth = new Summary_Daily__c();
                        sdmonth.AHT__c = integer.valueOf(ag.get('c'));
                        sdmonth.Abandon_Drop_By_System__c = integer.valueOf(ag.get('d'));
                        sdmonth.Abandon_Less_than_5_second__c = integer.valueOf(ag.get('a'));
                        sdmonth.Abandon_More_than_5_second__c = integer.valueOf(ag.get('b'));
                        sdmonth.Answered_Call_Distribution__c = integer.valueOf(ag.get('e'));
                        sdmonth.Answered_Call_Distribution_20sec__c = integer.valueOf(ag.get('f'));
                        sdmonth.Abandon__c = integer.valueOf(ag.get('g'));
                        sdmonth.Call_Offered__c = integer.valueOf(ag.get('h'));
                        String valtimeaht = '00:00:00';
                        integer valaht = integer.valueOf(ag.get('c'));
                        integer valjam = integer.valueof(math.floor(valaht/3600));
                        integer valmenit = integer.valueof(math.floor((math.mod(valaht, 3600))/60));
                        integer valdetik = math.MOD(math.MOD(valaht,3600),60);
                        if(valjam<10) valtimeaht = '0'+valjam+':';
                        else valtimeaht = string.valueOf(valjam)+':';
                        if(valmenit<10) valtimeaht = valtimeaht+'0'+valmenit+':';
                        else valtimeaht = valtimeaht+string.valueOf(valmenit)+':';
                        if(valdetik<10) valtimeaht = valtimeaht+'0'+valdetik;
                        else valtimeaht = valtimeaht+string.valueOf(valdetik);
                        system.debug('*valtimeaht*'+valtimeaht);
                        sdmonth.AHT_Time__c = valtimeaht;
                        sdmonth.External_ID__c = 'SM-'+bulan+'-'+tahun;
                        sdmonth.type__c = 'Monthly';
                        //sdmonth.Date__c = sdmc.Date__c;
                        if(sdmc.size()>0)sdmonth.Date__c = sdmc[0].Date__c;
                        else sdmonth.Date__c = harival;
                        upsert sdMONTH External_ID__c;
                        system.debug('sdMONTH'+sdMONTH);
                        system.debug('**'+integer.valueOf(ag.get('c')));
                        //IF(Duration_Wait__c/3600 < 10, '0','')+TEXT(FLOOR(Duration_Wait__c/3600)) + ":" + IF(FLOOR(MOD(Duration_Wait__c,3600)/60)< 10, '0','')+TEXT( FLOOR(MOD(Duration_Wait__c,3600)/60)) + ":" + IF(MOD(MOD(Duration_Wait__c,3600),60)< 10, '0','')+ TEXT(MOD(MOD(Duration_Wait__c,3600),60))
                    }
                
            }  
        }
        catch(exception e){
            system.debug('*error*'+e);
        }
    	
    }
}