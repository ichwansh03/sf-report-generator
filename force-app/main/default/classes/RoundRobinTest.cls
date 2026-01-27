@isTest
public class RoundRobinTest {
    static ID rtAgent = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    @isTest static void testGenerateCallLine(){
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
        
        // Criteria HVC RP
        
        Contact con = new Contact(LastName='Just Test',
                                 //WelcomeCall_APE__c=120000000,
                                 WelcomeCall_Payment_Type__c ='M',
                                 Premium__c=100000000,
                                 Total_Premium__c=1000000000,
                                 WelcomeCall_Issued_Date__c=Date.newInstance(Date.today().year(), Date.today().month(), Date.today().day()-4),
                                 WelcomeCall_Product_Code_Plan__c='HONMEP',
                                 MobilePhone='081111222',
                                 HomePhone='02111100',
                                 Phone='021222222',
                                 OtherPhone='01892874',
                                 Entity__c='AMFS',
                                 WelcomeCall_Currency__c='RP');
        // Criteria HVC USD
        Contact con1 = new Contact(LastName='Just Test 2',
                                 //WelcomeCall_APE__c=120000000,
                                 WelcomeCall_Payment_Type__c ='M',
                                 Premium__c=5000,
                                 Total_Premium__c=5000,
                                 WelcomeCall_Issued_Date__c=Date.newInstance(Date.today().year(), Date.today().month(), Date.today().day()-4),
                                 WelcomeCall_Product_Code_Plan__c='HONMEP',
                                 MobilePhone='081111222',
                                 HomePhone='02111100',
                                 Phone='021222222',
                                 OtherPhone='01892874',
                                 Entity__c='AMFS',
                                 WelcomeCall_Currency__c='USD');
        // Criteria RETAIL USD
        Contact con2 = new Contact(LastName='Just Test 3',
                                 //WelcomeCall_APE__c=120000000,
                                 WelcomeCall_Payment_Type__c ='M',
                                 Premium__c=500,
                                 Total_Premium__c=500,
                                 WelcomeCall_Issued_Date__c=Date.newInstance(Date.today().year(), Date.today().month(), Date.today().day()-4),
                                 WelcomeCall_Product_Code_Plan__c='MSKA',
                                 MobilePhone='081111222',
                                 HomePhone='02111100',
                                 Phone='021222222',
                                 OtherPhone='01892874',
                                 Entity__c='AMFS',
                                 WelcomeCall_Currency__c='USD');
        // Criteria RETAIL RP
        Contact con3 = new Contact(LastName='Just Test 4',
                                 //WelcomeCall_APE__c=120000000,
                                 WelcomeCall_Payment_Type__c ='A',
                                 Premium__c=50000000,
                                 Total_Premium__c=50000000,
                                 WelcomeCall_Issued_Date__c=Date.newInstance(Date.today().year(), Date.today().month(), Date.today().day()-4),
                                 WelcomeCall_Product_Code_Plan__c='AMPKS',
                                 MobilePhone='081111222',
                                 HomePhone='02111100',
                                 Phone='021222222',
                                 OtherPhone='01892874',
                                 Entity__c='AMFS',
                                 WelcomeCall_Currency__c='RP');
        // Criteria UNDERRETAIL USD
        Contact con4 = new Contact(LastName='Just Test 5',
                                 //WelcomeCall_APE__c=120000000,
                                 WelcomeCall_Payment_Type__c ='A',
                                 Premium__c=100,
                                 Total_Premium__c=100,
                                 WelcomeCall_Issued_Date__c=Date.newInstance(Date.today().year(), Date.today().month(), Date.today().day()-4),
                                 WelcomeCall_Product_Code_Plan__c='AMPKS',
                                 MobilePhone='081111222',
                                 HomePhone='02111100',
                                 Phone='021222222',
                                 OtherPhone='01892874',
                                 Entity__c='AMFS',
                                 WelcomeCall_Currency__c='USD');
        // Criteria UNDERRETAIL RP
        Contact con5 = new Contact(LastName='Just Test 6',
                                 //WelcomeCall_APE__c=120000000,
                                 WelcomeCall_Payment_Type__c ='A',
                                 Premium__c=5000000,
                                 Total_Premium__c=5000000,
                                 WelcomeCall_Issued_Date__c=Date.newInstance(Date.today().year(), Date.today().month(), Date.today().day()-4),
                                 WelcomeCall_Product_Code_Plan__c='AMPKS',
                                 MobilePhone='081111222',
                                 HomePhone='02111100',
                                 Phone='021222222',
                                 OtherPhone='01892874',
                                 Entity__c='AMFS',
                                 WelcomeCall_Currency__c='RP');
        insert con;
        insert con1;
        insert con2;
        insert con3;
        insert con4;
        insert con5;
        
        Contact con6 = new Contact(LastName='Just Test 6',
                                   //WelcomeCall_APE__c=120000000,
                                   WelcomeCall_Payment_Type__c ='A',
                                   Premium__c=11000000,
                                   Total_Premium__c=11000000,
                                   WelcomeCall_Issued_Date__c=Date.newInstance(Date.today().year(), Date.today().month(), Date.today().day()-1),
                                   WelcomeCall_Product_Code_Plan__c='MSW',
                                   MobilePhone='081111222',
                                   HomePhone='02111100',
                                   Phone='021222222',
                                   OtherPhone='01892874',
                                   Entity__c='AMFS',
                                   PolicyApp__c='RLS',
                                   WelcomeCall_Currency__c='RP');
        insert con6;
        
        CampaignWelcomeCall cal = new CampaignWelcomeCall();
        cal.generateMonthlyCampaign('Other');
        
        String formatName = 'WelcomeCall';
        String monthNow = Datetime.now().format('yyMM');
        formatName = formatName + monthNow + 'Other';
        Call_List__c calis = [SELECT Id
                              FROM Call_List__c 
                              WHERE Campaign_Name__c =: formatName];
        CallLineWelcomeCall calin = new CallLineWelcomeCall();
        calin.generateDailyCallLines(calis.Id);
        
        Call_Line__c[] lin = [SELECT Name, OwnerId, Contact__r.Name, Contact__r.WelcomeCall_APE__c, WelcomeCall_Call_Line_Status__c, Contact__r.Policy_No__c, Contact__r.WelcomeCall_Currency__c FROM Call_Line__c
                             WHERE Call_List__c = :calis.Id];
        
        /**system.assert(lin.size() > 0);
        system.assertEquals('Just Test', lin[0].Contact__r.Name);
        system.assertEquals('Open', lin[0].WelcomeCall_Call_Line_Status__c);*/
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
        if(dayOfWeek == 'Mon'){
            processDate = system.today().addDays((issuedDays + 2) * -1); // minus 1 untuk hari sebelumnya
        }
        else if(dayOfWeek == 'Tue'){
            if(issuedDays < 2)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 2)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        else if(dayOfWeek == 'Wed'){
            if(issuedDays < 3)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 3)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        else if(dayOfWeek == 'Thu'){
            if(issuedDays < 4)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 4)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        else if(dayOfWeek == 'Fri'){
            if(issuedDays < 5)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 5)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        // Criteria HVC RP Monthly
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
                                   Policy_No__c = '511-1234567',
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
        system.debug('formatName =='+formatName);
        Call_List__c calis = [SELECT Id, name
                              FROM Call_List__c 
                              WHERE Campaign_Name__c =: formatName];
        system.debug('calis =='+calis);
        CallLineWelcomeCall calin = new CallLineWelcomeCall();
        calin.generateDailyCallLines(calis.Id);
        calin.roundRobinDist(true);
        
        Call_Line__c[] lin = [SELECT Name, OwnerId, Contact__r.Name, Contact__r.WelcomeCall_APE__c, WelcomeCall_Call_Line_Status__c, Contact__r.Policy_No__c, Contact__r.WelcomeCall_Currency__c FROM Call_Line__c
                             WHERE Call_List__c = :calis.Id];
        system.debug('lin test =='+lin);
    }
}