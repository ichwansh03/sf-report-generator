global class QuickResponseEmailSchedule implements Schedulable{
   
    global void execute(SchedulableContext SC) {
        try{
            system.debug('Start Execute');
            //Date tomorrow = Date.today().addDays(+1);
            DateTime dtToday = DateTime.now();
            String todayName = dtToday.format('EEEE');
            Date dosGet = todayName == 'Friday' ? Date.today().addDays(3) : Date.today().addDays(1);
            system.debug('TODAY IS: ' + todayName);
            List<Case> listQc = [SELECT id, CaseNumber, Related_Department__c, Date_of_Service__c from Case where Date_of_Service__c = :dosGet];
            String recipient = System.LABEL.QuickResponse_EmailTo;
            String masking = System.LABEL.QuickResponse_EmailFrom;
            String[] to = recipient.trim().split(';');
            String subject = System.LABEL.QuickResponse_EmailSubject;
            String body = System.LABEL.QuickResponse_EmailBody;
            for(Case qc : listQc){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                string urlQRO = '<html><a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + qc.Id + '">' + qc.Related_Departments__c + ' Case ' + qc.CaseNumber + '</a></html>';
                email.setSenderDisplayName(masking); email.setSubject(subject); email.setHtmlBody(body + urlQro); email.setToAddresses(to);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                system.debug('End Execute');
            }
        } catch (Exception e){
             System.debug('FAILED SEND EMAIL : ' +  e.getMessage());
        }

    }
    
}