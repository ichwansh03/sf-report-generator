global class Batch_ChangeOwner_CallLine_AMFS implements Database.Batchable<sobject>{
    Public List<Call_Line__c> listCl;
    
    global Batch_ChangeOwner_CallLine_AMFS(List<Call_Line__c> listCL){
	this.listCl = listCl;
    }
    
    global List<Call_Line__c> start(Database.BatchableContext bc){
	return listCl;
    }
    
    global void execute(Database.BatchableContext bc, List<Call_Line__c> scope){
		system.debug('***SCOPE SIZE: '+scope.size());
		update scope;
    }
    
    Public void finish(Database.BatchableContext bc){ 

    }
}