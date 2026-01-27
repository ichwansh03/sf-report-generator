public class MassUploadCasesControllerQueueable implements Queueable{
    
    private List<String> currentLines;
    private Boolean isIcf;
    public Case cs{get;set;}
    private Contact cnt;
    private final static String TRX_TYPE_INQUIRY = 'Inquiry';
    
    public String contactid {get;set;}
    public String policyNumber {get;set;}
    public String description {get;set;}
    public Map<Integer,List<String>> mapDataRaw {get;set;}
    public Integer counter {get;set;}
    public String final_contactid {get;set;}
    public String final_policyNumbers {get;set;}
    public String final_descriptions {get;set;}
    public String func{get;set;}
    public String csType {get;set;}
    
    public MassUploadCasesControllerQueueable(Map<Integer,List<String>> mapDataRaw, Case cs, Contact cnt, Boolean isIcf, String func, Integer counter) {
        this.mapDataRaw = mapDataRaw;
        this.isIcf = isIcf;
        this.cs = cs;
        this.cnt = cnt;
        this.func = func;
        this.counter = counter;
    }
    
    public void execute(QueueableContext context) {
        System.debug('current counter : ' + counter);
        // distribute currentLines
        currentLines = mapDataRaw.get(counter);
        currentLines = mapDataRaw.get(counter);
        mapDataRaw.remove(counter);
        counter++;
        
        //looping policy number & mapping policy numbers and desc
        List<String> policyNumbers = new List<String>();
        List<String> csvData = new List<String>();
        Map<String, String> polnoDescMap = new Map<String, String>();
        Map<String, String> polnoSubjMap = new Map<String, String>();
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
            Map<string, Contact> contactsMap = new Map<string, Contact>([Select Id, Policy_No__c From Contact WHERE Policy_No__c in :policyNumbers]);
            Map<String, Contact> polnoContactMap = new Map<String, Contact>();
            for (string contactId : contactsMap.keyset()) {
                Contact contactIdSelected = contactsMap.get(contactId);
                polnoContactMap.put(contactIdSelected.Policy_No__c, contactIdSelected);
            }
            
            //looping for insert data to case
            List<Case> caseList = new List<Case>();
            //try{
                System.debug('casenya : '+cs);
                if(cs.Type == 'Request'){
                    /*
                    List<Temp_Mass_Case_Upload__c> tempUploadCase = new List<Temp_Mass_Case_Upload__c>();
                    
                    for(String polno : policyNumbers){
                    Temp_Mass_Case_Upload__c tempUp = new Temp_Mass_Case_Upload__c();
                    tempUp.Contact__c = polnoContactMap.get(polno).Id;
                    tempUp.Case_Policy_Number__c = polno;
                    tempUp.Case_Description__c = polnoDescMap.get(polno);
                    tempUp.Case_Subject__c = polnoSubjMap.get(polno);
                    tempUp.Case_Type__c = cs.Case_Type_Config__c;
                    tempUp.Case_Origin__c = cs.Origin == null? 'Web' : cs.Origin;
                    tempUp.Case_Priority__c = cs.Priority == null? 'Medium' : cs.Priority;
                    tempUp.Case_Record_Type__c = cs.RecordTypeId;
                    tempUp.Case_Root_Cause__c = cs.Root_Cause__c;
                    tempUp.Case_Customer_Mood__c = cs.General_Attitude__c;
                    tempUp.Case_Status__c = cs.Status;
                    tempUp.Case_NonPP__c = cs.NonPP__c;
                    tempUploadCase.add(tempUp);
                    }
                    insert tempUploadCase;
                    */
                    for(String polno : policyNumbers){
                        System.debug('######### 3 contactpolicyno = ' + polnoContactMap.get(polno));
                        System.debug('######### 3 policyNumbers = ' + polno);
                        System.debug('######### 3 descriptions = ' + polnoDescMap.get(polno));
                        System.debug('######### 3 id contact = ' + polnoContactMap.get(polno).Id);
                        
                        Case cse = new Case();
                        cse.Policy_Number__c = polno;
                        cse.Subject = polnoSubjMap.get(polno);
                        cse.ContactId = polnoContactMap.get(polno).Id;
                        cse.Description__c = polnoDescMap.get(polno);
                        cse.Description = polnoDescMap.get(polno);
                        cse.type = cs.Type;
                        cse.Request_Type__c = cs.Request_Type__c;
                        cse.Case_Type__c = cs.Case_Type__c != null ? cs.Case_Type__c : cs.Request_Type__c ;
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
                }else if(cs.Type == 'Inquiry'){
                    system.debug('mass case inquiry');
                    System.debug('policyNumbers : '+policyNumbers);
                    
                    /*
                    List<Temp_Mass_Case_Upload__c> tempUploadCase = new List<Temp_Mass_Case_Upload__c>();
                    
                    for(String polno : policyNumbers){
                    Temp_Mass_Case_Upload__c tempUp = new Temp_Mass_Case_Upload__c();
                    tempUp.Contact__c = polnoContactMap.get(polno).Id;
                    tempUp.Case_Policy_Number__c = polno;
                    tempUp.Case_Description__c = polnoDescMap.get(polno);
                    tempUp.Case_Subject__c = polnoSubjMap.get(polno);
                    tempUp.Case_Type__c = cs.Case_Type_Config__c;
                    tempUp.Case_Origin__c = cs.Origin == null? 'Web' : cs.Origin;
                    tempUp.Case_Priority__c = cs.Priority == null? 'Medium' : cs.Priority;
                    tempUp.Case_Record_Type__c = cs.RecordTypeId;
                    tempUp.Case_Root_Cause__c = cs.Root_Cause__c;
                    tempUp.Case_Customer_Mood__c = cs.General_Attitude__c;
                    tempUp.Case_Status__c = cs.Status;
                    tempUp.Case_NonPP__c = cs.NonPP__c;
                    tempUploadCase.add(tempUp);
                    }
                    insert tempUploadCase;
                    */
                    
                    integer temp = 0;
                    boolean temp2 = FALSE;
                    for(String polno : policyNumbers){
                        temp += 1;
                        if (temp > 1) temp2 = TRUE;
                        
                        Case cse = new Case();
                        cse.Policy_Number__c = polno;
                        cse.Subject = polnoSubjMap.get(polno);
                        cse.ContactId = polnoContactMap.get(polno).Id;
                        //cse.Description = polnoDescMap.get(polno);
                        cse.Status = cs.Status;
                        cse.type = cs.type;
                        cse.Priority = cs.Priority;
                        cse.Service_Type__c = cs.Service_Type__c;
                        cse.origin = cs.origin;
                        cse.Request_Type__c = cs.Request_Type__c;
                        cse.Case_Type__c = cs.Case_Type__c != null ? cs.Case_Type__c : cs.Request_Type__c ;
                        cse.Case_Type_Config__c = cs.Case_Type_Config__c == null ? (cs.Case_Type__c == null ? cs.Request_Type__c : cs.Case_Type__c) : cs.Case_Type_Config__c ;
                        //cse.accountId = cs.accountId;
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
                }else if(cs.Type == 'Complaint'){
                    System.debug('policyNumberssize :'+policyNumbers.size());
                    for(String polno : policyNumbers){
                        System.debug('######### 3 contactpolicyno = ' + polnoContactMap.get(polno));
                        System.debug('######### 3 policyNumbers = ' + polno);
                        System.debug('######### 3 id contact = ' + polnoContactMap.get(polno).Id);
                        Case cse = new Case();
                        cse.Policy_Number__c = polno;
                        cse.Subject = polnoSubjMap.get(polno);
                        cse.ContactId = polnoContactMap.get(polno).Id;
                        cse.Description__c = polnoDescMap.get(polno);
                        //cse.Description = polnoDescMap.get(polno);
                        cse.Status = cs.Status;
                        cse.type = cs.type;
                        cse.Priority = cs.Priority;
                        cse.Service_Type__c = cs.Service_Type__c;
                        cse.origin = cs.origin;
                        cse.Case_Type__c = cs.Case_Type__c;
                        cse.Case_Type_Config__c = cs.Case_Type_Config__c;
                        cse.CHS_Status__c = cs.CHS_Status__c;
                        cse.PIC__c = cs.PIC__c;
                        cse.Pending_Status__c = cs.Pending_Status__c;
                        cse.Sub_Status__c = cs.Sub_Status__c;
                        cse.Service_Type__c = cs.Service_Type__c;
                        cse.Nature_Config__c = cs.Nature_Config__c;
                        cse.Nature__c = cs.Nature__c == null ? cs.Nature_Config__c : cs.Nature__c;
                        cse.Customer__c = cs.Customer__c;
                        cse.Category_Config__c = cs.Category_Config__c;
                        cse.Category__c = cs.Category__c == null ? cs.Category__c : cs.Category_Config__c;
                        cse.Customer_type__c = cs.Customer_type__c;
                        cse.Business_channel__c = cs.Business_channel__c;
                        cse.Complainant__c = cs.Complainant__c;
                        cse.Channel__c = cs.Channel__c;
                        cse.Received_date__c = cs.Received_date__c;
                        cse.Complaint_type__c = cs.Complaint_type__c;
                        cse.Priority = cs.Priority;
                        cse.Product__c = cs.Product__c;
                        cse.Lampiran__c = cs.Lampiran__c;
                        cse.Back_Office_PIC__c = cs.Back_Office_PIC__c;
                        cse.Appeal__c = cs.Appeal__c;
                        cse.Region__c = cs.Region__c;
                        cse.Related_ticket__c = cs.Related_ticket__c;
                        cse.Other_Information__c = cs.Other_Information__c;
                        cse.Case_Error__c = cs.Case_Error__c;
                        cse.Complaint__c = cs.Complaint__c;     
                        cse.Demand__c = cs.Demand__c;
                        cse.Chronological__c = cs.Chronological__c;
                        cse.Financial_Lost__c = cs.Financial_Lost__c;
                        cse.Financial_Lost_Currency__c = cs.Financial_Lost_Currency__c;
                        cse.Reason_Root_Cause__c = cs.Reason_Root_Cause__c;
                        cse.Corrective_Action__c = cs.Corrective_Action__c;
                        cse.Recommendation__c = cs.Recommendation__c;
                        cse.accountId = cs.accountId;
                        cse.recordTypeId = cs.recordTypeId;
                        cse.createdbyId = UserInfo.getUserId();
                        cse.FCR__c = false;
                        cse.Received_date__c = cs.Received_date__c;
                        cse.Objek_Pertanggungan__c = cs.Objek_Pertanggungan__c;
                        cse.Jenis_Pertanggungan__c = cs.Jenis_Pertanggungan__c;
                        cse.Tanggal_Assign__c = cs.Tanggal_Assign__c;
                        cse.Bengkel__c = cs.Bengkel__c;
                        cse.Lokasi_Survey__c = cs.Lokasi_Survey__c;
                        cse.PIC_Surveyor__c = cs.PIC_Surveyor__c;
                        cse.COB__c = cs.COB__c;
                        cse.Received_Party__c = cs.Received_Party__c;
                        cse.Activity_Log__c = cs.Activity_Log__c;
                        cse.Complaint_Resume__c = cs.Complaint_Resume__c;
                        cse.Progress_Action__c = cs.Progress_Action__c;
                        //cse.ParentId= inquiryId;
                        cse.ParentId = cs.ParentId;
                        cse.Negative_Feedback__c = cs.Negative_Feedback__c;
                        cse.NonPP__c = cs.NonPP__c;
                        //cse.Escalated_Flow__c = esalatedFlowGenerator(cs.Category_Config__c, entity);
                        //cse.Escalated_Flow_TAT__c = esalatedFlowTATGenerator(cs.Category_Config__c, entity);
                        cse.Product_AFI__c = cs.Product_AFI__c;
                        cse.Line_Queue__c = cs.Line_Queue__c;
                        caseList.add(cse);
                    }
                    system.debug('caseList :'+caseList);
                    insert caseList;
                }
                /*
                
                //retreive id from each case
                system.debug('*********: start create email for reporting');
                List<String> caseIds = new List<String>();
                for(Case caseEachId : caseList){
                    String caseIdTemp = caseEachId.id;
                    caseIds.add(caseIdTemp);
                }
                
                // construct data table
                system.debug('*********: start construct data table');
                List<Case> casesReport = [select id, Policy_Numbers__c, CaseNumber from Case where id =: caseIds];
                string temp;
                temp = '<table border="1">';
                temp = temp+'<tr><th>Policy Number</th><th>Case Number</th></tr>';
                
                for(Case caseReport : casesReport){
                    temp = temp + '<tr>' + '<td>' + caseReport.Policy_Numbers__c + '</td>' + '<td>' + caseReport.CaseNumber + '</td>' + '</tr>';
                }
                temp = temp+'</table>';
                system.debug('*********: construct data table success');
                
                
                // construct body and subject
                system.debug('*********: start construct body and subject');
                EmailTemplate et = [SELECT Id, Subject, HtmlValue FROM EmailTemplate WHERE developerName  = 'DMU_Upload_New_Request'];
                String subject = et.Subject;                                         
                String htmlBody = et.HtmlValue;
                subject = subject.replace('{!DateToday}', String.valueOf(Date.Today()));
                htmlBody = htmlBody.replace('{!DataTable}',temp);
                system.debug('*********: construct body and subject success');
                
                
                // sending mail processing
                system.debug('*********: start sending email');
                id OwnerLast;
                OrgWideEmailAddress owe = [SELECT ID,IsAllowAllProfiles,DisplayName,Address FROM OrgWideEmailAddress WHERE Address = 'catur.yuwono@axa.co.id' LIMIT 1];
                String sendToEmail = Label.DMU_Send_To_Report;
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setOrgWideEmailAddressId(owe.Id);
                mail.setTargetObjectId(OwnerLast);
                if (sendToEmail != 'FALSE') {
                    sendToEmail = sendToEmail.left(sendToEmail.length()-1);
                    String[] toEmails = sendToEmail.split(',');
                    mail.setToAddresses(toEmails);
                }
                mail.setSubject(subject);
                mail.setHtmlBody(htmlBody);
                mail.setSaveAsActivity(false);
                
                List<Messaging.SingleEmailMessage> listmail = new List<Messaging.SingleEmailMessage>();
                listmail.add(mail);
                Messaging.sendEmail(listmail);
                system.debug('*********: email sent');
                */
            //}catch(Exception e){
                //system.debug('adaerrornih  '+e.getMessage()+' because '+e.getCause()+' in '+e.getLineNumber());
            //}
        }else if(func.equals('reqClose')){
            for(Integer i = 0; i < currentLines.size(); i++) {
                String currentLine = currentLines.get(i);
                String caseNumber = currentLine.substringBefore(',');
                
                if (caseNumber.left(1) != '0' && caseNumber.length() == 7) {
                    caseNumber = '0' + caseNumber;
                }
                
                List<Case> cases = [Select Id, Status, Type, ManualClosedCase__c From Case WHERE CaseNumber =: caseNumber LIMIT 1];
                if(cases.size() > 0){
                    if(cases[0].Type == cs.Type){
                        for(Case cse : cases) {
                            // insert new internal comment/case comment
                            if(currentLine.indexOf(',') != currentLine.lastIndexOf(',')) {
                                String remark = currentLine.substring(currentLine.indexOf(',')+1, currentLine.lastIndexOf(','));
                                CaseComment cc = new CaseComment(ParentId = cse.Id, CommentBody = remark);
                                insert cc;
                            }
                            // update status to closed if status exists
                            if(currentLine.right(1) != ',' && currentLine.substring(currentLine.lastIndexOf(',') + 1).length() >= 3) {
                                cse.Status = currentLine.substring(currentLine.lastIndexOf(',') + 1);
                            }
                            
                            cse.ManualClosedCase__c = isIcf;
                        }   
                    }else{
                    }
                }else{
                }
                
                update cases;
                
            }
        }
        
        // recursive call
        if(mapDataRaw.size() > 0){
            System.enqueueJob(new MassUploadCasesControllerQueueable(mapDataRaw, cs, cnt, isIcf,func, counter));
        }
    }
}