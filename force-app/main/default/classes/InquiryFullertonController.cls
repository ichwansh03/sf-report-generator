public class InquiryFullertonController {
    
    public String username {get;set;}
    public String uniqueNumber {get;set;}
    public String mobileNumber {get;set;}
    public String firstName {get;set;}
    public String lastName {get;set;}
    public Date dob {get;set;}
    public String dobString {get;set;}
    public String errorMsg {get;set;}
    
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
    
    public class DataResponse{
        public String firstName {get;set;}
        public String lastName {get;set;}
        public String username {get;set;}
        public String gender {get;set;}
        public Date dob {get;set;}
        public String email {get;set;}
        public String address {get;set;}
        public String mobileNumber {get;set;}
        public String uniqueNumber {get;set;}
    }
    
    public InquiryFullertonController(){
        
    }
    
    public void refreshAttribute(){
        responseCustomers = new List<DataResponse>();
        responseStatus = '';
        responseMessage = '';
        isError = false;
        properties = new Map<String,String>();
        hasNext = false;
        hasPrevious = false;
        totalPages = 0;
    }
    
    public PageReference inquiry(){
        refreshAttribute();
        properties.put(EIPConstant.PARAM_FIRST_NAME, firstName);
        properties.put(EIPConstant.PARAM_LAST_NAME, lastName);
        properties.put(EIPConstant.PARAM_USERNAME, username);
        properties.put(EIPConstant.PARAM_UNIQUE_NUMBER, uniqueNumber);
        properties.put(EIPConstant.PARAM_MOBILE_NUMBER, mobileNumber);
        properties.put(EIPConstant.PARAM_MSG_DOB, (dob != null ? Datetime.newInstance(dob, Time.newInstance(0,0,0,0)).format('yyyy-MM-dd') : ''));
        
        properties.put(EIPConstant.PARAM_ORDER_BY, 'username');
        properties.put(EIPConstant.PARAM_ORDER_DIR, 'asc');
        properties.put(EIPConstant.PARAM_PAGE_NUMBER, '1');
        properties.put(EIPConstant.PARAM_ROW_PER_PAGE, '15');
        this.invokeCustomerInfoFullerton();
        
        return null;
    }
    
    public PageReference nextPage(){
        properties.put(EIPConstant.PARAM_PAGE_NUMBER, String.valueOf(responsePage+1));
        responseCustomers = new List<DataResponse>();
        this.invokeCustomerInfoFullerton();
		
        return null;
    }
    
    public PageReference previousPage(){
        properties.put(EIPConstant.PARAM_PAGE_NUMBER, String.valueOf(responsePage-1));
        responseCustomers = new List<DataResponse>();
        this.invokeCustomerInfoFullerton();
        
        return null;
    }
    
    public void invokeCustomerInfoFullerton(){
        try{
            EIPJson getCustomerListFullertron = EIPConnector.getCustomerInfoFullerton(EIPConstant.OPERATION_SEARCH_PERSONAL, 
                                                                                      EIPConstant.ENTITY_AMFS, 
                                                                                      EIPConstant.APP_FULLERTON, 
                                                                                      properties);
            responseStatus = getCustomerListFullertron.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].deliveryStatusDesc;
            responseMessage = getCustomerListFullertron.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].message;
            
            if( getCustomerListFullertron.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn != null){
                system.debug('start mapping customer');
                for(EIPJson.EIP_IcAx_AXAAsiaCustomer customer : getCustomerListFullertron.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn){
                    DataResponse dataCust = new DataResponse();
                    dataCust.firstName = customer.canBeIndividual.firstNM;
                    dataCust.lastName = customer.canBeIndividual.lastNM;
                    dataCust.username = customer.canBeIndividual.localNM;
                    dataCust.gender = customer.canBeIndividual.genderCD;
                    dataCust.dob = CCCUtils.strToDate(customer.canBeIndividual.birthDT,'yyyy-mm-dd');
                    dataCust.email = customer.canBeIndividual.hasAddressesIn[0].emailAddress;
                    dataCust.address = customer.canBeIndividual.hasAddressesIn[0].addressLine1;
                    dataCust.mobileNumber = customer.canBeIndividual.hasAddressesIn[0].mobilePhoneNO;
                    dataCust.uniqueNumber = customer.canBeIndividual.socialSecurityNO;
                    responseCustomers.add(dataCust);
                    System.debug('added new cust for view');
                }
                
                for(EIPJson.EIP_AgSa_NameValue nameValue : getCustomerListFullertron.Body.IcAx_AXAAsiaCustomer_Type.hasNameValue){
                    if(nameValue.name == 'totalData') responseTotalData = Integer.valueOf(nameValue.value);
                    if(nameValue.name == 'page') responsePage = Integer.valueOf(nameValue.value);
                    if(nameValue.name == 'limit') responseLimitPage = Integer.valueOf(nameValue.value);
                    system.debug('has name : ' + nameValue.name + ', value : ' +nameValue.value);
                }
                
                System.debug(Double.valueOf(responseTotalData));
                System.debug(Double.valueOf(responseLimitPage));
                totalPages = Integer.valueOf(Math.ceil(Double.valueOf(responseTotalData)/Double.valueOf(responseLimitPage)));
                hasNext = (totalPages > 1 && responsePage < totalPages) ? true : false;
                hasPrevious = (responsePage != 1)? true : false;
                
            }else{
                System.debug('error : '+responseMessage);
                isError = true;
                errorMsg = responseMessage;
            }   
        }catch(EIPConnector.EIPConnectorException e){
            errorMsg = 'Ada masalah ketika pengambilan data, silahkan hubungi Admin.';
        }catch(Exception e){
            errorMsg = 'Internal Server Error '+e.getMessage();
        }
    }
    
}