@RestResource(urlMapping='/CallLine/v1/reschedule/*')
global class RestCallLineRescheduler {
    
    public static String STATUS_SUCCESS = '200';
    public static String CREATE_MESSAGE_SUCCESS = 'success';
    public static String FAILED_INVALID_DATE = 'Invalid Date / Time';
    public static String NO_CALL_LINE = 'No Call Line Available';
    
    /* 
    @HttpGet
    global static List<Call_Line__c> getCallLine(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        List<Call_Line__c> callLineExisting = new List<Call_Line__c>([Select Id, Policy_No__c, Activity_Result__c, Verification__c, WelcomeCall_Detail_Status__c, 
                                                                      Notes__c, WelcomeCall_Reason_Detail_Status__c, Last_Modified_Date_Time__c 
                                                                      FROM Call_Line__c
                                                                      WHERE RecordType.Name = 'Welcome Call' AND Activity_Result__c != '' 
                                                                      AND LastModifiedDate >= YESTERDAY AND LastModifiedDate < TODAY]);
        return callLineExisting;
        
    }
	*/ 
    
    @HttpPut
    global static CallLineWrapper.CallLineResponse checkPolicyWelcomeCall (CallLineWrapper.CallLineRequest callLineRequest){
        System.debug('Method : checkPolicyWelcomeCall');
        CallLineWrapper.CallLineResponse response = new CallLineWrapper.CallLineResponse();
        CallLineRescheduleAPI clreschedule = new CallLineRescheduleAPI();
        System.debug('callLineRequest : '+callLineRequest);
        Call_Line__c callLine = new Call_Line__c();
        Map<String,String> mapMessageCreate = new Map<String,String>();
        mapMessageCreate = clreschedule.checkAvailibility(callLineRequest.callLinePolNo, callLineRequest.callLineSchedule, callLineRequest.callLineSource);
        Set<String> newSet = new Set<String>();
        for(String keyStatus : mapMessageCreate.keySet()){
            response.status = keyStatus;
            response.message = mapMessageCreate.get(keyStatus);
        }
        system.debug('done');
        return response;
    }
    
    @HttpPost
    global static CallLineWrapper.CallLineResponse createCallLineReschedule(CallLineWrapper.CallLineRequest callLineRequest){
        System.debug('Method : createCallLineReschedule');
        CallLineWrapper.CallLineResponse response = new CallLineWrapper.CallLineResponse();
        CallLineRescheduleAPI clreschedule = new CallLineRescheduleAPI();
        System.debug('callLineRequest : '+callLineRequest);
        Call_Line__c callLine = new Call_Line__c();
        if(callLineRequest.callLineSchedule != ''){
            callLine.WelcomeCall_Schedule_Date__c = (DateTime)JSON.deserialize('"' + callLineRequest.callLineSchedule + '"', DateTime.class);
        }else{
            response.status = '500';
            response.message = FAILED_INVALID_DATE;
            return response;
        }
        callLine.Notes__c = callLineRequest.callLineNote;
        callLine.Call_Remarks__c = callLineRequest.callLineNote;
        callLine.WelcomeCall_Reschedule_Source__c = callLineRequest.callLineSource;
        Map<String,String> mapMessageCreate = new Map<String,String>();
        mapMessageCreate = clreschedule.restSaveReschedule(callLineRequest.callLinePolNo, true,callLine);
        Set<String> newSet = new Set<String>();
        for(String keyStatus : mapMessageCreate.keySet()){
            response.status = keyStatus;
            response.message = mapMessageCreate.get(keyStatus);
        }
        system.debug('done');
        return response;
    }
}