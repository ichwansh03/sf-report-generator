@isTest
public class CommonClassTest{
    public static testMethod void testNumberGen(){
        Date dateToday = Datetime.newInstance(2015,4,28).date();
        Date dateYesterday = Datetime.newInstance(2015,4,27).date();
        Date date3DaysBefore = Datetime.newInstance(2015,4,25).date();
        Date date7DaysBefore = Datetime.newInstance(2015,4,21).date();
        Date dateLaborDay = Datetime.newInstance(2015,5,1).date();
        /*
        List<Holiday> holList = new List<Holiday>();
        Holiday hol3daysbefore = new Holiday();
        hol3daysbefore.Name='Test holiday';
        hol3daysbefore.IsAllDay = true;
        hol3daysbefore.activitydate = System.Today();
        holList.add(hol3daysbefore);

        Holiday hol = new Holiday();
        hol.Name='Test holidayToday';
        hol.IsAllDay = true;
        hol.activitydate = System.Today();
        holList.add(hol);

        insert holList;
        */
        
        CommonClass com = new CommonClass();
        boolean isTodayWorkingDay = com.checkifItisWorkingDay(dateToday);
        system.debug('>>>> isTodayWorkingDay : '+isTodayWorkingDay);
        system.assertEquals(true,isTodayWorkingDay);

        boolean is3daysBeforeWorkingDay = com.checkifItisWorkingDay(date3DaysBefore);
        system.debug('>>>> is3daysBeforeWorkingDay : '+is3daysBeforeWorkingDay);
        system.assertEquals(false,is3daysBeforeWorkingDay);

        boolean is7daysBeforeWorkingDay = com.checkifItisWorkingDay(dateToday);
        system.debug('>>>> is7daysBeforeWorkingDay : '+is7daysBeforeWorkingDay);
        system.assertEquals(true,is7daysBeforeWorkingDay);

        boolean isLaborDayWorkingDay = com.checkifItisWorkingDay(dateLaborDay);
        system.debug('>>>> isLaborDayWorkingDay: '+isLaborDayWorkingDay);
        system.assertEquals(false,isLaborDayWorkingDay);
        
        
        integer workingDayBetween3DaysBeforeAndToday = com.calculateWorkingDaysBetweenTwoDates(date3DaysBefore,dateToday);
        system.debug('>>>> workingDayBetween3DaysBeforeAndToday : '+workingDayBetween3DaysBeforeAndToday);
        system.assertEquals(1,workingDayBetween3DaysBeforeAndToday);
        
        integer workingDayBetween7DaysBeforeAndToday = com.calculateWorkingDaysBetweenTwoDates(date7DaysBefore,dateToday);
        system.debug('>>>> workingDayBetween7DaysBeforeAndToday : '+workingDayBetween7DaysBeforeAndToday);
        system.assertEquals(5,workingDayBetween7DaysBeforeAndToday);

        integer workingDayBetweenYesterdayAndToday = com.calculateWorkingDaysBetweenTwoDates(dateYesterday,dateToday);
        system.debug('>>>> workingDayBetweenYesterdayAndToday: '+workingDayBetweenYesterdayAndToday);
        system.assertEquals(1,workingDayBetweenYesterdayAndToday);

        integer workingDayBetweenTodayAndLaborDay = com.calculateWorkingDaysBetweenTwoDates(dateToday,dateLaborDay);
        system.debug('>>>> workingDayBetweenTodayAndLaborDay: '+workingDayBetweenTodayAndLaborDay);
        system.assertEquals(3,workingDayBetweenTodayAndLaborDay);
        
        /*
        Test.startTest();
        Integer emailBeforeSendingCounter = Limits.getEmailInvocations();
        EmailTemplate et = [SELECT id FROM EmailTemplate limit 1];
        //boolean isSuccess = com.doSendEmail('wawankn@yahoo.com', 'wawan.kartawan@gmail.com', et.Id, 'MAGI') ;
        Integer emailAfterSendingCounter = Limits.getEmailInvocations();
        
        //system.debug('>>>> isSuccess : '+isSuccess);
        system.debug('>>>> emailBeforeSendingCounter : '+emailBeforeSendingCounter );
        system.debug('>>>> emailAfterSendingCounter : '+emailAfterSendingCounter );
        system.assertNotEquals(emailBeforeSendingCounter, emailAfterSendingCounter);
        //system.assertEquals(true, isSuccess);
        Test.stopTest();
		*/
		
        Test.startTest();
		Account acc = new Account(name='acc test',entity__c = 'AFI');
		insert acc;
		
		contact ct = new contact(lastname='testnama', policy_no__c='112233',entity__c='AFI',accountid=acc.id);
		insert ct;
		
		List<case> caseList = new List<case>();
		case c1 = new case(e2cSubject__c='SALDO xx1', e2cPolicy_No__c=ct.policy_no__c, e2cPayToDate__c='2015-05-31', e2cNAV__c=null, e2cSaldo__c=null, e2cContactId__c=ct.id);
		caselist.add(c1);		
		
		case c2 = new case(e2cSubject__c='PAYDT xx1', e2cPolicy_No__c=ct.policy_no__c, e2cPayToDate__c='2015-06-30', e2cNAV__c=null, e2cSaldo__c=null, e2cContactId__c=ct.id);
		caselist.add(c2);

		case c3 = new case(e2cSubject__c='NAV xx1', e2cPolicy_No__c=ct.policy_no__c, e2cPayToDate__c='2015-06-30', e2cNAV__c=null, e2cSaldo__c=null, e2cContactId__c=ct.id);
		caselist.add(c3);
		
		insert caselist;		

		CommonClass.callWS(c1.id+'::'+c2.id+'::'+c3.id);
        //system.assert(c1.e2cSaldo__c!=null);
        //system.assert(c1.e2cPayToDate__c!=null);
        //system.assert(c1.e2cNAV__c!=null);
		       
        Test.stopTest();

    }

}