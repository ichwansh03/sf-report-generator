@isTest
class ICFParameterTrigger_test {

   static testmethod void test() {
   Test.startTest();

    {      
      ICF_Parameter__c ip = new ICF_Parameter__c();

      RecordType rt = [SELECT id FROM RecordType WHERE DeveloperName = 'Master_CCC' and SobjectType = 'ICF_Parameter__c'];
      
          /*
            if (ip.Record_Type_Name__c == 'Master_CCC')
                RTID = id.valueof(label.Parameter_CCC);
            if (ip.Record_Type_Name__c == 'Master_Email_SMS')
                RTID = id.valueof(label.Parameter_Email);
            if (ip.Record_Type_Name__c == 'Master_Feedback')
                RTID = id.valueof(label.Parameter_Feedback);
            if (ip.Record_Type_Name__c == 'Master_IDAS')
                RTID = id.valueof(label.Parameter_IDAS);
            if (ip.Record_Type_Name__c == 'Master_Non_CCC')
                RTID = id.valueof(label.Parameter_NonCCC);
            */
      ip.RecordTypeId = rt.id;
      ip.Send_Thanks_Note_When_Case__c = 'Closed';
      ip.Send_Thanks_Note_Day__c = '0';
      insert ip;
      
    // ParameterChangeRequest
      ip.Change_Request__c = TRUE;
      update ip;
     
      ICF_Parameter__c ip2 = [SELECT id, Status__c FROM ICF_Parameter__c WHERE Master__c =: ip.id limit 1];
    // ParameterApproved
      ip2.Status__c = 'Approved';
      update ip2;
    
    }
    {
      ICF_Parameter__c ip = new ICF_Parameter__c();

      RecordType rt = [SELECT id FROM RecordType WHERE DeveloperName = 'Master_IDAS' and SobjectType = 'ICF_Parameter__c'];
      
      ip.RecordTypeId = rt.id;
      ip.Send_Thanks_Note_When_Case__c = 'Closed';
      ip.Send_Thanks_Note_Day__c = '0';
      insert ip;
      
       ICF_Parameterized_Filter_Criteria__c newipc = new ICF_Parameterized_Filter_Criteria__c(
            Parameterized__c = ip.id
        );
        insert newipc;

    // ParameterChangeRequest
      ip.Change_Request__c = TRUE;
      update ip;
     
      ICF_Parameter__c ip2 = [SELECT id, Status__c FROM ICF_Parameter__c WHERE Master__c =: ip.id limit 1];
    // ParameterApproved
      ip2.Status__c = 'Approved';
      update ip2;
    }

   Test.stopTest();

   }
}