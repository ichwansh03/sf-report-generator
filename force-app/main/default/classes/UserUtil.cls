public class UserUtil {
    private static User currentUser;

    public static User getCurrentUser() {
        if (currentUser == null) {
            currentUser = [select id, Entity__c from user where id = :UserInfo.getUserId()];
        }
        return currentUser;
    }
}