/***************************************************************************************
*    Class Name: CampaignWelcomeCallQueueable
*	 Description: This call is deployed to the Queueable to insert Call Line (Avoid CPU Limit Error)
*    Author: Fajar Salam
*    Date: 31 Maret 2022
*    Code version: 1.0
*
***************************************************************************************/

public class CampaignWelcomeCallQueueableTelUW implements Queueable{
    
    List<Call_Line__c> callLine = new List<Call_Line__c>();
    @TestVisible
    private static Boolean doChainJob = true;
    
    public CampaignWelcomeCallQueueableTelUW(List<Call_Line__c> callLine){
        this.callLine = callLine;
    }
    
    public void execute(QueueableContext context) {
        try{
            insert callLine;
            system.debug('Generate daily call lines done.');
            // Avoid Chaining Job Error in Test
            if(doChainJob){
                System.enqueueJob(new RoundRobinDistQueueableTelUW());
            }
        }catch(Exception e){
            System.debug('ERROR==== '+e);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String recipient = System.LABEL.Email_Recipient_Welcome_Call;
            if(recipient != null){
                String[] to = recipient.trim().split(';');
                
                Messaging.EmailFileAttachment logFile = new Messaging.EmailFileAttachment();
                blob logBlob = Blob.valueOf(String.valueOf(e));
                string logName= 'TelUW Schedule Log.txt';
                logFile.setFileName(logName);
                logFile.setBody(logBlob);
                email.setSubject('TelUW Schedule Error Log');
                email.setHtmlBody('TelUW Schedule is Finish with some ERROR. <br/>'+
                                  +' Please check the Log File.');
                email.setFileAttachments(new Messaging.EmailFileAttachment[]{logFile});
                email.setToAddresses(to);
                if(!Test.isRunningTest()){
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                    }
            } else {
                System.debug('ERROR Occurred and Email Recipient is not set.');
            }
        }
    }
}