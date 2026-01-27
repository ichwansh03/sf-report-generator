trigger SurveyChangeRequest on Survey__c (Before Update) {
    for (Survey__c ip : trigger.new){
        if (ip.Change_request__c){
            ip.Change_request__c = FALSE;
                        
            RecordType rt = [SELECT id FROM RecordType WHERE DeveloperName = 'Change_Request' and SobjectType = 'Survey__c'];
            
            Survey__c newparam = new Survey__c(
                RecordTypeId = rt.id,
                Answer_Type__c = ip.Answer_Type__c,
                Answer_Image_1__c = ip.Answer_Image_1__c,
                Answer_Image_2__c = ip.Answer_Image_2__c,
                Answer_Image_3__c = ip.Answer_Image_3__c,
                Answer_Image_4__c = ip.Answer_Image_4__c,
                Answer_Image_5__c = ip.Answer_Image_5__c,
                Answer_Image_6__c = ip.Answer_Image_6__c,
                Answer_Image_7__c = ip.Answer_Image_7__c,
                Answer_Image_8__c = ip.Answer_Image_8__c,
                Answer_Image_9__c = ip.Answer_Image_9__c,
                Answer_Image_10__c = ip.Answer_Image_10__c,
                Answer_Image_11__c = ip.Answer_Image_11__c,
                Answer_Count__c = ip.Answer_Count__c,
                Name = ip.Name,
                Entity__c = ip.Entity__c,
                Hide_Survey_Name__c = ip.Hide_Survey_Name__c,
                Master_Survey__c = ip.id,
                //Status__c
                Submit_Response__c = ip.Submit_Response__c,
                Survey_Container_CSS__c = ip.Survey_Container_CSS__c,
                Survey_Header__c = ip.Survey_Header__c,
                Survey_Type__c = ip.Survey_Type__c,
                thankYouLink__c = ip.thankYouLink__c,
                Thank_You_Text__c = ip.Thank_You_Text__c,
                thankYouText__c = ip.thankYouText__c,
                URL__c = ip.URL__c
            );
            
            insert newparam;
            
            {
                list<Survey_Question__c> listnewipc = new List<Survey_Question__c>();
                for (Survey_Question__c ipc : [SELECT id, name, Choices__c, OrderNumber__c, 
                                               Question__c, 
                                               Required__c, Survey__c, Type__c
                    FROM Survey_Question__c
                    WHERE Survey__c =:ip.id
                ]){
                    Survey_Question__c newipc = new Survey_Question__c(
                        name = ipc.name,
                        Survey__c = newparam.id,
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