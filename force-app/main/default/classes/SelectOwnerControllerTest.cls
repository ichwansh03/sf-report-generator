@isTest
public class SelectOwnerControllerTest {
    
    @testSetup  
    static void setup() {
        // Create test users
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
         Profile pDispatcher = [SELECT Id FROM Profile WHERE Name = 'Inbound Agent A-AMFS' LIMIT 1];
        User testUser = new User(
            Username = 'testuser' + System.currentTimeMillis() + '@test.com.test',
            LastName = 'TestUser',
            Email = 'testuserAdmin@test.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'Asia/Jakarta',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            Entity__c ='AMFS',
            IsActive = true,
            ProfileId = p.Id
        );
        insert testUser;

              User syariahUser = new User(
           Username = 'syariah' + System.currentTimeMillis() + '@test.com.test',
            LastName = 'SyariahUser',
            Email = 'syariah@test.com',
            Alias = 'syariah',
            TimeZoneSidKey = 'Asia/Jakarta',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            Entity__c ='AMFS',
            IsActive = true,
            ProfileId = pDispatcher.Id
        );
        insert syariahUser;
        
        // Create dispatcher group
      
        Group csQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS Dispatcher' LIMIT 1];
                Group pbcQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - PBC' LIMIT 1];
        // Add user to dispatcher group



         System.runAs(testUser) {
            GroupMember dispatcherMember = new GroupMember(
                GroupId = csQueue.Id, 
                UserOrGroupId = testUser.Id
            );
            insert dispatcherMember;

            GroupMember syariahGroupMember = new GroupMember(
                GroupId = csQueue.Id, 
                UserOrGroupId = syariahUser.Id
            );
            insert syariahGroupMember;
     }


        // Create agent group  
        // Group pbcQueue = new Group(Name = 'AMFS E2C - PBC', Type = 'Queue');
        // insert agentGroup;
        
        // // Add agent group to queue
        // GroupMember queueMember = new GroupMember(
        //     GroupId = amfsQueue.Id,
        //     UserOrGroupId = agentGroup.Id
        // );
        // insert queueMember;
        
        // // Add user to agent group
        // GroupMember agentMember = new GroupMember(
        //     GroupId = agentGroup.Id,
        //     UserOrGroupId = testUser.Id
        // );
        // insert agentMember;
        
        // Create test case
        Case testCase = new Case(
            Subject = 'Test Case',
            Status = 'New',
            Priority = 'Medium',
            ownerId = testUser.Id
        );
        insert testCase;
    }
    
    
    @isTest
    static void testConstructorForDispatcher() {
        User testUser = [SELECT Id FROM User WHERE Email = 'testuserAdmin@test.com' LIMIT 1];
        Case testCase = [SELECT Id FROM Case LIMIT 1];
        
        System.runAs(testUser) {
            Test.setCurrentPage(Page.VF_Select_Owner);
            ApexPages.currentPage().getParameters().put('ids', testCase.Id);
            
            Test.startTest();
            SelectOwnerController controller = new SelectOwnerController();
            Test.stopTest();
            
            System.assertEquals(true, controller.isDispatcher, 'User should be dispatcher');
            System.assert(controller.selectedCases.size() == 1, 'Should have one selected case');
            System.assert(controller.queueOptions.size() > 1, 'Should have queue options');
        }
    }
    @isTest
    static void testConstructorForAsNotAdmin() {
        User testUser = [SELECT Id FROM User WHERE Email = 'syariah@test.com' LIMIT 1];
        Case testCase = [SELECT Id FROM Case LIMIT 1];
        
        System.runAs(testUser) {
            Test.setCurrentPage(Page.VF_Select_Owner);
            ApexPages.currentPage().getParameters().put('ids', testCase.Id);
            
            Test.startTest();
            SelectOwnerController controller = new SelectOwnerController();
            Test.stopTest();
            
            System.assertEquals(true, controller.isDispatcher, 'User should be dispatcher');
            System.assert(controller.queueOptions.size() > 1, 'Should have queue options');
        }
    }
    
    @isTest
    static void testConstructorForNonDispatcher() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User nonDispatcherUser = new User(
            Username = 'nondispatcher@test.com.test',
            LastName = 'NonDispatcher', 
            Email = 'nondispatcher@test.com',
            Alias = 'ndisp',
            Entity__c ='AMFS',
            TimeZoneSidKey = 'Asia/Jakarta',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = p.Id
        );
        insert nonDispatcherUser;
        
        Case testCase = [SELECT Id FROM Case LIMIT 1];
        
        System.runAs(nonDispatcherUser) {
            Test.setCurrentPage(Page.VF_Select_Owner);
            ApexPages.currentPage().getParameters().put('ids', testCase.Id);
            
            Test.startTest();
            SelectOwnerController controller = new SelectOwnerController();
            Test.stopTest();
            
            System.assertEquals(false, controller.isDispatcher, 'User should not be dispatcher');
        }
    }
    
    @isTest
    static void testConstructorWithClosedCase() {
        User testUser = [SELECT Id FROM User WHERE Email = 'testuserAdmin@test.com' LIMIT 1];
        
        // Create closed case
        Case closedCase = new Case(
            Subject = 'Closed Test Case',
            Status = 'Closed',
            Priority = 'Medium'
        );
        insert closedCase;
        
        System.runAs(testUser) {
            Test.setCurrentPage(Page.VF_Select_Owner);
            ApexPages.currentPage().getParameters().put('ids', closedCase.Id);
            
            Test.startTest();
            SelectOwnerController controller = new SelectOwnerController();
            Test.stopTest();
            
            System.assertEquals(true, controller.isClosed, 'Should detect closed case');
        }
    }
    
    @isTest
    static void testSubmitSuccess() {
        User testUser = [SELECT Id FROM User WHERE Email = 'testuserAdmin@test.com' LIMIT 1];
        Case testCase = [SELECT Id FROM Case LIMIT 1];
        
        System.runAs(testUser) {
            Test.setCurrentPage(Page.VF_Select_Owner);
            ApexPages.currentPage().getParameters().put('ids', testCase.Id);
            
            SelectOwnerController controller = new SelectOwnerController();
            controller.selectedUserId = testUser.Id;
            
            Test.startTest();
            controller.submit();
            Test.stopTest();
            
            System.assertEquals(true, controller.isSuccess, 'Submit should be successful');
            System.assertEquals(true, controller.isDisabled, 'Should be disabled after submit');
            
            // Verify case owner was updated
            Case updatedCase = [SELECT OwnerId FROM Case WHERE Id = :testCase.Id];
            System.assertEquals(testUser.Id, updatedCase.OwnerId, 'Case owner should be updated');
        }
    }
    
    @isTest
    static void testSubmitEmpty() {
        User testUser = [SELECT Id FROM User WHERE Email = 'testuserAdmin@test.com' LIMIT 1];
        Case testCase = [SELECT Id FROM Case LIMIT 1];
        
        System.runAs(testUser) {
            Test.setCurrentPage(Page.VF_Select_Owner);
            ApexPages.currentPage().getParameters().put('ids', testCase.Id);
            
            SelectOwnerController controller = new SelectOwnerController();
            // Don't set selectedUserId
            
            Test.startTest();
            controller.submit();
            Test.stopTest();
            
            System.assertEquals(true, controller.isEmpty, 'Should set isEmpty to true');
            System.assertEquals(null, controller.isSuccess, 'Should not be successful');
        }
    }
    
    @isTest
    static void testChangeQueue() {
        User testUser = [SELECT Id FROM User WHERE Email = 'testuserAdmin@test.com' LIMIT 1];
        Group amfsQueue = [SELECT Id FROM Group WHERE Name = 'AMFS E2C - CS' LIMIT 1];
         Case testCase = [SELECT Id FROM Case LIMIT 1];
        // User userS = [SELECT Id, Name FROM User WHERE Id IN (
        //     SELECT UserOrGroupId FROM GroupMember WHERE GroupId = :amfsQueue.Id
        // )
        // ];
        
        System.runAs(testUser) {
            Test.setCurrentPage(Page.VF_Select_Owner);
            ApexPages.currentPage().getParameters().put('ids', testCase.Id);
            
            SelectOwnerController controller = new SelectOwnerController();
            controller.selectedQueueId = amfsQueue.Id;
            
            Test.startTest();
            controller.changeQueue();
            Test.stopTest();
            
            System.assert(controller.userOptions.size() > 1, 'Should have user options after changeQueue');
        }
    }
}