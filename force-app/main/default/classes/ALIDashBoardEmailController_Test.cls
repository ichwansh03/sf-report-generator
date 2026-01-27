@istest
private class ALIDashBoardEmailController_Test {
	static testMethod void test_UseCase1(){
    	ALIDashBoardEmailController aaa = new ALIDashBoardEmailController();
        aaa.LastOpenEmailAll = datetime.now();
        aaa.FirstOpenEmailAll = datetime.now();
        aaa.CountOpenCaseAll = 1;
        aaa.CountClosedCaseAll = 1;
        aaa.LastOpenEmailAllID='test';
        aaa.FirstOpenEmailAllID='test';
        aaa.LastOpenEmailAllNumber='test';
        aaa.FirstOpenEmailAllNumber='test' ;
        
        aaa.LastOpenEmailAgent= datetime.now();
        aaa.FirstOpenEmailAgent = Datetime.now();
        aaa.CountOpenCaseAgent = 1;
        aaa.CountClosedCaseAgent = 1;
        aaa.LastOpenEmailAgentID = 'test';
        aaa.FirstOpenEmailAgentID = 'test';
        aaa.LastOpenEmailAgentNumber = 'test';
        aaa.FirstOpenEmailAgentNumber = 'test';
        
        
    }
}