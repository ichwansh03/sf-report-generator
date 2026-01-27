public without sharing class ALIDashBoardEmailController {

    public datetime LastOpenEmailAll {get; set;}
    public datetime FirstOpenEmailAll {get; set;}
    public integer CountOpenCaseAll {get; set;}
    public integer CountClosedCaseAll {get; set;}
    public String LastOpenEmailAllID {get; set;}
    public String FirstOpenEmailAllID {get; set;}
    public String LastOpenEmailAllNumber {get; set;}
    public String FirstOpenEmailAllNumber {get; set;}

    public datetime LastOpenEmailAgent {get; set;}
    public datetime FirstOpenEmailAgent {get; set;}
    public integer CountOpenCaseAgent {get; set;}
    public integer CountClosedCaseAgent {get; set;}
    public String LastOpenEmailAgentID {get; set;}
    public String FirstOpenEmailAgentID {get; set;}
    public String LastOpenEmailAgentNumber {get; set;}
    public String FirstOpenEmailAgentNumber {get; set;}

    public Double offset {get {
        TimeZone tz = UserInfo.getTimeZone();
        //Milliseconds to Day
        return tz.getOffset(Datetime.now()) / (1000 * 3600 * 24.0);
    }}
    
    public ALIDashBoardEmailController(){
        String DataId = ApexPages.currentPage().getParameters().get('id');
        String RecordType = ApexPages.currentPage().getParameters().get('RecordType');
    id Userid = userInfo.getUserId();
        User us = [SELECT id, Entity__c FROM User 
                   WHERE id =: UserId];
        
        String Entity = us.Entity__c;
        list<String> StatusEmail = new list<String>();
        list<String> StatusCase = new list<String>();
        //Read --> 1
        //Replied --> 2
        //Sent --> 3
        //Forwarder --> 4
        //Draft --> 5

        StatusEmail.add('1');
        StatusCase.add('New');        
        StatusCase.add('Escalated');
        StatusCase.add('On Hold');        
        
        List<EmailMessage> em;
        em = [SELECT ParentId, Parent.CaseNumber, CreatedDate FROM EmailMessage 
              WHERE Parent.Entity__c =: Entity and Parent.Status IN: StatusCase 
              and Status IN: StatusEmail Order by CreatedDate Desc Limit 1];
        if (em.size() > 0) {
            LastOpenEmailAll = em[0].CreatedDate;
            LastOpenEmailAllID = em[0].ParentId;
            LastOpenEmailAllNumber = em[0].Parent.CaseNumber;

        }
        
        em = [SELECT ParentId, Parent.CaseNumber, CreatedDate FROM EmailMessage 
              WHERE Parent.Entity__c =: Entity 
              and Parent.Status IN: StatusCase and Status IN: StatusEmail Limit 1];
        if (em.size() > 0) {
            FirstOpenEmailAll = em[0].CreatedDate;
            FirstOpenEmailAllID = em[0].ParentId;
            FirstOpenEmailAllNumber = em[0].Parent.CaseNumber;
        }
    
        CountOpenCaseAll = [SELECT count() FROM EmailMessage 
                            WHERE Parent.Entity__c =: Entity 
                            and Parent.Status IN: StatusCase and Status IN: StatusEmail];
        CountClosedCaseAll = [SELECT count() FROM EmailMessage 
                              WHERE Parent.Entity__c =: Entity 
                              and Parent.Status NOT IN: StatusCase and Status IN: StatusEmail and CreatedDate = Today];
    
        em = [SELECT ParentId, Parent.CaseNumber, CreatedDate FROM EmailMessage 
              WHERE Parent.Entity__c =: Entity and Parent.Status IN: StatusCase 
              and Status IN: StatusEmail and Parent.OwnerId =: Userid Order by CreatedDate Desc Limit 1];
        if (em.size() > 0) {    
            LastOpenEmailAgent = em[0].CreatedDate;
            LastOpenEmailAgentID = em[0].ParentId;
            LastOpenEmailAgentNumber = em[0].Parent.CaseNumber;
        }
    
        em = [SELECT ParentId, Parent.CaseNumber, CreatedDate FROM EmailMessage 
              WHERE Parent.Entity__c =: Entity and Parent.Status IN: StatusCase 
              and Status IN: StatusEmail and Parent.OwnerId =: Userid Limit 1];
        if (em.size() > 0) {
            FirstOpenEmailAgent = em[0].CreatedDate;
            FirstOpenEmailAgentID = em[0].ParentId;
            FirstOpenEmailAgentNumber = em[0].Parent.CaseNumber;
        }
        CountOpenCaseAgent = [SELECT count() FROM EmailMessage 
                              WHERE Parent.Entity__c =: Entity 
                              and Parent.Status IN: StatusCase and Status IN: StatusEmail and Parent.OwnerId =: Userid];
        CountClosedCaseAgent = [SELECT count() FROM EmailMessage 
                                WHERE Parent.Entity__c =: Entity 
                                and Parent.Status NOT IN: StatusCase and Status IN: StatusEmail and CreatedDate = Today and Parent.OwnerId =: Userid];


  }
        
}