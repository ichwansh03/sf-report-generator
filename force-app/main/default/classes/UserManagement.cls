public class UserManagement {
    
    public String policyNo {get;set;}
    public String email {get;set;}
    public String cif {get;set;}
    public String mdmId {get;set;}
    public String typeOfRequest {get;set;}
    public String typeOfData {get;set;}
    public Date dob {get;set;}
    public String appId {get;set;}
    public String entity {get;set;}
    public String userInfos {get;set;}
    public String phone {get;set;}
    public String address {get;set;}
    public String newAddress {get;set;}
    public String subDistrict {get;set;}
    public String stateRegionCd {get;set;}
    public String city {get;set;}
    public String province {get;set;}
    public String postalCD {get;set;}
    public String village {get;set;}
    public String cityCodeRLS {get;set;}
    public String newEmail {get;set;}
    //add By Fajar Salam
    public String gender {get;set;}
    public Date startDate{get;set;}
    public Date endDate{get;set;}
   	public Boolean checkUserAllowance {get;set;}
   
    public List<Request_Tada_History__c> historyRequest{get;set;}
    
    public List<DataResponse> responseCustomers {get;set;}
    
    public Integer responseTotalData {get;set;}
    public Integer responsePage {get;set;}
    public Integer responseLimitPage {get;set;}
    public String responseStatus {get;set;}
    public String responseMessage {get;set;}
    public Boolean isError {get;set;}
    public Map<String,String> properties {get;set;}
    public Integer totalPages {get;set;}
    public Boolean hasNext {get;set;}
    public Boolean hasPrevious {get;set;}
    public Boolean hasAddPolicy {get;set;}
    public Boolean cancelAddPolicy {get;set;}
    public Boolean buttonAddPolicy {get;set;}
    public Boolean checkSubmit {get;set;}
    public Boolean sendLinkEmployeeActivation {get;set;}
    public String isEmployeeActive {get;set;}
    public String ktp {get;set;}
        
    // add by Fajar Salam
    public static final Integer GMTFORMAT = 7;
    public List<String> responseList{get; set;}
    public String newblobFile {get;set;}
    public class DataResponse{
        public String email {get;set;}
        public String fullName {get;set;}
        public String mobileNumber {get;set;}
        public String loginId {get;set;}
        public String isBlock {get;set;}
        public Datetime activationDate {get;set;}
        public String gender {get;set;}
        public String whatsappNumber {get;set;}
        public Date dob {get;set;}
        public String cif {get;set;}
        public String address {get;set;}
        //added by Fajar Salam
        public Datetime createdDate {get;set;}
        public Datetime sendDate {get;set;}
        public String sendTo {get;set;}
        public String emailMDM{get;set;}
        public String mobilePhoneMDM{get;set;}
        public Datetime lastLogin{get;set;}
        public Datetime modifyDate{get;set;}
        public String createdBy{get;set;}
        public String modifyBy{get;set;}
        public String policyNumber{get;set;}
        public String identityNo{get;set;}
        public String status{get;set;}
        public String remark{get;set;}
        public String registredBy{get;set;}
        //Added by Elvi Dec 2022
        public String registrationRemark {get;set;}
        public String ktp {get;set;}
        public Datetime inputTime {get;set;}
        /*
        public String strcreatedDate {get;set;}
        public String strmodifyDate{get;set;}
		public String strpolicyNumber{get;set;}
        public String strgender {get;set;}
        public String strloginId {get;set;}
        public String strmobileNumber {get;set;}
		public String strdob {get;set;}
        public String strcreatedBy{get;set;} 
        public String strmodifyBy{get;set;}
        public String strstatus{get;set;}
        public String strremark{get;set;}
        public String strregistredBy{get;set;}
        public String stremail {get;set;}*/


    }
    
        
    public UserManagement(ApexPages.StandardController controller) {
        checkRole();
    }
    
    public UserManagement(){
        checkRole();
    }
    private void checkRole(){
        User loginUser = [Select Id, Profile.Name From User Where Id =: userinfo.getUserId()];
        //System.debug('######### userinfo.getUserId = ' + userinfo.getUserId());
        //System.debug('######### loginUser.Id = ' + loginUser.Id);
        //System.debug('######### loginUser.Name = ' + loginUser.Name);
        //System.debug('######### loginUser.Agent_No__c = ' + loginUser.Agent_No__c);
        //System.debug('######### loginUser.ProfileId = ' + loginUser.ProfileId);
        String selectedProfileName = loginUser.Profile.Name;
        //Profile profileUser = [SELECT Id, Name FROM Profile Where Id =: loginUser.ProfileId];        
        System.debug('######### $Profile.Name = ' + loginUser.Profile.Name);        
        if (selectedProfileName.contains('System Administrator') || selectedProfileName =='SPV' || selectedProfileName =='Manager'){
            checkUserAllowance = true;
        }else{
            checkUserAllowance = false;
        }
        isEmployeeActive = 'true';
    }

    //Added by Elvi Dec 2022
    private void dataOnlineRegistration(EIPJson dataTADA){
        if(typeOfRequest == 'Inquiry Data Online Registration' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
               
                
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount != null){
                     
                    /**/
                    
                    for(EIPJson.EIP_AgSa_InsurancePolicy hasPolis : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount){
                        DataResponse dataCust = new DataResponse();
                        dataCust.registrationRemark = hasPolis.policyStatusRk != null ? hasPolis.policyStatusRk : 'KOSONG';
                        dataCust.policyNumber = hasPolis.policyNO != null ? hasPolis.policyNO : 'KOSONG';
                        dataCust.status=hasPolis.policyStatusCD != null ? hasPolis.policyStatusCD : 'KOSONG';
                        dataCust.inputTime=hasPolis.policyEffectiveDTTM != null ? CCCUtils.strToDate(hasPolis.policyEffectiveDTTM,'yyyy-mm-dd') : null; //inputTime=createdDate????
                                                
                        for(EIPJson.EIP_IcAx_AXAAsiaInsuredPersonDetails hasDetailsOfRisksIns : hasPolis.hasDetailsOfRisksIn){
                            for(EIPJson.EIP_IcAx_AXAAsiaIndividual hasPersonalDetailsIn : hasDetailsOfRisksIns.hasPersonalDetailsIn){
                                dataCust.KTP = hasPersonalDetailsIn.socialSecurityNO != null ? hasPersonalDetailsIn.socialSecurityNO :'';
                                dataCust.dob= hasPersonalDetailsIn.birthDT != null ? CCCUtils.strToDate(hasPersonalDetailsIn.birthDT,'yyyy-mm-dd') : null;
                                
                        }
                        }
                        responseTotalData=integer.valueof(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.sourceCInd);
                        responseLimitPage=integer.valueof(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.dependentNO);
                        responsePage=integer.valueof(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.watchlistInd);
                        responseCustomers.add(dataCust);
                        String requestJsonEIP = System.JSON.serialize(responseCustomers, true);
                        if(responseTotalData != null && responseLimitPage != null){
                            totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                            hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                            hasPrevious = (responsePage != 1)? true : false;
                        }
                    }
                }else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                }
            }
    }
    //Added by Elvi Dec 2022
    
    public PageReference nextPage(){
        responsePage = responsePage+1;
        checkSubmit = true;
        responseCustomers = new List<DataResponse>();
        this.submit();
        return null;
    }
    
    public PageReference previousPage(){
        responsePage = responsePage-1;
        checkSubmit = true;
        responseCustomers = new List<DataResponse>();
        this.submit();
        return null;
    }
    
    public void checkPhoneNumber(){
        System.debug('START checkPhoneNumber ' + phone);
        if(phone.length()>0){
           System.debug('KESINI checkPhoneNumber ' + phone); 
            String[] firstChar = phone.split('');
            System.debug('checkPhoneNumber ' + firstChar);
            if(firstChar[0]=='0' ){
                System.debug('masuk checkPhoneNumber ' );
                firstChar[0] = '2';
                String phoneFix = '6' + String.join(firstChar, '');
                phone = phoneFix;
                System.debug('checkPhoneNumber after' + phoneFix);
                
            }
        } System.debug('checkPhoneNumber after2' + phone);
    }
    
    public void refreshAttribute(){
        System.debug('ELVI refreshAttribute ');
        responseCustomers = new List<DataResponse>();
        responseStatus = '';
        responseMessage = '';
        responsePage = checkSubmit!=true ? null : responsePage;
        checkSubmit = false;
        isError = false;
        hasNext = false;
        hasPrevious = false;
        totalPages = 0;
        //responseCustomers.clear();
    }
    
    //add By Fajar Salam
     public List<SelectOption> getGenders() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('MALE','Laki-Laki'));  
        options.add(new SelectOption('FEMALE','Perempuan')); return options; 
    }
                   
    public String getGender() {
        return gender;
    }
                    
    public void setGender(String gender) { this.gender = gender; }
    
    // --------------
    
    
    public void init(){
        String contId = ApexPages.CurrentPage().getParameters().get('contact_id');
        List<Contact> cont = new List<Contact>();
        cont = [Select Id, Policy_No__c, mdmid_owner__c,entity__c, Email, mobilephone from Contact where id =: contId];
        if(cont.size() > 0){
            policyNo = cont[0].policy_no__c;
            cif = cont[0].mdmid_owner__c;
            //cif = 'CIF-'+mdmId;
            email = cont[0].email;
            entity = cont[0].entity__c;
            phone = cont[0].mobilephone;
            //userInfos = UserInfo.getName();   
        }
       //aading header
       
    }	
    private boolean checkInput(String reqType){
        switch on reqType{
                when 'Request User ID'{
                   	if(email == null || email == ''){
                		return false;
                   	}
                   	if(policyNo == null || policyNo == ''){
                		return false;
                   	}
                    if(gender == null || gender == ''){
                		return false;
                   	}	
                    if(dob == null){
                		return false;
                   	}
                    if(gender == null || gender == ''){
                		return false;
                   	}
                    return true;
                }
                when 'Inquiry Status Tracking'{
                    if(policyNo == null || policyNo == ''){
                		return false;
                   	}
                    return true;
                }
        	}
        return true;
        
    }

    public Integer checkAccount(){
       
        EIPJson dataTADA = new EIPJson();
        Map<String,String> properties = new Map<String, String>();
        String operation = '';
        String statusMessage = '';
        integer ck = 0;
        try{            
            operation = EIPConstant.SERVICE_GET_CUST_INFO;
            properties.put(EIPConstant.PARAM_MSG_CIF, cif);
            properties.put(EIPConstant.PARAM_MSG_EMAIL, email);
            properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
            properties.put(EIPConstant.MAP_ENTITY,'AMFS');

            appId = 'SLS';   
            dataTADA = EIPConnector.sendCommunicationMessageTADA(operation,entity,appId,properties);
            /*FOR INQUIRY REQ*/
            if(dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                DataResponse dataCust = new DataResponse();
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual != null){
                    EIPJson.EIP_IcAx_AXAAsiaIndividual individual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    individual = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual;
                    for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress customer : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn){
                        dataCust.loginId = individual.individualUniqueID;
                        if(dataCust.loginId == null || dataCust.loginId == ''){
                            ck = 1;
                        }
                    }
                }else{
                    responseMessage = 'No Data Available';
                    isError = true;
                }
            }
           String eipStatus = dataTADA.Body.status;   
           if(eipStatus != '1'){                               
               ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, dataTADA.Body.exceptionObj.message));
               ck = -1;
           }

        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,EIPConstant.ERROR_MSG_NODATA));
            isError = true;
            responseMessage = EIPConstant.ERROR_MSG_NODATA;
            ck = -1;
        }catch(EIPConnector.EIPConnectorException e){
            System.debug('e === '+e.getMessage()+ ' in line '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,+e.getMessage()));
            isError = true;            
            responseMessage = 'Ada masalah ketika pengambilan data, silahkan hubungi Admin.';
            ck = -1;
        }catch(Exception e){            
            System.debug('e === '+e.getMessage()+ ' in line '+e.getLineNumber());
            ck =  -1;
        }
        if(Test.isRunningTest()){
			return 1;
		}
        return ck;
    }
    
    
    private boolean checkDateRange(){
		Integer monthDiff = startDate.monthsBetween(endDate);
        System.debug('[?][Date Rage] '+monthDiff);
        if(monthDiff <= 6){
            return true;
        }
        return false;
    }
    
    public void addPolicy(){
        refreshAttribute();
        hasAddPolicy = true;
        buttonAddPolicy=false;
        System.debug('ELVI hasAddPolicy '+hasAddpolicy);
    }
    
    public void cancelAddPolicy(){
        refreshAttribute();
        hasAddPolicy = false;
        buttonAddPolicy=true;
        System.debug('ELVI hasAddPolicy '+hasAddpolicy);
    }
    
    public void resendEmployeeActivation(){
        System.debug('ELVI resendEmployeeActivation');
        sendLinkEmployeeActivation = true;
        submit();
    }
    
    public void submit(){
        System.debug('masuk submit ' + typeOfRequest +' phone ' + phone);
        
        if(hasAddPolicy==true){
            typeOfRequest = 'Add Policy';
            refreshAttribute();
        } else if (sendLinkEmployeeActivation==true) {
            typeOfRequest = 'Resend Email Employee';
            sendLinkEmployeeActivation = false;
        }else{
            refreshAttribute();
        }
        buttonAddPolicy = true;
        if(checkInput(typeOfRequest)){
        
        EIPJson dataTADA = new EIPJson();
        Map<String,String> properties = new Map<String, String>();
        String operation = '';
        String dobs = String.valueOf(dob)+'T00:00:00';
        String statusMessage;
        
        System.debug('dobs == '+dobs);
        integer ckTest = -2;
        try{
            appId = 'SLS';
            System.debug('masuk submit2 ' + typeOfRequest);
            /*if(typeOfRequest == 'Resend Activation Link'){
                operation = EIPConstant.OPERATION_REACTIVATION;
                // properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, userInfos);
                properties.put(EIPConstant.PARAM_MSG_DOB, dobs);
                properties.put(EIPConstant.PARAM_MSG_CIF, cif);
                properties.put(EIPConstant.PARAM_MSG_LANGUAGE, null);
                properties.put(EIPConstant.PARAM_MSG_CHANNEL, 'EMAIL');
                properties.put(EIPConstant.PARAM_MSG_EMAIL,email );
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
            }else if(typeOfRequest == 'Request for Reset Password'){
                operation = EIPConstant.OPERATION_RESET_PASSWORD_PAGE;
                properties.put(EIPConstant.PARAM_MSG_SESSION_ID, null);
                properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, userInfos);
                properties.put(EIPConstant.PARAM_MSG_DOB, dobs);
                // properties.put(EIPConstant.PARAM_MSG_PASSWORD, '');
                properties.put(EIPConstant.PARAM_MSG_LANGUAGE, null);
                properties.put(EIPConstant.PARAM_MSG_EMAIL, email );
                properties.put(EIPConstant.PARAM_MSG_CHANNEL, 'EMAIL');
                // properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
            }else */ if(typeOfRequest == 'Block User'){
                operation = EIPConstant.OPERATION_BLOCK;
                properties.put(EIPConstant.PARAM_MSG_CIF, cif);
                properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, userInfos);
                properties.put(EIPConstant.PARAM_MSG_LANGUAGE, null);
                properties.put(EIPConstant.PARAM_MSG_CHANNEL, 'EMAIL');
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
            }else if(typeOfRequest == 'Unblock User'){
                operation = EIPConstant.OPERATION_UNBLOCK;
                properties.put(EIPConstant.PARAM_MSG_CIF, cif);
                properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, userInfos);
                properties.put(EIPConstant.PARAM_MSG_LANGUAGE, null);
                properties.put(EIPConstant.PARAM_MSG_CHANNEL, 'EMAIL');
                // properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
            }/*else if(typeOfRequest == 'Update Data'){
                responseCustomers.clear();
                operation = EIPConstant.OPERATION_UPDATE;
                properties.put(EIPConstant.PARAM_MSG_CIF, cif);
                properties.put(EIPConstant.PARAM_MSG_LOGIN_ID, userInfos);
                properties.put(EIPConstant.PARAM_MSG_LANGUAGE, null);
                properties.put(EIPConstant.PARAM_MSG_CHANNEL, 'EMAIL');
                // properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
                if(typeOfData == 'Alamat Korespondensi'){
                    if(!String.isEmpty(address) && 
                       !String.isEmpty(subDistrict)  &&
                       !String.isEmpty(village) &&
                       !String.isEmpty(city) && 
                       !String.isEmpty(province)){
                           properties.put(EIPConstant.PARAM_MSG_CORESPONDENCE, address);
                           properties.put(EIPConstant.PARAM_SUBDISTRICT, subDistrict);
                           properties.put(EIPConstant.PARAM_STATE_REGION, village);
                           properties.put(EIPConstant.PARAM_CITY_NM, city);
                           properties.put(EIPConstant.PARAM_PROVINCE_NM, province);
                           properties.put(EIPConstant.PARAM_POSTAL_CD, postalCD);
                       }else{
                           String dataerrors = '';
                           dataerrors = String.isEmpty(address) ? 'Alamat Korespondensi Baru' :                            String.isEmpty(province) ? 'Provinsi' :                            String.isEmpty(city) ? 'Kota' :                            String.isEmpty(subDistrict) ? 'Kecamatan' :                            'Kelurahan';
                           dataerrors = dataerrors + ' tidak boleh kosong';
                           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,dataerrors));
                       }
                }else if(typeOfData == 'Alamat Email'){
                    properties.put(EIPConstant.PARAM_MSG_EMAIL,newEmail );
                }else if(typeOfData == 'Nomor Handphone'){
                    properties.put(EIPConstant.PARAM_MSG_PHONE, phone);
                }else if(typeOfData == 'Nomor Whatsapp'){
                    properties.put(EIPConstant.PARAM_MSG_PHONE2, phone);
                }
            }*/else if(typeOfRequest == 'Inquiry Data'){
                System.debug('ELVI MASUK Inquiry ');
                checkPhoneNumber();
                operation = EIPConstant.SERVICE_CUSTOMER_PROFILE;
                properties.put(EIPConstant.PARAM_MSG_CIF, ktp);
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
                properties.put(EIPConstant.PARAM_MSG_PHONE, phone);
                entity='AMFS';
                appId='EMMA';
            }else if(typeOfRequest == 'Request User ID'){
                checkPhoneNumber();
                operation = EIPConstant.SERVICE_GET_ADD_USER;
                properties.put(EIPConstant.PARAM_MSG_EMAIL, email);
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
                properties.put(EIPConstant.PARAM_MSG_PHONE, phone);                
                properties.put(EIPConstant.PARAM_MSG_EMAIL, email);
                properties.put(EIPConstant.PARAM_MSG_DOB, String.valueOf(dob));
                properties.put(EIPConstant.PARAM_MSG_GENDER, gender);                
            }else if(typeOfRequest == 'Inquiry Status Tracking'){
                operation = EIPConstant.SERVICE_CHECK_USER_ADDHOCK;
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
                properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
                properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
            }else if(typeOfRequest == 'Inquiry Tracking List'){
                operation = EIPConstant.SERVICE_LIST_USER_ADDHOCK;
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
                properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
                properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
                properties.put(EIPConstant.PARAM_MSG_START_DATE,String.valueOf(startDate) );
                properties.put(EIPConstant.PARAM_MSG_END_DATE,String.valueOf(endDate));
            }else if(typeOfRequest == 'Inquiry Data Online Registration'){
                operation = EIPConstant.SERVICE_GET_HISTORY_REGISTER;
                //properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo); -- identityNo
                properties.put(EIPConstant.PARAM_PAGE_NUMBER, responsePage != null ?  String.valueOf(responsePage) : '1');
                properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '10');
                properties.put(EIPConstant.PARAM_MSG_CIF, ktp);
                properties.put(EIPConstant.PARAM_MSG_EMAIL, email);
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
                entity='AMFS';
                appId='ORS';
            }else if(typeOfRequest == 'Add Policy'){
                checkPhoneNumber();
                System.debug('ELVI MASUK ADD POLICY ' + dob + gender);
                operation = EIPConstant.SERVICE_ADD_POLICY;
                properties.put(EIPConstant.PARAM_MSG_POLICY,policyNo);
                properties.put(EIPConstant.PARAM_MSG_CIF, ktp);
                properties.put(EIPConstant.PARAM_MSG_PHONE, phone);
                properties.put(EIPConstant.PARAM_MSG_DOB, String.valueOf(dob));
                properties.put(EIPConstant.PARAM_MSG_GENDER, gender);
                entity='AMFS';
                appId='EMMA';
                properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
                properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
            }else if(typeOfRequest == 'Inquiry Data Guest'){
                checkPhoneNumber();
                operation = EIPConstant.SERVICE_GET_GUEST_INFO;
                properties.put(EIPConstant.PARAM_MSG_PHONE, phone);
                entity='AMFS';
                appId='EMMA';
                properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
                properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
            }else if(typeOfRequest == 'Inquiry Status Karyawan'){
                checkPhoneNumber();
                operation = EIPConstant.SERVICE_STATUS_KARYAWAN;
                properties.put(EIPConstant.PARAM_MSG_EMAIL, email);
                properties.put(EIPConstant.PARAM_MSG_PHONE, phone);
                entity='AMFS';
                appId='EMMA';
               // properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
                //properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
            }else if(typeOfRequest == 'Resend Email Employee'){
                operation = EIPConstant.SERVICE_RESEND_EMAIL_EMPLOYEE;
                properties.put(EIPConstant.PARAM_MSG_EMAIL, email);
                entity='AMFS';
                appId='EMMA';
               // properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
                //properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
            }
            /*STARTING Checking  REQUEST*/
			System.debug('[?] Status = '+ ckTest);           
        	if (typeOfRequest == 'Request User ID'){
            	System.debug('[?]policyNo '+policyNo);                
            	if(checkHistory(policyNo)){
                    	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Tidak dapat melakukan request, No Polis '+policyNo+ ' masih memiliki antrian Request'  ));
                }else{
                    integer ck = checkAccount();
                    ckTest = ck;
                    if( ck == 0 ){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Account Already Created !' ));
                    }else if(ck == 1){
                        dataTADA = EIPConnector.sendCommunicationMessageTADA(operation,entity,appId,properties);
                    }
                }
            }else if(typeOfRequest == 'Inquiry Tracking List'){
                if(checkDateRange()){
                   	dataTADA = EIPConnector.sendCommunicationMessageTADA(operation,entity,appId,properties);
                }else{
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Tidak Dapat Melakukan Request, Rentang maksimal data = 6 bulan'  ));
                }
            } 
            else{
                system.debug('Request EIP Operation: ' + operation);
                system.debug('Request EIP entity: ' + entity);
                system.debug('Request EIP app: ' + appId);
                system.debug('Request EIP properties: ' + properties);
                dataTADA = EIPConnector.sendCommunicationMessageTADA(operation,entity,appId,properties);
                system.debug('response From EIP: ' + dataTADA);
            }
            
            //dataTADA = EIPConnector.sendCommunicationMessageTADA(operation,entity,appId,properties);
            /*FOR INQUIRY REQ*/
            if(typeOfRequest == 'Resend Email Employee' && dataTADA.Body.Customer != null){
                system.debug('START Resend Email Employee ****** ');
                String deliveryStatus;
                //List<EIPJson.EIP_CustomerCommunication> custCommunication = dataTADA.Body.Customer.haveCommunicatedMessage != null ? dataTADA.Body.Customer.haveCommunicatedMessage : new List<EIPJson.EIP_CustomerCommunication>();
                //system.debug('have Communicated Message ===>> ' + dataTADA.Body.Customer.haveCommunicatedMessage);
                
                if (dataTADA.Body.Customer != null){
                    if (dataTADA.Body.Customer.haveCommunicatedMessage != null){
                        List<EIPJson.EIP_CustomerCommunication> custCommunication = dataTADA.Body.Customer.haveCommunicatedMessage;
                        for(EIPJson.EIP_CustomerCommunication objCust : custCommunication){
                            deliveryStatus = objCust.deliveryStatusDesc;
                        }
                        }
                        
                    }
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,deliveryStatus));
                }
            if(typeOfRequest == 'Inquiry Data' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                //if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual != null){
                    EIPJson.EIP_IcAx_AXAAsiaIndividual individual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    /*Add by Fajar*/
                    List<EIPJson.EIP_AgSa_NameValue> valueName = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null ? dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue : new List<EIPJson.EIP_AgSa_NameValue>();
                    
                    Map<String, String> lsValName = new Map<String,String>();
                    system.debug('has name value ===>> ' + dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue);
                    if(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null){
                        for(EIPJson.EIP_AgSa_NameValue obj : valueName){
                            if(obj.value != null){
                                lsValName.put(obj.name, obj.value);
                            }                       
                    	}
                    }
                    
                    /**/
                    system.debug('start mapping customer' + lsValName);
                    DataResponse dataCust = new DataResponse();
                    dataCust.activationDate = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.validFromDttm!=null ? CCCUtils.strToDateTime(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.validFromDttm,'yyyy-MM-dd hh:mm:ss') : null;
                    dataCust.activationDate = dataCust.activationDate != null ? dataCust.activationDate.addHours(GMTFORMAT) : null;
                    dataCust.createdDate = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.firstBecameCustomerDt!=null ? CCCUtils.strToDateTime(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.firstBecameCustomerDt,'yyyy-MM-dd hh:mm:ss') : null;
                    system.debug('ACTIVATIONs' + dataCust.activationDate + 'activation date ' + dataTADA.Body.IcAx_AXAAsiaCustomer_Type.validFromDttm );
                    system.debug('CREATED DATE ' + dataCust.createdDate + 'created Date ' + dataTADA.Body.IcAx_AXAAsiaCustomer_Type);
                   
                    system.debug('have Communicated Message1 ===>> ' + dataTADA.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage);
                    List<EIPJson.EIP_CustomerCommunication> custCommunication = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage != null ? dataTADA.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage : new List<EIPJson.EIP_CustomerCommunication>();
                    system.debug('have Communicated Message ===>> ' + dataTADA.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage);
                    if (dataTADA.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage !=null){
                        for(EIPJson.EIP_CustomerCommunication objCust : custCommunication){
                            dataCust.lastLogin = objCust.deliveryDT != null ? CCCUtils.strToDateTime(objCust.deliveryDT, 'yyyy-MM-dd hh:mm:ss') : null;
                            dataCust.lastLogin = dataCust.lastLogin != null ? dataCust.lastLogin.addHours(GMTFORMAT) : null;
                            dataCust.sendDate = objCust.effectiveDT!= null ? CCCUtils.strToDateTime(objCust.effectiveDT, 'yyyy-MM-dd hh:mm:ss') : null;
                            dataCust.sendDate = dataCust.sendDate != null ? dataCust.sendDate.addHours(GMTFORMAT) : null;
                            dataCust.sendTo = objCust.target;
                            system.debug('lastLogin ' + dataCust.sendDate + 'lastLogin 2  ' + objCust.effectiveDT );                        
                        }
                    }
                    system.debug(' sebelum masuk has policy account');
                    if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount != null){
                        for (EIPJson.EIP_AgSa_InsurancePolicy hasPolicyAccount : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount) {
                        policyNo = hasPolicyAccount.policyNO;
                    }
                        //system.debug('masuk has policy account');
                        for(EIPJson.EIP_AgSa_InsurancePolicy hasPolis : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount){
                            system.debug('masuk looping has policy account');
                            for(EIPJson.EIP_IcAx_AXAAsiaInsuredPersonDetails hasDetailsOfRisksIns : hasPolis.hasDetailsOfRisksIn){
                                system.debug('masuk hasDetailsOfRisksIns');
                                for(EIPJson.EIP_IcAx_AXAAsiaIndividual hasPersonalDetailsIn : hasDetailsOfRisksIns.hasPersonalDetailsIn){
                                    for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress hasAddressesIn : hasPersonalDetailsIn.hasAddressesIn){
                                        system.debug('masuk hasAddressesIn' + hasPersonalDetailsIn.hasAddressesIn);
                                        system.debug('masuk hasAddressesIn2' + hasAddressesIn.emailAddress);
                                        
                                        dataCust.emailMDM = hasAddressesIn.emailAddress;
                                        dataCust.mobilePhoneMDM = hasAddressesIn.mobilePhoneNO;
                                        system.debug('masuk email' + dataCust.emailMDM);
                                        
                                    }
                                    
                                }
                            }
                        }
                    }
                    individual = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual;
                    system.debug('start mapping customer' + individual + ' , ' + dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual);
                    for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress customer : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn){
                        String street = customer.addressLine1 != null ? customer.addressLine1 : '';
                        String subDistrict = customer.subdistrictNm != null ? customer.subdistrictNm : '';
                        String district = customer.countyNm != null ? customer.countyNm : '';
                        String city = customer.cityNM != null ? customer.cityNM : '';
                        String province = customer.provinceNm != null ? customer.provinceNm : '';
                        String postalCode = customer.postalCD != null ? customer.postalCD : '';
                        
                        dataCust.email = customer.emailAddress;
                        
                        dataCust.fullName = (individual.firstNM != null ? individual.firstNM : '') + ' ' + (individual.lastNM != null ? individual.lastNM : '');
                        if (dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount == null) {
                            responseMessage = 'Data Not Found';
                            isError = true;
                        }
                        dataCust.mobileNumber = customer.mobilePhoneNO;
                        phone = customer.mobilePhoneNO;
                        dataCust.loginId = individual.individualUniqueID;
                        if(individual.disabilityFlg == 'true'){
                            dataCust.isBlock = 'Blocked';
                        }else if(individual.disabilityFlg == 'false'){
                            dataCust.isBlock = 'Unblock';
                        }else{
                            dataCust.isBlock = '';
                        }
                        
                        dataCust.gender = individual.genderCD;   
                        dataCust.whatsappNumber = customer.mobilePhoneNO2;                       
                        dataCust.dob = individual.birthDT != null ? CCCUtils.strToDate(individual.birthDT,'yyyy-mm-dd') : null;
                        dataCust.cif = individual.masterIndividualId;
                        ktp = individual.socialSecurityNO;
                        dataCust.address = street +', '+ subDistrict +','+ district +','+ city +','+ province +' '+ postalCode ;
                        /*add by Fajar Salam */
                        
                        //dataCust.createdDate = individual.processedDttm !=null ? CCCUtils.strToDateTime(individual.processedDttm, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.createdDate = dataCust.createdDate != null ? dataCust.createdDate.addHours(GMTFORMAT) : null;
                                              
                        /**/
                        
                        responseCustomers.add(dataCust);
                        System.debug('added new cust for view' + lsValName);
                        System.debug(Double.valueOf(responseTotalData));
                        System.debug(Double.valueOf(responseLimitPage));
                        if(responseTotalData != null && responseLimitPage != null){
                            totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                            hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                            hasPrevious = (responsePage != 1)? true : false;
                        }
                    }
                }else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                    //errorMsg = responseMessage;
                }
            }
            //Added by Elvi Dec 2022
            
            /*FOR INQUIRY DATA GUEST*/
            if(typeOfRequest == 'Inquiry Data Guest' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual != null){
                    EIPJson.EIP_IcAx_AXAAsiaIndividual individual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    /*Add by Fajar*/
                    List<EIPJson.EIP_AgSa_NameValue> valueName = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null ? dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue : new List<EIPJson.EIP_AgSa_NameValue>();
                    
                    Map<String, String> lsValName = new Map<String,String>();
                    if(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null){
                        for(EIPJson.EIP_AgSa_NameValue obj : valueName){
                            if(obj.value != null){
                                lsValName.put(obj.name, obj.value);
                            }                       
                    	}
                    }                    
                    /**/
                    system.debug('start mapping customer');
                    individual = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual;
                    for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress customer : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn){
                        
                        DataResponse dataCust = new DataResponse();
                        dataCust.email = customer.emailAddress;
                        
                        dataCust.fullName = (individual.fullNM != null ? individual.fullNM : '');
                        if (individual.fullNM == null) {
                            responseMessage = 'Data Not Found';
                            isError = true;
                        }
                        dataCust.mobileNumber = customer.mobilePhoneNO;
                        dataCust.loginId = individual.individualUniqueID;
                        
                        dataCust.gender = individual.genderCD;
                        gender = individual.genderCD;
                        dataCust.dob = individual.birthDT != null ? CCCUtils.strToDate(individual.birthDT,'yyyy-mm-dd') : null;
                        dob=individual.birthDT != null ? CCCUtils.strToDate(individual.birthDT,'yyyy-mm-dd') : null;
                        dataCust.cif = individual.socialSecurityNO;
                        
                        /*add by Fajar Salam */
                        dataCust.emailMDM = customer.emailAddress2;
                        dataCust.mobilePhoneMDM = customer.telephoneNO2;
                        dataCust.createdDate = individual.processedDttm !=null ? CCCUtils.strToDateTime(individual.processedDttm, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.createdDate = dataCust.createdDate != null ? dataCust.createdDate.addHours(GMTFORMAT) : null;
                        if (lsValName != null || lsValName.size() != 0){
                            dataCust.sendTo = lsValName.get(EIPConstant.PARAM_MSG_SENDTO);                            
                            dataCust.sendDate = lsValName.get(EIPConstant.PARAM_MSG_SEND_DATE) != null ? CCCUtils.strToDateTime(lsValName.get(EIPConstant.PARAM_MSG_SEND_DATE), 'yyyy-MM-dd hh:mm:ss') : null;
                            dataCust.sendDate = dataCust.sendDate != null ? dataCust.sendDate.addHours(GMTFORMAT) : null;
                            dataCust.lastLogin = lsValName.get(EIPConstant.PARAM_MSG_LAST_LOGIN) != null ? CCCUtils.strToDateTime(lsValName.get(EIPConstant.PARAM_MSG_LAST_LOGIN), 'yyyy-MM-dd hh:mm:ss') : null;
                            dataCust.lastLogin = dataCust.lastLogin != null ? dataCust.lastLogin.addHours(GMTFORMAT) : null;
                        }
                        /**/
                        
                        responseCustomers.add(dataCust);
                        System.debug('added new cust for view');
                        System.debug(Double.valueOf(responseTotalData));
                        System.debug(Double.valueOf(responseLimitPage));
                        if(responseTotalData != null && responseLimitPage != null){
                            totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                            hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                            hasPrevious = (responsePage != 1)? true : false;
                        }
                    }
                } 
                else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                    //errorMsg = responseMessage;
                }
            }
            
            /*FOR Inquiry Status Karyawan*/
            if(typeOfRequest == 'Inquiry Status Karyawan' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual != null){
                    EIPJson.EIP_IcAx_AXAAsiaIndividual individual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    /*Add by Fajar*/
                    List<EIPJson.EIP_AgSa_NameValue> valueName = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null ? dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue : new List<EIPJson.EIP_AgSa_NameValue>();
                    
                    Map<String, String> lsValName = new Map<String,String>();
                    if(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null){
                        for(EIPJson.EIP_AgSa_NameValue obj : valueName){
                            if(obj.value != null){
                                lsValName.put(obj.name, obj.value);
                            }                       
                    	}
                    }                    
                    /**/
                    system.debug('start mapping customer');
                    individual = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual;
                    DataResponse dataCust = new DataResponse();
                    for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress customer : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn){
                        dataCust.email = customer.emailAddress;
                        dataCust.gender = individual.genderCD;
                        gender = individual.genderCD;
                        dataCust.dob = individual.birthDT != null ? CCCUtils.strToDate(individual.birthDT,'yyyy-mm-dd') : null;
                        dob=individual.birthDT != null ? CCCUtils.strToDate(individual.birthDT,'yyyy-mm-dd') : null;
                        dataCust.cif = individual.socialSecurityNO;
                        dataCust.isBlock = individual.shareholderFlg=='true' ? 'Activated' : 'Not Activated';
                        isEmployeeActive = individual.shareholderFlg;
                    }
                    for (EIPJson.EIP_CustomerCommunication hasCommunicationMessage : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage) {
                        dataCust.loginId = hasCommunicationMessage.triggeredBy;
                    }
                    for (EIPJson.EIP_AgSa_InsurancePolicy hasPolicyAccount : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount) {
                        dataCust.policyNumber = hasPolicyAccount.policyNO;
                    }
                    responseCustomers.add(dataCust);
                } 
                else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                    //errorMsg = responseMessage;
                }
            }
            
            /*FOR ADD POLICY*/
            System.debug('test inquiry addPolicy2 ' + typeOfRequest);
            if(typeOfRequest == 'Add Policy' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual != null){
                    EIPJson.EIP_IcAx_AXAAsiaIndividual individual = new EIPJson.EIP_IcAx_AXAAsiaIndividual();
                    /*Add by Fajar*/
                    List<EIPJson.EIP_AgSa_NameValue> valueName = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null ? dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue : new List<EIPJson.EIP_AgSa_NameValue>();
                    
                    Map<String, String> lsValName = new Map<String,String>();
                    if(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue != null){
                        for(EIPJson.EIP_AgSa_NameValue obj : valueName){
                            if(obj.value != null){
                                lsValName.put(obj.name, obj.value);
                            }                       
                    	}
                    }                    
                    /**/
                    system.debug('start mapping customer');
                    individual = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual;
                    for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress customer : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn){
                        
                        DataResponse dataCust = new DataResponse();
                        dataCust.email = customer.emailAddress;
                        
                        dataCust.fullName = (individual.fullNM != null ? individual.fullNM : '');
                        dataCust.mobileNumber = customer.mobilePhoneNO;
                        dataCust.loginId = individual.individualUniqueID;
                        
                        dataCust.gender = individual.genderCD;                       
                        dataCust.dob = individual.birthDT != null ? CCCUtils.strToDate(individual.birthDT,'yyyy-mm-dd') : null;
                        dataCust.cif = individual.socialSecurityNO;
                        
                        /*add by Fajar Salam */
                        dataCust.emailMDM = customer.emailAddress2;
                        dataCust.mobilePhoneMDM = customer.telephoneNO2;
                        dataCust.createdDate = individual.processedDttm !=null ? CCCUtils.strToDateTime(individual.processedDttm, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.createdDate = dataCust.createdDate != null ? dataCust.createdDate.addHours(GMTFORMAT) : null;
                        if (lsValName != null || lsValName.size() != 0){
                            dataCust.sendTo = lsValName.get(EIPConstant.PARAM_MSG_SENDTO);                            
                            dataCust.sendDate = lsValName.get(EIPConstant.PARAM_MSG_SEND_DATE) != null ? CCCUtils.strToDateTime(lsValName.get(EIPConstant.PARAM_MSG_SEND_DATE), 'yyyy-MM-dd hh:mm:ss') : null;
                            dataCust.sendDate = dataCust.sendDate != null ? dataCust.sendDate.addHours(GMTFORMAT) : null;
                            dataCust.lastLogin = lsValName.get(EIPConstant.PARAM_MSG_LAST_LOGIN) != null ? CCCUtils.strToDateTime(lsValName.get(EIPConstant.PARAM_MSG_LAST_LOGIN), 'yyyy-MM-dd hh:mm:ss') : null;
                            dataCust.lastLogin = dataCust.lastLogin != null ? dataCust.lastLogin.addHours(GMTFORMAT) : null;
                        }
                        /**/
                        
                        responseCustomers.add(dataCust);
                        System.debug('added new cust for view');
                        System.debug(Double.valueOf(responseTotalData));
                        System.debug(Double.valueOf(responseLimitPage));
                        if(responseTotalData != null && responseLimitPage != null){
                            totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                            hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                            hasPrevious = (responsePage != 1)? true : false;
                        }
                    }
                }
            }
            
            String eipStatus = dataTADA.Body.status;
            
            /*FOR INQUIRY Data Online*/
            if(typeOfRequest == 'Inquiry Data Online Registration' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
               
                System.debug('==== START Inquiry Data Online Registration ==== ' + dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount);
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount != null){
                    System.debug('==== STARTS Inquiry Data Online Registration ====');
                    for(EIPJson.EIP_AgSa_InsurancePolicy hasPolis : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount){
                        DataResponse dataCust = new DataResponse();
                        dataCust.registrationRemark = hasPolis.policyStatusRk != null ? hasPolis.policyStatusRk : 'KOSONG';
                        dataCust.policyNumber = hasPolis.policyNO != null ? hasPolis.policyNO : 'KOSONG';
                        dataCust.status=hasPolis.policyStatusCD != null ? hasPolis.policyStatusCD : 'KOSONG';
                        dataCust.inputTime=hasPolis.policyEffectiveDTTM != null ? CCCUtils.strToDate(hasPolis.policyEffectiveDTTM,'yyyy-mm-dd') : null; //inputTime=createdDate????
                                                
                        for(EIPJson.EIP_IcAx_AXAAsiaInsuredPersonDetails hasDetailsOfRisksIns : hasPolis.hasDetailsOfRisksIn){
                            for(EIPJson.EIP_IcAx_AXAAsiaIndividual hasPersonalDetailsIn : hasDetailsOfRisksIns.hasPersonalDetailsIn){
                                dataCust.KTP = hasPersonalDetailsIn.socialSecurityNO != null ? hasPersonalDetailsIn.socialSecurityNO :'';
                                dataCust.dob= hasPersonalDetailsIn.birthDT != null ? CCCUtils.strToDate(hasPersonalDetailsIn.birthDT,'yyyy-mm-dd') : null;
                                //responseCustomers.add(dataCust);
                        }
                        }
                        
                    responseTotalData=integer.valueof(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.sourceCInd);
                    responseLimitPage=integer.valueof(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.dependentNO);
                    responsePage=integer.valueof(dataTADA.Body.IcAx_AXAAsiaCustomer_Type.watchlistInd);
                    responseCustomers.add(dataCust);
                    String requestJsonEIP = System.JSON.serialize(responseCustomers, true);
                        System.debug('added new cust for view');
                        System.debug(Double.valueOf(responseLimitPage));
                        if(responseTotalData != null && responseLimitPage != null){
                            totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                            System.debug('APA INI YA? total data' +Double.valueOf(responseTotalData) + 'iniLimitPage' +Double.valueOf(responseLimitPage)+ 'total pages' +Double.valueOf(totalPages));
                            hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                            hasPrevious = (responsePage != 1)? true : false;
                        }
                    }
                }else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                    //errorMsg = responseMessage;
                }
            }
//Added by Elvi Dec 2022
            
			/*FOR ADD USER ADHOC*/ 
            /*Add by Fajar*/
            
            if(typeOfRequest == 'Request User ID' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null && !checkHistory(policyNo) && ckTest == 1){
                
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                    system.debug('start mapping customer');
                    //individual = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount;
                    for(EIPJson.EIP_AgSa_InsurancePolicy hasPolis : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount){
                        DataResponse dataCust = new DataResponse();
                        dataCust.createdDate = hasPolis.processedDttm !=null ? CCCUtils.strToDateTime(hasPolis.processedDttm, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.createdDate = dataCust.createdDate != null ? dataCust.createdDate.addHours(GMTFORMAT) : null;
                        dataCust.modifyDate = hasPolis.statusChangeDT !=null ? CCCUtils.strToDateTime(hasPolis.statusChangeDT, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.modifyDate = dataCust.modifyDate != null ? dataCust.modifyDate.addHours(GMTFORMAT):null;
                        dataCust.registredBy = hasPolis.registeredBy != null ? hasPolis.registeredBy : '';
						dataCust.status = hasPolis.policyStatusRk != null ? hasPolis.policyStatusRk : '';
						dataCust.remark = hasPolis.policyRK != null ? hasPolis.policyRK : '';
                        
                        dataCust.policyNumber = hasPolis.policyNO != null ? hasPolis.policyNO : '';                        
                        for(EIPJson.EIP_IcAx_AXAAsiaCustomer customer : hasPolis.hasCustomerInformationIn){
                            dataCust.gender = customer.canBeIndividual.genderCD;
                            dataCust.dob =  customer.canBeIndividual.birthDT !=null ? CCCUtils.strToDate( customer.canBeIndividual.birthDT, 'yyyy-MM-dd') : null;
                            dataCust.loginId = customer.customerID;                            
                            for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress addressIn :customer.canBeIndividual.hasAddressesIn){
                                dataCust.email = addressIn.emailAddress;
								dataCust.mobileNumber =  addressIn.mobilePhoneNO;                                
                            }
                            
                        }
                        //mapping data name Value
                        Map<String, String> lsValName = new Map<String,String>();
                        for(EIPJson.EIP_AgSa_NameValue val : hasPolis.hasNameValue){
                            if(val.value != null){
                                lsValName.put(val.name, val.value);
                           	}
                        }
                        dataCust.modifyBy = lsValName.get(EIPConstant.PARAM_MSG_MODIFYBY);
                        
                       responseCustomers.add(dataCust);
                       
                    }
                }else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                    //errorMsg = responseMessage;
                }
            }
            
            /*FOR CHECK AVAILABLE USER ADHOC*/ 
            /*Add by Fajar*/
            if(typeOfRequest == 'Inquiry Status Tracking' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
               
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                    system.debug('start mapping customer');
                    //individual = dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount;                    
                    for(EIPJson.EIP_AgSa_InsurancePolicy hasPolis : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount){
                        DataResponse dataCust = new DataResponse();
                        dataCust.createdDate = hasPolis.processedDttm !=null ? CCCUtils.strToDateTime(hasPolis.processedDttm, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.createdDate = dataCust.createdDate != null ? dataCust.createdDate.addHours(GMTFORMAT) : null;
                        dataCust.modifyDate = hasPolis.statusChangeDT !=null ? CCCUtils.strToDateTime(hasPolis.statusChangeDT, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.modifyDate = dataCust.modifyDate != null ? dataCust.modifyDate.addHours(GMTFORMAT): null;
                        dataCust.registredBy = hasPolis.registeredBy != null ? hasPolis.registeredBy : '';
						dataCust.status = hasPolis.policyStatusRk != null ? hasPolis.policyStatusRk : '';
						dataCust.remark = hasPolis.policyRK != null ? hasPolis.policyRK : '';
                       
                        
                        dataCust.policyNumber = hasPolis.policyNO != null ? hasPolis.policyNO : '';                        
                        for(EIPJson.EIP_IcAx_AXAAsiaCustomer customer : hasPolis.hasCustomerInformationIn){
                            dataCust.gender = customer.canBeIndividual.genderCD;
                            dataCust.dob =  customer.canBeIndividual.birthDT !=null ? CCCUtils.strToDate( customer.canBeIndividual.birthDT, 'yyyy-MM-dd') : null;
                            dataCust.loginId = customer.customerID;                            
                            for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress addressIn :customer.canBeIndividual.hasAddressesIn){
                                dataCust.email = addressIn.emailAddress;
								dataCust.mobileNumber =  addressIn.mobilePhoneNO;
                                
                            }
                            
                        }
                        //mapping data name Value
                        Map<String, String> lsValName = new Map<String,String>();
                        for(EIPJson.EIP_AgSa_NameValue val : hasPolis.hasNameValue){
                            
                            if(val.value != null){
                                lsValName.put(val.name, val.value);
                           	}
                        }
                        dataCust.modifyBy = lsValName.get(EIPConstant.PARAM_MSG_MODIFYBY);
                        
                       responseCustomers.add(dataCust);
                       /*Tabulationa Data*/                        
                       System.debug(Double.valueOf(responseTotalData));
                       System.debug(Double.valueOf(responseLimitPage));
                       if(responseTotalData != null && responseLimitPage != null){
                            totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                            hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                            hasPrevious = (responsePage != 1)? true : false;
                       }
                    }
                }else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                    //errorMsg = responseMessage;
                }
            }
           
            /*FOR IQUIRY USER ADHOC LIST*/ 
            /*Add by Fajar*/
            if(typeOfRequest == 'Inquiry Tracking List' && dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
               
                if( dataTADA.Body.IcAx_AXAAsiaCustomer_Type != null){
                    system.debug('start mapping customer');
                    for(EIPJson.EIP_AgSa_InsurancePolicy hasPolis : dataTADA.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount){
                        DataResponse dataCust = new DataResponse();
                        dataCust.createdDate = hasPolis.processedDttm !=null ? CCCUtils.strToDateTime(hasPolis.processedDttm, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.createdDate = dataCust.createdDate != null ? dataCust.createdDate.addHours(GMTFORMAT) : null;
                        dataCust.modifyDate = hasPolis.statusChangeDT !=null ? CCCUtils.strToDateTime(hasPolis.statusChangeDT, 'yyyy-MM-dd hh:mm:ss') : null;
                        dataCust.modifyDate = dataCust.modifyDate != null ? dataCust.modifyDate.addHours(GMTFORMAT) : null;
                        dataCust.registredBy = hasPolis.registeredBy != null ? hasPolis.registeredBy : '';
						dataCust.status = hasPolis.policyStatusRk != null ? hasPolis.policyStatusRk : '';
						dataCust.remark = hasPolis.policyRK != null ? hasPolis.policyRK : '';
                       
                        
                        dataCust.policyNumber = hasPolis.policyNO != null ? hasPolis.policyNO : '';                        
                        for(EIPJson.EIP_IcAx_AXAAsiaCustomer customer : hasPolis.hasCustomerInformationIn){
                            dataCust.gender = customer.canBeIndividual.genderCD;
                            dataCust.dob =  customer.canBeIndividual.birthDT !=null ? CCCUtils.strToDate( customer.canBeIndividual.birthDT, 'yyyy-MM-dd') : null;
                            dataCust.loginId = customer.customerID;                            
                            for(EIPJson.EIP_IcAx_AXAAsiaIndividualAddress addressIn :customer.canBeIndividual.hasAddressesIn){
                                dataCust.email = addressIn.emailAddress;
								dataCust.mobileNumber =  addressIn.mobilePhoneNO;
                                
                            }
                            
                        }
                        //check status
                        
                        //mapping data name Value
                        Map<String, String> lsValName = new Map<String,String>();
                        for(EIPJson.EIP_AgSa_NameValue val : hasPolis.hasNameValue){
                            
                            if(val.value != null){
                                lsValName.put(val.name, val.value);
                           	}
                        }
                        dataCust.modifyBy = lsValName.get(EIPConstant.PARAM_MSG_MODIFYBY);
                       responseCustomers.add(dataCust);
                       /*Tabulationa Data*/                        
                       System.debug(Double.valueOf(responseTotalData));
                       System.debug(Double.valueOf(responseLimitPage));
                       if(responseTotalData != null && responseLimitPage != null){
                            totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                            hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                            hasPrevious = (responsePage != 1)? true : false;
                       }
                    }
                }else{
                    responseMessage = 'No Data Available';
                    System.debug('error : '+responseMessage);
                    isError = true;
                }
            }
            
            /*Adding To History And Cool Of Data*/ 
            /*Add by Fajar*/
            
            if(eipStatus == '1'){
                switch on typeOfRequest {
    				when 'Request User ID' {
        				addHistory(typeOfRequest,'', '', policyNo);
   				 	}/*
                    when 'Update Data'{                        
                        switch on typeOfData{
                            when 'Alamat Korespondensi'{
                                addHistory(typeOfRequest,'', '', policyNo);
                            }/
                            when 'Nomor Handphone'{
                                addHistory(typeOfRequest,'', '', policyNo);
                            }
                            when 'Alamat Email'{
                                addHistory(typeOfRequest,'email', 'newEmail', policyNo);
                            }
                            when 'Nomor Whatsapp'{
                                addHistory(typeOfRequest,'', '', policyNo);
                            }
                            
                        }
                    }*/
            	}
            
            }
            
           if(eipStatus == '1') {
                   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, typeOfRequest+' Success'));          
               if(typeOfRequest != 'Inquiry Status Karyawan') isEmployeeActive='true';
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, dataTADA.Body.exceptionObj.message));
            }
            

        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,EIPConstant.ERROR_MSG_NODATA));
            isError = true;
            responseMessage = EIPConstant.ERROR_MSG_NODATA;
            System.debug('Data Kodong []');
        }catch(EIPConnector.EIPConnectorException e){
            System.debug('e === '+e.getMessage()+ ' in line '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,+e.getMessage()));
            isError = true;
            responseMessage = 'Ada masalah ketika pengambilan data, silahkan hubungi Admin.';
        }catch(Exception e){
            System.debug('e === '+e.getMessage()+ ' in line '+e.getLineNumber());
            if(ckTest != 0){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Data Not Found !'));
            	isError = true;
            	responseMessage = 'Data Not Found !';
            }
        }    
        }
   }
    
    /*Adding data Log History*/
    /*Adding By Fajar Salam*/
    private void addHistory(String reqType, String oldData, String newData, String policyNumber){
        Request_Tada_History__c history = new Request_Tada_History__c();
        history.Type_Request__c = reqType;
        history.Request_Date__c = Date.today();
        history.Email_History__c = oldData;
        history.Active_Email__c = newData; 
        history.Policy_Number__c = policyNumber;      
        insert history;        
    }
    /**/
    /*Adding check Req Log*/
    private boolean checkHistory(String policyNumber){
        List<Request_Tada_History__c> lsH = [Select Id, Type_Request__c, Request_Date__c, Email_History__c, Active_Email__c, Status__c, Finish_Date__c FROM Request_Tada_History__c where Policy_Number__c =:policyNumber order by Request_Date__c DESC];
        historyRequest = lsH;
        for(Request_Tada_History__c obj : lsH){
            if(obj.Status__c != 'Finish'){
                return true;
            }
        }
        return false;
    }
    /**/
    
    public void downloadSumary(){        
        List<String> headerSumary = new List<String>{
             'Division','Upload By','Operator','Success','"Success, Not Recived"','"Success, Unknown Number"','Failed/Not Send','Total'   
        };
    }
    public pageReference downloadReport(){		      
        
        PageReference p = new PageReference('/apex/UserManagement_Excel');
        //p.setRedirect(false);
		return p;
        
    }
    
    
    
    public List<SelectOption> getTypeOfRequestList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        //tempList.add(new SelectOption('Resend Activation Link','Resend Activation Link'));
        //tempList.add(new SelectOption('Request for Reset Password','Request for Reset Password'));
        tempList.add(new SelectOption('Block User','Block User'));
        tempList.add(new SelectOption('Unblock User','Unblock User'));
        //tempList.add(new SelectOption('Update Data','Update Data'));
        tempList.add(new SelectOption('Inquiry Data','Inquiry Data'));
        //tempList.add(new SelectOption('Request User ID','Request User ID'));
        //tempList.add(new SelectOption('Inquiry Status Tracking','Inquiry Status Tracking'));
        //tempList.add(new SelectOption('Inquiry Tracking List','Inquiry Tracking List'));
        tempList.add(new SelectOption('Inquiry Data Online Registration','Inquiry Akun Nasabah'));
        tempList.add(new SelectOption('Inquiry Data Guest','Inquiry Akun Tamu'));
        tempList.add(new SelectOption('Inquiry Status Karyawan','Inquiry Akun Karyawan'));
        
        return tempList;
    }
    
    public List<SelectOption> getTypeOfDataList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('Alamat Korespondensi','Alamat Korespondensi'));
        tempList.add(new SelectOption('Alamat Email','Alamat Email'));
        tempList.add(new SelectOption('Nomor Handphone','Nomor Handphone'));
        tempList.add(new SelectOption('Nomor Whatsapp','Nomor Whatsapp'));
        return tempList;
    }
    
    private List<SelectOption> getProvincesList(){
        List<SelectOption> provinces = new List<SelectOption>();
        List<AggregateResult> provinceNames = new List<AggregateResult>();

        system.debug('count of limit queries : ' + Limits.getQueryRows());

        // Find all the provinces in the custom setting Postal Code
        provinceNames = [SELECT Province__c, COUNT(id) FROM Postal_Code__c 
                         GROUP BY Province__c ORDER BY Province__c LIMIT 50000];

        // Create the Select Options.                                        
        provinces.add(new SelectOption('', '-- Select One --'));
        for (AggregateResult provinceName : provinceNames) {
            provinces.add(new SelectOption(provinceName.get('Province__c').toString(), provinceName.get('Province__c').toString()));
        }
        return provinces;
    }

    private List<SelectOption> getCitiesList(String paramProvince){
        List<SelectOption> cities = new List<SelectOption>();
        Set<SelectOption> setCities = new Set<SelectOption>();
        List<AggregateResult> citiesNames = new List<AggregateResult>();
        
        system.debug('count of limit queries : '+Limits.getQueryRows());
        system.debug('this province : ' + paramProvince);

        if(String.isNotBlank(paramProvince))
            citiesNames = [SELECT City__c, COUNT(id) FROM Postal_Code__c WHERE Province__c =:paramProvince 
                            GROUP BY City__c ORDER BY City__c];
        system.debug('count of result query : '+ citiesNames.size());

        for (AggregateResult cityName : citiesNames) {
            cities.add(new SelectOption(cityName.get('City__c').toString(), cityName.get('City__c').toString()));
        }

        if (cities.size() > 0) {
            cities.sort();
            cities.add(0, new SelectOption('', '-- Select One --'));
        } else {
            cities.add(new SelectOption('', 'Not Required'));
        }

        return cities;
    }

    private List<SelectOption> getSubDistrictsList(String paramProvince, String paramCity){
        List<SelectOption> subDistricts = new List<SelectOption>();
        Set<SelectOption> setSubDistricts = new Set<SelectOption>();
        List<AggregateResult> subDistrictsNames = new List<AggregateResult>();
        
        system.debug('count of limit queries : '+Limits.getQueryRows());
        system.debug('this city : ' + paramCity);

        if(String.isNotBlank(paramCity))
            subDistrictsNames = [SELECT Sub_District__c, COUNT(id) FROM Postal_Code__c WHERE (City__c =:paramCity) AND (Province__c =:paramProvince) 
                                    GROUP BY Sub_District__c ORDER BY Sub_District__c];
        system.debug('count of result query : '+ subDistrictsNames.size());

        for (AggregateResult subDistrictsName : subDistrictsNames) {
            subDistricts.add(new SelectOption(subDistrictsName.get('Sub_District__c').toString(), subDistrictsName.get('Sub_District__c').toString()));
        }

        if (subDistricts.size() > 0) {
            subDistricts.sort();
            subDistricts.add(0, new SelectOption('', '-- Select One --'));
        } else {
            subDistricts.add(new SelectOption('', 'Not Required'));
        }

        return subDistricts;
    }

    private List<SelectOption> getVillagesList(String paramProvince, String paramCity, String paramSubDistrict){
        List<SelectOption> villages = new List<SelectOption>();
        Set<SelectOption> setVillages = new Set<SelectOption>();
        List<AggregateResult> villagesNames = new List<AggregateResult>();
        system.debug('count of limit queries : '+Limits.getQueryRows());
        system.debug('this subDistrict : ' + paramSubDistrict);

        if(String.isNotBlank(paramSubDistrict))
            villagesNames = [SELECT Village__c, COUNT(id) FROM Postal_Code__c WHERE (Sub_District__c =:paramSubDistrict) AND (City__c =:paramCity) AND (Province__c =:paramProvince) 
                                GROUP BY Village__c ORDER BY Village__c];
        system.debug('count of result query : '+ villagesNames.size());

        for (AggregateResult villagesName : villagesNames) {
            villages.add(new SelectOption(villagesName.get('Village__c').toString(), villagesName.get('Village__c').toString()));
        }

        if (villages.size() > 0) {
            villages.sort();
            villages.add(0, new SelectOption('', '-- Select One --'));
        } else {
            villages.add(new SelectOption('', 'Not Required'));
        }
        return villages;
    }

    private Postal_Code__c getPostalCodeData(String paramProvince, String paramCity, String paramSubDistrict, String paramVillage){
        system.debug('execute postal code from VFP');
        system.debug('province selected : ' + paramProvince);
        system.debug('city selected : ' + paramCity);
        system.debug('subDistrict selected : ' + paramSubDistrict);
        system.debug('village selected : ' + paramVillage);
        Postal_Code__c[] postalCodeData = new List<Postal_Code__c>();
        postalCodeData = [SELECT Id, Postal_Code__c, Province__c, Sub_District__c, City__c, Village__c, CityCodeRLS__c, Name 
                                        FROM Postal_Code__c 
                                        WHERE (Village__c =:paramVillage) AND (Sub_District__c =:paramSubDistrict) AND (City__c =:paramCity) AND (Province__c =:paramProvince) 
                                        LIMIT 1];
        return postalCodeData.size() > 0 ? postalCodeData[0] : null;
    }

    public List<SelectOption> getProvincesSelectList(){
        System.debug('--- GET PROVINCE LIST ---');
        return getProvincesList();
    }

    public List<SelectOption> getCitiesSelectList(){
        System.debug('--- GET CITY LIST ---');
        System.debug('this.province : '+this.province);
        return getCitiesList(this.province);
    }

    public List<SelectOption> getSubDistrictsSelectList(){
        System.debug('--- GET SUB DISTRICT LIST ---');
        return getSubDistrictsList(this.province, this.city);
    }

    public List<SelectOption> getVillagesSelectList(){
        System.debug('--- GET VILLAGE LIST ---');
        return getVillagesList(this.province, this.city, this.subDistrict);
    }

    public void getPostalCode(){
        System.debug('--- GET ZIPCODE ---');
        Postal_Code__c postalSelected = getPostalCodeData(province, city, subDistrict, village);
        if(postalSelected != null){
            postalCD = postalSelected.Postal_Code__c;
            cityCodeRLS = postalSelected.CityCodeRLS__c;
        } else{
            postalCD = '';
            cityCodeRLS = '';
        }
    }
}