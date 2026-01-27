@isTest
public class AttachmentMoveCasesToContactBatch_Test {

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
        //cas1.Policy_Number__c = con.Policy_No__c;
        //cas1.ContactId = con.Id;
        cas1.Status = 'New';
        cas1.Subject = 'ILCCYS';
        cas1.Type = 'Inquiry';
        cas1.Case_Type_Config__c = 'Inquiry Status';
        cas1.Description = 'testing for test class1';
        // cas.OwnerId = subOrdinateAFIUser.Id;
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
            attachment.ParentId = cas1.id;
            atts.add(attachment);
        }
        insert atts;
        Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 5;
        AttachmentMoveCasesToContactBatch batch = new AttachmentMoveCasesToContactBatch(limitQuery, yearProcess);
        Id batchJobId = Database.executeBatch(batch,5);
        Test.stopTest();
    }


}