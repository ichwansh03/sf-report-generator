@isTest
public class ScriptTest {
	
    public static Call_Line__c welcomeCallInfoPolis;
	    
    @isTest static void testAllTabTaskList(){
		Test.startTest();
        WelcomeCallMockUpData_T.mockScriptDatas();
        Call_Line__c welcomeCall = WelcomeCallMockUpData_T.mockWelcomeCallCallLine1();
        
        PageReference tabTaskListPage = Page.TabTaskList;
        Test.setCurrentPageReference(tabTaskListPage);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCall);
        TabTaskListCtrl tabTaskList = new TabTaskListCtrl(stdCon);
        tabTaskList.createNewSurveyTakerbyCL();
        TabTaskListCtrl.getTabsTaskList('HONMN');
        
        Test.stopTest();
    }
    
    @isTest static void testTabPembuka(){
        User usr = [Select id from User where id =: UserInfo.getUserId()];
		Test.startTest();
        WelcomeCallMockUpData_T.mockScriptDatas();
        Call_Line__c welcomeCall = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Salam', 'salam-1-1', 'Contacted Status');
        
        PageReference tabPembuka = Page.TabPembuka;
        tabPembuka.getParameters().put('id', welcomeCall.Id);
        tabPembuka.getParameters().put('tab', 'Salam');
        Test.setCurrentPageReference(tabPembuka);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCall);
        TabPembukaCtrl obj = new TabPembukaCtrl(stdCon);
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCall.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        
        System.runAs(usr){
        	TabPembukaCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved),'Salam');
        }
        
        Test.stopTest();
    }
    
    @isTest static void testTabVerify(){
		Test.startTest();
        WelcomeCallMockUpData_T.mockScriptDatas();
        Call_Line__c welcomeCall = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Verifikasi Data', 'verifikasi-1-1', 'Verifikasi Data');
                
        PageReference tabVerify = Page.TabVerify;
        tabVerify.getParameters().put('id', welcomeCall.Id);
        tabVerify.getParameters().put('tab', 'Verifikasi Data');
        Test.setCurrentPageReference(tabVerify);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCall);
        TabVerifyCtrl obj = new TabVerifyCtrl(stdCon);
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCall.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        TabVerifyCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved), 'Verifikasi Data');
        
        Test.stopTest();
    }
    
    @isTest static void testTabProduct(){
		Test.startTest();
        WelcomeCallMockUpData_T.mockScriptDatas();
        Call_Line__c welcomeCall = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Product', 'produk-1-1', 'Informasi Buku Polis e-Policy');
        
        PageReference tabProduct = Page.TabProduct;
        tabProduct.getParameters().put('id', welcomeCall.Id);
        tabProduct.getParameters().put('tab', 'Product');
        Test.setCurrentPageReference(tabProduct);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCall);
        TabProductCtrl obj = new TabProductCtrl(stdCon);
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCall.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        TabProductCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved), 'Product');
        
        Test.stopTest();
    }
    
    @isTest static void testTabPenutup(){
        User usr = [Select id from User where id =: UserInfo.getUserId()];
		Test.startTest();
        WelcomeCallMockUpData_T.mockScriptDatas();
        Call_Line__c welcomeCall = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Sesi Pertanyaan','pertanyaan-1-1', 'Salam Penutup');
        
        PageReference tabPenutup = Page.TabPenutup;
        tabPenutup.getParameters().put('id', welcomeCall.Id);
        tabPenutup.getParameters().put('tab', 'Penutup');
        Test.setCurrentPageReference(tabPenutup);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCall);
        TabPenutupCtrl obj = new TabPenutupCtrl(stdCon);
        
        welcomeCall.WelcomeCall_Call_Line_Status__c = 'Closed';
        update welcomeCall;
        obj.UpdateCallLineStatus();
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCall.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        
        System.runAs(usr){
        	TabPenutupCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved));
        }
        
        Test.stopTest();
    }
    
    @isTest static void testTabLegal(){
		Test.startTest();
        WelcomeCallMockUpData_T.mockScriptDatas();
        Call_Line__c welcomeCall = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Legal Statement','legal-1-1', 'Konfirmasi Kelanjutan Polis');
        
        PageReference tabLegal = Page.TabLegal;
        tabLegal.getParameters().put('id', welcomeCall.Id);
        tabLegal.getParameters().put('tab', 'Legal Statement');
        Test.setCurrentPageReference(tabLegal);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCall);
        TabLegalCtrl obj = new TabLegalCtrl(stdCon);
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCall.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        TabLegalCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved), 'Legal Statement');
        
        Test.stopTest();
    }
    
    @isTest public static void testTabQuestion(){
        Test.setMock(HttpCalloutMock.class, new ScriptTest_Mock());
        WelcomeCallMockUpData_T.mockScriptDatas();
        welcomeCallInfoPolis = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Sesi Pertanyaan','pertanyaan-11-1-a', 'Pertanyaan 1');
		Test.startTest();

        //welcomeCallInfoPolis = [Select id from Call_Line__c limit 1 ];
        system.debug('welcomeCall =='+welcomeCallInfoPolis);
        
        
        PageReference tabQuestion = Page.TabQuestion;
        tabQuestion.getParameters().put('id', welcomeCallInfoPolis.Id);
        tabQuestion.getParameters().put('tab', 'Sesi Pertanyaan');
        Test.setCurrentPageReference(tabQuestion);
        system.debug('tabQuestion =='+tabQuestion);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCallInfoPolis);
        system.debug('stdCon test test =='+stdCon);
        TabQuestionCtrl obj = new TabQuestionCtrl(stdCon);
        // String  dataCustomerJSON = '{"Body":{"operation":"Customer Profile","transactionId":"337708a6-6cb4-112d-6c1f-cd36a648cecb","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"F ","hasAddressesIn":[{"emailAddress":"SRINELVIHESTY@YAHOO.CO.ID     ","addressLine4":"BENGKALIS,RIAU 28884                              ","addressLine3":"GG.NURI,KEL.AIR JAMBAN                            ","addressLine2":"JL.TEGALSARI,BLOK A-5                             ","mobilePhoneNO":"081275452262        ","addressLine1":"PERUM.AKASIA RESIDENCE                            "}],"lastNM":"HESTY","middleNM":"NELVI","firstNM":"SRI","fullNM":"SRI NELVI HESTY                                   ","birthPlace":"                              ","birthDT":"19800410"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{}},"servicingCD":"62418004010206      ","producingCD":"62418004010206      "}],"policyNO":"515-3881890"}],"customerID":"640309500480000               "},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
        system.debug('obj test test =='+obj);
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCallInfoPolis.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        TabQuestionCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved), 'Sesi Pertanyaan');
        
        Test.stopTest();
    }
    
	@isTest public static void testTabInfoPolis(){
        Test.setMock(HttpCalloutMock.class, new ScriptTest_Mock());
        WelcomeCallMockUpData_T.mockScriptDatas();
        welcomeCallInfoPolis = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Sesi Informasi Produk dan Pertanyaan Pelayanan FA','pernyataan-1-1-a', 'Pernyataan 1');
		Test.startTest();

        //welcomeCallInfoPolis = [Select id from Call_Line__c limit 1 ];
        
        
        PageReference tabInfoPolis = Page.TabInformasiPolis;
        tabInfoPolis.getParameters().put('id', welcomeCallInfoPolis.Id);
        tabInfoPolis.getParameters().put('tab', 'Sesi Informasi Produk dan Pertanyaan Pelayanan FA');
        Test.setCurrentPageReference(tabInfoPolis);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCallInfoPolis);
        TabInfoPolisCtrl obj = new TabInfoPolisCtrl(stdCon);
        // String  dataCustomerJSON = '{"Body":{"operation":"Customer Profile","transactionId":"337708a6-6cb4-112d-6c1f-cd36a648cecb","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"F ","hasAddressesIn":[{"emailAddress":"SRINELVIHESTY@YAHOO.CO.ID     ","addressLine4":"BENGKALIS,RIAU 28884                              ","addressLine3":"GG.NURI,KEL.AIR JAMBAN                            ","addressLine2":"JL.TEGALSARI,BLOK A-5                             ","mobilePhoneNO":"081275452262        ","addressLine1":"PERUM.AKASIA RESIDENCE                            "}],"lastNM":"HESTY","middleNM":"NELVI","firstNM":"SRI","fullNM":"SRI NELVI HESTY                                   ","birthPlace":"                              ","birthDT":"19800410"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{}},"servicingCD":"62418004010206      ","producingCD":"62418004010206      "}],"policyNO":"515-3881890"}],"customerID":"640309500480000               "},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCallInfoPolis.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        TabInfoPolisCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved), 'Sesi Informasi Produk dan Pertanyaan Pelayanan FA');
        
        Test.stopTest();
    }
    
    @isTest public static void testTabSurvey(){
        Test.setMock(HttpCalloutMock.class, new ScriptTest_Mock());
        WelcomeCallMockUpData_T.mockScriptDatas();
        welcomeCallInfoPolis = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Survey','pernyataan-survey-paydi-1', 'Kepuasan Pelanggan');
        Test.startTest();

        //welcomeCallInfoPolis = [Select id from Call_Line__c limit 1 ];
        
        
        PageReference tabSurvey = Page.TabSurvey;
        tabSurvey.getParameters().put('id', welcomeCallInfoPolis.Id);
        tabSurvey.getParameters().put('tab', 'Survey');
        Test.setCurrentPageReference(tabSurvey);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCallInfoPolis);
        TabSurveyCtrl obj = new TabSurveyCtrl(stdCon);
        // String  dataCustomerJSON = '{"Body":{"operation":"Customer Profile","transactionId":"337708a6-6cb4-112d-6c1f-cd36a648cecb","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"F ","hasAddressesIn":[{"emailAddress":"SRINELVIHESTY@YAHOO.CO.ID     ","addressLine4":"BENGKALIS,RIAU 28884                              ","addressLine3":"GG.NURI,KEL.AIR JAMBAN                            ","addressLine2":"JL.TEGALSARI,BLOK A-5                             ","mobilePhoneNO":"081275452262        ","addressLine1":"PERUM.AKASIA RESIDENCE                            "}],"lastNM":"HESTY","middleNM":"NELVI","firstNM":"SRI","fullNM":"SRI NELVI HESTY                                   ","birthPlace":"                              ","birthDT":"19800410"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{}},"servicingCD":"62418004010206      ","producingCD":"62418004010206      "}],"policyNO":"515-3881890"}],"customerID":"640309500480000               "},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCallInfoPolis.Id;
        res.isValid = true;
        res.section ='Ekspetasi Pelanggan';
        res.answer1 = 'Lain-lain';
        mapDatatoSaved.put('SalamContacted', res);
        
        TabSurveyCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved), 'Survey');
        
        Map<String, ResponseScript> mapDatatoSaved2 = new Map<String, ResponseScript>();
        ResponseScript res2 = new ResponseScript();
        res2.callLineId = welcomeCallInfoPolis.Id;
        res2.isValid = true;
        res2.section ='Kepuasan Pelanggan';
        res2.answer1 = 'No Score';
        mapDatatoSaved2.put('SalamContacted', res2);
        
        TabSurveyCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved2), 'Survey');
        
        Test.stopTest();
    }
    
    @isTest public static void testTabKonfirmasi(){
        Test.setMock(HttpCalloutMock.class, new ScriptTest_Mock());
        WelcomeCallMockUpData_T.mockScriptDatas();
        welcomeCallInfoPolis = WelcomeCallMockUpData_T.mockWelcomeCallCallLine('Konfirmasi ke FA','konfirmasi-1-1-a', 'Konfirmasi ke FA');
		Test.startTest();

        //welcomeCallInfoPolis = [Select id from Call_Line__c limit 1 ];
        
        
        PageReference tabKonfirmasi = Page.TabKonfirmasi;
        tabKonfirmasi.getParameters().put('id', welcomeCallInfoPolis.Id);
        tabKonfirmasi.getParameters().put('tab', 'Konfirmasi ke FA');
        Test.setCurrentPageReference(tabKonfirmasi);
        
        apexpages.StandardController stdCon = new ApexPages.StandardController(welcomeCallInfoPolis);
        TabKonfirmasiCtrl obj = new TabKonfirmasiCtrl(stdCon);
        // String  dataCustomerJSON = '{"Body":{"operation":"Customer Profile","transactionId":"337708a6-6cb4-112d-6c1f-cd36a648cecb","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"F ","hasAddressesIn":[{"emailAddress":"SRINELVIHESTY@YAHOO.CO.ID     ","addressLine4":"BENGKALIS,RIAU 28884                              ","addressLine3":"GG.NURI,KEL.AIR JAMBAN                            ","addressLine2":"JL.TEGALSARI,BLOK A-5                             ","mobilePhoneNO":"081275452262        ","addressLine1":"PERUM.AKASIA RESIDENCE                            "}],"lastNM":"HESTY","middleNM":"NELVI","firstNM":"SRI","fullNM":"SRI NELVI HESTY                                   ","birthPlace":"                              ","birthDT":"19800410"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{}},"servicingCD":"62418004010206      ","producingCD":"62418004010206      "}],"policyNO":"515-3881890"}],"customerID":"640309500480000               "},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
        
        Map<String, ResponseScript> mapDatatoSaved = new Map<String, ResponseScript>();
        ResponseScript res = new ResponseScript();
        res.callLineId = welcomeCallInfoPolis.Id;
        res.isValid = true;
        mapDatatoSaved.put('SalamContacted', res);
        TabKonfirmasiCtrl.SaveorUpdateScript(JSON.serialize(mapDatatoSaved), 'Konfirmasi ke FA');
        
        Test.stopTest();
    }
}