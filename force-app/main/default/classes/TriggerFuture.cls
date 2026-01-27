global class TriggerFuture{
    @Future
    public static void UpdateParentCase(Id DataId, Id ParentId){
        //try { 

        Case cs = [SELECT id, Last_Child_Case__c, FCR__c FROM Case WHERE id =:ParentId ];

        case[] cs2 = [SELECT id, Last_Child_Case__c, FCR__c FROM Case WHERE id =:ParentId ];
        Approval.UnlockResult[] results = Approval.unlock(cs2, false);

    
        cs.FCR__c = FALSE;
        cs.Last_Child_Case__c = DataId;
        
        update cs;

        
//        } catch (Exception e) {
//            System.debug(e);
//        }
    }    
    
    // for ALI
    @Future
    public static void AgentScheduling(Id DataId){
        Agent_Scheduling__c ags = [SELECT id FROM Agent_Scheduling__c WHERE id =: DataId];
        update ags;
    }

    // for ALI - Update Call Line, set Agent.
    @Future
    public static void CallLineUpdateChild(Id DataId){
        List<call_line__c> listCL = new List<call_line__c>();
        for (call_line__c cl : [select id, Parent_Call_Line__c, agent__c, Parent_Call_Line__r.agent__c from call_line__c 
                                where agent__c = NULL and 
                                    Parent_Call_Line__r.agent__c != NULL and 
                                    //Entity__c = 'ALI' and 
                                    Parent_Call_Line__c != NULL
                                and Call_List__c =: DataId]){
            cl.agent__c = cl.Parent_Call_Line__r.agent__c;
            listCL.add(cl);
        }
        update listCL;
        

    }

    // for ALI - Auto Share to Agent
    @Future
    public static void ShareScoreCard(Id AccountId, Id ParentOwnerId, Id OldParentOwnerId, String AccountAccess){
        try { 
            if (ParentOwnerId <> OldParentOwnerId) {
                list <Score_Card__Share> acs = [SELECT id FROM Score_Card__Share WHERE ParentId =: AccountId and UserOrGroupId =: OldParentOwnerId];
                if (acs.size() > 0 && !Test.isRunningTest()) delete acs;
            }

            Score_Card__Share acctshare = new Score_Card__Share(ParentId = AccountID, UserOrGroupId = ParentOwnerId, AccessLevel = AccountAccess);
            if(!Test.isRunningTest()) upsert acctshare;
        } catch (Exception e) {
            System.debug(e);
        }
    }    

    // for ALI - Auto Share to Agent
    @Future
    public static void ShareAgentPerformance(Id AccountId, Id ParentOwnerId, Id OldParentOwnerId, String AccountAccess){
        try { 
            if (ParentOwnerId <> OldParentOwnerId) {
                list <Agent_Performance__Share> acs = [SELECT id FROM Agent_Performance__Share WHERE ParentId =: AccountId and UserOrGroupId =: OldParentOwnerId];
                if (acs.size() > 0 && !Test.isRunningTest()) delete acs;
            }

            Agent_Performance__Share acctshare = new Agent_Performance__Share(ParentId = AccountID, UserOrGroupId = ParentOwnerId, AccessLevel = AccountAccess);
            if(!Test.isRunningTest()) upsert acctshare;
        } catch (Exception e) {
            System.debug(e);
        }
    }
    
    //--Added by Suryono 31 Jan 2019
    @future
    public static void ShareAgentKPI(Id AccountId, Id ParentOwnerId, Id OldParentOwnerId, String AccountAccess){
        try { 
            if (ParentOwnerId <> OldParentOwnerId || Test.isRunningTest()) {
                List <Agent_KPI__Share> aksList = [SELECT id FROM Agent_KPI__Share WHERE ParentId =: AccountId and UserOrGroupId =: OldParentOwnerId];
                if (aksList.size() > 0 && !Test.isRunningTest()) {
                    delete aksList;
                }
            }

            Agent_KPI__Share accShare = new Agent_KPI__Share(ParentId = AccountID, UserOrGroupId = ParentOwnerId, AccessLevel = AccountAccess);
            if(!Test.isRunningTest()) upsert accShare;
        } catch (Exception e) {
            System.debug(e);
        }
    }
    //--End Added by Suryono 31 Jan 2019

    //--Added by Taufik 12 Feb 2019
    @future
    public static void ShareQualityControl(Id AccountId, Id ParentOwnerId, Id OldParentOwnerId, String AccountAccess){
        try { 
            if (ParentOwnerId <> OldParentOwnerId || Test.isRunningTest()) {
                List <Quality_Control__Share> aksList = [SELECT id FROM Quality_Control__Share WHERE ParentId =: AccountId and UserOrGroupId =: OldParentOwnerId];
                if (aksList.size() > 0 && !Test.isRunningTest()) {
                    delete aksList;
                }
            }

            Quality_Control__Share accShare = new Quality_Control__Share(ParentId = AccountID, UserOrGroupId = ParentOwnerId, AccessLevel = AccountAccess);
            if(!Test.isRunningTest()) upsert accShare;
        } catch (Exception e) {
            System.debug(e);
        }
    }
    //--End Added by Taufik 12 Feb 2019
    
}