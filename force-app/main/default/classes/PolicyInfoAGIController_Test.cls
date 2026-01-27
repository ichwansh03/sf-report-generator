@isTest()
public class PolicyInfoAGIController_Test {
    
    static testMethod void testPolicyInfoAGIController_Test() {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        Test.startTest();
        Contact conRLS = new Contact();
        conRLS.RecordTypeId = rtId;
        conRLS.LastName = '123';
        conRLS.FirstName = 'Testing';
        conRLS.Policy_No__c = 'G0004670';
        conRLS.PolicyApp__c = 'G400';
        conRLS.Insured_Name__c = 'GABRIEL MARCIO';
        conRLS.Entity__c = 'AGI';
        conRLS.Email = 'testing123@gmail.com';
        conRLS.MobilePhone = '085657585950';
        //lst_contact.add(conRLS);
        
        ApexPages.StandardController stdContrl1 = new ApexPages.StandardController(conRLS);              
        PolicyInfoAGIController policyInfoControllerRLS = new PolicyInfoAGIController(stdContrl1);
        
        policyInfoControllerRLS.contactIDRemote='12345678900987654321';

        policyInfoControllerRLS.customerInfoJSON ='{"Body":{"operation":"Customer Profile","transactionId":"0056F000004TDzzQAG-20190903-dba1daecf38aaf18273421c070a8a55d","status":"1","entity":"AGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"0242761490      ","postalCD":"50261     ","emailAddress":"sj_pramono@yahoo.com                              ","countyNm":"IND","addressLine3":"KOTA SEMARANG                 ","addressLine2":"RW.011 KEL/DESA.NGESREP       ","mobilePhoneNO":"081390585818    ","cityNM":"KEC.BANYUMANIK                ","addressLine1":"JL.BUKIT KAWI NO.1 RT.004     "}],"primaryLanguageCd":"E","passportNo":"3374112601790001        ","individualUniqueID":"0567919 ","firstNM":"SUGIRI AMARTA                 ","fullNM":"SUGIRI AMARTA ","birthPlace":"SEMARANG            ","birthDT":"19790126"},"relatedPolicyholdersCnt":"SUGIRI AMARTA ","hasPolicyAccount":[{"hasGIPolicyEndorsementIn":[{}],"issueBranchNM":"SEMARANG                      ","policyRK":"In Force                      ","policyNO":"G0004670","hasAccountDetailsIn":[{}],"policyExpirationDTTM":"20180207","currencyCD":"1","hasProducerInformationIn":[{"gaOfficeCD":"TH1","gaOfficeNM":"TRIANESKA HUTAMA              ","gaOfficeDept":"889"}],"isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{}]}],"hasDetailsOfRisksIn":[{"insuredID":"3","hasPersonalDetailsIn":[{"firstNM":"3","fullNM":"3"}]}],"hasDetailsOfPolicyTransactionIn":[{}],"issueDt":"20170208","issueBranchCD":"006     "}],"hasRelationContact":{"hasAddressesIn":[{}]}},"appID":"G400"}}';
        policyInfoControllerRLS.customerInfoJSON = '{"Body":{"operation":"Customer Profile","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"G0004670-2"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.customerInfoJSON = '{"Body":{"operation":"Customer Profile","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"G0004670-2"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        
        policyInfoControllerRLS.beneficiaryDetailJSON='{"Body":{"operation":"Beneficiary","transactionId":"1222","status":"1","entity":"AGI","service":"getBeneficiaryDetail","appID":"RLS","AgSa_InsurancePolicy_Type":{"policyNO":"100-103-0000022","forLifeUnitofExposure":[{"hasBeneficiaryInformationIn":[{"canBeIndividual":[{"genderCD":"M","lastNM":"Alif","middleNM":"Alif","firstNM":"Alif","birthPlace":"jakarta","birthDT":"20080818"}],"hasBeneficiaryXUoeDetailsIn":[{"benefitDistributionPCT":"80.00","relationshipToInsuredCD":"Children"}]}]},{"hasBeneficiaryInformationIn":[{"canBeIndividual":[{"genderCD":"F","lastNM":"Tuti","middleNM":"Tuti","firstNM":"Tuti","birthPlace":"jakarta","birthDT":"20080817"}],"hasBeneficiaryXUoeDetailsIn":[{"benefitDistributionPCT":"20.00","relationshipToInsuredCD":"Father"}]}]}]},"AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.beneficiaryDetailJSON = '{"Body":{"operation":"Beneficiary","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.beneficiaryDetailJSON = '{"Body":{"operation":"Beneficiary","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.benefitDetailJSON='{"Body":{"operation":"Benefit Detail","transactionId":"1242","status":"1","entity":"AGI","service":"getPremiumBreakdown","appID":"RLS","AgSa_InsurancePolicy_Type":{"policyEffectiveDTTM":"20160808","policyNO":"100-118-0120040","policyExpirationDTTM":"20200818","isAssociatedWithLifeInsuranceProduct":[{"planCd":"1";"hasBenefitDetailsIn":[{"benefitCD":"8000","benefitDESC":"abc","benefitRK":"visit","benefitAMT":"10000000",}],"planTypeCD":"1",},{"planCd":"2";"hasBenefitDetailsIn":[{"benefitCD":"8200","benefitDESC":"xyz","benefitRK":"month","benefitAMT":"1200000",}],"planTypeCD":"1",},{"planCd":"3";"hasBenefitDetailsIn":[{"benefitCD":"7200","benefitDESC":"uio","benefitRK":"year","benefitAMT":"980002",}],"planTypeCD":"1",},{"planCd":"4";"hasBenefitDetailsIn":[{"benefitCD":"9400","benefitDESC":"jkl","benefitRK":"life","benefitAMT":"2894100",}],"planTypeCD":"1",},]},"AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.benefitDetailJSON='{"Body":{"operation":"Benefit Detail","transactionId":"0056F000004TDzzQAG-20190903-ddbd9ff0c0c7ee64d5df38272a51b7cb","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.benefitDetailJSON='{"Body":{"operation":"Benefit Detail","transactionId":"0056F000004TDzzQAG-20190903-ddbd9ff0c0c7ee64d5df38272a51b7cb","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        
        
        policyInfoControllerRLS.premiumBreakdownJSON='{"Body":{"operation":"Premium Breakdown","transactionId":"1240","status":"1","entity":"AGI","service":"getPremiumBreakdown","appID":"RLS","AgSa_InsurancePolicy_Type":{"policyEffectiveDTTM":"20160808","policyNO":"100-118-0120040","policyExpirationDTTM":"20200818","isAssociatedWithLifeInsuranceProduct":[{"hasPlanDetailsIn":[{"planSI":"8000","modalPlanLoading":"1","premium":"1028.80","planStatus":"OK"}],"saleEffectiveDt":"20160808","terminationDt":"20160808","planTypeCD":"1","planClassCD":"Cooling Off","saleExpirationDt":"20200818","insuranceProductCd":"108"},{"hasPlanDetailsIn":[{"planSI":"8888","modalPlanLoading":"2","premium":"1028.80","planStatus":"OK"}],"saleEffectiveDt":"20160808","terminationDt":"20160808","planTypeCD":"1","planClassCD":"Cooling On","saleExpirationDt":"20200818","insuranceProductCd":"108"}]},"AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.premiumBreakdownJSON = '{"Body":{"operation":"Premium Breakdown","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.premiumBreakdownJSON = '{"Body":{"operation":"Premium Breakdown","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.policyChangeLifeJSON='{"Body":{"operation":"Policy Details","transactionId":"11205","status":"1","entity":"AGI","service":"getPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyEffectiveDTTM":"20160727","hasLifePolicyTransactionDetailsIn":[{"transDT":"20160823","transactionStatusCD":" ","processedDttm":"20160823","remark":"remark","transDesc":" ","transTypeCD":" "}],"paymentMethodCD":"DBC","policyRK":" ","policyExpirationDTTM":"20170727","initialLumpsumPremiumAMT":"1000.00","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"20160915","endPremiumHolidayDT":"20160915"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20160727"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"MFC","hasPolicySegmentDetailsIn":[{"sumInsured":"1000.00"}],"planNM":"ASURANSI MANDIRI FAMILY CARE"}],"topupRegularModalPremium":"1000.00","policyStatusCD":"Inforce","terminationDt":"20161027","hasDetailsOfPolicyIn":[{"gdbValue":" ","dividendAmt":"1000.00","futurePremiumDpIntTypeCode":" ","loanRepaymentAmt":"1000.00","futurePremiumDpAmt":"1000.00","loanIntTypeCd":" ","dividendTypeCD":"1040002003189"}],"policyDueDt":"20160727","policyNO":"100-103-0000105","premiumAMT":"1000.00","policyStatusRk":" ","paymentModeCD":"M","ePolicy":"000000000093836","hasDetailsOfRisksIn":[{"insuredID":"123456","hasPersonalDetailsIn":[{"genderCD":"M","hasAddressesIn":[{"emailAddress":"hafizh@gmail.com","mobilePhoneNO":"08124356993011"}],"lastNM":"Rifai","middleNM":"Ahmad","firstNM":"Hafidz","birthPlace":"Bukit Tinggi","birthDT":"19800327"}]}],"sourceChannelCD":"RP","issueDt":"20160727"},{"policyEffectiveDTTM":"20160727","hasLifePolicyTransactionDetailsIn":[{"transDT":"20160823","transactionStatusCD":" ","processedDttm":"20160823","remark":"remark","transDesc":" ","transTypeCD":" "}],"paymentMethodCD":"DBC","policyRK":" ","policyExpirationDTTM":"20170727","initialLumpsumPremiumAMT":"1000.00","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"20160915","endPremiumHolidayDT":"20160915"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20160727"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"MFC","hasPolicySegmentDetailsIn":[{"sumInsured":"1000.00"}],"planNM":"ASURANSI MANDIRI FAMILY CARE"}],"topupRegularModalPremium":"1000.00","policyStatusCD":"Inforce","terminationDt":"20161027","hasDetailsOfPolicyIn":[{"gdbValue":" ","dividendAmt":"1000.00","futurePremiumDpIntTypeCode":" ","loanRepaymentAmt":"1000.00","futurePremiumDpAmt":"1000.00","loanIntTypeCd":" ","dividendTypeCD":"1040002003190"}],"policyDueDt":"20160727","policyNO":"100-103-0000105","premiumAMT":"1000.00","policyStatusRk":" ","paymentModeCD":"M","ePolicy":"000000000093836","hasDetailsOfRisksIn":[{"insuredID":"123456","hasPersonalDetailsIn":[{"genderCD":"M","hasAddressesIn":[{"emailAddress":"hafizh@gmail.com","mobilePhoneNO":"08124356993011"}],"lastNM":"Rifai","middleNM":"Ahmad","firstNM":"Hafidz","birthPlace":"Bukit Tinggi","birthDT":"19800327"}]}],"sourceChannelCD":"RP","issueDt":"20160727"}]},"appID":"DMTM","AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
        policyInfoControllerRLS.policyChangeLifeJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.policyChangeLifeJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.endorsementGIJSON='{"Body":{"operation":"Policy Details","transactionId":"11204","status":"1","entity":"MAGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"021480452","postalCD":"127090","mobilePhoneNO2":"081288888888","emailAddress":"hafidz@gmail.com","faxNO2":"-","addressLine4":"-","emailAddress2":"ahmad.rifai@gmail.com","addressLine3":"-","addressLine2":"-","addressLine1":"Jl. Mampang Prapatan VIII","mobilePhoneNO":"081999999999","telephoneNO2":"-","countyNm":"Indonesia","faxNO":"-","cityNM":"Jakarta"}],"primaryLanguageCd":"Bahasa","occupation":"CEO","passportNo":"8789923647110","nationalityCD":"Indonesian","firstNM":"Hafidz","salutationTxt":"MMM","birthPlace":"Bukit Tinggi","birthDT":"19800327","titleTXT":"Asuransi MMM","maritalStatusCD":"NM","lastNM":"Rifai","individualUniqueID":"99998172","middleNM":"Ahmad","fullNM":"Hafidz Ahmad Rifai"},"customerTypeCD":"-","relatedPolicyholdersCnt":"Uk","hasPolicyAccount":[{"policyEffectiveDTTM":"20161025","issueBranchNM":"Kcp Rawamangun","policyRK":"-","policyExpirationDTTM":"20301025","currencyCD":"IDR","registeredBy":"77777777","hasProducerInformationIn":[{"gaOfficeCD":"MD007","gaOfficeNM":"Mad Dog","gaOfficeDept":"Sales and Marketting"}],"hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"1000000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"full","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Toyota"},{"name":"Model","value":"Mini Bus"},{"name":"Sub Model","value":"Alphard"},{"name":"Year of Manufacturin","value":"2016"},{"name":"License Number","value":"009991"},{"name":"Machine Number","value":"008881"},{"name":"Chasis Number","value":"007771"},{"name":"Type","value":"Automatic"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"White"},{"name":"STNK","value":"09876543"},{"name":"Location","value":"Jakarta"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"Full time","certificateNo":"12","inforceDate":"20161028","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Up","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y","hasPersonalDetailsIn":[{"fullNM":"CAR PROTECTION"}]}],"hasDetailsOfPolicyTransactionIn":[{"transactionTypeDesc":"-","effectiveDTTM":"20161025","intermediaryTypeDesc":"-","referenceDT":"20161025","referenceNO":"1092384765"}],"issueBranchCD":"889","issueDt":"20161025"},{"policyEffectiveDTTM":"20161017","issueBranchNM":"KCP Kuningan City","policyRK":"-","policyExpirationDTTM":"20301027","hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"500000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"1000","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Dodge"},{"name":"Model","value":"SUV"},{"name":"Sub Model","value":"Big SUV"},{"name":"Year of Manufacturin","value":"2015"},{"name":"License Number","value":"11111"},{"name":"Machine Number","value":"22222"},{"name":"Chasis Number","value":"33333"},{"name":"Type","value":"Journey"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"black metallic"},{"name":"STNK","value":"44444"},{"name":"Location","value":"Pondok Gede"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"MLMLM","certificateNo":"55555","inforceDate":"20161027","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Medium","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y"}],"hasDetailsOfPolicyTransactionIn":[{"effectiveDTTM":"20161017","referenceDT":"20161017","referenceNO":"1234567890"}],"issueBranchCD":"8889","issueDt":"20161027"}],"customerClassCD":"Y","hasRelationContact":{"hasAddressesIn":[{"telephoneNO":"081666655555","addressLine1":"Jl. Sigma Raya"}],"fullNM":"Mang Ujang"}},"appID":"PSEA","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.endorsementGIJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.endorsementGIJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.insuredDetailLifeJSON='{"Body":{"operation":"Policy Details","transactionId":"11204","status":"1","entity":"MAGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"021480452","postalCD":"127090","mobilePhoneNO2":"081288888888","emailAddress":"hafidz@gmail.com","faxNO2":"-","addressLine4":"-","emailAddress2":"ahmad.rifai@gmail.com","addressLine3":"-","addressLine2":"-","addressLine1":"Jl. Mampang Prapatan VIII","mobilePhoneNO":"081999999999","telephoneNO2":"-","countyNm":"Indonesia","faxNO":"-","cityNM":"Jakarta"}],"primaryLanguageCd":"Bahasa","occupation":"CEO","passportNo":"8789923647110","nationalityCD":"Indonesian","firstNM":"Hafidz","salutationTxt":"MMM","birthPlace":"Bukit Tinggi","birthDT":"19800327","titleTXT":"Asuransi MMM","maritalStatusCD":"NM","lastNM":"Rifai","individualUniqueID":"99998172","middleNM":"Ahmad","fullNM":"Hafidz Ahmad Rifai"},"customerTypeCD":"-","relatedPolicyholdersCnt":"Uk","hasPolicyAccount":[{"policyEffectiveDTTM":"20161025","issueBranchNM":"Kcp Rawamangun","policyRK":"-","policyExpirationDTTM":"20301025","currencyCD":"IDR","registeredBy":"77777777","hasProducerInformationIn":[{"gaOfficeCD":"MD007","gaOfficeNM":"Mad Dog","gaOfficeDept":"Sales and Marketting"}],"hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"1000000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"full","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Toyota"},{"name":"Model","value":"Mini Bus"},{"name":"Sub Model","value":"Alphard"},{"name":"Year of Manufacturin","value":"2016"},{"name":"License Number","value":"009991"},{"name":"Machine Number","value":"008881"},{"name":"Chasis Number","value":"007771"},{"name":"Type","value":"Automatic"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"White"},{"name":"STNK","value":"09876543"},{"name":"Location","value":"Jakarta"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"Full time","certificateNo":"12","inforceDate":"20161028","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Up","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y","hasPersonalDetailsIn":[{"fullNM":"CAR PROTECTION"}]}],"hasDetailsOfPolicyTransactionIn":[{"transactionTypeDesc":"-","effectiveDTTM":"20161025","intermediaryTypeDesc":"-","referenceDT":"20161025","referenceNO":"1092384765"}],"issueBranchCD":"889","issueDt":"20161025"},{"policyEffectiveDTTM":"20161017","issueBranchNM":"KCP Kuningan City","policyRK":"-","policyExpirationDTTM":"20301027","hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"500000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"1000","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Dodge"},{"name":"Model","value":"SUV"},{"name":"Sub Model","value":"Big SUV"},{"name":"Year of Manufacturin","value":"2015"},{"name":"License Number","value":"11111"},{"name":"Machine Number","value":"22222"},{"name":"Chasis Number","value":"33333"},{"name":"Type","value":"Journey"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"black metallic"},{"name":"STNK","value":"44444"},{"name":"Location","value":"Pondok Gede"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"MLMLM","certificateNo":"55555","inforceDate":"20161027","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Medium","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y"}],"hasDetailsOfPolicyTransactionIn":[{"effectiveDTTM":"20161017","referenceDT":"20161017","referenceNO":"1234567890"}],"issueBranchCD":"8889","issueDt":"20161027"}],"customerClassCD":"Y","hasRelationContact":{"hasAddressesIn":[{"telephoneNO":"081666655555","addressLine1":"Jl. Sigma Raya"}],"fullNM":"Mang Ujang"}},"appID":"PSEA","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.insuredDetailLifeJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.insuredDetailLifeJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.policyDetailLifeJSON='{"Body":{"operation":"Policy Details","transactionId":"11205","status":"1","entity":"AGI","service":"getPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyEffectiveDTTM":"20160727","hasLifePolicyTransactionDetailsIn":[{"transDT":"20160823","transactionStatusCD":" ","processedDttm":"20160823","remark":"remark","transDesc":" ","transTypeCD":" "}],"paymentMethodCD":"DBC","policyRK":" ","policyExpirationDTTM":"20170727","initialLumpsumPremiumAMT":"1000.00","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"20160915","endPremiumHolidayDT":"20160915"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20160727"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"MFC","hasPolicySegmentDetailsIn":[{"sumInsured":"1000.00"}],"planNM":"ASURANSI MANDIRI FAMILY CARE"}],"topupRegularModalPremium":"1000.00","policyStatusCD":"Inforce","terminationDt":"20161027","hasDetailsOfPolicyIn":[{"gdbValue":" ","dividendAmt":"1000.00","futurePremiumDpIntTypeCode":" ","loanRepaymentAmt":"1000.00","futurePremiumDpAmt":"1000.00","loanIntTypeCd":" ","dividendTypeCD":"1040002003189"}],"policyDueDt":"20160727","policyNO":"100-103-0000105","premiumAMT":"1000.00","policyStatusRk":" ","paymentModeCD":"M","ePolicy":"000000000093836","hasDetailsOfRisksIn":[{"insuredID":"123456","hasPersonalDetailsIn":[{"genderCD":"M","hasAddressesIn":[{"emailAddress":"hafizh@gmail.com","mobilePhoneNO":"08124356993011"}],"lastNM":"Rifai","middleNM":"Ahmad","firstNM":"Hafidz","birthPlace":"Bukit Tinggi","birthDT":"19800327"}]}],"sourceChannelCD":"RP","issueDt":"20160727"},{"policyEffectiveDTTM":"20160727","hasLifePolicyTransactionDetailsIn":[{"transDT":"20160823","transactionStatusCD":" ","processedDttm":"20160823","remark":"remark","transDesc":" ","transTypeCD":" "}],"paymentMethodCD":"DBC","policyRK":" ","policyExpirationDTTM":"20170727","initialLumpsumPremiumAMT":"1000.00","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"20160915","endPremiumHolidayDT":"20160915"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20160727"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"MFC","hasPolicySegmentDetailsIn":[{"sumInsured":"1000.00"}],"planNM":"ASURANSI MANDIRI FAMILY CARE"}],"topupRegularModalPremium":"1000.00","policyStatusCD":"Inforce","terminationDt":"20161027","hasDetailsOfPolicyIn":[{"gdbValue":" ","dividendAmt":"1000.00","futurePremiumDpIntTypeCode":" ","loanRepaymentAmt":"1000.00","futurePremiumDpAmt":"1000.00","loanIntTypeCd":" ","dividendTypeCD":"1040002003190"}],"policyDueDt":"20160727","policyNO":"100-103-0000105","premiumAMT":"1000.00","policyStatusRk":" ","paymentModeCD":"M","ePolicy":"000000000093836","hasDetailsOfRisksIn":[{"insuredID":"123456","hasPersonalDetailsIn":[{"genderCD":"M","hasAddressesIn":[{"emailAddress":"hafizh@gmail.com","mobilePhoneNO":"08124356993011"}],"lastNM":"Rifai","middleNM":"Ahmad","firstNM":"Hafidz","birthPlace":"Bukit Tinggi","birthDT":"19800327"}]}],"sourceChannelCD":"RP","issueDt":"20160727"}]},"appID":"DMTM","AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
        policyInfoControllerRLS.policyDetailLifeJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.policyDetailLifeJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        
        policyInfoControllerRLS.riskInfoJSON='{"Body":{"operation":"Policy Details","transactionId":"11204","status":"1","entity":"MAGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"021480452","postalCD":"127090","mobilePhoneNO2":"081288888888","emailAddress":"hafidz@gmail.com","faxNO2":"-","addressLine4":"-","emailAddress2":"ahmad.rifai@gmail.com","addressLine3":"-","addressLine2":"-","addressLine1":"Jl. Mampang Prapatan VIII","mobilePhoneNO":"081999999999","telephoneNO2":"-","countyNm":"Indonesia","faxNO":"-","cityNM":"Jakarta"}],"primaryLanguageCd":"Bahasa","occupation":"CEO","passportNo":"8789923647110","nationalityCD":"Indonesian","firstNM":"Hafidz","salutationTxt":"MMM","birthPlace":"Bukit Tinggi","birthDT":"19800327","titleTXT":"Asuransi MMM","maritalStatusCD":"NM","lastNM":"Rifai","individualUniqueID":"99998172","middleNM":"Ahmad","fullNM":"Hafidz Ahmad Rifai"},"customerTypeCD":"-","relatedPolicyholdersCnt":"Uk","hasPolicyAccount":[{"policyEffectiveDTTM":"20161025","issueBranchNM":"Kcp Rawamangun","policyRK":"-","policyExpirationDTTM":"20301025","currencyCD":"IDR","registeredBy":"77777777","hasProducerInformationIn":[{"gaOfficeCD":"MD007","gaOfficeNM":"Mad Dog","gaOfficeDept":"Sales and Marketting"}],"hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"1000000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"full","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Toyota"},{"name":"Model","value":"Mini Bus"},{"name":"Sub Model","value":"Alphard"},{"name":"Year of Manufacturin","value":"2016"},{"name":"License Number","value":"009991"},{"name":"Machine Number","value":"008881"},{"name":"Chasis Number","value":"007771"},{"name":"Type","value":"Automatic"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"White"},{"name":"STNK","value":"09876543"},{"name":"Location","value":"Jakarta"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"Full time","certificateNo":"12","inforceDate":"20161028","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Up","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y","hasPersonalDetailsIn":[{"fullNM":"CAR PROTECTION"}]}],"hasDetailsOfPolicyTransactionIn":[{"transactionTypeDesc":"-","effectiveDTTM":"20161025","intermediaryTypeDesc":"-","referenceDT":"20161025","referenceNO":"1092384765"}],"issueBranchCD":"889","issueDt":"20161025"},{"policyEffectiveDTTM":"20161017","issueBranchNM":"KCP Kuningan City","policyRK":"-","policyExpirationDTTM":"20301027","hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"500000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"1000","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Dodge"},{"name":"Model","value":"SUV"},{"name":"Sub Model","value":"Big SUV"},{"name":"Year of Manufacturin","value":"2015"},{"name":"License Number","value":"11111"},{"name":"Machine Number","value":"22222"},{"name":"Chasis Number","value":"33333"},{"name":"Type","value":"Journey"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"black metallic"},{"name":"STNK","value":"44444"},{"name":"Location","value":"Pondok Gede"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"MLMLM","certificateNo":"55555","inforceDate":"20161027","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Medium","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y"}],"hasDetailsOfPolicyTransactionIn":[{"effectiveDTTM":"20161017","referenceDT":"20161017","referenceNO":"1234567890"}],"issueBranchCD":"8889","issueDt":"20161027"}],"customerClassCD":"Y","hasRelationContact":{"hasAddressesIn":[{"telephoneNO":"081666655555","addressLine1":"Jl. Sigma Raya"}],"fullNM":"Mang Ujang"}},"appID":"PSEA","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.riskInfoJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.riskInfoJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.ownRiskJSON='{"Body":{"operation":"Policy Details","transactionId":"11204","status":"1","entity":"MAGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"021480452","postalCD":"127090","mobilePhoneNO2":"081288888888","emailAddress":"hafidz@gmail.com","faxNO2":"-","addressLine4":"-","emailAddress2":"ahmad.rifai@gmail.com","addressLine3":"-","addressLine2":"-","addressLine1":"Jl. Mampang Prapatan VIII","mobilePhoneNO":"081999999999","telephoneNO2":"-","countyNm":"Indonesia","faxNO":"-","cityNM":"Jakarta"}],"primaryLanguageCd":"Bahasa","occupation":"CEO","passportNo":"8789923647110","nationalityCD":"Indonesian","firstNM":"Hafidz","salutationTxt":"MMM","birthPlace":"Bukit Tinggi","birthDT":"19800327","titleTXT":"Asuransi MMM","maritalStatusCD":"NM","lastNM":"Rifai","individualUniqueID":"99998172","middleNM":"Ahmad","fullNM":"Hafidz Ahmad Rifai"},"customerTypeCD":"-","relatedPolicyholdersCnt":"Uk","hasPolicyAccount":[{"policyEffectiveDTTM":"20161025","issueBranchNM":"Kcp Rawamangun","policyRK":"-","policyExpirationDTTM":"20301025","currencyCD":"IDR","registeredBy":"77777777","hasProducerInformationIn":[{"gaOfficeCD":"MD007","gaOfficeNM":"Mad Dog","gaOfficeDept":"Sales and Marketting"}],"hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"1000000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"full","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Toyota"},{"name":"Model","value":"Mini Bus"},{"name":"Sub Model","value":"Alphard"},{"name":"Year of Manufacturin","value":"2016"},{"name":"License Number","value":"009991"},{"name":"Machine Number","value":"008881"},{"name":"Chasis Number","value":"007771"},{"name":"Type","value":"Automatic"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"White"},{"name":"STNK","value":"09876543"},{"name":"Location","value":"Jakarta"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"Full time","certificateNo":"12","inforceDate":"20161028","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Up","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y","hasPersonalDetailsIn":[{"fullNM":"CAR PROTECTION"}]}],"hasDetailsOfPolicyTransactionIn":[{"transactionTypeDesc":"-","effectiveDTTM":"20161025","intermediaryTypeDesc":"-","referenceDT":"20161025","referenceNO":"1092384765"}],"issueBranchCD":"889","issueDt":"20161025"},{"policyEffectiveDTTM":"20161017","issueBranchNM":"KCP Kuningan City","policyRK":"-","policyExpirationDTTM":"20301027","hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"500000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"1000","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Dodge"},{"name":"Model","value":"SUV"},{"name":"Sub Model","value":"Big SUV"},{"name":"Year of Manufacturin","value":"2015"},{"name":"License Number","value":"11111"},{"name":"Machine Number","value":"22222"},{"name":"Chasis Number","value":"33333"},{"name":"Type","value":"Journey"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"black metallic"},{"name":"STNK","value":"44444"},{"name":"Location","value":"Pondok Gede"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"MLMLM","certificateNo":"55555","inforceDate":"20161027","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Medium","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y"}],"hasDetailsOfPolicyTransactionIn":[{"effectiveDTTM":"20161017","referenceDT":"20161017","referenceNO":"1234567890"}],"issueBranchCD":"8889","issueDt":"20161027"}],"customerClassCD":"Y","hasRelationContact":{"hasAddressesIn":[{"telephoneNO":"081666655555","addressLine1":"Jl. Sigma Raya"}],"fullNM":"Mang Ujang"}},"appID":"PSEA","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.ownRiskJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.ownRiskJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.interestInfoJSON='{"Body":{"operation":"Policy Details","transactionId":"11204","status":"1","entity":"MAGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"021480452","postalCD":"127090","mobilePhoneNO2":"081288888888","emailAddress":"hafidz@gmail.com","faxNO2":"-","addressLine4":"-","emailAddress2":"ahmad.rifai@gmail.com","addressLine3":"-","addressLine2":"-","addressLine1":"Jl. Mampang Prapatan VIII","mobilePhoneNO":"081999999999","telephoneNO2":"-","countyNm":"Indonesia","faxNO":"-","cityNM":"Jakarta"}],"primaryLanguageCd":"Bahasa","occupation":"CEO","passportNo":"8789923647110","nationalityCD":"Indonesian","firstNM":"Hafidz","salutationTxt":"MMM","birthPlace":"Bukit Tinggi","birthDT":"19800327","titleTXT":"Asuransi MMM","maritalStatusCD":"NM","lastNM":"Rifai","individualUniqueID":"99998172","middleNM":"Ahmad","fullNM":"Hafidz Ahmad Rifai"},"customerTypeCD":"-","relatedPolicyholdersCnt":"Uk","hasPolicyAccount":[{"policyEffectiveDTTM":"20161025","issueBranchNM":"Kcp Rawamangun","policyRK":"-","policyExpirationDTTM":"20301025","currencyCD":"IDR","registeredBy":"77777777","hasProducerInformationIn":[{"gaOfficeCD":"MD007","gaOfficeNM":"Mad Dog","gaOfficeDept":"Sales and Marketting"}],"hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"1000000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"full","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Toyota"},{"name":"Model","value":"Mini Bus"},{"name":"Sub Model","value":"Alphard"},{"name":"Year of Manufacturin","value":"2016"},{"name":"License Number","value":"009991"},{"name":"Machine Number","value":"008881"},{"name":"Chasis Number","value":"007771"},{"name":"Type","value":"Automatic"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"White"},{"name":"STNK","value":"09876543"},{"name":"Location","value":"Jakarta"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"Full time","certificateNo":"12","inforceDate":"20161028","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Up","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y","hasPersonalDetailsIn":[{"fullNM":"CAR PROTECTION"}]}],"hasDetailsOfPolicyTransactionIn":[{"transactionTypeDesc":"-","effectiveDTTM":"20161025","intermediaryTypeDesc":"-","referenceDT":"20161025","referenceNO":"1092384765"}],"issueBranchCD":"889","issueDt":"20161025"},{"policyEffectiveDTTM":"20161017","issueBranchNM":"KCP Kuningan City","policyRK":"-","policyExpirationDTTM":"20301027","hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"500000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"1000","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Dodge"},{"name":"Model","value":"SUV"},{"name":"Sub Model","value":"Big SUV"},{"name":"Year of Manufacturin","value":"2015"},{"name":"License Number","value":"11111"},{"name":"Machine Number","value":"22222"},{"name":"Chasis Number","value":"33333"},{"name":"Type","value":"Journey"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"black metallic"},{"name":"STNK","value":"44444"},{"name":"Location","value":"Pondok Gede"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"MLMLM","certificateNo":"55555","inforceDate":"20161027","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Medium","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y"}],"hasDetailsOfPolicyTransactionIn":[{"effectiveDTTM":"20161017","referenceDT":"20161017","referenceNO":"1234567890"}],"issueBranchCD":"8889","issueDt":"20161027"}],"customerClassCD":"Y","hasRelationContact":{"hasAddressesIn":[{"telephoneNO":"081666655555","addressLine1":"Jl. Sigma Raya"}],"fullNM":"Mang Ujang"}},"appID":"PSEA","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.interestInfoJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.interestInfoJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.assNotesSummaryUWJSON='';
        policyInfoControllerRLS.assNotesJSON='';
        
        policyInfoControllerRLS.cashValueDetailJSON='{"Body":{"operation":"Policy Details","transactionId":"11205","status":"1","entity":"AGI","service":"getPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyEffectiveDTTM":"20160727","hasLifePolicyTransactionDetailsIn":[{"transDT":"20160823","transactionStatusCD":" ","processedDttm":"20160823","remark":"remark","transDesc":" ","transTypeCD":" "}],"paymentMethodCD":"DBC","policyRK":" ","policyExpirationDTTM":"20170727","initialLumpsumPremiumAMT":"1000.00","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"20160915","endPremiumHolidayDT":"20160915"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20160727"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"MFC","hasPolicySegmentDetailsIn":[{"sumInsured":"1000.00"}],"planNM":"ASURANSI MANDIRI FAMILY CARE"}],"topupRegularModalPremium":"1000.00","policyStatusCD":"Inforce","terminationDt":"20161027","hasDetailsOfPolicyIn":[{"gdbValue":" ","dividendAmt":"1000.00","futurePremiumDpIntTypeCode":" ","loanRepaymentAmt":"1000.00","futurePremiumDpAmt":"1000.00","loanIntTypeCd":" ","dividendTypeCD":"1040002003189"}],"policyDueDt":"20160727","policyNO":"100-103-0000105","premiumAMT":"1000.00","policyStatusRk":" ","paymentModeCD":"M","ePolicy":"000000000093836","hasDetailsOfRisksIn":[{"insuredID":"123456","hasPersonalDetailsIn":[{"genderCD":"M","hasAddressesIn":[{"emailAddress":"hafizh@gmail.com","mobilePhoneNO":"08124356993011"}],"lastNM":"Rifai","middleNM":"Ahmad","firstNM":"Hafidz","birthPlace":"Bukit Tinggi","birthDT":"19800327"}]}],"sourceChannelCD":"RP","issueDt":"20160727"},{"policyEffectiveDTTM":"20160727","hasLifePolicyTransactionDetailsIn":[{"transDT":"20160823","transactionStatusCD":" ","processedDttm":"20160823","remark":"remark","transDesc":" ","transTypeCD":" "}],"paymentMethodCD":"DBC","policyRK":" ","policyExpirationDTTM":"20170727","initialLumpsumPremiumAMT":"1000.00","hasLifePolicyChangeTransDetailsIn":[{"startPremiumHolidayDT":"20160915","endPremiumHolidayDT":"20160915"}],"hasApplicationDetailsIn":[{"applicationDTTM":"20160727"}],"isAssociatedWithLifeInsuranceProduct":[{"planCd":"MFC","hasPolicySegmentDetailsIn":[{"sumInsured":"1000.00"}],"planNM":"ASURANSI MANDIRI FAMILY CARE"}],"topupRegularModalPremium":"1000.00","policyStatusCD":"Inforce","terminationDt":"20161027","hasDetailsOfPolicyIn":[{"gdbValue":" ","dividendAmt":"1000.00","futurePremiumDpIntTypeCode":" ","loanRepaymentAmt":"1000.00","futurePremiumDpAmt":"1000.00","loanIntTypeCd":" ","dividendTypeCD":"1040002003190"}],"policyDueDt":"20160727","policyNO":"100-103-0000105","premiumAMT":"1000.00","policyStatusRk":" ","paymentModeCD":"M","ePolicy":"000000000093836","hasDetailsOfRisksIn":[{"insuredID":"123456","hasPersonalDetailsIn":[{"genderCD":"M","hasAddressesIn":[{"emailAddress":"hafizh@gmail.com","mobilePhoneNO":"08124356993011"}],"lastNM":"Rifai","middleNM":"Ahmad","firstNM":"Hafidz","birthPlace":"Bukit Tinggi","birthDT":"19800327"}]}],"sourceChannelCD":"RP","issueDt":"20160727"}]},"appID":"DMTM","AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
        policyInfoControllerRLS.cashValueDetailJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.cashValueDetailJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.policyDetailGIJSON='{"Body":{"operation":"Policy Details","transactionId":"11204","status":"1","entity":"MAGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"021480452","postalCD":"127090","mobilePhoneNO2":"081288888888","emailAddress":"hafidz@gmail.com","faxNO2":"-","addressLine4":"-","emailAddress2":"ahmad.rifai@gmail.com","addressLine3":"-","addressLine2":"-","addressLine1":"Jl. Mampang Prapatan VIII","mobilePhoneNO":"081999999999","telephoneNO2":"-","countyNm":"Indonesia","faxNO":"-","cityNM":"Jakarta"}],"primaryLanguageCd":"Bahasa","occupation":"CEO","passportNo":"8789923647110","nationalityCD":"Indonesian","firstNM":"Hafidz","salutationTxt":"MMM","birthPlace":"Bukit Tinggi","birthDT":"19800327","titleTXT":"Asuransi MMM","maritalStatusCD":"NM","lastNM":"Rifai","individualUniqueID":"99998172","middleNM":"Ahmad","fullNM":"Hafidz Ahmad Rifai"},"customerTypeCD":"-","relatedPolicyholdersCnt":"Uk","hasPolicyAccount":[{"policyEffectiveDTTM":"20161025","issueBranchNM":"Kcp Rawamangun","policyRK":"-","policyExpirationDTTM":"20301025","currencyCD":"IDR","registeredBy":"77777777","hasProducerInformationIn":[{"gaOfficeCD":"MD007","gaOfficeNM":"Mad Dog","gaOfficeDept":"Sales and Marketting"}],"hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"1000000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"full","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Toyota"},{"name":"Model","value":"Mini Bus"},{"name":"Sub Model","value":"Alphard"},{"name":"Year of Manufacturin","value":"2016"},{"name":"License Number","value":"009991"},{"name":"Machine Number","value":"008881"},{"name":"Chasis Number","value":"007771"},{"name":"Type","value":"Automatic"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"White"},{"name":"STNK","value":"09876543"},{"name":"Location","value":"Jakarta"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"Full time","certificateNo":"12","inforceDate":"20161028","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Up","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y","hasPersonalDetailsIn":[{"fullNM":"CAR PROTECTION"}]}],"hasDetailsOfPolicyTransactionIn":[{"transactionTypeDesc":"-","effectiveDTTM":"20161025","intermediaryTypeDesc":"-","referenceDT":"20161025","referenceNO":"1092384765"}],"issueBranchCD":"889","issueDt":"20161025"},{"policyEffectiveDTTM":"20161017","issueBranchNM":"KCP Kuningan City","policyRK":"-","policyExpirationDTTM":"20301027","hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"500000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"1000","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Dodge"},{"name":"Model","value":"SUV"},{"name":"Sub Model","value":"Big SUV"},{"name":"Year of Manufacturin","value":"2015"},{"name":"License Number","value":"11111"},{"name":"Machine Number","value":"22222"},{"name":"Chasis Number","value":"33333"},{"name":"Type","value":"Journey"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"black metallic"},{"name":"STNK","value":"44444"},{"name":"Location","value":"Pondok Gede"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"MLMLM","certificateNo":"55555","inforceDate":"20161027","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Medium","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y"}],"hasDetailsOfPolicyTransactionIn":[{"effectiveDTTM":"20161017","referenceDT":"20161017","referenceNO":"1234567890"}],"issueBranchCD":"8889","issueDt":"20161027"}],"customerClassCD":"Y","hasRelationContact":{"hasAddressesIn":[{"telephoneNO":"081666655555","addressLine1":"Jl. Sigma Raya"}],"fullNM":"Mang Ujang"}},"appID":"PSEA","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.policyDetailGIJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.policyDetailGIJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.TOCJSON='{"Body":{"operation":"Policy Details","transactionId":"11204","status":"1","entity":"MAGI","service":"getGIPolicyDetail","IcAx_AXAAsiaCustomer_Type":{"canBeIndividual":{"genderCD":"M","hasAddressesIn":[{"telephoneNO":"021480452","postalCD":"127090","mobilePhoneNO2":"081288888888","emailAddress":"hafidz@gmail.com","faxNO2":"-","addressLine4":"-","emailAddress2":"ahmad.rifai@gmail.com","addressLine3":"-","addressLine2":"-","addressLine1":"Jl. Mampang Prapatan VIII","mobilePhoneNO":"081999999999","telephoneNO2":"-","countyNm":"Indonesia","faxNO":"-","cityNM":"Jakarta"}],"primaryLanguageCd":"Bahasa","occupation":"CEO","passportNo":"8789923647110","nationalityCD":"Indonesian","firstNM":"Hafidz","salutationTxt":"MMM","birthPlace":"Bukit Tinggi","birthDT":"19800327","titleTXT":"Asuransi MMM","maritalStatusCD":"NM","lastNM":"Rifai","individualUniqueID":"99998172","middleNM":"Ahmad","fullNM":"Hafidz Ahmad Rifai"},"customerTypeCD":"-","relatedPolicyholdersCnt":"Uk","hasPolicyAccount":[{"policyEffectiveDTTM":"20161025","issueBranchNM":"Kcp Rawamangun","policyRK":"-","policyExpirationDTTM":"20301025","currencyCD":"IDR","registeredBy":"77777777","hasProducerInformationIn":[{"gaOfficeCD":"MD007","gaOfficeNM":"Mad Dog","gaOfficeDept":"Sales and Marketting"}],"hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"1000000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"full","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Toyota"},{"name":"Model","value":"Mini Bus"},{"name":"Sub Model","value":"Alphard"},{"name":"Year of Manufacturin","value":"2016"},{"name":"License Number","value":"009991"},{"name":"Machine Number","value":"008881"},{"name":"Chasis Number","value":"007771"},{"name":"Type","value":"Automatic"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"White"},{"name":"STNK","value":"09876543"},{"name":"Location","value":"Jakarta"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"Full time","certificateNo":"12","inforceDate":"20161028","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Up","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y","hasPersonalDetailsIn":[{"fullNM":"CAR PROTECTION"}]}],"hasDetailsOfPolicyTransactionIn":[{"transactionTypeDesc":"-","effectiveDTTM":"20161025","intermediaryTypeDesc":"-","referenceDT":"20161025","referenceNO":"1092384765"}],"issueBranchCD":"889","issueDt":"20161025"},{"policyEffectiveDTTM":"20161017","issueBranchNM":"KCP Kuningan City","policyRK":"-","policyExpirationDTTM":"20301027","hasDetailsOfGIRisksIn":[{"otherBenefit":[{"benefitDESC":"-","benefitAMT":"500000000"}],"deductibleName":"-","coverageEndDT":"2030","coverageRk":"1000","coverageParam":[{"name":"Table No","value":"1"},{"name":"Vehicle Brand","value":"Dodge"},{"name":"Model","value":"SUV"},{"name":"Sub Model","value":"Big SUV"},{"name":"Year of Manufacturin","value":"2015"},{"name":"License Number","value":"11111"},{"name":"Machine Number","value":"22222"},{"name":"Chasis Number","value":"33333"},{"name":"Type","value":"Journey"},{"name":"Function","value":"Personal Car"},{"name":"Colour","value":"black metallic"},{"name":"STNK","value":"44444"},{"name":"Location","value":"Pondok Gede"}]}],"hasGIPolicyEndorsementIn":[{"endorsementRk":"-","contractType":"MLMLM","certificateNo":"55555","inforceDate":"20161027","typeDesc":"-"}],"policyNO":"100-103-0000104","policySegment":"Medium","premiumAMT":"Y","hasAccountDetailsIn":[{"usageCd":"-"}],"generalRk":"-","isAssociatedWithGIInsuranceProduct":[{"hasGIPolicySegmentDetailsIn":[{"sumInsured":"-"}]}],"hasDetailsOfRisksIn":[{"insuredID":"Y"}],"hasDetailsOfPolicyTransactionIn":[{"effectiveDTTM":"20161017","referenceDT":"20161017","referenceNO":"1234567890"}],"issueBranchCD":"8889","issueDt":"20161027"}],"customerClassCD":"Y","hasRelationContact":{"hasAddressesIn":[{"telephoneNO":"081666655555","addressLine1":"Jl. Sigma Raya"}],"fullNM":"Mang Ujang"}},"appID":"PSEA","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.TOCJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.TOCJSON = '{"Body":{"operation":"Policy Details","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.accountDetailJSON='{"Body":{"operation":"Customer Profile","transactionId":"1234","status":"1","entity":"AGI","service":"getCustomerInfo","IcAx_AXAAsiaCustomer_Type":{"processedDttm":"2016-10-28T19:14:05","canBeIndividual":{"genderCD":"F","hasAddressesIn":[{"addressLine4":"Indonesia Raya","addressLine3":"Indonesia","addressLine2":"jakarta selatan","addressLine1":"kebayoran baru"}],"birthPlace":"Jakarta","birthDT":"19800327"},"hasPolicyAccount":[{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{"payorLastNM":"Bagus","branchCD":"Jakarta","rejectCD":"A1","accountEffectiveDT":"20100727","accountTypeCD":"1040002003189","accountStatusCD":"active","bankName":"Mandiri","accountNO":"104000200318","accountExpirationDT":"20150727","rejectDT":"20161026","payorFirstNM":"Bagus"}},"servicingCD":"000373","producingCD":"0003737"}],"policyNO":"100-103-0000038"},{"hasPartyDetailsIn":[{"canBeIndividual":{"hasPartyAccountDetailsIn":{"payorLastNM":"Bagus","branchCD":"Jakarta","rejectCD":"A1","accountEffectiveDT":"20100727","accountTypeCD":"1040002003189","accountStatusCD":"active","bankName":"Mandiri","accountNO":"104000200318","accountExpirationDT":"20150727","rejectDT":"20161026","payorFirstNM":"Bagus"}},"servicingCD":"000373","producingCD":"0003737"}],"policyNO":"100-103-0000038"}],"customerID":"000000000093836"},"appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":""}}}';
        policyInfoControllerRLS.accountDetailJSON = '{"Body":{"operation":"Customer Profile","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.accountDetailJSON = '{"Body":{"operation":"Customer Profile","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.agentInfoJSON='{"Body":{"operation":"Agent Info","transactionId":"1238","status":"1","entity":"AGI","service":"getAgentInfo","appID":"RLS","AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"},"AgSa_InsurancePolicy_Type":{"hasPartyDetailsIn":[{"canBeInternalOrg":{"orgShortNm":"AM"},"branchCD":"Jakarta","partyCD":"1231","effNominationDT":"20100727","canBeIndividual":{"hasAddressesIn":[{"telephoneNO":"02142881238","telephoneNO2":"02159761118","emailAddress":"annisa@mii.co.id","mobilePhoneNO":"081284522298","officeTelNo":"02179834518"}],"distributionType":"1","terminationDt":"20200727","lastNM":"Annisa","middleNM":"Annisa","distributionCD":"0000000088","firstNM":"Annisa","effectiveNominationDT":"20100727"},"parentPartyCD":"10521","partyID":"0B31200","partyNO":"1001030000038","termRk":"term-123","partyStatus":"Terminate"},{"canBeInternalOrg":{"orgShortNm":"AM"},"branchCD":"Jakarta","partyCD":"1232","effNominationDT":"20100727","canBeIndividual":{"hasAddressesIn":[{"telephoneNO":"02142881238","telephoneNO2":"02159761118","emailAddress":"annisa@mii.co.id","mobilePhoneNO":"081284522298","officeTelNo":"02179834518"}],"distributionType":"1","terminationDt":"20200727","lastNM":"Annisa","middleNM":"Annisa","distributionCD":"0000000088","firstNM":"Annisa","effectiveNominationDT":"20100727"},"parentPartyCD":"10522","partyID":"0B31200","partyNO":"1001030000038","termRk":"term-123","partyStatus":"Terminate"}]}}}';
        policyInfoControllerRLS.agentInfoJSON = '{"Body":{"operation":"Agent Info","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.agentInfoJSON = '{"Body":{"operation":"Agent Info","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        //policyInfoControllerRLS.agentReportingStructureHierarchyJSON='';
        policyInfoControllerRLS.assNotesJSON='{"Body":{"operation":"Summary","transactionId":"25d5bbde-ad03-9e79-f6d3-f552c8edb7a6","status":"1","entity":"AGI","service":"getAssNotes","appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"},"AgSa_InsurancePolicy_Type":{"policyNO":"515-3881890","hasPolicyAssessmentDetailsIn":[{"assmtSection":"UW ","assmtStatus":"  ","assessmentClassType":"UW ","assmtRemark":"       ","assmtRefNo":"0000000","assmtTypeCd":"       ","lastUpdDTTM":"20150227145623"}]}}}';
        policyInfoControllerRLS.assNotesJSON='{"Body":{"operation":"Detail","transactionId":"50c2b958-0db2-9e00-dd65-1feb6bc038c1","status":"1","entity":"AGI","service":"getAssNotes","appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"},"AgSa_InsurancePolicy_Type":{"hasPolicyAssessmentDetailsIn":[{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL03    ","assessmentClassType":"OTH","assmtDesc":"8191/hani/suci010102/status polis,tgl issued,saldo:12824368.87             \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20180806162753"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCDRE   ","assessmentClassType":"OTH","assmtDesc":"ext : 31024/sari/ pp ask sts claim RI, infokan masih proses investigasi. pp\nmemnta di segerakan, ccc bantu email team claim done.                       \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00002","assmtTypeCd":"     ","lastUpdDTTM":"20170405110113"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCESN   ","assessmentClassType":"OTH","assmtDesc":"31016/eisy / 000765560218/ verif ok pp ask claim Ri ; infokan ;            \nKESIMPULAN                   : Pending/Klaim masih membutuhkan informasi    \ntambahan dari RS untuk data PEC. Klaim di refer ke Claim Investigator   ;   \npp kecewa karna proses lama ; infokan maks mngu 60 hari dan telp diutup     \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00004","assmtTypeCd":"     ","lastUpdDTTM":"20170330092649"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCCIL   ","assessmentClassType":"OTH","assmtDesc":"31015/cindy/000765598791/ verif oke, ask sts claim RI, infokan masih dlm   \nproses investigasi, sggst pp wait 14-60 HK, pp kecewa proses lama ingn      \najukan ure saja, infokan rsikonya jika pp ttup polis                        \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00003","assmtTypeCd":"     ","lastUpdDTTM":"20170329115548"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCRUA   ","assessmentClassType":"OTH","assmtDesc":"31054 / ruslan / 000765560218 / verif ok, pp ask claim rinap , masih proses\ninvest                                                                      \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00002","assmtTypeCd":"     ","lastUpdDTTM":"20170321101720"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCRUA   ","assessmentClassType":"OTH","assmtDesc":"31054 / ruslan / 000765560218 / verif ok, pp ask claim rinap, cek masih    \n31054 / ruslan / 000765560218 / verif ok, pp ask claim rinap, cek masih     \nproses invest, suggest wait 60hk                                            \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00002","assmtTypeCd":"     ","lastUpdDTTM":"20170314125511"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL13    ","assessmentClassType":"OTH","assmtDesc":"8194 / desi / dini fa 013196 / search by name, ask claim hosp pending,     \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20170314124348"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCLAP   ","assessmentClassType":"OTH","assmtDesc":"31003//Aprillia//000765560218// pp ask CLM RI // Cek clm RI : proses invest\n// sla 60hk                                                                 \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00002","assmtTypeCd":"     ","lastUpdDTTM":"20170223141932"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL39    ","assessmentClassType":"OTH","assmtDesc":"8193/tya/ mita 010206 / ask histy debet,                                   \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20160118121549"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL42    ","assessmentClassType":"OTH","assmtDesc":"8162/ lutfi / mita 10206 ask hist debet                                    \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20160115143607"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL28    ","assessmentClassType":"OTH","assmtDesc":"8270 / ayu / shara 010206 / hist debet,                                    \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20160113103137"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL47    ","assessmentClassType":"OTH","assmtDesc":"8061 / dewi / shara 010206 / pendebetan, ptd,                              \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20151218092643"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL03    ","assessmentClassType":"OTH","assmtDesc":"8261/ aisah/ shara 010206/ history debet                                   \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20151109135153"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL29    ","assessmentClassType":"OTH","assmtDesc":"8286 / dila / shara 010206 ask / pndbtn , clm ok , ptd                     \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20151005142613"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCAAM   ","assessmentClassType":"OTH","assmtDesc":"813                                                                        \n6/n anggi/ sarab 010206/ ask clm approve                                    \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00002","assmtTypeCd":"     ","lastUpdDTTM":"20151002140548"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL16    ","assessmentClassType":"OTH","assmtDesc":"8375 adi/shara 010206/clm ri approve 28/9/2015                             \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150929134234"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL47    ","assessmentClassType":"OTH","assmtDesc":"8160/ yani/ shara 010206 / clm hosp, dok. dtrima tgl 25/9/2015             \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150928102923"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCSYA   ","assessmentClassType":"OTH","assmtDesc":"8155 / ayu / shara 010206 / info proses claim                              \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150925102431"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL11    ","assessmentClassType":"OTH","assmtDesc":"8176/ tiara/ shara 10206/ info polis/                                      \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150907095724"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL01    ","assessmentClassType":"OTH","assmtDesc":"sinta/fa sara/bp msh proses krm                                            \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150316121311"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL10    ","assessmentClassType":"OTH","assmtDesc":"winda\\shara\\bupol                                                          \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150304081333"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL27    ","assessmentClassType":"OTH","assmtDesc":"putri/fa dedinb pending                                                    \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150227135406"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL05    ","assessmentClassType":"OTH","assmtDesc":"lia/ fa dedi/ pending nb                                                   \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150226122450"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL21    ","assessmentClassType":"OTH","assmtDesc":"via / fa dedi / status nb pending info                                     \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150225145538"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL31    ","assessmentClassType":"OTH","assmtDesc":"dian, fa dedy, nb pending                                                  \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150224163735"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL03    ","assessmentClassType":"OTH","assmtDesc":"dairy / fa shara / buat laporan                                            \nmohon urgent untuk hard copy pendingan sudah di kirimkan dan di terima per  \ntgl 20 februari 2015 namun belum ter imaging di prescreaning mohon di bantu \nlaporan thk                                                                 \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00004","assmtTypeCd":"     ","lastUpdDTTM":"20150224152755"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL03    ","assessmentClassType":"OTH","assmtDesc":"dairy / fa shara/ buat laporan                                             \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150224152727"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL40    ","assessmentClassType":"OTH","assmtDesc":"dwi/fa shara/ nb : info pending                                            \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150224091138"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILCCTKA   ","assessmentClassType":"OTH","assmtDesc":"yudia,fa shara ask: pending nb                                             \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150223090500"},{"assmtSection":"OTH","assmtStatus":"          ","lastUpdBy":"ILHL05    ","assessmentClassType":"OTH","assmtDesc":"lia/ fa sara/ pending nb                                                   \n","assmtRemark":"00000000000000","assmtRefNo":"0000000","assmtNo":"00001","assmtTypeCd":"     ","lastUpdDTTM":"20150220134648"}]}}}';
        
        
        policyInfoControllerRLS.paymentHistoryLifeJSON='{"Body":{"operation":"Payment","transactionId":"1238","status":"1","entity":"AGI","service":"getPaymentHistory","appID":"RLS","AgSa_InsurancePolicy_Type":{"hasLifePolicyTransactionDetailsIn":[{"transDT":"20160827","paymentDueDT":"20160830","paymentMethodCd":"autodebet","settledAMT":"5000000","paymentTypeCD":"transfer","settledDT":"20160828"},{"transDT":"20160827","paymentDueDT":"20160830","paymentMethodCd":"creditCard","settledAMT":"7700000","paymentTypeCD":"transfer","settledDT":"20160828"}],"policyNO":"100-103-0000038"},"AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.paymentHistoryLifeJSON = '{"Body":{"operation":"Payment","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.paymentHistoryLifeJSON = '{"Body":{"operation":"Payment","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.paymentHistoryGIJSON='{"Body":{"operation":"Fund","transactionId":"1236","status":"1","entity":"AGI","service":"getFundHistory","appID":"RLS","AgSa_InsurancePolicy_Type":{"hasLifePolicyTransactionDetailsIn":[{"totalUnits":"11","transDT":"20160801","unitValuationDT":"20160801","transModeCD":"Mode","settledAMT":"28000000","unitPriceAsOfDt":"100","transDesc":"fund transaction","settledDT":"20160802","transTypeCD":"Type","unitValue":"1000000","key":"12822"},{"totalUnits":"11","transDT":"20160801","unitValuationDT":"20160801","transModeCD":"Mode","settledAMT":"28000000","unitPriceAsOfDt":"200","transDesc":"fund transaction","settledDT":"20160802","transTypeCD":"Type","unitValue":"1000000","key":"12821"}],"policyNO":"100-103-0000036","hasAccountDetailsIn":[{"hasInvestmentFundDetailsIn":[{"investmentFundCd":"12821"}]},{"hasInvestmentFundDetailsIn":[{"investmentFundCd":"12822"}]}]},"AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.paymentHistoryGIJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.paymentHistoryGIJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.fundHistoryJSON='{"Body":{"operation":"Fund","transactionId":"1237","status":"1","entity":"AGI","service":"getFundDetail","appID":"RLS","AgSa_InsurancePolicy_Type":{"policyNO":"100-103-0000037","hasAccountDetailsIn":[{"hasInvestmentFundDetailsIn":[{"totalUnits":"800000000","fundAllocation":"100","totalFundAmount":"8800000000","investmentFundCd":"881","unitPrice":"8000000","navDt":"20160828"}]},{"hasInvestmentFundDetailsIn":[{"totalUnits":"800000000","fundAllocation":"100","totalFundAmount":"8800000000","investmentFundCd":"888","unitPrice":"9900000","navDt":"20160828"}]}]},"AXAAsiaPagination_Type":{"rowPerPage":"","numberOfRecords":"2","startDateTime":"","pageNumber":"","endDateTime":"","startOfRecords":"1"}}}';
        policyInfoControllerRLS.fundHistoryJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.fundHistoryJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.fundDetailJSON='{"Body":{"operation":"Fund","transactionId":"12345","status":"","entity":"AGI","service":"getProductFundDetail","appID":"RLS","AgSa_InsurancePolicy_Type":{"policyNO":"100-104-1100068","hasAccountDetailsIn":[{"hasInvestmentFundDetailsIn":[{"investmentFundRk":"Anjay","fundCurrencyCd":"IDR","valuationDt":"20161010","investmentFundCd":"999","unitPrice":"100.00","unitPriceAsOfDt":"1500.00"},{"investmentFundRk":"Uhuy","fundCurrencyCd":"IDR","valuationDt":"20161110","investmentFundCd":"999","unitPrice":"200.00","unitPriceAsOfDt":"2500.00"}]}]},"AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
        policyInfoControllerRLS.fundDetailJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.fundDetailJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.fundPriceHistoryJSON='{"Body":{"operation":"Fund","transactionId":"12345","status":"","entity":"AGI","service":"getProductFundDetail","appID":"RLS","AgSa_InsurancePolicy_Type":{"policyNO":"100-104-1100068","hasAccountDetailsIn":[{"hasInvestmentFundDetailsIn":[{"investmentFundRk":"Anjay","fundCurrencyCd":"IDR","valuationDt":"20161010","investmentFundCd":"999","unitPrice":"100.00","unitPriceAsOfDt":"1500.00"},{"investmentFundRk":"Uhuy","fundCurrencyCd":"IDR","valuationDt":"20161110","investmentFundCd":"999","unitPrice":"200.00","unitPriceAsOfDt":"2500.00"}]}]},"AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
        policyInfoControllerRLS.fundPriceHistoryJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.fundPriceHistoryJSON = '{"Body":{"operation":"Fund","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.claimDetailLifeJSON='{"Body":{"operation":"Claim","transactionId":"123432","status":"1","entity":"AGI","service":"getClaimDetail","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"hasDetailsOfClaimIn":[{"claimOpenDTTM":"20160110","hasClaimUnitIn":[{"claimRK":"Ok","claimedAMT":"1000.00","claimUnitRK":"-"}],"claimReferenceID":"CL03.08.08.0249","claimTypeCd":"DR","claimApprovalDTTM":"20160110","claimRk":"Death Resuurection","claimStatusCD":"Accept"}],"policyNO":"100-103-0000031","isAssociatedWithLifeInsuranceProduct":[{"productTypeCD":"06"}]},{"hasDetailsOfClaimIn":[{"claimOpenDTTM":"20160110","hasClaimUnitIn":[{"claimRK":"ok","claimedAMT":"8000.00","claimUnitRK":"-"}],"claimReferenceID":"CL04.10.08.0249","claimTypeCd":"Car Accident","claimApprovalDTTM":"20160110","claimRk":"CA","claimStatusCD":"Accept"}],"policyNO":"100-103-0000031","isAssociatedWithLifeInsuranceProduct":[{"productTypeCD":"07"}]}]},"appID":"DMTM","AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
        policyInfoControllerRLS.claimDetailLifeJSON = '{"Body":{"operation":"Claim","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.claimDetailLifeJSON = '{"Body":{"operation":"Claim","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';

        policyInfoControllerRLS.claimDetailGIJSON='{"Body":{"operation":"Claim","transactionId":"55571","status":"1","entity":"MAGI","service":"getGIClaimDetail","appID":"CARE","AgSa_InsurancePolicy_Type":{"hasPnCClaimIn":[{"claimPaymentDate":"20160110","claimStatusDesc":"Accept","hasMotorClaim":{"repairShop":"Magic Punch Shop","hasMotorClaimDriverDetails":{"canBeIndividual":{"lastNM":"Tauladan","middleNM":"Suri","firstNM":"Morgan"}},"hasClaimAccidentDetails":{"accidentPlace":"Ujung Kulon"}},"hasClaimPartyRole":[{"canBeIndividual":{"lastNM":"Salsabiela","middleNM":"Husada","firstNM":"Sari"}}],"description":"-","notificationDate":"20160110","claimOpenDate":"20160110","approvalPaymentDate":"20160110","lossDate":"20160110","branchCode":"0008","claimNumber":"CL02.08.08.0249"},{"claimPaymentDate":"20160110","claimStatusDesc":"Accept","hasMotorClaim":{"repairShop":"Ketok Magic Sendjaja","hasMotorClaimDriverDetails":{"canBeIndividual":{"lastNM":"Suminem","middleNM":"Suminem","firstNM":"Suminem"}},"hasClaimAccidentDetails":{"accidentPlace":"Rawangmangun"}},"hasClaimPartyRole":[{"canBeIndividual":{"lastNM":"Quraina","middleNM":"Indah","firstNM":"Sari"}}],"description":" ","notificationDate":"20160110","claimOpenDate":"20160110","approvalPaymentDate":"20160110","lossDate":"20160110","branchCode":"008","claimNumber":"CL04.10.08.0250"}],"policyNO":"100-103-0000042"},"AXAAsiaPagination_Type":{"rowPerPage":"15","numberOfRecords":"2","startDateTime":"2016-08-16 14:43:00","pageNumber":"1","endDateTime":"2016-08-17 14:45:00","startOfRecords":"1"}}}';
        policyInfoControllerRLS.claimDetailGIJSON = '{"Body":{"operation":"Claim","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"0","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"280002"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
        policyInfoControllerRLS.claimDetailGIJSON = '{"Body":{"operation":"Claim","transactionId":"1b0bf455-8631-1cbd-726d-7029af3502d3","status":"-1","exception":{"message":"Response Not Available","backEndError":"(RET\u003dX) Data not found","code":"28"},"entity":"AGI","service":"getClaimDetails","IcAx_AXAAsiaCustomer_Type":{"hasPolicyAccount":[{"policyNO":"815-5142022"}]},"appID":"RLS","AXAAsiaPagination_Type":{"numberOfRecords":"100","pageNumber":"1","startOfRecords":"1"}}}';
		
        //policyInfoControllerRLS.getEIPPolicyDetailList();
        policyInfoControllerRLS.getEIPPolicyChangeList();
        policyInfoControllerRLS.getEIPBenefitDetailList();
        policyInfoControllerRLS.getEIPPremiumBreakdownList();
        policyInfoControllerRLS.getEIPRiskDetailList();
        policyInfoControllerRLS.getEIPClaimDetailList();
        policyInfoControllerRLS.getInsuredDetailList();
        
		PageReference pageRef = Page.PolicyInfoPage;
        Test.setCurrentPage(pageRef);

        Test.stopTest();
    }

    public static testMethod void testPage() {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        
        Contact conRLS = new Contact();
        conRLS.RecordTypeId = rtId;
        conRLS.LastName = '123';
        conRLS.FirstName = 'Testing';
        conRLS.Policy_No__c = '515-3881890';
        conRLS.PolicyApp__c = 'PSEA';
        conRLS.Insured_Name__c = 'Frys4';
        conRLS.Entity__c = 'AGI';
        conRLS.Email = 'testing123@gmail.com';
        conRLS.MobilePhone = '085657585950';
        //lst_contact.add(conRLS);
        ApexPages.StandardController stdContrl1 = new ApexPages.StandardController(conRLS);              
        PolicyInfoAGIController policyInfoControllerRLS = new PolicyInfoAGIController(stdContrl1);
        
        PageReference pageRef = Page.PolicyInfoPage;
        Test.setCurrentPage(pageRef);
        policyInfoControllerRLS.initAgentProfile();
        policyInfoControllerRLS.initPolicyInfo();
        
        //policyInfoControllerRLS.loadDataWSTopDownHierarchy();
        policyInfoControllerRLS.getContacts();
        policyInfoControllerRLS.loadDataSeq2and3();
        policyInfoControllerRLS.loadDataSeq2();
        policyInfoControllerRLS.loadDataSeq3();
        policyInfoControllerRLS.onloadCustomerProfile();
        //policyInfoControllerRLS.setJSONVariable();
        //policyInfoControllerRLS.preparingPageDataTEST();
        policyInfoControllerRLS.preparingPageDataCallFromPage();
        //policyInfoControllerRLS.preparingPageDataSFDC();
        policyInfoControllerRLS.initContactProfile();
        policyInfoControllerRLS.initPaymentInfo();
        policyInfoControllerRLS.initFundInfo();
        policyInfoControllerRLS.initClaimInfo();
        policyInfoControllerRLS.initRHSInfo();
        policyInfoControllerRLS.initCHSInfo();
        policyInfoControllerRLS.initInquiryInfo();
        policyInfoControllerRLS.initAssessmentNotesDetail();
        //policyInfoControllerRLS.getEIPPolicyDetailList();
        policyInfoControllerRLS.getEIPPolicyChangeList();
        policyInfoControllerRLS.getEIPBenefitDetailList();
        policyInfoControllerRLS.getEIPPremiumBreakdownList();
        policyInfoControllerRLS.getEIPRiskDetailList();
        policyInfoControllerRLS.getEIPClaimDetailList();
        policyInfoControllerRLS.getInsuredDetailList();
        policyInfoControllerRLS.setJSONVariable('getCustomerInfo::Customer Profile','test');
        policyInfoControllerRLS.setJSONVariable('getCustomerInfo::Account Detail','test');

        policyInfoControllerRLS.setJSONVariable('getPolicyDetails::Insured Details','test');
        policyInfoControllerRLS.setJSONVariable('getPolicyDetails::Policy Details','test');
        policyInfoControllerRLS.setJSONVariable('getPolicyDetails::Policy Change','test');
        policyInfoControllerRLS.setJSONVariable('getPolicyDetails::Cash Value','test');

        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Customer Profile','test');
        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Policy Details','test');
        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Insured Details','test');
        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Policy Change','test');
        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Risk Info','test');
        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Own Risk','test');
        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Interest Info','test');
        policyInfoControllerRLS.setJSONVariable('getGIPolicyDetail::Risk Detail','test');

        policyInfoControllerRLS.setJSONVariable('getAgentInfo::Agent Info','test');
        policyInfoControllerRLS.setJSONVariable('getAgentInfo::Agent Hierarchy','test');

        policyInfoControllerRLS.setJSONVariable('getBeneficiaryDetail::Beneficiary','test');

        policyInfoControllerRLS.setJSONVariable('getPremiumBreakdown::Premium Breakdown','test');
        
        policyInfoControllerRLS.setJSONVariable('getPremiumBreakdown::Benefit Detail','test');

        policyInfoControllerRLS.setJSONVariable('getClaimDetails::Claim','test');

        policyInfoControllerRLS.setJSONVariable('getGIClaimDetail::Claim','test');

        policyInfoControllerRLS.setJSONVariable('getPaymentHistory::Payment','test');

        policyInfoControllerRLS.setJSONVariable( 'getFundHistory::Fund','test');

        policyInfoControllerRLS.setJSONVariable('getFundDetail::Fund','test');

        policyInfoControllerRLS.setJSONVariable('getProductFundDetail::Fund','test');

        policyInfoControllerRLS.setJSONVariable('getAssNotes::Summary','test');

        policyInfoControllerRLS.setJSONVariable('getAssNotes::Detail','test');

    }

    public static testMethod void initVariableTest() {
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
        Map<String,Schema.RecordTypeInfo> ContactRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
        Id rtId = ContactRecordTypeInfo.get('Contact').getRecordTypeId();
        
        Contact conRLS = new Contact();
        conRLS.RecordTypeId = rtId;
        conRLS.LastName = '123';
        conRLS.FirstName = 'Testing';
        conRLS.Policy_No__c = '515-3881890';
        conRLS.PolicyApp__c = 'G400';
        conRLS.Insured_Name__c = 'GABRIEL MARCIO';
        conRLS.Entity__c = 'AGI';
        conRLS.Email = 'testing123@gmail.com';
        conRLS.MobilePhone = '085657585950';
        //lst_contact.add(conRLS);
        ApexPages.StandardController stdContrl1 = new ApexPages.StandardController(conRLS);              
        PolicyInfoAGIController policyInfoControllerRLS = new PolicyInfoAGIController(stdContrl1);

        PageReference pageRef = Page.PolicyInfoPage;
        Test.setCurrentPage(pageRef);
        policyInfoControllerRLS.initAgentProfile();
        policyInfoControllerRLS.initPolicyInfo();

        policyInfoControllerRLS.agen.AgentNo = '';
        policyInfoControllerRLS.agen.Entity = '';
        policyInfoControllerRLS.agen.DistributionCode = '';
        policyInfoControllerRLS.agen.DistributionType = '';
        policyInfoControllerRLS.agen.AgentName = '';
        policyInfoControllerRLS.agen.AgentID = '';
        policyInfoControllerRLS.agen.JoinDate = system.today();
        policyInfoControllerRLS.agen.Status = '';
        policyInfoControllerRLS.agen.Area = '';
        policyInfoControllerRLS.agen.HomeAddress1 = '';
        policyInfoControllerRLS.agen.HomeAddress2 = '';
        policyInfoControllerRLS.agen.HomeAddress3 = '';
        policyInfoControllerRLS.agen.HomeAddress4 = '';
        policyInfoControllerRLS.agen.OfficeAddress1 = '';
        policyInfoControllerRLS.agen.OfficeAddress2 = '';
        policyInfoControllerRLS.agen.OfficeAddress3 = '';
        policyInfoControllerRLS.agen.OfficeAddress4 = '';
        policyInfoControllerRLS.agen.EmailAddress = '';
        policyInfoControllerRLS.agen.HomePhone1 = '';
        policyInfoControllerRLS.agen.HomePhone2 = '';
        policyInfoControllerRLS.agen.OfficePhone = '';
        policyInfoControllerRLS.agen.MobilePhone1 = '';
        policyInfoControllerRLS.agen.MobilePhone2 = '';
        policyInfoControllerRLS.agen.Fax1 = '';
        policyInfoControllerRLS.agen.Fax2 = '';
        policyInfoControllerRLS.agen.City = '';
        policyInfoControllerRLS.agen.TOC = '';
        policyInfoControllerRLS.agen.ZipCode = '';
        policyInfoControllerRLS.agen.ContactPerson = '';
        policyInfoControllerRLS.agen.ContactAddress = '';
        policyInfoControllerRLS.agen.ContactPhone = '';
        policyInfoControllerRLS.agen.A_Type = '';
        policyInfoControllerRLS.agen.C_Type = '';
        policyInfoControllerRLS.agen.P_Type = '';
        policyInfoControllerRLS.agen.MO_Code = '';
        policyInfoControllerRLS.agen.MO_Name = '';
        policyInfoControllerRLS.agen.UserID = '';
        policyInfoControllerRLS.agen.CPOLICYNO = '';
        policyInfoControllerRLS.agen.PHOLDER = '';
        policyInfoControllerRLS.agen.CT = '';
        policyInfoControllerRLS.agen.ConjunctionF = '';
        policyInfoControllerRLS.agen.Description1 = '';
        policyInfoControllerRLS.agen.ID = '';
        policyInfoControllerRLS.agen.Salutation = '';
        policyInfoControllerRLS.agen.FirstName = '';
        policyInfoControllerRLS.agen.MidName = '';
        policyInfoControllerRLS.agen.LastName = '';
        policyInfoControllerRLS.agen.Name2 = '';
        policyInfoControllerRLS.agen.Email1 = '';
        policyInfoControllerRLS.agen.Email_2 = '';
        policyInfoControllerRLS.agen.Title = '';

        PolicyInfoAGIController.AccountInfo accountInfoTest = new PolicyInfoAGIController.AccountInfo();
        accountInfoTest.No = '';
        accountInfoTest.Name = '';
        accountInfoTest.FirstName = '';
        accountInfoTest.MiddleName = '';
        accountInfoTest.LastName = '';
        accountInfoTest.Salutation = '';
        accountInfoTest.Title = '';
        accountInfoTest.InsuredName = '';
        accountInfoTest.CustomerID = '';
        accountInfoTest.CustomerPolicyNo = '';
        accountInfoTest.Phone1 = '';
        accountInfoTest.Phone2 = '';
        accountInfoTest.Mobile1 = '';
        accountInfoTest.Mobile2 = '';
        accountInfoTest.Email1 = '';
        accountInfoTest.Email2 = '';
        accountInfoTest.Fax1 = '';
        accountInfoTest.Fax2 = '';
        accountInfoTest.ZipCode = '';
        accountInfoTest.City = '';
        accountInfoTest.InputerID = '';
        accountInfoTest.Address1 = '';
        accountInfoTest.Address2 = '';
        accountInfoTest.Address3 = '';
        accountInfoTest.Contact = '';
        accountInfoTest.ContactAddress = '';
        accountInfoTest.ContactPhone = '';
        accountInfoTest.Curr = '';
        accountInfoTest.MarketingOfficerName = '';
        accountInfoTest.MarketingOfficerCode = '';
        accountInfoTest.MarketingOfficerDept = '';
        accountInfoTest.TransactionTypeDescription = '';
        accountInfoTest.IntermediaryTypeDescription = '';
        accountInfoTest.CustomerTypeDescription = '';
        accountInfoTest.RelatedPolicy = '';
        accountInfoTest.Description = '';
        accountInfoTest.Gender = '';
        accountInfoTest.Married = '';
        accountInfoTest.Country = '';
        accountInfoTest.IDPassportNumber = '';
        accountInfoTest.Nationality = '';
        accountInfoTest.Occupation = '';
        accountInfoTest.Language = '';
        accountInfoTest.Birthdate = '';
        accountInfoTest.Age = '';
        accountInfoTest.Birthplace = '';
        accountInfoTest.VIP = '';
        accountInfoTest.AlternateAddress = '';

        PolicyInfoAGIController.PolicyDetailLife policyDetailLifeTest = new PolicyInfoAGIController.PolicyDetailLife();
        policyDetailLifeTest.policyNumber = '';
        policyDetailLifeTest.MataUang = '';
        policyDetailLifeTest.RegularTopUp = 0.0;

        PolicyInfoAGIController.PolicyDetailGI policyDetailGITest = new PolicyInfoAGIController.PolicyDetailGI();
        policyDetailGITest.No = '';
        policyDetailGITest.Name = '';
        policyDetailGITest.FirstName = '';
        policyDetailGITest.MiddleName = '';
        policyDetailGITest.LastName = '';
        policyDetailGITest.Salutation = '';
        policyDetailGITest.Title = '';
        policyDetailGITest.InsuredName = '';
        policyDetailGITest.CustomerID = '';
        policyDetailGITest.CustomerPolicyNo = '';
        policyDetailGITest.Phone1 = '';
        policyDetailGITest.Phone2 = '';
        policyDetailGITest.Mobile1 = '';
        policyDetailGITest.Mobile2 = '';
        policyDetailGITest.Email1 = '';
        policyDetailGITest.Email2 = '';
        policyDetailGITest.Fax1 = '';
        policyDetailGITest.Fax2 = '';
        policyDetailGITest.ZipCode = '';
        policyDetailGITest.City = '';
        policyDetailGITest.InputerID = '';
        policyDetailGITest.Address1 = '';
        policyDetailGITest.Address2 = '';
        policyDetailGITest.Address3 = '';
        policyDetailGITest.Contact = '';
        policyDetailGITest.ContactAddress = '';
        policyDetailGITest.ContactPhone = '';
        policyDetailGITest.Curr = '';
        policyDetailGITest.MarketingOfficerName = '';
        policyDetailGITest.MarketingOfficerCode = '';
        policyDetailGITest.MarketingOfficerDept = '';
        policyDetailGITest.TransactionTypeDescription = '';
        policyDetailGITest.IntermediaryTypeDescription = '';
        policyDetailGITest.CustomerTypeDescription = '';
        policyDetailGITest.RelatedPolicy = '';
        policyDetailGITest.Description = '';
        policyDetailGITest.Gender = '';
        policyDetailGITest.Married = '';
        policyDetailGITest.Country = '';
        policyDetailGITest.IDPassportNumber = '';
        policyDetailGITest.Nationality = '';
        policyDetailGITest.Occupation = '';
        policyDetailGITest.Language = '';
        policyDetailGITest.Age = '';
        policyDetailGITest.Birthplace = '';
        policyDetailGITest.VIP = '';
        policyDetailGITest.AlternateAddress = '';
        policyDetailGITest.Birthdate = date.parse('12/27/2015');
        
        PolicyInfoAGIController.AgentInfo agentInfoTest = new PolicyInfoAGIController.AgentInfo();
        agentInfoTest.Leader1 = '';
        agentInfoTest.Leader2 = '';
        agentInfoTest.Leader3 = '';
        agentInfoTest.Leader4 = '';

        PolicyInfoAGIController.AgentHierarchy agentHierarchyTest = new PolicyInfoAGIController.AgentHierarchy();
        agentHierarchyTest.AgentCode = '';
        agentHierarchyTest.AgentName = '';
        agentHierarchyTest.PosCode = '';
        agentHierarchyTest.Term = '';
        agentHierarchyTest.LeaderEffDate = date.parse('12/27/2015');
        
        PolicyInfoAGIController.InsuredDetail insuredDetailTest = new PolicyInfoAGIController.InsuredDetail();
        insuredDetailTest.Product = '';
        insuredDetailTest.IDNo = '';
        insuredDetailTest.Name = '';
        insuredDetailTest.PlaceofBirth = '';
        insuredDetailTest.DateofBirth = date.parse('12/27/2015');
        insuredDetailTest.Gender = '';
        insuredDetailTest.Email = '';
        insuredDetailTest.Mobile = '';
        insuredDetailTest.VehicleMerkModel = '';
        insuredDetailTest.PoliceRegNo = '';
        insuredDetailTest.YearofManufacturing = '';
        insuredDetailTest.PolicyCover = '';
        insuredDetailTest.SumInsured = 0.0;
        insuredDetailTest.PremiumAmount = 0.0;
        insuredDetailTest.ExtraCoverageLimits = 0.0;
        insuredDetailTest.Deductible = '';
        insuredDetailTest.RiskOccupation = '';
        insuredDetailTest.ContractWorks = '';
        insuredDetailTest.Destination = '';
        insuredDetailTest.ObjectInsured = '';
        insuredDetailTest.VesselFlag = '';
        insuredDetailTest.NoEmployee = '';
        insuredDetailTest.TPLLimit = 0.0;
        insuredDetailTest.LimitOccurrence = 0.0;
        insuredDetailTest.LimitPeriod = 0.0;
        insuredDetailTest.TerritorialLimit = '';
        insuredDetailTest.OwnerBusiness = '';
        insuredDetailTest.InsuredName = '';
        insuredDetailTest.Age = '';
        insuredDetailTest.Beneficiary = '';
        insuredDetailTest.Relation = '';
        insuredDetailTest.PolicyPlan = '';
        insuredDetailTest.Premium = 1.0;
        insuredDetailTest.VesselName = '';
        insuredDetailTest.VesselType = '';
        insuredDetailTest.ConveyanceName = '';
        insuredDetailTest.DepartureFrom = '';
        insuredDetailTest.To = '';
        insuredDetailTest.TimeDeparture = date.parse('12/27/2015');
        insuredDetailTest.TypeCover = '';
        insuredDetailTest.LimitAccident = 0.0;
        insuredDetailTest.EstimateCarrying = '';
        insuredDetailTest.RatePremises = '';
        insuredDetailTest.RateTransit = '';
        insuredDetailTest.ContractTitle = '';
        insuredDetailTest.RatePremium = '';

        PolicyInfoAGIController.InsuredDetailGIMV insuredDetailGIMVTest = new PolicyInfoAGIController.InsuredDetailGIMV();
        insuredDetailGIMVTest.TableNo = '';
        insuredDetailGIMVTest.VehicleBrand = '';
        insuredDetailGIMVTest.Model = '';
        insuredDetailGIMVTest.SubModel = '';
        insuredDetailGIMVTest.YearofManufacturing = '';
        insuredDetailGIMVTest.LicenseNumber = '';
        insuredDetailGIMVTest.MachineNumber = '';
        insuredDetailGIMVTest.ChasisNumber = '';
        insuredDetailGIMVTest.Type = '';
        insuredDetailGIMVTest.Function = '';
        insuredDetailGIMVTest.Colour = '';
        insuredDetailGIMVTest.STNK = '';
        insuredDetailGIMVTest.Location = '';

        PolicyInfoAGIController.InsuredDetailGINonMV insuredDetailGINonMVTest = new PolicyInfoAGIController.InsuredDetailGINonMV();
        insuredDetailGINonMVTest.ConstructionClass = '';
        insuredDetailGINonMVTest.RiskOccupation = '';
        insuredDetailGINonMVTest.RiskCategory = '';
        insuredDetailGINonMVTest.RiskLocation = '';
        insuredDetailGINonMVTest.Lighting = '';

        PolicyInfoAGIController.PremiumBreakdown premiumBreakdownTest = new PolicyInfoAGIController.PremiumBreakdown();
        premiumBreakdownTest.InsuranceProductCd = '';
        premiumBreakdownTest.EffectiveDate = date.parse('12/27/2015');
        premiumBreakdownTest.ExpiredDate = date.parse('12/27/2015');
        premiumBreakdownTest.TransactionNo = '';
        premiumBreakdownTest.ProductType = '';
        premiumBreakdownTest.GrossPremium = 0.0;
        premiumBreakdownTest.NettPremium = 0.0;
        premiumBreakdownTest.RiskNo = '';
        premiumBreakdownTest.InsuredNo = '';
        premiumBreakdownTest.InsuredName = '';
        premiumBreakdownTest.PlanCode = '';
        premiumBreakdownTest.PlanType = '';
        premiumBreakdownTest.PlanEffectiveDate = date.parse('12/27/2015');
        premiumBreakdownTest.PlanExpiredDate = date.parse('12/27/2015');
        premiumBreakdownTest.PlanSI = 0.0;
        premiumBreakdownTest.ModalPlanPremium = 0.0;
        premiumBreakdownTest.PlanStatus = '';
        premiumBreakdownTest.ClassCode = '';
        premiumBreakdownTest.ModalPlanLoading = 0.0;
        premiumBreakdownTest.TerminationDate = date.parse('12/27/2015');
        premiumBreakdownTest.Total = 0.0;
            

        PolicyInfoAGIController.PaymentHistoryLife paymentHistoryLifeTest = new PolicyInfoAGIController.PaymentHistoryLife();
        paymentHistoryLifeTest.PaymentMethod = '';
        paymentHistoryLifeTest.PaymentType = '';
        paymentHistoryLifeTest.PaymentAmount = 0.0;
        paymentHistoryLifeTest.PaymentSubmissionDate = date.parse('12/27/2015');
        paymentHistoryLifeTest.PaymentTransactionDate = date.parse('12/27/2015');
        paymentHistoryLifeTest.PaymentDueDate = date.parse('12/27/2015');

        PolicyInfoAGIController.FundHistory fundHistoryTest = new PolicyInfoAGIController.FundHistory();
        fundHistoryTest.ULFundCode = '';
        fundHistoryTest.TransactionDescription = '';
        fundHistoryTest.ProcessingType = '';
        fundHistoryTest.ProcessingMode = '';
        fundHistoryTest.TransactionUnit = 0.0;
        fundHistoryTest.UnitPrice = 0.0;
        fundHistoryTest.TransactionAmount = 0.0;
        fundHistoryTest.FundPriceDate = date.parse('12/27/2015');
        fundHistoryTest.TransactionDate = date.parse('12/27/2015');
        fundHistoryTest.TransactionEffectiveDate = date.parse('12/27/2015');
        fundHistoryTest.ULValuationDate = date.parse('12/27/2015');

        PolicyInfoAGIController.FundDetail fundDetailTest = new PolicyInfoAGIController.FundDetail();
        fundDetailTest.FundCode = '';
        fundDetailTest.FundUnit = '';
        fundDetailTest.FundAllocation = 0.0;
        fundDetailTest.FundPrice = 0.0;
        fundDetailTest.TotalUnitFund = 0.0;
        fundDetailTest.TotalFundAmount = 0.0;
        fundDetailTest.NAVDate = system.today();
        fundDetailTest.FundAmount = 0.0;
        fundDetailTest.FundTotal = 0.0;
        fundDetailTest.FundNAVDate = system.today();

        PolicyInfoAGIController.FundPriceHistory fundPriceHistoryTest = new PolicyInfoAGIController.FundPriceHistory();
        fundPriceHistoryTest.FundCurrency = '';
        fundPriceHistoryTest.FundCode = '';
        fundPriceHistoryTest.FundDescription = '';
        fundPriceHistoryTest.BidPrice_UnitPrice = 0.0;
        fundPriceHistoryTest.OfferPrice_UnitPrice = 0.0;
        fundPriceHistoryTest.ValuationDate = system.today();

        PolicyInfoAGIController.AssessmentNotesSummary assessmentNotesSummaryTest = new PolicyInfoAGIController.AssessmentNotesSummary();
        assessmentNotesSummaryTest.LastInputDateTimeOrigStr = '';
        assessmentNotesSummaryTest.Section = '';
        assessmentNotesSummaryTest.TranTypeClaimType = '';
        assessmentNotesSummaryTest.RefNo = '';
        assessmentNotesSummaryTest.Status = '';
        assessmentNotesSummaryTest.Remark = '';
        assessmentNotesSummaryTest.assessmentClassType = '';

        PolicyInfoAGIController.AssessmentNotesDetail assessmentNotesDetailTest = new PolicyInfoAGIController.AssessmentNotesDetail();
        assessmentNotesDetailTest.InputDateTime = datetime.newInstance(2019, 1, 1, 0, 0, 0);
        assessmentNotesDetailTest.UserIDAssessment = '';
        assessmentNotesDetailTest.Description = '';
        assessmentNotesDetailTest.Section = '';
        assessmentNotesDetailTest.assessmentClassType = '';

        PolicyInfoAGIController.ClaimDetailLife claimDetailLifeTest = new PolicyInfoAGIController.ClaimDetailLife();
        claimDetailLifeTest.ClaimCurrency = '';

        PolicyInfoAGIController.PolicyRider policyRiderTest = new PolicyInfoAGIController.PolicyRider();
        policyRiderTest.PolicyNumber = '';
        policyRiderTest.MataUang = '';
        policyRiderTest.ReferenceNumber = '';
        policyRiderTest.ProductCode = '';
        policyRiderTest.ProductName = '';
        policyRiderTest.PolicyStatus = '';
        policyRiderTest.Description = '';
        policyRiderTest.PaymentMethod = '';
        policyRiderTest.PaymentMode = '';
        policyRiderTest.FundPrice = '';
        policyRiderTest.StatusDesc = '';
        policyRiderTest.CoverNo = '';
        policyRiderTest.Segment = '';
        policyRiderTest.Branch = '';
        policyRiderTest.BranchCode = '';
        policyRiderTest.Insured = '';
        policyRiderTest.USPRRLTN = '';
        policyRiderTest.TSIS = '';
        policyRiderTest.PremiumGIS = '';
        policyRiderTest.AIDS = '';
        policyRiderTest.TotalPremium = 0.0;
        policyRiderTest.TotalSumInsured = 0.0;
        policyRiderTest.TotalPremiumofBasicPlan = 0.0;
        policyRiderTest.BasicSI = 0.0;
        policyRiderTest.RegularTopUp = 0.0;
        policyRiderTest.LumpSumTopUp = 0.0;
        policyRiderTest.BasicRiderModPrem = 0.0;
        policyRiderTest.BasicRegPrem = 0.0;
        policyRiderTest.CashValue = 0.0;
        policyRiderTest.TSI = 0.0;
        policyRiderTest.PremiumGI = 0.0;
        policyRiderTest.DateofApplication = Date.newInstance(2019, 1, 1);
        policyRiderTest.IssuedDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.EffectiveDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.ExpiredDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.TerminationDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.ReferenceDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.DueDate1 = Date.newInstance(2019, 1, 1);
        policyRiderTest.DueDate2 = Date.newInstance(2019, 1, 1);
        policyRiderTest.PremiumHolidayStart = Date.newInstance(2019, 1, 1);
        policyRiderTest.PremiumHolidayEnd = Date.newInstance(2019, 1, 1);
        policyRiderTest.StartDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.EndDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.CoverDate = Date.newInstance(2019, 1, 1);
        policyRiderTest.PolicyDate = Date.newInstance(2019, 1, 1);

        PolicyInfoAGIController.Insured insuredTest = new PolicyInfoAGIController.Insured();
        insuredTest.Name = '';
        insuredTest.PlaceofBirth = '';
        insuredTest.Gender = '';
        insuredTest.RelationwithPolicyHolder = '';
        insuredTest.DOB = system.today();
        insuredTest.IdentificationNo = '';
        insuredTest.EmailAddress = '';
        insuredTest.MobilePhoneNumber = '';

        PolicyInfoAGIController.Beneficiary beneficiaryTest = new PolicyInfoAGIController.Beneficiary();
        beneficiaryTest.Name = '';
        beneficiaryTest.PlaceofBirth = '';
        beneficiaryTest.Gender = '';
        beneficiaryTest.DOB = system.today();
        beneficiaryTest.RelationwithInsured = '';
        beneficiaryTest.PercentageofBenefit = '';
        
        PolicyInfoAGIController.BenefitDetail benefitDetailTest = new PolicyInfoAGIController.BenefitDetail();
        benefitDetailTest.PlanCode = '';
        benefitDetailTest.BenefitCode = '';
        benefitDetailTest.BenefitDesc = '';
        benefitDetailTest.BenefitInDay = 0.0;
        benefitDetailTest.BenefitInVisit = 0.0;
        benefitDetailTest.BenefitInMonth = 0.0;
        benefitDetailTest.BenefitInYear = 0.0;
        benefitDetailTest.BenefitInLife = 0.0;

		PolicyInfoAGIController.Benefit benefitTest = new PolicyInfoAGIController.Benefit();        
        benefitTest.PlanCode = '';
        benefitTest.BenefitCode = '';
        benefitTest.BenefitDesc = '';
        benefitTest.BenefitInDay = 0.0;
        benefitTest.BenefitInVisit = 0.0;
        benefitTest.BenefitInMonth = 0.0;
        benefitTest.BenefitInYear = 0.0;
        benefitTest.BenefitInLife = 0.0;

        PolicyInfoAGIController.TrxPayment trxPaymentTest = new PolicyInfoAGIController.TrxPayment();
        trxPaymentTest.TransactionType = '';
        trxPaymentTest.SubmissionDate = system.today();
        trxPaymentTest.PaymentDate = system.today();
        trxPaymentTest.DueDate = system.today();
        trxPaymentTest.Amount = 0.0;

        PolicyInfoAGIController.DetailFund detailFundTest = new PolicyInfoAGIController.DetailFund();
        detailFundTest.FundCode = '';
        detailFundTest.TotalUnitFund = 0.0;
        detailFundTest.FundPrice = 0.0;
        detailFundTest.FundAllocation = 0.0;
        detailFundTest.TotFundAmount = 0.0;
        detailFundTest.NAVDate = system.today();


        PolicyInfoAGIController.FundTransaction fundTransactionTest = new PolicyInfoAGIController.FundTransaction();
        fundTransactionTest.FundCodes = '';
        fundTransactionTest.FundCurrency = '';
        fundTransactionTest.FundPriceDate = system.today();
        fundTransactionTest.ValuationDate = system.today();
        fundTransactionTest.Spread = '';
        fundTransactionTest.TrxCode = '';
        fundTransactionTest.ProcessingType = '';
        fundTransactionTest.ProcessingMode = '';
        fundTransactionTest.TrxCode = '';
        fundTransactionTest.ProcessingType = '';
        fundTransactionTest.ProcessingMode = '';
        fundTransactionTest.UnitPrice = 0.0;
        fundTransactionTest.TrxAmount = 0.0;
        fundTransactionTest.TrxUnit = 0.0;
        fundTransactionTest.TrxDate = system.today();
        fundTransactionTest.TrxEffectiveDate = system.today();

        PolicyInfoAGIController.CashValueDetail_OLD cashValueDetail_OLDTest = new PolicyInfoAGIController.CashValueDetail_OLD();
        cashValueDetail_OLDTest.Loan = 0.0;
        cashValueDetail_OLDTest.LoanInterest = 0.0;
        cashValueDetail_OLDTest.Dividend = 0.0;
        cashValueDetail_OLDTest.DividendInterest = 0.0;
        cashValueDetail_OLDTest.FtrPremDeposit = 0.0;
        cashValueDetail_OLDTest.FtrPremDepInter = 0.0;
        cashValueDetail_OLDTest.CashValue = 0.0;

        PolicyInfoAGIController.TrxClaim trxClaimTest = new PolicyInfoAGIController.TrxClaim();
        trxClaimTest.ProductType = '';
        trxClaimTest.ClaimNumber = '';
        trxClaimTest.ClaimType = '';
        trxClaimTest.ClaimPlan = '';
        trxClaimTest.SubmissionDate = system.today();
        trxClaimTest.ApprovalDate = system.today();
        trxClaimTest.ClaimCurrency = '';
        trxClaimTest.ClaimStatus1 = '';
        trxClaimTest.ClaimStatus2 = '';
        trxClaimTest.StatusDesc = '';
        trxClaimTest.Amount = 0.0;

        PolicyInfoAGIController.GIClaim gIClaimTest = new PolicyInfoAGIController.GIClaim();
        gIClaimTest.PolicyNo = '';
        gIClaimTest.ClaimRegNo = '';
        gIClaimTest.ClaimStatus = '';
        gIClaimTest.Branch = '';
        gIClaimTest.ClientName = '';
        gIClaimTest.Description = '';
        gIClaimTest.AccidentPlace = '';
        gIClaimTest.RepairShop = '';
        gIClaimTest.DriverName = '';
        gIClaimTest.NotifDate = date.parse('12/27/2015');
        gIClaimTest.RegDate = system.today();
        gIClaimTest.DateofLoss = system.today();
        gIClaimTest.ApprPayDate = system.today();
        gIClaimTest.PaymentDate = system.today();

        PolicyInfoAGIController.GIEndorsement gIEndorsementTest = new PolicyInfoAGIController.GIEndorsement();
        gIEndorsementTest.PolicyNo = '';
        gIEndorsementTest.CertificateNo = '';
        gIEndorsementTest.ContractType = '';
        gIEndorsementTest.InforceDate = system.today();
        gIEndorsementTest.StartDate = system.today();
        gIEndorsementTest.EndDate = system.today();
        gIEndorsementTest.EndorsementRemark = '';
        gIEndorsementTest.Status = '';
        gIEndorsementTest.TypeGI = '';
        
        PolicyInfoAGIController.RiskDetail riskDetailTest = new PolicyInfoAGIController.RiskDetail();
		riskDetailTest.TahunPertanggungan = '';
        riskDetailTest.TSI = '';
        riskDetailTest.Premium = 0.0;
        riskDetailTest.Coverage = '';
        riskDetailTest.StartDate = system.today();
        riskDetailTest.EndDate = system.today();
        riskDetailTest.TransactionNo = '';
        riskDetailTest.MemberNo = '';
        riskDetailTest.MemberName = '';
        riskDetailTest.PlanNo = '';
        riskDetailTest.RiskNo = '';
        
        PolicyInfoAGIController.PremiumBreakdown_OLD premiumBreakdown_OLDTest = new PolicyInfoAGIController.PremiumBreakdown_OLD();
        premiumBreakdown_OLDTest.PlanCode = '';
        premiumBreakdown_OLDTest.PlanType = '';
        premiumBreakdown_OLDTest.ClassCode = '';
        premiumBreakdown_OLDTest.PlanStatus = '';
        premiumBreakdown_OLDTest.BasicPlan = 0.0;
        premiumBreakdown_OLDTest.ModalPlanPremium = 0.0;
        premiumBreakdown_OLDTest.ModalPlanLoading = 0.0;
        premiumBreakdown_OLDTest.PlanSi = 0.0;
        premiumBreakdown_OLDTest.EffectiveDate = system.today();
        premiumBreakdown_OLDTest.TerminationDate = system.today();
        premiumBreakdown_OLDTest.ExpiredDate = system.today();

        PolicyInfoAGIController.PolicyChange policyChangeTest = new PolicyInfoAGIController.PolicyChange();
        policyChangeTest.TransactionCode = '';
        policyChangeTest.TransactionDesc = '';
        policyChangeTest.SubmitDate = system.today();
        policyChangeTest.CreateDate = system.today();
        policyChangeTest.Status = '';
        policyChangeTest.Remark = '';

        PolicyInfoAGIController.TableofContent tableofContentTest = new PolicyInfoAGIController.TableofContent();
        tableofContentTest.tableList1 = '';
        tableofContentTest.tableList2 = '';
        tableofContentTest.tableList3 = '';
        tableofContentTest.tableList4 = '';
        tableofContentTest.tableList5 = '';
        tableofContentTest.tableList6 = '';
        tableofContentTest.tableList7 = '';
        tableofContentTest.tableList8 = '';
        tableofContentTest.tableList8 = '';
        tableofContentTest.tableList9 = '';
        tableofContentTest.tableList10 = '';
        tableofContentTest.tableList11 = '';
        tableofContentTest.tableList12 = '';
        tableofContentTest.tableList13 = '';
        tableofContentTest.tableList14 = '';
        tableofContentTest.tableList15 = '';
        tableofContentTest.tableLabel14 = '';
        tableofContentTest.tableLabel15 = '';
        tableofContentTest.tableValue14 = '';
        tableofContentTest.tableValue15 = '';

        PolicyInfoAGIController.AccountDetail_OLD accountDetail_OLDTest = new PolicyInfoAGIController.AccountDetail_OLD();
        accountDetail_OLDTest.AcchBranch = '';
        accountDetail_OLDTest.AccountNo = '';
        accountDetail_OLDTest.AccountEff = system.today();
        accountDetail_OLDTest.AccountExp = system.today();
        accountDetail_OLDTest.AccountType = '';
        accountDetail_OLDTest.AccountStatus = '';
        accountDetail_OLDTest.AccountName = '';
        accountDetail_OLDTest.CollectionBank = '';
        accountDetail_OLDTest.RejectCode = '';
        accountDetail_OLDTest.RejectDate = system.today();

        PolicyInfoAGIController.PremiumDetail premiumDetailTest = new PolicyInfoAGIController.PremiumDetail();
        premiumDetailTest.PremiumType = '';
        premiumDetailTest.PremRef = '';
        premiumDetailTest.PMRMKC = '';
        premiumDetailTest.PMRMKD = '';
        premiumDetailTest.PMRMKD2 = '';
        premiumDetailTest.PMRMKD3 = '';
        premiumDetailTest.PMDEPT = '';
        premiumDetailTest.PMUSER = '';
        premiumDetailTest.PMLUPD = '';
        premiumDetailTest.PMCOMD = '';
        premiumDetailTest.PMCOMS = '';
        
        PolicyInfoAGIController.InterestInfo_OLD interestInfo_OLDTest = new PolicyInfoAGIController.InterestInfo_OLD();
        interestInfo_OLDTest.AddCoverCode = '';
        interestInfo_OLDTest.AddCoverName = '';
        interestInfo_OLDTest.AddCoverType = '';
        interestInfo_OLDTest.AddCoverPremium = 0.0;
        interestInfo_OLDTest.SIofAddCover = 0.0;

        PolicyInfoAGIController.AssNotes assNotesTest = new PolicyInfoAGIController.AssNotes();
        assNotesTest.submittedDate = '';
        assNotesTest.submittedBy = '';

        PolicyInfoAGIController.AssNotesDetail assNotesDetailTest = new PolicyInfoAGIController.AssNotesDetail();
        assNotesDetailTest.inputDate = '';
        assNotesDetailTest.userID = '';
        assNotesDetailTest.userName = '';
        assNotesDetailTest.description = '';
        assNotesDetailTest.section = '';

        PolicyInfoAGIController.AssNotesJSON assNotesJSONTest = new PolicyInfoAGIController.AssNotesJSON();
        assNotesJSONTest.key = '';
        assNotesJSONTest.status = '';
        assNotesJSONTest.pageno = 0;
        assNotesJSONTest.startrecord = 0;
        assNotesJSONTest.endrecord = 0;
        assNotesJSONTest.totalrecords = 0;

        PolicyInfoAGIController.AssNotesDetailJSON assNotesDetailJSONTest = new PolicyInfoAGIController.AssNotesDetailJSON();
        assNotesDetailJSONTest.key = '';
        assNotesDetailJSONTest.status = '';
        assNotesDetailJSONTest.pageno = 0;
        assNotesDetailJSONTest.startrecord = 0;
        assNotesDetailJSONTest.endrecord = 0;
        assNotesDetailJSONTest.totalrecords = 0;
        

    }
}