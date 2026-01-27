trigger chatDuration on LiveChatTranscript (after update) {

  LiveChatTranscript lt = [Select Body, List_Agent__c, TriggerOff__c from LiveChatTranscript where Id =:Trigger.newMap.KeySet() limit 1];

    List<Transcript_Chat__c> insertChat = new List<Transcript_Chat__c>();
    // taufik - 15 Feb 2019
    if (lt.Body == NULL) lt.Body = '';
    if (lt.List_Agent__c == NULL) lt.List_Agent__c = '';
    // End taufik - 15 Feb 2019

    String replaceCenter = lt.Body.replace('<p align="center">', '<p>');
    String substring2 = replaceCenter.replace('<p>Chat Transferred From AXA Financial Indonesia To AXA Financial Indonesia</p>', '<br>Transferred');
    String substringChat = substring2.substringAfterLast('</p>\n');
    String[] splitChat = substringChat.Split('<br>');
    String[] listAgent = lt.List_Agent__c.split(';');
    System.debug(lt.body);
    System.debug('subs '+substring2);
    System.debug('Substring '+substringChat);
    String[] actors = new List<String>();
    Integer[] starttime = new List<Integer>();
    Integer[] endtime = new List<Integer>();
    String minutes, hours;
    Integer min, sec, hour, times;
    Integer age = 0;
    //System.debug('list Agent '+listAgent[0]+ ' '+listAgent[1]);
    //
    //this calculation running only for ALI RecordType
    if(replaceCenter.contains('AXA Financial Indonesia') == TRUE && !lt.TriggerOff__c){ //(label.Chat_TriggerOnOff != 'OFF')
          for(Integer i = 0; i<splitChat.size(); i++){
          if(splitChat[i].LEFT(1) == '(' && splitChat[i].substring(2,3).isNumeric()){
            String user = splitChat[i].substringBetween('s ) ', ':');
            String duration = splitChat[i].substringBeforeLast('s ) ');
            if(i == 0){
                times = calcTime(duration);
                starttime.add(times);
            } else if(i == 1){
                if(user == 'AXA Financial Indonesia'){
                    times = calcTime(duration);
                    endtime.add(times);
                    actors.add(listAgent[0]);
                    //age = age+1;
                }else{/*DO NOTHING*/}
            }
            else {
                String prevUser = splitChat[i-1].substringBetween('s ) ', ':');
                String prevDuration = splitChat[i-1].substringBeforeLast('s ) ');
                if(user != 'AXA Financial Indonesia' && user != prevUser && prevDuration.contains('Transferred') == FALSE){
                    times = calcTime(duration);
                    starttime.add(times);
                }else if(duration.contains('Transferred') == TRUE && prevUser != 'AXA Financial Indonesia'){
                  starttime.remove(starttime.size()-1);
                    times = calcTime(duration);
                    starttime.add(times);
                    if(starttime.size() > 1){ age = age + 1; }
                }else if(duration.contains('Transferred') == TRUE && prevUser == 'AXA Financial Indonesia'){
                    times = calcTime(duration);
                    starttime.add(times);
                    if(starttime.size() > 1){ age = age + 1; }
                } else if(user == 'AXA Financial Indonesia' && user != prevUser){
                  times = calcTime(duration);
                    endtime.add(times);
                    actors.add(listAgent[age]);
                }else if(user == 'AXA Financial Indonesia' && prevDuration.contains('Transferred') == TRUE){
                    times = calcTime(duration);
                    endtime.add(times);
                    actors.add(listAgent[age]);
                }
            }
          }
        }
        
        if(starttime.size() > endtime.size()){
        starttime.remove(starttime.size()-1);
        }
        
        if(endtime.size() > starttime.size()) {
            for(integer i = endtime.size()-1; i > starttime.size()-1; i--){
                endtime.remove(i);
                actors.remove(i);
            }
        }
        
        for(Integer i = 0; i<actors.size();i++){
            Transcript_Chat__c cd = new Transcript_Chat__c();
            cd.Name = String.valueOf(i+1);
            cd.User__c = actors[i];
            cd.Start__c = starttime[i];
            cd.End__c = endtime[i];
            cd.Live_Chat_Transcript__c = lt.Id;
            cd.Lead_Time_Seconds__c = cd.End__c - cd.Start__c;
            insertChat.add(cd);
        }
        
        System.debug('insertChat '+insertChat);
        
        List<Transcript_Chat__c> existing = [select id from Transcript_Chat__c where Live_Chat_Transcript__c =: lt.Id];
        if(existing.size() > 0){
            delete existing;
        }
        
        insert insertChat;
        
    }else{   /*DO NOTHING*/    }
        
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