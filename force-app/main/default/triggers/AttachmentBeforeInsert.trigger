trigger AttachmentBeforeInsert on Attachment (before insert) {
     /*
     * SMART FA - CHS Enhancement
     * MII Taufik
     * April, 2021
     */
    if (Trigger.isBefore && Trigger.isInsert) {
        List<Attachment> ListAttch = new List<Attachment>();
        for (Attachment att : trigger.new){
            string temp = att.parentid;
            if (temp.left(3) == '500') ListAttch.add(att);
        }
        if (ListAttch.size() > 0) CaseComplaintAttachmentService.updateAttachmentStatus(ListAttch);
            //CaseComplaintAttachmentService.updateAttachmentStatus(Trigger.new);
    }
}