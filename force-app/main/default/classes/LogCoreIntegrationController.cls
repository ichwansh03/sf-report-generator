public class LogCoreIntegrationController {

    public transient List<AppLog__c> appLog {get; set;}
    public Map<Id, Boolean> selectedLogs {get; set;}
    public Map<Integer, AppLog__c> logMap {get; set;}
    public String policy {get; set;}
    public String selectSize {get; set;}
    public String reportName {get; set;}
    public String statusOpt {get; set;}
    public String policyApp {get; set;}
    public String logId {get; set;}
    public String start {get; set;}
    public String ends {get; set;}
    public String exported {get; set;}
    public DateTime startDate {get; set;}
    public DateTime endDate {get; set;}
    public Integer pageNumber {get; set;}
    public Integer resultSize {get; set;}
    public ApexPages.StandardSetController logList {get; private set;}
    
    public LogCoreIntegrationController(){
        appLog = new List<AppLog__c>();
        selectedLogs = new Map<Id, Boolean>();
        selectSize = '25';

        resultSize = [SELECT count() FROM AppLog__c WHERE Report_Name__c != NULL AND Policy_App__c != NULL];
		        
        reportName = Apexpages.currentPage().getParameters().get('report');
        statusOpt = ApexPages.currentPage().getParameters().get('status');
        start = ApexPages.currentPage().getParameters().get('start');
        ends = ApexPages.currentPage().getParameters().get('ends');
        reportName = String.isNotBlank(reportName) ? reportName : 'All Reports';
        statusOpt = String.isNotBlank(statusOpt) ? statusOpt : 'None';
        policyApp = '';
        
        searchPolicy();
        entries();
        
    }
    
    public PageReference exportLogs() {      
        appLog = Database.query(filterQueryLog());
        system.debug('applog: '+appLog);
        PageReference exports = new PageReference('/apex/ExportServiceRevamp?report='+reportName+'&status='+statusOpt+'&start='+start+'&ends='+ends); 
        
        return exports;
    }
    
    public PageReference searchPolicy(){
        logList = new ApexPages.StandardSetController(Database.getQueryLocator(filterQueryLog()));
        
        if (String.isNotBlank(policy)){
            String searchPolicy = '%'+policy.trim()+'%';
            logList = new ApexPages.StandardSetController([SELECT Id, Name, Policy_No__c, Error_Message__c, Policy_App__c, Status__c, Report_Name__c, LastModifiedDate, Case_Type__c FROM AppLog__c WHERE Report_Name__c != '' AND Policy_App__c != '' AND Entity__c = 'AMFS' AND Policy_No__c LIKE :searchPolicy ORDER BY LastModifiedDate DESC]);
        }
        return null;
    }
    
    public List<AppLog__c> getLogs(){
        
        List<AppLog__c> logs = logList.getRecords();
        
        if (selectedLogs == null) selectedLogs = new Map<Id, Boolean>();
        
        for (AppLog__c log : logs) {
            if (!selectedLogs.containsKey(log.Id)) selectedLogs.put(log.Id, false);
        }
        
        return logs;
    }
    
    public void showReport(){
        logList = new ApexPages.StandardSetController(Database.getQueryLocator(filterQueryLog()));
        logList.setPageSize(Integer.valueOf(selectSize));
    }
    
    public String filterQueryLog(){
        String baseQuery = 'SELECT Id, Name, Policy_No__c, Error_Message__c, Status__c, Report_Name__c, LastModifiedDate, Policy_App__c, Case_Type__c FROM AppLog__c WHERE Policy_App__c != \'\' AND Entity__c = \'AMFS\' ';
        String filterReport;
        String filterStatus;
        String filterApp;
        String filterDate;
        
        switch on reportName {
            when 'All Reports' {
                filterReport = baseQuery+'AND Report_Name__c != \'\'';
            }
            when else {
                String reportNamePattern = reportName + '%';
                filterReport = baseQuery + ' AND Report_Name__c LIKE \'' + reportNamePattern + '\'';
            }
        }
        
        if (startDate != null || endDate != null) filterDate = filterReport+ ' AND LastModifiedDate > :startDate AND LastModifiedDate < :endDate';
        else filterDate = filterReport;    
        
        if (start != null && ends != null) {
            startDate = DateTime.valueOfGmt(start);
            endDate = DateTime.valueOfGmt(ends);
            filterDate = filterReport+ ' AND LastModifiedDate > :startDate AND LastModifiedDate < :endDate';    
        }
        
        if (!policyApp.equals('None') && !String.isBlank(policyApp)) filterApp = filterDate+' AND Policy_App__c = :policyApp';
        else filterApp = filterDate;

        if (statusOpt.equals('None')) filterStatus = filterApp+' ORDER BY LastModifiedDate DESC LIMIT 1000';   
        else filterStatus = filterApp+' AND Status__c = :statusOpt ORDER BY LastModifiedDate DESC LIMIT 1000';
        
        appLog = Database.query(filterStatus);
        
        logMap = new Map<Integer, AppLog__c>();
        Integer i = 0;
        for (AppLog__c log : appLog) {
                i++;
                logMap.put(i, log);   
        }
        return filterStatus;
    }
    
    public PageReference updateToInvalid(){

        List<AppLog__c> logsToUpdate = new List<AppLog__c>();
        
        for (Id logId : selectedLogs.keySet()) {
            if (selectedLogs.get(logId) == true) logsToUpdate.add(new AppLog__c(Id = logId, Status__c = 'Invalid'));
        }
        
        if (!logsToUpdate.isEmpty()) {
            try {
                update logsToUpdate;
                system.debug('logs update: '+logsToUpdate);
            } catch (Exception e) {
                system.debug('error: '+e.getMessage());
            }
        }
        
        String pageName = ApexPages.currentPage().getUrl().substringBefore('?');
        PageReference tempPage = new PageReference(pageName);
        tempPage.setRedirect(true);
        return tempPage;
    }
    
    public PageReference retryCoreAssesment(){

        List<AppLog__c> logsToUpdate = new List<AppLog__c>();
        
        for (Id logId : selectedLogs.keySet()) {
            if (selectedLogs.get(logId) == true) logsToUpdate.add(new AppLog__c(Id = logId, Status__c = 'Invalid'));
        }
        
        try {

            if (!logsToUpdate.isEmpty()) {
             	List<AppLog__c> log = [SELECT Id, Log_Call_Line__c, Log_Case__c, Request_Value__c, Policy_App__c, id__c FROM AppLog__c WHERE Id IN :logsToUpdate];   
                //Database.executeBatch(new LogCoreIntegrationServiceBatch(log), 20);
                System.enqueueJob(new LogCoreIntegrationServiceQueue(log));
            }
            
        } catch (Exception e) {
            system.debug('RETRY SERVICE IS ERROR: '+e.getMessage());
        }
        
        String pageName = ApexPages.currentPage().getUrl().substringBefore('?');
        PageReference tempPage = new PageReference(pageName);
        tempPage.setRedirect(true);
        return tempPage;
    }
    
    public void entries(){
        logList.setPageSize(Integer.valueOf(selectSize));
        pageNumber = logList.getPageNumber();
    }
    
    public void next(){
        logList.next();
        pageNumber = logList.getPageNumber();
    }
    
    public void previous(){
        logList.previous();
        pageNumber = logList.getPageNumber();
    }
    
    public void first(){
        logList.first();
        pageNumber = 1;
    }
    
    public void last(){
        logList.last();
        pageNumber = logList.getPageNumber();
    }
    
}