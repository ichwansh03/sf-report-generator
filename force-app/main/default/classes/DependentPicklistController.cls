public class DependentPicklistController {

    public static Map<Object, List<String>> getDependentPicklistValues(Schema.SObjectField dependToken) {
        Schema.DescribeFieldResult depend = dependToken.getDescribe();
        Schema.SObjectField controlToken = depend.getController();
        
        if (controlToken == null) return null;
        
        Schema.DescribeFieldResult control = controlToken.getDescribe();
        List<Schema.PicklistEntry> controlEntries = (control.getType() == Schema.DisplayType.Boolean ? null : control.getPicklistValues());
        
        String base64map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        Map<Object, List<String>> dependentPicklistValues = new Map<Object, List<String>>();
        
        for (Schema.PicklistEntry entry : depend.getPicklistValues()) if (entry.isActive()) {
            List<String> base64chars = String.valueOf(((Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')).split('');
            
            for (Integer i = 0; i < (controlEntries != null ? controlEntries.size() : 2); i++) {
                Object controlValue = (controlEntries == null ? (Object) (i == 1) : (Object) (controlEntries[i].isActive() ? controlEntries[i].getLabel() : null));
                Integer bitIndex = i / 6;
                if (bitIndex > base64chars.size() - 1) {break;}
                Integer bitShift = 5 - Math.mod(i, 6);
                
                if (controlValue == null || (base64map.indexOf(base64chars[bitIndex]) & (1 << bitShift)) == 0) continue;
                
                if (!dependentPicklistValues.containsKey(controlValue)) {
                    dependentPicklistValues.put(controlValue, new List<String>());
                }
                dependentPicklistValues.get(controlValue).add(entry.getLabel());
            }                                             
        }
        return dependentPicklistValues;
    }
    
    //get picklist value based on controlling field picklist, use getDependentPicklistValues(object name, dependent picklist field name)
    public static Map<Object, List<String>> getDependentPicklistValues(String sObjectName, String fieldName) {
        return getDependentPicklistValues(Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap().get(fieldName));
    }
    
    //get all picklist values from picklist field
    public static List<String> getPicklistValue(String sObjectName, String fieldName){
        List<String> picklistVal = new List<String>();
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(sObjectName);
        Schema.DescribeSObjectResult objResult = objType.getDescribe();
        Map<String, Schema.SObjectField> fields = objResult.fields.getMap();
        Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry pickVal : ple) {
            picklistVal.add(pickVal.getValue());
        }
        
        return picklistVal;
    }
}