global with sharing class CLTelUWWrapper {

    global class Response{
        public String status {get;set;}
        public String message {get;set;}
    }
    
    global class TelUWCallLineDataResponse{
        public String status {get;set;}
        public String message {get;set;}
        public TelUWCallLineData data {get;set;}
    }
    
    global class CheckTimeAvailabilityResponse {
        public String status {get;set;}
        public String message {get;set;}
        public CheckTimeAvailability data {get;set;}
    }
    
    global class Request{
        public String lastName;
        public String policyNo;
        public String policyNoNumeric;
        public String entity;
        public String phone;
        public String mobilePhone;
        public String email;
        public String insuredName;
        public String insuredEmail;
        public String policyApp;
        public String productCodePlan;
        public String totalPremium;
        public String premium;
        public String paymentType;
        public String gender;
        public String campaignType;
        public String issuedDate;
        public String ape;
        public String contactCurrency;
        public String scheduleDate;
        public String note;
        public String source;
    }
    
    global class CLRequest{
        public Request telUWRequest;
    }
    
    global class TelUWCallLineData{
        public String policyNo {get;set;}
        public String callLineStatus {get;set;}
        public String callStatus {get;set;}
        public String reasonStatus {get;set;}
        public String detailStatus {get;set;}
        public String reasonDetailStatus {get;set;}
        public String scheduleDate {get;set;}
        public String campaignType {get;set;}
    }
    
    global class CheckTimeAvailability {
        public List<String> availibility {get;set;}
    }
    
}