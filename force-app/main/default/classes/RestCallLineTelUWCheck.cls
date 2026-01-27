@RestResource(urlMapping='/CallLine/v1/TelUW/check')
global with sharing class RestCallLineTelUWCheck {

    public static String STATUS_MISSING_REQUIRED_FIELD = '101';
    public static String MISSING_REQUEST_PAYLOAD = 'Request Parameter is Missing';
    public static String MISSING_POLICY_NO = 'Policy No is Required';
    public static String MISSING_SCHEDULE_DATE = 'Schedule Date is Required';
    
    public static String METHOD_GET_AVAIL_TIME = 'getAvailTime';
    public static String METHOD_GET_CALL_LINE = 'getCallLine';
    
    public class MissingFieldException extends Exception {}
    
    @HttpPut
    global static CLTelUWWrapper.CheckTimeAvailabilityResponse getAvailTime(CLTelUWWrapper.Request telUWRequest) {
        CLTelUWWrapper.CheckTimeAvailabilityResponse res = new CLTelUWWrapper.CheckTimeAvailabilityResponse();
        CallLineTeluwHelper callLineTeluwHelper = new CallLineTeluwHelper();
        
        try {
            requestCheck(telUWRequest, METHOD_GET_AVAIL_TIME);
            Date checkDate = Date.valueOf(telUWRequest.scheduleDate);
        	String policyNo = telUWRequest.policyNo;
            CLTelUWWrapper.checkTimeAvailability timeAvail = callLineTeluwHelper.getAvailabilityTime(policyNo, checkDate);
            
            res.status = callLineTeluwHelper.STATUS_SUCCESS; res.message = callLineTeluwHelper.CREATE_MESSAGE_SUCCESS; res.data = timeAvail;
        } catch (callLineTeluwHelper.NoDataException e) {res.status = callLineTeluwHelper.STATUS_NOT_FOUND; res.message = e.getMessage();
        } catch (callLineTeluwHelper.NoDateException e) {res.status = callLineTeluwHelper.STATUS_DATE_ERROR; res.message = e.getMessage();
        } catch (callLineTeluwHelper.NoHourException e) {res.status = callLineTeluwHelper.STATUS_TIME_ERROR; res.message = e.getMessage();
        } catch (MissingFieldException e) {res.status = STATUS_MISSING_REQUIRED_FIELD; res.message = e.getMessage();
        } catch (Exception e) {res.status = callLineTeluwHelper.STATUS_SERVER_ERROR; res.message = e.getMessage();
        }
        
        return res;
    }
    
    @HttpPost
    global static CLTelUWWrapper.TelUWCallLineDataResponse getCallLine(CLTelUWWrapper.Request telUWRequest){
        CLTelUWWrapper.TelUWCallLineDataResponse res = new CLTelUWWrapper.TelUWCallLineDataResponse();
        CallLineTeluwHelper callLineTeluwHelper = new CallLineTeluwHelper();
        
        try {
            requestCheck(telUWRequest, METHOD_GET_CALL_LINE);
            CLTelUWWrapper.telUWCallLineData telUWData = callLineTeluwHelper.getTelUW(telUWRequest.policyNo);
            res.status = callLineTeluwHelper.STATUS_SUCCESS;
            res.message = callLineTeluwHelper.CREATE_MESSAGE_SUCCESS;
            res.data = telUWData;
        } catch (callLineTeluwHelper.NoDataException e) {res.status = callLineTeluwHelper.STATUS_NOT_FOUND; res.message = e.getMessage();
        } catch (callLineTeluwHelper.CallLineException e) {res.status = callLineTeluwHelper.STATUS_CALL_ERROR; res.message = e.getMessage();
        } catch (MissingFieldException e) {res.status = STATUS_MISSING_REQUIRED_FIELD; res.message = e.getMessage();
        } catch (Exception e) {res.status = callLineTeluwHelper.STATUS_SERVER_ERROR; res.message = e.getMessage();
        }
        
        return res;
    }
    
    public static void requestCheck(CLTelUWWrapper.Request telUWRequest, String methodName) {
        if (telUWRequest == null) throw new MissingFieldException(MISSING_REQUEST_PAYLOAD);
        if (telUWRequest.policyNo == null || telUWRequest.policyNo == '') throw new MissingFieldException(MISSING_POLICY_NO);
        if ((telUWRequest.scheduleDate == null || telUWRequest.scheduleDate == '') && methodName.equalsIgnoreCase(METHOD_GET_AVAIL_TIME)) throw new MissingFieldException(MISSING_SCHEDULE_DATE);
    }
}