trigger caseBeforeUpdate on Case (before update, before insert) {
    //User userObj = [select id, Entity__c from user where id = :UserInfo.getUserId()];
    User userObj = UserUtil.getCurrentUser();
    string entity = userObj.Entity__c;
    Map<id,RecordType> recordTypeMap = new Map<id,RecordType>([SELECT id,Name FROM RecordType where SObjectType = 'Case' and IsActive = true]);
    string caseType = null;
    string recTypeId = null;
    string recTypeId2 = null;
    string recTypeId3 = null;
    string recTypeId4 = null;
    Map<string,string> recTypeIdMap = new Map<string,string>();
    Map<string,string> recTypeMap = new Map<string,string>();
    RecordType rec = null;
    //Map<string,PIC_Department__c> picMap = new Map<string,PIC_Department__c>([select id, Email__c from PIC_Department__c]);
    String spvCMU;
    String assManager;
    String manager;
    String ceo;
    String claimHead;
    String cmu;
    String coo;
    String CO_Head;
    String collectionMgr;
    String custService;
    String deputyCOO;
    String emailSpv;
    String financeHead;
    String financialController;
    String hoo;
    String inboundSPV;
    String nbuwMgr;
    String outboundSPV;
    String oprSuppHead;
    String picClaim;
    String pic_CMU;
    String pic_CO;
    String pic_Collection;
    String pic_Finance;
    String pic_Sales;
    String posMgr;
    String requestMgr;
    String seniorMgr;
    String sales_DistrHead;
    String underwritingMgr;
    String walkIn_SPV;
    Map<String,UserRole> roleMap = new Map<String,UserRole>();
    
    //system.debug('## populate all case record types..');
    for(id recid : recordTypeMap.keySet()){
        rec = recordTypeMap.get(recid);
        recTypeIdMap.put(rec.Name, recid);
        //system.debug('## record type : '+rec.Name);
        recTypeMap.put(recid,rec.Name);
    }    
    
    // change by Ranti
    /* List<UserRole> roleList = [SELECT Id, Name FROM UserRole WHERE not Name like '%Agent%'];
    for(UserRole uRole: roleList){
        if(!roleMap.containsKey(uRole.Name)){
            roleMap.put(uRole.Name, uRole);
        }
    }
    
    
    List<User> userList = [SELECT Id, Name, UserRoleId, UserRole.name FROM User WHERE UserRole.name in :roleMap.keySet()]; */
     List<Config__c> configList = [select id, name, value__c from Config__c];
    //List<User> requestManagerUsers = [select id, name, entity__c from user where UserRole.Name = 'Request_Manager'];

    //List<User> cmuUsers = [select id, name, entity__c from user where UserRole.Name = 'CMU'];
    
    
    /** UPDATED, 15 Feb 2020 **/
    Set<Id> caseID = new Set<Id>();
    Map<Id, String> recordtypeCase = new Map<Id, String>();
    List<DateTime> l_createdDate = new List<DateTime>();
    List<EmailMessage> emailMessageList = new List<EmailMessage>();
    Map<String, String> mapMasterHoliday = new Map<String, String>();
    List<Master_Holiday__c> l_MasterHoliday = new List<Master_Holiday__c>();
    List<String> l_EmailTemplateID = new List<String>();
    Map<String, Email_SMS_Template__c> mapEmailTemplateDetail = new Map<String, Email_SMS_Template__c>();
    Map<String, Master_Holiday__c> map_MasterHolidayDetail = new Map<String, Master_Holiday__c>();
    Map<Id, Case> mapCase = new Map<Id, Case>();
    List<Case> l_case = new List<Case>();
    
    String nature = '';
    String category = '';
    String entityCase = '';
    
    for(Case cs : trigger.new){
        nature = cs.Nature_Config__c;
        category = cs.Category_Config__c;
        entityCase = cs.Entity_Backup__c;
        
        // updated by Ranti at 11/24/2021
        if (cs.Id != null) caseID.add(cs.Id);
        
        recordtypeCase.put(cs.Id, cs.RecordType.Name);
        l_createdDate.add(cs.CreatedDate);
    }
    system.debug('nature: ' + nature);
    system.debug('category: ' + category);
    system.debug('entityCase: ' + entityCase);
    system.debug('l_createdDate: ' + l_createdDate);
    
    // updated by Ranti  at 11/24/2021
    // List<Case> l_case_origin = [SELECT Id, CaseNumber, Type, Origin, Entity_Backup__c, RecordType.Name, Email_Text_Holiday_Weekend__c, Email_Inbox__c FROM Case WHERE Id =: caseID /*AND Origin = 'Email'*/ AND (RecordType.Name = 'InquiryAFICase' OR RecordType.Name = 'InquiryALICase')];
    List<Case> l_case_origin = new List<Case>();  
    system.debug('Case Id:'+caseID);
    if (caseID.size() > 0) {
        l_case_origin = [SELECT Id, CaseNumber, Type, Origin, Entity_Backup__c, RecordType.Name, Email_Text_Holiday_Weekend__c, Email_Inbox__c, ContactId, Contact.Name FROM Case WHERE Id =: caseID /*AND Origin = 'Email'*/ AND (RecordType.Name = 'InquiryAFICase' OR RecordType.Name = 'InquiryALICase')];        
    } 
    
    system.debug('l_case_origin: ' + l_case_origin);
    
    /*for(Case c : l_case_origin){
        if((c.Entity_Backup__c == 'AFI' || c.Entity_Backup__c == 'ALI') && c.Origin == 'Email'){
            l_case_origin.add(c);
        }
    }
    system.debug('l_case_origin (AFTER): ' + l_case_origin);*/
    
    List<String> holidayList = new List<String>();
    
    //vvvvv CASE ORIGIN = EMAIL && (CASE RECORDTYPE = 'InquiryAFICase' || CASE RECORDTYPE = 'InquiryALICASE') vvvvv
    if(l_case_origin.size() > 0){
        //QUERY EMAIL MESSAGE
        emailMessageList = [SELECT Id, ReplyToEmailMessageId, ParentId, ToAddress, CcAddress, BccAddress, FromAddress, MessageDate, First_Response_Date_In_Datetime__c, Last_Response_Date__c, InComing, Subject, Agent_Queue_ID__c, Reason__c FROM EmailMessage WHERE ParentId IN: l_case_origin ORDER BY CreatedDate DESC LIMIT 1];
        //  emailMessageList = [SELECT Id, ReplyToEmailMessageId, ParentId, ToAddress, CcAddress, BccAddress, FromAddress, MessageDate, First_Response_Date_In_Datetime__c, Last_Response_Date__c, InComing, Subject, Agent_Queue_ID__c, Reason__c FROM EmailMessage WHERE ParentId IN: caseID ORDER BY CreatedDate DESC LIMIT 1];
        system.debug('emailMessageList: '+emailMessageList);
        
        //QUERY MASTER HOLIDAY
        List<Master_Holiday__c> l_master_holiday = [SELECT Id, Name, Type__c, Entity__c, Service_Type__c, Start_Date_Time__c, Start_Date_F__c, End_Date_Time__c, End_Date_F__c, Calculate_Range_Date__c, Active_Date__c, Active_Date_F__c, Description_ID__c, Description_EN__c, Email_SMS_Template__c, Month_ID_Start_Date__c, Month_ID_End_Date__c, Month_ID_Active_Date__c, Email_Header__c, Email_Body__c, Email_Footer__c FROM Master_Holiday__c /*WHERE (Start_Date_Time__c <=: l_createdDate AND End_Date_Time__c >=: l_createdDate)*/ ORDER BY Type__c DESC];
        system.debug('l_master_holiday: '+l_master_holiday);
        
        // added by ranti at 11/04/2021 set validation
        if (emailMessageList.size() > 0) {
            for(Case cs : l_case_origin){
                for(EmailMessage em : emailMessageList){
                    if(l_master_holiday.size() > 0){
                        for(Master_Holiday__c mh : l_master_holiday){
                            system.debug('em.ToAddress: '+em.ToAddress);
                            system.debug('em.CcAddress: '+em.CcAddress);
                            system.debug('em.BccAddress: '+em.BccAddress);
                            if(!String.IsEmpty(em.ToAddress)){
                                if((em.ToAddress.contains(system.Label.CustomerEmail_AFI_ALI) || em.ToAddress.contains(system.Label.NoReplyEmail_AFI_ALI) || cs.Email_Inbox__c == system.Label.CustomerEmail_AFI_ALI || cs.Email_Inbox__c == system.Label.NoReplyEmail_AFI_ALI)){
                                    if(mh.Service_Type__c == 'Customer AFI'){
                                        system.debug('===== CUSTOMER AFI =====');
                                        if(mh.Start_Date_Time__c <= em.MessageDate && mh.End_Date_Time__c >= em.MessageDate){
                                            if(mh.Type__c == 'Holiday' && mh.Entity__c == 'AFI'){
                                                system.debug('HOLIDAY - AFI - CUSTOMER AFI');
                                                mapMasterHoliday.put(em.ParentId, mh.Email_SMS_Template__c);
                                                l_MasterHoliday.add(mh);
                                                l_EmailTemplateID.add(mh.Email_SMS_Template__c);
                                                map_MasterHolidayDetail.put(em.ParentId, mh);
                                                break;
                                            } else if(mh.Type__c == 'Event' && mh.Entity__c == 'AFI'){
                                                system.debug('EVENT - AFI - CUSTOMER AFI');
                                                mapMasterHoliday.put(em.ParentId, mh.Email_SMS_Template__c);
                                                l_MasterHoliday.add(mh);
                                                l_EmailTemplateID.add(mh.Email_SMS_Template__c);
                                                map_MasterHolidayDetail.put(em.ParentId, mh);
                                                break;
                                            }
                                        } else {
                                            if(mh.Type__c == 'Weekday' || mh.Type__c == 'Weekend'){
                                                system.debug('WEEKDAY/WEEKEND CUSTOMER AFI 1');
                                                mapMasterHoliday.put(em.ParentId, System.Label.Weekday_Template_ID_Nasabah);
                                                l_MasterHoliday.add(mh);
                                                l_EmailTemplateID.add(System.Label.Weekday_Template_ID_Nasabah);
                                                map_MasterHolidayDetail.put(em.ParentId, mh);
                                            }
                                            
                                        }
                                    } /*else {
                                        if(mh.Type__c == 'Weekday' || mh.Type__c == 'Weekend'){
                                            system.debug('WEEKDAY/WEEKEND CUSTOMER AFI 2');
                                            mapMasterHoliday.put(em.ParentId, System.Label.Weekday_Template_ID_Nasabah);
                                            l_MasterHoliday.add(mh);
                                            l_EmailTemplateID.add(System.Label.Weekday_Template_ID_Nasabah);
                                            map_MasterHolidayDetail.put(em.ParentId, mh);
                                        }
                                    }*/
                                } else if(em.ToAddress.contains(system.Label.HelplineEmail_AFI_ALI) || cs.Email_Inbox__c == system.Label.HelplineEmail_AFI_ALI){
                                    if(mh.Service_Type__c == 'Helpline'){
                                        system.debug('===== HELPLINE =====');
                                        if(mh.Start_Date_Time__c <= em.MessageDate && mh.End_Date_Time__c >= em.MessageDate){
                                            if(mh.Type__c == 'Holiday' && mh.Entity__c == 'AFI'){
                                                system.debug('HOLIDAY - AFI - HELPLINE');
                                                mapMasterHoliday.put(em.ParentId, mh.Email_SMS_Template__c);
                                                l_MasterHoliday.add(mh);
                                                l_EmailTemplateID.add(mh.Email_SMS_Template__c);
                                                break;
                                            } else if(mh.Type__c == 'Event' && mh.Entity__c == 'AFI'){
                                                system.debug('EVENT - AFI - HELPLINE');
                                                mapMasterHoliday.put(em.ParentId, mh.Email_SMS_Template__c);
                                                l_MasterHoliday.add(mh);
                                                l_EmailTemplateID.add(mh.Email_SMS_Template__c);
                                                break;
                                            }
                                        } else {
                                            if(mh.Type__c == 'Weekday' || mh.Type__c == 'Weekend'){
                                                system.debug('WEEKDAY/WEEKEND HELPLINE 3');
                                                mapMasterHoliday.put(em.ParentId, System.Label.Weekday_Template_ID_Helpline);
                                                l_MasterHoliday.add(mh);
                                                l_EmailTemplateID.add(System.Label.Weekday_Template_ID_Helpline);
                                                map_MasterHolidayDetail.put(em.ParentId, mh);
                                            }
                                        }
                                    } /*else {
                                        if(mh.Type__c == 'Weekday' || mh.Type__c == 'Weekend'){
                                            system.debug('WEEKDAY/WEEKEND HELPLINE 4');
                                            mapMasterHoliday.put(em.ParentId, System.Label.Weekday_Template_ID_Helpline);
                                            l_MasterHoliday.add(mh);
                                            l_EmailTemplateID.add(System.Label.Weekday_Template_ID_Helpline);
                                            map_MasterHolidayDetail.put(em.ParentId, mh);
                                        }
                                    }*/
                                }
                            }
                        }
                    }
                    system.debug('mapMasterHoliday: '+mapMasterHoliday);
                    system.debug('l_MasterHoliday: '+l_MasterHoliday);
                    system.debug('l_EmailTemplateID: '+l_EmailTemplateID);
                    system.debug('map_MasterHolidayDetail: '+map_MasterHolidayDetail);
                }
            }
        }
    }
    
    //QUERY EMAIL TEMPLATE
    /*List<Email_SMS_Template__c> l_est = [SELECT Id, Name, Email_Body__c, Email_Header__c, Email_Footer__c FROM Email_SMS_Template__c WHERE Id =: l_EmailTemplateID];
    system.debug('LIST EMAIL TEMPLATE: '+l_est);
    
    for(Email_SMS_Template__c est : l_est){
        mapEmailTemplateDetail.put(est.Id, est);
    }
    system.debug('mapEmailTemplateDetail: '+mapEmailTemplateDetail);*/

    /** END - UPDATED, 15 Feb 2020 **/
    
    
    system.debug('## set record type of incoming cases..');
    string rt = null;
    for(Case cs : trigger.new){ 
        system.debug('## case origin : '+cs.origin);
        //if((cs.origin == null || cs.origin == 'Email') && (cs.type == '' || cs.type == null)){
            //cs.type = 'Inquiry';
            //cs.origin = 'Email';
            //system.debug('## case type : '+cs.type);
        //}   
        system.debug('## case RECORDTYPEID : '+cs.recordtypeid);
        system.debug('## case type : '+cs.type);
        caseType = cs.type ;    
        recTypeId = recTypeIdMap.get(caseType+'Case');  //get('InquiryCase'); get('RequestCase'); get('ComplaintCase')
        recTypeId2 = recTypeIdMap.get('AFI'+caseType+'CaseNewButton');  //get('AFIComplaintCaseNewButton'), added by Hamfry (04-07-2015)
        recTypeId3 = recTypeIdMap.get('AMFS'+caseType+'CaseNewButton');  //get('AFIComplaintCaseNewButton'), added by Hamfry
        recTypeId4 = recTypeIdMap.get('MAGI'+caseType+'CaseNewButton');  //get('MAGIComplaintCaseNewButton'), added by Hamfry (04-07-2015)
        system.debug('## case record type : '+caseType+'Case');
        if(cs.recordtypeid!=null){
            rt = recTypeMap.get(cs.recordtypeid);
            if(rt.contains('Inquiry') ){
                // FCR Change Request 2017 - jika ada parent, bukan FCR.
                if (cs.ParentId != NULL) cs.FCR__c = FALSE;
                else cs.FCR__c = true;
            } else {
                cs.FCR__c = false;
            }
            
            //if(rt.contains('Inquiry') && cs.origin != 'Email'){
            //    cs.status = 'Closed';
            //} 
        }
        //cs.recordtypeid = recTypeId;
        
        system.debug(' cs.Entity__c :' + cs.Entity__c) ;
        system.debug(' cs.Entity_Backup__c :' + cs.Entity_Backup__c) ;
                    
        //-----The following logic is added by Hamfry (04-07-2015)
        if((cs.entity__c == 'AFI') && (cs.BOD_Type__c == 'Level 1' || cs.BOD_Type__c == 'Level 2' || cs.BOD_Type__c == 'Level 3') && cs.IsApproved__c == true){
            cs.recordtypeid = recTypeId2;
        }
        else if((cs.entity__c == 'AMFS') && (cs.BOD_Type__c == 'Level 1' || cs.BOD_Type__c == 'Level 2' || cs.BOD_Type__c == 'Level 3') && cs.IsApproved__c == true){
            cs.recordtypeid = recTypeId3;
        }
        else if(cs.entity__c == 'MAGI' && (cs.BOD_Type__c == 'Level 1' || cs.BOD_Type__c == 'Level 2' || cs.BOD_Type__c == 'Level 3') && cs.IsApproved__c == true){
            cs.recordtypeid = recTypeId4;
        }
        //---- End of logic added by Hamfry
         
        //if(cs.status == 'Escalated'){
            //cs.Request_Manager_Email__c = requestManagerUsers[0].email;
        //}
        /* 
        if(cs.PIC_Department__c != null){
            cs.PIC_Department_Email__c = picMap.get(cs.PIC_Department__c).Email__c;
        }
        */
        if(cs.Entity_Backup__c=='' || cs.Entity_Backup__c==null){
            cs.Entity_Backup__c=entity;
        }
        //Added by Hamfry
        if (cs.OwnerId != null && cs.Type == 'Complaint') {
            system.debug('Start setting up up-level roles....');
            setRoles(cs.Entity_Backup__c);
            
            cs.Assistant_Manager__c = assManager;
            //cs.CEO__c = ceo;
            cs.Central_Operation_Head__c = CO_Head;
            cs.Claim_Head__c = claimHead;
            cs.Collection_Manager__c = collectionMgr;
            cs.CMU__c = cmu;
            cs.Customer_Service__c = custService;
            cs.Deputy_COO__c = deputyCOO;
            cs.Email_SPV__c = emailSpv;
            cs.Finance_Head__c = financeHead;
            cs.Inbound_SPV__c = inboundSPV;
            cs.Manager__c = manager;
            cs.Operation_Support_Head__c = oprSuppHead;
            cs.Dept_Head__c = oprSuppHead; //Disamain dgn Operation Support Head
            cs.Outbound_SPV__c = outboundSPV;
            cs.PIC_Claim__c = picClaim;
            cs.PIC_CMU__c = pic_CMU;
            cs.PIC_CO__c = pic_CO;
            cs.PIC_Collection__c = pic_Collection;
            cs.PIC_Finance__c = pic_Finance;
            cs.PIC_Sales__c = pic_Sales;
            cs.Request_Manager__c = requestMgr;
            cs.Senior_Manager__c = seniorMgr;
            cs.Sales_Distribution_Head__c = sales_DistrHead;
            cs.Supervisor__c = spvCMU;
            cs.Underwriting_Manager__c = underwritingMgr;
            cs.Walk_In_SPV__c = walkIn_SPV;
            //add by MII for ICF (October 2024)
            cs.MOT__c = 'I Complain';
        } 
        
        
        /// TAMBAH UNTUK CHS AUTO ASSIGMENT ///
        

        // ** CHS AUTO ASSIGNMENT ** //
        List<Skill_of_Nature_Category__c> skillList = new List<Skill_of_Nature_Category__c>();

        String nature = cs.Nature_Config__c;
        String category = cs.Category_Config__c;
        String entityCase = cs.Entity_Backup__c; //cs.Entity__c;
        
        String skillName = '';
        Decimal lastOrderNo = 0;
        
        system.debug(' nature :' + nature) ;
        system.debug(' category :' + category) ;
        system.debug(' entityCase :' + entityCase) ;
        
        system.debug(' cs.Entity__c :' + cs.Entity__c) ;
        system.debug(' cs.Entity_Backup__c :' + cs.Entity_Backup__c) ;
                    
        boolean nextOrder=true;
                  
        if (Trigger.isUpdate) {  
            Case old = Trigger.oldMap.get(cs.Id);
            if ( cs.get('Nature_Config__c') != old.get('Nature_Config__c') || cs.get('Category_Config__c') != old.get('Category_Config__c')  ) {
                nextOrder = true;
                
                system.debug(' aaa :' + cs.get('Nature_Config__c')) ;
                system.debug(' abcd :' + old.get('Nature_Config__c'));
                system.debug(' abcd :' + cs.get('Category_Config__c'));
                system.debug(' abcd :' + old.get('Category_Config__c')  ) ;
                    
            } else nextOrder = false;
            
            
            /** UPDATED, 15 Feb 2020 **/
            
            //============================================================================
            //                              SET EMAIL TEMPLATE
            //============================================================================
            
            //Email_SMS_Template__c est = new Email_SMS_Template__c();
            Master_Holiday__c mholiday = new Master_Holiday__c();
            
            String text;
            String text2;
            String Header='';
            String Body='';
            String Footer='';
            Boolean isHoliday = FALSE;
            Boolean isEvent = FALSE;
            //Decimal RangeDateHolidayEvent = 0;
            //DateTime EndDateHolidayEvent;
            
            
            for(Master_Holiday__c holiday : l_MasterHoliday){
                for(Case cs_origin : l_case_origin){
                    mholiday = map_MasterHolidayDetail.get(cs_origin.Id);
                    
                    /*est = mapEmailTemplateDetail.get(mapMasterHoliday.get(cs_origin.Id));
                    system.debug('====== est: '+ est);
                    
                    if(est.Email_Header__c!=null) Header = est.Email_Header__c;
                    if(est.Email_Body__c!=null) Body = est.Email_Body__c;
                    if(est.Email_Footer__c!=null) Footer = est.Email_Footer__c;*/    

                    
                    if(holiday.Email_Header__c != null) Header = holiday.Email_Header__c;
                    if(holiday.Email_Body__c != null) Body = holiday.Email_Body__c;
                    if(holiday.Email_Footer__c != null) Footer = holiday.Email_Footer__c;
                    text = Header + ' ' + Body + ' ' + Footer;
                    List<String> result = new List<String>();
                    if(text != null && text != '') result = text.split('\\s');
                    
                    system.debug('======Header: '+ Header);
                    system.debug('======Body: '+ Body);
                    system.debug('======Footer: '+ Footer);
                    system.debug('======Text: '+ text);
                    system.debug('======result: '+ result);
                    
                    //String contactName = cs_origin.Contact.Name;
                    
                    IF(RESULT.size() > 0){
                        for(String r : result){
                            if(text2 == null){
                                System.debug('holiday >>> '+holiday);
                                if(r == '[CONTACT_NAME]' || r.contains('[CONTACT_NAME]') == true){ text2 = cs_origin.Contact.Name; }
                                else if(r == '[DESCRIPTION_ID]' || r.contains('[DESCRIPTION_ID]')== true){ text2 = holiday.Description_ID__c; }
                                else if(r == '[DESCRIPTION_EN]' || r.contains('[DESCRIPTION_EN]')== true){ text2 = holiday.Description_EN__c; }
                                else if(r == '[START_DATE_ID]' || r.contains('[START_DATE_ID]' )== true){
                                    String dayId_startDate = String.valueOf(Date.valueOf(holiday.Start_Date_F__c).day());
                                    String monthId_startDate = holiday.Month_ID_Start_Date__c;
                                    String yearId_startDate = String.valueOf(Date.valueOf(holiday.Start_Date_F__c).year());
                                    text2 = dayId_startDate + ' ' + monthId_startDate + ' ' + yearId_startDate;
                                }
                                else if(r == '[START_DATE_EN]' || r.contains('[START_DATE_EN]' )== true){
                                    DateTime StartDateEN = Datetime.newInstance(holiday.Start_Date_F__c.year(), holiday.Start_Date_F__c.month(), holiday.Start_Date_F__c.day());
                                    text2 = StartDateEN.format('MMMM dd, YYYY');
                                }
                                else if(r == '[END_DATE_ID]' || r.contains('[END_DATE_ID]' )== true){
                                    String dayId_endDate = String.valueOf(Date.valueOf(holiday.End_Date_F__c).day());
                                    String monthId_endDate = holiday.Month_ID_End_Date__c;
                                    String yearId_endDate = String.valueOf(Date.valueOf(holiday.End_Date_F__c).year());
                                    text2 = dayId_endDate + ' ' + monthId_endDate + ' ' + yearId_endDate;
                                }
                                else if(r == '[END_DATE_EN]' || r.contains('[END_DATE_EN]' )== true){
                                    DateTime EndDateEN = Datetime.newInstance(holiday.End_Date_F__c.year(), holiday.End_Date_F__c.month(), holiday.End_Date_F__c.day());
                                    text2 = EndDateEN.format('MMMM dd, YYYY');
                                }
                                else if(r == '[ACTIVE_DATE_ID]' || r.contains('[ACTIVE_DATE_ID]') == true){
                                    String dayId_activeDate = String.valueOf(holiday.Active_Date__c.day());
                                    String monthId_activeDate = holiday.Month_ID_Active_Date__c ;
                                    String yearId_activeDate = String.valueOf(holiday.Active_Date__c.year());
                                    text2 = dayId_activeDate + ' ' + monthId_activeDate + ' ' + yearId_activeDate;
                                }
                                else if(r == '[ACTIVE_DATE_EN]' || r.contains('[ACTIVE_DATE_EN]') == true){
                                    DateTime ActiveDateEN = Datetime.newInstance(holiday.Active_Date_F__c.year(), holiday.Active_Date_F__c.month(), holiday.Active_Date_F__c.day());
                                    text2 = ActiveDateEN.format('MMMM dd, YYYY');
                                }
                                else{
                                    text2 = r;
                                }
                            }
                            else{
                                if(r == '[CONTACT_NAME]' || r.contains('[CONTACT_NAME]') == true){
                                    text2 = text2+' ' +cs_origin.Contact.Name;
                                }
                                else if(r == '[DESCRIPTION_ID]' || r.contains('[DESCRIPTION_ID]')== true){
                                    text2 = text2+' ' +holiday.Description_ID__c;
                                }
                                else if(r == '[DESCRIPTION_EN]' || r.contains('[DESCRIPTION_EN]')== true){
                                    text2 = text2+' ' +holiday.Description_EN__c;
                                }
                                else if(r == '[START_DATE_ID]' || r.contains('[START_DATE_ID]' )== true){
                                    String dayId_startDate = String.valueOf(Date.valueOf(holiday.Start_Date_F__c).day());
                                    String monthId_startDate = holiday.Month_ID_Start_Date__c;
                                    String yearId_startDate = String.valueOf(Date.valueOf(holiday.Start_Date_F__c).year());
                                    text2 = text2+' ' +dayId_startDate + ' ' + monthId_startDate + ' ' + yearId_startDate;
                                }
                                else if(r == '[START_DATE_EN]' || r.contains('[START_DATE_EN]' )== true){
                                    DateTime StartDateEN = Datetime.newInstance(holiday.Start_Date_F__c.year(), holiday.Start_Date_F__c.month(), holiday.Start_Date_F__c.day());
                                    text2 = text2+' ' +StartDateEN.format('MMMM dd, YYYY');
                                }
                                else if(r == '[END_DATE_ID]' || r.contains('[END_DATE_ID]' )== true){
                                    String dayId_endDate = String.valueOf(Date.valueOf(holiday.End_Date_F__c).day());
                                    String monthId_endDate = holiday.Month_ID_End_Date__c;
                                    String yearId_endDate = String.valueOf(Date.valueOf(holiday.End_Date_F__c).year());
                                    text2 = text2+' ' +dayId_endDate + ' ' + monthId_endDate + ' ' + yearId_endDate;
                                }
                                else if(r == '[END_DATE_EN]' || r.contains('[END_DATE_EN]' )== true){
                                    DateTime EndDateEN = Datetime.newInstance(holiday.End_Date_F__c.year(), holiday.End_Date_F__c.month(), holiday.End_Date_F__c.day());
                                    text2 = text2+' ' +EndDateEN.format('MMMM dd, YYYY');
                                }
                                else if(r == '[ACTIVE_DATE_ID]' || r.contains('[ACTIVE_DATE_ID]') == true){
                                    String dayId_activeDate = String.valueOf(holiday.Active_Date__c.day());
                                    String monthId_activeDate = holiday.Month_ID_Active_Date__c ;
                                    String yearId_activeDate = String.valueOf(holiday.Active_Date__c.year());
                                    text2 = text2+' ' +dayId_activeDate + ' ' + monthId_activeDate + ' ' + yearId_activeDate;
                                }
                                else if(r == '[ACTIVE_DATE_EN]' || r.contains('[ACTIVE_DATE_EN]') == true){
                                    DateTime ActiveDateEN = Datetime.newInstance(holiday.Active_Date_F__c.year(), holiday.Active_Date_F__c.month(), holiday.Active_Date_F__c.day());
                                    text2 = text2+' ' +ActiveDateEN.format('MMMM dd, YYYY');
                                }                                
                                else{
                                    text2 = text2+' ' +r;
                                }
                                
                            }
                        }    
                    }
                    
                    /*if(text2 != null){
                        cs_origin.Email_Text_Holiday_Weekend__c = text2;
                        //RangeDateHolidayEvent = holiday.Calculate_Range_Date__c;
                    }*/
                    
                    if(holiday.Type__c == 'Holiday'){
                        isHoliday = TRUE;
                    }
                    if(holiday.Type__c == 'Event'){
                        isEvent = TRUE;
                    }
                    
                    /*if(holiday.Calculate_Range_Date__c != null){
                        RangeDateHolidayEvent = holiday.Calculate_Range_Date__c;
                    }
                    
                    if(holiday.End_Date_Time__c != null){
                        EndDateHolidayEvent = holiday.End_Date_Time__c;
                    }*/
                    
                    system.debug('Email_Text_Holiday_Weekend__c (HOLIDAY): '+ cs_origin.Email_Text_Holiday_Weekend__c);
                    //system.debug('Range Date Holiday/Event: '+ RangeDateHolidayEvent);
                }
            }
            //============================================================================
            //                            END - SET EMAIL TEMPLATE
            //============================================================================
            
            system.debug('----emailMessageList: '+emailMessageList);
            system.debug('----cs.Origin: '+cs.Origin);
            system.debug('----cs.First_Case_Origin__c: '+cs.First_Case_Origin__c);
            for(EmailMessage em : emailMessageList){
                if(em.Subject != '' && em.Subject != null){
                    system.debug('----Ada Subject----');
                    system.debug('----mapCase.containsKey: '+mapCase.containsKey(em.ParentId));
                    system.debug('----em.Subject: '+em.Subject.substring(0,3));
                    system.debug('----cs.Contact.Entity__c: '+cs.Contact.Entity__c);
                    if(cs.Assignment_Rules__c == FALSE /*&& (cs.First_Queue__c == null || cs.First_Queue__c == '')*/ ){
                    //if(em.Subject.substring(0,3) != 'RE:'){
                        system.debug('----SUBJECT BUKAN RE----');
                        //Case cs_email = mapCase.get(em.ParentId);
                        //system.debug('----cs_email 1: '+cs_email);
                        //cs.No_Need_To_Reply_New__c = FALSE;
                        cs.First_Case_Origin__c = cs.Origin;
                        if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null){
                            cs.Email_Text_Holiday_Weekend__c = text2;
                            
                            if(isHoliday == TRUE){
                                cs.isHoliday__c = TRUE;
                            }
                            if(isEvent == TRUE){
                                cs.isEvent__c = TRUE;
                            }
                        }
                        
                        //Update, 11 Maret 2020
                        String ownerText = string.valueOf(cs.OwnerId);
                        system.debug('ownerText: '+ownerText);
                        
                        if(ownerText.substring(0,3) == '00G' && (cs.First_Queue_ID__c == null || cs.First_Queue_ID__c == '')){
                            cs.First_Queue_ID__c = cs.OwnerId;
                            cs.Update_First_Queue__c = TRUE;
                        }
                        //Update, 11 Maret 2020
                        
                        break;
                        /*if(RangeDateHolidayEvent != null){
                            cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                        }
                        if(EndDateHolidayEvent != null){
                            cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                        }
                        system.debug('cs.Range_Date_Holiday_Event__c (1): '+cs.Range_Date_Holiday_Event__c);
                        system.debug('cs.End_Date_Holiday_Event__c (1): '+cs.End_Date_Holiday_Event__c);*/
                        
                        //em.Parent.OwnerId = mapQueue.get(em.ParentId);
                        //system.debug('l_case 1: '+l_case);
                    } else if(cs.Assignment_Rules__c == TRUE /*&& cs.First_Queue__c != null*/){
                      //else if(em.Subject.substring(0,3) == 'RE:'){
                        //Case cs_email = mapCase.get(em.ParentId);
                        //system.debug('----cs_email 2: '+cs_email);
                        if(cs.Origin == 'Email'){       //CHECK FIRST CASE ORIGIN | Update, 4 Februari 2020);
                            System.debug('==== Origin is Email (RE:) ====');
                            System.debug('==== cs.First_Case_Origin__c: '+cs.First_Case_Origin__c);
                            system.debug('---- To Address:'+em.ToAddress);
                            system.debug('---- Subject Email:'+em.Subject);
                                if(em.ToAddress == 'no-reply@axa-financial.co.id' || em.ToAddress == 'noreplydummy8@gmail.com'){  //Jika ada reply ke email: "no-reply@axa-financial.co.id"
                                    if(cs.First_Case_Origin__c == '' || cs.First_Case_Origin__c == null){
                                        cs.No_Need_To_Reply_New__c = FALSE;
                                        cs.First_Case_Origin__c = cs.Origin;
                                        if(cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null){
                                            cs.Email_Text_Holiday_Weekend__c = null;
                                            
                                            if(isHoliday == TRUE) cs.isHoliday__c = TRUE;
                                            
                                            if(isEvent == TRUE) cs.isEvent__c = TRUE;
                                        }
                                        /*if(RangeDateHolidayEvent != null){
                                            cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                        }
                                        if(EndDateHolidayEvent != null){
                                            cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                        }
                                        system.debug('cs.Range_Date_Holiday_Event__c (2): '+cs.Range_Date_Holiday_Event__c);
                                        system.debug('cs.End_Date_Holiday_Event__c (2): '+cs.End_Date_Holiday_Event__c);*/
                                        system.debug('update case 1');
                                    } else {
                                        cs.No_Need_To_Reply_New__c = FALSE;
                                        if(cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null){
                                            cs.Email_Text_Holiday_Weekend__c = null;
                                            
                                            if(isHoliday == TRUE) cs.isHoliday__c = TRUE;
                                            
                                            if(isEvent == TRUE) cs.isEvent__c = TRUE;
                                        }
                                        
                                        /*if(RangeDateHolidayEvent != null){
                                            cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                        }
                                        if(EndDateHolidayEvent != null){
                                            cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                        }
                                        system.debug('cs.Range_Date_Holiday_Event__c (1): '+cs.Range_Date_Holiday_Event__c);
                                        system.debug('cs.End_Date_Holiday_Event__c (1): '+cs.End_Date_Holiday_Event__c);*/
                                        system.debug('update case 2');
                                    }
                                } else if(em.ToAddress.contains(system.Label.CustomerEmail_AFI_ALI) || em.ToAddress.contains(system.Label.HelplineEmail_AFI_ALI) || cs.Email_Inbox__c == system.Label.CustomerEmail_AFI_ALI || cs.Email_Inbox__c == system.Label.HelplineEmail_AFI_ALI){ //============ REPLY TO "customer@axa-financial.co.id" / "helpline@axa-financial.co.id" ============
                                    //CHANGE OWNER to AGENT QUEUE (WEEKLY DAILY 24 Januari 2020)
                                    if(em.Agent_Queue_ID__c != null && em.Agent_Queue_ID__c != ''){  //Owner-nya "Agent"
                                        if(em.Incoming == TRUE){    //Incoming == TRUE
                                            //if(cs.First_Case_Origin__c == '' || cs.First_Case_Origin__c == 'Email'){
                                            if(cs.First_Case_Origin__c == 'Email' && cs.Origin == 'Email'){
                                                if(em.Reason__c == null){ cs.OwnerId = em.Agent_Queue_ID__c; cs.No_Need_To_Reply_New__c = FALSE;
                                                                         System.debug('- -  - CHANGE OWNER ID');
                                                } 
                                                
                                                cs.First_Case_Origin__c = cs.Origin;
                                                if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                                
                                                /*if(RangeDateHolidayEvent != null){
                                                    cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                                }
                                                if(EndDateHolidayEvent != null){
                                                    cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                                }
                                                system.debug('cs.Range_Date_Holiday_Event__c (3): '+cs.Range_Date_Holiday_Event__c);
                                                system.debug('cs.End_Date_Holiday_Event__c (3): '+cs.End_Date_Holiday_Event__c);*/
                                                system.debug('cs.First_Case_Origin__c (1): '+cs.First_Case_Origin__c);
                                                system.debug('update case 3 (agent-AFI), InComing TRUE (1)');
                                            } /*else if(cs.First_Case_Origin__c == 'Email' && cs.Origin == 'Email') {
                                                cs.OwnerId = em.Agent_Queue_ID__c;
                                                cs.No_Need_To_Reply_New__c = FALSE;
                                                cs.First_Case_Origin__c = cs.Origin;
                                                if(cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) cs.Email_Text_Holiday_Weekend__c = text2;
                                                
                                                system.debug('cs.First_Case_Origin__c (1): '+cs.First_Case_Origin__c);
                                                system.debug('update case 4 (agent-AFI), InComing TRUE (2)');
                                            }*/ else {
                                                cs.OwnerId = system.Label.CaseOriginNotEmail;
                                                cs.No_Need_To_Reply_New__c = FALSE;
                                                if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                                /*if(RangeDateHolidayEvent != null){
                                                    cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                                }
                                                if(EndDateHolidayEvent != null){
                                                    cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                                }
                                                system.debug('cs.Range_Date_Holiday_Event__c (4): '+cs.Range_Date_Holiday_Event__c);
                                                system.debug('cs.End_Date_Holiday_Event__c (4): '+cs.End_Date_Holiday_Event__c);*/
                                                system.debug('cs.First_Case_Origin__c (2): '+cs.First_Case_Origin__c);
                                                system.debug('update case 5 (agent-AFI), InComing TRUE (3)');
                                                break;
                                            }
                                        } else {                    //Incoming == FALSE
                                            cs.No_Need_To_Reply_New__c = FALSE;
                                            if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                            
                                            system.debug('cs.First_Case_Origin__c (3): '+cs.First_Case_Origin__c);
                                            system.debug('update case 6 (agent-AFI), InComing FALSE');
                                            break;
                                        }
                                    } else {                                        //Owner-nya SELAIN "Agent"
                                        if(em.Incoming == TRUE){
                                            //Update, 2 Maret 2020
                                            //cs.OwnerId = system.Label.CaseOriginNotEmail;
                                            //END - Update, 2 Maret 2020
                                            cs.No_Need_To_Reply_New__c = FALSE;
                                            if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                            /*if(RangeDateHolidayEvent != null){
                                                cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                            }
                                            if(EndDateHolidayEvent != null){
                                                cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                            }
                                            system.debug('cs.Range_Date_Holiday_Event__c (5): '+cs.Range_Date_Holiday_Event__c);
                                            system.debug('cs.End_Date_Holiday_Event__c (5): '+cs.End_Date_Holiday_Event__c);*/
                                            system.debug('cs.First_Case_Origin__c (4): '+cs.First_Case_Origin__c);
                                            system.debug('update case 7 (non agent)');
                                            break;
                                        } else {
                                            cs.No_Need_To_Reply_New__c = FALSE;
                                            if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                            /*if(RangeDateHolidayEvent != null){
                                                cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                            }
                                            if(EndDateHolidayEvent != null){
                                                cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                            }
                                            system.debug('cs.Range_Date_Holiday_Event__c (6): '+cs.Range_Date_Holiday_Event__c);
                                            system.debug('cs.End_Date_Holiday_Event__c (6): '+cs.End_Date_Holiday_Event__c);*/
                                            system.debug('cs.First_Case_Origin__c (5): '+cs.First_Case_Origin__c);
                                            system.debug('update case 8 (non agent)');
                                        }
                                        
                                    }
                                }
                            } else {
                            System.debug('==== Origin is not Email ====');
                                if(em.Incoming == TRUE){    //Incoming == TRUE
                                    System.debug('*** Incoming = TRUE ****');
                                    if(cs.First_Case_Origin__c != '' && cs.Origin != 'Email'){
                                        cs.OwnerId = system.Label.CaseOriginNotEmail;          //=== Set Queue to First Case Origin not "Email"
                                        cs.No_Need_To_Reply_New__c = FALSE;
                                        cs.First_Case_Origin__c = cs.Origin;
                                        if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                        /*if(RangeDateHolidayEvent != null){
                                            cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                        }
                                        if(EndDateHolidayEvent != null){
                                            cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                        }
                                        system.debug('cs.Range_Date_Holiday_Event__c (7): '+cs.Range_Date_Holiday_Event__c);
                                        system.debug('cs.End_Date_Holiday_Event__c (7): '+cs.End_Date_Holiday_Event__c);*/
                                        system.debug('update case 9 (FIRST CASE ORIGIN NOT EMAIL), InComing TRUE (1)');
                                    } else if(cs.First_Case_Origin__c != 'Email' && cs.Origin == 'Email'){
                                        cs.OwnerId = system.Label.CaseOriginNotEmail;          //=== Set Queue to First Case Origin not "Email"
                                        cs.No_Need_To_Reply_New__c = FALSE;
                                        if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                        
                                        /*if(RangeDateHolidayEvent != null){
                                            cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                        }
                                        if(EndDateHolidayEvent != null){
                                            cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                        }
                                        system.debug('cs.Range_Date_Holiday_Event__c (8): '+cs.Range_Date_Holiday_Event__c);
                                        system.debug('cs.End_Date_Holiday_Event__c (8): '+cs.End_Date_Holiday_Event__c);*/
                                        system.debug('update case 10 (FIRST CASE ORIGIN NOT EMAIL), InComing TRUE (2)');
                                        break;
                                    }
                                } else {                    //Incoming == FALSE
                                    System.debug('*** Incoming = FALSE ****');
                                    cs.No_Need_To_Reply_New__c = FALSE;
                                    if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null) cs.Email_Text_Holiday_Weekend__c = text2;
                                    /*if(RangeDateHolidayEvent != null){
                                        cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                                    }
                                    if(EndDateHolidayEvent != null){
                                        cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                                    }
                                    system.debug('cs.Range_Date_Holiday_Event__c (9): '+cs.Range_Date_Holiday_Event__c);
                                    system.debug('cs.End_Date_Holiday_Event__c (9): '+cs.End_Date_Holiday_Event__c);*/
                                    system.debug('update case 11 (FIRST CASE ORIGIN NOT EMAIL), InComing FALSE');
                                    break;
                                }
                            }
                        }
                } else {
                    system.debug('----Tidak Ada Subject----');
                    
                    cs.No_Need_To_Reply_New__c = FALSE;
                    cs.First_Case_Origin__c = cs.Origin;
                    if((cs.Email_Text_Holiday_Weekend__c == '' || cs.Email_Text_Holiday_Weekend__c == null) && text2 != null){
                        cs.Email_Text_Holiday_Weekend__c = text2;
                        
                        
                        if(isHoliday == TRUE) cs.isHoliday__c = TRUE;
                        
                        if(isEvent == TRUE) cs.isEvent__c = TRUE;
                    }
                    /*if(RangeDateHolidayEvent != null){
                        cs.Range_Date_Holiday_Event__c = RangeDateHolidayEvent;
                    }
                    if(EndDateHolidayEvent != null){
                        cs.End_Date_Holiday_Event__c = EndDateHolidayEvent;
                    }
                    system.debug('cs.Range_Date_Holiday_Event__c (10): '+cs.Range_Date_Holiday_Event__c);
                    system.debug('cs.End_Date_Holiday_Event__c (10): '+cs.End_Date_Holiday_Event__c);*/
                    system.debug('update case 12');
                }
            }

        }
        
        system.debug('-----UPDATE CASE DONE-----');
        /** END - UPDATED, 15 Feb 2020 **/
        
        
        //Update, 9 Maret 2020
        String skipData = '';
        if (test.isRunningTest() && nextOrder == TRUE) { skipData = 'test'; }
        //if ( nextOrder  ) {   //----->> Non Active
        if ( skipData == 'test' ) {  
        //END - Update, 9 Maret 2020
        //
            system.debug('nextOrder: '+nextOrder);
            
            
            //QUERY Skill of Nature Category
            skillList = [SELECT Name, Last_Order_No__c, Nature__c, Category__c FROM Skill_of_Nature_Category__c WHERE Entity__c=:entityCase AND  Status__c =: 'Active'];
            system.debug('skillList: ' + skillList);
            
            if(skillList.size() > 0){
                for(Skill_of_Nature_Category__c skill : skillList){
                    if(skill.Nature__c == 'All' && skill.Category__c == 'All'){
                        //skillList.add(skill);
                        system.debug('====== skillList.size() A : ' + skillList.size());    
                    } else if(skill.Nature__c == nature && skill.Category__c == 'All'){
                        //skillList.add(skill);
                        system.debug('====== skillList.size() B : ' + skillList.size());    
                    } else if(skill.Nature__c == nature && skill.Category__c == category){
                        //skillList.add(skill);
                        system.debug('====== skillList.size() C : ' + skillList.size());
                    }
                }
            }
            
            
            /** COMMENT, 15 Feb 2020 **/
            
            /*skillList = [SELECT Name, Last_Order_No__c FROM Skill_of_Nature_Category__c WHERE Nature__c=:'All' AND  Category__c =: 'All' AND Entity__c=:entityCase AND  Status__c =: 'Active'];
            
            system.debug('====== skillList.size() A : ' + skillList.size());    
            if (skillList.size()==0) {
                skillList = [SELECT Name, Last_Order_No__c FROM Skill_of_Nature_Category__c WHERE Nature__c=:nature AND  Category__c =: 'All' AND Entity__c=:entityCase AND  Status__c =: 'Active'];
            }
            
            system.debug('====== skillList.size() B : ' + skillList.size());    
            
            if (skillList.size()==0) {
                skillList = [SELECT Name, Last_Order_No__c FROM Skill_of_Nature_Category__c WHERE Nature__c=:nature AND  Category__c =: category AND Entity__c=:entityCase AND  Status__c =: 'Active'];
            }
            
            system.debug('====== skillList.size() C : ' + skillList.size());*/ 
            
            /** END - COMMENT, 15 Feb 2020 **/
            
            if (skillList.size()==0) {
                cs.CMU_Agent__c =null; 
                cs.PIC__C=null;
            }
            system.debug('cs.CMU_Agent__c: '+cs.CMU_Agent__c);
            system.debug('cs.PIC__C: '+cs.PIC__C);
            
                    for(Skill_of_Nature_Category__c skill: skillList){
                        if(skill != null){
                            skillName = skill.Name;
                            system.debug('====== skillName:' + skillName);
                            
                            lastOrderNo = skill.Last_Order_No__c;
                        
                            List<User_Skill__c> userSkillList = new List<User_Skill__c>();

                            List<AggregateResult> Result; 
                            Result = [SELECT MIN(Order__c) minOrder, MAX(Order__c) maxOrder FROM User_Skill__c WHERE Skill__r.name = :skillName AND  Status__c =: 'Active'];
                            
                            Decimal min = 0;
                            Decimal max = 0;
                            for(AggregateResult aggRes : Result) {
                                min = (Decimal) aggRes.get('minOrder'); 
                                max = (Decimal) aggRes.get('maxOrder');
                            }
                            
                            system.debug('====== min:' + min);
                            system.debug('====== max:' + max);
                            system.debug('====== lastOrderNo:' + lastOrderNo);
                            

                            // Decimal nextOrder =0;
                            userSkillList = [SELECT User__c, Order__c FROM User_Skill__c WHERE Skill__r.name = :skillName AND  Status__c = 'Active' order by Order__c ];
                            
                            for(User_Skill__c userSkill: userSkillList){
                                if(userSkill != null ){

                                    system.debug('====== userSkill:' + userSkill.User__c + ' - ' + userSkill.Order__c);
                                    // first
                                    if ( userSkill.Order__c == min && lastOrderNo >= max ) {
                                        system.debug('====== userSkill.User__c (1):' + userSkill.User__c);
                                        
                                        //before : c.Back_Office_PIC__c = userSkill.User__c;
                                        //after  : change to 'CMU Agent' field
                                        if (entityCase=='AMFS') {
                                            cs.PIC__C = userSkill.User__c;
                                        }
                                        cs.CMU_Agent__c= userSkill.User__c; 
                                        
                                        skill.Last_Order_No__c = min;//userSkill.Order__c;              
                                        break;
                                    }

                                    // next
                                    else if (userSkill.Order__c <= lastOrderNo ) {
                                        //=++
                                        continue;
                                    }

                                    //got the order
                                    else if (userSkill.Order__c > lastOrderNo ) {
                                        system.debug('====== userSkill.User__c: (3)' + userSkill.User__c);
                                        //before : c.Back_Office_PIC__c = userSkill.User__c;
                                        //after  : change to 'CMU Agent' field
                                        if (entityCase=='AMFS') {
                                            cs.PIC__C= userSkill.User__c;
                                        }
                                        cs.CMU_Agent__c= userSkill.User__c;
                                        
                                        system.debug('userSkill.Order__c : ' + userSkill.Order__c);
                                        skill.Last_Order_No__c = userSkill.Order__c;
                                        system.debug('skill.Last_Order_No__c : ' + skill.Last_Order_No__c);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    
                    update skillList;
                    }
    } 
    
    // added by Support MII at 03 24
    if (Trigger.isInsert) {
        boolean isAMFS = false;
        Map<String, string> caseMot = new Map<String, string>();
        for(Case row :  Trigger.new){  
            system.debug('#### row:'+row.Entity__c);
            if (row.Entity__c == 'AMFS' || entity == 'AMFS') {
                isAMFS = true;
                String caseType= row.Case_Type__c;
                if (string.isblank(caseType)) caseType = row.Case_Type_Config__c;
                caseMot.put(caseType, '');
            } 
        } 
        
        system.debug('#### isAMFS:'+isAMFS);
        
        if (isAMFS == true && caseMot.size() > 0) { 
            map<string, string> mapTypeCase = new map<string, string>();
            List<Master_Case_Type_Regional__c> masterCaseType = [SELECT Id, Qualtrics__c, Case_Type__c, mot__c, type__c FROM Master_Case_Type_Regional__c where Qualtrics__c = true and Case_Type__c in :caseMot.keySet()];
            for(Master_Case_Type_Regional__c row : masterCaseType) {
                caseMot.put(row.Case_Type__c, row.MOT__c);
                
                string concat = row.Case_Type__c; 
                concat += row.type__c; 
                mapTypeCase.put(concat, row.MOT__c);
            }
            
            
             for(Case row :  Trigger.new){  
                
                 String CaseType = row.Case_Type__c;
                 if(string.isblank(CaseType)) CaseType = row.Case_Type_Config__c; 
                 system.debug('#### CaseType:'+CaseType);   
                
                
                 string concat = CaseType; 
                 concat += row.type; 
                
                 // if(caseMot.ContainsKey(CaseType)){  
                    
                 if(mapTypeCase.ContainsKey(concat)){  
                     // system.debug('#### CaseType:'+caseMot.get(CaseType));   
                     // row.MOT__c = caseMot.get(CaseType); 
                     system.debug('#### CaseType:'+mapTypeCase.get(concat));   
                     row.MOT__c = mapTypeCase.get(concat); 
                 }
            } 
        }
    }

    // ended by Support MII at 03 24
 
    private void setRoles(String entity2){
        Map<id,User> userMap = new Map<id,User>();
        
        // change by Ranti
        List<UserRole> roleList = [SELECT Id, Name FROM UserRole WHERE not Name like '%Agent%'];
        for(UserRole uRole: roleList){
            if(!roleMap.containsKey(uRole.Name)){
                roleMap.put(uRole.Name, uRole);
            }
        }
        
        
        List<User> userList = [SELECT Id, Name, UserRoleId, UserRole.name FROM User WHERE UserRole.name in :roleMap.keySet()]; 
        
        //List<User> userList = [SELECT Id, Name, UserRoleId, UserRole.name FROM User WHERE UserRole.name in :roleMap.keySet()];
        
        for(User u: userList){
            if(!userMap.containsKey(u.id)){
                userMap.put(u.id, u);
            }
        }
        
        for(Id roleId: userMap.keySet()){
        
            User usr = userMap.get(roleId);
    
            if (usr.userRole.Name == 'CMU SPV '+entity2) {
               spvCMU = usr.Id;
            }
            else if (usr.userRole.Name == 'CCC Asst. Manager '+entity2) {
               assManager = usr.Id;
            }
            else if (usr.userRole.Name == 'CCC Manager '+entity2) {
               manager = usr.Id;
            }
            else if (usr.userRole.Name == 'CEO '+entity2) {
               ceo = usr.Id;
            }
            else if (usr.userRole.Name == 'Central Operation (CO) Head '+entity2) {
               CO_Head = usr.Id;
            }
            else if (usr.userRole.Name == 'Collection Manager '+entity2) {
               collectionMgr = usr.Id;
            }
            else if (usr.userRole.Name == 'CMU '+entity2) {
               cmu = usr.Id;
            }
            else if (usr.userRole.Name == 'Customer Service '+entity2) {
               custService = usr.Id;
            }
            else if (usr.userRole.Name == 'Deputy COO '+entity2) {
               deputyCOO = usr.Id;
            }
            else if (usr.userRole.Name == 'Finance Head '+entity2) {
               financeHead = usr.Id;
            }
            /*
            else if (usr.userRole.Name == 'Financial Controller '+entity) {
               financialController = usr.Id;
            }
            else if (usr.userRole.Name == 'POS Manager '+entity) {
               posMgr = usr.Id;
            }
            else if (usr.userRole.Name == 'NBUW Manager '+entity) {
               nbuwMgr = usr.Id;
            }
            */
            else if (usr.userRole.Name == 'Inbound SPV '+entity2) {
               inboundSPV = usr.Id;
            }
            else if (usr.userRole.Name == 'Outbound SPV '+entity2) {
               outboundSPV = usr.Id;
            }
            else if (usr.userRole.Name == 'Request Manager '+entity2) {
               requestMgr = usr.Id;
            }
            else if (usr.userRole.Name == 'CCC Senior Manager '+entity2) {
               seniorMgr = usr.Id;
            }
            else if (usr.userRole.Name == 'Claim Head '+entity2) {
               claimHead = usr.Id;
            }
            else if (usr.userRole.Name == 'Operation Support Head '+entity2) {
               oprSuppHead = usr.Id;
            }
            else if (usr.userRole.Name == 'PIC Claim '+entity2) {
               picClaim = usr.Id;
            }
            else if (usr.userRole.Name == 'PIC CO '+entity2) {
               pic_CO = usr.Id;
            }
            else if (usr.userRole.Name == 'PIC CMU '+entity2) {
               pic_CMU = usr.Id;
            }
            else if (usr.userRole.Name == 'PIC Collection '+entity2) {
               pic_Collection = usr.Id;
            }
            else if (usr.userRole.Name == 'PIC Finance '+entity2) {
               pic_Finance = usr.Id;
            }
            else if (usr.userRole.Name == 'PIC Sales '+entity2) {
               pic_Sales = usr.Id;
            }
            else if (usr.userRole.Name == 'Email SPV '+entity2) {
               emailSpv = usr.Id;
            }
            else if (usr.userRole.Name == 'Sales Distribution Head '+entity2) {
               sales_DistrHead = usr.Id;
            }
            else if (usr.userRole.Name == 'Underwriting Manager '+entity2) {
               underwritingMgr = usr.Id;
            }
            else if (usr.userRole.Name == 'Walk-In SPV '+entity2) {
               walkIn_SPV = usr.Id;
            }
        }
    }   
}