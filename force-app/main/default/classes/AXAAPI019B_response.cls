/* 
*  @author  Ranti Dwi Putri <rdpranntiii@gmail.com> 
*  @Desc    Convert Json parse to data
*  @Class   AXAAPI019B_response 
*  @Return  Array
*/ 
public class AXAAPI019B_response {
    
    public AXAAPI019B_response(){}
    
	public String status {get;set;} 
	public String message {get;set;} 
	public Data data {get;set;} 
    
	public class Data { 
        Public Data(){}
        public string analyzerScore {get;set;}
        public string commentCount {get;set;}
        public string content {get;set;}
        public string count_Post_c {get;set;}
        public datetime created_Date2_c {get;set;}
        public datetime created_Date_Text_c {get;set;}
        public string createdById {get;set;}
        public datetime createdDate {get;set;}
        public string engagementLevel {get;set;}
        public string externalPostId {get;set;}
        public string handle {get;set;}
        public datetime harvestDate {get;set;}
        public string id {get;set;}
        public string inboundLinkCount {get;set;}
        public string isDeleted {get;set;}
        public boolean isOutbound {get;set;}
        public string language {get;set;}
        public string lastModifiedById {get;set;}
        public datetime lastModifiedDate {get;set;}
        public string likesAndVotes {get;set;}
        public string mediaProvider {get;set;}
        public string mediaType {get;set;}
        public string messageType {get;set;}
        public string name {get;set;}
        public string over_SLA_SosMed_AFI_c {get;set;}
        public string ownerId {get;set;}
        public string parentId {get;set;}
        public string personaId {get;set;}
        public string post_to_Create_c {get;set;}
        public string post_to_Create_Text_c {get;set;}
        public datetime posted {get;set;}
        public datetime posted_Date_Text_c {get;set;}
        public string postTags {get;set;}
        public string postUrl {get;set;}
        public string postUrlCompact {get;set;}
        public string provider {get;set;}
        public string r6PostId {get;set;}
        public string r6SourceId {get;set;}
        public string r6TopicId {get;set;}
        public string recipient {get;set;}
        public string recipientType {get;set;}
        public string replyToId {get;set;}
        public string responseContextExternalId {get;set;}
        public string sentiment {get;set;}
        public string shares {get;set;}
        public string spamRating {get;set;}
        public datetime systemModstamp {get;set;}
        public string target_Status_c {get;set;}
        public string target_TAT_c {get;set;}
        public string threadSize {get;set;}
        public string topicProfileName {get;set;}
        public string topicType {get;set;}
        public string uniqueCommentors {get;set;}
        public string viewCount {get;set;}
        public string whoId {get;set;}
        public string whoName {get;set;}
        public string Notes {get;set;}
        public string headline {get;set;}
        public string parentInfo {get;set;}
        public string replyInfo {get;set;}
        public string DeletedById {get;set;}
        public string DeletedName {get;set;}
        public string HiddenById {get;set;}
        public string HiddenByName {get;set;}
        public string OutboundSocialAccountName {get;set;}
        public string outboundSocialAccountId {get;set;}
        public string SourceTags {get;set;}
        public string status {get;set;}
        public string StatusMessage {get;set;}
        public string createdName {get;set;}
        public string modifiedName {get;set;}
        public string AssignedTo {get;set;}
        public string attachmentType {get;set;}
        public string AttachmentUrl {get;set;}
        public string Classification {get;set;}
        public string ownerName {get;set;}
        public string KeywordGroupName {get;set;}
        public string LikedBy {get;set;}
        public string OutboundSocialAccount {get;set;}
        public string TruncatedContent {get;set;}
        public string PostPriority {get;set;}
        public string ReviewScore {get;set;}
        public string ReviewedStatus {get;set;}
        public string ReviewScale {get;set;}
        public datetime First_Response_Date_In_Datetime_c {get;set;}
        public datetime PostDate_Temporary_c {get;set;}
        public datetime Last_Response_Date_c {get;set;}
        public datetime Target_Datetime_c {get;set;}  
        

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if ( text == 'analyzerScore') {
                            analyzerScore = parser.getText();
                        } else if ( text == 'commentCount') {
                            commentCount = parser.getText();
                        } else if ( text == 'content') {
                            content = parser.getText(); 
                            content = content.replace('\n','<br/>');
                        } else if ( text == 'count_Post__c') {
                            count_Post_c = parser.getText();
                        } else if ( text == 'created_Date2__c') {
                            created_Date2_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'created_Date_Text__c') {
                            created_Date_Text_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'createdById') {
                            createdById = parser.getText();
                            if (createdById != null) createdName = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'user', 'name');
                        } else if ( text == 'createdDate') {
                            createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'engagementLevel') {
                            engagementLevel = parser.getText();
                        } else if ( text == 'externalPostId') {
                            externalPostId = parser.getText();
                        } else if ( text == 'handle') {
                            handle = parser.getText();
                        } else if ( text == 'harvestDate') {
                            harvestDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'id') {
                            id = parser.getText();
                            if (id != null ) {
                                Notes = AXAAPI_UtilityClass.getsObjectNameById(id, 'SocialPost', 'Notes');
                                DeletedById = AXAAPI_UtilityClass.getsObjectNameById(id, 'SocialPost', 'DeletedById');
                                if (DeletedById != null) DeletedName = AXAAPI_UtilityClass.getsObjectNameById(DeletedById, 'user', 'name');
                                HiddenById = AXAAPI_UtilityClass.getsObjectNameById(id, 'SocialPost', 'HiddenById');
                                if (HiddenById != null)  HiddenByName = AXAAPI_UtilityClass.getsObjectNameById(HiddenById, 'user', 'name');
                            }  
                        } else if ( text == 'inboundLinkCount') {
                            inboundLinkCount = parser.getText();
                        } else if ( text == 'isDeleted') {
                            isDeleted = parser.getText();
                        } else if ( text == 'isOutbound') {
                            isOutbound = AXAAPI_UtilityClass.stringToBoolean(parser.getText());
                            
                        } else if ( text == 'language') {
                            language = parser.getText();
                        } else if ( text == 'lastModifiedById') {
                            lastModifiedById = parser.getText();
                            if (lastModifiedById != null) modifiedName = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'user', 'name');
                        } else if ( text == 'lastModifiedDate') {
                            lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'likesAndVotes') {
                            likesAndVotes = parser.getText();
                        } else if ( text == 'mediaProvider') {
                            mediaProvider = parser.getText();
                        } else if ( text == 'mediaType') {
                            mediaType = parser.getText();
                        } else if ( text == 'messageType') {
                            messageType = parser.getText();
                        } else if ( text == 'name') {
                            name = parser.getText();
                        } else if ( text == 'over_SLA_SosMed_AFI__c') {
                            over_SLA_SosMed_AFI_c = parser.getText();
                        } else if ( text == 'ownerId') {
                            ownerId = parser.getText();
                            if (ownerId != null) ownerName = AXAAPI_UtilityClass.getsObjectNameById(ownerId, 'User', 'Name');
                        } else if ( text == 'parentId') {
                            parentId = parser.getText();
                            if (parentId != null) {
                                if (parentId.left(3) == Schema.SObjectType.Question.getKeyPrefix()) { 
                                	parentInfo = AXAAPI_UtilityClass.getsObjectNameById(parentId, 'Question', 'Name'); 
                                } else  if (parentId.left(3) == Schema.SObjectType.case.getKeyPrefix()) {
                                                                          
                                    /* AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(parentId);   
									if(getData != null && getData.data != null ) parentInfo = getData.data.caseNumber;  */
                                    parentInfo = AXAAPI_UtilityClass.getsObjectNameById(parentId, 'case', 'caseNumber'); 
                                } 
                            }
                        } else if ( text == 'personaId') {
                            personaId = parser.getText();
                        } else if ( text == 'post_to_Create__c') {
                            post_to_Create_c = parser.getText();
                        } else if ( text == 'post_to_Create_Text__c') {
                            post_to_Create_Text_c = parser.getText();
                        } else if ( text == 'posted') {
                            posted = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'posted_Date_Text__c') {
                            posted_Date_Text_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'postTags') {
                            postTags = parser.getText();
                        } else if ( text == 'postUrl') {
                            postUrl = parser.getText();
                            if (postUrl.length() > 50) {
                              postUrlCompact = postUrl;  
                               postUrlCompact = postUrlCompact.substring(0,47)+'...'; 
                            }
                        } else if ( text == 'provider') {
                            provider = parser.getText();
                        } else if ( text == 'r6PostId') {
                            r6PostId = parser.getText();
                        } else if ( text == 'r6SourceId') {
                            r6SourceId = parser.getText();
                        } else if ( text == 'r6TopicId') {
                            r6TopicId = parser.getText();
                        } else if ( text == 'recipient') {
                            recipient = parser.getText();
                        } else if ( text == 'recipientType') {
                            recipientType = parser.getText();
                        } else if ( text == 'replyToId') {
                            replyToId = parser.getText();
                            if (replyToId != null) replyInfo = AXAAPI_UtilityClass.getsObjectNameById(replyToId, 'socialPost', 'Name');
                        } else if ( text == 'responseContextExternalId') {
                            responseContextExternalId = parser.getText();
                        } else if ( text == 'sentiment') {
                            sentiment = parser.getText();
                        } else if ( text == 'shares') {
                            shares = parser.getText();
                        } else if ( text == 'spamRating') {
                            spamRating = parser.getText();
                        } else if ( text == 'systemModstamp') {
                            systemModstamp = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'target_Status__c') {
                            target_Status_c = parser.getText();
                        } else if ( text == 'target_TAT__c') {
                            target_TAT_c = parser.getText();
                        } else if ( text == 'threadSize') {
                            threadSize = parser.getText();
                        } else if ( text == 'topicProfileName') {
                            topicProfileName = parser.getText();
                        } else if ( text == 'topicType') {
                            topicType = parser.getText();
                        } else if ( text == 'uniqueCommentors') {
                            uniqueCommentors = parser.getText();
                        } else if ( text == 'viewCount') {
                            viewCount = parser.getText();
                        } else if ( text == 'whoId') {
                            whoId = parser.getText();
                            if (whoId != null) {
                                if (whoId.left(3) == Schema.SObjectType.Account.getKeyPrefix()) { 
                                	whoName = AXAAPI_UtilityClass.getsObjectNameById(whoId, 'Account', 'Name'); 
                                }else  if (whoId.left(3) == Schema.SObjectType.Lead.getKeyPrefix()) { 
                                	whoName = AXAAPI_UtilityClass.getsObjectNameById(whoId, 'Lead', 'Name'); 
                                }else  if (whoId.left(3) == Schema.SObjectType.Contact.getKeyPrefix()) {
                                	whoName = AXAAPI_UtilityClass.getsObjectNameById(whoId, 'Contact', 'Name'); 
                                }
                            }
                        } else if ( text == 'headline') {
                            headline = parser.getText(); 
                        }else if ( text == 'SourceTags') {
                            SourceTags = parser.getText(); 
                        }else if ( text == 'status') {
                            status = parser.getText(); 
                        }else if ( text == 'StatusMessage') {
                            StatusMessage = parser.getText(); 
                        }else if ( text == 'assignedTo') {
                            assignedTo = parser.getText(); 
                        }else if ( text == 'attachmentType') {
                            attachmentType = parser.getText(); 
                        }else if ( text == 'AttachmentUrl') {
                            AttachmentUrl = parser.getText(); 
                        }else if ( text == 'Classification') {
                            Classification = parser.getText(); 
                        }else if ( text == 'KeywordGroupName') {
                            KeywordGroupName = parser.getText(); 
                        }else if ( text == 'LikedBy') {
                            LikedBy = parser.getText(); 
                        }else if ( text == 'outboundSocialAccountId') {
                            outboundSocialAccountId = parser.getText(); 
                            if (outboundSocialAccountId != null && outboundSocialAccountId != '') OutboundSocialAccountName = AXAAPI_UtilityClass.getsObjectNameById(outboundSocialAccountId,'ExternalSocialAccount','Username');
                            system.debug('::: outboundSocialAccountId:'+outboundSocialAccountId);
                            system.debug('::: OutboundSocialAccountName:'+OutboundSocialAccountName);
                        }else if ( text == 'TruncatedContent') {
                            TruncatedContent = parser.getText(); 
                        }else if ( text == 'PostPriority') {
                            PostPriority = parser.getText(); 
                        }else if ( text == 'ReviewScore') {
                            ReviewScore = parser.getText(); 
                        }else if ( text == 'ReviewedStatus') {
                            ReviewedStatus = parser.getText(); 
                        }else if ( text == 'ReviewScale') {
                            ReviewScale = parser.getText(); 
                        }else if ( text == 'First_Response_Date_In_Datetime__c') {
                            First_Response_Date_In_Datetime_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        } else if ( text == 'PostDate_Temporary__c') {
                            PostDate_Temporary_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }else if ( text == 'Last_Response_Date__c') {
                            Last_Response_Date_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }else if ( text == 'Target_Datetime__c') {
                            Target_Datetime_c = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
                        }else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					} 
				}
			}
		}
	} 

	public AXAAPI019B_response(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'status') {
						status = parser.getText();
					} else if (text == 'message') {
						message = parser.getText();
					} else if (text == 'data') {
						data = new Data(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI019B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	} 
    
	public static AXAAPI019B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI019B_response(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	} 
}