public with sharing class CallLineAssNoteController {
    private final String ERROR_MSG_INVALID_POLICYNO = 'Policy Number is Invalid';
    private final String FORMAT_DATE_YYYYMMDDHHMMSS = 'yyyymmddhhmmss';
    private final String REMARK_POS_CODE = 'CWN';
    private final Integer REFF_NO_LENGTH = 7;
    
    public Call_line__c cl {get;set;} 
    
    public String policyNumber {get; set;}
    public String errMsgAssSumPOS {get; set;}
    public String errMsgAssGetPOSTransaction {get; set;}
    public String errMsgAssNotif {get; set;}
    public String errMsgAssDtl {get; set;}
    public List<AssessmentNotesSummary> assessmentNotesSummaryPOSList {get;set;}
    public List<AssessmentNotesDetail> assessmentNotesDetailList {get;set;}
    public List<AssessmentNotesRemark> assessmentNotesRemarkList {get;set;}
    public Long timeProcessing {get; set;} 
    public String selectedReffNo {get; set;}
    public Boolean isMainRendered {get; set;}
    
    public Double offset{
        get{
            TimeZone tz = UserInfo.getTimeZone();
            //Milliseconds to Day
            return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
        }
    }
    
    public class  AssessmentNotesSummary{
        public Datetime LastInputDateTime {get; set;}
        public String LastInputDateTimeOrigStr {get; set;}
        public string Section {get; set;}
        public string TranTypeClaimType {get; set;}
        public string RefNo {get; set;}
        public string Status {get; set;}
        public string Remark {get; set;}
        public string assessmentClassType {get; set;}
        
        
        public AssessmentNotesSummary(){
        }       
    } 
    
    public class AssessmentNotesDetail{
        public Datetime InputDateTime {get; set;}
        public string UserIDAssessment {get; set;}
        public string Description {get; set;}
        public string Section {get; set;} 
        public string assessmentClassType {get; set;}
        
        public AssessmentNotesDetail(){
        }       
    }
    
    public class AssessmentNotesRemark{
        public Datetime InputDateTime {get; set;}
        public string UserIDAssessment {get; set;}
        public string Remark {get; set;}
        public string Section {get; set;} 
        public string assessmentClassType {get; set;}
        public String ReffNo {get; set;}
        
        public AssessmentNotesRemark(){
        }       
    }

    public CallLineAssNoteController(ApexPages.StandardController std){ 
        cl = (Call_Line__c)std.getRecord();
        isMainRendered = false;
        
        assessmentNotesSummaryPOSList = new List<AssessmentNotesSummary>();
        assessmentNotesDetailList = new List<AssessmentNotesDetail>();
        assessmentNotesRemarkList = new List<AssessmentNotesRemark>();
    }
    
    public PageReference generateInitPage() {
        assessmentNotesSummaryPOSList = new List<AssessmentNotesSummary>();
        system.debug('cl: '+cl);
        Call_Line__c clMain = [Select Id, RecordTypeId, RecordType.Name, Contact__c from Call_Line__c where id = :cl.Id limit 1];
        system.debug('clMain: '+clMain);
        Contact cMain = [Select id, name, Policy_no__c from Contact where id = :clMain.Contact__c];
        system.debug('Contact: '+cMain);
        //policyNumber = '515-3306922';
        policyNumber = cMain.Policy_no__c;
        system.debug('Policy Number: ' + policyNumber);
        invokeEIP();
        isMainRendered = true;
        return null;
    }
    
    public PageReference generateAssNoteDetails() {
        assessmentNotesDetailList = new List<AssessmentNotesDetail>();
        assessmentNotesRemarkList = new List<AssessmentNotesRemark>();
        system.debug('======= generateAssNoteDetails =====');
        system.debug('==>generateAssNoteDetails.reffNo: ' + selectedReffNo);
        system.debug('==>generateAssNoteDetails.policyNumber: ' + policyNumber);
        loadAssNoteDetail(EIPConstant.ASSESSMENT_TYPE_POS, selectedReffNo);
        loadNotificationRemarks(EIPConstant.ASSESSMENT_TYPE_POS, selectedReffNo);
        system.debug('==> assessmentNotesDetailList: ' + assessmentNotesDetailList);
        return null;
    }
    
    public void invokeEIP(){
        System.debug('============= INVOKE EIP =====================');  
        System.debug('Policy Number = '+policyNumber);
        DateTime dtStart = DateTime.now();
        String errMessage;
        
        System.debug('============= Loading ASS Note Summary =====================');  
        loadAssNoteSummary(EIPConstant.ASSESSMENT_TYPE_POS);
        System.debug('============= End Loading Ass Note Summary =====================');  
        
        DateTime dtEnd = DateTime.now();
        timeProcessing = dtEnd.getTime() - dtStart.getTime();
    }
    
    public void loadAssNoteSummary(String assClsType){
        List<AssessmentNotesSummary> assessmentNotesSummaryList = new List<AssessmentNotesSummary>();
        String errMsg;
        try{
            system.debug('---- GET ASS NOTES SUMMARY');
            EIPJson result = EIPConnector.getAssNotes(EIPConstant.OPERATION_SUMMARY, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, policyNumber, assClsType, null, null);
            EIPConnector.checkStatus(result.Body);
            EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment[] policyAssesments = result.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn;
            if(result != null && policyAssesments != null){
                for(EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment policyAssesment : policyAssesments){
                    AssessmentNotesSummary dataRec = new AssessmentNotesSummary();
                    dataRec.LastInputDateTimeOrigStr = policyAssesment.lastUpdDTTM;
                    dataRec.LastInputDateTime = CCCUtils.strToDateTime(dataRec.LastInputDateTimeOrigStr, FORMAT_DATE_YYYYMMDDHHMMSS);
                    dataRec.Section = policyAssesment.assmtSection;
                    dataRec.TranTypeClaimType = policyAssesment.assmtTypeCd != null ? policyAssesment.assmtTypeCd : '';
                    dataRec.RefNo = policyAssesment.assmtRefNo;
                    dataRec.Status = policyAssesment.assmtTypeCd != null && policyAssesment.assmtStatus != null ? policyAssesment.assmtStatus : '';
                    dataRec.Remark =  CCCUtils.renderLineSpaceToHtml(policyAssesment.assmtRemark);
                    dataRec.assessmentClassType = policyAssesment.assessmentClassType;
                    assessmentNotesSummaryList.add(dataRec);
                }
            }
        } catch(EIPConnector.NoDataException e){
            errMsg = EIPConstant.OPERATION_SUMMARY + ':' + e.getMessage();
            System.debug('NoDataException in loadAssNoteSummary - '+EIPConstant.OPERATION_SUMMARY+ ': '+e.getMessage());
        } catch(EIPConnector.EIPConnectorException e){
            errMsg = EIPConstant.OPERATION_SUMMARY + ':' + e.getMessage();
            System.debug('EIPConnectorException in loadAssNoteSummary - '+EIPConstant.OPERATION_SUMMARY+ ': '+e.getMessage());
        } catch (Exception e){
            errMsg = EIPConstant.OPERATION_SUMMARY + ':' + EIPConstant.ERROR_MSG_UNKNOWN;
            System.debug('Exception in loadAssNoteSummary - '+EIPConstant.OPERATION_SUMMARY+ ': '+e.getMessage());
        }
        if(String.isNotBlank(errMsg)){
            errMsgAssSumPOS = errMsg;
        }
        assessmentNotesSummaryPOSList.addAll(assessmentNotesSummaryList);
    }
    
    // Edited by Adi (refer to getAssNoteDetail) 2022-11-15
    public void loadAssNoteDetail(String assType, String refNo){
        system.debug('===> Load Ass Note Detail');
        List<AssessmentNotesDetail> assessmentNotesDetailListTemp = getAssNoteDetail(assType, refNo);
        Integer assNoteDetailLength = assessmentNotesDetailListTemp.size(); 
        for (Integer idx = assNoteDetailLength-1; idx>=0; idx--) {
            assessmentNotesDetailList.add(assessmentNotesDetailListTemp[idx]);
        }
        
        /*
        for (AssessmentNotesDetail dataRec : assessmentNotesDetailListTemp) {
            system.debug('===> dataRec: ' + dataRec);
            assessmentNotesDetailList.add(dataRec);
        }
		*/
        system.debug('===> assessmentNotesDetailListTemp: ' + assessmentNotesDetailListTemp);
    }
    
    // add by Adi (create new reusable method to get assessment note detail) 2022-11-15
    public List<AssessmentNotesDetail> getAssNoteDetail(String assType, String refNo){
        List<AssessmentNotesDetail> assessmentNotesDetailListTemp = new List<AssessmentNotesDetail>();
        try{
            EIPJson result = EIPConnector.getAssNotes(EIPConstant.OPERATION_DETAIL, EIPConstant.ENTITY_AMFS, EIPConstant.APP_RLS, policyNumber, assType, refNo, null);
            EIPConnector.checkStatus(result.Body);
            EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment[] policyAssesments = result.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn;
        
            for(EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment policyAssesment : policyAssesments){
                AssessmentNotesDetail dataRec = new AssessmentNotesDetail();
                dataRec.InputDateTime = CCCUtils.strToDateTime(policyAssesment.lastUpdDTTM, FORMAT_DATE_YYYYMMDDHHMMSS);
                dataRec.UserIDAssessment = policyAssesment.lastUpdBy;
                dataRec.Description = policyAssesment.assmtDesc;
                dataRec.Section = policyAssesment.assmtSection;
                dataRec.assessmentClassType = policyAssesment.assessmentClassType;
                assessmentNotesDetailListTemp.add(dataRec);
            }
        } catch(EIPConnector.NoDataException e){
            errMsgAssDtl = EIPConstant.OPERATION_DETAIL + ':' + e.getMessage();
            System.debug('NoDataException in getAssNoteDetail - '+e.getMessage());
        } catch(EIPConnector.EIPConnectorException e){
            errMsgAssDtl = EIPConstant.OPERATION_DETAIL + ':' + e.getMessage();
            System.debug('EIPConnectorException in getAssNoteDetail - '+e.getMessage());
        } catch (Exception e){
            errMsgAssDtl = EIPConstant.OPERATION_DETAIL + ':' + EIPConstant.ERROR_MSG_UNKNOWN;
            System.debug('Exception in getAssNoteDetail - '+e.getMessage());
        }
        return assessmentNotesDetailListTemp;
    }
    
    public void loadNotificationRemarks(String assType, String reffNo) {
        List<AssessmentNotesRemark> assessmentNotesRemarkListTemp = new List<AssessmentNotesRemark>();
        DateTime lastInputDateTime = Datetime.newInstance(1960, 2, 17);
        AssessmentNotesRemark lastAssesmentNotesRemark = new AssessmentNotesRemark();
        Integer reffNoLength = REFF_NO_LENGTH;
        reffNoLength = reffNo.length();
        try{
            EIPJson result = EIPConnector.getAssNotes(EIPConstant.OPERATION_NOTIF_REMARK, EIPConstant.ENTITY_AMFS, Label.Notification_Remarks_APPID, policyNumber, assType, null, null);
            EIPConnector.checkStatus(result.Body);
            EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment[] policyAssesments = result.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn;
        
            for(EIPJson.EIP_IcAx_AXAAsiaPolicyAssessment policyAssesment : policyAssesments){
                AssessmentNotesRemark dataRec = new AssessmentNotesRemark();
                dataRec.InputDateTime = CCCUtils.strToDateTime(policyAssesment.lastUpdDTTM, '');
                dataRec.UserIDAssessment = policyAssesment.lastUpdBy;
                dataRec.Remark = policyAssesment.assmtRemark;
                dataRec.Section = policyAssesment.assmtSection;
                String dataRecReffNo = policyAssesment.assmtRefNo != null ? policyAssesment.assmtRefNo : '';
                dataRecReffNo = dataRecReffNo.trim().leftPad(reffNoLength, '0');
                String dataRecClassType = policyAssesment.assessmentClassType != null ? policyAssesment.assessmentClassType : '';
                dataRecClassType = dataRecClassType.trim();
                dataRec.assessmentClassType = dataRecClassType;
                dataRec.ReffNo = dataRecReffNo;
                system.debug('==> loadNotificationRemarks.dataRec: ' + dataRec);
                system.debug('==> loadNotificationRemarks.dataRec.ReffNo and assessmentClassType: ' + dataRecReffNo + '|' + dataRecClassType);
                system.debug('==> loadNotificationRemarks.reffNo and REMARK_POS_CODE: ' + reffNo + '|' + REMARK_POS_CODE);
                if (dataRecReffNo == reffNo && dataRecClassType.trim() == REMARK_POS_CODE) {
                    system.debug('==> : loadNotificationRemarks.put temporary list: '+ dataRec.ReffNo + '|' + dataRec.assessmentClassType);
                    assessmentNotesRemarkListTemp.add(dataRec);
                }
            }
            system.debug('==> loadNotificationRemarks.assessmentNotesRemarkListTemp: ' + assessmentNotesRemarkListTemp);
        } catch(EIPConnector.NoDataException e){
            errMsgAssDtl = EIPConstant.OPERATION_NOTIF_REMARK + ':' + e.getMessage();
            System.debug('NoDataException in loadNotificationRemarks - '+e.getMessage());
        } catch(EIPConnector.EIPConnectorException e){
            errMsgAssDtl = EIPConstant.OPERATION_NOTIF_REMARK + ':' + e.getMessage();
            System.debug('EIPConnectorException in loadNotificationRemarks - '+e.getMessage());
        } catch (Exception e){
            errMsgAssDtl = EIPConstant.OPERATION_NOTIF_REMARK + ':' + EIPConstant.ERROR_MSG_UNKNOWN;
            System.debug('Exception in loadNotificationRemarks - '+e.getMessage());
        }
        assessmentNotesRemarkList.addAll(assessmentNotesRemarkListTemp);
    }
}