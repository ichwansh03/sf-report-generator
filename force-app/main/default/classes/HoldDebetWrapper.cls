global with sharing class HoldDebetWrapper {

    global class Response{
        public String status {get;set;}
        public String message {get;set;}
    }
    
    global class caseDataResponse{
        public String status {get;set;}
        public String message {get;set;}
        public caseResp records {get;set;}
    }
    
    global class callLineDataResponse{
        public String status {get;set;}
        public String message {get;set;}
        public callLineResp records {get;set;}
    }
    
    global class caseResp {
        @JsonProperty('policy_numbers__c')
        public String policyNumbers {get;set;}
        @JsonProperty('follow_hold_date__c')
        public String followHoldDate {get;set;}
    }
    
    global class callLineResp {
        @JsonProperty('policy_no__c')
        public String policyNo {get;set;}
        @JsonProperty('Tanggal_Hold_Debet__c')
        public String tanggalHoldDebet {get;set;}
    }
}