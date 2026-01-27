public class RecordPolicyNotesQueueable implements Queueable, Database.AllowsCallouts {

    private Map<String, String> prop;
    
    public RecordPolicyNotesQueueable(Map<String, String> prop) {
        this.prop = prop;
    }
    
    public void execute(QueueableContext qc) {
        long startLongTime = system.now().getTime();
        String message = '', response, errorMessage = 'Record Policy Notes: Failed to insert assessment, please contact Admin';
        
        RecordPolicyNotesService insertNotes;
        try {
            Map<String, String> properties = new Map<String, String>();
            system.debug('policy no: '+prop.get(EIPConstant.FIELD_POLICY_NO));
            properties.put(EIPConstant.PARAM_REMARK_CODE, prop.get('assmtTypeCd'));
            properties.put(EIPConstant.PARAM_NOTIF_TYPECD, prop.get('assessmentClassType'));
            properties.put(EIPConstant.PARAM_LASTUPDATE_DT, System.now().format('yyyy-MM-dd'));
            properties.put(EIPConstant.PARAM_MSG_POLICY, prop.get(EIPConstant.FIELD_POLICY_NO));
            properties.put('ResubmissionFlag','Y');
            insertNotes = EIPConnector.insertPolicyNotes(EIPConstant.APP_RLS, properties);
            
            system.debug('insert notes: '+insertNotes);
            if (insertNotes != null) {
            	if (insertNotes.RecordPolicyNotesResponse.RLSResponse.validationErrorCode != null) message = errorMessage;
                response = insertNotes.toStringJSON();
            }
            
        } catch (Exception e) {
            system.debug('Record Policy Notes Service error '+e.getMessage());
            response = e.getMessage();
            message = errorMessage;
        }
        
        Map<String, String> logProp = new Map<String, String>();
        logProp.put('ObjectId', prop.get(EIPConstant.FIELD_ID));
        logProp.put('Message', message);
        logProp.put('CaseType', 'TelUW (Record Policy Notes)');
        logProp.put('Report', 'Report Contacted & Uncontacted TelUW');
        logProp.put('Request', EIPConnector.getRequestPrettyPrint());
        logProp.put('Response', response);
        BaseCoreServiceController.insertLog(logProp, startLongTime);
        
    }
    
}