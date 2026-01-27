/***************************************************************************************
*    Class Name: RoundRobinDistQueueable
*	 Description: This call is deployed to the Queueable to distribute Call Line to Agent
*    Author: Faizir Rahmadi Isman
*    Date: 5 Juni 2020
*    Code version: 1.2
*
***************************************************************************************/

public class RoundRobinDistQueueable implements Queueable{
    
    public void execute(QueueableContext context) {
        CampaignWelcomeCall campaignWelCall = new CampaignWelcomeCall();
        campaignWelCall.roundRobinDist(true);
    }
}