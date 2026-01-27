public class ScriptObj {
    public String contentQuestion {get; set{contentQuestion = value != null ? value.escapeJava() : '';}}
    public String contentQuestion2 {get; set{contentQuestion2 = value != null ? value.escapeJava() : '';}}
    public String lookupLabel {get; set{lookupLabel = value != null ?value.escapeHtml4() : '';}}
    public String lookupLabel2 {get; set{lookupLabel2 = value != null ?value.escapeHtml4() : '';}}
    public String product {get; set{product = value != null ?value.escapeHtml4() : '';}}
    public String section {get; set{section = value != null ?value.escapeHtml4() : '';}}
    public String tabName {get; set{tabName = value != null ?value.escapeHtml4() : '';}}
    public String type {get; set{type = value != null ?value.escapeHtml4() : '';}}
    public Integer secOrder {get;set;}
   	public String defPrevious {get; set{defPrevious = value != null ?value.escapeHtml4() : '';}}
    public String defNext {get; set{defNext = value != null ?value.escapeHtml4() : '';}}
    public String defNote {get; set{defNote = value != null ?value.escapeJava() : '';}}
    public Boolean defaultOpen {get; set{defaultOpen = value != null ?value : false;}}
    public Boolean defaultFgNote {get; set{defaultFgNote = value != null ?value : false;}}
    private Map<String, Direction> directions = new Map<String, Direction>();
    private Map<String, Map<String, Direction>> multiContentAnswer = new Map<String, Map<String, Direction>>();
    public Integer contentCount {get;set{contentCount = value != null ?value : 1;}}
    public Set<String> imageResourceContent {get; set;}
    
    public ScriptObj(){
        
    }
    public class Direction{
    	public String contentAnswer {get; set{contentAnswer = value != null ?value.escapeHtml4() : '';}}
    	public String name {get; set{name = value != null ?value.escapeHtml4() : '';}}
    	public String parent {get; set{parent = value != null ?value.escapeHtml4() : '';}}
        public String parentDependency {get; set{parentDependency = value != null ?value.escapeHtml4() : '';}}
    	public String previous {get; set{previous = value != null ?value.escapeHtml4() : '';}}
    	public String next {get; set{next = value != null ?value.escapeHtml4() : '';}}
        public Boolean fgClosing {get; set{fgClosing = value != null ? value : false;}}
        public Boolean fgNote {get; set{fgNote = value != null ? value : false;}}
        public Boolean fgreSchedul {get; set{fgreSchedul = value != null ?value : false;}}
        public Boolean fgIsExist {get; set{fgIsExist = value != null ?value : false;}}
        public Boolean fgDefault {get; set{fgDefault = value != null ?value : false;}}
        public Boolean fgLegal {get; set{fgLegal = value != null ?value : false;}}
        public Boolean fgProduct {get; set{fgProduct = value != null ?value : false;}}
        public Boolean fgSurvey {get; set{fgSurvey = value != null ?value : false;}}
    	public String type {get; set{type = value != null ?value.escapeHtml4() : '';}}
        public String grpType {get; set{grpType = value != null ?value.escapeHtml4() : '';}}
        public String note {get; set{note = value != null ?value.escapeJava() : '';}}
        public String question {get; set{question = value != null ? value.escapeJava() : '';}}
        public String question2 {get; set{question2 = value != null ? value.escapeJava() : '';}}
        public String section {get; set{section = value != null ?value.escapeHtml4() : '';}}
        public Integer orderAnswer {get; set{orderAnswer = value != null ?Integer.valueOf(value): 0;}}
        public String imageResourceAnswer {get; set{imageResourceAnswer = value != null ?value.escapeHtml4() : '';}}
        public Set<String> imageResourceContent {get; set;}
        
        public Direction(){
            
        }
        
        public Direction(WelcomeCall_Script__c val){
            this.name = val.name;
            this.contentAnswer = val.WelcomeCall_Content_Answer__c;
            this.parent = val.WelcomeCall_Parent__c;
            this.previous = val.WelcomeCall_Parent__c;
            this.fgClosing = val.WelcomeCall_Fg_Closing__c;
            this.fgNote = val.WelcomeCall_Fg_Note__c;
            this.fgreSchedul = val.WelcomeCall_Fg_Reschedule__c;
            this.fgLegal = val.WelcomeCall_fgLegalStatement__c;
            this.fgProduct = val.WelcomeCall_Fg_Product__c;
            this.fgIsExist = false;
            this.fgSurvey = val.WelcomeCall_Fg_Survey__c;
            this.type = val.WelcomeCall_Type__c;
            this.grpType = val.WelcomeCall_Group_Type__c;
        	this.section = val.WelcomeCall_Section__c;
            this.orderAnswer = Integer.valueOf(val.WelcomeCall_GroupOrder__c);
            this.imageResourceAnswer = null;
            this.imageResourceContent = new Set<String>();
            this.next = null;
            this.previous = null;
            this.fgDefault = false;
            this.parentDependency = val.WelcomeCall_Parent_Dependency__c;
        }
    }
    
    public Map<String, Map<String, Direction>> getMultiContentAnswer(){
        return this.multiContentAnswer;
    }
    
    public void setMultiContentAnswer(Direction value){
        String outerKey = ( value.grpType == '' || value.grpType == null ? value.type : value.grpType);
        directions = multiContentAnswer.get(outerKey);
        String key = value.name;
        if(directions == null){
            directions = new Map<String, Direction>();
            directions.put(key, value);
        } else {
            directions.put(key, value);
        }
        this.multiContentAnswer.put(outerKey, directions);
    }
    
    public ScriptObj(WelcomeCall_Script__c val){
        this.contentQuestion = val.WelcomeCall_Content_Question__c;
        this.contentQuestion2 = val.WelcomeCall_Content_Question_2__c;
        this.lookupLabel = val.WelcomeCall_Lookup_Label__c;
        this.lookupLabel2 = val.welcomeCall_Lookup_Label_2__c;
        this.product = val.WelcomeCall_Product_Name__c;
        this.section = val.WelcomeCall_Section__c;
        this.tabName = val.WelcomeCall_Tab_Name__c;
        this.type = val.WelcomeCall_Type__c;
        this.defPrevious = null;
        this.defNext = null;
        this.defNote = null;
        this.defaultFgNote = val.WelcomeCall_Fg_Note__c;
        this.contentCount = 1;
        this.imageResourceContent = new Set<String>();
    }
    
}