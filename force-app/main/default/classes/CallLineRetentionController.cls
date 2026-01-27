public class CallLineRetentionController {
    
    public Blob fileContent {get; set;}
    public String[] fileLines {get; set;}
    public String fileName {get; set;}
    public String campaignName {get; set;}
    public Integer uploadedNum {get; set;}
    public Integer validNum {get; set;}
    public Integer invalidNum {get; set;}
    public Contact contact {get; set;}
    public Call_Line_Retention__c clr {get; set;}
    public List<String> policy {get; set;}
    public List<String> invalidPolicyText {get; set;}
    public List<String> invalidPolicyStatus {get; set;}
    public List<InvalidPolicyNo> invalidPolicyList {get; set;}
    public List<Contact> contacts {get; set;}
    public List<Call_Line_Retention__c> listClr {get; set;}
    public List<Call_Line_Retention__c> updatedClr {get; set;} 
    public List<Call_Line__c> listCl {get; set;}
    public Map<String, Contact> contactMap {get; set;}
    public Map<String, Call_Line_Retention__c> mapClr {get; set;}
    public Map<String, List<Call_Line_Retention__c>> mapClrList {get; set;}
    public Map<String, List<Call_Line__c>> mapClList {get; set;}
        
    public CallLineRetentionController() {
        
        fileLines = new String[]{};
        listClr = new List<Call_Line_Retention__c>();
        updatedClr = new List<Call_Line_Retention__c>();
        
        invalidPolicyList = new List<InvalidPolicyNo>();
        invalidPolicyText = new List<String>();
        invalidPolicyStatus = new List<String>();
        
        uploadedNum = 0;
        validNum = 0;
        invalidNum = 0;
        
        String statusUpload = ApexPages.currentPage().getParameters().get('upload');
        String statusUploadedNum = ApexPages.currentPage().getParameters().get('uploadedNum');
        String statusValidNum = ApexPages.currentPage().getParameters().get('validNum');
        String statusInvalidNum = ApexPages.currentPage().getParameters().get('invalidNum');
        String statusInvalidPolText = ApexPages.currentPage().getParameters().get('invalidPolicy');
        String statusInvalidPolState = ApexPages.currentPage().getParameters().get('invalidPolicyStatus');

        if (statusUpload == 'success') {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
            uploadedNum = Integer.valueOf(statusUploadedNum);
            validNum = Integer.valueOf(statusValidNum);
            invalidNum = Integer.valueOf(statusInvalidNum);
            invalidPolicyText = statusInvalidPolText.split(',');
            invalidPolicyStatus = statusInvalidPolState.split(',');
			
            system.debug('validNum: '+validNum);
            
            listClr = [SELECT mdmid_owner__c, Policy_No__c, Remark_Description__c, Retention_Status__c FROM Call_Line_Retention__c ORDER BY LastModifiedDate DESC LIMIT :validNum];            
            
            system.debug('listclr: '+listClr);
            
            for (Integer i = 0; i < invalidPolicyText.size(); i++) {
                if (invalidPolicyStatus[i].contains('E1')) invalidPolicyStatus[i] = 'Policy number is blank or not registered in Contact';
                else if (invalidPolicyStatus[i].contains('E2')) invalidPolicyStatus[i] = 'Remarks description is blank';
                else if (invalidPolicyStatus[i].contains('E3')) invalidPolicyStatus[i] = 'Retention status value is not Takeout or Release';
                else if (invalidPolicyStatus[i].contains('E4')) invalidPolicyStatus[i] = 'MDM ID for this policy is null';
                
                if (i < 999) invalidPolicyList.add(new InvalidPolicyNo(invalidPolicyText[i].trim().replaceAll('[\\(\\)]',''), invalidPolicyStatus[i]));
            }
        }
    }

    public PageReference uploadFile() {
        invalidPolicyText = new List<String>();
        invalidPolicyStatus = new List<String>();
        listClr = new List<Call_Line_Retention__c>();
        updatedClr = new List<Call_Line_Retention__c>();

        fileLines = fileContent.toString().split('\n');
		system.debug(fileLines);
        
        if (!fileName.endsWith('csv') || fileLines[0].replaceAll(',','').trim().equals('')) {
            System.debug('Error upload CSV');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'File is blank or not csv type'));
            return null;
        }
        
        String joint = '';
        for (Integer i = 0; i < fileLines.size(); i++) {
            joint = fileLines[i].replaceAll(',,','').replaceAll('"','').normalizeSpace();
            if (joint.trim().length() > 0) {
                system.debug('line: '+fileLines[i]);   
            }
        }
        
        String jointxt = String.join(fileLines, '\n')
            .replace('Retention_Status__c','Retention_Status__cDBLQT')
            .replace(',Takeout',',TakeoutDBLQT')
            .replace(',Release',',ReleaseDBLQT')
            .replace(',,Takeout',',0,Takeout')
            .replace(',,Release',',0,Release')
            .normalizeSpace();
        system.debug(jointxt);
        
        List<String> processLine = jointxt
            .replaceAll(',,','')
            .replaceAll('"','')
            .normalizeSpace()
            .split('DBLQT');
        system.debug('process: '+processLine);
        system.debug('size: '+processLine.size());
        for (String process : processLine) {
            system.debug(process);
        }
        
        try {
            
            policy = new List<String>();
        	contactMap = new Map<String, Contact>();
            
            system.debug('processLine: '+processLine.size());
            
            for (Integer i = 1; i < processLine.size(); i++) {
                
                String[] record = processLine[i].split(',');
                                
                system.debug('***record: '+record);
                String policyNo = record[0].trim();
                
                if (!String.isBlank(policyNo)) {
                    policy.add(policyNo);
                } else {
                    invalidPolicyStatus.add('E1');
                    invalidPolicyText.add('null');
                }
                
        	}

            contacts = [SELECT Id, mdmid_owner__c, Policy_No__c FROM Contact WHERE Policy_No__c IN :policy];
            System.debug('contacts = '+contacts);
            
            for (Contact con : contacts) {
                if (con.mdmid_owner__c != null) {
                 	contactMap.put(con.Policy_No__c, con);   
                } else {
                    System.debug('mdmid is null');
                    invalidPolicyStatus.add('E4');
                    invalidPolicyText.add(con.Policy_No__c);
                    invalidPolicyList.add(new InvalidPolicyNo(String.join(invalidPolicyText,','), invalidPolicyStatus[0]));
                    continue;
                }
            }
            
            if (invalidPolicyText.size() < 999 && invalidPolicyStatus.size() > 1) invalidPolicyList.add(new InvalidPolicyNo(String.join(invalidPolicyText,','), invalidPolicyStatus[0]));
            
            parseCsvRecords(processLine, contactMap, listClr);
            
            getListClr(policy);

        } catch(Exception e) {
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured: '+e);
            ApexPages.addMessage(errorMsg);
        }

        if (updatedClr.size() > 0) changeRetentionStatus(updatedClr, policy);
        changeCallLine(updatedClr, policy);
        
        PageReference pageRef = new PageReference('/apex/Upload_Data_Takeout?upload=success&uploadedNum='+uploadedNum+'&validNum='+validNum+'&invalidNum='+invalidNum+'&invalidPolicy='+invalidPolicyText+'&invalidPolicyStatus='+invalidPolicyStatus);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void getListClr(List<String> policy) {
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
        listClr = [SELECT mdmid_owner__c, Policy_No__c, Remark_Description__c, Retention_Status__c FROM Call_Line_Retention__c WHERE Policy_No__c IN :policy];
        System.debug(listClr);
    }
        
    public void parseCsvRecords(List<String> records, Map<String, Contact> contactMap, List<Call_Line_Retention__c> listClr){
        List<Call_Line_Retention__c> existingClr = [SELECT Id, Policy_No__c, Remark_Description__c, Retention_Status__c FROM Call_Line_Retention__c WHERE CreatedDate > 2024-01-01T00:00:01Z];
        mapClr = new Map<String, Call_Line_Retention__c>();
		
        for (Call_Line_Retention__c clr : existingClr) {
            mapClr.put(clr.Policy_No__c, clr);
        }
        
        for (Integer i = 1; i < records.size(); i++) {
			            
            clr = new Call_Line_Retention__c();
            String[] recordData = records[i].split(',');
            system.debug('**record: '+recordData);
            
            String policyNo = recordData[0].trim();
            if (contactMap.containsKey(policyNo)) {
            	Contact contact = contactMap.get(policyNo);
                contact.Policy_No__c = policyNo;
                clr.Contact__c = contact.Id;
            } else {
                invalidPolicyStatus.add('E1');
                invalidPolicyText.add(policyNo);
                invalidPolicyList.add(new InvalidPolicyNo(String.join(invalidPolicyText,','), invalidPolicyStatus[0]));
                continue;
            }   
            System.debug('policyNo = '+policyNo);   
            
            String remarkDesc = '';
            for (Integer j = 1; j < recordData.size() - 1; j++) {
            	remarkDesc += recordData[j].trim();
                if (j < recordData.size() - 2) {
                	remarkDesc += ',';
                }
            }

            system.debug('remark: '+remarkDesc);
            if (!remarkDesc.equals('0')) clr.Remark_Description__c = remarkDesc;   
            else {
                invalidPolicyText.add(policyNo);
                invalidPolicyStatus.add('E2');
                invalidPolicyList.add(new InvalidPolicyNo(String.join(invalidPolicyText,','), invalidPolicyStatus[0]));
                continue;
            }        
            
            String status = recordData[recordData.size() - 1].trim();
            if (status.equals('Takeout') || status.equals('Release')) clr.Retention_Status__c = status;
            else {
                invalidPolicyText.add(policyNo);
                invalidPolicyStatus.add('E3');
                invalidPolicyList.add(new InvalidPolicyNo(String.join(invalidPolicyText,','), invalidPolicyStatus[0]));
                continue;
            }
            system.debug('status: '+status);
            
            //update policy if exist
            if (mapClr.containsKey(policyNo)) {
                clr.Id = mapClr.get(policyNo).Id;
                clr.Remark_Description__c = remarkDesc;
                clr.Retention_Status__c = status;
                updatedClr.add(clr);
            } else {
             	listClr.add(clr);
            }
            
        }
        
        try {
            insert listClr;
            system.debug('insert listclr: '+listclr);
            update updatedClr;
        } catch (DMLException e) {
           	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.error,'Error message when upsert list CLR: '+e);
            ApexPages.addMessage(myMsg); 
        }
        
        uploadedNum = listClr.size() + updatedClr.size() + invalidPolicyText.size();
        validNum = listClr.size() + updatedClr.size();
        invalidNum = uploadedNum - validNum;
    }
    
    //change retention status when mdmid has multiple policyNo
    public void changeRetentionStatus(List<Call_Line_Retention__c> updatedClr, List<String> policy) {
            
        mapClrList = new Map<String, List<Call_Line_Retention__c>>();
        mapClr = new Map<String, Call_Line_Retention__c>();
        listClr = new List<Call_Line_Retention__c>();
        List<Call_Line_Retention__c> orderedList = new List<Call_Line_Retention__c>();
		        
        for (Call_Line_Retention__c clr : [SELECT Contact__c, mdmid_owner__c, Policy_No__c, Retention_Status__c FROM Call_Line_Retention__c WHERE Policy_No__c = :policy]) {
            orderedList.add(clr);
            if (!mapClrList.containsKey(clr.mdmid_owner__c)) {
                mapClrList.put(clr.mdmid_owner__c, new List<Call_Line_Retention__c>());
            }
            if (clr.mdmid_owner__c != null) {
             	mapClrList.get(clr.mdmid_owner__c).add(clr);   
            }
        }

        for (Call_Line_Retention__c clr : updatedClr) {
            mapClr.put(clr.Contact__c, clr);
        }

        for (String mdmid : mapClrList.keySet()) {
            for (Call_Line_Retention__c clr : mapClrList.get(mdmid)) {
                if (!mapClr.containsKey(clr.Contact__c) && mdmid != null) {
                    //check first index of Call_Line_Retention__c grouping by mdmid
                    if (mapClrList.get(mdmid)[0].Retention_Status__c.equals('Takeout')) clr.Retention_Status__c = 'Takeout';
                    else clr.Retention_Status__c = 'Release';
                    
                    listClr.add(clr);   
                }
            }
        }
        
        update listClr;
    }

    //change call line existing to takeout when policyNo status are takeout
    public void changeCallLine(List<Call_Line_Retention__c> updatedClr, List<String> policy) {
		
        campaignName = '%Renewal Reminder%';
        mapClList = new Map<String, List<Call_Line__c>>();
        mapClr = new Map<String, Call_Line_Retention__c>();
        listClr = [SELECT Policy_No__c, Remark_Description__c FROM Call_Line_Retention__c WHERE Retention_Status__c = 'Takeout' AND Policy_No__c = :policy];
        
        policy = new List<String>();
        map<String, String> mapRemark = new map<String, String>();
        for (Call_Line_Retention__c clr : listClr) {
            policy.add(clr.Policy_No__c);
            mapRemark.put(clr.Policy_No__c, clr.Remark_Description__c);
        }
        
        List<Call_Line__c> allCallLines = [SELECT Id, Name, Call_List__c, Call_List__r.Case_Type__c, Contact__c, Policy_No__c, Campaign_Name__c, Status_has_call__c, Reason_Status_Config__c, Call_Remarks__c FROM Call_Line__c WHERE Campaign_Name__c LIKE :campaignName AND Policy_No__c = :policy AND Status_has_call__c != 'Closed' AND Status_has_call__c != 'Takeout'];
        listCl = new List<Call_Line__c>();
        
        for (Call_Line_Retention__c clr : updatedClr) {
            mapClr.put(clr.Contact__c, clr);
        }
        
        for (Call_Line__c callLine : allCallLines) {
            System.debug(mapClr.get(callLine.Contact__c));
            
            if (!mapClr.containsKey(callLine.Contact__c)) {
                callLine.Call_Status_Config__c = 'Takeout';
                callLine.Status_has_call__c = 'Takeout';
                callLine.Reason_Status_Config__c = 'Tidak Berkenan Dihubungi';
                callLine.Collection_Call_Date__c = Datetime.now();
                callLine.Call_Remarks__c = mapRemark.get(callLine.Policy_No__c);
                listCl.add(callLine);    
            }
            
        }    
        
        if (!listCl.isEmpty()) {
        	CallLineInsertBatch jb = new CallLineInsertBatch(listCl);
            Database.executeBatch(jb, 65);    
        }        
     }
    
    public class InvalidPolicyNo{
        public String policyNo {get;set;}
        public String status {get;set;}
        public InvalidPolicyNo(String policyNo, String status){
            this.policyNo = policyNo;
            this.status = status;
        }
    }
}