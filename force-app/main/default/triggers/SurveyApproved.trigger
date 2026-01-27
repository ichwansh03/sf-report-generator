trigger SurveyApproved on Survey__c (After Update) {
    for (Survey__c ip : trigger.new){
        if (ip.Status__c == 'Approved' && trigger.old[0].Status__c != ip.Status__c){
            
            String ipIdMasterSurvey = ip.Master_Survey__c;
            
            DescribeSObjectResult describeResultSurvey = Survey__c.getSObjectType().getDescribe();
            List<String> surveyFieldList = new List<String>(describeResultSurvey.fields.getMap().keySet());
            String surveyFields = String.join(surveyFieldList, ',');
            String surveyQuery = ' SELECT ' + surveyFields + ' FROM Survey__c WHERE Id = :ipIdMasterSurvey ';
            Survey__c masterparam = Database.query(surveyQuery);
            
                masterparam.Answer_Type__c = ip.Answer_Type__c;
                masterparam.Answer_Image_1__c = ip.Answer_Image_1__c;
                masterparam.Answer_Image_2__c = ip.Answer_Image_2__c;
                masterparam.Answer_Image_3__c = ip.Answer_Image_3__c;
                masterparam.Answer_Image_4__c = ip.Answer_Image_4__c;
                masterparam.Answer_Image_5__c = ip.Answer_Image_5__c;
                masterparam.Answer_Image_6__c = ip.Answer_Image_6__c;
                masterparam.Answer_Image_7__c = ip.Answer_Image_7__c;
                masterparam.Answer_Image_8__c = ip.Answer_Image_8__c;
                masterparam.Answer_Image_9__c = ip.Answer_Image_9__c;
                masterparam.Answer_Image_10__c = ip.Answer_Image_10__c;
                masterparam.Answer_Image_11__c = ip.Answer_Image_11__c;
                masterparam.Answer_Count__c = ip.Answer_Count__c;
                masterparam.Current_Survey__c = ip.id;
                masterparam.Entity__c = ip.Entity__c;
                masterparam.Hide_Survey_Name__c = ip.Hide_Survey_Name__c;
                //Master_Survey__c
                //Status__c
                masterparam.Submit_Response__c = ip.Submit_Response__c;
                masterparam.Survey_Container_CSS__c = ip.Survey_Container_CSS__c;
                masterparam.Survey_Header__c = ip.Survey_Header__c;
                masterparam.Survey_Type__c = ip.Survey_Type__c;
                masterparam.thankYouLink__c = ip.thankYouLink__c;
                masterparam.Thank_You_Text__c = ip.Thank_You_Text__c;
                masterparam.thankYouText__c = ip.thankYouText__c;
                masterparam.URL__c = ip.URL__c;
                
                update masterparam;
                
            {
                List<Survey_Question__c> ipc2 = [SELECT id, Name, Choices__c, OrderNumber__c, 
                                                 Question__c, 
                                                 Required__c, Survey__c, Type__c
                    FROM Survey_Question__c
                    WHERE Survey__c =:ip.Master_Survey__c];
                
                delete ipc2;
                
                list<Survey_Question__c> listnewipc = new List<Survey_Question__c>();
                for (Survey_Question__c ipc : [SELECT id, Name, Choices__c, OrderNumber__c, 
                                               Question__c, 
                                               Required__c, Survey__c, Type__c
                    FROM Survey_Question__c
                    WHERE Survey__c =:ip.id
                ]){
                    Survey_Question__c newipc = new Survey_Question__c(
                        Name = ipc.Name,
                        Survey__c = ip.Master_Survey__c,
                        Choices__c = ipc.Choices__c,
                        OrderNumber__c = ipc.OrderNumber__c, 
                        Question__c = ipc.Question__c, 
                        Required__c = ipc.Required__c,
                        Type__c = ipc.Type__c
                    );
                    listnewipc.add(newipc);
                }
                if (listnewipc.size() > 0) insert listnewipc;
            }
        }
    } // end for
} // end trigger