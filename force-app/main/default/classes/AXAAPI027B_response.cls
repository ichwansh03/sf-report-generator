/*---------------------------------------------------------------
    Author      : Fikri Hailal
    Company     : MII
    Description : 
    Inputs      : 
    Test Class  : 

    <History>
    <Date>      <Authors Name>     <Brief Description of Change>    
    01-11-2022    Fikri Hailal         Created
---------------------------------------------------------------*/

public class AXAAPI027B_response {
    public AXAAPI027B_response(){}
    public class Data {
        Public Data() {}
        Public String name {get;set;}
        Public String createdById {get;set;}
        Public String createdById_name {get;set;}
        Public Datetime createdDate {get;set;}
        Public String ownerId {get;set;}
        Public String ownerId_name {get;set;}
        Public String lastModifiedById {get;set;}
        Public String lastModifiedById_name {get;set;}
        Public Datetime lastModifiedDate {get;set;}
       
        
        
        public Data(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'createdById'){
                            createdById = parser.getText();
                            if(createdById != null) createdById_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
                        } else if (text == 'createdDate') {
                            createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'lastModifiedById') {
                            lastModifiedById = parser.getText();
                            if(lastModifiedByid != null) lastModifiedById_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
                        } else if (text == 'lastModifiedDate') {
                            lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if (text == 'ownerId') {
                            ownerId = parser.getText();
                            if(ownerid != null) ownerId_name = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'User', 'Name');
                        } else {
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
    public Data data {get;set;} 

    public AXAAPI027B_response(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'status') {
                        status = parser.getText();
                    } else if (text == 'message') {
                        message = parser.getText();
                    } else if (text == 'data') {
                        data = new Data(parser);
                    } else {
                        System.debug(LoggingLevel.WARN, 'AXAAPI027B_response consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static AXAAPI027B_response parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new AXAAPI027B_response(parser);
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
}