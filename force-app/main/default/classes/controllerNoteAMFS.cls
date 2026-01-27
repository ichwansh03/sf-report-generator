Public class controllerNoteAMFS {
    public Integer uploadedNum {get; set;}
    public Integer TotalPolis {get; set;}
    public List<Call_Line__c> Call_Line {get; set;} 
    public String selectedType{get;set;}   
//    public Blob csvFileBody{get;set;}
//    Public string csvAsString{get;set;}
    Public String[] csvfilelines{get;set;}
     map<string, List<string>> mapCallLine = new map<string, List<string>>();
    
    
    private ControllerHelper ControllerHelper;

    public controllerNoteAMFS(ControllerHelper helper) {
        ControllerHelper = helper;
    }
    
    
     public controllerNoteAMFS(){
        selectedType = '';
        csvFileLines = new String[]{};
        Call_Line = new List<Call_Line__c>();
        uploadedNum = 0;
        TotalPolis = 0;
         
     }
    
     public Document document {
        get {
            if (document == null){
                document = new Document();
            }
            return document;
        }
        set;
    }
    
 
    public PageReference upload() {
            
        try {
            Call_Line = new List<Call_Line__c>();
        if (selectedType == 'None' ){
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please Select Value'));
              return null;
             }
           else if(document.body==null || document.body.toString() == ''){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No file is selected.'));
                return null;
            }else{
                String nameFile = document.body.toString();
                System.debug('document name '+document.name);
                boolean fileExtension = document.name.endsWith('.csv');
                if(!fileExtension){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Uploaded file type is not supported. Please upload only csv file.'));
                    return null;
                }
                Call_Line = processCSV(nameFile,true);
                uploadedNum = Call_Line.size();

                
                
            }
        } catch (DMLException e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file/ Data tidak sesuai'));
            system.debug('Error '+e.getMessage());
            return null;
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            return null;
        } finally {
            document.body = null; // clears the viewstate
            document = new Document();
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));

        return null;
    }    
    
    public void recordtype(){
        if (selectedType == 'None' ){
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Please Select RecordType'));
        }
    }
    
    
    @TestVisible 
    public List<Call_Line__c> processCSV(String contents, Boolean skipHeaders) {
    List<Call_Line__c> dataList = new List<Call_Line__c>();

    List<String> lines = new List<String>();
    try {
        lines = contents.split('\n');
    } catch (System.ListException e) {
        System.debug('Limits exceeded?' + e.getMessage());
    }
    system.debug('Line num i s'+lines.size());

    if (skipHeaders) lines.remove(0);

    list<string> listCallLineName = new list<string>();

    for(String line : lines) {
        String[] data = line.split(',');

        listCallLineName.add(data[0]);
        System.debug('data 0 di csv : '+data[0]);
    }

    TotalPolis = listCallLineName.size();
   
    list<call_line__c> getCallLine = new list<call_line__c>();
    System.debug('selectedType : '+selectedType);
    if (selectedType == 'WelcomeCall') {
        getCallLine = [Select id, name, Policy_No__c, contact__c, contact__r.policy_no__c FROM Call_Line__c WHERE Policy_No__c IN :listCallLineName AND RecordType.name ='Welcome Call'];

        System.debug('data : '+getCallLine);
    } else if (selectedType == 'Tele UW') {
        getCallLine = [Select id, name, Policy_No__c, contact__c, contact__r.policy_no__c FROM Call_Line__c WHERE Policy_No__c IN :listCallLineName AND RecordType.name ='TelUW'];

        System.debug('data : '+getCallLine);
    } else {
        getCallLine = [Select id, name FROM Call_Line__c WHERE name IN :listCallLineName];
    }

   for (call_line__c row: getcallline){
        List<String> callId = new List<String>();
        
       if (!Test.isRunningTest() && selectedType == 'WelcomeCall' || selectedType == 'Tele UW' ){
        if (mapcallline.containskey(row.contact__r.policy_no__c)){
        callId = mapcallline.get(row.contact__r.policy_no__c);
        
        } 
        callId.add(row.id); 
        mapcallline.put(row.contact__r.policy_no__c, callId);
        }
       
       else {
        callId.add(row.id);
        mapcallline.put(row.name, callId);
       }
   }
    System.debug('data 1 : '+mapCallLine);

    for (String line : lines) {
        String[] data = line.split(',');
        String callLineName = data[0];
        if (mapCallLine.containsKey(callLineName)) {
            List<string> callLineIds = mapCallLine.get(callLineName);
            for (string callId: mapCallLine.get(data[0])) {
                Call_Line__c couObj = new Call_Line__c();
                couObj.id = callId;
                couObj.Call_Notes_1__c = data[1].trim();
                couObj.Call_Notes_2__c = data[2].trim();
                couObj.Call_Notes_3__c = data[3].trim();
                dataList.add(couObj);
                System.debug('data obj : '+callId);
             	System.debug('polno : '+dataList);
            }
        }
    }
        
 /*       if(couObj != null){
                 dataList.add(couObj);
                 update datalist;}
             System.debug('data obj : '+couObj.id);
             System.debug('polno : '+dataList);
        }*/

    update datalist;
    return dataList;

}
    
}