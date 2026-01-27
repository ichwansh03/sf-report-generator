global class SchCMUDispatch Implements Schedulable {
    global void execute(SchedulableContext sc)
    {
        SchCMUDispatchAMFS();
    }

    
    public void SchCMUDispatchAMFS(){
		string entity = 'AMFS';
        list<string> ListEntity = new list<string>();
        string SchCMUDispatchFor = label.SchCMUDispatchFor;
        ListEntity = SchCMUDispatchFor.split(',');
        list<Named_User__c> listCMU = new list<Named_User__c>();
        list<Named_User__c> DigitalCMU = new list<Named_User__c>();
        map<string,Integer> NamedUser_loopCMU = new map<string,Integer>();
        map<string,Integer> NamedUser_loopCMU_Digital = new map<string,Integer>();
        // Named User
        //* // 3 Jun 2020, Update Count Case dan Count Skip
        listCMU = [SELECT id, Name, Count_Case__c, Count_Skip__c, User__c, Status__c, Channel_Digital__c FROM Named_User__c WHERE Division__c = 'CMU' and Entity__c =: entity]; 
        map<String,Named_User__c> UserCMUCount = new map<String,Named_User__c>();
        list<string> ListUserCMU = new list<string>();
        for (integer i = 0; i < listCMU.size(); i++) {
            
            UserCMUCount.put(listCMU[i].Name, listCMU[i]);
            ListUserCMU.add(listCMU[i].Name);
        }
        
        listCMU = new list<Named_User__c>();
        // Count Case this month
        date datetoday = date.today();
        date startdate = date.newInstance(datetoday.year(), datetoday.month(), 1);
        date enddate = startdate.addMonths(1);
        Integer MinCount = 9999; // 7 Jun20, Untuk hitung count_skip secara automatic.
        
        AggregateResult[] groupedResults
          = [SELECT Named_User__c, Count(id) FROM case 
				WHERE Named_User__c != NULL and 
             		Named_User__c IN :ListUserCMU and 
             		Type = 'Complaint' and 
             		Entity__c IN : ListEntity and 
             		//Status = 'Closed' and
             		UnCount__c = FALSE and
             		Create_Date__c >= : startdate and Create_Date__c < : enddate
              GROUP BY Named_User__c];
        for (AggregateResult ar : groupedResults)  {
            System.debug('#SchCMUDispatch Named_User__c ' + ar.get('Named_User__c'));
            System.debug('#SchCMUDispatch Count Case ' + ar.get('expr0'));
            
            if (UserCMUCount.get(string.valueof(ar.get('Named_User__c'))) != NULL) {
                Named_User__c updateNU = new Named_User__c();
                updateNU = UserCMUCount.get(string.valueof(ar.get('Named_User__c')));
                updateNU.Count_Case__c = integer.valueOf(ar.get('expr0'));
                //updateNU.Count_Skip__c = 0;
                
                system.debug('#Update Named User = '+updateNU.Name+'; Count Case = '+updateNU.Count_Case__c+'; Count Skip = '+updateNU.Count_Skip__c);
                listCMU.add(updateNU);
                
                if (updateNU.Status__c == 'Active' && !updateNU.Channel_Digital__c && MinCount > integer.valueof(updateNU.Count_Case__c)) MinCount = integer.valueof(updateNU.Count_Case__c);

            } 
        }
        if (listCMU.size() > 0) update listCMU;
		listCMU = new list<Named_User__c>();
        // */
        
        map<string,Named_User__c> maplistCMU = new map<string,Named_User__c>();
		// Special Named User
		DigitalCMU = [SELECT id, Name, Count_Case__c, Count_Skip__c, User__c, Reset_Date__c FROM Named_User__c WHERE Status__c = 'Active' and Division__c = 'CMU' and Entity__c =: entity and Channel_Digital__c = TRUE order by Count_Case__c, Name limit 1]; 
		//if (DigitalCMU.size() > 0) maplistCMU.put(DigitalCMU[0].Name,DigitalCMU[0]);
        for (integer i = 0; i < DigitalCMU.size(); i++){
            system.debug('resetmonth Digital : ');
            integer resetmonth = 0;
			integer todaymonth = 0;
            if (DigitalCMU[i].Reset_Date__c == NULL) resetmonth = 0;
            else resetmonth = DigitalCMU[i].Reset_Date__c.Month();
            
            todaymonth = date.today().month();
            // 27 April 2020, add Count Skip.
			if (DigitalCMU[i].Count_Skip__c == NULL) DigitalCMU[i].Count_Skip__c = 0;
            if (resetmonth != todaymonth) {
                DigitalCMU[i].Count_Case__c = 0;
                DigitalCMU[i].Count_Skip__c = 0;
                DigitalCMU[i].Reset_Date__c = date.today();
            }

            system.debug('resetmonth digital : '+resetmonth);
            system.debug('todaymonth digital : '+todaymonth);
            
            maplistCMU.put(DigitalCMU[i].Name,DigitalCMU[i]);
            NamedUser_loopCMU_Digital.put(DigitalCMU[i].Name,i);
            
            // check Data Skip
            system.debug('## Named User Digital : '+DigitalCMU[i].Name+' ['+i+'] Count_Case='+DigitalCMU[i].Count_Case__c+'; count_skip='+DigitalCMU[i].Count_skip__c);
        }
        
        // Named User, order by CountCase.
        listCMU = [SELECT id, Name, Count_Case__c, Count_Skip__c, User__c, Reset_Date__c, Manual_Count_Skip__c FROM Named_User__c WHERE Status__c = 'Active' and Division__c = 'CMU' and Entity__c =: entity and Channel_Digital__c = FALSE order by Count_Case__c, Name]; 
        for (integer i = 0; i < listCMU.size(); i++){
            system.debug('resetmonth : ');
            integer resetmonth = 0;
			integer todaymonth = 0;
            if (listCMU[i].Reset_Date__c == NULL) resetmonth = 0;
            else resetmonth = listCMU[i].Reset_Date__c.Month();
            
            todaymonth = date.today().month();
            // 27 April 2020, add Count Skip.
			if (listCMU[i].Count_Skip__c == NULL) listCMU[i].Count_Skip__c = 0;
            if (resetmonth != todaymonth) {
                listCMU[i].Count_Case__c = 0;
                listCMU[i].Count_Skip__c = 0;
                listCMU[i].Reset_Date__c = date.today();
            }
            
            // 7 Jun20, Set CountSkip
            IF (listCMU[i].Count_Case__c-1 > MinCount && !listCMU[i].Manual_Count_Skip__c) listCMU[i].Count_Skip__c = listCMU[i].Count_Case__c - 1 - MinCount;

            system.debug('resetmonth : '+resetmonth);
            system.debug('todaymonth : '+todaymonth);
            
            maplistCMU.put(listCMU[i].Name,listCMU[i]);
            NamedUser_loopCMU.put(listCMU[i].Name,i);
            
            // check Data Skip
            system.debug('## Named User : '+listCMU[i].Name+' ['+i+'] Count_Case='+listCMU[i].Count_Case__c+'; count_skip='+listCMU[i].Count_skip__c);
        }
        
        // Case
        date cutoffdate = date.newInstance(2020, 01, 01);
        list<case> cs = [SELECT id, Named_User__c, Channel__c, ParentId, Parent.OwnerId, Parent.PIC__c, Parent_Type__c, Pending_Status__c, CHS_Status__c, Contact.Name, Contact.LastName, Contact.MobilePhone, Contact.Email, Parent.Named_User__c, UnCount__c, Complaint__c, Appeal__c FROM case 
                        	WHERE createdDate > : cutoffdate and Named_User__c = NULL and Type = 'Complaint' and Entity__c =: Entity and Status != 'Closed' and Complaint_type__c != 'Soft Complaint'
                        	// for testing, comment proses insert
							//WHERE createdDate > : cutoffdate and Type = 'Complaint' and Entity__c =: Entity and Complaint_type__c != 'Soft Complaint'
						order by Category__c, Contact.MobilePhone, Contact.Email];
        system.debug('### Count Case = '+cs.size());
        integer loopCMU = 0;
		integer loopCMUDig = 0; // for Digital
        string TempCase = '';
        boolean checkskip = FALSE; // jika true, akan ada proses While, untuk menjalankan yang tidak ada skip.
        map<string,string> MDScheckByName = new map<string,string>();
        map<string,string> MDScheckByMobile = new map<string,string>();
        map<string,string> MDScheckByEmail = new map<string,string>();    
        
        string EmailDummy = label.EmailDummy;
        
        boolean FlagSameUser = FALSE;
        
        for (integer i = 0; i < cs.size(); i++) {
            system.debug('### Case '+i+' of '+cs.size());
            //system.debug('### Dispatch 0:'+listCMU[0].Count_Case__c+'; 1:'+listCMU[1].Count_Case__c+'; 2:'+listCMU[2].Count_Case__c+'; 3:'+listCMU[3].Count_Case__c+'; 4:'+listCMU[4].Count_Case__c+'; 5:'+listCMU[5].Count_Case__c+'; 6:'+listCMU[6].Count_Case__c+';');
            
            if (loopCMU >= listCMU.size()) loopCMU = 0;
            FlagSameUser = FALSE;
            
            cs[i].CHS_Status__c = 'In Progress CMU';
            cs[i].Pending_Status__c = 'Not Yet Proceed by CMU';
            if (cs[i].Parent_Type__c == 'Complaint' && cs[i].Appeal__c != null && cs[i].Appeal__c == '^1Yes') cs[i].Appeal__c = '^1Yes';
            if (cs[i].Parent_Type__c == 'Complaint' && cs[i].Appeal__c != null && cs[i].Appeal__c == 'Yes') cs[i].Appeal__c = 'Yes';
            //if (cs[i].Parent_Type__c == 'Complaint') cs[i].Appeal__c = 'Yes';
			if (cs[i].Parent_Type__c == 'Complaint') cs[i].Complaint__c = 'Appeal';
            
            // Taufik, Update 30 July 2020
            if (cs[i].Complaint__c == '' || cs[i].Complaint__c == NULL) cs[i].Complaint__c = 'New';
            
            // PIC khusus untuk Channel ('Social Media', 'Print Media', 'Website', 'Regulator', 'Solicitor/Lawyer'). 
            if (cs[i].Channel__c == 'Social Media' || cs[i].Channel__c == 'Print Media' || cs[i].Channel__c == 'Website' || cs[i].Channel__c == 'Regulator' || cs[i].Channel__c == 'Solicitor/Lawyer') {
				if (loopCMUDig >= DigitalCMU.size()) loopCMUDig = 0;
                
                if (Test.isRunningTest()) cs[i].Named_User__c = 'Test'; 
                else cs[i].Named_User__c = DigitalCMU[loopCMUDig].Name; 
                
                FlagSameUser = TRUE;
                system.debug('#SchCMUDispatch : Channel Digital NamedUser - '+cs[i].Named_User__c);                
                // Set UnCount jika ada nama, email or mobile phone yang sama.
                if (MDScheckByName.get(cs[i].Contact.Name) != NULL) {
                    cs[i].Named_User__c = MDScheckByName.get(cs[i].Contact.Name); // taufik, update 30 july 2020
                    cs[i].UnCount__c = TRUE;
                    system.debug('#SchCMUDispatch : MDScheckByName - '+cs[i].Named_User__c);
                }
                else if (MDScheckByMobile.get(cs[i].Contact.MobilePhone) != NULL) {
                    cs[i].Named_User__c = MDScheckByMobile.get(cs[i].Contact.MobilePhone);  // taufik, update 30 july 2020
                    cs[i].UnCount__c = TRUE;
                    system.debug('#SchCMUDispatch : MDScheckByMobile - '+cs[i].Named_User__c);
                }
                else if (MDScheckByEmail.get(cs[i].Contact.Email) != NULL) {
                    cs[i].Named_User__c = MDScheckByEmail.get(cs[i].Contact.Email);  // taufik, update 30 july 2020
                    cs[i].UnCount__c = TRUE;
                    system.debug('#SchCMUDispatch : MDScheckByEmail - '+cs[i].Named_User__c);
                }
                else {
                    // count bertambah, sesuai dengan Parent.Named_User__c; 
                    if (NamedUser_loopCMU_Digital.get(cs[i].Named_User__c) != NULL) {
                        integer seq = NamedUser_loopCMU_Digital.get(cs[i].Named_User__c);
                        if (DigitalCMU[seq].Count_Case__c == NULL) DigitalCMU[seq].Count_Case__c = 1;
                        else DigitalCMU[seq].Count_Case__c += 1;
                    }

                    loopCMUDig += 1;
                }
            }
            else if (cs[i].ParentId != NULL && cs[i].Parent.Named_User__c != NULL) {
                cs[i].Named_User__c = cs[i].Parent.Named_User__c; // jika sudah pernah di handle oleh Named user, akan di assign kembali.
                cs[i].OwnerId = cs[i].Parent.OwnerId;
                cs[i].PIC__c = cs[i].Parent.PIC__c;            

                FlagSameUser = TRUE;
                system.debug('#SchCMUDispatch : Parent.NamedUser - '+cs[i].Named_User__c);

                //if (listCMU[loopCMU].Count_Case__c == NULL) listCMU[loopCMU].Count_Case__c = 1;
                //else listCMU[loopCMU].Count_Case__c += 1;                
                // count bertambah, sesuai dengan Parent.Named_User__c; 
                if (NamedUser_loopCMU.get(cs[i].Named_User__c) != NULL) {
                    integer seq = NamedUser_loopCMU.get(cs[i].Named_User__c);
					if (listCMU[seq].Count_Case__c == NULL) listCMU[seq].Count_Case__c = 1;
                	else listCMU[seq].Count_Case__c += 1;
                    
                    // count skip. jika sudah dapat case disini, case berikutnya dilewati.
					if (listCMU[seq].Count_Skip__c == NULL) listCMU[seq].Count_Skip__c = 1;
                	else listCMU[seq].Count_Skip__c += 1;
                }
            }
            else if (MDScheckByName.get(cs[i].Contact.Name) != NULL) {
                cs[i].Named_User__c = MDScheckByName.get(cs[i].Contact.Name);
                cs[i].UnCount__c = TRUE;
                FlagSameUser = TRUE;
                system.debug('#SchCMUDispatch : MDScheckByName - '+cs[i].Named_User__c);
            }
            else if (MDScheckByMobile.get(cs[i].Contact.MobilePhone) != NULL) {
                cs[i].Named_User__c = MDScheckByMobile.get(cs[i].Contact.MobilePhone);
                cs[i].UnCount__c = TRUE;
                FlagSameUser = TRUE;
                system.debug('#SchCMUDispatch : MDScheckByMobile - '+cs[i].Named_User__c);
            }
            else if (MDScheckByEmail.get(cs[i].Contact.Email) != NULL) {
                cs[i].Named_User__c = MDScheckByEmail.get(cs[i].Contact.Email);
                cs[i].UnCount__c = TRUE;
                FlagSameUser = TRUE;
                system.debug('#SchCMUDispatch : MDScheckByEmail - '+cs[i].Named_User__c);
            }
            else {
            	if (Test.isRunningTest()) cs[i].Named_User__c = 'Test';
                else cs[i].Named_User__c = listCMU[loopCMU].Name;
	            FlagSameUser = FALSE;
                system.debug('#SchCMUDispatch : Normal - '+cs[i].Named_User__c);

                if (!Test.isRunningTest())
                if (listCMU[loopCMU].Count_Case__c == NULL) listCMU[loopCMU].Count_Case__c = 1;
                else listCMU[loopCMU].Count_Case__c += 1;
            }           

			if (cs[i].Named_User__c != NULL) 
                if (maplistCMU.get(cs[i].Named_User__c) != NULL )
	                if (maplistCMU.get(cs[i].Named_User__c).User__c != NULL ) {
                		cs[i].OwnerId = maplistCMU.get(cs[i].Named_User__c).User__c;
                		cs[i].PIC__c = maplistCMU.get(cs[i].Named_User__c).User__c;            
    	            }
            // add map
            if (cs[i].Contact.Name != NULL)
            	if (MDScheckByName.get(cs[i].Contact.Name) == NULL) MDScheckByName.put(cs[i].Contact.Name, cs[i].Named_User__c);
            
            if (cs[i].Contact.MobilePhone != NULL)
            	if (MDScheckByMobile.get(cs[i].Contact.MobilePhone) == NULL) MDScheckByMobile.put(cs[i].Contact.MobilePhone, cs[i].Named_User__c);
            
            if (cs[i].Contact.Email != NULL)
                if (!EmailDummy.contains(cs[i].Contact.Email))
                	if (MDScheckByEmail.get(cs[i].Contact.Email) == NULL) MDScheckByEmail.put(cs[i].Contact.Email, cs[i].Named_User__c);                
            
            if (!FlagSameUser)    
                loopCMU += 1;

            // 27 Apr 2020, Jika ada data Count Skip, lewati.
            if (loopCMU == listCMU.size()) loopCMU = 0;            
            // check, jika ada count skip, lewati
            if (listCMU[loopCMU].Count_Skip__c == NULL) listCMU[loopCMU].Count_Skip__c = 0;
            if (listCMU[loopCMU].Count_Skip__c > 0) checkskip = TRUE;
            if (Test.isRunningTest()) checkskip = TRUE;
            // check Data Skip
            system.debug('## Named User : '+listCMU[loopCMU].Name+' ['+loopCMU+'] Count_Case='+listCMU[loopCMU].Count_Case__c+'; count_skip='+listCMU[loopCMU].Count_skip__c);

            while(checkskip){
                if (loopCMU == listCMU.size()) loopCMU = 0;
                // check Data Skip
                system.debug('## Named User Loop CheckSkip : '+listCMU[loopCMU].Name+' ['+loopCMU+'] Count_Case='+listCMU[loopCMU].Count_Case__c+'; count_skip='+listCMU[loopCMU].Count_skip__c);
                
                if (listCMU[loopCMU].Count_Skip__c == NULL) listCMU[loopCMU].Count_Skip__c = 0;
                if (listCMU[loopCMU].Count_Skip__c == 0) checkskip = FAlSE;
                else listCMU[loopCMU].Count_Skip__c = listCMU[loopCMU].Count_Skip__c - 1;
                
                if (checkskip) loopCMU += 1;
            }
            // 27 Apr 2020, END ====> Jika ada data Count Skip, lewati.

        }

        // update case count            
        if (listCMU.size() > 0) update listCMU;
        
        if (cs.size() > 0) {
            // test Result
            list<case> cs2 = new list<case>();
            cs2.add(cs[0]);
            CMUDispatchBatch jb;
            if (Test.isRunningTest()) jb = new CMUDispatchBatch(cs2);
            else jb = new CMUDispatchBatch(cs);
            Database.executeBatch(jb, 1);
        }
            //update cs;
        
		//return 'Success';
    }
}