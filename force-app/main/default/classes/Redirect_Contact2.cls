public class Redirect_Contact2 {
    List<Contact> listcontact{get;set;}
    Public String urlval{get;set;}
    Public String strval{get;set;}
    Public String ids {get;set;}
    Public String contact_name {get;set;}
    public Redirect_Contact2(ApexPages.StandardController controller){
        strval =''; urlval=''; contact_name=''; ids = ApexPages.CurrentPage().getParameters().get('id'); system.debug('*ids*'+ids);
        
    }

    public Redirect_Contact2(){
        if(test.isRunningTest()){
          strval ='';
            urlval='';
            contact_name='';
            system.debug('*ids*'+ids);    
        }
        
    }
        
    public void actionfunction(){
        if(ids!=null){
            Assign_Log__c lcti = [select contact__c from Assign_Log__c where id=:ids];
                listcontact = [select id, name, phone, homephone, mobilephone, otherphone, assistantphone from contact where id =:lcti.contact__c];

                strval = listcontact[0].id;
                urlval = '/'+listcontact[0].id;

            system.debug('*urlval*'+urlval);
        }
    }
}