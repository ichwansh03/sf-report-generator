@isTest
public class DetailNasabahCtrl_testClass {
    @isTest static void test1(){
        Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
            
        Contact contt = new Contact();
        contt.Policy_No__c = '515-3932503';
        contt.entity__c = 'AMFS'; 
        contt.policyApp__c = 'RLS';
        contt.phone = '45678'; 
        contt.Agent_Code__c = '675849';
        //contt.Welcomecall_Ape__c = 10000000;
        contt.WelcomeCall_Payment_Type__c ='M';
        contt.Premium__c=10000000;
        contt.welcomecall_issued_date__c = date.today();
        contt.welcomecall_product_code_plan__c = 'HONMN';
        contt.email = 'asdasd@gmail.com';
        contt.LastName = 'Telat';
        
        insert contt;
        
        Call_Line__c callL = new Call_Line__c();
        callL.Policy_No__c = contt.Policy_No__c;
        callL.WelcomeCall_Schedule_Date__c = datetime.now();
        callL.WelcomeCall_Call_Line_Status__c = 'Open';
        callL.RecordTypeId = recTypeWC;
        callL.Contact__c = contt.Id;
        
        insert callL;
            
        Test.setMock(HttpCalloutMock.class, new DetailNasabahCtrl_TestMock());
        test.startTest();
        apexpages.StandardController stdCon = new ApexPages.StandardController(callL);
        DetailNasabahCtrl testDNC = new DetailNasabahCtrl(stdCon);
        
        
        // testDNC.populateDetailNasabah(contt, callL);
        
        /*
        String  agentInfoJSON = '{"Body":{"operation":"Agent Info","transactionId":"60c2606f-7638-37b7-9496-36fa688560d9","status":"1","entity":"AMFS","service":"getAgentInfo","appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"},"AgSa_InsurancePolicy_Type":{"hasPartyDetailsIn":[{"canBeInternalOrg":{"orgShortNm":"IB"},"branchCD":"17205 ","canBeIndividual":{"hasAddressesIn":[{"telephoneNO":"0                   ","emailAddress":"shara.sasmita@fa.axa-mandiri.co.id                ","addressLine4":"                              ","addressLine3":"                              ","addressLine2":" - RIAU                       ","addressLine1":"JL. TUANKU TAMBUSAI UJUNG DURI","mobilePhoneNO":"085363771164        ","officeTelNo":"                    ","officeAddressLine1":"                              ","officeAddressLine3":"                              ","officeAddressLine2":"                              ","telephoneNO2":"                    ","officeAddressLine4":"                              "}],"distributionType":"BA","lastNM":"SASMITA","distributionCD":"  ","firstNM":"SHARA","effectiveNominationDT":"20141024"},"partyID":"1403094510928585    ","partyNO":"010206              ","partyStatus":"T "}]}}}';
        String  preBreakJSON = '{"Body":{"operation":"Premium Breakdown","transactionId":"df2f3d03-bb11-bd50-8f60-e12aaacca0d1","status":"1","entity":"AMFS","service":"getPremiumBreakdown","appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"},"AgSa_InsurancePolicy_Type":{"policyNO":"515-3932503","isAssociatedWithLifeInsuranceProduct":[{"hasPlanDetailsIn":[{"planSI":"000000100000000","premium":"        235083.33","planStatus":"  "}],"saleEffectiveDt":"        ","planTypeCD":"BASIC     ","planCd":"HONMN     ","planClassCD":"S  ","saleExpirationDt":"        ","insuranceProductCd":"HONMN     "},{"hasPlanDetailsIn":[{"planSI":"000000000000000","premium":"         14916.78","planStatus":"  "}],"saleEffectiveDt":"20150227","planTypeCD":"RIDER     ","planCd":"MEB1      ","planClassCD":"1  ","saleExpirationDt":"20710227","insuranceProductCd":"HONMN     "},{"hasPlanDetailsIn":[{"planSI":"000000000000000","premium":"          4772.22","planStatus":"  "}],"saleEffectiveDt":"20150227","planTypeCD":"RIDER     ","planCd":"WPDD21    ","planClassCD":"1  ","saleExpirationDt":"20320227","insuranceProductCd":"HONMN     "}]}}}';
        String  dataCustomerJSON = '{"Body":{"operation":"Customer Profile","transactionId":"337708a6-6cb4-112d-6c1f-cd36a648cecb","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"F ","hasAddressesIn":[{"emailAddress":"SRINELVIHESTY@YAHOO.CO.ID     ","addressLine4":"BENGKALIS,RIAU 28884                              ","addressLine3":"GG.NURI,KEL.AIR JAMBAN                            ","addressLine2":"JL.TEGALSARI,BLOK A-5                             ","mobilePhoneNO":"081275452262        ","addressLine1":"PERUM.AKASIA RESIDENCE                            "}],"lastNM":"HESTY","middleNM":"NELVI","firstNM":"SRI","fullNM":"SRI NELVI HESTY                                   ","birthPlace":"                              ","birthDT":"19800410"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{}},"servicingCD":"62418004010206      ","producingCD":"62418004010206      "}],"policyNO":"515-3932503"}],"customerID":"640309500480000               "},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
        String  dataGIPolicyJSON = '{"Body":{"operation":"Policy Details","transactionId":"71d8dcc2-e384-c664-8ef2-e22e95a2be2d","status":"1","entity":"AMFS","service":"getPolicyDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyEffectiveDTTM":"20140326","hasLifePolicyTransactionDetailsIn":[{}],"paymentMethodCD":"   ","policyRK":"A ","policyExpirationDTTM":"20890326","initialLumpsumPremiumAMT":"              .00","currencyCD":"RP ","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"0","endPremiumHolidayDT":"0"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20140326"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"HONMN          ","insuranceProductRk":"Asuransi Mandiri Sejahtera Mapan                  ","hasPolicySegmentDetailsIn":[{"sumInsured":"       50000000"}],"planNM":"Asuransi Mandiri Sejahtera Mapan                  ","insuranceProductCd":"HONMN          "}],"topupRegularModalPremium":"        100000.00","policyStatusCD":"[1] PREMIUM PAYING","terminationDt":"0","hasDetailsOfPolicyIn":[{"gdbValue":"              0","dividendAmt":"          .00","futurePremiumDpIntTypeCode":"             .0000","loanRepaymentAmt":"         .00","futurePremiumDpAmt":"              .00","loanIntTypeCd":"        .00","dividendTypeCD":"        .00"}],"policyDueDt":"20181126","policyNO":"515-3932503","premiumAMT":"348475.10","paymentModeCD":"M  ","ePolicy":"N  ","hasDetailsOfRisksIn":[{"insuredID":"3275011403890011              ","hasPersonalDetailsIn":[{"genderCD":"M ","hasAddressesIn":[{"emailAddress":"ASRORI.HUDRI@GMAIL.COM        ","mobilePhoneNO":"085215956399        "}],"lastNM":"HARIRI","middleNM":"HUDRI","firstNM":"ASRORI","birthPlace":"                              ","birthDT":"19890314"}]}],"sourceChannelCD":"          ","issueDt":"20140326"}]},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
        DetailNasabahCtrl.DetailTask dtN = new DetailNasabahCtrl.DetailTask(contt, callL, JSON.deserializeUntyped(preBreakJSON), 
                                                                            JSON.deserializeUntyped(agentInfoJSON),JSON.deserializeUntyped(dataCustomerJSON), JSON.deserializeUntyped(dataGIPolicyJSON));
		
        */
        
        testDNC.populateDetailNasabah();
        test.stopTest();
    }
    
}