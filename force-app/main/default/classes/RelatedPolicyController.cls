public class RelatedPolicyController {
    public List<Related_Policy__c> relatedPolicyList {get;set;}
    public List<RelatedPolicyView> relatedPolicyViewList {get;set;}
    public string callLineId {get; set;}
    
    public RelatedPolicyController (ApexPages.StandardController controller) {
        callLineId = controller.getID();
        
        populateList();
    }
    
    public class RelatedPolicyView{
        public boolean isSelected {get; set;}
        public string callLineId {get; set;}
        public string customerName {get; set;}
        public string policyNo {get; set;}      
        public string contactId {get; set;}      
    }
    
    public PageReference selectPolicy(){
        Call_Line__c cl = new Call_Line__c();
        integer selectedCounter = 0;
        for(RelatedPolicyView vw : relatedPolicyViewList){
            if(vw.isSelected){
                selectedCounter++;
                cl.id = vw.callLineId;
                cl.Contact__c = vw.contactId;
                cl.Is_Allowed__c = true;
                cl.Policy_No__c = vw.policyNo;
                break;
            }
        }
        if(selectedCounter>0){
            update cl;
            PageReference clPage = new ApexPages.StandardController(cl).view();
            //PageReference clPage = new PageReference('/'+cl.id+'?isdtp=vw');
            clPage.setRedirect(true);
            return clPage;
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'You have not selected one policy yet.'));
            return null;
        }
    }

    public PageReference cancel(){
        Call_Line__c cl = new Call_Line__c();
        cl.id = callLineId; 
        PageReference clPage = new ApexPages.StandardController(cl).view();
        clPage.setRedirect(true);
        return clPage;
    }

    
    public PageReference runclick() {
        String contactId = Apexpages.currentPage().getParameters().get('contactId');
        system.debug('>>>> contactId : '+contactId );

        relatedPolicyList = [select id, Call_Back__c, Contact_ID__c, Customer_Name__c, Policy_No__c, Call_Back__r.Contact__c from Related_Policy__c where Call_Back__c = :callLineId];
        
        RelatedPolicyView vw = null;
        relatedPolicyViewList = new List<RelatedPolicyView>();
        for(Related_Policy__c rp : relatedPolicyList){
            vw = new RelatedPolicyView();
            vw.isSelected = false;
            if(rp.Contact_ID__c == contactId){
                vw.isSelected = true;
            }
            vw.callLineId = rp.Call_Back__c;    
            vw.customerName = rp.Customer_Name__c;  
            vw.policyNo = rp.Policy_No__c;  
            vw.contactId = rp.Contact_ID__c;
            
            relatedPolicyViewList.add(vw);  
        }
        return null;
    
    }
    
    private void populateList(){
        relatedPolicyList = [select id, Call_Back__c, Contact_ID__c, Customer_Name__c, Policy_No__c, Call_Back__r.Contact__c from Related_Policy__c where Call_Back__c = :callLineId];
        
        RelatedPolicyView vw = null;
        relatedPolicyViewList = new List<RelatedPolicyView>();
        for(Related_Policy__c rp : relatedPolicyList){
            vw = new RelatedPolicyView();
            vw.isSelected = false;
            if(rp.Contact_ID__c == rp.Call_Back__r.Contact__c){
                vw.isSelected = true;
            }
            vw.callLineId = rp.Call_Back__c;    
            vw.customerName = rp.Customer_Name__c;  
            vw.policyNo = rp.Policy_No__c;  
            vw.contactId = rp.Contact_ID__c;
            
            relatedPolicyViewList.add(vw);  
        }
    }
}