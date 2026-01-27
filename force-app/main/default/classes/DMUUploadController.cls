public class DMUUploadController {

    public ApexPages.StandardController controller {get; set;}
    public Boolean isIcf {get; set;} // ManualClosedCase__c
    public Blob csvFileBody {get; set;}
    public String csvFileName {get; set;}
    public Integer csvfileSize {get; set;}
    public String newStatus {get; set;}
    public String remark {get; set;}

    // response
    public Blob resInquiryFileBody {get; set;}
    public String resInquiryFileName {get; set;}
    public Integer resInquiryfileSize {get; set;}
    public Blob resChsFileBody {get; set;}
    public String resChsFileName {get; set;}
    public Integer investigationfileSize {get; set;}
    public Blob investigationFileBody {get; set;}
    public String investigationFileName {get; set;}
    public Integer resChsfileSize {get; set;}

    // update and close
    public Blob reqCloseFileBody {get; set;}
    public String reqCloseFileName {get; set;}
    public Integer reqClosefileSize {get; set;}
    public Blob chsCloseFileBody {get; set;}
    public String chsCloseFileName {get; set;}
    public Integer chsClosefileSize {get; set;}

    // reassign
    public String csvContent {get; set;}
    public String[] csvContentLines {get; set;}
    public String[] parsedString {get; set;}
    public PageReference p {get; set;}
    public String message {get; set;}
    public Case cs {get; set;}
    public CaseComment cc {get; set;}

    //indah 30Agustus2018 - Upload Functionality to Request Duplicate or re-Print Policy Book
    public Blob resDuplicateFileBody {get; set;}
    public String resDuplicateFileName {get; set;}
    public Integer resDuplicatefileSize {get; set;}
    public String NomorPolis {get; set;}
    public String Deskripsi {get; set;}
    public Contact cnt {get; set;}

    public DMUUploadController() {
        csvContentLines = new String[]{};
        cs = new Case();
    }
    
    public DMUUploadController(ApexPages.StandardController controller) {
        this.controller = controller;
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

    // response request/inquiry
    public PageReference resInquiryUploadCsv() {
        try {
            System.debug('response new request');
            String moduleName = 'resInquiry';
            p = ApexPages.Currentpage();

            // proceed only if file is in proper format
            String isFileValid = checkFile(resInquiryfileSize, resInquiryFileName);
            if(isFileValid != 'true') {
                message = parseString(isFileValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            System.debug('File is valid!');

            csvContent = resInquiryFileBody.toString();
            // split content to array of string lines
            csvContentLines = csvContent.split('\\n');

            // proceed only if data is in valid format
            String isDataValid = checkData(csvContentLines, moduleName);
            if(isDataValid != 'true') {
                message = parseString(isDataValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            System.debug('Data is valid!');

            // List<List<String>> wrapperList = new List<List<String>>();

            // remove header line
            csvContentLines.remove(0);
            /**
            These line of code below is creating new List from text content lines list
            each new lists contains 10 lines (listSize)
            */
            Integer listSize = Integer.valueOf(System.Label.DMU_response_request_size);
            List<String> currentLines = new List<String>();
            // loop through every lines
            for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                List<String> tempList = new List<String>();
                for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                    tempList.add(csvContentLines[j]);
                }
                ID jobID = System.enqueueJob(new DMUResponseQueueable(tempList, moduleName, isIcf));
                // wrapperList.add(tempList);
            }

            message = 'New Request data has been uploaded successfully.';
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
            ApexPages.addMessage(errorMessage);
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage());
            ApexPages.addMessage(errorMessage);
            return p;
        }
    }

    // response chs
    public PageReference resChsUploadCsv() {
        try {
            String moduleName = 'resChs';
            p = ApexPages.Currentpage();

            // proceed only if file is in proper format
            String isFileValid = checkFile(resChsfileSize, resChsFileName);
            if(isFileValid != 'true') {
                message = parseString(isFileValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            csvContent = resChsFileBody.toString();
            // split content to array of string lines
            csvContentLines = csvContent.split('\\n');

            // proceed only if data is in valid format           
            String isDataValid = checkData(csvContentLines, moduleName);
            if(isDataValid != 'true') {
                message = parseString(isDataValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            
            // List<List<String>> wrapperList = new List<List<String>>();

            // remove header line
            csvContentLines.remove(0);
            /**
            These line of code below is creating new List from text content lines list
            each new lists contains 10 lines (listSize)
            */
            Integer listSize = Integer.valueOf(System.Label.DMU_response_chs_size);
            List<String> currentLines = new List<String>();
            // loop through every lines
            for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                List<String> tempList = new List<String>();
                for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                    tempList.add(csvContentLines[j]);
                }
                ID jobID = System.enqueueJob(new DMUResponseQueueable(tempList, moduleName, isIcf));
                // wrapperList.add(tempList);
            }

            message = 'New CHS data has been uploaded successfully.';
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
            ApexPages.addMessage(errorMessage);
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage());
            ApexPages.addMessage(errorMessage);
            return p;
        }
    }

    // response investigation
    public PageReference resUploadCsv() {
        try {
            String moduleName = 'res';
            p = ApexPages.Currentpage();

            // proceed only if file is in proper format
            String isFileValid = checkFile(investigationfileSize, investigationFileName);
            if(isFileValid != 'true') {
                message = parseString(isFileValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            csvContent = investigationFileBody.toString();
            // split content to array of string lines
            csvContentLines = csvContent.split('\\n');

            // proceed only if data is in valid format
            String isDataValid = checkData(csvContentLines, moduleName);
            if(isDataValid != 'true') {
                message = parseString(isDataValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }

            // List<List<String>> wrapperList = new List<List<String>>();
            
            // remove header line
            csvContentLines.remove(0);
            /**
            These line of code below is creating new List from text content lines list
            each new lists contains 10 lines (listSize)
            */
            Integer listSize = Integer.valueOf(System.Label.DMU_response_investigation_size);
            List<String> currentLines = new List<String>();
            // loop through every lines
            for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                List<String> tempList = new List<String>();
                for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                    tempList.add(csvContentLines[j]);
                }
                ID jobID = System.enqueueJob(new DMUResponseQueueable(tempList, 'res', isIcf));
                // wrapperList.add(tempList);
            }

            message = 'Data has been uploaded successfully.';
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
            ApexPages.addMessage(errorMessage);
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage());
            ApexPages.addMessage(errorMessage);
            return p;
        }
    }

    // update & reassign
    public PageReference uploadCsv() {
        try {
            String moduleName = 'reassign';
            p = ApexPages.Currentpage();

            // proceed only if file is in proper format
            String isFileValid = checkFile(csvfileSize, csvFileName);
            if(isFileValid != 'true') {
                message = parseString(isFileValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            csvContent = csvFileBody.toString();
            // split content to array of string lines
            csvContentLines = csvContent.split('\\n');

            // proceed only if data is in valid format
            String isDataValid = checkData(csvContentLines, moduleName);
            if(isDataValid != 'true') {
                message = parseString(isDataValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }

            // List<List<String>> wrapperList = new List<List<String>>();
            
            // remove header line
            csvContentLines.remove(0);
            /**
            These line of code below is creating new List from text content lines list
            each new lists contains 10 lines (listSize)
            */
            Integer listSize = Integer.valueOf(System.Label.DMU_update_reassign_size);
            List<String> currentLines = new List<String>();
            // loop through every lines
            for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                List<String> tempList = new List<String>();
                for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                    tempList.add(csvContentLines[j]);
                }
                ID jobID = System.enqueueJob(new DMUReassignQueueable(tempList, cs));
                // wrapperList.add(tempList);
            }

            message = 'Data uploaded successfully.';
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
            ApexPages.addMessage(errorMessage);
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage());
            ApexPages.addMessage(errorMessage);
            return p;
        }
    }

    // update & close new request
    public PageReference reqCloseUploadCsv() {
        try {
            String moduleName = 'reqClose';
            p = ApexPages.Currentpage();
            System.debug('is icf = ' + isIcf);

            // proceed only if file is in proper format
            String isFileValid = checkFile(reqClosefileSize, reqCloseFileName);
            if(isFileValid != 'true') {
                message = parseString(isFileValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            csvContent = reqCloseFileBody.toString();

            // split content to array of string lines
            csvContentLines = csvContent.split('\\n');

            // proceed only if data is in valid format
            String isDataValid = checkData(csvContentLines, moduleName);
            if(isDataValid != 'true') {
                message = parseString(isDataValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }

            // List<List<String>> wrapperList = new List<List<String>>();

            // remove header line
            csvContentLines.remove(0);
            /**
            These line of code below is creating new List from text content lines list
            each new lists contains 6 lines (listSize)
            */
            Integer listSize = Integer.valueOf(System.Label.DMU_update_close_request_size);
            List<String> currentLines = new List<String>();
            // loop through every lines
            for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                List<String> tempList = new List<String>();
                for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                    tempList.add(csvContentLines[j]);
                }
                ID jobID = System.enqueueJob(new DMUResponseQueueable(tempList, moduleName, isIcf));
                // wrapperList.add(tempList);
            }

            message = 'New Request data has been uploaded successfully.';
            ApexPages.Message infoMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
            ApexPages.addMessage(infoMessage);
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage());
            ApexPages.addMessage(errorMessage);
            return p;
        }
    }

    // update & close new chs
    public PageReference chsCloseUploadCsv() {
        try {
            System.debug('Close new CHS');
            String moduleName = 'chsClose';
            p = ApexPages.Currentpage();

            // proceed only if file is in proper format
            String isFileValid = checkFile(chsClosefileSize, chsCloseFileName);
            if(isFileValid != 'true') {
                message = parseString(isFileValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            System.debug('File is valid');
            csvContent = chsCloseFileBody.toString();
            // split content to array of string lines
            csvContentLines = csvContent.split('\\n');

            // proceed only if data is in valid format
            String isDataValid = checkData(csvContentLines, moduleName);
            if(isDataValid != 'true') {
                message = parseString(isDataValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            System.debug('Data is valid');
            // List<List<String>> wrapperList = new List<List<String>>();

            // remove header line
            csvContentLines.remove(0);
            System.debug('Header removed');

            /**
            These line of code below is creating new List from text content lines list
            each new lists contains 10 lines (listSize)
            */
            Integer listSize = Integer.valueOf(System.Label.DMU_update_close_chs_size);
            System.debug('List size is ' + listSize);
            List<String> currentLines = new List<String>();
            for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                List<String> tempList = new List<String>();
                for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                    tempList.add(csvContentLines[j]);
                }
                ID jobID = System.enqueueJob(new DMUResponseQueueable(tempList, moduleName, isIcf));
                // wrapperList.add(tempList);
            }

            message = 'New CHS data has been uploaded successfully.';
            ApexPages.Message infoMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
            ApexPages.addMessage(infoMessage);
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage());
            ApexPages.addMessage(errorMessage);
            return p;
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

    private String checkData(String[] lines, String moduleName) {
        System.debug('validate data');
        String errorMessage = '';
        Integer reqCloseValidSize = Integer.valueOf(System.Label.DMU_update_close_request_valid_size);
        Integer chsCloseValidSize = Integer.valueOf(System.Label.DMU_update_close_chs_valid_size);
        Integer responseValidSize = Integer.valueOf(System.Label.DMU_response_valid_size);
        Integer dmuFunctionalityValidSize = Integer.valueOf(System.Label.DMU_upload_Req_Duplicate);
        List<String> caseNumbers = new List<String>();
        
        // loop through every lines, but skip the header line
        for(Integer i = 1; i < lines.size(); i++) {
            String currentLine = lines[i];
            String caseNumber = currentLine.substringBefore(',');

            if (String.isEmpty(caseNumber) || !(caseNumber.isNumeric()) || caseNumber.length() > 8) {
                message = 'error,Invalid Data. Record number ' + i + ' is invalid. ' + currentLine;
                return message;
            }

            if (caseNumber.left(1) != '0' && caseNumber.length() == 7) {
                caseNumber = '0' + caseNumber;
            }
            caseNumbers.add(caseNumber);

            // Boolean isLineValid = Pattern.matches('^(^'+'\\'+'d{7,8}),(.+),(.*)$', currentLine);
            // Boolean isLineValid = Pattern.matches('^(^\\d{7,8}),(.+)$', currentLine);
            // if(isLineValid == false) {
                // System.debug('check line ' + isLineValid);
            //     message = 'error,Invalid Data. Record number ' + i + ' is invalid. ' + currentLine;
            //     return message;
            // }
        }

        if (moduleName.equals('reqClose')) {
            if (lines.size() > reqCloseValidSize) {
                message = 'error,<strong>Invalid Data</strong>. Limit data exeeded. Case numbers should not be more than ' + reqCloseValidSize + ' records';
                return message;
            }
        } else if(moduleName.equals('chsClose')) {
            if (lines.size() > chsCloseValidSize) {
                message = 'error,<strong>Invalid Data</strong>. Limit data exeeded. Case numbers should not be more than ' + chsCloseValidSize + ' records';
                return message;
            }
        } else if(moduleName.equals('resDuplicate')){
            if (lines.size() > dmuFunctionalityValidSize) {
                message = 'error,<strong>Invalid Data</strong>. Limit data exeeded. Case numbers should not be more than ' + dmuFunctionalityValidSize + ' records.';
                return message;
            }
        } else {
            if (lines.size() > responseValidSize) {
                message = 'error,<strong>Invalid Data</strong>. Limit data exeeded. Case numbers should not be more than ' + responseValidSize + ' records.';
                return message;
            }
        }

        List<Case> caseIds = [SELECT Id, CaseNumber, Type FROM Case WHERE CaseNumber IN :caseNumbers];
        for (Case cse : caseIds) {
            if (
                cse.Type.equals('Complaint') && moduleName.equals('reqClose') ||
                cse.Type.equals('Complaint') && moduleName.equals('resInquiry')) {
                message = 'error,<strong>Invalid Data</strong>. Complaint type is not acceptable for this operation. Make sure case type you upload is matching with the upload operation.';
                return message;
            } else if (cse.Type.equals('Request') && moduleName.equals('chsClose') ||
                cse.Type.equals('Request') && moduleName.equals('res') ||
                cse.Type.equals('Request') && moduleName.equals('resChs')) {
                message = 'error,<strong>Invalid Data</strong>. Request type is not acceptable for this operation. Make sure case type you upload is matching with the upload operation.';
                return message;
            }
        }

        String caseNumberStrings = String.join(caseIds, ',');
        
        if(caseIds == null || caseIds.isEmpty()) {
            message = 'error,<strong>Invalid Data</strong>. Case numbers are not found. Upload failed.';
            return message;
        } else  if (caseIds.size() != caseNumbers.size()) {
            for(String cse : caseNumbers) {
                System.debug('case id = ' + cse);
                if (caseNumberStrings.contains(cse)) {
                    System.debug('case id = ' + cse + ' exists');
                } else {
                    System.debug('case id = ' + cse + ' is not exists');
                    if (errorMessage == '') {
                        errorMessage = errorMessage + cse;
                    } else {
                        errorMessage = errorMessage + ', ' + cse;
                    }
                }
            }
        }
        if (errorMessage != '') {
            message = 'error,<strong>Invalid Data</strong>. Case number(s) : ' + errorMessage + ' are not found. Upload failed.';
            return message;
        } else {
            return 'true';
        }
    }


    private String parseString(String s) {
        return s.substringAfter(',');
    }

    //<!--indah 30Agustus2018 - start - Upload Functionality to Request Duplicate or re-Print Policy Book -->
    public void dmuUploadFunctionalityvalue () {
        List<Case> caseList = new List<Case>();
        cs = new Case();
        cs.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName()
                          .get('RequestAMFSCase').getRecordTypeId();
        cs.Entity_Backup__c = 'AMFS';
        cs.type = 'Request';
        cs.NonPP__c = false;
    } 
    
    public PageReference dmuUploadFunctionality () {
        try {
            System.debug('response Upload Functionality to Request Duplicate or re-Print Policy Book');
            String moduleName = 'resDuplicate';
            System.debug('is icf = ' + isIcf);
            p = ApexPages.Currentpage();

            // cek format csv file
            String isFileValid = checkFile(resDuplicatefileSize, resDuplicateFileName);
            if(isFileValid != 'true') {
                message = parseString(isFileValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            System.debug('Format File is valid!');

            csvContent = resDuplicateFileBody.toString();
            csvContentLines = csvContent.split('\\n');

            // proceed only if all policy number valid
            String isDataValid = checkData2(csvContentLines, moduleName);
            if(isDataValid != 'true') {
                message = parseString(isDataValid);
                ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, message);
                ApexPages.addMessage(errorMessage);
                return p;
            }
            System.debug('Data is valid!');

            // remove header line
            csvContentLines.remove(0);
            /** These line of code below is creating new List from text content lines list each new lists contains 10 lines (listSize) */
            Integer listSize = Integer.valueOf(System.Label.DMU_upload_Req_Duplicate_chunk);
            List<String> currentLines = new List<String>();
            // loop through every lines
            for(Integer i = 0; i < (csvContentLines.size()/listSize)+1; i++) {
                List<String> tempList = new List<String>();
                for (Integer j = (i*listSize); (j < (i*listSize)+listSize) && (j < csvContentLines.size()) ; j++) {
                    tempList.add(csvContentLines[j]);
                }
                ID jobID = System.enqueueJob(new DMUFunctionalityQueueable(tempList, cs, cnt, isIcf));
            }

            message = 'New DMU Functionality Request data has been uploaded successfully.';
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.INFO, message);
            ApexPages.addMessage(errorMessage);
            return p;
        } catch(Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Fatal Error. ' + e.getMessage());
            ApexPages.addMessage(errorMessage);
            return p;
        }
    } 

    private String checkData2(String[] lines, String moduleName) {
        System.debug('validate data');
        String errorMessage = '';
        Integer dmuFunctionalityValidSize = Integer.valueOf(System.Label.DMU_upload_Req_Duplicate);
        List<String> policyNumbers = new List<String>();
        List<String> descriptions = new List<String>();

        //CSV file column validation
        // Set<String> columnsInFile = new Set<String>();
        // if (!columnsInFile.containsAll('NomorPolis','Deskripsi')) {
        //     message = 'error,Invalid Data. Header csv tidak sesuai, header sesuai : NomorPolis,Deskripsi.';
        //     return message;
        // }
        
        // loop through every lines, but skip the header line
        for(Integer i = 1; i < lines.size(); i++) {
            String currentLine = lines[i];
            String policyNumber = currentLine.substringBefore(',');
            String description = currentLine.substringAfter(',');

            if (String.isEmpty(policyNumber)) {
                message = 'error,Invalid Data. Nomor Polis di baris ' + i + ' tidak ditemukan ' + currentLine; //message = 'error,Invalid Data. Record number ' + i + ' is invalid. ' + currentLine;
                return message;
            }

            if (policyNumber.left(1) != '0') {
                policyNumber = policyNumber;
            }

            policyNumbers.add(policyNumber);

            descriptions.add(description);
        }

        if (moduleName.equals('resDuplicate')){
            if (lines.size() > dmuFunctionalityValidSize) {
                message = 'error,Invalid Data. Limit data exeeded. Policy Number(s) should not be more than ' + dmuFunctionalityValidSize + ' records.';
                return message;
            }
        }

        //List<Case> caseIds = [Select Policy_Number__c From Case WHERE Policy_Number__c in :policyNumbers];
        List<Contact> contacts = [Select Id, Policy_No__c From Contact WHERE Policy_No__c =: policyNumbers];
        String policyNumStrings = String.join(contacts, ',');
        List<String> policyNumberInvalid = new List<String>();
        
        // all contact/policy number not found
        if(contacts == null || contacts.isEmpty()) {
            message = 'error,<strong>Invalid Data</strong> : All Policy Number not found';
            return message;
        } 

        
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
                }
            }
        }

        if (errorMessage != '') {
            message = 'error,<strong>Invalid Data</strong>. Policy Number(s) : ' + errorMessage + ' are not found. Upload failed.';
            return message;
        } else {
            return 'true';
        }
    }
    //<!--indah 30Agustus2018 - end - Upload Functionality to Request Duplicate or re-Print Policy Book -->

}