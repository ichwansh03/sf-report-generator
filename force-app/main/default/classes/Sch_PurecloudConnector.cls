Global class Sch_PurecloudConnector implements Schedulable  {
    global void execute(SchedulableContext ctx){
        Purecloud_Connector.execute();  
    }
}