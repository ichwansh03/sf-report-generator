@isTest
public class TaskListByOwner_testClass {
    private static String USER_TYPE = 'AFI';					// User.User_Type__c
    private static String USER_TIMEZONE = 'Asia/Jakarta';		// User.TimeZoneSidKey = (GMT+07:00) West Indonesia Time (Asia/Jakarta)
    private static String USER_LOCALE = 'en_ID';				// User.LocaleSidKey = Indonesian (Indonesia)
    private static String USER_LANGUAGE = 'en_US';				// User.LanguageLocaleKey = English
    private static String USER_CURRENCY = 'IDR';				// User.DefaultCurrencyIsoCode = IDR - Indonesian Rupiah
    private static String USER_EMAILENC = 'UTF-8';        		// User.EmailEncodingKey = Unicode (UTF-8)
    static ID rtAgent = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent').getRecordTypeId();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    
    @isTest
    static void test1(){
        TaskListByOwner tlBO = new TaskListByOwner();
        Profile profileList = [SELECT Id,Name FROM Profile WHERE Name = 'Chatter Free User'];
        
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
        
        WelcomeCall_Criteria__c wgc = new WelcomeCall_Criteria__c();
        wgc.Name = 'Retail';
        wgc.WelcomeCall_Start_Range__c=	8000000;
        wgc.WelcomeCall_End_Range__c=	79000000;
        wgc.WelcomeCall_Start_Range_USD__c=1000;
        wgc.WelcomeCall_End_Range_USD__c=8000;
        wgc.WelcomeCall_Fg_Active__c = true;
        insert wgc;
        
        WelcomeCall_Group__c grp = new WelcomeCall_Group__c();
        grp.WelcomeCall_Criteria__c = 'Retail';
        grp.WelcomeCall_Entity__c = 'AMFS';
        grp.WelcomeCall_Last_Priority__c = 0;
        grp.WelcomeCall_Status__c = true;
        
        insert grp;
        
        Agent_Group__c masuk = new Agent_Group__c();
        masuk.name = 'testing Agent';
        masuk.WelcomeCall_User__c = UserInfo.getUserId();// userbaru.Id;
        masuk.RecordTypeId = rtAgent;
        
        insert masuk;
        
        masuk.Id = masuk.Id;
        masuk.name = 'testing Agent2';
        masuk.WelcomeCall_User__c = UserInfo.getUserId();// userbaru.Id;
        masuk.RecordTypeId = rtAgent;
        
        update masuk;
        
        Agent_Group__c masukAG = new Agent_Group__c();
        masukAG.name = 'testing Agent Group';
        masukAG.WelcomeCall_Supervisor__c = true;
        masukAG.Agent__c = masuk.Id;
        masukAG.RecordTypeId = rtAgentGroup;
        masukAG.WelcomeCall_Group__c = grp.Id;
        masukAG.WelcomeCall_Priority__c = 1;
        
        insert masukAG;
            
        tlBO.Getcline();
        tlBO.Getcline2();
        tlBO.Getcline3();
        tlBO.refreshTaskList();
        tlBO.getListOfAgentbySVP();
       	
        tlBO.selectedType = 'True';
        
        tlBO.getListOfCallLine();
        tlBO.getListOwnTask();
        tlBO.getListType();
        tlBO.getStatusOptions();
    }
}