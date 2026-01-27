global class NumberGenerator {

  public String getNumber(string entity) {
    
      try{  
          NumberCounter__c count = [select counter__c from NumberCounter__c where Entity__c = :entity for update];
          integer newCount = Integer.valueOf(count.counter__c) + 1;
          count.counter__c = newCount;
          update count; 
          
          string countstr = formatNumber(newCount); 
          
          return countstr ;
      } catch(Exception e){
          return '' ;
      }
  }
  
  private string formatNumber(integer currnum){
      string text = String.valueOf(currnum);
      while (text.length() < 6){ 
          text = '0' + text; 
      }
      return text;
  }

  /*  
  public static testMethod void testNumberGen(){
    
    NumberGenerator NG = new NumberGenerator();
    NG.getNumber('MAGI');
    NG.getNumber('AMFS');
    NG.getNumber('AFI');

  }
  */  
}