trigger listAgentChat on LiveChatTranscriptEvent (before insert) {
    List<LiveChatTranscript> updateTranscripts = new List<LiveChatTranscript>();
    for(LiveChatTranscriptEvent cte : Trigger.new){
        if(cte.Type == 'Accept' || cte.Type == 'Transfer'){
            User agent = [select Id, Name from User where Id=:cte.AgentId];
            LiveChatTranscript lct = [select id, List_Agent__c from LiveChatTranscript where Id =: cte.LiveChatTranscriptId];
            LiveChatTranscript updateTranscript = new LiveChatTranscript();
            updateTranscript.Id = lct.Id;
            if(String.isBlank(lct.List_Agent__c) == TRUE){
                updateTranscript.List_Agent__c = agent.Name+';';
            }else{
                updateTranscript.List_Agent__c = lct.List_Agent__c + agent.Name+';';
            }
            updateTranscripts.add(updateTranscript);
        }
    }
    
    if(updateTranscripts.size() > 0){
        update updateTranscripts;
    }
}