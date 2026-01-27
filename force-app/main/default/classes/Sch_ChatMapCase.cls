global class Sch_ChatMapCase implements Schedulable{
  global void execute(SchedulableContext ctx) {
        date datetoday = date.today()- integer.valueof(label.ChatMapCaseDay);
        
        Date sDate = date.today()- integer.valueof(label.ChatMapCaseDay);
        Datetime sdt = datetime.newInstance(sDate.year(), sDate.month(),sDate.day());
        String startTimeFormat = sdt.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
        
        String q = 'SELECT id, SourceId FROM Case WHERE SourceId != NULL and CreatedDate >= '+startTimeFormat+'  order by createdDate desc';

        ChatMapCaseBatch bb = new ChatMapCaseBatch(q);
        Database.executeBatch(bb,10);
    }
}