/*---------------------------------------------------------------
    Author      : Fikri Hailal
    Company     : MII
    Description : 
    Inputs      : 
    Test Class  : 

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    01-11-2022    Fikri Hailal          Created
---------------------------------------------------------------*/
public class AXAAPI028A_response {
        
    
    public class Data {
        Public String activity_Result_c {get;set;}
        Public String agent_c {get;set;}
        Public String call_Bucket_c {get;set;}
        Public Datetime call_Date_c {get;set;}
        Public String call_Duration_Minutes_c {get;set;}
        Public String call_Result_c {get;set;}
        Public String campaign_Type_c {get;set;}
        Public String createdById {get;set;}
        Public Datetime createdDate {get;set;}
        Public String entity_c {get;set;}
        Public String id {get;set;}
        Public String isDeleted {get;set;}
        Public String lastModifiedById {get;set;}
        Public Datetime lastModifiedDate {get;set;}
        Public String name {get;set;}
        Public String owner_Entity_c {get;set;}
        Public String ownerId {get;set;}
        Public Datetime systemModstamp {get;set;}
        Public String createdById_name {get;set;}        
        Public String lastModifiedById_Name {get;set;}        
        public String agent_C_name {get;set;}
        
        public Data(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        IF (text == 'activity_Result__c') { activity_Result_c= parser.getText();}
                        ElSE IF (text == 'agent__c') { 
                                    agent_c= parser.getText();
                                    if (agent_c != null) agent_C_name = AXAAPI_UtilityClass.getsObjectNameById(agent_c, 'User', 'Name');
                        }
                        ElSE IF (text == 'call_Bucket__c') { call_Bucket_c= parser.getText();}
                        ElSE IF (text == 'call_Date__c') { call_Date_c= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'call_Duration_Minutes__c') { 
                                    call_Duration_Minutes_c= parser.getText();
                                    if(call_Duration_minutes_c == '0')
                                    {
                                        call_Duration_Minutes_c = null;
                                    }
                                                                     }
                        ElSE IF (text == 'call_Result__c') { call_Result_c= parser.getText();}
                        ElSE IF (text == 'campaign_Type__c') { campaign_Type_c= parser.getText();}
                        ElSE IF (text == 'createdById') { 
                                    createdById= parser.getText();
                                    if (createdById != null) createdById_Name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
                        }
                        ElSE IF (text == 'createdDate') { createdDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'entity__c') { entity_c= parser.getText();}
                        ElSE IF (text == 'id') { id= parser.getText();}
                        ElSE IF (text == 'isDeleted') { isDeleted = parser.getText();}
                        ElSE IF (text == 'lastModifiedById') { 
                                    lastModifiedById= parser.getText();
                                    if (lastModifiedById != null) lastModifiedById_Name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
                        }
                        ElSE IF (text == 'lastModifiedDate') { lastModifiedDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'name') { name= parser.getText();}
                        ElSE IF (text == 'owner_Entity__c') { owner_Entity_c= parser.getText();}
                        ElSE IF (text == 'ownerId') { ownerId= parser.getText();}
                        ElSE IF (text == 'systemModstamp') { systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ELSE{
                                System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
                                consumeObject(parser);
                             }
                    }
                }
            }
        }
    }
    
    public String status {get;set;} 
    public String message {get;set;} 
    public List<Data> data {get;set;} 
    public Integer counts {get;set;}
    
    public AXAAPI028A_response(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'status') {
                        status = parser.getText();
                    } else if (text == 'message') {
                        message = parser.getText();
                    } else if (text == 'data') {
                        data = arrayOfData(parser);
                    } else if (text == 'counts') {
                        counts = parser.getIntegerValue();
                    }else {
                        System.debug(LoggingLevel.WARN, 'AXAAPI028A_response consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static AXAAPI028A_response parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new AXAAPI028A_response(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }
    

    private static List<Data> arrayOfData(System.JSONParser p) {
        List<Data> res = new List<Data>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Data(p));
        }
        return res;
    }

}