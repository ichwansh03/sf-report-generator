@isTest(seeAllData = true)
public class CaseCommentController_test {
    public static testmethod void testSaveCaseComment() {
		Test.startTest();        
        
        Contact con1 = new Contact();
        con1.FirstName = 'Testing';
        con1.LastName = '123';
        con1.Policy_No__c = '365-7298157';
        con1.MobilePhone = '081122334455';
        con1.Entity__c = 'AMFS';
        insert con1;
        
        Case cs = new Case();
        cs.ContactId = con1.Id;
        cs.Status ='New';
        insert cs;

       	Id currentId = cs.id;
        String userId = UserInfo.getUserId();
        
        RecordType RecTypeId = [SELECT Id
                                     FROM RecordType
                                    WHERE SobjectType='Call_Line__c'
                                          and Name ='AMFS 4'
                                    LIMIT 1];
        
        Call_Line__c insertCl = new Call_Line__c();
        insertCl.RecordTypeId = RecTypeId.Id;
        insertCl.Contact__c = con1.Id; 
        insertCl.Case__c =  currentId;
        insertCl.Call_Remarks__c =  'Testing';
        insertCl.Status_Retry__c = 'Callback From CCC';
        insertCl.Agent__c = userId;
        insertCl.OwnerId = userId;
        insertCl.Entity__c = 'AMFS';
        insert insertCl;     
        
        ApexPages.currentPage().getParameters().put('Id',currentId);  
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cs);
        CaseCommentController controller = new CaseCommentController(sc);   
        controller.save();
        Test.stopTest();
    }
}