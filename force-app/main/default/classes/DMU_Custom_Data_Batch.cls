global class DMU_Custom_Data_Batch implements Database.Batchable<string>, Database.Stateful, Database.AllowsCallouts{
    public List<string> l_ba {get;set;}

    public DMU_Custom_Data_Batch(List<string> ba_l) {
        l_ba = ba_l;
    }

    public List<string> start(Database.BatchableContext BS) {
        return this.l_ba;
    }
    
    public void execute(Database.BatchableContext BS, List<string> l_ba) {

        for(String s : l_ba){
            list<string> Param = new list<string>();
            param = s.split(','); // OwnerID,20210706,20210707,1
            
            String PARAM_SOURCE = 'SFDC';
            String PARAM_REQUEST_ID = '1234567890';
            String PARAM_TYPE = 'Data Gudang';
            String VALID_FROM_DTTM = param[1]; //20210706
            String VALID_TO_DTTM = param[2]; // '20210707'
            String POLICY_NO = '';
            String PAGE_NUMBER = param[3]; // 1, 2, 3, 4, ... 
                
            // Execute Call OUt            
            list<DataDetail> GetDataList = new list<DataDetail>();
            GetDataList = getDataDetailBTO (PARAM_SOURCE, PARAM_REQUEST_ID, PARAM_TYPE, VALID_FROM_DTTM, VALID_TO_DTTM, POLICY_NO, PAGE_NUMBER);
            
            integer countBTO = 0;
            list<DMU_Data_Manual__c> BTOJList = new list<DMU_Data_Manual__c>();
            for (DataDetail ddm1 : GetDataList){
                countBTO += 1;
                
                // Insert to Custom Object
                DMU_Data_Manual__c newdata = new DMU_Data_Manual__c();
                newdata.bto_policy_no__c = ddm1.policy_number; 
                newdata.bto_Consignee__c = ddm1.warehouse_receiverName; //ddm1.holder_name;
                newdata.bto_ShipDate__c = ddm1.warehouse_bto_dt; //courier_receive_dt; 
                newdata.bto_TrackingStatus__c = ddm1.warehouse_btoSource; //courier_delivery_status;
                newdata.bto_Recipient__c = ''; //courier_receiver_name; 
                newdata.bto_DatePickUp__c = ddm1.warehouse_pickup_dt; //courier_pickup_dt; 
                newdata.bto_ReturnDate__c = ddm1.warehouse_return_dt; //courier_retur_dt;
                newdata.bto_ReturnReason__c = ddm1.courier_retur_note; //courier_retur_note;
                newdata.bto_ServiceBy__c = ddm1.warehouse_courierName; //courier_courier_name;
                newdata.bto_AWB__c = ddm1.warehouse_awb_no; //courier_awb_no;
                newdata.bto_ConsigneeAddress__c = ddm1.warehouse_custodylocation; //courier_address;
                newdata.bto_warehouse_outbound_dt__c = ddm1.warehouse_outbound_dt;
                newdata.bto_warehouse_outboundDestination__c = ddm1.warehouse_outboundDestination;
                newdata.bto_warehouse_boxFilling_no__c = ddm1.warehouse_boxFilling_no;
                newdata.bto_warehouse_picName__c = ddm1.warehouse_picName;
                newdata.bto_policyTypeCode__c = ddm1.policyTypeCode;
                newdata.bto_warehouse_type__c = ddm1.warehouse_type;
                newdata.bto_pagenumber__c = PAGE_NUMBER;
                id OwnerId = id.valueof(param[0]);
                newdata.OwnerId = OwnerId;

                BTOJList.add(newdata);
                
            }
            if (BTOJList.size() > 0) insert BTOJList;
            
            
        }  
        
    }
    
    public void finish(Database.BatchableContext BS) {
        
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
    
    public list<DataDetail> getDataDetailBTO (string PARAM_SOURCE, string PARAM_REQUEST_ID, String PARAM_TYPE, String VALID_FROM_DTTM, String VALID_TO_DTTM, String POLICY_NO, String PAGE_NUMBER) { 
            // Code EIP Connector - Summary
        list<DataDetail> DataList = new list<DataDetail>();

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

                // TestClass
                newdata.holder_name = '';
                newdata.linkExpired_dt = '';
                newdata.issue_dt = '';
                newdata.delivery_method = '';
                newdata.document_type = '';
                newdata.courier_delivery_status = '';
                newdata.courier_courier_name = '';
                newdata.courier_awb_no = '';
                newdata.courier_receiver_name = '';
                newdata.courier_address = '';
                newdata.courier_pickup_dt = '';
                newdata.courier_receive_dt = '';
                newdata.courier_retur_dt = '';
                newdata.courier_note = '';
                newdata.sms_phone_number = '';
                newdata.sms_delivery_dt = '';
                newdata.sms_download_dt = '';
                newdata.sms_sms_status = '';
                newdata.email_email_address = '';
                newdata.email_delivery_dt = '';
                newdata.email_download_dt = '';
                newdata.email_email_status = '';
                newdata.sms_issueTypeCD = '';
                // End TestClass
                
                //*
                newdata.edmu_type = 'Belum ada Field nya';
                
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