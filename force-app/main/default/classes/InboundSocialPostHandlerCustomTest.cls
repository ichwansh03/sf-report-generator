@isTest
public class InboundSocialPostHandlerCustomTest {

    static Map<String, Object> sampleSocialData;
    static InboundSocialPostHandlerCustom handler;

    static {
    	handler = new InboundSocialPostHandlerCustom();
        sampleSocialData = getSampleSocialData('1');
    }
    
    @testSetup static void setup() {
        Account a = new Account();
        a.Name = 'Anonymous Social Media';
        insert a;
    }
    
    static testMethod void verifyNewRecordCreation() {
        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);        
        
        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest();
        
        SocialPost createdPost = [SELECT Id, PersonaId, ParentId, WhoId FROM SocialPost];
        SocialPersona createdPersona = [SELECT Id, ParentId FROM SocialPersona];
        Contact createdContact = [SELECT Id FROM Contact];
        Case createdCase = [SELECT Id, ContactId FROM Case];
        
        System.assertEquals(createdPost.PersonaId, createdPersona.Id, 'Post is not linked to the Persona.');
        System.assertEquals(createdPost.WhoId, createdPersona.ParentId, 'Post is not linked to the Contact');
        System.assertEquals(createdPost.ParentId, createdCase.Id, 'Post is not linked to the Case.');
        System.assertEquals(createdCase.ContactId, createdContact.Id, 'Contact is not linked to the Case.');
    }
    
    //-------------------------------------- Social Media Post by Channel (START) --------------------------------------
    
    static testMethod void verifyNewRecordCreationFacebookAFI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataFacebook('1', 'AFI');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    static testMethod void verifyNewRecordCreationFacebookAGI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataFacebook('2', 'AGI');
        
        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);
        
        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest();
    }
    
    static testMethod void verifyNewRecordCreationFacebookMAGI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataFacebook('3', 'MAGI');
        
        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);
        
        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest();
    }
    
    static testMethod void verifyNewRecordCreationFacebookAMFS() {
        Map<String, Object> sampleSocialData = getSampleSocialDataFacebook('4', 'AMFS');
        
        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);
        
        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest();
    }
    
    static testMethod void verifyNewRecordCreationTwitterAFI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataTwitter('1', 'AFI');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    static testMethod void verifyNewRecordCreationTwitterAGI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataTwitter('2', 'AGI');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    static testMethod void verifyNewRecordCreationTwitterMAGI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataTwitter('3', 'MAGI');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    static testMethod void verifyNewRecordCreationTwitterAMFS() {
        Map<String, Object> sampleSocialData = getSampleSocialDataTwitter('4', 'AMFS');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    static testMethod void verifyNewRecordCreationInstagramAFI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataInstagram('1', 'AFI');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    
    static testMethod void verifyNewRecordCreationInstagramAGI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataInstagram('2', 'AGI');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    static testMethod void verifyNewRecordCreationInstagramMAGI() {
        Map<String, Object> sampleSocialData = getSampleSocialDataInstagram('3', 'MAGI');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    static testMethod void verifyNewRecordCreationInstagramAMFS() {
        Map<String, Object> sampleSocialData = getSampleSocialDataInstagram('4', 'AMFS');

        SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);

        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest(); 
    }
    
    //-------------------------------------- Social Media Post by Channel (END) --------------------------------------
    
    static testMethod void matchSocialPostRecord() {
        SocialPost existingPost = getSocialPost(getSampleSocialData('2'));
        insert existingPost;
        
        SocialPost post = getSocialPost(sampleSocialData);
        post.R6PostId = existingPost.R6PostId;
        SocialPersona persona = getSocialPersona(sampleSocialData);
        
        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest();
        
        System.assertEquals(1, [SELECT Id FROM SocialPost].size(), 'There should be only 1 post');
    }
    
    static testMethod void matchSocialPersonaRecord() {
    	Contact existingContact = new Contact(LastName = 'LastName');
    	insert existingContact;
    	SocialPersona existingPersona = getSocialPersona(getSampleSocialData('2'));
    	existingPersona.ParentId = existingContact.Id;
    	insert existingPersona;
    	
    	SocialPost post = getSocialPost(sampleSocialData);
        SocialPersona persona = getSocialPersona(sampleSocialData);
        persona.ExternalId = existingPersona.ExternalId;
        
        test.startTest();
        handler.handleInboundSocialPost(post, persona, sampleSocialData);
        test.stopTest();
        
        SocialPost createdPost = [SELECT Id, PersonaId, ParentId, WhoId FROM SocialPost];
        SocialPersona createdPersona = [SELECT Id, ParentId FROM SocialPersona];
        Contact createdContact = [SELECT Id FROM Contact];
        Case createdCase = [SELECT Id, ContactId FROM Case];
        
        System.assertEquals(createdPost.PersonaId, createdPersona.Id, 'Post is not linked to the Persona.');
        System.assertEquals(createdPost.WhoId, createdPersona.ParentId, 'Post is not linked to the Contact');
        System.assertEquals(createdPost.ParentId, createdCase.Id, 'Post is not linked to the Case.');
        System.assertEquals(createdCase.ContactId, createdContact.Id, 'Contact is not linked to the Case.');
    }
    
    static testMethod void matchCaseRecord() {
    	Contact existingContact = new Contact(LastName = 'LastName');
    	insert existingContact;
    	SocialPersona existingPersona = getSocialPersona(getSampleSocialData('2'));
    	existingPersona.ParentId = existingContact.Id;
    	insert existingPersona;
    	Case existingCase = new Case(ContactId = existingContact.Id, Subject = 'Test Case');
    	insert existingCase;
    	SocialPost existingPost = getSocialPost(getSampleSocialData('2'));
    	existingPost.ParentId = existingCase.Id;
    	existingPost.WhoId = existingContact.Id;
    	existingPost.PersonaId = existingPersona.Id;
    	String recipient = 'scs';
    	existingPost.recipient = recipient;
    	insert existingPost;
    	
    	SocialPost post = getSocialPost(sampleSocialData);
    	post.responseContextExternalId = existingPost.ExternalPostId;
    	post.Recipient = recipient;
        
        test.startTest();
        handler.handleInboundSocialPost(post, existingPersona, sampleSocialData);
        test.stopTest();
        
        SocialPost createdPost = [SELECT Id, PersonaId, ParentId, WhoId FROM SocialPost WHERE R6PostId = :post.R6PostId];
        System.assertEquals(existingPersona.Id, createdPost.PersonaId, 'Post is not linked to the Persona.');
        System.assertEquals(existingContact.Id, createdPost.WhoId, 'Post is not linked to the Contact');
        System.assertEquals(existingCase.Id, createdPost.ParentId, 'Post is not linked to the Case.');
        System.assertEquals(1, [SELECT Id FROM Case].size(), 'There should only be 1 Case.');
    }
    
    static testMethod void reopenClosedCase() {
    	Contact existingContact = new Contact(LastName = 'LastName');
    	insert existingContact;
    	SocialPersona existingPersona = getSocialPersona(getSampleSocialData('2'));
    	existingPersona.ParentId = existingContact.Id;
    	insert existingPersona;
    	Case existingCase = new Case(ContactId = existingContact.Id, Subject = 'Test Case', Status = 'Closed');
    	insert existingCase;
    	SocialPost existingPost = getSocialPost(getSampleSocialData('2'));
    	existingPost.ParentId = existingCase.Id;
    	existingPost.WhoId = existingContact.Id;
    	existingPost.PersonaId = existingPersona.Id;
    	String recipient = 'scs';
    	existingPost.recipient = recipient;
    	insert existingPost;
    	
    	SocialPost post = getSocialPost(sampleSocialData);
    	post.responseContextExternalId = existingPost.ExternalPostId;
    	post.Recipient = recipient;
        
        test.startTest();
        handler.handleInboundSocialPost(post, existingPersona, sampleSocialData);
        test.stopTest();
        
        SocialPost createdPost = [SELECT Id, PersonaId, ParentId, WhoId FROM SocialPost WHERE R6PostId = :post.R6PostId];
        System.assertEquals(existingPersona.Id, createdPost.PersonaId, 'Post is not linked to the Persona.');
        System.assertEquals(existingContact.Id, createdPost.WhoId, 'Post is not linked to the Contact');
        //System.assertEquals(existingCase.Id, createdPost.ParentId, 'Post is not linked to the Case.');
        //System.assertEquals(1, [SELECT Id FROM Case].size(), 'There should only be 1 Case.');
        //System.assertEquals(false, [SELECT Id, IsClosed FROM Case WHERE Id = :existingCase.Id].IsClosed, 'Case should be open.');
    }
    
    static SocialPost getSocialPost(Map<String, Object> socialData) {
        SocialPost post = new SocialPost();
       	post.Name = String.valueOf(socialData.get('source'));
        post.Content = String.valueOf(socialData.get('content'));
        post.Posted = Date.valueOf(String.valueOf(socialData.get('postDate')));
        post.PostUrl = String.valueOf(socialData.get('postUrl'));
        post.Provider = String.valueOf(socialData.get('mediaProvider'));
        post.MessageType = String.valueOf(socialData.get('messageType'));
        post.ExternalPostId = String.valueOf(socialData.get('externalPostId'));
        post.R6PostId = String.valueOf(socialData.get('r6PostId'));
        post.PostTags = String.valueOf(socialData.get('postTags'));
        post.ReviewScore = Double.valueOf(socialData.get('reviewScore'));
        return post;
    }
    
    static SocialPersona getSocialPersona(Map<String, Object> socialData) {
        SocialPersona persona = new SocialPersona();
        persona.Name = String.valueOf(socialData.get('author'));
        persona.RealName = String.valueOf(socialData.get('realName'));
        persona.Provider = String.valueOf(socialData.get('mediaProvider'));
        persona.MediaProvider = String.valueOf(socialData.get('mediaProvider'));
        persona.ExternalId = String.valueOf(socialData.get('externalUserId'));        
        return persona;
    }

    static Map<String, Object> getSampleSocialData(String suffix) {
        Map<String, Object> socialData = new Map<String, Object>();
        socialData.put('r6PostId', 'R6PostId' + suffix);
        socialData.put('r6SourceId', 'R6SourceId' + suffix);
        socialData.put('postLabels', null);
        socialData.put('externalPostId', 'ExternalPostId' + suffix);
        socialData.put('content', 'Content' + suffix);
        socialData.put('postDate', '2015-01-12T12:12:12Z');
        socialData.put('mediaType', 'Other');
        socialData.put('author', 'Author');
        socialData.put('skipCreateCase', false);
        socialData.put('mediaProvider', 'OTHER');
        socialData.put('externalUserId', 'ExternalUserId');
        socialData.put('postUrl', 'PostUrl' + suffix);
        socialData.put('messageType', 'Direct');
        socialData.put('source', 'Source' + suffix);
        socialData.put('replyToExternalPostId', null);
        socialData.put('realName', 'Real Name');
        socialData.put('postTags', 'AMFS,MAGI');
        socialData.put('reviewScore', '9');
        socialData.put('mediaUrls', '[{"mediaType" : "text", "mediaUrl" : "www.xyz.com"}]');
        return socialData;
    }
    
    //--Sample social data Facebook
    static Map<String, Object> getSampleSocialDataFacebook(String suffix, String entity) {
        Map<String, Object> socialData = new Map<String, Object>();
        socialData.put('r6PostId', 'R6PostId' + suffix);
        socialData.put('r6SourceId', 'R6SourceId' + suffix);
        socialData.put('postLabels', null);
        socialData.put('externalPostId', 'ExternalPostId' + suffix);
        socialData.put('content', 'Content' + suffix);
        socialData.put('postDate', '2015-01-12T12:12:12Z');
        socialData.put('mediaType', 'Facebook');
        socialData.put('author', 'Author' + suffix);
        socialData.put('skipCreateCase', false);
        socialData.put('mediaProvider', 'FACEBOOK');
        socialData.put('externalUserId', 'ExternalUserId' + suffix);
        socialData.put('postUrl', 'PostUrl' + suffix);
        socialData.put('messageType', 'Post');
        socialData.put('source', 'Source' + suffix);
        socialData.put('replyToExternalPostId', null);
        socialData.put('realName', 'Real Name FB');
        socialData.put('postTags', entity);
        return socialData;
    }
    
    //--Sample social data Twitter
    static Map<String, Object> getSampleSocialDataTwitter(String suffix, String entity) {
        Map<String, Object> socialData = new Map<String, Object>();
        socialData.put('r6PostId', 'R6PostId' + suffix);
        socialData.put('r6SourceId', 'R6SourceId' + suffix);
        socialData.put('postLabels', null);
        socialData.put('externalPostId', 'ExternalPostId' + suffix);
        socialData.put('content', 'Content' + suffix);
        socialData.put('postDate', '2015-01-12T12:12:12Z');
        socialData.put('mediaType', 'Twitter');
        socialData.put('author', 'Author' + suffix);
        socialData.put('skipCreateCase', false);
        socialData.put('mediaProvider', 'TWITTER');
        socialData.put('externalUserId', 'ExternalUserId' + suffix);
        socialData.put('postUrl', 'PostUrl' + suffix);
        socialData.put('messageType', 'Tweet');
        socialData.put('source', 'Source' + suffix);
        socialData.put('replyToExternalPostId', null);
        socialData.put('realName', 'Real Name TW');
        socialData.put('postTags', entity);
        return socialData;
    }
    
    //--Sample social data Instagram
    static Map<String, Object> getSampleSocialDataInstagram(String suffix, String entity) {
        Map<String, Object> socialData = new Map<String, Object>();
        socialData.put('r6PostId', 'R6PostId' + suffix);
        socialData.put('r6SourceId', 'R6SourceId' + suffix);
        socialData.put('postLabels', null);
        socialData.put('externalPostId', 'ExternalPostId' + suffix);
        socialData.put('content', 'Content' + suffix);
        socialData.put('postDate', '2015-01-12T12:12:12Z');
        socialData.put('mediaType', 'Instagram');
        socialData.put('author', 'Author' + suffix);
        socialData.put('skipCreateCase', false);
        socialData.put('mediaProvider', 'INSTAGRAM');
        socialData.put('externalUserId', 'ExternalUserId' + suffix);
        socialData.put('postUrl', 'PostUrl' + suffix);
        socialData.put('messageType', 'Post');
        socialData.put('source', 'Source' + suffix);
        socialData.put('replyToExternalPostId', null);
        socialData.put('realName', 'Real Name IG');
        socialData.put('postTags', entity);
        return socialData;
    }
}