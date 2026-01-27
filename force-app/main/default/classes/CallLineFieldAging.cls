public class CallLineFieldAging {
    public Call_line__c cl {get;set;} 
    public List<Master_Pinalty__c> listDataTable {get;set;}  
    public boolean isNCB {get;set;} 
    public boolean isPinalty {get;set;} 
    public boolean isWithdrawal {get;set;} 
    public boolean isSurrender {get;set;}  
    public String productName {get;set;} 
    public String codeName {get;set;} 
    public String subTypeProduct {get;set;} 
    public String colspanProductName {get;set;}
    public String rowspanThead {get;set;}
    public String stylePinalty1 {get;set;}
    public String stylePinalty2 {get;set;}
    public String stylePinalty3 {get;set;}
    public String stylePinalty4 {get;set;}
    Public String showTablePinalty {get;set;}
    public Boolean column1 {get;set;}
    public Boolean column2 {get;set;}
    public Boolean column3 {get;set;}
    public Boolean column4 {get;set;}
    
 
    public CallLineFieldAging(ApexPages.StandardController std){ 
        column1 = false;
        column2 = false;
        column3 = false;
        column4 = false; 
        stylePinalty1 = 'display:none;';
        stylePinalty2 = 'display:none;';
        stylePinalty3 = 'display:none;';
        stylePinalty4 = 'display:none;';
        showTablePinalty = 'display:none;';
        colspanProductName = '1';
        rowspanThead = '1';
        cl = (Call_Line__c)std.getRecord();
        system.debug('cl: '+cl);
        Call_line__c getRecord = [Select id, Formula_Product__c from Call_line__c where id =: cl.id ];
        // Call_line__c getRecord = [Select id, Formula_Product__c from Call_line__c where id =: 'a015D00000E6z2R' ];
        system.debug('Product: '+getRecord);
        isNCB = false;
        isPinalty = false;
        String productContact = '';
        listDataTable = [SELECT Id, Description__c,IDR__c,IsActive__c,IDR_2__c,Kode__c,Percentage__c, Product__c,
                         sub_type__c, Type_Product__c, USD__c, USD_2__c, Protection__c, Variabel__c, Prime__c 
                         FROM Master_Pinalty__c where Kode__c includes (: getRecord.Formula_Product__c ) AND IsActive__c = true order by Id];
        system.debug('listDataTable:'+listDataTable);
        for (Master_Pinalty__c row : listDataTable) {
            if (row.type_product__c == 'NCB') isNCB = true;
            if (row.type_product__c == 'Finalty') {
                isPinalty = true;
                showTablePinalty = '';
            }
            if (row.Variabel__c != null) {
                // isSurrender = true;
        		// colspanProductName = '4';
                // rowspanThead = '4';
                
                stylePinalty3 = '';
                column3 = true;
            } else if (row.Prime__c != null) {
                // isSurrender = true;
        		// colspanProductName = '4';
                // rowspanThead = '4';
                stylePinalty4 = ''; 
                column4 = true;
            } else if (row.sub_type__c == 'Finalti Surrender/Withdrawal') {
                isWithdrawal = true; 
                rowspanThead = '3';
                stylePinalty1 = ''; 
                column1 = true;
            } else if (row.sub_type__c == 'Finalti/Surrender') {
                isSurrender = true;
        		colspanProductName = '4';
                rowspanThead = '4';
                stylePinalty2 = ''; 
                column2 = true;
            } 
            
            productName = row.Product__c;
            subTypeProduct = row.sub_type__c; 
            codeName = String.valueOf(row.Kode__c).replaceAll(';','/'); 
        } 
        
    }
     
}