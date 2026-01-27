public class resetCustSegmentationCtrl {
	Integer totalRecs = 0;
   	Integer count= 0;
   	Integer LimitSize {get; set;}
    
    public resetCustSegmentationCtrl(ApexPages.StandardController controller){
        //totalRecs =[SELECT Count() from Contact where Entity__c = 'AMFS' and Cust_Segmentation__c != 'Regular'];
        
    }
                                
    public void resetValueToRegular(){
        try{
            UpdateContactBatchable be = new UpdateContactBatchable(null, false, UserInfo.getUserId(), null);
			database.executeBatch(be, 1000);
        } catch(Exception e){
            System.debug('System Error '+e);
        }
    }
}