public class SchContactFCR_Batch implements Database.Batchable<id> {
    public List<id> l_ba {get;set;}
    public Date l_tanggal {get;set;}
    
    public SchContactFCR_Batch(List<id> ba_l, Date Tanggal_l) {
        l_ba = ba_l;
        l_tanggal = tanggal_l;        
    }
    
    public List<id> start(Database.BatchableContext BS) {
        return this.l_ba;
    }
    
    public void execute(Database.BatchableContext BS, List<id> l_ba) {
        //update l_ba;
        Date TodayDate = Date.today();
        Date Tanggal = TodayDate;
        
        if (l_tanggal != NULL) Tanggal = l_Tanggal;
        //Tanggal = date.newInstance(TodayDate.Year(), 1, 1);
        SchCalc.FCRCaseDate(Tanggal, l_ba);

    }
    
    public void finish(Database.BatchableContext BS) {
        
    }
}