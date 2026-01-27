@isTest
public class callLineReschedule_testClass {
    @isTest static void testReschedule(){
        Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
        User u = [Select id, profile.name from User where id =: UserInfo.getUserId()];
        System.runAs(u){
            Call_Line__c callL = new Call_Line__c();
            
            callL.Policy_No__c = '1425364';
            callL.WelcomeCall_Schedule_Date__c = datetime.now();
            callL.WelcomeCall_Call_Line_Status__c = 'Open';
            callL.RecordTypeId = recTypeWC;
            //callL.Activity_Result__c = 'Uncontacted';
            //callL.Verification__c = 'Agree';
            
            insert callL;
                 
            Purecloud_Connector__c pc = new Purecloud_Connector__c();
            pc.name = 'Purecloud Token';
            pc.Access_Token__c = '123123123123';
            insert pc;
            
            PageReference testPageReschedule = Page.callLineReschedule;
            testPageReschedule.getParameters().put('id', callL.Id);
            Test.setCurrentPageReference(testPageReschedule);
            //System.currentPageReference().getParameters().put('id', callL.Id);
            apexpages.StandardController stdCon = new ApexPages.StandardController(callL);
            
            callLineReschedule testRes = new callLineReschedule(stdCon);
            
            testRes.getcallOptions();
            // Taufik, add couverage
            testRes.newSchedule = datetime.now();
            testRes.redirectClId = 'Test';
            
            testRes.current_page = 1;
            testRes.skip = 0;
            testRes.take = 10;
            testRes.total_page = 5;
            testRes.to_page = 2; 
            testRes.getDataNext();
            testRes.getDataPrevious();
            testRes.getDataToPage();
            testRes.getDataFirst();
            testRes.getDataLast();
            testRes.showListPagination(); 
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = null;
            testRes.saveReschedule();
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day());
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.parse('10/10/2018 10:36 AM');
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(), 8,0,0);
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+3, 13,0,0);
            testRes.saveReschedule();
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+1, 13,0,0);
            testRes.currentCL.Activity_Result__c = null;
            testRes.saveReschedule();
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+1, 7,0,0);
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+1, 13,0,0);
            testRes.currentCL.Activity_Result__c = 'Uncontacted';
            testRes.currentCL.Verification__c = 'Agree';
            
            testRes.saveReschedule();
            
            testRes.UpdateCallLineStatus();
            
            testRes.redirectCallLine();
                
            testRes.currentCL.Activity_Result__c = 'Contacted';
            testRes.currentCL.Verification__c = 'Agree';
            testRes.saveReschedule();
            
            testRes.UpdateCallLineStatus();
            
            testRes.redirectCallLine();
        }
    }

    @isTest static void testReschedule2(){
        Id recTypeWC = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
        User u = [Select id, profile.name from User where id =: UserInfo.getUserId()];
        System.runAs(u){
            
                 
            Purecloud_Connector__c pc = new Purecloud_Connector__c();
            pc.name = 'Purecloud Token';
            pc.Access_Token__c = '123123123123';
            insert pc;
            
            Call_Line__c callL = new Call_Line__c();
            
            callL.Policy_No__c = '1425364';
            callL.WelcomeCall_Schedule_Date__c = datetime.now();
            callL.WelcomeCall_Call_Line_Status__c = 'Open';
            callL.RecordTypeId = recTypeWC;
            //callL.Activity_Result__c = 'Uncontacted';
            //callL.Verification__c = 'Agree';
            
            insert callL;
            
            PageReference testPageReschedule = Page.callLineReschedule;
            testPageReschedule.getParameters().put('id', callL.Id);
            Test.setCurrentPageReference(testPageReschedule);
            //System.currentPageReference().getParameters().put('id', callL.Id);
            apexpages.StandardController stdCon = new ApexPages.StandardController(callL);
            
            callLineReschedule testRes = new callLineReschedule(stdCon);
            
            testRes.getcallOptions();
            // Taufik, add couverage
            WelcomeCal_Schedule__c newsch = new WelcomeCal_Schedule__c();
            newsch.Name = 'Reschedule Time';
            newsch.Start_Hour__c = Datetime.newInstance(2018, 1, 11, 19, 0, 0); //datetime.valueof('2018-11-01T01:00:00.000+0000');
            newsch.End_Hour__c = Datetime.newInstance(2018, 1, 11, 8, 0, 0); //datetime.valueof('2018-11-01T12:00:00.000+0000');
            newsch.FgWeekend__c = TRUE;
            insert newsch;
            testRes.newSchedule = datetime.now();
            testRes.redirectClId = 'Test';
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = null;
            testRes.saveReschedule();
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day());
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.parse('10/10/2018 10:36 AM');
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day(), 8,0,0);
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+3, 13,0,0);
            testRes.saveReschedule();
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+1, 13,0,0);
            testRes.currentCL.Activity_Result__c = null;
            testRes.saveReschedule();
                
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+1, 7,0,0);
            testRes.saveReschedule();
            
            testRes.newCallDate.WelcomeCall_Schedule_Date__c = datetime.newInstance(Date.today().year(), Date.today().month(), Date.today().day()+1, 13,0,0);
            testRes.currentCL.Activity_Result__c = 'Uncontacted';
            testRes.currentCL.Verification__c = 'Agree';
            
            testRes.saveReschedule();
            
            testRes.UpdateCallLineStatus();
            
            testRes.redirectCallLine();
                
            testRes.currentCL.Activity_Result__c = 'Contacted';
            testRes.currentCL.Verification__c = 'Agree';
            testRes.saveReschedule();
            
            testRes.UpdateCallLineStatus();
            
            testRes.redirectCallLine();
        }
    }
}