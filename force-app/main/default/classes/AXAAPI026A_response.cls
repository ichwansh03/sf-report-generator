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
public class AXAAPI026A_response {
        
    
    public class Data {
        Public String createdById {get;set;}
        Public Datetime createdDate {get;set;}
        Public String dataType {get;set;}
        Public String field {get;set;}
        Public String id {get;set;}
        Public Boolean isDeleted {get;set;}
        Public String newValue {get;set;}
        Public String oldValue {get;set;}
        Public String parentId {get;set;}
        Public String createdById_Name {get;set;}
        Public String action {get;set;}
        
        public Data(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        
                        
                        IF (text == 'createdById') { 
                                    createdById= parser.getText();
                                    if (createdById != null) createdById_Name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
                        }
                        ElSE IF (text == 'createdDate') { createdDate= AXAAPI_UtilityClass.stringToDatetime(parser.getText());}
                        ElSE IF (text == 'dataType') { dataType = parser.getText();}
                        ElSE IF (text == 'field') { 
                            field = parser.getText();
                            
                        }
                        ElSE IF (text == 'id') { id = parser.getText();}
                        ElSE IF (text == 'isDeleted') { 
                                    String a = parser.getText();
                                    isDeleted = Boolean.valueOf(a);}
                        ElSE IF (text == 'newValue') { newValue = parser.getText();}
                        ElSE IF (text == 'oldValue') { oldValue = parser.getText();                                                    
                                                     }
                        ElSE IF (text == 'parentId') {  parentId = parser.getText();}
                        ELSE{
                                System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
                                consumeObject(parser);
                        }
                        
                        
                        if(field != null && field == 'created'){
                            action = 'Created';
                        } else if(field != null && field == 'Agent__c') {
                           
                            action = 'Change  Agent from ' + oldValue + ' to ' + newValue;
                        } else {
                           
                            action = 'Change ' + field + ' from ' + oldValue + ' to ' + newValue;
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
    
    public AXAAPI026A_response(JSONParser parser) {
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
                        System.debug(LoggingLevel.WARN, 'AXAAPI026A_response consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static AXAAPI026A_response parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new AXAAPI026A_response(parser);
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