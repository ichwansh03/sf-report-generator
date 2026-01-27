public with sharing class CustomCaseLookupController {

  public Case cases {get;set;} // new account to create
  public List<Case> results {get;set;} // search results
  public string searchString {get;set;} // search keyword
  public string contactId {get;set;} // search keyword
  
  public CustomCaseLookupController() {
    cases = new Case();
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    contactId = System.currentPageReference().getParameters().get('contactId');
    runSearch();  
  }

  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }

  // prepare the query and issue the search command
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    results = performSearch(searchString);               
  } 

  // run the search and return the records found. 
  public List<Case> performSearch(string searchString) {
    DescribeSObjectResult describeResultAcc = Case.getSObjectType().getDescribe();
    List<String> accFieldList = new List<String>(describeResultAcc.fields.getMap().keySet());
    String accFields = String.join(accFieldList, ',');
    //String soql = 'select id, casenumber, case_type__c, contact.name, subject, contactid, accountid, account.name, status, type, recordtypeid, recordtype.name  from case where contactid = '+'\'' +contactId+ '\''+' and parentid = null';
    String soql = 'select ' +accFields+ ' , contact.name, account.name, recordtype.name from case where contactid = '+'\'' +contactId+ '\''+' and parentid = null';
    if(searchString != '' && searchString != null)
    soql = soql +  ' and (casenumber LIKE \'%' + searchString +'%\''+' OR case_type__c LIKE \'%' + searchString +'%\''+' OR contact.name LIKE \'%' + searchString +'%\''+' OR subject LIKE \'%' + searchString +'%\''+' OR account.name LIKE \'%' + searchString +'%\''+' OR status LIKE \'%' + searchString +'%\''+' OR type LIKE \'%' + searchString +'%\''+' OR recordtype.name LIKE \'%' + searchString +'%\''+')';
    soql = soql + ' order by casenumber desc limit 25';
    System.debug(soql);
    return database.query(soql); 

  }

  // save the new account record
  public PageReference saveCase() {
    insert cases;
    // reset the account
    cases = new Case();
    return null;
  }

  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }

  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }

}