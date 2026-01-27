@isTest
public class ParameterChangeRequest_test {
    @testSetup static void testData() {
        RecordType prmMasterEmailSms = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Email & SMS' LIMIT 1];
        RecordType prmMasterNonCCC = [SELECT Id FROM RecordType WHERE SObjectType = 'ICF_Parameter__c' AND Name = 'Master - Non CCC' LIMIT 1];
        
        //--Email Template
        Email_SMS_Template__c emailTp = new Email_SMS_Template__c();
        emailTp.Name = 'Email AFI';
        emailTp.Category__c = 'ICF';
        emailTp.Entity__c = 'AFI';
        emailTp.Subject__c = 'Email Subject';
        emailTp.Method__c = 'Email';
        emailTp.Detail_Link__c = '[SURVEY_LINK]';
        insert emailTp;
        
        //--SMS Template
        Email_SMS_Template__c smsTp = new Email_SMS_Template__c();
        smsTp.Name = 'SMS AFI';
        smsTp.Category__c = 'ICF';
        smsTp.Entity__c = 'AFI';
        smsTp.Subject__c = 'SMS Subject';
        smsTp.Method__c = 'SMS';
        smsTp.Detail_Link__c = '[SURVEY_LINK]';
        insert smsTp;
        
        //--ICF Parameter Record
        ICF_Parameter__c prm = new ICF_Parameter__c();
        prm.Entity__c = 'AFI';
        prm.RecordTypeId = prmMasterEmailSms.Id; //--'Master - Email & SMS'
        prm.Status__c = 'Active';
        prm.User_ID__c = 'axacccafi';
        prm.Password__c = 'axacccafi789';
        prm.Division__c = 'CCCAFI';
        prm.Sender__c = 'AXA_FIN_IND';
        prm.Batchname__c = 'ICF_SMS_AFI';
        prm.Uploadby__c = 'Salesforce_AFI';
        prm.Channel__c = '0';
        prm.ICF_Method__c = 'Email';
        prm.Login_1__c = 'axamii4';
        prm.API_Key_1__c = 'R_76b949e73be6442fb388476e3ec5727d';
        prm.ICF_Email_Template__c = emailTp.Id;
        prm.ICF_SMS_Template__c = smsTp.Id;
        insert prm;
        
        //--ICF Non CCC
        ICF_Parameter__c prmNC = new ICF_Parameter__c();
        prmNC.Entity__c = 'AFI';
        prmNC.RecordTypeId = prmMasterNonCCC.Id; //--'Master - Non CCC'
        prmNC.Status__c = 'Active';
        insert prmNC;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter1 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter1.Category__c = ''; 
        prmFilter1.Type__c = 'Schedule - I Buy';
        prmFilter1.Seq__c = 1;
        prmFilter1.Field__c = 'Application';
        prmFilter1.Operator__c = 'Equal';
        prmFIlter1.Value_Custom__c = 'RLS';
        prmFilter1.Parameterized__c = prmNC.Id;
        insert prmFilter1;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter2 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter2.Category__c = ''; 
        prmFilter2.Type__c = 'Schedule - I Renew';
        prmFilter2.Seq__c = 1;
        prmFilter2.Field__c = 'Application';
        prmFilter2.Operator__c = 'Equal';
        prmFIlter2.Value_Custom__c = 'RLS';
        prmFilter2.Parameterized__c = prmNC.Id;
        insert prmFilter2;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter3 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter3.Category__c = ''; 
        prmFilter3.Type__c = 'Schedule - I Ask';
        prmFilter3.Seq__c = 1;
        prmFilter3.Field__c = 'Application';
        prmFilter3.Operator__c = 'Equal';
        prmFIlter3.Value_Custom__c = 'RLS';
        prmFilter3.Parameterized__c = prmNC.Id;
        insert prmFilter3;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter4 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter4.Category__c = ''; 
        prmFilter4.Type__c = 'Schedule - I Claim';
        prmFilter4.Seq__c = 1;
        prmFilter4.Field__c = 'Application';
        prmFilter4.Operator__c = 'Equal';
        prmFIlter4.Value_Custom__c = 'RLS';
        prmFilter4.Parameterized__c = prmNC.Id;
        insert prmFilter4;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter5 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter5.Category__c = ''; 
        prmFilter5.Type__c = 'Exclude - I Buy';
        prmFilter5.Seq__c = 1;
        prmFilter5.Field__c = 'Application';
        prmFilter5.Operator__c = 'Equal';
        prmFIlter5.Value_Custom__c = 'RLS';
        prmFilter5.Parameterized__c = prmNC.Id;
        insert prmFilter5;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter6 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter6.Category__c = ''; 
        prmFilter6.Type__c = 'Exclude - I Renew';
        prmFilter6.Seq__c = 1;
        prmFilter6.Field__c = 'Application';
        prmFilter6.Operator__c = 'Equal';
        prmFIlter6.Value_Custom__c = 'RLS';
        prmFilter6.Parameterized__c = prmNC.Id;
        insert prmFilter6;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter7 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter7.Category__c = ''; 
        prmFilter7.Type__c = 'Exclude - I Ask';
        prmFilter7.Seq__c = 1;
        prmFilter7.Field__c = 'Application';
        prmFilter7.Operator__c = 'Equal';
        prmFIlter7.Value_Custom__c = 'RLS';
        prmFilter7.Parameterized__c = prmNC.Id;
        insert prmFilter7;
        
        ICF_Parameterized_Filter_Criteria__c prmFilter8 = new ICF_Parameterized_Filter_Criteria__c();
        prmFilter8.Category__c = ''; 
        prmFilter8.Type__c = 'Exclude - I Claim';
        prmFilter8.Seq__c = 1;
        prmFilter8.Field__c = 'Application';
        prmFilter8.Operator__c = 'Equal';
        prmFIlter8.Value_Custom__c = 'RLS';
        prmFilter8.Parameterized__c = prmNC.Id;
        insert prmFilter8;
    }
    
    static testMethod void updateCR() {
        Test.startTest();
        List<ICF_Parameter__c> prm = [SELECT Id, Change_Request__c FROM ICF_Parameter__c WHERE Uploadby__c = 'Salesforce_AFI' LIMIT 1];
        if(prm.size() > 0) {
            prm[0].Change_Request__c = TRUE;
            update prm[0];
        }
        Test.stopTest();
    }
    
    static testMethod void updateCRNonCCC() {
        Test.startTest();
        List<ICF_Parameter__c> prm = [SELECT Id, Change_Request__c FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_Non_CCC' LIMIT 1];
        if(prm.size() > 0) {
            prm[0].Change_Request__c = TRUE;
            update prm[0];
        }
        Test.stopTest();
    }
}