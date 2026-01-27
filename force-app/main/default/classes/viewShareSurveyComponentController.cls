public with sharing class viewShareSurveyComponentController {

    public List<SelectOption> urlType {get;set;}
    public List<Selectoption> sitesPicklist {get; set;}
    public Survey__c mySurvey {get;set;}
    public String selectedURLType {get;set;}
    public String POD {get; set;}
    public String surveySite {get; set;}
    public String showAddSitesMessage {get; set;}
    public String siteInfo {get; set;}
    private String subdomain;
    private boolean useTopLevelDomain;
    
    private static final String CHATTER = 'Chatter';
    private static final String EMAIL_ANON = 'Email Link, Anonymous';
    private static final String EMAIL_CONTACT_MERGE = 'Email Link w/ Contact Merge';
    private static final String EMAIL_CONTACT_CASE_MERGE = 'Email Link w/ Contact & Case Merge';
    private static final String EMPTY = 'EMPTY';
    private static final String INTERNAL = 'Internal';
    private static final String NO_POD = 'NO_POD';
    private static final String PUBLIC_SURVEY = 'Public_Survey';
    private static final String SALESFORCE = 'salesforce';
    private static final String SELECT_SITE = '--SELECT SITE--';
    private static final String SURVEY_PUBLIC_SITE = 'survey';
    private static final String TAKE_SURVEY_VF = 'TakeSurvey';
    private static final String VISUAL = 'visual';
    
    /* add new survey record type nov 2024*/
    private static final String TAKE_SURVEY_DYNAMIC_VF = 'TakeSurveyDynamic';
    private String RecordType;
    
    public Id surveyId {
        get;
        set {
            this.surveyId = value;
            init();
        }
    }
    
    public String surveyURL {
        get {
            if (selectedURLType == EMAIL_ANON || selectedURLType == CHATTER) {
                return 'id=' + surveyId + '&cId=none&caId=none';
            }
            else if (selectedURLType == EMAIL_CONTACT_MERGE) {
                return 'id=' + surveyId + '&cId={!Contact.Id}&caId=none';
            }
            else {
                return 'id=' + surveyId +  '&cId={!Contact.Id}&caId={!Case.id}';
            }
        }
        set;
    }
    
    public String surveyURLBase {
        get {
            if (surveySite == SELECT_SITE) {
                POD = '';
                return null;
            }
            String urlPrefix = setupUrlPrefix(surveySite);
            String domain = setupDomainForSurvey(POD);
            String urlToSave = domain + '/' + urlPrefix + TAKE_SURVEY_VF + '?';
            if(RecordType == 'Master New Onboarding') urlToSave = domain + '/' + urlPrefix + TAKE_SURVEY_DYNAMIC_VF + '?';
            
            if (surveySite == INTERNAL || selectedURLType == CHATTER) {
                urlToSave = URL.getSalesforceBaseUrl().toExternalForm() + '/apex/' + TAKE_SURVEY_VF + '?';
                if(RecordType == 'Master New Onboarding') urlToSave = URL.getSalesforceBaseUrl().toExternalForm() + '/apex/' + TAKE_SURVEY_DYNAMIC_VF + '?';
                System.debug(LoggingLevel.DEBUG, '*** ENTER INTERNAL SITE: ' + urlToSave);
            }
            /*
            * Rival - 2016/12/14 - API: 38
            * get sites link. ref: http://salesforce.stackexchange.com/questions/7639/get-site-url-from-apex
            */
            else if (surveySite == SURVEY_PUBLIC_SITE) {
                Site site = [SELECT GuestUserId FROM Site WHERE UrlPathPrefix = :surveySite LIMIT 1];
                String path = '/sites/servlet.SiteDebugMode';
                PageReference pr = new PageReference(path);
                pr.getParameters().put('guid', site.GuestUserId);
                pr.getParameters().put('sitedebugmode', 'x');
                String url = null;
                if (!Test.isRunningTest()) {
                    url = pr.getContent().toString().substringAfter('URL=').substringBefore(path);
                }
                else {
                    Blob content = Blob.valueOf('URL=http://crm-axaindonesia.cs5.force.com/survey/sites/servlet.SiteDebugMode?sitedebugmode=x&amp;rand=85071');
                    url = content.toString().substringAfter('URL=').substringBefore(path);
                }
                urlToSave = url + '/' + TAKE_SURVEY_VF + '?';
                if(RecordType == 'Master New Onboarding') urlToSave =  url + '/' + TAKE_SURVEY_DYNAMIC_VF + '?';
                
                System.debug(LoggingLevel.DEBUG, '*** ENTER PUBLIC SITE: ' + urlToSave);
            }
            
            return urlToSave;
        }
        set;
    }
    
    public viewShareSurveyComponentController() {
        urlType = new List<SelectOption>();
        /* 
        urlType.add(new SelectOption('Email Link w/ Contact Merge',System.Label.LABS_SF_Email_Link_w_Contact_Merge));
        urlType.add(new SelectOption('Email Link w/ Contact & Case Merge',System.Label.LABS_SF_Email_Link_w_Contact_Case_Merge));
        urlType.add(new SelectOption('Email Link, Anonymous',System.Label.LABS_SF_Email_Link_Anonymous));
        urlType.add(new SelectOption('Chatter',System.Label.LABS_SF_Chatter)); 
        */
        
        urlType.add(new SelectOption(EMAIL_ANON,EMAIL_ANON));
        selectedURLType = EMAIL_ANON;
        
        setupPOD();
        setupSitesPicklist();
        siteInfo = Site.getDomain();
        
        init();
    }
    
    private void setupPOD() {
        String urlToSplit = URL.getSalesforceBaseUrl().toExternalForm();
        List<String> splitURL = urlToSplit.split('\\.');
        Integer loc = -1;
        Integer i;
        
        for (i = 0; i < splitURL.size(); i++) {
            if (splitURL.get(i) == VISUAL || splitURL.get(i)  == SALESFORCE) {
                loc = i - 1;
                break;
            }
        }
        
        if (loc == -1) {
            pod = NO_POD;
            return;
        }
        
        if(splitURL.get(loc + 1) == VISUAL) {
            pod = splitURL.get(loc);
        }
        else {
            pod = NO_POD;
        }
    }
    
    private void setupSitesPicklist() {
        
        List<SurveySitesUtil.SurveySiteInfo> sites = new SurveySitesUtil().getSiteList();
        
        if (sites.size() > 0) {
            subdomain = sites[0].Subdomain;
        } 
        useTopLevelDomain = false;
        String pathPrefix;
        sitesPicklist = new List<Selectoption>();
        sitesPicklist.add(new Selectoption(INTERNAL, System.Label.LABS_SF_Internal));
        
        for(SurveySitesUtil.SurveySiteInfo current : sites) {
            if(current.prefix == null) 
                pathPrefix = EMPTY;
            else 
                pathPrefix = current.prefix;
            sitesPicklist.add(new Selectoption(pathPrefix, current.Name));
        }
        
        surveySite = INTERNAL;
    }
    
    public String setupDomainForSurvey(String pod) {
        if(pod != NO_POD && !useTopLevelDomain && checkSubdomain(subdomain)){
            return 'http://'+subdomain+'.'+pod+'.force.com';
        }
        else if(pod != NO_POD && useTopLevelDomain && checkSubdomain(subdomain)){
            return 'http://'+subdomain+'.'+pod;
        }
        else if(useTopLevelDomain) {
            return 'http://'+subdomain;
        }
        else{
            return 'http://'+subdomain+'.force.com';
        }
    }
      
    public boolean checkSubdomain(String subdomain) {
        if(subdomain == null)
            return false;
        else if (subdomain.contains('developer-edition'))
            return true;
        else
            return false;
    }
      
    public String setupUrlPrefix(String site) {
        if(site == null || site == EMPTY)
            return '';
        else
            return site + '/';
    }
    
    public void init() {
        if (surveyId != null) {
            mySurvey = [Select Id, Name, Survey_Header__c, thankYouText__c, thankYouLink__c, URL__c, RecordType.Name FROM Survey__c where Id=:surveyId];
            RecordType = mySurvey.RecordType.Name;
        }
    }
}