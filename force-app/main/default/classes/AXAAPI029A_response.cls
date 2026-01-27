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
public class AXAAPI029A_response {
        
    
    public class Data {
        Public String objectName {get;set;}
        Public String count {get;set;}
        
        public Data(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        IF (text == 'objectName') { objectName= parser.getText();}
                        ElSE IF (text == 'count') { count= parser.getText();}
                       
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
    
    public AXAAPI029A_response(JSONParser parser) {
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
                        System.debug(LoggingLevel.WARN, 'AXAAPI029A_response consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static AXAAPI029A_response parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new AXAAPI029A_response(parser);
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