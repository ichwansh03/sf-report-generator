public without sharing class CaseDuplicateListController {
    public Id id { get; set; }
    public List<Case> cases { get; set; }
    public  Case caseItem { get; set;}
    
  public CaseDuplicateListController() {
    id = ApexPages.currentPage().getParameters().get('id');
    System.debug('AMFS_E2C_ - id Case:' + id);
    cases = new List<Case>();


    System.debug('AMFS_E2C_ - CaseDuplicateListController constructor called');
    System.debug('AMFS_E2C_ - Start query RecordType: ' + System.Label.AMFS_Case_Type);
    RecordType rt = [SELECT Id, Name FROM RecordType 
    WHERE SObjectType = 'Case' 
    AND Name = :System.Label.AMFS_Case_Type LIMIT 
    1];
    System.debug('AMFS_E2C_ - RecordType found: ' + rt.Name + ' with Id: ' + rt.Id);


    System.debug('AMFS_E2C_ - Querying Case with Id: ' + id);
    if (id != null) {
      System.debug('AMFS_E2C_ - Querying Case with RecordTypeId: ' + rt.Id);

      // Query the Case with the given Id and RecordTypeId

      List<Case> caseList = [
        SELECT
          Id, e2cEmailToAddress__c, Subject, CreatedDate, SuppliedEmail, CaseNumber, Status, Priority, Description
        FROM Case
        WHERE Id = :id AND  
          RecordTypeId = :rt.Id
        LIMIT 1
      ];
      System.debug('AMFS_E2C_ - Case List Size: ' + caseList.size());
        

      if (!caseList.isEmpty()) {
         caseItem = caseList[0];

        System.debug('AMFS_E2C_ - Supplied Email ' + caseItem.SuppliedEmail);
        System.debug('AMFS_E2C_ - Subject ' + caseItem.Subject);
        cases = [
          SELECT Id, CaseNumber, Subject, Status, Priority, CreatedDate, Description
          FROM Case
          WHERE
            SuppliedEmail = :caseItem.SuppliedEmail
            AND Subject = :caseItem.Subject
            AND Id != :id
            AND CreatedDate = LAST_N_DAYS:14
          ORDER BY CreatedDate DESC
          LIMIT 50
        ];
        System.debug('Cases found: ' + cases.size());
      }
    }
  }
}