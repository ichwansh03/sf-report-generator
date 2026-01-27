@RestResource(urlMapping='/generateWord/*')
global with sharing class GenerateWordDocument{

  @HttpPost
    webservice static void doPost(list<String> caseIdList) {
       list<attachment> lst_attachment = new list<attachment>();
       NumberGenerator numGen = new NumberGenerator();
       Integer month = Date.Today().Month();
       Integer year = Date.Today().Year();
       String numberCounter;
          
       for(String caseId: caseIdList){
            //VF pages rendered as Word
            pageReference wordPageAMFS = Page.Memo_Approval_Print_AMFS;
        	wordPageAMFS.getParameters().put('id', caseId);
        
        	pageReference wordPageMAGI = Page.Memo_Approval_Print_MAGI;
        	wordPageMAGI.getParameters().put('id', caseId);
            
            Attachment attachment = new Attachment();
            Blob body;
            
            List<Case> lst_case = [SELECT Id, CaseNumber, Type, BOD_Type__c, Entity__c FROM Case WHERE Id=: caseId];
            
            try{
            	system.debug('Case ID: '+caseId);
            	
    		    if(lst_case[0].Type == 'Complaint' && (lst_case[0].Entity__c == 'AMFS' || lst_case[0].Entity__c == 'AFI')){
            		if(lst_case[0].BOD_Type__c == 'Level 1' || lst_case[0].BOD_Type__c == 'Level 2' || lst_case[0].BOD_Type__c == 'Level 3'){
	                    body = wordPageAMFS.getContent();
	                    system.debug('Get content AFI/AMFS: ' +body.toString());
	                    
	                    if(lst_case[0].Entity__c == 'AMFS' ){
	                    	numberCounter = numGen.getNumber('AMFS');
	                    	attachment.Name = 'MemoApproval '+numberCounter+'-CMU-AMFS-'+month+'-'+year+'.doc';
			            }
	                    else if(lst_case[0].Entity__c == 'AFI' ){
	                    	numberCounter = numGen.getNumber('AFI');
	                    	attachment.Name = 'MemoApproval '+numberCounter+'-CMU-AFI-'+month+'-'+year+'.doc';
			            }
	                    
	                    attachment.Body = body;
			            attachment.IsPrivate = false;
			            attachment.ParentId = caseId;//This is the record to which the Word doc will be attached
			            lst_attachment.add(attachment);
			        }
        		}
	            if(lst_case[0].Type == 'Complaint' && lst_case[0].Entity__c == 'MAGI'){
	                if(lst_case[0].BOD_Type__c == 'Level 1' || lst_case[0].BOD_Type__c == 'Level 2' || lst_case[0].BOD_Type__c == 'Level 3'){
	                    body = wordPageMAGI.getContent();
	                    system.debug('Get content MAGI: ' +body.toString());
	                    
	                    numberCounter = numGen.getNumber('MAGI');
	                    
	                    attachment.Body = body;
			            attachment.Name = 'MemoApproval '+numberCounter+'-MAGI-CCC-AT-'+month+'-'+year+'.doc';
			            attachment.IsPrivate = false;
			            attachment.ParentId = caseId;
			            lst_attachment.add(attachment);
			        }
	            }
	        }catch (VisualforceException e) {
	             body = Blob.valueOf('Failed to generate Word document');
	        }
        }
        insert lst_attachment;
    }
}