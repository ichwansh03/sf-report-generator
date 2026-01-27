@isTest
public class groupclass_TestClass {
    private static String USER_TYPE = 'AFI';					// User.User_Type__c
    private static String USER_TIMEZONE = 'Asia/Jakarta';		// User.TimeZoneSidKey = (GMT+07:00) West Indonesia Time (Asia/Jakarta)
    private static String USER_LOCALE = 'en_ID';				// User.LocaleSidKey = Indonesian (Indonesia)
    private static String USER_LANGUAGE = 'en_US';				// User.LanguageLocaleKey = English
    private static String USER_CURRENCY = 'IDR';				// User.DefaultCurrencyIsoCode = IDR - Indonesian Rupiah
    private static String USER_EMAILENC = 'UTF-8';        		// User.EmailEncodingKey = Unicode (UTF-8)
    static ID rtAgent = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    Static RecordType rt = [select id, name from recordType where name='Agent Group'];
    
    @isTest static void groupTestClass(){
        
        Profile profileList = [SELECT Id,Name FROM Profile WHERE Name = 'System Administrator'];
        
        User userbaru = new User();
        userbaru.LastName = 'halo';
        userbaru.Alias = 'hl';
        userbaru.Email = 'xicy1@wmail.com';
        userbaru.Username = 'xicy1@wmail.com';
        userbaru.CommunityNickname = 'sembarang';
        userbaru.ProfileId = profileList.Id;
        userbaru.Entity__c = 'AMFS';
        userbaru.LocaleSidKey = USER_LOCALE;
        userbaru.LanguageLocaleKey = USER_LANGUAGE;
        userbaru.EmailEncodingKey = USER_EMAILENC;
        userbaru.TimeZoneSidKey = USER_TIMEZONE;
        
        insert userbaru;
        
        User userbaru1 = new User();
        userbaru1.LastName = 'tst1';
        userbaru1.Alias = 'TEST1';
        userbaru1.Email = 'TEST1@wmail.com';
        userbaru1.Username = 'tEST1@wmail.com';
        userbaru1.CommunityNickname = 'TEST1';
        userbaru1.ProfileId = profileList.Id;
        userbaru1.Entity__c = 'AMFS';
        userbaru1.LocaleSidKey = USER_LOCALE;
        userbaru1.LanguageLocaleKey = USER_LANGUAGE;
        userbaru1.EmailEncodingKey = USER_EMAILENC;
        userbaru1.TimeZoneSidKey = USER_TIMEZONE;
        //userbaru.CurrencyIsoCode = USER_CURRENCY;
        
        insert userbaru1;
        
        group_class grpclass;
        System.runAs(userbaru){  
            
            Call_line__c welcomeCallCL1 = WelcomeCallMockUpData_T.mockWelcomeCallCallLine1();
            
            welcomeCallCL1.OwnerId = userbaru.Id;
            update welcomeCallCL1;
            
            WelcomeCall_Criteria__c wgc = new WelcomeCall_Criteria__c();
            wgc.Name = 'Retail';
            wgc.WelcomeCall_Start_Range__c = 1000000;
            wgc.WelcomeCall_End_Range__c = 100000000;
            wgc.WelcomeCall_Start_Range_USD__c = 0;
            wgc.WelcomeCall_End_Range_USD__c = 1000;
            wgc.WelcomeCall_Fg_Active__c = true;
            
            insert wgc;
            
            WelcomeCall_Group__c grp = new WelcomeCall_Group__c();
            grp.WelcomeCall_Criteria__c = 'Retail';
            grp.WelcomeCall_Entity__c = 'AMFS';
            grp.WelcomeCall_Last_Priority__c = 1;
            grp.WelcomeCall_Status__c = true;
            
            insert grp;
            
            Agent_Group__c notUser = new Agent_Group__c();
            notUser.name = 'testing';
            notUser.WelcomeCall_Supervisor__c = true;
            notUser.WelcomeCall_User__c = userbaru1.Id;
            notUser.RecordTypeId = rtAgent;
            notUser.WelcomeCall_Resign__c = false;
            
            insert notUser;
            
            Agent_Group__c ag1 = new Agent_Group__c();
            ag1.name = 'testing Agent Group 1';
            ag1.WelcomeCall_Supervisor__c = true;
            ag1.Agent__c = notUser.Id;
            ag1.RecordTypeId = rtAgentGroup;
            ag1.WelcomeCall_Group__c = grp.Id;
            ag1.WelcomeCall_Priority__c = 1;
            ag1.WelcomeCall_Fg_Head__c = false;
            ag1.WelcomeCall_Resign__c = false;
            ag1.WelcomeCall_Assignment__c = true;

            insert ag1;
            
            Agent_Group__c masuk = new Agent_Group__c();
            masuk.name = 'testing Agent';
            masuk.WelcomeCall_Supervisor__c = true;
            masuk.WelcomeCall_User__c = userbaru.Id;
            masuk.RecordTypeId = rtAgent;
            masuk.WelcomeCall_Resign__c = false;
            masuk.WelcomeCall_Fg_Head__c = false;
            
            insert masuk;
            
            Agent_Group__c masukAG = new Agent_Group__c();
            masukAG.name = 'testing Agent Group';
            masukAG.WelcomeCall_Supervisor__c = true;
            masukAG.Agent__c = masuk.Id;
            masukAG.RecordTypeId = rtAgentGroup;
            masukAG.WelcomeCall_Group__c = grp.Id;
            masukAG.WelcomeCall_Priority__c = 2;
            masukAG.WelcomeCall_Resign__c = false;
            masukAG.WelcomeCall_Fg_Head__c = false;
            
            insert masukAG;

            grpclass = new group_class();
            grpclass.displayButton = true;
            grpclass.act = ApexPages.CurrentPage().getParameters().put('clickDate',masukAG.Id);
            grpclass.agentid = ApexPages.CurrentPage().getParameters().put('id',masukAG.Id);
            grpclass.agentname = masukAG.name;
            grpclass.closePopup();
            grpclass.showPopup();
            
            grpclass.editpg();
            
             WelcomeCall_Leave__c welLeave = new WelcomeCall_Leave__c();
            welLeave.WelcomeCall_Agent__c = masuk.id;
            welLeave.WelcomeCall_Reason__c = 'Sick';
            welLeave.WelcomeCall_Description__c = 'Sick';
            welLeave.WelcomeCall_Start_Date__c = date.today()+1;
            welLeave.WelcomeCall_End_Date__c = date.today()+2;
            insert welLeave;
            
            group_class.MyWrapper mp = new group_class.MyWrapper(masukAG, welLeave);
        }
    }
        
        @isTest static void FGHeadTrue(){
        
        Profile profileList = [SELECT Id,Name FROM Profile WHERE Name = 'System Administrator'];
        
        User userbaru = new User();
        userbaru.LastName = 'halo';
        userbaru.Alias = 'hl';
        userbaru.Email = 'xicy@wmail.com';
        userbaru.Username = 'xicy@wmail.com';
        userbaru.CommunityNickname = 'sembarang';
        userbaru.ProfileId = profileList.Id;
        userbaru.Entity__c = 'AMFS';
        userbaru.LocaleSidKey = USER_LOCALE;
        userbaru.LanguageLocaleKey = USER_LANGUAGE;
        userbaru.EmailEncodingKey = USER_EMAILENC;
        userbaru.TimeZoneSidKey = USER_TIMEZONE;
        //userbaru.CurrencyIsoCode = USER_CURRENCY;
        
        insert userbaru;
        //Profile profileList = [SELECT Id,Name FROM Profile WHERE Name = 'System Administrator'];
        
        User userbaru2 = new User();
        userbaru2.LastName = 'tst2';
        userbaru2.Alias = 'TEST2';
        userbaru2.Email = 'TEST2@wmail.com';
        userbaru2.Username = 'tEST2@wmail.com';
        userbaru2.CommunityNickname = 'TEST2';
        userbaru2.ProfileId = profileList.Id;
        userbaru2.Entity__c = 'AMFS';
        userbaru2.LocaleSidKey = USER_LOCALE;
        userbaru2.LanguageLocaleKey = USER_LANGUAGE;
        userbaru2.EmailEncodingKey = USER_EMAILENC;
        userbaru2.TimeZoneSidKey = USER_TIMEZONE;
        //userbaru.CurrencyIsoCode = USER_CURRENCY;
        
        insert userbaru2;
        
        group_class grpclass;
        System.runAs(userbaru){  
            
            
            WelcomeCall_Criteria__c wgc = new WelcomeCall_Criteria__c();
            wgc.Name = 'Retail';
            wgc.WelcomeCall_Start_Range__c = 1000000;
            wgc.WelcomeCall_End_Range__c = 100000000;
            wgc.WelcomeCall_Start_Range_USD__c = 0;
            wgc.WelcomeCall_End_Range_USD__c = 1000;
            wgc.WelcomeCall_Fg_Active__c = true;
            
            insert wgc;
            
            WelcomeCall_Group__c grp = new WelcomeCall_Group__c();
            grp.WelcomeCall_Criteria__c = 'Retail';
            grp.WelcomeCall_Entity__c = 'AMFS';
            grp.WelcomeCall_Last_Priority__c = 0;
            grp.WelcomeCall_Status__c = true;
            
            insert grp;
            
            Agent_Group__c notUser = new Agent_Group__c();
            notUser.name = 'testing';
            notUser.WelcomeCall_Supervisor__c = true;
            notUser.WelcomeCall_User__c = userbaru2.Id;
            notUser.RecordTypeId = rtAgent;
            notUser.WelcomeCall_Resign__c = false;
            //masuk.WelcomeCall_Group__c = '';
            
            insert notUser;
            
            Agent_Group__c ag1 = new Agent_Group__c();
            ag1.name = 'testing Agent Group 1';
            ag1.WelcomeCall_Supervisor__c = true;
            ag1.Agent__c = notUser.Id;
            ag1.RecordTypeId = rtAgentGroup;
            ag1.WelcomeCall_Group__c = grp.Id;
            ag1.WelcomeCall_Priority__c = 1;
            ag1.WelcomeCall_Fg_Head__c = false;
            ag1.WelcomeCall_Resign__c = false;
            //masukAG.recordtype.name = rtAgentGroup;
            
            // masukAG.WelcomeCall_User__c = userbaru.Id;
            insert ag1;
            
            Agent_Group__c masuk = new Agent_Group__c();
            masuk.name = 'testing Agent';
            masuk.WelcomeCall_Supervisor__c = true;
            masuk.WelcomeCall_User__c = userbaru.Id;
            masuk.RecordTypeId = rtAgent;
            masuk.WelcomeCall_Resign__c = false;
            masuk.WelcomeCall_Fg_Head__c = true;
            //masuk.WelcomeCall_Group__c = '';
            
            insert masuk;
            
            Agent_Group__c masukAG = new Agent_Group__c();
            masukAG.name = 'testing Agent Group';
            masukAG.WelcomeCall_Supervisor__c = true;
            masukAG.Agent__c = masuk.Id;
            masukAG.RecordTypeId = rtAgentGroup;
            masukAG.WelcomeCall_Group__c = grp.Id;
            masukAG.WelcomeCall_Priority__c = 2;
            masukAG.WelcomeCall_Resign__c = false;
            masukAG.WelcomeCall_Fg_Head__c = false;
            //masukAG.recordtype.name = rtAgentGroup;
            
            // masukAG.WelcomeCall_User__c = userbaru.Id;
            insert masukAG;
            
            
            
            grpclass = new group_class();
            grpclass.displayButton = true;
            grpclass.act = ApexPages.CurrentPage().getParameters().put('clickDate',masukAG.Id);
            grpclass.agentid = ApexPages.CurrentPage().getParameters().put('id',masukAG.Id);
            grpclass.agentname = masukAG.name;
            grpclass.closePopup();
            grpclass.showPopup();
            
            grpclass.editpg();
            
             WelcomeCall_Leave__c welLeave = new WelcomeCall_Leave__c();
            //welLeave.name = 'Test';
            welLeave.WelcomeCall_Agent__c = masuk.id;
            welLeave.WelcomeCall_Reason__c = 'Sick';
            welLeave.WelcomeCall_Description__c = 'Sick';
            //welLeave.Active_Leave__c = true;
            welLeave.WelcomeCall_Start_Date__c = date.today()+1;
            welLeave.WelcomeCall_End_Date__c = date.today()+2;
            insert welLeave;

            group_class.MyWrapper mp = new group_class.MyWrapper(masukAG, welLeave);
            
            Agent_Group__c agr = [select id, name, WelcomeCall_Priority__c from Agent_Group__c where id = :masukAG.id];
            agr.WelcomeCall_Priority__c = 2;
            update agr;
            
            WelcomeCall_Group__c welgp = [select id, name, WelcomeCall_Last_Priority__c, WelcomeCall_Entity__c 
                                          from WelcomeCall_Group__c where id= :grp.id];
            welgp.WelcomeCall_Entity__c = 'AMFS';
            update welgp;
        }
        
        
        
    }
    
    
    
    
}