public class UpdateGetCurrentAgentController {
    private final Case currentCase;
    public Boolean shouldRenderButton { get; private set; }
    public Boolean updated { get; private set; }
    public Boolean disable { get; private set; }
    public Boolean isButtonDisabled { get; set; }
    
    public UpdateGetCurrentAgentController(ApexPages.StandardController controller) {
        this.currentCase = (Case)controller.getRecord();
        
        Case cs = [SELECT Id, GetInfo__c FROM Case WHERE Id = :currentCase.Id LIMIT 1];
        System.debug('case = '+ cs);
        
        if (cs != null) {
            String currUserId = UserInfo.getName();
            String caseUserName = cs.GetInfo__c;
            System.debug('Case User Name: ' + caseUserName);
            System.debug('Case User Name: ' + currUserId);
            
            if (currUserId == caseUserName) {
                isButtonDisabled = true;
            } else {
                isButtonDisabled = false;
            }
            System.debug('button: ' + isButtonDisabled);
           // shouldRenderButton = cs.GetInfo__c != UserInfo.getName();
        }
    }
    
    public void updateGetInfo() {
        try {
            // Set GetInfo__c to the current user's name
            currentCase.GetInfo__c = UserInfo.getName();
            
            update currentCase;
            
            updated = true; // Set the updated flag to true
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'GetInfo updated successfully.'));
           // shouldRenderButton = false; 
           // isButtonDisabled = false;
        } catch (Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An error occurred: ' + ex.getMessage()));
        }
    }
}