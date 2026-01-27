@isTest(seeAllData=true)
private class KPI_Trigger_Test {

    static testMethod void myTest() { 

        Test.startTest();
        list<Agent_KPI__c> delkpi = [SELECT id FROM Agent_KPI__c WHERE Team__c = 'Inbound Helpline' and Master__c = TRUE];        
        delete delkpi;
        
        // Create Data
        Agent_KPI__c ak = new Agent_KPI__c();
        ak.Name = 'Master AFI - Inbound Helpline';
        ak.Document_Date__c = date.today();
        RecordType rt = [SELECT id FROM RecordType WHERE SObjectType = 'Agent_KPI__c' and Name = 'Master' limit 1];
        ak.RecordTypeId = rt.id;
        ak.Team__c = 'Inbound Helpline';
        ak.Master__c = TRUE;
        ak.Type_Score__c = '3';
        ak.Entity__c = 'AFI';
        ak.Rating_1_Score__c = 95;
        ak.Rating_2_Score__c = 90;
        ak.Rating_3_Score__c = 86;
        ak.Rating_4_Score__c = 76;
        ak.Rating_5_Score__c = 0;
        //ak.Rating_6_Score__c = ;
        //ak.Rating_7_Score__c = 95;
        //ak.Rating_8_Score__c = 95;
        //ak.Rating_9_Score__c = 95;        
        ak.Rating_1_Name__c = 'Outstanding';
        ak.Rating_2_Name__c = 'Excelent';
        ak.Rating_3_Name__c = 'Succesfull';
        ak.Rating_4_Name__c = 'Partial Successfull';
        ak.Rating_5_Name__c = 'Unsuccessfull';

        ak.Final_Rating_1_Name__c = 'A';
        ak.Final_Rating_2_Name__c = 'B';
        ak.Final_Rating_3_Name__c = 'C';
        ak.Final_Rating_4_Name__c = 'D';
        ak.Final_Rating_5_Name__c = 'E';
        
        insert ak;
        
        // insert Item
        // 01
        Agent_KPI_Item__c  aki = new Agent_KPI_Item__c();
        aki.Seq__c = 1;
        aki.Parameter__c = 'Discipline';
        aki.KPI__c = 'Attendance';
        aki.Weight__c = 15;
        aki.Master_Score_1__c = '3';
        aki.Master_Score_2__c = '2';
        aki.Master_Score_3__c = '0';
        //aki.Master_Score_4__c
        //aki.Master_Score_5__c
        aki.Master_Data_1__c = 100;
        aki.Master_Data_1_Detail__c = '100';
        aki.Master_Data_2__c = 95;
        aki.Master_Data_2_Detail__c = '95';
        aki.Master_Data_3__c = 0;
        aki.Master_Data_3_Detail__c = '0';
        //aki.Master_Data_4__c
        //aki.Master_Data_4_Detail__c
        //aki.Master_Data_5__c
        //aki.Master_Data_5_Detail__c
        aki.Actual_Data__c = 0;
        aki.Actual_Score__c = '3';
        aki.Score_Auto__c = 'Auto';

        aki.Agent_KPI__c = ak.id;
        //aki.Data_Auto__c = 
        aki.Type_Score__c = '3';
        insert aki;
        
        ak.Master__c = FALSE;
        RecordType rt3 = [SELECT id FROM RecordType WHERE SObjectType = 'Agent_KPI__c' and Name = 'New' limit 1];
        ak.RecordTypeId = rt3.id;
        ak.Agent__c = UserInfo.getUserId();
        ak.id = null;
        insert ak;

//aki.Case_CHS__c
//aki.Case_Contact__c
//aki.Case_Count_Email__c
//aki.Case_Count_LiveChat__c
//aki.Case_Inquiry__c
//aki.Case_Request__c
//aki.Data_Source__c
//aki.ICF_Negative_Feedback__c
//aki.PureCloud_Count_Attendance__c
//aki.PureCloud_Count_Days__c
//aki.PureCloud_Sum_AHT__c
//aki.PureCloud_Sum_Latetime__c
//aki.PureCloud_Sum_Minute__c
//aki.PureCloud_Target_Attendance__c
//aki.Quality_Control_Data__c
//aki.Remarks__c

        // 02
        // 03
        // 04
        // 05

        Test.stopTest();

    }
}