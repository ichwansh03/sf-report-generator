global class SchFollowUpBackoffice implements Schedulable{
    
    /*public static String sch1 = '0 0 10 ? * MON-FRI';
    public static String sch2 = '0 15 10-17/3 * * ?';
    public static String schtoday = system.today();
    system.debug('schtoday: '+schtoday);*/

    global void execute(SchedulableContext ctx) {
        
        SchPopUpFollowUpBackoffice FU_Backoffice = new SchPopUpFollowUpBackoffice ();
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(FU_Backoffice);
        
        /*SchPopUpEmailNotReply emailNotReply = new SchPopUpEmailNotReply ();
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(emailNotReply);*/
        
        
        /*if(schtoday == sch1){
            SchPopUpFollowUpBackoffice b = new SchPopUpFollowUpBackoffice ();
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b);
        } 
        
        if(2){
            SchPopUpFollowUpBackoffice2 b = new SchPopUpFollowUpBackoffice2 ();
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b);
        }*/
    }
}