trigger KPI_Trigger on Agent_KPI__c (after Insert) {
    for (Agent_KPI__c kpi : trigger.new) {
         // Query Master
        if (trigger.isInsert && kpi.Entity__c != 'ALI') {
            if (!kpi.Master__c) {
                //Agent_KPI__c
                Agent_KPI__c kpi2 = new Agent_KPI__c();
                Agent_KPI__c opp = new Agent_KPI__c();
                DescribeSObjectResult describeResultOpp = Agent_KPI__c.getSObjectType().getDescribe();
                List<String> oppFieldList = new List<String>(describeResultOpp.fields.getMap().keySet());
                String oppFields = String.join(oppFieldList, ',');
                String oppQuery = ' SELECT ' + oppFields + ' FROM Agent_KPI__c WHERE Team__c = \''+kpi.Team__c+'\' and Master__c = TRUE and Entity__c = \''+kpi.Entity__c+'\' LIMIT 1 ';
                SObject currentOpp = Database.query(oppQuery);
                opp = (Agent_KPI__c) currentOpp;

                //Agent_KPI__c 
                Agent_KPI__c opp2 = new Agent_KPI__c();
                oppQuery = ' SELECT ' + oppFields + ' FROM Agent_KPI__c WHERE id = \''+kpi.id+'\' ';
                SObject currentOpp2 = Database.query(oppQuery);
                kpi2 = (Agent_KPI__c) currentOpp2;
                         
                //Agent_KPI_Item__c
                DescribeSObjectResult describeResultOli = Agent_KPI_Item__c.getSObjectType().getDescribe();
                List<String> oliFieldList = new List<String>(describeResultOli.fields.getMap().keySet());
                String oliFields = String.join(oliFieldList, ',');
                String oliQuery = ' SELECT ' + oliFields + ' FROM Agent_KPI_Item__c WHERE Agent_KPI__c = \''+opp.Id+'\' ORDER BY Id ASC ';
                List<SObject> currentOliList = Database.query(oliQuery);

                if (currentOliList.size() > 0){
                    //RecordType rt = [SELECT Id, Name, DeveloperName, NamespacePrefix, Description, BusinessProcessId, SobjectType, IsActive FROM RecordType WHERE SobjectType = 'Agent_KPI__c' and Name = 'Edit'];
                    //kpi.RecordTypeId = rt.id;
                    kpi2.Final_Rating_1_Name__c = opp.Final_Rating_1_Name__c;
                    kpi2.Final_Rating_2_Name__c = opp.Final_Rating_2_Name__c;
                    kpi2.Final_Rating_3_Name__c = opp.Final_Rating_3_Name__c;
                    kpi2.Final_Rating_4_Name__c = opp.Final_Rating_4_Name__c;
                    kpi2.Final_Rating_5_Name__c = opp.Final_Rating_5_Name__c;
                    kpi2.Final_Rating_6_Name__c = opp.Final_Rating_6_Name__c;
                    kpi2.Final_Rating_7_Name__c = opp.Final_Rating_7_Name__c;
                    kpi2.Final_Rating_8_Name__c = opp.Final_Rating_8_Name__c;
                    kpi2.Final_Rating_9_Name__c = opp.Final_Rating_9_Name__c;
                    kpi2.Rating_1_Name__c = opp.Rating_1_Name__c;
                    kpi2.Rating_1_Score__c = opp.Rating_1_Score__c;
                    kpi2.Rating_2_Name__c = opp.Rating_2_Name__c;
                    kpi2.Rating_2_Score__c = opp.Rating_2_Score__c;
                    kpi2.Rating_3_Name__c = opp.Rating_3_Name__c;
                    kpi2.Rating_3_Score__c = opp.Rating_3_Score__c;
                    kpi2.Rating_4_Name__c = opp.Rating_4_Name__c;
                    kpi2.Rating_4_Score__c = opp.Rating_4_Score__c;
                    kpi2.Rating_5_Name__c = opp.Rating_5_Name__c;
                    kpi2.Rating_5_Score__c = opp.Rating_5_Score__c;
                    kpi2.Rating_6_Name__c = opp.Rating_6_Name__c;
                    kpi2.Rating_6_Score__c = opp.Rating_6_Score__c;
                    kpi2.Rating_7_Name__c = opp.Rating_7_Name__c;
                    kpi2.Rating_7_Score__c = opp.Rating_7_Score__c;
                    kpi2.Rating_8_Name__c = opp.Rating_8_Name__c;
                    kpi2.Rating_8_Score__c = opp.Rating_8_Score__c;
                    kpi2.Rating_9_Name__c = opp.Rating_9_Name__c;
                    kpi2.Rating_9_Score__c = opp.Rating_9_Score__c;
                    kpi2.Type_Score__c = opp.Type_Score__c;
                    
                    // insert Item
                    list<Agent_KPI_Item__c> AKPII = new list<Agent_KPI_Item__c>();
                    for (SObject currentOli : currentOliList) {
                        Agent_KPI_Item__c newAKPII = (Agent_KPI_Item__c) currentOli;
                        //Agent_KPI_Item__c newAKPII = new Agent_KPI_Item__c();

                        newAKPII.id = null;
                        newAKPII.Agent_KPI__c = kpi.id;
                        newAKPII.Actual_Data__c = null;
                        newAKPII.Actual_Score__c = null;
                        AKPII.add(newAKPII);
                    }

                    if (kpi.Master__c) kpi2.External_Id__c = kpi.Entity__c+'-'+kpi.Team__c;
                    else kpi2.External_Id__c = kpi.Agent__c+'-'+kpi.Periode__c;
                    
                    insert AKPII;
                    update kpi2;
                }
                else {
                    kpi.AddError('Not Master Available.');
                }
            }
        }
           
    }
}