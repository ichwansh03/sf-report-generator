public class ChatbotQueueReleaseController {
    public QueueReleaseInfo queueReleaseInfoData {get; set;}
    
   	public class QueueReleaseInfo {
        public String status {get; set;}
        public String message {get; set;}
        public String totalQueue {get; set;}
        public String released {get; set;}
    }
    
    public PageReference queueRelease(){
        String errMsg = null;
        queueReleaseInfoData = new QueueReleaseInfo();
        try{
            EIPJson result = EIPConnector.queueRelease(EIPConstant.OPERATION_QUEUE_RELEASER, EIPConstant.ENTITY_AMFS, EIPConstant.APP_CHATBOT);
            if(result.Body.status == EIPConstant.STATUS_SUCCESS ){
                String queueReleaseStatus = result.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasAXAAsiaPolicyPaymentAccount[0].statusCD;
                
                if(String.isNotBlank(queueReleaseStatus)){
                    queueReleaseInfoData.status = queueReleaseStatus.toUpperCase();
                    queueReleaseInfoData.message = result.Body.IcAx_AXAAsiaCustomer_Type.haveCommunicatedMessage[0].message;
                    queueReleaseInfoData.totalQueue = result.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].ccInstalmentIND;
                	queueReleaseInfoData.released = result.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].batchID;
                }else{
                    errMsg = EIPConstant.ERROR_MSG_STATUS_NOTFOUND;
                }
            }
        } catch(EIPConnector.NoDataException e){
            errMsg = e.getMessage();
            System.debug('NoDataException - '+e.getMessage());
        } catch(EIPConnector.EIPConnectorException e){
            errMsg = e.getMessage();
            System.debug('EIPConnectorException - '+e.getMessage());
        } catch (Exception e){
            errMsg = EIPConstant.ERROR_MSG_UNKNOWN;
            System.debug('Exception - '+e.getMessage());
        }
        
        if(String.isNotBlank(errMsg)){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, errMsg));
        }
        return null;
    }
}