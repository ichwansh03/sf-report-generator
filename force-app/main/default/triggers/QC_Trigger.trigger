trigger QC_Trigger on Quality_Control__c (Before Insert, Before Update) {
    for (Quality_Control__c sc : trigger.new) {
         // Query Master
        if (trigger.isInsert ) { //&& sc.Entity__c != 'ALI'
            if (!sc.Master__c) {
                List<Quality_Control__c> scmaster = [SELECT id, 
                    Group_1_End__c, Group_1_Name__c, Group_2_End__c, Group_2_Name__c, Group_3_End__c, Group_3_Name__c, Group_4_End__c, Group_4_Name__c, Group_5_End__c, Group_5_Name__c, 
                    Rating_A_Name__c, Rating_A_Score__c, Rating_B_Name__c, Rating_B_Score__c, Rating_C_Name__c, Rating_C_Score__c, Rating_D_Name__c, Rating_D_Score__c, Rating_E_Name__c, Rating_E_Score__c, 
                    X1_Key_Check__c, X1_Master_Point__c, X2_Key_Check__c, X2_Master_Point__c, X3_Key_Check__c, X3_Master_Point__c, X4_Key_Check__c, X4_Master_Point__c, X5_Key_Check__c, X5_Master_Point__c, 
                    X6_Key_Check__c, X6_Master_Point__c, X7_Key_Check__c, X7_Master_Point__c, X8_Key_Check__c, X8_Master_Point__c, X9_Key_Check__c, X9_Master_Point__c, X10_Key_Check__c, X10_Master_Point__c, 
                    X11_Key_Check__c, X11_Master_Point__c, X12_Key_Check__c, X12_Master_Point__c, X13_Key_Check__c, X13_Master_Point__c, X14_Key_Check__c, X14_Master_Point__c, X15_Key_Check__c, X15_Master_Point__c, 
                    X16_Key_Check__c, X16_Master_Point__c, X17_Key_Check__c, X17_Master_Point__c, X18_Key_Check__c, X18_Master_Point__c, X19_Key_Check__c, X19_Master_Point__c, X20_Key_Check__c, X20_Master_Point__c, 
                    X21_Key_Check__c, X21_Master_Point__c, X22_Key_Check__c, X22_Master_Point__c, X23_Key_Check__c, X23_Master_Point__c, X24_Key_Check__c, X24_Master_Point__c, X25_Key_Check__c, X25_Master_Point__c, 
                    X26_Key_Check__c, X26_Master_Point__c, X27_Key_Check__c, X27_Master_Point__c, X28_Key_Check__c, X28_Master_Point__c, X29_Key_Check__c, X29_Master_Point__c, X30_Key_Check__c, X30_Master_Point__c, 
                    X31_Key_Check__c, X31_Master_Point__c, X32_Key_Check__c, X32_Master_Point__c, X33_Key_Check__c, X33_Master_Point__c, X34_Key_Check__c, X34_Master_Point__c, X35_Key_Check__c, X35_Master_Point__c,
                    X36_Key_Check__c, X36_Master_Point__c, X37_Key_Check__c, X37_Master_Point__c, X38_Key_Check__c, X38_Master_Point__c, X39_Key_Check__c, X39_Master_Point__c, X40_Key_Check__c, X40_Master_Point__c, 

                    Pass_Group_1__c, Pass_Group_2__c, Pass_Group_3__c, Pass_Group_4__c, Pass_Group_5__c,

                    X1_Scoring_Schemes__c, X2_Scoring_Schemes__c, X3_Scoring_Schemes__c, X4_Scoring_Schemes__c, X5_Scoring_Schemes__c, 
                    X6_Scoring_Schemes__c, X7_Scoring_Schemes__c, X8_Scoring_Schemes__c, X9_Scoring_Schemes__c, X10_Scoring_Schemes__c, 
                    X11_Scoring_Schemes__c, X12_Scoring_Schemes__c, X13_Scoring_Schemes__c, X14_Scoring_Schemes__c, X15_Scoring_Schemes__c, 
                    X16_Scoring_Schemes__c, X17_Scoring_Schemes__c, X18_Scoring_Schemes__c, X19_Scoring_Schemes__c, X20_Scoring_Schemes__c, 
                    X21_Scoring_Schemes__c, X22_Scoring_Schemes__c, X23_Scoring_Schemes__c, X24_Scoring_Schemes__c, X25_Scoring_Schemes__c, 
                    X26_Scoring_Schemes__c, X27_Scoring_Schemes__c, X28_Scoring_Schemes__c, X29_Scoring_Schemes__c, X30_Scoring_Schemes__c, 
                    X31_Scoring_Schemes__c, X32_Scoring_Schemes__c, X33_Scoring_Schemes__c, X34_Scoring_Schemes__c, X35_Scoring_Schemes__c,
                    X36_Scoring_Schemes__c, X37_Scoring_Schemes__c, X38_Scoring_Schemes__c, X39_Scoring_Schemes__c, X40_Scoring_Schemes__c, 

                    X1_Description__c, X2_Description__c, X3_Description__c, X4_Description__c, X5_Description__c, 
                    X6_Description__c, X7_Description__c, X8_Description__c, X9_Description__c, X10_Description__c, 
                    X11_Description__c, X12_Description__c, X13_Description__c, X14_Description__c, X15_Description__c, 
                    X16_Description__c, X17_Description__c, X18_Description__c, X19_Description__c, X20_Description__c, 
                    X21_Description__c, X22_Description__c, X23_Description__c, X24_Description__c, X25_Description__c, 
                    X26_Description__c, X27_Description__c, X28_Description__c, X29_Description__c, X30_Description__c, 
                    X31_Description__c, X32_Description__c, X33_Description__c, X34_Description__c, X35_Description__c,
                    X36_Description__c, X37_Description__c, X38_Description__c, X39_Description__c, X40_Description__c, 

                    FullMark_Group_1__c, FullMark_Group_2__c, FullMark_Group_3__c, FullMark_Group_4__c, FullMark_Group_5__c
                FROM Quality_Control__c WHERE Team__c = :sc.Team__c and Master__c = TRUE and Entity__c =: sc.Entity__c];

                if (scmaster.size() > 0) {
                    RecordType rt = [SELECT Id, Name, DeveloperName, NamespacePrefix, Description, BusinessProcessId, SobjectType, IsActive FROM RecordType WHERE SobjectType = 'Quality_Control__c' and Name = 'Edit'];
                    sc.RecordTypeId = rt.id;
                    sc.Group_1_End__c = scmaster[0].Group_1_End__c;
                    sc.Group_1_Name__c = scmaster[0].Group_1_Name__c;
                    
                    sc.Group_2_End__c = scmaster[0].Group_2_End__c;
                    sc.Group_2_Name__c = scmaster[0].Group_2_Name__c;
                    
                    sc.Group_3_End__c = scmaster[0].Group_3_End__c;
                    sc.Group_3_Name__c = scmaster[0].Group_3_Name__c;
                    
                    sc.Group_4_End__c = scmaster[0].Group_4_End__c;
                    sc.Group_4_Name__c = scmaster[0].Group_4_Name__c;
                    
                    sc.Group_5_End__c = scmaster[0].Group_5_End__c;
                    sc.Group_5_Name__c = scmaster[0].Group_5_Name__c;
                    
                    sc.Rating_A_Name__c = scmaster[0].Rating_A_Name__c;
                    sc.Rating_A_Score__c = scmaster[0].Rating_A_Score__c;
                    sc.Rating_B_Name__c = scmaster[0].Rating_B_Name__c;
                    sc.Rating_B_Score__c = scmaster[0].Rating_B_Score__c;
                    sc.Rating_C_Name__c = scmaster[0].Rating_C_Name__c;
                    sc.Rating_C_Score__c = scmaster[0].Rating_C_Score__c;
                    sc.Rating_D_Name__c = scmaster[0].Rating_D_Name__c;
                    sc.Rating_D_Score__c = scmaster[0].Rating_D_Score__c;
                    sc.Rating_E_Name__c = scmaster[0].Rating_E_Name__c;
                    sc.Rating_E_Score__c = scmaster[0].Rating_E_Score__c;
                    
                    sc.X1_Key_Check__c = scmaster[0].X1_Key_Check__c;
                    sc.X1_Master_Point__c = scmaster[0].X1_Master_Point__c;
                    
                    sc.X2_Key_Check__c = scmaster[0].X2_Key_Check__c;
                    sc.X2_Master_Point__c = scmaster[0].X2_Master_Point__c;
                    
                    sc.X3_Key_Check__c = scmaster[0].X3_Key_Check__c;
                    sc.X3_Master_Point__c = scmaster[0].X3_Master_Point__c;
                    
                    sc.X4_Key_Check__c = scmaster[0].X4_Key_Check__c;
                    sc.X4_Master_Point__c = scmaster[0].X4_Master_Point__c;
                    
                    sc.X5_Key_Check__c = scmaster[0].X5_Key_Check__c;
                    sc.X5_Master_Point__c = scmaster[0].X5_Master_Point__c;
                    
                    sc.X6_Key_Check__c = scmaster[0].X6_Key_Check__c;
                    sc.X6_Master_Point__c = scmaster[0].X6_Master_Point__c;
                    
                    sc.X7_Key_Check__c = scmaster[0].X7_Key_Check__c;
                    sc.X7_Master_Point__c = scmaster[0].X7_Master_Point__c;
                    
                    sc.X8_Key_Check__c = scmaster[0].X8_Key_Check__c;
                    sc.X8_Master_Point__c = scmaster[0].X8_Master_Point__c;
                    
                    sc.X9_Key_Check__c = scmaster[0].X9_Key_Check__c;
                    sc.X9_Master_Point__c = scmaster[0].X9_Master_Point__c;
                    
                    sc.X10_Key_Check__c = scmaster[0].X10_Key_Check__c;
                    sc.X10_Master_Point__c = scmaster[0].X10_Master_Point__c;
                    
                    sc.X11_Key_Check__c = scmaster[0].X11_Key_Check__c;
                    sc.X11_Master_Point__c = scmaster[0].X11_Master_Point__c;
                    
                    sc.X12_Key_Check__c = scmaster[0].X12_Key_Check__c;
                    sc.X12_Master_Point__c = scmaster[0].X12_Master_Point__c;
                    
                    sc.X13_Key_Check__c = scmaster[0].X13_Key_Check__c;
                    sc.X13_Master_Point__c = scmaster[0].X13_Master_Point__c;
                    
                    sc.X14_Key_Check__c = scmaster[0].X14_Key_Check__c;
                    sc.X14_Master_Point__c = scmaster[0].X14_Master_Point__c;
                    
                    sc.X15_Key_Check__c = scmaster[0].X15_Key_Check__c;
                    sc.X15_Master_Point__c = scmaster[0].X15_Master_Point__c;
                    
                    sc.X16_Key_Check__c = scmaster[0].X16_Key_Check__c;
                    sc.X16_Master_Point__c = scmaster[0].X16_Master_Point__c;
                    
                    sc.X17_Key_Check__c = scmaster[0].X17_Key_Check__c;
                    sc.X17_Master_Point__c = scmaster[0].X17_Master_Point__c;
                    
                    sc.X18_Key_Check__c = scmaster[0].X18_Key_Check__c;
                    sc.X18_Master_Point__c = scmaster[0].X18_Master_Point__c;
                    
                    sc.X19_Key_Check__c = scmaster[0].X19_Key_Check__c;
                    sc.X19_Master_Point__c = scmaster[0].X19_Master_Point__c;
                    
                    sc.X20_Key_Check__c = scmaster[0].X20_Key_Check__c;
                    sc.X20_Master_Point__c = scmaster[0].X20_Master_Point__c;
                    
                    sc.X21_Key_Check__c = scmaster[0].X21_Key_Check__c;
                    sc.X21_Master_Point__c = scmaster[0].X21_Master_Point__c;
                    
                    sc.X22_Key_Check__c = scmaster[0].X22_Key_Check__c;
                    sc.X22_Master_Point__c = scmaster[0].X22_Master_Point__c;
                    
                    sc.X23_Key_Check__c = scmaster[0].X23_Key_Check__c;
                    sc.X23_Master_Point__c = scmaster[0].X23_Master_Point__c;
                    
                    sc.X24_Key_Check__c = scmaster[0].X24_Key_Check__c;
                    sc.X24_Master_Point__c = scmaster[0].X24_Master_Point__c;
                    
                    sc.X25_Key_Check__c = scmaster[0].X25_Key_Check__c;
                    sc.X25_Master_Point__c = scmaster[0].X25_Master_Point__c;
                    
                    sc.X26_Key_Check__c = scmaster[0].X26_Key_Check__c;
                    sc.X26_Master_Point__c = scmaster[0].X26_Master_Point__c;
                    
                    sc.X27_Key_Check__c = scmaster[0].X27_Key_Check__c;
                    sc.X27_Master_Point__c = scmaster[0].X27_Master_Point__c;
                    
                    sc.X28_Key_Check__c = scmaster[0].X28_Key_Check__c;
                    sc.X28_Master_Point__c = scmaster[0].X28_Master_Point__c;
                    
                    sc.X29_Key_Check__c = scmaster[0].X29_Key_Check__c;
                    sc.X29_Master_Point__c = scmaster[0].X29_Master_Point__c;
                    
                    sc.X30_Key_Check__c = scmaster[0].X30_Key_Check__c;
                    sc.X30_Master_Point__c = scmaster[0].X30_Master_Point__c;
                    
                    sc.X31_Key_Check__c = scmaster[0].X31_Key_Check__c;
                    sc.X31_Master_Point__c = scmaster[0].X31_Master_Point__c;
                    
                    sc.X32_Key_Check__c = scmaster[0].X32_Key_Check__c;
                    sc.X32_Master_Point__c = scmaster[0].X32_Master_Point__c;
                    
                    sc.X33_Key_Check__c = scmaster[0].X33_Key_Check__c;
                    sc.X33_Master_Point__c = scmaster[0].X33_Master_Point__c;
                    
                    sc.X34_Key_Check__c = scmaster[0].X34_Key_Check__c;
                    sc.X34_Master_Point__c = scmaster[0].X34_Master_Point__c;
                    
                    sc.X35_Key_Check__c = scmaster[0].X35_Key_Check__c;
                    sc.X35_Master_Point__c = scmaster[0].X35_Master_Point__c;
                    
                    sc.X36_Key_Check__c = scmaster[0].X36_Key_Check__c;
                    sc.X36_Master_Point__c = scmaster[0].X36_Master_Point__c;
                    
                    sc.X37_Key_Check__c = scmaster[0].X37_Key_Check__c;
                    sc.X37_Master_Point__c = scmaster[0].X37_Master_Point__c;
                    
                    sc.X38_Key_Check__c = scmaster[0].X38_Key_Check__c;
                    sc.X38_Master_Point__c = scmaster[0].X38_Master_Point__c;
                    
                    sc.X39_Key_Check__c = scmaster[0].X39_Key_Check__c;
                    sc.X39_Master_Point__c = scmaster[0].X39_Master_Point__c;
                    
                    sc.X40_Key_Check__c = scmaster[0].X40_Key_Check__c;
                    sc.X40_Master_Point__c = scmaster[0].X40_Master_Point__c;
                    
                    sc.X1_Scoring_Schemes__c = scmaster[0].X1_Scoring_Schemes__c;
                    sc.X2_Scoring_Schemes__c = scmaster[0].X2_Scoring_Schemes__c;
                    sc.X3_Scoring_Schemes__c = scmaster[0].X3_Scoring_Schemes__c;
                    sc.X4_Scoring_Schemes__c = scmaster[0].X4_Scoring_Schemes__c;
                    sc.X5_Scoring_Schemes__c = scmaster[0].X5_Scoring_Schemes__c;
                    sc.X6_Scoring_Schemes__c = scmaster[0].X6_Scoring_Schemes__c;
                    sc.X7_Scoring_Schemes__c = scmaster[0].X7_Scoring_Schemes__c;
                    sc.X8_Scoring_Schemes__c = scmaster[0].X8_Scoring_Schemes__c;
                    sc.X9_Scoring_Schemes__c = scmaster[0].X9_Scoring_Schemes__c;
                    sc.X10_Scoring_Schemes__c = scmaster[0].X10_Scoring_Schemes__c;
                    sc.X11_Scoring_Schemes__c = scmaster[0].X11_Scoring_Schemes__c;
                    sc.X12_Scoring_Schemes__c = scmaster[0].X12_Scoring_Schemes__c;
                    sc.X13_Scoring_Schemes__c = scmaster[0].X13_Scoring_Schemes__c;
                    sc.X14_Scoring_Schemes__c = scmaster[0].X14_Scoring_Schemes__c;
                    sc.X15_Scoring_Schemes__c = scmaster[0].X15_Scoring_Schemes__c;
                    sc.X16_Scoring_Schemes__c = scmaster[0].X16_Scoring_Schemes__c;
                    sc.X17_Scoring_Schemes__c = scmaster[0].X17_Scoring_Schemes__c;
                    sc.X18_Scoring_Schemes__c = scmaster[0].X18_Scoring_Schemes__c;
                    sc.X19_Scoring_Schemes__c = scmaster[0].X19_Scoring_Schemes__c;
                    sc.X20_Scoring_Schemes__c = scmaster[0].X20_Scoring_Schemes__c;
                    sc.X21_Scoring_Schemes__c = scmaster[0].X21_Scoring_Schemes__c;
                    sc.X22_Scoring_Schemes__c = scmaster[0].X22_Scoring_Schemes__c;
                    sc.X23_Scoring_Schemes__c = scmaster[0].X23_Scoring_Schemes__c;
                    sc.X24_Scoring_Schemes__c = scmaster[0].X24_Scoring_Schemes__c;
                    sc.X25_Scoring_Schemes__c = scmaster[0].X25_Scoring_Schemes__c;
                    sc.X26_Scoring_Schemes__c = scmaster[0].X26_Scoring_Schemes__c;
                    sc.X27_Scoring_Schemes__c = scmaster[0].X27_Scoring_Schemes__c;
                    sc.X28_Scoring_Schemes__c = scmaster[0].X28_Scoring_Schemes__c;
                    sc.X29_Scoring_Schemes__c = scmaster[0].X29_Scoring_Schemes__c;
                    sc.X30_Scoring_Schemes__c = scmaster[0].X30_Scoring_Schemes__c;
                    sc.X31_Scoring_Schemes__c = scmaster[0].X31_Scoring_Schemes__c;
                    sc.X32_Scoring_Schemes__c = scmaster[0].X32_Scoring_Schemes__c;
                    sc.X33_Scoring_Schemes__c = scmaster[0].X33_Scoring_Schemes__c;
                    sc.X34_Scoring_Schemes__c = scmaster[0].X34_Scoring_Schemes__c;
                    sc.X35_Scoring_Schemes__c = scmaster[0].X35_Scoring_Schemes__c;
                    sc.X36_Scoring_Schemes__c = scmaster[0].X36_Scoring_Schemes__c;
                    sc.X37_Scoring_Schemes__c = scmaster[0].X37_Scoring_Schemes__c;
                    sc.X38_Scoring_Schemes__c = scmaster[0].X38_Scoring_Schemes__c;
                    sc.X39_Scoring_Schemes__c = scmaster[0].X39_Scoring_Schemes__c;
                    sc.X40_Scoring_Schemes__c = scmaster[0].X40_Scoring_Schemes__c;
                                    
                    sc.X1_Description__c = scmaster[0].X1_Description__c;
                    sc.X2_Description__c = scmaster[0].X2_Description__c;
                    sc.X3_Description__c = scmaster[0].X3_Description__c;
                    sc.X4_Description__c = scmaster[0].X4_Description__c;
                    sc.X5_Description__c = scmaster[0].X5_Description__c;
                    sc.X6_Description__c = scmaster[0].X6_Description__c;
                    sc.X7_Description__c = scmaster[0].X7_Description__c;
                    sc.X8_Description__c = scmaster[0].X8_Description__c;
                    sc.X9_Description__c = scmaster[0].X9_Description__c;
                    sc.X10_Description__c = scmaster[0].X10_Description__c;
                    sc.X11_Description__c = scmaster[0].X11_Description__c;
                    sc.X12_Description__c = scmaster[0].X12_Description__c;
                    sc.X13_Description__c = scmaster[0].X13_Description__c;
                    sc.X14_Description__c = scmaster[0].X14_Description__c;
                    sc.X15_Description__c = scmaster[0].X15_Description__c;
                    sc.X16_Description__c = scmaster[0].X16_Description__c;
                    sc.X17_Description__c = scmaster[0].X17_Description__c;
                    sc.X18_Description__c = scmaster[0].X18_Description__c;
                    sc.X19_Description__c = scmaster[0].X19_Description__c;
                    sc.X20_Description__c = scmaster[0].X20_Description__c;
                    sc.X21_Description__c = scmaster[0].X21_Description__c;
                    sc.X22_Description__c = scmaster[0].X22_Description__c;
                    sc.X23_Description__c = scmaster[0].X23_Description__c;
                    sc.X24_Description__c = scmaster[0].X24_Description__c;
                    sc.X25_Description__c = scmaster[0].X25_Description__c;
                    sc.X26_Description__c = scmaster[0].X26_Description__c;
                    sc.X27_Description__c = scmaster[0].X27_Description__c;
                    sc.X28_Description__c = scmaster[0].X28_Description__c;
                    sc.X29_Description__c = scmaster[0].X29_Description__c;
                    sc.X30_Description__c = scmaster[0].X30_Description__c;
                    sc.X31_Description__c = scmaster[0].X31_Description__c;
                    sc.X32_Description__c = scmaster[0].X32_Description__c;
                    sc.X33_Description__c = scmaster[0].X33_Description__c;
                    sc.X34_Description__c = scmaster[0].X34_Description__c;
                    sc.X35_Description__c = scmaster[0].X35_Description__c;
                    sc.X36_Description__c = scmaster[0].X36_Description__c;
                    sc.X37_Description__c = scmaster[0].X37_Description__c;
                    sc.X38_Description__c = scmaster[0].X38_Description__c;
                    sc.X39_Description__c = scmaster[0].X39_Description__c;
                    sc.X40_Description__c = scmaster[0].X40_Description__c;

                    sc.Pass_Group_1__c = scmaster[0].Pass_Group_1__c;
                    sc.Pass_Group_2__c = scmaster[0].Pass_Group_2__c;
                    sc.Pass_Group_3__c = scmaster[0].Pass_Group_3__c;
                    sc.Pass_Group_4__c = scmaster[0].Pass_Group_4__c;
                    sc.Pass_Group_5__c = scmaster[0].Pass_Group_5__c;
                    sc.FullMark_Group_1__c = scmaster[0].FullMark_Group_1__c;
                    sc.FullMark_Group_2__c = scmaster[0].FullMark_Group_2__c;
                    sc.FullMark_Group_3__c = scmaster[0].FullMark_Group_3__c;
                    sc.FullMark_Group_4__c = scmaster[0].FullMark_Group_4__c;
                    sc.FullMark_Group_5__c = scmaster[0].FullMark_Group_5__c;
                }
                else {
                    sc.AddError('Not Master Available.');
                }
            }
        }
         
         
         
         if (sc.Master__c) sc.External_Id__c = sc.Entity__c+'-'+sc.Team__c;
         else sc.External_Id__c = sc.SC_No__c;

         sc.Group_1_Point__c = 0;
         sc.Group_2_Point__c = 0;
         sc.Group_3_Point__c = 0;
         sc.Group_4_Point__c = 0;
         sc.Group_5_Point__c = 0;

//** Group 1 Point **
         IF (sc.Group_1_End__c > 0) sc.Group_1_Point__c += sc.X1_Point__c; 
         IF (sc.Group_1_End__c > 1) sc.Group_1_Point__c += sc.X2_Point__c;
         IF (sc.Group_1_End__c > 2) sc.Group_1_Point__c += sc.X3_Point__c;
         IF (sc.Group_1_End__c > 3) sc.Group_1_Point__c += sc.X4_Point__c;
         IF (sc.Group_1_End__c > 4) sc.Group_1_Point__c += sc.X5_Point__c;
         IF (sc.Group_1_End__c > 5) sc.Group_1_Point__c += sc.X6_Point__c;
         IF (sc.Group_1_End__c > 6) sc.Group_1_Point__c += sc.X7_Point__c;
         IF (sc.Group_1_End__c > 7) sc.Group_1_Point__c += sc.X8_Point__c;
         IF (sc.Group_1_End__c > 8) sc.Group_1_Point__c += sc.X9_Point__c;
         IF (sc.Group_1_End__c > 9) sc.Group_1_Point__c += sc.X10_Point__c;
         IF (sc.Group_1_End__c > 10) sc.Group_1_Point__c += sc.X11_Point__c;
         IF (sc.Group_1_End__c > 11) sc.Group_1_Point__c += sc.X12_Point__c;
         IF (sc.Group_1_End__c > 12) sc.Group_1_Point__c += sc.X13_Point__c;
         IF (sc.Group_1_End__c > 13) sc.Group_1_Point__c += sc.X14_Point__c;
         IF (sc.Group_1_End__c > 14) sc.Group_1_Point__c += sc.X15_Point__c;
         IF (sc.Group_1_End__c > 15) sc.Group_1_Point__c += sc.X16_Point__c;
         IF (sc.Group_1_End__c > 16) sc.Group_1_Point__c += sc.X17_Point__c;
         IF (sc.Group_1_End__c > 17) sc.Group_1_Point__c += sc.X18_Point__c;
         IF (sc.Group_1_End__c > 18) sc.Group_1_Point__c += sc.X19_Point__c;
         IF (sc.Group_1_End__c > 19) sc.Group_1_Point__c += sc.X20_Point__c;
         IF (sc.Group_1_End__c > 20) sc.Group_1_Point__c += sc.X21_Point__c;
         IF (sc.Group_1_End__c > 21) sc.Group_1_Point__c += sc.X22_Point__c;
         IF (sc.Group_1_End__c > 22) sc.Group_1_Point__c += sc.X23_Point__c;
         IF (sc.Group_1_End__c > 23) sc.Group_1_Point__c += sc.X24_Point__c;
         IF (sc.Group_1_End__c > 24) sc.Group_1_Point__c += sc.X25_Point__c;
         IF (sc.Group_1_End__c > 25) sc.Group_1_Point__c += sc.X26_Point__c;
         IF (sc.Group_1_End__c > 26) sc.Group_1_Point__c += sc.X27_Point__c;
         IF (sc.Group_1_End__c > 27) sc.Group_1_Point__c += sc.X28_Point__c;
         IF (sc.Group_1_End__c > 28) sc.Group_1_Point__c += sc.X29_Point__c;
         IF (sc.Group_1_End__c > 29) sc.Group_1_Point__c += sc.X30_Point__c;
         IF (sc.Group_1_End__c > 30) sc.Group_1_Point__c += sc.X31_Point__c;
         IF (sc.Group_1_End__c > 31) sc.Group_1_Point__c += sc.X32_Point__c;
         IF (sc.Group_1_End__c > 32) sc.Group_1_Point__c += sc.X33_Point__c;
         IF (sc.Group_1_End__c > 33) sc.Group_1_Point__c += sc.X34_Point__c;
         IF (sc.Group_1_End__c > 34) sc.Group_1_Point__c += sc.X35_Point__c;
         IF (sc.Group_1_End__c > 35) sc.Group_1_Point__c += sc.X36_Point__c;
         IF (sc.Group_1_End__c > 36) sc.Group_1_Point__c += sc.X37_Point__c;
         IF (sc.Group_1_End__c > 37) sc.Group_1_Point__c += sc.X38_Point__c;
         IF (sc.Group_1_End__c > 38) sc.Group_1_Point__c += sc.X39_Point__c;
         IF (sc.Group_1_End__c > 39) sc.Group_1_Point__c += sc.X40_Point__c;

//** Group 2 Point **
         IF ((sc.Group_2_End__c > 0) && (sc.Group_1_End__c < 1)) sc.Group_2_Point__c += sc.X1_Point__c; 
         IF ((sc.Group_2_End__c > 1) && (sc.Group_1_End__c < 2)) sc.Group_2_Point__c += sc.X2_Point__c;
         IF ((sc.Group_2_End__c > 2) && (sc.Group_1_End__c < 3)) sc.Group_2_Point__c += sc.X3_Point__c;
         IF ((sc.Group_2_End__c > 3) && (sc.Group_1_End__c < 4)) sc.Group_2_Point__c += sc.X4_Point__c;
         IF ((sc.Group_2_End__c > 4) && (sc.Group_1_End__c < 5)) sc.Group_2_Point__c += sc.X5_Point__c;
         IF ((sc.Group_2_End__c > 5) && (sc.Group_1_End__c < 6)) sc.Group_2_Point__c += sc.X6_Point__c;
         IF ((sc.Group_2_End__c > 6) && (sc.Group_1_End__c < 7)) sc.Group_2_Point__c += sc.X7_Point__c;
         IF ((sc.Group_2_End__c > 7) && (sc.Group_1_End__c < 8)) sc.Group_2_Point__c += sc.X8_Point__c;
         IF ((sc.Group_2_End__c > 8) && (sc.Group_1_End__c < 9)) sc.Group_2_Point__c += sc.X9_Point__c;
         IF ((sc.Group_2_End__c > 9) && (sc.Group_1_End__c < 10)) sc.Group_2_Point__c += sc.X10_Point__c;
         IF ((sc.Group_2_End__c > 10) && (sc.Group_1_End__c < 11)) sc.Group_2_Point__c += sc.X11_Point__c;
         IF ((sc.Group_2_End__c > 11) && (sc.Group_1_End__c < 12)) sc.Group_2_Point__c += sc.X12_Point__c;
         IF ((sc.Group_2_End__c > 12) && (sc.Group_1_End__c < 13)) sc.Group_2_Point__c += sc.X13_Point__c;
         IF ((sc.Group_2_End__c > 13) && (sc.Group_1_End__c < 14)) sc.Group_2_Point__c += sc.X14_Point__c;
         IF ((sc.Group_2_End__c > 14) && (sc.Group_1_End__c < 15)) sc.Group_2_Point__c += sc.X15_Point__c;
         IF ((sc.Group_2_End__c > 15) && (sc.Group_1_End__c < 16)) sc.Group_2_Point__c += sc.X16_Point__c;
         IF ((sc.Group_2_End__c > 16) && (sc.Group_1_End__c < 17)) sc.Group_2_Point__c += sc.X17_Point__c;
         IF ((sc.Group_2_End__c > 17) && (sc.Group_1_End__c < 18)) sc.Group_2_Point__c += sc.X18_Point__c;
         IF ((sc.Group_2_End__c > 18) && (sc.Group_1_End__c < 19)) sc.Group_2_Point__c += sc.X19_Point__c;
         IF ((sc.Group_2_End__c > 19) && (sc.Group_1_End__c < 20)) sc.Group_2_Point__c += sc.X20_Point__c;
         IF ((sc.Group_2_End__c > 20) && (sc.Group_1_End__c < 21)) sc.Group_2_Point__c += sc.X21_Point__c;
         IF ((sc.Group_2_End__c > 21) && (sc.Group_1_End__c < 22)) sc.Group_2_Point__c += sc.X22_Point__c;
         IF ((sc.Group_2_End__c > 22) && (sc.Group_1_End__c < 23)) sc.Group_2_Point__c += sc.X23_Point__c;
         IF ((sc.Group_2_End__c > 23) && (sc.Group_1_End__c < 24)) sc.Group_2_Point__c += sc.X24_Point__c;
         IF ((sc.Group_2_End__c > 24) && (sc.Group_1_End__c < 25)) sc.Group_2_Point__c += sc.X25_Point__c;
         IF ((sc.Group_2_End__c > 25) && (sc.Group_1_End__c < 26)) sc.Group_2_Point__c += sc.X26_Point__c;
         IF ((sc.Group_2_End__c > 26) && (sc.Group_1_End__c < 27)) sc.Group_2_Point__c += sc.X27_Point__c;
         IF ((sc.Group_2_End__c > 27) && (sc.Group_1_End__c < 28)) sc.Group_2_Point__c += sc.X28_Point__c;
         IF ((sc.Group_2_End__c > 28) && (sc.Group_1_End__c < 29)) sc.Group_2_Point__c += sc.X29_Point__c;
         IF ((sc.Group_2_End__c > 29) && (sc.Group_1_End__c < 30)) sc.Group_2_Point__c += sc.X30_Point__c;
         IF ((sc.Group_2_End__c > 30) && (sc.Group_1_End__c < 31)) sc.Group_2_Point__c += sc.X31_Point__c;
         IF ((sc.Group_2_End__c > 31) && (sc.Group_1_End__c < 32)) sc.Group_2_Point__c += sc.X32_Point__c;
         IF ((sc.Group_2_End__c > 32) && (sc.Group_1_End__c < 33)) sc.Group_2_Point__c += sc.X33_Point__c;
         IF ((sc.Group_2_End__c > 33) && (sc.Group_1_End__c < 34)) sc.Group_2_Point__c += sc.X34_Point__c;
         IF ((sc.Group_2_End__c > 34) && (sc.Group_1_End__c < 35)) sc.Group_2_Point__c += sc.X35_Point__c;
         IF ((sc.Group_2_End__c > 35) && (sc.Group_1_End__c < 36)) sc.Group_2_Point__c += sc.X36_Point__c;
         IF ((sc.Group_2_End__c > 36) && (sc.Group_1_End__c < 37)) sc.Group_2_Point__c += sc.X37_Point__c;
         IF ((sc.Group_2_End__c > 37) && (sc.Group_1_End__c < 38)) sc.Group_2_Point__c += sc.X38_Point__c;
         IF ((sc.Group_2_End__c > 38) && (sc.Group_1_End__c < 39)) sc.Group_2_Point__c += sc.X39_Point__c;
         IF ((sc.Group_2_End__c > 39) && (sc.Group_1_End__c < 40)) sc.Group_2_Point__c += sc.X40_Point__c;

//** Group 3 Point **
         IF ((sc.Group_3_End__c > 0) && (sc.Group_2_End__c < 1)) sc.Group_3_Point__c += sc.X1_Point__c; 
         IF ((sc.Group_3_End__c > 1) && (sc.Group_2_End__c < 2)) sc.Group_3_Point__c += sc.X2_Point__c;
         IF ((sc.Group_3_End__c > 2) && (sc.Group_2_End__c < 3)) sc.Group_3_Point__c += sc.X3_Point__c;
         IF ((sc.Group_3_End__c > 3) && (sc.Group_2_End__c < 4)) sc.Group_3_Point__c += sc.X4_Point__c;
         IF ((sc.Group_3_End__c > 4) && (sc.Group_2_End__c < 5)) sc.Group_3_Point__c += sc.X5_Point__c;
         IF ((sc.Group_3_End__c > 5) && (sc.Group_2_End__c < 6)) sc.Group_3_Point__c += sc.X6_Point__c;
         IF ((sc.Group_3_End__c > 6) && (sc.Group_2_End__c < 7)) sc.Group_3_Point__c += sc.X7_Point__c;
         IF ((sc.Group_3_End__c > 7) && (sc.Group_2_End__c < 8)) sc.Group_3_Point__c += sc.X8_Point__c;
         IF ((sc.Group_3_End__c > 8) && (sc.Group_2_End__c < 9)) sc.Group_3_Point__c += sc.X9_Point__c;
         IF ((sc.Group_3_End__c > 9) && (sc.Group_2_End__c < 10)) sc.Group_3_Point__c += sc.X10_Point__c;
         IF ((sc.Group_3_End__c > 10) && (sc.Group_2_End__c < 11)) sc.Group_3_Point__c += sc.X11_Point__c;
         IF ((sc.Group_3_End__c > 11) && (sc.Group_2_End__c < 12)) sc.Group_3_Point__c += sc.X12_Point__c;
         IF ((sc.Group_3_End__c > 12) && (sc.Group_2_End__c < 13)) sc.Group_3_Point__c += sc.X13_Point__c;
         IF ((sc.Group_3_End__c > 13) && (sc.Group_2_End__c < 14)) sc.Group_3_Point__c += sc.X14_Point__c;
         IF ((sc.Group_3_End__c > 14) && (sc.Group_2_End__c < 15)) sc.Group_3_Point__c += sc.X15_Point__c;
         IF ((sc.Group_3_End__c > 15) && (sc.Group_2_End__c < 16)) sc.Group_3_Point__c += sc.X16_Point__c;
         IF ((sc.Group_3_End__c > 16) && (sc.Group_2_End__c < 17)) sc.Group_3_Point__c += sc.X17_Point__c;
         IF ((sc.Group_3_End__c > 17) && (sc.Group_2_End__c < 18)) sc.Group_3_Point__c += sc.X18_Point__c;
         IF ((sc.Group_3_End__c > 18) && (sc.Group_2_End__c < 19)) sc.Group_3_Point__c += sc.X19_Point__c;
         IF ((sc.Group_3_End__c > 19) && (sc.Group_2_End__c < 20)) sc.Group_3_Point__c += sc.X20_Point__c;
         IF ((sc.Group_3_End__c > 20) && (sc.Group_2_End__c < 21)) sc.Group_3_Point__c += sc.X21_Point__c;
         IF ((sc.Group_3_End__c > 21) && (sc.Group_2_End__c < 22)) sc.Group_3_Point__c += sc.X22_Point__c;
         IF ((sc.Group_3_End__c > 22) && (sc.Group_2_End__c < 23)) sc.Group_3_Point__c += sc.X23_Point__c;
         IF ((sc.Group_3_End__c > 23) && (sc.Group_2_End__c < 24)) sc.Group_3_Point__c += sc.X24_Point__c;
         IF ((sc.Group_3_End__c > 24) && (sc.Group_2_End__c < 25)) sc.Group_3_Point__c += sc.X25_Point__c;
         IF ((sc.Group_3_End__c > 25) && (sc.Group_2_End__c < 26)) sc.Group_3_Point__c += sc.X26_Point__c;
         IF ((sc.Group_3_End__c > 26) && (sc.Group_2_End__c < 27)) sc.Group_3_Point__c += sc.X27_Point__c;
         IF ((sc.Group_3_End__c > 27) && (sc.Group_2_End__c < 28)) sc.Group_3_Point__c += sc.X28_Point__c;
         IF ((sc.Group_3_End__c > 28) && (sc.Group_2_End__c < 29)) sc.Group_3_Point__c += sc.X29_Point__c;
         IF ((sc.Group_3_End__c > 29) && (sc.Group_2_End__c < 30)) sc.Group_3_Point__c += sc.X30_Point__c;
         IF ((sc.Group_3_End__c > 30) && (sc.Group_2_End__c < 31)) sc.Group_3_Point__c += sc.X31_Point__c;
         IF ((sc.Group_3_End__c > 31) && (sc.Group_2_End__c < 32)) sc.Group_3_Point__c += sc.X32_Point__c;
         IF ((sc.Group_3_End__c > 32) && (sc.Group_2_End__c < 33)) sc.Group_3_Point__c += sc.X33_Point__c;
         IF ((sc.Group_3_End__c > 33) && (sc.Group_2_End__c < 34)) sc.Group_3_Point__c += sc.X34_Point__c;
         IF ((sc.Group_3_End__c > 34) && (sc.Group_2_End__c < 35)) sc.Group_3_Point__c += sc.X35_Point__c;
         IF ((sc.Group_3_End__c > 35) && (sc.Group_2_End__c < 36)) sc.Group_3_Point__c += sc.X36_Point__c;
         IF ((sc.Group_3_End__c > 36) && (sc.Group_2_End__c < 37)) sc.Group_3_Point__c += sc.X37_Point__c;
         IF ((sc.Group_3_End__c > 37) && (sc.Group_2_End__c < 38)) sc.Group_3_Point__c += sc.X38_Point__c;
         IF ((sc.Group_3_End__c > 38) && (sc.Group_2_End__c < 39)) sc.Group_3_Point__c += sc.X39_Point__c;
         IF ((sc.Group_3_End__c > 39) && (sc.Group_2_End__c < 40)) sc.Group_3_Point__c += sc.X40_Point__c;

//** Group 4 Point **
         IF ((sc.Group_4_End__c > 0) && (sc.Group_3_End__c < 1)) sc.Group_4_Point__c += sc.X1_Point__c; 
         IF ((sc.Group_4_End__c > 1) && (sc.Group_3_End__c < 2)) sc.Group_4_Point__c += sc.X2_Point__c;
         IF ((sc.Group_4_End__c > 2) && (sc.Group_3_End__c < 3)) sc.Group_4_Point__c += sc.X3_Point__c;
         IF ((sc.Group_4_End__c > 3) && (sc.Group_3_End__c < 4)) sc.Group_4_Point__c += sc.X4_Point__c;
         IF ((sc.Group_4_End__c > 4) && (sc.Group_3_End__c < 5)) sc.Group_4_Point__c += sc.X5_Point__c;
         IF ((sc.Group_4_End__c > 5) && (sc.Group_3_End__c < 6)) sc.Group_4_Point__c += sc.X6_Point__c;
         IF ((sc.Group_4_End__c > 6) && (sc.Group_3_End__c < 7)) sc.Group_4_Point__c += sc.X7_Point__c;
         IF ((sc.Group_4_End__c > 7) && (sc.Group_3_End__c < 8)) sc.Group_4_Point__c += sc.X8_Point__c;
         IF ((sc.Group_4_End__c > 8) && (sc.Group_3_End__c < 9)) sc.Group_4_Point__c += sc.X9_Point__c;
         IF ((sc.Group_4_End__c > 9) && (sc.Group_3_End__c < 10)) sc.Group_4_Point__c += sc.X10_Point__c;
         IF ((sc.Group_4_End__c > 10) && (sc.Group_3_End__c < 11)) sc.Group_4_Point__c += sc.X11_Point__c;
         IF ((sc.Group_4_End__c > 11) && (sc.Group_3_End__c < 12)) sc.Group_4_Point__c += sc.X12_Point__c;
         IF ((sc.Group_4_End__c > 12) && (sc.Group_3_End__c < 13)) sc.Group_4_Point__c += sc.X13_Point__c;
         IF ((sc.Group_4_End__c > 13) && (sc.Group_3_End__c < 14)) sc.Group_4_Point__c += sc.X14_Point__c;
         IF ((sc.Group_4_End__c > 14) && (sc.Group_3_End__c < 15)) sc.Group_4_Point__c += sc.X15_Point__c;
         IF ((sc.Group_4_End__c > 15) && (sc.Group_3_End__c < 16)) sc.Group_4_Point__c += sc.X16_Point__c;
         IF ((sc.Group_4_End__c > 16) && (sc.Group_3_End__c < 17)) sc.Group_4_Point__c += sc.X17_Point__c;
         IF ((sc.Group_4_End__c > 17) && (sc.Group_3_End__c < 18)) sc.Group_4_Point__c += sc.X18_Point__c;
         IF ((sc.Group_4_End__c > 18) && (sc.Group_3_End__c < 19)) sc.Group_4_Point__c += sc.X19_Point__c;
         IF ((sc.Group_4_End__c > 19) && (sc.Group_3_End__c < 20)) sc.Group_4_Point__c += sc.X20_Point__c;
         IF ((sc.Group_4_End__c > 20) && (sc.Group_3_End__c < 21)) sc.Group_4_Point__c += sc.X21_Point__c;
         IF ((sc.Group_4_End__c > 21) && (sc.Group_3_End__c < 22)) sc.Group_4_Point__c += sc.X22_Point__c;
         IF ((sc.Group_4_End__c > 22) && (sc.Group_3_End__c < 23)) sc.Group_4_Point__c += sc.X23_Point__c;
         IF ((sc.Group_4_End__c > 23) && (sc.Group_3_End__c < 24)) sc.Group_4_Point__c += sc.X24_Point__c;
         IF ((sc.Group_4_End__c > 24) && (sc.Group_3_End__c < 25)) sc.Group_4_Point__c += sc.X25_Point__c;
         IF ((sc.Group_4_End__c > 25) && (sc.Group_3_End__c < 26)) sc.Group_4_Point__c += sc.X26_Point__c;
         IF ((sc.Group_4_End__c > 26) && (sc.Group_3_End__c < 27)) sc.Group_4_Point__c += sc.X27_Point__c;
         IF ((sc.Group_4_End__c > 27) && (sc.Group_3_End__c < 28)) sc.Group_4_Point__c += sc.X28_Point__c;
         IF ((sc.Group_4_End__c > 28) && (sc.Group_3_End__c < 29)) sc.Group_4_Point__c += sc.X29_Point__c;
         IF ((sc.Group_4_End__c > 29) && (sc.Group_3_End__c < 30)) sc.Group_4_Point__c += sc.X30_Point__c;
         IF ((sc.Group_4_End__c > 30) && (sc.Group_3_End__c < 31)) sc.Group_4_Point__c += sc.X31_Point__c;
         IF ((sc.Group_4_End__c > 31) && (sc.Group_3_End__c < 32)) sc.Group_4_Point__c += sc.X32_Point__c;
         IF ((sc.Group_4_End__c > 32) && (sc.Group_3_End__c < 33)) sc.Group_4_Point__c += sc.X33_Point__c;
         IF ((sc.Group_4_End__c > 33) && (sc.Group_3_End__c < 34)) sc.Group_4_Point__c += sc.X34_Point__c;
         IF ((sc.Group_4_End__c > 34) && (sc.Group_3_End__c < 35)) sc.Group_4_Point__c += sc.X35_Point__c;
         IF ((sc.Group_4_End__c > 35) && (sc.Group_3_End__c < 36)) sc.Group_4_Point__c += sc.X36_Point__c;
         IF ((sc.Group_4_End__c > 36) && (sc.Group_3_End__c < 37)) sc.Group_4_Point__c += sc.X37_Point__c;
         IF ((sc.Group_4_End__c > 37) && (sc.Group_3_End__c < 38)) sc.Group_4_Point__c += sc.X38_Point__c;
         IF ((sc.Group_4_End__c > 38) && (sc.Group_3_End__c < 39)) sc.Group_4_Point__c += sc.X39_Point__c;
         IF ((sc.Group_4_End__c > 39) && (sc.Group_3_End__c < 40)) sc.Group_4_Point__c += sc.X40_Point__c;

//** Group 5 Point **             
         IF ((sc.Group_5_End__c > 0) && (sc.Group_4_End__c < 1)) sc.Group_5_Point__c += sc.X1_Point__c; 
         IF ((sc.Group_5_End__c > 1) && (sc.Group_4_End__c < 2)) sc.Group_5_Point__c += sc.X2_Point__c;
         IF ((sc.Group_5_End__c > 2) && (sc.Group_4_End__c < 3)) sc.Group_5_Point__c += sc.X3_Point__c;
         IF ((sc.Group_5_End__c > 3) && (sc.Group_4_End__c < 4)) sc.Group_5_Point__c += sc.X4_Point__c;
         IF ((sc.Group_5_End__c > 4) && (sc.Group_4_End__c < 5)) sc.Group_5_Point__c += sc.X5_Point__c;
         IF ((sc.Group_5_End__c > 5) && (sc.Group_4_End__c < 6)) sc.Group_5_Point__c += sc.X6_Point__c;
         IF ((sc.Group_5_End__c > 6) && (sc.Group_4_End__c < 7)) sc.Group_5_Point__c += sc.X7_Point__c;
         IF ((sc.Group_5_End__c > 7) && (sc.Group_4_End__c < 8)) sc.Group_5_Point__c += sc.X8_Point__c;
         IF ((sc.Group_5_End__c > 8) && (sc.Group_4_End__c < 9)) sc.Group_5_Point__c += sc.X9_Point__c;
         IF ((sc.Group_5_End__c > 9) && (sc.Group_4_End__c < 10)) sc.Group_5_Point__c += sc.X10_Point__c;
         IF ((sc.Group_5_End__c > 10) && (sc.Group_4_End__c < 11)) sc.Group_5_Point__c += sc.X11_Point__c;
         IF ((sc.Group_5_End__c > 11) && (sc.Group_4_End__c < 12)) sc.Group_5_Point__c += sc.X12_Point__c;
         IF ((sc.Group_5_End__c > 12) && (sc.Group_4_End__c < 13)) sc.Group_5_Point__c += sc.X13_Point__c;
         IF ((sc.Group_5_End__c > 13) && (sc.Group_4_End__c < 14)) sc.Group_5_Point__c += sc.X14_Point__c;
         IF ((sc.Group_5_End__c > 14) && (sc.Group_4_End__c < 15)) sc.Group_5_Point__c += sc.X15_Point__c;
         IF ((sc.Group_5_End__c > 15) && (sc.Group_4_End__c < 16)) sc.Group_5_Point__c += sc.X16_Point__c;
         IF ((sc.Group_5_End__c > 16) && (sc.Group_4_End__c < 17)) sc.Group_5_Point__c += sc.X17_Point__c;
         IF ((sc.Group_5_End__c > 17) && (sc.Group_4_End__c < 18)) sc.Group_5_Point__c += sc.X18_Point__c;
         IF ((sc.Group_5_End__c > 18) && (sc.Group_4_End__c < 19)) sc.Group_5_Point__c += sc.X19_Point__c;
         IF ((sc.Group_5_End__c > 19) && (sc.Group_4_End__c < 20)) sc.Group_5_Point__c += sc.X20_Point__c;
         IF ((sc.Group_5_End__c > 20) && (sc.Group_4_End__c < 21)) sc.Group_5_Point__c += sc.X21_Point__c;
         IF ((sc.Group_5_End__c > 21) && (sc.Group_4_End__c < 22)) sc.Group_5_Point__c += sc.X22_Point__c;
         IF ((sc.Group_5_End__c > 22) && (sc.Group_4_End__c < 23)) sc.Group_5_Point__c += sc.X23_Point__c;
         IF ((sc.Group_5_End__c > 23) && (sc.Group_4_End__c < 24)) sc.Group_5_Point__c += sc.X24_Point__c;
         IF ((sc.Group_5_End__c > 24) && (sc.Group_4_End__c < 25)) sc.Group_5_Point__c += sc.X25_Point__c;
         IF ((sc.Group_5_End__c > 25) && (sc.Group_4_End__c < 26)) sc.Group_5_Point__c += sc.X26_Point__c;
         IF ((sc.Group_5_End__c > 26) && (sc.Group_4_End__c < 27)) sc.Group_5_Point__c += sc.X27_Point__c;
         IF ((sc.Group_5_End__c > 27) && (sc.Group_4_End__c < 28)) sc.Group_5_Point__c += sc.X28_Point__c;
         IF ((sc.Group_5_End__c > 28) && (sc.Group_4_End__c < 29)) sc.Group_5_Point__c += sc.X29_Point__c;
         IF ((sc.Group_5_End__c > 29) && (sc.Group_4_End__c < 30)) sc.Group_5_Point__c += sc.X30_Point__c;
         IF ((sc.Group_5_End__c > 30) && (sc.Group_4_End__c < 31)) sc.Group_5_Point__c += sc.X31_Point__c;
         IF ((sc.Group_5_End__c > 31) && (sc.Group_4_End__c < 32)) sc.Group_5_Point__c += sc.X32_Point__c;
         IF ((sc.Group_5_End__c > 32) && (sc.Group_4_End__c < 33)) sc.Group_5_Point__c += sc.X33_Point__c;
         IF ((sc.Group_5_End__c > 33) && (sc.Group_4_End__c < 34)) sc.Group_5_Point__c += sc.X34_Point__c;
         IF ((sc.Group_5_End__c > 34) && (sc.Group_4_End__c < 35)) sc.Group_5_Point__c += sc.X35_Point__c;
         IF ((sc.Group_5_End__c > 35) && (sc.Group_4_End__c < 36)) sc.Group_5_Point__c += sc.X36_Point__c;
         IF ((sc.Group_5_End__c > 36) && (sc.Group_4_End__c < 37)) sc.Group_5_Point__c += sc.X37_Point__c;
         IF ((sc.Group_5_End__c > 37) && (sc.Group_4_End__c < 38)) sc.Group_5_Point__c += sc.X38_Point__c;
         IF ((sc.Group_5_End__c > 38) && (sc.Group_4_End__c < 39)) sc.Group_5_Point__c += sc.X39_Point__c;
         IF ((sc.Group_5_End__c > 39) && (sc.Group_4_End__c < 40)) sc.Group_5_Point__c += sc.X40_Point__c;

         if (sc.Master__c) {
            sc.FullMark_Group_1__c = sc.Group_1_Point__c;
            sc.FullMark_Group_2__c = sc.Group_2_Point__c;
            sc.FullMark_Group_3__c = sc.Group_3_Point__c;
            sc.FullMark_Group_4__c = sc.Group_4_Point__c;
            sc.FullMark_Group_5__c = sc.Group_5_Point__c;   
         }            
    }
}