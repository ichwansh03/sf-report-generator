global with sharing class CallLineWrapper {
    
    global class CallLineResponse{
        public String status ;
        public String message ;
    }
    
    global class CallLineRequest{
        public String callLinePolNo {get;set;}
        public String callLineSchedule {get;set;}
        public String callLineNote {get;set;}
        public String callLineSource {get;set;}
    }

}