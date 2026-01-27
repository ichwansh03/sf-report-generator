@isTest
public class AttachmentTriggerTest {

    public static testMethod void testDuplicateAttachment() {
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
        // cas.OwnerId = subOrdinateAFIUser.Id;
        cas.e2cEmailTo__c = 'customer@axa-financial.co.id';
        cases.add(cas);
        insert cases;
        
        List<EmailMessage> emails = new List<EmailMessage>();
        for(integer i = 0; i<2; i++){
            Integer mod = Math.MOD(i,2);
            EmailMessage em = new EmailMessage(Subject='SubjectEmail'+ i, FromName ='FromName'+ i, FromAddress ='FromAddress'+ i+ '@test.com', ToAddress ='ToAddress'+ i+ '@test.com');
            em.ParentId = cas.Id;
            emails.add(em);
        }
        insert emails;
        List<Attachment> atts = new List<Attachment>();
        for(integer i = 0; i<2; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            //attachment.OwnerId = cas.ContactId;
            attachment.ParentId = email.Id;
            atts.add(attachment);
        }
        // for duplicate in same bulk
        for(integer i = 0; i<2; i++){
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
        // for duplicate in different bulk
        List<Attachment> atts2 = new List<Attachment>();
        for(integer i = 0; i<2; i++){
            EmailMessage email = emails.get(i);
            Attachment attachment = new Attachment();
            attachment.Body = Blob.valueOf('Attachment Body'+i);
            attachment.name = 'Attachment Name'+i;
            attachment.description = email.Id;
            //attachment.OwnerId = cas.ContactId;
            attachment.ParentId = email.Id;
            atts2.add(attachment);
        }
        insert atts2;
        /*Date d = Date.today();
        Integer yearProcess = d.year();
        Integer limitQuery = 50;
        AttachmentMoveParentToContactBatch batch = new AttachmentMoveParentToContactBatch(limitQuery, yearProcess);
        Id batchJobId = Database.executeBatch(batch,50);*/
        Test.stopTest();
    }
    
}