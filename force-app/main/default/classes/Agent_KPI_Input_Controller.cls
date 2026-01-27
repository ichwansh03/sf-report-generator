public class Agent_KPI_Input_Controller {
  private ApexPages.StandardController controller;
    public List<Agent_KPI_Item__c> oliDelList {get;set;}
    public List<OliWrapper> oliWrapperList {get;set;}
    public List<SelectOption> priceBookOptionList {get;set;}
    public Integer rowToRemove {get;set;}
    public Id opportunityId {get;set;}
    public OliWrapper delOli {get;set;}
    public Agent_KPI__c opp {get;set;}
    public String selectedItem {get;set;}
    public String selectedPriceBook {get;set;}
    public Id selectedPriceBookId {get;set;}
    public Boolean existingRendered {get;set;}
    public Boolean newRendered {get;set;}
    public Boolean priceBookDisabled {get;set;}
    public Boolean productRowRendered {get;set;}
    public Boolean EditMode {get;set;}
    public Boolean ViewMode {get;set;}
    public Boolean MasterMode {get;set;}
    public Boolean DataMode {get;set;}

    public Integer countOldProduct {get;set;}
    
    private static final String NONE = '--- None ---';
    private static final String LBL_OPPORTUNITY = 'Agent KPI';
    private static final String LBL_PRICE_BOOK = 'Price Book Information';
    public String lblOpportunity {get;set;}
    
    public class OliWrapper {
        public Integer index {get;set;}
        public Agent_KPI_Item__c oli {get;set;}
    }
    
    public Agent_KPI_Input_Controller(ApexPages.StandardController controller) {
        this.controller = controller;
        this.productRowRendered = false;
        this.existingRendered = false;
        this.newRendered = false;
        lblOpportunity = LBL_OPPORTUNITY;
        
        String opportunityId = ApexPages.currentPage().getParameters().get('id');
        String EditModeTemp = ApexPages.currentPage().getParameters().get('EditMode');
        String MasterTemp = ApexPages.currentPage().getParameters().get('Master');

        if (EditModeTemp == 'TRUE')            
            EditMode = TRUE;
        else 
            EditMode = FALSE;
            
        ViewMode = !EditMode;

        if (MasterTemp == '1')            
            MasterMode = TRUE;
        else 
            MasterMode = FALSE;

        DataMode = !MasterMode;

        this.opportunityId = Id.valueOf(opportunityId);
        
        //Agent_KPI__c
        DescribeSObjectResult describeResultOpp = Agent_KPI__c.getSObjectType().getDescribe();
        List<String> oppFieldList = new List<String>(describeResultOpp.fields.getMap().keySet());
        String oppFields = String.join(oppFieldList, ',');
        String oppQuery = ' SELECT ' + oppFields + ' FROM Agent_KPI__c WHERE Id = :opportunityId LIMIT 1 ';
        SObject currentOpp = Database.query(oppQuery);
        this.opp = (Agent_KPI__c) currentOpp;
                 
        //Agent_KPI_Item__c
        DescribeSObjectResult describeResultOli = Agent_KPI_Item__c.getSObjectType().getDescribe();
        List<String> oliFieldList = new List<String>(describeResultOli.fields.getMap().keySet());
        String oliFields = String.join(oliFieldList, ',');
        String oliQuery = ' SELECT ' + oliFields + ' FROM Agent_KPI_Item__c WHERE Agent_KPI__c = :opportunityId ORDER BY Seq__c, Id ASC ';
        List<SObject> currentOliList = Database.query(oliQuery);
        
        this.oliWrapperList = new List<OliWrapper>();
        this.oliDelList = new List<Agent_KPI_Item__c>();
        
        for (SObject currentOli : currentOliList) {
            OliWrapper newWrapper = new OliWrapper();
            Agent_KPI_Item__c newOli = (Agent_KPI_Item__c) currentOli;
            //newOli.Product_Custom__c = newOli.Product2Id;
            newWrapper.index = this.oliWrapperList.size();
            newWrapper.oli = newOli;
            this.oliWrapperList.add(newWrapper);
        }
        
        if (this.oliWrapperList.size() == 0) {
            addOli();
        }
        this.countOldProduct = currentOliList.size();
        
        System.debug(LoggingLevel.ERROR, '***SELECTED in constructor onLoad : ' + selectedItem);
    }
    
    public void addOli() {
        this.oliWrapperList = addToList(this.oliWrapperList);
    }
    
    public List<OliWrapper> addToList(List<OliWrapper> oliWs) {
        OliWrapper newWrapper = new OliWrapper();
        Agent_KPI_Item__c newOli = new Agent_KPI_Item__c();
        newOli.Agent_KPI__c = this.opportunityId;
        newOli.Seq__c = oliWs.Size()+1;
        newOli.Type_Score__c = opp.Type_Score__c;
        newWrapper.index = oliWs.size();
        newWrapper.oli = newOli;
        oliWs.add(newWrapper);
        return oliWs;
    }
    
    public void delOli() {
        this.oliWrapperList = delFromList(this.rowToRemove, this.oliWrapperList);
    }
    
    public List<OliWrapper> delFromList(Integer index, List<OliWrapper> oliWs) {
        delOli = oliWs.remove(index);
        if (delOli.oli.Id != null) {
            this.oliDelList.add(delOli.oli);
            this.countOldProduct = this.countOldProduct - 1;
        }
        return oliWs;
    }
        
    public PageReference SaveOli() {
        List<Agent_KPI_Item__c> oliToUpsert = new List<Agent_KPI_Item__c>();
        List<Agent_KPI_Item__c> oliToDelete = new List<Agent_KPI_Item__c>();
        Boolean isEmptyProductCustom = false;
        Boolean isEmptyPrice = false;
        Boolean isEmptyQuantity = false;
            
        integer i = 0;
        for (OliWrapper oliw : this.oliWrapperList) {
            if (MasterMode) {
                oliw.oli.Actual_Data__c = oliw.oli.Master_Data_1__c;
                oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Actual_Score_F__c);
            }
            if (oliw.oli.Score_Auto__c == 'Auto') {
                if ( oliw.oli.Master_Data_1__c > oliw.oli.Master_Data_2__c) {
                    if ( oliw.oli.Actual_Data__c >= oliw.oli.Master_Data_1__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_1__c); 
                    else if ( oliw.oli.Actual_Data__c >= oliw.oli.Master_Data_2__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_2__c); 
                    else if ( oliw.oli.Actual_Data__c >= oliw.oli.Master_Data_3__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_3__c); 
                    else if ( oliw.oli.Actual_Data__c >= oliw.oli.Master_Data_4__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_4__c); 
                    else if ( oliw.oli.Actual_Data__c >= oliw.oli.Master_Data_5__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_5__c); 
                }
                else {
                    if ( oliw.oli.Actual_Data__c <= oliw.oli.Master_Data_1__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_1__c); 
                    else if ( oliw.oli.Actual_Data__c <= oliw.oli.Master_Data_2__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_2__c); 
                    else if ( oliw.oli.Actual_Data__c <= oliw.oli.Master_Data_3__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_3__c); 
                    else if ( oliw.oli.Actual_Data__c <= oliw.oli.Master_Data_4__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_4__c); 
                    else if ( oliw.oli.Actual_Data__c <= oliw.oli.Master_Data_5__c) oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Master_Score_5__c); 

                }
                //oliw.oli.Actual_Score__c = string.valueof(oliw.oli.Actual_Score_F__c);
            }
            
            if (oliw.oli.Id == null) {                
                oliToUpsert.add(oliw.oli);
            }
            else {
                oliToUpsert.add(oliw.oli);
            }
        }
        oliToDelete.addAll(oliDelList);
        
        if (isEmptyProductCustom) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Product: You must enter a value');
            ApexPages.addMessage(errorMessage);
            return null;
        }
        
        try {
            if (oliToDelete.size() > 0) {
                delete oliToDelete;
            }
            if (oliToUpsert.size() > 0) {
                upsert oliToUpsert;
            }
            return new PageReference('/' + this.opportunityId);
        }
        catch (DmlException de) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, de.getMessage());
            ApexPages.addMessage(errorMessage);
            return null;
        }
        catch (Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(errorMessage);
            return null;
        }
    }
    
    public PageReference Cancel() {
        return this.controller.cancel();
    }
    
    public PageReference showProductRow() {
        if (this.selectedItem != null) {
            this.productRowRendered = true;
        }
        else {
            this.productRowRendered = false;
        }
        this.oliWrapperList = new List<OliWrapper>();
        addOli();
        
        System.debug(LoggingLevel.ERROR, '***SELECTED in showProductRow onChange : ' + this.selectedItem);
        return null;
    }
}