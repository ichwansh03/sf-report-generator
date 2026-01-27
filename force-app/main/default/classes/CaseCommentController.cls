public with sharing class CaseCommentController {
    public string remark {get;set;} 
    public string currentStatus {get;set;}
    public Case cs {get; set;}
    public Id currentId {get;set;}
    public List<call_line__c> callLine {get;set;}
    public caseComment cm {get;set;}
    
     public CaseCommentController(ApexPages.StandardController std) { 
         currentId = ApexPages.CurrentPage().getparameters().get('id'); 
         cs = [SELECT status FROM case where id =:currentId limit 1];
         currentStatus = cs.status;
         cs.status = 'Closed';
         system.debug('cs:'+cs);
         callLine = [SELECT Call_Remarks__c FROM call_line__c where case__c =:currentId order by createdDate desc limit 1];
         if (callLine.size() > 0) {
         	remark = callLine[0].Call_Remarks__c;    
         }
         system.debug('Call Line:'+callLine);
         
         
     }
    
    public PageReference save(){
        
        try{ 
            cm = new caseComment();
            cm.parentId = currentId;
            cm.commentBody = remark;
            insert cm;
            
            case updateCs = new case(
                id = currentId,
                status = cs.status
            );
            update updateCs;
        } catch(Exception ex){
            String errorMessage =  ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage();
            System.debug(errorMessage); 
        }
        
        PageReference pr = Page.caseComment;
        pr.getParameters().put('Id', currentId);
        pr.setRedirect(true);
        return pr; 
    }  
}