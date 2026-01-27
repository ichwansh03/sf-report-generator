public with sharing class RemoteDataController {
    
    public RemoteDataController(ApexPages.StandardController controller) {
        
    }

    @RemoteAction
    public static string getRemoteDataBeneficiaryDetail (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getBeneficiaryDetail';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );     

        try{
            CCCRESTWebserviceConnectors.BeneficiaryDetail objWS = new CCCRESTWebserviceConnectors.BeneficiaryDetail();
            Map<String, Object> packageData = new Map<String, Object>();
            
            strJson = objWS.getJSON(policyNo, entity, policyApp, 'Beneficiary',  startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);      
            system.debug('============== strJson BeneficiaryDetail - ' + operation + ' :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataBeneficiaryDetail - ' + operation + ' :' + e.getMessage()); 
        }


        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
                
        return strJson;
    }
      
    @RemoteAction
    public static string getRemoteDataPremiumBreakdown (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;
        
        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getPremiumBreakdown';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
        
        try{
            CCCRESTWebserviceConnectors.PremiumBreakdown objWS = new CCCRESTWebserviceConnectors.PremiumBreakdown(); 
            Map<String, Object> packageData = new Map<String, Object>();
            
            strJson = objWS.getJSON(policyNo, entity, policyApp, 'Premium Breakdown', startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);         
            system.debug('============== strJson PremiumBreakdown - ' + operation + ' :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataPremiumBreakdown - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd ); 
                    
        return strJson; 
    }


    @RemoteAction
    public static string getRemoteDataPolicyDetailLife (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getPolicyDetails';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
        
                
        try{
            CCCRESTWebserviceConnectors.PolicyDetailLife objWS = new CCCRESTWebserviceConnectors.PolicyDetailLife(); 
            Map<String, Object> packageData = new Map<String, Object>();
            
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson PolicyDetailLife - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataPolicyDetailLife - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
                
        return strJson; 
    }

    @RemoteAction
    public static string getRemoteDataGIPolicyDetail (String policyNo, String entity,  String policyApp, string operation, string certificateNo,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getGIPolicyDetail';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
        
        try{
            CCCRESTWebserviceConnectors.GIPolicyDetail objWS = new CCCRESTWebserviceConnectors.GIPolicyDetail(); 
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, certificateNo, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);        
            system.debug('============== strJson GIPolicyDetail - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataGIPolicyDetail - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
                
        return strJson; 
    } 
    
    
    @RemoteAction
    public static string getRemoteDataCustomerInfo (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getCustomerInfo';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.CustomerInfo objWS = new CCCRESTWebserviceConnectors.CustomerInfo();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson CustomerInfo - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataCustomerInfo - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
                
        return strJson; 
    } 


    @RemoteAction
    public static string getRemoteDataAssessmentNotes (String policyNo, String entity,  String policyApp, string operation, string classType, string refNo,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getAssNotes';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.AssessmentNotes objWS = new CCCRESTWebserviceConnectors.AssessmentNotes();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, classType, refNo, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);         
            system.debug('============== strJson AssessmentNotes - ' + operation + ' - ' +  classType + ' - ' + refNo + ' :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataAssessmentNotes - ' + operation + ' - ' +  classType + ' - ' + refNo + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
                
        return strJson; 
    }
    

    @RemoteAction
    public static string getRemoteDataAgentInfo (String agentCode, String entity,  String policyApp, string operation, 
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;
        agentCode = agentCode.trim();
        system.debug ('=========== REMOTE DATA =========== ');
        system.debug ('== agentCode : ' + agentCode);
        
        
        string service = 'getAgentInfo';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.AgentInfo objWS = new CCCRESTWebserviceConnectors.AgentInfo();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(agentCode, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);      
            system.debug('============== strJson AgentInfo - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataAgentInfo - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd ); 
                
        return strJson; 
    }

    @RemoteAction
    public static string getRemoteDataPaymentHistoryLife (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getPaymentHistory';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.PaymentHistory objWS = new CCCRESTWebserviceConnectors.PaymentHistory();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson Payment History - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataPaymentHistoryLife - ' + operation + ' :' + e.getMessage());
        } 

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd ); 
                
        return strJson; 
    }

/*
    @RemoteAction
    public static string getRemoteDataPaymentHistoryGI (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        string service = '??';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.PaymentHistory objWS = new CCCRESTWebserviceConnectors.PaymentHistory();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson Payment History - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataPaymentHistoryGI - ' + operation + ' :' + e.getMessage());
        }
        
        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );

        return strJson; 
    }
*/


    @RemoteAction
    public static string getRemoteDataFundHistory (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getFundHistory';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );
                
        try{
            CCCRESTWebserviceConnectors.FundHistory objWS = new CCCRESTWebserviceConnectors.FundHistory();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson Fund History - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataFundHistory - ' + operation + ' :' + e.getMessage());
        }
        
        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
        
        return strJson; 
    }
    
    @RemoteAction
    public static string getRemoteDataFundDetail (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;
        
        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getFundDetail';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
            
        try{
            CCCRESTWebserviceConnectors.FundDetail objWS = new CCCRESTWebserviceConnectors.FundDetail();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson Fund Detail - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataFundDetail - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
                        
        return strJson; 
    } 

    @RemoteAction
    public static string getRemoteDataProductFundDetail (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, String fundCode, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson; 

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getFundPriceHistory';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.ProductFundDetail objWS = new CCCRESTWebserviceConnectors.ProductFundDetail();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, fundCode, rowPerPage, startOfRecords, numberOfRecords, pageNumber);         
            system.debug('============== strJson Product Fund Detail - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataProductFundDetail - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );
                
        return strJson; 
    }    

    @RemoteAction
    public static string getRemoteDataClaimDetailLife (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;
        
        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getClaimDetails';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.ClaimDetailLife objWS = new CCCRESTWebserviceConnectors.ClaimDetailLife();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson Claim Detail Life- ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataClaimDetailLife - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd ); 
    
        return strJson;     
    }    
    
    @RemoteAction
    public static string getRemoteDataClaimDetailGI (String policyNo, String entity,  String policyApp, string operation,
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;

        system.debug ('=========== REMOTE DATA =========== ');
        string service = 'getGIClaimDetail';
        DateTime dtStart = DateTime.now();
        CCCUtils.debugDataLoad('start', service, operation, entity, policyApp, dtStart, null );    
                
        try{
            CCCRESTWebserviceConnectors.ClaimDetailGI objWS = new CCCRESTWebserviceConnectors.ClaimDetailGI();  
            Map<String, Object> packageData = new Map<String, Object>();
             
            strJson = objWS.getJSON(policyNo, entity, policyApp, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);       
            system.debug('============== strJson Claim Detail GI - ' + operation + '  :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataClaimDetailGI - ' + operation + ' :' + e.getMessage());
        }

        DateTime dtEnd = DateTime.now();
        CCCUtils.debugDataLoad('end', service, operation, entity, policyApp, dtStart, dtEnd );     
    
        return strJson;    
    }    

            
   /*     
    @RemoteAction
    public static string getRemoteDataPolicyChangeLife (String policyNo, String entity,  String policyApp, 
        String startDateTime, String endDateTime, Integer rowPerPage, Integer startOfRecords, Integer numberOfRecords,  Integer pageNumber) {
        string strJson;
        try{
            CCCRESTWebserviceConnectors.PolicyDetailLife objWS = new CCCRESTWebserviceConnectors.PolicyDetailLife(); 
            Map<String, Object> packageData = new Map<String, Object>();
            
            strJson = objWS.getJSON(policyNo, entity, 'Policy Change', policyApp, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);         
            system.debug('============== strJson PolicyChangeLife :' + strJson);
                
        }catch(Exception e){
            system.debug ('==== There is an error on REMOTE DATA : getRemoteDataPolicyChangeLife :' + e.getMessage());
        }
        return strJson; 
    } 
    */
    
    
    
/*      
    @RemoteAction
    public static string getAssNotesDetailRA2 (String policyNo, String sectionName,  String refNo, Integer pageNo, Integer recordPerPage ) {
        string strJson;
        try{
            //strJson = getAssNotesDetail2  (policyNo, sectionName,  refNo, pageNo, recordPerPage );
            CCCRESTWebserviceConnectors rwsc = new CCCRESTWebserviceConnectors();
            strJson = rwsc.getAssessmentNotesDetailJSON (policyNo, sectionName,  refNo, pageNo, recordPerPage );
            system.debug('============== strJson :' + strJson);
                
        }catch(Exception e){
            system.debug ('There is an error :' + e.getMessage());
        }
        return strJson;
    }  
*/


    
}