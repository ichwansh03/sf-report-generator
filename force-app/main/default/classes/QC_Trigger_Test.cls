@isTest(seeAllData=true)
private class QC_Trigger_Test {

    static testMethod void myTest() { 

        Test.startTest();
        list<Quality_Control__c> delqc = [SELECT id FROM Quality_Control__c WHERE Team__c = 'Call Center' and Master__c = TRUE];        
        delete delqc;
        
        Quality_Control__c qc = new Quality_Control__c();
        qc.Name = 'AFI - Master - Call Center';
        qc.Document_Date__c = date.today();
        qc.Entity__c = 'AFI';
        qc.Team__c = 'Call Center';
        qc.Master__c = TRUE;
        RecordType rt = [SELECT id FROM RecordType WHERE SObjectType = 'Quality_Control__c' and Name = 'Master' limit 1];
        qc.RecordTypeId = rt.id;
        
        qc.Rating_A_Name__c = 'Excellent';
        qc.Rating_B_Name__c = 'Good';
        qc.Rating_C_Name__c = 'Poor';
        qc.Rating_D_Name__c = 'Bad';
        qc.Rating_E_Name__c = 'Failed';

        qc.Rating_A_Score__c = 90;
        qc.Rating_B_Score__c = 80;
        qc.Rating_C_Score__c = 70;
        qc.Rating_D_Score__c = 60;
        qc.Rating_E_Score__c = 0;

        qc.Group_1_Point__c = 40;
        qc.Group_2_Point__c = 60;
        qc.Group_3_Point__c = 0;
        qc.Group_4_Point__c = 0;
        qc.Group_5_Point__c = 0;

        qc.Pass_Group_1__c = 40;
        qc.Pass_Group_2__c = 60;
        qc.FullMark_Group_1__c = 40;
        qc.FullMark_Group_2__c = 60;
        
        qc.Group_1_Name__c = 'C';
        qc.Group_2_Name__c = 'Ac';
        
        qc.Group_1_End__c = 6;
        qc.Group_2_End__c = 10;
        qc.Group_3_End__c = 0;
        qc.Group_4_End__c = 0;
        qc.Group_5_End__c = 0;

        qc.X1_Key_Check__c = 'X1_Key_Check__c';
        qc.X1_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X1_Master_Point__c = 5;
        qc.X1_Score__c = 'Yes';

        qc.X2_Key_Check__c = 'X1_Key_Check__c';
        qc.X2_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X2_Master_Point__c = 10;
        qc.X2_Score__c = 'Yes';

        qc.X3_Key_Check__c = 'X1_Key_Check__c';
        qc.X3_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X3_Master_Point__c = 5;
        qc.X3_Score__c = 'Yes';

        qc.X4_Key_Check__c = 'X1_Key_Check__c';
        qc.X4_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X4_Master_Point__c = 10;
        qc.X4_Score__c = 'Yes';

        qc.X5_Key_Check__c = 'X1_Key_Check__c';
        qc.X5_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X5_Master_Point__c = 5;
        qc.X5_Score__c = 'Yes';

        qc.X6_Key_Check__c = 'X1_Key_Check__c';
        qc.X6_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X6_Master_Point__c = 5;
        qc.X6_Score__c = 'Yes';

        qc.X7_Key_Check__c = 'X1_Key_Check__c';
        qc.X7_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X7_Master_Point__c = 20;
        qc.X7_Score__c = 'Yes';

        qc.X8_Key_Check__c = 'X1_Key_Check__c';
        qc.X8_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X8_Master_Point__c = 20;
        qc.X8_Score__c = 'Yes';

        qc.X9_Key_Check__c = 'X1_Key_Check__c';
        qc.X9_Scoring_Schemes__c = 'Yes/No Scheme';
        qc.X9_Master_Point__c = 20;
        qc.X9_Score__c = 'Yes';
        
        insert qc;
        
        Quality_Control__c sc = new Quality_Control__c();
        sc.Name = 'AFI - Agent - Call Center';
        sc.Document_Date__c = date.today();
        sc.Entity__c = 'AFI';
        sc.Team__c = 'Call Center';
        //sc.Master__c = TRUE;
        RecordType rt2 = [SELECT id FROM RecordType WHERE SObjectType = 'Quality_Control__c' and Name = 'New' limit 1];
        sc.RecordTypeId = rt2.id;
        
        insert sc;
        
        //Quality_Control__c sc = [SELECT id, Status__c FROM Quality_Control__c LIMIT 1];
        sc.Status__c = 'Approved';
        update sc;
        
        sc.Status__c = 'Draft';
        update sc;

        Test.stopTest();

    }
}