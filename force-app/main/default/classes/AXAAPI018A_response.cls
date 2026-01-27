public class AXAAPI018A_response {

	public class Data {
        //public String recordType {get;set;} 
        Public String division_c {get; set;}	
        public String commentBody {get;set;} 
        public String createdById {get;set;} 
        public Datetime createdDate {get;set;} 
        public String creatorFullPhotoUrl {get;set;} 
        public String creatorSmallPhotoUrl {get;set;} 
        public String id {get;set;} 
        public Boolean isDeleted {get;set;} 
        public Boolean isPublished {get;set;} 
        public String lastModifiedById {get;set;} 
        public Datetime lastModifiedDate {get;set;} 
        public String parentId {get;set;} 
        public String systemModstamp {get;set;} 

        public String createdById_name {get;set;} 
        public String lastModifiedById_name {get;set;} 
        public String parentId_name {get;set;} 
			
		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'division_c') {
							division_c = parser.getText();
						} else if (text == 'commentBody') {
							commentBody = parser.getText();
                            commentBody = commentBody.replace('<','');
                            commentBody = commentBody.replace('\n','<br/>'); 
                            commentBody = commentBody.replace('https', '<https');
						} else if (text == 'createdById') {
							createdById = parser.getText();
                            if (createdById != null) createdById_name = AXAAPI_UtilityClass.getsObjectNameById(createdById, 'User', 'Name');
						} else if (text == 'createdDate') {
							createdDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						} else if (text == 'creatorFullPhotoUrl') {
							creatorFullPhotoUrl = parser.getText();
						}  else if (text == 'creatorSmallPhotoUrl') {
							creatorSmallPhotoUrl = parser.getText();
						} else if (text == 'id') {
                         	id = parser.getText();
                        } else if (text == 'isDeleted') {
                            String a = parser.getText();
							isDeleted = Boolean.valueOf(a);
						} else if (text == 'isPublished') {
							String a = parser.getText();
                            isPublished = Boolean.valueOf(a);
						} else if (text == 'lastModifiedById') {
							lastModifiedById = parser.getText();
                            if (lastModifiedById != null) lastModifiedById_name = AXAAPI_UtilityClass.getsObjectNameById(lastModifiedById, 'User', 'Name');
						} else if (text == 'lastModifiedDate') {
							lastModifiedDate = AXAAPI_UtilityClass.stringToDatetime(parser.getText());
						}  else if (text == 'parentId') {
							parentId = parser.getText();
                            /* if (parentId != null && parentId.left(3) == Schema.SObjectType.Case.getKeyPrefix() ) {
                                AXAAPI001B_response getData  = AXAAPI001B_CaseById.getCaseById(parentId);   
                                if(getData != null && getData.data != null ) parentId_name = getData.data.caseNumber; 
                            } */
                            if (parentId != null) parentId_name = AXAAPI_UtilityClass.getsObjectNameById(parentId, 'Case', 'CaseNumber');
						} else if (text == 'systemModstamp') {
                           // 
							//id = Boolean.valueOf(a);
							systemModstamp = parser.getText();
                            
						}
                        else {
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

	public AXAAPI018A_response(JSONParser parser) {
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
						System.debug(LoggingLevel.WARN, 'AXAAPI018A_response consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static AXAAPI018A_response parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AXAAPI018A_response(parser);
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