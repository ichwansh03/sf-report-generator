@IsTest
public class JSON2Apex_UserDetail_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'  \"userDetails\": ['+
		'    {'+
		'      \"userId\": \"01c03a67-32aa-4d3b-b0e4-02fe9d9f9599\",'+
		'      \"primaryPresence\": ['+
		'        {'+
		'          \"startTime\": \"2018-10-04T07:34:54.223Z\",'+
		'          \"endTime\": \"2018-10-10T05:38:12.906Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-10T05:38:12.906Z\",'+
		'          \"endTime\": \"2018-10-10T05:41:21.866Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-10T05:41:21.866Z\",'+
		'          \"endTime\": \"2018-10-12T06:43:57.893Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        }'+
		'      ]'+
		'    },'+
		'    {'+
		'      \"userId\": \"4f798b1d-d27a-4415-b793-02b420586e73\",'+
		'      \"primaryPresence\": ['+
		'        {'+
		'          \"startTime\": \"2018-10-04T11:08:13.992Z\",'+
		'          \"endTime\": \"2018-10-08T07:09:57.926Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-08T07:09:57.926Z\",'+
		'          \"endTime\": \"2018-10-09T18:03:10.752Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-09T18:03:10.752Z\",'+
		'          \"endTime\": \"2018-10-09T18:03:12.087Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-09T18:03:12.087Z\",'+
		'          \"endTime\": \"2018-10-12T09:38:38.575Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        }'+
		'      ]'+
		'    },'+
		'    {'+
		'      \"userId\": \"ab24ddb8-f1ef-4cca-ae72-9f20f5975332\",'+
		'      \"primaryPresence\": ['+
		'        {'+
		'          \"startTime\": \"2018-10-04T10:31:32.224Z\",'+
		'          \"endTime\": \"2018-10-05T02:55:37.812Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T02:55:37.812Z\",'+
		'          \"endTime\": \"2018-10-05T03:04:27.292Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T03:04:27.292Z\",'+
		'          \"endTime\": \"2018-10-05T03:04:39.424Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T03:04:39.424Z\",'+
		'          \"endTime\": \"2018-10-05T03:19:41.220Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T03:19:41.220Z\",'+
		'          \"endTime\": \"2018-10-05T03:19:49.329Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T03:19:49.329Z\",'+
		'          \"endTime\": \"2018-10-05T03:28:23.534Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T03:28:23.534Z\",'+
		'          \"endTime\": \"2018-10-05T07:04:08.110Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T07:04:08.110Z\",'+
		'          \"endTime\": \"2018-10-05T07:06:46.264Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T07:06:46.264Z\",'+
		'          \"endTime\": \"2018-10-05T07:50:13.548Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T07:50:13.548Z\",'+
		'          \"endTime\": \"2018-10-05T07:51:24.799Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-05T07:51:24.799Z\",'+
		'          \"endTime\": \"2018-10-08T02:57:30.403Z\",'+
		'          \"systemPresence\": \"OFFLINE\",'+
		'          \"organizationPresenceId\": \"ccf3c10a-aa2c-4845-8e8d-f59fa48c58e5\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-08T02:57:30.403Z\",'+
		'          \"endTime\": \"2018-10-08T03:23:21.741Z\",'+
		'          \"systemPresence\": \"AVAILABLE\",'+
		'          \"organizationPresenceId\": \"6a3af858-942f-489d-9700-5f9bcdcdae9b\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-08T03:23:21.741Z\",'+
		'          \"endTime\": \"2018-10-08T03:23:43.564Z\",'+
		'          \"systemPresence\": \"BUSY\",'+
		'          \"organizationPresenceId\": \"31fe3bac-dea6-44b7-bed7-47f91660a1a0\"'+
		'        },'+
		'        {'+
		'          \"startTime\": \"2018-10-08T03:23:43.564Z\",'+
		'          \"endTime\": \"2018-10-08T03:23:48.470Z\",'+
		'          \"systemPresence\": \"AWAY\",'+
		'          \"organizationPresenceId\": \"5e5c5c66-ea97-4e7f-ac41-6424784829f2\"'+
		'        }'+
		'      ]'+
		'    }'+
		'  ]'+
		'}';
		JSON2Apex_UserDetail obj = JSON2Apex_UserDetail.parse(json);
		System.assert(obj != null);
	}
}