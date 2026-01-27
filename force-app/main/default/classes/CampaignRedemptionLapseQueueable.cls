/***************************************************************************************
*    Class Name: CampaignWelcomeCallQueueable
*	 Description: This call is deployed to the Queueable to insert Call Line (Avoid CPU Limit Error)
*    Author: Faizir Rahmadi Isman
*    Date: 5 Juni 2020
*    Code version: 1.2
*
***************************************************************************************/

public class CampaignRedemptionLapseQueueable implements Queueable{
    
    List<Call_Line__c> callLine = new List<Call_Line__c>();
    @TestVisible
    private static Boolean doChainJob = true;
    
    public CampaignRedemptionLapseQueueable(List<Call_Line__c> callLine){
        this.callLine = callLine;
        system.debug('call line que '+ callLine.size());
    }
    
    public void execute(QueueableContext context) {
        try{
            insert callLine;
            system.debug('Generate daily call lines done.');
            // Avoid Chaining Job Error in Test
            if(doChainJob){
                system.debug('START OF DISTRIBUTION REDEMPT');
                System.enqueueJob(new RoundRobinRedemptionLapse());
            }
        }catch(Exception e){
            
            
        }
    }
}