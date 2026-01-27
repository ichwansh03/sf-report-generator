@isTest (seealldata=true)
private class Redirect_Contact2_Test{
  static testMethod void test_actionfunction_UseCase1(){
    //PageReference pageRef = Page.Redirect_Contact;
    //pageRef.getParameters().put('id');
    //Redirect_Contact obj01 = new Redirect_Contact();
    //
      Redirect_Contact2 rc = new Redirect_Contact2();
      rc.urlval = 'test data';
      rc.strval = 'test data';
      Contact ct = [SELECT id FROM Contact Limit 1];
        
      Assign_Log__c lcti = new Assign_Log__c(
      Contact__c = ct.id,
      Entity__c = 'ALI'
      );
      insert lcti;
      rc.ids = lcti.id;
      rc.actionfunction();
  }
    
    static testMethod void test_actionfunction_UseCase2(){
        //PageReference pageRef = Page.Redirect_Contact2;
        //pageRef.getParameters().put('id');
        //Redirect_Contact2 obj01 = new Redirect_Contact2();
        //
        Redirect_Contact2 rc = new Redirect_Contact2();
        rc.urlval = 'test data';
        rc.strval = 'test data';
        Contact ct = [SELECT id FROM Contact Limit 1];

        //Assign_Log__c lcti =  [select id from Assign_Log__c where Mode__c='API Call In' limit 1];
        Assign_Log__c lcti = new Assign_Log__c(
        Contact__c = ct.id,
        Entity__c = 'ALI'
        );
        insert lcti;
        rc.ids = lcti.id;
        rc.actionfunction();
    }
}