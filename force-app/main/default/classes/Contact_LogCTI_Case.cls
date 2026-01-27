public class Contact_LogCTI_Case {
	
    public Contact_LogCTI_Case(ApexPages.StandardController controller){
        
    }
    
    public Contact_LogCTI_Case(){
        
    }
    
    public List<MappingClass> getMappingAction(){
        List<MappingClass> listmap = new List<MappingClass>();
    	String ids = '';
        if(test.isRunningTest()==true){
            //Log_CTI_Valdo__c lcti = [select contact__C from Log_CTI_Valdo__c where contact__c != null limit 1];
            //Contact con = [select id from contact limit 1];
            Case cs = [select contactid from case where contactid!=null order by createddate desc limit 1 ];
            //ids = con.id;
            ids = cs.contactid;
        } 
        else{
            ids = ApexPages.CurrentPage().getParameters().get('id');
        }
        Date dt = date.today();
        if(ids!=null){
            Contact con = [SELECT Id, Phone, Fax, MobilePhone, HomePhone, OtherPhone, AssistantPhone FROM Contact where id=:ids];
            String query = 'SELECT id, name, ID_Valdo__c, createddate FROM Log_CTI_Valdo__c where contact__c ='+'\''+ids+'\''+' ';
            if(con.phone!=null) query = query + ' OR from__c = '+'\''+con.phone+'\''+' OR to__c ='+'\''+con.phone+'\''+' ';
            if(con.fax!=null) query = query + ' OR from__c = '+'\''+con.fax+'\''+' OR to__c ='+'\''+con.fax+'\''+' ';
            if(con.MobilePhone!=null) query = query + ' OR from__c = '+'\''+con.MobilePhone+'\''+' OR to__c ='+'\''+con.MobilePhone+'\''+' ';
            if(con.HomePhone!=null) query = query + ' OR from__c = '+'\''+con.HomePhone+'\''+' OR to__c ='+'\''+con.HomePhone+'\''+' ';
            if(con.OtherPhone!=null) query = query + ' OR from__c = '+'\''+con.OtherPhone+'\''+' OR to__c ='+'\''+con.OtherPhone+'\''+' ';
            if(con.AssistantPhone!=null) query = query + ' OR from__c = '+'\''+con.AssistantPhone+'\''+' OR to__c ='+'\''+con.AssistantPhone+'\''+' ';
        	/*
            List<Log_CTI_Valdo__c> listcti = [SELECT id, name, ID_Valdo__c, createddate FROM Log_CTI_Valdo__c
                                           where contact__c =: ids OR from__c =:con.Phone or from__c =:con.Fax or from__c =:con.MobilePhone or from__c =:con.HomePhone
                                           or from__c =:con.OtherPhone or from__c =: con.AssistantPhone OR to__c =:con.Phone or to__c =:con.Fax or to__c =:con.MobilePhone 
                                           or to__c =:con.HomePhone or to__c =:con.OtherPhone or to__c =: con.AssistantPhone
                                           order by createddate desc limit 10000];
            */
            List<Log_CTI_Valdo__c> listcti = Database.query(query);
			List<Case> listcs = [select id, casenumber, createddate from case where contactid=:ids order by createddate desc limit 10000];  
            for(Integer i = 0; i<90; i++){
                Date dtstart = dt.addDays(-i);
                Date dtfinish = dt.addDays(-(i-1));
                List<Log_CTI_Valdo__c> lcti = new List<Log_CTI_Valdo__c> ();
                List<Case> lcs = new List<Case>();
                for(Log_CTI_Valdo__c cti:listcti){
                    if(cti.createddate > dtstart && cti.CreatedDate < dtfinish){
                        lcti.add(cti);
                    }
                }
                
                for(Case cs:listcs){
                    if(cs.createddate > dtstart && cs.CreatedDate < dtfinish){
                        lcs.add(cs);
                    }
                }
                
                if(lcti.size()>0 || lcs.size()>0){
                    listmap.add(new MappingClass(dtstart, lcti, lcs));
                }
                
                if(listmap.size()==10){
                    break;
                }
            }
        }
        return listmap;
    }
    
    class MappingClass{
        Public List<Case> listcs{get;set;}
        Public List<Log_CTI_Valdo__c> listcti {get;set;}
        Public Date thisdate {get;set;}
        public MappingClass(Date thisdate, List<Log_CTI_Valdo__c> listcti, List<Case> listcs){
            this.listcs = listcs;
            this.listcti = listcti;
            this.thisdate = thisdate;
        }
    }
}