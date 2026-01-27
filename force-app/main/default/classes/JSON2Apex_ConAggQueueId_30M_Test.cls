@IsTest
public class JSON2Apex_ConAggQueueId_30M_Test {
	
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
		'          \"interval\": \"2018-10-01T09:30:00.000+07:00/2018-10-01T13:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 2'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"nTransferred\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
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
		'              \"metric\": \"tTalk\",'+
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
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 5565,'+
		'                \"min\": 4728,'+
		'                \"count\": 2,'+
		'                \"sum\": 10293'+
		'              }'+
		'            },'+
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
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 5565,'+
		'                \"min\": 4728,'+
		'                \"count\": 2,'+
		'                \"sum\": 10293'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt5s\",'+
		'              \"stats\": {'+
		'                \"max\": 4728,'+
		'                \"min\": 4728,'+
		'                \"count\": 1,'+
		'                \"sum\": 4728'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-01T15:30:00.000+07:00/2018-10-01T16:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"nTransferred\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 4302,'+
		'                \"min\": 4302,'+
		'                \"count\": 1,'+
		'                \"sum\": 4302'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 4000,'+
		'                \"min\": 4000,'+
		'                \"count\": 1,'+
		'                \"sum\": 4000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 4302,'+
		'                \"min\": 4302,'+
		'                \"count\": 1,'+
		'                \"sum\": 4302'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 8152,'+
		'                \"min\": 8152,'+
		'                \"count\": 1,'+
		'                \"sum\": 8152'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 4152,'+
		'                \"min\": 4152,'+
		'                \"count\": 1,'+
		'                \"sum\": 4152'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 4302,'+
		'                \"min\": 4302,'+
		'                \"count\": 1,'+
		'                \"sum\": 4302'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 4302,'+
		'                \"min\": 4302,'+
		'                \"count\": 1,'+
		'                \"sum\": 4302'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 4302,'+
		'                \"min\": 4302,'+
		'                \"count\": 1,'+
		'                \"sum\": 4302'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt5s\",'+
		'              \"stats\": {'+
		'                \"max\": 4302,'+
		'                \"min\": 4302,'+
		'                \"count\": 1,'+
		'                \"sum\": 4302'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-01T16:00:00.000+07:00/2018-10-01T16:30:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 5'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"nTransferred\",'+
		'              \"stats\": {'+
		'                \"count\": 5'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 6771,'+
		'                \"min\": 3883,'+
		'                \"count\": 5,'+
		'                \"sum\": 24886'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 170000,'+
		'                \"min\": 3000,'+
		'                \"count\": 5,'+
		'                \"sum\": 195000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 6771,'+
		'                \"min\": 3883,'+
		'                \"count\": 5,'+
		'                \"sum\": 24886'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 175083,'+
		'                \"min\": 5118,'+
		'                \"count\": 5,'+
		'                \"sum\": 209264'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 5083,'+
		'                \"min\": 1118,'+
		'                \"count\": 5,'+
		'                \"sum\": 14264'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 6771,'+
		'                \"min\": 3883,'+
		'                \"count\": 5,'+
		'                \"sum\": 24886'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 6771,'+
		'                \"min\": 3883,'+
		'                \"count\": 5,'+
		'                \"sum\": 24886'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 6771,'+
		'                \"min\": 3883,'+
		'                \"count\": 5,'+
		'                \"sum\": 24886'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt5s\",'+
		'              \"stats\": {'+
		'                \"max\": 4867,'+
		'                \"min\": 3883,'+
		'                \"count\": 3,'+
		'                \"sum\": 12777'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-02T08:30:00.000+07:00/2018-10-02T09:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 3'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"nTransferred\",'+
		'              \"stats\": {'+
		'                \"count\": 2'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAbandon\",'+
		'              \"stats\": {'+
		'                \"max\": 6227,'+
		'                \"min\": 6227,'+
		'                \"count\": 1,'+
		'                \"sum\": 6227'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 6379,'+
		'                \"min\": 3867,'+
		'                \"count\": 3,'+
		'                \"sum\": 16473'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 4000,'+
		'                \"min\": 4000,'+
		'                \"count\": 2,'+
		'                \"sum\": 8000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 6379,'+
		'                \"min\": 3867,'+
		'                \"count\": 2,'+
		'                \"sum\": 10246'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 9095,'+
		'                \"min\": 7167,'+
		'                \"count\": 2,'+
		'                \"sum\": 16262'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 5095,'+
		'                \"min\": 3167,'+
		'                \"count\": 2,'+
		'                \"sum\": 8262'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 6379,'+
		'                \"min\": 3867,'+
		'                \"count\": 2,'+
		'                \"sum\": 10246'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 6379,'+
		'                \"min\": 3867,'+
		'                \"count\": 2,'+
		'                \"sum\": 10246'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 6379,'+
		'                \"min\": 3867,'+
		'                \"count\": 2,'+
		'                \"sum\": 10246'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt5s\",'+
		'              \"stats\": {'+
		'                \"max\": 3867,'+
		'                \"min\": 3867,'+
		'                \"count\": 1,'+
		'                \"sum\": 3867'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-03T09:30:00.000+07:00/2018-10-03T10:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 2'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"nTransferred\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAbandon\",'+
		'              \"stats\": {'+
		'                \"max\": 11154,'+
		'                \"min\": 11154,'+
		'                \"count\": 1,'+
		'                \"sum\": 11154'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 11154,'+
		'                \"min\": 3631,'+
		'                \"count\": 2,'+
		'                \"sum\": 14785'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 4000,'+
		'                \"min\": 4000,'+
		'                \"count\": 1,'+
		'                \"sum\": 4000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 3631,'+
		'                \"min\": 3631,'+
		'                \"count\": 1,'+
		'                \"sum\": 3631'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 12307,'+
		'                \"min\": 12307,'+
		'                \"count\": 1,'+
		'                \"sum\": 12307'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 8307,'+
		'                \"min\": 8307,'+
		'                \"count\": 1,'+
		'                \"sum\": 8307'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 3631,'+
		'                \"min\": 3631,'+
		'                \"count\": 1,'+
		'                \"sum\": 3631'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 3631,'+
		'                \"min\": 3631,'+
		'                \"count\": 1,'+
		'                \"sum\": 3631'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 3631,'+
		'                \"min\": 3631,'+
		'                \"count\": 1,'+
		'                \"sum\": 3631'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt5s\",'+
		'              \"stats\": {'+
		'                \"max\": 3631,'+
		'                \"min\": 3631,'+
		'                \"count\": 1,'+
		'                \"sum\": 3631'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-03T14:00:00.000+07:00/2018-10-03T14:30:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 4309,'+
		'                \"min\": 4309,'+
		'                \"count\": 1,'+
		'                \"sum\": 4309'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 4309,'+
		'                \"min\": 4309,'+
		'                \"count\": 1,'+
		'                \"sum\": 4309'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 4309,'+
		'                \"min\": 4309,'+
		'                \"count\": 1,'+
		'                \"sum\": 4309'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 4309,'+
		'                \"min\": 4309,'+
		'                \"count\": 1,'+
		'                \"sum\": 4309'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 4309,'+
		'                \"min\": 4309,'+
		'                \"count\": 1,'+
		'                \"sum\": 4309'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt5s\",'+
		'              \"stats\": {'+
		'                \"max\": 4309,'+
		'                \"min\": 4309,'+
		'                \"count\": 1,'+
		'                \"sum\": 4309'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-03T14:30:00.000+07:00/2018-10-03T15:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nTransferred\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 7000,'+
		'                \"min\": 7000,'+
		'                \"count\": 1,'+
		'                \"sum\": 7000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 230907,'+
		'                \"min\": 230907,'+
		'                \"count\": 1,'+
		'                \"sum\": 230907'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 223907,'+
		'                \"min\": 223907,'+
		'                \"count\": 1,'+
		'                \"sum\": 223907'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-04T13:30:00.000+07:00/2018-10-04T14:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 6000,'+
		'                \"min\": 6000,'+
		'                \"count\": 1,'+
		'                \"sum\": 6000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 30380,'+
		'                \"min\": 30380,'+
		'                \"count\": 1,'+
		'                \"sum\": 30380'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 24380,'+
		'                \"min\": 24380,'+
		'                \"count\": 1,'+
		'                \"sum\": 24380'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-04T14:00:00.000+07:00/2018-10-04T14:30:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 6000,'+
		'                \"min\": 6000,'+
		'                \"count\": 1,'+
		'                \"sum\": 6000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 24898,'+
		'                \"min\": 1993,'+
		'                \"count\": 2,'+
		'                \"sum\": 26891'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 18898,'+
		'                \"min\": 1993,'+
		'                \"count\": 2,'+
		'                \"sum\": 20891'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-04T15:30:00.000+07:00/2018-10-04T16:00:00.000+07:00\",'+
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
		'                \"max\": 46988,'+
		'                \"min\": 35444,'+
		'                \"count\": 2,'+
		'                \"sum\": 82432'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-04T16:30:00.000+07:00/2018-10-04T17:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 5'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAbandon\",'+
		'              \"stats\": {'+
		'                \"max\": 18690,'+
		'                \"min\": 6948,'+
		'                \"count\": 5,'+
		'                \"sum\": 61127'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 18690,'+
		'                \"min\": 6948,'+
		'                \"count\": 5,'+
		'                \"sum\": 61127'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-05T10:00:00.000+07:00/2018-10-05T10:30:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 9002,'+
		'                \"min\": 9002,'+
		'                \"count\": 1,'+
		'                \"sum\": 9002'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 4000,'+
		'                \"min\": 4000,'+
		'                \"count\": 1,'+
		'                \"sum\": 4000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 9002,'+
		'                \"min\": 9002,'+
		'                \"count\": 1,'+
		'                \"sum\": 9002'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 102194,'+
		'                \"min\": 102194,'+
		'                \"count\": 1,'+
		'                \"sum\": 102194'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 98194,'+
		'                \"min\": 98194,'+
		'                \"count\": 1,'+
		'                \"sum\": 98194'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 9002,'+
		'                \"min\": 9002,'+
		'                \"count\": 1,'+
		'                \"sum\": 9002'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 9002,'+
		'                \"min\": 9002,'+
		'                \"count\": 1,'+
		'                \"sum\": 9002'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 9002,'+
		'                \"min\": 9002,'+
		'                \"count\": 1,'+
		'                \"sum\": 9002'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-05T13:00:00.000+07:00/2018-10-05T13:30:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nOffered\",'+
		'              \"stats\": {'+
		'                \"count\": 6'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcd\",'+
		'              \"stats\": {'+
		'                \"max\": 6845,'+
		'                \"min\": 5842,'+
		'                \"count\": 6,'+
		'                \"sum\": 38563'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 15000,'+
		'                \"min\": 2000,'+
		'                \"count\": 5,'+
		'                \"sum\": 29000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAnswered\",'+
		'              \"stats\": {'+
		'                \"max\": 6845,'+
		'                \"min\": 5842,'+
		'                \"count\": 6,'+
		'                \"sum\": 38563'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 425386,'+
		'                \"min\": 42551,'+
		'                \"count\": 5,'+
		'                \"sum\": 948697'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 419386,'+
		'                \"min\": 27622,'+
		'                \"count\": 5,'+
		'                \"sum\": 920163'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"views\": ['+
		'            {'+
		'              \"name\": \"Answerlt10s\",'+
		'              \"stats\": {'+
		'                \"max\": 6845,'+
		'                \"min\": 5842,'+
		'                \"count\": 6,'+
		'                \"sum\": 38563'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt20s\",'+
		'              \"stats\": {'+
		'                \"max\": 6845,'+
		'                \"min\": 5842,'+
		'                \"count\": 6,'+
		'                \"sum\": 38563'+
		'              }'+
		'            },'+
		'            {'+
		'              \"name\": \"Answerlt30\",'+
		'              \"stats\": {'+
		'                \"max\": 6845,'+
		'                \"min\": 5842,'+
		'                \"count\": 6,'+
		'                \"sum\": 38563'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"interval\": \"2018-10-05T13:30:00.000+07:00/2018-10-05T14:00:00.000+07:00\",'+
		'          \"metrics\": ['+
		'            {'+
		'              \"metric\": \"nTransferred\",'+
		'              \"stats\": {'+
		'                \"count\": 1'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tAcw\",'+
		'              \"stats\": {'+
		'                \"max\": 4000,'+
		'                \"min\": 4000,'+
		'                \"count\": 1,'+
		'                \"sum\": 4000'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tHandle\",'+
		'              \"stats\": {'+
		'                \"max\": 79696,'+
		'                \"min\": 79696,'+
		'                \"count\": 1,'+
		'                \"sum\": 79696'+
		'              }'+
		'            },'+
		'            {'+
		'              \"metric\": \"tTalk\",'+
		'              \"stats\": {'+
		'                \"max\": 75835,'+
		'                \"min\": 75835,'+
		'                \"count\": 1,'+
		'                \"sum\": 75835'+
		'              }'+
		'            }'+
		'          ]'+
		'        }'+
		'      ]'+
		'    }'+
		'  ]'+
		'}';
		JSON2Apex_ConAggQueueId_30M r = JSON2Apex_ConAggQueueId_30M.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M.Metrics objMetrics = new JSON2Apex_ConAggQueueId_30M.Metrics(System.JSON.createParser(json));
		System.assert(objMetrics != null);
		System.assert(objMetrics.metric == null);
		System.assert(objMetrics.stats == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M.Views objViews = new JSON2Apex_ConAggQueueId_30M.Views(System.JSON.createParser(json));
		System.assert(objViews != null);
		System.assert(objViews.name == null);
		System.assert(objViews.stats == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M objJSON2Apex_ConAggQueueId_30M = new JSON2Apex_ConAggQueueId_30M(System.JSON.createParser(json));
		System.assert(objJSON2Apex_ConAggQueueId_30M != null);
		System.assert(objJSON2Apex_ConAggQueueId_30M.results == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M.Results objResults = new JSON2Apex_ConAggQueueId_30M.Results(System.JSON.createParser(json));
		System.assert(objResults != null);
		System.assert(objResults.group_Z == null);
		System.assert(objResults.data == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M.Stats objStats = new JSON2Apex_ConAggQueueId_30M.Stats(System.JSON.createParser(json));
		System.assert(objStats != null);
		System.assert(objStats.count == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M.Data objData = new JSON2Apex_ConAggQueueId_30M.Data(System.JSON.createParser(json));
		System.assert(objData != null);
		System.assert(objData.interval == null);
		System.assert(objData.metrics == null);
		System.assert(objData.views == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M.Stats_Z objStats_Z = new JSON2Apex_ConAggQueueId_30M.Stats_Z(System.JSON.createParser(json));
		System.assert(objStats_Z != null);
		System.assert(objStats_Z.max == null);
		System.assert(objStats_Z.min == null);
		System.assert(objStats_Z.count == null);
		System.assert(objStats_Z.sum == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JSON2Apex_ConAggQueueId_30M.Group_Z objGroup_Z = new JSON2Apex_ConAggQueueId_30M.Group_Z(System.JSON.createParser(json));
		System.assert(objGroup_Z != null);
		System.assert(objGroup_Z.mediaType == null);
		System.assert(objGroup_Z.queueId == null);
	}
}