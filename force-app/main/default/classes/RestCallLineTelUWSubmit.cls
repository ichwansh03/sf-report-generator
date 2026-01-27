@RestResource(urlMapping='/CallLine/v1/TelUW/submit')
global with sharing class RestCallLineTelUWSubmit {

    public static String STATUS_MISSING_REQUIRED_FIELD = '101';
    public static String MISSING_REQUEST_PAYLOAD = 'Request Parameter is Missing';
    public static String MISSING_POLICY_NO = 'Policy No is Required';
    public static String MISSING_SCHEDULE_DATE = 'Schedule Date is Required';
    public static String MISSING_NOTE = 'Note is Required';
    public static String MISSING_SOURCE = 'Source is Required';
    public static String MISSING_LASTNAME = 'Name is Missing';
    public static String MISSING_KEY = 'Policy No Numeric is Missing';
    public static String MISSING_ENTITY = 'Entity is Missing';
    public static String MISSING_PHONE = 'Phone No is Missing';
    public static String MISSING_MOBILE_PHONE = 'Mobile Phone No is Missing';
    public static String MISSING_EMAIL = 'Email is Missing';
    public static String MISSING_POLICY_APP = 'Policy App is Missing';
    public static String MISSING_PRODUCT_CODE = 'Product Code is Missing';
    public static String MISSING_TOTAL_PREMI = 'Total Premium is Missing';
    public static String MISSING_PREMI = 'Premi is Missing';
    public static String MISSING_PAYMENT_TYPE = 'Payment Type is Missing';
    public static String MISSING_GENDER = 'Gender is Missing';
    public static String MISSING_CAMPAIGN_TYPE = 'Campaign Type is Missing';
    public static String MISSING_ISSUED_DATE = 'Issued Date is Missing';
    public static String MISSING_APE = 'APE is Missing';
    public static String MISSING_CURRENCY = 'Currency is Missing';
    
    public static String METHOD_RESCHEDULE_TELUW = 'rescheduleTelUW';
    public static String METHOD_REQUEST_TELUW = 'requestTelUW';
    
    public class MissingFieldException extends Exception {}
    
    @HttpPut
    global static CLTelUWWrapper.Response rescheduleTelUW(CLTelUWWrapper.Request telUWRequest) {
        CLTelUWWrapper.Response res = new CLTelUWWrapper.Response();
        CallLineTeluwHelper callLineTeluwHelper = new CallLineTeluwHelper();
        try {
            requestCheck(telUWRequest, METHOD_RESCHEDULE_TELUW);
        	DateTime strRescheduleDateTime = DateTime.valueOf(telUWRequest.ScheduleDate);
            callLineTeluwHelper.rescheduleTelUW(telUWRequest.policyNo, strRescheduleDateTime, telUWRequest.note, telUWRequest.source);
            res.status = callLineTeluwHelper.STATUS_SUCCESS; res.message = callLineTeluwHelper.CREATE_MESSAGE_SUCCESS;
        } catch (callLineTeluwHelper.NoDataException e) {
            res.status = callLineTeluwHelper.STATUS_NOT_FOUND; res.message = e.getMessage();
        } catch (callLineTeluwHelper.NoDateException e) {
            res.status = callLineTeluwHelper.STATUS_DATE_ERROR; res.message = e.getMessage();
        } catch (callLineTeluwHelper.NoHourException e) {
            res.status = callLineTeluwHelper.STATUS_TIME_ERROR; res.message = e.getMessage();
        } catch (callLineTeluwHelper.CallLineException e) {
            res.status = callLineTeluwHelper.STATUS_CALL_ERROR; res.message = e.getMessage();
        } catch (MissingFieldException e) {
            res.status = STATUS_MISSING_REQUIRED_FIELD; res.message = e.getMessage();
        } catch (Exception e) {
            res.status = callLineTeluwHelper.STATUS_SERVER_ERROR; res.message = e.getMessage();
        }
        return res;
    }
    
    @HttpPost
    global static CLTelUWWrapper.TelUWCallLineDataResponse requestTelUW(CLTelUWWrapper.Request telUWRequest) {
        CLTelUWWrapper.telUWCallLineDataResponse res = new CLTelUWWrapper.telUWCallLineDataResponse();
        CallLineTeluwHelper callLineTeluwHelper = new CallLineTeluwHelper();
        
        try {
            system.debug('=========== Request TelUW API ============');
            requestCheck(telUWRequest, METHOD_REQUEST_TELUW);
            CLTelUWWrapper.TelUWCallLineData resData = callLineTeluwHelper.requestTelUW(telUWRequest);
            system.debug('=========== Request TelUW API Done ============');
            system.debug('resData ===>: ' + resData);
            res.status = callLineTeluwHelper.STATUS_SUCCESS;
            res.message = callLineTeluwHelper.CREATE_MESSAGE_SUCCESS;
            res.data = resData;
        } catch (callLineTeluwHelper.NoDataException e) {
            res.status = callLineTeluwHelper.STATUS_NOT_FOUND;
            res.message = e.getMessage();
        } catch (MissingFieldException e) {
            res.status = STATUS_MISSING_REQUIRED_FIELD;
            res.message = e.getMessage();
        } catch (Exception e) {
            res.status = callLineTeluwHelper.STATUS_SERVER_ERROR;
            res.message = e.getMessage();
        }
        
        return res;
    }
    
    public static void requestCheck(CLTelUWWrapper.Request telUWRequest, String methodName) {
        if (telUWRequest == null) throw new MissingFieldException(MISSING_REQUEST_PAYLOAD);
        if (telUWRequest.policyNo == null || telUWRequest.policyNo == '') throw new MissingFieldException(MISSING_POLICY_NO);
        if ((telUWRequest.scheduleDate == null || telUWRequest.scheduleDate == '') && methodName.equalsIgnoreCase(METHOD_RESCHEDULE_TELUW)) throw new MissingFieldException(MISSING_SCHEDULE_DATE);
        if ((telUWRequest.note == null || telUWRequest.note == '') && methodName.equalsIgnoreCase(METHOD_RESCHEDULE_TELUW)) throw new MissingFieldException(MISSING_NOTE);
        if ((telUWRequest.source == null || telUWRequest.source == '') && methodName.equalsIgnoreCase(METHOD_RESCHEDULE_TELUW)) throw new MissingFieldException(MISSING_SOURCE);
        if ((telUWRequest.lastName == null || telUWRequest.lastName == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_LASTNAME);
        if ((telUWRequest.policyNoNumeric == null || telUWRequest.policyNoNumeric == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_KEY);
        if ((telUWRequest.entity == null || telUWRequest.entity == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_ENTITY);
        if ((telUWRequest.phone == null || telUWRequest.phone == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_PHONE);
        if ((telUWRequest.mobilePhone == null || telUWRequest.mobilePhone == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_MOBILE_PHONE);
        if ((telUWRequest.email == null || telUWRequest.email == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_EMAIL);
        if ((telUWRequest.policyApp == null || telUWRequest.policyApp == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_POLICY_APP);
        if ((telUWRequest.productCodePlan == null || telUWRequest.productCodePlan == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_PRODUCT_CODE);
        if ((telUWRequest.totalPremium == null || telUWRequest.totalPremium == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_TOTAL_PREMI);
        if ((telUWRequest.premium == null || telUWRequest.premium == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_PREMI);
        if ((telUWRequest.paymentType == null || telUWRequest.paymentType == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_PAYMENT_TYPE);
        if ((telUWRequest.gender == null || telUWRequest.gender == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_GENDER);
        if ((telUWRequest.campaignType == null || telUWRequest.campaignType == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_CAMPAIGN_TYPE);
        if ((telUWRequest.issuedDate == null || telUWRequest.issuedDate == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_ISSUED_DATE);
        if ((telUWRequest.ape == null || telUWRequest.ape == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_APE);
        if ((telUWRequest.contactCurrency == null || telUWRequest.contactCurrency == '') &&  methodName.equalsIgnoreCase(METHOD_REQUEST_TELUW)) throw new MissingFieldException(MISSING_CURRENCY);
        
    }
}