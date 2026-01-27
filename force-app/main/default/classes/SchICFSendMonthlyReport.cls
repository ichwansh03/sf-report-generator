global class SchICFSendMonthlyReport implements Schedulable {
    
    global void execute(SchedulableContext ctx) {
        sendReport();
    }
    
    @Future(Callout=true)
    public static void sendReport(){
        String[] monthList = (System.Label.MonthNameList_Eng).split(';');
        Date yterday = (Date.today()).addMonths(-1);
        String periode = String.valueOf(monthList[yterday.Month()-1] + ' ' + String.valueOf(yterday.Year()));
        String reportListLabel = System.Label.ICF_Sch_Report_List;
        String emailToLabel = System.Label.ICF_Sch_Email_To;
        String emailCCLabel = System.Label.ICF_Sch_Email_CC;
        String emailSubject = System.Label.ICF_Sch_Email_Subject;
        String emailMasking = System.Label.ICF_Sch_Email_Masking;
        String emailBody = (System.Label.ICF_Sch_Email_Body).replace('[Periode]', periode);
        String instanceName = URL.getSalesforceBaseUrl().toExternalForm();
        List<String> reportList = reportListLabel.split(';');
        List<String> emailTo = emailToLabel.split(';');
        List<String> emailCC = emailCCLabel.split(';');
        List<Messaging.EmailFileAttachment> attachmentList = new List<Messaging.EmailFileAttachment>();
        
        // prepare report attachments 
        List<Report> reportIdList = [SELECT Id,DeveloperName,Name FROM Report where DeveloperName in :reportList];
        for (Report report : reportIdList) {
            //ApexPages.PageReference reportPage = new ApexPages.PageReference(instanceName+ '/' + report.Id + '?csv=1');
            ApexPages.PageReference reportPage = new ApexPages.PageReference(instanceName+ '/' + report.Id + '?excel=1');
            //ApexPages.PageReference reportPage = new ApexPages.PageReference(instanceName+ '/servlet/PrintableViewDownloadServlet?isdtp=p1&reportId=' + report.Id);
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            
            attachment.setFileName(report.DeveloperName+'_'+periode+ '.xls');
            attachment.setBody(reportPage.getContent());
            //attachment.setContentType('text/csv');
            attachment.setContentType('application/vnd.ms-excel');
            attachmentList.add(attachment);
        }
        system.debug('attachment list:' + attachmentList);
        
        // setup email attribute
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(emailTo);
        message.setCcAddresses(emailCC);
        message.setSubject(emailSubject);
        message.setHtmlBody(emailBody);
        message.setSenderDisplayName(emailMasking);
        message.setFileAttachments(attachmentList);
		
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
    }
}