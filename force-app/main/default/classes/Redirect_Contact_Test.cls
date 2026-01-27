@isTest (seealldata=true)
private class Redirect_Contact_Test{
  static testMethod void test_actionfunction_UseCase1(){
    //PageReference pageRef = Page.Redirect_Contact;
    //pageRef.getParameters().put('id');
    //Redirect_Contact obj01 = new Redirect_Contact();
    //
      Redirect_Contact rc = new Redirect_Contact();
      rc.urlval = 'test data';
      rc.strval = 'test data';
      //Log_CTI_Valdo__c lcti =  [select id from Log_CTI_Valdo__c limit 1];
      Call_Line__c call_line_Obj = new Call_Line__c(Is_Already_Assigned__c = false, Is_Calledback_Already__c = false, Update_Child__c = false);
      Insert call_line_Obj; 
      Log_CTI_Valdo__c lcti = new Log_CTI_Valdo__c(from__c = '081218625912', Mode__c='API Call Out', SIP__C = '703', Status__c = 'Outbound', call_line__c = call_line_Obj.Id);
      insert lcti;
      rc.ids = lcti.id;
      rc.actionfunction();
  }
    
    static testMethod void test_actionfunction_UseCase2(){
        //PageReference pageRef = Page.Redirect_Contact;
        //pageRef.getParameters().put('id');
        //Redirect_Contact obj01 = new Redirect_Contact();
        //
        Redirect_Contact rc = new Redirect_Contact();
        rc.urlval = 'test data';
        rc.strval = 'test data';
        //Log_CTI_Valdo__c lcti =  [select id from Log_CTI_Valdo__c where Mode__c='API Call In' limit 1];
        Log_CTI_Valdo__c lcti = new Log_CTI_Valdo__c(from__c = '08978687676878', Mode__c='API Call In', SIP__C = '703', Status__c = 'Inbound');
        insert lcti;
        rc.ids = lcti.id;
        rc.actionfunction();
    }
}