Global class Purecloud_InsertCallService_Callback {
    @future (callout=true)
    Public static void getTest (String startInterval, String endInterval){
       
        String url = Label.API_Purecloud+'api/v2/analytics/conversations/aggregates/query';
        String clientid = Label.Purecloud_ClientId;
        String clientSecret = Label.Purecloud_ClientSecret;
        String token = [SELECT Access_token__c FROM Purecloud_Connector__c WHERE Name ='Purecloud Token' LIMIT 1].Access_token__c;
        String ownerAdmin = [SELECT Id FROM User Where Username = 'taufik.susanto@mii.co.id.ccc' AND Profile.Name = 'System Administrator'].id;
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
        system.debug('TOKEN ==>'+token);
    	
        Integer year = Integer.Valueof(Date.valueof(endInterval).year());
        Integer month = Integer.Valueof(Date.valueof(endInterval).month());
        Integer day = Integer.Valueof(Date.valueof(endInterval).day());
        
        List<PureCloud_Call_Service__c> Callbackcalltoinsert = new list<PureCloud_Call_Service__c>(); //Callback Count
        List<PureCloud_Call_Service__c> CallbackcalltoinsertSum = new list<PureCloud_Call_Service__c>(); //Callback Sum
        List<PureCloud_Call_Service__c> CallbackcalltoinsertView = new list<PureCloud_Call_Service__c>(); //Callback View
        List<Purecloud_Call_Service__c> CallbacktoInsert = new List<Purecloud_Call_Service__c>(); //Callback Offered
        List<PureCloud_Call_Service__c> upsertcallservicewithoutduplicate = new list<PureCloud_Call_Service__c>(); //Remove Duplicate Count
        List<PureCloud_Call_Service__c> upsertcallservicewithoutduplicateSum = new list<PureCloud_Call_Service__c>(); //Remove Duplicate Sum
        List<PureCloud_Call_Service__c> upsertcallservicewithoutduplicateView = new list<PureCloud_Call_Service__c>(); //Remove Duplicate View
        List<PureCloud_Call_Service__c> CallbackWithoutDuplicates = new list<PureCloud_Call_Service__c>(); //Callback
        List<Purecloud_Master_Queue__c> listQueueCallback = [Select ID, Name, Queue_Id__c, Entity__c, Skill__c, Languange__c, Type__c FROM Purecloud_Master_Queue__c Where Queue_Id__c != null and Type__c = 'Callback']; //List queueu di SF
        
        
        //METRICS
        String queueid = '0';
        String nOffered = '0';
        String tAnsweredSum = '0';
        String tAbandonSum = '0';
        String tTalkSum = '0';
        String tAcwSum = '0';
        String tHeldSum = '0';
        String tHandleSum = '0'; 
        String tHandleCount = '0';
        String tAcwCount = '0'; 
        String nTransferredCount = '0';
        String tTalkCount = '0';
        String tAbandonCount = '0';
        String tHeldCount = '0';
        //VAR
        Date tglTrue;
        String tgl = '0';
        //VIEW ANSWER
        String answerLT30s = '0';
        String answerLT20s = '0';
        String answerLT10s = '0';
        String answerLT5s = '0';
        String answerGT20s = '0';
        //VIEW ABANDON
        String abandonLTEqual5s = '0';
        String abandonGT5s = '0';
        String abandonLTEqual20s = '0';
        
        List<PureCloud_Call_Service__c> listCallService = new List<PureCloud_Call_Service__c>();
        List<Schema.PicklistEntry> listcs = PureCloud_Call_Service__c.interval__c.getDescribe().getPicklistValues();
        for (Purecloud_Master_Queue__c que : listQueueCallback){
            for(Schema.PicklistEntry val:listcs){
                PureCloud_Call_Service__c cs = new PureCloud_Call_Service__c();
                cs.OwnerId = ownerAdmin;
                cs.Interval__c = val.getValue();
                cs.Date__c = Date.valueof(endInterval);
                cs.queueId__c = que.Queue_Id__c;
                cs.Queue_Name__c = que.Name;
                cs.Entity__c = que.Entity__c;
                cs.External_ID__c = que.Queue_ID__c + '_' + val.getValue() + '_' + year + '-' + month + '-' + day + '_Callback';
                cs.Call_Offered__c = 0;
                cs.ACD_Count__c = 0;
                cs.ACD_Count_5_Secs__c = 0;
                cs.ACD_Count_10_Secs__c = 0;
                cs.ACD_Count_20_Sec__c = 0;
                cs.ACD_Count_30_Sec__c = 0;
                cs.ACD_Count_20_Secs__c = 0;
                cs.Abandon_Sum__c = 0;
                cs.Abandon_Count__c = 0;
                cs.Abandon_Count_5_Sec__c = 0;
                cs.Abandon_Count_5_Sec_High__c = 0;
                cs.Abandon_Count_20_Sec__c = 0;
                cs.Callback_Count__c = 0;
                cs.Hold_Count__c = 0;
                cs.Extn_Out_Calls__c = 0;
                cs.Transferred_Out__c = 0;
                cs.Calls_Answered_Sum__c = 0;
                cs.Talk_Sum__c = 0;
                cs.Talk_Count__c = 0;
                cs.ACW_Sum__c = 0;
                cs.ACW_Count__c = 0;
                cs.ACD_Sum__c = 0;    
                cs.Hold_Sum__c = 0;
                cs.Handle_Sum__c = 0;
                cs.Handle_Count__c = 0;   
                listCallService.add(cs);
            }
        }
            
        //-----------------------------------------------MEDIA TYPE CALLBACK---------------------------------------------------------
        String JSONstringConAggregate = '{  "interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "granularity": "PT30M",  "groupBy": [   "queueId",   "mediaType"  ],  "filter": {   "type": "and",   "clauses": [    {     "type": "or",     "predicates": [';
        String bodypart1ConAggregate = '{"type":"dimension","dimension":"queueId","operator":"matches","value":"';
        String bodypart2ConAggregate = '"}';
        String endStringConAggregate = ']    }   ],   "predicates": [    {     "type": "dimension",     "dimension": "mediaType",     "operator": "matches",     "value": "callback"    }   ]  }, "views": [   {    "name": "Answerlt5s",    "target": "tAnswered",    "function": "rangeBound",    "range": {     "gte": "0",     "lt": "4999"    }   },   {    "name": "Answerlt10s",    "target": "tAnswered",    "function": "rangeBound",    "range": {     "gte": "0",     "lt": "9999"    }   },   {    "name": "Answerlt20s",    "target": "tAnswered",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "19999"    }   },   {    "name": "Answerlt30",    "target": "tAnswered",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "29999"    }   },   {    "name": "Answergt20s",    "target": "tAnswered",    "function": "rangeBound",    "range": {     "gte": "20000",     "lt": "99999999"    }   },   {    "name": "Abandonltequal5s",    "target": "tAbandon",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "5000"    }   },   {    "name": "Abandonltequal20s",    "target": "tAbandon",    "function": "rangeBound",    "range": {     "gte": 0,     "lt": "20000"    }   },   {    "name": "Abandongt5s",    "target": "tAbandon",    "function": "rangeBound",    "range": {     "gte": "5000",     "lt": "999999"    }   }  ],  "metrics": [   "nOffered",  "nOutbound", "nTransferred",   "tAbandon",   "tAcw",   "tAnswered",   "tHandle",   "tHeld",   "tTalk" ,"tFlowOut" ] }';
        String comma = ',';
        Integer sizeQueue = listQueueCallback.size();
        
        for (integer i = 0; i < sizeQueue; i++){
            JSONstringConAggregate += bodypart1ConAggregate + listQueueCallback[i].Queue_ID__c + bodypart2ConAggregate;
            if(i + 1 < sizeQueue){
                JSONstringConAggregate += comma;
            }
        }
        JSONstringConAggregate += endStringConAggregate;
        System.debug('JSONstringConAggregate = ' + JSONstringConAggregate);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setTimeout(120000);
        req.setHeader('content-type', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ token);
        req.setBody(JSONstringConAggregate);
        blob exResAgg = [SELECT Body FROM StaticResource WHERE Name='ResBody_ConAggregate_QueueIdPT30M'].Body;   
		String conAggregateResponseDummy = exResAgg.toString();
            
        try{
            HttpResponse res = new HttpResponse();
            res = h.send(req);
                String parser;
				if(test.isRunningTest()) parser = conAggregateResponseDummy;
				else parser = res.getBody(); //JSON.createParser(res.getBody());
            
                system.debug('*body ==>*'+parser);
				if (parser != '{}') {
            
            	String tempMetric;
            	String trueMetric;
            	String timeInterval;
            	String picklistStartInterval;
            	String picklistEndInterval;
            	String picklistInterval;
            	String[] arrayConAggregateServiceCallback = new String[] {};
                for (JSON2Apex_ConAggQueueId_30M.Results conr : JSON2Apex_ConAggQueueId_30M.parse(parser).results) {
                    JSON2Apex_ConAggQueueId_30M.Group_Z conQueueID = conr.group_Z;
                    
                    if (conQueueId.queueId != null){
                    	for (JSON2Apex_ConAggQueueId_30M.Data cond : conr.data) {
                            if (cond.Metrics == null){
                            //do nothing   
                            }
                            else {
                            // Each d represent an interval
                                for (JSON2Apex_ConAggQueueId_30M.Metrics conm : cond.Metrics) {
                                    //Each m represent a metric
                                    tempMetric = conm.metric;
                                    trueMetric = conm.metric.substring(1,conm.metric.length());
                                    
                                    timeInterval = cond.interval;
                                    String jamStart = String.Valueof(timeInterval.substring(11,13));
                                    String menitStart = String.Valueof(timeInterval.substring(14,16));
                                    picklistStartInterval = jamStart + ':' + menitStart;
                                    
                                    String jamEnd = String.Valueof(timeInterval.substring(41,43));
                                    String menitEnd = String.Valueof(timeInterval.substring(44,46));
                                    picklistEndInterval = jamEnd + ':' + menitEnd;
                                    picklistInterval = picklistStartInterval + '-' + picklistEndInterval;
                                    
                                    
                                    if (trueMetric == 'Offered') trueMetric = 'Call_Offered__c';
                                    if (trueMetric == 'Outbound') trueMetric = 'Outbound_Call__c';
                                    if (trueMetric == 'Transferred') trueMetric = 'Transferred_Out__c';
                                    if (trueMetric == 'Acw') trueMetric = 'Acw_Count__c';
                                    if (trueMetric == 'Answered') trueMetric = 'Acd_Count__c';
                                    if (trueMetric == 'Handle') trueMetric = 'Handle_Count__c';
                                    if (trueMetric == 'Talk') trueMetric = 'Talk_Count__c';
                                    if (trueMetric == 'Abandon') trueMetric = 'Abandon_Count__c';
                                    if (trueMetric == 'Held') trueMetric = 'Hold_Count__c';
        
                                    arrayConAggregateServiceCallback.add(conQueueID.queueId + '_' + picklistInterval + '_' +year+'-'+month+'-'+day+ '_Callback' + ';' + trueMetric + ';' + conm.stats.count + ';' + conm.stats.sum + ';' + picklistInterval + ';' + conQueueID.queueid);
                                }
                            }
                        }    
                    }
                }
            
            Map<string, PureCloud_Call_Service__c> conAggregateByExternalIdCount = new Map<string, PureCloud_Call_Service__c>();
            for(string record: arrayConAggregateServiceCallback)
            {
                PureCloud_Call_Service__c customObject;
                List<string> data = record.split(';');
                    if (conAggregateByExternalIdCount.containsKey(data[0])){
                    	customObject = conAggregateByExternalIdCount.get(data[0]);   
                        customObject.put(data[1], decimal.valueof(data[2]));
                    }
                    else{
                    	customObject = new PureCloud_Call_Service__c();
                        customObject.External_Id__c = data[0];
                        customObject.Interval__c = data[4];
                        customObject.queueId__c = data[5];
                        customObject.put(data[1], decimal.valueof(data[2]));
                        conAggregateByExternalIdCount.put(data[0], customObject);
                    }
                Callbackcalltoinsert.add(customObject);
            }	
            		//debug
                	string ss1 = '';
                    for (Object rr1 : Callbackcalltoinsert) ss1 += '\n' + rr1;
                    system.debug('Callbackcalltoinsert ==>'+ss1);
            
                	string ss2 = '';
                    for (Object rr2 : arrayConAggregateServiceCallback) ss2 += '\n' + rr2;
                    system.debug('arrayConAggregateServiceCallback ==>'+ss2);
            
            //Remove duplicate
            
            Set<PureCloud_Call_Service__c> mysetCon = new Set<PureCloud_Call_Service__c>();
            mysetCon.addAll(Callbackcalltoinsert);
            upsertcallservicewithoutduplicate.addAll(mysetCon);
            
            //debug
            string ss3 = '';
            for (Object rr3 : upsertcallservicewithoutduplicate) ss3 += '\n' + rr3;
            system.debug('upsertcallservicewithoutduplicate ==>'+ss3); 
 			
            
            //--------------------------CONVERSATION AGGREGATE SUM -------------------------------------------------
            
            	String[] arrayConAggregateServiceCallbackSum = new String[] {};
                for (JSON2Apex_ConAggQueueId_30M.Results conr : JSON2Apex_ConAggQueueId_30M.parse(parser).results) {
                    JSON2Apex_ConAggQueueId_30M.Group_Z conQueueID = conr.group_Z;
                    // Each d represent a queueid
                    if (conQueueId.queueId != null){
                    	for (JSON2Apex_ConAggQueueId_30M.Data cond : conr.data) {
                            if (cond.Metrics == null){
                            //do nothing   
                            }
                            else {
                            // Each d represent an interval
                                for (JSON2Apex_ConAggQueueId_30M.Metrics conm : cond.Metrics) {
                                    //Each m represent a metric
                                    tempMetric = conm.metric;
                                    trueMetric = conm.metric.substring(1,conm.metric.length());
                                    
                                    timeInterval = cond.interval;
                                    String jamStart = String.Valueof(timeInterval.substring(11,13));
                                    String menitStart = String.Valueof(timeInterval.substring(14,16));
                                    picklistStartInterval = jamStart + ':' + menitStart;
                                    
                                    String jamEnd = String.Valueof(timeInterval.substring(41,43));
                                    String menitEnd = String.Valueof(timeInterval.substring(44,46));
                                    picklistEndInterval = jamEnd + ':' + menitEnd;
                                    picklistInterval = picklistStartInterval + '-' + picklistEndInterval;
                                    
                                    
                                    if (trueMetric == 'Offered') trueMetric = 'temp_aux__c';
                                    if (trueMetric == 'Outbound') trueMetric = 'temp_aux__c';
                                    if (trueMetric == 'Transferred') trueMetric = 'temp_aux__c';
                                    if (trueMetric == 'Acd') trueMetric = 'Acd_Sum__c';
                                    if (trueMetric == 'Acw') trueMetric = 'Acw_Sum__c';
                                    if (trueMetric == 'Answered') trueMetric = 'Calls_Answered_Sum__c';
                                    if (trueMetric == 'Handle') trueMetric = 'Handle_Sum__c';
                                    if (trueMetric == 'Talk') trueMetric = 'Talk_Sum__c';
                                    if (trueMetric == 'Abandon') trueMetric = 'Abandon_Sum__c';
                                    if (trueMetric == 'Held') trueMetric = 'Hold_Sum__c';
                                    if (conm.stats.sum == null) conm.stats.sum = '0';
        
                                    arrayConAggregateServiceCallbackSum.add(conQueueID.queueId + '_' + picklistInterval + '_' +year+'-'+month+'-'+day+ '_Callback' + ';' + trueMetric + ';' + conm.stats.count + ';' + conm.stats.sum + ';' + picklistInterval);
                                }
                            }
                        }    
                    }
                    
                }
            
            Map<string, PureCloud_Call_Service__c> conAggregateByExternalIdSum = new Map<string, PureCloud_Call_Service__c>();
            for(string record2: arrayConAggregateServiceCallbackSum)
            {
                PureCloud_Call_Service__c customObject2;
                List<string> data2 = record2.split(';');
                    if (conAggregateByExternalIdSum.containsKey(data2[0])){
                    	customObject2 = conAggregateByExternalIdSum.get(data2[0]);   
                        customObject2.put(data2[1], decimal.valueof(Integer.valueof(data2[3])/1000));
                    }
                    else{
                    	customObject2 = new PureCloud_Call_Service__c();
                        customObject2.External_Id__c = data2[0];
                        customObject2.Interval__c = data2[4];
                        customObject2.put(data2[1], decimal.valueof(Integer.valueof(data2[3])/1000));
                        conAggregateByExternalIdSum.put(data2[0], customObject2);
                    }
                CallbackcalltoinsertSum.add(customObject2);
            }	
            		//debug
                	string sss1 = '';
                    for (Object rrr1 : CallbackcalltoinsertSum) sss1 += '\n' + rrr1;
                    system.debug('CallbackcalltoinsertSum ==>'+sss1);
            
                	string sss2 = '';
                    for (Object rrr2 : arrayConAggregateServiceCallbackSum) sss2 += '\n' + rrr2;
                    system.debug('arrayConAggregateServiceCallbackSum ==>'+sss2);
            
            //Remove duplicate
            
            Set<PureCloud_Call_Service__c> mysetCon2 = new Set<PureCloud_Call_Service__c>();
            mysetCon2.addAll(CallbackcalltoinsertSum);
            upsertcallservicewithoutduplicateSum.addAll(mysetCon2);
            
            //debug
            string sss3 = '';
            for (Object rrr3 : upsertcallservicewithoutduplicateSum) sss3 += '\n' + rrr3;
            system.debug('upsertcallservicewithoutduplicateSum ==>'+sss3); 

            
            //--------------------------CONVERSATION AGGREGATE VIEW -------------------------------------------------
            	String tempView;
            	String[] arrayConAggregateServiceCallbackView = new String[] {};
                for (JSON2Apex_ConAggQueueId_30M.Results conrView : JSON2Apex_ConAggQueueId_30M.parse(parser).results) {
                    JSON2Apex_ConAggQueueId_30M.Group_Z conQueueID = conrView.group_Z;
                    // Each d represent a queueid
                    if (conQueueId.queueid != null){
                    	for (JSON2Apex_ConAggQueueId_30M.Data condView : conrView.data) {
                            if (condView.views == null){
                            //do nothing   
                            }
                            else {
                            // Each d represent an view
                                for (JSON2Apex_ConAggQueueId_30M.Views conv : condView.views) {
                                    //Each m represent a view
                                    tempView = conv.name;
                                    //system.debug('tempView ==>'+ conv.name);
                                    timeInterval = condView.interval;
                                    //system.debug('timeInterval ==>'+ timeInterval);
                                    String jamStart = String.Valueof(timeInterval.substring(11,13));
                                    String menitStart = String.Valueof(timeInterval.substring(14,16));
                                    picklistStartInterval = jamStart + ':' + menitStart;
                                    
                                    String jamEnd = String.Valueof(timeInterval.substring(41,43));
                                    String menitEnd = String.Valueof(timeInterval.substring(44,46));
                                    picklistEndInterval = jamEnd + ':' + menitEnd;
                                    picklistInterval = picklistStartInterval + '-' + picklistEndInterval;
                                    
                                    if (tempView == 'Answerlt5s') tempView = 'ACD_Count_5_Secs__c';
                                    if (tempView == 'Answerlt10s') tempView = 'ACD_Count_10_Secs__c';
                                    if (tempView == 'Answerlt20s') tempView = 'ACD_Count_20_Sec__c';
                                    if (tempView == 'Answerlt30') tempView = 'ACD_Count_30_Sec__c';
                                    if (tempView == 'Answergt20s') tempView = 'ACD_Count_20_Secs__c';
                                    if (tempView == 'Abandonltequal5s') tempView = 'Abandon_Count_5_sec__c';
                                    if (tempView == 'Abandonltequal20s') tempView = 'Abandon_Count_20_Sec__c';
                                    if (tempView == 'Abandongt5s') tempView = 'Abandon_Count_5_sec_high__c';
                                    arrayConAggregateServiceCallbackView.add(conQueueID.queueId + '_' + picklistInterval + '_' +year+'-'+month+'-'+day+ '_Callback' + ';' + tempView + ';' + conv.stats.count + ';' + picklistInterval + ';' + conQueueID.queueid);
                                }                                                        
                            }
                        }    
                    } 
                }
            
            
            Map<string, PureCloud_Call_Service__c> conAggregateByExternalIdView = new Map<string, PureCloud_Call_Service__c>();
            for(string record3: arrayConAggregateServiceCallbackView)
            {
                PureCloud_Call_Service__c customObject3;
                List<string> data3 = record3.split(';');
                    if (conAggregateByExternalIdView.containsKey(data3[0])){
                    	customObject3 = conAggregateByExternalIdView.get(data3[0]);   
                        customObject3.put(data3[1], decimal.valueof(data3[2]));
                    }
                    else{
                    	customObject3 = new PureCloud_Call_Service__c();
                        customObject3.External_Id__c = data3[0];
                        customObject3.Interval__c = data3[3];
                        //customObject3.queueId__c = data3[4];
                        //system.debug('Taufik - Data3 : '+data3);

                        customObject3.put(data3[1], decimal.valueof(data3[2]));
                        conAggregateByExternalIdView.put(data3[0], customObject3);
                    }
                CallbackcalltoinsertView.add(customObject3);
            }	
            
            //Remove duplicate
            Set<PureCloud_Call_Service__c> mysetCon3 = new Set<PureCloud_Call_Service__c>();
            mysetCon3.addAll(CallbackcalltoinsertView);
            upsertcallservicewithoutduplicateView.addAll(mysetCon3);

            } 	
        	} // Taufik, 6 Nov 2018, jika Body == {}, tidak perlu dijalankan.
        	catch(exception e){
                system.debug('*error*'+e);
            } 

        if (listCallService.size() > 0) upsert listCallService External_ID__c; //Record semua queue callback yang ada
		if (upsertcallservicewithoutduplicate.size() > 0) upsert upsertcallservicewithoutduplicate External_ID__c; //upsert count
        if (upsertcallservicewithoutduplicateSum.size() > 0) upsert upsertcallservicewithoutduplicateSum External_ID__c; //upsert sum
        if (upsertcallservicewithoutduplicateView.size() > 0) upsert upsertcallservicewithoutduplicateView External_ID__c; //upsert view
        //if (CallbackWithoutDuplicates.size() > 0) upsert CallbackWithoutDuplicates External_ID__c; //upsert callback offered  
    }
}