public class CommonClass {
    List<Holiday> holidays {get;set;}
    
    public CommonClass(){
        holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
    }
    
    public Integer calculateWorkingDaysBetweenTwoDates(Date date1,Date date2){
        Integer allDaysBetween = date1.daysBetween(date2);
        Integer allWorkingDays=0;
        for(Integer k=0;k<allDaysBetween ;k++ ){
            //if(checkifItisWorkingDay(date1.addDays(k),holidays)){
            if(checkifItisWorkingDay(date1.addDays(k))){
                allWorkingDays++;
            } 
        }

        return allWorkingDays;
    }

    //public boolean checkifItisWorkingDay(Date currentDate,List<Holiday> holidays){
    public boolean checkifItisWorkingDay(Date currentDate){
        Date weekStart  = currentDate.toStartofWeek();
        for(Holiday hDay:holidays){
            if(currentDate.daysBetween(hDay.ActivityDate) == 0){
                     return false;
            }
        }
        if(weekStart.daysBetween(currentDate) ==0 || weekStart.daysBetween(currentDate) == 6){
            return false;
        } else { 
            return true;
        }
    }

    /*
    public void doSendEmail(string emailAddr, string subject, string body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string[] toAddresses = new String[] {emailAddr};
        mail.setToAddresses(toAddresses);

        mail.setSubject(subject);

        mail.setPlainTextBody(subject);
        mail.setHtmlBody(subject);

        system.debug(''+Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }));    
    }
    public Boolean doSendEmail(string toEmailAddr, string fromEmailAddr, string templateId, string entity) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string[] toAddresses = new String[] {toEmailAddr};
        mail.setToAddresses(toAddresses);
        mail.setReplyTo(fromEmailAddr);
        mail.setSenderDisplayName('Customer '+entity);
        mail.setSaveAsActivity(false); 
        mail.setTemplateId(templateId);
        //mail.setTargetObjectId('003O000000fdbtB');
        List<Messaging.SendEmailResult> emailResult = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        boolean isEmailSendingSuccess = emailResult[0].isSuccess(); 
        system.debug('>> message sending result : '+isEmailSendingSuccess);  
        return  isEmailSendingSuccess; 
    }
    */

	@future(callout=true)
	public static void callWS(String caseidarr){
		system.debug('>>> caseidarr : '+caseidarr);
		PolicyDetailController controller = new PolicyDetailController();
		List<string> caseIdList = caseidarr.split('::');
		List<case> caseList = [select id, e2cSubject__c, e2cPolicy_No__c, e2cPayToDate__c, e2cNAV__c, e2cSaldo__c, e2cContactId__c  from case where createddate > 2014-12-31T23:59:59Z and id in :caseIdList];
		string nav = '';
		for(Case cs : caseList){
			system.debug('>>> cs.e2cContactId__c : '+cs.e2cContactId__c);
			controller.contactId = cs.e2cContactId__c;
			system.debug('>>> controller.contactId : '+controller.contactId);
			if(Test.isRunningTest()){
				controller.polisRider.MataUang = 'Rp';
				controller.detailFund.TotFundAmount = Decimal.valueOf('10000');
				controller.polisRider.DueDate1 = system.today();
				controller.detailFundList = new List<PolicyDetailController.DetailFund>();
			}else{
				try{
					controller.callDataviaWS();
				} catch(CalloutException e){
					try {
						controller.callDataviaWS();
					}catch(CalloutException e2){
						controller.callDataviaWS();
					}
				}
			}
			system.debug('>>> controller.contactId : '+controller.contactId);
			if(cs.e2cSubject__c.indexof('SALDO')!=-1){
				cs.e2cSaldo__c =  controller.polisRider.MataUang +' '+controller.detailFund.TotFundAmount;
				system.debug('>>> cs.e2cSaldo__c : '+cs.e2cSaldo__c);
			}else if(cs.e2cSubject__c.indexof('PAY')!=-1){
				system.debug('>>> controller.polisRider.DueDate1 : '+controller.polisRider.DueDate1);
				system.debug('>>> controller.polisRider.DueDate2 : '+controller.polisRider.DueDate2);
				//cs.e2cPayToDate__c = ''+(controller.polisRider.DueDate1!=null? controller.polisRider.DueDate1: controller.polisRider.DueDate2);
				string datestr = ''+(controller.polisRider.DueDate1!=null? controller.polisRider.DueDate1: controller.polisRider.DueDate2);
				cs.e2cPayToDate__c = datestr.length()>10? datestr.substring(0,10):datestr;
				system.debug('>>> cs.e2cPayToDate__c : '+cs.e2cPayToDate__c);
			}else if(cs.e2cSubject__c.indexof('NAV')!=-1){
				List<PolicyDetailController.DetailFund> detailFundList = controller.detailFundList;
				nav = '';
				nav = '<table border = \'1\' width=\'250px\'><tr><td>Fund Code</td><td>Fund Price</td></tr>';
				for(PolicyDetailController.DetailFund fund : detailFundList){
					if(fund.FundCode == '0'){
						break;
					}
					nav = nav + '<tr><td>'+fund.FundCode+'</td><td>'+fund.FundPrice+'</td></tr>';	
				}
				nav = nav + '</table>';
				cs.e2cNAV__c = nav;
				system.debug('>>> cs.e2cNAV__c : '+cs.e2cNAV__c);
			}
		}
		update caseList;
	}
    
}