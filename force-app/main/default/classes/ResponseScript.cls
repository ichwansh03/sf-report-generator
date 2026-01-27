public class ResponseScript {
    public String responseId {get;set;}
    public String callLineId {get;set;}
    public String answer1 {get;set;}
    public String answer2 {get;set;}
    public String answer3 {get;set;}
    public String answer4 {get;set;}
    public String question1 {get;set;}
    public String question2 {get;set;}
    public String question3 {get;set;}
    public String question4 {get;set;}
    public String parent {get;set;}
    public String note {get;set;}
    public Boolean isValid {get;set{isValid = value != null ?value : false;}}
    public String tab {get;set;}
    public String section {get;set;}
    
    public String address1 {get;set;}
    public String address2 {get;set;}
    public String address3 {get;set;}
    public String address4 {get;set;}
    public String email {get;set;}
    public String other {get;set;}
    public String surveyTaker {get;set;}
    public String defNext {get;set;}
    public String defPrev {get;set;}
    
    public ResponseScript(){
        
    }
    
    public ResponseScript(Survey_Response__c res){
        this.responseId = res.Id;
        this.callLineId = res.WelcomeCall_Call_Line__c;
        this.answer1 = res.Answer_1__c;
        this.answer2 = res.Answer_2__c;
        this.answer3 = res.Answer_3__c;
        this.answer4 = res.Answer_4__c;
        this.question1 = res.Question_1__c;
        this.question2 = res.Question_2__c;
        this.question3 = res.Question_3__c;
        this.question4 = res.Question_4__c;
        this.note = res.WelcomeCall_Note__c == null ? null : res.WelcomeCall_Note__c.escapeHtml4().replaceAll('\\n','&#13;');
        //this.note = res.WelcomeCall_Note__c;
        /*
        if(this.note != null){
            if(this.note.contains('\'')){
                this.note = this.note.replaceAll('\'','&#039;');
            }
            if(this.note.contains('\n')){
                this.note = this.note.replaceAll('\\n','&#13;');
            }
            if(this.note.contains('\"')){
                this.note = this.note.replaceAll('\"','&quot;');
            }
        }
        */
        this.tab = res.WelcomeCall_Tab__c;
        this.section = res.WelcomeCall_Section__c;
        this.surveyTaker = res.SurveyTaker__c;
        this.other = res.WelcomeCall_Others__c;
        this.address1 = res.WelcomeCall_Address_1__c;
        this.address2 = res.WelcomeCall_Address_2__c;
        this.address3 = res.WelcomeCall_Address_3__c;
        this.address4 = res.WelcomeCall_Address_4__c;
        this.email = res.WelcomeCall_Email__c;
    }
}