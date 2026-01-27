@istest
private class InvokeClass_Test {
    @testSetup static void setTestData() {
        //UserRole r = new UserRole(DeveloperName = 'CCC_Test', Name = 'CCC');
        //insert r;
        
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
            //UserRoleId = r.Id
        );
        insert u;
        
        //--Master Quality Control
        Quality_Control__c msQC = new Quality_Control__c();
        msQc.Name = 'AFI - Master - Call Center';
        msQc.Document_Date__c = Date.newInstance(2018, 11, 1);
        msQc.Entity__c = 'AFI';
        msQc.Team__c = 'Call Center';
        msQc.Master__c = TRUE;
        
        msQc.Rating_A_Name__c = 'Excellent';
        msQc.Rating_A_Score__c = 90;
        
        msQc.Rating_B_Name__c = 'Good';
        msQc.Rating_B_Score__c = 80;
        
        msQc.Rating_C_Name__c = 'Poor';
        msQc.Rating_C_Score__c = 70;
        
        msQc.Rating_D_Name__c = 'Bad';
        msQc.Rating_D_Score__c = 60;
        
        msQc.Rating_E_Name__c = 'Failed';
        msQc.Rating_E_Score__c = 0;
        
        msQc.Group_1_Point__c = 40;
        msQc.Group_2_Point__c = 60;
        msQc.Pass_Group_1__c = 40;
        msQc.Pass_Group_2__c = 60;
        msQc.FullMark_Group_1__c = 40;
        msQc.FullMark_Group_2__c = 60;
        msQc.Group_1_Name__c = 'Courtesy';
        msQc.Group_2_Name__c = 'Accuracy';
        msQc.Group_1_End__c = 6;
        msQc.Group_2_End__c = 10;
        
        msQc.X1_Key_Check__c = 'GREETING CALLS';
        msQc.X1_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X1_Score__c = 'Yes';
        msQc.X1_Master_Point__c = 5;
        
        msQc.X2_Key_Check__c = 'RESPONSIVENESS';
        msQc.X2_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X2_Score__c = 'Yes';
        msQc.X2_Master_Point__c = 10;
        
        msQc.X3_Key_Check__c = 'INTONATION';
        msQc.X3_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X3_Score__c = 'Yes';
        msQc.X3_Master_Point__c = 5;
        
        msQc.X4_Key_Check__c = 'LISTENING & EMPHATY';
        msQc.X4_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X4_Score__c = 'Yes';
        msQc.X4_Master_Point__c = 10;
        
        msQc.X5_Key_Check__c = 'PERSONALIZED';
        msQc.X5_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X5_Score__c = 'Yes';
        msQc.X5_Master_Point__c = 5;
        
        msQc.X6_Key_Check__c = 'END CALLS';
        msQc.X6_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X6_Score__c = 'Yes';
        msQc.X6_Master_Point__c = 5;
        
        msQc.X7_Key_Check__c = 'VERIFICATION';
        msQc.X7_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X7_Score__c = 'Yes';
        msQc.X7_Master_Point__c = 20;
        
        msQc.X8_Key_Check__c = 'PROBLEM SOLVING';
        msQc.X8_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X8_Score__c = 'Yes';
        msQc.X8_Master_Point__c = 20;
        
        msQc.X9_Key_Check__c = 'SYSTEM';
        msQc.X9_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X9_Score__c = 'Yes';
        msQc.X9_Master_Point__c = 5;
        
        msQc.X10_Key_Check__c = 'SOMETHING';
        msQc.X10_Scoring_Schemes__c = 'Yes/No Scheme';
        msQc.X10_Score__c = 'Yes';
        msQc.X10_Master_Point__c = 0;
        
        insert msQc;
        
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
    
    static testMethod void testQCRefresh() {
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        
        Quality_Control__c qc = new Quality_Control__c();
        qc.Name = 'AgentName';
        qc.Document_Date__c = Date.newInstance(2018, 10, 26);
        qc.Entity__c = 'AFI';
        qc.Team__c = 'Call Center';
        qc.Master__c = FALSE;
        qc.Card_No__c = 1;
        qc.Agent__c = u.Id;
        qc.Tgl_Call_Mon__c = Date.newInstance(2018, 10, 25);
        insert qc;
        
        Test.startTest();
        InvokeClass.QCRefresh(qc.Id);
        Test.stopTest();
        
    }
    
    static testMethod void testKpiItemRefresh(){
        User u = [SELECT Id FROM User WHERE LastName = 'LastName'];
        
        Agent_KPI__c agentKpi = new Agent_KPI__c();
        agentKpi.Entity__c = 'AFI';
        agentKpi.Master__c = false;
        agentKpi.Team__c = 'Inbound Customer';
        agentKpi.Agent__c = u.Id;
        agentKpi.Document_Date__c = Date.newInstance(2018, 10, 26);
        insert agentKpi;
        
        Test.startTest();
        InvokeClass.KpiItemRefresh(agentKpi.Id);
        Test.stopTest();
    }
    
    static testMethod void testUpdateOwnerCase(){
        
        Case cs = new Case();
        cs.Entity_Backup__c = 'AFI';
        cs.Subject = 'Test Invoke';
        cs.Description = 'Test Invoke';
        insert cs;
        
        Test.startTest();
        InvokeClass.UpdateOwnerCase(cs.Id);
        Test.stopTest();
    }
}