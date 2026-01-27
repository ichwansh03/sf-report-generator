@isTest
global class InformationPanelClass_Test {
    private static testMethod void setupTestData() {
        Account a = new Account();
        a.Name = 'Account TestData';
        insert a;
        
        Contact con = new Contact();
        con.LastName = 'Contact LastName';
        con.FirstName = 'Contact FirstName';
        insert con;
        
        Test.startTest();
        
        PageReference pageRef = Page.InformationPanelCustomer;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', String.valueOf(con.Id));
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        InformationPanelClass ext = new InformationPanelClass(sc);
        
        Test.setMock(HttpCalloutMock.class, new mockGetCustomerInfo());
        String res = ext.calloutCustomerInfo();
        
        ext.calloutPolicyAgent();
        ext.responsePolicyAgent();
        
        String js1 = '{"Body":{"operation":"Policy Details","transactionId":"daee0fe9-26a6-7895-ce89-c0e384ab4de6","status":"1","entity":"AMFS","service":"getPolicyDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyEffectiveDTTM":"20150227","hasLifePolicyTransactionDetailsIn":[{}],"paymentMethodCD":"   ","policyRK":"A ","policyExpirationDTTM":"21110227","initialLumpsumPremiumAMT":"              .00","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"0","endPremiumHolidayDT":"0"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20150213"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"HONMN          ","hasPolicySegmentDetailsIn":[{"sumInsured":"      100000000"}],"planNM":"Asuransi Mandiri Sejahtera Map"}],"topupRegularModalPremium":"        245229.00","policyStatusCD":"[1] PREMIUM PAYING","terminationDt":"0","hasDetailsOfPolicyIn":[{"gdbValue":"              0","dividendAmt":"          .00","futurePremiumDpIntTypeCode":"             .0000","loanRepaymentAmt":"         .00","futurePremiumDpAmt":"              .00","loanIntTypeCd":"        .00","dividendTypeCD":"        .00"}],"policyDueDt":"20180927","premiumAMT":"        500001.33","paymentModeCD":"M  ","ePolicy":"N  ","hasDetailsOfRisksIn":[{"insuredID":"1403CLT04081001024            ","hasPersonalDetailsIn":[{"genderCD":"F ","hasAddressesIn":[{"emailAddress":"                              ","mobilePhoneNO":"081275452262        "}],"lastNM":"ALIFAH","middleNM":"NAYLA","firstNM":"SITI","birthPlace":"                             ","birthDT":"20100319"}]}],"issueDt":"20150227","sourceChannelCD":"RP                                 "}]},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
        ext.deserializePolicyDetails(js1);
        
        String js2 = '{"Body":{"operation":"Agent Info","transactionId":"60c2606f-7638-37b7-9496-36fa688560d9","status":"1","entity":"AMFS","service":"getAgentInfo","appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"},"AgSa_InsurancePolicy_Type":{"hasPartyDetailsIn":[{"canBeInternalOrg":{"orgShortNm":"IB"},"branchCD":"  ","canBeIndividual":{"hasAddressesIn":[{"telephoneNO":"0                   ","emailAddress":"shara.sasmita@fa.axa-mandiri.co.id                ","addressLine4":"                              ","addressLine3":"                              ","addressLine2":" - RIAU                       ","addressLine1":"JL. TUANKU TAMBUSAI UJUNG DURI","mobilePhoneNO":"085363771164        ","officeTelNo":"                    ","officeAddressLine1":"                              ","officeAddressLine3":"                              ","officeAddressLine2":"                              ","telephoneNO2":"                    ","officeAddressLine4":"                              "}],"distributionType":"BA","lastNM":"SASMITA","distributionCD":"  ","firstNM":"SHARA","effectiveNominationDT":"20141024"},"partyID":"1403094510928585    ","partyNO":"010206              ","partyStatus":"  "}]}}}';
        ext.deserializeAgentInfo(js2);
        
        String js3 = '{"Body":{"operation":"Claim","transactionId":"1c4ae3aa-80cb-4ae8-cd49-8ec42bd5a8ab","status":"1","entity":"AMFS","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"hasDetailsOfClaimIn":[{"claimOpenDTTM":"20180305","hasClaimUnitIn":[{"claimRK":"[P] Claim Approved","claimedAMT":"       750000.00   ","claimUnitRK":"CA"}],"claimReferenceID":"0000211621","claimTypeCd":"HEALTH    ","claimApprovalDTTM":"20180305","claimRk":"MEB1      "}],"isAssociatedWithLifeInsuranceProduct":[{"productTypeCD":"R"}],"key":"1"},{"hasDetailsOfClaimIn":[{"claimOpenDTTM":"20170522","hasClaimUnitIn":[{"claimRK":"[P] Claim Approved","claimedAMT":"      1000000.00   ","claimUnitRK":"CA"}],"claimReferenceID":"0000190646","claimTypeCd":"HEALTH    ","claimApprovalDTTM":"20170522","claimRk":"MEB1      "}],"isAssociatedWithLifeInsuranceProduct":[{"productTypeCD":"R"}],"key":"2"},{"hasDetailsOfClaimIn":[{"claimOpenDTTM":"20170222","hasClaimUnitIn":[{"claimRK":"[P] Claim Approved","claimedAMT":"      1000000.00   ","claimUnitRK":"CA"}],"claimReferenceID":"0000183442","claimTypeCd":"HEALTH    ","claimApprovalDTTM":"20170406","claimRk":"MEB1      "}],"isAssociatedWithLifeInsuranceProduct":[{"productTypeCD":"R"}],"key":"3"},{"hasDetailsOfClaimIn":[{"claimOpenDTTM":"20150928","hasClaimUnitIn":[{"claimRK":"[P] Claim Approved","claimedAMT":"       750000.00   ","claimUnitRK":"CA"}],"claimReferenceID":"0000141123","claimTypeCd":"HEALTH    ","claimApprovalDTTM":"20150928","claimRk":"MEB1      "}],"isAssociatedWithLifeInsuranceProduct":[{"productTypeCD":"R"}],"key":"4"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        ext.deserializeClaimDetails(js3);
        
        Test.stopTest();
    }

    global class mockGetCustomerInfo implements HttpCalloutMock {
        global HttpResponse respond(HTTPRequest req) {
            
            String jsonBody = '{"Body":{"operation":"Customer Profile","transactionId":"337708a6-6cb4-112d-6c1f-cd36a648cecb","status":"1","entity":"AMFS","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"F ","hasAddressesIn":[{"addressLine4":"BENGKALIS,RIAU 28884","addressLine3":"GG.NURI,KEL.AIR JAMBAN","addressLine2":"JL.TEGALSARI,BLOK A-5","addressLine1":"PERUM.AKASIA RESIDENCE"}],"birthPlace":"","birthDT":"20100319"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{}},"servicingCD":"62418004010206","producingCD":"62418004010206"}]}],"customerID":"1403CLT04081001024"},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"0","numberOfRecords":"0","pageNumber":"0","startOfRecords":"0"}}}';
            HttpResponse res = new HttpResponse();
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setHeader('Content-Type', 'application/json');
            res.setBody(jsonBody);
            
            return res;
        }
    }
}