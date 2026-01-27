Global class Purecloud_InsertTask {
    @future (callout=true)
    webservice static void getTest (String conversationId, String TaskId, String ParticipantId, id TaskOwnerId, id RelatedId, string subjectName){
        String url = Label.API_Purecloud+'api/v2/conversations/'+conversationId;
        //String url2 = Label.API_Purecloud+'api/v2/analytics/conversations/aggregates/query';
        String clientid = Label.Purecloud_ClientId;
        String clientSecret = Label.Purecloud_ClientSecret;
        String token = [SELECT Access_token__c FROM Purecloud_Connector__c WHERE Name ='Purecloud Token' LIMIT 1].Access_token__c;
        system.debug(LoggingLevel.DEBUG,'*url*'+url);
        system.debug('TOKEN ==>'+token);
        List<String> IVRChoose = new list <String>();
        
        String conId = '';
        String queueId;
        String startCalling;
        String startDialling;
        String endCalling;
        String callType;
        String languange;
        String skill;
        String entity;
        String queuename;
        String surveyName;  
        String q1;
        String q2;
        String q3;
        String q4;
        String q5;
        String tDial;
        String tWait;
        string tHold;
        String ani;
        String dnis;
        String transferFrom;
        String transferTo;
        String transferDate;
        Integer purecloudAPIHold = 0;
        Integer holdDuration = 0;
        String responseName;
        //String ownerAdmin = [SELECT Id FROM User Where Email = 'taufik.susanto@mii.co.id' AND Profile.Name = 'System Administrator'].id;
        //----------------------------------CONVERSATION DETAIL SURVEY------------------------------------------
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        req.setTimeout(120000);
        req.setHeader('content-type', 'application/json');
        req.setHeader('Authorization', 'Bearer '+ token);
        //String responseDummy = '{   "id": "a7d61fca-3824-4427-9863-d8fc2ad43a5e",   "participants": [     {       "id": "c49756b3-16e6-4f84-9679-1077beb3be90",       "name": "0327763333",       "address": "tel:+60327763333",       "startTime": "2018-10-09T09:44:03.683Z",       "connectedTime": "2018-10-09T09:44:03.772Z",       "endTime": "2018-10-09T09:44:32.958Z",       "purpose": "customer",       "state": "disconnected",       "direction": "inbound",       "disconnectType": "peer",       "held": false,       "wrapupRequired": false,       "queue": {         "id": "4bd54af7-0ace-4423-abbb-bdcf4a80759e",         "selfUri": "/api/v2/routing/queues/4bd54af7-0ace-4423-abbb-bdcf4a80759e"       },       "attributes": {         "Question3": "5",         "Question2": "5",         "Question1": "3",         "Salesforce": "Testing for Salesforce"       },       "alertingTimeoutMs": 0,       "provider": "Edge",       "externalContact": {         "id": "386d85ba-9e6e-4665-9f6d-252acdd035e6",         "selfUri": "/api/v2/externalcontacts/contacts/386d85ba-9e6e-4665-9f6d-252acdd035e6"       },       "muted": false,       "confined": false,       "recording": false,       "recordingState": "none",       "ani": "tel:+60327763333",       "dnis": "tel:+60327813619"     }   ],   "otherMediaUris": [],   "recordingState": "none",   "selfUri": "/api/v2/conversations/calls/a7d61fca-3824-4427-9863-d8fc2ad43a5e" }';
        try{
            HttpResponse res = new HttpResponse();
            res = h.send(req);
            system.debug('*res ==>*'+res);
            
            String parser;
            parser = res.getBody();
            system.debug('*body ==>*'+parser);
            
            //Level 1 -- PARTICIPANTS
            Map<String, Object> MapLv1 = (Map<String, Object>) JSON.deserializeUntyped(parser);
            system.debug('MapLv1 Conversation Summary ==>'+MapLv1);
            
            String temp;
            List<Object> arrayConversationSummary = new list <Object>(); 
            List<Object> arrayConversationPurpose = new list <Object>();
            for(Object o : (List<Object>)Maplv1.get('participants')){
                Map<String, Object> keyMap = (Map<String, Object>)o;
                temp = (String)keyMap.get('userId');
                String responseParticipantId = (String)keyMap.get('id');
                String purposeResponse = (String)KeyMap.get('purpose');
                
                if (purposeResponse == 'customer') {
                    arrayConversationPurpose.add(o);
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q1Answer=Yes')) q1 = 'Yes';
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q1Answer=No')) q1 = 'No';
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q1Answer=No Response')) q1 = 'No Response';
                    
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q2Answer=Yes')) q2 = 'Yes'; 
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q2Answer=No')) q2 = 'No';
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q2Answer=No Response')) q2 = 'No Response'; 
                    
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q3Answer=Yes')) q3 = 'Yes'; 
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q3Answer=No')) q3 = 'No';
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q3Answer=No Response')) q3 = 'No Response'; 
                    
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q4Answer=Yes')) q4 = 'Yes'; 
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q4Answer=No')) q4 = 'No';
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q4Answer=No Response')) q4 = 'No Response'; 
                    
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q5Answer=Yes')) q5 = 'Yes'; 
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q5Answer=No')) q5 = 'No';
                    if (String.valueof(arrayConversationPurpose[0]).contains('x_Q5Answer=No Response')) q5 = 'No Response'; 
                    
                    //Get survey value from IVR and IVR Number
                    /*
String tempDirection;
JSONParser parserSurvey = JSON.createParser(res.getBody());
String stringParsing = String.valueof(arrayConversationPurpose[0]);
system.debug('String Parsing ==>'+stringParsing);
if (stringParsing.contains('direction=outbound')) system.debug('DIRECTION OUTBOUND');
if (stringParsing.contains('direction=inbound')) system.debug('DIRECTION INBOUND');    

while (parserSurvey.nextToken() != null) {
if(parserSurvey.getCurrentToken() == JSONToken.FIELD_NAME){ 

if(parserSurvey.getText() == 'attributes'){
system.debug('ATTRIBUTES ==>'+parserSurvey.getText());
parserSurvey.nextToken();
parserSurvey.nextToken();
system.debug('x_Q1Answer ==>'+parserSurvey.getText());

if (parserSurvey.getText() == 'x_Q1Answer'){
parserSurvey.nextToken();
q1 = parserSurvey.getText();
}
else if (parserSurvey.getText() == 'x_Q2Answer'){
parserSurvey.nextToken();
q2 = parserSurvey.getText();
}
else if (parserSurvey.getText() == 'x_Q3Answer'){
parserSurvey.nextToken();
q3 = parserSurvey.getText();
}
else if (parserSurvey.getText() == 'x_Q4Answer'){
parserSurvey.nextToken();
q4 = parserSurvey.getText();
}
else if (parserSurvey.getText() == 'x_Q5Answer'){
parserSurvey.nextToken();
q5 = parserSurvey.getText();
}
}
}
}
*/
                    //Get IVR Number
                    String tempIVR1;
                    String tempIVR2;
                    JSONParser parserIVR = JSON.createParser(res.getBody());
                    while (parserIVR.nextToken() != null) {
                        if(parserIVR.getCurrentToken() == JSONToken.FIELD_NAME){ 
                            if(parserIVR.getText() == 'attributes'){
                                parserIVR.nextToken();
                                parserIVR.nextToken();
                                
                                if (parserIVR.getText().contains('AFI') || parserIVR.getText().contains('AGI') || parserIVR.getText().contains('ALI') || parserIVR.getText().contains('AMFS') || parserIVR.getText().contains('MAGI') ||
                                    parserIVR.getText().contains('Survey')){
                                        tempIVR1 = parserIVR.getText();
                                        parserIVR.nextToken();
                                        tempIVR2 = parserIVR.getText();
                                        IVRChoose.add(tempIVR1+':'+tempIVR2);
                                        
                                        parserIVR.nextToken();
                                        parserIVR.nextToken();
                                        parserIVR.nextToken();
                                        if (parserIVR.getText() != '}') {
                                            tempIVR1 = parserIVR.getText();
                                            parserIVR.nextToken();
                                            tempIVR2 = parserIVR.getText();
                                            IVRChoose.add(tempIVR1+':'+tempIVR2);
                                        }
                                        else {
                                            parserIVR.nextToken();
                                            
                                        }
                                    }
                            }
                        }
                    }
                    system.debug('IVR 1 ==>'+IVRChoose);
                    system.debug('Q1 ==>'+q1);
                    system.debug('Q2 ==>'+q2);
                }
                
                if (temp == null){
                    
                }
                else if (temp != null && participantId == responseParticipantId){
                    arrayConversationSummary.add(o);
                    startCalling = (String)keyMap.get('startTime');
                    startDialling = (String)keyMap.get('connectedTime');
                    endCalling = (String)keyMap.get('endTime');
                    responseName = (String)keyMap.get('name');
                    queueid = (String)keyMap.get('queueId');
                    ani = (String)keyMap.get('ani');
                    dnis = (String)keyMap.get('dnis');
                }
                
                //system.debug('Start Dialling ==>'+startDialling);
                //system.debug('queueid ==>'+ queueid);
            }
            system.debug('User ID ==>'+temp);   
            system.debug('Start Calling 1 ==>'+startCalling);
            
            
            //This is debug
            string s = '';
            for (Object r : IVRChoose) s += '\n' + r;
            system.debug('IVRChoose ==>'+s);
            
            //Level 2 -- CALLS
            Map<String, Object> MapLv2 = (Map<String, Object>) arrayConversationSummary[0];
            system.debug('MapLv2 Participants ==>'+MapLv2);
            
            List<Object> arrayParticipants = new List<Object>();
            for (Object o : (List<Object>)MapLv2.get('calls')) {
                Map<String, Object> keyMap = (Map<String, Object>)o;
                callType = (String)keyMap.get('direction');
                system.debug('DIRECTION ==>'+(String)keyMap.get('direction'));
                arrayParticipants.add(o);
            }
            string s2 = '';
            for (Object r2 : arrayParticipants) s2 += '\n' + r2;
            system.debug('arrayParticipants ==>'+s2);
            
            
            //Level 3 -- SEGMENTS
            Map<String, Object> MapLv3 = (Map<String, Object>) arrayParticipants[0];     
            system.debug('Map Lv 3 ==>'+MapLv3);
            
            List<Object> arraySegments = new List<Object>();
            for (Object o : (List<Object>)MapLv3.get('segments')) {
                arraySegments.add(o);
            }
            
            Map<String, Map<String,Object>> sgmnt = new Map<String, Map<String,Object>>();
            Integer i = 0;
            for (Object finalSegment : arraySegments){
                sgmnt.put(String.valueof(i), (Map<String, Object>) finalSegment);
                i++;
            }
            String indx;
            for (Integer xx = 0; xx < arraySegments.size(); xx++){
                if (String.valueof(arraySegments[xx]).contains('type=Hold')){
                    purecloudAPIHold += 1;
                    indx = String.valueof(xx);
                    String holdStart = String.valueof(sgmnt.get(indx).get('startTime'));
                    String holdEnd = String.valueof(sgmnt.get(indx).get('endTime'));
                    
                    Integer yy = Integer.Valueof(holdStart.substring(0,4));
                    Integer mm = Integer.Valueof(holdStart.substring(5,7));
                    Integer dd = Integer.Valueof(holdStart.substring(8,10));
                    Integer hh = Integer.Valueof(holdStart.substring(11,13));
                    Integer min = Integer.Valueof(holdStart.substring(14,16));
                    Integer sec = Integer.Valueof(holdStart.substring(17,19));
                    System.debug('Hold Start ==>'+yy+'-'+mm+'-'+dd+' '+hh+':'+min+':'+sec);
                    DateTime HoldstartGap = DateTime.newInstance(yy,mm,dd,hh,min,sec);
                    
                    Integer yy2 = Integer.Valueof(holdEnd.substring(0,4));
                    Integer mm2 = Integer.Valueof(holdEnd.substring(5,7));
                    Integer dd2 = Integer.Valueof(holdEnd.substring(8,10));
                    Integer hh2 = Integer.Valueof(holdEnd.substring(11,13));
                    Integer min2 = Integer.Valueof(holdEnd.substring(14,16));
                    Integer sec2 = Integer.Valueof(holdEnd.substring(17,19));
                    System.debug('Hold End ==>'+yy2+'-'+mm2+'-'+dd2+' '+hh2+':'+min2+':'+sec2);
                    DateTime HoldendGap = DateTime.newInstance(yy2,mm2,dd2,hh2,min2,sec2);
                    
                    Integer holdgap = Integer.valueof(HoldendGap.getTime() - HoldstartGap.getTime());
                    Integer holdgapSecond = holdgap/1000;
                    
                    holdDuration += holdgapSecond;
                }
                
                string sg2 = '';
                for (Object rg2 : arraySegments) sg2 += '\n' + rg2;
                system.debug('arraySegments ==>'+sg2);
                
                if (String.valueof(arraySegments[xx]).contains('type=Interact') && String.valueof(arraySegments[xx]).contains('disconnectType=transfer')){
                    
                    Map<String, Object> tf = (Map<String, Object>) JSON.deserializeUntyped(parser); 
                    List<Object> arrayTransfer = new list <Object>();           
                    for(Object o : (List<Object>)tf.get('participants')){
                        Map<String, Object> keyMapTransfer = (Map<String, Object>)o;
                        String tempTf = (String)keyMapTransfer.get('userId');
                        String responseParticipantIdTf = (String)keyMapTransfer.get('id');
                        if (tempTf == null){
                            //do nothing   
                        }
                        else{
                            arrayTransfer.add(o);    
                        }
                    }
                    //debug
                    string s3 = '';
                    for (Object r3 : arrayTransfer) s3 += '\n' + r3;
                    system.debug('arrayTransfer ==>'+s3);
                    
                    Map<String, Map<String,Object>> transferWithIndex = new Map<String, Map<String,Object>>();
                    Integer ii = 0;
                    for (Object finalTransfer : arrayTransfer){
                        transferWithIndex.put(String.valueof(ii), (Map<String, Object>) finalTransfer);
                        ii++;
                    }
                    system.debug('Transfer with index ==>'+transferWithIndex);
                    
                    for (integer indxTf = 0; indxTf < arrayTransfer.size(); indxTf++){
                        String transferParticipant = String.valueof(transferWithIndex.get(String.valueof(indxTf)).get('id'));
                        system.debug('Transfer Participant ==>'+String.valueof(transferWithIndex.get(String.valueof(indxTf)).get('id')));
                        if (transferParticipant == ParticipantId && indxTf != 0){
                            transferfrom = String.valueof(transferWithIndex.get(String.valueof(indxTf-1)).get('name'));
                            transferto = String.valueof(transferWithIndex.get(String.valueof(indxTf)).get('name'));
                            queueid = String.valueof(transferWithIndex.get(String.valueof(indxTf)).get('queueId')); 
                            //system.debug('Transfer From ==>'+String.valueof(transferWithIndex.get(String.valueof(indxTf)).get('userId')));
                            //system.debug('Transfer To ==>'+String.valueof(transferWithIndex.get(String.valueof(indxTf + 1)).get('userId')));
                            break;
                        }
                        else if (transferParticipant == ParticipantId && indxTf == 0){
                            transferfrom = 'Queue';
                            transferto = String.valueof(transferWithIndex.get(String.valueof(indxTf)).get('name'));
                            queueid = String.valueof(transferWithIndex.get(String.valueof(indxTf)).get('queueId'));
                        }
                        
                    }
                }
            }
            
            if (q1 != null){
                for(Object o : (List<Object>)Maplv1.get('participants')){
                    Map<String, Object> keyMap = (Map<String, Object>)o;
                    queueId = (String)keyMap.get('queueId');
                }
            }
            system.debug('Purecloud Hold API ==>'+purecloudAPIHold);
            system.debug('Segment Final ==>'+sgmnt);
            system.debug('Transfer From ==>'+transferfrom);
        }
        
        catch(exception e){
            system.debug('*error*'+e);
        }
        
        DateTime newstartCalling;
        if (startCalling != null){
            Integer tahun = Integer.Valueof(startCalling.substring(0,4));
            Integer bulan = Integer.Valueof(startCalling.substring(5,7));
            Integer hari = Integer.Valueof(startCalling.substring(8,10));
            Integer jam = Integer.Valueof(startCalling.substring(11,13));
            Integer menit = Integer.Valueof(startCalling.substring(14,16));
            Integer second = Integer.Valueof(startCalling.substring(17,19));
            System.debug('New startCalling ==>'+tahun+'-'+bulan+'-'+hari+' '+jam+':'+menit+':'+second);
            newstartCalling = DateTime.newInstance(tahun,bulan,hari,jam,menit,second);    
        }
        else {
            newstartCalling = system.now(); 
        }
        
        
        DateTime newstartDialing;
        
        if (startDialling != null){
            Integer tahun1 = Integer.Valueof(startDialling.substring(0,4));
            Integer bulan1 = Integer.Valueof(startDialling.substring(5,7));
            Integer hari1 = Integer.Valueof(startDialling.substring(8,10));
            Integer jam1 = Integer.Valueof(startDialling.substring(11,13));
            Integer menit1 = Integer.Valueof(startDialling.substring(14,16));
            Integer second1 = Integer.Valueof(startDialling.substring(17,19));
            System.debug('New startDialing ==>'+tahun1+'-'+bulan1+'-'+hari1+' '+jam1+':'+menit1+':'+second1);
            newstartDialing = DateTime.newInstance(tahun1,bulan1,hari1,jam1,menit1,second1);      
        }
        else {
            newStartDialing = newstartCalling;    
        }
        
        DateTime newendCalling;
        
        if (endCalling != null){ //ada kemungkinan endCalling nya null karena log ter create di tengah conversation, bukan di akhir conversation
            Integer tahun2 = Integer.Valueof(endCalling.substring(0,4));
            Integer bulan2 = Integer.Valueof(endCalling.substring(5,7));
            Integer hari2 = Integer.Valueof(endCalling.substring(8,10));
            Integer jam2 = Integer.Valueof(endCalling.substring(11,13));
            Integer menit2 = Integer.Valueof(endCalling.substring(14,16));
            Integer second2 = Integer.Valueof(endCalling.substring(17,19));
            System.debug('New endCalling ==>'+tahun2+'-'+bulan2+'-'+hari2+' '+jam2+':'+menit2+':'+second2);
            newendCalling = DateTime.newInstance(tahun2,bulan2,hari2,jam2,menit2,second2);     
        }
        else {
            newendCalling = newStartDialing.addMinutes(1);   
        }
        
        
        
        system.debug('Queue ==>'+queueid);      
        if (queueid != null){
            List<Purecloud_Master_Queue__c> queueData = [SELECT Entity__c, Languange__c, Skill__c, Name FROM Purecloud_Master_Queue__c WHERE Queue_ID__c =: queueid limit 1];
            system.debug('check ==>'+ queueData);
            if (queueData.size() > 0){
                //entity = queueData[0].Entity__c;
                languange = queueData[0].Languange__c;
                skill = queueData[0].Skill__c;
                queuename = queueData[0].name;     
            } 
        }
        else {
            entity = '-';
            languange = '-';
            skill = '-';
            queuename = '[No Queue Found]';
        }
        
        
        system.debug('Entity ==>'+entity);
        system.debug('Languange ==>'+languange);
        system.debug('Skill ==>'+skill);
        
        Integer gap = Integer.valueof(newEndCalling.getTime() - newStartDialing.getTime());
        Integer gapSecond = gap/1000;
        system.debug('GAPSECOND ==>'+gapSecond);
        Integer gapDial = Integer.valueof(newStartDialing.getTime() - newStartCalling.getTime());
        Integer gapSecondDial = gapDial/1000;
         
        Task tk = new Task();
        tk.id = id.valueof(TaskId);
        //tk.OwnerId = ownerAdmin;
        //tk.Purecloud_Call_ID__c = conversationId;
        tk.Queue_ID__c = queuename;
        tk.Languange__c = languange;
        tk.Skill__c = skill;
        tk.Entity__c = entity;
        tk.Call_Type__c = callType;
        tk.Start_Calling__c = newstartCalling.addHours(7); //Karena data yang dikirim dari API dalam bentuk UTC+0 sedangkan jakarta UTC+7
        tk.Start_Dialing__c = newstartDialing.addHours(7);
        tk.End_Calling__c = newendCalling.addHours(7);
        tk.Duration_Dial__c = gapSecondDial;
        tk.Duration_Hold__c = holdDuration;
        tk.Duration_Call__c = gapSecond;
        //tk.PureCloud_Hold_API__c = String.valueof(PurecloudAPIHold);
        //if (transferfrom != null) tk.Transfer_Date__c = newstartDialing.addHours(7); 
        
        if (surveyName == null){
            tk.PureCloud_Survey__c = '-';    
        }
        else {
            tk.PureCloud_Survey__c = surveyName;
        }
        if (q1 == null) {
            tk.PureCloud_Question1__c = '-';
        }
        else {
            tk.PureCloud_Question1__c = q1;    
        }
        if (q2 == null) {
            tk.PureCloud_Question2__c = '-';
        }
        else {
            tk.PureCloud_Question2__c = q2;    
        }
        if (q3 == null) {
            tk.PureCloud_Question3__c = '-';
        }
        else {
            tk.PureCloud_Question3__c = q3;    
        }
        if (q4 == null) {
            tk.PureCloud_Question4__c = '-';
        }
        else {
            tk.PureCloud_Question4__c = q4;    
        }
        if (q5 == null) {
            tk.PureCloud_Question5__c = '-';
        }
        else {
            tk.PureCloud_Question5__c = q5;    
        }
        
        
        if (transferFrom != null) tk.Transfer_From__c = transferFrom;
        
        if (transferTo != null) tk.Transfer_To__c = transferTo; 
        system.debug('transfer from ==>'+transferFrom);
        system.debug('transfer to ==>'+transferto);
        
            system.debug('conversationId:'+conversationId);
        if (conversationId == null){
            //do nothing
        }
        else{   
            
            // added by Ranti at 01/31/2022
            Integer intCount = 0; 
            
            for(AggregateResult result :[Select count(id) intVal from Task where CallObject =: conversationId ]) {
                intCount+=(Integer)result.get('intVal');
            }    
            
            System.debug(':: intCount:'+intCount);
            if (intCount > 1) {
                // string getFirstId = [Select id from Task where CallObject =: conversationId order by CreatedDate asc limit 1].id; 
                
            System.debug(':: conversationId:'+conversationId);
                List<Task> ListDataTask = [Select id,is_Transfer__c, ownerId from Task where CallObject =: conversationId order by CreatedDate asc ];  
                
                if (ListDataTask.size() > 0) {
                    Task getFirstData = ListDataTask[0];
                    system.debug('getFirstData.ownerId:'+getFirstData.ownerId); 
                    system.debug('tk.ownerId:'+TaskOwnerId);
                    system.debug('tk.WhatId:'+RelatedId);
                    system.debug('TaskId:'+TaskId);
                    
                   // String subject = [SELECT subject from Task WHERE Id = :TaskId].subject;
                    
                    // system.debug('subject:'+subject);
                    
                    // added by Ranti at 06/04/2022
                    if (getFirstData.ownerId != TaskOwnerId && (RelatedId != null || subjectName != null)) {  
                        System.debug(':: TaskId:'+TaskId); 
                        tk.is_Transfer__c = true;
                        System.debug(':: tk.is_Transfer__c:'+tk.is_Transfer__c);
                        
                        if (getFirstData.is_Transfer__c == false) { 
                            getFirstData.is_Transfer__c = true;
                            update getFirstData;
                        }
                        
                    }      
                }           
            }  
            Update tk;   
        }  
        
        
        
        // added by Ranti at 10 02 2023
        // add total attemp in day
        string getRelatedid = String.valueOf(RelatedId);
         if(getRelatedid != NULL && getRelatedid.left(3) == Schema.SObjectType.Call_Line__c.getKeyPrefix()) {
              Call_Line__c resultCallLine = [Select id, entity__c,Attemp_Call__c, Attempt_call_Day__c, Name, (Select Subject, createdDate, ActivityDate from ActivityHistories order by createdDate asc) from Call_Line__c where id =:getRelatedid Limit 1];
               
             if (resultCallLine.entity__c == 'AMFS') {
                double totalAttemp = 0;
                double totalAttemptPerDay = 0;
                Map<String, double> mappingActivtiyHistory = new Map<String, double>();
                 
                 Date firstTime = System.today();
                 Date lastTime = System.today();
                 integer n = 0;
                for (ActivityHistory ah : resultCallLine.getSObjects('ActivityHistories')) { 
                    string getActivityDate = String.valueOf(ah.ActivityDate);
                    totalAttemp += 1;
                    if (n == 0) firstTime = date.valueof(ah.createdDate);
                    if (!mappingActivtiyHistory.containsKey(getActivityDate)) {
                        mappingActivtiyHistory.put(getActivityDate, 1);
                    }    
                    lastTime = date.valueof(ah.createdDate);
                    n++;
                }
                 
                system.debug('mappingActivtiyHistory:'+mappingActivtiyHistory);
                
                 
                for(String row : mappingActivtiyHistory.keySet()){
                    totalAttemptPerDay += 1;
                }
                 
                 if (totalAttemp > 0 && totalAttemptPerDay == 0) {
                     totalAttemptPerDay = 1;
                 }
                 
                 Integer totalDays = firstTime.daysBetween(lastTime);
                 
                 if (totalAttemp > 0 && totalDays == 0) totalDays = 1;
                 
                system.debug('totalAttemp:'+totalAttemp);
                system.debug('totalAttemptPerDay:'+totalAttemptPerDay);
                 Call_line__c updateCallLine = new Call_line__c();
                 updateCallLine.id = getRelatedid; 
                 updateCallLine.Attemp_Call__c = totalAttemptPerDay; 
                 // updateCallLine.Attemp_Call__c = totalDays; 
                 updateCallLine.Attempt_call_Day__c = totalAttemp;
                 
                 update updateCallLine;
            } 
        }
        
        //end
        
        
        /* String whoId = [SELECT whoId from Task WHERE Id = :TaskId].whoId;
        String ownerId = [SELECT OwnerId from Task WHERE Id = :TaskId].OwnerId;
        String policyNum;
        if (whoId != null) policyNum = [SELECT Policy_No__c FROM Contact WHERE Id = :whoId].Policy_No__c;
        
        Task tk2 = new Task();
        tk2.id = taskId;
        tk2.Entity__c = [SELECT Entity__c from user where id = :OwnerId].Entity__c;
        if (policyNum == null){
            tk2.Policy_No__c = '[Contact not found or there`s no policy number]';
        }
        else {
            tk2.Policy_No__c = policyNum;   
        }
        tk2.Transfer_Date__c = date.valueof(newstartCalling);
        tk2.Customer_IVR__c = String.join(IVRChoose, '\n');
        
        if (callType == 'Inbound' && tk2.From__c == null){
            tk2.From__c = ani;
            tk2.To__c = dnis;
        }
        else if (callType == 'Outbound' && tk2.From__c == null){
            tk2.From__c = ani;
            tk2.To__c = dnis;
        }
        else if (tk2.From__c != null){
            //do nothing    
        }    
        
        update tk2; */
        
    } 
}