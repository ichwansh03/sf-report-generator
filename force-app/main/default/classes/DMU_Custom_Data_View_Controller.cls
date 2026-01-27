public without sharing class DMU_Custom_Data_View_Controller { 
    public String recordTypeSummary = Schema.SObjectType.DMU_Data_Manual__c.getRecordTypeInfosByName().get('Summary Data').getRecordTypeId();
    public List<polishardcopy> phList {get;set;}
    public List<redelivery> redeliveryList {get;set;}
    public List<epolicy> epolicyList {get;set;}
    public List<AXATower> axaTList {get;set;}
    public List<KartuKesehatan> kkList {get;set;}
    public List<suratHardcopy> shList {get;set;}
    public List<eletter> eletterList {get;set;}
    public List<tsHardcopy> tshList {get;set;}
    public List<tsEmail> tseList {get;set;}
    public List<SMS> smsList {get;set;}
    public List<PolicyBTO> BTOJList {get;set;}
    public List<PolicyBTO> BTOJListAll {get;set;}
    public String nextRk {get;set;}
    public String dateConvertStart {get;set;}
    public String dateConvertEnd {get;set;}
    public String job_Id {get;set;}
    
    // Hide field / button, if ContactId terisi.
    public boolean HideField {get;set;}

    public List<DataDetail> DataList {get;set;} 

    public List<DataSummary> phDMUList {get;set;} 
    public List<DataSummary> redDMUList {get;set;} 
    public List<DataSummary> epoDMUList {get;set;} 
    public List<DataSummary> axaDMUList {get;set;} 
    public List<DataSummary> kkDMUList {get;set;} 
    public List<DataSummary> shDMUList {get;set;} 
    public List<DataSummary> eletDMUList {get;set;} 
    public List<DataSummary> tshDMUList {get;set;} 
    public List<DataSummary> tseDMUList {get;set;} 
    public List<DataSummary> smsDMUList {get;set;} 
    public List<DataSummary> btoDMUList {get;set;} 
    public List<DataSummary> SummaryDMUList {get;set;} 
    
    public DMU_Delivery_Status_Daily__c filterdata {get; set;}                    //Filter Data
    //public String filterType {get; set;}                    //Store current selected contactId from I    
    //public String filterSubType {get; set;}                    //Store current selected contactId from I    
    //public String filterStatus {get; set;}                    //Store current selected contactId from I    
    
    public integer countPolishardcopy {get;set;}
    public integer countRedelivery {get;set;}
    public integer countEpolicy {get;set;}
    public integer countAXATower {get;set;}
    public integer countKartuKesehatan {get;set;}
    public integer countsuratHardcopy {get;set;}
    public integer counteletter {get;set;}
    public integer counttsHardcopy {get;set;}
    public integer counttsEmail {get;set;}
    public integer countSMS {get;set;}    
    public integer countBTO {get;set;}    
    
    public List<SelectOption> listOfDataType;                //Store picklist value for Data Type
    public string DataType {get;set;}
    public List<SelectOption> listOfRangeDateType;                //Store picklist value for Data Type
    public string RangeDateType {get;set;}
    public List<SelectOption> listOfPageNumber;                //Store picklist value for Page Number
    
    public boolean ShowData01 {get;set;}
    public boolean ShowData02 {get;set;}
    public boolean ShowData03 {get;set;}
    public boolean ShowData04 {get;set;}
    public boolean ShowData05 {get;set;}
    public boolean ShowData06 {get;set;}
    public boolean ShowData07 {get;set;}
    public boolean ShowData08 {get;set;}
    public boolean ShowData09 {get;set;}
    public boolean ShowData10 {get;set;}
    public boolean ShowData11 {get;set;}
    
    //=========================
    public boolean lockPage {get;set;}
    public MID_Secure_Payment__c cLookup {get; set;} 
    public String firstContactId {get; set;}
    public String paramContactId {get; set;}        
    public String contactEmail {get; set;}
    public String contactMobilePhone {get; set;}
    public String contactName {get; set;}
    public String contactPolicyNo {get; set;}
    public String contactPolicyApp {get; set;}
    public String contactEntity {get; set;}
    public Contact firstContact {get; set;} 
    public String PageNumber {get; set;}
    public String MaxPage {get; set;}
    public boolean RefreshPageNumber {get;set;}
    
    //--Store first contact id
    public void storeContactId() {
        firstContactId = cLookup.Contact__c;
        if(firstContactId != NULL) {
            firstContact = [SELECT Id, Entity__c, Name, Email, MobilePhone, Policy_No__c, Policy_No_PCIDSS__c, PolicyApp__c FROM Contact WHERE Id = :firstContactId LIMIT 1];
            contactEmail = firstContact.Email;
            contactPolicyNo = firstContact.Policy_No_PCIDSS__c; //firstContact.Policy_no__c;
            contactPolicyApp = firstContact.PolicyApp__c;
            contactEntity = firstContact.Entity__c;
            contactMobilePhone = firstContact.MobilePhone;
            contactName = firstContact.Name;
        }
    }
    //=========================
    
    Public string filename {
        get {
            string filename2 = 'File-'+date.today();
            return filename2;
        }
    }
    
    public String xlsHeader {
        get {
            String strHeader = '';
            strHeader += '<?xml version="1.0"?> \n';
            strHeader += '<?mso-application progid="Excel.Sheet"?>';
            return strHeader;
        }
    }
    
    public void hideData() {
        system.debug('filterdata.Type_Doc__c : '+filterdata.Type_Doc__c);
        
        IF (filterdata.Type_Doc__c == NULL) {
            ShowData01 = FALSE;
            ShowData02 = FALSE;
            ShowData03 = FALSE;
            ShowData04 = FALSE;
            ShowData05 = FALSE;
            ShowData06 = FALSE;
            ShowData07 = FALSE;
            ShowData08 = FALSE;
            ShowData09 = FALSE;
            ShowData10 = FALSE;
            ShowData11 = FALSE;                        
        }
        Else {
            ShowData01 = TRUE;
            ShowData02 = TRUE;
            ShowData03 = TRUE;
            ShowData04 = TRUE;
            ShowData05 = TRUE;
            ShowData06 = TRUE;
            ShowData07 = TRUE;
            ShowData08 = TRUE;
            ShowData09 = TRUE;
            ShowData10 = TRUE;
            ShowData11 = TRUE;            
        }
        
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'polis hardcopy') ShowData01 = FALSE;        
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'redelivery') ShowData02 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'epolicy') ShowData03 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'AXA Tower') ShowData04 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'Kartu Kesehatan') ShowData05 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'surat hardcopy') ShowData06 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'e-letter') ShowData07 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'transaction statement (hardcopy)') ShowData08 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'transaction statement (email)') ShowData09 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'SMS') ShowData10 = FALSE;
        if (filterdata.Type_Doc__c != NULL && filterdata.Type_Doc__c != 'Policy BTO') ShowData11 = FALSE;
        
        system.debug('ShowData01 '+ ShowData01);
    }
    
    public DMU_Custom_Data_View_Controller(){    

        filterdata = new DMU_Delivery_Status_Daily__c();
        hideData();
        
        String ExportToExcel = ApexPages.currentPage().getParameters().get('ExportToExcel');
        String ParamDateForm = ApexPages.currentPage().getParameters().get('DateFrom');
        String ParamDateTo = ApexPages.currentPage().getParameters().get('DateTo');
        String ParamDataType = ApexPages.currentPage().getParameters().get('DataType');
        String ParamRangeDateType = ApexPages.currentPage().getParameters().get('RangeDateType');
        String ParamType = ApexPages.currentPage().getParameters().get('Type');
        String PolicyOwner = ApexPages.currentPage().getParameters().get('PolicyOwner');
        if (PageNumber == NULL) PageNumber = '1';
        if (MaxPage == NULL) MaxPage = '1';
        
        
        if (ParamDateForm != NULL) filterdata.Filter_StartDate__c = date.valueof(ParamDateForm);
        if (ParamDateTo != NULL) filterdata.Filter_EndDate__c = date.valueof(ParamDateTo);
        if (ParamDataType != NULL) DataType = ParamDataType;
        if (ParamRangeDateType != NULL) RangeDateType = ParamRangeDateType;
        if (ParamType != NULL) filterdata.Type_Doc__c = ParamType;
        
        if (PolicyOwner != NULL) paramContactId = PolicyOwner;
            
        if (ParamDateForm != NULL || ParamDateTo != NULL || ParamDataType != NULL || ParamRangeDateType != NULL || ParamType != NULL || PolicyOwner != NULL || ExportToExcel == 'TRUE')
        	typeControl();
    }
    
    public void typeControl() {
        System.debug('DataType ' +DataType);
        ApexPages.getMessages().clear();
        string validate = 'FALSE';
        // validation Date, only 3 Month
        if (filterdata.Filter_StartDate__c != NULL) {
            if (filterdata.Filter_EndDate__c == NULL) validate = 'TRUE';

            integer range =  filterdata.Filter_StartDate__c.daysBetween(filterdata.Filter_EndDate__c);
            if (range > 90) {
	            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Range Date must under 90 Days, Please change the date!'));
				validate = 'TRUE';
            }
                
        }
        RefreshPageNumber = FALSE;
        if (validate == 'FALSE') {            
            if(DataType == 'Detail') getdataDetail();
            else if (DataType == 'Summary') getdataSummery();
        }
    }
    
    public void getdataSummery(){
        String fieldDate = '';
        String queryRange = '';
        if(RangeDateType == null){
            queryRange = '';
            fieldDate = '';
        }
        if(RangeDateType == 'Daily'){
            queryRange = ',DMU_Date__c '; 
            fieldDate = 'DMU_Date__c,';
        } 
        if(RangeDateType == 'Monthly'){
            queryRange = ', DMU_Date_Monthly__c';
            fieldDate = 'DMU_Date_Monthly__c,';
        } 
        System.debug('RangeDateType ' +RangeDateType);
        
        //filter date
        string filterDate = '';
        //String dateConvertStart = '';
        //String dateConvertEnd = '';
        dateConvertStart = '';
        dateConvertEnd = '';

        if(filterdata.Filter_StartDate__c != NULL){
            dateConvertStart = String.valueOf(filterdata.Filter_StartDate__c).remove(' 00:00:00');
            dateConvertStart = dateConvertStart.remove('-');
        }
        if(filterdata.Filter_EndDate__c != NULL){
            dateConvertEnd = String.valueOf(filterdata.Filter_EndDate__c).remove(' 00:00:00');
            dateConvertEnd = dateConvertEnd.remove('-');
        }
        if (filterdata.Filter_StartDate__c != NULL && filterdata.Filter_EndDate__c != NULL){
            filterDate = ' AND DMU_Date__c >= \'' +dateConvertStart +'\' AND DMU_Date__c <= \'' +dateConvertEnd +'\' ' ;
        } 
        else if (filterdata.Filter_StartDate__c != NULL && filterdata.Filter_EndDate__c == NULL){
            filterDate = ' AND DMU_Date__c = \'' +dateConvertStart +'\' ' ;
        } 
        else if (filterdata.Filter_StartDate__c == NULL && filterdata.Filter_EndDate__c != NULL){
            filterDate = ' AND DMU_Date__c = \'' +dateConvertEnd +'\' ' ;
        } 
        else {
            filterDate = ' ';
        }
        System.debug('filterDate ' +filterDate);
        
        string queryStr = '';

        string PARAM_SOURCE = 'SFDC';
        string PARAM_REQUEST_ID = '1234567890';
        String PARAM_TYPE = 'ALL'; // ALL, Hardcopy Policy, Redelivery, e-Policy, AXA Tower, Kartu Kesehatan, Surat Hardcopy, e-Letter, Transaction Statement – Hardcopy, Transaction Statement - Email SMS, SMS, Data Gudang
        String VALID_FROM_DTTM = dateConvertStart; //'20210601'; //'20210706'
        String VALID_TO_DTTM = dateConvertEnd; //'20210901'; //'20210707'
        String POLICY_NO = ''; //'520-3069546';
        String PAGE_NUMBER = PageNumber; // 1, 2, 3, 4, ...
        
        // == polis hardcopy ==
        if(ShowData01){

	        PARAM_TYPE = 'Hardcopy Policy';
            
            phDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = phDMUList;
        }
        
        // == redelivery (redel) ==
        if(ShowData02){
	        PARAM_TYPE = 'Redelivery';
            
            redDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
			SummaryDMUList = redDMUList;
        }
        
        // == epolicy ==
        if(ShowData03){
	        PARAM_TYPE = 'e-Policy';
            
            epoDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = epoDMUList;
        }
        
        // == AXA Tower ==
        if(ShowData04){
	        PARAM_TYPE = 'AXA Tower';
            
            axaDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = axaDMUList;
        }
        
        // == Kartu Kesehatan ==
        if(ShowData05){
	        PARAM_TYPE = 'Kartu Kesehatan';
            
            kkDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = kkDMUList;
        }
        
        // == surat hardcopy ==
        if(ShowData06){
	        PARAM_TYPE = 'Surat Hardcopy';
            
            shDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = shDMUList;
        }
        
        // == e-letter ==
        if(ShowData07){
	        PARAM_TYPE = 'e-Letter';
            
            eletDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType); 
            SummaryDMUList = eletDMUList;
        }
        
        // == transaction statement (hardcopy) ==
        if(ShowData08){
	        //PARAM_TYPE = 'Transaction Statement – Hardcopy';
	        PARAM_TYPE = 'Transaction Statement - Hardcopy';
            
            tshDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = tshDMUList;
        }
        
        // == transaction statement (email) ==
        if(ShowData09){
	        PARAM_TYPE = 'Transaction Statement - Email SMS';
            
            tseDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = tseDMUList;
        }
        
        // == SMS ==
        if(ShowData10){
	        PARAM_TYPE = 'SMS';
            
            smsDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = smsDMUList;
        }
        
        // == Policy BTO ==
        if(ShowData11){
	        PARAM_TYPE = 'Data Gudang';
            
            btoDMUList = getDataSummary (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, RangeDateType);
            SummaryDMUList = btoDMUList;
        }
    }
    
    public void getdataDetail() {
        
        countPolishardcopy = 0;
        countRedelivery = 0;
        countEpolicy = 0;
        countAXATower = 0;
        countKartuKesehatan = 0;
        countsuratHardcopy = 0;
        counteletter = 0;
        counttsHardcopy = 0;
        counttsEmail = 0;
        countSMS = 0;
        countBTO = 0;
        
        //======================
        paramContactId = ApexPages.currentPage().getParameters().get('contactID');
        if (paramContactId != '' && paramContactId != NULL)  DataType = 'Detail';
        if (paramContactId != '' && paramContactId != NULL)  lockPage = TRUE;
        
        //filterdata = new DMU_Delivery_Status_Daily__c();
        hideData();
        
        cLookup = new MID_Secure_Payment__c();
        if(String.isNotEmpty(paramContactId)) {
            cLookup.Contact__c = paramContactId;
            storeContactId();
        }
        //======================
        
        //filter date
        string filterDate = '';
        //String dateConvertStart = '';
        //String dateConvertEnd = '';
        dateConvertStart = '';
        dateConvertEnd = '';
        if(filterdata.Filter_StartDate__c != NULL){
            dateConvertStart = String.valueOf(filterdata.Filter_StartDate__c).remove(' 00:00:00');
            dateConvertStart = dateConvertStart.remove('-');
        }
        if(filterdata.Filter_EndDate__c != NULL){
            dateConvertEnd = String.valueOf(filterdata.Filter_EndDate__c).remove(' 00:00:00');
            dateConvertEnd = dateConvertEnd.remove('-');
        }
        if (filterdata.Filter_StartDate__c != NULL && filterdata.Filter_EndDate__c != NULL){
            filterDate = ' AND DMU_Date__c >= \'' +dateConvertStart +'\' AND DMU_Date__c <= \'' +dateConvertEnd +'\' ' ;
        } 
        else if (filterdata.Filter_StartDate__c != NULL && filterdata.Filter_EndDate__c == NULL){
            filterDate = ' AND DMU_Date__c = \'' +dateConvertStart +'\' ' ;
        } 
        else if (filterdata.Filter_StartDate__c == NULL && filterdata.Filter_EndDate__c != NULL){
            filterDate = ' AND DMU_Date__c = \'' +dateConvertEnd +'\' ' ;
        } 
        else {
            filterDate = ' ';
        }
        System.debug('filterDate ' +filterDate);
        system.debug('#dateConvertStart : '+dateConvertStart);
        system.debug('#dateConvertEnd : '+dateConvertEnd);
        system.debug('#contactPolicyNo : '+contactPolicyNo);
        
        //coba mus
        DescribeSObjectResult drx = DMU_Data_Manual__c.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(drx.fields.getMap().keySet());
        String fields = String.join(fieldList, ',');
        string queryStr = '';
        //coba mus

        string PARAM_SOURCE = 'SFDC';
        string PARAM_REQUEST_ID = '1234567890';
        String PARAM_TYPE = 'ALL';
        String VALID_FROM_DTTM = dateConvertStart;//'20210706';
        String VALID_TO_DTTM = dateConvertEnd;//'20210707';
        //String POLICY_NO = '100-402-0258446'; //'100-712-0935817'; //'100-122-3346529';//'123-4567890'; //'520-3069546'
        String POLICY_NO = contactPolicyNo;//'100-122-3346529';
        String PAGE_NUMBER = PageNumber; // 1, 2, 3, 4, ...
        system.debug('#Page_Numnber : '+PAGE_NUMBER);

        system.debug('#Start Show Data - '+POLICY_NO);
        // == polis hardcopy ==
        if(ShowData01){
                    
	        PARAM_TYPE = 'Hardcopy Policy';
            
            system.debug('#Start GetDataList');
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);
            system.debug('#End GetDataList : '+GetDataList);
            
            phList = new list<polishardcopy>();
			if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countPolishardcopy += 1;
                
                polishardcopy newdata = new polishardcopy();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglPickUp = ddm1.courier_pickup_dt; 
                newdata.Status = ddm1.courier_delivery_status;
                newdata.NamaPenerima = ddm1.courier_receiver_name; 
                newdata.TglTerima = ddm1.courier_receive_dt; 
                newdata.TglRetur = ddm1.courier_retur_dt;
                newdata.KeteranganRetur = ddm1.courier_retur_note;
                newdata.Kurir = ddm1.courier_courier_name;
                newdata.Resi = ddm1.courier_awb_no;
                newdata.Alamat = ddm1.courier_address;
                newdata.Note = ddm1.courier_note;
                
                phList.add(newdata);
            }
                        
        }
        
        // == redelivery (redel) ==
        if(ShowData02){

	        PARAM_TYPE = 'Redelivery';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            redeliveryList = new list<redelivery>();
			if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countRedelivery += 1;
                
                redelivery newdata = new redelivery();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglPickUp = ddm1.courier_pickup_dt; 
                newdata.Status = ddm1.courier_delivery_status;
                newdata.NamaPenerima = ddm1.courier_receiver_name; 
                newdata.TglTerima = ddm1.courier_receive_dt; 
                newdata.TglRetur = ddm1.courier_retur_dt;
                newdata.KeteranganRetur = ddm1.courier_retur_note;
                newdata.Kurir = ddm1.courier_courier_name;
                newdata.Resi = ddm1.courier_awb_no;
                newdata.Alamat = ddm1.courier_address;
                newdata.Note = ddm1.courier_note;
                
                redeliveryList.add(newdata);
            }

        }
                
        // == epolicy ==
        if(ShowData03){
	        PARAM_TYPE = 'e-Policy';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            epolicyList = new list<epolicy>();
			if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countEpolicy += 1;
                
                epolicy newdata = new epolicy();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglKirim = ddm1.courier_receive_dt; 
                newdata.StatusEmail = ddm1.email_email_status;
                newdata.TglDownloadEmail = ddm1.email_download_dt; 
                newdata.StatusSMS  = ddm1.sms_sms_status; 
                newdata.TglDownloadSMS = ddm1.sms_download_dt;
                newdata.ExpiredLink = ddm1.linkExpired_dt;
                newdata.Email = ddm1.email_email_address;
                newdata.NoHP = ddm1.sms_phone_number;
                newdata.TglIssued = ddm1.issue_dt;
                newdata.TipePengiriman = ddm1.delivery_method;
                newdata.email_delivery_dt = ddm1.email_delivery_dt;
				newdata.sms_delivery_dt = ddm1.sms_delivery_dt;
                
                epolicyList.add(newdata);
            }

        }
                
        // == AXA Tower ==
        if(ShowData04){
	        PARAM_TYPE = 'AXA Tower';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            axaTList = new list<AXATower>();
			if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countAXATower += 1;
                
                AXATower newdata = new AXATower();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglPickUp = ddm1.courier_pickup_dt; 
                newdata.Status = ddm1.courier_delivery_status;
                newdata.NamaPenerima = ddm1.courier_receiver_name; 
                newdata.TglTerima = ddm1.courier_receive_dt; 
                newdata.TglRetur = ddm1.courier_retur_dt;
                newdata.KeteranganRetur = ddm1.courier_retur_note;
                newdata.Kurir = ddm1.courier_courier_name;
                newdata.Resi = ddm1.courier_awb_no;
                newdata.Alamat = ddm1.courier_address;
                newdata.Note = ddm1.courier_note;
                
                axaTList.add(newdata);
            }

        }
                
        // == Kartu Kesehatan ==
        if(ShowData05){
	        PARAM_TYPE = 'Kartu Kesehatan';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            kkList = new list<KartuKesehatan>();
			if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countKartuKesehatan += 1;
                
                KartuKesehatan newdata = new KartuKesehatan();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglPickUp = ddm1.courier_pickup_dt; 
                newdata.Status = ddm1.courier_delivery_status;
                newdata.NamaPenerima = ddm1.courier_receiver_name; 
                newdata.TglTerima = ddm1.courier_receive_dt; 
                newdata.TglRetur = ddm1.courier_retur_dt;
                newdata.KeteranganRetur = ddm1.courier_retur_note;
                newdata.Kurir = ddm1.courier_courier_name;
                newdata.Resi = ddm1.courier_awb_no;
                newdata.Alamat = ddm1.courier_address;
                newdata.Note = ddm1.courier_note;
                
                kkList.add(newdata);
            }

        }
                
        // == surat hardcopy ==
        if(ShowData06){
	        PARAM_TYPE = 'Surat Hardcopy';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            shList = new list<suratHardcopy>();
			if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countsuratHardcopy += 1;
                
                suratHardcopy newdata = new suratHardcopy();

                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglPickUp = ddm1.courier_pickup_dt; 
                newdata.Status = ddm1.courier_delivery_status;
                newdata.NamaPenerima = ddm1.courier_receiver_name; 
                newdata.TglTerima = ddm1.courier_receive_dt; 
                newdata.TglRetur = ddm1.courier_retur_dt;
                newdata.KeteranganRetur = ddm1.courier_retur_note;
                newdata.Kurir = ddm1.courier_courier_name;
                newdata.Resi = ddm1.courier_awb_no;
                newdata.Alamat = ddm1.courier_address;
                newdata.JenisSurat = ddm1.document_type;
                
                shList.add(newdata);
            }

        }
                
        // == e-letter ==
        if(ShowData07){
	        PARAM_TYPE = 'e-Letter';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            eletterList = new list<eletter>();
			if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                counteletter += 1;
                
                eletter newdata = new eletter();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglKirim = ddm1.courier_receive_dt; 
                newdata.StatusEmail = ddm1.email_email_status;
                newdata.TglDownloadEmail = ddm1.email_download_dt; 
                newdata.StatusSMS  = ddm1.sms_sms_status; 
                newdata.TglDownloadSMS = ddm1.sms_download_dt;
                newdata.Email = ddm1.email_email_address;
                newdata.NoHP = ddm1.sms_phone_number;
                newdata.JenisEletter = ddm1.document_type;
                newdata.email_delivery_dt = ddm1.email_delivery_dt;
				newdata.sms_delivery_dt = ddm1.sms_delivery_dt;
                
                eletterList.add(newdata);

            }
        }
        
        
        // == transaction statement (hardcopy) ==
        if(ShowData08){
	        //PARAM_TYPE = 'Transaction Statement – Hardcopy';
            PARAM_TYPE = 'Transaction Statement - Hardcopy';

            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            tshList = new list<tsHardcopy>();
            if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                counttsHardcopy += 1;
                
                tsHardcopy newdata = new tsHardcopy();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglPickUp = ddm1.courier_pickup_dt;
                newdata.Status = ddm1.courier_delivery_status;
                newdata.NamaPenerima = ddm1.courier_receiver_name; 
                newdata.TglTerima = ddm1.courier_receive_dt; 
                newdata.TglRetur = ddm1.courier_retur_dt;
                newdata.KeteranganRetur = ddm1.courier_retur_note;
                newdata.Kurir = ddm1.courier_courier_name;
                newdata.Resi = ddm1.courier_awb_no;
                newdata.Alamat = ddm1.courier_address;
                
                tshList.add(newdata);

            }
        }
               
        // == transaction statement (email) ==
        if(ShowData09){
	        PARAM_TYPE = 'Transaction Statement - Email SMS';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            tseList = new list<tsEmail>();
            if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                counttsEmail += 1;
                
                tsEmail newdata = new tsEmail();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.holder_name;
                newdata.TglKirim = ddm1.courier_receive_dt; 
                newdata.StatusEmail = ddm1.email_email_status;
                newdata.TglDownloadEmail = ddm1.email_download_dt; 
                newdata.StatusSMS  = ddm1.sms_sms_status; 
                newdata.TglDownloadSMS = ddm1.sms_download_dt;
                newdata.Email = ddm1.email_email_address;
                newdata.NoHP = ddm1.sms_phone_number;
                newdata.TglIssued = ddm1.issue_dt;
                newdata.email_delivery_dt = ddm1.email_delivery_dt;
				newdata.sms_delivery_dt = ddm1.sms_delivery_dt;
                
                tseList.add(newdata);

            }
        }
        
        
        // == SMS ==
        if(ShowData10){
	        PARAM_TYPE = 'SMS';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            smsList = new list<SMS>();
            if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countSMS += 1;
                
                SMS newdata = new SMS();
                newdata.policy_no = ddm1.policy_number; 
                newdata.JenisSMS = ddm1.document_type;
                newdata.TglKirim = ddm1.sms_delivery_dt; //ddm1.courier_receive_dt; 
                newdata.Status = ddm1.sms_sms_status; //ddm1.courier_delivery_status;
                newdata.Dept = ddm1.sms_issueTypeCD; //'tidak ada';//ddm10.Divisionname__c; 
                newdata.NoHP  = ddm1.sms_phone_number; 
                
                smsList.add(newdata);

            }
        }
                
        // == Policy BTO ==
        if(ShowData11){
	        PARAM_TYPE = 'Data Gudang';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetailBTO (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);            
            
            BTOJList = new list<PolicyBTO>();
            if (GetDataList != NULL)
            for (DataDetail ddm1 : GetDataList){
                countBTO += 1;
                
                PolicyBTO newdata = new PolicyBTO();
                newdata.policy_no = ddm1.policy_number; 
                newdata.Consignee = ddm1.warehouse_receiverName; //ddm1.holder_name;
                newdata.ShipDate = ddm1.warehouse_bto_dt; //courier_receive_dt; 
                newdata.TrackingStatus = ddm1.warehouse_btoSource; //courier_delivery_status;
                newdata.Recipient = ''; //courier_receiver_name; 
                newdata.DatePickUp = ddm1.warehouse_pickup_dt; //courier_pickup_dt; 
                newdata.ReturnDate = ddm1.warehouse_return_dt; //courier_retur_dt;
                newdata.ReturnReason = ddm1.courier_retur_note; //courier_retur_note;
                newdata.ServiceBy = ddm1.warehouse_courierName; //courier_courier_name;
                newdata.AWB = ddm1.warehouse_awb_no; //courier_awb_no;
                newdata.ConsigneeAddress = ddm1.warehouse_custodylocation; //courier_address;
                newdata.warehouse_outbound_dt = ddm1.warehouse_outbound_dt;
				newdata.warehouse_outboundDestination = ddm1.warehouse_outboundDestination;
                newdata.warehouse_boxFilling_no = ddm1.warehouse_boxFilling_no;
                newdata.warehouse_picName = ddm1.warehouse_picName;
                newdata.policyTypeCode = ddm1.policyTypeCode;
                newdata.warehouse_type = ddm1.warehouse_type;
                
                BTOJList.add(newdata);

            }
        }
        // Refresh Picklist
        RefreshPageNumber = TRUE;
        getListOfPageNumber();

    }
    
    public Pagereference CheckJob(){
        
        // Query AsyncApexJob
        if (job_Id != NULL) {
            AsyncApexJob jobList = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors, ExtendedStatus FROM AsyncApexJob Where Id = :job_Id];
            
            ApexPages.getMessages().clear();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Status Job : '+jobList.Status+'; Job Process : '+jobList.JobItemsProcessed+' of '+jobList.TotalJobItems+ '; Error : '+jobList.NumberOfErrors+'; ErrorMessage : '+jobList.ExtendedStatus ));
            
        }
        
        Return null;
    }

    public Pagereference ExportAllBTO(){
        
        ApexPages.getMessages().clear();
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Export Success!!!'));
        String instanceName = URL.getSalesforceBaseUrl().toExternalForm();
            
        String reportDevName = 'DMU_Policy_BTO';
        List <Report> reportList = [SELECT Id,DeveloperName,Name FROM Report where DeveloperName =:reportDevName];
        
        if (!Test.isRunningTest()) return new Pagereference(instanceName+'/'+reportList[0].id+'?excel=1&isdtp=p1');
        //if (!Test.isRunningTest()) return new Pagereference(instanceName+'/apex/DMU_Custom_Data_ExportToExcel_DBTO?id='+reportList[0].id+'&fileName=data_gudang');
		return null;
    }
    
    public Pagereference SendAll(){
        ApexPages.getMessages().clear();
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Data will Generate, please wait several minute. or Click "Check Status Jobs" to get more information.'));
        
        Id OwnerId = UserInfo.getUserId();

        // Delete Old Data.
        List<DMU_Data_Manual__c> DataBTO = [SELECT id FROM DMU_Data_Manual__c WHERE OwnerId =: OwnerId];
        if (DataBTO.size() > 0) delete DataBTO;

		// looping callout via Batch
        list<string> Parameter = new list<string>();
        for (integer i = 1; i <= integer.valueof(MaxPage); i++) {
            // OwnerID,20210706,20210707,1
            String DataPage = ''+OwnerId+','+dateConvertStart+','+dateConvertEnd+','+i;
            Parameter.add(DataPage);
        }
		        
        DMU_Custom_Data_Batch jb = new DMU_Custom_Data_Batch(parameter);
        job_Id = Database.executeBatch(jb, 1);

        return null;
    }
    
    public Pagereference exportAll(){
        if (DataType == 'Detail') {
            if (!Test.isRunningTest() && ShowData01) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D01?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData02) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D02?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData03) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D03?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData04) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D04?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData05) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D05?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData06) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D06?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData07) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D07?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData08) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D08?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData09) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D09?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData10) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D10?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
            if (!Test.isRunningTest() && ShowData11) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_D11?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);            
        }

        system.debug('ShowData01 : '+ShowData01);
        system.debug('ShowData02 : '+ShowData02);
        system.debug('ShowData03 : '+ShowData03);
        system.debug('ShowData04 : '+ShowData04);
        system.debug('ShowData05 : '+ShowData05);
        system.debug('ShowData06 : '+ShowData06);
        system.debug('ShowData07 : '+ShowData07);
        system.debug('ShowData08 : '+ShowData08);
        system.debug('ShowData09 : '+ShowData09);
        system.debug('ShowData10 : '+ShowData10);
        system.debug('ShowData11 : '+ShowData11);
        system.debug('filterdata.Filter_StartDate__c : '+filterdata.Filter_StartDate__c);
        system.debug('filterdata.Filter_EndDate__c : '+filterdata.Filter_EndDate__c);
        system.debug('DataType : '+DataType);
        system.debug('RangeDateType : '+RangeDateType);
        system.debug('filterdata.Type_Doc__c : '+filterdata.Type_Doc__c);
        //system.debug('cLookup.Contact__c : '+cLookup.Contact__c);
                
        //if (!Test.isRunningTest() && DataType == 'Summary' && (ShowData01 || ShowData02 || ShowData04 || ShowData05 || ShowData06 || ShowData08 || ShowData11)) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_S01?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
        //if (!Test.isRunningTest() && DataType == 'Summary' && (ShowData03 || ShowData07 || ShowData09 || ShowData10)) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_S02?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c+'&PolicyOwner='+cLookup.Contact__c);
        if (!Test.isRunningTest() && DataType == 'Summary' && (ShowData01 || ShowData02 || ShowData04 || ShowData05 || ShowData06 || ShowData08 || ShowData11)) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_S01?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c);
        if (!Test.isRunningTest() && DataType == 'Summary' && (ShowData03 || ShowData07 || ShowData09 || ShowData10)) return new Pagereference('/apex/DMU_Custom_Data_ExportToExcel_S02?ExportToExcel=TRUE&DateFrom='+filterdata.Filter_StartDate__c+'&DateTo='+filterdata.Filter_EndDate__c+'&DataType='+DataType+'&RangeDateType='+RangeDateType+'&Type='+filterdata.Type_Doc__c);

        return null;
    }
    
    public Pagereference reset(){
        contactPolicyNo = null;
        contactPolicyApp = null;
        contactEntity = null;
        filterdata.Filter_StartDate__c = null;
        filterdata.Filter_EndDate__c = null;
        RangeDateType = '--None--';
        typeControl();
        return null;
    }
    
    //--Generate picklist Data type
    public List<SelectOption> getListOfDataType() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('0', '--None--'));
        string checkparamContactId = ApexPages.currentPage().getParameters().get('contactID');
        if (checkparamContactId == NULL)
        tempList.add(new SelectOption('Summary', 'Summary'));
        tempList.add(new SelectOption('Detail', 'Detail'));
        return tempList;
    }
    
    public List<SelectOption> getListOfRangeDateType() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('0', '--None--'));
        tempList.add(new SelectOption('Daily', 'Daily'));
        tempList.add(new SelectOption('Monthly', 'Monthly'));
        return tempList;
    }

    //--Generate picklist Page Number
    public List<SelectOption> getListOfPageNumber() {
        List<SelectOption> tempList = new List<SelectOption>();
        //tempList.add(new SelectOption('1', '1'));

        if (MaxPage != NULL)
            for (integer i = 1; i <= integer.valueof(MaxPage); i++){
                tempList.add(new SelectOption(''+i, ''+i));
            } 
        
        return tempList;
    }
    
    public class DataSummary{
        public string DateText {get; set;}
        public string Type_Doc {get; set;}
        public string OK {get; set;}
        public string Return_Docs {get; set;}
        public string Total_Documents {get; set;}
        public string Success {get; set;}
        public string Not_Success {get; set;}
        public string Last_Sync {get; set;}
        public string InProgress {get; set;}
        public string deliveredEmail {get; set;}
        public string undeliveredEmail {get; set;}
        public string nonemail {get; set;}
        public string nonSMS {get; set;}
        public string undeliveredSMS {get; set;}
        public string deliveredSMS {get; set;}
        
        public DataSummary(){
        }       
    }

    public class DataDetail{
        
        public string edmu_type {get; set;}
        public string policy_number {get; set;}
        public string holder_name {get; set;}
        public string linkExpired_dt {get; set;}
        public string issue_dt {get; set;}
        public string delivery_method {get; set;}
        public string document_type {get; set;}
        public string courier_delivery_status {get; set;}
        public string courier_courier_name {get; set;}
        public string courier_awb_no {get; set;}
        public string courier_receiver_name {get; set;}
        public string courier_address {get; set;}
        public string courier_pickup_dt {get; set;}
        public string courier_receive_dt {get; set;}
        public string courier_retur_dt {get; set;}
        public string courier_retur_note {get; set;}
        public string courier_note {get; set;}
        public string sms_phone_number {get; set;}
        public string sms_delivery_dt {get; set;}
        public string sms_download_dt {get; set;}
        public string sms_sms_status {get; set;}
        public string email_email_address {get; set;}
        public string email_delivery_dt {get; set;}
        public string email_download_dt {get; set;}
        public string email_email_status {get; set;}

        public string policyTypeCode {get; set;}
        public string warehouse_awb_no {get; set;}
        public string warehouse_courierName {get; set;}
        public string warehouse_type {get; set;}
        public string warehouse_pickup_dt {get; set;}
        public string warehouse_return_dt {get; set;}
        public string warehouse_receiverName {get; set;}
        public string warehouse_btoSource {get; set;}
        public string warehouse_bto_dt {get; set;}
        public string warehouse_custodyLocation {get; set;}
        public string warehouse_outbound_dt {get; set;}
        public string warehouse_outboundDestination {get; set;}
        public string warehouse_boxFilling_no {get; set;}
        public string warehouse_picName {get; set;}
        public string sms_issueTypeCD {get; set;}
        
        public DataDetail(){
        }
    }
    
    public class polishardcopy{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglPickUp {get; set;}
        public string Status {get; set;}
        public string NamaPenerima {get; set;}
        public string TglTerima {get; set;}
        public string TglRetur {get; set;}
        public string KeteranganRetur {get; set;}
        public string Kurir {get; set;}
        public string Resi {get; set;}
        public string Alamat {get; set;}
        public string Note {get; set;}
        
        public polishardcopy(){
        }
    }
    
    public class redelivery{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglPickUp {get; set;}
        public string Status {get; set;}
        public string NamaPenerima {get; set;}
        public string TglTerima {get; set;}
        public string TglRetur {get; set;}
        public string KeteranganRetur {get; set;}
        public string Kurir {get; set;}
        public string Resi {get; set;}
        public string Alamat {get; set;}
        public string Note {get; set;}
        
        public redelivery(){
        }       
    }
    
    public class epolicy{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglKirim {get; set;}
        public string StatusEmail {get; set;}
        public string TglDownloadEmail {get; set;}
        public string StatusSMS {get; set;}
        public string TglDownloadSMS {get; set;}
        public string ExpiredLink {get; set;}
        public string Email {get; set;}
        public string NoHP {get; set;}
        public string TglIssued {get; set;}
        public string TipePengiriman {get; set;}
        public string sms_delivery_dt {get; set;}
        public string email_delivery_dt {get; set;}
        
        public epolicy(){
        }       
    }
    
    public class AXATower{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglPickUp {get; set;}
        public string Status {get; set;}
        public string NamaPenerima {get; set;}
        public string TglTerima {get; set;}
        public string TglRetur {get; set;}
        public string KeteranganRetur {get; set;}
        public string Kurir {get; set;}
        public string Resi {get; set;}
        public string Alamat {get; set;}
        public string Note {get; set;}
        
        public AXATower(){
        }
    }
    
    public class KartuKesehatan{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglPickUp {get; set;}
        public string Status {get; set;}
        public string NamaPenerima {get; set;}
        public string TglTerima {get; set;}
        public string TglRetur {get; set;}
        public string KeteranganRetur {get; set;}
        public string Kurir {get; set;}
        public string Resi {get; set;}
        public string Alamat {get; set;}
        public string Note {get; set;}
        
        public KartuKesehatan(){
        }       
    }
    
    public class suratHardcopy{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglPickUp {get; set;}
        public string Status {get; set;}
        public string NamaPenerima {get; set;}
        public string TglTerima {get; set;}
        public string TglRetur {get; set;}
        public string KeteranganRetur {get; set;}
        public string Kurir {get; set;}
        public string Resi {get; set;}
        public string Alamat {get; set;}
        public string JenisSurat {get; set;}
        
        public suratHardcopy(){
        }
    }
    
    public class eletter{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglKirim {get; set;}
        public string StatusEmail {get; set;}
        public string TglDownloadEmail {get; set;}
        public string StatusSMS {get; set;}
        public string TglDownloadSMS {get; set;}
        public string Email {get; set;}
        public string NoHP {get; set;}
        public string JenisEletter {get; set;}
        public string sms_delivery_dt {get; set;}
        public string email_delivery_dt {get; set;}
        
        public eletter(){
        }
    }
    
    public class tsHardcopy{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglPickUp {get; set;}
        public string Status {get; set;}
        public string NamaPenerima {get; set;}
        public string TglTerima {get; set;}
        public string TglRetur {get; set;}
        public string KeteranganRetur {get; set;}
        public string Kurir {get; set;}
        public string Resi {get; set;}
        public string Alamat {get; set;}
        
        public tsHardcopy(){
        }
    }
    
    public class tsEmail{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string TglKirim {get; set;}
        public string StatusEmail {get; set;}
        public string  TglDownloadEmail {get; set;}
        public string StatusSMS {get; set;}
        public string TglDownloadSMS {get; set;}
        public string Email {get; set;}
        public string NoHP {get; set;}
        public string TglIssued {get; set;}
        public string sms_delivery_dt {get; set;}
        public string email_delivery_dt {get; set;}
        
        public tsEmail(){
        }
    }
    
    public class SMS{
        public string policy_no {get; set;}
        public string JenisSMS {get; set;}
        public string TglKirim {get; set;}
        public string Status {get; set;}
        public string Dept {get; set;}
        public string NoHP {get; set;}
        
        public SMS(){
        }
    }
    
    public class PolicyBTO{
        public string policy_no {get; set;}
        public string Consignee {get; set;}
        public string ShipDate {get; set;}
        public string TrackingStatus {get; set;}
        public string Recipient {get; set;}
        public string DatePickUp {get; set;}
        public string ReturnDate {get; set;}
        public string ReturnReason {get; set;}
        public string ServiceBy {get; set;}
        public string AWB {get; set;}
        public string ConsigneeAddress {get; set;}
        public string warehouse_outbound_dt {get; set;}
        public string warehouse_outboundDestination {get; set;}
        public string warehouse_boxFilling_no {get; set;}
        public string warehouse_picName {get; set;}
        public string policyTypeCode {get; set;}
		public string warehouse_type {get; set;}
        
        public PolicyBTO(){
        }
    }
    
    public list<DataSummary> getDataSummary (string PARAM_SOURCE, string PARAM_REQUEST_ID, String PARAM_TYPE, String VALID_FROM_DTTM, String VALID_TO_DTTM, String POLICY_NO, String RangeDateType) { 
            // Code EIP Connector - Summary
            try {
                Map<String,String> params = new Map<String, String>();
                params.put(EIPConstant.PARAM_SOURCE, PARAM_SOURCE); // 'SFDC'
                system.debug('#PARAM_SOURCE : '+ PARAM_SOURCE);
                IF (RangeDateType == 'Daily')
                    params.put(EIPConstant.PARAM_RESULT_GROUP, EIPConstant.PARAM_RESULT_GROUP_DAILY);
                else
                	params.put(EIPConstant.PARAM_RESULT_GROUP, EIPConstant.PARAM_RESULT_GROUP_MONTHLY);
                system.debug('#RangeDateType : '+ RangeDateType);
                params.put(EIPConstant.PARAM_REQUEST_ID, PARAM_REQUEST_ID); // '1234567890'
                system.debug('#PARAM_REQUEST_ID : '+ PARAM_REQUEST_ID);
                params.put(EIPConstant.PARAM_TYPE, PARAM_TYPE); // 'ALL'
                system.debug('#PARAM_TYPE : '+ PARAM_TYPE);
                params.put(EIPConstant.VALID_FROM_DTTM, VALID_FROM_DTTM); // dateConvertStart // yyyymmdd 20210901
                system.debug('#VALID_FROM_DTTM : '+ VALID_FROM_DTTM);
                params.put(EIPConstant.VALID_TO_DTTM, VALID_TO_DTTM); // dateConvertEnd // yyyymmdd
                system.debug('#VALID_TO_DTTM : '+ VALID_TO_DTTM);
                
                EIPJson edmuSummaryJson;
                if (!Test.isRunningTest())
                	edmuSummaryJson = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_SUMMARY, EIPConstant.ENTITY_AMFS, EIPConstant.APP_EDMU, POLICY_NO, params); // '520-3069546'

                //'EIPJson:[Body=EIP_Body:[AXAAsiaPagination_Type=null, AgSa_InsurancePolicy_Type=null, Customer=null, IcAx_AXAAsiaCustomer_Type=EIP_IcAx_AXAAsiaCustomer:[canBeIndividual=null, customerClassCD=null, customerID=null, customerRK=null, customerTypeCD=null, dependentNO=null, documentID=null, hasNameValue=null, hasPolicyAccount=(EIP_AgSa_InsurancePolicy:[applicationRk=null, assignmentFlg=null, bonusAmt=null, bonusReserveAmt=null, bonusReservesAmt=null, certificateNo=null, currencyCD=null, dividendAccumRt=null, dividentAccumRt=null, ePolicy=null, financialFundRk=null, forLifeUnitofExposure=null, generalRk=null, grossAnnualPremiumAmt=null, hasAXAAsiaPolicyPaymentAccount=null, hasAccountDetailsIn=null, hasApplicationDetailsIn=null, hasBilling=null, hasCustomerInformationIn=null, hasDetailsOfClaimIn=null, hasDetailsOfGIRisksIn=null, hasDetailsOfPolicyIn=null, hasDetailsOfPolicyTransactionIn=null, hasDetailsOfRisksIn=null, hasDetailsRecordIn=null, hasGIPolicyEndorsementIn=null, hasLifePolicyChangeTransDetailsIn=null, hasLifePolicyTransactionDetailsIn=null, hasNameValue=(EIP_AgSa_NameValue:[name=inProgress, value=2], EIP_AgSa_NameValue:[name=ok, value=19], EIP_AgSa_NameValue:[name=returnDocs, value=0], EIP_AgSa_NameValue:[name=totalDocs, value=17]), hasPartyDetailsIn=null, hasPnCClaimIn=null, hasPolicyAssessmentDetailsIn=null, hasProducerInformationIn=null, initialLumpsumPremiumAMT=null, insuranceProductRk=null, isAssociatedWithGIInsuranceProduct=null, isAssociatedWithIssuer=null, isAssociatedWithLifeInsuranceProduct=null, issueBranchCD=null, issueBranchNM=null, issueDt=null, issueTypeCD=null, key=null, paidToDT=null, paymentMethodCD=null, paymentModeCD=null, payorCd=null, policyDueDt=null, policyEffectiveDTTM=null, policyExpirationDTTM=null, policyFeeAmt=null, policyNO=null, policyRK=null, policyReserveAmt=null, policySegment=null, policyStatusCD=null, policyStatusRk=null, policyTypeCd=null, policyValue=null, preferredChannelCd=null, premiumAMT=null, premiumIndexRt=null, processedDttm=null, producerRk=null, reEntryRt=null, registeredBy=null, remark1=null, sourceChannelCD=null, statusChangeDT=null, targetPremiumAmt=null, termProcessDt=202112, terminationDt=null, topupRegularModalPremium=null, validFromDttm=null, validToDttm=null]), hasRelationContact=null, haveCommunicatedMessage=(EIP_CustomerCommunication:[additionalRk=13, channelID=null, chargeAmt=null, deliveryDT=null, deliveryStatusCD=200, deliveryStatusDesc=success, message=ok, messageID=1234567890, replyTo=null, target=null]), numRelations=null, ownerIND=null, parties=null, processedDttm=null, relatedPolicy=null, relatedPolicyholdersCnt=null, sourceCInd=null, terminationDt=null, validFromDttm=null], appID=EDMU, entity=AMFS, exceptionObj=null, operation=Summary, service=getPolicyDetails, status=1, transactionId=0056F000004TDzzQAG-20220203-48542e587eeba49a3ed8f85d9c566379], Header=null, errorCode=null, errorDetail=null, errorMessage=null, message=null, reason=null, reasonCode=null] ');

                system.debug('edmuSummaryJson : '+ edmuSummaryJson);
                phDMUList = new list<DataSummary>();
                
                if (!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount == NULL)
                    system.debug('edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount: '+ edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount);
                
                //@Fajar Salam
                //01-07-2022
                //nextRk = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].additionalRk;
                
                //System.debug('[#][?] = ' +nextRk);
                
                Integer countphDMU = 0;
                if (Test.isRunningTest()) countphDMU = 1;
                else countphDMU = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
                    
                if (countphDMU != NULL)
                	system.debug('countphDMU: '+countphDMU);
                
                for(Integer i=0; i < countphDMU; i++) {
                    DataSummary newdata = new DataSummary();
                    
                    //New Field
                    newdata.Type_Doc = PARAM_TYPE; //PARAM_REQUEST_ID;
                    newdata.DateText = '';
                    newdata.OK = '';
                    newdata.Return_Docs = '';
                    newdata.Total_Documents = '';
                    newdata.Success = '';
                    newdata.Not_Success = '';
                    newdata.Last_Sync = '';
                    newdata.InProgress = '';
					newdata.deliveredEmail = '';
    				newdata.undeliveredEmail = '';
					newdata.nonemail = '';
					newdata.nonSMS = '';
					newdata.undeliveredSMS = '';
					newdata.deliveredSMS = '';
                    
                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[0].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[0].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[0].name == 'inProgress'){
                        newdata.InProgress = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[0].value;
                    }
                    //End - New Field

                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name == 'ok'){
                        newdata.Success = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value;
                    }
                    
                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[2].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[2].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[2].name == 'returnDocs'){
                        newdata.Not_Success = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[2].value;
                    }
                    
                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[3].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[3].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[3].name == 'totalDocs'){
                        newdata.Total_Documents = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[3].value;
                    }

                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[4].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[4].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[4].name == 'deliveredEmail'){
						newdata.deliveredEmail = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[4].value;
                    }

                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[5].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[5].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[5].name == 'undeliveredEmail'){
                        newdata.undeliveredEmail = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[5].value;
                    }

                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[6].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[6].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[6].name == 'nonemail'){
                        newdata.nonemail = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[6].value;
                    }

                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[7].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[7].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[7].name == 'nonSMS'){
                        newdata.nonSMS = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[7].value;
                    }

                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[8].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[8].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[8].name == 'undeliveredSMS'){
                        newdata.undeliveredSMS = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[8].value;
                    }

                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[9].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[9].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[9].name == 'deliveredSMS'){
                        newdata.deliveredSMS = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[9].value;
                    }


                    system.debug('#check report_dt '); //
                    if(!Test.isRunningTest() && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].termProcessDt != null ){
                        newdata.DateText = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].termProcessDt;
                    }
                    system.debug('#OK report_dt ');
                    
                    //=== Tidak ada di response-nya
                    /*if(edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name == 'ok'){
                        newdata.Type_Doc = CCCUtils.strToDec(edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value);
                    }
					
                    if(edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name == 'ok'){
                        newdata.Success = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value;
                    }
					
					if(edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name == 'ok'){
                        newdata.Not_Success = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value;
                    }

                    if(edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name != null && edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].name == 'ok'){
                        newdata.Last_Sync = edmuSummaryJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasNameValue[1].value;
                    }*/
                    //=== END - Tidak ada di response-nya
                    
                    phDMUList.add(newdata);
                }
                system.debug('phDMUList: '+phDMUList);
            } catch(EIPConnector.NoDataException e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response. '+e.getMessage()));
            } catch(EIPConnector.EIPConnectorException e){ 
                //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
                //system.debug('e : '+e);
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin. '+ e.getMessage()));
            } catch(Exception e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin. '+e.getMessage()));
            }
            // End Code EIP Connector
		return phDMUList;
    }

    public list<DataDetail> getDataDetail (string PARAM_SOURCE, string PARAM_REQUEST_ID, String PARAM_TYPE, String VALID_FROM_DTTM, String VALID_TO_DTTM, String POLICY_NO, String PAGE_NUMBER) { 
            // Code EIP Connector - Summary
            try {
                system.debug('#Start Code EIP Connector - Param');
                Map<String,String> params = new Map<String, String>();
                params.put(EIPConstant.PARAM_SOURCE, PARAM_SOURCE); // 'SFDC'
                params.put(EIPConstant.PARAM_REQUEST_ID, PARAM_REQUEST_ID); // '1234567890'
                params.put(EIPConstant.PARAM_TYPE, PARAM_TYPE); // 'ALL'
                params.put(EIPConstant.VALID_FROM_DTTM, VALID_FROM_DTTM); // dateConvertStart
                params.put(EIPConstant.VALID_TO_DTTM, VALID_TO_DTTM); // dateConvertEnd
                params.put(EIPConstant.PARAM_DMU_NEXTPAGE, PAGE_NUMBER); // Page Number, 1,2,3,4,5
                
                System.debug('#EIPConstant.PARAM_DMU_NEXTPAGE : '+PAGE_NUMBER);

                EIPJson edmuDetailJson;
                if (!Test.isRunningTest()) 
                	edmuDetailJson = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_DETAIL, EIPConstant.ENTITY_AMFS, EIPConstant.APP_EDMU, POLICY_NO, params); // '520-3069546'

                DataList = new list<DataDetail>();
                
                system.debug('#edmuDetailJson : '+edmuDetailJson);
                //@Fajar DMU
                String pageBTO = '1';
                if (!Test.isRunningTest()) pageBTO = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].bizContext;
                System.debug('#pageBTO : '+pageBTO);
                
                Integer countphDMU = 0;
                if (Test.isRunningTest()) countphDMU = 1;
                else countphDMU = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
                
                system.debug('countphDMU: '+countphDMU);
                boolean hidedebug = FALSE;
                boolean RunLive = !Test.isRunningTest();
                for(Integer i=0; i < countphDMU; i++) {
                    DataDetail newdata = new DataDetail();
                    
                    //*
                    newdata.edmu_type = 'Belum ada Field nya';
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueTypeCD != null){
                    //    newdata.edmu_type = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueTypeCD;
                    //}
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyNO != null){
                        newdata.policy_number = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyNO;
                    }
                    if (hidedebug) system.debug('newdata.policy_number : '+ newdata.policy_number);
                    if (hidedebug) system.debug('01 : '+newdata.policy_number);
                                 
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.fullNM != null){
                        newdata.holder_name = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.fullNM;
                    }
                    if (hidedebug) system.debug('newdata.holder_name : '+ newdata.holder_name);
                    if (hidedebug) system.debug('02 : '+newdata.holder_name);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyExpirationDTTM != null){
                        //system.debug('newdata.linkExpired_dt : '+edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyExpirationDTTM);
                        //newdata.linkExpired_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyExpirationDTTM, 'yyyymmdd');
                        newdata.linkExpired_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyExpirationDTTM;
                    }
                    if (hidedebug) system.debug('newdata.linkExpired_dt : '+ newdata.linkExpired_dt);
                    if (hidedebug) system.debug('03 : '+newdata.linkExpired_dt);

                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueDt != null){
                        //newdata.issue_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueDt, 'yyyymmdd');
                        newdata.issue_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueDt;
                    }
                    if (hidedebug) system.debug('newdata.issue_dt : '+ newdata.issue_dt);
                    if (hidedebug) system.debug('04');
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].sourceChannelCD != null){
                        newdata.delivery_method = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].sourceChannelCD;
                    }
                    if (hidedebug) system.debug('05 : '+newdata.delivery_method);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.documentTypeCD != null){
                        newdata.document_type = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.documentTypeCD;
                    }
                    if (hidedebug) system.debug('06 : '+newdata.document_type);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyStatusCD != null){
                        newdata.courier_delivery_status = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyStatusCD;
                    }
                    if (hidedebug) system.debug('07 : '+newdata.courier_delivery_status);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'courier_name'){
                        newdata.courier_courier_name = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    }
                    if (hidedebug) system.debug('08 : '+newdata.courier_courier_name);
                    
                    //newdata.courier_awb_no = 'Belum ada Field nya';
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'awb_no'){
                    //    newdata.courier_awb_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    //}
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].dependentNO != null ){
                        newdata.courier_awb_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].dependentNO;
                    }
                    if (hidedebug) system.debug('09 : '+newdata.courier_awb_no);
                    
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasRelationContact.fullNM != null ){
                    //    newdata.courier_receiver_name = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasRelationContact.fullNM;
                    //}
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasRelationContact != null )
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasRelationContact.fullNM != null ){
                        newdata.courier_receiver_name = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasRelationContact.fullNM;
                    }
                    if (hidedebug) system.debug('10 : '+newdata.courier_receiver_name);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].addressLine1 != null ){
                        newdata.courier_address = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].addressLine1;
                    }
                    if (hidedebug) system.debug('11 : '+newdata.courier_address);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].processedDttm != null){
                        //newdata.courier_pickup_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].processedDttm, 'yyyymmdd');
                        newdata.courier_pickup_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].processedDttm;
                    }
                    if (hidedebug) system.debug('12 : '+newdata.courier_pickup_dt);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyEffectiveDTTM != null){
                        //newdata.courier_receive_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyEffectiveDTTM, 'yyyymmdd');
                        newdata.courier_receive_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyEffectiveDTTM;
                    }
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyExpirationDTTM != null){
                    //    newdata.courier_receive_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyExpirationDTTM, 'yyyymmdd');
                    //}
                    if (hidedebug) system.debug('13 : '+newdata.courier_receive_dt);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].statusChangeDT != null){
                        //newdata.courier_retur_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].statusChangeDT, 'yyyymmdd');
                        newdata.courier_retur_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].statusChangeDT;
                    }
                    if (hidedebug) system.debug('14 : '+newdata.courier_retur_dt);
                    
                    //newdata.courier_retur_note = 'Belum ada Field nya';
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'retur_note'){
                    //    newdata.courier_retur_note = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    //}
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].financialFundRk != null ){
                        newdata.courier_retur_note = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].financialFundRk;
                    }
                    if (hidedebug) system.debug('15 : '+newdata.courier_retur_note);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyRK != null ){
                        newdata.courier_note = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyRK;
                    }
                    if (hidedebug) system.debug('16 : '+newdata.courier_note);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].mobilePhoneNO != null ){
                        newdata.sms_phone_number = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].mobilePhoneNO;
                    }
                    if (hidedebug) system.debug('17 : '+newdata.sms_phone_number);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'sms_delivery_dt'){
                        //newdata.sms_delivery_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value, 'yyyymmdd');
                        newdata.sms_delivery_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    }
                    if (hidedebug) system.debug('18 : '+newdata.sms_delivery_dt);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'sms_download_dt'){
                    //    newdata.sms_download_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value, 'yyyymmdd');
                    //}
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 1)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].name == 'sms_download_dt'){
                        //newdata.sms_download_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value, 'yyyymmdd');
                        newdata.sms_download_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value;
                    }
                    if (hidedebug) system.debug('19 : '+newdata.sms_download_dt);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'sms_status'){
                    //    newdata.sms_sms_status = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    //}
					if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 2)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].name == 'sms_status'){
                        newdata.sms_sms_status = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].value;
                    }
                    
                    // for SMS
                    if (PARAM_TYPE != 'Data Gudang')
					if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 1)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].name == 'sms_status'){
                        newdata.sms_sms_status = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value;
                    }
                    if (hidedebug) system.debug('20 : '+newdata.sms_sms_status);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].emailAddress != null ){
                        newdata.email_email_address = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].emailAddress;
                    }
                    if (hidedebug) system.debug('21 : '+newdata.email_email_address);

                    if (PARAM_TYPE != 'Data Gudang')
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'email_delivery_dt'){
                        //newdata.email_delivery_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value, 'yyyymmdd');
                    //    newdata.email_delivery_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    //}
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 3)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].name == 'email_delivery_dt'){
                        //newdata.email_delivery_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value, 'yyyymmdd');
                        newdata.email_delivery_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].value;
                    }
                    if (hidedebug) system.debug('22 : '+newdata.email_delivery_dt);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'email_download_dt'){
                    //    newdata.email_download_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value, 'yyyymmdd');
                    //}
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 4)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].name == 'email_download_dt'){
                        //newdata.email_download_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].value, 'yyyymmdd');
                        newdata.email_download_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].value;
                    }
                    if (hidedebug) system.debug('23 : '+newdata.email_download_dt);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'email_status'){
                    //    newdata.email_email_status = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    //}
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 5)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name == 'email_status'){
                        newdata.email_email_status = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].value;
                    }
                    if (hidedebug) system.debug('24 : '+newdata.email_email_status);                    
                    
                    //if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyTypeCd != null){
                        newdata.policyTypeCode = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyTypeCd;
                    }
                    if (hidedebug) system.debug('25 : '+newdata.policyTypeCode);                    

                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNo != null ){
                        newdata.warehouse_awb_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNo;
                    }
                    if (hidedebug) system.debug('26 : '+newdata.warehouse_awb_no);                    

                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'warehouse_courier_name'){
                        newdata.warehouse_courierName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    }                    
                    if (hidedebug) system.debug('27: '+newdata.warehouse_courierName);                    
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitType != null ){
                        newdata.warehouse_type = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitType;
                    }
                    //newdata.warehouse_type = '<< Tidak ada Data >>';
                    if (hidedebug) system.debug('28 : '+newdata.warehouse_type);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 1)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].name == 'warehouse_pickup_dt'){
                        //newdata.warehouse_pickup_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value, 'yyyymmdd');
                        newdata.warehouse_pickup_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value;
                    }                    
                    if (hidedebug) system.debug('29 : '+newdata.warehouse_pickup_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 2)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].name == 'warehouse_return_dt'){
                        //newdata.warehouse_return_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].value, 'yyyymmdd');
                        newdata.warehouse_return_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].value;
                    }                    
                    if (hidedebug) system.debug('30 : '+newdata.warehouse_return_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 3)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].name == 'warehouse_receiver_name'){
                        newdata.warehouse_receiverName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].value;
                    }                    
                    if (hidedebug) system.debug('31 : '+newdata.warehouse_receiverName);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRk != null ){
                        newdata.warehouse_btoSource = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRk;
                    }
                    if (hidedebug) system.debug('32 : '+newdata.warehouse_btoSource);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT != null ){
                        //newdata.warehouse_bto_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT, 'yyyymmdd');
                        newdata.warehouse_bto_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT;
                    }
                    if (hidedebug) system.debug('33 : '+newdata.warehouse_bto_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 4)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].name == 'warehouse_custody_location'){
                        newdata.warehouse_custodyLocation = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].value;
                    }                    
                    if (hidedebug) system.debug('34 : '+newdata.warehouse_custodyLocation);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate != null ){
                        //newdata.warehouse_outbound_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate, 'yyyymmdd');
                        newdata.warehouse_outbound_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate;
                    }
                    if (hidedebug) system.debug('35 : '+newdata.warehouse_outbound_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation != null ){
                        newdata.warehouse_outboundDestination = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation;
                    }
                    if (hidedebug) system.debug('36 : '+newdata.warehouse_outboundDestination);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].chasisNO != null ){
                        newdata.warehouse_boxFilling_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].chasisNO;
                    }
                    //newdata.warehouse_boxFilling_no = '<< Tidak ada Data >>';
                    if (hidedebug) system.debug('37 : '+newdata.warehouse_boxFilling_no);                    

                    if (PARAM_TYPE == 'Data Gudang')
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'warehouse_pic_name'){
                    //    newdata.warehouse_picName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    //}                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 5)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name == 'warehouse_pic_name'){
                        newdata.warehouse_picName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].value;
                    }                    

                    if (hidedebug) system.debug('38 : '+newdata.warehouse_picName);

                    if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].producerRk != null ){
                        newdata.sms_issueTypeCD = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].producerRk;
                    }                    

                    if (hidedebug) system.debug('39 : '+newdata.sms_issueTypeCD);
                    
                    dataList.add(newdata);
					//*/
                }
                    //if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].bizContext != null ) MaxPage = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].bizContext;

                    if (hidedebug) system.debug('40 : '+MaxPage);
                    nextRk = MaxPage;

                if (hidedebug) system.debug('dataList: '+dataList);
            } catch(EIPConnector.NoDataException e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response. '+e.getMessage()));
            } catch(EIPConnector.EIPConnectorException e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin. '+e.getMessage()));
            } catch(Exception e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin. '+e.getMessage()));
            }
            // End Code EIP Connector
        

        Return dataList;
    }

    public list<DataDetail> getDataDetailBTO (string PARAM_SOURCE, string PARAM_REQUEST_ID, String PARAM_TYPE, String VALID_FROM_DTTM, String VALID_TO_DTTM, String POLICY_NO, String PAGE_NUMBER) { 
            // Code EIP Connector - Summary
            try {
                system.debug('#Start Code EIP Connector - Param');
                Map<String,String> params = new Map<String, String>();
                params.put(EIPConstant.PARAM_SOURCE, PARAM_SOURCE); // 'SFDC'
                params.put(EIPConstant.PARAM_REQUEST_ID, PARAM_REQUEST_ID); // '1234567890'
                params.put(EIPConstant.PARAM_TYPE, PARAM_TYPE); // 'ALL'
                params.put(EIPConstant.VALID_FROM_DTTM, VALID_FROM_DTTM); // dateConvertStart
                params.put(EIPConstant.VALID_TO_DTTM, VALID_TO_DTTM); // dateConvertEnd
                params.put(EIPConstant.PARAM_DMU_NEXTPAGE, PAGE_NUMBER); // Page Number, 1,2,3,4,5
                
                System.debug('#EIPConstant.PARAM_DMU_NEXTPAGE : '+PAGE_NUMBER);

                EIPJson edmuDetailJson;
                if (!Test.isRunningTest()) 
                	edmuDetailJson = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_DETAIL, EIPConstant.ENTITY_AMFS, EIPConstant.APP_EDMU, POLICY_NO, params); // '520-3069546'

                DataList = new list<DataDetail>();
                
                system.debug('#edmuDetailJson : '+edmuDetailJson);
                //@Fajar DMU
                String pageBTO = '1';
                if (!Test.isRunningTest()) pageBTO = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].bizContext;
                System.debug('#pageBTO : '+pageBTO);
                
                Integer countphDMU = 0;
                if (Test.isRunningTest()) countphDMU = 1;
                else countphDMU = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
                
                system.debug('countphDMU: '+countphDMU);
                boolean hidedebug = FALSE;
                boolean RunLive = !Test.isRunningTest();
                for(Integer i=0; i < countphDMU; i++) {
                    DataDetail newdata = new DataDetail();
                    
                    //*
                    newdata.edmu_type = 'Belum ada Field nya';
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueTypeCD != null){
                    //    newdata.edmu_type = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueTypeCD;
                    //}
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyNO != null){
                        newdata.policy_number = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyNO;
                    }
                    if (hidedebug) system.debug('newdata.policy_number : '+ newdata.policy_number);
                    if (hidedebug) system.debug('01 : '+newdata.policy_number);
                                                                                                                                                                                                                                         
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].financialFundRk != null ){
                        newdata.courier_retur_note = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].financialFundRk;
                    }
                    if (hidedebug) system.debug('15 : '+newdata.courier_retur_note);
                                                                                                                                                                
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyTypeCd != null){
                        newdata.policyTypeCode = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyTypeCd;
                    }
                    if (hidedebug) system.debug('25 : '+newdata.policyTypeCode);                    

                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNo != null ){
                        newdata.warehouse_awb_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNo;
                    }
                    if (hidedebug) system.debug('26 : '+newdata.warehouse_awb_no);                    

                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'warehouse_courier_name'){
                        newdata.warehouse_courierName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    }                    
                    if (hidedebug) system.debug('27: '+newdata.warehouse_courierName);                    
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitType != null ){
                        newdata.warehouse_type = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitType;
                    }
                    if (hidedebug) system.debug('28 : '+newdata.warehouse_type);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 1)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].name == 'warehouse_pickup_dt'){
                        newdata.warehouse_pickup_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value;
                    }                    
                    if (hidedebug) system.debug('29 : '+newdata.warehouse_pickup_dt);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 2)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].name == 'warehouse_return_dt'){
                        newdata.warehouse_return_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].value;
                    }                    
                    if (hidedebug) system.debug('30 : '+newdata.warehouse_return_dt);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 3)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].name == 'warehouse_receiver_name'){
                        newdata.warehouse_receiverName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].value;
                    }                    
                    if (hidedebug) system.debug('31 : '+newdata.warehouse_receiverName);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRk != null ){
                        newdata.warehouse_btoSource = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRk;
                    }
                    if (hidedebug) system.debug('32 : '+newdata.warehouse_btoSource);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT != null ){
                        //newdata.warehouse_bto_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT, 'yyyymmdd');
                        newdata.warehouse_bto_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT;
                    }
                    if (hidedebug) system.debug('33 : '+newdata.warehouse_bto_dt);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 4)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].name == 'warehouse_custody_location'){
                        newdata.warehouse_custodyLocation = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].value;
                    }                    
                    if (hidedebug) system.debug('34 : '+newdata.warehouse_custodyLocation);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate != null ){
                        //newdata.warehouse_outbound_dt = (date) CCCUtils.strToDate(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate, 'yyyymmdd');
                        newdata.warehouse_outbound_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate;
                    }
                    if (hidedebug) system.debug('35 : '+newdata.warehouse_outbound_dt);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation != null ){
                        newdata.warehouse_outboundDestination = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation;
                    }
                    if (hidedebug) system.debug('36 : '+newdata.warehouse_outboundDestination);
                    
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].chasisNO != null ){
                        newdata.warehouse_boxFilling_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].chasisNO;
                    }
                    //newdata.warehouse_boxFilling_no = '<< Tidak ada Data >>';
                    if (hidedebug) system.debug('37 : '+newdata.warehouse_boxFilling_no);                    

                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue.size() > 5)
                    if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name == 'warehouse_pic_name'){
                        newdata.warehouse_picName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].value;
                    }                    

                    if (hidedebug) system.debug('38 : '+newdata.warehouse_picName);
                    
                    dataList.add(newdata);
					//*/
                }
                    //if (PARAM_TYPE != 'Data Gudang')
                    if(RunLive && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].bizContext != null ) MaxPage = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].bizContext;

                    if (hidedebug) system.debug('40 : '+MaxPage);
                    nextRk = MaxPage;

                if (hidedebug) system.debug('dataList: '+dataList);
            } catch(EIPConnector.NoDataException e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response. '+e.getMessage()));
            } catch(EIPConnector.EIPConnectorException e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin. '+e.getMessage()));
            } catch(Exception e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin. '+e.getMessage()));
            }
            // End Code EIP Connector
        

        Return dataList;
    }    
}