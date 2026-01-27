Global class Purecloud_InsertDailySummary_Callback {
    @future (callout=true)
    public static void getTest(String startInterval, String endInterval){
        String url = Label.API_Purecloud+'api/v2/analytics/conversations/aggregates/query';
        String clientid = Label.Purecloud_ClientId;
        String clientSecret = Label.Purecloud_ClientSecret;
        String token = [SELECT Access_token__c FROM Purecloud_Connector__c WHERE Name = 'Purecloud Token' Limit 1].Access_token__c;
        String ownerAdmin = [SELECT Id FROM User Where Username = 'taufik.susanto@mii.co.id.ccc' AND Profile.Name = 'System Administrator'].id;
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
        system.debug('TOKEN ==>'+token);

        system.debug('Taufik - Masuk');
        
        Integer year = Integer.Valueof(Date.valueof(endInterval).year());
        Integer month = Integer.Valueof(Date.valueof(endInterval).month());
        Integer day = Integer.Valueof(Date.valueof(endInterval).day());
        
        List<Purecloud_Master_Queue__c> listQueueCallback = [Select ID, Name, Queue_Id__c, Entity__c, Skill__c, Languange__c, Type__c FROM Purecloud_Master_Queue__c Where Queue_Id__c != null and type__c = 'Callback'];
        List<PureCloud_Call_Summary__c> conCount = new list<PureCloud_Call_Summary__c>();
        List<PureCloud_Call_Summary__c> conSum = new list<PureCloud_Call_Summary__c>();
        List<PureCloud_Call_Summary__c> conView = new list<PureCloud_Call_Summary__c>();
        List<Purecloud_Call_Summary__c> CallbacktoInsert = new List<Purecloud_Call_Summary__c>();
        List<PureCloud_Call_Summary__c> upsertconCountWithoutDuplicate = new list <PureCloud_Call_Summary__c>();
        List<PureCloud_Call_Summary__c> upsertconSumWithoutDuplicate = new list <PureCloud_Call_Summary__c>();
        List<PureCloud_Call_Summary__c> upsertconViewWithoutDuplicate = new list <PureCloud_Call_Summary__c>();
        List<Purecloud_Call_Summary__c> CallbackWithoutDuplicates = new List <Purecloud_Call_Summary__c>();
        
        //METRICS
        String queueid = '0';
        String nOffered = '0';
        String nTransferredCount = '0';
        String tTalkCount = '0';
        String tAbandonCount = '0';
        String tHeldCount = '0';
        String tAnsweredSum = '0';
        String tAbandonSum = '0';
        String tTalkSum = '0';
        String tAcwSum = '0';
        String tHeldSum = '0';
        String tHandleSum = '0';
        String tHandleCount = '0';
        String tAcwCount = '0'; 
        //VAR
        Date tglTrue;
        String tgl = '0';
        String entity = '0';
        //VIEW ANSWER
        String answerLT20s = '0';
        //VIEW ABANDON
        String abandonLT5s = '0';
        String abandonGTEqual5s = '0';
        
        list <PureCloud_Call_Summary__c> pcs = new list <PureCloud_Call_Summary__c>();
        for (Purecloud_Master_Queue__c que : listQueueCallback){          
			PureCloud_Call_Summary__c newq = new PureCloud_Call_Summary__c();
            newq.OwnerId = ownerAdmin;
            newq.Queue__c = que.queue_id__c;
            newq.Queue_Name__c = que.Name;
            newq.Entity__c = que.entity__c;
            newq.Date__c = date.valueof(endInterval);
            newq.External_ID__c = que.queue_id__c + '_' + year + '-' + month + '-' + day + '_Callback';
            newq.Handle_Sum__c = 0;
            newq.Abandon_Count_5_Sec__c = 0; 
            newq.Abandon_Count_5_Sec_Up__c = 0;
            newq.Abandon_Count__c = 0;
            newq.Call_Offered__c = 0;
            newq.ACD_Count_20_Sec__c = 0;
            newq.ACD_Count__c = 0;
            newq.ACD_Sum__c = 0;
            newq.ACW_Sum__c = 0;
            newq.Hold_Sum__c = 0;
            newq.Callback_Count__c = 0;
            pcs.add(newq);  
        }
        		
                Http h = new Http(); 
                HttpRequest req = new HttpRequest();
                req.setEndpoint(url);
                req.setMethod('POST');
                req.setTimeout(120000);
                req.setHeader('content-type', 'application/json');
                req.setHeader('Authorization', 'Bearer '+ token);
				
        		// taufik, 6 Nov 2018, tambahkan Queue untuk filter.
				//req.setBody('{  "interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "groupBy": [   "queueId"  ],  "filter": {   "type": "or",   "predicates": [    {     "type": "dimension",     "dimension": "mediaType",     "operator": "matches",     "value": "callback"    }   ]  },  "views": [   {    "name": "Answerlt20s",    "target": "tAnswered",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "19999"    }   },   {    "name": "Abandonlt5s",    "target": "tAbandon",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "4999"    }   },   {    "name": "Abandongtequal5s",    "target": "tAbandon",    "function": "rangeBound",    "range": {     "gte": "5000",     "lt": "9999999"    }   }  ],  "metrics": [   "nOffered",   "tAbandon",   "tAcd",   "tAcw",   "tHeld"  ,"tFlowOut"] }');
				
                String BodyFilterClauses = '';
				BodyFilterClauses = '  "clauses": [   {    "type": "or",    "predicates": [';
        		for (integer i = 0; i < listQueueCallback.size(); i++)
        			if (i == 0) BodyFilterClauses += '     {      "type": "dimension",      "dimension": "queueId",      "operator": "matches",      "value": "'+listQueueCallback[i].Queue_Id__c+'"     } ';
        			else BodyFilterClauses += '     ,{      "type": "dimension",      "dimension": "queueId",      "operator": "matches",      "value": "'+listQueueCallback[i].Queue_Id__c+'"     }';

        		BodyFilterClauses += '    ]   }  ],';
        		if (listQueueCallback.size() == 0) BodyFilterClauses = '';
        		
        		system.debug('Taufik - BodyFilterClauses : '+BodyFilterClauses);
				req.setBody('{  "interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "groupBy": [   "queueId"  ],  "filter": {   "type": "and",  '+BodyFilterClauses+' "predicates": [    {     "type": "dimension",     "dimension": "mediaType",     "operator": "matches",     "value": "callback"    }   ]  },  "views": [   {    "name": "Answerlt20s",    "target": "tAnswered",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "19999"    }   },   {    "name": "Abandonlt5s",    "target": "tAbandon",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "4999"    }   },   {    "name": "Abandongtequal5s",    "target": "tAbandon",    "function": "rangeBound",    "range": {     "gte": "5000",     "lt": "9999999"    }   }  ],  "metrics": [   "nOffered",  "nOutbound","tHandle" ,"tAbandon",   "tAnswered",   "tAcw",   "tHeld"  ] }');
        		
        		blob exResAgg = [SELECT Body FROM StaticResource WHERE Name='ResBody_ConAggregate_QueueId_Daily'].Body;   
				String conAggregateDailyResponseDummy = exResAgg.toString();

        		try{
                    HttpResponse res = new HttpResponse();
                    res = h.send(req);
                    String parser;
                    //JSONParser parser;
                    //if(test.isRunningTest()==false) parser = JSON.createParser(res.getBody());
                    if(test.isRunningTest()) parser = conAggregateDailyResponseDummy; //JSON.createParser(conAggregateDailyResponseDummy);
                    else parser = res.getBody(); //JSON.createParser(res.getBody());
                         
                    system.debug('*body*'+parser);
                    if (parser != '{}') {
                    
                    String tempMetric1;
            		String trueMetric1;
                    String tempMetric2;
            		String trueMetric2;
                    String tempView;
                    String[] arrayConAggregateMetricsCount = new String[] {};
                    String[] arrayConAggregateMetricsSum = new String[] {};    
                    String[] arrayConAggregateViews = new String[] {};
                    for (JSON2Apex_DailySummaryVoice.Results conr : JSON2Apex_DailySummaryVoice.parse(parser).results) {                        
                    system.debug('Taufik - conr : '+conr);
                        JSON2Apex_DailySummaryVoice.Group_Z conQueueID = conr.group_Z;
	                    system.debug('Taufik - conQueueID : '+conQueueID);

                        // Each d represent a user
                        for (JSON2Apex_DailySummaryVoice.Data cond : conr.data) {
	                    system.debug('Taufik - conr.data : '+conr.data);
	                    system.debug('Taufik - cond : '+cond);
                            if (cond.Metrics == null){
                            //do nothing   
                            }
                            else {
                            // Each d represent an interval
                                for (JSON2Apex_DailySummaryVoice.Metrics conm : cond.metrics) {
                                    //Each m represent a metric
                                    tempMetric1 = conm.metric;
                            		trueMetric1 = conm.metric.substring(1,conm.metric.length());
                                    
                                    if (trueMetric1 == 'Offered') trueMetric1 = 'Call_Offered__c';
                                    if (trueMetric1 == 'Outbound') trueMetric1 = 'Outbound_Call__c';
                                    if (trueMetric1 == 'Answered') trueMetric1 = 'Acd_Count__c';
                                    if (trueMetric1 == 'Abandon') trueMetric1 = 'Abandon_Count__c';
                                    if (trueMetric1 == 'Acw') trueMetric1 = 'temp_aux__c';
                                    if (trueMetric1 == 'Handle') trueMetric1 = 'temp_aux__c';
                                    if (trueMetric1 == 'Held') trueMetric1 = 'temp_aux__c';
                                    if (trueMetric1 == 'FlowOut') trueMetric1 = 'FlowOut_Count__c';
                                    
                                    
                                    arrayConAggregateMetricsCount.add(conQueueID.queueId + '_' +year+'-'+month+'-'+day + '_Callback' + ';' + trueMetric1 + ';' + conm.stats.count + ';' + conQueueID.queueId);
                                    
                                    tempMetric2 = conm.metric;
                            		trueMetric2 = conm.metric.substring(1,conm.metric.length());
                                    if (trueMetric2 == 'Offered') trueMetric2 = 'temp_aux__c';
                                    if (trueMetric2 == 'Outbound') trueMetric2 = 'temp_aux__c';
                                    if (trueMetric2 == 'Transferred') trueMetric2 = 'temp_aux__c';
                                    if (trueMetric2 == 'Answered') trueMetric2 = 'Acd_Sum__c';
                                    if (trueMetric2 == 'Acw') trueMetric2 = 'Acw_Sum__c';
                                    if (trueMetric2 == 'Handle') trueMetric2 = 'Handle_Sum__c';
                                    if (trueMetric2 == 'Held') trueMetric2 = 'Hold_Sum__c';
                                    if (trueMetric2 == 'Abandon') trueMetric2 = 'temp_aux__c';
                                    if (trueMetric2 == 'FlowOut') trueMetric2 = 'temp_aux__c';
                                    if (conm.stats.sum == null) conm.stats.sum = '0';
                                    
                                    arrayConAggregateMetricsSum.add(conQueueID.queueId + '_' +year+'-'+month+'-'+day + '_Callback' + ';' + trueMetric2 + ';' + conm.stats.sum + ';' + conQueueID.queueId);
                                }
                                if (cond.views != NULL ) // taufik, 6 Nov 2018, jika null, di skip.
                            	for (JSON2Apex_DailySummaryVoice.Views conv : cond.views){
                                    tempView = conv.name;
                                    
                                    if (tempView == 'Answerlt20s') tempView = 'ACD_Count_20_Sec__c';
                                    if (tempView == 'abandonLT5s') tempView = 'Abandon_Count_5_Sec__c';
                                    if (tempView == 'Abandongtequal5s') tempView = 'Abandon_Count_5_sec_up__c';
                                    
                                    arrayConAggregateViews.add(conQueueID.queueId + '_' +year+'-'+month+'-'+day + '_Callback' + ';' + tempView + ';' + conv.stats.count + ';' + conQueueID.queueId);
                                } 
                            }
                        }
                    }
                    //DEBUG
                    string ss1 = '';
                    for (Object rr1 : arrayConAggregateMetricsCount) ss1 += '\n' + rr1;
                    system.debug('arrayConAggregateMetricsCount ==>'+ss1);
                    
                    string ss2 = '';
                    for (Object rr2 : arrayConAggregateMetricsSum) ss2 += '\n' + rr2;
                    system.debug('arrayConAggregateMetricsSum ==>'+ss2);
                    
                    string ss3 = '';
                    for (Object rr3 : arrayConAggregateViews) ss3 += '\n' + rr3;
                    system.debug('arrayConAggregateViews ==>'+ss3);
                    
                    
                    //---------------------------------COUNT-----------------------------------------------------
                    Map<string, PureCloud_Call_Summary__c> conAggregateByExternalIdCount = new Map<string, PureCloud_Call_Summary__c>();
                    for(string record: arrayConAggregateMetricsCount)
                    {
                        PureCloud_Call_Summary__c customObject;
                        List<string> data = record.split(';');
                            if (conAggregateByExternalIdCount.containsKey(data[0])){
                                customObject = conAggregateByExternalIdCount.get(data[0]);   
                                customObject.put(data[1], decimal.valueof(data[2]));
                            }
                            else{
                                customObject = new PureCloud_Call_Summary__c();
                                customObject.External_Id__c = data[0];
                                
                                for (Purecloud_Master_Queue__c qq : listQueueCallback){
                                    if (qq.Queue_ID__c == data[3]) customObject.Queue__c = qq.Name;
                                    else {
                                        //Do nothing
                                    }
                                }
								
                                customObject.put(data[1], decimal.valueof(data[2]));
                                conAggregateByExternalIdCount.put(data[0], customObject);
                            }
                        conCount.add(customObject);
                    }
                    //DEBUG                    
                    string sss1 = '';
                    for (Object rrr1 : conCount) sss1 += '\n' + rrr1;
                    system.debug('conCount ==>'+sss1);
                    system.debug('conAggregateByExternalIdCount ==>'+conAggregateByExternalIdCount);
                    
                    //Remove Duplicates
                    Set<PureCloud_Call_Summary__c> mysetConCount = new Set<PureCloud_Call_Summary__c>();
                    mysetConCount.addAll(conCount);
                    upsertconCountWithoutDuplicate.addAll(mysetConCount);
                    
                    string sss2 = '';
                    for (Object rrr2 : upsertconCountWithoutDuplicate) sss2 += '\n' + rrr2;
                    system.debug('upsertconCountWithoutDuplicate ==>'+sss2);
                    
                    
                    //-----------------------------------------SUM--------------------------------------------------
                    Map<string, PureCloud_Call_Summary__c> conAggregateByExternalIdSum = new Map<string, PureCloud_Call_Summary__c>();
                    for(string record2: arrayConAggregateMetricsSum)
                    {
                        PureCloud_Call_Summary__c customObject2;
                        List<string> data2 = record2.split(';');
                            if (conAggregateByExternalIdSum.containsKey(data2[0])){
                                customObject2 = conAggregateByExternalIdSum.get(data2[0]);   
                                customObject2.put(data2[1], decimal.valueof(data2[2])/1000);
                            }
                            else{
                                customObject2 = new PureCloud_Call_Summary__c();
                                customObject2.External_Id__c = data2[0];
                                
                                for (Purecloud_Master_Queue__c qq2 : listQueueCallback){
                                	if (qq2.Queue_ID__c == data2[3]) customObject2.Queue__c = qq2.Name;
                                    else {
                                        //Do nothing
                                    }
                                }
								
                                customObject2.put(data2[1], decimal.valueof(data2[2])/1000);
                                conAggregateByExternalIdSum.put(data2[0], customObject2);
                            }
                        conSum.add(customObject2);
                    }
                    //DEBUG                    
                    string sum1 = '';
                    for (Object rum1 : conCount) sum1 += '\n' + rum1;
                    system.debug('conSum ==>'+sum1);
                    
                    //Remove Duplicates
                    Set<PureCloud_Call_Summary__c> mysetConSum = new Set<PureCloud_Call_Summary__c>();
                    mysetConSum.addAll(conSum);
                    upsertconSumWithoutDuplicate.addAll(mysetConSum);
                    
                    string sum2 = '';
                    for (Object rum2 : upsertconSumWithoutDuplicate) sum2 += '\n' + rum2;
                    system.debug('upsertconSumWithoutDuplicate ==>'+sum2);
                    
                    //--------------------------------------VIEWS COUNT---------------------------------------------
                    Map<string, PureCloud_Call_Summary__c> conAggregateByExternalIdView = new Map<string, PureCloud_Call_Summary__c>();
                    for(string record3: arrayConAggregateViews)
                    {
                        system.debug('Taufik - arrayConAggregateViews : '+arrayConAggregateViews);
                        PureCloud_Call_Summary__c customObject3;
                        List<string> data3 = record3.split(';');
                            if (conAggregateByExternalIdView.containsKey(data3[0])){
                                customObject3 = conAggregateByExternalIdView.get(data3[0]);   
                                customObject3.put(data3[1], decimal.valueof(data3[2]));
                            }
                            else{
                                customObject3 = new PureCloud_Call_Summary__c();
                                customObject3.External_Id__c = data3[0];
                                
                                for (Purecloud_Master_Queue__c qq3 : listQueueCallback){
                                	if (qq3.Queue_ID__c == data3[3]) customObject3.Queue__c = qq3.Name;
                                    else {
                                        //Do nothing
                                    }
                                }
								
                                customObject3.put(data3[1], decimal.valueof(data3[2]));
                                conAggregateByExternalIdView.put(data3[0], customObject3);
                            }
                        conView.add(customObject3);
                    }
                    //DEBUG                    
                    string view1 = '';
                    for (Object rview1 : conView) view1 += '\n' + rview1;
                    system.debug('conView ==>'+view1);
                    
                    //Remove Duplicates
                    Set<PureCloud_Call_Summary__c> mysetConView = new Set<PureCloud_Call_Summary__c>();
                    mysetConView.addAll(conView);
                    upsertconViewWithoutDuplicate.addAll(mysetConView);
                    
                    string view2 = '';
                    for (Object rview2 : upsertconViewWithoutDuplicate) view2 += '\n' + rview2;
                    system.debug('upsertconViewWithoutDuplicate ==>'+view2);
                    
                    } // Taufik, 6 Nov 2018, jika Body == {}, tidak perlu dijalankan.
                }
        		catch (System.CalloutException e){
                    system.debug('Exception ==>'+e);
                }
        
        if (pcs.size() > 0) upsert pcs External_ID__c;
        if (upsertconCountWithoutDuplicate.size() > 0) upsert upsertconCountWithoutDuplicate External_ID__c;
        if (upsertconSumWithoutDuplicate.size() > 0) upsert upsertconSumWithoutDuplicate External_ID__c;
        if (upsertconViewWithoutDuplicate.size() > 0) upsert upsertconViewWithoutDuplicate External_ID__c;
        if (CallbackWithoutDuplicates.size()> 0) upsert CallbackWithoutDuplicates External_ID__c;
    }
}