public class WorkingTimeConfigJSON {
    
    public String status;
    public Data data;
    public String message;
    public String status_code;
    public WorkingHour[] working_hour;
    public Messages messages;
    public List<String> holiday_dates;
    
    public class Data {
        public WorkingHour[] working_hour;
        public Messages messages;
        public List<String> holiday_dates;
    }
    
    public class WorkingHour{
        public String day_id;
        public String day ;
        public String work ;
        public String start_hour ;
        public String start_min ;
        public String end_hour ;
        public String end_min ;
    }
    
    public class Messages{
        public String on_facebook ;
        public String off_facebook ;
        public String on_whatsapp ;
        public String off_whatsapp ;
    }
}