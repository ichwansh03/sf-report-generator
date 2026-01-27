public with sharing class ConservationWithdrawal {
    
    //private final Call_Line__c cLine;
    public Call_Line__c cLine {get;set;}
    
    public String contactID {get;set;}
    public string policyNo {get; set;}
    public string entity {get; set;}
    public string policyApp {get; set;}
    public string contactName {get; set;}
    public string certificateNo {get; set;}
    public string sessionID {get; set;}
    
    public List <FundDetail> fundDetailList {get;set;}
    public integer fundDetailLastPageNo {get;set;} 
    public integer fundDetailRowPerPage {get;set;} 
    
    public integer fundHistoryLastPageNo {get;set;} 
    public integer fundHistoryRowPerPage {get;set;}
    
    public integer fundPriceHistoryLastPageNo {get;set;} 
    public integer fundPriceHistoryRowPerPage {get;set;}
    
    public Decimal n_Conservation {get;set;}
    
    public Decimal nilaiConservation {
        get;
        set {
            // when changed nilaiConservation value, recalc newPrice value
            if (value != nilaiConservation) {
                nilaiConservation = value;
                recalcNewPrice();
            }
        }
    }
    
    public Decimal nilaiWithdrawal {
        get;
        set {
            // when changed nilaiWithdrawal value, recalc newPrice value
            if (value != nilaiWithdrawal) {
                nilaiWithdrawal = value;
                recalcNewPrice();
            }
        }
    }
    
    public Decimal selisih {get;set;}
    //public String offeringRetain {get;set;}
    //public List<SelectOption> offeringRetainList {get; set;}
    
    
    //EIP FUND INFO (Update 12 April 2020)
    
    
    /* Fund Details
     * base on End to End Document
     * by Doddy 2016
     */
    public class  FundDetail{
        public string FundCode {get; set;}
        public decimal FundAllocation {get; set;}
        public decimal FundPrice {get; set;}
        public decimal TotalUnitFund {get; set;}
        public decimal TotalFundAmount {get; set;}
        public date NAVDate {get; set;}
        public decimal FundAmount {get; set;}
        public string FundUnit {get; set;}
        public decimal FundTotal {get; set;}
        public date FundNAVDate {get; set;}

        public FundDetail(){
        }       
    }  
    
    
    public void initFundInfo () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initFundInfo is begin ..');
        initMain();
        fundHistoryLastPageNo = 0;
        fundDetailLastPageNo = 0;
        fundPriceHistoryLastPageNo = 0;
        
        // get Row Per Page
        fundHistoryRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Fund History', 'FundInfoPage');
        fundDetailRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Fund Details', 'FundInfoPage');
        fundPriceHistoryRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Fund Price History', 'FundInfoPage');
        //fundHistoryLastDate = Date.today();
        
        cLine = [SELECT Id, Name, Contact__c, Contact__r.Name, Contact__r.Entity__c, Nilai_Conservation__c, Nilai_Withdrawal__c, Selisih__c, Offering_Retain__c, Call_Status_Config__c, Reason_Status_Config__c FROM Call_Line__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        
        contactID = cLine.Contact__c;
        system.debug('contactID: '+contactID);
        system.debug('Contact (Name): '+cLine.Contact__r.Name);
        
        system.debug('Call Line (Nilai_Conservation__c): '+cLine.Nilai_Conservation__c);
        
        sessionID = contactID.substring(0,15) + '-'+ CCCUtils.getSessionID();
        system.debug('sessionID (new): '+sessionID);
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageData(sessionID, 'FundInfoPage');
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        if(n_Conservation != null && (cLine.Nilai_Conservation__c == null || cLine.Nilai_Conservation__c == 0) && cLine.Nilai_Conservation__c != n_Conservation){ this.nilaiConservation = n_Conservation; system.debug('this.nilaiConservation (not NULL) (1): '+ this.nilaiConservation); } 
        else if(n_Conservation != null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0) && cLine.Nilai_Conservation__c != n_Conservation){ this.nilaiConservation = cLine.Nilai_Conservation__c; system.debug('this.nilaiConservation (not NULL) (2): '+ this.nilaiConservation); } 
        else if(n_Conservation != null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0) && cLine.Nilai_Conservation__c == n_Conservation){ this.nilaiConservation = cLine.Nilai_Conservation__c; system.debug('this.nilaiConservation (not NULL) (3): '+ this.nilaiConservation); } 
        else if(n_Conservation == null && (cLine.Nilai_Conservation__c == null && cLine.Nilai_Conservation__c == 0)){ this.nilaiConservation = 0; system.debug('this.nilaiConservation (NULL) (4): '+ this.nilaiConservation); } 
        else if(n_Conservation == null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0)){ this.nilaiConservation = cLine.Nilai_Conservation__c; system.debug('this.nilaiConservation (NULL) (5): '+ this.nilaiConservation); }
        
        this.nilaiWithdrawal = 0;
        system.debug('this.nilaiWithdrawal: '+ this.nilaiWithdrawal);
        //offeringRetainList = new List<SelectOption>();
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== FUND INFO PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');                   
    }
    
    
    public void initMain(){ 
        List<AppLog__c> logList = new List<AppLog__c>();        
        AppLog__c applogWs = new AppLog__c();
        AppLog__c applogScreen = new AppLog__c();
        applogScreen.id__c = contactId;
        applogScreen.method__c = 'load police detatil screen ';
        //applogScreen.start_date__c = system.now();
        applogScreen.StartLongTime__c = system.now().getTime();
    
        //List<Contact> contactList = [SELECT Id, Policy_No__c, Entity__c, PolicyApp__c FROM Contact WHERE ID =: contactId];      system.debug('contactList: ' +contactList);
        List<Contact> contactList = [SELECT Id, name, Policy_No__c, Entity__c, PolicyApp__c, Certificate_No__c, Phone, MobilePhone, HomePhone, Policy_Status__c, Policy_Effective_Date__c, Agent_Name__c, Agent_Code__c, Agent_Status__c, Premium__c, Segment_Name__c, Branch_Name__c, Branch_Code__c, Date_of_Accident__c, Driver__c, Accident_Place__c, Detail_of_Damage__c, Production_Year__c, Licence_Number__c, Machine_No__c, Chassis_no__c, Vehicle_Type__c, Color__c, Machine_Capacity__c, Agent_Profile_No__c FROM Contact WHERE ID =: contactId];      
        system.debug('contactList: ' +contactList);
        Contact contactRec = null;
        
        if(contactList.size()>0){ contactRec = contactList[0]; policyNo = contactRec.Policy_No__c; contactName = contactRec.name; certificateNo = contactRec.Certificate_No__c; entity = contactRec.Entity__c; policyApp = contactRec.PolicyApp__c;
            
            system.debug (' *** policyNo      : ' + policyNo );
            system.debug (' *** contactName   : ' + contactName );
            system.debug (' *** certificateNo : ' + certificateNo );
            system.debug (' *** entity        : ' + entity );
            system.debug (' *** policyApp     : ' + policyApp );
            
        }
    }
    
    
    public String fundDetailJSON{
        get{
            return fundDetailJSON;
        }
        set{
            system.debug('>>> on fundDetailJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            fundDetailList = new List<FundDetail>();
            //fundDetailList = null;
            
            fundDetailJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
     
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasAccountDetailsIn');

                        integer numberOfRecords = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::numberOfRecords'));
                        integer pageNumber = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::pageNumber'));


                        if (objList.size() < numberOfRecords) { fundHistoryLastPageNo = pageNumber; }
                        system.debug('== fundDetailLastPageNo :' + fundDetailLastPageNo );
                        
                              
                        List <FundDetail> fundDetailListTMP = new List <FundDetail>();
                        
                        //system.debug ('objList size : ' + objList.size());
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            FundDetail dataRec = new FundDetail();
                            
                        /*
                            public class  FundDetail{
                                public string FundCode {get; set;}
                                public decimal FundAllocation {get; set;}
                                public decimal FundPrice {get; set;}
                                public decimal TotalUnitFund {get; set;}
                                public decimal TotalFundAmount {get; set;}
                                public date NAVDate {get; set;}
                                public decimal FundAmount {get; set;}
                                public string FundUnit {get; set;}
                                public decimal FundTotal {get; set;}
                                public date FundNAVDate {get; set;}

                                public FundDetail(){
                                }       
                            }
                            */
                            dataRec.FundCode     = CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::investmentFundCd');
                            dataRec.FundAllocation   = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::fundAllocation'));
                            dataRec.FundPrice    = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::unitPrice'));
                            dataRec.TotalUnitFund    = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::totalUnits'));
                            dataRec.TotalFundAmount  = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::totalFundAmount'));
                            dataRec.NAVDate  = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::navDt'), 'yyyymmdd');   
                                            
                            fundDetailListTMP.add(dataRec);             
                        }

                        if (fundDetailListTMP.size()==1 && fundDetailListTMP[0].FundCode=='') { fundDetailLastPageNo = pageNumber-1; }
                        system.debug('== fundDetailLastPageNo :' + fundDetailLastPageNo );
                                                
                        
                        fundDetailList = fundDetailListTMP;
                        system.debug('====== value of fundDetailList : ' + fundDetailList);
                        
                    }
                    catch  (Exception e) { 
                            system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                        }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                }
                else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    }
                    else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
                
            }
            
            if(fundDetailList.size() > 0){
                n_Conservation = fundDetailList[0].totalFundAmount;
            	system.debug('n_Conservation: '+n_Conservation);
            }
            
        }
    }
    
    
    public void preparingPageData (string sessionID, string pageName) {
        /* ----------------------------------- */
        /* Load Data for page                  */
        /* ----------------------------------- */
        system.debug ('.'); system.debug ('.');
        system.debug ('======= *** PREPARING OF PAGE DATA *** ==========================================================================================================');
        
        DateTime dtStart = DateTime.now();
        system.debug ('=========== Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        
        
        //string pageName='PolicyInfoPage';
        //List<Session_data__c> sessionDataList = [select data_name__c, service__c, operation__c, classType__c, refNo__c, session_id__c, page_name__c, data__c, data_request__c from session_data__c where Entity__c = 'AFI' AND service__c = 'getFundDetail' AND Operation__c = 'Fund' order by  sequenceNo__c , order__C];
        
        List<Session_data__c> sessionDataList = [select data_name__c, service__c, operation__c, classType__c, refNo__c, session_id__c, page_name__c, data__c, data_request__c from session_data__c where Entity__c = 'AFI' AND service__c = 'getFundDetail' AND Operation__c = 'Fund' AND session_id__c=:sessionID order by  sequenceNo__c , order__C];
        Session_data__c sessionDataRec = null;
        // select data_name, data from session_data__c where session_id__c='userid-customerid-20170106-abcde12345' and data_name__c='Policy Details' and page_name__c='PolicyInfoPage';
        integer dataNo=0;
        if(sessionDataList.size()>0){
            for(Integer i = 0; i < sessionDataList.size(); i++){  
                sessionDataRec = sessionDataList[i];
                
                sessionID = sessionDataRec.session_id__c;
                
                dataNo=i+1;
                system.debug ('.'); 
                system.debug('== :: DATA NO      : #' + dataNo + ' << ');
                system.debug('== :: SERVICE      : ' + sessionDataRec.service__c);
                system.debug('== :: OPERATION    : ' + sessionDataRec.operation__c);
                system.debug('== :: Entity       : ' + entity);
                system.debug('== :: App          : ' + policyApp);
                system.debug('== :: JSON Request : ' + sessionDataRec.data_request__c);
                

                setJSONVariable(sessionDataRec.service__c +'::'+sessionDataRec.operation__c, sessionDataRec.data__c );
            }           
        }
        
        system.debug ('.');system.debug ('.');system.debug ('.');
        system.debug ('=========== Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        DateTime dtEnd = DateTime.now();
        system.debug ('=========== Finish at   : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        system.debug ('=========== Duration    : ' + d + ' milliseconds'); 
        system.debug ('======= *** Preparing of Page data is Done *** ==================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');
        system.debug ('.');
    }
    
    
    public void setJSONVariable (string code, string value) {
        system.debug('----- mapping for  : ' + code);
        system.debug('----- value        : ' + value);
        
        if (value!= null) {
            // :: getFundDetail
            if (code == 'getFundDetail::Fund') { 
                fundDetailJSON = value;
            }
        }
    }
    //END - EIP FUND INFO (Update 12 April 2020)
    
    
    public ConservationWithdrawal() {
        
        /*this.nilaiConservation = n_Conservation;
        system.debug('this.nilaiConservation: '+ this.nilaiConservation);
        this.nilaiWithdrawal = 0;
        system.debug('this.nilaiWithdrawal: '+ this.nilaiWithdrawal);
        //offeringRetainList = new List<SelectOption>();
        cLine = [SELECT Id, Name, Contact__c, Contact__r.Entity__c, Nilai_Conservation__c, Nilai_Withdrawal__c, Selisih__c, Offering_Retain__c, Call_Status_Config__c, Reason_Status_Config__c FROM Call_Line__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        
        contactId = cLine.Contact__c;*/
    }
    
    private void recalcNewPrice() {
        if(n_Conservation != null && (cLine.Nilai_Conservation__c == null || cLine.Nilai_Conservation__c == 0) && cLine.Nilai_Conservation__c != n_Conservation){ nilaiConservation = n_Conservation; system.debug('nilaiConservation (1): '+ this.nilaiConservation); } 
        else if(n_Conservation != null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0) && cLine.Nilai_Conservation__c != n_Conservation){ nilaiConservation = cLine.Nilai_Conservation__c; system.debug('nilaiConservation (2): '+ this.nilaiConservation); } 
        else if(n_Conservation != null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0) && cLine.Nilai_Conservation__c == n_Conservation){ nilaiConservation = cLine.Nilai_Conservation__c; system.debug('nilaiConservation (3): '+ this.nilaiConservation); } 
        else if(n_Conservation == null && (cLine.Nilai_Conservation__c == null && cLine.Nilai_Conservation__c == 0)){ nilaiConservation = 0; system.debug('nilaiConservation (4): '+ this.nilaiConservation); } 
        else if(n_Conservation == null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0)){ nilaiConservation = cLine.Nilai_Conservation__c; system.debug('nilaiConservation (5): '+ this.nilaiConservation); }
        
        
        selisih = (null == nilaiConservation ? 0 : nilaiConservation) 
                 - (null == nilaiWithdrawal ? 0 : nilaiWithdrawal);
    }
    
    public PageReference save() {
        if(n_Conservation != null && (cLine.Nilai_Conservation__c == null || cLine.Nilai_Conservation__c == 0) && cLine.Nilai_Conservation__c != n_Conservation){ cLine.Nilai_Conservation__c = n_Conservation; system.debug('FINAL nilaiConservation (1): '+ this.nilaiConservation); } 
        else if(n_Conservation != null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0) && cLine.Nilai_Conservation__c != n_Conservation){ cLine.Nilai_Conservation__c = cLine.Nilai_Conservation__c; system.debug('FINAL nilaiConservation (2): '+ this.nilaiConservation); } 
        else if(n_Conservation != null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0) && cLine.Nilai_Conservation__c == n_Conservation){ cLine.Nilai_Conservation__c = cLine.Nilai_Conservation__c; system.debug('FINAL nilaiConservation (3): '+ this.nilaiConservation); } 
        else if(n_Conservation == null && (cLine.Nilai_Conservation__c == null && cLine.Nilai_Conservation__c == 0)){ cLine.Nilai_Conservation__c = 0; system.debug('FINAL nilaiConservation (4): '+ this.nilaiConservation); } 
        else if(n_Conservation == null && (cLine.Nilai_Conservation__c != null && cLine.Nilai_Conservation__c != 0)){ cLine.Nilai_Conservation__c = cLine.Nilai_Conservation__c; system.debug('FINAL nilaiConservation (5): '+ this.nilaiConservation); }
        
        
        //cLine.Nilai_Conservation__c = nilaiConservation;
        cLine.Nilai_Withdrawal__c = nilaiWithdrawal;
        //if(cLine.Call_Status_Config__c == 'Contacted' && cLine.Reason_Status_Config__c.substring(0,5) == 'Agree'){
            cLine.Selisih__c = selisih;
        //} else {
        //    cLine.Selisih__c = 0;
        //}
        cLine.Offering_Retain__c = cLine.Offering_Retain__c;
        
        system.debug('Nilai_Conservation__c: '+cLine.Nilai_Conservation__c);
        system.debug('Nilai_Withdrawal__c: '+cLine.Nilai_Withdrawal__c);
        system.debug('Selisih__c: '+cLine.Selisih__c);
        system.debug('Offering_Retain__c: '+cLine.Offering_Retain__c);
        
        update cLine;
        return new pagereference('/'+cLine.Id);
    }
    
    public PageReference cancel() {
        return new pagereference('/'+cLine.Id);
    }
    
}