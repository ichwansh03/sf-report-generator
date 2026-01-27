trigger setDuration on AppLog__c (before insert, before update) {
    
    for(AppLog__c log : trigger.new){
        
        Long startlongtime = (Long)log.StartLongTime__c;    //applog.StartLongTime__c = system.now().getTime();
        Long endlongtime = (Long)log.EndLongTime__c;        //applog.EndLongTime__c = system.now().getTime();
        Long milliseconddiff = endlongtime - startlongtime;
         
        log.start_date_time__c = DateTime.newInstance(startlongtime).format('M/d/yyyy HH:mm:ss.SSS');
        log.end_date_time__c = DateTime.newInstance(endlongtime).format('M/d/yyyy HH:mm:ss.SSS');
        log.duration_in_second__c = milliseconddiff/1000;
        system.debug('>>> duration : '+milliseconddiff);
        
    }

}