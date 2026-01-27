trigger EmailSmsLog_setShortName on Email_SMS_Log__c (before insert, before update) {
    if (trigger.isBefore){
        for (Email_SMS_Log__c tsk : trigger.new) {
            if(tsk.Contact_Name__c != '') {
                // hide, ganti solusi, ambil 22 char saja.
                if (tsk.Contact_Name__c.Length() > 22)
                    Tsk.Contact_Short_name__c = tsk.Contact_Name__c.substring(0, 21);
                else
                    Tsk.Contact_Short_name__c = tsk.Contact_Name__c;
                /*
                List<string> temp = tsk.Contact_name__c.split(' ');
                if(temp.size() > 2) {
                    Tsk.Contact_Short_name__c = temp[1]+' '+temp[2];
                } else tsk.contact_short_name__c = tsk.contact_name__c;
                */
            }
        }
    }
}