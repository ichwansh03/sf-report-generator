trigger UpdateCaseInfoSprout on SproutSocialApp__Sprout_Social_Post__c (before insert, after insert) {
    
     List<SproutSocialApp__Sprout_Social_Post__c> updatedSocialPostList = new List<SproutSocialApp__Sprout_Social_Post__c>();
     Map<String, SproutSocialApp__Sprout_Social_Post__c> socialPostMap = new Map<String, SproutSocialApp__Sprout_Social_Post__c>();
     Map<String, String> setMapresponse = new Map<String, String>();
    
    String entityUser = [SELECT Id, Entity__c FROM User WHERE Id = :UserInfo.getUserId()][0].Entity__c;
    system.debug('entityUser: '+entityUser);
    
    //BEFORE INSERT
    if(Trigger.isBefore && Trigger.isInsert){
        
         UpdateCaseInfoTriggerHandler.onBeforeInsert(Trigger.new);
 
        
        
  /*      for(SproutSocialApp__Sprout_Social_Post__c sp : Trigger.new) {

            if(sp.SproutSocialApp__IsOutbound__c == TRUE){
                socialPostMap.put(sp.SproutSocialApp__ParentId__c, sp);
                system.debug('socialPostMap: '+socialPostMap);
                system.debug('socialPostMap (Key Set): '+socialPostMap.keySet());
            }
            
      //      if(/*entityUser == 'AFI' && sp.SproutSocialApp__PostTags__c != null){
                if(sp.SproutSocialApp__IsOutbound__c == false/* && (sp.SproutSocialApp__PostTags__c.containsIgnoreCase('AXA Financial Indonesia') || sp.SproutSocialApp__PostTags__c.containsIgnoreCase('AXA Financial'))){
                    system.debug('=== Check Posted Date in Business Hours AFI or not ===');
                    datetime dt_PostedDate = sp.SproutSocialApp__Posted__c;
                    datetime dt_StartNextDate = DateTime.newInstance(dt_PostedDate.year(),dt_PostedDate.month(),dt_PostedDate.day(),0,0,0);
                    datetime dt_EndNextDate = DateTime.newInstance(dt_PostedDate.year(),dt_PostedDate.month(),dt_PostedDate.day(),8,0,0);
                    datetime dtime_cutOff_AFI = DateTime.newInstance(dt_PostedDate.year(),dt_PostedDate.month(),dt_PostedDate.day(),16,0,0);
                    
                    datetime nextStartBusinessHours;
                    //if it is within the business hours. The returned time will be in the local time zone
                    nextStartBusinessHours = BusinessHours.nextStartDate(system.label.BusinessHoursAFI_Customer, sp.SproutSocialApp__Posted__c);
                    
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
                    }
                    
                    if(sp.SproutSocialApp__Posted__c <= dtime_cutOff_AFI && sp.SproutSocialApp__Posted__c >= dt_EndNextDate && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun') && sp.PostDate_Temporary__c == null){
                        system.debug('=== In Business Hours (>=8.00 AM && <=4.00 PM) ===');
                        sp.PostDate_Temporary__c = sp.SproutSocialApp__Posted__c;
                    } else if(sp.SproutSocialApp__Posted__c <= dtime_cutOff_AFI && sp.SproutSocialApp__Posted__c < dt_EndNextDate && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== Before Business Hours (<8.00 AM && <=4.00 PM) ==='); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    } else if(sp.SproutSocialApp__Posted__c <= dtime_cutOff_AFI && (dt_PostedDate.format('E') == 'Sat' || dt_PostedDate.format('E') == 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== After Business Hours (> 4.00 PM) === (1)'); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    } else if(sp.SproutSocialApp__Posted__c > dtime_cutOff_AFI && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== After Business Hours (> 4.00 PM) === (2)'); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    } else if(sp.SproutSocialApp__Posted__c > dtime_cutOff_AFI && (dt_PostedDate.format('E') == 'Sat' || dt_PostedDate.format('E') == 'Sun') && sp.PostDate_Temporary__c == null){ system.debug('=== After Business Hours (> 4.00 PM) === (3)'); sp.PostDate_Temporary__c = nextStartBusinessHours;
                    }
                    
                    system.debug('=== Update sp.PostDate_Temporary__c: '+sp.PostDate_Temporary__c);
                }
        }
        
          List<SproutSocialApp__Sprout_Social_Post__c> socialPostList = [SELECT Id,SproutSocialApp__ReplyToId__r.Id,SproutSocialApp__ParentId__r.Id, PostDate_Temporary__c, SproutSocialApp__ResponseContextExternalId__c, SproutSocialApp__ReplyToId__c, Name, SproutSocialApp__ParentId__c, SproutSocialApp__Content__c, SproutSocialApp__Message_Type__c, SproutSocialApp__IsOutbound__c, SproutSocialApp__Posted__c, First_Response_Date__c, Last_Response_Date__c, SproutSocialApp__PostTags__c, Owner.Name, CreatedDate FROM SproutSocialApp__Sprout_Social_Post__c WHERE SproutSocialApp__ParentId__c IN :socialPostMap.keySet() AND SproutSocialApp__IsOutbound__c = FALSE ORDER BY SproutSocialApp__Posted__c ASC ];
        system.debug('socialPostList: '+socialPostList);
      
    //List<SproutSocialApp__Sprout_Social_Post__c> socialPostList2 = new List<SproutSocialApp__Sprout_Social_Post__c>(); // Deklarasikan variabel di luar blok try

         List<SproutSocialApp__Sprout_Social_Post__c> socialPostList2 = [SELECT Id,SproutSocialApp__ReplyToId__r.Id,SproutSocialApp__ParentId__r.Id, PostDate_Temporary__c, SproutSocialApp__ResponseContextExternalId__c, SproutSocialApp__ReplyToId__c, Name, SproutSocialApp__ParentId__c, SproutSocialApp__Content__c, SproutSocialApp__Message_Type__c, SproutSocialApp__IsOutbound__c, SproutSocialApp__Posted__c, First_Response_Date__c, Last_Response_Date__c, SproutSocialApp__PostTags__c, Owner.Name, CreatedDate FROM SproutSocialApp__Sprout_Social_Post__c WHERE SproutSocialApp__ParentId__c IN :socialPostMap.keySet() AND SproutSocialApp__IsOutbound__c = TRUE ORDER BY SproutSocialApp__Posted__c DESC limit 1  ];
        system.debug('socialPostList2: '+socialPostList2);

        
        boolean isFirstDataAdded = false;
        
       
        
        for(SproutSocialApp__Sprout_Social_Post__c mp:socialPostList ){ 
            if (socialPostList2.isEmpty() || socialPostList2[0].SproutSocialApp__Posted__c < mp.SproutSocialApp__Posted__c) {
                    if (!isFirstDataAdded) {
                        setMapresponse.put(mp.SproutSocialApp__ParentId__c + 'first_Response', String.valueOf(mp.SproutSocialApp__Posted__c));
                        setMapresponse.put(mp.SproutSocialApp__ParentId__c + 'Id_Response', mp.Id);
                        system.debug('socialPostListmapfirst: ' + setMapresponse);
                        isFirstDataAdded = true;
                    }
                }

        }
        
        for(SproutSocialApp__Sprout_Social_Post__c mr:socialPostList2 ){
            setMapresponse.put(mr.SproutSocialApp__ParentId__c+'agent_Response', string.valueof(mr.SproutSocialApp__Posted__c));
            system.debug('socialPostList2map: '+setMapresponse);         
        }



      for (SproutSocialApp__Sprout_Social_Post__c sptwo : socialpostmap.values()) {
   		if (setMapresponse.containsKey(sptwo.SproutSocialApp__ParentId__c + 'Id_Response')) {
        SproutSocialApp__Sprout_Social_Post__c setUpdate = new SproutSocialApp__Sprout_Social_Post__c();
        setUpdate.id = setMapresponse.get(sptwo.SproutSocialApp__ParentId__c + 'Id_Response');
        if (setMapresponse.containsKey(sptwo.SproutSocialApp__ParentId__c + 'first_Response')) {
            setUpdate.First_Response_Date__c = DateTime.valueOf(setMapresponse.get(string.valueof(sptwo.SproutSocialApp__ParentId__c + 'first_Response')));
        }
        if (setMapresponse.containsKey(sptwo.SproutSocialApp__ParentId__c + 'agent_Response')) {
            setUpdate.Last_Response_Date__c = DateTime.valueOf(setMapresponse.get(string.valueof(sptwo.SproutSocialApp__ParentId__c + 'agent_Response')));
        }

        updatedSocialPostList.add(setUpdate);
         system.debug('===spOne.First_Response_Date_In_Datetime__c: ' + setUpdate.First_Response_Date__c);
  		 system.debug('===spOne.Last_Response_Date__c: ' + setUpdate.Last_Response_Date__c);
    	}
          
         if (updatedSocialPostList.size() > 0) update updatedSocialPostList; 
    }    */   
       
 }
        
        

    //END - BEFORE INSERT
   
    
    //AFTER INSERT
    
    
    
    
    if(Trigger.isAfter && Trigger.isInsert) {
        
        for(SproutSocialApp__Sprout_Social_Post__c sp : Trigger.new) {
            if(sp.SproutSocialApp__ParentId__c != null) {
                Case c = [SELECT Id, Post_Status__c, Entity_Backup__c, OwnerId, Owner.Type FROM Case WHERE Id = :sp.SproutSocialApp__ParentId__c];
                
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
                
                if(sp.SproutSocialApp__PersonaId__c != null) {
                    SproutSocialApp__Sprout_Social_Persona__c spe = [SELECT Id, SproutSocialApp__Profile_URL__c FROM SproutSocialApp__Sprout_Social_Persona__c WHERE Id = :sp.SproutSocialApp__PersonaId__c];
                    c.Social_Account_Url__c = spe.SproutSocialApp__Profile_URL__c;
                }
                
                if(sp.SproutSocialApp__IsOutbound__c == true) { c.Post_Status__c = 'Replied';
                    //c.OwnerId = agentQueue;
                    system.debug('====== Social Post : Outbound');
                } else {
                    c.Post_Status__c = 'Unread';
                    // changes by Ranti at 11/23/2021
                    // if(agentQueue != '') { c.OwnerId = agentQueue; }
                    if(agentQueue != '' && (entityUser != 'AFI' || entityUser != 'ALI')) { c.OwnerId = agentQueue; }
                    system.debug('====== Social Post : Inbound');
                }
                system.debug('Case Owner (After): '+c.OwnerId);
                
 /*               if(sp.Handle__c == null) { c.Last_Post_By__c = UserInfo.getName();
                } else { c.Last_Post_By__c = sp.Handle__c;
                }*/
                
             /*   if (sp.ModifiedGetUser__c == null) {
                    // Isi field LastModifiedByCustom__c dengan nilai dari LastModifiedBy.Name
                    sp.ModifiedGetUser__c = sp.LastModifiedBy.firstname;
                    system.debug('modifiedcustom: '+sp.ModifiedGetUser__c);
                }*/
                        
                c.Last_Post_By__c = sp.Get_Agent__c;
                c.Last_Post_Message__c = sp.SproutSocialApp__Content__c;
                c.Last_Posted_Date__c = sp.SproutSocialApp__Posted__c;
                c.Last_Post_Provider__c = sp.SproutSocialApp__Provider__c;
                c.Last_Post_Url__c = sp.SproutSocialApp__Post_URL__c;
                
                update c;
            }
        }
    }
    
       

}