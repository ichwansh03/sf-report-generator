public class UpdateCaseInfoTriggerHandler {
        public static void onBeforeInsert(List<SproutSocialApp__Sprout_Social_Post__c> newSocialPosts) {
        List<SproutSocialApp__Sprout_Social_Post__c> updatedSocialPostList = new List<SproutSocialApp__Sprout_Social_Post__c>();
        Map<String, SproutSocialApp__Sprout_Social_Post__c> socialPostMap = new Map<String, SproutSocialApp__Sprout_Social_Post__c>();
        Map<String, Datetime> postIdToDateMap = new Map<String, Datetime>();
        Map<Id, Datetime> originalLastResponseDates = new Map<Id, Datetime>();
      
        Map<String, String> setMapresponse = new Map<String, String>();
            
        Id currentUserId = UserInfo.getUserId();

        String entityUser = [SELECT Id, Entity__c FROM User WHERE Id = :UserInfo.getUserId()][0].Entity__c;
        System.debug('entityUser: ' + entityUser);

        for (SproutSocialApp__Sprout_Social_Post__c sp : newSocialPosts) {
            if (sp.SproutSocialApp__IsOutbound__c == true) {
                socialPostMap.put(sp.SproutSocialApp__ParentId__c, sp);
                System.debug('socialPostMap: ' + socialPostMap);
                System.debug('socialPostMap (Key Set): ' + socialPostMap.keySet());
            }

            if (sp.SproutSocialApp__IsOutbound__c == false) {
                System.debug('=== Check Posted Date in Business Hours AFI or not ===');
                Datetime dt_PostedDate = sp.SproutSocialApp__Posted__c;
                Datetime dt_StartNextDate = DateTime.newInstance(dt_PostedDate.year(), dt_PostedDate.month(), dt_PostedDate.day(), 0, 0, 0);
                Datetime dt_EndNextDate = DateTime.newInstance(dt_PostedDate.year(), dt_PostedDate.month(), dt_PostedDate.day(), 8, 0, 0);
                Datetime dt_CutOff_AFI = DateTime.newInstance(dt_PostedDate.year(), dt_PostedDate.month(), dt_PostedDate.day(), 16, 0, 0);

                Datetime nextStartBusinessHours;
                nextStartBusinessHours = BusinessHours.nextStartDate(system.label.BusinessHoursAFI_Customer, sp.SproutSocialApp__Posted__c);

                System.debug('check (dt_PostedDate): ' + dt_PostedDate);
                System.debug('check (dt_StartNextDate): ' + dt_StartNextDate);
                System.debug('check (dt_EndNextDate): ' + dt_EndNextDate);
                System.debug('check (dt_CutOff_AFI): ' + dt_CutOff_AFI);
                System.debug('check (nextStartBusinessHours): ' + nextStartBusinessHours);

                if (sp.SproutSocialApp__Posted__c <= dt_CutOff_AFI && sp.SproutSocialApp__Posted__c >= dt_EndNextDate && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun')) {
                    System.debug('=== In Business Hours (>=8.00 AM && <=4.00 PM) ===');
                    sp.PostDate_Temporary__c = sp.SproutSocialApp__Posted__c;
                } else if (sp.SproutSocialApp__Posted__c <= dt_CutOff_AFI && sp.SproutSocialApp__Posted__c < dt_EndNextDate && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun')) {
                    System.debug('=== Before Business Hours (<8.00 AM && <=4.00 PM) ===');
                    sp.PostDate_Temporary__c = nextStartBusinessHours;
                } else if (sp.SproutSocialApp__Posted__c <= dt_CutOff_AFI && (dt_PostedDate.format('E') == 'Sat' || dt_PostedDate.format('E') == 'Sun')) {
                    System.debug('=== After Business Hours (> 4.00 PM) === (1)');
                    sp.PostDate_Temporary__c = nextStartBusinessHours;
                } else if (sp.SproutSocialApp__Posted__c > dt_CutOff_AFI && (dt_PostedDate.format('E') != 'Sat' && dt_PostedDate.format('E') != 'Sun')) {
                    System.debug('=== After Business Hours (> 4.00 PM) === (2)');
                    sp.PostDate_Temporary__c = nextStartBusinessHours;
                } else if (sp.SproutSocialApp__Posted__c > dt_CutOff_AFI && (dt_PostedDate.format('E') == 'Sat' || dt_PostedDate.format('E') == 'Sun')) {
                    System.debug('=== After Business Hours (> 4.00 PM) === (3)');
                    sp.PostDate_Temporary__c = nextStartBusinessHours;
                }

                System.debug('=== Update sp.PostDate_Temporary__c: ' + sp.PostDate_Temporary__c);
            }
        }
        
    List<SproutSocialApp__Sprout_Social_Post__c> socialPostList2 = [
    SELECT SproutSocialApp__Posted__c
    FROM SproutSocialApp__Sprout_Social_Post__c
    WHERE SproutSocialApp__ParentId__c IN :socialPostMap.keySet()
        AND SproutSocialApp__IsOutbound__c = TRUE
    ORDER BY SproutSocialApp__Posted__c DESC
    LIMIT 1
];
System.debug('socialPostList2: ' + socialPostList2);

Datetime socialPostList2PostedDate = socialPostList2.isEmpty() ? Datetime.newInstance(2000, 1, 1) : socialPostList2[0].SproutSocialApp__Posted__c;

List<SproutSocialApp__Sprout_Social_Post__c> socialPostList = [
    SELECT Id, SproutSocialApp__ReplyToId__r.Id, SproutSocialApp__ParentId__r.Id, PostDate_Temporary__c, SproutSocialApp__ResponseContextExternalId__c,
        SproutSocialApp__ReplyToId__c, Name, SproutSocialApp__ParentId__c, SproutSocialApp__Content__c, SproutSocialApp__Message_Type__c,
        SproutSocialApp__IsOutbound__c, SproutSocialApp__Posted__c, First_Response_Date__c, Last_Response_Date__c, SproutSocialApp__PostTags__c,
        Owner.Name, CreatedDate
    FROM SproutSocialApp__Sprout_Social_Post__c
    WHERE SproutSocialApp__ParentId__c IN :socialPostMap.keySet()
        AND SproutSocialApp__IsOutbound__c = FALSE
        AND SproutSocialApp__Posted__c > :socialPostList2PostedDate
    ORDER BY CreatedDate limit 1
];
System.debug('socialPostList: ' + socialPostList);
            

            
        for (SproutSocialApp__Sprout_Social_Post__c spOne : socialPostList) {
            for (SproutSocialApp__Sprout_Social_Post__c spTwo : socialPostMap.values()) {
                if (spTwo.Id != spOne.Id && spTwo.SproutSocialApp__ParentId__c == spOne.SproutSocialApp__ParentId__c /*&& spTwo.ReplyToId == spOne.Id*/) {
                    if (spOne.SproutSocialApp__Posted__c < spTwo.SproutSocialApp__Posted__c && spOne.First_Response_Date__c == null) {
                        spOne.First_Response_Date__c = spTwo.SproutSocialApp__Posted__c;
                    }
                    spOne.Last_Response_Date__c = spTwo.SproutSocialApp__Posted__c;
                    updatedSocialPostList.add(spOne);
                }
                System.debug('===spOne.First_Response_Date_In_Datetime__c: ' + spOne.First_Response_Date__c);
                System.debug('===spOne.Last_Response_Date__c: ' + spOne.Last_Response_Date__c);
            }
        }
        System.debug('updatedSocialPostList: ' + updatedSocialPostList);
        update updatedSocialPostList;
        }
    
    
    
}