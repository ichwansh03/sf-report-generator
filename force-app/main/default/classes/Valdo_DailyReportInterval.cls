public class Valdo_DailyReportInterval {
	@future (callout=true)  // future method needed to run callouts from Triggers
    static public void getDailyReport(String tgl, String bln, String thn){
    	Date harival = date.newInstance(integer.valueOf(thn), integer.valueOf(bln), integer.valueOf(tgl));
        String bsk = String.valueof(integer.valueOf(tgl)+1);
        if(tgl.length()<2) tgl = '0'+tgl;
        if(bln.length()<2) bln = '0'+bln;
        if(bsk.length()<2) bsk = '0'+bsk;
        String url = Label.API_Valdo+'report-inbound?start='+thn+'-'+bln+'-'+tgl+'&end='+thn+'-'+bln+'-'+tgl;
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
        List<Inbound_Call_Monthly_Interval__c> listica = new List<Inbound_Call_Monthly_Interval__c>();
        String interval = '';
        String Call_Offer = '';
        String total_acd = '';
        String acd_1 = ''; //acd<5
        String acd_2 = ''; //acd5-20
        String acd_3 = ''; //acd<=20
        String acd_4 = ''; //acd<=30
        String acd_5 = ''; //acd>20
        String Total_Abandone_Calls = '';	
        String Abandone_Calls_1 = ''; //Abandone Calls <=5Sec	
        String Abandone_Calls_2 = ''; //Abandone Calls <=20Sec	
        String Abandone_Calls_3 = ''; //Abandone Calls >20Sec	
        String AVG_Speed_Answer = '';
        String AVG_Abandone_Time = '';
        String AVG_ACD_Time = '';
        String SLA_1 = ''; //SLA (%)80/20	
        String SLA_2 = ''; //SLA (%)80/30	
        String SLA_3 = ''; //SLA (%)80/20 ACD
		List<Inbound_Call_Monthly_Interval__c> listcccc = new List<Inbound_Call_Monthly_Interval__c>();
        List<Schema.PicklistEntry> listpa = Inbound_Call_Monthly_Interval__c.interval__c.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry val:listpa){
            Inbound_Call_Monthly_Interval__c iccccc = new Inbound_Call_Monthly_Interval__c();
            iccccc.Date__c = harival;
            iccccc.external_id__c = val.getvalue()+'/'+tgl+'-'+bln+'-'+thn;
            iccccc.Interval__c = val.getvalue();
            iccccc.Call_Offered__c = 0;
            iccccc.Total_ACD_Calls__c = 0;
            iccccc.ACD_5_Secs__c = 0;
            iccccc.ACD_5_20Sec__c = 0;
            iccccc.ACD_20_Sec__c = 0;
            iccccc.ACD_30_Sec__c = 0;
            iccccc.ACD_20_Secs__c = 0;
            iccccc.Total_Abandone_Calls__c = 0;
            iccccc.Abandone_Calls_5Sec__c = 0;
            iccccc.Abandone_Calls_20Sec__c = 0;
            iccccc.Abandone_Calls_20Secs__c = 0;
            listcccc.add(iccccc);
        }
        
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
                if(test.isRunningTest()) parser = JSON.createParser(label.JSON_ReportInterval);
                while (parser.nextToken() != null) {
                	if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Interval Data')){
                        parser.nextToken();
                        integer i = 0;
                        while (parser.nextToken() != JSONToken.END_ARRAY) {
                            if (parser.getText() == 'jam'){
                                 parser.nextToken(); 
                                 String val = parser.getText();
                                 String val2 = val.replace(':00 - ', '-'); 
								 interval = val2.substring(0,11);
                             }
                            else if (parser.getText() == 'coff'){
                                 parser.nextToken(); 
                                 Call_Offer = parser.getText();
                            }
                            else if (parser.getText() == 'acd'){
                                 parser.nextToken(); 
                                 total_acd = parser.getText();
                            }
                            else if (parser.getText() == 'acd_kurang5s'){
                                 parser.nextToken(); 
                                 acd_1 = parser.getText();
                            }
                            else if (parser.getText() == 'acd_5sd20'){
                                 parser.nextToken(); 
                                 acd_2 = parser.getText();
                            }
                            else if (parser.getText() == 'acd_kurang20s'){
                                 parser.nextToken(); 
                                 acd_3 = parser.getText();
                            }
                            else if (parser.getText() == 'acd_kurang30s'){
                                 parser.nextToken(); 
                                 acd_4 = parser.getText();
                            }
                            else if (parser.getText() == 'acd_up20s'){
                                 parser.nextToken(); 
                                 acd_5 = parser.getText();
                            }
                            else if (parser.getText() == 'abandoned'){
                                 parser.nextToken(); 
                                 Total_Abandone_Calls = parser.getText();
                            }
                            else if (parser.getText() == 'abandoned_5s'){
                                 parser.nextToken(); 
                                 Abandone_Calls_1 = parser.getText();
                            }
                            else if (parser.getText() == 'abandoned_20s'){
                                 parser.nextToken(); 
                                 Abandone_Calls_2 = parser.getText();
                            }
                            else if (parser.getText() == 'abandoned_up20s'){
                                 parser.nextToken(); 
                                 Abandone_Calls_3 = parser.getText();
                            }
                            else if (parser.getText() == 'AVG_abandone'){
                                 parser.nextToken(); 
                                 AVG_Abandone_Time = parser.getText();
                            }
                            else if (parser.getText() == 'AVG_speed'){
                                 parser.nextToken(); 
                                 AVG_Speed_Answer = parser.getText();
                            }
                            else if (parser.getText() == 'AVG_acd'){
                                 parser.nextToken(); 
                                 AVG_ACD_Time = parser.getText();
                            }
                            else if (parser.getText() == 'SLA20S'){
                                 parser.nextToken();
                                 SLA_1 = parser.getText().replace('%','');
                            }
                            else if (parser.getText() == 'SLA30S'){
                                parser.nextToken(); 
                                SLA_2 = parser.getText().replace('%','');
                            }
                            else if (parser.getText() == 'SLA20SACD'){
                                parser.nextToken(); 
                                SLA_3 = parser.getText().replace('%','');
                                IF(interval!='' && Call_Offer!='' && total_acd!='' && acd_1!='' && acd_2!='' && acd_3!='' && acd_4!='' && acd_5!='' 
                                   && Total_Abandone_Calls!='' && Abandone_Calls_1!='' && Abandone_Calls_2!='' && Abandone_Calls_3!='' && AVG_Speed_Answer!=''
                                   && AVG_Abandone_Time!='' && AVG_ACD_Time!='' && SLA_1!='' && SLA_2!='' && SLA_3!='' && parser.nextToken() == JSONToken.END_OBJECT){
                                       Inbound_Call_Monthly_Interval__c icmi = new Inbound_Call_Monthly_Interval__c();
                                       icmi.Interval__c = interval;
                                       icmi.Date__c = harival;
                                       icmi.external_id__c = interval+'/'+tgl+'-'+bln+'-'+thn;
                                       icmi.Call_Offered__c = decimal.valueOf(Call_Offer);
                                       icmi.Total_ACD_Calls__c = decimal.valueOf(total_acd);
                                       icmi.ACD_5_Secs__c = decimal.valueOf(acd_1);
                                       icmi.ACD_5_20Sec__c = decimal.valueOf(acd_2);
                                       icmi.ACD_20_Sec__c = decimal.valueOf(acd_3);
                                       icmi.ACD_30_Sec__c = decimal.valueOf(acd_4);
                                       icmi.ACD_20_Secs__c = decimal.valueof(acd_5);
                                       icmi.Total_Abandone_Calls__c = decimal.valueOf(Total_Abandone_Calls);
                                       icmi.Abandone_Calls_5Sec__c = decimal.valueOf(Abandone_Calls_1);
                                       icmi.Abandone_Calls_20Sec__c = decimal.valueOf(Abandone_Calls_2);
                                       icmi.Abandone_Calls_20Secs__c = decimal.valueOf(Abandone_Calls_3);
                                       icmi.AVG_Speed_Answer_text__c = AVG_Speed_Answer;
                                       icmi.AVG_ACD__c = avg_acd_time;
                                       icmi.AVG_Abandone__c = AVG_Abandone_Time;
                                       if(sla_1!='null') icmi.SLA_80_20__c = decimal.valueOf(sla_1);
                                       if(sla_2!='null') icmi.SLA_80_30__c = decimal.valueOf(sla_2);
                                       if(sla_3!='null') icmi.SLA_80_20_ACD__c = decimal.valueOf(sla_3);
                                       integer x = 0;
                                       integer a = 0;
                                       integer b = 0;
                                       integer c = 0;
                                       List<String> listasa = AVG_Speed_Answer.split(':');
                                       for(String asa:listasa){
                                           x++;
                                           if(x==1){
                                               a = a +(integer.valueOf(asa)*3600);                                       
                                           }
                                           else if(x==2){
                                               a = a +(integer.valueOf(asa)*60); 
                                           }
                                           else{
                                               a = a +(integer.valueOf(asa));
                                           }
                                       }
                                       icmi.AVG_Speed_Answer__c = a;
                                       x =0;
                                       List<String> listacd = avg_acd_time.split(':');
                                       for(String asa:listacd){
                                           x++;
                                           if(x==1){
                                               b = b +(integer.valueOf(asa)*3600);                                       
                                           }
                                           else if(x==2){
                                               b = b +(integer.valueOf(asa)*60); 
                                           }
                                           else{
                                               b = b +(integer.valueOf(asa));
                                           }
                                       }
                                       x=0;
                                       icmi.AVG_ACD_Time__c = b;
                                       List<String> listAbandone = AVG_Abandone_Time.split(':');
                                       for(String asa:listAbandone){
                                           x++;
                                           if(x==1){
                                               c = c +(integer.valueOf(asa)*3600);                                       
                                           }
                                           else if(x==2){
                                               c = c +(integer.valueOf(asa)*60); 
                                           }
                                           else{
                                               c = c +(integer.valueOf(asa));
                                           }
                                       }
                                       icmi.AVG_Abandone_Time__c = c;
                                       x=0;
                                       listica.add(icmi);
                                   }
                                interval   				= '';
                                Call_Offer 				= '';
                                total_acd 				= '';
                                acd_1 					= '';
                                acd_2 					= '';
                                acd_3 					= '';
                                acd_4 					= '';
                                acd_5 					= '';
                                Total_Abandone_Calls 	= '';
                                Abandone_Calls_1 		= '';
                                Abandone_Calls_2 		= '';
                                Abandone_Calls_3 		= '';
                                AVG_Speed_Answer 		= '';
                                AVG_Abandone_Time 		= '';
                                AVG_ACD_Time 			= '';
                                SLA_1 					= '';
                                SLA_2 					= '';
                                SLA_3 					= '';
                            }
                        }
                    }
                }
            }
            if(listcccc.size()>0)  upsert listcccc external_id__c;
            if(listica.size()>0) upsert listica external_id__c;
        }
        catch(exception e){
            system.debug('*error*'+e);
        }
    }
}