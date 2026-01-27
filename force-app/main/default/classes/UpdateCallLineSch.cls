global class UpdateCallLineSch implements Schedulable{
    global void execute(SchedulableContext ctx){               
        //Get Survey Taken ID
        /*For Testing*/
        /*
        List<String> Ids = new List<String>();
        Ids.add('a0NBK0000018jYr');
        String query = ' SELECT Id from SurveyTaker__c where Id in:Ids ';
        */
        /*For Prod*/
        
        
		Survey__c survey = [SELECT Id, RecordType.Name, URL__c FROM Survey__c WHERE RecordType.Name = 'Master New Onboarding' AND Survey_Type__c = 'I Buy' AND Status__c = 'Active' AND Entity__c = 'AMFS' AND Name = 'Survey Nasabah Onboarding' limit 1];	            
		String surveyId = survey.Id;
        Date YESTERDAYS = Date.today().addDays(-14);
        String query = ' SELECT Id from SurveyTaker__c where Survey__c =:surveyId AND Update_Call_Line__c=false AND createddate >:YESTERDAYS';
		
        
        List<SurveyTaker__c> sr = Database.query(query);
        Set<Id> idResponse = new Set<Id>();
        
        if(sr.size() > 0){
            for(SurveyTaker__c s:sr){
                idResponse.add(s.id);
            }
            UpdateCallLineNewCust.UpdateCallLine(idResponse);
        }
    }

}