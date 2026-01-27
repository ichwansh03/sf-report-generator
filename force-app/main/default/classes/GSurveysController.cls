global with sharing class GSurveysController {
    public List<miniSurvey>allSurveys {get; set;}
    public List<Selectoption> sitesPicklist {get; set;}
    public String surveyDelete {get; set;}
    public String newSurveyName {get; set;}
    public String username {get; set;}
    public String userId {get; set;}
    public String POD {get; set;}
    public String surveySite {get; set;}
    public String showAddSitesMessage {get; set;} 
    public String siteInfo {get; set;}
    private String subdomain;
    private boolean useTopLevelDomain;
    
    private static final String EMPTY = 'EMPTY';
    private static final String INTERNAL = 'Internal';
    private static final String PUBLIC_SURVEY = 'Public_Survey';
    private static final String SELECT_SITE = '--SELECT SITE--';
    private static final String SURVEY_MANAGER_PAGE_VF = 'SurveyManagerPage';
    private static final String SURVEY_PUBLIC_SITE = 'survey';
    private static final String TAKE_SURVEY_VF = 'TakeSurvey';
    private static final String THANK_YOU_LINK_SF = 'http://www.salesforce.com';
    private static final String THANK_YOU_LINK_AXA = 'http://www.axa.co.id';
	
	public GSurveysController(ApexPages.StandardController stdController){
        username = System.Userinfo.getUserId();
        setAllSurveys();
        setupSitesPicklist();
        siteInfo = Site.getDomain();
        
        surveySite = SURVEY_PUBLIC_SITE;
	}
    
	private void setupSitesPicklist(){
        List<SurveySitesUtil.SurveySiteInfo> sites = new SurveySitesUtil().getSiteList();
        
        if (sites.size() > 0) {
            subdomain = sites[0].Subdomain;
        }
        useTopLevelDomain = false;
        String pathPrefix;
        sitesPicklist = new List<Selectoption>();
		//List<Site> sites = [select Name, Subdomain, TopLevelDomain, UrlPathPrefix from Site where Status = 'Active' ];
    	//setupDomain(sites);
        setupShowSites(sites.size());
        sitesPicklist.add(new Selectoption(SELECT_SITE, System.Label.LABS_SF_SELECTSITE ));
        sitesPicklist.add(new Selectoption(INTERNAL, System.Label.LABS_SF_Internal));
        
		for (SurveySitesUtil.SurveySiteInfo s : sites) {
			if (s.prefix == null)
				pathPrefix = EMPTY;
			else
				pathPrefix=s.prefix;
            
			sitesPicklist.add(new Selectoption(pathPrefix, s.Name));
		}
	}
	
    /*
      private void setupDomain(list <Site> sites){
        String subD;
        String tLevelDomain;
        useTopLevelDomain =false;
        if(sites!=null && sites.size()>0){
          if(sites[0].TopLevelDomain != null && sites[0].TopLevelDomain.length()>0){
            subdomain = sites[0].TopLevelDomain;
            useTopLevelDomain=true;
          }
          else
            subdomain = sites[0].Subdomain;
        }
      }
    */
    
	private void setupShowSites(Integer i) {
		if (i > 0) {
			showAddSitesMessage = 'false';
		}
		else {
			showAddSitesMessage = 'true';
		}
	}
	
	private void setAllSurveys() {
		List<Survey__c> surveys = [Select Id, Name from Survey__c where IsDeleted = false order by Name];
        
		if (allSurveys == null) {
			allSurveys = new List<miniSurvey>();
		}
		else {
			allSurveys.clear(); 
		}
        
		for (Survey__c s : surveys) {
			allSurveys.add(new miniSurvey(s.Name, s.Id));
		}
	}
    
	public Pagereference makeNewSurvey() {
		if (newSurveyName == null) {
     		POD = '';
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.LABS_SF_Survey_Name_Is_Required));
			return null;
		}
		if (surveySite == SELECT_SITE) {
            POD = '';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.LABS_SF_Survey_Site_Is_Required));
            return null;
		}
        
        String urlPrefix = setupUrlPrefix(surveySite);
        String domain = setupDomainForSurvey(POD);
        String urlToSave = domain + '/' + urlPrefix + TAKE_SURVEY_VF + '?';
        
		if (surveySite == INTERNAL) {
			urlToSave = URL.getSalesforceBaseUrl().toExternalForm() + '/apex/' + TAKE_SURVEY_VF + '?';
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
        }
		
        Survey__c s = new Survey__c();
        s.Name = newSurveyName;
        s.URL__c = urlToSave;
        s.Submit_Response__c = 'empty';
        s.thankYouText__c = System.Label.LABS_SF_Survey_Submitted_Thank_you;
        s.thankYouLink__c = THANK_YOU_LINK_AXA;
		
        try {
			insert s;
			createAnonSurveyTaker(s.Id);
			return new Pagereference('/apex/' + SURVEY_MANAGER_PAGE_VF + '?id=' + s.Id);
		}
        catch (Exception e) {
			return null;
		}
	}

	private static void createAnonSurveyTaker(String surveyId) {
		list <SurveyTaker__c> sTakers = [select id from SurveyTaker__c where Survey__c = :surveyId and Contact__c = null and Case__c = null];
		
        if (sTakers != null && sTakers.size() > 0)
			return;
		
        SurveyTaker__c st = new SurveyTaker__c();      
		st.Case__c = null;
		st.Survey__c = surveyId;
		st.Contact__c = null;
		insert st;
	}
	
	private String setupDomainForSurvey(String pod) {
    	if (pod != 'NO_POD' && !useTopLevelDomain && checkSubdomain(subdomain)) {
			return 'http://'+subdomain+'.'+pod+'.force.com';
		}
		else if (pod != 'NO_POD' && useTopLevelDomain && checkSubdomain(subdomain)) {
			return 'http://'+subdomain+'.'+pod;
		}
		else if (useTopLevelDomain) {
			return 'http://'+subdomain;
		}
		else {
			return 'http://'+subdomain+'.force.com';
		}
	}
  
	private boolean checkSubdomain(String subdomain) {
		if(subdomain == null)
			return false;
		else if (subdomain.contains('developer-edition'))
			return true;
		else
			return false;
	}
  
	private String setupUrlPrefix(String site) {
		if(site == null || site=='EMPTY')
			return '';
		else
			return site+'/';
	}

	public Pagereference doSurveyReset() {
		setAllSurveys();
		return null;
	}
  
	public static String deleteSurvey(String deleteId) {
		Survey__c s= [Select Id, Name from Survey__c where Id =:deleteId];
		delete s;
		return 'true';
	}
    
	public Class miniSurvey {
        public String sName {get; set;}
    	public String sId   {get; set;}
    
        public miniSurvey(String miniName, String miniId) {
			sName = miniName;
			sId = miniId;
		}
	}
}