public class CreateEmailSMSLogWhenCaseClosedHelper {
    // Added by Dimas Support MII 02/05/2025. Static variable to prevent CreateEmailSmsLogQueue process the same Case Id Twice in one execution
	public static Set<Id> processedCaseId = new Set<Id>();
}