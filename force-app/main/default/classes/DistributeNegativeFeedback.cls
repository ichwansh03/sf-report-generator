global with sharing class DistributeNegativeFeedback implements Schedulable, Database.Batchable<sObject>{
    global void execute(SchedulableContext sc) { 
        // To start the batch job: 
        Database.executeBatch(new DistributeNegativeFeedback(), 200);
    }
    
    private final datetime currDatetime = System.Now();
    
    /* global Iterable<sObject> start(Database.BatchableContext bc){
List<Id> surveyIds = new List<Id>();
List<Survey__c> getListSurvey = [Select id from Survey__c where recordType.name = 'Master Qualtrics'];
for (survey__c row : getListSurvey) {
surveyIds.add(row.id);
}

date currentDate = System.Today();
List<Negative_Feedback__c> data = new List<Negative_Feedback__c> ();
if (System.test.isRunningTest() ){

data = [
Select id, contact__c, contact__r.Name, contact__r.email, ownerId, First_Owner__c,
contact__r.phone,contact__r.MobilePhone,contact__r.policy_no__c,case__c, case__r.mot__c, Due_Date__c
from Negative_Feedback__c  
order by contact__r.policy_no__c ASC, contact__r.email asc, contact__r.phone asc
LIMIT 5000
];
} else {
data = [
Select id, contact__c, contact__r.Name, contact__r.email, ownerId, First_Owner__c,
contact__r.phone,contact__r.MobilePhone,contact__r.policy_no__c,case__c, case__r.mot__c, Due_Date__c
from Negative_Feedback__c 
where  Survey_Form__c != null
AND Survey_Form__c in :surveyIds
and case__c != null AND case__r.mot__c  != null
and contact__c != null
// and case__c = null 
and Follow_Up_ICF__c < 1
and Call_Status__c != null
// and Call_Status__c = null
// and Test_No__c='1'
AND (Due_Date__c = null or Due_Date__c < :currentDate)
order by contact__r.policy_no__c ASC, contact__r.email asc, contact__r.phone asc
LIMIT 5000
];
}
return data;
} */
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        
        String RTTeleServiceCallLine =  Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TeleService').getRecordTypeId();
        String caseTypeComplain = System.label.Case_Type_Complain;
        date currentDate = System.Today();
        List<Call_Line__c> data = new List<Call_Line__c> ();
        if (System.test.isRunningTest() ){ 
            data = [
                Select id,contact__c, contact__r.Name, contact__r.email, ownerId, First_Owner__c, Agent__c,
                contact__r.phone,contact__r.MobilePhone,contact__r.policy_no__c,case__c, case__r.mot__c, Due_Date__c, Priority__c
                from Call_Line__c  
                order by contact__r.email asc nulls Last, contact__r.phone asc nulls Last, contact__r.policy_no__c ASC
                LIMIT 5000
            ];
        } else {
            data = [
                Select id,contact__c, contact__r.Name, contact__r.email, ownerId, First_Owner__c,Agent__c,
                contact__r.phone,contact__r.MobilePhone,contact__r.policy_no__c,case__c, case__r.mot__c, Due_Date__c, Priority__c
                from Call_Line__c 
                where  recordtypeid=:RTTeleServiceCallLine
                and case__c != null AND case__r.mot__c  != null
                and Activity_Result__c = null
                and Follow_Up_ICF__c < 1
                // and Priority__c= 'Yes' 
                // and createddate = today
                AND Case_Type__c != :caseTypeComplain
                AND (Due_Date__c = null or Due_Date__c < :currentDate) 
                order by contact__r.email asc nulls Last, contact__r.phone asc nulls Last, contact__r.policy_no__c ASC
                LIMIT 5000
            ];
        }
        return data;
    }
    
    
    /* global void execute(Database.BatchableContext BC, List<Negative_Feedback__c> data){
List<Group> dataGroup = [SELECT Id, Name FROM Group where name = 'AMFS - Tele Service Queue'];
List<User_detail__c> getDetailUser = [Select id, User__c from User_detail__c 
where recordtype.name = 'User Detail Qualtrics AMFS' AND User__c != null 
and user__r.isactive = true and Active__c = true and User__r.LastLoginDate  = today
];        
if (data.size() > 0 && getDetailUser.size() > 0 && dataGroup.size() > 0){

// Calculate the number of cases per agent
Integer totalData = data.size();
Integer totalUser = getDetailUser.size();
List<Integer> dataPerAgent = new List<Integer>(); 

for (Integer i = 0; i < totalUser; i++) {
Integer num = totalData / totalUser;
Integer sisaPembagian = Math.mod(totalData, totalUser);
if (sisaPembagian > i) {
num++;
}
dataPerAgent.add(num);
}


// checking due date
integer targetDuedate = Integer.valueof(System.Label.due_date_negative_Feedback);
Date currDate = System.Today();             
Date dueDate = currDate.addDays(targetDuedate); 
Datetime dueDateTime = currDate.addDays(targetDuedate);   
System.debug('dueDate:'+dueDate);
List<Master_Holiday__c> mstHoliday = [SELECT Id, End_Date_Time__c, Active_Date__c  FROM Master_Holiday__c where Active_Date_F__c > TODAY AND Type__c = 'Holiday' AND Entity__c = 'AMFS' ORDER by Active_Date_F__c DESC];
for (Master_Holiday__c row : mstHoliday) {
DateTime endDateTime = row.End_Date_Time__c; 
Date endDate = date.valueof(endDateTime);
System.debug('endDate:'+endDate);
if (endDate <= dueDate && endDateTime.format('E') != 'Sat' && endDateTime.format('E') != 'Sun') {
targetDuedate++;
dueDateTime = dueDateTime.addDays(1);
}
}
System.debug('targetDuedate:'+targetDuedate);   
System.debug('dueDateTime:'+dueDateTime);         
while(dueDateTime.format('E') == 'Sat' || dueDateTime.format('E') == 'Sun'){
targetDuedate++;
dueDateTime = dueDateTime.addDays(1);  
} 
dueDate = dueDateTime.date();
System.debug('targetDuedate:'+targetDuedate);
System.debug('dueDate:'+dueDate);

Map<String, List<Negative_Feedback__c>> groupingByEmail = new Map<String, List<Negative_Feedback__c>>();
Map<String, List<Negative_Feedback__c>> groupingByPhone = new Map<String, List<Negative_Feedback__c>>();
Map<String, List<Negative_Feedback__c>> groupingByMobilePhone = new Map<String, List<Negative_Feedback__c>>();
Map<String, List<Negative_Feedback__c>> groupingByPolicy = new Map<String, List<Negative_Feedback__c>>();
for(Negative_Feedback__c row: data) { 
List<Negative_Feedback__c> dataEmail = new List<Negative_Feedback__c>();
List<Negative_Feedback__c> dataPhone = new List<Negative_Feedback__c>();
List<Negative_Feedback__c> dataMobilePhone = new List<Negative_Feedback__c>();
List<Negative_Feedback__c> dataPolicy = new List<Negative_Feedback__c>();

if (string.isnotblank(row.contact__r.email)) { 
string key = row.contact__r.email;
if (groupingByEmail.containskey(key)) {
dataEmail = groupingByEmail.get(key);
}
dataEmail.add(row);      
groupingByEmail.put(key, dataEmail);
}


if (string.isnotblank(row.contact__r.MobilePhone)) { 
string key = row.contact__r.MobilePhone;
if (groupingByMobilePhone.containskey(key)) { 
dataMobilePhone = groupingByMobilePhone.get(key);
}
dataMobilePhone.add(row);          
groupingByMobilePhone.put(key, dataMobilePhone);
}


if (string.isnotblank(row.contact__r.phone)) { 
string key = row.contact__r.phone;
if (groupingByPhone.containskey(key)) { 
dataPhone = groupingByPhone.get(key);
}
dataPhone.add(row);          
groupingByPhone.put(key, dataPhone);
}


if (string.isnotblank(row.contact__r.policy_no__c)) { 
string key = row.contact__r.policy_no__c;
if (groupingByPolicy.containskey(key)) { 
dataPolicy = groupingByPolicy.get(key);
}
dataPolicy.add(row);          
groupingByPolicy.put(key, dataPolicy);
}  
} 

Map<String,list<Negative_Feedback__c>> groupingNegativeFeedback = new Map<String,list<Negative_Feedback__c>>();

if (groupingByEmail.size() > 0) {
for (string email: groupingByEmail.keySet()) {
string parentId = groupingByEmail.get(email)[0].Id;
List<Negative_Feedback__c> setNegative = groupingByEmail.get(email);
groupingNegativeFeedback.put(parentId, setNegative);
}
}

system.debug('groupingNegativeFeedback:'+groupingNegativeFeedback);

if (groupingByPhone.size() > 0) {
for (string phone: groupingByPhone.keySet()) {
string parentId = groupingByPhone.get(phone)[0].Id;
List<Negative_Feedback__c> setNegative = groupingByPhone.get(phone);
if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
groupingNegativeFeedback.put(parentId, setNegative);
}
}

if (groupingByMobilePhone.size() > 0) {
for (string Mobilephone: groupingByMobilePhone.keySet()) {
string parentId = groupingByMobilePhone.get(Mobilephone)[0].Id;
List<Negative_Feedback__c> setNegative = groupingByMobilePhone.get(Mobilephone);
if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
groupingNegativeFeedback.put(parentId, setNegative);
}
}

if (groupingByPolicy.size() > 0) {
for (string policy: groupingByPolicy.keySet()) {
string parentId = groupingByPolicy.get(policy)[0].Id;
List<Negative_Feedback__c> setNegative = groupingByPolicy.get(policy);
if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
groupingNegativeFeedback.put(parentId, setNegative);
}
}


Map<string, Negative_Feedback__c> mapNegativeFeedback = new Map<string, Negative_Feedback__c>();
map<string, integer> totalPerAgent = new map<string, integer>();
map<string, List<Negative_Feedback__c>> dataUserDetail = new map<string, List<Negative_Feedback__c>>();

system.debug('dataPerAgent:'+dataPerAgent);
integer numAgent = 0;
for (String rowId: groupingNegativeFeedback.keySet()) {  
integer countagent = dataPerAgent[numAgent];
string agentId = getDetailUser[numAgent].User__c ; 
integer totalNegativeByAgent = 1;
integer totalDataPerAgent = 1;

system.debug('1. agentid:'+agentId+', total data = '+ totalDataPerAgent);

string currOwnerId = groupingNegativeFeedback.get(rowId)[0].ownerId;

system.debug('numAgent:'+numAgent);

if (currOwnerId == agentId) { 
numAgent++;

if (numAgent >= dataPerAgent.size()) {
numAgent = 0;
}
countagent = dataPerAgent[numAgent];
agentId = getDetailUser[numAgent].User__c ; 
}  

if (totalPerAgent.containsKey(agentId)) {
totalNegativeByAgent = totalPerAgent.get(agentId); 
system.debug('2.1. agentid:'+agentId+', total data:'+ totalDataPerAgent);
String AgentFirst = getDetailUser[numAgent].User__c;

Integer loopAgent =  0; 
while(totalNegativeByAgent > countagent) { 

if (loopAgent > 0 && AgentFirst == agentId) {
totalPerAgent.put(agentId, 0);
break;
}

if (totalPerAgent.containsKey(agentId)) { 
totalNegativeByAgent = totalPerAgent.get(agentId);
if (totalNegativeByAgent < countagent) break;
}

numAgent++; 
if (numAgent >= dataPerAgent.size()) {
numAgent = 0;
}
countagent = dataPerAgent[numAgent];
agentId = getDetailUser[numAgent].User__c ; 

loopAgent++;

}  
}      


system.debug('agentId:'+agentId);

List<Negative_Feedback__c> dataNegativeFeedback = new List<Negative_Feedback__c>();
if (dataUserDetail.containsKey(agentId)) {
dataNegativeFeedback.addAll(dataUserDetail.get(agentId));
}

for(Negative_Feedback__c row : groupingNegativeFeedback.get(rowId)) {
string dataId = row.id;
if (!mapNegativeFeedback.containsKey(dataId)) {
row.OwnerId = agentId; 
row.Due_Date__c = dueDate;
row.Distribution_Date_Time__c = system.now();
mapNegativeFeedback.put(dataId,row);
totalPerAgent.put(agentId, totalNegativeByAgent++);
dataNegativeFeedback.add(row);
}
}
dataUserDetail.put(agentId, dataNegativeFeedback);

system.debug('3. agentid:'+agentId+', total data:'+ totalDataPerAgent);
numAgent++;
if (numAgent >= dataPerAgent.size()) {
numAgent = 0;
}
}

System.debug('mapNegativeFeedback:'+mapNegativeFeedback);

update mapNegativeFeedback.values();

List<Agent_Distribution_History__c> insertLog = new List<Agent_Distribution_History__c>();
for(User_detail__c row: getDetailUser) {
if (dataUserDetail.containsKey(row.User__c)) {
insertLog.add(new Agent_Distribution_History__c(
User_Detail__c = row.Id,
Total_Distributed__c = dataUserDetail.get(row.User__c).size(),
Is_Qualtrics__c = true
));
}
}

insert insertLog;

}
} */
    
    global void execute(Database.BatchableContext BC, List<Call_Line__c> callLine){ 
        
        List<Call_Line__c> data = new List<Call_Line__c>();
        List<Call_Line__c> data2 = new List<Call_Line__c>();
        
        for (Call_Line__c row : callLine) {
            if (String.isnotblank(row.Priority__c) && row.Priority__c.tolowercase().contains('yes')) {
                data2.add(row);
            } else {
                data.add(row);
            }
        }
        
        system.debug('data2 size:'+data2.size());
        
        String label_user_detail_qualtrics = System.Label.User_Detail_Qualtrics;
        List<User_detail__c> getDetailUserNon = new List<User_detail__c>();
        if (!System.test.isRunningTest() ) {
            getDetailUserNon = [Select id, User__c from User_detail__c 
                                where recordtype.name =: label_user_detail_qualtrics AND User__c != null 
                                and user__r.isactive = true and Active__c = true 
                                and User__r.LastLoginDate  = today
                               ];     
        } else {
            getDetailUserNon = [Select id, User__c from User_detail__c 
                                where recordtype.name =: label_user_detail_qualtrics AND User__c != null 
                                and user__r.isactive = true and Active__c = true 
                               ];     
        }
        
        String label_user_detail_priority = System.Label.User_Detail_Priority;
        List<User_detail__c> getDetailUserPrio = new List<User_detail__c>();
        if (!System.test.isRunningTest() ) { 
            getDetailUserPrio = [Select id, User__c from User_detail__c 
                                 where recordtype.name =: label_user_detail_priority AND User__c != null 
                                 and user__r.isactive = true and Active__c = true 
                                 and User__r.LastLoginDate  = today
                                ];
        } else {
            getDetailUserPrio = [Select id, User__c from User_detail__c 
                                 where recordtype.name =: label_user_detail_priority AND User__c != null 
                                 and user__r.isactive = true and Active__c = true 
                                ];
        }
        
        system.debug('getDetailUserNon:'+getDetailUserNon);         
        system.debug('getDetailUserPrio:'+getDetailUserPrio);
        
        
        // checking due date
        integer targetDuedate = Integer.valueof(System.Label.due_date_negative_Feedback);
        Date currDate = System.Today();             
        Date dueDate = currDate.addDays(targetDuedate); 
        Datetime dueDateTime = currDate.addDays(targetDuedate);   
        System.debug('dueDate:'+dueDate);
        List<Master_Holiday__c> mstHoliday = [SELECT Id, End_Date_Time__c, Active_Date__c  FROM Master_Holiday__c where Active_Date_F__c > TODAY AND Type__c = 'Holiday' AND Entity__c = 'AMFS' ORDER by Active_Date_F__c DESC];
        for (Master_Holiday__c row : mstHoliday) {
            DateTime endDateTime = row.End_Date_Time__c; 
            Date endDate = date.valueof(endDateTime);
            System.debug('endDate:'+endDate);
            if (endDate <= dueDate && endDateTime.format('E') != 'Sat' && endDateTime.format('E') != 'Sun') {
                targetDuedate++;
                dueDateTime = dueDateTime.addDays(1);
            }
        }
        System.debug('targetDuedate:'+targetDuedate);   
        System.debug('dueDateTime:'+dueDateTime);         
        while(dueDateTime.format('E') == 'Sat' || dueDateTime.format('E') == 'Sun'){
            targetDuedate++;
            dueDateTime = dueDateTime.addDays(1);  
        } 
        dueDate = dueDateTime.date();
        System.debug('targetDuedate:'+targetDuedate);
        System.debug('dueDate:'+dueDate);
        
        
        if (data.size() > 0 && getDetailUserNon.size() > 0) {
            
            // Calculate the number of cases per agent
            Integer totalDataNon = data.size();
            Integer totalUserNon = getDetailUserNon.size();
            List<Integer> dataPerAgentNon = new List<Integer>(); 
            
            for (Integer i = 0; i < totalUserNon; i++) {
                Integer num = totalDataNon / totalUserNon;
                Integer sisaPembagian = Math.mod(totalDataNon, totalUserNon);
                if (sisaPembagian > i) {
                    num++;
                }
                dataPerAgentNon.add(num);
            }
            
            
            Map<String, List<Call_line__c>> groupingByEmailNon = new Map<String, List<Call_line__c>>();
            Map<String, List<Call_line__c>> groupingByPhoneNon = new Map<String, List<Call_line__c>>();
            Map<String, List<Call_line__c>> groupingByMobilePhoneNon = new Map<String, List<Call_line__c>>();
            Map<String, List<Call_line__c>> groupingByPolicyNon = new Map<String, List<Call_line__c>>();
            for(Call_line__c row: data) { 
                if (String.isblank(row.Priority__c) || (string.isnotblank(row.Priority__c) &&row.Priority__c.tolowercase().contains('no'))) {
                    List<Call_line__c> dataEmailNon = new List<Call_line__c>();
                    List<Call_line__c> dataPhoneNon = new List<Call_line__c>();
                    List<Call_line__c> dataMobilePhoneNon = new List<Call_line__c>();
                    List<Call_line__c> dataPolicyNon = new List<Call_line__c>();
                    
                    if (string.isnotblank(row.contact__r.email)) { 
                        string key = row.contact__r.email;
                        if (groupingByEmailNon.containskey(key)) {
                            dataEmailNon = groupingByEmailNon.get(key);
                        }
                        dataEmailNon.add(row);      
                        groupingByEmailNon.put(key, dataEmailNon);
                    }
                    
                    
                    if (string.isnotblank(row.contact__r.MobilePhone)) { 
                        string key = row.contact__r.MobilePhone;
                        if (groupingByMobilePhoneNon.containskey(key)) { 
                            dataMobilePhoneNon = groupingByMobilePhoneNon.get(key);
                        }
                        dataMobilePhoneNon.add(row);          
                        groupingByMobilePhoneNon.put(key, dataMobilePhoneNon);
                    }
                    
                    
                    if (string.isnotblank(row.contact__r.phone)) { 
                        string key = row.contact__r.phone;
                        if (groupingByPhoneNon.containskey(key)) { 
                            dataPhoneNon = groupingByPhoneNon.get(key);
                        }
                        dataPhoneNon.add(row);          
                        groupingByPhoneNon.put(key, dataPhoneNon);
                    }
                    
                    
                    if (string.isnotblank(row.contact__r.policy_no__c)) { 
                        string key = row.contact__r.policy_no__c;
                        if (groupingByPolicyNon.containskey(key)) { 
                            dataPolicyNon = groupingByPolicyNon.get(key);
                        }
                        dataPolicyNon.add(row);          
                        groupingByPolicyNon.put(key, dataPolicyNon);
                    }  
                }
            } 
            
            Map<String,list<Call_line__c>> groupingNegativeFeedback = new Map<String,list<Call_line__c>>();
            
            if (groupingByEmailNon.size() > 0) {
                for (string email: groupingByEmailNon.keySet()) {
                    string parentId = groupingByEmailNon.get(email)[0].Id;
                    List<Call_line__c> setNegative = groupingByEmailNon.get(email);
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            system.debug('groupingNegativeFeedback:'+groupingNegativeFeedback);
            
            if (groupingByPhoneNon.size() > 0) {
                for (string phone: groupingByPhoneNon.keySet()) {
                    string parentId = groupingByPhoneNon.get(phone)[0].Id;
                    List<Call_line__c> setNegative = groupingByPhoneNon.get(phone);
                    if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            if (groupingByMobilePhoneNon.size() > 0) {
                for (string Mobilephone: groupingByMobilePhoneNon.keySet()) {
                    string parentId = groupingByMobilePhoneNon.get(Mobilephone)[0].Id;
                    List<Call_line__c> setNegative = groupingByMobilePhoneNon.get(Mobilephone);
                    if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            if (groupingByPolicyNon.size() > 0) {
                for (string policy: groupingByPolicyNon.keySet()) {
                    string parentId = groupingByPolicyNon.get(policy)[0].Id;
                    List<Call_line__c> setNegative = groupingByPolicyNon.get(policy);
                    if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            
            Map<string, Call_line__c> mapNegativeFeedback = new Map<string, Call_line__c>();
            map<string, integer> totalPerAgent = new map<string, integer>();
            map<string, List<Call_line__c>> dataUserDetail = new map<string, List<Call_line__c>>();
            
            system.debug('dataPerAgentNon:'+dataPerAgentNon);
            integer numAgent = 0;
            for (String rowId: groupingNegativeFeedback.keySet()) {  
                integer countagent = dataPerAgentNon[numAgent];
                string agentId = getDetailUserNon[numAgent].User__c ; 
                integer totalNegativeByAgent = 1;
                integer totalDataNonPerAgent = 1;
                
                system.debug('1. agentid:'+agentId+', total data = '+ totalDataNonPerAgent);
                
                string currOwnerId = groupingNegativeFeedback.get(rowId)[0].ownerId;
                
                system.debug('numAgent:'+numAgent);
                
                if (currOwnerId == agentId) {  
                    numAgent++;
                    
                    if (numAgent >= dataPerAgentNon.size()) {
                        numAgent = 0;
                    }
                    countagent = dataPerAgentNon[numAgent];
                    agentId = getDetailUserNon[numAgent].User__c ; 
                }  
                
                if (totalPerAgent.containsKey(agentId)) {
                    totalNegativeByAgent = totalPerAgent.get(agentId); 
                    system.debug('2.1. agentid:'+agentId+', total data:'+ totalDataNonPerAgent);
                    String AgentFirst = getDetailUserNon[numAgent].User__c;
                    
                    Integer loopAgent =  0; 
                    while(totalNegativeByAgent > countagent) { 
                        
                        if (loopAgent > 0 && AgentFirst == agentId) {
                            totalPerAgent.put(agentId, 0);
                            break;
                        }
                        
                        if (totalPerAgent.containsKey(agentId)) { 
                            totalNegativeByAgent = totalPerAgent.get(agentId);
                            if (totalNegativeByAgent < countagent) break;
                        }
                        
                        numAgent++; 
                        if (numAgent >= dataPerAgentNon.size()) {
                            numAgent = 0;
                        }
                        countagent = dataPerAgentNon[numAgent];
                        agentId = getDetailUserNon[numAgent].User__c ; 
                        
                        loopAgent++;
                        
                    }  
                }      
                
                
                system.debug('agentId:'+agentId);
                
                List<Call_line__c> dataNegativeFeedback = new List<Call_line__c>();
                if (dataUserDetail.containsKey(agentId)) {
                    dataNegativeFeedback.addAll(dataUserDetail.get(agentId));
                }
                
                for(Call_line__c row : groupingNegativeFeedback.get(rowId)) {
                    string dataId = row.id;
                    if (!mapNegativeFeedback.containsKey(dataId)) {
                        row.OwnerId = agentId; 
                        row.Agent__c = agentId; 
                        row.Due_Date__c = dueDate;
                        row.Distribution_Date_Time__c = system.now();
                        mapNegativeFeedback.put(dataId,row);
                        totalPerAgent.put(agentId, totalNegativeByAgent++);
                        dataNegativeFeedback.add(row);
                    }
                }
                dataUserDetail.put(agentId, dataNegativeFeedback);
                
                system.debug('3. agentid:'+agentId+', total data:'+ totalDataNonPerAgent);
                numAgent++;
                if (numAgent >= dataPerAgentNon.size()) {
                    numAgent = 0;
                }
            }
            
            System.debug('mapNegativeFeedback:'+mapNegativeFeedback);
            System.debug('dataUserDetail:'+dataUserDetail);
            
            
            update mapNegativeFeedback.values();
            
            Map<string, double> totalUserMap = new Map<string, double>();
            List<Agent_Distribution_History__c> insertLog = new List<Agent_Distribution_History__c>();
            for(User_detail__c row: getDetailUserNon) {
                if (dataUserDetail.containsKey(row.User__c)) {
                    insertLog.add(new Agent_Distribution_History__c(
                        User_Detail__c = row.Id,
                        Total_Distributed__c = dataUserDetail.get(row.User__c).size(),
                        Is_Qualtrics__c = true
                    ));
                    totalUserMap.put(row.id, dataUserDetail.get(row.User__c).size());
                }
            }
            
            System.debug('totalUserMap:'+totalUserMap);
            insert insertLog;
        }
        
        if (data2.size() > 0 && getDetailUserPrio.size() > 0) {
            // Calculate the number of cases per agent
            Integer totalDataPrio = data2.size();
            Integer totalUserPrio = getDetailUserPrio.size();
            List<Integer> dataPerAgentPrio = new List<Integer>(); 
            
            for (Integer i = 0; i < totalUserPrio; i++) {
                Integer num = totalDataPrio / totalUserPrio;
                Integer sisaPembagian = Math.mod(totalDataPrio, totalUserPrio);
                if (sisaPembagian > i) {
                    num++;
                }
                dataPerAgentPrio.add(num);
            }
            
            
            Map<String, List<Call_line__c>> groupingByEmailPrio = new Map<String, List<Call_line__c>>();
            Map<String, List<Call_line__c>> groupingByPhonePrio = new Map<String, List<Call_line__c>>();
            Map<String, List<Call_line__c>> groupingByMobilePhonePrio = new Map<String, List<Call_line__c>>();
            Map<String, List<Call_line__c>> groupingByPolicyPrio = new Map<String, List<Call_line__c>>();
            for(Call_line__c row: data2) { 
                
                List<Call_line__c> dataEmailPrio = new List<Call_line__c>();
                List<Call_line__c> dataPhonePrio = new List<Call_line__c>();
                List<Call_line__c> dataMobilePhonePrio = new List<Call_line__c>();
                List<Call_line__c> dataPolicyPrio = new List<Call_line__c>();
                
                if (string.isnotblank(row.contact__r.email)) { 
                    string key = row.contact__r.email;
                    if (groupingByEmailPrio.containskey(key)) {
                        dataEmailPrio = groupingByEmailPrio.get(key);
                    }
                    dataEmailPrio.add(row);      
                    groupingByEmailPrio.put(key, dataEmailPrio);
                }
                
                
                if (string.isnotblank(row.contact__r.MobilePhone)) { 
                    string key = row.contact__r.MobilePhone;
                    if (groupingByMobilePhonePrio.containskey(key)) { 
                        dataMobilePhonePrio = groupingByMobilePhonePrio.get(key);
                    }
                    dataMobilePhonePrio.add(row);          
                    groupingByMobilePhonePrio.put(key, dataMobilePhonePrio);
                }
                
                if (string.isnotblank(row.contact__r.phone)) { 
                    string key = row.contact__r.phone;
                    if (groupingByPhonePrio.containskey(key)) { 
                        dataPhonePrio = groupingByPhonePrio.get(key);
                    }
                    dataPhonePrio.add(row);          
                    groupingByPhonePrio.put(key, dataPhonePrio);
                }
                
                system.debug('row.contact__r.policy_no__c:'+row.contact__r.policy_no__c);
                system.debug('row.contact__r.Name:'+row.contact__r.Name);
                system.debug('-----------');
                if (string.isnotblank(row.contact__r.policy_no__c)) { 
                    string key = row.contact__r.policy_no__c;
                    if (groupingByPolicyPrio.containskey(key)) { 
                        dataPolicyPrio = groupingByPolicyPrio.get(key);
                    }
                    dataPolicyPrio.add(row);          
                    groupingByPolicyPrio.put(key, dataPolicyPrio);
                }   
            } 
            
            system.debug('groupingByMobilePhonePrio:'+groupingByMobilePhonePrio);
            system.debug('groupingByMobilePhonePrio.size():'+groupingByMobilePhonePrio.size());
            system.debug('groupingByPhonePrio:'+groupingByPhonePrio);
            system.debug('groupingByPhonePrio.size():'+groupingByPhonePrio.size());
            system.debug('groupingByEmailPrio:'+groupingByEmailPrio);
            system.debug('groupingByEmailPrio.size():'+groupingByEmailPrio.size());            
            system.debug('groupingByPolicyPrio:'+groupingByPolicyPrio);
            system.debug('groupingByPolicyPrio.size():'+groupingByPolicyPrio.size());
            
            Map<String,list<Call_line__c>> groupingNegativeFeedback = new Map<String,list<Call_line__c>>();
            
            if (groupingByEmailPrio.size() > 0) {
                for (string email: groupingByEmailPrio.keySet()) {
                    string parentId = groupingByEmailPrio.get(email)[0].Id;
                    List<Call_line__c> setNegative = groupingByEmailPrio.get(email);
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            if (groupingByPhonePrio.size() > 0) {
                for (string phone: groupingByPhonePrio.keySet()) {
                    string parentId = groupingByPhonePrio.get(phone)[0].Id;
                    List<Call_line__c> setNegative = groupingByPhonePrio.get(phone);
                    if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            if (groupingByMobilePhonePrio.size() > 0) {
                for (string Mobilephone: groupingByMobilePhonePrio.keySet()) {
                    string parentId = groupingByMobilePhonePrio.get(Mobilephone)[0].Id;
                    List<Call_line__c> setNegative = groupingByMobilePhonePrio.get(Mobilephone);
                    if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            if (groupingByPolicyPrio.size() > 0) {
                for (string policy: groupingByPolicyPrio.keySet()) {
                    string parentId = groupingByPolicyPrio.get(policy)[0].Id;
                    List<Call_line__c> setNegative = groupingByPolicyPrio.get(policy);
                    if (groupingNegativeFeedback.containsKey(parentId)) setNegative.addAll(groupingNegativeFeedback.get(parentId));
                    groupingNegativeFeedback.put(parentId, setNegative);
                }
            }
            
            system.debug('groupingNegativeFeedback:'+groupingNegativeFeedback); 
            system.debug('groupingNegativeFeedback.size():'+groupingNegativeFeedback.size());
            
            Map<string, Call_line__c> mapNegativeFeedback = new Map<string, Call_line__c>();
            map<string, integer> totalPerAgent = new map<string, integer>();
            map<string, List<Call_line__c>> dataUserDetail = new map<string, List<Call_line__c>>();
            
            system.debug('dataPerAgentPrio:'+dataPerAgentPrio);
            integer numAgent = 0;
            for (String rowId: groupingNegativeFeedback.keySet()) {  
                integer countagent = dataPerAgentPrio[numAgent];
                string agentId = getDetailUserPrio[numAgent].User__c ; 
                integer totalNegativeByAgent = 1;
                integer totalDataPrioPerAgent = 1;
                
                system.debug('1. agentid:'+agentId+', total data = '+ totalDataPrioPerAgent);
                
                string currOwnerId = groupingNegativeFeedback.get(rowId)[0].ownerId;
                
                system.debug('numAgent:'+numAgent);
                
                if (currOwnerId == agentId) { 
                    numAgent++;
                    system.debug('in');
                    system.debug('numAgent:'+numAgent);
                    system.debug('currOwnerId'+currOwnerId);
                    system.debug('agentId'+agentId); 
                    if (numAgent >= dataPerAgentPrio.size()) {
                        numAgent = 0;
                    }
                    countagent = dataPerAgentPrio[numAgent];
                    agentId = getDetailUserPrio[numAgent].User__c ; 
                    
                    
                    system.debug('currOwnerId'+currOwnerId);
                    system.debug('agentId'+agentId); 
                }  
                
                if (totalPerAgent.containsKey(agentId)) {
                    totalNegativeByAgent = totalPerAgent.get(agentId); 
                    system.debug('2.1. agentid:'+agentId+', total data:'+ totalDataPrioPerAgent);
                    String AgentFirst = getDetailUserPrio[numAgent].User__c;
                    
                    Integer loopAgent =  0;  
                    while(totalNegativeByAgent > countagent) { 
                        if (loopAgent > 0 && AgentFirst == agentId) {
                            totalPerAgent.put(agentId, 0);
                            break;
                        }
                        
                        if (totalPerAgent.containsKey(agentId)) { 
                            totalNegativeByAgent = totalPerAgent.get(agentId);
                            system.debug('==== totalNegativeByAgent:'+totalNegativeByAgent);
                            system.debug('==== countagent:'+countagent);
                            if (totalNegativeByAgent < countagent) {
                                system.debug('==== in');
                                break;
                            }
                        }
                        
                        system.debug('numAgent:'+numAgent);
                        numAgent++; 
                        system.debug('numAgent:'+numAgent);
                        if (numAgent >= dataPerAgentPrio.size()) {
                            numAgent = 0;
                        }
                        countagent = dataPerAgentPrio[numAgent];
                        agentId = getDetailUserPrio[numAgent].User__c ; 
                        
                        system.debug('loopAgent:'+loopAgent);
                        loopAgent++;
                        system.debug('loopAgent:'+loopAgent);
                        system.debug('---------------------------');
                    }  
                }      
                
                
                system.debug('agentId:'+agentId);
                
                List<Call_line__c> dataNegativeFeedback = new List<Call_line__c>();
                if (dataUserDetail.containsKey(agentId)) {
                    dataNegativeFeedback.addAll(dataUserDetail.get(agentId));
                }
                
                for(Call_line__c row : groupingNegativeFeedback.get(rowId)) {
                    string dataId = row.id;
                    if (!mapNegativeFeedback.containsKey(dataId)) {
                        row.OwnerId = agentId; 
                        row.Agent__c = agentId; 
                        row.Due_Date__c = dueDate;
                        row.Distribution_Date_Time__c = system.now();
                        mapNegativeFeedback.put(dataId,row);
                        totalPerAgent.put(agentId, totalNegativeByAgent++);
                        dataNegativeFeedback.add(row);
                    }
                }
                dataUserDetail.put(agentId, dataNegativeFeedback);
                
                system.debug('3. agentid:'+agentId+', total data:'+ totalDataPrioPerAgent);
                system.debug('===== ===== ===== ===== ===== ===== ');
                system.debug('===== numAgent'+numAgent);
                numAgent++;
                system.debug('===== numAgent'+numAgent);
                if (numAgent >= dataPerAgentPrio.size()) {
                    numAgent = 0;
                }
                system.debug('===== numAgent'+numAgent);
                system.debug('===== ===== ===== ===== ===== ===== ');
            }
            
            System.debug('totalPerAgent:'+totalPerAgent);
            System.debug('mapNegativeFeedback:'+mapNegativeFeedback);
            System.debug('dataUserDetail:'+dataUserDetail);
            
            update mapNegativeFeedback.values();
            Map<string, double> totalUserMap = new Map<string, double>();
            List<Agent_Distribution_History__c> insertLog = new List<Agent_Distribution_History__c>();
            for(User_detail__c row: getDetailUserPrio) { 
                if (dataUserDetail.containsKey(row.User__c)) { 
                    insertLog.add(new Agent_Distribution_History__c(
                        User_Detail__c = row.Id,
                        Total_Distributed__c = dataUserDetail.get(row.User__c).size(),
                        Is_Qualtrics__c = true
                    ));
                    totalUserMap.put(row.id, dataUserDetail.get(row.User__c).size());
                }
            }
            System.debug('totalUserMap:'+totalUserMap);
            
            insert insertLog;
        }
    }
    
    
    global void finish(Database.BatchableContext bc){
        
    }
    
}