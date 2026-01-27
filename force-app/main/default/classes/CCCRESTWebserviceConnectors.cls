public with sharing class CCCRESTWebserviceConnectors {
    /** :: ATTRIBUTES :: */
     
    
     
    /* #1
     * GET Customer Info 
     * 
     */
    
    public class CustomerInfo {
        public String requestJSON {get; set;}
        
        public CustomerInfo () {
        }
        
        public string getJSON (string policyNo, string entity, 
                string appID, string operation, 
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber) { 
            
            
            String endPoint ;
            String method;
            
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetCustomerInfo/pno-100-103-0000040.json' ;
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getCustomerInfo ; //comment biz by Beni Rama 14/04/2022
            } 
            
            
            // HEADER
            
            // put information of REQUEST parameters ------------------
            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName;  
            String password = sk.password; 
            String token = sk.token; 
            
            
            // BODY
            String transactionId = CCCUtils.getNewGUID(); 
            String service ='getCustomerInfo';

            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            System.debug('========== objSecurityContext : ' + objSecurityContext);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type objIcAx_AXAAsiaCustomer_Type = new ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type();

            // Put PolicyNo
            // old script : objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.policyNO = policyNO;
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.add (objAgSa_InsurancePolicy_Type);

            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;        /* -<<<--- */
            objAXAAsiaPagination_Type.endDateTime = endDateTime;            /* -<<<--- */
            objAXAAsiaPagination_Type.rowPerPage = string.valueOf(rowPerPage);              /* -<<<--- */
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);      /* -<<<--- */
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);    /* -<<<--- */
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);              /* -<<<--- */
            System.debug('========== objAXAAsiaPagination_Type : ' + objAXAAsiaPagination_Type);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('IcAx_AXAAsiaCustomer_Type', objIcAx_AXAAsiaCustomer_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            
            objBody.put('operation', operation);
            objBody.put('appID', appID); 
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap);   
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            
            //just for test
            //requestJSON ='{"Header":{"SecurityContext":{"username":"SFDCEIP","password":"SFDCEIP123!"}},"Body":{"IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"100-105-0721049"}]},"AXAAsiaPagination_Type":{"startDateTime":"","endDateTime":"","rowPerPage":"","startOfRecords":"","numberOfRecords":"","pageNumber":""},"operation":"Customer Profile","appID":"DMTM","entity":"AMFS","transactionId":"1234","service":"getCustomerInfo"}}';
  
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
            
            system.debug('endPoint : ' + endPoint);
            return rws.getResponseBody();
        } 

        public Map<String, Object> getPackageData (string policyNo, string entity, 
                string operation, string appID,
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
            system.debug ('================== CCCRESTWebserviceConnectors (CustomerInfo) json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try {
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);      
                mapWS.put('jsonStr', jsonStr);  
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try  (CustomerInfo) :' + e.getMessage());
            }
            
            return mapWS;
        }

    }    
    // .END OF - Get Customer Info
    

    /* #2
     * GET Policy Detail
     * 
     */ 

    public class PolicyDetailLife{ 
        public String requestJSON {get; set;}
        
        public PolicyDetailLife() {
            
        }
        
        public string getJSON (string policyNo, string entity, 
                string appID, string operation, 
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber) { 

            system.debug(' ==== operation : ' + operation);
            String endPoint ='';
            String method;
            
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetCustomerInfo/pno-' + policyNo + '.json' ;
                
                if (operation == 'Policy Details') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetPolicyDetail/PolicyDetail-PolicyDetail-pno-100-103-0000039-p1.json';
                }
                if (operation == 'Policy Change') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetPolicyDetail/PolicyDetail-PolicyDetail-pno-100-103-0000039-p'  + pageNumber  +  '.json';
                }
                if (operation == 'Insured Details') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetPolicyDetail/PolicyDetail-PolicyDetail-pno-100-103-0000039-p'  + pageNumber  +  '.json';
                }
                if (operation == 'Cash Value') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetPolicyDetail/PolicyDetail-PolicyDetail-pno-100-103-0000039-p' + pageNumber  +  '.json';
                } 
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getPolicyDetail ; //comment biz by Beni Rama 14/04/2022
            } 
            
            // PUT information of REQUEST parameters ------------------
            
            // HEADER
            
            // put information of REQUEST parameters ------------------
            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName; 
            String password = sk.password;
            String token = sk.token; 
            
            String transactionId = CCCUtils.getNewGUID(); 
            String service ='getPolicyDetails';
            // ----------------------------------------------
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            System.debug('========== objSecurityContext : ' + objSecurityContext);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type objIcAx_AXAAsiaCustomer_Type = new ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type();
            
            // Put PolicyNo
            // old script : objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.policyNO = policyNO;
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.add (objAgSa_InsurancePolicy_Type);
            
            // !! put the parameter over here
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;        /* -<<<--- */
            objAXAAsiaPagination_Type.endDateTime = endDateTime;            /* -<<<--- */
            objAXAAsiaPagination_Type.rowPerPage = string.valueOf(rowPerPage);              /* -<<<--- */
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);      /* -<<<--- */
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);    /* -<<<--- */
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);              /* -<<<--- */
            System.debug('========== objAXAAsiaPagination_Type : ' + objAXAAsiaPagination_Type);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('IcAx_AXAAsiaCustomer_Type', objIcAx_AXAAsiaCustomer_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap);       
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }
        
        public Map<String, Object> getPackageData (string policyNo, string entity, 
                string operation, string appID,
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime,rowPerPage, startOfRecords, numberOfRecords, pageNumber );
            //policyNoTEMP, entity, operation, policyApp, '', '', 0, 0, 0, 0);  
            system.debug ('================== CCCRESTWebserviceConnectors (PolicyDetailLife) json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try {
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);
                mapWS.put('jsonStr', jsonStr);          
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try  (PolicyDetailLife)  :' + e.getMessage());
            }
            return mapWS;
        }
    }
    
    /* #3
     * GET GI Policy Detail
     * 
     */ 
    public class GIPolicyDetail{  
        public String requestJSON {get; set;}
        
        public GIPolicyDetail() {
            
        }
        
        public string getJSON (string policyNo, string entity, 
                string appID, string operation, string certificateNo, 
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber) {  
             
            /*
            Customer Profile
            Insured Details
            Policy Details
            Insured Details
            Policy Change
            Risk Info
            Own Risk
            Interest Info
            */
            
            String endPoint ='';
            String method;
            //String endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetCustomerInfo/pno-' + policyNo + '.json' ;
            
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET'; 
                if (operation == 'Customer Profile') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetGIPolicyDetail/GIPolicyDetail-ALL-pno-100-103-0000038-p1.json';
                }
                if (operation == 'Insured Details') {
                    //endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetPolicyDetail/GIPolicyDetail-GIPolicyDetail-pno-100-103-0000038-p'  + pageNumber  +  '.json';
                }
                if (operation == 'Policy Details') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetGIPolicyDetail/GIPolicyDetail-ALL-pno-100-103-0000038-p1.json';                 
                }
                if (operation == 'Insured Details') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetGIPolicyDetail/GIPolicyDetail-ALL-pno-100-103-0000038-p1.json';
                }
                if (operation == 'Policy Change') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetGIPolicyDetail/GIPolicyDetail-ALL-pno-100-103-0000038-p1.json';
                } 
                if (operation == 'Risk Info') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetGIPolicyDetail/GIPolicyDetail-ALL-pno-100-103-0000038-p'  + pageNumber  +  '.json';
                }  
                if (operation == 'Own Risk') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetGIPolicyDetail/GIPolicyDetail-ALL-pno-100-103-0000038-p1.json';
                }
                if (operation == 'Interest Info') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetGIPolicyDetail/GIPolicyDetail-ALL-pno-100-103-0000038-p1.json';
                }
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getGIPolicyDetail ; //comment biz by Beni Rama 14/04/2022
            } 

            // put information of REQUEST parameters ------------------
            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName; 
            String password = sk.password; 
            String token = sk.token; 

            String transactionId = CCCUtils.getNewGUID(); 
            String service ='getGIPolicyDetail';
            // ----------------------------------------------
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            System.debug('========== objSecurityContext : ' + objSecurityContext);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type objIcAx_AXAAsiaCustomer_Type = new ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type();
            
            // Put PolicyNo
            // old script : objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.policyNO = policyNO;
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            if (operation=='Policy Change') {
                objAgSa_InsurancePolicy_Type.certificateNo = (certificateNo==null?'' :certificateNo); 
            } //<<<< cek disini!!!
            objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.add (objAgSa_InsurancePolicy_Type);
                        
            // !! put the parameter over here
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;        /* -<<<--- */
            objAXAAsiaPagination_Type.endDateTime = endDateTime;            /* -<<<--- */
            objAXAAsiaPagination_Type.rowPerPage = string.valueOf(rowPerPage);              /* -<<<--- */
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);      /* -<<<--- */
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);    /* -<<<--- */
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);              /* -<<<--- */
            System.debug('========== objAXAAsiaPagination_Type : ' + objAXAAsiaPagination_Type);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('IcAx_AXAAsiaCustomer_Type', objIcAx_AXAAsiaCustomer_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap);       
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }
        
        public Map<String, Object> getPackageData (string policyNo, string entity, 
                string operation, string appID, string certificateNo, 
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, certificateNo, startDateTime, endDateTime,rowPerPage, startOfRecords, numberOfRecords, pageNumber );
            system.debug ('================== CCCRESTWebserviceConnectors (GIPolicyDetail - ' + operation +') json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>(); 
            
            try {
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);
                mapWS.put('jsonStr', jsonStr);          
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try (GIPolicyDetail - ' + operation +') :' + e.getMessage());
            }
            return mapWS;
        }
    }
    // .END OF - Get Policy Detail

    
    /* #4
     * GET Agent Info
     * 
     */
    //@RemoteAction 

    public class AgentInfo {
        public String requestJSON {get; set;}
        
        public AgentInfo(){
            
        }
        
        public string getJSON (string agentNo, string entity, 
                string appID, string operation, 
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber)  
        { 
            
            // put information of REQUEST parameters ------------------
            // header :
            
            String endPoint ='';
            String method;
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetAgentInfo/agentinfo-agentinfo-pno-100-103-0000042.json' ;
                if (operation=='Reporting Structure Hierarchy') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetAgentInfo/agentinfo-agentinfo-pno-100-103-0000042-reportingh.json' ;
                }
                if (operation=='Top Down Hierarchy') {
                    endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetAgentInfo/agentinfo-agentinfo-pno-100-103-0000042-topdownh.json' ;
                }

            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getAgentInfo ; //comment biz by Beni Rama 14/04/2022
            } 

            // put information of REQUEST parameters ------------------
            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName; 
            String password = sk.password; 
            String token = sk.token; 
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getAgentInfo';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            ServiceInboundOutboundObjectType.IcAx_AXAAsiaParty_Type objIcAx_AXAAsiaParty_Type = new ServiceInboundOutboundObjectType.IcAx_AXAAsiaParty_Type();

            ServiceInboundOutboundObjectType.AgSa_NameValue_Type objAgSa_hasNameValue = new ServiceInboundOutboundObjectType.AgSa_NameValue_Type();
            objAgSa_hasNameValue.name = 'factPeriod';
            DateTime currentDate = Date.Today() ;
            objAgSa_hasNameValue.value = currentDate.format('yyyyMM');
            /*
            system.debug('end date time : '+ String.isBlank(endDateTime));
            if(String.isBlank(endDateTime)){
                // based on current date
                DateTime currentDate = Date.Today() ;
                objAgSa_hasNameValue.value = currentDate.format('yyyyMM');
            }else{
                // based on issued date policy
                DateTime currentDate = Date.Today() ;
                objAgSa_hasNameValue.value = currentDate.format('yyyyMM');
                //objAgSa_hasNameValue.value = endDateTime.substring(0,6);
            }
            */
            objIcAx_AXAAsiaParty_Type.hasNameValue.add(objAgSa_hasNameValue);

            if(operation == 'Reporting Structure Hierarchy' || operation == 'Top Down Hierarchy'){
                objIcAx_AXAAsiaParty_Type.partyID=agentNo;   //<< put Agent No
            }else{
                objIcAx_AXAAsiaParty_Type.partyNO=agentNo;   //<< put Agent No
            }
            objAgSa_InsurancePolicy_Type.hasPartyDetailsIn.add(objIcAx_AXAAsiaParty_Type);
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            //objAXAAsiaPagination_Type.startDateTime = startDateTime;
            //objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.rowPerPage = string.valueOf(rowPerPage);
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }   
        
        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) {
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
            system.debug ('================== CCCRESTWebserviceConnectors getAgentInfo - ' + operation + ' json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try {
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);      
                mapWS.put('jsonStr', jsonStr);  
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try getAgentInfo - ' + operation + ' :' + e.getMessage());
            }
            
            return mapWS;
        }
        
    }       
    // .END OF GET AGENT INFO
    
    
    /* #4
     * GET Beneficiary Detail
     * 
     */
    //@RemoteAction 
    public class BeneficiaryDetail {
        public String requestJSON {get; set;}
        
        public BeneficiaryDetail(){
            
        }
        
        public string getJSON (string policyNo, string entity, 
                string appID, string operation, 
                string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber) 
        { 
            
            String endPoint ='';
            String method;
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetBeneficiaryDetail/beneficiary-pno-100-103-0000041-' + pageNumber + '.json' ;
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getBeneficiaryDetail ; //comment biz by Beni Rama 14/04/2022
            } 

            // put information of REQUEST parameters ------------------
            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName; 
            String password = sk.password; 
            String token = sk.token; 

            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getBeneficiaryDetail';
            // --------------------------------------------------------
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.rowPerPage = string.valueOf(rowPerPage);
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }   
        
        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) {
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
            system.debug ('================== CCCRESTWebserviceConnectors GetBenefieceryDetail - ' + operation + ' :' +  ' json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try {
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);      
                mapWS.put('jsonStr', jsonStr);  
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try GetBenefieceryDetail - ' + operation + ' :' +  '  :' + e.getMessage());
            }
            
            return mapWS;
        }
        
    }
    // .END OF GET Beneficiary Detail
    
    
    /* #5
     * GET Premium Breakdown
     * 
     */
    public class PremiumBreakdown {
        public String requestJSON {get; set;}
        
        public PremiumBreakdown() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation, 
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) 
        {   
            String endPoint ='';
            String method;

            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetPremiumBreakdown/PremiumBreakdown-pno-100-103-0000038-p-' + pageNumber + '.json' ;
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getPremiumBreakdown ; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName;  
            String password = sk.password; 
            String token = sk.token; 
            
            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getPremiumBreakdown';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
                                   //policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber
            
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData  Premium Breakdown - ' + operation + ' :' +  '  json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);          
                mapWS.put('jsonStr', jsonStr);
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try Premium Breakdown - ' + operation + ' :' +  ':' + e.getMessage());
            }
            
            return mapWS;
        }
    }
    // .END OF GET Premium Breakdown


    /* #6
     * GET Claim Detail
     * 
     */
    //@RemoteAction 
    public class ClaimDetailLife {
        public String requestJSON {get; set;}
        
        public ClaimDetailLife() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation, 
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) 
        {               
            // put information of REQUEST parameters ------------------
            
            String endPoint ='';
            String method;          
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetClaimDetailLife/ClaimDetailLife-Claim-pno-100-103-0000038-p-' + pageNumber + '.json' ;

            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getClaimDetail ; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName;  
            String password = sk.password; 
            String token = sk.token; 
            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getClaimDetails';
            // --------------------------------------------------------
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type objIcAx_AXAAsiaCustomer_Type = new ServiceInboundOutboundObjectType.IcAx_AXAAsiaCustomer_Type();

            // Put PolicyNo
            // old script : objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.policyNO = policyNO;
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            objIcAx_AXAAsiaCustomer_Type.hasPolicyAccount.add (objAgSa_InsurancePolicy_Type);
                    
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('IcAx_AXAAsiaCustomer_Type', objIcAx_AXAAsiaCustomer_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
                                   //policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber
            
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData  Claim Life - ' + operation + ' :' +  '  json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);  
                mapWS.put('jsonStr', jsonStr);      
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try Claim Life - ' + operation + ' :' +  ':' + e.getMessage());
            }
            
            return mapWS;
        }
    }   
    
    public class ClaimDetailGI {
        public String requestJSON {get; set;}
        
        public ClaimDetailGI() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation, 
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) 
        {   
            
            // put information of REQUEST parameters ------------------
            // header :
            // body, main :
            
            String endPoint ='';
            String method;
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetClaimDetailGI/ClaimDetailGI-Claim-pno-100-103-0000038-p-' + pageNumber + '.json' ;
            
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getGIClaimDetail ; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName; 
            String password = sk.password; 
            String token = sk.token; 
            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getGIClaimDetail';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
                                   //policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber
            
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData  Claim GI - ' + operation + ' :' +  '  json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);
                mapWS.put('jsonStr', jsonStr);          
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try Claim GI - ' + operation + ' :' +  ':' + e.getMessage());
            }
            
            return mapWS;
        }
    }   
    // END OF GET Claim Detail
    
    
    /* #7
     * GET Payment History
     * 
     */
    public class PaymentHistory {
        public String requestJSON {get; set;}
        
        public PaymentHistory() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation, 
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) 
        {   
            
            // put information of REQUEST parameters ------------------
            // header :
            // body, main :
            
            String endPoint ='';
            String method;
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetPaymentHistory/PaymentHistory-Payment-pno-100-103-0000038-p-' + pageNumber + '.json' ;
            
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getPaymentHistory; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName; 
            String password = sk.password; 
            String token = sk.token; 
            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getPaymentHistory';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            objAXAAsiaPagination_Type.lineNumber = objAXAAsiaPagination_Type.startOfRecords; //<< coba 
            
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON); 
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
            
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData  Payment History - ' + operation + ' :' +  '  json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);      
                mapWS.put('jsonStr', jsonStr);  
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try Payment History - ' + operation + ' :' +  ':' + e.getMessage());
            }
            
            return mapWS;
        }
    }
     
    // .END OF GET Payment History    
    

    /* #8
     * GET FUND History
     * 
     */
    public class FundHistory {
        public String requestJSON {get; set;}
        
        public FundHistory() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation, 
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) 
        {   
            // put information of REQUEST parameters ------------------
            // header :
            // body, main :
            
            String endPoint ='';
            String method;          
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetFundHistory/FundHistory-Fund-pno-100-103-0000038-p-' + pageNumber + '.json' ;
            
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getFundHistory ; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName;  
            String password = sk.password; 
            String token = sk.token; 
            
            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getFundHistory';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);          
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData  Fund History - ' + operation + ' :' +  '  json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);          
                mapWS.put('jsonStr', jsonStr);
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try Fund History - ' + operation + ' :' +  ':' + e.getMessage());
            }
            
            return mapWS;
        }
    }
    // .END OF GET Fund History
    
    
    /* #9
     * GET FUND Detail
     * 
     */
    public class FundDetail {
        public String requestJSON {get; set;}
        
        public FundDetail() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation, 
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) 
        {   
            // put information of REQUEST parameters ------------------
            // header :
            // body, main :
            
            String endPoint ='';
            String method;          
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetFundDetail/FundDetail-Fund-pno-100-103-0000038-p-' + pageNumber + '.json' ;
            
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getFundDetail; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName; 
            String password = sk.password; 
            String token = sk.token; 

            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getFundDetail';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);          
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData  Fund Detail - ' + operation + ' :' +  '  json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);      
                mapWS.put('jsonStr', jsonStr);  
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try Fund Detail - ' + operation + ' :' +  ':' + e.getMessage());
            }
            
            return mapWS;
        }
    } 
    // .END OF GET Fund Detail


    /* #10
     * GET Product FUND Detail
     * 
     */
    public class ProductFundDetail {
        public String requestJSON {get; set;}
        
        public ProductFundDetail() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation,
            string startDateTime, string endDateTime, String fundCode,
            Integer rowPerPage, Integer startOfRecords, 
            Integer numberOfRecords, Integer pageNumber) 
        {   
            // put information of REQUEST parameters ------------------
            // header :
            // body, main :
            
            String endPoint ='';
            String method;          
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/GetProductFundDetail/ProductFundDetail-Fund-pno-100-103-0000038-p-' + pageNumber + '.json' ;
            
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getProductFundDetail; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName;  
            String password = sk.password; 
            String token = sk.token; 

            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getFundPriceHistory';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            //objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            // For Fund Code ::
            //AgSa_InsurancePolicy_Type hasAccountDetailsIn+    IcAx_AXAAsiaSubAccount_Type.hasInvestmentFundDetailsIn+ AgSa_InvestmentFund_Type.investmentFundCd
            
            ServiceInboundOutboundObjectType.AgSa_InvestmentFund_Type objAgSa_InvestmentFund_Type = new ServiceInboundOutboundObjectType.AgSa_InvestmentFund_Type();
            objAgSa_InvestmentFund_Type.investmentFundCd=fundCode;  //<<<--- fundCode
            
            // modified by catur 20171011 --> mandatory added for RLS AMFS
            if((entity == 'AMFS' || entity == 'AFI') && appID == 'RLS'){
                String valuationDt = startDateTime;
                valuationDt = valuationDt.replaceAll('^([0-9]{4})-([0-9]{2})-([0-9]{2}).*$','$1$2$3');
                objAgSa_InvestmentFund_Type.valuationDt=valuationDt;
            }
            
            List <ServiceInboundOutboundObjectType.AgSa_InvestmentFund_Type> hasInvestmentFundDetailsIn = new List <ServiceInboundOutboundObjectType.AgSa_InvestmentFund_Type>();
            hasInvestmentFundDetailsIn.add(objAgSa_InvestmentFund_Type);    // add to list ..
            
            ServiceInboundOutboundObjectType.IcAx_AXAAsiaSubAccount_Type objIcAx_AXAAsiaSubAccount_Type = new ServiceInboundOutboundObjectType.IcAx_AXAAsiaSubAccount_Type();
            objIcAx_AXAAsiaSubAccount_Type.hasInvestmentFundDetailsIn = hasInvestmentFundDetailsIn;
            
            List <ServiceInboundOutboundObjectType.IcAx_AXAAsiaSubAccount_Type> hasAccountDetailsIn = new List <ServiceInboundOutboundObjectType.IcAx_AXAAsiaSubAccount_Type>();
            hasAccountDetailsIn.add(objIcAx_AXAAsiaSubAccount_Type);
            
            //objAgSa_InsurancePolicy_Type.hasAccountDetailsIn[0].hasInvestmentFundDetailsIn[0].investmentFundCd=fundCode;
            objAgSa_InsurancePolicy_Type.hasAccountDetailsIn = hasAccountDetailsIn;
            
            // ... End of Fund Code ::  
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            objAXAAsiaPagination_Type.numberOfRecords = string.valueOf(numberOfRecords);
            objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
                    
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);
            objBody.put('service', service);
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID,
            string startDateTime, string endDateTime, String fundCode, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, fundCode, rowPerPage, startOfRecords, numberOfRecords, pageNumber);            
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData  Product Fund Detail - ' + operation + ' :' +  '  json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);          
                mapWS.put('jsonStr', jsonStr);
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try Product Fund Detail - ' + operation + ' :' +  ':' + e.getMessage());
            }
            
            return mapWS;
        }
    }
    
    // .END OF GET Product Fund Detail
    

    /* #11
     * GET ASSESSMENT NOTES 
     * 
     */
    public class AssessmentNotes {
        public String requestJSON {get; set;}
        
        public AssessmentNotes() {
            
        }
        public string getJSON (string policyNo, string entity, 
            string appID, string operation, 
            string classType, string refNo,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) 
        {   
            // put information of REQUEST parameters ------------------
            // header :
            // body, main :
            
            String endPoint ='';
            String method;          
            if (Label.EndPoint_Mode == 'DUMMY'){
                method='GET';
                string ANtype='';
                if (operation=='Summary') {ANtype='summary';} else {ANtype='detail';}
                endPoint = 'https://axacccw2-dummy-api-doddyprima.c9users.io/getAssNotes/' + classType.toLowerCase() +'/assnotes-'+classType.toLowerCase()+'-'+ANtype+'-509-5020177-p' + pageNumber + '.json' ;
                            
            }
            else if (Label.EndPoint_Mode == 'REAL'){
                method='POST';
                endPoint = Label.REST_WS_Endpoint /*+ 'biz='*/ + Label.Biz_getAssNotes ; //comment biz by Beni Rama 14/04/2022
            } 

            CCCUtils.SecurityKeys sk = new CCCUtils.SecurityKeys();
            String username = sk.userName;  
            String password = sk.password; 
            String token = sk.token; 

            
            // body, pagination :
            /*
            startDateTime ='';
            endDateTime ='';
            rowPerPage =1;
            startOfRecords =1;
            numberOfRecords =1;
            pageNumber ='1';
            */
            
            
            // body, operation
            String transactionId = CCCUtils.getNewGUID();
            String service ='getAssNotes';
            // --------------------------------------------------------
            
            
            // HEADER
            Map<String, Object> objSecurityContext = new Map<String, Object>();
            objSecurityContext.put('username', username);
            objSecurityContext.put('password', password);
            objSecurityContext.put('token', token);
            
            Map<String, Object> objHeader = new Map<String, Object>();
            objHeader.put('SecurityContext', objSecurityContext);
            
            // BODY
            ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type objAgSa_InsurancePolicy_Type = new ServiceInboundOutboundObjectType.AgSa_InsurancePolicy_Type();
            objAgSa_InsurancePolicy_Type.policyNO = policyNO;
            
            ServiceInboundOutboundObjectType.IcAx_AXAAsiaPolicyAssessment_Type objIcAx_AXAAsiaPolicyAssessment_Type = new ServiceInboundOutboundObjectType.IcAx_AXAAsiaPolicyAssessment_Type();
            objIcAx_AXAAsiaPolicyAssessment_Type.assessmentClassType=classType;
            objIcAx_AXAAsiaPolicyAssessment_Type.assmtRefNo=refNo;
            objAgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn.add(objIcAx_AXAAsiaPolicyAssessment_Type); 
            
            
            ServiceInboundOutboundObjectType.AXAAsiaPagination_Type objAXAAsiaPagination_Type = new ServiceInboundOutboundObjectType.AXAAsiaPagination_Type(); 
            objAXAAsiaPagination_Type.startDateTime = startDateTime;
            objAXAAsiaPagination_Type.endDateTime = endDateTime;
            //objAXAAsiaPagination_Type.pageNumber = string.valueOf(pageNumber);
            //objAXAAsiaPagination_Type.startOfRecords = string.valueOf(startOfRecords);
            //objAXAAsiaPagination_Type.numberOfRecords = 'string.valueOf(numberOfRecords)';
            //objAXAAsiaPagination_Type.lineNumber = objAXAAsiaPagination_Type.startOfRecords; 
            objAXAAsiaPagination_Type.pageNumber = '1';
            objAXAAsiaPagination_Type.startOfRecords = '1';
            objAXAAsiaPagination_Type.numberOfRecords = '100';
            
            
            Map<String, Object> objBody = new Map<String, Object>();
            objBody.put('AgSa_InsurancePolicy_Type', objAgSa_InsurancePolicy_Type);
            objBody.put('AXAAsiaPagination_Type', objAXAAsiaPagination_Type);
            objBody.put('operation', operation);
            objBody.put('appID', appID);
            objBody.put('entity', entity);
            objBody.put('transactionId', transactionId);            
            objBody.put('service', service);
            
            
            Map<String, Object> requestMap = new Map<String, Object>();
            requestMap.put('Header', objHeader);
            requestMap.put('Body', objBody);    
            
            requestJSON = JSON.serialize(requestMap); 
            System.debug('========== requestJSON : ' + requestJSON);        
            requestJSON = CCCUtils.stripJsonNulls(requestJSON);
            System.debug('========== requestJSON : ' + requestJSON);
            
            system.debug('=');
            system.debug('================== ***** SERVICE : ' + service  + ' ***** ==================');
            system.debug('================== >> request : ' + requestJSON );
            RESTWebserviceService rws = new RESTWebserviceService(endPoint, requestJSON, method, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
    
            return rws.getResponseBody();
        }

        public Map<String, Object> getPackageData (string policyNo, string entity, 
            string operation, string appID, 
            string classType, string refNo,
            string startDateTime, string endDateTime, 
            Integer rowPerPage, Integer startOfRecords,
            Integer numberOfRecords, Integer pageNumber) { 
            
            // :: get JSON string from webservice 
            string jsonStr = getJSON(policyNo, entity, appID, operation, classType, refNo, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);            
            system.debug ('================== CCCRESTWebserviceConnectors getPackageData Assessment Notes - ' + operation + ' :' +  'json : ' + jsonStr);
            
            Map<String, Object> mapWS = new Map<String, Object>();
            
            try { 
                // deserializeUntyped to mapData
                Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
                String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
                mapWS.put('status', status);
                mapWS.put('mapData', mapData);      
                mapWS.put('jsonStr', jsonStr);  
            } 
            catch (Exception e) {
                mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
                mapWS.put('mapData', 'null');
                mapWS.put('jsonStr', jsonStr);
                system.debug('============ error on try (deserializeUntyped Assessment Notes - ' + operation + ' - ' + classType + ' - ' + refNo + ' :' +  ') :' + e.getMessage());
            }
            
            return mapWS;
        }
    }
    // .END OF GET ASSESSMENT NOTES
    
    /** :: COSNSTROCTOR :: */
    public CCCRESTWebserviceConnectors(){
    }
}