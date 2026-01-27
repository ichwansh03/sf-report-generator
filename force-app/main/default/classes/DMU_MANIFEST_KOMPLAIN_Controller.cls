public with sharing class DMU_MANIFEST_KOMPLAIN_Controller {
    public string paramContactId {get;set;}
    public List<coa> coaList {get;set;}
    public List<inquiry> inquiryList {get;set;}
    public List<invest> investList {get;set;}
    public List<bto> btoList {get;set;}
    public List<redel> redelList {get;set;}
    public integer countCOA {get;set;}
    public integer countInquiry {get;set;}
    public integer countInvest {get;set;}
    public integer countBTO {get;set;}
    public integer countRedel {get;set;}
    public List<PolicyBTO> BTOJList {get;set;}
    public List<DataDetail> DataList {get;set;} 
    
    public boolean lockPage {get;set;}
    public case filterdata {get;set;}
    public String policyNo {get;set;}
    public String contactName {get;set;}

    // Hide field / button, if ContactId terisi.
    public boolean HideField {get;set;}

    //public string coa  {get; set;}
    //public string inquiry  {get; set;}
    //public string redel  {get; set;}
    //public string invest  {get; set;}
    //public string bto  {get; set;}
    
    public class coa{
        public string DATA_ID {get; set;}
        public string REQUEST_NO {get; set;}
        public string CUSTOMER_NAME {get; set;}
        public string REQUEST_STATUS {get; set;}
        public string RECEIVED_DATE {get; set;}
        public string CATEGORY {get; set;}
        public string REQUESTOR {get; set;}
        public string POLIS {get; set;}
        public string COMPLAIN {get; set;}
        public string DESCRIPTION {get; set;}
        public string OTHERINFORMATION {get; set;}
        public string TELP {get; set;}
        public string KOTA {get; set;}
        public string REMARK_FROM_AXA {get; set;}
        public string SENDDATE {get; set;}
        public string STATUS {get; set;}
        public string PENERIMA {get; set;}
        public string HUBUNGAN {get; set;}
        public string TGLTERIMA {get; set;}
        public string REMARK_FROM_NCS {get; set;}
        public string DATECLOSED {get; set;}
        public string STATUSCHS {get; set;}
        public string KURIR {get; set;}
        
        public coa(){
        }       
    }

    public class inquiry{
        public string DATA_ID {get; set;}
        public string REQUEST_NO {get; set;}
        public string CUSTOMER_NAME {get; set;}
        public string REQUEST_STATUS {get; set;}
        public string RECEIVED_DATE {get; set;}
        public string CATEGORY {get; set;}
        public string REQUESTOR {get; set;}
        public string POLIS {get; set;}
        public string COMPLAIN {get; set;}
        public string DESCRIPTION {get; set;}
        public string OTHERINFORMATION {get; set;}
        public string TELP {get; set;}
        public string KOTA {get; set;}
        public string REMARK_FROM_AXA {get; set;}
        public string SENDDATE {get; set;}
        public string STATUS {get; set;}
        public string PENERIMA {get; set;}
        public string HUBUNGAN {get; set;}
        public string TGLTERIMA {get; set;}
        public string REMARK_FROM_NCS {get; set;}
        public string DATECLOSED {get; set;}
        public string STATUSCHS {get; set;}
        public string KURIR {get; set;}
        
        public inquiry(){
        }       
    }

    public class redel{
        public string DATA_ID {get; set;}
        public string REQUEST_NO {get; set;}
        public string CUSTOMER_NAME {get; set;}
        public string REQUEST_STATUS {get; set;}
        public string RECEIVED_DATE {get; set;}
        public string CATEGORY {get; set;}
        public string REQUESTOR {get; set;}
        public string POLIS {get; set;}
        public string COMPLAIN {get; set;}
        public string DESCRIPTION {get; set;}
        public string OTHERINFORMATION {get; set;}
        public string TELP {get; set;}
        public string KOTA {get; set;}
        public string REMARK_FROM_AXA {get; set;}
        public string SENDDATE {get; set;}
        public string STATUS {get; set;}
        public string PENERIMA {get; set;}
        public string HUBUNGAN {get; set;}
        public string TGLTERIMA {get; set;}
        public string REMARK_FROM_NCS {get; set;}
        public string DATECLOSED {get; set;}
        public string STATUSCHS {get; set;}
        public string KURIR {get; set;}
        
        public redel(){
        }       
    }

    public class invest{
        public string NUM {get; set;}
        public string POLIS {get; set;}
        public string CONSIGNEE {get; set;}
        public string NO_INVESTIGASI {get; set;}
        public string KOTA {get; set;}
        public string SLA {get; set;}
        public string DATA_CASE {get; set;}
        public string REMARK_AXA {get; set;}
        public string TELP {get; set;}
        public string DATE_REQUEST {get; set;}
        public string TGLHASILINVESTIGASI {get; set;}
        public string HASIL_INVESTIGASI {get; set;}
        public string AGING_PINALTY {get; set;}
        public string PINALTY {get; set;}
        public string REMARK {get; set;}
        public string KESIMPULAN_HASIL_INVESTIGASI {get; set;}
        public string SLA_OVERDUE_OK {get; set;}
        public string COMPLAIN {get; set;}
        public string Kurir {get; set;}
        public string Category {get; set;}
        public string No_request {get; set;}
        
        public invest(){
        }       
    }

    public class bto{
        public string Policy_Number {get; set;}
        public string Tujuan_Keluar {get; set;}
        public string Lokasi_Custody {get; set;}
        public string Tgl_Upload {get; set;}
        
        public bto(){
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

    public class DataDetail{
        
        public string edmu_type {get; set;}
        public string policy_number {get; set;}
        public string holder_name {get; set;}

        public string policyTypeCode {get; set;}
        public string warehouse_awb_no {get; set;}
        public string warehouse_courierName {get; set;}
        public string warehouse_type {get; set;}
        public String warehouse_pickup_dt {get; set;}
        public String warehouse_return_dt {get; set;}
        public string warehouse_receiverName {get; set;}
        public string warehouse_btoSource {get; set;}
        public String warehouse_bto_dt {get; set;}
        public string warehouse_custodyLocation {get; set;}
        public String warehouse_outbound_dt {get; set;}
        public string warehouse_outboundDestination {get; set;}
        public string warehouse_boxFilling_no {get; set;}
        public string warehouse_picName {get; set;}
        public string courier_retur_note {get; set;}
        
        public DataDetail(){
        }
    }

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

	public String xlsHeader2 {
        get {
            String strHeader = '';
            //strHeader += '<?xml version="1.0"?> \n';
            //strHeader += '<?mso-application progid="Excel.Sheet"?>';

            strHeader += '<?xml version="1.0"?> \n';
            strHeader += '<?mso-application progid="Excel.Sheet"?> \n';
            strHeader += '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" \n';
             strHeader += 'xmlns:o="urn:schemas-microsoft-com:office:office" \n';
             strHeader += 'xmlns:x="urn:schemas-microsoft-com:office:excel" \n';
             strHeader += 'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" \n';
             strHeader += 'xmlns:html="http://www.w3.org/TR/REC-html40"> \n';
             strHeader += '<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office"> \n';
              strHeader += '<Author>Taufik Susanto</Author> \n';
              strHeader += '<LastAuthor>Taufik Susanto</LastAuthor> \n';
              strHeader += '<Created>2020-01-22T15:28:32Z</Created> \n';
              strHeader += '<Version>16.00</Version> \n';
             strHeader += '</DocumentProperties> \n';
             strHeader += '<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office"> \n';
              strHeader += '<AllowPNG/> \n';
             strHeader += '</OfficeDocumentSettings> \n';
             strHeader += '<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel"> \n';
              strHeader += '<WindowHeight>9192</WindowHeight> \n';
              strHeader += '<WindowWidth>23040</WindowWidth> \n';
              strHeader += '<WindowTopX>0</WindowTopX> \n';
              strHeader += '<WindowTopY>0</WindowTopY> \n';
              strHeader += '<ProtectStructure>False</ProtectStructure> \n';
              strHeader += '<ProtectWindows>False</ProtectWindows> \n';
             strHeader += '</ExcelWorkbook> \n';
             strHeader += '<Styles> \n';
              strHeader += '<Style ss:ID="Default" ss:Name="Normal"> \n';
               strHeader += '<Alignment ss:Vertical="Bottom"/> \n';
               strHeader += '<Borders/> \n';
               strHeader += '<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/> \n';
               strHeader += '<Interior/> \n';
               strHeader += '<NumberFormat/> \n';
               strHeader += '<Protection/> \n';
              strHeader += '</Style> \n';
             strHeader += '</Styles> \n';
             strHeader += '<Worksheet ss:Name="Sheet1"> \n';
              strHeader += '<Table ss:ExpandedColumnCount="4" ss:ExpandedRowCount="5" x:FullColumns="1" \n';
               strHeader += 'x:FullRows="1" ss:DefaultRowHeight="14.4"> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">Kolom 1</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Kolom 2</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Kolom 3</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Kolom 4</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 11</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 21</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 31</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 41</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 12</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 22</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 32</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 42</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 13</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 23</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 33</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 43</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 14</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 24</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 34</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">Data 44</Data></Cell> \n';
               strHeader += '</Row> \n';
              strHeader += '</Table> \n';
              strHeader += '<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel"> \n';
               strHeader += '<PageSetup> \n';
                strHeader += '<Header x:Margin="0.3"/> \n';
                strHeader += '<Footer x:Margin="0.3"/> \n';
                strHeader += '<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/> \n';
               strHeader += '</PageSetup> \n';
               strHeader += '<Selected/> \n';
               strHeader += '<ProtectObjects>False</ProtectObjects> \n';
               strHeader += '<ProtectScenarios>False</ProtectScenarios> \n';
              strHeader += '</WorksheetOptions> \n';
             strHeader += '</Worksheet> \n';
             strHeader += '<Worksheet ss:Name="Sheet2"> \n';
              strHeader += '<Table ss:ExpandedColumnCount="4" ss:ExpandedRowCount="5" x:FullColumns="1" \n';
               strHeader += 'x:FullRows="1" ss:DefaultRowHeight="14.4"> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">2Kolom 1</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Kolom 2</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Kolom 3</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Kolom 4</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 11</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 21</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 31</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 41</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 12</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 22</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 32</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 42</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 13</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 23</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 33</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 43</Data></Cell> \n';
               strHeader += '</Row> \n';
               strHeader += '<Row> \n';
               strHeader += '<Cell><Data ss:Type="String">2Data 14</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 24</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 34</Data></Cell> \n';
                strHeader += '<Cell><Data ss:Type="String">2Data 44</Data></Cell> \n';
               strHeader += '</Row> \n';
              strHeader += '</Table> \n';
              strHeader += '<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel"> \n';
               strHeader += '<PageSetup> \n';
                strHeader += '<Header x:Margin="0.3"/> \n';
                strHeader += '<Footer x:Margin="0.3"/> \n';
                strHeader += '<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/> \n';
               strHeader += '</PageSetup> \n';
               strHeader += '<Panes> \n';
                strHeader += '<Pane> \n';
                 strHeader += '<Number>3</Number> \n';
                 strHeader += '<ActiveRow>1</ActiveRow> \n';
                 strHeader += '<ActiveCol>1</ActiveCol> \n';
                strHeader += '</Pane> \n';
               strHeader += '</Panes> \n';
               strHeader += '<ProtectObjects>False</ProtectObjects> \n';
               strHeader += '<ProtectScenarios>False</ProtectScenarios> \n';
              strHeader += '</WorksheetOptions> \n';
             strHeader += '</Worksheet> \n';
            strHeader += '</Workbook> \n';

            return strHeader;
        }
    }

    public DMU_MANIFEST_KOMPLAIN_Controller(){
        
        paramContactId = ApexPages.currentPage().getParameters().get('contactID');
        if (paramContactId != NULL) HideField = TRUE;
        
        //accountList = [select id, name from Account LIMIT 50];
        //contactList = [Select id, name, account.name, email from Contact LIMIT 50];
        filterdata = new case();
        system.debug('#RecordType : '+Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId());
        filterdata.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('AMFSComplaintCase').getRecordTypeId();
        filterdata.ContactId = paramContactId;
        filterdata.Status = NULL;
        date datetoday = date.today();
        filterdata.Due_Date__c = date.newInstance(datetoday.year(), datetoday.month(), 1);
        date datenext = datetoday.addMonths(1);
        filterdata.Closed_Date__c = date.newInstance(datenext.year(), datenext.month(), 1) - 1;
        //filterdata.Courier__c
        //Due_Date__c // Start 
        //Closed_Date__c = // end
        String ExportToExcel = ApexPages.currentPage().getParameters().get('ExportToExcel');
        String DateForm = ApexPages.currentPage().getParameters().get('DateFrom');
        String DateTo = ApexPages.currentPage().getParameters().get('DateTo');
        String Courier = ApexPages.currentPage().getParameters().get('Courier');
        
        if (DateForm != NULL || DateTo != NULL || Courier != NULL || ExportToExcel == 'TRUE')
        	getdata();
    }

    public void getdata() {
		countCOA = 0;
    	countInquiry = 0;
    	countInvest = 0;
    	countBTO = 0;
    	countRedel = 0;
        string filtercourier = '';
        if (filterdata.courier__c != 'null' && filterdata.courier__c != NULL && filterdata.courier__c != '') filtercourier = ' AND courier__c = \''+filterdata.courier__c+'\' ';

        string filterStatus = '';
        if (filterdata.Status != NULL) filterstatus = ' AND Status = \''+filterdata.Status+'\' ';

        string filterDate = '';
        if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c >= '+filterdata.Due_Date__c+' AND Create_Date__c <= '+filterdata.Closed_Date__c+' ' ;
        else if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c == NULL) filterDate = ' AND Create_Date__c = '+filterdata.Due_Date__c+' ' ;
        else if (filterdata.Due_Date__c == NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c = '+filterdata.Closed_Date__c+' ' ;
        else filterDate = '' ;
        
        filterDate = filterDate.replace('00:00:00', '');

        //if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c >= \''+filterdata.Due_Date__c+'\' AND Create_Date__c <= \''+filterdata.Closed_Date__c+'\' ' ;
        //else if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c == NULL) filterDate = ' AND Create_Date__c = \''+filterdata.Due_Date__c+'\' ' ;
        //else if (filterdata.Due_Date__c == NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c = \''+filterdata.Closed_Date__c+'\' ' ;
        //else filterDate = ' AND Create_Date__c = \''+filterdata.Due_Date__c+'\' ' ;

        string defaultqueryStr = '';
        defaultqueryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone, ';
		defaultqueryStr += ' DMU_TGLHASILINVESTIGASI__c, DMU_HASIL_INVESTIGASI__c, DMU_AGING_PINALTY__c, DMU_PINALTY__c, DMU_REMARK__c, DMU_KESIMPULAN_HASIL_INVESTIGASI__c, DMU_SLA_OVERDUE_OK__c, ';
		defaultqueryStr += ' DMU_STATUS__c, DMU_PENERIMA__c, DMU_HUBUNGAN__c, DMU_TGLTERIMA__c, DMU_REMARK_FROM_NCS__c, DMU_DATECLOSED__c, DMU_STATUSCHS__c ';
        defaultqueryStr += ' FROM Case ';
        
        // QUERY DATA
        string queryStr = '';
        // == COA ==
        //queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone, ';
		//queryStr += ' DMU_TGLHASILINVESTIGASI__c, DMU_HASIL_INVESTIGASI__c, DMU_AGING_PINALTY__c, DMU_PINALTY__c, DMU_REMARK__c, DMU_KESIMPULAN_HASIL_INVESTIGASI__c, DMU_SLA_OVERDUE_OK__c, ';
		//queryStr += ' DMU_STATUS__c, DMU_PENERIMA__c, DMU_HUBUNGAN__c, DMU_TGLTERIMA__c, DMU_REMARK_FROM_NCS__c, DMU_DATECLOSED__c, DMU_STATUSCHS__c ';
        //queryStr += ' FROM Case ';
        queryStr = defaultqueryStr;
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
        if (Test.isRunningTest()) queryStr += ' Type = \'Request\' LIMIT 1';
        if (!Test.isRunningTest()) queryStr += ' Type = \'Request\' AND ';
		if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'Request_Courier Delivery ? Change of Address\' ';
        if (!Test.isRunningTest()) queryStr += filtercourier;
        if (!Test.isRunningTest()) queryStr += filterDate;
        if (!Test.isRunningTest()) queryStr += filterStatus;
        
        system.debug('## COA : '+queryStr);
        
        coaList = new list<coa>();
        for (case cs : Database.query(queryStr))
        {
            countCOA += 1;
            
            coa newdata = new coa();
            
            newdata.DATA_ID = cs.CaseNumber; //'';
            newdata.REQUEST_NO = cs.CaseNumber; //'';
            newdata.CUSTOMER_NAME = cs.Contact.Name; //'';
            newdata.REQUEST_STATUS = '';
            newdata.RECEIVED_DATE = string.valueof(cs.CreatedDate); //'';
            newdata.CATEGORY = cs.Case_Type__c; //'';
            newdata.REQUESTOR = 'AMFS - DMU Queue';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.COMPLAIN = 'Customer';
            newdata.DESCRIPTION = cs.Description; //'';
            newdata.OTHERINFORMATION = '';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone  +'/'+ cs.Contact.HomePhone; //'';
            newdata.KOTA = '';
            newdata.REMARK_FROM_AXA = '';
            newdata.SENDDATE = string.valueof(date.Today()); //'';
            newdata.STATUS = cs.DMU_STATUS__c;//'';
            newdata.PENERIMA = cs.DMU_PENERIMA__c; //'';
            newdata.HUBUNGAN = cs.DMU_HUBUNGAN__c; //'';
            newdata.TGLTERIMA = cs.DMU_TGLTERIMA__c; //'';
            newdata.REMARK_FROM_NCS = cs.DMU_REMARK_FROM_NCS__c; //'';
            newdata.DATECLOSED = cs.DMU_DATECLOSED__c; //'';
            newdata.STATUSCHS = 'OPEN';
            newdata.KURIR = filterdata.Courier__c;
            
            coaList.add(newdata);
        }
        // == INQUIRY ==
        //queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr = defaultqueryStr;
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
		if (Test.isRunningTest()) queryStr += ' Type = \'Request\' LIMIT 1';
        if (!Test.isRunningTest()) queryStr += ' Type = \'Request\' AND ';
		if (!Test.isRunningTest()) queryStr += ' ( ';
        if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'Request_Courier Delivery ? Speed Up Delivery\' OR ';
		if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'Request_Courier Delivery - Inquiry Receipt\' ';
		if (!Test.isRunningTest()) queryStr += ' ) ';
        if (!Test.isRunningTest()) queryStr += filtercourier;
        if (!Test.isRunningTest()) queryStr += filterDate;
        if (!Test.isRunningTest()) queryStr += filterStatus;
        
        system.debug('## Inquiry : '+queryStr);
				
        inquiryList = new list<inquiry>();
        for (case cs : Database.query(queryStr))
        {
            countInquiry += 1;
                
            inquiry newdata = new inquiry();
            newdata.DATA_ID = cs.CaseNumber; //'';
            newdata.REQUEST_NO = cs.CaseNumber; //'';
            newdata.CUSTOMER_NAME = cs.Contact.Name; //'';
            newdata.REQUEST_STATUS = '';
            newdata.RECEIVED_DATE = string.valueOf(cs.CreatedDate); //'';
            newdata.CATEGORY = cs.Case_Type__c; //'';
            newdata.REQUESTOR = 'AMFS - DMU Queue';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.COMPLAIN = 'Customer';
            newdata.DESCRIPTION = cs.Description; //'';
            newdata.OTHERINFORMATION = '';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone +'/'+ cs.Contact.HomePhone; //'';
            newdata.KOTA = '';
            newdata.REMARK_FROM_AXA = 'DMU: REQUEST SPEED UP TO KURIR';
            newdata.SENDDATE = string.valueof(date.Today()); //'';
            newdata.STATUS = cs.DMU_STATUS__c; //'';
            newdata.PENERIMA = cs.DMU_PENERIMA__c; //'';
            newdata.HUBUNGAN = cs.DMU_HUBUNGAN__c; //'';
            newdata.TGLTERIMA = cs.DMU_TGLTERIMA__c; //'';
            newdata.REMARK_FROM_NCS = cs.DMU_REMARK_FROM_NCS__c; //'';
            newdata.DATECLOSED = cs.DMU_DATECLOSED__c; //'';
            newdata.STATUSCHS = 'OPEN';
            newdata.KURIR = filterdata.Courier__c;
            
			inquiryList.add(newdata);
        }

        
        // == INVEST ==
        //queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr = defaultqueryStr;
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
        //queryStr += ' Type = \'Complaint\' AND ';
		//queryStr += ' ( ';
        //queryStr += ' Category__c = \'Courier Delivery - Investigation\' OR ';
		//queryStr += ' Category__c = \'Courier Investigation - Delivery\' ';
		//queryStr += ' ) ';
		if (Test.isRunningTest()) queryStr += ' Type = \'Request\' LIMIT 1';
        if (!Test.isRunningTest()) queryStr += ' Type = \'Request\' AND ';
		if (!Test.isRunningTest()) queryStr += ' ( ';
        if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'Request_DMU_Sanggah\' OR ';
		if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'Request_DMU_Sanggah Berulang\' ';
		if (!Test.isRunningTest()) queryStr += ' ) ';
        if (!Test.isRunningTest()) queryStr += filtercourier;
        if (!Test.isRunningTest()) queryStr += filterDate;
        if (!Test.isRunningTest()) queryStr += filterStatus;

        system.debug('## Invest : '+queryStr);

        investList = new list<invest>();
        for (case cs : Database.query(queryStr))
        {
            countInvest += 1;
            
            invest newdata = new invest();

            newdata.NUM = cs.CaseNumber; //'';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.CONSIGNEE = cs.Contact.Name; //'';
            newdata.NO_INVESTIGASI = 'DMU / '+cs.CaseNumber+' / Investigasi /'+cs.CreatedDate.year();
            newdata.KOTA = '';
            newdata.SLA = '';
            newdata.DATA_CASE = cs.Description; //'';
            newdata.REMARK_AXA = 'DMU: REQUEST INVESTIGASI TO KURIR';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone +'/'+ cs.Contact.HomePhone; //'';
            newdata.DATE_REQUEST = string.valueof(date.today()); //string.valueof(cs.CreatedDate); //'';
            newdata.TGLHASILINVESTIGASI = cs.DMU_TGLHASILINVESTIGASI__c; //'';
            newdata.HASIL_INVESTIGASI = cs.DMU_HASIL_INVESTIGASI__c; //'';
            newdata.AGING_PINALTY = cs.DMU_AGING_PINALTY__c; //'';
            newdata.PINALTY = cs.DMU_PINALTY__c; //'';
            newdata.REMARK = cs.DMU_REMARK__c; //'';
            newdata.KESIMPULAN_HASIL_INVESTIGASI = cs.DMU_KESIMPULAN_HASIL_INVESTIGASI__c; //'';
            newdata.SLA_OVERDUE_OK = cs.DMU_SLA_OVERDUE_OK__c; // '';
            newdata.COMPLAIN = 'CUSTOMER';
            newdata.Kurir = filterdata.Courier__c;
            newdata.Category = cs.Case_Type__c; //'';
            newdata.No_request = cs.CaseNumber; //'';
            
            investList.add(newdata);
        }

        
        // == BTO ==
        //queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr = defaultqueryStr;
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
		if (Test.isRunningTest()) queryStr += ' Type = \'Request\' LIMIT 1';
        if (!Test.isRunningTest()) queryStr += ' Type = \'Request\' AND ';
		if (!Test.isRunningTest()) queryStr += ' ( ';
        if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'BTO\' OR ';
		if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'BTO2\' ';
		if (!Test.isRunningTest()) queryStr += ' ) ';
        if (!Test.isRunningTest()) queryStr += filtercourier;
        if (!Test.isRunningTest()) queryStr += filterDate;
        if (!Test.isRunningTest()) queryStr += filterStatus;

        system.debug('## BTO : '+queryStr);

        btoList = new list<bto>();
        for (case cs :Database.query(queryStr))
        {
            countBTO += 1;
            
            bto newdata = new bto();
            newdata.Policy_Number = cs.contact.Policy_No__c; //'';
            newdata.Tujuan_Keluar = '';
            newdata.Lokasi_Custody = '';
            newdata.Tgl_Upload = '';
            
			btoList.add(newdata);
        }

        // == REDEL ==
        //queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr = defaultqueryStr;
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
		if (Test.isRunningTest()) queryStr += ' Type = \'Request\' LIMIT 1';
        if (!Test.isRunningTest()) queryStr += ' Type = \'Request\' AND ';
		if (!Test.isRunningTest()) queryStr += ' ( ';
        if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'Request_Courier Delivery ? Policy Retur\' OR ';
		if (!Test.isRunningTest()) queryStr += ' Case_Type__c = \'Request_Courier Delivery-Surat Retur\' ';
		if (!Test.isRunningTest()) queryStr += ' ) ';
        if (!Test.isRunningTest()) queryStr += filtercourier;
        if (!Test.isRunningTest()) queryStr += filterDate;
        if (!Test.isRunningTest()) queryStr += filterStatus;

        system.debug('## REDEL : '+queryStr);

        redelList = new list<redel>();
        List<Case> ListCS = Database.query(queryStr);
        for (case cs : ListCS)
        {
            countRedel += 1;
            
            redel newdata = new redel();
            newdata.DATA_ID = cs.CaseNumber; //'';
            newdata.REQUEST_NO = cs.CaseNumber; //'';
            newdata.CUSTOMER_NAME = cs.Contact.Name; //'';
            newdata.REQUEST_STATUS = '';
            newdata.RECEIVED_DATE = string.valueof(cs.CreatedDate); //'';
            newdata.CATEGORY = cs.Case_Type__c; //'';
            newdata.REQUESTOR = 'AMFS - DMU Queue';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.COMPLAIN = 'Customer';
            newdata.DESCRIPTION = cs.Description; //'';
            newdata.OTHERINFORMATION = '';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone  +'/'+ cs.Contact.HomePhone; //'';
            newdata.KOTA = '';
            newdata.REMARK_FROM_AXA = '';
            newdata.SENDDATE = string.valueof(date.Today()); //'';
            newdata.STATUS = cs.DMU_STATUS__c; //'';
            newdata.PENERIMA = cs.DMU_PENERIMA__c; //'';
            newdata.HUBUNGAN = cs.DMU_HUBUNGAN__c; //'';
            newdata.TGLTERIMA = cs.DMU_TGLTERIMA__c; //'';
            newdata.REMARK_FROM_NCS = cs.DMU_REMARK_FROM_NCS__c; //'';
            newdata.DATECLOSED = cs.DMU_DATECLOSED__c; //'';
            newdata.STATUSCHS = 'OPEN';
            newdata.KURIR = filterdata.Courier__c;

            redelList.add(newdata);
        }

        // == Policy BTO ==
        BTOJList = new list<PolicyBTO>();

        for (case cs : ListCS){ // Database.query(queryStr)
            string PARAM_SOURCE = 'SFDC';
            string PARAM_REQUEST_ID = '1234567890';
	        String PARAM_TYPE = 'Data Gudang';
            String VALID_FROM_DTTM = ''; //dateConvertStart;//'20210706';
            String VALID_TO_DTTM = ''; //dateConvertEnd;//'20210707';
            //String POLICY_NO = '100-402-0258446'; //'100-712-0935817'; //'100-122-3346529';//'123-4567890'; //'520-3069546'
            String POLICY_NO = cs.Contact.Policy_No__c;//contactPolicyNo;//'100-122-3346529';
            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetail (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO);            
            
            String TempPolicy = '';
            
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
                
                if (TempPolicy != ddm1.policy_number) {
					BTOJList.add(newdata);
                    TempPolicy = ddm1.policy_number;
                }

            }
        }        
    }
    
    public Pagereference exportAll(){
        
        return new Pagereference('/apex/DMU_MANIFEST_ExportToExcel?ExportToExcel=TRUE&DateFrom='+filterdata.Due_Date__c+'&DateTo='+filterdata.Closed_Date__c+'&Courier='+filterdata.courier__c);
     
     
    }

    public list<DataDetail> getDataDetail (string PARAM_SOURCE, string PARAM_REQUEST_ID, String PARAM_TYPE, String VALID_FROM_DTTM, String VALID_TO_DTTM, String POLICY_NO) { 
            // Code EIP Connector - Summary
            try {
                system.debug('#Start Code EIP Connector - Param');
                Map<String,String> params = new Map<String, String>();
                params.put(EIPConstant.PARAM_SOURCE, PARAM_SOURCE); // 'SFDC'
                params.put(EIPConstant.PARAM_REQUEST_ID, PARAM_REQUEST_ID); // '1234567890'
                params.put(EIPConstant.PARAM_TYPE, PARAM_TYPE); // 'ALL'
                params.put(EIPConstant.VALID_FROM_DTTM, VALID_FROM_DTTM); // dateConvertStart
                params.put(EIPConstant.VALID_TO_DTTM, VALID_TO_DTTM); // dateConvertEnd
                
                EIPJson edmuDetailJson;
                if (!Test.isRunningTest()) 
                	edmuDetailJson = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_DETAIL, EIPConstant.ENTITY_AMFS, EIPConstant.APP_EDMU, POLICY_NO, params); // '520-3069546'

                DataList = new list<DataDetail>();
                
                Integer countphDMU = 0;
                if (Test.isRunningTest()) countphDMU = 1;
                else countphDMU = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
                
                system.debug('countphDMU: '+countphDMU);
                for(Integer i=0; i < countphDMU; i++) {
                    DataDetail newdata = new DataDetail();
                    
                    newdata.edmu_type = 'Belum ada Field nya';
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueTypeCD != null){
                    //    newdata.edmu_type = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueTypeCD;
                    //}
                    
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyNO != null){
                        newdata.policy_number = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyNO;
                    }
                    system.debug('newdata.policy_number : '+ newdata.policy_number);
                    system.debug('01 : '+newdata.policy_number);
                                 
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.fullNM != null){
                        newdata.holder_name = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.fullNM;
                    }
                    system.debug('newdata.holder_name : '+ newdata.holder_name);
                    system.debug('02 : '+newdata.holder_name);
                    
                    if (PARAM_TYPE != 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].financialFundRk != null ){
                        newdata.courier_retur_note = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].financialFundRk;
                    }
                    system.debug('15 : '+newdata.courier_retur_note);

                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyTypeCd != null){
                        newdata.policyTypeCode = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyTypeCd;
                    }
                    system.debug('25 : '+newdata.policyTypeCode);                    


                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNo != null ){
                        newdata.warehouse_awb_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNo;
                    }
                    system.debug('26 : '+newdata.warehouse_awb_no);                    

                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'warehouse_courier_name'){
                        newdata.warehouse_courierName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    }                    
                    system.debug('27: '+newdata.warehouse_courierName);                    
                    
                    //if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitType != null ){
                        newdata.warehouse_type = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitType;
                    }
                    //newdata.warehouse_type = '<< Tidak ada Data >>';
                    system.debug('28 : '+newdata.warehouse_type);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].name == 'warehouse_pickup_dt'){
                        newdata.warehouse_pickup_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[1].value;
                    }                    
                    system.debug('29 : '+newdata.warehouse_pickup_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].name == 'warehouse_return_dt'){
                        newdata.warehouse_return_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[2].value;
                    }                    
                    system.debug('30 : '+newdata.warehouse_return_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].name == 'warehouse_receiver_name'){
                        newdata.warehouse_receiverName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[3].value;
                    }                    
                    system.debug('31 : '+newdata.warehouse_receiverName);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRk != null ){
                        newdata.warehouse_btoSource = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRk;
                    }
                    system.debug('32 : '+newdata.warehouse_btoSource);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT != null ){
                        newdata.warehouse_bto_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT;
                    }
                    system.debug('33 : '+newdata.warehouse_bto_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].name == 'warehouse_custody_location'){
                        newdata.warehouse_custodyLocation = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[4].value;
                    }                    
                    system.debug('34 : '+newdata.warehouse_custodyLocation);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate != null ){
                        newdata.warehouse_outbound_dt = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate;
                    }
                    system.debug('35 : '+newdata.warehouse_outbound_dt);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation != null ){
                        newdata.warehouse_outboundDestination = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation;
                    }
                    system.debug('36 : '+newdata.warehouse_outboundDestination);
                    
                    if (PARAM_TYPE == 'Data Gudang')
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].chasisNO != null ){
                        newdata.warehouse_boxFilling_no = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].chasisNO;
                    }
                    //newdata.warehouse_boxFilling_no = '<< Tidak ada Data >>';
                    system.debug('37 : '+newdata.warehouse_boxFilling_no);                    

                    if (PARAM_TYPE == 'Data Gudang')
                    //if(edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].name == 'warehouse_pic_name'){
                    //    newdata.warehouse_picName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value;
                    //}                    
                    if(!Test.isRunningTest() && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[0].value != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name != null && edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].name == 'warehouse_pic_name'){
                        newdata.warehouse_picName = edmuDetailJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].hasNameValue[5].value;
                    }                    

                    system.debug('38 : '+newdata.warehouse_picName);
                    
                    dataList.add(newdata);
                }
                system.debug('dataList: '+dataList);
            } catch(EIPConnector.NoDataException e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
            } catch(EIPConnector.EIPConnectorException e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            } catch(Exception e){ 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
            }
            // End Code EIP Connector
        Return dataList;
    }

}