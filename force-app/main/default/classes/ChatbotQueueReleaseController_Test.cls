@isTest
public class ChatbotQueueReleaseController_Test {
    
    static testmethod void testQueueRelease(){
        ChatbotQueueReleaseController ctrl = new ChatbotQueueReleaseController();
        ctrl.queueRelease(); //error
        
        Test.setMock(HttpCalloutMock.class, new ChatbotQueueReleaseMock());
        ctrl.queueRelease(); //success
        
    }

}