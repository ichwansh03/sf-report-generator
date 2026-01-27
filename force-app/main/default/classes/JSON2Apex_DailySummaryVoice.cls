Global class JSON2Apex_DailySummaryVoice {

	public class Metrics {
		public String metric {get;set;} 
		public Stats stats {get;set;} 

		public Metrics(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'metric') {
							metric = parser.getText();
						} else if (text == 'stats') {
							stats = new Stats(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Metrics consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Views {
		public String name {get;set;} 
		public Stats_Z stats {get;set;} 

		public Views(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'stats') {
							stats = new Stats_Z(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Views consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Results {
		public Group_Z group_Z {get;set;} // in json: group
		public List<Data> data {get;set;} 

		public Results(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'group') {
							group_Z = new Group_Z(parser);
						} else if (text == 'data') {
							data = arrayOfData(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Results consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Stats {
		public Integer count {get;set;} 
		public String max {get;set;} 
        public String min {get;set;} 
        public String sum {get;set;} 
        
        
		public Stats(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'count') {
							count = parser.getIntegerValue();
						}
                        else if (text == 'max'){
                            max = parser.getText();
                        }
                        else if (text == 'min'){
                            min = parser.getText();
                        }
                        else if (text == 'sum'){
                            sum = parser.getText();
                        }
                        else {
							System.debug(LoggingLevel.WARN, 'Stats consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public List<Results> results {get;set;} 

	public JSON2Apex_DailySummaryVoice(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'results') {
						results = arrayOfResults(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex_DailySummaryVoice consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Data {
		public String interval {get;set;} 
		public List<Metrics> metrics {get;set;} 
		public List<Views> views {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'interval') {
							interval = parser.getText();
						} else if (text == 'metrics') {
							metrics = arrayOfMetrics(parser);
						} else if (text == 'views') {
							views = arrayOfViews(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Stats_Z {
		public Integer max {get;set;} 
		public Integer min {get;set;} 
		public Integer count {get;set;} 
		public Integer sum {get;set;} 

		public Stats_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'max') {
							max = parser.getIntegerValue();
						} else if (text == 'min') {
							min = parser.getIntegerValue();
						} else if (text == 'count') {
							count = parser.getIntegerValue();
						} else if (text == 'sum') {
							sum = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Stats_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Group_Z {
		public String mediaType {get;set;} 
		public String queueId {get;set;} 

		public Group_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'mediaType') {
							mediaType = parser.getText();
						} else if (text == 'queueId') {
							queueId = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Group_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JSON2Apex_DailySummaryVoice parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JSON2Apex_DailySummaryVoice(parser);
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
	

    private static List<Metrics> arrayOfMetrics(System.JSONParser p) {
        List<Metrics> res = new List<Metrics>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Metrics(p));
        }
        return res;
    }






    private static List<Data> arrayOfData(System.JSONParser p) {
        List<Data> res = new List<Data>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Data(p));
        }
        return res;
    }






    private static List<Views> arrayOfViews(System.JSONParser p) {
        List<Views> res = new List<Views>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Views(p));
        }
        return res;
    }



    private static List<Results> arrayOfResults(System.JSONParser p) {
        List<Results> res = new List<Results>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Results(p));
        }
        return res;
    }



}