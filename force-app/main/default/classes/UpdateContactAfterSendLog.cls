global class UpdateContactAfterSendLog implements Database.Batchable<sObject>, Database.Stateful {
    global Map<String, Integer> intervalMap;
    global Map<String, String> surveyTypeMap;
    global String query;
    global Integer recordsProcessed = 0;
    global Map<String, ICF_Parameter__c> mapICFParam;
    private static final String SEND = 'Send';
    private static final String ICF = 'ICF';
    private static final Date MyDate = Date.today();
    private static final String intervalUnit = 'MONTH';
    private static final String I_ASK = 'I Ask';
    private static final String I_BUY = 'I Buy';
    private static final String I_CLAIM = 'I Claim';
    private static final String I_COMPLAIN = 'I Complain';
    private static final String I_RENEW = 'I Renew';
    private static final String I_ASK_INQUIRY = 'I Ask - Inquiry';
	private static final String I_ASK_REQUEST = 'I Ask - Request';
    private static final Date todayDate = Date.today();
    
    global UpdateContactAfterSendLog(Map<String, Integer> intervalMapParam, Map<String, String> surveyTypeMapParam, String q) {
        this.intervalMap = intervalMapParam;
        this.surveyTypeMap = surveyTypeMapParam;
        this.query = q;
        
        this.mapICFParam = new Map<String, ICF_Parameter__c>();
        String MASTER_EMAIL_SMS = 'Master_Email_SMS';
        String ACTIVE = 'Active';
        DescribeSObjectResult describeResultIcfParam = ICF_Parameter__c.getSObjectType().getDescribe();
        List<String> icfParamFieldList = new List<String>(describeResultIcfParam.fields.getMap().keySet());
        String icfParamFields = String.join(icfParamFieldList, ',');
        String icfParamQuery = ' SELECT ' + icfParamFields + ' FROM ICF_Parameter__c WHERE Record_Type_Name__c = :MASTER_EMAIL_SMS AND Status__c = :ACTIVE ';
        List<ICF_Parameter__c> icfParamList = Database.query(icfParamQuery);
        for (ICF_Parameter__c icfParam : icfParamList) {
            this.mapICFParam.put(icfParam.Entity__c, icfParam);
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Email_Sms_Log__c> scope) {
        Set<Contact> contactToUpdate = new Set<Contact>();
        Set<Email_SMS_Log__c> eslToUpdate = new Set<Email_SMS_Log__c>();
        
        System.debug(LoggingLevel.DEBUG, '***SCOPE: ' + scope.size());
        for (Email_Sms_Log__c esl : scope) {
            if (intervalMap.get(esl.Contact__c) != null && surveyTypeMap.get(esl.Contact__c) != null) {
                Date freezeDate = null;
                Integer interval = intervalMap.get(esl.Contact__c);
                //String surveyType = surveyTypeMap.get(esl.Contact__c);
                String surveyType = (esl.Survey_Type__c == I_ASK_INQUIRY || esl.Survey_Type__c == I_ASK_REQUEST ? I_ASK : esl.Survey_Type__c);
                Contact ct = new Contact();
                ct.Id = esl.Contact__c;
                
                if ('MONTH' == intervalUnit) {
                    freezeDate = todayDate.addMonths(interval);
                }
                
                System.debug(LoggingLevel.DEBUG, '***UCASL surveyType: ' + surveyType);
                if (I_ASK == surveyType) {
                    ct.Freeze_Ask_End_Date__c = freezeDate;
                    ct.Survey_Ask_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                else if (I_COMPLAIN == surveyType) {
                    ct.Freeze_Complaint_End_Date__c = freezeDate;
                    ct.Survey_Complaint_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                /*
                else if (I_BUY == surveyType) {
                    ct.Freeze_Buy_End_Date__c = freezeDate;
                    ct.Survey_Buy_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                else if (I_CLAIM == surveyType) {
                    ct.Freeze_Claim_End_Date__c = freezeDate;
                    ct.Survey_Claim_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                
                else if (I_RENEW == surveyType) {
                    ct.Freeze_Renew_End_Date__c = freezeDate;
                    ct.Survey_Renew_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
				*/
            }
            else {
                System.debug(LoggingLevel.DEBUG, '***MAP NOT FOUND WITH CONTACT ID: ' + esl.Contact__c);
                
                Contact ct = new Contact();
        		ct.Id = esl.Contact__c;
                FreezeConfig fc = initFC(esl);
                
                if (I_ASK == fc.surveyType) {
                    ct.Freeze_Ask_End_Date__c = fc.freezeDate;
                    ct.Survey_Ask_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                else if (I_COMPLAIN == fc.surveyType) {
                    ct.Freeze_Complaint_End_Date__c = fc.freezeDate;
                    ct.Survey_Complaint_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                /*
                else if (I_BUY == surveyType) {
                    ct.Freeze_Buy_End_Date__c = freezeDate;
                    ct.Survey_Buy_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                else if (I_CLAIM == surveyType) {
                    ct.Freeze_Claim_End_Date__c = freezeDate;
                    ct.Survey_Claim_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
                else if (I_RENEW == surveyType) {
                    ct.Freeze_Renew_End_Date__c = freezeDate;
                    ct.Survey_Renew_Send_Counter__c = 0;
                    contactToUpdate.add(ct);
                    esl.Updated_Contact_Flag__c = true;
                    eslToUpdate.add(esl);
                    recordsProcessed = recordsProcessed + 1;
                }
				*/
            }
        }
        
        List<Contact> cList = new List<Contact>();
        List<Email_SMS_Log__c> eslList = new List<Email_SMS_Log__c>();
        cList.addAll(contactToUpdate);
        eslList.addAll(eslToUpdate);
        update cList;
        update eslList;
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***TOTAL PROCESSED: ' + recordsProcessed);
    }
    
    public class FreezeConfig {
        public Date freezeDate;
        public String surveyType;
    }
    
    public FreezeConfig initFC(Email_SMS_Log__c esl) {
        Date freezeDate = null;
        Integer interval = 0;
        String surveyType = '';
        
        if (mapICFParam.get(esl.Entity__c) != null) {
            ICF_Parameter__c icfParam = mapICFParam.get(esl.Entity__c);
            surveyType = (esl.Survey_Type__c == I_ASK_INQUIRY || esl.Survey_Type__c == I_ASK_REQUEST ? I_ASK : esl.Survey_Type__c);
            interval = Integer.valueOf(icfParam.Interval_Completed_Month__c != null ? icfParam.Interval_Completed_Month__c : '1');
        }
        else {
            ICF_Parameter__c icfParam = mapICFParam.get('General');
            surveyType = (esl.Survey_Type__c == I_ASK_INQUIRY || esl.Survey_Type__c == I_ASK_REQUEST ? I_ASK : esl.Survey_Type__c);
            interval = Integer.valueOf(icfParam.Interval_Completed_Month__c != null ? icfParam.Interval_Completed_Month__c : '1');
        }
        
        if ('MONTH' == intervalUnit) {
            freezeDate = todayDate.addMonths(interval);
        }
        
        FreezeConfig fc = new FreezeConfig();
        fc.freezeDate = freezeDate;
        fc.surveyType = surveyType;
        return fc;
    }
}