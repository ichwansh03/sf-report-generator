@RestResource(urlMapping='/SmartComment/v1/*')
global class CaseComplaintCommentAPI {

    global class CommentResponse {
        public Boolean success {get;set;}
        public List<String> errors {get;set;}
        public String id {get;set;}
    }

    @HttpPost
    global static CommentResponse addComment(CaseComment new_comment) {
        Savepoint sp = Database.setSavepoint();
        CommentResponse commentResponseObj;
        System.debug('***CaseComplaintCommentAPI addComment new_comment :' + new_comment);
        try {
            if (new_comment != null) {
                insert new_comment;
                commentResponseObj = new CommentResponse();
                commentResponseObj.success = true;
                commentResponseObj.id = new_comment.Id;
                commentResponseObj.errors = null;
            }
        }
        catch (Exception e) {
            Database.rollback(sp);
            commentResponseObj = new CommentResponse(); commentResponseObj.success = false; commentResponseObj.id = null; commentResponseObj.errors = new List<String>{e.getMessage() + '. ' + e.getStackTraceString()};
        }
        return commentResponseObj;
    }
}