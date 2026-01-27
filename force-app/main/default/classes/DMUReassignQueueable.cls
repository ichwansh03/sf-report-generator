public class DMUReassignQueueable implements Queueable {

    private List<String> currentLines;
    private Case cs;

    public DMUReassignQueueable(List<String> currentLines, Case cs) {
        this.currentLines = currentLines;
        this.cs = cs;
    }

    public void execute(QueueableContext context) {
        for(Integer i = 0; i < currentLines.size(); i++) {
            String currentLine = currentLines.get(i);
            String caseNumber = currentLine.substringBefore(',');

            if (caseNumber.left(1) != '0' && caseNumber.length() == 7) {
                caseNumber = '0' + caseNumber;
            }

            // split line by comma delimiter
            // parsedString = currentLine.split(',');
            String remark = currentLine.substring(currentLine.indexOf(',')+1, currentLine.length());

            // complain detail = Description__c
            List<Case> cases = [Select Description__c, PIC__c From Case WHERE CaseNumber =: caseNumber LIMIT 1];
            for(Case cse : cases) {
                // append remark to description_cc/complaint detail
                cse.Description__c = cse.Description__c + '\r\n' + '\r\n' + remark;

                // update pic
                cse.PIC__c = cs.PIC__c;
            }

            update cases;
        }
    }
}