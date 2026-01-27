/***************************************************************************************
*    Class Name: RoundRobinDistQueueable
*	 Description: This call is deployed to the Queueable to distribute Call Line to Agent
*    Author: Fajar Salam
*    Date: 31 Maret 2022
*    Code version: 1.0
*
***************************************************************************************/

public class RoundRobinDistQueueableTelUW implements Queueable{
    
    public void execute(QueueableContext context) {
        CampaignTelUW campaign = new CampaignTelUW();
        campaign.roundRobinDist();
    }
}