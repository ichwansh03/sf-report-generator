@isTest
public class AttachMoveParentToContactMonthBatchTest {
    public static testMethod void testBatchNonCustALI() {
        Test.startTest();
        Contact con = new Contact();
        con.FirstName = 'Hamfrees';
        con.LastName = 'Lantwos';
        con.Policy_No__c = '1234-56784';
        insert con;
        
        List<Case> cases = new List<Case>();
        Case cas1 = new Case();
		cas1.Entity_Backup__c = 'ALI';
        cas1.Origin = 'Email';
        cas1.Status ='New';
        cas1.suppliedEmail = 'testing123@nyaho.com';
        cas1.Status = 'New';
        cas1.Subject = 'ILCCYS';
        cas1.Type = 'Inquiry';
        cas1.Case_Type_Config__c = 'Inquiry Status';
        cas1.Description = 'testing for test class1';
        cas1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        cases.add(cas1);
        insert cases;
        
        List<EmailMessage> emails = new List<EmailMessage>();
        for(integer i = 0; i<5; i++){
            Integer mod = Math.MOD(i,2);
            EmailMessage em = new EmailMessage(Subject='SubjectEmail'+ i, FromName ='FromName'+ i, FromAddress ='FromAddress'+ i+ '@test.com', ToAddress ='ToAddress'+ i+ '@test.com');
            em.ParentId = cas1.Id;
            emails.add(em);
        }
        insert emails;
        List<Attachment> atts = new List<Attachment>();
        for(integer i = 0; i<5; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            attachment.ParentId = email.Id;
            atts.add(attachment);
        }
        insert atts;
        Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 5;
        Integer startMonth = 1;
        Integer endMOnth = d.month();
        system.debug('yearProcess:' + yearProcess);
        system.debug('limitQuery:' + limitQuery);
        system.debug('startMonth:' + startMonth);
        system.debug('endMOnth:' + endMOnth);
        AttachmentMoveParentToContactMonthBatch batch = new AttachmentMoveParentToContactMonthBatch(limitQuery, yearProcess, startMonth, endMonth);
        Id batchJobId = Database.executeBatch(batch,5);
        Test.stopTest();
    }
    
    public static testMethod void testBatchNonCustAGI() {
        Test.startTest();
        Contact con = new Contact();
        con.FirstName = 'Hamfrees';
        con.LastName = 'Lantwos';
        con.Policy_No__c = '1234-56784';
        insert con;
        
        List<Case> cases = new List<Case>();
        Case cas1 = new Case();
		cas1.Entity_Backup__c = 'AGI';
        cas1.Origin = 'Email';
        cas1.Status ='New';
        cas1.suppliedEmail = 'testing123@nyaho.com';
        cas1.Status = 'New';
        cas1.Subject = 'ILCCYS';
        cas1.Type = 'Inquiry';
        cas1.Case_Type_Config__c = 'Inquiry Status';
        cas1.Description = 'testing for test class1';
        cas1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        cases.add(cas1);
        insert cases;
        
        List<EmailMessage> emails = new List<EmailMessage>();
        for(integer i = 0; i<5; i++){
            Integer mod = Math.MOD(i,2);
            EmailMessage em = new EmailMessage(Subject='SubjectEmail'+ i, FromName ='FromName'+ i, FromAddress ='FromAddress'+ i+ '@test.com', ToAddress ='ToAddress'+ i+ '@test.com');
            em.ParentId = cas1.Id;
            emails.add(em);
        }
        insert emails;
        List<Attachment> atts = new List<Attachment>();
        for(integer i = 0; i<5; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            //attachment.OwnerId = cas.ContactId;
            attachment.ParentId = email.Id;
            atts.add(attachment);
        }
        insert atts;
        Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 5;
        Integer startMonth = 1;
        Integer endMOnth = d.month();
        system.debug('yearProcess:' + yearProcess);
        system.debug('limitQuery:' + limitQuery);
        system.debug('startMonth:' + startMonth);
        system.debug('endMOnth:' + endMOnth);
        AttachmentMoveParentToContactMonthBatch batch = new AttachmentMoveParentToContactMonthBatch(limitQuery, yearProcess, startMonth, endMonth);
        Id batchJobId = Database.executeBatch(batch,5);
        Test.stopTest();
    }
    
    public static testMethod void testBatchNonCustMAGI() {
        Test.startTest();
        Contact con = new Contact();
        con.FirstName = 'Hamfrees';
        con.LastName = 'Lantwos';
        con.Policy_No__c = '1234-56784';
        insert con;
        
        List<Case> cases = new List<Case>();
        Case cas1 = new Case();
		cas1.Entity_Backup__c = 'MAGI';
        cas1.Origin = 'Email';
        cas1.Status ='New';
        cas1.suppliedEmail = 'testing123@nyaho.com';
        cas1.Status = 'New';
        cas1.Subject = 'ILCCYS';
        cas1.Type = 'Inquiry';
        cas1.Case_Type_Config__c = 'Inquiry Status';
        cas1.Description = 'testing for test class1';
        cas1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        cases.add(cas1);
        insert cases;
        
        List<EmailMessage> emails = new List<EmailMessage>();
        for(integer i = 0; i<5; i++){
            Integer mod = Math.MOD(i,2);
            EmailMessage em = new EmailMessage(Subject='SubjectEmail'+ i, FromName ='FromName'+ i, FromAddress ='FromAddress'+ i+ '@test.com', ToAddress ='ToAddress'+ i+ '@test.com');
            em.ParentId = cas1.Id;
            emails.add(em);
        }
        insert emails;
        List<Attachment> atts = new List<Attachment>();
        for(integer i = 0; i<5; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            attachment.ParentId = email.Id;
            atts.add(attachment);
        }
        insert atts;
        Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 5;
        Integer startMonth = 1;
        Integer endMOnth = d.month();
        system.debug('yearProcess:' + yearProcess);
        system.debug('limitQuery:' + limitQuery);
        system.debug('startMonth:' + startMonth);
        system.debug('endMOnth:' + endMOnth);
        AttachmentMoveParentToContactMonthBatch batch = new AttachmentMoveParentToContactMonthBatch(limitQuery, yearProcess, startMonth, endMonth);
        Id batchJobId = Database.executeBatch(batch,5);
        Test.stopTest();
    }
    
    public static testMethod void testBatchNonCustAMFS() {
        Test.startTest();
        Contact con = new Contact();
        con.FirstName = 'Hamfrees';
        con.LastName = 'Lantwos';
        con.Policy_No__c = '1234-56784';
        insert con;
        
        List<Case> cases = new List<Case>();
        Case cas1 = new Case();
		cas1.Entity_Backup__c = 'AMFS';
        cas1.Origin = 'Email';
        cas1.Status ='New';
        cas1.suppliedEmail = 'testing123@nyaho.com';
        cas1.Status = 'New';
        cas1.Subject = 'ILCCYS';
        cas1.Type = 'Inquiry';
        cas1.Case_Type_Config__c = 'Inquiry Status';
        cas1.Description = 'testing for test class1';
        cas1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        cases.add(cas1);
        insert cases;
        
        List<EmailMessage> emails = new List<EmailMessage>();
        for(integer i = 0; i<5; i++){
            Integer mod = Math.MOD(i,2);
            EmailMessage em = new EmailMessage(Subject='SubjectEmail'+ i, FromName ='FromName'+ i, FromAddress ='FromAddress'+ i+ '@test.com', ToAddress ='ToAddress'+ i+ '@test.com');
            em.ParentId = cas1.Id;
            emails.add(em);
        }
        insert emails;
        List<Attachment> atts = new List<Attachment>();
        for(integer i = 0; i<5; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            attachment.ParentId = email.Id;
            atts.add(attachment);
        }
        insert atts;
        Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 5;
        Integer startMonth = 1;
        Integer endMOnth = d.month();
        system.debug('yearProcess:' + yearProcess);
        system.debug('limitQuery:' + limitQuery);
        system.debug('startMonth:' + startMonth);
        system.debug('endMOnth:' + endMOnth);
        AttachmentMoveParentToContactMonthBatch batch = new AttachmentMoveParentToContactMonthBatch(limitQuery, yearProcess, startMonth, endMonth);
        Id batchJobId = Database.executeBatch(batch,5);
        Test.stopTest();
    }
    
    public static testMethod void testBatchNonCustAFI() {
        Test.startTest();
        Contact con = new Contact();
        con.FirstName = 'Hamfrees';
        con.LastName = 'Lantwos';
        con.Policy_No__c = '1234-56784';
        insert con;
        
        List<Case> cases = new List<Case>();
        Case cas1 = new Case();
		cas1.Entity_Backup__c = 'AFI';
        cas1.Origin = 'Email';
        cas1.Status ='New';
        cas1.suppliedEmail = 'testing123@nyaho.com';
        cas1.Status = 'New';
        cas1.Subject = 'ILCCYS';
        cas1.Type = 'Inquiry';
        cas1.Case_Type_Config__c = 'Inquiry Status';
        cas1.Description = 'testing for test class1';
        cas1.e2cEmailTo__c = 'customer@axa-financial.co.id';
        cases.add(cas1);
        insert cases;
        
        List<EmailMessage> emails = new List<EmailMessage>();
        for(integer i = 0; i<5; i++){
            Integer mod = Math.MOD(i,2);
            EmailMessage em = new EmailMessage(Subject='SubjectEmail'+ i, FromName ='FromName'+ i, FromAddress ='FromAddress'+ i+ '@test.com', ToAddress ='ToAddress'+ i+ '@test.com');
            em.ParentId = cas1.Id;
            emails.add(em);
        }
        insert emails;
        List<Attachment> atts = new List<Attachment>();
        for(integer i = 0; i<5; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            attachment.ParentId = email.Id;
            atts.add(attachment);
        }
        insert atts;
        Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 5;
        Integer startMonth = 1;
        Integer endMOnth = d.month();
        system.debug('yearProcess:' + yearProcess);
        system.debug('limitQuery:' + limitQuery);
        system.debug('startMonth:' + startMonth);
        system.debug('endMOnth:' + endMOnth);
        AttachmentMoveParentToContactMonthBatch batch = new AttachmentMoveParentToContactMonthBatch(limitQuery, yearProcess, startMonth, endMonth);
        Id batchJobId = Database.executeBatch(batch,5);
        Test.stopTest();
    }
    
    public static testMethod void testBatchCust() {
        Test.startTest();
        Contact con = new Contact();
        con.FirstName = 'Hamfrees';
        con.LastName = 'Lantwos';
        con.Policy_No__c = '1234-56784';
        insert con;
        
        List<Case> cases = new List<Case>();
        Case cas = new Case();
		cas.Entity_Backup__c = 'AFI';
        cas.Origin = 'Email';
        cas.Status ='New';
        cas.suppliedEmail = 'testing123@nyaho.com';
        cas.Policy_Number__c = con.Policy_No__c;
        cas.ContactId = con.Id;
        cas.Status = 'New';
        cas.Subject = 'ILCCYS';
        cas.Type = 'Inquiry';
        cas.Case_Type_Config__c = 'Inquiry Status';
        cas.Description = 'testing for test class';
        cas.e2cEmailTo__c = 'customer@axa-financial.co.id';
        cases.add(cas);
        insert cases;
        
        List<EmailMessage> emails = new List<EmailMessage>();
        for(integer i = 0; i<50; i++){
            Integer mod = Math.MOD(i,2);
            EmailMessage em = new EmailMessage(Subject='SubjectEmail'+ i, FromName ='FromName'+ i, FromAddress ='FromAddress'+ i+ '@test.com', ToAddress ='ToAddress'+ i+ '@test.com');
            em.ParentId = cas.Id;
            emails.add(em);
        }
        insert emails;
        List<Attachment> atts = new List<Attachment>();
        for(integer i = 0; i<50; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            attachment.ParentId = email.Id;
            atts.add(attachment);
        }
        insert atts;
        Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 50;
        Integer startMonth = 1;
        Integer endMOnth = d.month();
        system.debug('yearProcess:' + yearProcess);
        system.debug('limitQuery:' + limitQuery);
        system.debug('startMonth:' + startMonth);
        system.debug('endMOnth:' + endMOnth);
        AttachmentMoveParentToContactMonthBatch batch = new AttachmentMoveParentToContactMonthBatch(limitQuery, yearProcess, startMonth, endMonth);
        Id batchJobId = Database.executeBatch(batch,50);
        Test.stopTest();
    }
}