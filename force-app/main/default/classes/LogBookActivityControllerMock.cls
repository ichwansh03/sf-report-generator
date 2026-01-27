@isTest
global class LogBookActivityControllerMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        
        System.debug('EIP MOCK REQUEST: '+req.getBody());
        String sJsonResponse='';
        if (req.getBody().contains('getPolicyDetails')) {
            sJsonResponse = '{"Body":{"service":"getPolicyDetails","appID":"RLS","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"birthPlace":"                              ","birthDT":"19780608","socialSecurityNO":"3604144806780002              ","genderCD":"F ","firstNM":"MALIHATUL MASNU\'AH                                ","hasAddressesIn":[{"mobilePhoneNO":"081319428480        ","emailAddress":"MALIHASYAUQI@GMAIL.COM        "}]},"hasPolicyAccount":[{"isAssociatedWithLifeInsuranceProduct":[{"hasPolicySegmentDetailsIn":[{"sumInsured":"      169532650"}],"insuranceProductRk":"Asuransi PAS 5 Years Max - Annual                 ","planCd":"MFPS5MA        ","planNM":"Asuransi PAS 5 Years Max - Annual                 ","insuranceProductCd":"MFPS5MA        "}],"policyDueDt":"20250614","ePolicy":"N  ","hasLifePolicyTransactionDetailsIn":[{"hasPaymentDetailsIn":[{"accountDetails":{}}]}],"hasDetailsOfPolicyIn":[{"gdbValue":"               ","loanRepaymentAmt":"         .00","dividendAmt":"          .00","futurePremiumDpIntTypeCode":"             .0000","loanIntTypeCd":"        .00","dividendTypeCD":"        .00","futurePremiumDpAmt":"              .00"}],"currencyCD":"RP ","paidToDT":"00000000","policyExpirationDTTM":"20320614","initialLumpsumPremiumAMT":"              .00","statusChangeDT":"00000000","policyNO":"319-1834021","hasDetailsOfRisksIn":[{"hasPersonalDetailsIn":[{"birthPlace":"                              ","birthDT":"19780608","genderCD":"F ","firstNM":"MALIHATUL","hasAddressesIn":[{"mobilePhoneNO":"081319428480        ","emailAddress":"MALIHASYAUQI@GMAIL.COM        "}],"lastNM":"MASNU\'AH"}],"insuredID":"3604144806780002              "}],"hasPartyDetailsIn":[{"servicingCD":"55869004015703      ","partyCD":"55869004015703      "}],"paymentModeCD":"A  ","topupRegularModalPremium":"              .00","policyStatusCD":"[1] PREMIUM PAYING","policyRK":"A ","hasApplicationDetailsIn":[{"applicationDTTM":"20240613"}],"policyReserveAmt":"              .00","premiumAMT":"      25000000.03","terminationDt":"0","paymentMethodCD":"A  ","policyEffectiveDTTM":"20240614","sourceChannelCD":"          ","hasLifePolicyChangeTransDetailsIn":[{"endPremiumHolidayDT":"0","startPremiumHolidayDT":"0"}],"issueDt":"20240614"}],"key":"19a0677f-b5b4-403a-89b1-1ca6ccc02fb2#10.144.2.16#SFDCEIP"},"operation":"Policy Details","transactionId":"0055D00000567M6QAI-20240718-5e16cf52933a1d85d611f270df09d4eb","entity":"AMFS","status":"1"}}';
        } else if(req.getBody().contains('Direct Verification')) {
            sJsonResponse = '{"Body":{"Customer":{"hasPolicyAccount":[{"policyNO":"319-1834021"}],"canBeIndividual":{"passportNo":"aHehT#84wQ","birthDT":"Tidak Sesuai","residentStatusCd":"Tidak Sesuai","hasAddressesIn":[{"hamletNo":"100","villageNm":"Tidak Sesuai","primaryAddressFLG":"Tidak Sesuai (0)","neighbourhoodNo":"Tidak Sesuai","addressLine1":"Tidak Sesuai","addressLine2":"Tidak Sesuai","addressLine3":"Tidak Sesuai","addressLine4":"Tidak Sesuai"}],"individualRK":"SFDC-WS","birthPlace":"Tidak Sesuai (0)","titleTXT":"DASHBOARD","maritalStatusCD":"Tidak Sesuai","socialSecurityNO":"Sesuai","genderCD":"Tidak Sesuai","headOfHouseholdInd":"Tidak Sesuai (0)","occupationClassCd":"Tidak Sesuai","fullNM":"Sesuai (100)"},"key":"1c52e043-76bf-4658-b610-092764102352#10.144.2.15#SFDCEIP","haveCommunicatedMessage":[{}]},"service":"getCustomerInfo","appID":"DUKCAPIL","operation":"Direct Verification","transactionId":"0055D00000567M6QAI-20240718-e0d6503f7ddced2d6e3a3b9aab46e83c","entity":"AMFS","status":"1"}}';
        } else {
      		sJsonResponse = '{"Body": {"transactionId": "1234567890","status": "1"}}';      
        }
      
        res.setBody(sJsonResponse);
        res.setStatusCode(200);
        
        return res; 
    }
}