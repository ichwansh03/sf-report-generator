public class DMUResponseQueueable implements Queueable {

    private List<String> currentLines;
    private String func;
    private Boolean isIcf;

    public DMUResponseQueueable(List<String> currentLines, String func, Boolean isIcf) {
        this.currentLines = currentLines;
        this.func = func;
        this.isIcf = isIcf;
    }

    public void execute(QueueableContext context) {
        if (func.equals('resInquiry')) {
            for(Integer i = 0; i < currentLines.size(); i++) {
                String currentLine = currentLines.get(i);
                String caseNumber = currentLine.substringBefore(',');

                if (caseNumber.left(1) != '0' && caseNumber.length() == 7) {
                    caseNumber = '0' + caseNumber;
                }

                // split line by comma delimiter
                // parsedString = currentLine.split(',');
                String remark = currentLine.substring(currentLine.indexOf(',')+1, currentLine.length());

                List<Case> cases = [Select Id From Case WHERE CaseNumber =: caseNumber LIMIT 1];
                for(Case cse : cases) {
                    // insert new internal comment/case comment
                    CaseComment cc = new CaseComment(ParentId = cse.Id, CommentBody = remark);
                    insert cc;
                }

                update cases;
            }
        } else if (func.equals('resChs') || func.equals('res')) {
            for(Integer i = 0; i < currentLines.size(); i++) {
                String currentLine = currentLines.get(i);
                String caseNumber = currentLine.substringBefore(',');

                if (caseNumber.left(1) != '0' && caseNumber.length() == 7) {
                    caseNumber = '0' + caseNumber;
                }

                // split line by comma delimiter
                // parsedString = currentLine.split(',');
                String remark = currentLine.substring(currentLine.indexOf(',')+1, currentLine.length());

                List<Case> cases = [Select Description__c From Case WHERE CaseNumber =: caseNumber LIMIT 1];
                for(Case cse : cases) {
                    System.debug('Description = ' + cse.Description__c);
                    // append remark to description_cc/complaint detail
                    cse.Description__c = cse.Description__c + '\r\n' + '\r\n' + remark;
                }

                update cases;
            }
        } else if (func.equals('reqClose')) {
            for(Integer i = 0; i < currentLines.size(); i++) {
                String currentLine = currentLines.get(i);
                String caseNumber = currentLine.substringBefore(',');

                if (caseNumber.left(1) != '0' && caseNumber.length() == 7) {
                    caseNumber = '0' + caseNumber;
                }

                List<Case> cases = [Select Id, Status, ManualClosedCase__c From Case WHERE CaseNumber =: caseNumber LIMIT 1];
                for(Case cse : cases) {
                    // insert new internal comment/case comment
                    if(currentLine.indexOf(',') != currentLine.lastIndexOf(',')) {
                        String remark = currentLine.substring(currentLine.indexOf(',')+1, currentLine.lastIndexOf(','));
                        CaseComment cc = new CaseComment(ParentId = cse.Id, CommentBody = remark);
                        insert cc;
                    }
                    // update status to closed if status exists
                    if(currentLine.right(1) != ',' && currentLine.substring(currentLine.lastIndexOf(',') + 1).length() >= 3) {
                        cse.Status = currentLine.substring(currentLine.lastIndexOf(',') + 1);
                    }

                    cse.ManualClosedCase__c = isIcf;
                }
                
                update cases;
            }
        } else if (func.equals('chsClose')) {
            System.debug('Current User: ' + UserInfo.getUserName());
            
            for(Integer i = 0; i < currentLines.size(); i++) {
                String currentLine = currentLines.get(i);
                String caseNumber = currentLine.substringBefore(',');

                if (caseNumber.left(1) != '0' && caseNumber.length() == 7) {
                    caseNumber = '0' + caseNumber;
                }

                List<Case> cases = [Select Description__c, Other_Information__c, CHS_Status__c, ManualClosedCase__c From Case WHERE CaseNumber =: caseNumber LIMIT 1];
                for(Case cse : cases) {

                    if(currentLine.indexOf(',') != currentLine.lastIndexOf(',')) {
                        String remark = currentLine.substring(currentLine.indexOf(',')+1, currentLine.lastIndexOf(','));
                        // append remark to Other_Information__c/other information
                        cse.Other_Information__c = cse.Other_Information__c + '\r\n' + '\r\n' + remark;
                    }

                    // update status to open if status exists
                    if(currentLine.right(1) != ',' && currentLine.substring(currentLine.lastIndexOf(',') + 1).length() >= 3) {
                        if(!Test.isRunningTest()){
                            cse.CHS_Status__c = currentLine.substring(currentLine.lastIndexOf(',') + 1);
                        }
                    }

                    cse.ManualClosedCase__c = isIcf;
                }

                update cases;
            }
        }
    }
}