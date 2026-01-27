global class Sch_DelBackEndPaging implements Schedulable{
  global void execute(SchedulableContext ctx) {
        
        String q = 'SELECT id FROM BackEndPaging__c ';

        DelBackEndPagingBatch bb = new DelBackEndPagingBatch(q);
        Database.executeBatch(bb,integer.valueof(label.DelBackEndPagingRow));
    }
}