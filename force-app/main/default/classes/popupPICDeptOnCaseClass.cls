public class popupPICDeptOnCaseClass {
    public Case currentCase {get; set;}
    public String selectedPicklist {get; set;}
    public String selectedQueueDept {get; set;}
    public User userObj {get; set;}
    public String entity {get;set;}
    
    public popupPICDeptOnCaseClass(ApexPages.StandardController controller) {
        currentCase = (Case) controller.getRecord();
        userObj = [SELECT id, Entity__c, Profile.Name FROM user WHERE id = :UserInfo.getUserId()];
        entity = userObj.Entity__c;
    }
    
    public PageReference updateCase() {
        if(selectedPicklist == 'Case_Type') {
            List<Master_Case_Type_Regional__c> mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Case_Type__c = :currentCase.Case_Type_Config__c AND Entity__c = :entity AND Type__c = :currentCase.Type AND Active__c = TRUE AND (Department_Queue__c != '' OR Current_User__c = TRUE) LIMIT 1];
            Case cse = new Case();
            cse.Id = currentCase.Id;
            
            if(mctr.size() > 0) {
                if(mctr[0].Current_User__c) {
                    cse.PIC_Department_LU__c = UserInfo.getUserId();
                } else {
                    cse.PIC_Department_LU__c = mctr[0].PIC_Department__c;
                }
                cse.TAT__c = mctr[0].TAT__c;
                cse.SLA_Case_Closed__c = mctr[0].SLA__c;
                cse.Division__c = mctr[0].Department_Queue__c;
                if(mctr[0].Current_User__c) {
                    selectedQueueDept = 'Current User';
                } else {
                    selectedQueueDept = mctr[0].Department_Queue__c;
                }
            } else {
                String qDefCaseType = entity + ' Default Case Type';
                List<Master_Case_Type_Regional__c> altmctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE Entity__c = :entity AND Name = :qDefCaseType AND Active__c = TRUE AND Type__c = :currentCase.Type LIMIT 1];
                if(altmctr.size() > 0) {
                    if(altmctr[0].Current_User__c) {
                        cse.PIC_Department_LU__c = UserInfo.getUserId();
                    } else {
                        cse.PIC_Department_LU__c = altmctr[0].PIC_Department__c;
                    }
                    
                    cse.TAT__c = altmctr[0].TAT__c;
                    cse.SLA_Case_Closed__c = altmctr[0].SLA__c;
                    cse.Division__c = altmctr[0].Department_Queue__c;
                    
                    if(altmctr[0].Current_User__c) {
                        selectedQueueDept = 'Current User';
                    } else {
                        selectedQueueDept = altmctr[0].Department_Queue__c;
                    }
                } else {
                    selectedQueueDept = 'Temporary';
                }
            }
            if(selectedQueueDept != 'Current User') {
                System.debug('old selectedQueueDept : ' + selectedQueueDept);
                if(selectedQueueDept.containsWhitespace()) { 
                    selectedQueueDept = selectedQueueDept.replaceAll('\\s', '_'); 
                    System.debug('new selectedQueueDept : ' + selectedQueueDept);
                }
                String qDevName = entity + '_' + selectedQueueDept + '_Queue';
                List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
                if(gQueue.size() > 0) {
                    cse.OwnerId = gQueue[0].Id;
                    if (selectedQueueDept == 'Temporary') {cse.PIC_Department_LU__c = UserInfo.getUserId();}
                } else {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.'));
                }
            }
            update cse;
        } else if(selectedPicklist == 'PIC_Department') {
            List<Master_Case_Type_Regional__c> mctr = [SELECT Id, PIC_Department__c, TAT__c, SLA__c, Department_Queue__c, Current_User__c FROM Master_Case_Type_Regional__c WHERE PIC_Department__c = :currentCase.PIC_Department_LU__c LIMIT 1];
            Case cse = new Case();
            cse.Id = currentCase.Id;
            
            if(mctr.size() > 0) {
                if(mctr[0].Department_Queue__c != '') {
                    selectedQueueDept = mctr[0].Department_Queue__c;
                } else {
                    selectedQueueDept = 'Temporary';
                }
                
                if(selectedQueueDept.containsWhitespace()) { selectedQueueDept = selectedQueueDept.replaceAll('\\s', '_'); }
                String qDevName = entity + '_' + selectedQueueDept + '_Queue';
                List<Group> gQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = :qDevName];
                if(gQueue.size() > 0) {
                    cse.OwnerId = gQueue[0].Id;
                } else {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Queue available, please contact your Administrator.'));
                }
            }
            update cse;
        } else {
            //--selectedPicklist is empty, cancel save/warning message
        }
        
        return new PageReference('javascript:window.close()');
    }
}