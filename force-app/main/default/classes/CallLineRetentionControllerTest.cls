@isTest
public class CallLineRetentionControllerTest {
    
    @testSetup
    static void initContact() {
        Contact testContact = new Contact(mdmid_owner__c = '77416108', Policy_No__c = '201-5123421', LastName = 'Sholihin');
        insert testContact;
    }
    
    @isTest
    public static void updloadFileFailedTest(){
        CallLineRetentionController controller = new CallLineRetentionController();
        Test.startTest();
        controller.fileContent = Blob.valueOf('201-5123421\n201-5012131');
        controller.fileLines = controller.fileContent.toString().split('\n');
        controller.fileName = 'test.txt';
        controller.uploadFile();
        Test.stopTest();
        System.assertEquals('File is blank or not csv type', ApexPages.getMessages()[0].getSummary());
    }
    
    @isTest
    public static void uploadRecordTakeoutTest(){
        
        CallLineRetentionController controller = new CallLineRetentionController();
        
        controller.contact = [SELECT Id FROM Contact LIMIT 1];
        try {
            String header = 'Policy_No__c, Remark_Description__c, Retention_Status__c\n';
                        
            Test.startTest();
            controller.fileContent = Blob.valueOf(header+ '201-5123421, Req by user, Takeout\n');
			controller.fileName = 'test.csv';
            controller.uploadFile();
            controller.changeRetentionStatus(controller.updatedClr, controller.policy);
            controller.changeCallLine(controller.updatedClr, controller.policy);
            controller.parseCsvRecords(controller.fileLines, controller.contactMap, controller.listClr);
            ApexPages.currentPage().getParameters().put('upload', 'success');
            Test.stopTest();
                        
        } catch (Exception e) {
            System.assertEquals(e.getMessage(), 'An error has occured: '+e);
        }
        
    }

	@isTest
    public static void uploadRecordReleaseTest(){
        
        CallLineRetentionController controller = new CallLineRetentionController();
        
        controller.contact = [SELECT Id FROM Contact LIMIT 1];
        Call_Line_Retention__c clr = new Call_Line_Retention__c();
        try {
            String header = 'Policy_No__c, Remark_Description__c, Retention_Status__c\n';
                        
            Test.startTest();
            controller.fileContent = Blob.valueOf(header+ '201-5123421, Req by admin, Release');
            controller.fileName = 'test.csv';
            controller.uploadFile();
            controller.changeRetentionStatus(controller.updatedClr, controller.policy);
            controller.changeCallLine(controller.updatedClr, controller.policy);
            controller.parseCsvRecords(controller.fileLines, controller.contactMap, controller.listClr);
            ApexPages.currentPage().getParameters().put('upload', 'success');
            
            List<String> records = controller.fileContent.toString().split('/n');
            system.debug('records: '+records);
            List<Call_Line_Retention__c> retentions = new List<Call_Line_Retention__c>();
            for (Integer i = 1; i < records.size(); i++) {
                clr.Contact__c = controller.contact.Id;
                clr.Remark_Description__c = records[1];
                clr.Retention_Status__c = records[2];
                retentions.add(clr);
            }
            insert retentions;
            Test.stopTest();
            
        } catch (Exception e) {
            System.assertEquals(e.getMessage(), 'An error has occured: '+e);
        }
        
    }
    
    @isTest
    public static void policyNotRegisteredTest() {
       
        CallLineRetentionController controller = new CallLineRetentionController();
                
        controller.contact = [SELECT Id, Policy_No__c FROM Contact LIMIT 1];

		String header = 'Policy_No__c, Remark_Description__c, Retention_Status__c\n';
        Test.startTest();
        controller.fileContent = Blob.valueOf(header+ '201-5123420, Req by user, Release\n');
        controller.fileName = 'test.csv';
        controller.uploadFile();
        controller.parseCsvRecords(controller.fileLines, controller.contactMap, controller.listClr);
        Test.stopTest();
    }
    
    @isTest
    public static void remarksBlankTest() {
        CallLineRetentionController controller = new CallLineRetentionController();
                
        controller.contact = [SELECT Id, Policy_No__c FROM Contact LIMIT 1];
        
		String header = 'Policy_No__c, Remark_Description__c, Retention_Status__c\n';
        Test.startTest();
        controller.fileContent = Blob.valueOf(header+ '201-5123421,0,Release\n');
        controller.fileName = 'test.csv';
        controller.uploadFile();
        controller.parseCsvRecords(controller.fileLines, controller.contactMap, controller.listClr);
        CallLineRetentionController.InvalidPolicyNo invalidPolicy = new CallLineRetentionController.InvalidPolicyNo(controller.invalidPolicyText[0], controller.invalidPolicyStatus[0]);
        Test.stopTest();
        
        System.assertEquals(controller.invalidPolicyText[0],'201-5123421');
        System.assertEquals(controller.invalidPolicyStatus[0],'E2');
    }
    
    @isTest
    public static void statusInvalidTest() {
        CallLineRetentionController controller = new CallLineRetentionController();
                
        controller.contact = [SELECT Id, Policy_No__c FROM Contact LIMIT 1];
        
		String header = 'Policy_No__c, Remark_Description__c, Retention_Status__c\n';
        Test.startTest();
        controller.fileContent = Blob.valueOf(header+ '201-5123421, test remarks, Completed\n');
        controller.fileName = 'test.csv';
        controller.uploadFile();
        controller.parseCsvRecords(controller.fileLines, controller.contactMap, controller.listClr);
        CallLineRetentionController.InvalidPolicyNo invalidPolicy = new CallLineRetentionController.InvalidPolicyNo(controller.invalidPolicyText[0], controller.invalidPolicyStatus[0]);
        Test.stopTest();
        
        System.assertEquals(controller.invalidPolicyText[0],'201-5123421');
        System.assertEquals(controller.invalidPolicyStatus[0],'E3');
    }
    
    @isTest
    public static void recordNullTest() {
        CallLineRetentionController controller = new CallLineRetentionController();
                
        controller.contact = [SELECT Id, Policy_No__c FROM Contact LIMIT 1];
        
		String header = 'Policy_No__c, Remark_Description__c, Retention_Status__c\n';
        Test.startTest();
        controller.fileContent = Blob.valueOf(header+ ',test remarks, Takeout\n, , ');
        controller.fileName = 'test.csv';
        controller.uploadFile();
        controller.parseCsvRecords(controller.fileLines, controller.contactMap, controller.listClr);
        CallLineRetentionController.InvalidPolicyNo invalidPolicy = new CallLineRetentionController.InvalidPolicyNo(controller.invalidPolicyText[0], controller.invalidPolicyStatus[0]);
        Test.stopTest();
        
        System.assertEquals(controller.invalidPolicyStatus[0],'E1');
    }
    
    @isTest
    public static void changeCallLineTest() {
        
        CallLineRetentionController controller = new CallLineRetentionController();
		controller.contact = [SELECT Id, Policy_No__c FROM Contact LIMIT 1];
		
        List<Call_Line_Retention__c> clrList = new List<Call_Line_Retention__c>();
		clrList.add(new Call_Line_Retention__c(
        	Contact__c = controller.contact.Id,
            Remark_Description__c = 'Req by admin',
            Retention_Status__c = 'Takeout'
        ));
        List<String> policy = new List<String>();
        policy.add(clrList[0].Policy_No__c);
		insert clrList;
        
        Test.startTest();
        controller.mapClr = new Map<String, Call_Line_Retention__c>();
		controller.changeCallLine(clrList, policy);
        
        for (Call_Line__c cl : controller.listCl) {
            System.assertEquals(controller.mapClr.containsKey(cl.Contact__c), true, 'call line retention is updated');
            System.assertEquals('Takeout', cl.Status_has_call__c, 'call status is not changed');
            System.assertEquals('Tidak Berkenan Dihubungi', cl.Reason_Status_Config__c, 'reason status is not changed');
            System.assertEquals(Datetime.now(), cl.Collection_Call_Date__c, 'date time is different');
            System.assertEquals(clrList[0].Remark_Description__c, cl.Call_Remarks__c, 'remark is different');
        }
        Test.stopTest();
    }
}