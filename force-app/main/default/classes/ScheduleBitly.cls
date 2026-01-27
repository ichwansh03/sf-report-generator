global class ScheduleBitly implements Schedulable{
	global void execute(SchedulableContext ctx) {
    	String q = 'select id, bitly__C, name, ready_to_send__c, mobile__c, entity__c, email_text__c, Survey_URL__c ';
        q = q +' from email_sms_log__c where method__c in('+'\''+'SMS'+'\''+', '+'\''+'Whatsapp'+'\''+') and category__c = '+'\''+'ICF'+'\''+' and status__c = '+'\''+'Draft'+'\''+'';
        //q = q + ' and bitly__c = null and Ready_To_Send__c = false';
        q = q + ' and (bitly__c = null OR Ready_To_Send__c = false)';
        q = q + ' and entity__c = '+'\''+'AMFS'+'\''+' and createddate >= 2023-01-01T00:00:00.000+0000';
        BitlyBatch bb = new BitlyBatch(q);
		Database.executeBatch(bb,10);
    }
}