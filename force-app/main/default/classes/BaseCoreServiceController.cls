public class BaseCoreServiceController {
    
    public static Case generateCase(String caseid) {
        system.debug('generate case: '+caseid);

        return [SELECT Id, ContactId, Origin, Case_Owner_CCC__c, Department__c, Status, Contact.PolicyApp__c, 
                LastModifiedById, CreatedDate, LastModifiedDate, Description, Policy_Numbers__c, ContactMobile, 
                ContactPhone, Case_Type__c FROM Case WHERE Id = :caseid];
        
    }
    
    public static Call_Line__c generateCallLine(String clid) {
        system.debug('clid: '+clid);
        
        return [SELECT Id, Policy_No__c, Case_Type__c, Agent__c, Collection_Call_Date__c, 
                Activity_Result__c, Status_has_call__c, CreatedDate, Reason_Status_Config__c, 
                Verification__c, LastModifiedDate, Call_Remarks__c, Contacted_Number__c, Contact_Policy_App__c, 
                LastModifiedById, CreatedById, Owner.Name, OwnerId, Notes__c FROM Call_Line__c WHERE Id = :clid];
    }
    
    public static User generateUser(String agentId) {
        
        return [SELECT Id, ID_User_RLS__c, ID_User_DMTM__c, CommunityNickname FROM User WHERE Id = :agentId LIMIT 1];
    }
    
    public static void insertLog(Map<String, String> logProp, long startTime) {
        
        AppLog__c log;
        String objectId = logProp.get('ObjectId');
        String message = logProp.get('Message');
        String report = logProp.get('Report');
        String request = logProp.get('Request');
        String response = logProp.get('Response');
        String caseType = logProp.get('CaseType');
        system.debug('insert app log');
        /*try {
            DescribeSObjectResult describeResult = AppLog__c.getSObjectType().getDescribe();
            List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
            String fieldStr = String.join(fieldList, ',');
            String query;
            if (Test.isRunningTest()) query = ' SELECT '+fieldStr+' FROM AppLog__c ORDER BY LastModifiedDate DESC LIMIT 1';
            else query = ' SELECT '+fieldStr+' FROM AppLog__c WHERE id__c =:objectId AND Case_Type__c =:caseType ORDER BY LastModifiedDate DESC LIMIT 1';
            log = Database.query(query);
            
        } catch (Exception e) {
            system.debug('BaseCoreServiceController cannot update: '+e.getMessage());
        }*/
        
        if(objectId != NULL && objectId.left(3) == Schema.SObjectType.Call_Line__c.getKeyPrefix()){  
            String clid = objectId;
            Call_Line__c cl = generateCallLine(clid);
            if (log == null) log = new AppLog__c();
            log.Policy_No__c = cl.Policy_No__c;
            log.Policy_App__c = cl.Contact_Policy_App__c;
            log.Log_Call_Line__c = cl.Id;
            log.id__c = cl.Id;
            log.OwnerId = cl.LastModifiedById;
        } 
        
        if(objectId != NULL && objectId.left(3) == Schema.SObjectType.Case.getKeyPrefix()){ 
            
            Case cs = generateCase(objectId);

            Id conId = cs.ContactId;
            String policyApp = [SELECT Id, PolicyApp__c FROM Contact WHERE id =:conId].PolicyApp__c;
            if (log == null) log = new AppLog__c();
            log.Policy_No__c = cs.Policy_Numbers__c;
            log.Policy_App__c = policyApp;
            log.Log_Case__c = cs.Id;
            log.id__c = cs.Id;
            log.OwnerId = cs.LastModifiedById;
        }
        
        log.Entity__c = 'AMFS';
        log.Report_Name__c = report;
        log.Error_Message__c = message;
        log.StartLongTime__c = startTime;
        log.Case_Type__c = caseType;
        log.EndLongTime__c = system.now().getTime();
        log.Status__c = String.isBlank(message) ? 'Success' : 'Error';
        log.Status__c = message.contains('RequestId') ? 'Invalid' : log.Status__c;
        log.Response_Payload__c = response;
        log.Request_Value__c = request;
        //upsert log;
        insert log;
        system.debug('upsert log: '+log);
    }
    
    public static String getValueFilterReport(String reportName, String fieldName) {
        
        List<String> values = new List<String>();
        
        if (!Test.isRunningTest()) {
            Report r = [SELECT Id, Name FROM Report WHERE Name = :reportName];
            String reportId = (String)r.get('Id');
            Reports.ReportDescribeResult describeResult = Reports.ReportManager.describeReport(reportId);
            Reports.ReportMetadata rm = describeResult.getReportMetadata();
            List<Reports.ReportFilter> rpFilters = rm.getReportFilters();
            
            for (Reports.ReportFilter rp : rpFilters) {
                String columnName = rp.getColumn();
                String filterValue = String.valueOf(rp.getValue());
                if (columnName == fieldName) {
                    values.add(filterValue);
                }
            }   
        } else values = new List<String>{'Test','Test1'};
        
        return String.join(values,',');
    }
}