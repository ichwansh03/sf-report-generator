public with sharing class SurveyManagerController {
    private ApexPages.StandardController stdControl;
    public Boolean editCSS;
    public Boolean isMaster{get; set;}
    public Survey__c surveyObj{get; set;}
    public String surveyQuery{get; set;}
    
    public Blob imgValue1{get; set;}
    public Blob imgValue2{get; set;}
    public Blob imgValue3{get; set;}
    public Blob imgValue4{get; set;}
    public Blob imgValue5{get; set;}
    //addition 05/04/2018
    public Blob imgValue6{get;set;}
    public Blob imgValue7{get;set;}
    public Blob imgValue8{get;set;}
    public Blob imgValue9{get;set;}
    public Blob imgValue10{get;set;}
    public Blob imgValue11{get;set;}
    
    public String imgURL1{get; set;}
    public String imgURL2{get; set;}
    public String imgURL3{get; set;}
    public String imgURL4{get; set;}
    public String imgURL5{get; set;}
    //addition 05/04/2018
    public String imgURL6{get; set;}
    public String imgURL7{get; set;}
    public String imgURL8{get; set;}
    public String imgURL9{get; set;}
    public String imgURL10{get; set;}
    public String imgURL11{get; set;}
    
    private static final String ACTIVE = 'Active';
    private static final String MASTER = 'Master';
    
    public Boolean getEditCSS(){
        return editCSS;
    } 
    
    public SurveyManagerController(ApexPages.StandardController stdController) {
        this.stdControl = stdController;
        String surveyId = this.stdControl.getId();
        surveyObj = (Survey__c) this.stdControl.getRecord();
        
        DescribeSObjectResult describeResultSurvey = Survey__c.getSObjectType().getDescribe();
        List<String> surveyFieldList = new List<String>(describeResultSurvey.fields.getMap().keySet());
        String surveyFields = String.join(surveyFieldList, ',');
        String surveyQuery = ' SELECT ' + surveyFields + ' FROM Survey__c WHERE Id = :surveyId ';
        Survey__c surveyCheck = Database.query(surveyQuery);
        
        List<User> res = [SELECT Profile.PermissionsAuthorApex FROM User WHERE id=:Userinfo.getUserId()];
        User u = res[0];
        if (u.Profile.PermissionsAuthorApex) {
            this.editCSS = true;
        }
        else {
            this.editCSS = false;
        }
        
        surveyQuery = ' SELECT Id, Name, RecordType.Name FROM Survey__c WHERE Id = :surveyId LIMIT 1 ';
        Survey__c survey = Database.query(surveyQuery);
        isMaster = false;
        
        // if (survey.RecordType.Name.equals(MASTER)) {
        if (survey.RecordType.Name.contains(MASTER)) {
            isMaster = true;
        }
        else {
            String surveyType = surveyObj.Survey_Type__c;
            // surveyQuery = ' SELECT Id, Name, RecordType.Name FROM Survey__c WHERE RecordType.Name = :MASTER AND Survey_Type__c = :surveyType AND Status__c = :ACTIVE LIMIT 1 ';
            surveyQuery = ' SELECT Id, Name, RecordType.Name FROM Survey__c WHERE RecordType.Name like \'%'+MASTER+'%\'  AND Survey_Type__c = :surveyType AND Status__c = :ACTIVE LIMIT 1 ';
            Survey__c masterSurvey = Database.query(surveyQuery);
            if (masterSurvey != null) {
                //surveyObj.Master_Survey__c = masterSurvey.Id;
            }
        }
        
        if (surveyCheck != null) {
            if (surveyCheck.Answer_Image_1__c != null) {
                String url1 = 'data:image;base64,' + surveyCheck.Answer_Image_1__c;
                imgURL1 = url1;
            }
            if (surveyCheck.Answer_Image_2__c != null) {
                String url2 = 'data:image;base64,' + surveyCheck.Answer_Image_2__c;
                imgURL2 = url2;
            }
            if (surveyCheck.Answer_Image_3__c != null) {
                String url3 = 'data:image;base64,' + surveyCheck.Answer_Image_3__c;
                imgURL3 = url3;
            }
            if (surveyCheck.Answer_Image_4__c != null) {
                String url4 = 'data:image;base64,' + surveyCheck.Answer_Image_4__c;
                imgURL4 = url4;
            }
            if (surveyCheck.Answer_Image_5__c != null) {
                String url5 = 'data:image;base64,' + surveyCheck.Answer_Image_5__c;
                imgURL5 = url5;
            }
            if (surveyCheck.Answer_Image_6__c != null) {
                String url6 = 'data:image;base64,' + surveyCheck.Answer_Image_6__c;
                imgURL6 = url6;
            }
            if (surveyCheck.Answer_Image_7__c != null) {
                String url7 = 'data:image;base64,' + surveyCheck.Answer_Image_7__c;
                imgURL7 = url7;
            }
            if (surveyCheck.Answer_Image_8__c != null) {
                String url8 = 'data:image;base64,' + surveyCheck.Answer_Image_8__c;
                imgURL8 = url8;
            }
            if (surveyCheck.Answer_Image_9__c != null) {
                String url9 = 'data:image;base64,' + surveyCheck.Answer_Image_9__c;
                imgURL9 = url9;
            }
            if (surveyCheck.Answer_Image_10__c != null) {
                String url10 = 'data:image;base64,' + surveyCheck.Answer_Image_10__c;
                imgURL10 = url10;
            }
            if (surveyCheck.Answer_Image_11__c != null) {
                String url11 = 'data:image;base64,' + surveyCheck.Answer_Image_11__c;
                imgURL11 = url11;
            }
        }
    }
    
    public PageReference refreshMasterSurvey() {
        String surveyType = surveyObj.Survey_Type__c;
        String containsMaster = '%'+MASTER+'%';
        //List<Survey__c> masterSurveys = [SELECT Id, Name, RecordType.Name FROM Survey__c WHERE RecordType.Name = :MASTER AND Survey_Type__c = :surveyType AND Status__c = :ACTIVE LIMIT 1];
        List<Survey__c> masterSurveys = [SELECT Id, Name, RecordType.Name FROM Survey__c WHERE RecordType.Name like :containsMaster AND Survey_Type__c = :surveyType AND Status__c = :ACTIVE LIMIT 1];
        
        if (masterSurveys.size() > 0) {
            surveyObj.Master_Survey__c = masterSurveys[0].Id;
        }
        else {
            surveyObj.Master_Survey__c = null;
        }
        return null;
    }
    
    public PageReference save() {
        System.debug(LoggingLevel.DEBUG, '*** IMG1: ' + imgValue1);
        System.debug(LoggingLevel.DEBUG, '*** IMG2: ' + imgValue2);
        System.debug(LoggingLevel.DEBUG, '*** IMG3: ' + imgValue3);
        System.debug(LoggingLevel.DEBUG, '*** IMG4: ' + imgValue4);
        System.debug(LoggingLevel.DEBUG, '*** IMG5: ' + imgValue5);
        System.debug(LoggingLevel.DEBUG, '*** IMG6: ' + imgValue6);
        System.debug(LoggingLevel.DEBUG, '*** IMG7: ' + imgValue7);
        System.debug(LoggingLevel.DEBUG, '*** IMG8: ' + imgValue8);
        System.debug(LoggingLevel.DEBUG, '*** IMG9: ' + imgValue9);
        System.debug(LoggingLevel.DEBUG, '*** IMG10: ' + imgValue10);
        System.debug(LoggingLevel.DEBUG, '*** IMG10: ' + imgValue11);        
        
        if (imgValue1 != null) {
            String tempImage1 = EncodingUtil.base64Encode(imgValue1);
            surveyObj.Answer_Image_1__c = tempImage1;
        }
        if (imgValue2 != null) {
            String tempImage2 = EncodingUtil.base64Encode(imgValue2);
            surveyObj.Answer_Image_2__c = tempImage2;
        }
        if (imgValue3 != null) {
            String tempImage3 = EncodingUtil.base64Encode(imgValue3);
            surveyObj.Answer_Image_3__c = tempImage3;
        }
        if (imgValue4 != null) {
            String tempImage4 = EncodingUtil.base64Encode(imgValue4);
            surveyObj.Answer_Image_4__c = tempImage4;
        }
        if (imgValue5 != null) {
            String tempImage5 = EncodingUtil.base64Encode(imgValue5);
            surveyObj.Answer_Image_5__c = tempImage5;
        }
        if (imgValue6 != null) {
            String tempImage6 = EncodingUtil.base64Encode(imgValue6);
            surveyObj.Answer_Image_6__c = tempImage6;
        }
        if (imgValue7 != null) {
            String tempImage7 = EncodingUtil.base64Encode(imgValue7);
            surveyObj.Answer_Image_7__c = tempImage7;
        }
        if (imgValue8 != null) {
            String tempImage8 = EncodingUtil.base64Encode(imgValue8);
            surveyObj.Answer_Image_8__c = tempImage8;
        }
        if (imgValue9 != null) {
            String tempImage9 = EncodingUtil.base64Encode(imgValue9);
            surveyObj.Answer_Image_9__c = tempImage9;
        }
        if (imgValue10 != null) {
            String tempImage10 = EncodingUtil.base64Encode(imgValue10);
            surveyObj.Answer_Image_10__c = tempImage10;
        }
        if (imgValue11 != null) {
            String tempImage11 = EncodingUtil.base64Encode(imgValue11);
            surveyObj.Answer_Image_11__c = tempImage11;
        }
        
        System.debug(LoggingLevel.DEBUG, '*** RESULT1: ' + surveyObj.Answer_Image_1__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT2: ' + surveyObj.Answer_Image_2__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT3: ' + surveyObj.Answer_Image_3__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT4: ' + surveyObj.Answer_Image_4__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT5: ' + surveyObj.Answer_Image_5__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT6: ' + surveyObj.Answer_Image_6__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT7: ' + surveyObj.Answer_Image_7__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT8: ' + surveyObj.Answer_Image_8__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT9: ' + surveyObj.Answer_Image_9__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT10: ' + surveyObj.Answer_Image_10__c);
        System.debug(LoggingLevel.DEBUG, '*** RESULT10: ' + surveyObj.Answer_Image_11__c);
        return stdControl.save();
    }
}