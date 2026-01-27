public class TodoAgent {
    
    public Boolean checkTasks {get; set;}
    public Boolean checkCl {get; set;}
    public Call_Line__c cl {get; set;}
    public Call_List__c campaign {get; set;}
    public List<TodoListWrapper> todos {get; set;}
    public List<String> items {get; set;}
    public List<String> statuses {get; set;}
    
    public TodoAgent(ApexPages.StandardController controller){
        todos = new List<TodoListWrapper>();

        Id clId = ApexPages.currentpage().getparameters().get('id');

        cl = new Call_Line__c();
        cl = [SELECT Id, Todo_Item__c, Todo_Item_Status__c, Call_List__c, Campaign_Name__c, Call_Remarks__c, Reason_Status_Config__c, Call_Status_Config__c, Status_has_call__c, Progress__c FROM Call_Line__c WHERE Id = :clId];
		campaign = [SELECT Id, Case_Type__c, Todo_List_Config__c FROM Call_List__c WHERE Id = :cl.Call_List__c];

        if (cl != null && campaign != null) {
            loadItems();
            checkTask();   
        }
    }
        
    public void loadItems() {
        Map<Object, List<String>> dependValues = DependentPicklistController.getDependentPicklistValues('Call_List__c', 'Todo_List_Config__c');
        
        items = new List<String>();
        statuses = new List<String>();
        
        if (cl.Todo_Item__c != null && cl.Todo_Item_Status__c != null) {
            items = cl.Todo_Item__c.split(',');
            statuses = cl.Todo_Item_Status__c.split(',');
        }
        
        for (Object key : dependValues.keySet()) {
            if (key == campaign.Case_Type__c) {
                items = dependValues.get(key);
            }
        }
        
        for (Integer i = 0; i < items.size(); i++) {
            Boolean status = (i < statuses.size() && statuses[i] == 'true') ? true : false;
            todos.add(new TodoListWrapper(items[i], status));
        }
    }
    
    public void save(){
        items = new List<String>();
        statuses = new List<String>();
        
        for (TodoListWrapper wrapper : todos) {
            items.add(wrapper.item);
            statuses.add(wrapper.isChecked ? 'true' : 'false');
            if (!wrapper.isChecked) checkTasks = false;
        }
        
        cl.Todo_Item__c = String.join(items,',');
        cl.Todo_Item_Status__c = String.join(statuses,',');
        
        checkTask();
        
        try {
            if (checkCl) update cl;
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error when save to-do list'));
        }
    }
    
    public void checkTask() {
        checkTasks = true;
        checkCl = true;
        for (TodoListWrapper item : todos) {
            if (!item.isChecked) {
                checkTasks = false;
                break;
            }
        }
        
        if (cl.Call_Status_Config__c == 'Approved' || cl.Call_Status_Config__c == 'Not Approved' || cl.Call_Status_Config__c == 'Sudah Pay By System' || cl.Call_Status_Config__c == 'N' || cl.Call_Status_Config__c == 'Y' || cl.Call_Status_Config__c == 'Cancel By System' || (cl.Progress__c == 'Presented' && cl.Campaign_Name__c.contains('Redemption TM'))){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Cannot edit To-Do List, Call Line is Closed!'));
            checkCl = false;
        }
        
        if (!checkTasks && (cl.Call_Status_Config__c == 'Uncontacted' || cl.Call_Status_Config__c == 'F' || cl.Call_Status_Config__c == 'P' || (cl.Call_Status_Config__c == null && cl.Reason_Status_Config__c == null && String.isBlank(cl.Call_Remarks__c)) || ((cl.Progress__c == 'Not Presented' || cl.Progress__c == null) && cl.Campaign_Name__c.contains('Redemption TM')))) {    
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'To-do list is not finished'));
        }
        
       	if (cl.Call_Status_Config__c == 'Takeout') {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Cannot edit To-Do List, Call Status/Reason Status/Remarks should not be blank!'));
            checkCl = false;
        }
         
        if (checkTasks && cl.Status_has_call__c != 'Closed'){
        	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'To-Do List successfully done'));  
        } 

    }
    
    public class TodoListWrapper {
        public String item {get; set;}
        public Boolean isChecked {get; set;}
        
        public TodoListWrapper(String item, Boolean isChecked) {
            this.item = item;
            this.isChecked = isChecked;
        }
    }
}