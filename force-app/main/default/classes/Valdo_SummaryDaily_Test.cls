@isTest (seealldata=true)
private class Valdo_SummaryDaily_Test {
    static testMethod void test_execute_UseCase1(){
        String tgl = String.valueof(date.today().day());
        String bln = String.valueof(date.today().month());
        String thn = String.valueof(date.today().year());
        Valdo_SummaryDaily.getSummaryDaily(tgl, bln, thn);
    }
}