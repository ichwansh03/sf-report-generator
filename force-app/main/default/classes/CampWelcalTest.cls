@isTest
public class CampWelcalTest {
    static ID rtAgent = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    @isTest static void testCreateManual(){
        CampaignWelcomeCall cal = new CampaignWelcomeCall();
        cal.generateMonthlyCampaign('Manual');
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c FROM Call_List__c WHERE Campaign_Name__c = 'WelcomeCall1810Manual'];
        
        //system.assert(calis.size() > 0);
        //system.assertEquals('WelcomeCall1810Manual', calis[0].Campaign_Name__c);
    }
    
    @isTest static void testCreateAutomatic(){
        CampaignWelcomeCall cal = new CampaignWelcomeCall();
        cal.generateMonthlyCampaign('Automatic');
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c FROM Call_List__c WHERE Campaign_Name__c = 'WelcomeCall1810Automatic'];
        
        //system.assert(calis.size() > 0);
        //system.assertEquals('WelcomeCall1810Automatic', calis[0].Campaign_Name__c);
    }
    
    @isTest static void testCreateOther(){
        CampaignWelcomeCall cal = new CampaignWelcomeCall();
        cal.generateMonthlyCampaign('Other');
        
        Call_List__c[] calis = [SELECT Id, Campaign_Name__c, Activity__c,Case_Type_Config__c,Expired_Date__c,Entity__c,WelcomeCall_Fg_Automatic__c  FROM Call_List__c WHERE Campaign_Name__c = 'WelcomeCall1810Other'];
        
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
            new WelcomeCall_Criteria__c(Name='HVC', WelcomeCall_Start_Range__c=80000000, WelcomeCall_End_Range__c=1500000000,
                                        WelcomeCall_Start_Range_USD__c=8000,WelcomeCall_End_Range_USD__c=0),
                new WelcomeCall_Criteria__c(Name='RETAIL', WelcomeCall_Start_Range__c=10000000, WelcomeCall_End_Range__c=79000000,
                                            WelcomeCall_Start_Range_USD__c=1000,WelcomeCall_End_Range_USD__c=7999),
                new WelcomeCall_Criteria__c(Name='UNDERRETAIL', WelcomeCall_Start_Range__c=0, WelcomeCall_End_Range__c=9999999,
                                            WelcomeCall_Start_Range_USD__c=0,WelcomeCall_End_Range_USD__c=999),
                new WelcomeCall_Criteria__c(Name='RETAIL MSW EKSTERNAL', WelcomeCall_Start_Range__c=10000000, WelcomeCall_End_Range__c=49999999,
                                            WelcomeCall_Start_Range_USD__c=0,WelcomeCall_End_Range_USD__c=0),
                new WelcomeCall_Criteria__c(Name='RETAIL MSW INTERNAL', WelcomeCall_Start_Range__c=50000000, WelcomeCall_End_Range__c=79999999,
                                            WelcomeCall_Start_Range_USD__c=0,WelcomeCall_End_Range_USD__c=0)
                };
                    insert crit;
        
        List<WelcomeCall_Group__c> groups = new List<WelcomeCall_Group__c>{
            new WelcomeCall_Group__c(Name='HVC', WelcomeCall_Criteria__c='HVC', WelcomeCall_Last_Priority__c=1, WelcomeCall_Entity__c = 'AMFS',
                                     WelcomeCall_Status__c = true),
                new WelcomeCall_Group__c(Name='RETAIL', WelcomeCall_Criteria__c='RETAIL', WelcomeCall_Last_Priority__c=1, WelcomeCall_Entity__c = 'AMFS',
                                         WelcomeCall_Status__c = true),
                new WelcomeCall_Group__c(Name='UNDERRETAIL', WelcomeCall_Criteria__c='UNDERRETAIL', WelcomeCall_Last_Priority__c=1, WelcomeCall_Entity__c = 'AMFS',
                                         WelcomeCall_Status__c = true),
                new WelcomeCall_Group__c(Name='RETAIL MSW EKSTERNAL', WelcomeCall_Criteria__c='RETAIL MSW EKSTERNAL', WelcomeCall_Last_Priority__c=1, WelcomeCall_Entity__c = 'AMFS',
                                         WelcomeCall_Status__c = true),
                new WelcomeCall_Group__c(Name='RETAIL MSW INTERNAL', WelcomeCall_Criteria__c='RETAIL MSW INTERNAL', WelcomeCall_Last_Priority__c=1, WelcomeCall_Entity__c = 'AMFS',
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
            
            Agent_Group__c agentGrpMSW = new Agent_Group__c();
            agentGrpMSW.name = 'testing Agent Group';
            agentGrpMSW.WelcomeCall_Supervisor__c = true;
            agentGrpMSW.Agent__c = agentMSW.Id;
            agentGrpMSW.RecordTypeId = rtAgentGroup;
            agentGrpMSW.WelcomeCall_Group__c = groups.get(2).Id;
            agentGrpMSW.WelcomeCall_Priority__c = 2;
            agentGrpMSW.WelcomeCall_Resign__c = false;
            agentGrpMSW.WelcomeCall_Fg_Head__c = false;
        	agentGrpMSW.WelcomeCall_Assignment__c = true;
            
            insert agentGrpMSW;
        System.debug('agentGrpMSW : '+agentGrpMSW);
        
        Integer issuedDays = Integer.valueOf(System.Label.WelcomeCall_Issued_Date_Day); 
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate;
        system.debug('Issued days: '+issuedDays);
        system.debug('Day of week: '+dayOfWeek);
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1); // minus 1 untuk hari sebelumnya
        }
        else if(dayOfWeek == 'Tue'){
            if(issuedDays < 2)
                processDate = now.addDays(issuedDays * -1);
            else if(issuedDays >= 2)
                processDate = now.addDays((issuedDays + 2) * -1);
        }
        else if(dayOfWeek == 'Wed'){
            if(issuedDays < 3)
                processDate = now.addDays(issuedDays * -1);
            else if(issuedDays >= 3)
                processDate = now.addDays((issuedDays + 2) * -1);
        }
        else if(dayOfWeek == 'Thu'){
            if(issuedDays < 4)
                processDate = now.addDays(issuedDays * -1);
            else if(issuedDays >= 4)
                processDate = now.addDays((issuedDays + 2) * -1);
        }
        else if(dayOfWeek == 'Fri'){
            if(issuedDays < 5)
                processDate = now.addDays(issuedDays * -1);
            else if(issuedDays >= 5)
                processDate = now.addDays((issuedDays + 2) * -1);
        }
        // Criteria HVC RP Monthly
        Contact con = new Contact(LastName='Just Test',
                                  WelcomeCall_Payment_Type__c ='M',
                                  Premium__c=1000000,
                                  Total_Premium__c=1000000,
                                  WelcomeCall_Issued_Date__c=processDate,
                                  WelcomeCall_Product_Code_Plan__c='HONMEP',
                                  MobilePhone='081111222',
                                  HomePhone='02111100',
                                  Phone='021222222',
                                  OtherPhone='01892874',
                                  Entity__c='AMFS',
                                  PolicyApp__c='RLS',
                                  WelcomeCall_Currency__c='RP');
        // Criteria HVC USD Monthly
        Contact con1 = new Contact(LastName='Just Test 2',
                                   WelcomeCall_Payment_Type__c ='M',
                                   Premium__c=5000,
                                   Total_Premium__c=5000,
                                   WelcomeCall_Issued_Date__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='HONMEP',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='RLS',
                                   WelcomeCall_Currency__c='USD');
        // Criteria RETAIL USD Monthly
        Contact con2 = new Contact(LastName='Just Test 3',
                                   WelcomeCall_Payment_Type__c ='M',
                                   Premium__c=500,
                                   Total_Premium__c=500,
                                   WelcomeCall_Issued_Date__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='MSKA',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='RLS',
                                   WelcomeCall_Currency__c='USD');
        // Criteria RETAIL RP Monthly
        Contact con3 = new Contact(LastName='Just Test 4',
                                   WelcomeCall_Payment_Type__c ='M',
                                   Premium__c=5000000,
                                   Total_Premium__c=5000000,
                                   WelcomeCall_Issued_Date__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='AMPKS',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='RLS',
                                   WelcomeCall_Currency__c='RP');
        // Criteria UNDERRETAIL USD Annual
        Contact con4 = new Contact(LastName='Just Test 5',
                                   //WelcomeCall_APE__c=120000000,
                                   WelcomeCall_Payment_Type__c ='A',
                                   Premium__c=100,
                                   Total_Premium__c=100,
                                   WelcomeCall_Issued_Date__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='MSKA',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='RLS',
                                   WelcomeCall_Currency__c='USD');
        // Criteria UNDERRETAIL RP Annual
        Contact con5 = new Contact(LastName='Just Test 6',
                                   //WelcomeCall_APE__c=120000000,
                                   WelcomeCall_Payment_Type__c ='A',
                                   Policy_No__c = '511-1234567',
                                   Premium__c=5000000,
                                   Total_Premium__c=5000000,
                                   WelcomeCall_Issued_Date__c=processDate,
                                   WelcomeCall_Product_Code_Plan__c='AMPKS',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='RLS',
                                   WelcomeCall_Currency__c='RP');
        insert con;
        insert con1;
        insert con2;
        insert con3;
        insert con4;
        insert con5;
        
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays(-3); // minus 3 untuk hari Senin untuk mengambil process Date Jumat
        }else if(dayOfWeek != 'Sun' && dayOfWeek != 'Sat'){
            processDate = now.addDays(-1); // minus 1 untuk hari sebelumnya   
        }
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
        
        CampaignWelcomeCall cal = new CampaignWelcomeCall();
        cal.generateMonthlyCampaign('Automatic');
        
        String formatName = 'WelcomeCall';
        String monthNow = Datetime.now().format('yyMM');
        formatName = formatName + monthNow + 'Automatic';
        Call_List__c calis = [SELECT Id
                              FROM Call_List__c 
                              WHERE Campaign_Name__c =: formatName];
        cal.generateDailyCallLines(calis.Id);
        // cal.roundRobinDist(true);
        
        Call_Line__c[] lin = [SELECT Id, Contact__r.Name, WelcomeCall_Call_Line_Status__c, ownerId FROM Call_Line__c
                              WHERE Call_List__c = :calis.Id];
        
        CampaignWelcomeCallQueueable.doChainJob = false;
        System.enqueueJob(new CampaignWelcomeCallQueueable(lin));
        System.enqueueJob(new RoundRobinDistQueueable());
        
        // Agar catch bisa ter-cover
        System.enqueueJob(new CampaignWelcomeCallQueueable(null));
    }
}