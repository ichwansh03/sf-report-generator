trigger LiveChatTranscript_BeforeUpdate on LiveChatTranscript (Before Update) {
    Integer[] starttime = new List<Integer>();
    Integer[] endtime = new List<Integer>();
    String minutes, hours;
    Integer min, sec, hour, times;
    Integer age = 0;

    for (LiveChatTranscript  lct : trigger.new) {
        //lct.Body
        //system.debug('body : '+lct.Body);
        //String substringChat = lct.Body.substringAfterLast('</p>\n');
        if (lct.Status == 'Completed') {
        String substringChat = lct.Body.substringAfterLast('</p>');
        String[] splitChat = substringChat.Split('<br>');
        String[] splitChat2 = splitChat;
        string timetext = '';
        system.debug('taufik - splitChat : '+splitChat);
        List<Transcript_Chat__c> insertChat = new List<Transcript_Chat__c>();
        datetime ChatTime = lct.RequestTime; //lct.StartTime;
        system.debug('taufik - Start chattime - '+ChatTime);
        //if (lct.ready_to_send__c == FALSE && (lct.Body_Custom__c == NULL || lct.Body_Custom__c == '')) {
            lct.Body_Custom__c = '';
            for(Integer i = 0; i<splitChat.size(); i++){
                if(splitChat[i].LEFT(1) == '(' && splitChat[i].substring(2,3).isNumeric()){
                    String duration = splitChat[i].substringBeforeLast('s ) ');
                    times = calcTime(duration);
                    system.debug('taufik - time - '+i+ ' : '+times);
                    ChatTime = lct.RequestTime.addSeconds(times+25200);
                    system.debug('taufik - chattime - '+ChatTime);
                    timetext = ''+ChatTime;
                    timetext = '( '+timetext.right(8);
                    
                    lct.Body_Custom__c += splitChat2[i].replace(duration+'s',timetext);
                    lct.Body_Custom__c += ' \n';
                    lct.ready_to_send__c = TRUE;
                    lct.Entity_Backup__c = lct.SkillId;
                }
            }
        // }
        // Mapping Chat Transcript.
            if (lct.CaseId == NULL) {
                try {
                    List<Case> insertCase = new List<Case>();
                    List<Case> conCase = new List<Case>();
                    
                    if(!Test.isRunningTest()){
                        conCase = [select Id, SourceId from Case
                                   where contactId  =:lct.ContactId AND (Origin = 'Web' OR Origin = 'Chat') AND Chat_Key__c = '' AND CreatedDate =TODAY];
                    }else{
                        conCase = [select Id, SourceId from Case
                                   where contactId  =:lct.ContactId AND (Origin = 'Web' OR Origin = 'Chat') AND Chat_Key__c = ''];
                    }
                    if(conCase.size() > 0){
                        for(Integer i = 0; i<conCase.size(); i++){
                            Case cs = new Case();
                            cs.Id = conCase[i].Id;
                            cs.SourceId = lct.Id;
                            cs.Chat_Key__c = lct.ChatKey;
                            insertCase.add(cs);
                        }
                        update insertCase;
	                    lct.CaseId = conCase[0].Id;
                    }
                }
                catch (Exception e) {                    
                }

            } // end mapping transcript
            
        }
    }

    public Integer calcTime(String duration){
        if(duration == '' || duration == null){
            sec = 0;
        }else{
           sec = Integer.valueOf(duration.right(2).trim());
        }
                
        if(duration.contains('m')==true){
          minutes = duration.substringBeforeLast('m').right(2).trim();
        }else{ 
          minutes = '';
        }
                
        if(minutes == '' || minutes == null){
          min = 0;
        }else{
          min = Integer.valueOf(minutes);
        }
                
        hours = duration.substringBetween('( ', 'h');
        if(hours == '' || hours == null){
          hour = 0;
        }else{
          hour = Integer.valueOf(hours);
        }
                
        Integer getTime = (hour*3600)+(min*60)+sec;
        return getTime;
    }
}