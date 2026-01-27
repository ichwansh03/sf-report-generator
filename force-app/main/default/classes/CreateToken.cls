public class CreateToken {
	private String cypher = '';
    private String username = '';
    private String password = '';
    private String result = '';
        
    public String getToken(){
        
        //function to randomize query result
        Integer recCount = [SELECT COUNT() FROM Hashkey__c LIMIT 2000]; //limit 2000 to avoid OFFSET governor limit
		Integer rand = Math.floor(Math.random()*recCount).intValue();
		system.debug('integer random: ' +rand);
		Hashkey__c hash = [SELECT Name, Username__c, Password__c, Cypher__c FROM Hashkey__c WHERE CreatedDate >= 2015-04-01T00:00:01Z LIMIT 1 OFFSET :rand]; //Live: 2015-05-01T00:00:01Z sandbox: 2015-03-10T00:00:01Z
        system.debug('Query: '+hash);
        
    	cypher = hash.Cypher__c;
    	username = hash.Username__c;
    	password = hash.Password__c;
        
 		String gabungan =  username+'|'+password+'|'+cypher;
        system.debug('Gabungan string: '+gabungan);
        blob blobs = blob.valueof(gabungan);
        blob md5Hash = Crypto.generateDigest('MD5', blobs); //convert to MD5
        result = EncodingUtil.convertToHex(md5Hash).ToUpperCase(); //convert to Base16
        system.debug('Result: '+result);
        return result;
    }
}