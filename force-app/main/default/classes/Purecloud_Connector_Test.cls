@isTest
public class Purecloud_Connector_Test {
	static testMethod void myTest() {
        
        String clientId = label.Purecloud_ClientId;
        String clientSecret = label.Purecloud_ClientSecret;
        String connId = label.PureCloud_connId;
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('RequestToken_DummyResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        Purecloud_Connector.execute();
        Test.stopTest(); 
    }
}