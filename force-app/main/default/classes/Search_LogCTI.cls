public class Search_LogCTI {
    Public Log_CTI_Valdo__c srclcti {get;set;}
    Public Date fromdate {get;set;}
    Public Date todate {get;set;}
    public Search_LogCTI(){
        srclcti = new Log_CTI_Valdo__c();
    }
    
    Public List<Log_CTI_Valdo__c> getDataLog(){
        List<Log_CTI_Valdo__c> listcti = new List<Log_CTI_Valdo__c>();
        DescribeSObjectResult describeResultdp = Log_CTI_Valdo__c.getSObjectType().getDescribe();
        List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
        String dpFields = String.join(dpFieldList, ',');
        String dpquery = 'SELECT '+dpFields+ ' from Log_CTI_Valdo__c where id_valdo__c!=null ';
        if(srclcti!=null){
            if(srclcti.agent__c!=null) dpquery = dpquery + ' and ownerid = '+'\''+srclcti.agent__c+'\''+' ';
            if(srclcti.status__c!=null) dpquery = dpquery + ' and status__c = '+'\''+srclcti.status__c+'\''+' ';
            //if(srclcti.to__c!=null) dpquery = dpquery + ' and ( to__c LIKE '+'\''+'%'+srclcti.to__c+'%'+'\''+' OR from__c LIKE '+'\''+'%'+srclcti.to__c+'%'+'\''+' ) ';
            //if(srclcti.contact__c!=null) dpquery = dpquery + ' and contact__c = '+'\''+srclcti.contact__c+'\''+' ';
            if(fromdate!=null ){
                List<string> svaldate = string.valueOf(fromdate).split('\\s');
                //system.debug('*fromdate*'+fromdate);
                //system.debug('*svaldate*'+svaldate);
                String startdate = svaldate[0]+'T00:00:00.000Z';
                dpquery = dpquery +' and start_dialling__c >= '+startdate+ ' ';
            } 
            if(todate!=null){
                List<string> evaldate = string.valueOf(todate).split('\\s');
                String endtdate = evaldate[0]+'T23:59:59.000Z';
                dpquery = dpquery + ' and start_dialling__c <= '+endtdate+' ';
            } 
        }
        dpquery = dpquery  + ' order by start_dialling__c desc limit 1000';
        system.debug('*query*'+dpquery);
        listcti = Database.query(dpquery);
        return listcti;
    }
}