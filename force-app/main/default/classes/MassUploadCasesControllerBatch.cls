public class MassUploadCasesControllerBatch implements Database.Batchable<sObject>{

    private List<String> currentLines;
    private Boolean isIcf;
    public Case cs{get;set;}
    private Contact cnt;
    
    public Map<Integer,List<String>> mapDataRaw {get;set;}
    public Integer counter {get;set;}
    public String func{get;set;}
    
    public MassUploadCasesControllerBatch(Map<Integer,List<String>> mapDataRaw, Case cs, Contact cnt, Boolean isIcf, String func, Integer counter) {
        this.mapDataRaw = mapDataRaw;
        this.isIcf = isIcf;
        this.cs = cs;
        this.cnt = cnt;
        this.func = func;
        this.counter = counter;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){

        currentLines = mapDataRaw.get(counter);
        currentLines = mapDataRaw.get(counter);
        mapDataRaw.remove(counter);
        counter++;
        
        List<String> policyNumbers = new List<String>();
        List<String> csvData = new List<String>();
        
        for(Integer i = 0; i < currentLines.size(); i++) {
            String currentLine = currentLines.get(i);
            csvData = currentLine.split(',');
            if(csvData.size() == 3){
                String policyNumber = csvData[0];
                policyNumbers.add(policyNumber);
            }
        }
        
        return Database.getQueryLocator('Select Id, Policy_No__c From Contact WHERE Policy_No__c in :policyNumbers');
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> contacts){
        
        //looping policy number & mapping policy numbers and desc
        
        currentLines = mapDataRaw.get(counter);
        currentLines = mapDataRaw.get(counter);
        mapDataRaw.remove(counter);
        counter++;
        
        List<String> policyNumbers = new List<String>();
        List<String> csvData = new List<String>();
        Map<String, String> polnoDescMap = new Map<String, String>();
        Map<String, String> polnoSubjMap = new Map<String, String>();
        
        List<Case> cases = new List<Case>();
        List<String> csType = new List<String>();
        System.debug('currentLines :'+currentLines);
        if (func.equals('massUpload')) {
            for(Integer i = 0; i < currentLines.size(); i++) {
                String currentLine = currentLines.get(i);
                System.debug('currentLine :'+currentLine);
                csvData = currentLine.split(',');
                System.debug('csvData : '+csvData);
                if(csvData.size() == 3){
                    String policyNumber = csvData[0];
                    String subject = csvData[1];
                    String description = csvData[2];
                    policyNumbers.add(policyNumber);
                    polnoDescMap.put(policyNumber, description);
                    polnoSubjMap.put(policyNumber, subject);
                }
            }
            system.debug('policyNumbers :'+policyNumbers);
            
            //loping id contact & mapping policy numbers and object Contact
            Map<string, Contact> contactsMap = new Map<string, Contact>();
            for (Contact c : contacts) {
                if (!contactsMap.containsKey(c.Policy_No__c)) {
                    system.debug('contact: '+c);
                    contactsMap.put(c.Policy_No__c, c);   
                }
            }
            Map<String, Contact> polnoContactMap = new Map<String, Contact>();
            for (string contactId : contactsMap.keyset()) {
                Contact contactIdSelected = contactsMap.get(contactId);
                if (contactIdSelected != null) polnoContactMap.put(contactIdSelected.Policy_No__c, contactIdSelected);
            }

            //looping for insert data to case
            List<Case> caseList = new List<Case>();
            
            if (cs.Type == 'Request') {
                for(String polno : polnoContactMap.keySet()){
                    System.debug('######### 3 contactpolicyno = ' + polnoContactMap.get(polno));
                    System.debug('######### 3 policyNumbers = ' + polno);
                    System.debug('######### 3 descriptions = ' + polnoDescMap.get(polno));
                    
                    Case cse = new Case();
                    cse.Policy_Number__c = polno;
                    cse.Subject = polnoSubjMap.get(polno);
                    cse.ContactId = polnoContactMap.get(polno).Id;
                    cse.Description__c = polnoDescMap.get(polno);
                    cse.Description = polnoDescMap.get(polno);
                    cse.type = cs.Type;
                    cse.Request_Type__c = cs.Request_Type__c;
                    cse.Case_Type__c = cs.Case_Type__c != null ? cs.Case_Type__c : cs.Request_Type__c ;
                    system.debug(cs.Case_Type__c);
                    cse.Case_Type_Config__c = cs.Case_Type_Config__c == null ? (cs.Case_Type__c == null ? cs.Request_Type__c : cs.Case_Type__c) : cs.Case_Type_Config__c ;
                    cse.PIC_Department_LU__c = cs.PIC__c;
                    cse.PIC__c = cs.PIC__c;
                    cse.ManualClosedCase__c = isIcf;
                    cse.Status = cs.Status;
                    cse.Origin = cs.Origin == null? 'Web' : cs.Origin;
                    cse.createdbyId = UserInfo.getUserId();
                    cse.Priority = cs.Priority == null? 'Medium' : cs.Priority;
                    cse.recordTypeId = cs.recordTypeId;
                    cse.isMassUpload__c = true;
                    caseList.add(cse);
                }
                insert caseList;
            } else if (cs.Type == 'Inquiry') {
                integer temp = 0;
                boolean temp2 = FALSE;
                for(String polno : polnoContactMap.keySet()){
                    temp += 1;
                    if (temp > 1) temp2 = TRUE;
                    
                    Case cse = new Case();
                    cse.Policy_Number__c = polno;
                    cse.Subject = polnoSubjMap.get(polno);
                    cse.ContactId = polnoContactMap.get(polno).Id;
                    cse.Description__c = polnoDescMap.get(polno);
                    cse.Description = polnoDescMap.get(polno);
                    cse.Status = cs.Status;
                    cse.type = cs.type;
                    cse.Priority = cs.Priority;
                    cse.Service_Type__c = cs.Service_Type__c;
                    cse.origin = cs.origin;
                    cse.Request_Type__c = cs.Request_Type__c;
                    cse.Case_Type__c = cs.Case_Type__c != null ? cs.Case_Type__c : cs.Request_Type__c ;
                    cse.Case_Type_Config__c = cs.Case_Type_Config__c == null ? (cs.Case_Type__c == null ? cs.Request_Type__c : cs.Case_Type__c) : cs.Case_Type_Config__c ;
                    cse.recordTypeId = cs.recordTypeId;
                    cse.createdbyId = UserInfo.getUserId();
                    cse.Negative_Feedback__c = cs.Negative_Feedback__c;
                    cse.parentid = cs.parentid;
                    cse.NonPP__c = cs.NonPP__c;
                    cse.General_Attitude__c = cs.General_Attitude__c;
                    cse.MultiCreate__c = TRUE;
                    cse.X2nd_Record__c = temp2;
                    cse.Product__c = cs.Product__c;
                    cse.Product_AFI__c = cs.Product_AFI__c;
                    cse.Line_Queue__c = cs.Line_Queue__c; 
                    cse.Root_Cause__c = cs.Root_Cause__c;
                    cse.PIC_Department_LU__c = cs.PIC__c;
                    cse.PIC__c = cs.PIC__c;
                    cse.ManualClosedCase__c = true;
                    cse.Already_Send_Survey__c = true;
                    cse.isMassUpload__c = true;
                    caseList.add(cse);
                }
                insert caseList;
            } 
        }
    }
    
    public void finish(Database.BatchableContext bc){
        
    }

}