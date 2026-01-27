@isTest (seealldata=true)
private class Log_CTI_ValdoTrigger_Test{
  static testMethod void test_Log_CTI_ValdoTrigger(){
   test.startTest();
      Contact con = [select id from contact limit 1];
      Log_CTI_Valdo__c log_cti_valdo_Obj = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call Out', to__c = '0812345678', status__C = 'Outbound', sip__c = '702');
      Insert log_cti_valdo_Obj; 
      log_cti_valdo_Obj.Contact__c = con.id;
      update log_cti_valdo_Obj;
      
      Log_CTI_Valdo__c log_cti_valdo_Obj3 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', from__c = '0812345678', status__C = 'Inbound', sip__c = '702');
      Insert log_cti_valdo_Obj3; 
      log_cti_valdo_Obj3.Contact__c = con.id;
      update log_cti_valdo_Obj3;
      
      Log_CTI_Valdo__c log_cti_valdo_Obj2 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', transfer_from__C ='702', sip__c = '701', status__c = 'Transfer');
      Insert log_cti_valdo_Obj2; 
      update log_cti_valdo_Obj2;
   test.stopTest();
  }
    
   static testMethod void test_Log_CTI_ValdoTrigger2(){
   test.startTest();
      Contact con = [select id from contact limit 1];
      Log_CTI_Valdo__c log_cti_valdo_Obj3 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', from__c = '0812345678', status__C = 'Inbound', sip__c = '702');
      Insert log_cti_valdo_Obj3; 
      log_cti_valdo_Obj3.Contact__c = con.id;
      log_cti_valdo_Obj3.Recording_ID__c = 'https://axasales.valdo-intl.com/test';
       update log_cti_valdo_Obj3;
      
      Log_CTI_Valdo__c log_cti_valdo_Obj2 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', transfer_from__C ='702', sip__c = '701', status__c = 'Inbound');
      Insert log_cti_valdo_Obj2;
       log_cti_valdo_obj2.status__c = 'Transfer';
       log_cti_valdo_obj2.Recording_ID__c = 'https://axasales.valdo-intl.com/test';
      update log_cti_valdo_Obj2;
   test.stopTest();
  }
    
    static testMethod void test_Log_CTI_ValdoTrigger3(){
   test.startTest();
      Contact con = [select id from contact limit 1];
      Log_CTI_Valdo__c log_cti_valdo_Obj3 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', from__c = '0812345678', status__C = 'Inbound', sip__c = '702');
      Insert log_cti_valdo_Obj3; 
      log_cti_valdo_Obj3.Contact__c = con.id;
       update log_cti_valdo_Obj3;
      
      Log_CTI_Valdo__c log_cti_valdo_Obj2 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', transfer_from__C ='702', sip__c = '701', status__c = 'Inbound');
      Insert log_cti_valdo_Obj2;
        log_cti_valdo_obj2.status__c = 'Transfer';
      update log_cti_valdo_Obj2;
   test.stopTest();
  }
    
    static testMethod void test_Log_CTI_ValdoTrigger4(){
        test.startTest();
        Contact con = [select id from contact limit 1];
        Log_CTI_Valdo__c log_cti_valdo_Obj3 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', from__c = '0812345678', status__C = 'Inbound', sip__c = '702');
        Insert log_cti_valdo_Obj3; 
        log_cti_valdo_Obj3.Contact__c = con.id;
        log_cti_valdo_Obj3.Recording_ID__c = 'https://axasales.valdo-intl.com/test';
        update log_cti_valdo_Obj3;
        
        Log_CTI_Valdo__c log_cti_valdo_Obj2 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', transfer_from__C ='702', sip__c = '701', status__c = 'Transfer', Recording_ID__c = 'https://axasales.valdo-intl.com/test');
        Insert log_cti_valdo_Obj2;

        update log_cti_valdo_Obj2;
        test.stopTest();
    }
    
    static testMethod void test_Log_CTI_ValdoTrigger5(){
        test.startTest();
        Contact con = [select id from contact limit 1];
        Log_CTI_Valdo__c log_cti_valdo_Obj3 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', from__c = '0812345678', status__C = 'Inbound', sip__c = '702');
        Insert log_cti_valdo_Obj3; 
        log_cti_valdo_Obj3.Contact__c = con.id;
        log_cti_valdo_Obj3.Recording_ID__c = 'https://axasales.valdo-intl.com/test';
        update log_cti_valdo_Obj3;
        
        Log_CTI_Valdo__c log_cti_valdo_Obj2 = new Log_CTI_Valdo__c(Answer__c = false, ValdoDailyData__c = false, Mode__c='API Call In', transfer_from__C ='702', sip__c = '701', status__c = 'Transfer');
        Insert log_cti_valdo_Obj2;

        update log_cti_valdo_Obj2;
        test.stopTest();
    }
}