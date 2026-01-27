@istest
public class CreateEmailSMSLogNewCust_Test {
    public static testmethod void createCaseAsk() {
        Test.startTest();
        String userId = UserInfo.getUserId();
        DescribeSObjectResult describeResultUser = User.getSObjectType().getDescribe();
        List<String> userFieldList = new List<String>(describeResultUser.fields.getMap().keySet());
        String userFields = String.join(userFieldList, ',');
        String userQuery = ' SELECT ' + userFields + ' FROM User WHERE Id = :userId ORDER BY CreatedDate DESC LIMIT 1 ';
        User userObj = Database.query(userQuery);
        String entity = 'AMFS';
        
        Account ac1 = new Account();
        ac1.Name = 'AccountTest20';
        ac1.Entity__c = entity;
        insert ac1;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'Bill';
        contact1.LastName = 'Gates';
        contact1.Email = 'billgates@email.com';
        contact1.Policy_No__c = '77700101';
        contact1.Entity__c = entity;
        contact1.AccountId = ac1.Id;
        insert contact1;
        
        Contact contact2 = new Contact();
        contact2.FirstName = 'Bill';
        contact2.LastName = 'Steve';
        contact2.MobilePhone = '0891667363';
        contact2.Policy_No__c = '77700102';
        contact2.Entity__c = entity;
        contact2.AccountId = ac1.Id;
        insert contact2;
        
        Contact contactObj = new Contact();
        contactObj.FirstName = 'Bill';
        contactObj.LastName = 'John';
        contactObj.Email = 'billgates@gmail.com';
        contactObj.Policy_No__c = '77700103';
        contactObj.Entity__c = entity;
        contactObj.AccountId = ac1.Id;
        insert contactObj;
        
        Email_SMS_Template__c est = new Email_SMS_Template__c();
        est.name = 'ICF Email Customer Onboarding (AMFS) 2024';
        est.Email_Body__c = '<table width="100%"> <tr> <td colspan="3"> <b>Yth. [CONTACT_GENDER] [CONTACT_NAME]  , </b><br/>  Terima kasih telah mempercayakan perlindungan Anda & keluarga kepada AXA Mandiri. <br/> Untuk meningkatkan kualitas pelayanan kami, mohon berikan penilaian Anda kepada kami dengan mengisi survei singkat ini. <br/>  Berikut informasi Anda / <i>Your information </i> :<br/> </td> </tr><tr> <td width="10%">Nomor Polis / <i>Policy no </i></td> <td width="1%">:</td> <td><i><b> [POLICY_NO] </b> </i></td> </tr> <tr> <td>Transaksi/ <i>Transaction</i></td> <td>:</td> <td><i><b> Pembelian Polis </b> </i></td> </tr> <tr> <td colspan="3"><br/> Klik link berikut : <a href=" [SURVEY_LINK] "><b>Link Survei</b> </a><br/><br/> <b>PT AXA Mandiri Financial Services</b><br/><br/> <img src="https://axaid-ccc--fullsb.sandbox.my.salesforce.com/sfc/dist/version/renditionDownload?rendition=ORIGINAL_Png&versionId=068F8000001TzMf&operationContext=DELIVERY&contentId=05TF8000004sjdl&page=0&d=/a/F80000000bme/3S4laOao8Mx3n9Vcv6i5HKOz21MyEfGK0xdS.Pkeuwo&oid=00D5D0000005HgM&dpt=null&viewId=" width="250" style="margin: 0 0 0 0"/> </td> </tr> </table> <br/>';
        est.Email_Footer__c = '<tr><td colspan="2"><b>INFO : </b><br/>Apabila Anda membutuhkan informasi lebih lanjut, kami siap membantu Anda di layanan <b>Customer Care Centre</b> atau <b>Layanan Live Chat</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> atau Anda dapat mengirimkan email ke <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a> <br/><i>For more info, please contact <b>Customer Care Centre</b> or <b>Live Chat Service</b> <a href="www.axa-mandiri.co.id">www.axa-mandiri.co.id</a> or email to <a href="mailto:customer@axa-mandiri.co.id">customer@axa-mandiri.co.id</a></i></td></tr></table>';
        est.Subject__c = 'Survey Kepuasan Nasabah Pembelian Polis';
        insert est;
        
        Survey__c setSurvey = new Survey__c();
        setSurvey.name = 'Survey Nasabah Onboarding';
        setSurvey.Submit_Response__c = 'empty';
        setSurvey.RecordTypeId =  Schema.SObjectType.Survey__c.getRecordTypeInfosByName().get('Master New Onboarding').getRecordTypeId();
        setSurvey.Status__c = 'Active';
        setSurvey.Survey_Type__c = 'I Buy';
        setSurvey.Entity__c = 'AMFS';
        insert setSurvey;
        
        Email_SMS_Log__c esl = new Email_SMS_Log__c();
        esl.OwnerId = UserInfo.getUserId();
        esl.Account__c = contactObj.AccountId;
        esl.Category__c = 'ICF';
        esl.Contact__c = contactObj.Id;
        esl.Mobile__c = contactObj.MobilePhone;
        esl.Email__c = contactObj.Email;
        esl.Method__c = 'Email';
        esl.Entity__c = 'AMFS';
        esl.Request_Date__c = Date.Today();
        esl.Survey_Type__c = 'I Buy - Pembelian Polis';
        esl.Survey_URL__c = setSurvey.URL__c;
        esl.Survey__c = setSurvey.Id;
        esl.Start_Date__c = Date.Today();
        esl.Type__c = 'CCC';
        esl.Email_SMS_Template__c = est.Id;
        esl.Template_Email__c =  est.Id;
        esl.Template_SMS__c =  est.Id;
        esl.Department_Owner__c = 'ICF';
        esl.Topic__c = 'ICF';
        esl.MOT__c = 'I Buy';
        esl.Status__c = 'Hold'; 
        Insert esl;
        
    
        
        
        Set<Id> idContact = new Set<Id>();
        idContact.add(contact1.Id);
        idContact.add(contact2.Id);
        System.enqueueJob(new CreateEmailSMSLogNewCust.CreateEmailSMSLog(idContact, 'New'));
        
        
        Set<Id> idContact2 = new Set<Id>();
        idContact2.add(contactObj.Id);
        CreateEmailSMSLogNewCust.sendSurveyNewCustomer(idContact2);
        Test.stopTest();
    }
}