@isTest (seeAllData = true)
public class prechatform_Controller_Test {
    public static testMethod void useCase1(){
        Contact con =new Contact(LastName ='test0101', Phone='0811828282', Email='mail@test.co.id', Policy_No_Numeric__c='881717111');
        insert con;
        
        String myParam = '881717111;0811828282;mail@test.co.id';
        prechatform_Controller.getParam(myParam);
    }
    
    public static testMethod void useCase2(){
        Contact con =new Contact(LastName ='test0101', Phone='0811828282', Email='mail@test.co.id', Policy_No_Numeric__c='881717111');
        insert con;
        
        String myParam = 'test123;0811828282;mail@test.co.id';
        prechatform_Controller.getParam(myParam);
    }
    
    public static testMethod void useCase3(){
        Contact con =new Contact(LastName ='test0101', Phone='0811828282', Email='mail@test.co.id', Policy_No_Numeric__c='881717111');
        insert con;
        
        String myParam = 'test123;;mail@test.co.id';
        prechatform_Controller.getParam(myParam);
    }
    
    public static testMethod void useCase4(){
        Contact con =new Contact(LastName ='test0101', Phone='0811828282', Email='mail@test.co.id', Policy_No_Numeric__c='881717111');
        insert con;
        
        String myParam = 'test123;0811;mail@test.co.id';
        prechatform_Controller.getParam(myParam);
    }
    
    public static testMethod void useCase5(){
        Contact con =new Contact(LastName ='test0101', Phone='0811828282', Email='mail@test.co.id', Policy_No_Numeric__c='881717111');
        insert con;
        
        String myParam = 'pol;7666;mail@test.co.id';
        prechatform_Controller.getParam(myParam);
    }
}