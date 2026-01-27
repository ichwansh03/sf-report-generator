public class LogBookPolicyLookupController {
    private final static String PRODUCT_DMTM = 'DMTM';
    private final static String PRODUCT_KONVEN = 'Konvensional';
    private final static String PRODUCT_SYARIAH = 'Syariah';
    private final static String PRODUCT_CORPSOL = 'Corpsol';
    
    public List<Contact> listContact {get; set;}
  	public String searchString {get;set;}
    public List<Map<String,String>> policyResult {get; set;}
    
    public LogBookPolicyLookupController(){
        searchString = System.currentPageReference().getParameters().get('spno');
        runSearch();
    }
    
    public PageReference search() {
        try{
        	runSearch();
        }catch(QueryException qex){
            System.debug(qex.getStackTraceString() + ' || ' + qex.getTypeName() + ' || ' + qex.getMessage());
        }catch(Exception ex){
            System.debug(ex.getStackTraceString() + ' || ' + ex.getTypeName() + ' || ' + ex.getMessage());
        }
        return null;
    }
    
    private void runSearch() {
        if(String.isNotEmpty(searchString)){
            policyResult = performSearch(searchString+'%', '%'+searchString+'%');
        }
    } 
    
    public List<Map<String,String>> performSearch(String searchPolicyNo, String searchName) {
		List<Contact> contacts = [SELECT id, Policy_No__c, Name 
                                  FROM Contact 
                                  WHERE Entity__c = 'AMFS' AND PolicyApp__c IN ('RLS','DMTM') AND RecordType.Name = 'Contact' AND (Policy_No__c LIKE :searchPolicyNo OR Name LIKE :searchName) 
                                  ORDER BY Policy_No__c LIMIT 25];
        
        List<Map<String,String>> result = new List<Map<String,String>>();
        for(Contact cont : contacts){
            Map<String, String> mapCont = new Map<String, String>();
            mapCont.put('PolicyNo', cont.Policy_No__c);
            mapCont.put('PolicyNameHolder', cont.Name);
            mapCont.put('PolicyProductType', cekPolicyProduct(cont.Policy_No__c));
            result.add(mapCont);
        }
        return result;
    }
    
    private String cekPolicyProduct(String policyNo){        
        String productType = '';
        if(policyNo != null){
            if(policyNo.startsWith('1') || policyNo.startsWith('4')){
                productType = PRODUCT_DMTM;
            }else if(policyNo.startsWith('5') || policyNo.startsWith('8')){
                productType = PRODUCT_KONVEN;
            }else if(policyNo.startsWith('3')){
                productType = PRODUCT_SYARIAH;
            }else if(policyNo.startsWith('80')){
                productType = PRODUCT_CORPSOL;
            }
        }
        return productType;
    }
}