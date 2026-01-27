public class Manual_Service {
    public Date tgl {get;set;}
    public String Pilihan {get;set;}
    public Manual_Service(){
        
    }
    
    public List<SelectOption> getCategoryService(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','None'));
        options.add(new SelectOption('Agent Status','Agent Status'));
        options.add(new SelectOption('Log CTI Valdo','Log CTI Valdo'));
        options.add(new SelectOption('Inbound Call Interval','Inbound Call Interval'));
        options.add(new SelectOption('Inbound Call Agent','Inbound Call Agent'));
        options.add(new SelectOption('Summary Daily','Summary Daily'));
        return options;   
     }
    
    public void action(){
        if(tgl!=null && (Pilihan!=null || Pilihan != '')){
            String tanggal = String.valueOf(tgl.day());
            String bulan = String.valueOf(tgl.month());
            String tahun = String.valueOf(tgl.year());
            if(Pilihan == 'Agent Status'){
                Valdo_DailyAUX.getDailyAUX(tanggal, bulan, tahun);
            }
            else if(Pilihan == 'Log CTI Valdo'){
                Valdo_DailyData.getDailyCall(tanggal, bulan, tahun);
            }
            else if(Pilihan == 'Inbound Call Interval'){
                Valdo_DailyReportInterval.getDailyReport(tanggal, bulan, tahun);
            }
            else if(Pilihan == 'Inbound Call Agent'){
                Valdo_DailyReportAgent.getDailyReport(tanggal, bulan, tahun);
            }
            else if(Pilihan == 'Summary Daily'){
                Valdo_SummaryDaily.getSummaryDaily(tanggal, bulan, tahun);
            }
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'OK'));
        }
    }
}