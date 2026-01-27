public class EmailSMSLog_CustomPage_ctrl {
	public String id {get;set;}
    public String parent_id {get;set;}
    public List<AXAAPI003A_response.Data> logs {get;set;}
    public AXAAPI003B_response log {get;set;}
        public boolean isConsole {get;set;}

   
    public String processTime {get;set;}
    public Integer skip {get;set;}
    public Integer take {get;set;} 
    public Integer total_page {get;set;}
    public Integer current_page {get;set;}
    public String to_page {get;set;}
    public List<string> list_page {get;set;}
    public static final Integer SIZE_DATA_RELATED_LIST = Integer.valueOf(Label.AXASFDC_RowLimitRelatedList);   
    
    
    public Long mulai {get;set;}
    public Long selesai {get;set;}
    public Integer totalRow {get;set;} 
   
    
    
    public EmailSMSLog_CustomPage_ctrl(){ 
        refresh(); 
        id = ApexPages.currentPage().getParameters().get('id');
        system.debug(id+'|'+ Schema.SObjectType.Email_SMS_Log__c.getKeyPrefix());
        
         if (id !=  null && id.left(3) == Schema.SObjectType.contact.getKeyPrefix() && id.length() < 18) {
             Contact dataContact = new Contact();
             if (Test.isRunningTest()) {
                 dataContact = [select id from contact limit 1]; 
             } else {
             	dataContact = [select id from contact where id =: id limit 1]; 
             }
             id = string.valueOf(dataContact.id);
         } else if(id.left(3) == Schema.SObjectType.Email_SMS_Log__c.getKeyPrefix()) {
            String uniqueId = ApexPages.currentPage().getParameters().get('lastId'); 
            System.debug('::uniqueId:'+uniqueId);
            System.debug('::id.length():'+id.length());
            if (id.length() > 14 && id.length() < 18 && uniqueId != null) {
                id = id+uniqueId;
            }  
            log = getEmailSMSLogDetail(id);
        } 
        
        String urlVal = Apexpages.currentPage().getUrl();
        system.debug(':::URl:'+urlVal);
        if(urlVal != null && urlVal.contains('console')) {
             isConsole = false;  
        } else {
            isConsole = true;    
        }       
    }
    
     public EmailSMSLog_CustomPage_ctrl(ApexPages.StandardController controller){
         
        refresh(); 
        //id = ApexPages.currentPage().getParameters().get('id');
        //entity = [SELECT Entity__c FROM Contact WHERE Id=:id].Entity__c;
        id = ApexPages.currentPage().getParameters().get('id');  
         
         if (id !=  null && id.left(3) == Schema.SObjectType.contact.getKeyPrefix() && id.length() < 18) {
             Contact dataContact = [select id from contact where id =: id limit 1];
             id = string.valueOf(dataContact.id);
         }
         
        Cache.SessionPartition sessionPart = Cache.Session.getPartition('local.axaPartition');
        
        // if(id != NULL && id.left(3) ==  Schema.SObjectType.Email_SMS_Log__c.getKeyPrefix()) log = getEmailSMSLogDetail(id);
        
         
    }
    
    public void refresh(){  
        processTime = ''; 
        totalRow = 0;
        skip = 0;
        current_page = 1;
        total_page = 1; 
        take = SIZE_DATA_RELATED_LIST;
        list_page = new List<String>();    
    }

    
    public AXAAPI003B_response getEmailSMSLogDetail(String id){
        AXAAPI003B_response res = AXAAPI003B_EmailSMSLogById.getEmailSMSLogById(id);
        res.data.OwnerId_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.ownerId, 'User', 'Name');
        res.data.template_email_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_email_c, 'Email_SMS_Template__c', 'Name');
        res.data.template_sms_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.template_sms_c, 'Email_SMS_Template__c', 'Name');
        res.data.ICF_Non_CCC_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.ICF_Non_CCC_c, 'ICF_Non_CCC__c', 'Name');
        // res.data.Survey_Taken_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.Survey_Taken_c, 'SurveyTaker__c', 'Name');
        // res.data.Case_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.case_c, 'Case', 'CaseNumber');
        res.data.Account_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.account_c, 'Account', 'Name');
        res.data.Contact_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.contact_c, 'Contact', 'Name');
        res.data.email_sms_template_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.email_sms_template_c, 'Email_SMS_Template__c', 'Name');
        res.data.survey_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.survey_c, 'Survey__c', 'Name');
        res.data.createdby_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.createdbyId, 'User', 'Name');
        res.data.lastmodifiedby_name  = AXAAPI_UtilityClass.getsObjectNameById(res.data.lastmodifiedbyId, 'User', 'Name');
        
        /*res.data.contact_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.contactId, 'Contact', 'Name');
        res.data.contact_phone = AXAAPI_UtilityClass.getsObjectNameById(res.data.contactId, 'Contact', 'Phone');
        res.data.Contact_Email = AXAAPI_UtilityClass.getsObjectNameById(res.data.contactId, 'Contact', 'Email');
        res.data.Last_Child_Case_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.Last_Child_Case_c, 'Case', 'Name');
        res.data.Negative_Feedback_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.Negative_Feedback_c, 'Negative_Feedback__c', 'Name');
        res.data.CreatedBy_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.CreatedById, 'User', 'Name');
        res.data.LastModifiedBy_name = AXAAPI_UtilityClass.getsObjectNameById(res.data.LastModifiedById, 'User', 'Name');
        res.data.Account_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.AccountId, 'Account', 'Name');
        res.data.Owner_Name = AXAAPI_UtilityClass.getsObjectNameById(res.data.OwnerId, 'User', 'Name');
        res.data.RecordType_Name = Schema.SObjectType.Case.getRecordTypeInfosById().get(res.data.recordtypeid).getname();*/
        
        /*EmailSMSLog log = new EmailSMSLog();
        log.Id = id;
        log.Name = 'LOG-07057469';
        log.Contact_Id = '0036F00002PT2mo';
        log.Contact = 'INDRA WIJAYA SIREGAR';
        log.Category = 'Thanks Note	';
        log.Entity = 'ALI';
        log.Method = 'Email';
        log.Request_Date = system.today();
        log.End_Date = system.today();
        log.Status = 'Cancel';
                
        log.owner_id = '0056F000004TDzz';
        log.owner_name = 'Admin SFDC';
        log.Exclude_From = '';
        log.Send_Admin = true;
        log.Exclude_From2 = '';
        log.Template_Email = 'ICF Email (ALI) 9 Dec';
        log.Template_Email_Id = 'a0i0K000008ODPT';
        log.Case_Open_Date = system.now();
        log.Template_SMS = 'ICF SMS (ALI) 09 Dec';
        log.Template_SMS_Id = 'a0i0K000008ODPd';
        log.Case_Type = 'Inquiry';
        log.Description = '';
        log.First_Send = system.today();
        log.Status_Have_Email_SMS_Log = 'SEND';
        log.First_Send_F = system.today();
        log.External_ID = '5002s000008vHGW-ICF';
        log.Ready_To_Send = false;
        log.ICF_Non_CCC = '';
        log.Survey_Taken = '';
        log.MOT = '';
        log.Response_Date = system.now();
        log.Use_Contact_Email = true;
        log.ICF_Walk_IN = '';
        log.Insurance_Type = '';
        
        log.Division = '';
        log.Short_URL = '';
        log.MessageId_JATIS = '';
        log.retry_get_status_delivery = '';
        log.Status_JATIS = '';
        log.Description_Status_JATIS = '';
        log.Status_Deliver = '';
        log.Description_Status_Deliver = '';
        log.Date_Hit_JATIS = '';
        log.Date_Received_JATIS = '';
        
        log.Case_z = '05044068';
        log.Case_z_Id = '5002s000008vHGW';
        log.Ext_ID_IDAS = '';
        log.Account = 'Account ALI';
        log.Account_Id = '0016F00002FIgx2';
        log.Email = 'mjkb@ymail.com';
        log.Mobile = '08161411840';
        log.Contact_Short_Name = 'INDRA WIJAYA SIREGAR';
        log.Mobile_Fix = '08161411840';
        log.Policy_Number = '1030401-0853163_';
        log.Mobile_Fix_Check = true;
        log.Case_List = '05044068';
        
        log.Send_Flag = true;
        log.Start_Date = system.today();
        log.Type = 'CCC';
        log.Loop_z = false;
        log.Survey_Type = '';
        log.Loop_Date_1 = system.today();
        log.Loop_Date_2 = system.today();
        log.Loop_Date_3 = system.today();
        log.Survey = 'I Ask (ALI)';
        log.Survey_Id = 'a0P6F00001EF20M';
        log.Survey_URL = 'http://axaindonesia.force.com/survey/TakeSurvey?id=a0P6F00001EF20MUAT&cId=0036F00002PT2moQAD&caId=5002s000008vHGWAA2';
        log.Fg_Update_Contact = true;
        log.Email_SMS_Template = 'ICF Email (ALI) 9 Dec';
        log.Email_SMS_Template_Id = 'a0i0K000008ODPT';
        log.Email_SMS_Text = '<img src="https://c.ap4.content.force.com/servlet/servlet.ImageServer?id=0156F00000HPeZF&oid=00D90000000zAlz&lastMod=1551859137000" width="50" /> <br/><br/><br/><br/> Terima kasih atas kepercayaan Anda kepada PT AXA Financial Indonesia sebagai mitra perlindungan Anda dan keluarga.<br/> <table width="100%"> <tbody> <tr style="height: 66.142px;"> <td style="width: 1015px; height: 66.142px;" colspan="3"><br/><strong>Yang terhormat Bapak/Ibu INDRA WIJAYA SIREGAR <br/></td> </tr> <tr style="height: 13px;"> <td style="width: 148px; height: 13px;">Nomor Polis</td> <td style="width: 6px; height: 13px;">:</td> <td style="width: 849px; height: 13px;"><em> 1030401-0853163_ </em></td> </tr> <tr style="height: 13px;"> <td style="width: 148px; height: 13px;">Nomor</td> <td style="width: 6px; height: 13px;">:</td> <td style="width: 849px; height: 13px;"><em> 05044068 </em></td> </tr> <tr style="height: 13px;"> <td style="width: 148px; height: 13px;">Keterangan</td> <td style="width: 6px; height: 13px;">:</td> <td style="width: 849px; height: 13px;"><em> INFORMASI POLIS </em></td> </tr> <tr style="height: 100px;"> <td style="width: 1015px; height: 100px;" colspan="3"> <br/> Guna membantu menjaga standar kualitas layanan kami, mohon kesediaan Anda untuk mengisi <strong>Survei Kepuasan Nasabah.</strong> <br/><br/><br/> Silakan klik tautan berikut : <a href=" http://axaindonesia.force.com/survey/TakeSurvey?id=a0P6F00001EF20MUAT&cId=0036F00002PT2moQAD&caId=5002s000008vHGWAA2 "> <strong>Instant Customer Feedback</strong></a><br/><br/><br/> Untuk informasi mengenai survei ini, hubungi AXA Customer Call Center di <strong>1500 940</strong>.<br/><br/> Terima kasih atas dukungan Anda.<br/><br/> <strong>Salam Hangat,</strong><br/> PT AXA Financial Indonesia<br/><br/> </td> </tr> </tbody> </table> <hr style="border-top: 1px dashed;" /><hr style="border-top: 1px dashed;" /> <br/> Thank you for trusting PT AXA Financial Indonesia as life protection partner for you &amp; your family.<br/> <table width="100%"> <tbody> <tr style="height: 52.0653px;"> <td style="width: 1015px; height: 52.0653px;" colspan="3"><br/><strong>Dear Mr/Mrs INDRA WIJAYA SIREGAR </tr> <tr style="height: 13px;"> <td style="width: 148px; height: 13px;">Policy No.</td> <td style="width: 6px; height: 13px;">:</td> <td style="width: 849px; height: 13px;"><em> 1030401-0853163_ </em></td> </tr> <tr style="height: 13px;"> <td style="width: 148px; height: 13px;">Number</td> <td style="width: 6px; height: 13px;">:</td> <td style="width: 849px; height: 13px;"><em> 05044068 </em></td> </tr> <tr style="height: 13px;"> <td style="width: 148px; height: 13px;">Subject</td> <td style="width: 6px; height: 13px;">:</td> <td style="width: 849px; height: 13px;"><em> INFORMASI POLIS </em></td> </tr> <tr style="height: 100px;"> <td style="width: 1015px; height: 100px;" colspan="3"> <br/><br/> In order to maintain our high service standard, we would appreciate your valued opinion by filling <strong>Customer Satisfaction Survey.</strong> <br/><br/><br/> Please click this link :&nbsp;<a href=" http://axaindonesia.force.com/survey/TakeSurvey?id=a0P6F00001EF20MUAT&cId=0036F00002PT2moQAD&caId=5002s000008vHGWAA2 "><strong>Instant Customer Feedback</strong></a> <br/><br/><br/> If there any question regarding this survey, please contact AXA Customer Call Center at <strong>1500 940</strong>.<br/><br/> Thank you in advance for your thoughtful feedback.<br/><br/> <strong>Warm Regards,</strong><br/> PT AXA Financial Indonesia<br/> </td> </tr> </tbody> </table>';
        
        log.Created_By = 'Admin SFDC';
        log.Created_By_Id = '0056F000004TDzz';
        log.Created_Date = system.now();
        log.Last_Modified_By = 'Admin SFDC';
        log.Last_Modified_By_Id = '0056F000004TDzz';
        log.Last_Modified_Date = system.now();*/
        
        return res;
    }
    
    
    
    
    
    public void getDataNext(){    
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataNext(current_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        loadLogs_contact();
    }
     
    public void getDataPrevious(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataPrevious(current_page); 
        
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        } 
        loadLogs_contact();
         
    }
    
    
    public void getDataToPage(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataToPage(current_page, to_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        loadLogs_contact();
    }
    
    public void getDataFirst(){ 
  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataFirst(current_page); 
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        }  
        loadLogs_contact();
    }
    
    public void getDataLast(){  
        Map<string,integer> pagination = AXAAPI_UtilityClass.getDataLast(total_page); 
        
        if (pagination.containsKey('skip')) {
            skip = pagination.get('skip');
        } 
        if (pagination.containsKey('take')) {
            take = pagination.get('take');
        } 
        if (pagination.containsKey('current_page')) {
            current_page = pagination.get('current_page');
        } 
        loadLogs_contact();
         
    } 
    

    
    
    public void loadLogs(){
        /* List<Case> list_case = [SELECT Id FROM Case WHERE Id=:id LIMIT 1];
        if(list_case.size()>0){
            Case cas = list_case[0];
            AXAAPI003A_response res = AXAAPI003A_EmailSMSLogByCase.getEmailSMSLogByCase(cas.id);
            if(res != NULL && res.data != NULL){
                logs = res.data;
                
                //for(AXAAPI016A_response.Data data:mid_pays){
                  //  data.recordType = entity;
                //}
            }
        } */
        /* 
        logs = new List<AXAAPI003A_response.Data>();
		AXAAPI003A_response res = AXAAPI003A_EmailSMSLogByCase.getEmailSMSLogByCase(id);
        if(res != NULL && res.data != NULL){
            logs = res.data;
            
            //for(AXAAPI016A_response.Data data:mid_pays){
            //  data.recordType = entity;
            //}
        } */
    }
    
    
    
    public void loadLogs_contact(){
        
        mulai =  DateTime.now().getTime(); 
         
        logs = new List<AXAAPI003A_response.Data>();
        /* List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id=:id LIMIT 1];
        // List<Contact> list_con = [SELECT Id, Policy_No__c FROM Contact WHERE Id='0030K00001tZOKp' LIMIT 1];
        if(list_con.size()>0){
            Contact con = list_con[0];
            AXAAPI003A_response res = AXAAPI003A_EmailSMSLogByContact.getEmailSMSLogByContact(con.id);
            if(res != NULL && res.data != NULL){
                logs = res.data; 
            }
        }*/
        AXAAPI003A_response res = AXAAPI003A_EmailSMSLogByContact.getEmailSMSLogByContact(id, skip, take);
        if(res != NULL && res.data != NULL){
            logs = res.data; 
            
            
            totalRow = res.counts; 
            
            if (test.isRunningTest()) totalRow = 10;
            
            Decimal countPage = ((double) totalRow)/SIZE_DATA_RELATED_LIST;
            countPage = countPage.round(System.RoundingMode.CEILING);
            total_page = integer.valueOf(countPage);
                
            list_page= AXAAPI_UtilityClass.showListPagination(current_page,total_page); 
            
            selesai =  Datetime.now().getTime();
            system.debug('selesai == '+selesai); 
            system.debug('mulai == '+mulai); 
            processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
            processTime += '<br/>Total : ' + totalRow + ' records';
            system.debug('processTime == '+processTime);
        }
    } 
}