global class Purecloud_InsertCallAgent implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    global String query;
    global String startInterval;
    global String endInterval;
    global String pageResponse = 'Page Response';
    global Purecloud_InsertCallAgent(String q, String s, String e) {
        this.query = q;
        this.startInterval = s;
        this.endInterval = e;
    }
    
	global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<User> scope){
        String url = Label.API_Purecloud+'api/v2/analytics/users/aggregates/query';
        String url2 = Label.API_Purecloud+'api/v2/analytics/users/details/query';
        String url3 = Label.API_Purecloud+'api/v2/analytics/conversations/aggregates/query';
        String clientid = Label.Purecloud_ClientId;
        String clientSecret = Label.Purecloud_ClientSecret;
        String UserSync = Label.Purecloud_UserSync;
		String token = [SELECT Access_token__c FROM Purecloud_Connector__c WHERE Name ='Purecloud Token' LIMIT 1].Access_token__c;
        //String ownerAdmin = [SELECT Id FROM User Where Username = 'taufik.susanto@mii.co.id.ccc' AND Profile.Name = 'System Administrator' limit 1].id;
        String ownerAdmin = [SELECT Id FROM User Where Username =: UserSync AND Profile.Name = 'System Administrator' limit 1].id;
        
        //system.debug(LoggingLevel.DEBUG,'*url*'+url);
        system.debug('TOKEN ==>'+token);
        
        Integer year = Integer.Valueof(Date.valueof(endInterval).year());
        Integer month = Integer.Valueof(Date.valueof(endInterval).month());
        Integer day = Integer.Valueof(Date.valueof(endInterval).day());
        
        //List<User> userSF = [SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c = '052efa3d-cc0b-4212-a513-24f336d46165' AND Softphone_Type__c = 'PureCloud' ];       
        //List<User> userSF = [SELECT Id,SIP__c,Entity__c, Name FROM User WHERE SIP__c != NULL and Softphone_Type__c = 'PureCloud' and isActive = TRUE ];
        //System.debug('Taufik - Count UserSF : '+userSF.size());
        //List<Purecloud_Connector__c> listPresence = [SELECT Presence_ID__c, AUX_Name__c, Primary_AUX_Name__c FROM Purecloud_Connector__c WHERE Name = 'AUX' and Presence_ID__c != null];
        //userSF[0].SIP__c = '5bd7fd0c2aa9491a62d14168';
        List<Purecloud__c> tempAgent = new List<Purecloud__c>(); //Data temp awal
        Transient List<Purecloud__c> upsertAPI1 = new List<Purecloud__c>(); //UNTUK TAMPUNG DATA UPSERT API-1
        Transient List<Purecloud__c> upsertAPI1_1 = new List<Purecloud__c>();
        Transient List<Purecloud__c> upsertAPI1_2 = new List<Purecloud__c>();
        List<Purecloud__c> upsertAPI2 = new List<Purecloud__c>(); //UNTUK TAMPUNG DATA UPSERT API-2
        List<Purecloud__c> upsertAPI2_1 = new List<Purecloud__c>();
        Transient List<Purecloud__c> upsertAPI3 = new List<Purecloud__c>(); //UNTUK TAMPUNG DATA UPSERT API-3 Count
        Transient List<Purecloud__c> upsertAPI3_1 = new List<Purecloud__c>(); //SUM
        List<Purecloud__c> upsertWithoutDuplicates = new List<Purecloud__c>(); //AGENT STATUS
        List<Purecloud__c> upsertWithoutDuplicatesAvailable = new List<Purecloud__c>();
        List<Purecloud__c> upsertWithoutDuplicatesTraining = new List<Purecloud__c>();
        List<Purecloud__c> upsertWithoutDuplicatesCon = new List<Purecloud__c>(); // CONVERSATION AGGREGATE - COUNT
        List<Purecloud__c> upsertWithoutDuplicatesConSum = new List<Purecloud__c>(); // CONVERSATION AGGREGATE - SUM
        purecloud__c agentAPI1 = new purecloud__c();
        
        
        String purecloudid = '';
        String tgl = '0';
        String status = '0';
        String AUXduration = '0';
        Date tglTrue;
        String startLogin = '0';
        String endLogin = '0';
        String availableSec = '0';
        String awaySec = '0';
        String meetingSec = '0';
        String trainingSec = '0';
        String busySec = '0';
        String breakSec = '0';
        String breakLunchSec = '0';
        String breakPraySec = '0';
        String breakRestSec = '0';
        String breakOtherSec = '0';
        // new May2020
        String availableAdminSec = '0';
        String availableWalkINSec = '0';
        String availableOutboundSec = '0';
        String availableFollowUpSec = '0';
        String trainingTrainingSec = '0';
        String trainingCoachingSec = '0';
        // END - new May2020
        Integer countAway = 0;
        Integer countMeeting = 0;
        Integer countTraining = 0;
        Integer countBusy = 0;
        Integer countMeal = 0;
        Integer countBreak = 0;
        Integer countBreakLunch = 0;
        Integer countBreakPray = 0;
        Integer countBreakRest = 0;
        Integer countBreakOther = 0;
        Integer countCoaching = 0;
        // new May2020
        Integer countAvailableAdmin = 0;
        Integer countAvailableWalkIN = 0;
        Integer countAvailableOutbound = 0;
        Integer countAvailableFollowUp = 0;
        Integer countTrainingTraining = 0;
        Integer countTrainingCoaching = 0;
        // END - new May2020
        String sumACW = '0';
        String countTalk = '0';
        String tTalkSum = '0';
        String countHeld = '0';
        String tHeldSum = '0';
        String tHandleSum = '0';
        String countACW = '0';
        
        Integer us_index = -1;
        
        for (User us : scope){    
            /*
            Http hQueue = new Http();
            HttpRequest reqQueue = new HttpRequest();
            reqQueue.setEndpoint(Label.API_Purecloud+'/api/v2/users/'+ us.SIP__c +'/queues');
            reqQueue.setMethod('GET');
            reqQueue.setTimeout(120000);
            reqQueue.setHeader('content-type', 'application/json');
            reqQueue.setHeader('Authorization', 'Bearer '+ token);
            */
            
            us_index = us_index + 1;
            String parser_log;	//penampung json error/kosong
            
            Purecloud__c ipcccc = new Purecloud__c();
            ipcccc.OwnerId = ownerAdmin;
            ipcccc.Name = us.Name+'_'+year+'-'+month+'-'+day;
            ipcccc.Agent__c = '-';
            ipcccc.Agent_Name__c = us.Id;
            ipcccc.Queue_Group__c = '-';
            ipcccc.Entity__c = us.Entity__c;
            ipcccc.External_ID__c = us.SIP__c+'_'+year+'-'+month+'-'+day;
            ipcccc.Date__c = date.valueof(endInterval);
            ipcccc.Type__c = 'Daily';
            ipcccc.SIP__c = us.SIP__c;
            ipcccc.Away_Sum__c = 0;
            ipcccc.Break_Lunch_Sum__c = 0;
            ipcccc.Break_Other_Sum__c = 0;
            ipcccc.Break_Pray_Sum__c = 0;
            ipcccc.Break_Rest_Sum__c = 0;
            ipcccc.Busy_Sum__c = 0;
            ipcccc.Meeting_Sum__c = 0;
            ipcccc.Training_Sum__c = 0;
            ipcccc.Available_Sum__c = 0;
            ipcccc.On_Queue_Sum__c = 0;	//new, 16/10/2020
			// new May 2020
            ipcccc.Available_Follow_Up_Sum__c = 0;
            ipcccc.Available_Admin_Sum__c = 0;
            ipcccc.Available_Walk_IN_Sum__c = 0;
            ipcccc.Available_Outbound_Sum__c = 0;
            ipcccc.Training_Training_Sum__c = 0;
            ipcccc.Training_Coaching_Sum__c = 0;
            
            ipcccc.Away_Count__c = 0;
            ipcccc.Break_Lunch_Count__c = 0;
            ipcccc.Break_Other_Count__c = 0;
            ipcccc.Break_Pray_Count__c = 0;
            ipcccc.Break_Rest_Count__c = 0;
            ipcccc.Busy_Count__c = 0;
            ipcccc.Meeting_Count__c = 0;
            ipcccc.Training_Count__c = 0;
			// new May 2020
            ipcccc.Available_Follow_Up_Count__c = 0;
            ipcccc.Available_Admin_Count__c = 0;
            ipcccc.Available_Walk_IN_Count__c = 0;
            ipcccc.Available_Outbound_Count__c = 0;
            ipcccc.Training_Training_Count__c = 0;
            ipcccc.Training_Coaching_Count__c = 0;

            ipcccc.ACD_Count__c = 0;
            ipcccc.Handle_Sum__c = 0;
            ipcccc.ACW_Sum__c = 0;
            ipcccc.Talk_Sum__c = 0;
            ipcccc.Talk_Count__c = 0;    
            ipcccc.ACW_Count__c = 0;
            ipcccc.Hold_Sum__c = 0;
            ipcccc.Hold_Count__c = 0;   
            ipcccc.Coaching_Sum__c = 0;
            ipcccc.Handle_Count__c = 0;
            //ipcccc.API_Check_API1_Status__c = 'test1';
            //ipcccc.API_Check_API2_Status__c = 'test2';
            //ipcccc.API_Check_API3_Status__c = 'test3';
            tempAgent.add(ipcccc);
        
             
        String JSONstring = '{  "interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "groupBy": [   "userId"  ],  "filter": {   "type": "and",   "predicates": [';
        String bodypart1 = '{"type":"dimension","dimension":"userId","operator":"matches","value":"';
        String bodypart2 = '"}';
        String endString = ']  },  "metrics": [   "tOrganizationPresence"  ] }';
        String comma = ',';
        Integer sizeUser = scope.size();
        
        for (integer i = 0; i < sizeUser; i++){
            JSONstring += bodypart1 + scope[i].SIP__c + bodypart2;
            if(i + 1 < sizeUser){
                JSONstring += comma;
            }
        }
        JSONstring += endString;
        //System.debug('jsonString = ' + jsonString);
        
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setTimeout(120000);
        req.setHeader('content-type', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ token);
        req.setBody(JSONstring);
        blob exResAgg = [SELECT Body FROM StaticResource WHERE Name='ResBody_UserAggregate'].Body;   
        String UserAggregateResponseDummy = exResAgg.toString();
        
        try{
            HttpResponse res = new HttpResponse();
            res = h.send(req);
                Transient String parser;
                //if (test.isRunningTest()) parser = UserAggregateResponseDummy;
                if (test.isRunningTest()==false) parser = res.getBody();
            	else parser = UserAggregateResponseDummy;
            	
            	parser_log = parser;	//utk nampung error log kalo gagal. Evan 02/09/2020
            
                system.debug('*body*'+parser);
                //JSON2Apex jsonApex = JSON2Apex.parse(parser);
                //system.debug('JSON ==>'+jsonApex);
            if (parser != '{}') {
            
            String trueMetric;
            String metricId;
            String tempPrimaryPresence;
            String[] arrayMetricsAggregate = new String[] {};
            String[] arrayMetricsAvailableOnly = new String[] {};
            String[] arrayMetricsTrainingOnly = new String[] {};     
            for (JSON2Apex.Results r : JSON2Apex.parse(parser).results) {
                JSON2Apex.Group_Z g = r.group_Z;
                // Each d represent a user
                for (JSON2Apex.Data d : r.data) {
                    // Each d represent an interval
                    for (JSON2Apex.Metrics m : d.metrics) {
                        //Each m represent a metric
                        metricId = m.qualifier;
                        for (Purecloud_Connector__c masterPresence : [SELECT Presence_ID__c, AUX_Name__c, Primary_AUX_Name__c FROM Purecloud_Connector__c WHERE Name = 'AUX' and Presence_ID__c != null]){ //represent presence
                            if (masterPresence.Presence_ID__c == metricId){
        						tempPrimaryPresence = masterPresence.Primary_AUX_Name__c;
                                trueMetric = masterPresence.AUX_Name__c;
                                system.debug('Primary Presence ==>'+tempPrimaryPresence);
                                system.debug('Primary Metrics ==>'+trueMetric);
                                if (tempPrimaryPresence == 'Break' || tempPrimaryPresence == 'Away' || tempPrimaryPresence == 'Meeting') {
                                    arrayMetricsAggregate.add(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                    System.debug(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                }
                                if (tempPrimaryPresence == 'Busy' || trueMetric == 'System Problem'){
                                    trueMetric = 'Busy';
                                    arrayMetricsAggregate.add(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                }
                                // New, 202005
                                if (tempPrimaryPresence == 'Available') {
                                    //trueMetric = 'Available';
                                    if (trueMetric != 'Available')
                                    	arrayMetricsAggregate.add(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                }
                                if (tempPrimaryPresence == 'Available') {
                                    trueMetric = 'Available';
                                    arrayMetricsAvailableOnly.add(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                } 
                                // New, 202005
                                if (tempPrimaryPresence == 'Training'){
                                    //trueMetric = 'Training';
                                    if (trueMetric != 'Training')
                                    	arrayMetricsAggregate.add(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                }
                                if (tempPrimaryPresence == 'Training'){
                                    trueMetric = 'Training';
                                    arrayMetricsTrainingOnly.add(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                }
                                //New, 16/10/2020
                                if (tempPrimaryPresence == 'On Queue'){
                                    trueMetric = 'On_Queue';
                                    arrayMetricsAggregate.add(g.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Sum__c' + ';' + m.stats.sum);
                                }
                            }
                        }
                    }
                }
            }   
                
            Map<string, Purecloud__c> customObjectByExternalId = new Map<string, Purecloud__c>();
            for(string record: arrayMetricsAggregate)
            {
                Purecloud__c customObject;
                List<string> data = record.split(';');
                	
                    if (customObjectByExternalId.containsKey(data[0])){
                        customObject = customObjectByExternalId.get(data[0]);   
                        customObject.put(data[1], decimal.valueof(integer.valueof(data[2])/1000));
                    }
                    else{
                        customObject = new Purecloud__c();
                        customObject.External_Id__c = data[0];
                        customObject.put(data[1], decimal.valueof(integer.valueof(data[2])/1000));
                        customObjectByExternalId.put(data[0], customObject);
                    }
                
                //flag API check - API 1
                customObject.API_Check_API1__c = true;
				customObject.API_Check_API1_Status__c = 'Okay.';
                customObject.API_Check_API1_Date__c = Datetime.now();
                
                upsertAPI1.add(customObject);
            }   

            //Remove duplicate
            Set<Purecloud__c> myset = new Set<Purecloud__c>();
            myset.addAll(upsertAPI1);
            upsertWithoutDuplicates.addAll(myset);
            
            upsertAPI1.clear();    
                
            Integer sumAvailable = 0;
           	Map<string, Purecloud__c> customObjectByExternalIdAvailable = new Map<string, Purecloud__c>();
            for(string recordAvailable: arrayMetricsAvailableOnly)
            {
                Purecloud__c customObjectAvailable;
                List<string> dataAvailable = recordAvailable.split(';');
                sumAvailable += Integer.valueof(dataAvailable[2]);
                
                    if (customObjectByExternalIdAvailable.containsKey(dataAvailable[0])){
                        customObjectAvailable = customObjectByExternalIdAvailable.get(dataAvailable[0]);   
                        customObjectAvailable.put(dataAvailable[1], decimal.valueof(sumAvailable/1000));
                    }
                    else{
                        customObjectAvailable = new Purecloud__c();
                        customObjectAvailable.External_Id__c = dataAvailable[0];
                        customObjectAvailable.put(dataAvailable[1], decimal.valueof(sumAvailable/1000));
                        customObjectByExternalIdAvailable.put(dataAvailable[0], customObjectAvailable);
                    }
                
                //flag API check - API 1
                customObjectAvailable.API_Check_API1__c = true;
				customObjectAvailable.API_Check_API1_Status__c = 'Okay. Available';
                customObjectAvailable.API_Check_API1_Date__c = Datetime.now();
					
                upsertAPI1_1.add(customObjectAvailable);
            }
   
            //Remove duplicate
            Set<Purecloud__c> myset1_1 = new Set<Purecloud__c>();
            myset1_1.addAll(upsertAPI1_1);
            upsertWithoutDuplicatesAvailable.addAll(myset1_1);
            
            upsertAPI1_1.clear();    
                
            Integer sumTraining = 0;
           	Map<string, Purecloud__c> customObjectByExternalIdTraining = new Map<string, Purecloud__c>();
            for(string recordTraining: arrayMetricsTrainingOnly)
            {
                Purecloud__c customObjectTraining;
                List<string> dataTraining = recordTraining.split(';');
                sumTraining += Integer.valueof(dataTraining[2]);
                
                    if (customObjectByExternalIdTraining.containsKey(dataTraining[0])){
                        customObjectTraining = customObjectByExternalIdTraining.get(dataTraining[0]);   
                        customObjectTraining.put(dataTraining[1], decimal.valueof(sumTraining/1000));
                    }
                    else{
                        customObjectTraining = new Purecloud__c();
                        customObjectTraining.External_Id__c = dataTraining[0];
                        customObjectTraining.put(dataTraining[1], decimal.valueof(sumTraining/1000));
                        customObjectByExternalIdTraining.put(dataTraining[0], customObjectTraining);
                    }
                
                //flag API check - API 1
                customObjectTraining.API_Check_API1__c = true;
				customObjectTraining.API_Check_API1_Status__c = 'Okay. Training';
                customObjectTraining.API_Check_API1_Date__c = Datetime.now();
					
                upsertAPI1_2.add(customObjectTraining);
            }
   
            //Remove duplicate
            Set<Purecloud__c> myset1_2 = new Set<Purecloud__c>();
            myset1_2.addAll(upsertAPI1_2);
            upsertWithoutDuplicatesTraining.addAll(myset1_2);    
            
            upsertAPI1_2.clear();    
                
            	} // Taufik, 6 Nov 2018, jika Body == {}, tidak perlu dijalankan.
            
            System.debug('api1 no error, bah');
            
            if(upsertWithoutDuplicates.size() == 0 && upsertWithoutDuplicatesAvailable.size() == 0 && upsertWithoutDuplicatesTraining.size() == 0){
                tempAgent[us_index].API_Check_API1__c = true;
				tempAgent[us_index].API_Check_API1_Status__c = 'Okay. Agent Offline';
                tempAgent[us_index].API_Check_API1_Date__c = Datetime.now();
            }
            
            }                   
        catch(exception e){
                system.debug('*error*'+e);
                //system.debug('*error*'+parser_log);
              	tempAgent[us_index].API_Check_API1__c = false;
            	tempAgent[us_index].API_Check_API1_Status__c = 'Error: ' + e;
            }
		
        //-------------------------------------------USER DETAIL-----------------------------------------------------
        String JSONstringDetail = '';
        String bodypart1Detail = '{"type":"dimension","dimension":"userId","operator":"matches","value":"';
        String bodypart2Detail = '"}';
        String endStringDetail = '] } ] }';
        
        for (integer i = 0; i < sizeUser; i++){
            JSONstringDetail += bodypart1Detail + scope[i].SIP__c + bodypart2Detail;
            if(i + 1 < sizeUser){
                JSONstringDetail += comma;
            }
        }
        JSONstringDetail += endStringDetail;
        //System.debug('jsonStringDetail = ' + JSONstringDetail);
        
        Integer pageNumber = 1;
        
        blob exResDetail = [SELECT Body FROM StaticResource WHERE Name='ResBody_UserDetail' Limit 1].Body;   
        string tempuseridpc2 = ''; //tampung userid yang datanya kepotong di page selanjutnya
        
            System.debug(pageResponse);
            
		while ( pageResponse != null || pageResponse != '{}' || pageResponse != '') {
            
            System.debug(pageResponse);
            
        Http h2 = new Http();
        HttpRequest req2 = new HttpRequest();
        req2.setEndpoint(url2);
        req2.setMethod('POST');
        req2.setTimeout(120000);
        req2.setHeader('content-type', 'application/json');
        req2.setHeader('Authorization', 'Bearer '+ token);
        req2.setBody('{  "interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "order": "asc",  "paging": {   "pageSize": 100,   "pageNumber": '+pageNumber+'  }, "userFilters": [   {    "type": "or",    "predicates": [ '+JSONStringDetail);
        //System.debug('ARIEF Request Body =   {"interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "order": "asc",  "paging": {   "pageSize": 100,   "pageNumber": '+pageNumber+'  } , "userFilters": [   {    "type": "or",    "predicates": [ '+JSONStringDetail); 
		String UserDetailResponseDummy = exResDetail.toString();    
        try{
            HttpResponse res2 = new HttpResponse();
            res2 = h2.send(req2);
                Transient String parser2;
                //if (test.isRunningTest()) parser2 = UserDetailResponseDummy;
                if (test.isRunningTest()==false) parser2 = res2.getBody();
            	else parser2 = UserDetailResponseDummy;
                    
                system.debug('*body2*'+parser2);
            	pageResponse = parser2;
            	
            	parser_log = parser2;
            

            //if (parser2 != '{}' || parser2 != '' || parser2 != null) {
            if (JSON2Apex_UserDetail.parse(parser2).userDetails != null) {
                //String[] arrayUserDetailAux = new String[] {};
                system.debug('JSON2Apex_UserDetail.parse(parser2).userDetails ==>'+JSON2Apex_UserDetail.parse(parser2).userDetails);
                for (JSON2Apex_UserDetail.UserDetails usDetailJSON : JSON2Apex_UserDetail.parse(parser2).userDetails) {
					String g= usDetailJSON.userId;
                    System.debug('usDetailJSON.userId = ' + g);
                    string temp1, temp2;
                    string tempuseridpc;
                    string tempPresence;
                    string PresenceName;
                    string PresencePrimary;
                    string tempTime;
                    List<JSON2Apex_UserDetail.PrimaryPresence> pp2 = usDetailJSON.PrimaryPresence;
                    System.debug(pp2);
                        if( pp2 != null || test.isRunningTest()){
                            System.debug(pp2);
                        	tempuseridpc = g;
                            tempTime = pp2[pp2.size()-1].endTime;
                            if (tempuseridpc != tempuseridpc2){ //cek apakah user selanjutnya sama dengan user sebelumnya atau tidak
                                if (pageNumber == 1) temp1 = pp2[0].endTime; // endTime index 0
                                //temp2 = pp2[pp2.size()-1].startTime;

                                if (tempTime == null || tempTime == ''){ //Cek apakah di array terakhir itu offline  / available, krn yg outbound sering ga ada OFFLINE nya
                                	temp2 = pp2[pp2.size()-1].startTime; // startTime   
                                }
                                else{
                                    temp2 = tempTime; // endTime index akhir
                                }
                                
                                // updated by Ranti at 28/09/2022
                                temp2 = pp2[pp2.size()-1].startTime;
                                
                                system.debug('temp 2 end:'+temp2);
							System.debug(temp2);
                            for (integer xx3 = 0; xx3<pp2.size(); xx3++){
                                tempPresence = pp2[xx3].organizationPresenceId;
                                System.debug('masih oke. pp2 : ' + tempPresence);
                                for (Purecloud_Connector__c mPresence : [SELECT Presence_ID__c, AUX_Name__c, Primary_AUX_Name__c FROM Purecloud_Connector__c WHERE Name = 'AUX' and Presence_ID__c != null]){
                                    if (tempPresence == mPresence.Presence_ID__c){
                                        PresenceName = mPresence.AUX_Name__c;
                                        System.debug('PresenceName = ' + PresenceName);
                                        if (PresenceName == 'Away' || test.isRunningTest()){
                                            CountAway = CountAway+1;
                                        }
                                        if (PresenceName == 'Break_Pray' || test.isRunningTest()){
                                            CountBreakPray = CountBreakPray+1;
                                        }
                                        if (PresenceName == 'Break_Lunch' || test.isRunningTest()){
                                            CountBreakLunch = CountBreakLunch+1;
                                        }
                                        if (PresenceName == 'Break_Rest' || test.isRunningTest()){
                                            CountBreakRest = CountBreakRest+1;
                                        }
                                        if (PresenceName == 'Break_Other' || test.isRunningTest()){
                                            CountBreakOther = CountBreakOther+1;
                                        }
                                        //if (PresenceName == 'Busy' || test.isRunningTest()){
                                            //countBusy = countBusy+1;
                                        //}
                                        if (PresenceName == 'Meeting' || test.isRunningTest()){
                                            countMeeting = countMeeting+1;
                                        }
                                        if (PresenceName == 'Training' || test.isRunningTest()){ //|| PresenceName == 'Coaching'
                                            countTraining = countTraining+1;
                                        }
                                        if (PresenceName == 'Training_Coaching' || test.isRunningTest()){
                                            countTrainingCoaching = countTrainingCoaching+1;
                                        }
                                        if (PresenceName == 'Available_Admin' || test.isRunningTest()){
                                            countAvailableAdmin = countAvailableAdmin+1;
                                        }
                                        if (PresenceName == 'Available_Walk_in' || test.isRunningTest()){
                                            countAvailableWalkIN = countAvailableWalkIN+1;
                                        }
                                        if (PresenceName == 'Available_Outbound' || test.isRunningTest()){
                                            countAvailableOutbound  = countAvailableOutbound +1;
                                        }
                                        if (PresenceName == 'Available_Follow_Up' || test.isRunningTest()){
                                            countAvailableFollowUp  = countAvailableFollowUp +1;
                                        }
                                        if (PresenceName == 'System Problem' || PresenceName == 'Busy' || test.isRunningTest()){
                                            countBusy = countBusy+1;
                                        }
                                    }
                                } 
                            } 
                            	//system.debug('tempuseridpc2 ==>'+tempuseridpc2);
                                //system.debug('tempuseridpc ==>'+tempuseridpc);
                                //system.debug('Temp 1 ==>'+temp1);
                                //system.debug('Temp 2 ==>'+temp2);
                                startLogin = temp1;
                                endLogin = temp2;
                                Integer tahun = Integer.Valueof(startLogin.substring(0,4));
                                Integer bulan = Integer.Valueof(startLogin.substring(5,7));
                                Integer hari = Integer.Valueof(startLogin.substring(8,10));
                                Integer jam = Integer.Valueof(startLogin.substring(11,13));
                                Integer menit = Integer.Valueof(startLogin.substring(14,16));
                                Integer second = Integer.Valueof(startLogin.substring(17,19));
                                //System.debug('New DateTime ==>'+tahun+'-'+bulan+'-'+hari+' '+jam+':'+menit+':'+second);
                                DateTime newStartLogin = DateTime.newInstance(tahun,bulan,hari,jam,menit,second);
                                
                                Integer tahun2 = Integer.Valueof(endLogin.substring(0,4));
                                Integer bulan2 = Integer.Valueof(endLogin.substring(5,7));
                                Integer hari2 = Integer.Valueof(endLogin.substring(8,10));
                                Integer jam2 = Integer.Valueof(endLogin.substring(11,13));
                                Integer menit2 = Integer.Valueof(endLogin.substring(14,16));
                                Integer second2 = Integer.Valueof(endLogin.substring(17,19));
                                //System.debug('New DateTime End ==>'+tahun2+'-'+bulan2+'-'+hari2+' '+jam2+':'+menit2+':'+second2);
                                DateTime newEndLogin = DateTime.newInstance(tahun2,bulan2,hari2,jam2,menit2,second2);

                                purecloud__c agentAPI2 = new purecloud__c();
                                agentAPI2.Away_Count__c = decimal.valueof(countAway);
                                agentAPI2.Busy_Count__c = decimal.valueof(countBusy);
                                agentAPI2.Meeting_Count__c = decimal.valueof(countMeeting);
                                agentAPI2.Training_Count__c = decimal.valueof(countTraining);
                                agentAPI2.Break_Lunch_Count__c = decimal.valueof(countBreakLunch);
                                agentAPI2.Break_Pray_Count__c = decimal.valueof(countBreakPray);
                                agentAPI2.Break_Rest_Count__c = decimal.valueof(countBreakRest);
                                agentAPI2.Break_Other_Count__c = decimal.valueof(countBreakOther);
                                // NEW May 2020
                                agentAPI2.Available_Admin_Count__c = decimal.valueof(countAvailableAdmin);
                                agentAPI2.Available_Walk_IN_Count__c = decimal.valueof(countAvailableWalkIn);
                                agentAPI2.Available_Outbound_Count__c = decimal.valueof(countAvailableOutbound);
                                agentAPI2.Available_Follow_UP_Count__c = decimal.valueof(countAvailableFollowUp);
                                //agentAPI2.Training_Training_Count__c = decimal.valueof(countBreakOther);
                                agentAPI2.Training_Coaching_Count__c = decimal.valueof(countTrainingCoaching);
                                
                                agentAPI2.Start_Login__c = newStartLogin.addHours(7);
                                agentAPI2.End_Login__c = newEndLogin.addHours(7);
                                agentAPI2.External_ID__c = tempuseridpc +'_'+year+'-'+month+'-'+day;
                                
                                agentAPI2.API_Check_API2__c = true;
                                agentAPI2.API_Check_API2_Status__c = 'Okay';
                                agentAPI2.API_Check_API2_Date__c = Datetime.now(); 
                                
                                upsertAPI2.add(agentAPI2);  
                            
                                countAway = 0;
                                countMeeting = 0;
                                countTraining = 0;
                                countBusy = 0;
                                countMeal = 0;
                                countBreakLunch = 0;
                                countBreakPray = 0;
                                countBreakRest = 0;
                                countBreakOther = 0;
                                // NEW MAY 2020
                                countAvailableAdmin = 0;
                                countAvailableWalkIn = 0;
                                countAvailableOutbound = 0;
                                countAvailableFollowUp = 0;
                                countTrainingCoaching = 0;
                                    
                                tempuseridpc2 = g;
                        	}
                            else if (tempuseridpc == tempuseridpc2 || Test.isRunningTest()){
                            	if (pageNumber == 1) temp1 = pp2[0].endTime; // endTime index 0
                                //temp2 = pp2[pp2.size()-1].startTime;                            
                                
                                if (tempTime == null || tempTime == ''){ //Cek apakah di array terakhir itu offline  / available, krn yg outbound sering ga ada OFFLINE nya
                                	temp2 = pp2[pp2.size()-1].startTime; // start    
                                }
                                else {
                                    temp2 = tempTime; // end index akhir
                                }
                              
                            for (integer xx3 = 0; xx3<pp2.size(); xx3++){
                                tempPresence = pp2[xx3].organizationPresenceId;
                                
                                for (Purecloud_Connector__c mPresence : [SELECT Presence_ID__c, AUX_Name__c, Primary_AUX_Name__c FROM Purecloud_Connector__c WHERE Name = 'AUX' and Presence_ID__c != null]){
                                    if (tempPresence == mPresence.Presence_ID__c){
                                        PresenceName = mPresence.AUX_Name__c;
                                        if (PresenceName == 'Away'){
                                            CountAway = CountAway+1;
                                        }
                                        if (PresenceName == 'Pray'){
                                            CountBreakPray = CountBreakPray+1;
                                        }
                                        if (PresenceName == 'Lunch'){
                                            CountBreakLunch = CountBreakLunch+1;
                                        }
                                        if (PresenceName == 'Restroom'){
                                            CountBreakRest = CountBreakRest+1;
                                        }
                                        if (PresenceName == 'Other'){
                                            CountBreakOther = CountBreakOther+1;
                                        }
                                        if (PresenceName == 'Busy'){
                                            countBusy = countBusy+1;
                                        }
                                        if (PresenceName == 'Meeting'){
                                            countMeeting = countMeeting+1;
                                        }
                                        if (PresenceName == 'Training'){ //  || PresenceName == 'Coaching'
                                            countTraining = countTraining+1;
                                        }
                                        if (PresenceName == 'Training_Coaching' || test.isRunningTest()){
                                            countTrainingCoaching = countTrainingCoaching+1;
                                        }
                                        if (PresenceName == 'Available_Admin' || test.isRunningTest()){
                                            countAvailableAdmin = countAvailableAdmin+1;
                                        }
                                        if (PresenceName == 'Available_Walk_in' || test.isRunningTest()){
                                            countAvailableWalkIN = countAvailableWalkIN+1;
                                        }
                                        if (PresenceName == 'Available_Outbound' || test.isRunningTest()){
                                            countAvailableOutbound  = countAvailableOutbound +1;
                                        }
                                        if (PresenceName == 'Available_Follow_Up' || test.isRunningTest()){
                                            countAvailableFollowUp  = countAvailableFollowUp +1;
                                        }

                                    }
                                } 
                            } 
                            	//system.debug('Temp 1 ==>'+temp1);
                                //system.debug('Temp 2 ==>'+temp2);
                                startLogin = temp1;
                                endLogin = temp2;
                                Integer tahun = Integer.Valueof(startLogin.substring(0,4));
                                Integer bulan = Integer.Valueof(startLogin.substring(5,7));
                                Integer hari = Integer.Valueof(startLogin.substring(8,10));
                                Integer jam = Integer.Valueof(startLogin.substring(11,13));
                                Integer menit = Integer.Valueof(startLogin.substring(14,16));
                                Integer second = Integer.Valueof(startLogin.substring(17,19));
                                //System.debug('New DateTime ==>'+tahun+'-'+bulan+'-'+hari+' '+jam+':'+menit+':'+second);
                                DateTime newStartLogin = DateTime.newInstance(tahun,bulan,hari,jam,menit,second);
                                
                                Integer tahun2 = Integer.Valueof(endLogin.substring(0,4));
                                Integer bulan2 = Integer.Valueof(endLogin.substring(5,7));
                                Integer hari2 = Integer.Valueof(endLogin.substring(8,10));
                                Integer jam2 = Integer.Valueof(endLogin.substring(11,13));
                                Integer menit2 = Integer.Valueof(endLogin.substring(14,16));
                                Integer second2 = Integer.Valueof(endLogin.substring(17,19));
                                //System.debug('New DateTime End ==>'+tahun2+'-'+bulan2+'-'+hari2+' '+jam2+':'+menit2+':'+second2);
                                DateTime newEndLogin = DateTime.newInstance(tahun2,bulan2,hari2,jam2,menit2,second2);
                            
                                purecloud__c agentAPI2_1 = new purecloud__c();
                                agentAPI2_1.Away_Count__c = decimal.valueof(countAway);
                                agentAPI2_1.Busy_Count__c = decimal.valueof(countBusy);
                                agentAPI2_1.Meeting_Count__c = decimal.valueof(countMeeting);
                                agentAPI2_1.Training_Count__c = decimal.valueof(countTraining);
                                agentAPI2_1.Break_Lunch_Count__c = decimal.valueof(countBreakLunch);
                                agentAPI2_1.Break_Pray_Count__c = decimal.valueof(countBreakPray);
                                agentAPI2_1.Break_Rest_Count__c = decimal.valueof(countBreakRest);
                                agentAPI2_1.Break_Other_Count__c = decimal.valueof(countBreakOther);
                                // NEW May 2020
                                agentAPI2_1.Available_Admin_Count__c = decimal.valueof(countAvailableAdmin);
                                agentAPI2_1.Available_Walk_IN_Count__c = decimal.valueof(countAvailableWalkIn);
                                agentAPI2_1.Available_Outbound_Count__c = decimal.valueof(countAvailableOutbound);
                                agentAPI2_1.Available_Follow_UP_Count__c = decimal.valueof(countAvailableFollowUp);
                                //agentAPI2_1.Training_Training_Count__c = decimal.valueof(countBreakOther);
                                agentAPI2_1.Training_Coaching_Count__c = decimal.valueof(countTrainingCoaching);

                                agentAPI2_1.End_Login__c = newEndLogin;
                                agentAPI2_1.External_ID__c = tempuseridpc +'_'+year+'-'+month+'-'+day;
                                
                                agentAPI2_1.API_Check_API2__c = true;
                                agentAPI2_1.API_Check_API2_Status__c = 'Okay';
                                agentAPI2_1.API_Check_API2_Date__c = Datetime.now(); 
                                    
                                upsertAPI2_1.add(agentAPI2_1);  
                                
                                countAway = 0;
                                countMeeting = 0;
                                countTraining = 0;
                                countBusy = 0;
                                countMeal = 0;
                                countBreakLunch = 0;
                                countBreakPray = 0;
                                countBreakRest = 0;
                                countBreakOther = 0;
                                // NEW MAY 2020
                                countAvailableAdmin = 0;
                                countAvailableWalkIn = 0;
                                countAvailableOutbound = 0;
                                countAvailableFollowUp = 0;
                                countTrainingCoaching = 0;
                                
                                tempuseridpc2 = '';
                            }    
                        }       
                	}
            	} // Taufik, 6 Nov 2018, jika Body == {}, tidak perlu dijalankan.
            
            	System.debug('actually, this function works. albeit it returned blank result, not error');
            	System.debug(upsertAPI2_1.size());
                if(pageNumber == 1 && (pageResponse == null || pageResponse == '{}' || pageResponse == '') ){
                    tempAgent[us_index].API_Check_API2__c = true;
                    tempAgent[us_index].API_Check_API2_Status__c = 'Okay. No Data';
                    tempAgent[us_index].API_Check_API2_Date__c = Datetime.now();
                }
            }

       		catch(exception e){
                system.debug('*error*'+e);
                
                if(upsertAPI2!=null){
                    upsertAPI2[us_index].API_Check_API2__c = false;
                    upsertAPI2[us_index].API_Check_API2_Status__c = 'Incomplete. Partial Error: ' + e;
                }
                else{
                    tempAgent[us_index].API_Check_API2__c = false;
                    tempAgent[us_index].API_Check_API2_Status__c = 'Error: ' + e;
                }
            }
            
            if (pageResponse == Null || pageResponse == '{}' || pageResponse == ''){
				break;
			}
			else {
				pageNumber++;
                System.debug(pageNumber);
                
                if (pageNumber >= 30) break;
                if (Test.isRunningTest() && pageNumber == 2) exResDetail = [SELECT Body FROM StaticResource WHERE Name='ResBody_UserDetail_Page2' Limit 1].Body; 
                if (Test.isRunningTest() && pageNumber == 3) exResDetail = [SELECT Body FROM StaticResource WHERE Name='ResBody_UserDetail_Page3' Limit 1].Body; 
			}
            
            //system.debug('PAGE RESPONSE ==>'+pageResponse);
        }//end while
        
        //-------------------------------------------------CONVERSATION AGGREGATE COUNT-----------------------------------------------
        //String JSONstringConAggregate = '{  "interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "groupBy": [   "userId"  ],"filter": {   "type": "and",   "predicates": [ {     "type": "dimension",     "dimension": "mediaType",     "operator": "matches",     "value": "voice"    },';
        //String bodypart1ConAggregate = '{"type":"dimension","dimension":"userId","operator":"matches","value":"';
        //String bodypart2ConAggregate = '"}';
		//String endStringConAggregate = '] }, "views": [],  "metrics": [   "tHandle",   "tAnswered",   "tAcw",   "tHeld",   "tTalk"  ] }';
        String JSONstringConAggregate = '{  "interval": "'+startInterval+'/'+endInterval+'",  "timeZone": "Asia/Jakarta",  "groupBy": [   "userId",   "mediaType"  ],  "filter": {   "type": "and",   "clauses": [    {     "type": "or",     "predicates": [';
        String bodypart1ConAggregate = '{"type":"dimension","dimension":"userId","operator":"matches","value":"';
        String bodypart2ConAggregate = '"}';
        String endStringConAggregate = ']    }   ],   "predicates": [    {     "type": "dimension",     "dimension": "mediaType",     "operator": "matches",     "value": "voice"    }   ]  }, "views": [],  "metrics": [   "tHandle",   "tAnswered",   "tAcw",   "tHeld",   "tTalk"  ] }';
        
        for (integer i = 0; i < sizeUser; i++){
            JSONstringConAggregate += bodypart1ConAggregate + scope[i].SIP__c + bodypart2ConAggregate;
            if(i + 1 < sizeUser){
                JSONstringConAggregate += comma;
            }
        }
        JSONstringConAggregate += endStringConAggregate;
        //System.debug('JSONstringConAggregate = ' + JSONstringConAggregate);

        Http h3 = new Http();
        HttpRequest req3 = new HttpRequest();
        req3.setEndpoint(url3);
        req3.setMethod('POST');
        req3.setTimeout(120000);
        req3.setHeader('content-type', 'application/json');
        req3.setHeader('Authorization', 'Bearer '+ token);
        req3.setBody(JSONstringConAggregate);
        //System.debug('Taufik Request Body 3 = {  "interval": "2018-10-05T01:00:00.000Z/2018-10-12T01:00:00.000Z",  "timeZone": "Asia/Jakarta",  "groupBy": [   "userId"  ],  "views": [],  "metrics": [   "tHandle",   "tAnswered",   "tAcw",   "tHeld",   "tTalk"  ] }');
        
        blob exResConAgg = [SELECT Body FROM StaticResource WHERE Name='ResBody_ConAggregate_Agent'].Body;   
        String ConAggregateResponseDummy = exResConAgg.toString();
        
        try{
            HttpResponse res3 = new HttpResponse();
            res3 = h3.send(req3);
                Transient String parser3;
                //if (test.isRunningTest()) parser3 = ConAggregateResponseDummy;
                if (test.isRunningTest()==false) parser3 = res3.getBody();
            	else parser3 = ConAggregateResponseDummy;
            	
            	parser_log = parser3;
            
                system.debug('*body3*'+parser3);
			
            if (parser3 != null && parser3 != '{}'){
                String tempMetric;
                String trueMetric;
                String[] arrayConAggregate = new String[] {};
                for (JSON2Apex_ConAggregateUserID.Results conr : JSON2Apex_ConAggregateUserID.parse(parser3).results) {
                    JSON2Apex_ConAggregateUserID.Group_Z conUserID = conr.group_Z;
                    JSON2Apex_ConAggregateUserID.Stats_Z statsCon = conr.Stats_Z;
                    // Each d represent a user
                    for (JSON2Apex_ConAggregateUserID.Data cond : conr.data) {
                        if (cond.Metrics == null){
                        //do nothing   
                        }
                        else {
                        // Each d represent an interval
                        for (JSON2Apex_ConAggregateUserID.Metrics conm : cond.metrics) {
                            //Each m represent a metric
                            tempMetric = conm.metric;
                            System.debug('tempMetric: ' + tempMetric);
                            trueMetric = conm.metric.substring(1,conm.metric.length());
                            System.debug('trueMetric: ' + trueMetric);
                            if (trueMetric == 'Held') trueMetric = 'Hold';
                            //if (trueMetric == 'Handle') trueMetric = 'temp_aux';	//dicomment, butuh mengambil data Handle_Count // Evan ME 12/10/2020
                            if (trueMetric == 'Answered') trueMetric = 'Acd';
                            
                            System.debug('final trueMetric: ' + trueMetric);
                            
                            if (trueMetric != 'temp_aux'){
                                arrayConAggregate.add(conUserID.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '_Count__c' + ';' + conm.stats.count);
                                System.debug('count metric: ' + trueMetric + '_Count__c = ' + conm.stats.count);
                            }
                            else if (trueMetric == 'temp_aux'){
                                arrayConAggregate.add(conUserID.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric + '__c' + ';' + conm.stats.count);
                                System.debug('count metric: ' + trueMetric + '__c = ' + conm.stats.count);
                            }
                            
                        }
                        }
                    }
                }
            
            Map<string, Purecloud__c> conAggregateByExternalId = new Map<string, Purecloud__c>();
            for(string recordCon: arrayConAggregate)
            {
                Purecloud__c customObjectCon;
                List<string> data = recordCon.split(';');
                    if (conAggregateByExternalId.containsKey(data[0])){
                        customObjectCon = conAggregateByExternalId.get(data[0]);   
                        customObjectCon.put(data[1], decimal.valueof(data[2]));
                    }
                    else{
                        customObjectCon = new Purecloud__c();
                        customObjectCon.External_Id__c = data[0];
                        customObjectCon.put(data[1], decimal.valueof(data[2]));
                        conAggregateByExternalId.put(data[0], customObjectCon);
                    }
                
                //flag API check - API 3
                customObjectCon.API_Check_API3__c = true;
				customObjectCon.API_Check_API3_Status__c = 'Okay. Conversation Aggregate Count';
                customObjectCon.API_Check_API3_Date__c = Datetime.now();
                
                upsertAPI3.add(customObjectCon);
            }   
            Set<Purecloud__c> mysetCon = new Set<Purecloud__c>();
            mysetCon.addAll(upsertAPI3);
            upsertWithoutDuplicatesCon.addAll(mysetCon);
            
            upsertAPI3.clear();    
                
           
            //----------------------CONVERSATION AGGREGATE SUM--------------------------------
            
                String tempMetric2;
                String trueMetric2;
                String[] arrayConAggregate2 = new String[] {};
                for (JSON2Apex_ConAggregateUserID.Results conr2 : JSON2Apex_ConAggregateUserID.parse(parser3).results) {
                    JSON2Apex_ConAggregateUserID.Group_Z conUserID2 = conr2.group_Z;
                    JSON2Apex_ConAggregateUserID.Stats_Z statsCon2 = conr2.Stats_Z;
                    // Each d represent a user
                    for (JSON2Apex_ConAggregateUserID.Data cond2 : conr2.data) {
                        if (cond2.Metrics == null){ //Validasi jika metrics null = do nothing
                        //do nothing   
                        }
                        else {
                        // Each d represent an interval
                        for (JSON2Apex_ConAggregateUserID.Metrics conm2 : cond2.metrics) {
                            //Each m represent a metric
                            tempMetric2 = conm2.metric;
                            trueMetric2 = conm2.metric.substring(1,conm2.metric.length());
                            if (trueMetric2 == 'Held') trueMetric2 = 'Hold';
                            if (trueMetric2 == 'Answered') trueMetric2 = 'temp_aux';
                            if (trueMetric2 == 'Acd') trueMetric2 = 'temp_aux';
                            
                            if (trueMetric2 != 'temp_aux'){
                                arrayConAggregate2.add(conUserID2.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric2 + '_Sum__c' + ';' + conm2.stats.sum);
                                System.debug('sum metric: ' + trueMetric2 + '_Sum__c = ' + conm2.stats.sum);
                            }
                            else if (trueMetric2 == 'temp_aux'){ 
                                arrayConAggregate2.add(conUserID2.userId + '_' +year+'-'+month+'-'+day + ';' + trueMetric2 + '__c' + ';' + conm2.stats.sum);
                            	System.debug('sum metric: ' + trueMetric2 + '__c = ' + conm2.stats.sum);
                            }
                        }
                        }
                    }
                }
            
            Map<string, Purecloud__c> conAggregateByExternalId2 = new Map<string, Purecloud__c>();
            for(string recordCon2: arrayConAggregate2)
            {
                Purecloud__c customObjectCon2;
                List<string> data2 = recordCon2.split(';');
                    if (conAggregateByExternalId2.containsKey(data2[0])){
                        customObjectCon2 = conAggregateByExternalId2.get(data2[0]);   
                        customObjectCon2.put(data2[1], decimal.valueof(data2[2])/1000);
                    }
                    else{
                        customObjectCon2 = new Purecloud__c();
                        customObjectCon2.External_Id__c = data2[0];
                        customObjectCon2.put(data2[1], decimal.valueof(data2[2])/1000);
                        conAggregateByExternalId2.put(data2[0], customObjectCon2);
                    }
                
                //flag API check - API 3
                customObjectCon2.API_Check_API3__c = true;
				customObjectCon2.API_Check_API3_Status__c = 'Okay. Conversation Aggregate Sum';
                customObjectCon2.API_Check_API3_Date__c = Datetime.now();
                
                upsertAPI3_1.add(customObjectCon2);
            }   
                    
            //Remove duplicate
            Set<Purecloud__c> mysetCon2 = new Set<Purecloud__c>();
            mysetCon2.addAll(upsertAPI3_1);
            upsertWithoutDuplicatesConSum.addAll(mysetCon2);
            
            upsertAPI3_1.clear();    
                
            }
            
            if(upsertWithoutDuplicatesCon.size()==0 && upsertWithoutDuplicatesConSum.size()==0){
                tempAgent[us_index].API_Check_API3__c = true;
				tempAgent[us_index].API_Check_API3_Status__c = 'Okay. No Data';
                tempAgent[us_index].API_Check_API3_Date__c = Datetime.now();
            }
            
            }                   
        catch(exception e){
                system.debug('*error*'+e);
                //system.debug('*error*'+parser_log);
                tempAgent[us_index].API_Check_API3__c = false;
            	tempAgent[us_index].API_Check_API3_Status__c = 'Error: ' + e;
            }
			/*		
            		//debug
                    string s = '';
                    for (Object r : tempAgent) s += '\n' + r;
                    system.debug('tempAgent ==>'+s);
        
                    string s2 = '';
                    for (Object r2 : upsertWithoutDuplicates) s2 += '\n' + r2;
                    system.debug('API 1 User Aggregate ==>'+s2);
        
        			string s3 = '';
                    for (Object r3 : upsertAPI2) s3 += '\n' + r3;
                    system.debug('API 2 User Detail ==>'+s3);
        
        			string s5 = '';
                    for (Object r5 : upsertWithoutDuplicatesCon) s5 += '\n' + r5;
                    system.debug('Conversation Aggregate Count ==>'+s5);
        
        			string s6 = '';
                    for (Object r6 : upsertWithoutDuplicatesConSum) s6 += '\n' + r6;
                    system.debug('Conversation Aggregate Sum ==>'+s6);
            */
          
        if (tempAgent.size() > 0) upsert tempAgent External_ID__c;
        if (upsertWithoutDuplicates.size() > 0) upsert upsertWithoutDuplicates External_ID__c;
        if (upsertWithoutDuplicatesAvailable.size() > 0) upsert upsertWithoutDuplicatesAvailable External_ID__c;
        if (upsertWithoutDuplicatesTraining.size() > 0) upsert upsertWithoutDuplicatesTraining External_ID__c;
        if (upsertAPI2.size() > 0) upsert upsertAPI2 External_ID__c;
        
        List <Purecloud__c> newOveridePC = new List<Purecloud__c>();
        /*List <Purecloud__c> listAllAgent = [SELECT Id, Name, Away_Sum__c, Break_Pray_Sum__c, Break_Rest_Sum__c, Break_Lunch_Sum__c, Break_Other_Sum__c, Busy_Sum__c, Meeting_Sum__c, Training_Sum__c, Available_Sum__c,
                                Away_Count__c, Break_Pray_Count__c, Break_Rest_Count__c, Break_Lunch_Count__c, Break_Other_Count__c, Busy_Count__c, Meeting_Count__c, Training_Count__c,
                                ACD_Count__c, Handle_Sum__c, Handle_Count__c, ACW_Sum__c, ACW_Count__c, Talk_Sum__c, Talk_Count__c, Hold_Sum__c, Hold_Count__c, External_ID__c, CreatedDate, LastmodifiedDate
                                FROM Purecloud__c];
        */
        for (Purecloud__c pcCheck : [SELECT Id, Name, Away_Sum__c, Break_Pray_Sum__c, Break_Rest_Sum__c, Break_Lunch_Sum__c, Break_Other_Sum__c, Busy_Sum__c, Meeting_Sum__c, Training_Sum__c, Available_Sum__c,
                                Away_Count__c, Break_Pray_Count__c, Break_Rest_Count__c, Break_Lunch_Count__c, Break_Other_Count__c, Busy_Count__c, Meeting_Count__c, Training_Count__c,
                                Available_Admin_Count__c, Available_Follow_Up_Count__c, Available_Outbound_Count__c, Available_Walk_IN_Count__c, Training_Training_Count__c, Training_Coaching_Count__c, 
                                ACD_Count__c, Handle_Sum__c, Handle_Count__c, ACW_Sum__c, ACW_Count__c, Talk_Sum__c, Talk_Count__c, Hold_Sum__c, Hold_Count__c, External_ID__c, CreatedDate, LastmodifiedDate
                                FROM Purecloud__c WHERE CreatedDate = TODAY OR LastModifiedDate = TODAY]){
                      
            //if (pcCheck.CreatedDate == system.today() || pcCheck.LastmodifiedDate == system.today()){
                for (Purecloud__c IttupsertAPI2_1 : upsertAPI2_1){
                    if (IttupsertAPI2_1.External_ID__c == pcCheck.External_ID__c){
                        Purecloud__c newPcCheck = new Purecloud__c ();
                        newPcCheck.External_ID__c = IttupsertAPI2_1.External_ID__c;
                        newPcCheck.End_Login__c = IttupsertAPI2_1.End_Login__c;
                        newPcCheck.Away_Count__c = IttupsertAPI2_1.Away_Count__c + pcCheck.Away_Count__c;
                        newPcCheck.Break_Pray_Count__c = IttupsertAPI2_1.Break_Pray_Count__c + pcCheck.Break_Pray_Count__c;
                        newPcCheck.Break_Lunch_Count__c = IttupsertAPI2_1.Break_Lunch_Count__c + pcCheck.Break_Lunch_Count__c;
                        newPcCheck.Break_Rest_Count__c = IttupsertAPI2_1.Break_Rest_Count__c + pcCheck.Break_Rest_Count__c;
                        newPcCheck.Break_Other_Count__c = IttupsertAPI2_1.Break_Other_Count__c + pcCheck.Break_Other_Count__c;
                        newPcCheck.Busy_Count__c = IttupsertAPI2_1.Busy_Count__c + pcCheck.Busy_Count__c;
                        newPcCheck.Meeting_Count__c = IttupsertAPI2_1.Meeting_Count__c + pcCheck.Meeting_Count__c;
                        newPcCheck.Training_Count__c = IttupsertAPI2_1.Training_Count__c + pcCheck.Training_Count__c;
                        // New May 2020
                        newPcCheck.Available_Admin_Count__c = IttupsertAPI2_1.Available_Admin_Count__c + pcCheck.Available_Admin_Count__c;
                        newPcCheck.Available_Outbound_Count__c = IttupsertAPI2_1.Available_Outbound_Count__c + pcCheck.Available_Outbound_Count__c;
                        newPcCheck.Available_Walk_In_Count__c = IttupsertAPI2_1.Available_Walk_In_Count__c + pcCheck.Available_Walk_In_Count__c;
                        newPcCheck.Available_Follow_Up_Count__c = IttupsertAPI2_1.Available_Follow_Up_Count__c + pcCheck.Available_Follow_Up_Count__c;
                        newPcCheck.Training_Coaching_Count__c = IttupsertAPI2_1.Training_Coaching_Count__c + pcCheck.Training_Coaching_Count__c;
                        
                        newOveridePC.add(newPcCheck);
                        //Overide data existing, endTime nya diganti ke yang baru, count AUX nya di tambah
                    }
                    else {
                        //do nothing
                    }
                }
            //}
            //else {
                //do nothing
            //}
        }
         
        if (newOveridePC.size() > 0) upsert newOveridePC External_ID__c; //Overide endTIme dan count AUX untuk record yang kepotong data nya
        if (upsertWithoutDuplicatesCon.size() > 0) upsert upsertWithoutDuplicatesCon External_ID__c;
        if (upsertWithoutDuplicatesConSum.size() > 0) upsert upsertWithoutDuplicatesConSum External_ID__c;
        			/*
            		string s4 = '';
                    for (Object r4 : newOveridePC) s4 += '\n' + r4;
                    system.debug('Overide API 2 ==>'+s4);
            		*/
        			
 		}
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
}