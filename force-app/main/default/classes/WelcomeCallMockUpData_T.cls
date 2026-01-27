@isTest
public class WelcomeCallMockUpData_T {
    static ID rtConfirmationAMFS = Schema.SObjectType.Call_list__c.getRecordTypeInfosByName().get('Confirmation AMFS').getRecordTypeId();
    static ID rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    
    public static void mockScriptDatas(){
        List<WelcomeCall_Script__c> scripts = new List<WelcomeCall_Script__c>{
            new WelcomeCall_Script__c(Name='salam-1-1', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                      WelcomeCall_Content_Question__c='Hi developer salam 1!', WelcomeCall_Content_Answer__c='Cancel the Policy',
                                      WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                      WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                      WelcomeCall_Tab_Name__c='Salam', WelcomeCall_Section__c='SalamContacted'),
                new WelcomeCall_Script__c(Name='salam-1-2', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='2', 
                                          WelcomeCall_Content_Question__c='Hi developer salam 1-2!', WelcomeCall_Content_Answer__c='Contacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Parent__c = 'salam-1-1', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Salam', WelcomeCall_Section__c='SalamContacted'),
                
                new WelcomeCall_Script__c(Name='verifikasi-1-1', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer verifikasi-1-1!', WelcomeCall_Content_Answer__c='Continue',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Verifikasi data', WelcomeCall_Section__c='Verifikasi Data'),
                new WelcomeCall_Script__c(Name='verifikasi-1-2', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='2', 
                                          WelcomeCall_Content_Question__c='Hi developer verifikasi-1-2!', WelcomeCall_Content_Answer__c='Uncontacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true, WelcomeCall_Parent__c = 'verifikasi-1-1',
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Verifikasi data', WelcomeCall_Section__c='Verifikasi Data'),
                
                new WelcomeCall_Script__c(Name='produk-1-1', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer produk-1-1!', WelcomeCall_Content_Answer__c='Contacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Product', WelcomeCall_Section__c='SalamContacted'),
                new WelcomeCall_Script__c(Name='produk-1-2', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='2', 
                                          WelcomeCall_Content_Question__c='Hi developer produk-1-2!', WelcomeCall_Content_Answer__c='Contacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true, WelcomeCall_Parent__c='produk-1-2',
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Product', WelcomeCall_Section__c='SalamContacted'),
                
                new WelcomeCall_Script__c(Name='pertanyaan-11-1-a', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer pertanyaan-11-1-a!', WelcomeCall_Content_Answer__c='Uncontacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Sesi Pertanyaan', WelcomeCall_Section__c='SalamContacted'),
                new WelcomeCall_Script__c(Name='pertanyaan-11-1-b', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='2', 
                                          WelcomeCall_Content_Question__c='Hi developer pertanyaan-11-1-b!', WelcomeCall_Content_Answer__c='Uncontacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true, WelcomeCall_Parent__c='pertanyaan-1-1',
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Sesi Pertanyaan', WelcomeCall_Section__c='SalamContacted'),
                
                new WelcomeCall_Script__c(Name='pernyataan-1-1-a', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer pernyataan-1-1-a! !Contact.Product_Type', WelcomeCall_Content_Answer__c='Uncontacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Sesi Informasi Produk dan Pertanyaan Pelayanan FA', WelcomeCall_Section__c='Pernyataan 1'),
                new WelcomeCall_Script__c(Name='pernyataan-1-1-b', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='2', 
                                          WelcomeCall_Content_Question__c='Hi developer pernyataan-1-1-b!', WelcomeCall_Content_Answer__c='Uncontacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',WelcomeCall_Parent__c='pernyataan-1-1-a',
                                          WelcomeCall_Tab_Name__c='Sesi Informasi Produk dan Pertanyaan Pelayanan FA', WelcomeCall_Section__c='Pernyataan 1'),
                new WelcomeCall_Script__c(Name='pernyataan-1-1-c', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='3', 
                                          WelcomeCall_Content_Question__c='!Contact.Product_Type pernyataan-1-1-c', WelcomeCall_Content_Answer__c='Contacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',WelcomeCall_Parent__c='pernyataan-1-1-a',
                                          WelcomeCall_Tab_Name__c='Sesi Informasi Produk dan Pertanyaan Pelayanan FA', WelcomeCall_Section__c='Pernyataan 1'),
               
                new WelcomeCall_Script__c(Name='legal-1-1', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer legal-1-1!', WelcomeCall_Content_Answer__c='Contacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Legal Statement', WelcomeCall_Section__c='Konfirmasi Kelanjutan Polis'),
                new WelcomeCall_Script__c(Name='legal-1-2', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='2', 
                                          WelcomeCall_Content_Question__c='Hi developer legal-1-2!', WelcomeCall_Content_Answer__c='Contacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true, WelcomeCall_Parent__c='legal-1-1;verifikasi-1-1;',
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Legal Statement', WelcomeCall_Section__c='Konfirmasi Kelanjutan Polis'),
                
                new WelcomeCall_Script__c(Name='penutup-1-1', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer penutup-1-1!', WelcomeCall_Content_Answer__c='Uncontacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true,
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Penutup', WelcomeCall_Section__c='Salam Penutup'),
                new WelcomeCall_Script__c(Name='penutup-1-2', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='2', 
                                          WelcomeCall_Content_Question__c='Hi developer penutup-1-2!', WelcomeCall_Content_Answer__c='Uncontacted',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true, WelcomeCall_Parent__c='penutup-1-1;verifikasi-1-1;',
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Penutup', WelcomeCall_Section__c='Salam Penutup'),
                new WelcomeCall_Script__c(Name='pernyataan-survey-paydi-1', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer pernyataan-survey-paydi-1!', WelcomeCall_Content_Answer__c='1',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true, WelcomeCall_Parent__c='pernyataan-7-1-b-1; pernyataan-8-1-e; pernyataan-8-1-f-1;',
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Survey', WelcomeCall_Section__c='Kepuasan Pelanggan'),
                new WelcomeCall_Script__c(Name='konfirmasi-1-1-a', WelcomeCall_Type__c='Radio Button', WelcomeCall_Order__c='1', 
                                          WelcomeCall_Content_Question__c='Hi developer konfirmasi-1-1-a!', WelcomeCall_Content_Answer__c='',
                                          WelcomeCall_Group_Type__c='Radio Button', WelcomeCall_Fg_Note__c=true, WelcomeCall_Parent__c='pernyataan-7-1-b-1; pernyataan-8-1-e; pernyataan-8-1-f-1;',
                                          WelcomeCall_Product_Name__c='LABEL_WelcomeCall_all_konvensional_product;',
                                          WelcomeCall_Tab_Name__c='Konfirmasi ke FA', WelcomeCall_Section__c='Konfirmasi ke FA')
                };
                    insert scripts;
        
        List<WelcomeCall_Product__c> products = new List<WelcomeCall_Product__c>{
            new WelcomeCall_Product__c(Name='MSW5A', WelcomeCall_Type__c = 'KONVENSIONAL', WelcomeCall_Product_Name__c='MSW5A', WelcomeCall_Fg_Active__c = true),
                new WelcomeCall_Product__c(Name='HONMEP', WelcomeCall_Type__c = 'Unit Link', WelcomeCall_Product_Name__c='HONMEP', WelcomeCall_Fg_Active__c = true),
                new WelcomeCall_Product__c(Name='HONMIP', WelcomeCall_Type__c = 'Unit Link', WelcomeCall_Product_Name__c='HONMIP', WelcomeCall_Fg_Active__c = true)
                };
                    insert products;
    }
    
    
    
    public static Id mockContactData(){
        Contact ct = new Contact();
        ct.LastName = 'Test Contact Last Name';
        ct.Policy_No__c = '515-6068438';
        ct.PolicyApp__c = 'RLS';
        ct.WelcomeCall_Product_Code_Plan__c ='HONMEP';
        ct.Entity__c = 'AMFS';
        ct.Total_Premium__c = 10000.0;
        ct.WelcomeCall_Lump_Sum__c = 1000.0;
        insert ct;
        
        return ct.Id;
    }
    
    public static Contact mockContact(){
        Contact ct = new Contact();
        ct.LastName = 'Test Contact Last Name 1';
        ct.Policy_No__c = '515-6068439';
        ct.PolicyApp__c = 'RLS';
        ct.WelcomeCall_Product_Code_Plan__c ='MSW5A';
        ct.Entity__c = 'AMFS';
        ct.Total_Premium__c = 10000.0;
        ct.WelcomeCall_Lump_Sum__c = 1000.0;
        insert ct;
        return ct;
    }
    
    public static Id mockWelcomeCallCampaignData(){
        Call_List__c cpg = new Call_List__c();
        cpg.Activity__c = 'Confirmation';
        cpg.Case_Type__c = 'Welcome Call';
        cpg.RecordTypeId = rtConfirmationAMFS;
        cpg.Expired_Date__c = Date.newInstance(3000, 12, 1);
        insert cpg;
        
        return cpg.Id;
    }
    public static Call_Line__c mockWelcomeCallCallLine1(){
        Contact contactNew = new Contact();
        contactNew = mockContact();
        Call_Line__c welcomeCall = new Call_Line__c();
        welcomeCall.Contact__c = mockContactData();
        welcomeCall.Call_List__c = mockWelcomeCallCampaignData();
        welcomecall.Case_Type__c = 'Welcome Call';
        welcomeCall.RecordTypeId = rtCallLineWC;
        welcomeCall.WelcomeCall_Call_Line_Status__c = 'Open';
        welcomeCall.WelcomeCall_Schedule_Date__c = Datetime.now();
        welcomeCall.WelcomeCall_Criteria__c ='Retail';
        
        insert welcomeCall;
        WelcomeCallUtils wcu = new WelcomeCallUtils();
        wcu.populateDetailNasabah(contactNew,welcomeCall);
        return welcomeCall;
    }
    
    
    
    public static Call_Line__c mockWelcomeCallCallLine(String tabName, String name, String section){
        Call_Line__c welcomeCall = new Call_Line__c();
        welcomeCall.Contact__c = mockContactData();
        welcomeCall.Call_List__c = mockWelcomeCallCampaignData();
        welcomecall.Case_Type__c = 'Welcome Call';
        welcomeCall.RecordTypeId = rtCallLineWC;
        welcomeCall.WelcomeCall_Call_Line_Status__c = 'Open';
        welcomeCall.WelcomeCall_Schedule_Date__c = Datetime.now();
        //welcomeCall.WelcomeCall_Criteria__c ='Retail';
        
        insert welcomeCall;
        
        welcomeCall.WelcomeCall_Call_Line_Status__c = 'Closed';
        update welcomeCall;
        
        SurveyTaker__c svT = new SurveyTaker__c();
        svT.OwnerId = userinfo.getUserId();
        svt.Contact__c = welcomeCall.Contact__c;
        svt.WelcomeCall_CallLine__c = welcomeCall.Id;
        svt.User__c = svT.OwnerId;
        
        insert svt;
        
        CallLineTriggerControl.skipResponseTrigger = true;
        Survey_Response__c response = new Survey_Response__c();
        response.SurveyTaker__c = svt.Id;
        response.WelcomeCall_Call_Line__c = welcomecall.Id;
        response.WelcomeCall_Section__c = section;
        response.Question_1__c = name;
        response.WelcomeCall_Tab__c = TabName;
        response.answer_1__c ='Continue';
        insert response;
        
        return welcomeCall;
    }
    
}