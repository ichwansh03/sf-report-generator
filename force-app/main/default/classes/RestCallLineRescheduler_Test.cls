@isTest
global class RestCallLineRescheduler_Test {
    
    private static final Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    private static final Id recTypeTelUW = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
    
    public static String checkHari(){
        String tanggal;
        if(Datetime.now().format('EEE') != 'Sat' && (Datetime.now()+1).format('EEE') != 'Sat'){ // Sekarang hari minggu - kamis
            tanggal = (Datetime.now()+1).format('yyyy-MM-dd');
        }else if((Datetime.now()+1).format('EEE') == 'Sat'){ // Sekarang hari jumat
            tanggal = (Datetime.now()+3).format('yyyy-MM-dd');
        }else if(Datetime.now().format('EEE') == 'Sat'){ // Sekarang hari Sabtu
            tanggal = (Datetime.now()+2).format('yyyy-MM-dd');
        }
        return tanggal;
    }
    
    public static String checkHariWeekend(){
        String tanggal;
        if(Datetime.now().format('EEE') == 'Sat' || Datetime.now().format('EEE') != 'Sat'){ // Sekarang hari sabtu / minggu
            tanggal = Datetime.now().format('yyyy-MM-dd');
        }
        if((Datetime.now()+1).format('EEE') == 'Sat'){ // Sekarang hari jumat
            tanggal = (Datetime.now()+1).format('yyyy-MM-dd');
        }
        if((Datetime.now()+2).format('EEE') == 'Sat'){ // Sekarang hari kamis
            tanggal = (Datetime.now()+2).format('yyyy-MM-dd');
        }
        if((Datetime.now()+3).format('EEE') == 'Sat'){ // Sekarang hari rabu
            tanggal = (Datetime.now()+3).format('yyyy-MM-dd');
        }
        if((Datetime.now()-2).format('EEE') == 'Sun'){ // Sekarang hari selasa 
            tanggal = (Datetime.now()-2).format('yyyy-MM-dd');
        }
        if((Datetime.now()-1).format('EEE') == 'Sun'){  // Sekarang hari senin
            tanggal = (Datetime.now()-1).format('yyyy-MM-dd');
        }
        return tanggal;
    }
    
    public static testMethod void createContactPositiveCase(){
        Contact kontakBaru = new Contact();
        kontakBaru.Policy_No__c = '514-8459257';
        kontakBaru.LastName = 'Test Mockup';
        kontakBaru.OwnerId = UserInfo.getUserId();
        kontakBaru.WelcomeCall_Issued_Date__c = Date.today()-7;
        insert kontakBaru;
        
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = kontakBaru.Id;
        cl1.Policy_No__c = kontakBaru.Policy_No__c;
        cl1.OwnerId = kontakBaru.OwnerId;
        cl1.Call_Date__c = Date.today();
        cl1.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl1.WelcomeCall_Reference__c = null;
        cl1.Welcomecall_call_line_status__c = 'Open';
        //cl1.Activity_Result__c = 'Reschedule';
        //cl1.Verification__c = 'Contacted';
        cl1.WelcomeCall_Detail_Status__c = '';
        cl1.WelcomeCall_Reason_Detail_Status__c = '';
        cl1.Notes__c = '';
        cl1.recordtypeid = recTypeWC;
        insert cl1;
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Contact__c = kontakBaru.Id;
        cl2.Policy_No__c = kontakBaru.Policy_No__c;
        cl2.OwnerId = kontakBaru.OwnerId;
        cl2.Call_Date__c = Date.today();
        cl2.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl2.WelcomeCall_Reference__c = null;
        cl2.Welcomecall_call_line_status__c = 'Open';
        //cl1.Activity_Result__c = 'Reschedule';
        //cl1.Verification__c = 'Contacted';
        cl2.WelcomeCall_Detail_Status__c = '';
        cl2.WelcomeCall_Reason_Detail_Status__c = '';
        cl2.Notes__c = '';
        cl2.recordtypeid = recTypeTelUW;
        insert cl2;
        
        
        WelcomeCal_Schedule__c welCallSchedule = new WelcomeCal_Schedule__c(
            Name = 'Reschedule Time',
            Start_Hour__c = Datetime.newInstance(Date.today(), Time.newInstance(8, 0, 0, 0)),
            End_Hour__c = Datetime.newInstance(Date.today(), Time.newInstance(17, 0, 0, 0))
        );
        insert welCallSchedule;
    }
    
    public static testMethod void createPolicyHasMultipleCallLine(){
        Contact kontakBaru1 = new Contact();
        kontakBaru1.Policy_No__c = '514-84592890';
        kontakBaru1.LastName = 'Test Mockup';
        kontakBaru1.OwnerId = UserInfo.getUserId();
        kontakBaru1.WelcomeCall_Issued_Date__c = Date.today()-7;
        insert kontakBaru1;
        
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = kontakBaru1.Id;
        cl1.Policy_No__c = kontakBaru1.Policy_No__c;
        cl1.OwnerId = kontakBaru1.OwnerId;
        cl1.Call_Date__c = Date.today();
        cl1.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl1.WelcomeCall_Reference__c = null;
        cl1.Welcomecall_call_line_status__c = 'Open';
        //cl1.Activity_Result__c = 'Reschedule';
        //cl1.Verification__c = 'Contacted';
        cl1.WelcomeCall_Detail_Status__c = '';
        cl1.WelcomeCall_Reason_Detail_Status__c = '';
        cl1.Notes__c = '';
        cl1.recordtypeid = recTypeWC;
        insert cl1;
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Contact__c = kontakBaru1.Id;
        cl2.Policy_No__c = kontakBaru1.Policy_No__c;
        cl2.OwnerId = kontakBaru1.OwnerId;
        cl2.Call_Date__c = Date.today();
        cl2.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl2.WelcomeCall_Reference__c = null;
        cl2.Welcomecall_call_line_status__c = 'Open';
        cl2.WelcomeCall_Detail_Status__c = '';
        cl2.WelcomeCall_Reason_Detail_Status__c = '';
        cl2.Notes__c = '';
        cl2.recordtypeid = recTypeWC;
        insert cl2;
        cl2.Welcomecall_call_line_status__c = 'Closed';
        cl2.Activity_Result__c = 'Reschedule';
        cl2.Verification__c = 'Contacted';
        update cl2;
        
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Contact__c = kontakBaru1.Id;
        cl3.Policy_No__c = kontakBaru1.Policy_No__c;
        cl3.OwnerId = kontakBaru1.OwnerId;
        cl3.Call_Date__c = Date.today();
        cl3.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl3.WelcomeCall_Reference__c = null;
        cl3.Welcomecall_call_line_status__c = 'Open';
        cl3.WelcomeCall_Detail_Status__c = '';
        cl3.WelcomeCall_Reason_Detail_Status__c = '';
        cl3.Notes__c = '';
        cl3.recordtypeid = recTypeWC;
        insert cl3;
        cl3.Welcomecall_call_line_status__c = 'Closed';
        cl3.Activity_Result__c = 'Reschedule';
        cl3.Verification__c = 'Contacted';
        update cl3;
        
        Call_Line__c cl4 = new Call_Line__c();
        cl4.Contact__c = kontakBaru1.Id;
        cl4.Policy_No__c = kontakBaru1.Policy_No__c;
        cl4.OwnerId = kontakBaru1.OwnerId;
        cl4.Call_Date__c = Date.today();
        cl4.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl4.WelcomeCall_Reference__c = null;
        cl4.Welcomecall_call_line_status__c = 'Open';
        cl4.WelcomeCall_Detail_Status__c = '';
        cl4.WelcomeCall_Reason_Detail_Status__c = '';
        cl4.Notes__c = '';
        cl4.recordtypeid = recTypeWC;
        insert cl4;
        cl4.Welcomecall_call_line_status__c = 'Progress';
        update cl4;
        
        WelcomeCal_Schedule__c welCallSchedule = new WelcomeCal_Schedule__c(
            Name = 'Reschedule Time',
            Start_Hour__c = Datetime.newInstance(Date.today(), Time.newInstance(8, 0, 0, 0)),
            End_Hour__c = Datetime.newInstance(Date.today(), Time.newInstance(17, 0, 0, 0))
        );
        insert welCallSchedule;
    }
    
    public static testMethod void createPolicyHasMultipleCallLineClosed(){
        Contact kontakBaru1 = new Contact();
        kontakBaru1.Policy_No__c = '514-84592890';
        kontakBaru1.LastName = 'Test Mockup';
        kontakBaru1.OwnerId = UserInfo.getUserId();
        kontakBaru1.WelcomeCall_Issued_Date__c = Date.today()-7;
        insert kontakBaru1;
        
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = kontakBaru1.Id;
        cl1.Policy_No__c = kontakBaru1.Policy_No__c;
        cl1.OwnerId = kontakBaru1.OwnerId;
        cl1.Call_Date__c = Date.today();
        cl1.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl1.WelcomeCall_Reference__c = null;
        cl1.Welcomecall_call_line_status__c = 'Open';
        cl1.WelcomeCall_Detail_Status__c = '';
        cl1.WelcomeCall_Reason_Detail_Status__c = '';
        cl1.Notes__c = '';
        cl1.recordtypeid = recTypeWC;
        insert cl1;
        cl1.Welcomecall_call_line_status__c = 'Closed';
        cl1.Activity_Result__c = 'Reschedule';
        cl1.Verification__c = 'Contacted';
        update cl1;
        
        
        Call_Line__c cl2 = new Call_Line__c();
        cl2.Contact__c = kontakBaru1.Id;
        cl2.Policy_No__c = kontakBaru1.Policy_No__c;
        cl2.OwnerId = kontakBaru1.OwnerId;
        cl2.Call_Date__c = Date.today();
        cl2.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl2.WelcomeCall_Reference__c = null;
        cl2.Welcomecall_call_line_status__c = 'Open';
        cl2.WelcomeCall_Detail_Status__c = '';
        cl2.WelcomeCall_Reason_Detail_Status__c = '';
        cl2.Notes__c = '';
        cl2.recordtypeid = recTypeWC;
        insert cl2;
        cl2.Welcomecall_call_line_status__c = 'Closed';
        cl2.Activity_Result__c = 'Reschedule';
        cl2.Verification__c = 'Contacted';
        update cl2;
        
        Call_Line__c cl3 = new Call_Line__c();
        cl3.Contact__c = kontakBaru1.Id;
        cl3.Policy_No__c = kontakBaru1.Policy_No__c;
        cl3.OwnerId = kontakBaru1.OwnerId;
        cl3.Call_Date__c = Date.today();
        cl3.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl3.WelcomeCall_Reference__c = null;
        cl3.Welcomecall_call_line_status__c = 'Open';
        cl3.WelcomeCall_Detail_Status__c = '';
        cl3.WelcomeCall_Reason_Detail_Status__c = '';
        cl3.Notes__c = '';
        cl3.recordtypeid = recTypeWC;
        insert cl3;
        cl3.Welcomecall_call_line_status__c = 'Closed';
        cl3.Activity_Result__c = 'Reschedule';
        cl3.Verification__c = 'Contacted';
        update cl3;
        
        Call_Line__c cl4 = new Call_Line__c();
        cl4.Contact__c = kontakBaru1.Id;
        cl4.Policy_No__c = kontakBaru1.Policy_No__c;
        cl4.OwnerId = kontakBaru1.OwnerId;
        cl4.Call_Date__c = Date.today();
        cl4.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl4.WelcomeCall_Reference__c = null;
        cl4.Welcomecall_call_line_status__c = 'Open';
        cl4.WelcomeCall_Detail_Status__c = '';
        cl4.WelcomeCall_Reason_Detail_Status__c = '';
        cl4.Notes__c = '';
        cl4.recordtypeid = recTypeWC;
        insert cl4;
        cl4.Welcomecall_call_line_status__c = 'Closed';
        update cl4;
        
        WelcomeCal_Schedule__c welCallSchedule = new WelcomeCal_Schedule__c(
            Name = 'Reschedule Time',
            Start_Hour__c = Datetime.newInstance(Date.today(), Time.newInstance(8, 0, 0, 0)),
            End_Hour__c = Datetime.newInstance(Date.today(), Time.newInstance(17, 0, 0, 0))
        );
        insert welCallSchedule;
    }
    
    public static testMethod void createContactOverPeriod(){
        Contact kontakBaru = new Contact();
        kontakBaru.Policy_No__c = '514-8459258';
        kontakBaru.LastName = 'Test Mockup';
        kontakBaru.OwnerId = UserInfo.getUserId();
        kontakBaru.WelcomeCall_Issued_Date__c = Date.today()-30;
        insert kontakBaru;
        
        
        Call_Line__c cl1 = new Call_Line__c();
        cl1.Contact__c = kontakBaru.Id;
        cl1.Policy_No__c = kontakBaru.Policy_No__c;
        cl1.OwnerId = kontakBaru.OwnerId;
        cl1.Call_Date__c = Date.today();
        cl1.WelcomeCall_Schedule_Date__c = (Datetime.now().format('EEE') != 'Sat' || Datetime.now().format('EEE') != 'Sun' || (Datetime.now()+1).format('EEE') != 'Sat' || (Datetime.now()+2).format('EEE') != 'Sun') ? Datetime.now()+1 : Datetime.now()+3;
        cl1.WelcomeCall_Reference__c = null;
        cl1.Welcomecall_call_line_status__c = 'Open';
        //cl1.Activity_Result__c = 'Reschedule';
        //cl1.Verification__c = 'Contacted';
        cl1.WelcomeCall_Detail_Status__c = '';
        cl1.WelcomeCall_Reason_Detail_Status__c = '';
        cl1.Notes__c = '';
        cl1.recordtypeid = recTypeWC;
        insert cl1;
    }
    
    //Contact Availibility Positive Case
    public testMethod static void testCheckPolicyAvailibility(){
        
        
        // welcome Call
        createContactPositiveCase();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-8459257',null,'');        
        //TeleUW
        Map<String,String> newMap2 = new Map<String,String>();
        newMap2 = callLineRescheduleAPI.checkAvailibility('514-8459257#TelUW',null,'');
        
        Test.stopTest();
        
        
    }
    
    //Contact Availibility Negative Case Catch
    public testMethod static void testCatch(){
        createContactPositiveCase();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-8459257','1abc','');
         //TeleUW
        Map<String,String> newMap2 = new Map<String,String>();
        newMap2 = callLineRescheduleAPI.checkAvailibility('514-8459257#TelUW',null,'');
        Test.stopTest();
    }
    
    //Contact Availibility Negative Case Catch
    public testMethod static void testOverCoolingOff(){
        createContactPositiveCase();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-8459257','2021-11-01','');
        //TeleUW
        Map<String,String> newMap2 = new Map<String,String>();
        newMap2 = callLineRescheduleAPI.checkAvailibility('514-8459257#TelUW','2021-11-01','');
        Test.stopTest();
    }
    
    //Contact Availibility Negative Case Catch
    public testMethod static void testWeekend(){
        createContactPositiveCase();
        String tanggal;
        tanggal = checkHariWeekend();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-8459257',tanggal,'');
        //TeleUW
        Map<String,String> newMap2 = new Map<String,String>();
        newMap2 = callLineRescheduleAPI.checkAvailibility('514-8459257#TelUW',tanggal,'');
        Test.stopTest();
    }
    
    //Contact Availibility NEGATIVE Case (Call Line Closed)
    public testMethod static void testCheckCallLineClosed(){
        createPolicyHasMultipleCallLineClosed();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-84592890',null,'');
        Test.stopTest();
    }
    
    public testMethod static void testCheckCallLineMultiple(){
        createPolicyHasMultipleCallLine();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-84592890',null,'');
        Test.stopTest();
    }
    
    //Schedule Availibility Positive Case
    public testMethod static void testCheckScheduleAvailibility(){
        createContactPositiveCase();
        String tanggal;
        tanggal = checkHari();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-8459257',tanggal,'SMARTS');
        
        //TeleUW
        Map<String,String> newMap2 = new Map<String,String>();
        newMap2 = callLineRescheduleAPI.checkAvailibility('514-8459257#TelUW',tanggal,'SMART');
 
        Test.stopTest();
    }
    
    // Save Schedule Positive Case
    public testMethod static void testSaveNewScheduleAPI(){
        createContactPositiveCase();
        String tanggal;
        tanggal = checkHari();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        Call_Line__c callLine = new Call_Line__c();
        callLine.WelcomeCall_Schedule_Date__c = (DateTime)JSON.deserialize('"'+tanggal+'T09:00:00"', DateTime.class);
        callLine.Notes__c = '';
        callLine.Call_Remarks__c = '';
        callLine.WelcomeCall_Reschedule_Source__c = 'SMARTS';
        
        // For rescheduler via API
        newMap = callLineRescheduleAPI.restSaveReschedule('514-8459257',true,callLine);
        // For rescheduler via UI CCC
        newMap = callLineRescheduleAPI.restSaveReschedule('514-8459257',false,callLine);
        
        //TeleUW
        newMap = callLineRescheduleAPI.restSaveReschedule('514-8459257#TelUW',true,callLine);
        
        Test.stopTest();
    }
    
    //Contact Availibility NEGATIVE Case
    public testMethod static void testCheckPolicyUnavailible(){
        createContactPositiveCase();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        String tanggal;
        tanggal = checkHari();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-8459390',null,'');
        createContactOverPeriod();
        Call_Line__c callLine = new Call_Line__c();
        callLine.WelcomeCall_Schedule_Date__c = (DateTime)JSON.deserialize('"'+tanggal+'T09:00:00"', DateTime.class);
        callLine.Notes__c = '';
        callLine.Call_Remarks__c = '';
        callLine.WelcomeCall_Reschedule_Source__c = 'SMARTS';
        newMap = callLineRescheduleAPI.restSaveReschedule('514-8459258',true,callLine);
        newMap = callLineRescheduleAPI.restSaveReschedule('514-8459258',false,callLine);
        Test.stopTest();
    }
    
    
    //Contact Availibility NEGATIVE Case Over Period Contact Issued Date
    public testMethod static void testPolicyOverPeriod(){
        Test.setMock(HttpCalloutMock.class, new RestMock());
        String tanggal;
        tanggal = checkHari();
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        createContactOverPeriod();
        Call_Line__c callLine = new Call_Line__c();
        callLine.WelcomeCall_Schedule_Date__c = (DateTime)JSON.deserialize('"'+tanggal+'T09:00:00"', DateTime.class);
        callLine.Notes__c = '';
        callLine.Call_Remarks__c = '';
        callLine.WelcomeCall_Reschedule_Source__c = 'SMARTS';
        newMap = callLineRescheduleAPI.restSaveReschedule('514-8459258',true,callLine);
        newMap = callLineRescheduleAPI.restSaveReschedule('514-8459258',false,callLine);
        Test.stopTest();
    }
    
    public testMethod static void testCheckSebelumHariIni(){
        createContactPositiveCase();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        Map<String,String> newMap = new Map<String,String>();
        newMap = callLineRescheduleAPI.checkAvailibility('514-8459257','2021-08-24','SMARTS');
        Test.stopTest();
    }
    
    public testMethod static void testinsertRescheduleCatch(){
        CallLineRescheduleAPI callLineRescheduleAPI = new CallLineRescheduleAPI();
        Test.startTest();
        try{
            callLineRescheduleAPI.insertReschedule(null,null);   
        }catch(Exception e){
            
        }
        Test.stopTest();
    }
    
    public testMethod static void testRestCallLine(){
        createContactPositiveCase();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineWrapper.CallLineResponse response = new CallLineWrapper.CallLineResponse();
        CallLineWrapper.CallLineRequest requestObject = new CallLineWrapper.CallLineRequest();
        requestObject.callLinePolNo = '514-8459257';
        requestObject.callLineSchedule = null;
        requestObject.callLineNote = '';
        requestObject.callLineSource = 'SMARTS';
        String testJson = (JSON.serialize(requestObject));
        
        Test.startTest();
        response = RestCallLineRescheduler.checkPolicyWelcomeCall(requestObject);
        Test.stopTest();
    }
    
    public testMethod static void testRestCallLineCreateCallLine(){
        String tanggal;
        tanggal = checkHari();
        createContactPositiveCase();
        Test.setMock(HttpCalloutMock.class, new RestMock());
        CallLineWrapper.CallLineResponse response1 = new CallLineWrapper.CallLineResponse();
        CallLineWrapper.CallLineRequest requestObject1 = new CallLineWrapper.CallLineRequest();
        requestObject1.callLinePolNo = '514-8459257';
        requestObject1.callLineSchedule = tanggal;
        requestObject1.callLineNote = '';
        requestObject1.callLineSource = 'SMARTS';
        String testJson = (JSON.serialize(requestObject1));
        
        CallLineWrapper.CallLineResponse response2 = new CallLineWrapper.CallLineResponse();
        CallLineWrapper.CallLineRequest requestObject2 = new CallLineWrapper.CallLineRequest();
        requestObject2.callLinePolNo = '514-8459257';
        requestObject2.callLineSchedule = tanggal;
        requestObject2.callLineNote = '';
        requestObject2.callLineSource = 'SMARTS';
        String testJson2 = (JSON.serialize(requestObject2));
        
        
        Test.startTest();
        response1 = RestCallLineRescheduler.createCallLineReschedule(requestObject1);
        response2 = RestCallLineRescheduler.createCallLineReschedule(requestObject2);
        Test.stopTest();
    }
    
    global class RestMock implements HttpCalloutMock{
        
        global HttpResponse respond(HttpRequest req){
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            String sJsonRequest = '{"status": "00","stackTrace": null,"message": "Success created case","caseNumber": "1234567","caseId": "1234567890ABC"}}';
            
            res.setBody(sJsonRequest);
            res.setStatusCode(200);
            
            return res; 
        }
    }

}