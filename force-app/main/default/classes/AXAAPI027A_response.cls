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
public class AXAAPI027A_response {
        
    
    public class Data {
        Public String id {get;set;}
        Public String name {get;set;}
        Public String sfdC_Order_Id_c {get;set;}
        Public String origin_c {get;set;}
        Public String payment_Type_c {get;set;}
        Public String policy_App_c {get;set;}
        Public String mid_status_code_c {get;set;}
        Public String mid_status_message_c {get;set;}


        public Data(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        IF (text == 'name') { name= parser.getText();}
                        ELSE IF (text == 'id'){id = parser.getText();}
                        ElSE IF (text == 'sfdC_Order_Id__c') { sfdC_Order_Id_c= parser.getText();}
                        ElSE IF (text == 'origin__c') { origin_c= parser.getText();}
                        ElSE IF (text == 'payment_Type__c') { payment_Type_c= parser.getText();}
                        ElSE IF (text == 'policy_App__c') { policy_App_c= parser.getText();}
                        ElSE IF (text == 'mid_status_code__c') { mid_status_code_c= parser.getText();}
                        ElSE IF (text == 'mid_status_message__c') { mid_status_message_c= parser.getText();}
                        
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
    
    public AXAAPI027A_response(JSONParser parser) {
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
                        System.debug(LoggingLevel.WARN, 'AXAAPI027A_response consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static AXAAPI027A_response parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new AXAAPI027A_response(parser);
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