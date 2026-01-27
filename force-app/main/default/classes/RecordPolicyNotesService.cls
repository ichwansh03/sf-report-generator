public class RecordPolicyNotesService {
    
    public Response RecordPolicyNotesResponse;
    public Request RecordPolicyNotesRequest;
    public String message;
    public String reasonCode;
    public String reason;

    public class Request {
        public Policy RLSPolicy;
        public RequestParameter STPRequestParameter;
    }
    
    public class Policy {
        public String policyNumber;
        public UWRemarks[] underwritingRemarks;
    }
    
    public class UWRemarks {
        public String notificationTypeCode;
        public String referenceNumber;
        public String remarkCode;
        public String remarkDescription;
        public String departmentCode;
        public String lastUpdateDate;
        public String completionDate;
        public String completionStatus;
        public String remarkIssueDate;
    }
    
    public class RequestParameter {
        public String languageCode;
        public String countryCode;
    }
    
    public class Response {
        public RLSResponseAPI RLSResponse;
    }
    
    public class RLSResponseAPI {
        public String validationErrorCode;
        public String validationErrorDescription;
        public String status;
    }
    
    public String toStringJSON(){
        String sJson = null;
        try{
            sJson = (String)System.JSON.serialize(this, true);
        }catch(Exception e){
            System.debug('error to String JSON : '+ e.getMessage());
        }
        return sJson;
    }
    
}