@IsTest
public class JSON2Apex_DailySummaryVoice_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"results\": ['+
		'    {'+
		'      \"group\": {'+
		'        \"mediaType\": \"voice\",'+
		'        \"queueId\": \"4bd54af7-0ace-4423-abbb-bdcf4a80759e\"'+
		'      },'+
		'      \"data\": ['+
		'        {'+
		'          \"interval\": \"2018-10-01T08:00:00.000+07:00/2018-10-01T08:30:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 2'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 5565,'+
		'                \"min\": 4728,'+
		'                \"count\": 2,'+
		'                \"sum\": 10293'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 100000,'+
		'                \"min\": 10000,'+
		'                \"count\": 2,'+
		'                \"sum\": 110000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 5565,'+
		'                \"min\": 4728,'+
		'                \"count\": 2,'+
		'                \"sum\": 10293'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 132624,'+
		'                \"min\": 22642,'+
		'                \"count\": 2,'+
		'                \"sum\": 155266'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHeld\",'+
		'              \"stats\": {'+
		'                \"max\": 32624,'+
		'                \"min\": 12642,'+
		'                \"count\": 2,'+
		'                \"sum\": 45266'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 5565,'+
		'                \"min\": 4728,'+
		'                \"count\": 2,'+
		'                \"sum\": 10293'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Abandonlt5s\",'+
		'              \"stats\": {'+
		'                \"max\": 5565,'+
		'                \"min\": 4728,'+
		'                \"count\": 2,'+
		'                \"sum\": 10293'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Abandongtequal5s\",'+
		'              \"stats\": {'+
		'                \"max\": 4728,'+
		'                \"min\": 4728,'+
		'                \"count\": 1,'+
		'                \"sum\": 4728'+
		'              }'+
		'            }'+
		'          ]'+
		'        }'+
		'      ]'+
		'    }'+
		'  ]'+
		'}';
		JSON2Apex_DailySummaryVoice r = JSON2Apex_DailySummaryVoice.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice.Metrics objMetrics = new JSON2Apex_DailySummaryVoice.Metrics(System.JSON.createParser(json));
		System.assert(objMetrics != null);
		System.assert(objMetrics.metric == null);
		System.assert(objMetrics.stats == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice.Views objViews = new JSON2Apex_DailySummaryVoice.Views(System.JSON.createParser(json));
		System.assert(objViews != null);
		System.assert(objViews.name == null);
		System.assert(objViews.stats == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice.Results objResults = new JSON2Apex_DailySummaryVoice.Results(System.JSON.createParser(json));
		System.assert(objResults != null);
		System.assert(objResults.group_Z == null);
		System.assert(objResults.data == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice.Stats objStats = new JSON2Apex_DailySummaryVoice.Stats(System.JSON.createParser(json));
		System.assert(objStats != null);
		System.assert(objStats.count == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice objJSON2Apex_DailySummaryVoice = new JSON2Apex_DailySummaryVoice(System.JSON.createParser(json));
		System.assert(objJSON2Apex_DailySummaryVoice != null);
		System.assert(objJSON2Apex_DailySummaryVoice.results == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice.Data objData = new JSON2Apex_DailySummaryVoice.Data(System.JSON.createParser(json));
		System.assert(objData != null);
		System.assert(objData.interval == null);
		System.assert(objData.metrics == null);
		System.assert(objData.views == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice.Stats_Z objStats_Z = new JSON2Apex_DailySummaryVoice.Stats_Z(System.JSON.createParser(json));
		System.assert(objStats_Z != null);
		System.assert(objStats_Z.max == null);
		System.assert(objStats_Z.min == null);
		System.assert(objStats_Z.count == null);
		System.assert(objStats_Z.sum == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_DailySummaryVoice.Group_Z objGroup_Z = new JSON2Apex_DailySummaryVoice.Group_Z(System.JSON.createParser(json));
		System.assert(objGroup_Z != null);
		System.assert(objGroup_Z.mediaType == null);
		System.assert(objGroup_Z.queueId == null);
	}
}