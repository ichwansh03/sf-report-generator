@isTest
public class BookingCallCR_Test {
    
    @testSetup
    static void setupData() {
        // Account & Contact
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        Contact c = new Contact(
            LastName = 'Test Contact',
            Email = 'test@example.com',
            MobilePhone = '08123456789',
            AccountId = acc.Id
        );
        insert c;
        
        // Call List yg CreatedDate -2 hari kerja (positif case)
        Call_List__c clistValid = new Call_List__c(
            case_type__c = 'Withdrawal',
            Expired_Date__c = Date.newInstance(2030, 9, 30),
            ACTIVITY__C = 'Collection'
        );
        insert clistValid;
        //Date targetDate = BookingCallCR.getPreviousWorkday(Date.today(), 2);
        // Datetime startOfDay = DateTime.newInstance(targetDate, Time.newInstance(0,0,0,0));
        //Test.setCreatedDate(clistValid.Id, startOfDay);
        
        // Call List yg CreatedDate = today (negatif case)
        Call_List__c clistInvalid = new Call_List__c(
            case_type__c = 'Welcome Call',
            Expired_Date__c = Date.newInstance(2030, 9, 30),
            ACTIVITY__C = 'Collection'
        );
        insert clistInvalid;
        
        Call_List__c refreshedList = [SELECT Id, createdDate, Campaign_Type__c FROM Call_List__c WHERE Id = :clistValid.Id];
        System.debug('Campaign_Type__c di Call_List: ' + refreshedList.Campaign_Type__c);
        System.debug('createdDate di Call_List: ' + refreshedList.createdDate);
        
        RecordType recId = getRecordTypeId('Collection AMFS 6', 'Call_Line__c');
        Call_List__c calist = new Call_List__c(Activity__c = 'Collection',
                                               Case_Type_Config__c = 'Withdrawal',
                                               Expired_Date__c = Date.newInstance(2030, 9, 30),
                                               Entity__c = 'AMFS'
                                               
                                               //RecordTypeId = recId.Id
                                              );
        
        insert calist;
        
        Date targetDate = BookingCallCR.getPreviousWorkday(Date.today(), 2);
        System.debug('Target Date test = ' + targetDate);
        Datetime startOfDay = DateTime.newInstance(targetDate, Time.newInstance(7,0,0,0));
        Test.setCreatedDate(clistValid.Id, startOfDay);
        
        // (tidak diubah CreatedDate, jadi default = today)
        
        // Call Line untuk positif case
        Call_Line__c clineValid = new Call_Line__c(
            Entity__c = 'AMFS',
            Contact__c = c.Id,
            Policy_No__c = 'PN123',
            Contacted_Number__c = '08123456789',
            Activity_Result__c = 'F',
            Call_List__c = clistValid.Id
        );
        insert clineValid;
        clineValid.Activity_Result__c = 'F';
        update clineValid;
        
        Call_Line__c refreshedLine = [SELECT Id, Entity__c, Campaign_Type__c, Contact__r.AccountId, Contact__r.Email, 
                                                   Contact__r.LastName, Contact__r.MobilePhone, Name, Policy_No__c, Contacted_Number__c, 
                                                   WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c, 
                                                   Campaign_Name__c, Call_List__r.createdDate FROM Call_Line__c WHERE Id = :clineValid.Id];
        System.debug('Campaign_Type__c di Call_Line: ' + refreshedLine.Campaign_Type__c);
        System.debug('Campaign_Type__c di Call_Line2: ' + refreshedLine.Activity_Result__c);
        System.debug('Campaign_Type__c di Call_Line2: ' + refreshedLine.Call_List__r.createdDate);
        
        // Call Line untuk negatif case
        Call_Line__c clineInvalid = new Call_Line__c(
            Entity__c = 'AMFS',
            Contact__c = c.Id,
            Policy_No__c = 'PN456',
            Contacted_Number__c = '08198765432',
            Activity_Result__c = 'F',
            Verification__c = 'Y',
            Call_List__c = clistInvalid.Id
        );
        insert clineInvalid;
    }
    
    static RecordType getRecordTypeId(string recordTypeName, string sObjectName)
    {
        RecordType result;
        list <RecordType> recordTypeList = [
            SELECT Id, Name, SObjectType 
            FROM RecordType 
            WHERE SObjectType = :sObjectName ORDER BY Name
        ];
        for(RecordType recordType: recordTypeList)
        {
            if(recordType.Name.equalsIgnoreCase(recordTypeName))
            {
                result = recordType; 
                break;
            }
        }
        
        return result;
    }
    
    @isTest
    static void testExecute_DirectCall() {
        Test.startTest();
        new BookingCallCR().execute(null);
        Test.stopTest();
    }
}