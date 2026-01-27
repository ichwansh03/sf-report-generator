public class CallLineGroupByAGI {
    @future
    public static void CallLine(id choosen_campaign, String entity){
    //public static String CallLine(id choosen_campaign, String entity)

        List<Call_Line__c> ListCLUpdate = new List<Call_Line__c>();
        string temp = '';
        id Parentid; 
        for (Call_Line__c cl : [SELECT id, Policy_No__c, Entity__c, Name, Parent_Name_Mobile__c, Contact__c, Contact__r.Name,
                                Name_1__c, Contacted_Number__c, Call_List__c, Parent_Call_Line__c, Parent_Campaign__c
                               From Call_Line__c WHERE Call_List__c = :choosen_campaign AND Entity__c = :entity 
                                // fix for Parent belum di mapping, 26 feb 2018
                               and Parent_Call_Line__c = NULL and Parent_Campaign__c = NULL
                                ORDER BY Name_1__c, Contacted_Number__c]) {
                                //ORDER BY Contact__r.Name, Name_1__c, Contacted_Number__c])
            if (isNUll(cl.Name_1__c) == '') cl.Name_1__c = cl.Contact__r.Name;
            if (temp != (isNUll(cl.Name_1__c)+''+isNUll(cl.Contacted_Number__c)) ) {
                cl.Parent_Campaign__c = cl.Call_List__c;
                cl.Parent_Call_Line__c = NULL;
                
                temp = isNUll(cl.Name_1__c)+''+isNUll(cl.Contacted_Number__c);
                Parentid = cl.id;
            }
            else {
                cl.Parent_Campaign__c = null;
                cl.Parent_Call_Line__c = Parentid; 
            }
            ListCLUpdate.add(cl);
        }
        system.debug('data update : '+ListCLUpdate.size());
        if (ListCLUpdate.size() > 0) update ListCLUpdate;
        //return null;
    }
    
    public static string isNUll(String param){
        string result ='';
        if (param == NULL) result = '';
        else result = param;
        Return result;
    }
}