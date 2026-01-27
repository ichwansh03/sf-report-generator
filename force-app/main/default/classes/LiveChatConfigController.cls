public class LiveChatConfigController {
    
    public String endPoint = Label.Live_Chat_Endpoint;
    public String methodGet = 'GET';
    public String methodPost = 'POST';
    
    public String day_id {get;set;}
    public String day {get;set;}
    public String work {get;set;}
    public String start_hour {get;set;}
    public String start_min {get;set;}
    public String end_hour {get;set;}
    public String end_min {get;set;}
    
    public String channel {get;set;}
    public String messages {get;set;}
    public String msgstatuses {get;set;}
    
    public String holidayDate {get;set;}
    public Boolean isDisabled {get;set;}
    
    public List<WorkingHour> workingHours {get;set;}
    public Map<String,String> mapMsg {get;set;}
    public List<String> listChannel {get;set;}
    public List<String> listMessageInactive {get;set;}
    public List<MessagesActive> messagesActive {get;set;}
    public List<MessagesInactive> messagesInactive {get;set;}
    public List<String> holidayDates {get;set;}
    public List<HolidayDates> newHoliday {get;set;}
    public List<String> saveNewHoliday {get;set;}
    public List<DateWrapper> invalidNewHoliday {get;set;}
    public WorkingTimeConfigJSON wtcJSON = new WorkingTimeConfigJSON();
    
    public Document document {
        get {
            if (document == null){
                document = new Document();
            }
            return document;
        }
        set;
    }
    
    public class WorkingHour {
        public String dayId {get;set;}
        public String dayName {get;set;}
        public Boolean workDay {get;set;}
        public String startHour {get;set;}
        public String startMin {get;set;}
        public String endHour {get;set;}
        public String endMin {get;set;}
        
        public WorkingHour (String dayId, String dayName,  Boolean workDay, String startHour, String startMin, String endHour,String endMin){
            this.dayId = dayId;
            this.dayName = dayName;
            this.workDay = workDay;
            this.startHour = startHour;
            this.startMin = startMin;
            this.endHour = endHour;
            this.endMin = endMin;
        }
    }
    
    public class DateWrapper {
        public String dateHoliday {get;set;}
        public String messageError {get;set;}
        
        public DateWrapper (String dateHoliday, String messageError){
            this.dateHoliday = dateHoliday;
            this.messageError = messageError;
        }
    }
    
    public class MessagesActive{
        public String channel {get;set;}
        public String messages {get;set;}
        
        public MessagesActive (String channel,String messages){
            this.channel = channel;
            this.messages = messages;
        }
    }
    
    public class MessagesInactive{
        public String channel {get;set;}
        public String messages {get;set;}
        
        public MessagesInactive (String channel,String messages){
            this.channel = channel;
            this.messages = messages;
        }
    }
    
    public class HolidayDates{
        public Date value {get;set;}
    }
    
    public LiveChatConfigController(ApexPages.StandardController controller) {
        isDisabled = true;
    }
    
    public LiveChatConfigController(){}
    
    public void init(){
        workingHours = new List<WorkingHour>();
        mapMsg = new Map<String,String>();
        try{
            wtcJSON = get();
            if(wtcJSON.status == 'Success'){
                for(Integer i = 0 ; i < wtcJSON.Data.working_hour.size() ; i++){
                    String day_id = wtcJSON.Data.working_hour[i].day_id;
                    String day = wtcJSON.Data.working_hour[i].day;
                    Boolean work = wtcJSON.Data.working_hour[i].work == 'true' ? true : false ;
                    String start_hour = wtcJSON.Data.working_hour[i].start_hour;
                    String start_min = wtcJSON.Data.working_hour[i].start_min;
                    String end_hour = wtcJSON.Data.working_hour[i].end_hour;
                    String end_min = wtcJSON.Data.working_hour[i].end_min;
                    WorkingHour wh = new WorkingHour(day_id,day,work,start_hour,start_min,end_hour,end_min);
                    workingHours.add(wh);
                }
                
                messagesActive = new List<MessagesActive>();
                messagesInactive = new List<MessagesInactive>();
                
                String onfb = wtcJSON.Data.messages.on_facebook == null ? 'Tidak Ada Data' : wtcJSON.Data.messages.on_facebook;
                MessagesActive msgac = new MessagesActive('Facebook',onfb);
                messagesActive.add(msgac);
                
                String onwa = wtcJSON.Data.messages.on_whatsapp == null ? 'Tidak Ada Data' : wtcJSON.Data.messages.on_whatsapp;
                msgac = new MessagesActive('Whatsapp',onwa);
                messagesActive.add(msgac);
                
                String offfb = wtcJSON.Data.messages.off_facebook == null ? 'Tidak Ada Data' : wtcJSON.Data.messages.off_facebook;
                MessagesInactive msgin = new MessagesInactive('Facebook',offfb);
                messagesInactive.add(msgin);
                
                String offwa = wtcJSON.Data.messages.off_whatsapp == null ? 'Tidak Ada Data' : wtcJSON.Data.messages.off_whatsapp;
                msgin = new MessagesInactive('Whatsapp',offwa);
                messagesInactive.add(msgin);
                
                holidayDates = wtcJSON.Data.holiday_dates;
                holidayDates.sort();
            }
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan saat Load init. Silahkan hubungi admin.'));
            system.debug('Error INIT == '+e.getStackTraceString()+' in '+e.getLineNumber());
        }
    }
    
    public PageReference editWorkHour(){
        
        PageReference direct;
        String dayidWH = ApexPages.currentPage().getParameters().get('dayid');
        String dayNameWH = ApexPages.currentPage().getParameters().get('dayName');
        String startHourWH = ApexPages.currentPage().getParameters().get('startHour');
        String startMinWH = ApexPages.currentPage().getParameters().get('startMin');
        String endHourWH = ApexPages.currentPage().getParameters().get('endHour');
        String endMinWH = ApexPages.currentPage().getParameters().get('endMin');
        String workDayWH = ApexPages.currentPage().getParameters().get('workDay');
        
        day_id = dayidWH;
        day = dayNameWH;
        work = workDayWH;
        start_hour = startHourWH;
        start_min = startMinWH;
        end_hour = endHourWH;
        end_min = endMinWH;
        
        direct = new PageReference('/apex/LiveChatConfigEditWH');
        return direct;
        //return null;
        
    }
    
    public void saveWorkHour(){
        try{
            wtcJSON = get();
            Boolean isError = false;
            for(Integer i = 0; i < wtcJSON.data.working_hour.size(); i ++){
                if(wtcJSON.data.working_hour[i].day_id == day_id){
                    if(start_hour.isNumeric() && end_hour.isNumeric() && start_min.isNumeric() &&  end_min.isNumeric()){
                        if(!(Integer.valueOf(start_hour) > 23) && !(Integer.valueOf(end_hour) > 23) && !(Integer.valueOf(start_min) > 59) && !(Integer.valueOf(end_min) > 59)){
                            wtcJSON.data.working_hour[i].work = work;
                            wtcJSON.data.working_hour[i].start_hour = start_hour;
                            wtcJSON.data.working_hour[i].start_min = start_min;
                            wtcJSON.data.working_hour[i].end_hour = end_hour;
                            wtcJSON.data.working_hour[i].end_min = end_min;
                        }else{
                            isError = true;
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid Hour / Minute format. Hour must not greater than 23 and minute must not greater than 59.'));
                        }
                    }else{
                        isError = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid Hour / Minute format. Must digit only.'));
                    }
                }
            }
            if(!isError){
                String status = config(wtcJSON);
                
                if(status == 'Success'){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
                }else{
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
                }
            }
        }catch(Exception e){
            system.debug('Error SAVEWORKHOUR == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
    }
    
    public PageReference editMessage(){
        PageReference direct;
        try{
            wtcJSON = get();
            String msgMsg = ApexPages.currentPage().getParameters().get('status');
            String channelMsg = ApexPages.currentPage().getParameters().get('channel');
            msgstatuses = msgMsg;
            channel = channelMsg;
            System.debug('channel == '+channel);
            System.debug('msgstatuses == '+msgstatuses);
            System.debug('off fb == '+wtcJSON.data.messages.off_facebook);
            System.debug('off wa == '+wtcJSON.data.messages.off_whatsapp);
            if(channel == 'Facebook' && msgstatuses == 'active'){
                messages = wtcJSON.data.messages.on_facebook;
            }else if(channel == 'Facebook' && msgstatuses == 'inactive'){
                messages = wtcJSON.data.messages.off_facebook;
            } else if(channel == 'Whatsapp' && msgstatuses == 'active'){
                messages = wtcJSON.data.messages.on_whatsapp;
            }else if(channel == 'Whatsapp' && msgstatuses == 'inactive'){
                messages = wtcJSON.data.messages.off_whatsapp;
            }
            direct = new PageReference('/apex/LiveChatConfigEditMsg');
        }catch(Exception e){
            system.debug('Error EDITMESSAGE == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        return direct;
    }
    
    public void saveMessageActive(){
        try{
            wtcJSON = get();
            if(channel == 'Facebook'){
                wtcJSON.data.messages.on_facebook = messages;
            }else if(channel == 'Whatsapp'){
                wtcJSON.data.messages.on_whatsapp = messages;
            }
            
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            }
        }catch(Exception e){
            system.debug('Error SAVEMESSAGE ACTIVE == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
    }
    
    public void saveMessageInactive(){
        try{
            wtcJSON = get();
            if(channel == 'Facebook'){
                wtcJSON.data.messages.off_facebook = messages;
            }else if(channel == 'Whatsapp'){
                wtcJSON.data.messages.off_whatsapp = messages;
            }
            system.debug('Inactive');
            
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            }
        }catch(Exception e){
            system.debug('Error SAVEMESSAGE INACTIVE == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
    }
    
    public PageReference setAsDefaultWorkHour(){
        String dayid = ApexPages.currentPage().getParameters().get('day_id');
        PageReference direct;
        try{
            wtcJSON = get();
            
            for(Integer i = 0; i < wtcJSON.data.working_hour.size(); i++){
                if(Integer.valueOf(dayid)-1 == 0 || Integer.valueOf(dayid)-1 == 1 || Integer.valueOf(dayid)-1 == 2 || Integer.valueOf(dayid)-1 == 3 || Integer.valueOf(dayid)-1 == 4){
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].work = 'true';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].start_hour = '8';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].start_min = '0';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].end_hour = '17';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].end_min = '0';
                }else{
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].work = 'false';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].start_hour = '0';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].start_min = '0';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].end_hour = '23';
                    wtcJSON.data.working_hour[Integer.valueOf(dayid)-1].end_min = '0';
                }
            }
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
                direct = new PageReference('/apex/LiveChatConfig');
                direct.setRedirect(true);
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            }
        }catch(Exception e){
            system.debug('Error SETASDEFAULWORKHOUR == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        return direct;
    }
    
    public PageReference setAsDefaultMessageActive(){
        
        channel = ApexPages.currentPage().getParameters().get('channel');
        PageReference direct;
        try{
            wtcJSON = get();
            if(channel == 'Facebook'){
                wtcJSON.data.messages.on_facebook = Label.Live_Chat_Active_Facebook_Message;
            }else if(channel == 'Whatsapp'){
                wtcJSON.data.messages.on_whatsapp = Label.Live_Chat_Active_Whatsapp_Message;
            }
            
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
                direct = new PageReference('/apex/LiveChatConfig');
                direct.setRedirect(true);
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
                return null;
            }
        }catch(Exception e){
            system.debug('Error SETASDEFAULMESSAGE ACTIVE == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        
        return direct;
    }
    
    public PageReference setAsDefaultMessageInactive(){
        
        channel = ApexPages.currentPage().getParameters().get('channel');
        PageReference direct;
        try{
            wtcJSON = get();
            if(channel == 'Facebook'){
                wtcJSON.data.messages.off_facebook = Label.Live_Chat_Inactive_Facebook_Message;
            }else if(channel == 'Whatsapp'){
                wtcJSON.data.messages.off_whatsapp = Label.Live_Chat_Inactive_Whatsapp_Message;
            }
            
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
                direct = new PageReference('/apex/LiveChatConfig');
                direct.setRedirect(true);
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
                return null;
            }   
        }catch(Exception e){
            system.debug('Error SETASDEFAULMESSAGE INACTIVE == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        
        return direct;
    }
    
    public void startAddHolidayDates(){
        newHoliday = new List<HolidayDates>();
        newHoliday.add(new HolidayDates());
    }
    
    public void addHolidayDates(){
        newHoliday.add(new HolidayDates());
    }
    
    public void minusHolidayDates(){
        HolidayDates hd = new HolidayDates();
        Integer hol_date = Integer.valueOf(ApexPages.currentPage().getParameters().get('cnt'));
        newHoliday.remove(hol_date);
    }
    
    public void saveNewHolidayDates(){
        try{
            wtcJSON = get();
            saveNewHoliday = new List<String>();
            invalidNewHoliday = new List<DateWrapper>();
            for(Integer i = 0;i < newHoliday.size();i++){
                if(!wtcJSON.data.holiday_dates.contains(String.valueOf(newHoliday[i].value))){
                    wtcJSON.data.holiday_dates.add(String.valueOf(newHoliday[i].value));
                    saveNewHoliday.add(String.valueOf(newHoliday[i].value));
                }else{
                    invalidNewHoliday.add(new DateWrapper(String.valueOf(newHoliday[i].value),'This date is already exist.'));
                }
            }
            
            String status = config(wtcJSON);
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
                newHoliday.clear();
                startAddHolidayDates();
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            }
        }catch(Exception e){
            system.debug('Error SAVENEWHOLIDAYDATES == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
    }
    
    public PageReference removeHolidayDates(){
        PageReference direct;
        try{
            String hol_date = ApexPages.currentPage().getParameters().get('hol_date');
            wtcJSON = get();
            for(Integer i = 0;i < wtcJSON.data.holiday_dates.size();i++){
                if(hol_date == wtcJSON.data.holiday_dates[i]){
                    wtcJSON.data.holiday_dates.remove(i);
                }
            }
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
                direct = new PageReference('/apex/LiveChatConfig');
                direct.setRedirect(true);
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            }
        }catch(Exception e){
            system.debug('Error REMOVEHOLIDAYDATES == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        return direct;
    }
    
    public PageReference removeAllHolidayDates(){
        PageReference direct;
        try{
            wtcJSON = get();
            wtcJSON.data.holiday_dates.clear();
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
                direct = new PageReference('/apex/LiveChatConfig');
                direct.setRedirect(true);
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            }
        }catch(Exception e){
            system.debug('Error REMOVEALLHOLIDAYDATES == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        return direct;
    }
    
    public void uploadHolidayDates(){
        try{
            wtcJSON = get();
            document.AuthorId = UserInfo.getUserId();
            document.FolderId = UserInfo.getUserId(); // put it in running user's folder
            string nameFile = document.body.toString();
            System.debug('document name '+document.name);
            boolean fileExtension = document.name.endsWith('.csv');
            
            if(!fileExtension){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Uploaded file type is not supported. Please upload only csv file.'));
            }
            List<String> dataList = parseCSV(nameFile,true);
            system.debug('dataList == '+dataList);
            String dateRegEx = '((19|20)\\d\\d)-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])';
            Pattern myPattern = Pattern.compile(dateRegEx);
            invalidNewHoliday = new List<DateWrapper>();
            saveNewHoliday = new List<String>();
            for(Integer i = 0;i < dataList.size();i++){
                Matcher myMatcher = myPattern.matcher(dataList[i]);
                if(!myMatcher.matches()){
                    invalidNewHoliday.add(new DateWrapper(dataList[i],'Invalid Date Format (yyyy/dd/mm)'));
                }else{
                    if(!wtcJSON.data.holiday_dates.contains(dataList[i])){
                        wtcJSON.data.holiday_dates.add(dataList[i]);
                        saveNewHoliday.add(dataList[i]);
                    }else{
                        invalidNewHoliday.add(new DateWrapper(dataList[i],'This date is already exist.'));
                    }
                }
            }
            String status = config(wtcJSON);
            
            if(status == 'Success'){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Data Berhasil Disimpan.'));
            }else{
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            }
        }catch(Exception e){
            system.debug('Error UPLOADHOLIDAYDATES == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
    }
    
    private List<String> parseCSV(String contents,Boolean skipHeaders) {
        
        List<String> dataList = new List<String>();
        
        try{
            contents = contents.replaceAll(',"""',',"DBLQT').replaceall('""",','DBLQT",');
            contents = contents.replaceAll('""','DBLQT');
            List<String> lines = new List<String>();
            try {
                lines = contents.split('\n');
            } catch (System.ListException e) {
                System.debug('Limits exceeded?' + e.getMessage());
            }
            system.debug('Line num i s'+lines.size());
            for(String line : lines) {
                dataList.add(line.trim());
            }
            if (skipHeaders) dataList.remove(0);
        }catch(Exception e){
            system.debug('Error PARSECSV == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        return dataList;    
        
    }
    
    public void enableButtonRemove(){
        isDisabled = false;
    }
    
    public WorkingTimeConfigJSON get(){
        try{
            String endpointGet = endpoint+'/getWorkingTimeConfiguration/';
            System.debug('endpointGet = ' + endpointGet + ' methodGet = ' + methodGet + ' timeout = ' + Integer.ValueOf(Label.WS_Callout_Timeout));
            RESTWebserviceService rws = new RESTWebserviceService(endpointGet, 'Live Chat', methodGet, Integer.ValueOf(Label.WS_Callout_Timeout));
            System.debug('RESTWebserviceService Live Chat =  ' + rws);
            rws.send();
            String responseJsonEIP = rws.getResponseBodyReplace();
            wtcJSON = (WorkingTimeConfigJSON) System.JSON.deserialize(responseJsonEIP, WorkingTimeConfigJSON.class);
            system.debug('================');
            system.debug('responseJsonEIP : '+responseJsonEIP);
            system.debug('Data wtcJSON : '+wtcJSON.Data);
            system.debug('================');
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
            system.debug('Error GET == '+e.getStackTraceString()+' in '+e.getLineNumber());
        }
        return wtcJSON;
    }
    
    public String config(WorkingTimeConfigJSON wtcJSON){
        
        WorkingTimeConfigJSON postJSON = new WorkingTimeConfigJSON();
        try{
            WorkingTimeConfigJSON configJSON = new WorkingTimeConfigJSON();
            configJSON.working_hour = wtcJSON.data.working_hour;
            configJSON.messages = wtcJSON.data.messages;
            configJSON.holiday_dates = wtcJSON.data.holiday_dates;
            
            String jsonRequest = System.JSON.serialize(configJSON, true);
            postJSON = post(jsonRequest);  
        }catch(Exception e){
            system.debug('Error CONFIG == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        
        return postJSON.status;
    }
    
    public WorkingTimeConfigJSON post(String jsonRequest){
        try{
            String endpointGet = endpoint+'/editWorkingTimeConfiguration/';
            System.debug('jsonRequest == ' + jsonRequest);
            System.debug('endpointGet == ' + endpointGet);
            RESTWebserviceService rws = new RESTWebserviceService(endpointGet, jsonRequest, methodPost, Integer.ValueOf(Label.WS_Callout_Timeout));
            rws.send();
            String responseJsonEIP = rws.getResponseBodyReplace();
            
            wtcJSON = (WorkingTimeConfigJSON) System.JSON.deserialize(responseJsonEIP, WorkingTimeConfigJSON.class);
            system.debug('================');
            system.debug('responseJsonEIP : '+responseJsonEIP);
            system.debug('================');
            
        }catch(Exception e){
            system.debug('Error POST == '+e.getStackTraceString()+' in '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada kesalahan. Silahkan hubungi admin.'));
        }
        return wtcJSON;
    }
}