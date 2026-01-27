@isTest(seeAllData = true)
public class JatisBatchWorker_Test {
    public static testmethod void tes(){
        /* ICF_Parameter__c icfES = [SELECT id, ICF_Email_Template__c, ICF_SMS_Template__c, 
User_ID__c, Password__c, Division__c, Sender__c, Batchname__c, Uploadby__c, Channel__c, 
Login_1__c, API_Key_1__c, Login_2__c, API_Key_2__c, Description__c,
ICF_Method__c, Entity__c, ICF_Email_Template__r.Email_Body__c,ICF_SMS_Template__r.Email_Body__c,
ICF_Email_Template__r.Email_Header__c,ICF_Email_Template__r.Email_Footer__c,ICF_Email_Template__r.subject__c,ICF_SMS_Template__r.Subject__c   
FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_CMU' and Entity__c = 'AMFS' 
and ICF_Email_Template__r.Subject__c='Reminder Case Complaint' and ICF_SMS_Template__r.Subject__c='Reminder Case Complaint']; */
        
        
        ICF_Parameter__c icfES = [SELECT id, ICF_Email_Template__c, ICF_SMS_Template__c, 
                                            User_ID__c, Password__c, Division__c, Sender__c, Batchname__c, Uploadby__c, Channel__c, 
                                            Login_1__c, API_Key_1__c, Login_2__c, API_Key_2__c, Description__c,
                                            ICF_Method__c, Entity__c, ICF_Email_Template__r.Email_Body__c,ICF_SMS_Template__r.Email_Body__c,
                                            ICF_Email_Template__r.Email_Header__c,ICF_Email_Template__r.Email_Footer__c,ICF_Email_Template__r.subject__c,ICF_SMS_Template__r.Subject__c   
                                            FROM ICF_Parameter__c WHERE Record_Type_Name__c = 'Master_CMU' and Entity__c = 'AMFS' 
                                            and ICF_Email_Template__r.Subject__c='Reminder Case Complaint' and ICF_SMS_Template__r.Subject__c='Reminder Case Complaint'];
        
        
        List<Case> listCS = [select id,contactId from case where contactId='0030K00002CKOYjQAP' limit 1];
        if(listCS.isEmpty()){
            Case cs = new Case();
            cs.Status='New';
            cs.Complaint_type__c='Priority';
            cs.Nature_Config__c='Processing Times';
            cs.ContactId='0030K00002CKOYjQAP';
            cs.Customer_type__c='Priority Banking Customer';
            listCS.add(cs);
            insert listCS;
            
        }else{
            for(Case cs: listCS){
                cs.id = '5005D000008pWKqQAM';
                cs.Status='New';
                cs.Complaint_type__c='Priority';
                cs.Nature_Config__c='Processing Times';
                cs.ContactId='0030K00002CKOYjQAP';
                cs.Customer_type__c='Priority Banking Customer';
                update cs;
                
            }
            
        }
        
        DateTime currentDate = Date.today();
        String createddate = '';
        
        
                String phone = '082216648485';
                Date dt = Date.newInstance(2024,3,1);
                
                createddate = ((Datetime)dt).format('dd MMM yyyy');
                System.debug('JatisBatchWorkerTest: '+createddate);
                
                String emailText = icfES.ICF_SMS_Template__r.email_body__c;
                emailText= emailText.replace('[CREATED_DATE]',createddate); 
                emailText= emailText.replace('[CASE_NO]', '05411723');
                emailText = emailText.replace('[POLICY_NO]','520-2217658');
                
                String sms = EncodingUtil.urlEncode(emailText, 'UTF-8');
                System.debug('[?][username / pass] = '+ icfES.user_id__c +'/'+icfES.password__c);
                
                // checking format
                String defaultFormat = Label.Jatis_Phone_Prefix_Default;
                List<String> otherFormatList = (Label.Phone_Others_Prefix).split(';');
                String phoneCurrentFormat = phone.substring(0, defaultFormat.length());
                if (!phoneCurrentFormat.equals(defaultFormat)) {
                    for (String phoneFormat : otherFormatList) {
                        phoneCurrentFormat = phone.substring(0, phoneFormat.length());
                        if (phoneCurrentFormat.equals(phoneFormat)) {
                            phone = defaultFormat + phone.substring(phoneFormat.length()); 
                            system.debug(LoggingLevel.DEBUG, 'Phone number after formating:' + phone);
                        }
                    }
                }
                
                String phonenumber = phone;
                
                String url1 = Label.JATIS_SMS_Endpoint + '?userid='+icfES.user_id__c+'&password='+icfES.password__c+'&msisdn='+phonenumber+'&message='+sms;
                String url2 = '&sender='+icfES.sender__c+'&division='+EncodingUtil.urlEncode(icfES.division__c, 'UTF-8')+'&batchname='+EncodingUtil.urlEncode(icfES.batchname__c, 'UTF-8');
                String url3 = '&uploadby='+EncodingUtil.urlEncode(icfES.uploadby__c, 'UTF-8')+'&channel='+EncodingUtil.urlEncode(icfES.channel__c, 'UTF-8')+' ';
                String url = url1 + url2 + url3;
                
                System.debug('JatisBatchWorkerTest: '+url+'_'+createddate);
                
                JatisBatchWorker.call(url+'_'+createddate); 	
        
        
    }
}