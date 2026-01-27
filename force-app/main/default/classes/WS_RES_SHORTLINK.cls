public class WS_RES_SHORTLINK {
	public Body Body;

	public class HaveCommunicatedMessage {
		public String messageID;
		public String replyTo;
		public String additionalRk;
		public String deliveryStatusCD;
		public String channelID;
		public String target;
		public String deliveryDT;
		public String chargeAmt;
	}

	public class Customer {
		public List<HaveCommunicatedMessage> haveCommunicatedMessage;
	}

	public class Body {
		public Customer Customer;
		public String operation;
		public String transactionId;
		public String status;
		public String entity;
		public String service;
		public String appID;
	}

	
	public static WS_RES_SHORTLINK parse(String json) {
		return (WS_RES_SHORTLINK) System.JSON.deserialize(json, WS_RES_SHORTLINK.class);
	}
}