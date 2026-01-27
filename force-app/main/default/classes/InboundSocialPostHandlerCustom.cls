global virtual class InboundSocialPostHandlerCustom implements Social.InboundSocialPostHandler {

    final static Integer CONTENT_MAX_LENGTH = SocialPost.Content.getDescribe().getLength();
    final static Integer SUBJECT_MAX_LENGTH = Case.Subject.getDescribe().getLength();
    Boolean isNewCaseCreated = false;
    
    // Reopen case if it has not been closed for more than this number
    global virtual Integer getMaxNumberOfDaysClosedToReopenCase() {
        return 0;
    }
    
    // Create a case if one of these post labels are on the SocialPost, regardless of the skipCreateCase indicator.
    global virtual Set<String> getPostLabelsThatCreateCase(){
        return new Set<String>();
    }

    // If true, use the active case assignment rule if one is found
    global virtual Boolean getUsingCaseAssignmentRule(){
        return false;
    }

    global virtual String getDefaultAccountId() {
        return null;
    }

    global virtual String getCaseSubject(SocialPost post) {
        String caseSubject = post.Name;
        if (hasReview(post)) {
            String ratingsStr = getRatingString(post);
            caseSubject = ratingsStr + ' • ' + caseSubject;
        }

        return caseSubject;
    }

    global Social.InboundSocialPostResult handleInboundSocialPost(SocialPost post, SocialPersona persona, Map<String, Object> rawData) {
        Social.InboundSocialPostResult result = new Social.InboundSocialPostResult();
        result.setSuccess(true);
        matchPost(post);
        matchPersona(persona);

        if ((post.Content != null) && (post.Content.length() > CONTENT_MAX_LENGTH)) {
            post.Content = post.Content.abbreviate(CONTENT_MAX_LENGTH);
        }

        if (post.Id != null) {
            handleExistingPost(post, persona);
            return result;
        }

        setReplyTo(post, persona);
        buildPersona(post, persona);
        Case parentCase = buildParentCase(post, persona, rawData);
        setRelationshipsOnPost(post, persona, parentCase);
        setModeration(post, rawData);
        
        upsert post;
        
        if(isNewCaseCreated){
            updateCaseSource(post, parentCase);
        }
        
		handlePostAttachments(post, rawData);
		        
        return result;
    }
    
    private void setModeration(SocialPost post, Map<String, Object> rawData){
        //if we don't automatically create a case, we should flag the post as requiring moderator review.
        if(post.parentId == null && !isUnsentParent(rawData))
            post.reviewedStatus = 'Needed';
    }
    
    private void updateCaseSource(SocialPost post, Case parentCase){
        if(parentCase != null) {
            parentCase.SourceId = post.Id;
            //update as a new sobject to prevent undoing any changes done by insert triggers
            update new Case(Id = parentCase.Id, SourceId = parentCase.SourceId);
        }
    
    }
    
    private void handleExistingPost(SocialPost post, SocialPersona persona) {
    		List<SocialPost> existingPosts = [Select Recipient, IsOutbound from SocialPost where id = :post.Id limit 1];
    		
    		// for any existing outbound post, we don't overwrite its recipient field
    		if (!existingPosts.isEmpty() && existingPosts[0].IsOutBound == true && String.isNotBlank(existingPosts[0].Recipient)) {
    			post.Recipient = existingPosts[0].Recipient;
    		}
    		
    		update post;
    		if (persona.id != null)
    			updatePersona(persona);
    }

    private void setReplyTo(SocialPost post, SocialPersona persona) {
        SocialPost replyTo = findReplyTo(post, persona);
        if(replyTo.id != null) {
            post.replyToId = replyTo.id;
            post.replyTo = replyTo;
        }
    }

    private SocialPersona buildPersona(SocialPost post, SocialPersona persona) {
        if (persona.Id == null)
            createPersona(post, persona);
        else
            updatePersona(persona);
            
        return persona;
    }
    
    private void updatePersona(SocialPersona persona) {
        try{
            update persona;
        }catch(Exception e) {
            System.debug('Error updating social persona: ' + e.getMessage());
        }
    }
    
    private Case buildParentCase(SocialPost post, SocialPersona persona, Map<String, Object> rawData){
        if(!isUnsentParent(rawData)) {
            Case parentCase = findParentCase(post, persona);
            if (parentCase != null) {
                if (!parentCase.IsClosed) {
                    return parentCase;
                }
                else if (caseShouldBeReopened(parentCase)) {
                    reopenCase(parentCase);
                    return parentCase;
                }
            }
            if(shouldCreateCase(post, rawData)){
                isNewCaseCreated = true;
                return createCase(post, persona);
            }
        }
        
        return null;
    }
    
    private boolean caseShouldBeReopened(Case c){
        return c.id != null && c.isClosed && System.now() < c.closedDate.addDays(getMaxNumberOfDaysClosedToReopenCase());
    }

    private void setRelationshipsOnPost(SocialPost postToUpdate, SocialPersona persona, Case parentCase) {
        if (persona.Id != null) {
            postToUpdate.PersonaId = persona.Id;
            
            if(persona.ParentId.getSObjectType() != SocialPost.sObjectType) { 
                postToUpdate.WhoId = persona.ParentId;
            }
            
            //--Override contact on social post
            String s = postToUpdate.PostTags;
            Set<String> tagSet = new Set<String>();
            if(s != null) {
                if(s.contains(',')) { 
                    List<String> tagList = s.split(',');
                    tagSet.addAll(tagList);
                } else {
                    tagSet.add(s);
                }
            }
            //--If tagging found contact
            List<Contact> contactList = new List<Contact>();
            if(tagSet.contains('AMFS') || tagSet.contains('AXA Mandiri')) {
                contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AMFS%'];
            } else if(tagSet.contains('AFI') || tagSet.contains('AXA Financial') || tagSet.contains('AXA Financial Indonesia')) {
                contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AFI%'];
            } else if(tagSet.contains('AGI') || tagSet.contains('AXA General') || tagSet.contains('AXA General Indonesia')) {
                contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AGI%'];
            } else if(tagSet.contains('MAGI') || tagSet.contains('AXA Mandiri General')) {
                contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous MAGI%'];
            } 
            //--Relate post to contact based on tag
            if(contactList.size() > 0) {
                postToUpdate.WhoId = contactList[0].Id;
            }            
        }
        if(parentCase != null) {
            postToUpdate.ParentId = parentCase.Id;
        }
    }
    
    private Boolean hasReview(SocialPost post) {
        return post.ReviewScore != null;
    }
    
    private String getRatingString(SocialPost post) {
        Integer maxNumberOfStars = 5;
        Double reviewScore = post.ReviewScore;
        Double reviewScale = post.ReviewScale;
        if (reviewScore == null) {
            reviewScore = 0;
        }
        if (reviewScale == null) {
            reviewScale = maxNumberOfStars;
        }
        Integer numberOfStars = Math.floor((reviewScore / reviewScale) * maxNumberOfStars).intValue();
        return numberOfStars.format() + '-Star';
    }
    
    private Case createCase(SocialPost post, SocialPersona persona) {
        String caseSubject = getCaseSubject(post).abbreviate(SUBJECT_MAX_LENGTH);
		
        String s = post.PostTags;
        Set<String> tagSet = new Set<String>();
        if(s != null) {
            if(s.contains(',')) { 
                List<String> tagList = s.split(',');
                tagSet.addAll(tagList);
            } else {
                tagSet.add(s);
            }
        }
        
        Case newCase = new Case(subject = caseSubject);
        if (persona != null && persona.ParentId != null) {
            if (persona.ParentId.getSObjectType() == Contact.sObjectType) {
                List<Contact> contactList = new List<Contact>();
                if(tagSet.contains('AMFS') || tagSet.contains('AXA Mandiri')) {
                    contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AMFS%'];
                } else if(tagSet.contains('AFI') || tagSet.contains('AXA Financial') || tagSet.contains('AXA Financial Indonesia')) {
                    contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AFI%'];
                } else if(tagSet.contains('AGI') || tagSet.contains('AXA General') || tagSet.contains('AXA General Indonesia')) {
                    contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AGI%'];
                } else if(tagSet.contains('MAGI') || tagSet.contains('AXA Mandiri General')) {
                    contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous MAGI%'];
                } 
                
                if(contactList.size() > 0) {
                    newCase.ContactId = contactList[0].Id;
                } else {
                	newCase.ContactId = persona.ParentId;
                }
            } else if (persona.ParentId.getSObjectType() == Account.sObjectType) {
                newCase.AccountId = persona.ParentId;
            }
        }
        
        if (post != null && post.Provider != null) {
            newCase.Origin = post.Provider;
            newCase.Topic_Profile_Name__c = post.TopicProfileName; //--Added to handle user with cross managed social account
        }

        if (getUsingCaseAssignmentRule()){
            //Find the active assignment rules on case
            AssignmentRule[] rules = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];

            if (rules.size() > 0){
                //Creating the DMLOptions for "Assign using active assignment rules" checkbox
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.assignmentRuleId= rules[0].id;

                //Setting the DMLOption on Case instance
                newCase.setOptions(dmlOpts);
            }
        }
        
        //--Generate case field based on condition
        List<RecordType> socmedRecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'SocialPost'];
        System.debug('sizeSocialPostRecordType : ' + socmedRecordType.size());
        if(socmedRecordType.size() > 0) {
            newCase.RecordTypeId = socmedRecordType[0].Id;
            System.debug('getSocialPostRecordType : ' + socmedRecordType[0].Id);
        }
        newCase.Type = 'Inquiry';
        
        
        Integer counter = 0;
        if(tagSet.contains('AMFS') || tagSet.contains('AXA Mandiri')) {counter += 1;}
        if(tagSet.contains('AFI') || tagSet.contains('AXA Financial') || tagSet.contains('AXA Financial Indonesia')) {counter += 1;}
        if(tagSet.contains('AGI') || tagSet.contains('AXA General') || tagSet.contains('AXA General Indonesia')) {counter += 1;}
        if(tagSet.contains('MAGI') || tagSet.contains('AXA Mandiri General')) {counter += 1;}
        
        if(tagSet.isEmpty() || tagSet.size() == 0) { //counter > 1
            /*
            List<Group> gAXA = new List<Group>();
            gAXA = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA SMCC Queue' LIMIT 1];
            
            if(post.Provider == 'Facebook') {
                gAXA = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA Indonesia FB Queue' LIMIT 1];
            } else if(post.Provider == 'Twitter') {
                gAXA = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA Indonesia TW Queue' LIMIT 1];
            } else if(post.Provider == 'Instagram') {
                gAXA = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA Indonesia IG Queue' LIMIT 1];
            }
			
            if(gAXA.size() > 0) {newCase.OwnerId = gAXA[0].Id;} else {// SET OWNER IF QUEUE NOT FOUND  }
            */
        } else {        
            //--Logic assignment NEW case
            if(tagSet.contains('AMFS') || tagSet.contains('AXA Mandiri')) {
                List<RecordType> socmedEntity = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'SocialPost-AMFS'];
                newCase.RecordTypeId = socmedEntity[0].Id;
                
                List<Group> gAMFS = new List<Group>();
                gAMFS = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA Mandiri Queue' LIMIT 1];
                /*if(post.Provider == 'Facebook') {
                    gAMFS = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AMFS Facebook Queue' LIMIT 1];
                } else if(post.Provider == 'Twitter') {
                    gAMFS = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AMFS Twitter Queue' LIMIT 1];
                } else if(post.Provider == 'Instagram') {
                    gAMFS = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AMFS Instagram Queue' LIMIT 1];
                }*/
                if(gAMFS.size() > 0) {newCase.OwnerId = gAMFS[0].Id; newCase.Entity_Backup__c = 'AMFS';} else {/* SET OWNER IF QUEUE NOT FOUND */ }
                
            } else if(tagSet.contains('AFI') || tagSet.contains('AXA Financial') || tagSet.contains('AXA Financial Indonesia')) {
                List<RecordType> socmedEntity = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'SocialPost-AFI'];
                newCase.RecordTypeId = socmedEntity[0].Id;
                
                List<Group> gAFI = new List<Group>();
                gAFI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA Indonesia Queue' LIMIT 1];
                /*if(post.Provider == 'Facebook') {
                    gAFI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AFI Facebook Queue' LIMIT 1];
                } else if(post.Provider == 'Twitter') {
                    gAFI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AFI Twitter Queue' LIMIT 1];
                } else if(post.Provider == 'Instagram') {
                    gAFI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AFI Instagram Queue' LIMIT 1];
                }*/
                if(gAFI.size() > 0) {newCase.OwnerId = gAFI[0].Id; newCase.Entity_Backup__c = 'AFI';} else {/* SET OWNER IF QUEUE NOT FOUND */ }
                
            } else if(tagSet.contains('AGI') || tagSet.contains('AXA General') || tagSet.contains('AXA General Indonesia')) {
                List<RecordType> socmedEntity = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'SocialPost-AGI'];
                newCase.RecordTypeId = socmedEntity[0].Id;
                
                List<Group> gAGI = new List<Group>();
                gAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA General Indonesia Queue' LIMIT 1];
                /*if(post.Provider == 'Facebook') {
                    gAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AGI Facebook Queue' LIMIT 1];
                } else if(post.Provider == 'Twitter') {
                    gAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AGI Twitter Queue' LIMIT 1];
                } else if(post.Provider == 'Instagram') {
                    gAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AGI Instagram Queue' LIMIT 1];
                }*/
                if(gAGI.size() > 0) {newCase.OwnerId = gAGI[0].Id; newCase.Entity_Backup__c = 'AGI';} else {/* SET OWNER IF QUEUE NOT FOUND */ }
                
            } else if(tagSet.contains('MAGI') || tagSet.contains('AXA Mandiri General')) {
                List<RecordType> socmedEntity = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'SocialPost-MAGI'];
                newCase.RecordTypeId = socmedEntity[0].Id;
                
                List<Group> gMAGI = new List<Group>();
                gMAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA Mandiri General Queue' LIMIT 1];
                /*if(post.Provider == 'Facebook') {
                    gMAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'MAGI Facebook Queue' LIMIT 1];
                } else if(post.Provider == 'Twitter') {
                    gMAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'MAGI Twitter Queue' LIMIT 1];
                } else if(post.Provider == 'Instagram') {
                    gMAGI = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'MAGI Instagram Queue' LIMIT 1];
                }*/
                if(gMAGI.size() > 0) {newCase.OwnerId = gMAGI[0].Id; newCase.Entity_Backup__c = 'MAGI';} else {/* SET OWNER IF QUEUE NOT FOUND */ }
                
            } else {
                //--Set owner if no one else is found
                //List<Group> gAXA = new List<Group>();
            	//gAXA = [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name = 'AXA SMCC Queue' LIMIT 1];
                //if(gAXA.size() > 0) {newCase.OwnerId = gAXA[0].Id;} 
            }
        }  
        insert newCase;
        return newCase;
    }
    
    //--Tag old case if = 1. recipient = persona, 2. reply from outbound and to self, 3. reply from self social persona
    private Case findParentCase(SocialPost post, SocialPersona persona) {
    		Case parentCase = null;
    		if (!isChat(post) && (isReplyingToOutboundPost(post) && isSocialPostRecipientSameAsPersona(post.ReplyTo, persona)) || (!isReplyingToOutboundPost(post) && isReplyingToSelf(post,persona)) || isReplyingFromSelfSocialPersona(persona, post)) {
    			parentCase = findParentCaseFromPostReply(post);
    			if (isParentCaseValid(parentCase)) { 
                	return parentCase;
            	}
    		}
		
		parentCase = findParentCaseFromPersonaAndRecipient(post, persona);
		if (parentCase == null && isChat(post)) {
			parentCase = findParentCaseOfChatFromPersonaAndRecipient(post, persona);	
		}
		return parentCase;
    }
    
    private boolean isChat(SocialPost post) {
        return post.messageType == 'Private' || post.messageType == 'Direct';
    }
        
    private boolean isParentCaseValid(Case parentCase) {
        return parentCase != null && (!parentCase.IsClosed || caseShouldBeReopened(parentCase));
    }
    
    private Case findParentCaseFromPostReply(SocialPost post) {
        if (post.ReplyTo != null && String.isNotBlank(post.ReplyTo.ParentId)) {
            List<Case> cases = [SELECT Id, IsClosed, Status, ClosedDate FROM Case WHERE Id = :post.ReplyTo.ParentId LIMIT 1];
            if(!cases.isEmpty()) {
                return cases[0];
            }
        }
        return null;
    }
    
    //--Reply from assigned Social Persona
    private boolean isReplyingFromSelfSocialPersona(SocialPersona persona, SocialPost post) {
    		return ((persona.Name == 'AXA Mandiri' || persona.Name == 'AXA Indonesia') && post.ReplyToId != null);
    }
    
    // reply to outbound post
    private boolean isReplyingToOutboundPost(SocialPost post) {
    		return (post != null && post.ReplyTo != null && post.ReplyTo.IsOutbound);
    }
    
    // replyTo.recipient == inboundSocialPost.persona.externalId
    private boolean isSocialPostRecipientSameAsPersona(SocialPost postWithRecipient, SocialPersona persona) {
    		return (postWithRecipient != null && postWithRecipient.Recipient == persona.ExternalId);
    }
    
    // is replying to self
    private boolean isReplyingToSelf(SocialPost post, SocialPersona persona) {
    		return (post != null && 
    				persona != null && 
    				String.isNotBlank(persona.Id) && 
    				post.ReplyTo != null &&
    				String.isNotBlank(post.ReplyTo.PersonaId) &&
    				post.ReplyTo.PersonaId == persona.id);
    }

    private Case findParentCaseFromPersona(SocialPost post, SocialPersona persona) {
        SocialPost lastestInboundPostWithSamePersona = findLatestInboundPostBasedOnPersona(post, persona);
        if (lastestInboundPostWithSamePersona != null) {
            List<Case> cases = [SELECT Id, IsClosed, Status, ClosedDate FROM Case WHERE id = :lastestInboundPostWithSamePersona.parentId LIMIT 1];
            if(!cases.isEmpty()) {
                return cases[0];
            }
        }
        return null;
    }
    
    private Case findParentCaseFromPersonaAndRecipient(SocialPost post, SocialPersona persona) {
        SocialPost lastestInboundPostWithSamePersonaAndRecipient = findLatestInboundPostBasedOnPersonaAndRecipient(post, persona);
        if (lastestInboundPostWithSamePersonaAndRecipient != null) {
            List<Case> cases = [SELECT Id, IsClosed, Status, ClosedDate FROM Case WHERE id = :lastestInboundPostWithSamePersonaAndRecipient.parentId LIMIT 1];
            if(!cases.isEmpty()) {
                return cases[0];
            }
        }
        return null;
    }
    
    private Case findParentCaseOfChatFromPersonaAndRecipient(SocialPost post, SocialPersona persona) {
        SocialPost lastestReplyToPost = findLatestOutboundReplyToPostBasedOnPersonaAndRecipient(post, persona);
        if (lastestReplyToPost != null) {
            List<Case> cases = [SELECT Id, IsClosed, Status, ClosedDate FROM Case WHERE id = :lastestReplyToPost.parentId LIMIT 1];
            if(!cases.isEmpty()) {
                return cases[0];
            }
        }
        return null;
    }

    private void reopenCase(Case parentCase) {
        SObject[] status = [SELECT MasterLabel FROM CaseStatus WHERE IsClosed = false AND IsDefault = true];
        parentCase.Status = ((CaseStatus)status[0]).MasterLabel;
        update parentCase;
    }

    private void matchPost(SocialPost post) {
            if (post.Id != null) return;
        
        performR6PostIdCheck(post);
        
        if (post.Id == null){
            performExternalPostIdCheck(post);
        }
    }
    
    
    private void performR6PostIdCheck(SocialPost post){
        if(post.R6PostId == null) return;
        List<SocialPost> postList = [SELECT Id FROM SocialPost WHERE R6PostId = :post.R6PostId LIMIT 1];
        if (!postList.isEmpty()) {
            post.Id = postList[0].Id;
        }
    }
    
    
    private void performExternalPostIdCheck(SocialPost post) {
        if (post.provider == 'Facebook' && post.messageType == 'Private') return;
        if (post.provider == null || post.externalPostId == null) return;
        List<SocialPost> postList = [SELECT Id FROM SocialPost WHERE ExternalPostId = :post.ExternalPostId AND Provider = :post.provider LIMIT 1];
        if (!postList.isEmpty()) {
            post.Id = postList[0].Id;
        }
    }
    
    
    private SocialPost findReplyTo(SocialPost post, SocialPersona persona) {
        if(post.replyToId != null && post.replyTo == null)
            return findReplyToBasedOnReplyToId(post);
        if(post.responseContextExternalId != null){
            if((post.provider == 'Facebook' && post.messageType == 'Private') || (post.provider == 'Twitter' && post.messageType == 'Direct')) {
                SocialPost replyTo = findReplyToBasedOnResponseContextExternalPostIdAndProvider(post);
                if(replyTo.id != null) 
                    return replyTo;
            }
            return findReplyToBasedOnExternalPostIdAndProvider(post);
        }
        return new SocialPost();
    }

    private SocialPost findReplyToBasedOnReplyToId(SocialPost post){
        List<SocialPost> posts = [SELECT Id, ParentId, IsOutbound, PersonaId, Recipient FROM SocialPost WHERE id = :post.replyToId LIMIT 1];
        if(posts.isEmpty())
            return new SocialPost();
        return posts[0];
    }

    private SocialPost findReplyToBasedOnExternalPostIdAndProvider(SocialPost post){
        List<SocialPost> posts = [SELECT Id, ParentId, IsOutbound, PersonaId, Recipient FROM SocialPost WHERE Provider = :post.provider AND ExternalPostId = :post.responseContextExternalId LIMIT 1];
        if(posts.isEmpty())
            return new SocialPost();
        return posts[0];
    }
    
    private SocialPost findReplyToBasedOnResponseContextExternalPostIdAndProvider(SocialPost post){
        List<SocialPost> posts = [SELECT Id, ParentId, IsOutbound, PersonaId FROM SocialPost WHERE Provider = :post.provider AND Recipient = :post.Recipient AND responseContextExternalId = :post.responseContextExternalId ORDER BY posted DESC NULLS LAST LIMIT 1];
        if(posts.isEmpty())
            return new SocialPost();
        return posts[0];
    }

    private SocialPost findLatestInboundPostBasedOnPersonaAndRecipient(SocialPost post, SocialPersona persona) {
        if (persona != null && String.isNotBlank(persona.Id) && post != null && String.isNotBlank(post.Recipient)) {
            List<SocialPost> posts = [SELECT Id, ParentId FROM SocialPost WHERE Provider = :post.provider AND Recipient = :post.Recipient AND PersonaId = :persona.id AND IsOutbound = false ORDER BY CreatedDate DESC LIMIT 1];
            if (!posts.isEmpty()) {
                return posts[0];
            }
        }
        return null;
    }
    
    private SocialPost findLatestInboundPostBasedOnPersona(SocialPost post, SocialPersona persona) {
        if (persona != null && String.isNotBlank(persona.Id) && post != null) {
            List<SocialPost> posts = [SELECT Id, ParentId FROM SocialPost WHERE Provider = :post.provider AND PersonaId = :persona.id AND IsOutbound = false ORDER BY CreatedDate DESC LIMIT 1];
            if (!posts.isEmpty()) {
                return posts[0];
            }
        }
        return null;
    }
    
    private SocialPost findLatestOutboundReplyToPostBasedOnPersonaAndRecipient(SocialPost post, SocialPersona persona) {
        if (persona != null && String.isNotBlank(persona.Id) && post != null) {
        		List<ExternalSocialAccount> accounts = [SELECT Id FROM ExternalSocialAccount WHERE ExternalAccountId = :post.Recipient];
            if (!accounts.isEmpty()) {
            		ExternalSocialAccount account = accounts[0];
	            List<SocialPost> posts = [SELECT Id, ParentId FROM SocialPost WHERE Provider = :post.provider AND Recipient = :persona.ExternalId AND OutboundSocialAccountId = :account.Id AND IsOutbound = true ORDER BY CreatedDate DESC LIMIT 1];
	            if (!posts.isEmpty()) {
	                return posts[0];
	            }
	        }
        }
        return null;
    }
    
    private void matchPersona(SocialPersona persona) {
        if (persona != null) {
            List<SocialPersona> personaList = new List<SocialPersona>();
            if (persona.Provider != 'Other') {
                if (String.isNotBlank(persona.ExternalId)) {
                    personaList = [SELECT Id, ParentId FROM SocialPersona WHERE
                        Provider = :persona.Provider AND
                        ExternalId = :persona.ExternalId LIMIT 1];
                }
                else if (String.isNotBlank(persona.Name)) {
                    //this is a best-effort attempt to match: persona.Name is not guaranteed to be unique for all networks
                    personaList = [SELECT Id, ParentId FROM SocialPersona WHERE
                        Provider = :persona.Provider AND
                        Name = :persona.Name LIMIT 1];
                }
            }
            else if(persona.Provider == 'Other' && String.isNotBlank(persona.ExternalId) && String.isNotBlank(persona.MediaProvider)) {
                personaList = [SELECT Id, ParentId FROM SocialPersona WHERE
                    MediaProvider = :persona.MediaProvider AND
                    ExternalId = :persona.ExternalId LIMIT 1];
            } else if(persona.Provider == 'Other' && String.isNotBlank(persona.Name) && String.isNotBlank(persona.MediaProvider)) {
                personaList = [SELECT Id, ParentId FROM SocialPersona WHERE
                    MediaProvider = :persona.MediaProvider AND
                    Name = :persona.Name LIMIT 1];
            }
                    
            if (!personaList.isEmpty()) {
                persona.Id = personaList[0].Id;
                persona.ParentId = personaList[0].ParentId;
            }
        }
    }

    private void createPersona(SocialPost post, SocialPersona persona) {
        if (persona == null || String.isNotBlank(persona.Id) || !isThereEnoughInformationToCreatePersona(persona))
            return;

        SObject parent = createPersonaParent(post, persona);
        persona.ParentId = parent.Id;
        insert persona;
    }

    private boolean isThereEnoughInformationToCreatePersona(SocialPersona persona) {
        return String.isNotBlank(persona.Name) && 
               String.isNotBlank(persona.Provider) && 
               String.isNotBlank(persona.MediaProvider);
    }
    
    private boolean shouldCreateCase(SocialPost post, Map<String, Object> rawData) {
        return !isUnsentParent(rawData) && (!hasSkipCreateCaseIndicator(rawData) || hasPostLabelsThatCreateCase(post));
    }
    
    private boolean isUnsentParent(Map<String, Object> rawData) {
        Object unsentParent = rawData.get('unsentParent');
        return unsentParent != null && 'true'.equalsIgnoreCase(String.valueOf(unsentParent));
    }

    private boolean hasSkipCreateCaseIndicator(Map<String, Object> rawData) {
        Object skipCreateCase = rawData.get('skipCreateCase');
        return skipCreateCase != null && 'true'.equalsIgnoreCase(String.valueOf(skipCreateCase));
    }
    
    private boolean hasPostLabelsThatCreateCase(SocialPost post){
        Set<String> postLabels = getPostLabels(post);
        postLabels.retainAll(getPostLabelsThatCreateCase());
        return !postLabels.isEmpty();
    }
    
    //--This is used using previous version of 'postLabels' which is 'postTags'
    private Set<String> getPostLabels(SocialPost post){
        Set<String> postLabels = new Set<String>();
        if(post.postTags != null)
            postLabels.addAll(post.postTags.split(',', 0));
        return postLabels;
    }

    global String getPersonaFirstName(SocialPersona persona) {
        String name = getPersonaName(persona);      
        String firstName = '';
        if (name.contains(' ')) {
            firstName = name.substringBeforeLast(' ');
        }
        firstName = firstName.abbreviate(40);
        return firstName;
    }
    
    global String getPersonaLastName(SocialPersona persona) {   
        String name = getPersonaName(persona);   
        String lastName = name;
        if (name.contains(' ')) {
            lastName = name.substringAfterLast(' ');
        }
        lastName = lastName.abbreviate(80);
        return lastName;
    }
    
    private String getPersonaName(SocialPersona persona) {
        String name = persona.Name.trim();
        if (String.isNotBlank(persona.RealName)) {
            name = persona.RealName.trim();
        }
        return name;
    }
    
    //--Adding condition, default Persona Parent is Anonymous (unless new condition to compare Contact viable), for each entity has unique anonymous contact
    global virtual SObject createPersonaParent(SocialPost post, SocialPersona persona) {
        String firstName = getPersonaFirstName(persona); 
        String lastName = getPersonaLastName(persona);
        
        /*
        Contact contact = new Contact(LastName = lastName, FirstName = firstName);
        String defaultAccountId = getDefaultAccountId();
        if (defaultAccountId != null)
            contact.AccountId = defaultAccountId;
        insert contact;
        */
        
        String s = post.PostTags;
        System.debug('PostTag -- EntityPersona : ' + s);
        Set<String> tagSet = new Set<String>();
        if(s != null) {
            if(s.contains(',')) { 
                List<String> tagList = s.split(',');
                tagSet.addAll(tagList);
            } else {
                tagSet.add(s);
            }
        }
        
        List<Contact> contactList = new List<Contact>();
        if(tagSet.contains('AMFS') || tagSet.contains('AXA Mandiri')) {
            contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AMFS%'];
        } else if(tagSet.contains('AFI') || tagSet.contains('AXA Financial') || tagSet.contains('AXA Financial Indonesia')) {
            contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AFI%'];
        } else if(tagSet.contains('AGI') || tagSet.contains('AXA General') || tagSet.contains('AXA General Indonesia')) {
            contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous AGI%'];
        } else if(tagSet.contains('MAGI') || tagSet.contains('AXA Mandiri General')) {
            contactList = [SELECT Id, LastName, AccountId FROM Contact WHERE LastName LIKE '%Anonymous MAGI%'];
        }
        System.debug('contactList : ' + contactList);
        
        Contact contact = new Contact();
        Account accTemp = [SELECT Id FROM Account WHERE Name = 'Anonymous Social Media'];
        if(contactList.size() > 0) {contact = contactList[0];} else {contact.LastName = 'Anonymous'; contact.AccountId = accTemp.Id ; insert contact;}
        System.debug('contact[0] : ' + contact);
        
        return contact;
    }
            
    private void handlePostAttachments(SocialPost post, Map<String, Object> rawData) {
        String attachmentRawData;
        if(Test.isRunningTest()) {attachmentRawData = String.valueOf(rawData.get('mediaUrls'));} else {attachmentRawData = JSON.serialize(rawData.get('mediaUrls'));}
		if (String.isNotBlank(attachmentRawData)) {
        	List<PostAttachment> attachments = (List<PostAttachment>) JSON.deserialize(attachmentRawData, List<PostAttachment>.class);
        	if (attachments != null && !attachments.isEmpty()) {
        		createAttachments(post, attachments);
    		}
    	}
    }
    
    private void createAttachments(SocialPost post, List<PostAttachment> attachments) {
        List<ContentVersion> contentVersions = new List<ContentVersion>();
        for(PostAttachment attachment : attachments) {
            if (String.isNotBlank(attachment.mediaUrl) && attachment.mediaUrl != null && attachment.mediaUrl.length() <= ContentVersion.ContentUrl.getDescribe().getLength()) {
                ContentVersion contentVersion = new ContentVersion();
                contentVersion.contentUrl = attachment.mediaUrl;
                contentVersion.contentLocation = 'L';
                contentVersions.add(contentVersion);
            }
        }
        if (!contentVersions.isEmpty()) {
	        insert(contentVersions);
	        createLinksForAttachmentsToSocialPost(post, contentVersions);
        }
    }
    
    private void createLinksForAttachmentsToSocialPost(SocialPost post, List<ContentVersion> contentVersions) {
        List<Id> versionIds = new List<Id>(new Map<Id, ContentVersion>(contentVersions).keySet());
        List<ContentDocument> contentDocuments = [SELECT Id FROM ContentDocument WHERE LatestPublishedVersionId IN :versionIds];
        List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
        for(ContentDocument contentDocument : contentDocuments) {
            ContentDocumentLink contentDocLink = new ContentDocumentLink();
            contentDocLink.contentDocumentId = contentDocument.Id;
            contentDocLink.linkedEntityId = post.Id;
            contentDocLink.shareType = 'I';
            contentDocLink.visibility = 'AllUsers';
            contentDocumentLinks.add(contentDocLink);
        }
        if (!contentDocumentLinks.isEmpty()) {
        	insert(contentDocumentLinks);
    	}
    }

    public class PostAttachment {
        public String mediaType;
        public String mediaUrl;
        
        public PostAttachment(String mediaType, String mediaUrl) {
            this.mediaType = mediaType;
            this.mediaUrl = mediaUrl;
        }
    }
}