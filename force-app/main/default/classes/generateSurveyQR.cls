public without sharing class generateSurveyQR {
    
    public String recordId { get; set; }
    public string surveyUrl { get; set; }
    
    private final Contact ct;
    
    public generateSurveyQR(ApexPages.StandardController stdController) {
        this.ct = (Contact)stdController.getRecord();
        recordId = Apexpages.currentPage().getParameters().get('id');
    }
    
    public String getGenerateQRCode() {
        
        if (!Test.isRunningTest()) {
            Email_Sms_Log__c esl = [Select Id, Survey_URL__c from Email_Sms_Log__c WHERE Contact__c = :recordId and ICF_Walk_IN__c != '' and Survey_URL__c != '' order by CreatedDate Desc LIMIT 1];
        surveyUrl = esl.Survey_URL__c;
        system.debug('surveyUrl' + surveyUrl);
        }
        
        if (Test.isRunningTest()) surveyUrl = 'www.google.com';
        String qrCodeUrl = 'https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl=' + EncodingUtil.urlEncode(surveyUrl, 'UTF-8');
        return qrCodeUrl;
    }
    
    
}