/**
 * @description       : 
 * @author            : Mario Carlos Eyo
 * @group             : 
 * @last modified on  : 31-07-2025
 * @last modified by  : Mario Carlos Eyo
**/
global without sharing class AMFS_GeneratePDFController {
    
    public AMFS_GeneratePDFController(ApexPages.StandardController controller) {
        // Can be used if needed
    }
    @RemoteAction
    global static string generatePDF(String recordId) {
        // Get the describe for the object
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('E_Form_Master_Data__c').getDescribe().fields.getMap();

        // Build the field list dynamically
        String fields = String.join(new List<String>(fieldMap.keySet()), ',');

        // Construct and execute the dynamic SOQL query
        String query = 'SELECT ' + fields + ' FROM E_Form_Master_Data__c WHERE Id = :recordId';
        List<SObject> results = Database.query(query);

        List<E_Form_Master_Data__c> eform = new List<E_Form_Master_Data__c>();
        eform.add((E_Form_Master_Data__c)results[0]);

        // Call your existing method
        AMFS_GeneratePDF.AMFS_GeneratePDF(eform);

        return 'Success';
    }
}