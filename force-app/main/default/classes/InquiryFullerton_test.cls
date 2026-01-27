@isTest
public class InquiryFullerton_test {
	static testmethod void testInquiry(){
        
        String firstName = 'rose';
        String lastName = 'rose';
        String username = 'rose';
        String uniqueNumber = 'rose';
        String mobileNumber = '081222121';
        Date dob = Date.today();
        String dobString = '2021-01-01';
        Test.setMock(HttpCalloutMock.class, new InquiryFullerton_testMock());
        Test.startTest();
        InquiryFullertonController controller = new InquiryFullertonController();
        controller.firstName = firstName;
        Test.setCurrentPage(Page.InquiryFullertonForm);
        controller.inquiry();
        
        Datetime now = Datetime.now();
		String todayDt = now.format('yyyy-MM-dd');
        //FUND HISTORY
        controller.nextPage();
        controller.previousPage();
        
        Test.stopTest();
    }
}