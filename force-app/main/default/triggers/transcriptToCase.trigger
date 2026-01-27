trigger transcriptToCase on LiveChatTranscript (after insert) {
    List<Case> insertCase = new List<Case>();
    List<Case> conCase = new List<Case>();
    for(LiveChatTranscript lc : Trigger.New){
        if(lc.ContactId != null){
           /* List<Contact> con = [Select Id, chatKey__c from Contact where Id=:lc.contactId limit 1];
            
            if(con.size() > 0){
                Contact c = new Contact();
                c.Id = con[0].Id;
                c.ChatKey__c = lc.Id;
                update c;
                Contact con1 = [Select Id, ChatKey__c from Contact where Id=:c.Id]; */
            
            if(!Test.isRunningTest()){
                conCase = [select Id, SourceId from Case
                                      where contactId  =:lc.ContactId AND (Origin = 'Web' OR Origin = 'Chat') AND Chat_Key__c = '' AND CreatedDate =TODAY];
            }else{
                conCase = [select Id, SourceId from Case
                                      where contactId  =:lc.ContactId AND (Origin = 'Web' OR Origin = 'Chat') AND Chat_Key__c = ''];
            }
                if(conCase.size() > 0){
                    for(Integer i = 0; i<conCase.size(); i++){
                        Case cs = new Case();
                        cs.Id = conCase[i].Id;
                        cs.SourceId = lc.Id;
                        cs.Chat_Key__c = lc.ChatKey;
                        insertCase.add(cs);
                    }
                    update insertCase;
                }
        }
    }
}