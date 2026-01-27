trigger Trigger_InsertCustomField_CallLogPurecloud on Task (before Update) {
    String conversationId;
    String participantId; 
    for (Task tsk : trigger.new){
        if (trigger.isBefore && trigger.isUpdate) { 
            conversationId = tsk.CallObject; //tsk.Purecloud_Call_ID__c;
            //conversationId = tsk.Purecloud_Call_ID__c; //'1f64384d-0738-433c-a411-86661bb228ae'; 
            participantId = tsk.Purecloud_Participant_ID__c; //'786f2e8b-911b-44ab-bff1-3e7a85a0c204'; 
            if (!System.isfuture() && !System.isBatch()) Purecloud_InsertTask.getTest(conversationId, Tsk.id, participantId, tsk.ownerId, tsk.whatid, tsk.subject); 
        }    
    }        
}