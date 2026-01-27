public class MassUploadCasesController {

    public ApexPages.StandardController controller {get; set;}
    public Boolean isIcf {get; set;} // ManualClosedCase__c
    public String csDepartment {get; set;}
    // reassign
    public String csvContent {get; set;}
    public String[] csvContentLines {get; set;}
    public String[] parsedString {get; set;}
    public PageReference p {get; set;}
    public String message {get; set;}
    public Case cs {get;set;}
    public CaseComment cc {get; set;}

    public Contact cnt {get; set;}
    
    // Faizir 15-03-2021, add mass case upload
    public String entity {get;set;}
    public String massReqUploadFileName {get;set;}
    public Integer massReqUploadFileSize {get;set;}
    public Blob massReqUploadFileBody {get;set;}
    public String massInqUploadFileName {get;set;}
    public Integer massInqUploadFileSize {get;set;}
    public Blob massInqUploadFileBody {get;set;}
    public String massCompUploadFileName {get;set;}
    public Integer massCompUploadFileSize {get;set;}
    public Blob massCompUploadFileBody {get;set;}
    public String reqCloseFileName {get;set;}
    public Integer reqCloseFileSize {get;set;}
    public Blob reqCloseFileBody {get;set;}
    public Boolean isInvalidCase {get;set;}
    public Boolean isValidCase {get;set;}
    public List<String > invalidCaseList{get;set;}
    public Boolean isDisplayAFI {get;set;}
    public Boolean AFIRequired {get;set;}
    public Boolean AMFSRequired {get;set;}
    public Boolean AMFS_AFIRequired {get;set;}
    
    public List<MassUploadWrapper> validDataList{get;set;}

    public MassUploadCasesController() {
        csvContentLines = new String[]{};
     //               cs = new Case();
    }
    
    public MassUploadCasesController(ApexPages.StandardController controller) {
        this.controller = controller;
        cs = new Case();
        cs.status = 'New';
    }
    
    public void checkRecordType(){
        String recType = '';
        System.debug('cs : '+cs);
        if(cs.Type != null){
            if(cs.Type == 'Request' || cs.Type == 'Inquiry'){
                recType = cs.Type+cs.Entity_Backup__c+'Case';  
            }else if(cs.Type == 'Complaint'){
                recType = cs.Entity_Backup__c+cs.Type+'Case';
            }
            cs.Related_Departments__c = csDepartment;
            cs.Related_Department__c = csDepartment;
            cs.Department__c = csDepartment;
            if(cs.Entity_Backup__c == 'AFI'){
                isDisplayAFI = true;
                AFIRequired = true;
                AMFS_AFIRequired = true;
            }
            if(cs.Entity_Backup__c == 'AMFS'){
                AMFSRequired = true;
                AMFS_AFIRequired = true;
            }
            List<Master_Case_Type_Regional__c> csTypeReg = new List<Master_Case_Type_Regional__c>([Select Id, PIC_Department__c from Master_Case_Type_Regional__c where Case_Type__c =: recType]);
            cs.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recType).getRecordTypeId();
            //cs.PIC__c = csTypeReg.size() > 0 ? csTypeReg[0].PIC_Department__c : UserInfo.getUserId();
        }
    }
    
    @RemoteAction
    public static String attachBlob(String caseNumber, String attachmentId, String fileName, String contentType, String base64BlobValue) {
        // get parent id by case number
        Id tempId = [SELECT Id FROM Case WHERE CaseNumber = :caseNumber].Id;
        String parentId = Id.valueOf(tempId);
               
        //If recordId is blank this is the first part of a multi piece upload
        IF(attachmentId == '' || attachmentId == null) {
            Attachment att = new Attachment(
                ParentId = parentId,
                Body = EncodingUtil.Base64Decode(base64BlobValue),
                Name = fileName,
                ContentType = contentType
            );
            insert att;
            
            //Return the new attachment Id
            return att.Id;
            
        } else {
            for(Attachment atm : [select Id, Body from Attachment where Id = :attachmentId]) {
                //Take the body of the current attachment, convert to base64 string, append base64 value sent from page, then convert back to binary for the body
                update new Attachment(Id = attachmentId, Body = EncodingUtil.Base64Decode(EncodingUtil.Base64Encode(atm.Body) + base64BlobValue));
            }
            
            //Return the Id of the attachment we are currently processing
            return attachmentId;
        }
    }

    private String checkFile(Integer fileSize, String fileName) {
        // proceed only if file exists
        if(fileSize > 0) {
            // proceed only if file is csv file
            fileName.toLowerCase();
            if(fileName.substringAfterLast('.') != 'csv') {
                return 'error,<strong>Invalid file</strong>. File is not in csv format. Please make sure that input file is csv file.';
            }
            return 'true';
        } else {
            return 'error,No file selected.';
        }
    }

    private String parseString(String s) {
        return s.substringAfter(',');
    }
    
    public PageReference massCaseUpload () {
        try {
            System.debug('Mass Upload Case');
            String moduleName = 'massUpload';
            isIcf = (isIcf != null) ? isIcf : false;
            p = ApexPages.Currentpage();
            if(cs.Type != null){
                if(cs.Status == 'New' && (cs.Type == 'Inquiry' && cs.Entity_Backup__c != null && cs.Origin != null && cs.General_Attitude__c != null && cs.Root_Cause__c != null && cs.Priority != null) || (cs.Type == 'Request' && cs.Related_Departments__c != null) || (cs.Type == 'Complaint')){
                    cs.General_Attitude__c = cs.General_Attitude__c;
                    cs.Priority = cs.Priority;
                    cs.Root_Cause__c = cs.Root_Cause__c;
                    System.debug('Cases Data : '+cs);
                    
                    // cek format csv file
                    if(cs.Type == 'Request'){
                        String isFileValid = checkFile(massReqUploadFileSize, massReqUploadFileName);
                        if(isFileValid != 'true') {
                            message = parseString(isFileValid);
                            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                            ApexPages.addMessage(errorMessage);
                            return p;
                        }
                        System.debug('Format File is valid!');
                        
                        cs.PIC__c = cs.PIC_Department_LU__c;
                        
                        csvContent = massReqUploadFileBody.toString();
                    }
                    if(cs.Type == 'Inquiry'){
                        String isFileValid = checkFile(massInqUploadFileSize, massInqUploadFileName);
                        if(isFileValid != 'true') {
                            message = parseString(isFileValid);
                            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                            ApexPages.addMessage(errorMessage);
                            return p;
                        }
                        System.debug('Format File is valid!');
                        
                        csvContent = massInqUploadFileBody.toString();
                    }
                    if(cs.Type == 'Complaint'){
                        String isFileValid = checkFile(massCompUploadFileSize, massCompUploadFileName);
                        if(isFileValid != 'true') {
                            message = parseString(isFileValid);
                            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                            ApexPages.addMessage(errorMessage);
                            return p;
                        }
                        System.debug('Format File is valid!');
                        
                        csvContent = massCompUploadFileBody.toString();
                    }
                    csvContentLines = csvContent.split('\\n');
                    
                    // proceed only if all policy number valid
                    
                    // remove header line
                    csvContentLines.remove(0);
                    String isDataValid = checkData2(csvContentLines, moduleName);
                    if(isDataValid != 'true') {
                        message = parseString(isDataValid);
                        ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                        ApexPages.addMessage(errorMessage);
                        return p;
                    }
                    System.debug('Data is valid!');
                    /** These line of code below is creating new List from text content lines list each new lists contains 10 lines (listSize) */
                    Integer listSize = Integer.valueOf(System.Label.Mass_Upload_Case_Limit_chunk);
                    List<String> currentLines = new List<String>();
                    // loop through every lines
                    Map<Integer,List<String>> mapDataRaw = new Map<Integer, List<String>>();
                    Integer counterMap = 0;
                    for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                        List<String> tempList = new List<String>();
                        Integer count = 0;
                        System.debug('ike : '+i);
                        Datetime timeNow = System.now();
                        for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                            tempList.add(csvContentLines[j]);
                        }
                        mapDataRaw.put(counterMap++, tempList);
                    }
                    
                    //Mass_Upload_Cases_Batch_Limit must be < 50, impacting to call future method from SubmitCaseServiceQueueable
                    Database.executeBatch(new MassUploadCasesControllerBatch(mapDataRaw, cs, cnt, isIcf,moduleName,0), Integer.valueOf(Label.Mass_Upload_Cases_Batch_Limit));
                    
                    message = 'New Mass Case Upload data has been uploaded successfully.';
                    ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
                    ApexPages.addMessage(errorMessage);
                }else if(cs.Type != 'Complaint'){
                    System.debug('Cases Data : '+cs);
                    message = 'There is problem with input data. ';
                    message += (cs.Type == null ? 'Type is Null, ' : '');
                    message += (cs.Entity_Backup__c == null ? 'Entity is Null, ' : '');
                    message += (cs.NonPP__c == false && cs.General_Attitude__c == null ? 'Customer Mood is Null, ' : '');
                    message += (cs.Root_Cause__c == null ? 'Root Cause is Null, ' : '');
                    message += (cs.Type == 'Request' && cs.Related_Departments__c == null ? 'Department is Null, ' : '');
                    message += (cs.Priority == null ? 'Priority is Null, ' : '');
                    message += (cs.Origin == null ? 'Origin is Null' : '');
                    ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                    ApexPages.addMessage(errorMessage);
                }   
            }
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage() + ' in line '+e.getLineNumber());
            ApexPages.addMessage(errorMessage);
            return p;
        }
    } 

    private String checkData2(String[] lines, String moduleName) {
        System.debug('validate data');
        String errorMessage = '';
        List<String> policyNumbers = new List<String>();
        List<String> descriptions = new List<String>();

        // loop through every lines, but skip the header line
        for(Integer i = 0; i < lines.size(); i++) {
            String currentLine = lines[i];
            System.debug('currentLine '+currentLine);
            String policyNumber = currentLine.substringBefore(',');
            String description = currentLine.substringAfter(',');

            if (String.isEmpty(policyNumber)) {
                message = 'error,Invalid Data. Nomor Polis di baris ' + i + ' tidak ditemukan ' + currentLine;
                return message;
            }

            if (policyNumber.left(1) != '0') {
                policyNumber = policyNumber;
            }

            policyNumbers.add(policyNumber);

            descriptions.add(description);
        }
        
        List<String> duplicatePolicy = new List<String>();
        List<String> tempPolicyNumber = new List<String>();
        for(Integer i = 0; i < policyNumbers.size(); i++) {
            System.debug('tempPolicyNumber :'+tempPolicyNumber);
            if(!tempPolicyNumber.contains(policyNumbers[i]) || tempPolicyNumber.size() <= 0){
                tempPolicyNumber.add(policyNumbers[i]);
            }else{
                duplicatePolicy.add(policyNumbers[i]);
            }
        }
        System.debug('duplicatePolicy : '+duplicatePolicy);
        if(duplicatePolicy.size() > 0){
            message = 'error, Invalid Data. Duplicate data found for policy Number '+duplicatePolicy;
            return message;
        }

        List<Contact> contacts = [Select Id, Policy_No__c From Contact WHERE Policy_No__c =: policyNumbers];
        String policyNumStrings = String.join(contacts, ',');
        List<String> policyNumberInvalid = new List<String>();
        
        // all contact/policy number not found
        if(contacts == null || contacts.isEmpty()) {
            message = 'error,<strong>Invalid Data</strong> : All Policy Number not found';
            return message;
        } 

        validDataList = new List<MassUploadWrapper>();
        if(contacts.size() != policyNumbers.size()){
            // number of policy number not match, need loop for detection invalid policy number
            for(String cse : policyNumbers) {
                System.debug('######### 1 policy number = ' + cse);
                System.debug('######### 1 contacts = ' + contacts);
                System.debug('######### 1 policyNumbers = ' + policyNumbers);
                System.debug('######### 1 descriptions = ' + descriptions);
                if (policyNumStrings.contains(cse)) {
                    System.debug('######### policy number = ' + cse + ' exists');
                } else {
                    policyNumberInvalid.add(cse);
                    System.debug('######### policy number = ' + cse + ' is not exists');
                    if (errorMessage == '') {
                        errorMessage = errorMessage + cse;
                    } else {
                        errorMessage = errorMessage + ', ' + cse;
                    }
                    validDataList.add(new MassUploadWrapper(cse,'Policy Number does not exist'));
                }
            }
        }

        if (errorMessage != '') {
            message = 'error,<strong>Invalid Data</strong>. See details below';
            return message;
        } else {
            return 'true';
        }
    }
    
    public List<SelectOption> getEntityList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('AMFS', 'AMFS'));
        tempList.add(new SelectOption('AFI', 'AFI'));
        tempList.add(new SelectOption('ALI', 'ALI'));
        tempList.add(new SelectOption('MAGI', 'MAGI'));
        return tempList;
    }
    
    public List<SelectOption> getStatusList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.Status.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('New', 'New'));
        
        return tempList;
    }
    
    public List<SelectOption> getTypeList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.Type.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        for(String pick : picklist){
            tempList.add(new SelectOption(pick,pick));
        }
        return tempList;
    }
    
    public List<SelectOption> getCaseTypeList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.Case_Type__c.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        for(String pick : picklist){
            tempList.add(new SelectOption(pick,pick));
        }
        return tempList;
    }
    
    public List<SelectOption> getPriorityList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.Priority.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        for(String pick : picklist){
            tempList.add(new SelectOption(pick,pick));
        }
        return tempList;
    }
    
    public List<SelectOption> getGeneralAttitudeList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.General_Attitude__c.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        for(String pick : picklist){
            tempList.add(new SelectOption(pick,pick));
        }
        return tempList;
    }
    
    public List<SelectOption> getRootCauseList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.Root_Cause__c.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        for(String pick : picklist){
            tempList.add(new SelectOption(pick,pick));
        }
        return tempList;
    }
    
    public List<SelectOption> getDepartmentList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.Related_Departments__c.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        for(String pick : picklist){
            tempList.add(new SelectOption(pick,pick));
        }
        return tempList;
    }
    
    public List<SelectOption> getOriginList() {
        List<SelectOption> tempList = new List<SelectOption>();
        List<String> picklist = getPickListValuesIntoList(Schema.Case.Origin.getDescribe());
        tempList.add(new SelectOption('', '--None--'));
        for(String pick : picklist){
            tempList.add(new SelectOption(pick,pick));
        }
        return tempList;
    }
    
    public List<String> getPickListValuesIntoList(Schema.DescribeFieldResult describeFieldPicklist){
        List<String> pickListValuesList= new List<String>();
        DescribeFieldResult fieldResult = describeFieldPicklist;
        System.debug('fieldResult :'+fieldResult);
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            System.debug('pickListVal :'+pickListVal);
            pickListValuesList.add(pickListVal.getLabel());
        }
		return pickListValuesList;
    }
    
    public class MassUploadWrapper{
        public String caseNo {get;set;}
        public String reason {get;set;}
        
        public MassUploadWrapper(String caseNo, String reason){
            this.caseNo = caseNo;
            this.reason = reason;
        }
    }

}