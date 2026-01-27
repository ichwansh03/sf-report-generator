public with sharing class HoldDebetDataController {
    
    public String DATA_NOT_FOUND = 'Data Not Found';
    public class NoDataException extends Exception {}
    public Static String HOLD_DEBET_CASE_TYPE = 'Renewal Reminder,Withdrawa,MKP,Cuti Premi,RTU,Redemption Konven,TRO Project,Others - Gagal Debet';
    public Static String HOLD_DEBET_CAMPAIGN_NAME = 'Collection AMFS';
    
    public HoldDebetDataController() {
        
    }
    
    public HoldDebetWrapper.caseResp getCaseHD(String policyNo) {
        HoldDebetWrapper.caseResp resp = new HoldDebetWrapper.caseResp();
        List<Case> caseList = new List<Case>();
        system.debug('policyNo ==>' + policyNo);
        Case cs;
        
        try {
            caseList = [select id, Policy_Numbers__c, Follow_Hold_Date__c from Case where entity__c='AMFS' and follow_hold_date__c<>null and status='Closed' and case_type__c='Request_Hold Debit' and (policy_numbers__c=:policyNo or policy_no__c=:policyNo) order by follow_hold_date__c desc limit 1];
            system.debug('caseList ==>' + caseList);
            if (caseList == null) throw new NoDataException(DATA_NOT_FOUND);
            if (caseList.size() < 1) throw new NoDataException(DATA_NOT_FOUND);
            cs = caseList[0];
            resp.policyNumbers = cs.Policy_Numbers__c;
            resp.followHoldDate = String.valueOf(cs.follow_hold_date__c);
        } catch (NoDataException e) {
            throw new NoDataException(DATA_NOT_FOUND);
    	} catch (Exception e) {
            throw new SObjectException('ERROR System: ' + e.getMessage() + '|' + e.getStackTraceString());
        }
        
        return resp;
    }
    
    public HoldDebetWrapper.callLineResp getCallLineHD(String policyNo) {
        HoldDebetWrapper.callLineResp resp = new HoldDebetWrapper.callLineResp();
        List<Call_Line__c> clList = new List<Call_Line__c>();
        Call_Line__c cl;
        List<Call_List__c> CpList = new List<Call_List__c>();
        Call_List__c cp;
        system.debug('policyNo ==>' + policyNo);
        
        try { 
            clList = [select id, policy_no__c,Tanggal_Hold_Debet__c, Call_List__c, entity__c from call_line__c where policy_no__c= :policyNo and Tanggal_Hold_Debet__c<>null and entity__c='AMFS' order by tanggal_hold_debet__c desc limit 1];
            system.debug('clList ==>' + clList);
            if (clList == null) throw new NoDataException(DATA_NOT_FOUND);
            if (clList.size() < 1) throw new NoDataException(DATA_NOT_FOUND);
            //case_type__c in('Renewal Reminder','Withdrawal','MKP','Cuti Premi','RTU','Redemption Konven','TRO Project','Others - Gagal Debet') and recordtype.name='Collection AMFS' and
            cl = clList[0];
            cpList = [SELECT id, case_Type__c, recordTypeId FROM Call_List__c WHERE id = :cl.Call_List__c  order by createddate desc limit 1];
            system.debug('cpList ==>' + cpList);
            if (cpList == null) throw new NoDataException(DATA_NOT_FOUND);
            if (cpList.size() < 1) throw new NoDataException(DATA_NOT_FOUND);
            ID cliId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
            cp = cpList[0];
            String cpRecordId = cp.RecordTypeId;
            String cpCaseType = cp.Case_Type__c;
            system.debug('cpRecordId ==>' + cpRecordId);
            system.debug('cliId ==>' + cliId);
            system.debug('cpCaseType ==>' + cpCaseType);
            if (HOLD_DEBET_CASE_TYPE.contains(cpCaseType) && cpRecordId == cliId) {
                resp.policyNo = cl.policy_no__c;
            	resp.tanggalHoldDebet = String.valueOf(cl.Tanggal_Hold_Debet__c);
            } else {
                throw new NoDataException(DATA_NOT_FOUND);
            }
        } catch (NoDataException e) {
            throw new NoDataException(DATA_NOT_FOUND);
    	} catch (Exception e) {
            throw new SObjectException('ERROR System: ' + e.getMessage() + '|' + e.getStackTraceString());
        }
        
        return resp;
    }
}