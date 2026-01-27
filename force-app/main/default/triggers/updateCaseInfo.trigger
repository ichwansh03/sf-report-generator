trigger updateCaseInfo on SocialPost (before insert, after insert) {
    
    List<SocialPost> updatedSocialPostList = new List<SocialPost>();
    Map<String, SocialPost> socialPostMap = new Map<String, SocialPost>();
    
    String entityUser = [SELECT Id, Entity__c FROM User WHERE Id = :UserInfo.getUserId()][0].Entity__c;
    system.debug('entityUser: '+entityUser);
    
    //BEFORE INSERT
    if(Trigger.isBefore && Trigger.isInsert){
        for(SocialPost sp : Trigger.new) {
            
            if(sp.IsOutbound == TRUE){
                socialPostMap.put(sp.ParentId, sp);
                system.debug('socialPostMap: '+socialPostMap);
                system.debug('socialPostMap (Key Set): '+socialPostMap.keySet());
            }
            
            if(/*entityUser == 'AFI' &&*/ sp.PostTags != null){
                if(sp.IsOutbound == false && (sp.PostTags.containsIgnoreCase('AXA Financial Indonesia') || sp.PostTags.containsIgnoreCase('AXA Financial'))){
                    system.debug('=== Check Posted Date in Business Hours AFI or not ===');
                    datetime dt_PostedDate = sp.Posted;
                    datetime dt_StartNextDate = DateTime.newInstance(dt_PostedDate.year(),dt_PostedDate.month(),dt_PostedDate.day(),0,0,0);
                    datetime dt_EndNextDate = DateTime.newInstance(dt_PostedDate.year(),dt_PostedDate.month(),dt_PostedDate.day(),8,0,0);
                    datetime dtime_cutOff_AFI = DateTime.newInstance(dt_PostedDate.year(),dt_PostedDate.month(),dt_PostedDate.day(),16,0,0);
                    
                    datetime nextStartBusinessHours;
                    //if it is within the business hours. The returned time will be in the local time zone
                    nextStartBusinessHours = BusinessHours.nextStartDate(system.label.BusinessHoursAFI_Customer, sp.Posted);
                    
                    system.debug('check (dt_PostedDate): '+dt_PostedDate);
                    system.debug('check (dt_StartNextDate): '+dt_StartNextDate);
                    system.debug('check (dt_EndNextDate): '+dt_EndNextDate);
                    system.debug('check (dtime_cutOff_AFI): '+dtime_cutOff_AFI);
                    system.debug('check (nextStartBusinessHours): '+nextStartBusinessHours);
                    
                    /*if(sp.Posted <= dtime_cutOff_AFI && sp.PostDate_Temporary__c == null){
                        system.debug('=== In Business Hours (4.00 PM) ===');
                        sp.PostDate_Temporary__c = sp.Posted;
                    } else if(sp.Posted > dtime_cutOff_AFI && sp.PostDate_Temporary__c == null){
                        system.debug('=== After Business Hours (> 4.00 PM) ===');
                        sp.PostDate_Temporary__c = nextStartBusinessHours;
                    }*/
                    
                    if(sp.Posted <= dtime_cutOff_AFI && sp.Posted >= dt_EndNextDate && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun') && sp.PostDate_Temporary__c == null){
                        system.debug('=== In Business Hours (>=8.00 AM && <=4.00 PM) ===');
                        sp.PostDate_Temporary__c = sp.Posted;
                    } else if(sp.Posted <= dtime_cutOff_AFI && sp.Posted < dt_EndNextDate && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== Before Business Hours (<8.00 AM && <=4.00 PM) ==='); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    } else if(sp.Posted <= dtime_cutOff_AFI && (dt_PostedDate.format('E') == 'Sat' || dt_PostedDate.format('E') == 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== After Business Hours (> 4.00 PM) === (1)'); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    } else if(sp.Posted > dtime_cutOff_AFI && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== After Business Hours (> 4.00 PM) === (2)'); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    } else if(sp.Posted > dtime_cutOff_AFI && (dt_PostedDate.format('E') == 'Sat' || dt_PostedDate.format('E') == 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== After Business Hours (> 4.00 PM) === (3)'); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    }
                    
                    system.debug('=== Update sp.PostDate_Temporary__c: '+sp.PostDate_Temporary__c);
                }
            }
        }
        
        List<SocialPost> socialPostList = [SELECT Id, ReplyToId, Name, ParentId, Parent.Name, Content, MessageType, IsOutbound, Posted, First_Response_Date_In_Datetime__c, Last_Response_Date__c, PostTags, Owner.Name, CreatedDate FROM SocialPost WHERE ParentId IN :socialPostMap.keySet() AND IsOutbound = FALSE ORDER BY CreatedDate DESC LIMIT 1];
        system.debug('socialPostList: '+socialPostList);
        
        for(SocialPost spOne: socialPostList){
            for(SocialPost spTwo: socialPostMap.values()){
                if(spTwo.Id != spOne.Id && spTwo.ParentId == spOne.ParentId /*&& spTwo.ReplyToId == spOne.Id*/){
                    if(spOne.Posted < spTwo.Posted && spOne.First_Response_Date_In_Datetime__c == null){
                        spOne.First_Response_Date_In_Datetime__c = spTwo.Posted;
                    }
                    spOne.Last_Response_Date__c = spTwo.Posted;
                    updatedSocialPostList.add(spOne);
                }
                system.debug('===spOne.First_Response_Date_In_Datetime__c: '+spOne.First_Response_Date_In_Datetime__c);
                system.debug('===spOne.Last_Response_Date__c: '+spOne.Last_Response_Date__c);
            }
        }
        system.debug('updatedSocialPostList: '+updatedSocialPostList);
        update updatedSocialPostList;
    }
    //END - BEFORE INSERT
    
    
    //AFTER INSERT
    if(Trigger.isAfter && Trigger.isInsert) {
        for(SocialPost sp : Trigger.new) {
            if(sp.ParentId != null) {
                Case c = [SELECT Id, Post_Status__c, Entity_Backup__c, OwnerId, Owner.Type FROM Case WHERE Id = :sp.ParentId];
                
                /*String caseOwner = c.OwnerId;
                
                system.debug('Case Owner (Before): '+caseOwner);
                
                list<User> us = [SELECT Id, Name, Agent__c, Agent_Queue_ID_Email_Reply_Customer__c FROM User WHERE Id =: caseOwner];*/
                
                system.debug('Case Owner (Before): '+c.OwnerId);
                
                List<User> us = new List<User>();       
                String agentQueue = '';
                
                if(c.Owner.Type == 'User' && (c.Entity_Backup__c == 'ALI' || c.Entity_Backup__c == 'AFI')){
                    us = [SELECT Id, Name, Agent__c, Agent_Queue_ID_Email_Reply_Customer__c FROM User WHERE Id =: c.OwnerId];
                    
                    Boolean isAgent = FALSE;
                    if (us.size() > 0){
                        isAgent = us[0].Agent__c;  
                    }
                    
                    if(isAgent == TRUE){
                        system.debug('User Agent');
                        agentQueue = us[0].Agent_Queue_ID_Email_Reply_Customer__c;
                        system.debug('Agent Queue ID: '+agentQueue);
                    } else {
                        system.debug('Not User Agent.');
                    }
                }
                
                if(sp.PersonaId != null) {
                    SocialPersona spe = [SELECT Id, ProfileUrl FROM SocialPersona WHERE Id = :sp.PersonaId];
                    c.Social_Account_Url__c = spe.ProfileUrl;
                }
                
                if(sp.IsOutbound == true) { c.Post_Status__c = 'Replied';
                    //c.OwnerId = agentQueue;
                    system.debug('====== Social Post : Outbound');
                } else {
                    c.Post_Status__c = 'Unread';
                    if(agentQueue != '') { c.OwnerId = agentQueue; }
                    system.debug('====== Social Post : Inbound');
                }
                system.debug('Case Owner (After): '+c.OwnerId);
                
                if(sp.Handle == null) { c.Last_Post_By__c = UserInfo.getName();
                } else { c.Last_Post_By__c = sp.Handle;
                }
                
                c.Last_Post_Message__c = sp.Content;
                c.Last_Posted_Date__c = sp.Posted;
                c.Last_Post_Provider__c = sp.Provider;
                c.Last_Post_Url__c = sp.PostUrl;
                
                update c;
            }
        }
    }
    //END - AFTER INSERT
}