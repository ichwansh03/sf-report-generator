public class QroQuickResponseController {
	public Case qc {get; set;}
    public Boolean isQR {get;set;}
    public String caseId {get;set;}
    public Integer qrRescLimit {get;set;}
    
    ApexPages.StandardController controller;
    public Boolean isSave;
    
    public DateTime dtNow;
    public Time tNow;
    public Time maxTimeDaily;
    
    public QroQuickResponseController(ApexPages.StandardController std){
        dtNow = Date.today();
        tNow = Time.newInstance(DateTime.now().hour(), DateTime.now().Minute(), DateTime.Now().Second(), 0);
        Integer maxHour = Integer.valueOf(Label.QuickResponse_MaxHour);
        Integer maxMinute = Integer.valueOf(Label.QuickResponse_MaxMinute);
        maxTimeDaily = Time.newInstance(maxHour, MaxMinute, 0, 0);
        //String IdRequestor = Apexpages.currentPage().getParameters().get('ID');
        String qrRescLimitStr = Label.QuickResponseRescheduleLimit;
        qrRescLimit = Integer.valueOf(qrRescLimitStr);
      	qc = new Case();
        caseId = std.getId();
        system.debug('===Case Id: ' + caseId);
        DescribeSObjectResult dr = Case.getSObjectType().getDescribe();
        List <String> fieldList = new List<String>(dr.fields.getMap().keySet());
        //String fields = String.join(fieldList,',');
        String fields = 'Id, CaseNumber, Date_of_submit__c, Date_of_Service__c, Time_of_Service__c, Unit_of_Request__c, ' +
            'Type_of_Request__c, Service_of_Area__c, address_of_service__c, QR_Status__c, Result_Call__c, Status, ' +
            'Reason_Call__c, Date_off_Call__c, Receiver__c, Name_of_Receiver__c, Type_of_Owner_Policy__c, Description, ' +
            'Materai__c, Questionare_Feedback__c, Souvenir__c, Case_Phone__c, Related_Departments__c, Policy_No__c, ' +
            'Entity__c';
        String qr = 'SELECT '+ fields +' From Case where id = \''+ caseId +'\'';
        system.debug('===query: ' + qr);
        qc = Database.query(qr); 
        qc.Date_Off_Call__c = qc.Date_Off_Call__c == null ? qc.Date_of_submit__c : qc.Date_Off_Call__c;
        DateTime dtToday = DateTime.now();
        isQR = qc.Related_Departments__c == 'Quick Response' ? true : false; 
        //qc.Date_of_Submit__c = dtToday.date();
        //onChangeDateOfService();
        tNow = Time.newInstance(DateTime.now().hour(), DateTime.now().Minute(), DateTime.Now().Second(), 0);
       	List<Case> listServiceDate = new List<Case>();
        listServiceDate = [Select Id, Date_of_Service__c, createdDate from Case where Date_of_Service__c =: qc.Date_of_Service__c and related_departments__c = 'Quick Response' order by Id];
        if (listServiceDate.size() >= qrRescLimit) {
            Case lastCase = listServiceDate[listServiceDate.size()-1];
            if (caseId.equals(lastCase.Id)) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_Quota_Val_4 + ' ' + qc.Date_of_Service__c));
            }
        }
  	} 
    
    public PageReference save() {
        try{ 
            isSave = false;
            collectiveSave();
            if (isSave) {
                //sendEmail();
                PageReference redirectPG = new PageReference('/' + caseId);
                redirectPG.setRedirect(true);
                return redirectPG;
            } else {
                return null;
            }
     	}catch(DmlException ex){
      		ApexPages.addMessages(ex);  //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
      		return null;
    	}
    }
    
    public PageReference cancel() {	
        PageReference redirectPG = new PageReference('/' + caseId);
        redirectPG.setRedirect(true);
        return redirectPG; 
    }
    
    public void collectiveSave() {	
        tNow = Time.newInstance(DateTime.now().hour(), DateTime.now().Minute(), DateTime.Now().Second(), 0);
        List<Case> listServiceDate = new List<Case>();
        listServiceDate = [Select Id, Date_of_Service__c, createdDate from Case where Date_of_Service__c =: qc.Date_of_Service__c and related_departments__c = 'Quick Response' order by Id];
        if(qc.Date_of_Service__c <= qc.Date_of_Submit__c){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_DOS_Val_1 + ' ' + Date.Today()));
            return;
        } else {
            if(listServiceDate.size() > qrRescLimit){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_Quota_Val_3 + ' ' + qc.Date_of_Service__c));
                return;
            }
        }
        
        if (qc.Status.equalsIgnoreCase('Closed') && qc.Description == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_Desc_Val_1));
            return;
        }
        
        List<Case> forSaveList = new List<Case>();
        Case qcs =  new Case();
        qcs.Id = qc.Id;
        qcs.Date_of_Service__c = qc.Date_of_Service__c;
        qcs.Time_of_Service__c = qc.Time_of_Service__c;
        qcs.Service_of_Area__c = qc.Service_of_Area__c;
        qcs.address_of_service__c = qc.address_of_service__c;
        qcs.Case_Phone__c = qc.Case_Phone__c;
        qcs.QR_Status__c = qc.QR_Status__c;
        qcs.Result_Call__c = qc.Result_Call__c;
        qcs.Reason_Call__c = qc.Reason_Call__c;
        qcs.Date_Off_Call__c = qc.Date_Off_Call__c;
        qcs.Receiver__c = qc.Receiver__c;
        qcs.Name_of_Receiver__c = qc.Name_of_Receiver__c;
        qcs.Type_of_Owner_Policy__c = qc.Type_of_Owner_Policy__c;
        qcs.Materai__c = qc.Materai__c;
        qcs.Questionare_Feedback__c = qc.Questionare_Feedback__c;
        qcs.Souvenir__c = qc.Souvenir__c;
        qcs.Status = qc.Status;
        qcs.Description = qc.Description;
        forSaveList.add(qcs);
        update forSaveList;
        isSave = true;
    }
    
    public PageReference onChangeDateOfService(){
        tNow = Time.newInstance(DateTime.now().hour(), DateTime.now().Minute(), DateTime.Now().Second(), 0);
       	List<Case> listServiceDate = new List<Case>();
        listServiceDate = [Select Id, Date_of_Service__c, createdDate from Case where Date_of_Service__c =: qc.Date_of_Service__c and related_departments__c = 'Quick Response' order by Id];
        if(qc.Date_of_Service__c <= Date.today()){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_DOS_Val_1 + ' ' + Date.Today()));
        } 
        
        if (listServiceDate.size() >= qrRescLimit) {
            Case lastCase = listServiceDate[listServiceDate.size()-1];
            if (caseId.equals(lastCase.Id)) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, Label.QR_Quota_Val_4 + ' ' + qc.Date_of_Service__c));
            }
        }
        return null;
    }
    
    public PageReference onChangeReceiver() {
        if (qc.Receiver__c == 'Diri Sendiri') {
            Contact c = [select id, LastName from Contact where policy_no__c = :qc.Policy_No__c];
            qc.Name_of_Receiver__c = c.LastName;
            qc.Type_of_Owner_Policy__c = 'PBC';
        } else {
            qc.Name_of_Receiver__c = null;
            qc.Type_of_Owner_Policy__c = null;
        }
        return null;
    }
    
    public PageReference onChangeRelatedDepartment() {
        qc.Related_Departments__c = 'Quick Response';
        return null;
    }
}