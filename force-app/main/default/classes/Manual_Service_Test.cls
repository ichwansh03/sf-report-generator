@isTest (seealldata=true)
private class Manual_Service_Test {
    static testMethod void test_execute_UseCase1(){
        Manual_Service ms = new Manual_Service();
        ms.tgl = date.today();
        ms.Pilihan = 'Log CTI Valdo';
        ms.getCategoryService();
        ms.action();
        ms.Pilihan = 'Agent Status';
        ms.action();
        ms.Pilihan = 'Inbound Call Interval';
        ms.action();
        ms.Pilihan = 'Inbound Call Agent';
        ms.action();
        ms.Pilihan = 'Summary Daily';
        ms.action();
        
    }
}