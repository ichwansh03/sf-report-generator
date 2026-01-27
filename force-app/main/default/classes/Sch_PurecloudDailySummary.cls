Global class Sch_PurecloudDailySummary implements Schedulable {
    global void execute(SchedulableContext ctx){
    	Date yesterday = Date.today().addDays(-1);
        String tgl = String.valueof(yesterday.day());
        String bln = String.valueof(yesterday.month());
        String thn = String.valueof(yesterday.year());
        
        Date newtgl = yesterday.addDays(-1);
        String newhri = String.valueof(newtgl.day());
        String newbln = String.valueof(newtgl.month());
        
        String startInterval = thn+'-'+newbln+'-'+newhri+'T17:00.000Z';
        String endInterval = thn+'-'+bln+'-'+tgl+'T17:00.000Z';
        Purecloud_InsertDailySummary.getTest(startInterval, endInterval);    
        Purecloud_InsertDailySummary_Callback.getTest(startInterval, endInterval);
    }

}