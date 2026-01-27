global class SchChangeOwnerToNonActiveQueue implements Schedulable{
    global void execute(SchedulableContext ctx) {
        
        ChangeOwnerToNonActiveQueue_Batch b = new ChangeOwnerToNonActiveQueue_Batch ();
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b, 10);
        
    }
}