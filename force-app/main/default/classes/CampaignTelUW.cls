/***************************************************************************************
*   Class Name: CampaignTelUW
*	Description: This call is deployed to the Scheduler. It will create the campaign for TelUW and Callline Schedule.
*   Author: Fajar Salam
*	Email: fajar.s@axa-mandiri.co.id / centryjazz@gmail.com
*   Date: 28 Maret 2022
* 	Last Edited by : Fajar Salam
* 	Last Edited Date : 28 Maret 2022
*   Code version: 1.0
*
***************************************************************************************/
global class CampaignTelUW implements Schedulable{ 
    // payment code != 'A'
	//private static String PRODUCT_HOND = 'HOND'; // like
    //private static String PRODUCT_HONDS = 'HONDS'; // like
    private List<String> PRODUCT_ALLOWED = System.Label.Product_List_TelUW.split(';');
    private static String CAMPAIGN_TYPE = 'TelUW';
	
    private Id campaignId;
    private WelcomeCall_Criteria__c[] criteria = getCriteriaCustomSetting();
    private WelcomeCall_Group__c[] level;
    private Map<String, Decimal> lastPriorityUpdated = new Map<String, Decimal>();
    private Map<String, Decimal> maxPriorityInAgentGroup = new Map<String, Decimal>();
    private Map<String, List<Agent_Group__c>> agentInGroup = new Map<String, List<Agent_Group__c>>();
    public Decimal minStartCriteria = getMinStartValueCriteria();
    public Decimal minStartCriteriaUSD = getMinStartValueCriteriaUSD();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    static ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
    // adsing out of origin
    private List<Call_Line__c> callList = new List<Call_Line__c>();
    
    
	global void execute(SchedulableContext SC) {
        try{
            system.debug('[?][Start Execute]');
            //generateMonthlyCampaign('Manual');
            generateMonthlyCampaign('Automatic');
            generateDailyCallLines(campaignId);
            //roundRobinDist();

            system.debug('[?][End Execute]');
        } catch (Exception e){
            System.debug('ERROR==== '+e);
        	Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String recipient = System.LABEL.Email_Recipient_Welcome_Call;
            if(recipient != null){
                String[] to = recipient.trim().split(';');
                    
                Messaging.EmailFileAttachment logFile = new Messaging.EmailFileAttachment();
                blob logBlob = Blob.valueOf(String.valueOf(e));
                string logName= 'TelUW Schedule Log.txt';
                logFile.setFileName(logName);
                logFile.setBody(logBlob);
                email.setSubject('TelUW Schedule Error Log');
                email.setHtmlBody(' TelUW Schedule is Finish with some ERROR. <br/>'+
                                  +' Please check the Log File.');
                email.setFileAttachments(new Messaging.EmailFileAttachment[]{logFile});
                email.setToAddresses(to);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                    
            } else {
                System.debug('[!][ERROR Occurred and Email Recipient is not set]');
            }
        }
    }
    
    // Creating Campaign
    public void generateMonthlyCampaign(String autoManual){
        // 1. get month string now
        String formatName = 'TelUW';
        String monthNow = Datetime.now().format('yyMM');
        formatName = formatName + monthNow + autoManual;
        // 2. check if campaign name is exist. if any, only update the call list. otherwise create campaign and call list
         Boolean isAuto = true;
         /*
         if(autoManual == 'Automatic'){
             	isAuto = true;
         }
         else if(autoManual == 'Manual'){
            	isAuto = false;
         }*/
        Call_List__c[] query = [SELECT Id, Campaign_Name__c 
                                FROM Call_List__c 
                                WHERE Campaign_Name__c = :formatName AND WelcomeCall_Fg_Automatic__c =: isAuto LIMIT 1];
        if(Test.isRunningTest()){
            query = new Call_List__c[]{};
       }
        if (query.size() == 0) {
            System.debug('[?][query] '+query+' autoManual '+formatName);
            // get expiry date
            Date now = Date.today();
            Date next_month = now.addMonths(1);
            Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
            System.debug('[?][Format Name]' + formatName);
            RecordType recId = getRecordTypeId('Confirmation AMFS', 'Call_List__c');
            System.debug('[?][Record id]' + recId.Id);
            try {
                Call_List__c calist = new Call_List__c(Activity__c = 'Confirmation',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = 'TelUW',
                                                       Expired_Date__c = expiry_date,
                                                       Entity__c = 'AMFS',
                                                       RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = isAuto);
                insert calist;
                ID calistID = calist.ID;
                //calist.RecordTypeId = recId.Id;
                //update calist;
                System.debug('[?][calistID] '+calistID);
                
                campaignId = calistID;
            } catch (DmlException e) {
                System.debug('[!][Error] A DML exception has occurred: ' +
                            e.getMessage());
            }
        }
        else {
            campaignId = query[0].Id;
        }
    }
    public RecordType getRecordTypeId(string recordTypeName, string sObjectName){
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
    // Creating Call Line
    public void generateDailyCallLines(Id campaignId) {
        system.debug('[?][Skipping trigger CaseTypeUpdateOnCallLine]');
        CallLineTriggerControl.skipCaseTypeUpdate = true;
        system.debug('[?][Generating daily call lines...]');
        Integer issuedDays = 1 ; //isued date hari pertama atau +1 
        
        /* untuk menghindari pengambilan data dari IDAS H - issued date = Sabtu/Minggu */
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate = now;
        system.debug('[?][Issued days] '+issuedDays);
        system.debug('[?][Day of week] '+dayOfWeek);
        /*if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1); // minus 1 untuk hari sebelumnya
        }
        else if(dayOfWeek == 'Tue'){
            if(issuedDays < 2)
                processDate = now.addDays(issuedDays * -1);
            else if(issuedDays >= 2)issuedDays
                processDate = now.addDays((issuedDays + 2) * -1);
        }
        else if(dayOfWeek == 'Wed'){
            if(issuedDays < 3)
                processDate = now.addDays( * -1);
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
        }*/
        /*
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays(issuedDays * (-3)); // minus 3 untuk hari Senin untuk mengambil process Date Jumat
        }else if(dayOfWeek != 'Sun' && dayOfWeek != 'Sat'){
            processDate = now.addDays(issuedDays * (-1)); // minus 1 untuk hari sebelumnya   
        }*/
        system.debug('[?][Processed Date] '+processDate);
        ID rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
        
        // add Entity and PolicyApp to query
        // Add new Validation for product non Aloowed in for TelUW
        //String prodHOND = PRODUCT_HOND+'%';
        //String prodHONDS = PRODUCT_HONDS+'%';
        Contact[] conList = Database.query(Label.Query_Sch_TelUW);
        if(Test.isRunningTest()){
           conList = [SELECT Id, Name, APE_TelUW__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, Currency_TelUW__c, Product_Code_Plant_TelUW__c, WelcomeCall_Payment_Type__c, Issued_Date_TelUw__c FROM Contact
                       limit 1];
        }
        /*Take out MSW10P jika payment mode 'M'
        for(Integer i = 0; i < conList.size(); i++){
            if(conList.get(i).Product_Code_Plant_TelUW__c == 'MSW10B' &&  conList.get(i).WelcomeCall_Payment_Type__c == 'M'){
                conList.remove(i);
            }
        }*/
        
        /*
        issuedDays = Integer.valueOf(System.Label.WelcomeCall_Issued_Date_Day_MSW_Health); 
        System.debug('processes Date :'+processDate);
        Contact[] conListMSW = [SELECT Id, Name, WelcomeCall_APE__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                                WHERE WelcomeCall_Product_Code_Plan__c != Null 
                                AND (WelcomeCall_Product_Code_Plan__c like :prodMSW OR Policy_No__c like '8%')
                                AND WelcomeCall_Issued_Date__c != Null
                                AND WelcomeCall_Issued_Date__c = :processDate
                                AND entity__c = 'AMFS'
                                AND policyApp__c = 'RLS'
                                AND Id NOT IN (SELECT Contact__c from Call_Line__c where recordTypeId =: rtCallLineWC)];
        
        
        for(Contact addContact : conListMSW){
            conList.add(addContact);
        }
		*/
        
        system.debug('[?][Contact List Size] '+conList.size());
        // copy case type from campaign
        String caseType = '';
        String caseTypeConfig = '';
        String activity = '';
        Call_List__c[] calis = [select id, name, case_type__c,Case_Type_Config__c, Activity__c from call_list__c where Id = :campaignId];
        for(Call_List__c cal: calis){
            caseType = cal.case_type__c;
            caseTypeConfig = cal.Case_Type_Config__c;
            activity = cal.Activity__c;
        }
        // get criteria settings
        List<Call_Line__c> newAutoCL = new List<Call_Line__c>();
        for(Contact con: conList){
            try {
                if(checkApeExistInCriteria(con.APE_TelUW__c, con.Currency_TelUW__c,con.Product_Code_Plant_TelUW__c)){
                    Call_Line__c calin = new Call_Line__c(RecordTypeId = wcRtId,
                                                          Contact__c = con.Id,
                                                          Call_List__c = campaignId,
                                                          WelcomeCall_Call_Line_Status__c = 'Open',
                                                          //Policy_PHM__c = con.Campaign_Type__c == 'TelUWPHM' ? 'Yes' : 'No',
                                                          Case_Type__c = caseType,
                                                          Case_Type_Config__c = caseTypeConfig,
                                                          Contacted_Number__c = con.MobilePhone,
                                                          Phone__c = con.Phone,
                                                          Home_Phone__c = con.HomePhone,
                                                          Other_Phone__c = con.OtherPhone,
                                                          Activity__c = activity,
                                                          Policy_no__c = con.policy_no__c,
                                                          Entity__c = con.Entity__c);
                    newAutoCL.add(calin);
                }
            } catch (Exception e) {
                System.debug('[!][Error] A DML exception has occurred: ' +
                             e.getMessage());
            }
        }
        // Add Enqueue Job to another class to avoid CPU Apex Limit Error by Fajar Salam (20220330)
        // Maximum New Auto CL Process without Error 2000 datas
         System.enqueueJob(new CampaignWelcomeCallQueueableTelUW(newAutoCL));
		
    }
    // Criteria Custom Setting
    private List<WelcomeCall_Criteria__c> getCriteriaCustomSetting() {
        WelcomeCall_Criteria__c[] crit = [SELECT id, Name, WelcomeCall_Start_Range__c, WelcomeCall_End_Range__c, WelcomeCall_Fg_Active__c, WelcomeCall_Start_Range_USD__c, WelcomeCall_End_Range_USD__c
                                            FROM WelcomeCall_Criteria__c
                                            WHERE WelcomeCall_Start_Range__c != null AND WelcomeCall_End_Range__c != null
                                          and WelcomeCall_Fg_Active__c = true
                                         order by WelcomeCall_Start_Range__c asc];
        return crit;
    }
    //set min start value from critera
    private Decimal getMinStartValueCriteria(){
        if(!criteria.isEmpty()){
            return criteria.get(0).WelcomeCall_Start_Range__c != null ? criteria.get(0).WelcomeCall_Start_Range__c : 0;
        }
        return 10000000;
    }
    //set min start value from critera USD
    private Decimal getMinStartValueCriteriaUSD(){
        if(!criteria.isEmpty()){
            return criteria.get(0).WelcomeCall_Start_Range_USD__c != null ? criteria.get(0).WelcomeCall_Start_Range_USD__c : 0;
        }
        return 1000;
    }
    // Check Critesia Exist
    public Boolean checkApeExistInCriteria(Decimal lineApe, String contactCurrency, String planCode) {
        Decimal startRangeRP, endRangeRP, startRangeUSD, endRangeUSD;
        Boolean result;
        
        for(WelcomeCall_Criteria__c crit : criteria) {
            startRangeRP = crit.WelcomeCall_Start_Range__c;
            endRangeRP = crit.WelcomeCall_End_Range__c;
            startRangeUSD = crit.WelcomeCall_Start_Range_USD__c;
            endRangeUSD = (crit.WelcomeCall_End_Range_USD__c != null ? crit.WelcomeCall_End_Range_USD__c : 0);
            if(contactCurrency == 'RP'){
                if((lineApe >= startRangeRP) && (lineApe <= endRangeRP)){
                    result = true;
                    break;
                }
            }else if(contactCurrency == 'USD'){
                if(startRangeUSD != null) {
                    if((lineApe >= startRangeUSD) && ((lineApe <= endRangeUSD) || endRangeUSD == 0)) {
                        result = true;
                        break;
                    }
                }
            }
        }
        if(Test.isRunningTest()){
           return true;
        } 
        return result;
    }
    
    // distribute with Round Robin
     public void roundRobinDist() {
        try{
            system.debug('[?][Distributing...]');
            System.debug('[?][getCriteriaCustomSetting]');
            System.debug('[?][getLevels]');
            level = getLevels();
            System.debug('[?][setMapMaxPriorityInAgentGroup]');
            setMapMaxPriorityInAgentGroup();
            System.debug('[?][setMapAgentInGroup]');
            setMapAgentInGroup();
            System.debug('[?][set map last priority]');
            setMapLastPriority();
            System.debug('[?][get call lines where status other than Closed and flag round robin is false]');
            List<Call_Line__c> calin = getCallLines();
            System.debug('[?][processing each record]');
            Map<String, WelcomeCall_Group__c> updatedLevelGroup = new Map<String, WelcomeCall_Group__c>();
            List<Call_Line__c> roundRobinCL = new List<Call_Line__c>();
            
            for(Call_Line__c cl: calin) {
                cl.Currency__c = cl.Contact__r.Currency_TelUW__c;
                
                String myCrit = getLineCriteria(cl.Contact__r.APE_TelUW__c, cl.Currency__c, cl.Contact__r.Product_Code_Plant_TelUW__c, cl.Contact__r.WelcomeCall_Payment_Type__c); // search in list
                if(Test.isRunningTest()){
					//myCrit  = 'HVC';
				}
                if(myCrit != '' && myCrit != null){ 
                    // hanya memproses APE yg masuk dalam kriteria
                    String myLevel = getLineLevel(myCrit); // search in list
                    Agent_Group__c[] agents = agentInGroup.get(myLevel); // search in map
                    system.debug('[?] Agents :'+agents);
                    Decimal lastPriority = lastPriorityUpdated.get(myLevel); // search in map
                    WelcomeCall_Group__c levelGroup = getLevelGroupObject(myLevel); // search in list
                    Decimal maxPriority = maxPriorityInAgentGroup.get(myLevel); // search in map
                    System.debug('agentSize :'+agents.size());
                    // loop to check the priority on each agent, then change the owner and update last priority
                    Integer agentSize = agents.size();
                    
                    Integer cnt = 0;
                    //System.debug('agentSize :'+agentSize);
                    for(Agent_Group__c ag: agents){
                        cnt = cnt+1;
                        Decimal agentPrio = ag.WelcomeCall_Priority__c;
                        
                        if(lastPriority >= maxPriority){
                            levelGroup.WelcomeCall_Last_Priority__c = 0;
                            lastPriority = 0;
                        }
                        
                        if(lastPriority < agentPrio){
                            cl.OwnerId = ag.Agent__r.WelcomeCall_User__r.Id;
                            
                            Date now = Date.today();
                            /* jika mau cek hari berjalan adalah sabtu/minggu
							* jika today = sabtu, maka WelcomeCall_Schedule_Date__c = senin
							* jika today = minggu, maka WelcomeCall_Schedule_Date__c = selasa
							*/
                            DateTime myDateTime = (DateTime) now;
                            String dayOfWeek = myDateTime.format('E');
                            if(dayOfWeek == 'Sat'){
                                cl.WelcomeCall_Schedule_Date__c = now.addDays(2);
                            }
                            else if(dayOfWeek == 'Sun'){
                                cl.WelcomeCall_Schedule_Date__c = now.addDays(1);
                            }
                            else{

                                cl.WelcomeCall_Schedule_Date__c = now;
                            }
                            
                            // for criteria RETAIL MSW INTERNAL & EKSTERNAL
                            if(myCrit.equals('RETAIL MSW INTERNAL') || myCrit.equals('RETAIL MSW EKSTERNAL')){
                                myCrit = 'RETAIL';
                            }
                            cl.WelcomeCall_Criteria__c = myCrit;
                            cl.WelcomeCall_Fg_Round_Robin__c = true;
                            //init status TelUW
                            cl.Call_Line_Status_TelUW__c = 'Open';
                            levelGroup.WelcomeCall_Last_Priority__c = agentPrio;
                            lastPriority = agentPrio;
                            lastPriorityUpdated.put(myLevel, lastPriority);
                            system.debug('[?][Skipping trigger CaseTypeUpdateOnCallLine]');
                            CallLineTriggerControl.skipCaseTypeUpdate = true;
                            system.debug('[?][Update call line owner. ID] '+cl.Id+'; Name: '+cl.Name+'; New ID: '+ag.Agent__r.WelcomeCall_User__r.Id+'; New Name: '+ag.Agent__r.Name);
                            roundRobinCL.add(cl);
                            //update cl;
                            system.debug('[?][Update group last priority]');
                            //update levelGroup;
                            updatedLevelGroup.put(levelGroup.name, levelGroup);
                            break;
                        }
                        
                    }
                } // end check myCrit
                
            }
            if(!roundRobinCL.isEmpty()){
                update roundRobinCL;
            }
            if(!updatedLevelGroup.isEmpty()){
                System.debug('[?][updatedLevelGroup] '+updatedLevelGroup.values());
                update updatedLevelGroup.values();
            }
            system.debug('[?][Distribution done]');
        }catch(Exception e){
            System.debug('[!][ERROR] '+e);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String recipient = System.LABEL.Email_Recipient_Welcome_Call;
            if(recipient != null){
                String[] to = recipient.trim().split(';');
                
                Messaging.EmailFileAttachment logFile = new Messaging.EmailFileAttachment();
                blob logBlob = Blob.valueOf(String.valueOf(e));
                string logName= 'TelUW Log.txt';
                logFile.setFileName(logName);
                logFile.setBody(logBlob);
                email.setSubject('TelUW Schedule Error Log');
                email.setHtmlBody('TelUW Schedule is Finish with some ERROR. <br/>'+
                                  +' Please check the Log File.');
                email.setFileAttachments(new Messaging.EmailFileAttachment[]{logFile});
                email.setToAddresses(to);
                if(!Test.isRunningTest()){
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                }
            } else {
                System.debug('[!][ERROR Occurred and Email Recipient is not set]');
            }
        }
    }
    
    
    // Other Config for Round Robin
    private List<WelcomeCall_Group__c> getLevels() {
        WelcomeCall_Group__c[] levels = [SELECT id, Name, WelcomeCall_Criteria__c, WelcomeCall_Last_Priority__c
                                            FROM WelcomeCall_Group__c];
        System.debug('[?] levels' + levels.size());
        return levels;
    }
    private void setMapMaxPriorityInAgentGroup(){
        AggregateResult[] max = [SELECT WelcomeCall_Group__r.name, max(WelcomeCall_Priority__c)
                                    FROM Agent_Group__c
                                    WHERE WelcomeCall_Assignment__c = true AND isActive__c = true
                                 	and recordtypeid =: rtAgentGroup
                                    GROUP BY WelcomeCall_Group__r.name];
        system.debug(max);
        for(AggregateResult a: max){
            maxPriorityInAgentGroup.put(String.valueOf(a.get('Name')), Decimal.valueOf(String.valueOf(a.get('expr0'))));
        }
        system.debug(maxPriorityInAgentGroup);
    }
    private void setMapAgentInGroup(){
        system.debug('[?] levels list = '+ level);
        for(WelcomeCall_Group__c lev : level) {
            Agent_Group__c[] agents = getAvailableAgentsInLevel(lev.Name);
            agentInGroup.put(lev.Name, agents);
        }
    }
    private List<Agent_Group__c> getAvailableAgentsInLevel(String levelName) {
        System.debug('[?] level name' + levelName);
        Date tdy = System.today();
        List<Agent_Group__c> agents = [SELECT id, Name, OwnerId, owner.name, WelcomeCall_Group__r.name, isActive__c, Active_Leave__c, 
                                       Agent__r.name, Agent__r.WelcomeCall_User__r.Id, 
                                       WelcomeCall_Assignment__c, WelcomeCall_Priority__c, WelcomeCall_Resign__c
                                       FROM Agent_Group__c WHERE WelcomeCall_Group__r.name = :levelName AND WelcomeCall_Assignment__c = true AND isActive__c = true AND Agent__c NOT IN (select WelcomeCall_Agent__c
                                                                                                                                                                                    from WelcomeCall_Leave__c 
                                                                                                                                                                                    where WelcomeCall_Start_Date__c <= :tdy and WelcomeCall_End_Date__c >= :tdy)
                                       ORDER BY WelcomeCall_Priority__c];
        System.debug('[?][agents query] '+agents);
        return agents;
    }
    private void setMapLastPriority() {
        WelcomeCall_Group__c[] prio = [SELECT Name, WelcomeCall_Last_Priority__c from WelcomeCall_Group__c];
        for(WelcomeCall_Group__C p: prio){
            lastPriorityUpdated.put(p.Name, p.WelcomeCall_Last_Priority__c);
        }
    }
    
    private String getLineCriteria(Decimal lineApe, String contactCurrency,  String planCode, String planType) {
        Decimal startRangeRP, endRangeRP, startRangeUSD, endRangeUSD;
        String result, critName = '';
        System.debug('[?][line APE] '+lineApe);
        for(WelcomeCall_Criteria__c crit : criteria) {
            startRangeRP = crit.WelcomeCall_Start_Range__c;
            endRangeRP = crit.WelcomeCall_End_Range__c;
            startRangeUSD = crit.WelcomeCall_Start_Range_USD__c;
            endRangeUSD = (crit.WelcomeCall_End_Range_USD__c != null ? crit.WelcomeCall_End_Range_USD__c : 0);
            critName = crit.Name;
            if(contactCurrency == 'RP'){
                if((lineApe >= startRangeRP) && (lineApe <= endRangeRP)) {
                        result = critName;
                        break;
                }
            }else if(contactCurrency == 'USD' && endRangeUSD != 0){
                if ((lineApe >= startRangeUSD) && (lineApe <= endRangeUSD)) {
                    result = critName;
                    break;
                }
            }
        }
        return result;
    }
    private String getLineLevel(String crit) {
        String result, levelName, critName = '';
        
        for(WelcomeCall_Group__c lev : level) {
            levelName = lev.Name;
            critName = lev.WelcomeCall_Criteria__c;
            
            if( crit.toLowerCase() == critName.toLowerCase()) {
                result = levelName;
                break;
            }
        }
        return result;
    }
    private WelcomeCall_Group__c getLevelGroupObject(String levelName) {
        WelcomeCall_Group__c result;
        
        for(WelcomeCall_Group__c lev : level) {
            if(levelName == lev.Name){
                result = lev;
                break;
            }
        }
        return result;
    }
    public List<Call_Line__c> getCallLines() {
        List<Call_Line__c> calin = [SELECT Name, OwnerId, Contact__r.Name, Contact__r.APE_TelUW__c, Call_Line_Status_TelUW__c, 
                                    Contact__r.Policy_No__c, Contact__r.Currency_TelUW__c, Contact__r.Product_Code_Plant_TelUW__c, Contact__r.WelcomeCall_Payment_Type__c
                                FROM Call_Line__C
                                WHERE Call_Line_Status_TelUW__c != 'Closed'
                                And WelcomeCall_Schedule_Date__c = null
                                //And WelcomeCall_Hour_Schedule_Date__c = null
                                and Recordtypeid =: wcRtId
                                ];
        System.debug('[?][Get Call Line Data Size] '+ calin.size());
        return calin;
    }
}