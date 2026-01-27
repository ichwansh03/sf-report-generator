global class CampaignRedemptionKonvenAndTM implements Schedulable {
    
    private Id campaignId;
    private Id campaignId2;
    private WelcomeCall_Group__c[] level;
    private Map<String, Decimal> lastPriorityUpdated = new Map<String, Decimal>();
    private Map<String, Decimal> maxPriorityInAgentGroup = new Map<String, Decimal>();
    private Map<String, List<Agent_Group__c>> agentInGroup = new Map<String, List<Agent_Group__c>>();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    static ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Collection AMFS 8').getRecordTypeId();
    static ID wcRtId2 = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Collection AMFS 7').getRecordTypeId();
    
    private Map<Id, String> batchClassIds;
    
    
    
    global void execute(SchedulableContext SC) {
        try{
            system.debug('Start Executess ' + wcRtId);
            system.debug('Start Execute ' + wcRtId2);
            generateMonthlyCampaign('Manual');
            //CallLineWelcomeCall call = new CallLineWelcomeCall();
            generateDailyCallLines(campaignId, campaignId2);
            
            
            system.debug('End Execute');
        } catch (Exception e){
            System.debug('ERROR==== '+e);
        }
    }
    
    public void generateCriteria(List<Call_Line__c> calin){
        system.debug('generateCriteria --> ' + calin);
        Map<String, WelcomeCall_Group__c> updatedLevelGroup = new Map<String, WelcomeCall_Group__c>();
        List<Call_Line__c> roundRobinCL = new List<Call_Line__c>();
        String myCrit = '';
        
        
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        for(Call_Line__c cl: calin) {
            System.debug('LVLVLV '+ cl.Contact__r.campaign_type__c);
            
            if (cl.Contact__r.campaign_type__c == 'Redemption_TM'){
                myCrit = 'Collection - Redemption TM';
            } else if (cl.Contact__r.campaign_type__c == 'Lapse_TM'){
                myCrit = 'Collection - Lapse TM';
            }
            
            System.debug('?[] mycrit '+ myCrit);
            
            if(myCrit != '' && myCrit != null){ 
                // hanya memproses APE yg masuk dalam kriteria
                String myLevel = myCrit; // search in list
                System.debug('?[] mycrit 2'+ myCrit + ' my Level ' + myLevel);
                Agent_Group__c[] agents = agentInGroup.get(myLevel); // search in map
                Decimal lastPriority = lastPriorityUpdated.get(myLevel); // search in map
                WelcomeCall_Group__c levelGroup = getLevelGroupObject(myLevel); // search in list
                //WelcomeCall_Group__c levelGroup = [SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, WelcomeCall_Criteria__c, WelcomeCall_Entity__c, WelcomeCall_Last_Priority__c, WelcomeCall_Status__c FROM WelcomeCall_Group__c where name =: myCrit];
                Decimal maxPriority = maxPriorityInAgentGroup.get(myLevel); // search in map
                System.debug('agents '+ agents + ' lastPriority ' + lastPriority + ' levelGroup ' + levelGroup + ' maxPriority ' + maxPriority);
                System.debug('LevelGroup LV => '+ levelGroup);
                System.debug('LevelGroup LV => '+ levelGroup.Name);
                
                // loop to check the priority on each agent, then change the owner and update last priority
                Integer agentSize = agents.size();
                Integer cnt = 0;
                System.debug('agentSize :'+agentSize);
                for(Agent_Group__c ag: agents){
                    cnt = cnt+1;
                    Decimal agentPrio = ag.WelcomeCall_Priority__c;
                    
                    if(lastPriority >= maxPriority){
                        levelGroup.WelcomeCall_Last_Priority__c = 0;
                        lastPriority = 0;
                    }
                    
                    if(lastPriority < agentPrio){
                        cl.OwnerId = ag.Agent__r.WelcomeCall_User__r.Id;
                        /*
                        if(dayOfWeek == 'Sat'){
                            cl.WelcomeCall_Schedule_Date__c = now.addDays(2);
                        }
                        else if(dayOfWeek == 'Sun'){
                            cl.WelcomeCall_Schedule_Date__c = now.addDays(1);
                        }*/
                        cl.WelcomeCall_Schedule_Date__c = now;
                        
                        
                        cl.WelcomeCall_Criteria__c = myCrit;
                        //cl.Policy_No__c = cl.Contact__r.Policy_No__c;
                        cl.WelcomeCall_Fg_Round_Robin__c = true;
                        
                        levelGroup.WelcomeCall_Last_Priority__c = agentPrio;
                        lastPriority = agentPrio;
                        lastPriorityUpdated.put(myLevel, lastPriority);
                        system.debug('Skipping trigger CaseTypeUpdateOnCallLine.');
                        CallLineTriggerControl.skipCaseTypeUpdate = true;
                        system.debug('Update call line owner. ID: '+cl.Id+'; Name: '+cl.Name+'; New ID: '+ag.Agent__r.WelcomeCall_User__r.Id+'; New Name: '+ag.Agent__r.Name);
                        roundRobinCL.add(cl);
                        //update cl;
                        system.debug('Update group last priority');
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
            System.debug('updatedLevelGroup '+updatedLevelGroup.values());
            update updatedLevelGroup.values();
        }
        system.debug('Distribution done.');
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
    
    public void generateMonthlyCampaign(String autoManual)
    {
        // 1. get month string now
        String formatName = 'Redemption TM';
        String formatName2 = 'Lapse TM';
        String monthNow = Datetime.now().format('yyyyMMdd');
        String monthNow2 = Datetime.now().format('yyyyMM');
        
        formatName = 'Collection-'+formatName +'#'+ monthNow;
        formatName2 = 'Collection-'+formatName2 +'#'+ monthNow2;
        System.debug('formatName ==> ' + formatName);
        System.debug('formatName2 ==> ' + formatName2);
        //formatName = formatName + monthNow + 'Automatic'; 
        // 2. check if campaign name is exist. if any, only update the call list. otherwise create campaign and call list
        Boolean isAuto = false;
        
        Call_List__c[] query = [SELECT Id, Campaign_Name__c 
                                FROM Call_List__c 
                                WHERE Campaign_Name__c = :formatName LIMIT 1];
        
        Call_List__c[] query2 = [SELECT Id, Campaign_Name__c 
                                 FROM Call_List__c 
                                 WHERE Campaign_Name__c = :formatName2  LIMIT 1];
        
        
        if(Test.isRunningTest()){
            query = new Call_List__c[]{};
                }
        System.debug('query LV atas '+query.size());
        if (query.size() == 0) {
            System.debug('query LV '+query+' autoManual '+formatName);
            // get expiry date
            
            System.debug('ELVI Record ==');
            RecordType recId = getRecordTypeId('Collection AMFS', 'Call_List__c');
            //RecordType recId2 = getRecordTypeId('Collection AMFS 7', 'Call_Line__c');
            //System.debug(recId.Id);
            try {
                System.debug('recId ==> ' + recId);
                //System.debug('recId2 ==> ' + recId2);
                Date now = Date.today();
                Date next_month = now.addMonths(1);
                Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
                Call_List__c calist = new Call_List__c(Activity__c = 'Collection',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = 'Redemption TM',
                                                       Entity__c = 'AMFS',
                                                       Expired_Date__c = expiry_date,
                                                       //RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = isAuto);
                
                insert calist;
                calist.RecordTypeId = recId.ID;
                update calist;
                ID calistID = calist.ID;
                System.debug('calist ==> ' + calist.ID);
                
                Call_List__c calist2 = new Call_List__c(Activity__c = 'Collection',
                                                        Campaign_Name__c = formatName2, 
                                                        Case_Type_Config__c = 'Lapse TM',
                                                        Entity__c = 'AMFS',
                                                        Expired_Date__c = expiry_date,
                                                        //RecordTypeId = recId.Id,
                                                        WelcomeCall_Fg_Automatic__c = isAuto);
                
                insert calist2;
                calist2.RecordTypeId = recId.ID;
                update calist2;
                ID calistID2 = calist2.ID;
                System.debug('masuk try ' + calist.ID);
                System.debug('masuk try2 ' + calist2.ID);
                //calist.RecordTypeId = recId.Id;
                //update calist;
                System.debug('calistID '+calistID);
                System.debug('calistID2 '+calistID2);
                
                campaignId = calistID;
                campaignId2 = calistID2;
            } catch (DmlException e) {
                System.debug('A DML exception has occurred: ' +
                             e.getMessage());
            }
        } else {
            System.debug('formatName '+formatName + ' query[0].Id ==> ' + query[0].Id);
            System.debug('formatName2 '+formatName2 + ' query2[0].Id ==> ' + query2[0].Id);
            campaignId = query[0].Id;
            campaignId2 = query2[0].Id;
        }
    }
    public RecordType getRecordTypeId(string recordTypeName, string sObjectName)
    {
        System.debug('masuk RecordType ' + recordTypeName + ' object Name === ' + sObjectName);
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
        System.debug('Result record type ' + result);
        return result;
    }
    
    /*
public void testAja(Id campaignId) {
generateDailyCallLines(campaignId);
roundRobinDist(true);
}
*/    
    
    public void roundRobinDist(Boolean isAutoCallLine) {
        try{
            system.debug('Distributing...LV');
            level = getLevels(); // soql
            // set map maximal priority
            System.debug('setMapMaxPriorityInAgentGroup');
            setMapMaxPriorityInAgentGroup();
            // set map agent in group
            System.debug('setMapAgentInGroup');
            setMapAgentInGroup();
            // set map last priority
            System.debug('setMapLastPriority LV');
            setMapLastPriority(); // soql
            // get call lines where status other than Closed and flag round robin is false
            System.debug('isAutoCallLine LV= ' + isAutoCallLine);
            List<Call_Line__c> calin = getCallLines(wcRtId);
            List<Call_Line__c> calin2 = getCallLines(wcRtId2);// soql
            generateCriteria(calin);
            generateCriteria(calin2);
            system.debug('calin1 --> ' + calin);
            system.debug('calin2 --> ' + calin);
            
        }catch(Exception e){
            System.debug('ERROR==== '+e);
            
        }
    }
    
    //Faizir 27042021, Add validation for product MSW
    public List<Call_Line__c> getCallLines(String wcRtId) {
        System.debug('[?] Recordtypeid LV = ' + wcRtId);
        List<Call_Line__c> calin = [SELECT id, Name, OwnerId, Contact__r.campaign_type__c, Contact__r.Name, Contact__r.policyApp__c, Contact__r.WelcomeCall_APE__c, WelcomeCall_Call_Line_Status__c, 
                                    Contact__r.Policy_No__c, Contact__r.WelcomeCall_Currency__c, Contact__r.WelcomeCall_Product_Code_Plan__c, Contact__r.WelcomeCall_Payment_Type__c
                                    FROM Call_Line__c
                                    WHERE Call_Line_Status_TelUW__c = 'Open'
                                    AND WelcomeCall_Fg_Round_Robin__c = false
                                    And welcomecall_fg_schedule__c = false
                                    and Recordtypeid =: wcRtId];
        System.debug('[?] calin = '+ calin);
        System.debug('[?] Call List = '+calin.size());
        return calin;
    }
    
    private List<WelcomeCall_Group__c> getLevels() {
        WelcomeCall_Group__c[] levels = [SELECT id, Name, WelcomeCall_Criteria__c, WelcomeCall_Last_Priority__c
                                         FROM WelcomeCall_Group__c];
        return levels;
    }
    
    private List<Agent_Group__c> getAvailableAgentsInLevel(String levelName) {
        Date tdy = System.today();
        List<Agent_Group__c> agents = [SELECT id, Name, OwnerId, owner.name, WelcomeCall_Group__r.name, isActive__c, Active_Leave__c, 
                                       Agent__r.name, Agent__r.WelcomeCall_User__r.Id, 
                                       WelcomeCall_Assignment__c, WelcomeCall_Priority__c, WelcomeCall_Resign__c
                                       FROM Agent_Group__c WHERE WelcomeCall_Group__r.name = :levelName AND WelcomeCall_Assignment__c = true AND isActive__c = true AND Agent__c NOT IN (select WelcomeCall_Agent__c
                                                                                                                                                                                         from WelcomeCall_Leave__c 
                                                                                                                                                                                         where WelcomeCall_Start_Date__c <= :tdy and WelcomeCall_End_Date__c >= :tdy)
                                       ORDER BY WelcomeCall_Priority__c];
        System.debug('agents query :'+agents);
        return agents;
    }
    
    private void setMapAgentInGroup(){
        for(WelcomeCall_Group__c lev : level) {
            Agent_Group__c[] agents = getAvailableAgentsInLevel(lev.Name);
            agentInGroup.put(lev.Name, agents);
            System.debug('setMapAgentInGroup SET--> :'+agents + ' , ' + lev.name);
        }
    }
    
    private void setMapMaxPriorityInAgentGroup(){
        AggregateResult[] max = [SELECT WelcomeCall_Group__r.name, max(WelcomeCall_Priority__c)
                                 FROM Agent_Group__c
                                 WHERE WelcomeCall_Assignment__c = true AND isActive__c = true
                                 and recordtypeid =: rtAgentGroup
                                 GROUP BY WelcomeCall_Group__r.name];
        system.debug('setMapMaxPriorityInAgentGroup LV --> '+max);
        for(AggregateResult a: max){
            maxPriorityInAgentGroup.put(String.valueOf(a.get('Name')), Decimal.valueOf(String.valueOf(a.get('expr0'))));
        }
        system.debug('maxPriorityInAgentGroup LV --> '+maxPriorityInAgentGroup);
    }
    
    private void setMapLastPriority() {
        WelcomeCall_Group__c[] prio = [SELECT Name, WelcomeCall_Last_Priority__c from WelcomeCall_Group__c];
        for(WelcomeCall_Group__C p: prio){
            lastPriorityUpdated.put(p.Name, p.WelcomeCall_Last_Priority__c);
        }
    }
    
    public void generateDailyCallLines(Id campaignId, Id campaignId2) {
        system.debug('Skipping trigger CaseTypeUpdateOnCallLine.');
        CallLineTriggerControl.skipCaseTypeUpdate = true;
        system.debug('Generating daily call lines...');
        Integer issuedDays = Integer.valueOf(System.Label.WelcomeCall_Lapse_Date_Day); 
        
        /* untuk menghindari pengambilan data dari IDAS H - issued date = Sabtu/Minggu */
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate=now.addDays(issuedDays * -1);
        Date processDate2= now.addDays((issuedDays - 1) * -1);
        system.debug('Issued days: '+issuedDays);
        system.debug('Day of week: '+dayOfWeek);
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1);
            processDate2 = now.addDays((issuedDays + 1) * -1);
        } else if(dayOfWeek == 'Wed' || dayOfWeek == 'Thu' || dayOfWeek == 'Fri' ){
            processDate = now.addDays(issuedDays * -1);
            processDate2 = now.addDays((issuedDays - 1) * -1);
            
        } else if(dayOfWeek == 'Tue'){
            
            processDate = now.addDays((issuedDays + 1) * -1);
            processDate2 = now.addDays((issuedDays) * -1);
        }
        system.debug('processed Date MSW: '+processDate);
        system.debug('processed Date MSW2: '+processDate2);
        
        ID rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Collection AMFS 8').getRecordTypeId();
        ID rtCallLineWC2 = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Collection AMFS 7').getRecordTypeId();
        system.debug('rtCallLineWC: '+rtCallLineWC);
        system.debug('rtCallLineWC2: '+rtCallLineWC2);
        // add Entity and PolicyApp to query by Faizir 2020/05/22
        //Faizir 28042021, Add new Validation for product non MSW
        //
        
        Contact[] conList = [SELECT Id, Name, Campaign_Type__c, policyApp__c, WelcomeCall_APE__c, Lapse_Date_Day__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                             WHERE Lapse_Date_Day__c != Null
                             AND (Lapse_Date_Day__c >= :processDate AND  Lapse_Date_Day__c <= :processDate2)                   
                             AND entity__c = 'AMFS'
                             AND (policyApp__c = 'DMTM')
                             AND Campaign_Type__c = 'Lapse_TM'
                             AND Id NOT IN (SELECT Contact__c from Call_Line__c where recordTypeId =: rtCallLineWC2)];
        system.debug('conlistnya nyaxx: '+conList);
        system.debug('conlistnya nyax: '+conList.size());
        system.debug('rtCallLineWC nyax: '+rtCallLineWC2);
        if(Test.isRunningTest()){
            conList = [SELECT Id, Name, Campaign_Type__c, WelcomeCall_APE__c, policyApp__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                       WHERE WelcomeCall_Product_Code_Plan__c != Null limit 1];
        }
        system.debug('conlistnya nya: '+conList);
        system.debug('copy nih nya: '+rtCallLineWC);
        
        //Faizir 27042021, Utk product MSW dan All Health, Process Date yg diambil itu H-1
        issuedDays = Integer.valueOf(System.Label.WelcomeCall_Redepmtion_Date_Day);
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays((issuedDays + 2) * -1); 
        }else if(dayOfWeek != 'Sun' && dayOfWeek != 'Sat' && dayOfWeek != 'Mon'){
            processDate = now.addDays(issuedDays * (-1));
        } 
        
        System.debug('processes Date Other:'+processDate);
        System.debug('issued Date Other:'+issuedDays);
        Contact[] conListMSW = [SELECT Id, Name, Campaign_Type__c, policyApp__c,WelcomeCall_APE__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                                WHERE LastModifiedDate != Null 
                                AND LastModifiedDate >= :processDate
                                AND entity__c = 'AMFS'
                                AND policyApp__c = 'DMTM'
                                AND Campaign_Type__c = 'Redemption_TM'
                                /*
* Add by Fajar Salam 29/03/2022
* Prevent for addid Data TelUW
*/
                                AND Id NOT IN (SELECT Contact__c from Call_Line__c where recordTypeId =: rtCallLineWC)];
        system.debug('conlistnyaaaa: '+conListMSW);
        for(Contact addContact : conListMSW){
            conList.add(addContact);
        }
        system.debug('Contact List Size : '+conList.size());
        // copy case type from campaign
        String caseType = '';
        String caseTypeConfig = '';
        String activity = '';
        String caseType2 = '';
        String caseTypeConfig2 = '';
        String activity2 = '';
        Call_List__c[] calis = [select id, name, case_type__c,Case_Type_Config__c, Activity__c from call_list__c where Id = :campaignId];
        for(Call_List__c cal: calis){
            caseType = cal.case_type__c;
            caseTypeConfig = cal.Case_Type_Config__c;
            activity = cal.Activity__c;
        }
        Call_List__c[] calis2 = [select id, name, case_type__c,Case_Type_Config__c, Activity__c from call_list__c where Id = :campaignId2];
        for(Call_List__c cal2: calis2){
            caseType2 = cal2.case_type__c;
            caseTypeConfig2 = cal2.Case_Type_Config__c; 
            activity2 = cal2.Activity__c;
        }
        
        // get criteria settings
        //criteria = getCriteriaCustomSetting();
        List<Call_Line__c> newAutoCL = new List<Call_Line__c>();
        system.debug('MASUKxx' + conList.size());
        for(Contact con: conList){
            system.debug('MASUK loop ' + con.policyApp__c);
            system.debug('MASUK loop contact ' + con);
            try {
                system.debug('Campaign_Type__c ==> ' + con.Campaign_Type__c);
                system.debug('Call_List__c ==> ' + campaignId);
                system.debug('Call_List__c ==> ' + campaignId2);
                system.debug('activity ==> ' + activity);
                system.debug('activity2 ==> ' + activity2);
                if (con.Campaign_Type__c == 'Redemption_TM'){
                    Call_Line__c calin = new Call_Line__c(RecordTypeId = wcRtId,
                                                          Contact__c = con.Id,
                                                          Call_List__c = campaignId,
                                                          Call_Line_Status_TelUW__c = 'Open',
                                                          Case_Type__c = caseType,
                                                          Case_Type_Config__c = caseTypeConfig,
                                                          Contacted_Number__c = con.MobilePhone,
                                                          Phone__c = con.Phone,
                                                          Home_Phone__c = con.HomePhone,
                                                          Other_Phone__c = con.OtherPhone,
                                                          Activity__c = activity,
                                                          Policy_no__c = con.policy_no__c,
                                                          Entity__c = con.Entity__c,
                                                          Parent_Campaign__c= campaignId);
                    newAutoCL.add(calin);
                } else {
                    
                    Call_Line__c calin2 = new Call_Line__c(RecordTypeId = wcRtId2,
                                                           Contact__c = con.Id,
                                                           Call_List__c = campaignId2 ,
                                                           //WelcomeCall_Call_Line_Status__c = 'Open',
                                                           Call_Line_Status_TelUW__c = 'Open',
                                                           Case_Type__c = caseType2,
                                                           Case_Type_Config__c = caseTypeConfig2,
                                                           Contacted_Number__c = con.MobilePhone,
                                                           Phone__c = con.Phone,
                                                           Home_Phone__c = con.HomePhone,
                                                           Other_Phone__c = con.OtherPhone,
                                                           Activity__c = activity2,
                                                           Policy_no__c = con.policy_no__c,
                                                           Entity__c = con.Entity__c,
                                                           Parent_Campaign__c= campaignId2);
                    newAutoCL.add(calin2);
                }
                system.debug('kesina');
            } catch (Exception e) {
                System.debug('A DML exception has occurred: ' +
                             e.getMessage());
            }
        } system.debug('MASUK2');
        // Add Enqueue Job to another class to avoid CPU Apex Limit Error by Faizir (20200605)
        // Maximum New Auto CL Process without Error 2000 datas
        //System.enqueueJob(new CampaignWelcomeCallQueueable(newAutoCL));
        System.enqueueJob(new CampaignRedemptionLapseQueueable(newAutoCL)); 
        
    }
}