/*
 * filename format:
 * [status]_tag_policyno_timestamp
 *
 * status:
 * n = new/draft
 * v = valid/submitted
 * x = invalid/old
 *
 * examples:
 * [n]_KTP_520-1234567_20210415103800
 * [v]_SURAT-KUASA_520-1234567_20210415103800
 * [x]_FORM-COMPLAINT_520-1234567_20210415103800
 */
public class CaseComplaintAttachmentService {

    public static final String DELIMITER = '_';
    public static final String ATT_NEW = '[n]';
    public static final String ATT_SUBMITTED = '[v]';
    public static final String ATT_INVALID = '[x]';

    public static void updateAttachmentStatus(List<Attachment> attList) {
        Datetime todayDt = System.now();
        Map<String, String> parentIdMap = new Map<String, String>();
        for (Attachment attObj : attList) {
            parentIdMap.put(attObj.ParentId, attObj.ParentId);
        }
        List<Attachment> existingAttList = getAttachmentByParentIdList(parentIdMap.values());
        Map<String, List<Attachment>> attByParentMap = new Map<String, List<Attachment>>();
        for (String attParentId : parentIdMap.values()) {
            List<Attachment> attByParentList = new List<Attachment>();
            for (Attachment existingAttObj : existingAttList) {
                if (existingAttObj.ParentId == attParentId) {
                    attByParentList.add(existingAttObj);
                }
            }
            attByParentMap.put(attParentId, attByParentList);
        }
        Map<String, Attachment> updateMap = new Map<String, Attachment>();
        for (Attachment attObj : attList) {
            Map<String, String> filenameMap = getAttachmentTags(attObj.Name);
            String fileStatus = filenameMap.get('status');
            String fileTag = filenameMap.get('tag');
            String filePolicyNo = filenameMap.get('policy-no');
            if (fileStatus == ATT_SUBMITTED) {
                List<Attachment> existingAttByParentList = attByParentMap.get(attObj.ParentId);
                if (existingAttByParentList != null) {
                    Map<String, Attachment> existingAttByParentSubmittedMap = getExistingSubmittedAttachment(existingAttByParentList);
                    Attachment attCheck = existingAttByParentSubmittedMap.get(fileTag);
                    if (attCheck != null) {
                        Map<String, String> oldAttTagMap = getAttachmentTags(attCheck.Name);
                        String timestampStr = String.isNotBlank(oldAttTagMap.get('timestamp')) ? oldAttTagMap.get('timestamp') : todayDt.format('yyyyMMddHHmmss');
                        String fileExtensionOld = attCheck.Name.substring(attCheck.Name.lastIndexOf('.') + 1);
                        String attOldFilename = getOldName(fileTag, filePolicyNo, timestampStr, fileExtensionOld);
                        attCheck.Name = attOldFilename;
                        attCheck.OwnerId = UserInfo.getUserId();
                        attCheck.IsPrivate = false;
                        updateMap.put(attCheck.Id, attCheck);
                    }
                }
            }
        }
        try {
            update updateMap.values();
        }
        catch (Exception e) {
            attList[0].addError('Error updating existing attachments: ' + e.getMessage() + ', ' + e.getStackTraceString());
        }
    }

    public static Map<String, String> getAttachmentTags(String filename) {
        Map<String, String> resultMap = new Map<String, String>();
        if (String.isNotBlank(filename)) {
            List<String> filenameParts = filename.split('\\s*_\\s*');
            if (filenameParts.size() > 0) {
                resultMap.put('status', filenameParts.get(0));
            }
            if (filenameParts.size() > 1) {
                resultMap.put('tag', filenameParts.get(1));
            }
            if (filenameParts.size() > 2) {
                resultMap.put('policy-no', filenameParts.get(2));
                if (filenameParts.size() > 3) resultMap.put('timestamp', filenameParts.get(3).substringBefore('.'));
            }
        }
        return resultMap;
    }

    public static Map<String, Attachment> getExistingSubmittedAttachment(List<Attachment> currentAttList) {
        Map<String, Attachment> resultMap = new Map<String, Attachment>();
        for (Attachment att : currentAttList) {
            Map<String, String> filenameMap = getAttachmentTags(att.Name);
            String attStatus = filenameMap.get('status');
            String attTag = filenameMap.get('tag');
            if (String.isNotBlank(attStatus) && String.isNotBlank(attTag) && attStatus == ATT_SUBMITTED) {
                resultMap.put(attTag, att);
            }
        }
        return resultMap;
    }

    public static String getOldName(String fileTag, String policyNo, String timestampStr, String fileExtensionOld) {
        String attOldFilename = ATT_INVALID.replaceAll(DELIMITER, '');
        attOldFilename += DELIMITER + fileTag.replaceAll(DELIMITER, '');
        attOldFilename += DELIMITER + policyNo.replaceAll(DELIMITER, '');
        attOldFilename += DELIMITER + timestampStr;
        attOldFilename += '.' + fileExtensionOld;
        return attOldFilename;
    }

    public static List<Attachment> getAttachmentByParentIdList(List<String> parentIdList) {
        String q = 'SELECT Id, ParentId, Name, IsPrivate, ContentType, Description, LastModifiedDate, Parent.Name, LastModifiedBy.Name FROM Attachment WHERE ParentId IN :parentIdList ORDER BY CreatedDate ASC LIMIT 10000 ';
        return Database.query(q);
    }
}