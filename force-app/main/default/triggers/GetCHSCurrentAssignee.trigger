trigger GetCHSCurrentAssignee on Case (before update) {
    String entity = '';
    Integer i = 0;
    
    List<User> cmuUserAFI = [SELECT id, name, UserRole.name FROM User WHERE UserRole.name = 'CMU AFI']; //added by WK, 20150128
    List<User> cmuUserAMFS = [SELECT id, name, UserRole.name FROM User WHERE UserRole.name = 'CMU AMFS'];
    List<User> cmuUserMAGI = [SELECT id, name, UserRole.name FROM User WHERE UserRole.name = 'CMU MAGI'];
        
    for (Case c : System.Trigger.New){
    	if(c.Type == 'Complaint' && (c.CHS_Status__c != 'Closed - Invalid' || c.CHS_Status__c != 'Closed - Valid')){
            system.debug('Entering logic...');
            
            //PIC assignee = Back office PIC (PIC Claim, PIC Finance etc)
            if (c.CHS_Status__c == 'Assigned to Back Office' || c.CHS_Status__c == 'In Progress Back Office'){
                c.Current_Assignee__c = c.Back_Office_PIC__c;
            }
            //PIC assignee = Agent/Case Owner
            else if(c.CHS_Status__c == 'Incomplete Information'){
                c.Current_Assignee__c = c.OwnerId;
                system.debug('Status: '+c.CHS_Status__c);
            }
            //PIC assignee = PIC CMU (CMU AFI/CMU AMFS/CMU MAGI)
            else if(c.CHS_Status__c != 'Assigned to Back Office' && c.CHS_Status__c != 'In Progress Back Office' && c.CHS_Status__c != 'Incomplete Information' && c.CHS_Status__c != 'Escalated' && c.CHS_Status__c != 'BOD Approval'){
                entity = c.Entity__c;
                
                system.debug('Status: '+c.CHS_Status__c);
                
                if(entity == 'AFI'){
                	if(cmuUserAFI.size() > 0){
	                	c.Current_Assignee__c = cmuUserAFI[i].id;
	                	//c.Complaint_Closer_Name__c = cmuUserAFI[i].id;
	                }
                }
                else if(entity == 'AMFS'){
                	if(cmuUserAMFS.size() > 0){
	                	c.Current_Assignee__c = cmuUserAMFS[i].id;
	                	//c.Complaint_Closer_Name__c = cmuUserAMFS[i].id;
	                }
                }
                else if(entity == 'MAGI'){
                    if(cmuUserMAGI.size() > 0){
	                	c.Current_Assignee__c = cmuUserMAGI[i].id;
	                	//c.Complaint_Closer_Name__c = cmuUserMAGI[i].id;
	                }
                }
                i++;
            }
            else{
                c.Current_Assignee__c = null;
                c.Complaint_Closer_Name__c = null;
            }
        }
        else if(c.Type == 'Complaint' && (c.CHS_Status__c == 'Closed - Invalid' || c.CHS_Status__c == 'Closed - Valid')){
        	c.Complaint_Closer_Name__c = c.LastModifiedBy.LastName;
        }
    }
}