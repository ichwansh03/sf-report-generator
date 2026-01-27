@isTest
public class CampRedemptLapseTest {
    static ID rtAgent = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    
    @isTest static void testCreateManual(){
        Integer issuedDays = Integer.valueOf(System.Label.WelcomeCall_Redepmtion_Date_Day); 
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate;
        Date processDate2;
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1);
            processDate2 = now.addDays((issuedDays + 1) * -1);
        }
        
        Contact con5 = new Contact(LastName='Just Test 6',
                                   Policy_No__c = '511-1234588',
                                   Lapse_Date_Day__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='AMPKS',
                                   Campaign_Type__c = 'Lapse_TM',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='DMTM',
                                   WelcomeCall_Currency__c='RP');
        insert con5;
        
        System.debug('con 5 --> ' + con5.Id);
        
        String formatName = 'Lapse TM';
        String monthNow = Datetime.now().format('yyyyMM');
        formatName = 'Collection-'+formatName +'#'+ monthNow;
        Date next_month = now.addMonths(1);
        Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
            // System.debug(formatName);
        RecordType recId = getRecordTypeId('Collection AMFS', 'Call_List__c');
        
        Call_List__c calist = new Call_List__c(Activity__c = 'Collection',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = 'Lapse TM',
                                                       Entity__c = 'AMFS',
                                                       Expired_Date__c = expiry_date,
                                                       //RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = true);
                
        insert calist;
        
        
        system.debug('MASUK ROBIN ATAS --> ' + calist.id);
        /*List<Call_line__C> callLineLs = new List<Call_line__C>();
        Call_Line__c calin = new Call_Line__c(RecordTypeId = '0120K000000q1QTQAY',
                                                          Contact__c = con5.Id,
                                                          Call_List__c =calist.id,
                                                          WelcomeCall_Call_Line_Status__c = 'Open',
                                                          //Case_Type__c = caseType,
                                                          //Case_Type_Config__c = caseTypeConfig,
                                                          Contacted_Number__c = con5.MobilePhone,
                                                          Phone__c = con5.Phone,
                                                          Home_Phone__c = con5.HomePhone,
                                                          Other_Phone__c = con5.OtherPhone,
                                                          //Activity__c = activity,
                                                          Policy_no__c = con5.policy_no__c,
                                                          Entity__c = con5.Entity__c);
        callLineLs.add(calin);
        insert callLineLs;*/
        
        CampaignRedemptionKonvenAndTM cal = new CampaignRedemptionKonvenAndTM();
        cal.execute(null);
        //cal.roundRobinDist(true);
        //cal.generateMonthlyCampaign('Manual');
        //cal.generateDailyCallLines();
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c FROM Call_List__c WHERE Campaign_Name__c = 'Collection-Lapse TM#202403'];
        
        //system.assert(calis.size() > 0);
        //system.assertEquals('WelcomeCall1810Manual', calis[0].Campaign_Name__c);
    }
    
    @isTest static void testCreateManual3(){
        Integer issuedDays = Integer.valueOf(System.Label.WelcomeCall_Redepmtion_Date_Day); 
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate;
        Date processDate2;
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1);
            processDate2 = now.addDays((issuedDays + 1) * -1);
        }
        
        Contact con5 = new Contact(LastName='Just Test 6',
                                   Policy_No__c = '511-1234588',
                                   Lapse_Date_Day__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='AMPKS',
                                   Campaign_Type__c = 'Lapse_TM',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='DMTM',
                                   WelcomeCall_Currency__c='RP');
        insert con5;
        
        System.debug('con 5 --> ' + con5.Id);
        
        String formatName = 'Test TM';
        String monthNow = Datetime.now().format('yyyyMM');
        formatName = 'Collection-'+formatName +'#'+ monthNow;
        Date next_month = now.addMonths(1);
        Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
            // System.debug(formatName);
        RecordType recId = getRecordTypeId('Collection AMFS', 'Call_List__c');
        
        Call_List__c calist = new Call_List__c(Activity__c = 'Collection',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = 'Lapse TM',
                                                       Entity__c = 'AMFS',
                                                       Expired_Date__c = expiry_date,
                                                       //RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = true);
                
        insert calist;
        
        
        system.debug('MASUK ROBIN ATAS --> ' + calist.id);
        /*List<Call_line__C> callLineLs = new List<Call_line__C>();
        Call_Line__c calin = new Call_Line__c(RecordTypeId = '0120K000000q1QTQAY',
                                                          Contact__c = con5.Id,
                                                          Call_List__c =calist.id,
                                                          WelcomeCall_Call_Line_Status__c = 'Open',
                                                          //Case_Type__c = caseType,
                                                          //Case_Type_Config__c = caseTypeConfig,
                                                          Contacted_Number__c = con5.MobilePhone,
                                                          Phone__c = con5.Phone,
                                                          Home_Phone__c = con5.HomePhone,
                                                          Other_Phone__c = con5.OtherPhone,
                                                          //Activity__c = activity,
                                                          Policy_no__c = con5.policy_no__c,
                                                          Entity__c = con5.Entity__c);
        callLineLs.add(calin);
        insert callLineLs;*/
        
        CampaignRedemptionKonvenAndTM cal = new CampaignRedemptionKonvenAndTM();
        cal.execute(null);
        //cal.roundRobinDist(true);
        //cal.generateMonthlyCampaign('Manual');
        //cal.generateDailyCallLines();
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c FROM Call_List__c WHERE Campaign_Name__c = 'Collection-Lapse TM#202403'];
        
        //system.assert(calis.size() > 0);
        //system.assertEquals('WelcomeCall1810Manual', calis[0].Campaign_Name__c);
    }

static RecordType getRecordTypeId(string recordTypeName, string sObjectName)
    {
        RecordType result;
        list <RecordType> recordTypeList = [
          SELECT Id, Name, SObjectType 
          FROM RecordType 
          WHERE SObjectType = :sObjectName ORDER BY Name
        ];
        for(RecordType recordType: recordTypeList)
        {
            if(recordType.Name.equalsIgnoreCase(recordTypeName))
            {
                result = recordType; 
                break;
            }
        }
        
        return result;
    }
    
    @isTest static void testCreateManual2(){
        Integer issuedDays = Integer.valueOf(System.Label.WelcomeCall_Redepmtion_Date_Day); 
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate;
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1); 
        }
        Contact con5 = new Contact(LastName='Just Test 6',
                                   Policy_No__c = '511-1234568',
                                   Lapse_Date_Day__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='AMPKS',
                                   Campaign_Type__c = 'Redemption_TM',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='DMTM',
                                   WelcomeCall_Currency__c='RP');
        insert con5;
        
        CampaignRedemptionKonvenAndTM cal = new CampaignRedemptionKonvenAndTM();
        cal.execute(null);
        //cal.generateMonthlyCampaign('Manual');
        //cal.generateDailyCallLines();
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c FROM Call_List__c WHERE Campaign_Name__c = 'Collection-Redemption TM#202403'];
        
        //system.assert(calis.size() > 0);
        //system.assertEquals('WelcomeCall1810Manual', calis[0].Campaign_Name__c);
    }
    
    @isTest static void testCreateAutomatic(){
        CampaignRedemptionKonvenAndTM cal = new CampaignRedemptionKonvenAndTM();
        cal.generateMonthlyCampaign('Automatic');
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c FROM Call_List__c WHERE Campaign_Name__c = 'Collection-Lapse TM#202403'];
        
        //system.assert(calis.size() > 0);
        //system.assertEquals('WelcomeCall1810Automatic', calis[0].Campaign_Name__c);
    }
    
    @isTest static void testCreateOther(){
        CampaignRedemptionKonvenAndTM cal = new CampaignRedemptionKonvenAndTM();
        cal.generateMonthlyCampaign('Other');
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c, Activity__c,Case_Type_Config__c,Expired_Date__c,Entity__c,WelcomeCall_Fg_Automatic__c  FROM Call_List__c WHERE Campaign_Name__c = 'Collection-Lapse TM#20240312'];
        
        /*system.assert(calis.size() > 0);
system.assertEquals('WelcomeCall1810Other', calis[0].Campaign_Name__c);
system.assertEquals('Confirmation', calis[0].Activity__c);
system.assertEquals('Welcome Call', calis[0].Case_Type_Config__c);
system.assertEquals(Date.valueOf('2018-11-15'), calis[0].Expired_Date__c);
system.assertEquals('AMFS', calis[0].Entity__c);
system.assertEquals(false, calis[0].WelcomeCall_Fg_Automatic__c);*/
    }
    
    @isTest static void testRoundRobin(){
        List<WelcomeCall_Criteria__c> crit = new List<WelcomeCall_Criteria__c>{
            
                new WelcomeCall_Criteria__c(Name='Collection - Lapse TM', WelcomeCall_Start_Range__c=0, WelcomeCall_End_Range__c=0,
                                            WelcomeCall_Start_Range_USD__c=0,WelcomeCall_End_Range_USD__c=0),
                new WelcomeCall_Criteria__c(Name='Collection - Redemption TM', WelcomeCall_Start_Range__c=0, WelcomeCall_End_Range__c=0,
                                            WelcomeCall_Start_Range_USD__c=0,WelcomeCall_End_Range_USD__c=0)
                };
                    insert crit;
        
        List<WelcomeCall_Group__c> groups = new List<WelcomeCall_Group__c>{
           
                new WelcomeCall_Group__c(Name='Collection - Redemption TM', WelcomeCall_Criteria__c='Collection - Redemption TM', WelcomeCall_Last_Priority__c=1, WelcomeCall_Entity__c = 'AMFS',
                                         WelcomeCall_Status__c = true),
                new WelcomeCall_Group__c(Name='Collection - Lapse TM', WelcomeCall_Criteria__c='Collection - Lapse TM', WelcomeCall_Last_Priority__c=1, WelcomeCall_Entity__c = 'AMFS',
                                         WelcomeCall_Status__c = true)
                };
                    insert groups;

        for(Integer i = 0; i < groups.size() ; i++){
            system.debug('group : '+groups[i].WelcomeCall_Last_Priority__c);
            groups[i].WelcomeCall_Last_Priority__c = groups[i].WelcomeCall_Last_Priority__c;
        }
        update groups;
        
        
        Profile profileList = [SELECT Id,Name FROM Profile WHERE Name = 'System Administrator'];
        
        User userbaru = new User();
        userbaru.LastName = 'halo';
        userbaru.Alias = 'hl';
        userbaru.Email = 'xicy@wmail.com';
        userbaru.Username = 'xicy@wmail.com';
        userbaru.CommunityNickname = 'sembarang';
        userbaru.ProfileId = profileList.Id;
        userbaru.Entity__c = 'AMFS';
        userbaru.LocaleSidKey = 'en_ID';
        userbaru.LanguageLocaleKey = 'en_US';
        userbaru.EmailEncodingKey = 'UTF-8';
        userbaru.TimeZoneSidKey = 'Asia/Jakarta';
        insert userbaru;
        
        system.debug('rtAgentGroup LVLV = ' + rtAgentGroup);
        system.debug('rtAgent LVLV = ' + rtAgent);
        
        Agent_Group__c agent = new Agent_Group__c();
            agent.name = 'testing Agent';
            agent.WelcomeCall_Supervisor__c = true;
            agent.WelcomeCall_User__c = userbaru.Id;
            agent.RecordTypeId = rtAgent;
            agent.WelcomeCall_Resign__c = false;
            agent.WelcomeCall_Fg_Head__c = false;
            agent.WelcomeCall_Assignment__c = true;
            
            insert agent;
            
            Agent_Group__c agentGrp = new Agent_Group__c();
            agentGrp.name = 'testing Agent Group';
            agentGrp.WelcomeCall_Supervisor__c = true;
            agentGrp.Agent__c = agent.Id;
            agentGrp.RecordTypeId = rtAgentGroup;
            agentGrp.WelcomeCall_Group__c = groups.get(0).Id;
            agentGrp.WelcomeCall_Priority__c = 2;
            agentGrp.WelcomeCall_Resign__c = false;
            agentGrp.WelcomeCall_Fg_Head__c = false;
          agentGrp.WelcomeCall_Assignment__c = true;
            
            insert agentGrp;
        System.debug('agentGrp : '+agentGrp);
        
        User userEksternal = new User();
        userEksternal.LastName = 'halomsw';
        userEksternal.Alias = 'hlmsw';
        userEksternal.Email = 'testMSW@wmail.com';
        userEksternal.Username = 'testMSW@wmail.com';
        userEksternal.CommunityNickname = 'msw';
        userEksternal.ProfileId = profileList.Id;
        userEksternal.Entity__c = 'AMFS';
        userEksternal.LocaleSidKey = 'en_ID';
        userEksternal.LanguageLocaleKey = 'en_US';
        userEksternal.EmailEncodingKey = 'UTF-8';
        userEksternal.TimeZoneSidKey = 'Asia/Jakarta';
        insert userEksternal;
        
            Agent_Group__c agentMSW = new Agent_Group__c();
            agentMSW.name = 'testing Agent';
            agentMSW.WelcomeCall_Supervisor__c = true;
            agentMSW.WelcomeCall_User__c = userEksternal.Id;
            agentMSW.RecordTypeId = rtAgent;
            agentMSW.WelcomeCall_Resign__c = false;
            agentMSW.WelcomeCall_Fg_Head__c = false;
            agentMSW.WelcomeCall_Assignment__c = true;
            
            insert agentMSW;
            
          
        
        Integer issuedDays = 2; 
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate;
        Date processDate2;
        system.debug('Issued days: '+issuedDays);
        system.debug('Day of week: '+dayOfWeek);
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1);
            processDate2 = now.addDays((issuedDays + 1) * -1);
        }
        else if(dayOfWeek == 'Tue'){
            if(issuedDays < 2){
                processDate = now.addDays(issuedDays * -1);
            }else if(issuedDays >= 2){
                processDate = now.addDays((issuedDays + 1) * -1);
              processDate2 = now.addDays((issuedDays) * -1);
            }
        }
        else if(dayOfWeek == 'Wed'){
            if(issuedDays < 3){
                processDate = now.addDays(issuedDays * -1);
              processDate2 = now.addDays((issuedDays - 1) * -1);
            }else if(issuedDays >= 3){
                processDate = now.addDays((issuedDays + 2) * -1);
            }
        }
        else if(dayOfWeek == 'Thu'){
            if(issuedDays < 4){
                processDate = now.addDays(issuedDays * -1);
              processDate2 = now.addDays((issuedDays - 1) * -1);
            }else if(issuedDays >= 4){
                processDate = now.addDays((issuedDays + 2) * -1);
            }
        }
        //else if(dayOfWeek == 'Fri'){
        else if(dayOfWeek == 'Fri'){
            if(issuedDays < 5){
                processDate = now.addDays(issuedDays * -1);
              processDate2 = now.addDays((issuedDays - 1) * -1);
            }else if(issuedDays >= 5){
                processDate = now.addDays((issuedDays + 2) * -1);
            }
        }else {
            if(issuedDays < 4){
                processDate = now.addDays(issuedDays * -1);
                processDate2 = now.addDays((issuedDays - 1) * -1);
            }else if(issuedDays >= 4){
                processDate = now.addDays((issuedDays + 2) * -1);
            }
        }
        
        system.debug('processDate TEST 1 ==>  '+processDate);
        system.debug('processDate TEST 1a ==>  '+processDate2);
        // Criteria HVC RP Monthly
        Contact con5 = new Contact(LastName='Just Test 6',
                                   Policy_No__c = '511-1234588',
                                   Lapse_Date_Day__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='AMPKS',
                                   Campaign_Type__c = 'Lapse_TM',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='DMTM',
                                   WelcomeCall_Currency__c='RP');
        system.debug('connnnn==>  '+con5);
        
        insert con5;
        
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1);  // minus 3 untuk hari Senin untuk mengambil process Date Jumat
        }else if(dayOfWeek != 'Sun' && dayOfWeek != 'Sat'){
            processDate = now.addDays(-1); // minus 1 untuk hari sebelumnya   
        }
        system.debug('processDate TEST 2==>  '+processDate);
        Contact con6 = new Contact(LastName='Just Test 6',
                                   //WelcomeCall_APE__c=120000000,
                                   WelcomeCall_Payment_Type__c ='A',
                                   Premium__c=11000000,
                                   Total_Premium__c=11000000,
                                   WelcomeCall_Issued_Date__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='MSW5A',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='RLS',
                                   WelcomeCall_Currency__c='RP');
        insert con6;
        
        CampaignRedemptionKonvenAndTM cal = new CampaignRedemptionKonvenAndTM();
        cal.generateMonthlyCampaign('Automatic');
        
        String formatName = 'Lapse TM';
        String monthNow = Datetime.now().format('yyyyMM');
        formatName = 'Collection-'+formatName +'#'+ monthNow;
        Date next_month = now.addMonths(1);
        Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
            // System.debug(formatName);
        RecordType recId = getRecordTypeId('Collection AMFS', 'Call_List__c');
        
        Call_List__c calist = new Call_List__c(Activity__c = 'Collection',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = 'Lapse TM',
                                                       Entity__c = 'AMFS',
                                                       Expired_Date__c = expiry_date,
                                                       //RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = true);
                
        insert calist;
       
        Call_List__c calis = [SELECT Id FROM Call_List__c WHERE Campaign_Name__c =: formatName limit 1];
        system.debug('sebelum coba null nihxx' + calis);
        //cal.generateDailyCallLines(calis.Id);
        cal.roundRobinDist(true);
        
        Call_Line__c[] lin = [SELECT Id, Contact__r.Name, WelcomeCall_Call_Line_Status__c, ownerId FROM Call_Line__c
                              WHERE Call_List__c = :calis.Id];
        
        CampaignRedemptionLapseQueueable.doChainJob = false;
        system.debug('sebelum coba null nih');
        System.enqueueJob(new CampaignRedemptionLapseQueueable(lin));
        System.enqueueJob(new RoundRobinRedemptionLapse());
        
        // Agar catch bisa ter-cover
        //System.enqueueJob(new CampaignRedemptionLapseQueueable(null));
    }
}