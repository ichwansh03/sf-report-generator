@RestResource(urlMapping='/HoldDebet/v1/Data')
global class RestHoldDebetData {
	
    public static String STATUS_MISSING_REQUIRED_FIELD = '101';
    public static String STATUS_FORMAT_INVALID = '102';
    public static String STATUS_SERVER_ERROR = '501';
    public static String STATUS_PREVENT_REQUEST_BODY = '502';
    public static String STATUS_NOT_FOUND = '404';
    public static String STATUS_SUCCESS = '200';
    public static String MISSING_PARAM_MESSAGE = 'PARAM is Required';
    public static String FORMAT_INVALID_MESSAGE = 'PARAM Format invalid';
    public static String SERVER_ERROR_MESSAGE = 'Internal Server Error, please contact administrator';
    public static String CREATE_MESSAGE_SUCCESS = 'success';
    public static String PREVENT_REQUEST_BODY_MESSAGE = 'Request Body is not allowed';
    
    public class MissingFieldException extends Exception {}
    public class FormatInvalidException extends Exception {}
    
    @HttpPost
    global static HoldDebetWrapper.caseDataResponse getCaseHoldDebet() {
        HoldDebetWrapper.caseDataResponse res = new HoldDebetWrapper.caseDataResponse();
        HoldDebetWrapper.caseResp data = new HoldDebetWrapper.caseResp();
        HoldDebetDataController holdDebetDataController = new HoldDebetDataController();
        RestRequest req = RestContext.request;
        if (req.requestBody != null && req.requestBody.toString().trim() != '') {
            res.status = STATUS_PREVENT_REQUEST_BODY; res.message = PREVENT_REQUEST_BODY_MESSAGE;
            return res;
        }
        String policyNo = req.params.get('q');
        
        try {
        	isValidFormat(policyNo);
            data = HoldDebetDataController.getCaseHD(policyNo);
            res.status = STATUS_SUCCESS; res.message = CREATE_MESSAGE_SUCCESS; res.records = data;
        } catch (holdDebetDataController.NoDataException e) {
            res.status = STATUS_NOT_FOUND; res.message = holdDebetDataController.DATA_NOT_FOUND;
        } catch (MissingFieldException e) {
            res.status = STATUS_MISSING_REQUIRED_FIELD; res.message = MISSING_PARAM_MESSAGE;
        } catch (FormatInvalidException e) {
            res.status = STATUS_FORMAT_INVALID; res.message = FORMAT_INVALID_MESSAGE;
        } catch (Exception e) {
            res.status = STATUS_SERVER_ERROR; res.message = SERVER_ERROR_MESSAGE;
        }

        return res;
    }
    
    @HttpPut
    global static HoldDebetWrapper.callLineDataResponse getCallLineHoldDebet() {
        HoldDebetWrapper.callLineDataResponse res = new HoldDebetWrapper.callLineDataResponse();
        HoldDebetWrapper.callLineResp data = new HoldDebetWrapper.callLineResp();
        HoldDebetDataController holdDebetDataController = new HoldDebetDataController();
        RestRequest req = RestContext.request;
        if (req.requestBody != null && req.requestBody.toString().trim() != '') {
            res.status = STATUS_PREVENT_REQUEST_BODY; res.message = PREVENT_REQUEST_BODY_MESSAGE;
            return res;
        }
        String policyNo = req.params.get('q');
        
        try {
            isValidFormat(policyNo);
            data = HoldDebetDataController.getCallLineHD(policyNo);
            res.status = STATUS_SUCCESS; res.message = CREATE_MESSAGE_SUCCESS; res.records = data;
        } catch (holdDebetDataController.NoDataException e) {
            res.status = STATUS_NOT_FOUND; res.message = holdDebetDataController.DATA_NOT_FOUND;
        } catch (MissingFieldException e) {
            res.status = STATUS_MISSING_REQUIRED_FIELD; res.message = MISSING_PARAM_MESSAGE;
        } catch (FormatInvalidException e) {
            res.status = STATUS_FORMAT_INVALID; res.message = FORMAT_INVALID_MESSAGE;
        } catch (Exception e) {
            res.status = STATUS_SERVER_ERROR; res.message = SERVER_ERROR_MESSAGE;
        }

        return res;
    }
    
	public static void isValidFormat(String input) {
        try {
            if (input == null) throw new FormatInvalidException(FORMAT_INVALID_MESSAGE);

            // Compile the regex pattern
            Pattern pattern = Pattern.compile('^\\d{3}-\\d{7}$');
            Matcher matcher = pattern.matcher(input);
    		if (!matcher.matches()) throw new FormatInvalidException(FORMAT_INVALID_MESSAGE);
            
        } catch (Exception e) {
            throw new FormatInvalidException(FORMAT_INVALID_MESSAGE);
        }

    }


}