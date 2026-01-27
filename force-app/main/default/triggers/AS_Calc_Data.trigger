trigger AS_Calc_Data on Agent_Scheduling__c (After Update) {
    if (Trigger.isAfter) {
        for (Agent_Scheduling__c ags : trigger.new){
            if (ags.Calc_Data__c) {
                Agent_Scheduling__c ags2 = [SELECT id, Calc_Data__c, Agent_SIP__c, Document_Date__c, Entity__c, Status__c, 
                First_Login_01__c, First_Login_02__c, First_Login_03__c, First_Login_04__c, First_Login_05__c,
                First_Login_06__c, First_Login_07__c, First_Login_08__c, First_Login_09__c, First_Login_10__c,
                First_Login_11__c, First_Login_12__c, First_Login_13__c, First_Login_14__c, First_Login_15__c,
                First_Login_16__c, First_Login_17__c, First_Login_18__c, First_Login_19__c, First_Login_20__c,
                First_Login_21__c, First_Login_22__c, First_Login_23__c, First_Login_24__c, First_Login_25__c,
                First_Login_26__c, First_Login_27__c, First_Login_28__c, First_Login_29__c, First_Login_30__c,
                First_Login_31__c
                FROM Agent_Scheduling__c WHERE id =: ags.id];
                
                ags2.Calc_Data__c = False;
                ags2.Status__c = 'Approved';

                Map<string,Agent_Status__c> mapAG = new Map<string,Agent_Status__c>();
                for (Agent_Status__c AG : [SELECT Id, Name, AUX_Time__c, Agent__c, 
                    Average_Talk_Time__c, Date__c, Login_Time__c, 
                    Duration_AUX_Time__c, Duration_Average_Talk_Time__c, Duration_Service_Time__c, 
                    SIP__c FROM Agent_Status__c WHERE SIP__c=:ags.Agent_SIP__c and Periode__c =: ags.Periode__c ]){
                    
                    if (AG.SIP__c != NULL)
                    mapAG.put(AG.SIP__c+'-'+AG.Date__c.day(),AG);
                }
                
                // map to First Login
                if (mapAG.get(ags.Agent_SIP__c+'-1') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-1').Login_Time__c != NULL) ags2.First_Login_01__c = mapAG.get(ags.Agent_SIP__c+'-1').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-2') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-2').Login_Time__c != NULL) ags2.First_Login_02__c = mapAG.get(ags.Agent_SIP__c+'-2').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-3') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-3').Login_Time__c != NULL) ags2.First_Login_03__c = mapAG.get(ags.Agent_SIP__c+'-3').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-4') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-4').Login_Time__c != NULL) ags2.First_Login_04__c = mapAG.get(ags.Agent_SIP__c+'-4').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-5') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-5').Login_Time__c != NULL) ags2.First_Login_05__c = mapAG.get(ags.Agent_SIP__c+'-5').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-6') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-6').Login_Time__c != NULL) ags2.First_Login_06__c = mapAG.get(ags.Agent_SIP__c+'-6').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-7') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-7').Login_Time__c != NULL) ags2.First_Login_07__c = mapAG.get(ags.Agent_SIP__c+'-7').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-8') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-8').Login_Time__c != NULL) ags2.First_Login_08__c = mapAG.get(ags.Agent_SIP__c+'-8').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-9') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-9').Login_Time__c != NULL) ags2.First_Login_09__c = mapAG.get(ags.Agent_SIP__c+'-9').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-10') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-10').Login_Time__c != NULL) ags2.First_Login_10__c = mapAG.get(ags.Agent_SIP__c+'-10').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-11') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-11').Login_Time__c != NULL) ags2.First_Login_11__c = mapAG.get(ags.Agent_SIP__c+'-11').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-12') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-12').Login_Time__c != NULL) ags2.First_Login_12__c = mapAG.get(ags.Agent_SIP__c+'-12').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-13') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-13').Login_Time__c != NULL) ags2.First_Login_13__c = mapAG.get(ags.Agent_SIP__c+'-13').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-14') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-14').Login_Time__c != NULL) ags2.First_Login_14__c = mapAG.get(ags.Agent_SIP__c+'-14').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-15') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-15').Login_Time__c != NULL) ags2.First_Login_15__c = mapAG.get(ags.Agent_SIP__c+'-15').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-16') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-16').Login_Time__c != NULL) ags2.First_Login_16__c = mapAG.get(ags.Agent_SIP__c+'-16').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-17') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-17').Login_Time__c != NULL) ags2.First_Login_17__c = mapAG.get(ags.Agent_SIP__c+'-17').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-18') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-18').Login_Time__c != NULL) ags2.First_Login_18__c = mapAG.get(ags.Agent_SIP__c+'-18').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-19') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-19').Login_Time__c != NULL) ags2.First_Login_19__c = mapAG.get(ags.Agent_SIP__c+'-19').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-20') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-20').Login_Time__c != NULL) ags2.First_Login_20__c = mapAG.get(ags.Agent_SIP__c+'-20').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-21') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-21').Login_Time__c != NULL) ags2.First_Login_21__c = mapAG.get(ags.Agent_SIP__c+'-21').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-22') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-22').Login_Time__c != NULL) ags2.First_Login_22__c = mapAG.get(ags.Agent_SIP__c+'-22').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-23') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-23').Login_Time__c != NULL) ags2.First_Login_23__c = mapAG.get(ags.Agent_SIP__c+'-23').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-24') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-24').Login_Time__c != NULL) ags2.First_Login_24__c = mapAG.get(ags.Agent_SIP__c+'-24').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-25') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-25').Login_Time__c != NULL) ags2.First_Login_25__c = mapAG.get(ags.Agent_SIP__c+'-25').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-26') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-26').Login_Time__c != NULL) ags2.First_Login_26__c = mapAG.get(ags.Agent_SIP__c+'-26').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-27') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-27').Login_Time__c != NULL) ags2.First_Login_27__c = mapAG.get(ags.Agent_SIP__c+'-27').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-28') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-28').Login_Time__c != NULL) ags2.First_Login_28__c = mapAG.get(ags.Agent_SIP__c+'-28').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-29') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-29').Login_Time__c != NULL) ags2.First_Login_29__c = mapAG.get(ags.Agent_SIP__c+'-29').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-30') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-30').Login_Time__c != NULL) ags2.First_Login_30__c = mapAG.get(ags.Agent_SIP__c+'-30').Login_Time__c;
                if (mapAG.get(ags.Agent_SIP__c+'-31') != NULL) if (mapAG.get(ags.Agent_SIP__c+'-31').Login_Time__c != NULL) ags2.First_Login_31__c = mapAG.get(ags.Agent_SIP__c+'-31').Login_Time__c;

                Update ags2;
            }
        }
    }
}