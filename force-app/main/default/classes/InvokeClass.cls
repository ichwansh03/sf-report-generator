global class InvokeClass{ 
    //15 Jan 2019, Daniel, add "Unread" Button
    webservice static void UpdateEmailStatusToUnread(String caseid) {
        //Case cs  = [select id, CaseNumber, Email_Status__c, owner.Name, OwnerId from case where id=:caseid AND Email_Status__c != 'Unread'];
        Case cs  = [select id, CaseNumber, Email_Status__c, owner.Name, OwnerId from case where id=:caseid];
        cs.Email_Status__c = 'Unread';
        update cs;
    }
    
    // 10 Dec 2019, Daniel, add "No Need Reply" Button
    webservice static void UpdateNoNeedReply(String caseid) {
        Case cs  = [select id, Parent.CaseNumber, No_Need_To_Reply_New__c from case where Id =: caseid AND No_Need_To_Reply_New__c = FALSE];
        
        List<EmailMessage> l_EmailMessage = [Select Id, Incoming, ReplyToEmailMessageId, ParentId, Parent.CaseNumber, Parent.Origin, Parent.No_Need_To_Reply_New__c, First_Response_Date_In_Datetime__c, Last_Response_Date__c From EmailMessage where ParentId =: caseid ORDER BY MessageDate DESC LIMIT 1];
        system.debug('l_EmailMessage: '+l_EmailMessage);
        Integer CountEmailMessage = l_EmailMessage.size();
        system.debug('--- CountEmailMessage: '+CountEmailMessage);
        
        Map<String, String> mapEmailMessage = new Map<String, String>();
        
        List<EmailMessage> l_em = new List<EmailMessage>();
        for(EmailMessage em : l_EmailMessage){
            if(em.ParentId == caseid && em.Incoming == TRUE && em.First_Response_Date_In_Datetime__c == null){
                em.First_Response_Date_In_Datetime__c = system.now();
                em.Last_Response_Date__c = system.now();
                em.Reason__c = 'No Need to Reply';
                //em.Status = '2';
                update em;
                //mapEmailMessage.put(em.ParentId, em.Id);
                //system.debug('mapEmailMessage: '+mapEmailMessage);
            }
        }
        cs.No_Need_To_Reply_New__c = TRUE; 
        update cs;
    }
    
    
    // 4 sept 2019, taufik, add, for Action Button "Accept"
    webservice static void UpdateOwnerCase(String caseid) {
        //ESBServices_GetLog_SIMKEU.getCallOut(billid);
        Case cs  = [select id, ownerid from case where id=:caseid];
        cs.OwnerId = userinfo.getUserId();
        cs.Named_User__c = userinfo.getName(); 
        update cs;
    }
    
    webservice static void QCRefresh(String Dataid) {
        id DataQuery = id.valueof(Dataid);
        
        Quality_Control__c sc = [SELECT id, 
            Group_1_End__c, Group_1_Name__c, Group_2_End__c, Group_2_Name__c, Group_3_End__c, Group_3_Name__c, Group_4_End__c, Group_4_Name__c, Group_5_End__c, Group_5_Name__c, 
            Rating_A_Name__c, Rating_A_Score__c, Rating_B_Name__c, Rating_B_Score__c, Rating_C_Name__c, Rating_C_Score__c, Rating_D_Name__c, Rating_D_Score__c, Rating_E_Name__c, Rating_E_Score__c, 
            X1_Key_Check__c, X1_Master_Point__c, X2_Key_Check__c, X2_Master_Point__c, X3_Key_Check__c, X3_Master_Point__c, X4_Key_Check__c, X4_Master_Point__c, X5_Key_Check__c, X5_Master_Point__c, 
            X6_Key_Check__c, X6_Master_Point__c, X7_Key_Check__c, X7_Master_Point__c, X8_Key_Check__c, X8_Master_Point__c, X9_Key_Check__c, X9_Master_Point__c, X10_Key_Check__c, X10_Master_Point__c, 
            X11_Key_Check__c, X11_Master_Point__c, X12_Key_Check__c, X12_Master_Point__c, X13_Key_Check__c, X13_Master_Point__c, X14_Key_Check__c, X14_Master_Point__c, X15_Key_Check__c, X15_Master_Point__c, 
            X16_Key_Check__c, X16_Master_Point__c, X17_Key_Check__c, X17_Master_Point__c, X18_Key_Check__c, X18_Master_Point__c, X19_Key_Check__c, X19_Master_Point__c, X20_Key_Check__c, X20_Master_Point__c, 
            X21_Key_Check__c, X21_Master_Point__c, X22_Key_Check__c, X22_Master_Point__c, X23_Key_Check__c, X23_Master_Point__c, X24_Key_Check__c, X24_Master_Point__c, X25_Key_Check__c, X25_Master_Point__c, 
            X26_Key_Check__c, X26_Master_Point__c, X27_Key_Check__c, X27_Master_Point__c, X28_Key_Check__c, X28_Master_Point__c, X29_Key_Check__c, X29_Master_Point__c, X30_Key_Check__c, X30_Master_Point__c, 
            X31_Key_Check__c, X31_Master_Point__c, X32_Key_Check__c, X32_Master_Point__c, X33_Key_Check__c, X33_Master_Point__c, X34_Key_Check__c, X34_Master_Point__c, X35_Key_Check__c, X35_Master_Point__c,
            Pass_Group_1__c, Pass_Group_2__c, Pass_Group_3__c, Pass_Group_4__c, Pass_Group_5__c,
            X1_Scoring_Schemes__c, X2_Scoring_Schemes__c, X3_Scoring_Schemes__c, X4_Scoring_Schemes__c, X5_Scoring_Schemes__c, 
            X6_Scoring_Schemes__c, X7_Scoring_Schemes__c, X8_Scoring_Schemes__c, X9_Scoring_Schemes__c, X10_Scoring_Schemes__c, 
            X11_Scoring_Schemes__c, X12_Scoring_Schemes__c, X13_Scoring_Schemes__c, X14_Scoring_Schemes__c, X15_Scoring_Schemes__c, 
            X16_Scoring_Schemes__c, X17_Scoring_Schemes__c, X18_Scoring_Schemes__c, X19_Scoring_Schemes__c, X20_Scoring_Schemes__c, 
            X21_Scoring_Schemes__c, X22_Scoring_Schemes__c, X23_Scoring_Schemes__c, X24_Scoring_Schemes__c, X25_Scoring_Schemes__c, 
            X26_Scoring_Schemes__c, X27_Scoring_Schemes__c, X28_Scoring_Schemes__c, X29_Scoring_Schemes__c, X30_Scoring_Schemes__c, 
            X31_Scoring_Schemes__c, X32_Scoring_Schemes__c, X33_Scoring_Schemes__c, X34_Scoring_Schemes__c, X35_Scoring_Schemes__c,
            Team__c, Entity__c, 
            FullMark_Group_1__c, FullMark_Group_2__c, FullMark_Group_3__c, FullMark_Group_4__c, FullMark_Group_5__c
        FROM Quality_Control__c WHERE id =: DataQuery];
    
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
            Pass_Group_1__c, Pass_Group_2__c, Pass_Group_3__c, Pass_Group_4__c, Pass_Group_5__c,
            X1_Scoring_Schemes__c, X2_Scoring_Schemes__c, X3_Scoring_Schemes__c, X4_Scoring_Schemes__c, X5_Scoring_Schemes__c, 
            X6_Scoring_Schemes__c, X7_Scoring_Schemes__c, X8_Scoring_Schemes__c, X9_Scoring_Schemes__c, X10_Scoring_Schemes__c, 
            X11_Scoring_Schemes__c, X12_Scoring_Schemes__c, X13_Scoring_Schemes__c, X14_Scoring_Schemes__c, X15_Scoring_Schemes__c, 
            X16_Scoring_Schemes__c, X17_Scoring_Schemes__c, X18_Scoring_Schemes__c, X19_Scoring_Schemes__c, X20_Scoring_Schemes__c, 
            X21_Scoring_Schemes__c, X22_Scoring_Schemes__c, X23_Scoring_Schemes__c, X24_Scoring_Schemes__c, X25_Scoring_Schemes__c, 
            X26_Scoring_Schemes__c, X27_Scoring_Schemes__c, X28_Scoring_Schemes__c, X29_Scoring_Schemes__c, X30_Scoring_Schemes__c, 
            X31_Scoring_Schemes__c, X32_Scoring_Schemes__c, X33_Scoring_Schemes__c, X34_Scoring_Schemes__c, X35_Scoring_Schemes__c,
            FullMark_Group_1__c, FullMark_Group_2__c, FullMark_Group_3__c, FullMark_Group_4__c, FullMark_Group_5__c
        FROM Quality_Control__c WHERE Team__c = :sc.Team__c and Master__c = TRUE and Entity__c =: sc.Entity__c];
    
        if (scmaster.size() > 0) {
            //RecordType rt = [SELECT Id, Name, DeveloperName, NamespacePrefix, Description, BusinessProcessId, SobjectType, IsActive FROM RecordType WHERE SobjectType = 'Quality_Control__c' and Name = 'Edit'];
            //sc.RecordTypeId = rt.id;
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
            
            update sc;
        }
        else {
            sc.AddError('Not Master Available.');
        }
    }
    
    //--Added by Suryono 24 Jan 2019
    webservice static void KpiItemRefresh(String kpiId) {
        Agent_KPI__c currentAgentKPI = [SELECT Id, Entity__c, Master__c, Team__c, Agent__c, Periode__c FROM Agent_KPI__c WHERE Id = :kpiId];
        
        if(currentAgentKPI.Entity__c != 'ALI' && !currentAgentKPI.Master__c) {
            List<Agent_KPI_Item__c> akiList = [SELECT Id, Agent_KPI__c, Seq__c FROM Agent_KPI_Item__c WHERE Agent_KPI__c = :kpiId];        
            if(akiList.size() > 0) {
                delete akiList;
            }
            
            //--Find Master Agent KPI
            Agent_KPI__c masterAgentKPI = new Agent_KPI__c();
            DescribeSObjectResult describeResultAgentKPI = Agent_KPI__c.getSObjectType().getDescribe();
            List<String> agentKPIFieldList = new List<String>(describeResultAgentKPI.fields.getMap().keySet());
            String agentKPIFields = String.join(agentKPIFieldList, ',');
            String agentKPIQuery = ' SELECT ' + agentKPIFields + ' FROM Agent_KPI__c WHERE Team__c = \''+currentAgentKPI.Team__c+'\' and Master__c = TRUE and Entity__c = \''+currentAgentKPI.Entity__c+'\' LIMIT 1 ';
            SObject qMsAgentKPI = Database.query(agentKPIQuery);
            masterAgentKPI = (Agent_KPI__c) qMsAgentKPI;
            
            //--Select User Agent KPI
            Agent_KPI__c userAgentKPI = new Agent_KPI__c();
            agentKPIQuery = ' SELECT ' + agentKPIFields + ' FROM Agent_KPI__c WHERE id = \''+currentAgentKPI.Id+'\' ';
            SObject qUserAgentKPI = Database.query(agentKPIQuery);
            userAgentKPI = (Agent_KPI__c) qUserAgentKPI;
            
            //--Select Master KPI Item
            DescribeSObjectResult describeResultAgentKPIItem = Agent_KPI_Item__c.getSObjectType().getDescribe();
            List<String> kpiItemFieldList = new List<String>(describeResultAgentKPIItem.fields.getMap().keySet());
            String kpiItemFields = String.join(kpiItemFieldList, ',');
            String kpiItemQuery = ' SELECT ' + kpiItemFields + ' FROM Agent_KPI_Item__c WHERE Agent_KPI__c = \''+masterAgentKPI.Id+'\' ORDER BY Id ASC ';
            List<SObject> masterKPIItemList = Database.query(kpiItemQuery);
            
            if(masterKPIItemList.size() > 0) {
                userAgentKPI.Final_Rating_1_Name__c = masterAgentKPI.Final_Rating_1_Name__c;
                userAgentKPI.Final_Rating_2_Name__c = masterAgentKPI.Final_Rating_2_Name__c;
                userAgentKPI.Final_Rating_3_Name__c = masterAgentKPI.Final_Rating_3_Name__c;
                userAgentKPI.Final_Rating_4_Name__c = masterAgentKPI.Final_Rating_4_Name__c;
                userAgentKPI.Final_Rating_5_Name__c = masterAgentKPI.Final_Rating_5_Name__c;
                userAgentKPI.Final_Rating_6_Name__c = masterAgentKPI.Final_Rating_6_Name__c;
                userAgentKPI.Final_Rating_7_Name__c = masterAgentKPI.Final_Rating_7_Name__c;
                userAgentKPI.Final_Rating_8_Name__c = masterAgentKPI.Final_Rating_8_Name__c;
                userAgentKPI.Final_Rating_9_Name__c = masterAgentKPI.Final_Rating_9_Name__c;
                userAgentKPI.Rating_1_Name__c = masterAgentKPI.Rating_1_Name__c;
                userAgentKPI.Rating_1_Score__c = masterAgentKPI.Rating_1_Score__c;
                userAgentKPI.Rating_2_Name__c = masterAgentKPI.Rating_2_Name__c;
                userAgentKPI.Rating_2_Score__c = masterAgentKPI.Rating_2_Score__c;
                userAgentKPI.Rating_3_Name__c = masterAgentKPI.Rating_3_Name__c;
                userAgentKPI.Rating_3_Score__c = masterAgentKPI.Rating_3_Score__c;
                userAgentKPI.Rating_4_Name__c = masterAgentKPI.Rating_4_Name__c;
                userAgentKPI.Rating_4_Score__c = masterAgentKPI.Rating_4_Score__c;
                userAgentKPI.Rating_5_Name__c = masterAgentKPI.Rating_5_Name__c;
                userAgentKPI.Rating_5_Score__c = masterAgentKPI.Rating_5_Score__c;
                userAgentKPI.Rating_6_Name__c = masterAgentKPI.Rating_6_Name__c;
                userAgentKPI.Rating_6_Score__c = masterAgentKPI.Rating_6_Score__c;
                userAgentKPI.Rating_7_Name__c = masterAgentKPI.Rating_7_Name__c;
                userAgentKPI.Rating_7_Score__c = masterAgentKPI.Rating_7_Score__c;
                userAgentKPI.Rating_8_Name__c = masterAgentKPI.Rating_8_Name__c;
                userAgentKPI.Rating_8_Score__c = masterAgentKPI.Rating_8_Score__c;
                userAgentKPI.Rating_9_Name__c = masterAgentKPI.Rating_9_Name__c;
                userAgentKPI.Rating_9_Score__c = masterAgentKPI.Rating_9_Score__c;
                userAgentKPI.Type_Score__c = masterAgentKPI.Type_Score__c;
                
                //--Insert User KPI Item
                List<Agent_KPI_Item__c> userKPIItemList = new List<Agent_KPI_Item__c>();
                
                for (SObject masterKPIItem : masterKPIItemList) {
                    Agent_KPI_Item__c userKPIItem = (Agent_KPI_Item__c) masterKPIItem;
                    
                    userKPIItem.Id = null;
                    userKPIItem.Agent_KPI__c = currentAgentKPI.Id;
                    userKPIItem.Actual_Data__c = null;
                    userKPIItem.Actual_Score__c = null;
                    userKPIItemList.add(userKPIItem);
                }
                
                if (currentAgentKPI.Master__c) userAgentKPI.External_Id__c = currentAgentKPI.Entity__c+'-'+currentAgentKPI.Team__c;
                else userAgentKPI.External_Id__c = currentAgentKPI.Agent__c+'-'+currentAgentKPI.Periode__c;
                        
                insert userKPIItemList;
                update userAgentKPI;
            } else {
                currentAgentKPI.AddError('No Master KPI is Available.');
            }
        }
    }
}