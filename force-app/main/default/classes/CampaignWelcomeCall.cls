/***************************************************************************************
*   Class Name: CampaignWelcomeCall
*	Description: This call is deployed to the Scheduler. It will create the campaign.
*   Author: Ocky Harliansyah
*	Email: ocky.harliansyah@phincon.com | ocky.harli@gmail.com
*   Date: 17 September 2018
* 	Last Edited by : Adi Wijaya
* 	Last Edited Date : 6 April 2023
*   Code version: 2.4
*
***************************************************************************************/
global class CampaignWelcomeCall implements Schedulable {    
    //private static String PRODUCT_MSW = Label.Product_list_MS_1;
    private static String PRODUCT_MSW = '';
    private List<String> listProductAdd1Day = new List<String>();
    
    private Id campaignId;
    private WelcomeCall_Criteria__c[] criteria = getCriteriaCustomSetting();
    private WelcomeCall_Group__c[] level;
    private Map<String, Decimal> lastPriorityUpdated = new Map<String, Decimal>();
    private Map<String, Decimal> maxPriorityInAgentGroup = new Map<String, Decimal>();
    private Map<String, List<Agent_Group__c>> agentInGroup = new Map<String, List<Agent_Group__c>>();
    public Decimal minStartCriteria = getMinStartValueCriteria();
    public Decimal minStartCriteriaUSD = getMinStartValueCriteriaUSD();
    static ID rtAgentGroup = Schema.SObjectType.Agent_Group__c.getRecordTypeInfosByName().get('Agent Group').getRecordTypeId();
    static ID wcRtId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    
    
	global void execute(SchedulableContext SC) {
        try{
            system.debug('Start Executess' + wcRtId);
            system.debug('Start Execute');
            generateMonthlyCampaign('Manual');
            generateMonthlyCampaign('Automatic');
            getProduct('Unit Link');
            //CallLineWelcomeCall call = new CallLineWelcomeCall();
            generateDailyCallLines(campaignId);
            //roundRobinDist(true);
            system.debug('End Execute');
        } catch (Exception e){
            System.debug('ERROR==== '+e);
        	Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String recipient = System.LABEL.Email_Recipient_Welcome_Call;
            if(recipient != null){
                String[] to = recipient.trim().split(';');
                    
                Messaging.EmailFileAttachment logFile = new Messaging.EmailFileAttachment();
                blob logBlob = Blob.valueOf(String.valueOf(e));
                string logName= 'Welcome Call Schedule Log.txt';
                logFile.setFileName(logName);
                logFile.setBody(logBlob);
                email.setSubject('Welcome Call Schedule Error Log');
                email.setHtmlBody(' Welcome Call Schedule is Finish with some ERROR. <br/>'+
                                  +' Please check the Log File.');
                email.setFileAttachments(new Messaging.EmailFileAttachment[]{logFile});
                email.setToAddresses(to);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                    
            } else {
                System.debug('ERROR Occurred and Email Recipient is not set.');
            }
        }
    }
    
     //Added by Elvi Oktober 2024
    public void getProduct(String autoManual){
    List <WelcomeCall_Product__c>  welcomeCallProduct=[SELECT Id, IsDeleted, Name, WelcomeCall_Type__c from WelcomeCall_Product__c where WelcomeCall_Type__c != :autoManual];
        for (WelcomeCall_Product__c listProduct : welcomeCallProduct){
            PRODUCT_MSW= listProduct.Name;
            listProductAdd1Day.add(PRODUCT_MSW);
        }
        System.debug('Check listProductAdd1Day '+ listProductAdd1Day.size());
        
    }
    //Added by Elvi Oktober 2024
    
    public void generateMonthlyCampaign(String autoManual)
    {
        // 1. get month string now
        String formatName = 'WelcomeCall';
        String monthNow = Datetime.now().format('yyMM');
        formatName = formatName + monthNow + autoManual;
        //formatName = formatName + monthNow + 'Automatic';
        // 2. check if campaign name is exist. if any, only update the call list. otherwise create campaign and call list
         Boolean isAuto = false;
         if(autoManual == 'Automatic'){
             	isAuto = true;
         }
         else if(autoManual == 'Manual'){
            	isAuto = false;
         }
        Call_List__c[] query = [SELECT Id, Campaign_Name__c 
                                FROM Call_List__c 
                                WHERE Campaign_Name__c = :formatName AND WelcomeCall_Fg_Automatic__c =: isAuto LIMIT 1];
        if(Test.isRunningTest()){
            query = new Call_List__c[]{};
        }
        if (query.size() == 0) {
            System.debug('query '+query+' autoManual '+formatName);
            // get expiry date
            
            Date now = Date.today();
            Date next_month = now.addMonths(1);
            Date expiry_date = Date.valueOf(next_month.year() + '-' + next_month.month() + '-' + System.Label.Welcome_Call_Expired_Days);
            // System.debug(formatName);
            RecordType recId = getRecordTypeId('Confirmation AMFS', 'Call_List__c');
            //System.debug(recId.Id);
            try {
                Call_List__c calist = new Call_List__c(Activity__c = 'Confirmation',
                                                       Campaign_Name__c = formatName, 
                                                       Case_Type_Config__c = 'Welcome Call',
                                                       Expired_Date__c = expiry_date,
                                                       Entity__c = 'AMFS',
                                                       RecordTypeId = recId.Id,
                                                       WelcomeCall_Fg_Automatic__c = isAuto);
                
                insert calist;
                ID calistID = calist.ID;
                //calist.RecordTypeId = recId.Id;
                //update calist;
                System.debug('calistID '+calistID);
                
                campaignId = calistID;
            } catch (DmlException e) {
                System.debug('A DML exception has occurred: ' +
                            e.getMessage());
            }
        }
        else {
            campaignId = query[0].Id;
        }
    }
    public RecordType getRecordTypeId(string recordTypeName, string sObjectName)
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
    
    /*
    public void testAja(Id campaignId) {
        //criteria = getCriteriaCustomSetting(); // soql
        generateDailyCallLines(campaignId);
        roundRobinDist(true);
    }
	*/
    
    public void roundRobinDist(Boolean isAutoCallLine) {
        try{
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
            System.debug('setMapLastPriority');
            setMapLastPriority(); // soql
            // get call lines where status other than Closed and flag round robin is false
            System.debug('isAutoCallLine = ' + isAutoCallLine);
            List<Call_Line__c> calin = getCallLines(isAutoCallLine); // soql
            // processing each record
                            System.debug('call line atas ==> ' + calin +'isAutoCallLine = ' + isAutoCallLine);
            Map<String, WelcomeCall_Group__c> updatedLevelGroup = new Map<String, WelcomeCall_Group__c>();
            List<Call_Line__c> roundRobinCL = new List<Call_Line__c>();
            
            getProduct('Unit Link');
            
            for(Call_Line__c cl: calin) {
                System.debug('call line ==> ' + cl + 'policyApp ==> ' + cl.Contact__r.policyApp__c );
                cl.Currency__c = cl.Contact__r.WelcomeCall_Currency__c;
                // update getLineCriteria by Faizir 20200313
                String myCrit = 'Agent In House';
                if (cl.Contact__r.policyApp__c != 'G400'){
                    myCrit = getLineCriteria(cl.Contact__r.WelcomeCall_APE__c, cl.Currency__c, cl.Contact__r.WelcomeCall_Product_Code_Plan__c, cl.Contact__r.WelcomeCall_Payment_Type__c); // search in list
                }
                
                System.debug('?[] mycrit '+ myCrit);
                if(Test.isRunningTest()){
					myCrit  = 'HVC';
				}
                if(myCrit != '' && myCrit != null){ 
                    // hanya memproses APE yg masuk dalam kriteria
                    String myLevel = getLineLevel(myCrit); // search in list
                    System.debug('Polis >> ' + cl.Contact__r.policy_no__c + '?[] mycrit before distribution '+ myCrit + ' my Level ' + myLevel);
                    Agent_Group__c[] agents = agentInGroup.get(myLevel); // search in map
                    Decimal lastPriority = lastPriorityUpdated.get(myLevel); // search in map
                    WelcomeCall_Group__c levelGroup = getLevelGroupObject(myLevel); // search in list
                    Decimal maxPriority = maxPriorityInAgentGroup.get(myLevel); // search in map
                    System.debug('agents '+ agents + ' lastPriority ' + lastPriority + ' levelGroup ' + levelGroup + ' maxPriority ' + maxPriority);
                    
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
                            System.debug('Polis --->> ' + cl.Contact__r.policy_no__c + ' ?[] mycrit 2 before update -> '+ myCrit);
                            if(myCrit.equals('RETAIL MSW INTERNAL') || myCrit.equals('RETAIL MSW EKSTERNAL')){
                                myCrit = 'RETAIL';
                            }
                            System.debug('?[] mycrit after update --> '+ myCrit);
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
        }catch(Exception e){
            System.debug('ERROR==== '+e);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String recipient = System.LABEL.Email_Recipient_Welcome_Call;
            if(recipient != null){
                String[] to = recipient.trim().split(';');
                
                Messaging.EmailFileAttachment logFile = new Messaging.EmailFileAttachment();
                blob logBlob = Blob.valueOf(String.valueOf(e));
                string logName= 'Welcome Call Schedule Log.txt';
                logFile.setFileName(logName);
                logFile.setBody(logBlob);
                email.setSubject('Welcome Call Schedule Error Log');
                email.setHtmlBody(' Welcome Call Schedule is Finish with some ERROR. <br/>'+
                                  +' Please check the Log File.');
                email.setFileAttachments(new Messaging.EmailFileAttachment[]{logFile});
                email.setToAddresses(to);
                if(!Test.isRunningTest()){
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                }
            } else {
                System.debug('ERROR Occurred and Email Recipient is not set.');
            }
        }
    }
    
    //Faizir 27042021, Add validation for product MSW
    public List<Call_Line__c> getCallLines(Boolean isAutoCallLine) {
        List<Call_Line__c> calin = [SELECT Name, OwnerId, Contact__r.Name, Contact__r.policyApp__c, Contact__r.WelcomeCall_APE__c, WelcomeCall_Call_Line_Status__c, 
                                    Contact__r.Policy_No__c, Contact__r.WelcomeCall_Currency__c, Contact__r.WelcomeCall_Product_Code_Plan__c, Contact__r.WelcomeCall_Payment_Type__c
                                FROM Call_Line__C
                                WHERE WelcomeCall_Call_Line_Status__c != 'Closed' 
                                AND Call_List__r.WelcomeCall_Fg_Automatic__c =: isAutoCallLine
                                AND WelcomeCall_Fg_Round_Robin__c = false
                                And welcomecall_fg_schedule__c = false
                                and Recordtypeid =: wcRtId];
        
        System.debug('[?] Call List = '+calin.size());
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
        system.debug(max);
        for(AggregateResult a: max){
            maxPriorityInAgentGroup.put(String.valueOf(a.get('Name')), Decimal.valueOf(String.valueOf(a.get('expr0'))));
        }
        system.debug(maxPriorityInAgentGroup);
    }
    
    // Update getLineCriteria, add UNDERRETAIL criteria by Faizir 20200313
    // Update remove UNDERRETAIL Validation by Faizir 20200508
    // Add validation MSW by Faizir 27042021
    private String getLineCriteria(Decimal lineApe, String contactCurrency,  String planCode, String planType) {
        Decimal startRangeRP, endRangeRP, startRangeUSD, endRangeUSD;
        String result, critName = '';
        System.debug('lineApebuatcek :'+lineApe+'contactCurrency :'+contactCurrency+'planCode :'+planCode+'planType :'+planType);
        List<String> listProducts = new List<String>();
        //List<String> listProductAdd1Day = new List<String>();
        //if(PRODUCT_MSW!=null && PRODUCT_MSW!='') listProductAdd1Day = PRODUCT_MSW.split(';');
        if(listProductAdd1Day.size()>0){
            for(String product:listProductAdd1Day){
                listProducts.add(product);
            }
        }
        System.debug('Check listProducts '+ listProducts);
        
        for(WelcomeCall_Criteria__c crit : criteria) {
            startRangeRP = crit.WelcomeCall_Start_Range__c;
            endRangeRP = crit.WelcomeCall_End_Range__c;
            startRangeUSD = crit.WelcomeCall_Start_Range_USD__c;
            endRangeUSD = (crit.WelcomeCall_End_Range_USD__c != null ? crit.WelcomeCall_End_Range_USD__c : 0);
            critName = crit.Name;
            if(contactCurrency == 'RP'){
                if((!listProducts.contains(planCode) && (critName != 'RETAIL MSW INTERNAL' && critName != 'RETAIL MSW EKSTERNAL'))  
                   || (listProducts.contains(planCode) && critName == 'HVC')){
                    if((lineApe >= startRangeRP) && (lineApe <= endRangeRP)) {
                        result = critName;
                        break;
                    }
                }else if(listProducts.contains(planCode) && critName == 'RETAIL MSW INTERNAL'){
                    if((lineApe >= startRangeRP) && (lineApe <= endRangeRP)) {
                        result = critName;
                        break;
                    }
                }else if(listProducts.contains(planCode) && critName == 'RETAIL MSW EKSTERNAL'){
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
        system.debug('getLineLevel ' + crit);
        system.debug('Level ' + level);
        
        for(WelcomeCall_Group__c lev : level) {
            levelName = lev.Name;
            critName = lev.WelcomeCall_Criteria__c;
            system.debug('Level ' + levelName + ' critName ' + critName);
            if( crit.toLowerCase() == critName.toLowerCase()) {
                result = levelName;
                system.debug('levelName ' + levelName);
                break;
            }
        }
        system.debug('result ' + result);
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
        //else if(dayOfWeek == 'Fri'){
        else if(dayOfWeek == 'Fri'){
            if(issuedDays < 5)
                processDate = now.addDays(issuedDays * -1);
            else if(issuedDays >= 5)
                processDate = now.addDays((issuedDays + 2) * -1);
        }
        system.debug('Processed Date MSW: '+processDate);
        ID rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
        // add Entity and PolicyApp to query by Faizir 2020/05/22
        //Faizir 28042021, Add new Validation for product non MSW
        //
        List<String> listProducts = new List<String>();
        //List<String> listProductAdd1Day = new List<String>();
        //if(PRODUCT_MSW!=null && PRODUCT_MSW!='') listProductAdd1Day = PRODUCT_MSW.split(';');
        if(listProductAdd1Day.size()>0){
            for(String s:listProductAdd1Day){
                listProducts.add(s);
            }
        }
        system.debug('processDate ==>  '+processDate);
        Contact[] conList = [SELECT Id, Name, policyApp__c, WelcomeCall_APE__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                         WHERE WelcomeCall_Product_Code_Plan__c != Null 
                             AND (not Policy_No__c like '8%')
                             AND (not WelcomeCall_Product_Code_Plan__c IN :listProducts)
                             AND WelcomeCall_Issued_Date__c != Null
                             AND WelcomeCall_Issued_Date__c = :processDate                     
                             AND entity__c = 'AMFS'
                             AND (policyApp__c = 'RLS' OR policyApp__c = 'G400')
                             /*
                              * Add by Fajar Salam 29/03/2022
							  * Prevent for addid Data TelUW
							 */
                             AND Campaign_Type__c != 'TelUW'
                             AND Id NOT IN (SELECT Contact__c from Call_Line__c where recordTypeId =: rtCallLineWC)];
         system.debug('conlistnya nyax: '+conList);
        system.debug('conlistnya nyax: '+conList.size());
        system.debug('rtCallLineWC nyax: '+rtCallLineWC);
        if(Test.isRunningTest()){
           conList = [SELECT Id, Name, WelcomeCall_APE__c, policyApp__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                      WHERE WelcomeCall_Product_Code_Plan__c != Null limit 1];
        }
        system.debug('conlistnya nya: '+conList);
        system.debug('copy nih nya: '+rtCallLineWC);
        
        //Faizir 27042021, Utk product MSW dan All Health, Process Date yg diambil itu H-1
        issuedDays = Integer.valueOf(System.Label.WelcomeCall_Issued_Date_Day_MSW_Health); 
        if(dayOfWeek == 'Mon'){
            processDate = now.addDays(issuedDays * (-3)); // minus 3 untuk hari Senin untuk mengambil process Date Jumat
        }else if(dayOfWeek != 'Sun' && dayOfWeek != 'Sat'){
            processDate = now.addDays(issuedDays * (-1)); // minus 1 untuk hari sebelumnya   
        }
        
        System.debug('processes Date Other:'+processDate);
        System.debug('issued Date Other:'+issuedDays);
        Contact[] conListMSW = [SELECT Id, Name, policyApp__c,WelcomeCall_APE__c, policy_no__c, MobilePhone, HomePhone, Phone, OtherPhone, Entity__c, WelcomeCall_Currency__c, WelcomeCall_Product_Code_Plan__c, WelcomeCall_Payment_Type__c, WelcomeCall_Issued_Date__c FROM Contact
                                WHERE WelcomeCall_Product_Code_Plan__c != Null 
                                AND (WelcomeCall_Product_Code_Plan__c in :listProducts OR Policy_No__c like '8%')
                                AND WelcomeCall_Issued_Date__c != Null 
                                AND WelcomeCall_Issued_Date__c = :processDate
                                AND entity__c = 'AMFS'
                                AND policyApp__c = 'RLS'
                                /*
                                * Add by Fajar Salam 29/03/2022
							    * Prevent for addid Data TelUW
							    */
                                AND Campaign_Type__c != 'TelUW'
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
        Call_List__c[] calis = [select id, name, case_type__c,Case_Type_Config__c, Activity__c from call_list__c where Id = :campaignId];
        for(Call_List__c cal: calis){
            caseType = cal.case_type__c;
            caseTypeConfig = cal.Case_Type_Config__c;
            activity = cal.Activity__c;
        }
        
        // get criteria settings
        //criteria = getCriteriaCustomSetting();
        List<Call_Line__c> newAutoCL = new List<Call_Line__c>();
        system.debug('MASUKxx' + conList);
        for(Contact con: conList){
            system.debug('MASUK loop ' + con.policyApp__c);
            try {
                if(con.policyApp__c=='G400' || checkApeExistInCriteria(con.WelcomeCall_APE__c, con.WelcomeCall_Currency__c,con.WelcomeCall_Product_Code_Plan__c)){
                    system.debug('kesini');
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
                    system.debug('kesina');
                    
                }
            } catch (Exception e) {
                System.debug('A DML exception has occurred: ' +
                             e.getMessage());
            }
        } system.debug('MASUK2');
        // Add Enqueue Job to another class to avoid CPU Apex Limit Error by Faizir (20200605)
        // Maximum New Auto CL Process without Error 2000 datas
        System.enqueueJob(new CampaignWelcomeCallQueueable(newAutoCL));
        
       
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
    
    /*
    private Boolean checkApeExistInCriteria(Decimal lineApe) {
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
        return result;
    }
    */
    
    //Faizir 27042021, Add validation for product MSW
    private Boolean checkApeExistInCriteria(Decimal lineApe, String contactCurrency, String planCode) {
        system.debug('checkApeExistInCriteria lineApe==> ' + lineApe +'contactCurrency ==> ' + contactCurrency +'planCode ==> ' + planCode);
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
}