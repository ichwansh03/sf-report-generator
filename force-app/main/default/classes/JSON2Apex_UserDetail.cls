public class JSON2Apex_UserDetail {

	public class PrimaryPresence {
		public String startTime;
		public String endTime;
		public String systemPresence;
		public String organizationPresenceId;
        public String userId;
	}

	public class UserDetails {
		public String userId;
		public List<PrimaryPresence> primaryPresence;
	}

	public List<UserDetails> userDetails;

	
	public static JSON2Apex_UserDetail parse(String json) {
		return (JSON2Apex_UserDetail) System.JSON.deserialize(json, JSON2Apex_UserDetail.class);
	}
}