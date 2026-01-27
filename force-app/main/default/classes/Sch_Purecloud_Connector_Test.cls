@isTest
public class Sch_Purecloud_Connector_Test {
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
        Sch_PurecloudConnector sh1 = new Sch_PurecloudConnector();
		String sch = '0 0 23 * * ?';
        system.schedule('Sch_PurecloudConnector', sch, sh1); 
        
        Test.stopTest();
        
    }
}