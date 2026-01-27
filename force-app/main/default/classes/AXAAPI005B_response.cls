public class AXAAPI005B_response {

	public class Data {
		public String Owner_Name {get;set;}
        public String Parent_Name {get;set;}
        public String Size {get;set;}
        public String url {get;set;}
        public String CreatedBy_Name {get;set;}
        public String LastModifiedBy_Name {get;set;}
                       
        public String body {get;set;} 
		public Decimal bodyLength {get;set;} 
		public String contentType {get;set;} 
		public String createdById {get;set;} 
		public Datetime createdDate {get;set;} 
		public String description {get;set;} 
		public String id {get;set;} 
        public String lastId {get;set;} 
        public String new_id {get;set;}
		public String isDeleted {get;set;} 
		public String isPrivate {get;set;} 
		public String lastModifiedById {get;set;} 
		public Datetime lastModifiedDate {get;set;} 
		public String name {get;set;} 
		public String ownerId {get;set;} 
		public String parentId {get;set;} 
		public String systemModstamp {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'body') {
							body = parser.getText();
						} else if (text == 'bodyLength') {
                            bodyLength = parser.getDecimalValue();
                            
                            system.debug('Length: ' + bodyLength);
                            if(bodyLength >= 1000 && bodyLength <=999999){
                                 bodyLength = bodylength / 1024;
                                 Size = String.valueOf(bodyLength) + 'KB';
                            } if (bodyLength >= 1000000){
                                bodyLength = bodylength/ 1048576;
                                bodyLength = bodylength.setScale(2, RoundingMode.HALF_UP);
                                Size = String.valueOf(bodyLength) + 'MB';
                                system.debug('Length to MB: ' + bodyLength );
                            } else{
                                Size = String.valueOf(bodyLength) + 'Byte';
                            }
						} else if (text == 'contentType') {
							contentType = parser.getText();
						} else if (text == 'createdById') {
							createdById = parser.getText();
                            if (createdById != null) CreatedBy_Name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'user', 'name');
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
                            lastId = id.SubString(id.length() - 3);  
                            new_id = AXAAPI_UtilityClass.getNewAttachmentID(parser.getText());
						} else if (text == 'isDeleted') {
							isDeleted = parser.getText();
						} else if (text == 'isPrivate') {
							isPrivate = parser.getText();
						} else if (text == 'lastModifiedById') {
							lastModifiedById = parser.getText();
						} else if (text == 'lastModifiedDate') {
							lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'ownerId') {
							ownerId = parser.getText();
						} else if (text == 'parentId') {
							parentId = parser.getText();
                             if (parentId != null) Parent_Name = AXAAPI_UtilityClass.getsObjectNameById(parentId, 'user', 'name');
						} else if (text == 'systemModstamp') {
							systemModstamp = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public String status {get;set;} 
	public String message {get;set;} 
	public List<Data> data {get;set;} 
    public integer counts {get;set;} 
    

	public AXAAPI005B_response(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'status') {
						status = parser.getText();
					} else if (text == 'message') {
						message = parser.getText();
					} else if (text == 'data') {
						data = arrayOfData(parser);
					} else if (text == 'counts') {
						counts = integer.valueOf(parser.getText());
					} else {
						System.debug(LoggingLevel.WARN, 'AXAAPI005B_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI005B_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI005B_response(parser);
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
	
    private static List<Data> arrayOfData(System.JSONParser p) {
        List<Data> res = new List<Data>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Data(p));
        }
        return res;
    }



}