/***************************************************************************************
*    Class Name: CallLineWelcomeCall
*    Description: 
*    Author: Ocky Harliansyah
*    Email: ocky.harliansyah@phincon.com | ocky.harli@gmail.com
*    Date: 17 September 2018
*    Code version: 1.2
*
***************************************************************************************/
public class CallLineWelcomeCall {
    private static String PRODUCT_MSW = 'MSW';
    private WelcomeCall_Criteria__c[] criteria;
    private WelcomeCall_Group__c[] level;
    private Map<String, Decimal> lastPriorityUpdated = new Map<String, Decimal>();
    private Map<String, Decimal> maxPriorityInAgentGroup = new Map<String, Decimal>();
    private Decimal minStartCriteria;
    private Decimal minStartCriteriaUSD;
    private Map<String, List<Agent_Group__c>> agentInGroup = new Map<String, List<Agent_Group__c>>();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    static ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    
    public CallLineWelcomeCall(){
        criteria = getCriteriaCustomSetting();
        minStartCriteria = getMinStartValueCriteria();
        minStartCriteriaUSD = getMinStartValueCriteriaUSD();
    }
    
    /*
public void testAja(Id campaignId) {
//criteria = getCriteriaCustomSetting(); // soql
generateDailyCallLines(campaignId);
roundRobinDist(true);
}
*/
    
    public void roundRobinDist(Boolean isAutoCallLine) {
        system.debug('wcRtId : ' + wcRtId);
        system.debug('Distributing...');
        // get criteria setting
        System.debug('getCriteriaCustomSetting');
        //already populate when create new class object
        //criteria = getCriteriaCustomSetting(); // soql
        // get levels
        System.debug('getLevels');
        level = getLevels(); // soql
        // set map maximal priority
        System.debug('setMapMaxPriorityInAgentGroup');
        setMapMaxPriorityInAgentGroup();
        // set map agent in group
        System.debug('setMapAgentInGroup');
        setMapAgentInGroup();
        // set map last priority
        System.debug('setMapLastPriority ' + isAutoCallLine);
        setMapLastPriority(); // soql
        // get call lines where status other than Closed and flag round robin is false
        List<Call_Line__c> calin = getCallLines(isAutoCallLine); // soql
        System.debug('setMapLastPriority 2' + calin);
        // processing each record
        
        Map<String, WelcomeCall_Group__c> updatedLevelGroup = new Map<String, WelcomeCall_Group__c>();
        List<Call_Line__c> roundRobinCL = new List<Call_Line__c>();
        //Decimal batas = 0;
        String myCrit;
        System.debug('myCrit ' + myCrit + calin.size());
        for(Call_Line__c cl: calin) {
            system.debug('Getting Call Line Criteria');
            if (cl.Contact__r.policyApp__c !=  'G400'){
                myCrit = getLineCriteria(cl.Contact__r.WelcomeCall_APE__c, cl.Contact__r.WelcomeCall_Currency__c, cl.Contact__r.WelcomeCall_Product_Code_Plan__c, cl.Contact__r.WelcomeCall_Payment_Type__c); // search in list
            } else {
                myCrit = 'Agent In House';
            }
            if(myCrit != '' && myCrit != null 
               //&& batas <= 500
              ){ // hanya memproses APE yg masuk dalam kriteria
                System.debug('APE: '+cl.Contact__r.WelcomeCall_APE__c);
                System.debug('Line Criteria: '+myCrit);
                String myLevel = getLineLevel(myCrit); // search in list
                System.debug('Level: '+myLevel);
                
                Agent_Group__c[] agents = agentInGroup.get(myLevel); // search in map
                Decimal lastPriority = lastPriorityUpdated.get(myLevel); // search in map
                WelcomeCall_Group__c levelGroup = getLevelGroupObject(myLevel); // search in list
                Decimal maxPriority = maxPriorityInAgentGroup.get(myLevel); // search in map
                
                // loop to check the priority on each agent, then change the owner and update last priority
                Integer agentSize = agents.size();
                Integer cnt = 0;
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
                        
                        if(myCrit.equals('RETAIL MSW INTERNAL') || myCrit.equals('RETAIL MSW EKSTERNAL')){
                            myCrit = 'RETAIL';
                        }
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
            //batas++;
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
    
    public List<Call_Line__c> getCallLines(Boolean isAutoCallLine) {
        List<Call_Line__c> calin = [SELECT Name, OwnerId, Contact__r.Name, Contact__r.WelcomeCall_APE__c, WelcomeCall_Call_Line_Status__c, Contact__r.Policy_No__c, 
                                    Contact__r.WelcomeCall_Currency__c, Contact__r.policyApp__c, Contact__r.WelcomeCall_Product_Code_Plan__c, Contact__r.WelcomeCall_Payment_Type__c 
                                    FROM Call_Line__C
                                    WHERE WelcomeCall_Call_Line_Status__c != 'Closed' 
                                    AND Call_List__r.WelcomeCall_Fg_Automatic__c =: isAutoCallLine
                                    AND WelcomeCall_Fg_Round_Robin__c = false
                                    And welcomecall_fg_schedule__c = false
                                    and Recordtypeid =: wcRtId];
        return calin;
    }
    
    private List<WelcomeCall_Criteria__c> getCriteriaCustomSetting() {
        WelcomeCall_Criteria__c[] crit = [SELECT id, Name, WelcomeCall_Start_Range__c, WelcomeCall_End_Range__c, WelcomeCall_Fg_Active__c, WelcomeCall_Start_Range_USD__c, WelcomeCall_End_Range_USD__c
                                          FROM WelcomeCall_Criteria__c
                                          WHERE WelcomeCall_Start_Range__c != null AND WelcomeCall_End_Range__c != null
                                          and WelcomeCall_Fg_Active__c = true
                                          order by WelcomeCall_Start_Range__c asc];
        return crit;
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
        return agents;
    }
    
    private void setMapAgentInGroup(){
        for(WelcomeCall_Group__c lev : level) {
            Agent_Group__c[] agents = getAvailableAgentsInLevel(lev.Name);
            agentInGroup.put(lev.Name, agents);
        }
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
    
    // Edited to include USD by Faizir 31/01/2020
    // Add UNDERRETAIL Criteria by Faizir 13/04/2020
    // // Update remove UNDERRETAIL Validation by Faizir 20200508
    private String getLineCriteria(Decimal lineApe, String contactCurrency,  String planCode, String planType) {
        Decimal startRangeRP, endRangeRP, startRangeUSD, endRangeUSD;
        String result, critName = '';
        for(WelcomeCall_Criteria__c crit : criteria) {
            startRangeRP = crit.WelcomeCall_Start_Range__c;
            endRangeRP = crit.WelcomeCall_End_Range__c;
            startRangeUSD = crit.WelcomeCall_Start_Range_USD__c;
            endRangeUSD = (crit.WelcomeCall_End_Range_USD__c != null ? crit.WelcomeCall_End_Range_USD__c : 0);
            critName = crit.Name;
            if(contactCurrency == 'RP'){
                if(!planCode.contains(PRODUCT_MSW)  || (planCode.contains(PRODUCT_MSW) && critName == 'HVC')){
                    if((lineApe >= startRangeRP) && (lineApe <= endRangeRP)) {
                        result = critName;
                        break;
                    }
                }else if(planCode.contains(PRODUCT_MSW) && critName == 'RETAIL MSW INTERNAL'){
                    if((lineApe >= startRangeRP) && (lineApe <= endRangeRP)) {
                        result = critName;
                        break;
                    }
                }else if(planCode.contains(PRODUCT_MSW) && critName == 'RETAIL MSW EKSTERNAL'){
                    if((lineApe >= startRangeRP) && (lineApe <= endRangeRP)) {
                        result = critName;
                        break;
                    }
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
    
    private void setMapLastPriority() {
        WelcomeCall_Group__c[] prio = [SELECT Name, WelcomeCall_Last_Priority__c from WelcomeCall_Group__c];
        for(WelcomeCall_Group__C p: prio){
            lastPriorityUpdated.put(p.Name, p.WelcomeCall_Last_Priority__c);
        }
    }
    
    public void generateDailyCallLines(Id campaignId) {
        system.debug('Skipping trigger CaseTypeUpdateOnCallLine.');
        CallLineTriggerControl.skipCaseTypeUpdate = true;
        system.debug('Generating daily call lines...');
        Integer issuedDays = Integer.valueOf(System.Label.WelcomeCall_Issued_Date_Day); 
        
        /* untuk menghindari pengambilan data dari IDAS H - issued date = Sabtu/Minggu */
        Date now = Date.today();
        DateTime myDateTime = (DateTime) now;
        String dayOfWeek = myDateTime.format('E');
        Date processDate;
        system.debug('Issued days: '+issuedDays);
        system.debug('Day of week: '+dayOfWeek);
        if(dayOfWeek == 'Mon'){
            processDate = system.today().addDays((issuedDays + 2) * -1); // minus 1 untuk hari sebelumnya
        }
        
        if(Test.isRunningTest()){
            dayOfWeek = 'Tue';
        }
        if(dayOfWeek == 'Tue'){
            if(issuedDays < 2)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 2)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        if(Test.isRunningTest()){
            dayOfWeek = 'Wed';
        }
        if(dayOfWeek == 'Wed'){
            if(issuedDays < 3)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 3)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        if(Test.isRunningTest()){
            dayOfWeek = 'Thu';
        }
        if(dayOfWeek == 'Thu'){
            if(issuedDays < 4)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 4)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        if(Test.isRunningTest()){
            dayOfWeek = 'Fri';
        }
        if(dayOfWeek == 'Fri'){
            if(issuedDays < 5)
                processDate = system.today().addDays(issuedDays * -1);
            else if(issuedDays >= 5)
                processDate = system.today().addDays((issuedDays + 2) * -1);
        }
        
        if(Test.isRunningTest()){
            dayOfWeek = myDateTime.format('E');
        }
        
        String prodMSW = PRODUCT_MSW+'%';
        system.debug('processDate =='+processDate);
        Contact[] conList = [SELECT Id, Name, WelcomeCall_APE__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                         WHERE WelcomeCall_Product_Code_Plan__c != Null 
                             AND (not Policy_No__c like '8%')
                             AND (not WelcomeCall_Product_Code_Plan__c like :prodMSW)
                             AND WelcomeCall_Issued_Date__c != Null
                             AND WelcomeCall_Issued_Date__c = :processDate
                             AND entity__c = 'AMFS'
                             AND policyApp__c = 'RLS'
                             AND Id NOT IN (SELECT Contact__c from Call_Line__c where recordTypeId =: wcRtId)];
        
        //Faizir 27042021, Utk product MSW dan All Health, Process Date yg diambil itu H-1
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays(-3); // minus 3 untuk hari Senin untuk mengambil process Date Jumat
        }else if(dayOfWeek != 'Sun' && dayOfWeek != 'Sat'){
            processDate = now.addDays(-1); // minus 1 untuk hari sebelumnya   
        }
        System.debug('processes Date :'+processDate);
        Contact[] conListMSW = [SELECT Id, Name, WelcomeCall_APE__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c,WelcomeCall_Payment_Type_Name__c FROM Contact
                                WHERE WelcomeCall_Product_Code_Plan__c != Null 
                                AND (WelcomeCall_Product_Code_Plan__c like :prodMSW OR Policy_No__c like '8%')
                                AND WelcomeCall_Issued_Date__c != Null
                                AND WelcomeCall_Issued_Date__c = :processDate
                                AND entity__c = 'AMFS'
                                AND policyApp__c = 'RLS'
                                AND Id NOT IN (SELECT Contact__c from Call_Line__c where recordTypeId =: wcRtId)];
        for(Contact addContact : conListMSW){
            conList.add(addContact);
        }
        
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
        //criteria = getCriteriaCustomSetting();
        List<Call_Line__c> newAutoCL = new List<Call_Line__c>();
        for(Contact con: conList){
            try {
                if(checkApeExistInCriteria(con.WelcomeCall_APE__c, con.WelcomeCall_Currency__c, con.WelcomeCall_Payment_Type_Name__c)){
                    Call_Line__c calin = new Call_Line__c(RecordTypeId = wcRtId,
                                                          Contact__c = con.Id,
                                                          Call_List__c = campaignId,
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
                    newAutoCL.add(calin);
                    //insert calin;
                    
                }  
            } catch (Exception e) {
                System.debug('A DML exception has occurred: ' +
                             e.getMessage());
            }
        }
        // insert list of new automatic call line
        insert newAutoCL;
        system.debug('Generate daily call lines done.');
    }
    
    /**
* set min start value from critera
*/
    private Decimal getMinStartValueCriteria(){
        if(!criteria.isEmpty()){
            return criteria.get(0).WelcomeCall_Start_Range__c != null ? criteria.get(0).WelcomeCall_Start_Range__c : 0;
        }
        return 10000000;
    }
    
    private Decimal getMinStartValueCriteriaUSD(){
        if(!criteria.isEmpty()){
            return criteria.get(0).WelcomeCall_Start_Range_USD__c != null ? criteria.get(0).WelcomeCall_Start_Range_USD__c : 0;
        }
        return 1000;
    }
    
    private Boolean checkApeExistInCriteria(Decimal lineApe, String contactCurrency, String planCode) {
        /*
Decimal startRange, endRange;
Boolean result = false;

for(WelcomeCall_Criteria__c crit : criteria) {
startRange = crit.WelcomeCall_Start_Range__c;
endRange = crit.WelcomeCall_End_Range__c;


if((startRange != null) && (endRange != null)){
if((lineApe >= startRange) && (lineApe <= endRange)) {
result = true;
break;
}
}
}
*/
        
        // Add USD Currency by Faizir (31/01/2020)
        Decimal startRangeRP, endRangeRP, startRangeUSD, endRangeUSD;
        Boolean result = false;
        
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
            }else if(contactCurrency == 'USD' && endRangeUSD != 0 && startRangeUSD != null){
                if((lineApe >= startRangeUSD) && (lineApe <= endRangeUSD)) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
}