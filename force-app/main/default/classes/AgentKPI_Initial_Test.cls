@isTest
private class AgentKPI_Initial_Test {
    @testSetup static void setTestData() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'LastName',
            Email = 'tester@email.com',
            Username = 'tester@email.com' + System.currentTimeMillis(),
            CompanyName = 'The Company',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Entity__c = 'AFI'
        );
        insert u;
        
        //--Master Agent KPI
        Agent_KPI__c msKpi = new Agent_KPI__c();
        msKpi.Name = 'Master AFI - Inbound Customer';
        msKpi.Document_Date__c = Date.newInstance(2018, 11, 1);
        msKpi.Entity__c = 'AFI';
        msKpi.Team__c = 'Inbound Customer';
        msKpi.Type_Score__c = '3';
        msKpi.Master__c = TRUE;
        
        msKpi.Rating_1_Score__c = 95;
        msKpi.Rating_1_Name__c = 'Outstanding';
        msKpi.Final_Rating_1_Name__c = 'A';
        
        msKpi.Rating_2_Score__c = 90;
        msKpi.Rating_2_Name__c = 'Excellent';
        msKpi.Final_Rating_2_Name__c = 'B';
        
        msKpi.Rating_3_Score__c = 86;
        msKpi.Rating_3_Name__c = 'Successful';
        msKpi.Final_Rating_3_Name__c = 'C';
        
        msKpi.Rating_4_Score__c = 76;
        msKpi.Rating_4_Name__c = 'Partial Successful';
        msKpi.Final_Rating_4_Name__c = 'D';
        
        msKpi.Rating_5_Score__c = 0;
        msKpi.Rating_5_Name__c = 'Unsuccessful';
        msKpi.Final_Rating_5_Name__c = 'E';
        
        insert msKpi;
        
        //--Master Agent KPI Item
        Agent_KPI_Item__c msItem = new Agent_KPI_Item__c();
        msItem.Agent_KPI__c = msKpi.Id;
        msItem.Seq__c = 1;
        msItem.Parameter__c = 'Discipline';
        msItem.KPI__c = 'Attendance';
        msItem.Weight__c = 15;
        
        msItem.Master_Score_1__c = '3';
        msItem.Master_Data_1__c = 100;
        msItem.Master_Data_1_Detail__c = 'Persentasi kehadiran adalah 100% pada bulan berjalan';
        
        msItem.Master_Score_2__c = '2';
        msItem.Master_Data_2__c = 95;
        msItem.Master_Data_2_Detail__c = 'Persentasi kehadiran adalah 95% - 99% pada bulan berjalan';
        
        msItem.Master_Score_3__c = '0';
        msItem.Master_Data_2__c = 0;
        msItem.Master_Data_2_Detail__c = 'Persentasi kehadiran adalah < 95% pada bulan berjalan';
        
        msItem.Actual_Data__c = 100;
        msItem.Score_Auto__c = 'Auto';
        insert msItem;
    }
    
    static testMethod void testSharingRecord() {
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        
    	Agent_KPI__c agentKpi = new Agent_KPI__c();
        agentKpi.Entity__c = 'AFI';
        agentKpi.Master__c = false;
        agentKpi.Team__c = 'Inbound Customer';
        agentKpi.Agent__c = u.Id;
        agentKpi.Document_Date__c = Date.today();
        insert agentKpi;
		
        Purecloud__c callAgent = new Purecloud__c();
        callAgent.Name = 'Test';
        callAgent.Talk_Sum__c  = 300;
        callAgent.Hold_Sum__c  = 2;
        callAgent.ACD_Count__c  = 2;
        callAgent.Date__c = date.today();
        callAgent.Agent_Name__c = u.id;
        callAgent.Start_Login__c = Datetime.now();
        callAgent.End_Login__c = Datetime.now();
        callAgent.Break_Pray_Sum__c = 10;
        callAgent.Break_Rest_Sum__c = 10;
        callAgent.Break_Lunch_Sum__c = 10;
        callAgent.Busy_Sum__c = 10;
        insert callAgent;
        
        Test.startTest();
        
        Agent_KPI__c ak = [SELECT id, Status__c FROM Agent_KPI__c LIMIT 1];
        ak.Status__c = 'Approved';
        update ak;
        
        ak.Status__c = 'Draft';
        update ak;
        
        Agent_KPI_Item__c akpii = new Agent_KPI_Item__c();
        akpii.Agent_KPI__c = agentKpi.id;
        akpii.Data_Source__c = 'Quality Control';
		insert akpii;
        
        Agent_KPI_Item__c akpii2 = new Agent_KPI_Item__c();
        akpii2.Agent_KPI__c = agentKpi.id;
        akpii2.Data_Source__c = 'PureCloud - Attendance';
		insert akpii2;
        
        Agent_KPI_Item__c akpii4 = new Agent_KPI_Item__c();
        akpii4.Agent_KPI__c = agentKpi.id;
        akpii4.Data_Source__c = 'PureCloud - Latetime';
		insert akpii4;
        
        Agent_KPI_Item__c akpii5 = new Agent_KPI_Item__c();
        akpii5.Agent_KPI__c = agentKpi.id;
        akpii5.Data_Source__c = 'PureCloud - Productivity';
        akpii5.PureCloud_Count_Days__c = 1;
        //akpii5.PureCloud_Sum_Minute__c = 300;
		insert akpii5;
        
        Agent_KPI_Item__c akpii3 = new Agent_KPI_Item__c();
        akpii3.Agent_KPI__c = agentKpi.id;
        akpii3.Data_Source__c = 'PureCloud - AHT';
		insert akpii3;
        
        Agent_KPI_Item__c akpii13 = new Agent_KPI_Item__c();
        akpii13.Agent_KPI__c = agentKpi.id;
        akpii13.Data_Source__c = 'ICF - Negative Feedback';
		insert akpii13;
        
        Agent_KPI_Item__c akpii6 = new Agent_KPI_Item__c();
        akpii6.Agent_KPI__c = agentKpi.id;
        akpii6.Data_Source__c = 'Case - Email';
		insert akpii6;
        
        Agent_KPI_Item__c akpii7 = new Agent_KPI_Item__c();
        akpii7.Agent_KPI__c = agentKpi.id;
        akpii7.Data_Source__c = 'Case - LiveChat';
		insert akpii7;
        
        Agent_KPI_Item__c akpii8 = new Agent_KPI_Item__c();
        akpii8.Agent_KPI__c = agentKpi.id;
        akpii8.Data_Source__c = 'Case - Email and LiveChat';
		insert akpii8;
        
        Agent_KPI_Item__c akpii9 = new Agent_KPI_Item__c();
        akpii9.Agent_KPI__c = agentKpi.id;
        akpii9.Data_Source__c = 'Case - Inquiry';
		insert akpii9;
        
        Agent_KPI_Item__c akpii10 = new Agent_KPI_Item__c();
        akpii10.Agent_KPI__c = agentKpi.id;
        akpii10.Data_Source__c = 'Case - Request';
		insert akpii10;
        
        Agent_KPI_Item__c akpii11 = new Agent_KPI_Item__c();
        akpii11.Agent_KPI__c = agentKpi.id;
        akpii11.Data_Source__c = 'Case - CHS';
		insert akpii11;
        
        Agent_KPI_Item__c akpii12 = new Agent_KPI_Item__c();
        akpii12.Agent_KPI__c = agentKpi.id;
        akpii12.Data_Source__c = 'Case - Contact';
		insert akpii12;
        
        Test.stopTest();

    }
}