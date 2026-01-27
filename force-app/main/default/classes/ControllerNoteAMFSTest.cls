@isTest

public class ControllerNoteAMFSTest {
    public static Blob csvFileBody;
    public static String[] csvFileLines;
    Public static string csvAsString;
    static ID rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    static ID rtCallLineTw = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('TelUW').getRecordTypeId();
    static ID rtCallLineCollection = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Collection AMFS 1').getRecordTypeId();
    
    @testSetup 
    public static void setup() {         
        account acc = new account();
        acc.Name = 'Test';
        acc.Entity__c = 'AMFS';
        insert acc;
        
        contact con1 = new contact();
        con1.lastName = 'Test 1';
        con1.AccountId = acc.id;
        con1.Entity__c = 'AMFS';
        con1.Policy_No__c = '511-7298157';
        insert con1;
        
        
        contact con2 = new contact();
        con2.lastName = 'Test 2';
        con2.AccountId = acc.id;
        con2.Entity__c = 'AMFS';
        con2.Policy_No__c = '511-72981576';
        insert con2;         
    }
    
    /* @isTest
    static void testUpload() {
        Test.startTest(); 
        //call_line__c testAcct = new call_line__c (Name='Test',RecordTypeId=rtCallLineWC);
        call_line__c cmp = new call_line__c();
        
        
        //Insert Document
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        cgc.selectedType = 'TelUW';
        String body='Policy No, Call Note 1\n';
        body = body + '511-7298157,test1,test2,test3 \n';
        Document document = new Document();
        document.Name = 'Testing.csv';
        cgc.document = document;
        document.Body = Blob.valueOf(body);
        document.ContentType ='text/plain; charset=UTF-8';
        cgc.uploadedNum = cgc.Call_Line.size();
        
        cgc.Upload();
        
        apexpages.currentPage().getparameters();
        Test.stopTest();
    } */
    
    public static testMethod void testSuccessController() {
        Test.startTest(); 
        
        Contact con1 = [Select id,Policy_No__c from contact where name = 'Test 1'];
        Contact con2 = [Select id,Policy_No__c from contact where name = 'Test 2'];
        
        Call_Line__c callLine1 = new Call_Line__c();
        callLine1.contact__c = con1.id;
        callLine1.Policy_No__c = con1.Policy_No__c;
       	callLine1.RecordTypeId = rtCallLineCollection;
        insert callLine1;
        
        Call_Line__c callLine2 = new Call_Line__c();
        callLine2.contact__c = con2.id;
        callLine2.Policy_No__c = con2.Policy_No__c;
       	callLine2.RecordTypeId = rtCallLineCollection;
        insert callLine2;
        
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        Document document = new Document();
        String body='Policy No, Call Note 1 \n';
        body = body + '511-7298157, test1 \n';
        document.Body = Blob.valueOf(body);
        document.ContentType ='text/plain; charset=UTF-8';
        document.Name = 'Testing Upload Policy Teleconfirm.csv';
        cgc.document = document;
        cgc.upload();
        Test.stopTest();
    }
    
    public static testMethod void  function2() {
        Test.startTest();       
        call_line__c cmp = new call_line__c();
        
        Contact con1 = [Select id,Policy_No__c from contact where name = 'Test 1'];
        Contact con2 = [Select id,Policy_No__c from contact where name = 'Test 2'];
        
        Call_Line__c callLine1 = new Call_Line__c();
        callLine1.contact__c = con1.id;
        callLine1.Policy_No__c = con1.Policy_No__c;
       	callLine1.RecordTypeId = rtCallLineWC;
        insert callLine1;
        
        Call_Line__c callLine2 = new Call_Line__c();
        callLine2.contact__c = con2.id;
        callLine2.Policy_No__c = con2.Policy_No__c;
       	callLine2.RecordTypeId = rtCallLineWC;
        insert callLine2;
        
        //Insert Document
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        cgc.selectedType = 'WelcomeCall';
        String body='Policy No, Call Note 1\n';
        body = body + '511-7298157, test1 \n';
        Document document = new Document();
        document.Name = 'Testing.csv';
        cgc.document = document;
        document.Body = Blob.valueOf(body);
        document.ContentType ='text/plain; charset=UTF-8';
        cgc.uploadedNum = cgc.Call_Line.size();
        
        cgc.Upload();
        Test.stopTest();
    }
    
    public static testMethod void  function3() {
        Test.startTest();
        
        call_line__c cmp = new call_line__c();
        
        //Insert Document
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        cgc.selectedType = 'CR';
        String body='name, Call Note 1\n';
        body = body + 'CL-3847571,test1,test2,test3 \n';
        Document document = new Document();
        document.Name = 'Testing.csv';
        cgc.document = document;
        document.Body = Blob.valueOf(body);
        document.ContentType ='text/plain; charset=UTF-8';
        cgc.Upload();
        Test.stopTest();
    }
    
    public static testMethod void  function4() {
        Test.startTest();
         
        
        Contact con1 = [Select id,Policy_No__c from contact where name = 'Test 1'];
        Contact con2 = [Select id,Policy_No__c from contact where name = 'Test 2'];
        
        Call_Line__c callLine1 = new Call_Line__c();
        callLine1.contact__c = con1.id;
        callLine1.Policy_No__c = con2.Policy_No__c;
       	callLine1.RecordTypeId = rtCallLineTw;
        insert callLine1;
        
        Call_Line__c callLine2 = new Call_Line__c();
        callLine2.contact__c = con2.id;
        callLine2.Policy_No__c = con2.Policy_No__c;
       	callLine2.RecordTypeId = rtCallLineTw;
        insert callLine2;
        
        //Insert Document
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        String body='';
        body = body + '';
        Document document = new Document();
        document.Name = 'Testing.csv';
        cgc.document = document;
        document.Body = Blob.valueOf(body);
        document.ContentType ='text/plain; charset=UTF-8';       
        cgc.Upload();
        Test.stopTest();
    }
    
    /* public static testMethod void function5() {
        // Membuat instansiasi objek ControllerNoteAMFS
        ControllerNoteAMFS controller = new ControllerNoteAMFS();
        
        // Menset nilai-nilai yang diperlukan
        controller.selectedType = 'Tele UW';
        controller.TotalPolis = 2;
        
        // Membuat data Call_Line__c yang dibutuhkan
        List<Call_Line__c> callLineData = new List<Call_Line__c>();
        Call_Line__c callLine1 = new Call_Line__c();
        callLine1.Id = 'a015D00000EDcZ0QAL';
        callLine1.contact__r = new Contact();
        callLine1.contact__r.policy_no__c = '515-3123456';
        Call_Line__c callLine2 = new Call_Line__c();
        callLine2.Id = 'CallLine2';
        callLine2.contact__r = new Contact();
        callLine2.contact__r.policy_no__c = '515-3123457';
        callLineData.add(callLine1);
        callLineData.add(callLine2);
        
        // Memasukkan data Call_Line__c ke dalam database
        insert callLineData;
        
        // Memanggil metode processCSV
        List<Call_Line__c> dataList = controller.processCSV('', true);
        
        // Melakukan verifikasi
        System.assertEquals(2, dataList.size());
        System.assertEquals('CallLine1', dataList[0].Id);
        System.assertEquals('CallLine2', dataList[1].Id);
        System.assertEquals('Policy1', dataList[0].Call_Notes_1__c);
        System.assertEquals('Policy2', dataList[1].Call_Notes_1__c);
    } */
    
    
    public static testMethod void function5() {
        // Membuat instansiasi objek ControllerNoteAMFS
        ControllerNoteAMFS controller = new ControllerNoteAMFS();
        
        // Menset nilai-nilai yang diperlukan
        controller.selectedType = 'Tele UW';
        controller.TotalPolis = 2;
        
        
        Contact con1 = [Select id,Policy_No__c from contact where name = 'Test 1'];
        Contact con2 = [Select id,Policy_No__c from contact where name = 'Test 2'];
        
        Call_Line__c callLine1 = new Call_Line__c();
        callLine1.contact__c = con1.id;
        callLine1.Policy_No__c = con1.Policy_No__c;
       	callLine1.RecordTypeId = rtCallLineTw;
        insert callLine1;
        
        Call_Line__c callLine2 = new Call_Line__c();
        callLine2.contact__c = con2.id;
        callLine2.Policy_No__c = con2.Policy_No__c;
       	callLine2.RecordTypeId = rtCallLineTw;
        insert callLine2;
        
        
        // Memanggil metode processCSV
        List<Call_Line__c> dataList = controller.processCSV('', true);
        controller.selectedType = 'None';
        controller.recordtype();
        Document document = new Document();
        String body = 'Policy No, Call Note 1 \n';
        body += '511-7298157, test1 \n';
        document.Body = Blob.valueOf(body);
        document.ContentType = 'text/plain; charset=UTF-8';
        document.Name = 'Testing Upload Policy Teleconfirm.txt'; // Non-csv file extension
        controller.document = document;
        controller.upload();
         
        Document document2 = new Document();
        String body2 = 'Policy No, Call Note 1 \n';
        body2 += '511-7298156, test1 \n';
        document2.Body = Blob.valueOf(body2);
        document2.ContentType = 'text/plain; charset=UTF-8';
        document2.Name = 'Testing Upload Policy Teleconfirm.txt'; // Non-csv file extension
        controller.document = document2;
        controller.upload();
        
        // Melakukan verifikasi
        System.assertEquals(0, dataList.size());  
    }
    
    private static testMethod void  testUploadEmpty() {
        //campaign empty Document
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        apexpages.currentPage().getparameters();
        cgc.upload();
    }
    
    public static testMethod void testUploadNoExtension() {
        Test.startTest();
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        Document document = new Document();
        String body = 'Policy No, Call Note 1 \n';
        body += '511-7298157, test1 \n';
        document.Body = Blob.valueOf(body);
        document.ContentType = 'text/plain; charset=UTF-8';
        document.Name = 'Testing Upload Policy Teleconfirm.txt'; // Non-csv file extension
        cgc.document = document;
        cgc.upload();
        Test.stopTest();
    }
    
    public static testMethod void testUploadRecordTypeNone() {
        Test.startTest();
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        cgc.selectedType = 'None'; // Test with 'None' selectedType
        Document document = new Document();
        String body = 'Policy No, Call Note 1 \n';
        body += '511-7298157, test1 \n';
        document.Body = Blob.valueOf(body);
        document.ContentType = 'text/plain; charset=UTF-8';
        document.Name = 'Testing.csv';
        cgc.document = document;
        cgc.upload();
        Test.stopTest();
    }
    
    public static testMethod void testUploadNoFileSelected() {
        Test.startTest();
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        cgc.selectedType = 'WelcomeCall';
        cgc.upload();
        Test.stopTest();
    }
    
    public static testMethod void testUploadDMLException() {
        Test.startTest();
        controllerNoteAMFS cgc = new controllerNoteAMFS();
        cgc.selectedType = 'WelcomeCall';
        String body = 'Policy No, Call Note 1 \n';
        body += '511-7298157, test1 \n';
        Document document = new Document();
        document.Body = Blob.valueOf(body);
        document.ContentType = 'text/plain; charset=UTF-8';
        document.Name = 'Testing.csv';
        cgc.document = document;
        
        // Simulate a DML exception by trying to insert a Call_Line__c record with missing required fields
        cgc.Call_Line.add(new Call_Line__c());
        cgc.upload();
        Test.stopTest();
    }
    
    public static testMethod void testProcessCSV() {
        Test.startTest();
        
        // Prepare mock Call_Line__c records and initial data for helper
        Map<String, List<String>> initialData = new Map<String, List<String>>();
        // Populate initialData with relevant data based on the test scenario
        // ...
        
        // Create CallLineHelper instance and set initial data
        ControllerHelper helper = new ControllerHelper(initialData);
        
        // Create and set up the controller using the helper instance
        controllerNoteAMFS cgc = new controllerNoteAMFS(helper);
        
        // Prepare CSV content based on the mock data
        String body = 'Policy No, Call Note 1, Call Note 2, Call Note 3\n';
        for (String callLineName : initialData.keySet()) {
            body += '511-7298157, test1, test2, test3\n';
        }
        
        // Call processCSV method
        List<Call_Line__c> dataList = cgc.processCSV(body, true);
        
        // Verify results
        // ... (assertions and debug statements)
        
        Test.stopTest();
    }
    
    
    
    public static testMethod void testHelpers() {
        Test.startTest();
        
        // Prepare mock Call_Line__c records and initial data for helper
        Map<String, List<String>> initialData = new Map<String, List<String>>();
        // Populate initialData with relevant data based on the test scenario
        // ...
        
        // Create CallLineHelper instance and set initial data
        ControllerHelper helper = new ControllerHelper(initialData);
        helper.addCallId('xxx','xxx');
        helper.getCallIds('xxx');
        Test.stopTest();
    }
}