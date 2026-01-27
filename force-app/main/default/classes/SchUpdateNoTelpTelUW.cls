global class SchUpdateNoTelpTelUW implements Schedulable {
    global void execute(SchedulableContext ctx){

        String strQueryCallLine = '';
        List<Call_Line__c> listCallLine = new List<Call_Line__c>();
        List<String> listPolicyNumber = new List<String>();
        
        if (Test.isRunningTest()) {
            strQueryCallLine = Label.query_schUpdateNoTelpTelUW;
        }else{
            strQueryCallLine = Label.query_schUpdateNoTelpTelUW;
        }
        
        listCallLine = Database.query(strQueryCallLine);
        for(Call_Line__c cl: listCallLine){
            System.debug('POLICY NO: '+ cl.Policy_No__c+', listCallLine: '+listCallLine.size());
            listPolicyNumber.add(cl.Policy_No__c);
        }
        BatchUpdateNoTelpTelUW batchUpdateNoHpTelUW = new BatchUpdateNoTelpTelUW(listPolicyNumber);
            if (!Test.isRunningTest())
                Database.executeBatch(batchUpdateNoHpTelUW, 50);
    }
}