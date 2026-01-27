@IsTest
public class JSON2Apex_ConAggregateUserID_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"results\": ['+
		'    {'+
		'      \"group\": {'+
		'        \"mediaType\": \"voice\",'+
		'        \"userId\": \"2e1f73e2-cc81-43bb-828d-5e6a65c75958\"'+
		'      },'+
		'      \"data\": ['+
		'        {'+
		'          \"interval\": \"2018-10-01T08:00:00.000+07:00/2018-10-08T08:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOutbound\",'+
		'              \"stats\": {'+
		'                \"count\": 3'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 6000,'+
		'                \"min\": 6000,'+
		'                \"count\": 2,'+
		'                \"sum\": 12000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 30380,'+
		'                \"min\": 1993,'+
		'                \"count\": 7,'+
		'                \"sum\": 83355'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 24380,'+
		'                \"min\": 1993,'+
		'                \"count\": 7,'+
		'                \"sum\": 71355'+
		'              }'+
		'            }'+
		'          ]'+
		'        }'+
		'      ]'+
		'    }'+
		'  ]'+
		'}';
		JSON2Apex_ConAggregateUserID r = JSON2Apex_ConAggregateUserID.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggregateUserID.Metrics objMetrics = new JSON2Apex_ConAggregateUserID.Metrics(System.JSON.createParser(json));
		System.assert(objMetrics != null);
		System.assert(objMetrics.metric == null);
		System.assert(objMetrics.stats == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggregateUserID.Results objResults = new JSON2Apex_ConAggregateUserID.Results(System.JSON.createParser(json));
		System.assert(objResults != null);
		System.assert(objResults.group_Z == null);
		System.assert(objResults.data == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggregateUserID.Stats objStats = new JSON2Apex_ConAggregateUserID.Stats(System.JSON.createParser(json));
		System.assert(objStats != null);
		System.assert(objStats.count == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggregateUserID objJSON2Apex_ConAggregateUserID = new JSON2Apex_ConAggregateUserID(System.JSON.createParser(json));
		System.assert(objJSON2Apex_ConAggregateUserID != null);
		System.assert(objJSON2Apex_ConAggregateUserID.results == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggregateUserID.Data objData = new JSON2Apex_ConAggregateUserID.Data(System.JSON.createParser(json));
		System.assert(objData != null);
		System.assert(objData.interval == null);
		System.assert(objData.metrics == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggregateUserID.Stats_Z objStats_Z = new JSON2Apex_ConAggregateUserID.Stats_Z(System.JSON.createParser(json));
		System.assert(objStats_Z != null);
		System.assert(objStats_Z.max == null);
		System.assert(objStats_Z.min == null);
		System.assert(objStats_Z.count == null);
		System.assert(objStats_Z.sum == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggregateUserID.Group_Z objGroup_Z = new JSON2Apex_ConAggregateUserID.Group_Z(System.JSON.createParser(json));
		System.assert(objGroup_Z != null);
		System.assert(objGroup_Z.mediaType == null);
		System.assert(objGroup_Z.userId == null);
	}
}