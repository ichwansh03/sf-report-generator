@isTest
public class ErecieptNotifControllerTest { 
    @testSetup static void setup() {    
        id recordID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        List<Contact> contList = new List<Contact>();
        Contact cont = new Contact();
        cont.Policy_No__c = '100-000-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP DMTM';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '500-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP KONV';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '300-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP SYA';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        
        cont = new Contact();
        cont.Policy_No__c = '801-1110001';
        cont.FirstName = 'DUMMY';
        cont.LastName = 'LOOKUP CORP';
        cont.Entity__c = 'AMFS';
        cont.PolicyApp__c = 'RLS';
        cont.RecordTypeId = recordID;
        contList.add(cont);
        Insert contList;
        
        List<Log_Book_Activitiy_Detail__c> listDetail = new List<Log_Book_Activitiy_Detail__c>();
        Log_Book_Activitiy__c logBook = new Log_Book_Activitiy__c();
        logBook.Touch_Point__c = 'Head Office';
        logBook.Log_Book_Date__c = Date.today();
        logBook.Queue_No__c = 'A001';
        logBook.Time_In__c = Time.newInstance(15, 0, 0, 0);
        logBook.Time_Served__c = Time.newInstance(15, 3, 0, 0);
        logBook.Time_Out__c = Time.newInstance(15, 20, 0, 0);
        logBook.Waiting_Time__c = '0 hours 3 minutes';
        logBook.Handling_Time__c = '0 hours 17 minutes';
        logBook.Type__c = 'Walk-In';
        Database.SaveResult lbResult = Database.insert(logBook);
         
        System.debug('lbResult.success ? '+lbResult.isSuccess());
        System.debug('lbResult.id ? '+lbResult.getId());
        
        Log_Book_Activitiy_Detail__c  logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-123-1234567';
        logBookDetail.Policy_Name_Holder__c = 'RIRIN LINDAWATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'ADS';
        logBookDetail.Kind_Of_Transaction__c = 'Cancelled Redemption';
        logBookDetail.Document_Type__c = 'New Submission';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 2;
        logBookDetail.Remarks_Long_Text__c = 'E-Receipt AMFS Test Remarks 1';
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Phone_PP__c = '085156080110';
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        listDetail.add(logBookDetail);
        
        logBookDetail = new Log_Book_Activitiy_Detail__c();
        logBookDetail.Policy_Number__c = '100-321-7654321';
        logBookDetail.Policy_Name_Holder__c = 'RITA DWI HASTATI';
        logBookDetail.Product_Type__c = 'DMTM';
        logBookDetail.Customer_Name__c = 'ririn';
        logBookDetail.Customer_Relation__c = 'Diri Sendiri';
        logBookDetail.Is_Policy_Holder__c =  true;
        logBookDetail.Segmentation__c = 'Reguler';
        logBookDetail.Department__c = 'POS';
        logBookDetail.Kind_Of_Transaction__c = 'Withdrawal';
        logBookDetail.Document_Type__c = 'Japen';
        logBookDetail.Document_Information__c = 'Fotokopi KTP[Copy];';
        logBookDetail.Other_Document__c = 'Fotokopi Buku Nikah[Copy];';
        logBookDetail.Stamp__c = 1;
        logBookDetail.Remarks_Long_Text__c = 'E-Receipt AMFS Test Remarks 2';
        logBookDetail.Customer_Mood__c = 'Normal';
        logBookDetail.Need_CR__c = 'Yes';
        logBookDetail.Status__c = 'Closed';
        logBookDetail.Contact_Policy__c = cont.Id;
        logBookDetail.Log_Book_Activitiy__c = lbResult.getId();
        logBookDetail.Shorten_Link__c = 'Adatestlink'; 
        logBookDetail.Phone_PP__c = '085156080110';
        listDetail.add(logBookDetail);
        
        LogBookActivitiyController ctrl = new LogBookActivitiyController();
        //ctrl.fetchContactDetail();
        ctrl.getListOfKYC();
        List<Database.SaveResult> lbdResults = Database.insert(listDetail);
        System.debug('lbdResults ? '+lbdResults);
        
        Email_SMS_Template__c setEmail = new Email_SMS_Template__c();
        setEmail.Method__c = 'Email';
        setEmail.Subject__c = '[SFDC] AXA - E-Receipt';
        setEmail.Email_Body__c = '<table style="width: 100%;"><tr><td style="width: 100%;">Kepada Yth : <br />Bapak/Ibu [CONTACT_NAME]<br /><br />Terimakasih atas kunjungan Bapak/Ibu ke Layanan Customer Service AXA Mandiri. Untuk tanda terima dari transaksi yang Bapak/Ibu lakukan pada [CREATED_DATE], mohon klik tautan berikut ini :<br /><br /><a href="[LINKPAGE]">Klik Link Ini</a><br /><br /> Atas perhatian, kepercayaan dan kerjasama Bapak/Ibu, kami ucapkan terima kasih.<br /><br /><i><b>&#34;Nikmati layanan mengakses informasi Polis Asuransi dan status Klaim Anda dengan cepat &amp; mudah melalui Emma – Teknologi Mudah dan Nyaman untuk Sehat juga Terlindungi di portal nasabah melalui Login Emma di www.axa-mandiri.co.id serta Whatsapp di 0815-8608-6801&#34; #nyamandirumahsaja</b></i></td></tr></table>';
        setEmail.Email_Footer__c = '<br/><table style="width: 100%;"><tr><td style="width: 100%;">  <b>PT  AXA Mandiri Financial Services</b><br/>  AXA Tower Ground Floor<br/>  Jl. Prof. Dr. Satrio Kav. 18, Kuningan City<br/>  Jakarta 12940, Indonesia<br/><table>    <tr>        <td>Email</td>        <td>: customer@axa-mandiri.co.id</td>    </tr>    <tr>        <td>Livechat</td>        <td>: www.axa-mandiri.co.id</td>    </tr>    <tr>        <td>Telp</td>        <td>: 021 – 1500 803</td>    </tr></table><br/><br/></td></tr></table>';
        insert setEmail;
        
        system.debug('setEmail:'+setEmail.id);
        
        Email_SMS_Template__c setSms = new Email_SMS_Template__c();
        setSms.Method__c = 'SMS';
        setSms.Subject__c = '[SFDC] AXA - E-Receipt';
        setSms.Email_Body__c = 'Nasabah Yth, Mohon klik tautan ini utk mendapatkan tanda terima atas transaksi Bpk/Ibu di Customer Service AXA Mandiri : [LINKPAGE]>';
        insert setSms;
        
        system.debug('setSms:'+setSms.id);
        
        system.debug('::setEmail.id:'+setEmail.id);
        system.debug('::setSms.id:'+setSms.id);
        ICF_Parameter__c setTemplateEmail = new ICF_Parameter__c();
        setTemplateEmail.Sender__c = 'AXA_MANDIRI';
        setTemplateEmail.Password__c = 'axaccc567';
        setTemplateEmail.Division__c = 'CCC';
        setTemplateEmail.Batchname__c = 'ICF_SMS_AMFS';
        setTemplateEmail.Uploadby__c = 'Salesforce_AMFS';
        setTemplateEmail.Entity__c  = 'AMFS E-Receipt'; 
        setTemplateEmail.recordTypeId  = Schema.SObjectType.ICF_Parameter__c.getRecordTypeInfosByName().get('Master - Email & SMS').getRecordTypeId(); 
        setTemplateEmail.ICF_Email_Template__c = setEmail.id;
        setTemplateEmail.ICF_SMS_Template__c = setSms.id; 
        insert setTemplateEmail;
    }
         
    static testmethod void testSendEmail(){
        Test.startTest();
        
        List<string> listEmail = new List<string>();
        listEmail.add('adi.wijaya@axa-mandiri.co.id');
       
        String subjectEmail = 'Tes Class Email';
        String bodyEmail = 'Tes Class Email';
        
        List<Log_Book_Activitiy_Detail__c> logBookDetailList = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__c, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                                 Log_Book_Activitiy__r.CSO_Name__c, Status_send__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                                 Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                                 Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, Log_Case__c,
                                 Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                                 Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,
                                 Contact_Policy__r.Email, Contact_Policy__r.MobilePhone, Email_Non_PP__c, Phone_Non_PP__c, Email_PP__c, Phone_PP__c,Is_Non_Customer__c
                                 FROM Log_Book_Activitiy_Detail__c Order by CreatedDate Limit 1];
        
        ErecieptNotifController ctrl = new ErecieptNotifController(); 
        
            
        ctrl.sendEmail(listEmail,logBookDetailList,subjectEmail,bodyEmail);
        Test.stopTest();
    }
    
    
    static testmethod void testSendSMSShortLinkBlank(){
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new ErecieptNotifController_MockTest());
           
        Log_Book_Activitiy_Detail__c logBookDetailList = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__c, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                                 Log_Book_Activitiy__r.CSO_Name__c, Status_send__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                                 Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                                 Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, Log_Case__c,
                                 Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                                 Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,
                                 Contact_Policy__r.Email, Contact_Policy__r.MobilePhone, Email_Non_PP__c, Phone_Non_PP__c, Email_PP__c, Phone_PP__c,Is_Non_Customer__c
                                 FROM Log_Book_Activitiy_Detail__c where policy_number__c = '100-123-1234567' Order by CreatedDate Limit 1];
        
        
        String touchPoint = logBookDetailList.Log_Book_Activitiy__r.Touch_Point__c;
        String urlEreciept = Label.Ereciept_URL;
        if(touchPoint.contains(' ')) touchPoint = touchPoint.replace(' ', '%20');
        urlEreciept = urlEreciept.replace('[QUEUE_NUMBER]', logBookDetailList.Log_Book_Activitiy__r.Queue_No__c);
        urlEreciept = urlEreciept.replace('[TOUCH_POINT]', touchPoint);
        urlEreciept = urlEreciept.replace('[DATE_LOG]', string.valueof(logBookDetailList.Log_Book_Activitiy__r.Log_Book_Date__c));
        
        ICF_Parameter__c icfParam = [SELECT Id, User_Id__c, Password__c, Sender__c, Division__c, Batchname__c, Uploadby__c, Channel__c, ICF_Email_Template__r.Subject__c, 
                                         ICF_Email_Template__r.Email_Header__c, ICF_Email_Template__r.Email_Body__c, ICF_Email_Template__r.Email_Footer__c, ICF_SMS_Template__r.Email_Body__c
                                         FROM ICF_Parameter__c WHERE Entity__c = 'AMFS E-Receipt' AND Record_Type_Name__c = 'Master_Email_SMS' LIMIT 1];
        
        Id LogbookId = logBookDetailList.id; 
        String bodySMS = icfParam.ICF_SMS_Template__r.Email_Body__c;
        ErecieptNotifController.sendSMS(LogbookId,bodySMS,urlEreciept,icfparam.User_ID__c,icfparam.Password__c, icfparam.Sender__c, icfparam.Division__c, icfparam.Batchname__c, icfparam.Uploadby__c, icfparam.Channel__c);
        DateTime start = System.Now();
        while(System.Now().getTime()< start.getTime()+100){}
        Test.stopTest();
    }
     
    static testmethod void testSendSMSShortWithLink(){
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new ErecieptNotifController_MockTest());
           
        Log_Book_Activitiy_Detail__c logBookDetailList = [SELECT ID, Log_Case__r.CaseNumber, Log_Book_Activitiy__c, Log_Book_Activitiy__r.Log_Book_Date__c, Log_Book_Activitiy__r.Touch_Point__c,Log_Book_Activitiy__r.Touch_Point_City__c, Log_Book_Activitiy__r.Queue_No__c, 
                                 Log_Book_Activitiy__r.CSO_Name__c, Status_send__c, Policy_Number__c, Policy_Name_Holder__c, Product_Type__c, Customer_Name__c, Customer_Relation__c,
                                 Is_Policy_Holder__c, Segmentation__c, Department__c, Kind_Of_Transaction__c, Document_Type__c, Document__c, Document_Information__c, 
                                 Stamp__c, Remarks_Long_Text__c, Notes__c, Transaction_Type__c, Case_Type__c, Customer_Mood__c, Status__c, Need_CR__c, Log_Case__r.Type, Log_Case__c,
                                 Log_Case__r.Case_Type_Config__c, Log_Case__r.Case_Type__c, Log_Case__r.Subject, Log_Case__r.Description, Log_Case__r.Description__c, 
                                 Log_Case__r.Nature_Config__c, Log_Case__r.Category_Config__c, Log_Case__r.PIC_Department_LU__c, Log_Case__r.Status, Other_Document__c,
                                 Contact_Policy__r.Email, Contact_Policy__r.MobilePhone, Email_Non_PP__c, Phone_Non_PP__c, Email_PP__c, Phone_PP__c,Is_Non_Customer__c
                                 FROM Log_Book_Activitiy_Detail__c where policy_number__c = '100-321-7654321' Order by CreatedDate Limit 1];
        
        
        String touchPoint = logBookDetailList.Log_Book_Activitiy__r.Touch_Point__c;
        String urlEreciept = Label.Ereciept_URL;
        if(touchPoint.contains(' ')) touchPoint = touchPoint.replace(' ', '%20');
        urlEreciept = urlEreciept.replace('[QUEUE_NUMBER]', logBookDetailList.Log_Book_Activitiy__r.Queue_No__c);
        urlEreciept = urlEreciept.replace('[TOUCH_POINT]', touchPoint);
        urlEreciept = urlEreciept.replace('[DATE_LOG]', string.valueof(logBookDetailList.Log_Book_Activitiy__r.Log_Book_Date__c));
        
        ICF_Parameter__c icfParam = [SELECT Id, User_Id__c, Password__c, Sender__c, Division__c, Batchname__c, Uploadby__c, Channel__c, ICF_Email_Template__r.Subject__c, 
                                         ICF_Email_Template__r.Email_Header__c, ICF_Email_Template__r.Email_Body__c, ICF_Email_Template__r.Email_Footer__c, ICF_SMS_Template__r.Email_Body__c
                                         FROM ICF_Parameter__c WHERE Entity__c = 'AMFS E-Receipt' AND Record_Type_Name__c = 'Master_Email_SMS' LIMIT 1];
        
        Id LogbookId = logBookDetailList.id; 
        String bodySMS = icfParam.ICF_SMS_Template__r.Email_Body__c;
        ErecieptNotifController.sendSMS(LogbookId,bodySMS,urlEreciept,icfparam.User_ID__c,icfparam.Password__c, icfparam.Sender__c, icfparam.Division__c, icfparam.Batchname__c, icfparam.Uploadby__c, icfparam.Channel__c);
        Test.stopTest();
    }
     
}