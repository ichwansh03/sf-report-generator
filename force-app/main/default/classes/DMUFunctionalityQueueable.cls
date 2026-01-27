public class DMUFunctionalityQueueable implements Queueable {

    private List<String> currentLines;
    private Boolean isIcf;
    private Case cs;
    private Contact cnt;

    public String contactid {get;set;}
    public String policyNumber {get;set;}
    public String description {get;set;}
    
    public String final_contactid {get;set;}
    public String final_policyNumbers {get;set;}
    public String final_descriptions {get;set;}

    public DMUFunctionalityQueueable(List<String> currentLines, Case cs, Contact cnt, Boolean isIcf) {
        this.currentLines = currentLines;
        this.isIcf = isIcf;
        this.cs = cs;
        this.cnt = cnt;
    }

    public void execute(QueueableContext context) {

        //looping policy number & mapping policy numbers and desc
        List<String> policyNumbers = new List<String>();
        Map<String, String> polnoDescMap = new Map<String, String>();
        for(Integer i = 0; i < currentLines.size(); i++) {
            String currentLine = currentLines.get(i);
            String policyNumber = currentLine.substringBefore(',');
            String description = currentLine.substringAfter(',');
            String remark = currentLine.substring(currentLine.indexOf(',')+1, currentLine.length());
            policyNumbers.add(policyNumber);
            polnoDescMap.put(policyNumber, description);
        }

        //loping id contact & mapping policy numbers and object Contact
        Map<string, Contact> contactsMap = new Map<string, Contact>([Select Id, Policy_No__c From Contact WHERE Policy_No__c in :policyNumbers]);
        Map<String, Contact> polnoContactMap = new Map<String, Contact>();
        for (string contactId : contactsMap.keyset()) {
            Contact contactIdSelected = contactsMap.get(contactId);
            polnoContactMap.put(contactIdSelected.Policy_No__c, contactIdSelected);
        }

        //looping for insert data to case
        List<Case> caseList = new List<Case>();
        List<Master_Case_Type_Regional__c> mctr = new List<Master_Case_Type_Regional__c>();
        for(String polno : policyNumbers){
            System.debug('######### 3 contactpolicyno = ' + polnoContactMap.get(polno));
            System.debug('######### 3 policyNumbers = ' + polno);
            System.debug('######### 3 descriptions = ' + polnoDescMap.get(polno));
            System.debug('######### 3 id contact = ' + polnoContactMap.get(polno).Id);
            
            List<Master_Case_Type_Regional__c> mctrc = new List<Master_Case_Type_Regional__c>();
          mctrc = [SELECT Id, PIC_Department__c, TAT__c,Case_DMU_Upload_Total__c,Process_DMU_Upload_Date__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = 'AMFS' AND Active__c = TRUE AND Type__c = :cs.Type AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE)];
          List<Master_Case_Type_Regional__c> mctrlistcek = new List<Master_Case_Type_Regional__c>();
          for (Master_Case_Type_Regional__c mCase : mctrc) {
              if (mCase.Process_DMU_Upload_Date__c < date.today()){
                  mCase.Process_DMU_Upload_Date__c = date.today();
                  mCase.Case_DMU_Upload_Total__c = 0;
                  mctrlistcek.add(mCase);
             }
          }
          update mctrlistcek;
          
            if (cs.Case_Type_Config__c == 'Request_CCC_Call Back DMU') {
              mctr = [SELECT Id, PIC_Department__c, TAT__c,Case_DMU_Upload_Total__c,Process_DMU_Upload_Date__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :cs.Case_Type_Config__c AND Entity__c = 'AMFS' AND Active__c = TRUE AND Type__c = :cs.Type AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) ORDER BY Case_DMU_Upload_Total__c LIMIT 1];
          
              List<Master_Case_Type_Regional__c> mctrlist = new List<Master_Case_Type_Regional__c>();
              for (Master_Case_Type_Regional__c m : mctr) {
                  m.Case_DMU_Upload_Total__c = m.Case_DMU_Upload_Total__c+1;
                  mctrlist.add(m);
              }
              update mctrlist;  
            }
            
            Case cse = new Case();
            cse.Policy_Number__c = polno;
            cse.Subject = polno;
            cse.ContactId = polnoContactMap.get(polno).Id;
            cse.Description = polnoDescMap.get(polno);
            cse.type = 'Request';
            cse.Case_Type_Config__c = cs.Case_Type_Config__c;
            cse.PIC_Department_LU__c = cs.Case_Type_Config__c == 'Request_CCC_Call Back DMU' ? mctr[0].PIC_Department__c : cs.PIC__c;
            cse.PIC__c = cs.Case_Type_Config__c == 'Request_CCC_Call Back DMU' ? mctr[0].PIC_Department__c : cs.PIC__c;
            cse.ManualClosedCase__c = isIcf;
            cse.Status = 'New';
            cse.createdbyId = UserInfo.getUserId();
            cse.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName()
                          .get('RequestAMFSCase').getRecordTypeId();
            caseList.add(cse);
        }
        insert caseList;

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
    }
}