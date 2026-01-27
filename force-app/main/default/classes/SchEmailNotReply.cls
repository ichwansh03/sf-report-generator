global class SchEmailNotReply implements Schedulable{
    global void execute(SchedulableContext ctx) {
        
        SchPopUpEmailNotReply b = new SchPopUpEmailNotReply ();
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b);
        
    }
}