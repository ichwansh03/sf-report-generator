public class prechatform_Controller {
    public prechatform_Controller(){}
    
    @remoteAction
    public Static string getParam(String myParam){
        /*
        Search Contact based on Policy_No_Numeric__c, Phone. Email
        */
        String[]param = myParam.split(';');
        List<Contact> conPolicy = new List<Contact>();
        List<Contact> conPhone = new List<Contact>();
        List<Contact> conEmail = new List<Contact>();
        
        String ret;
        if(param[0] != ''){
            conPolicy = [select Id from Contact where Policy_No_Numeric__c =:param[0]];
            if(conPolicy.size() > 0){
                 ret = 'Policy_No_Numeric__c';
            }else{
                if(param[1] != ''){
                    conPhone = [select Id from Contact where Phone =:param[1]];
                    if(conPhone.size() > 0){
                        ret = 'Phone';
                    }else{
                        if(param[2] != '')
                        conEmail = [select Id from Contact where email =:param[2]];
                        if(conEmail.size() > 0){
                            ret = 'Email';
                        }else{
                            ret = 'Policy_No_Numeric__c';
                        }
                    }
                }else if(param[2] != ''){
                    conEmail = [select Id from Contact where email =:param[2]];
                    if(conEmail.size() > 0){
                        ret = 'Email';
                    }else{
                        ret = 'Policy_No_Numeric__c';
                    }
                }
            }
        }
        return ret;
    }
}