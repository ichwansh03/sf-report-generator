public class EIPJson {
    public EIP_Body Body;
    public EIP_Header Header;
    public String errorCode;
    public String errorMessage;
    public String errorDetail;
    public String reasonCode;
    public String message;
    public String reason;
    public String access_token;
    public String expires_in;
    public String token_type;
    
    public class EIP_Header{
        public EIP_SecurityContext SecurityContext;
    }
    
    public class EIP_Body {
        public String operation;
        public String transactionId;
        public String status;
        public String entity;
        public String service;
        public String appID;
        public EIP_AXAAsiaPagination AXAAsiaPagination_Type;
        public EIP_AgSa_InsurancePolicy AgSa_InsurancePolicy_Type;
        public EIP_IcAx_AXAAsiaCustomer IcAx_AXAAsiaCustomer_Type;
        public EIP_Exception exceptionObj;
        // added by @Fajar Salam
        public EIP_IcAx_AXAAsiaCustomer Customer;
        // added by Ichwan
        public EIP_AgSa_CommunicationList RecordPolicyCommunicationListRequest;
    }

    public class EIP_SecurityContext{
        public String token;
        public String password;
        public String username;
    }
    
    public class EIP_GetToken{
        public String client_id;
        public String client_secret;
        public String grant_type;
        public String audience;
    }
    
    public class EIP_AXAAsiaPagination{
        public String startDateTime;
        public String endDateTime;
        public String rowPerPage;
        public String startOfRecords;
        public String numberOfRecords;
        public String pageNumber;
        public String lineNumber;
    }
    
    public class EIP_Exception extends Exception{
        public String code;
        public String message;
        public String backEndError;
    }
    
        public class Exceptions{
        public String code;
        public String message;
        public String backEndError;
    }
    
    public class EIP_AgSa_InsurancePolicy{
        public String policyVersion;
        public String accountNo;
        public String renewalDt;
        public String currencyCD;
        public String ePolicy;
        public String initialLumpsumPremiumAMT;
        public String issueDt;
        public String originalPolicyNo;
        public String paymentMethodCD;
        public String paymentModeCD;
        public String policyDueDt;
        public String policyEffectiveDTTM;
        public String policyExpirationDTTM;
        public String policyNO;
        public String policyRK;
        public String policyStatusCD;
        public String policySegment;
        public String policyTypeCd;
        public String agencyBinderNo;
        public String premiumAMT;
        public String sourceChannelCD;
        public String terminationDt;
        public String topupRegularModalPremium;
        public String key;
        public String certificateNo;
        public String registeredBy;
        public String generalRk;
        public String lobRk;
        public String issueBranchNM;
        public String issueBranchCD;
        public String collectedByAgentAmt;
        public String remark1;
        public String insuranceProductRk;
        public String binderPurposeCd;
        public String otherInsuredInd;
        public String convertToPrivateInd;
        // add Valid DTTM by Faizir 2020-02-13
        public String validFromDttm;
        public String validToDttm;
        public String statusReasonCd;
        public String uwTypeCd;
        public String policyReserveAmt;
        public String bonusReserveAmt;
        public String processedDttm;
        public String grossAnnualPremiumAmt;
        public String reEntryRt;
        
        public String bonusReservesAmt;
        public String targetPremiumAmt;
        public String dividentAccumRt;
        public String premiumIndexRt;
        public String policyStatusRk;
        public String assignmentFlg;
        public String applicationRk;

        // Catur, 20200727, AFI webservice getLoanHistory, adminFee
        public String dividendAccumRt;
        public String payorCd;
        public String bonusAmt;
        public String policyValue;
        public String policyFeeAmt;
        public String statusChangeDT;
        public String paidToDT;
        
        //Catur, 20200709, send communication to TADA
        public String preferredChannelCd;
        
        //Catur, 20211012, edmu
       	public String issueTypeCD;
        public String termProcessDt;
        public String financialFundRk;
        public String producerRk;
        public String SARamt;
        public String groupNm;
        public String customerRk;
        
        public EIP_IcAx_AXAAsiaPayment hasBilling;
        public EIP_IcAx_AXAAsiaLifePolicyTrans[] hasLifePolicyTransactionDetailsIn;
        public EIP_IcAx_AXAAsiaLifeUnitOfExposure[] forLifeUnitofExposure;
        public EIP_IcAx_AXAAsiaInsuredPersonDetails[] hasDetailsOfRisksIn;
        public EIP_IcAx_AXAAsiaLifePolicyChangeTrans[] hasLifePolicyChangeTransDetailsIn;
        public EIP_IcAx_AXAAsiaApplicationDetails[] hasApplicationDetailsIn;
        public EIP_IcAx_AXAAsiaLifeInsuranceProduct[] isAssociatedWithLifeInsuranceProduct;
        public EIP_IcAx_AXAAsiaLifePolicyDetails[] hasDetailsOfPolicyIn;
        public EIP_IcAx_AXAAsiaSubAccount[] hasAccountDetailsIn;
        public EIP_IcAx_AXAAsiaParty[] hasPartyDetailsIn;
        public EIP_IcAx_AXAAsiaLifeInsuranceClaim[] hasDetailsOfClaimIn;
        public EIP_IcAx_AXAAsiaPolicyAssessment[] hasPolicyAssessmentDetailsIn;
        public EIP_PnCClaim_CLAIM[] hasPnCClaimIn;
        public EIP_IcAx_AXAAsiaProducer_Type[] hasProducerInformationIn;
        public EIP_IcAx_AXAAsiaGeneralPolicyTrans[] hasDetailsOfPolicyTransactionIn;
        public EIP_IcAx_AXAAsiaGeneralInsuranceProduct[] isAssociatedWithGIInsuranceProduct;
        public EIP_IcAx_AXAAsiaGeneralPolicyCoverage[] hasDetailsOfGIRisksIn;
        public EIP_IcAx_AXAAsiaGeneralEndorsement[] hasGIPolicyEndorsementIn;
        public EIP_AgSa_NameValue[] hasNameValue;
        public EIP_IcAx_AXAAsiaPolicyPaymentAccount[] hasAXAAsiaPolicyPaymentAccount;
        public EIP_IcAx_AXAAsiaCustomer[] hasCustomerInformationIn;
        public EIP_AgSa_InvestmentDetails[] hasDetailsRecordIn;
        public EIP_IssuerAssociated isAssociatedWithIssuer;
        public EIP_IcAx_AXAAsiaDocumentDetailsIn[] hasDocumentDetailsIn;
        public EIP_IcAx_AXAAsiaRemarkDetailsIn[] hasPolicyRemarkDetailsIn;
    }
    
    public class EIP_IcAx_AXAAsiaRemarkDetailsIn{
        public String creationDT;
        public String lastUpdatedBy;
        public String lastUpdatedDT;
        public String remarks;
    }
    
    //Add EIP_IcAx_AXAAsiaDocumentDetailsIn by Elviana Victoria 2025, 22 June
     public class EIP_IcAx_AXAAsiaDocumentDetailsIn{
         public String documentID;
         public String documentMIMETypeCD;
         public String documentNM;
         public String documentTypeCD;
     }

    public class EIP_IcAx_AXAAsiaPayment{
        public String transactionReferenceNO;
        public String grossAmount;
        public String enabled_payment;
        public String installmentTerm;
        public String corporateID;
        public String save_token_id;
        public String currencyCd;
        public String method;
        public String remark1;
        public String remark2;
        public EIP_IcAx_AXAAsiaPolicyPaymentAccount transferAccountDetails;
        public EIP_IcAx_AXAAsiaPaymentHistory[] hasPaymentHistoryDetails;
    }

    public class EIP_IcAx_AXAAsiaPaymentHistory{
        public String statusCode;
        public String statusMessage;
        public String redirect_url;
        public String transactionTime;
        public String maskedCard;
        public String fraudStatus;
        public String paymentRefID;
        public String paymentType;
        public String transactionStatus;
        public String bank;
        public String approvalCode;
        public EIP_AgSa_NameValue[] hasNameValue;
    }

    public class EIP_AgSa_RelationContact{
        public String fullNM;
        public EIP_IcAx_AXAAsiaIndividualAddress[] hasAddressesIn;
    }

    public class EIP_IcAx_AXAAsiaGeneralEndorsement{
        public String certificateNo;
        public String contractType;
        public String inforceDate;
        public String endorsementRk;
        public String typeDesc;
        public String collateralAMT;
        public String model;
        public String regNumber;
        public String remark;
        public String manufacturedDT;
        public String unitLocation;
        public String brand;
        public String unitType;
        public String chasisNO;
    }

    public class EIP_IcAx_AXAAsiaGeneralPolicyCoverage{
        public String coverageEndDT;
        public String coverageRk;
        public String deductibleName;
        public EIP_AgSa_NameValue[] coverageParam;
        public EIP_IcAx_AXAAsiaBenefit[] otherBenefit;
    }

    public class EIP_IcAx_AXAAsiaBenefit{
        public String benefitDESC;
        public String benefitAMT;
    }

    public class EIP_IcAx_AXAAsiaGeneralInsuranceProduct{
        public EIP_IcAx_AXAAsiaGeneralPolicySegment[] hasGIPolicySegmentDetailsIn;
    }

    public class EIP_IcAx_AXAAsiaGeneralPolicySegment{
        public String sumInsured;
    }

    public class EIP_IcAx_AXAAsiaGeneralPolicyTrans{
        public String transactionTypeDesc;
        public String intermediaryTypeDesc;
        public String intermediateryTypeDesc;
        public String referenceNO;
        public String referenceDT;
        public String effectiveDTTM;
        public String totalTransAMT;
        public String batchID;
        public String ccInstalmentIND;
        public String sourceSystemCD;
        public String key;
        public String transactionNo;
        public String producerCreditLimitUseIND;
        public String transTypeCD;
        public String transDT;
    }

    public class EIP_IcAx_AXAAsiaProducer_Type{
        public String gaOfficeNM;
        public String gaOfficeCD;
        public String gaOfficeDept;
        public EIP_IcAx_AXAAsiaIndividual[] hasPersonalDetailsIn;
    }

    public class EIP_IcAx_AXAAsiaPolicyAssessment{
        public String assessmentClassType;
        public String assmtRefNo;
        public String assmtDesc;
        public String assmtSection;
        public String assmtTypeCd;
        public String assmtNo;
        public String assmtStatus;
        public String assmtRemark;
        public String assessor;
        public String assessorDTTM;
        public String lastUpdDTTM;
        public String lastUpdBy;
    }
    
    public class EIP_IcAx_AXAAsiaIndividual{
        public String socialSecurityNO;
        public String masterIndividualId;
        public String genderCD;
        public String lastNM;
        public String middleNM;
        public String firstNM;
        public String fullNM;
        public String birthPlace;
        public String birthDT;
        public String distributionCD;
        public String distributionType;
        public String effectiveNominationDT;
        public String terminationDt;
        public String religion;
        public String occupation;
        public String educationLevelCd;
        public String maritalStatusCD;
        public String salutationTxt;
        public String titleTXT;
        public String individualUniqueID;
        public String passportNo;
        public String nationalityCD;
        public String primaryLanguageCd;
        public String ownerIND;
        public String emailAddress;
        public String mobilePhoneNO;
        public String shareholderFlg;
        
        // add by Faizir
        public String otherNm;
        public String occupationClassCd;
        public String processedDttm;
        public String localNM;
        public String countryOfResidenceCD;
        public String individualRK;
        public String customerClassCD;
        public String documentTypeCD;
        public String documentID;
        public String disabilityFlg;
        public String validFromDttm;
        
        public String claimStatusChangeDTTM;
        
        public EIP_IcAx_AXAAsiaPartyAccount hasPartyAccountDetailsIn;
        public EIP_IcAx_AXAAsiaIndividualAddress[] hasAddressesIn;
        public EIP_ProspectDetail[] hasProspectIndividual;
    }
    
    public class EIP_IcAx_AXAAsiaLifeUnitOfExposure{
        public EIP_IcAx_AXAAsiaBeneficiary[] hasBeneficiaryInformationIn;
    }
    
    public class EIP_IcAx_AXAAsiaBeneficiary{
        public String beneficiaryRK;
        public String relationshipIND;
        public EIP_IcAx_AXAAsiaIndividual[] canBeIndividual;
        public EIP_IcAx_AXAAsiaBeneficiaryXUoe[] hasBeneficiaryXUoeDetailsIn;
    }

    public class EIP_IcAx_AXAAsiaInsuredPersonDetails{
        public String key;
        public String validFromDttm;
        public String policyRk;
        public String insuredRK;
        public String insuredID;
        public String dependNo;
        public String agrRk;
        public String relationshipToOwnerCD;
        public String issueAge;
        public EIP_IcAx_AXAAsiaIndividual[] hasPersonalDetailsIn;
    }

    public class EIP_IcAx_AXAAsiaLifeInsuranceProduct{
        public String productTypeCD;
        public String planCd;
        public String insuranceProductRk;
        public String planNM;
        public String insuranceProductCd;
        public String saleEffectiveDt;
        public String planTypeCD;
        public String planClassCD;
        public String saleExpirationDt;
        public String key;
        public String terminationDt;
        public String totalRecordCount;
        public String productCategoryRk;
        public String lobRk;
        public String policyProductFormCd;
        public String guarRateInd;

        public EIP_IcAx_AXAAsiaLifePolicySegment[] hasPolicySegmentDetailsIn;
        public EIP_IcAx_AXAAsiaLifeInsurancePlanDetails[] hasPlanDetailsIn;
        public EIP_IcAx_AXAAsiaaBenefit[] hasBenefitDetailsIn;
        public EIP_AgSa_LifeProduct hasDetailsRecordIn;
        //Catur 20200730, getAdminFee
        public EIP_AgSa_NameValue[] hasNameValue;
    }

    public class EIP_IcAx_AXAAsiaParty{
        public String parentPartyCD;
        public String partyCD;
        public String partyID;
        public String partyNO;
        public String partyStatus;
        public String effNominationDT;
        public String termRk;
        public String branchCD;
        public String servicingCD;
        public String producingCD;
        public String[] partyRoleCD;
        public String validFromDttm;
        public String partyTypeCD;
        public EIP_IcAx_AXAAsiaIndividual canBeIndividual;
        public EIP_IcAx_AXAAsiaPartyAccount hasPartyAccountDetailsIn;
        public EIP_IcAx_AXAAsiaInternalOrg canBeInternalOrg;
        public EIP_AgSa_NameValue[] hasNameValue;
    }

    public class EIP_AgSa_NameValue{
        public String value;
        public String name;
    }

    public class EIP_IcAx_AXAAsiaCustomer{
        public String customerID;
        public String customerRK;
        public String customerTypeCD;
        public String customerStatusCD;
        public String customerClassCD;
        public String telephonableFlg;
        public String relatedPolicy;
        public String relatedPolicyholdersCnt;
        public String sourceCInd;
        public String watchlistInd;
        public String numRelations;
        public String parties;
        public String processedDttm;
        public String terminationDt;
        public String validFromDttm;
        public String validToDttm;
        public String firstBecameCustomerDt;
        public String staffStatusCD;
        public String crossSellableFlg;
        //Catur, 20200730, getAdminFee
        public String ownerIND;
        
        //Faizir, 20201006, getcustomerlist
        public String documentID;
        
        //Catur, 20211012, EDMu
        public String dependentNO;

        public EIP_AgSa_RelationContact hasRelationContact;
        public EIP_IcAx_AXAAsiaIndividual canBeIndividual;
        public EIP_canBeExternalOrg canBeExternalOrg;
        public EIP_AgSa_InsurancePolicy[] hasPolicyAccount;
        public EIP_AgSa_NameValue[] hasNameValue;
        public EIP_CustomerCommunication[] haveCommunicatedMessage;
    }
    
    public class EIP_canBeExternalOrg {
        public String natureOfBusinessCd;
    }
    
    public class EIP_IssuerAssociated{
        public String issuerID;
        public String issuerAppID;
        public String issuerRk;
    }

    public class EIP_IcAx_AXAAsiaSubAccount{
        public String usageCd;
        public EIP_AgSa_InvestmentFund[] hasInvestmentFundDetailsIn;
    }

    public class EIP_AgSa_InvestmentFund{
        public String investmentFundCd;
        public String fundAllocation;
        public String unitPrice;
        public String totalUnits;
        public String totalFundAmount;
        public String navDt;
        public String unitPriceAsOfDt;
        public String valuationDt;
        public String fundCurrencyCd;
        public String investmentFundRk;
        public String saleEffectiveDt;
        public String saleExpirationDt;
    }
    
    public class EIP_IcAx_AXAAsiaBeneficiaryXUoe{
        public String benefitDistributionPCT;
        public String relationshipToInsuredCD;
    }

    public class EIP_IcAx_AXAAsiaLifePolicyTrans{
        public String transTypeCD;
        public String transDesc;
        public String processedDttm;
        public String transDT;
        public String transactionStatusCD;
        public String remark;
        public String paymentMethodCD;
        public String paymentTypeCD;
        public String paymentDueDT;
        public String settledDT;
        public String settledAMT;
        public String key;
        public String unitPriceAsOfDt;
        public String unitValue;
        public String unitValuationDT;
        public String totalUnits;
        public String transModeCD;
        public String transCurrencyCD;
        public String annuityContributionAmt;
    }

    public class EIP_IcAx_AXAAsiaLifePolicyChangeTrans{
        public String startPremiumHolidayDT;
        public String endPremiumHolidayDT;
    }

    public class EIP_IcAx_AXAAsiaApplicationDetails{
        public String applicationDTTM;
        
        //add to get data from MDM by Faizir (02-03-2020)
        public String requestedPolicyDT;
        public String applicationTypeCD;
        public String underwritingDT;
        public String underwriterNM;  
        public String applicationNO;
        public String applicationStatusCD;
    }

    public class EIP_IcAx_AXAAsiaPartyAccount{
        public String accountNO;
        public String payorFirstNM; 
        public String payorLastNM;
        public String accountEffectiveDT;
        public String accountExpirationDT;
        public String accountTypeCD;
        public String accountStatusCD;
        public String bankName;
        public String branchCD;
        public String rejectCD;
        public String rejectDT;
        public String cardTokenNumber;
        public String accessToken;
        // catur 20200727, added account detail for AFI
        public String accountBankCD;
    }

    public class EIP_IcAx_AXAAsiaInternalOrg{
        public String orgShortNm;
    }

    public class EIP_IcAx_AXAAsiaLifeInsuranceClaim{
        public String claimReferenceID;
        public String claimTypeCd;
        public String claimRk;
        public String claimOpenDTTM;
        public String claimApprovalDTTM;
        public String claimStatusCD;
        public String claimStatusRk;
        public String claimStatusDesc;
        public String claimEndAMT;
        public String remarks;
        public String key;
        public String letterCD;
        public EIP_IcAx_AXAAsiaClaimDetails[] hasClaimDetails;
        public EIP_IcAx_AXAAsiaClaimUnit[] hasClaimUnitIn;
        
        //Added by Dimas Support MII 07/02/2025
        public String claimStatusChangeDTTM;
        public String processedDttm;
    }
    
    public class EIP_IcAx_AXAAsiaClaimDetails{
        public String reason1;
        public String reason2;
        public String remarks;
    }

    public class EIP_IcAx_AXAAsiaClaimUnit{
        public String claimedAMT;
        public String claimRK;
        public String claimUnitRK;
    }

    public class EIP_IcAx_AXAAsiaLifePolicySegment{
        public String sumInsured;
        // catur 20200727, getloanhistory
        public String tbFV;
        public String rbFV;
    }

    public class EIP_IcAx_AXAAsiaLifeInsurancePlanDetails{
        public String planSI;
        public String premium;
        public String planStatus;
        public String modalPlanLoading;
    }

    public class EIP_IcAx_AXAAsiaLifePolicyDetails{
        public String loanRepaymentAmt;
        public String gdbValue;
        public String dividendAmt;
        public String futurePremiumDpIntTypeCode;
        public String futurePremiumDpAmt;
        public String loanIntTypeCd;
        public String dividendTypeCD;
        public String uwRemark1;
        public String uwRemark2;
        public String uwRemark3;
    }

    public class EIP_IcAx_AXAAsiaIndividualAddress{
        public String addressLine1;
        public String addressLine2;
        public String addressLine3;
        public String addressLine4;
        public String emailAddress;
        public String emailAddress2;
        public String mobilePhoneNO;
        public String mobilePhoneNO2;
        public String telephoneNO;
        public String telephoneNO2;
        public String officeTelNo;
        public String officeAddressLine1;
        public String officeAddressLine2;
        public String officeAddressLine3;
        public String officeAddressLine4;
        public String provinceNm;
        public String countyNm;
        public String subdistrictNm;
        public String stateRegionCd;
        public String villageNm;
        public String hamletNo;
        public String neighbourhoodNo;
        public String faxNO;
        public String faxNO2;
        public String postalCD;
        public String cityNM;
        public String addressTypeCD;
        public String validFromDttm;
        public String individualRK;
        public String individualAddressRk;
        public String primaryAddressFlg;
        public String masterIndividualId;
        //added by Fajar
        public String createdDate;
        public String sendTo;
        public String sendDate;
        public String emailMDM;
        public String phoneNumberMDM;
        public String lastLogin;
    }

    public class EIP_PnCClaim_CLAIM{
        public String claimNumber;
        public String claimStatusDesc;
        public String branchCode;
        public String notificationDate;
        public String claimOpenDate;
        public String lossDate;
        public String description;
        public String approvalPaymentDate;
        public String claimPaymentDate;
        public String coverageCode;
        public String dischargeDate;
        public String totalClaimAmount;
        // add by Faizir
        public String claimantNumber;
        public String lossCause;
        public String totalPaidAmount;
        public String claimSubmissionDate;
        public String claimStatusCode;
        public EIP_PnCClaim_MotorClaim hasMotorClaim;
        public EIP_PnCClaim_POLICY_PartyRole[] hasClaimPartyRoles;
        // Added by Dimas Support MII 27/05/2025
        public String entityCode;
        public String serviceProviderId;
		public String claimTypeCode;
        public String claimStageDescription;
        public String servicingAgentCode;
        public String policyType;
        public String policyNumber;
        public String preAuthorizationNumber;
        public String providerNetworkCode;
        public String firstApprovalDate;
        public String lastApprovalDate;
        public String totalApprovedAmount;
    }

    public class EIP_PnCClaim_POLICY_PartyRole{
        public EIP_IcAx_AXAAsiaIndividual canBeIndividual;
        public String type;
        public String description;
    }

    public class EIP_PnCClaim_MotorClaim{
        public String repairShop;
        public EIP_PnCClaim_ClaimAccidentDetails hasClaimAccidentDetails;
        public EIP_PnCClaim_MotorClaimDriverDetails hasMotorClaimDriverDetails;
    }

    public class EIP_PnCClaim_ClaimAccidentDetails{
        public String accidentPlace;
    }

    public class EIP_PnCClaim_MotorClaimDriverDetails{
        public EIP_IcAx_AXAAsiaIndividual canBeIndividual;
    }

    public class EIP_IcAx_AXAAsiaaBenefit{
        public String benefitCD;
        public String benefitRK;
        public String benefitAMT;
        public String benefitDESC;
    }
    
    public class EIP_AgSa_LifeProduct{
        public String key;
        public String minAnnualizedPayment;
        public String minModalPayment;
    }

    public class EIP_IcAx_AXAAsiaPolicyPaymentAccount{
        public String statusCD;
        
        //add to get Data  from MDM by Faizir (02-03-2020)
        public String validFromDttm;
        public String accountNO;
        public String partyAccountNM;
        public String bankNO;
        public String accountBankCD;
        public String branchNO;
        public String accountTypeCD;
        public String approvalCD;

    }

    public class EIP_ProspectDetail{
        public EIP_IcAx_AXAAsiaLifeInsuranceProduct[] hasProductDetails; 
    }

    public class EIP_CustomerCommunication{
        public String message;
        public String deliveryStatusCD;
        public String deliveryStatusDesc;
        public String deliveryDT;
        //added by @Fajar Salam
        public String target;
        public String messageID;
        public String replyTo;
        public String additionalRk;
        public String channelID;
        public String chargeAmt;
        public String bizContext;
        public String effectiveDT;
        //added by @Adi Wijaya 2023-26-03
        public String messageType;
        public String triggeredBy;
        public String sender;
        public String bizDivision;
    }

    public class EIP_AgSa_InvestmentDetails{
        public String pooledInd;
        public String eeContribAmt;
        public String erContribAmt;
        public String liabilityAmt;
    }
    
    //added by Ichwan 11/25/2024
    public class EIP_AgSa_CommunicationList {
    	public EIP_AgSa_RLSPolicy RLSPolicy;
    }
    
    public class EIP_AgSa_RLSPolicy {
        public String policyNumber;
        public EIP_AgSa_RequestParameter STPRequestParameter;
        public EIP_AgSa_PolicyServicings[] policyServicings;
    }
    
    public class EIP_AgSa_RequestParameter {
        public String countryCode;
    }
    
    public class EIP_AgSa_PolicyServicings {
        public String creationDate;
        public String creationTime;
        public String userId;
        public String sectionCode;
        public String referenceNumber;
        public EIP_AgSa_ServicingLineItems[] policyServicingLineItems;
    }
    
    public class EIP_AgSa_ServicingLineItems {
        public String lineNumber;
        public String assessmentDetailDescription;
    }
    
    public String toStringJSON(){
        String sJson = null;
        try{
            sJson = (String)System.JSON.serialize(this, true);
        }catch(Exception e){
            System.debug('error to String JSON : '+ e.getMessage());
        }
        return sJson;
    }
}