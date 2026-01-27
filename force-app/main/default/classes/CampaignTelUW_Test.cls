@isTest(SeeAllData=true)
public class CampaignTelUW_Test {
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    static ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
	 static testmethod void testScheduledJob() {
        Test.startTest();
         
        List<Contact>conlist = new List<Contact>();
        Contact con = new Contact();
        con.LastName = 'Test Name1';
        //con.Total_Premium__c =  10000000;
        con.policy_no__c = '513-12345';
        con.MobilePhone = '0813987654';
        con.HomePhone = '';
        con.Phone = '';
        con.OtherPhone = '';
        con.Entity__c = 'AMFS';
        con.Currency_TelUW__c= 'RP';
        con.Product_Code_Plant_TelUW__c = 'HONMPS';
        con.WelcomeCall_Payment_Type__c = 'A';
        con.Issued_Date_TelUw__c = date.today()-1;
        con.Campaign_Type__c = 'TelUW';
        con.policyApp__c = 'RLS';
        con.APE_TelUW__c = 10000000;
        conlist.Add(con);
        insert conlist;        

        String formatName = 'TelUW';
        String autoManual = 'Automatic';
        String monthNow = Datetime.now().format('yyMM');
        formatName = formatName + monthNow + autoManual;
        Date now = Date.today();
        Date next_month = now.addMonths(1);
        Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
         
        RecordType recId = getRecordTypeId('Confirmation AMFS', 'Call_List__c');
        Call_List__c calist = new Call_List__c(Activity__c = 'Confirmation',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = 'TelUW',
                                                       Expired_Date__c = expiry_date,
                                                       Entity__c = 'AMFS',
                                                       RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = true);
        
        insert calist;  
         
        List<Call_line__C> callLineLs = new List<Call_line__C>();
        String caseType = '';
        String caseTypeConfig = '';
        String activity = '';
        Call_List__c[] calis = [select id, name, case_type__c,Case_Type_Config__c, Activity__c from call_list__c where Id = :calist.id];
        for(Call_List__c cal: calis){
            caseType = cal.case_type__c;
            caseTypeConfig = cal.Case_Type_Config__c;
            activity = cal.Activity__c;
        } 
        CampaignTelUW testWelcomCall = new CampaignTelUW(); 
        Call_Line__c calin = new Call_Line__c(RecordTypeId = wcRtId,
                                                          Contact__c = con.Id,
                                                          Call_List__c =calist.id,
                                                          WelcomeCall_Call_Line_Status__c = 'Open',
                                                          Case_Type__c = caseType,
                                                          Case_Type_Config__c = caseTypeConfig,
                                                          Contacted_Number__c = con.MobilePhone,
                                                          Phone__c = con.Phone,
                                                          Home_Phone__c = con.HomePhone,
                                                          Other_Phone__c = con.OtherPhone,
                                                          Activity__c = activity,
                                                          Policy_no__c = con.policy_no__c,
                                                          Entity__c = con.Entity__c);
        callLineLs.add(calin);
        insert callLineLs;
         
         
        //CampaignTelUW testWelcomCall = new CampaignTelUW();
        //testWelcomCall.generateMonthlyCampaign('TelUW');
        //testWelcomCall.generateDailyCallLines(calist.id);
		testWelcomCall.execute(null);
        testWelcomCall.roundRobinDist();
         //RoundRobinDistQueueableTelUW rbn = new RoundRobinDistQueueableTelUW();
         //rbn.execute(null);
        Test.stopTest();
     }
     static RecordType getRecordTypeId(string recordTypeName, string sObjectName){
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
}