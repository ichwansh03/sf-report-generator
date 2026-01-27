@isTest
public class Axa2_Json_T
{
    static Axa2_Json getObj()
    {
		String data = '{"RecordClaimsRequest":{"STPRequestParameter":{"requestCaptureDate":"2017-06-11","userId":"IDDIGIHCLM","countryCode":"IB"},"RLSClaim":{"policyNumber":"814-9399886","claimStatusCode":"S","lossReportDate":"2017-06-02","creditAccountAuthorization":[{"authorizationStatusCode":"D","bankAccountNumber":"888888889","confirmationDate":"2017-06-12","premiumEffectiveDate":"2017-06-12","processingDate":"2017-06-12","accountTypeCode":"axa","subTransactionNumber":"3","depositBankBranch":{"bankCode":"MTB","branchCode":"MTB2"},"payee":{"fullName":"FullNametest"}},{"authorizationStatusCode":"D","bankAccountNumber":"999999998","confirmationDate":"2017-06-12","premiumEffectiveDate":"2017-06-12","processingDate":"2017-06-12","accountTypeCode":"ssc","subTransactionNumber":"6","depositBankBranch":{"bankCode":"SSC","branchCode":"SSC2"},"payee":{"fullName":"fullNametest2"}}],"claimBenefits":[{"paidBenefitAmount":"4000","claimedBenefitDayCount":"6","paidBenefitDayCount":"4","claimedBenefitAmount":"5000","benefitCode":"MSH25F0","rejectedBenefitAmount":"30000.15","rejectionReasonDescription":"Testing"},{"paidBenefitAmount":"2000","claimedBenefitDayCount":"6","paidBenefitDayCount":"7","claimedBenefitAmount":"111","benefitCode":"MSH25F0","rejectedBenefitAmount":"12500","rejectionReasonDescription":"saysaysayheyhey"}]}}}';
		Axa2_Json obj = new Axa2_Json(data);
        return obj;
    }
    
    @isTest static void Const()
    {
        Axa2_Json obj = new Axa2_Json();
        System.assertEquals(null, obj.getData());
    }
    
    @isTest static void getData()
    {
        Axa2_Json obj = getObj();
		Object oJson;
        oJson = obj.getData(null);
        System.assertEquals(oJson, oJson);
        oJson = obj.getData('');
        System.assertEquals(oJson, oJson);
        oJson = obj.getData('RecordClaimsRequest.STPRequestParameter.countryCode');
        System.assertEquals('IB', oJson);
    }
    
    @isTest static void setData()
    {
        Axa2_Json obj = new Axa2_Json();
        obj.setData(null);
        System.assertEquals(null, obj.getData());
        obj.setData('');
        System.assertEquals(null, obj.getData());
        obj.setData('x');
        System.assertEquals(null, obj.getData());
        
        obj = getObj();
        obj.setData(obj.getData(), 'RecordClaimsRequest.STPRequestParameter.countryCode');
        System.assertEquals('IB', obj.getData());
    }
    
    @isTest static void setPath_getLocation()
    {
        Axa2_Json obj = getObj();
        obj.setPath('RecordClaimsRequest.RLSClaim');
        Object oJson = obj.getLocation(null);
        System.assertEquals(null, oJson);
        oJson = obj.getLocation('');
        System.assertEquals(null, oJson);
        
        obj.setPath('claimBenefits');
        oJson = obj.getLocation('0.paidBenefitAmount');
        
        obj.setPath('0');
        oJson = obj.getLocation('abc');
        System.assertEquals(null, oJson);
        
        oJson = obj.getData('paidBenefitAmount');
        System.assertEquals('4000', oJson);
        
        obj.setPath('paidBenefitAmount');
        String sJson = obj.toString();
        System.assertEquals('"4000"', sJson);
    }
    
    @isTest static void getTypeShort()
    {
        String sTemp = 's';
        String sType = Axa2_Json.getTypeShort(sTemp);
        System.assertEquals('String', sType);
    }
}