global class Sch_PurecloudSurveyResult implements Schedulable{
    global void execute(SchedulableContext ctx) {
        String q = Label.Purecloud_Survey_Batch_Query; // saving query to custom label, 20230824    
        
        Purecloud_GetSurveyResult_Batch bb = new Purecloud_GetSurveyResult_Batch(q);
        Database.executeBatch(bb,Integer.valueOf(Label.Purecloud_Survey_Batch_Total));
    }
}