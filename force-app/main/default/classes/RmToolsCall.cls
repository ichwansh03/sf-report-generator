public class RmToolsCall {
    public void populateAndUpdateCallLiner(Set<Id> contactIdList){
        //get list of call liner based on contact dan record type Call Line Customer Segmentation
        //List<Call_Line__c> callLineListRM = [Select id, open_cases__c, policy_no__c, Contact__c from Call_line__c
                                        //     where Contact__c in : contactIdList 
                                         //    and recordtype.name ='Call Line Customer Segmentation'];
        //System.debug('CL LIST '+callLineListRM);
        //    CountOpenCaseBatchable be = new CountOpenCaseBatchable(contactIdList, callLineListRM);
        //    database.executeBatch(be, 1000);
        System.debug('calling RMToolsCall');
    }
}