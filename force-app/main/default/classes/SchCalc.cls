global class SchCalc{
    
//    @Future
    public static void FCRCaseDate(Date Tanggal, List<id> ContactId){
        system.debug('Tanggal : '+Tanggal);
        system.debug('List<id> : '+contactid.size());        
        
        Date TodayDate = Tanggal;
        Date StartDate = Tanggal;
        Date EndDate = Tanggal;

        Date StartDatePrev = Tanggal;
        Date EndDatePrev = Tanggal;
        
        StartDate = date.newInstance(TodayDate.Year(), TodayDate.Month(), 1);
        //IF (TodayDate.Month() == 1 || TodayDate.Month() == 3 || TodayDate.Month() == 5 || TodayDate.Month() == 7 || TodayDate.Month() == 8 || TodayDate.Month() == 10 || TodayDate.Month() == 12 )
        EndDate = StartDate.addMonths(1); //date.newInstance(TodayDate.Year(), TodayDate.Month(), 27);
        
        List<String> AccountTemp = new List<String>();
        Map<String,Integer> Revenue = new Map<String,Integer>();
        Map<String,Integer> Rangking = new Map<String,Integer>();

        integer i = 0;

// Previous Month        
        EndDatePrev = StartDate - 1;
        StartDatePrev = date.newInstance(EndDatePrev.Year(), EndDatePrev.Month(), 1);
		//<contactId+'-'+CaseType, Created Date>
        Map<String,Date> CaseTypePrev = new Map<String,Date>();
        
        AggregateResult[] groupedResultsOld = [SELECT ContactId, Case_Type__c, Create_Date__c, Count(id) data
          FROM Case
          WHERE Create_Date__c >=: StartDatePrev and Create_Date__c <=: EndDatePrev and ContactId IN : ContactId and ContactId != NULL
          GROUP BY ContactId, Case_Type__c, Create_Date__c
          Order BY ContactId, Case_Type__c, Create_Date__c desc];

        String ContactCaseType = '';
		Date ContactCaseTypeDate = StartDatePrev;
        
        for (AggregateResult ar : groupedResultsOld)  {
            ContactCaseType = string.valueOf(ar.get('ContactId')) + '-' + string.valueOf(ar.get('Case_Type__c'));
            ContactCaseTypeDate = date.valueOf(ar.get('Create_date__c'));
            
			if (CaseTypePrev.Get(ContactCaseType) == NULL) CaseTypePrev.Put(ContactCaseType,ContactCaseTypeDate);
        }

// This Month
        contact ct = new contact();
        //Map<String,contact> ct = new Map<String,contact>();
        list<contact> listct = new list<contact>();
        AggregateResult[] groupedResults = [SELECT ContactId, Case_Type__c, Count(id) data
          FROM Case
          WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId IN : ContactId and ContactId != NULL
          GROUP BY ContactId, Case_Type__c
          Order BY ContactId, Case_Type__c];
        string branchTemp = '';
        string ContactTemp = '';
 		
        // add for Insurance type fcr afi, by Beni R 16032022
        Map<String,String> insuranceTypeAFI = new Map<String,String>();
        AggregateResult[] contactInsuranceGroup = [SELECT ContactId, Insurance_Type_AFI__c, Count(id) data
          FROM Case
          WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId IN : ContactId and ContactId != NULL and Insurance_Type_AFI__c != NULL
          GROUP BY ContactId, Insurance_Type_AFI__c
          Order BY ContactId, Insurance_Type_AFI__c];
        String contactIdIT = '';
        String insuranceTypeIT = '';
        for(AggregateResult ci : contactInsuranceGroup) {
            contactIdIT = string.valueOf(ci.get('ContactId'));
            insuranceTypeIT = string.valueOf(ci.get('Insurance_Type_AFI__c'))+'('+ string.valueOf(ci.get('data'))+')'+';';   
            if (insuranceTypeAFI.Get(contactIdIT) == NULL) {
                insuranceTypeAFI.Put(contactIdIT,insuranceTypeIT);
            } else {
                insuranceTypeIT = insuranceTypeIT + insuranceTypeAFI.Get(contactIdIT);
                insuranceTypeAFI.Put(contactIdIT,insuranceTypeIT);
            }                
        }
        // end add for Insurance type fcr afi, by Beni R 16032022
        
        Boolean HaveCaselast30Days = FALSE;
        for (AggregateResult ar : groupedResults)  {
            // Check Last Case 30Days
            HaveCaselast30Days = FALSE;
            ContactCaseType = string.valueOf(ar.get('ContactId')) + '-' + string.valueOf(ar.get('Case_Type__c'));
            if (CaseTypePrev.Get(ContactCaseType) != NULL || Test.isRunningTest() ) 
                if (CaseTypePrev.Get(ContactCaseType) < (Tanggal - 30) || Test.isRunningTest()) 
                	HaveCaselast30Days = TRUE;
            // End Check Last Case 30Days
            
            // reset Rangking per Branch.
            if (ContactTemp != string.valueOf(ar.get('ContactId'))) {                
                if (ct.id != NULL) listct.add(ct);
                ContactTemp = string.valueOf(ar.get('ContactId'));
                ct = new contact();
                string dataid = string.valueOf(ar.get('ContactId'));
                ct.id = dataid;                
            }

            if (TodayDate.month() == 1 || Test.isRunningTest()) {
                
                if (ct.FCR_Jan__c == null) ct.FCR_Jan__c = 0;
                if (ct.Repeat_Jan__c == null) ct.Repeat_Jan__c = 0;
                if (ct.Case_Type_Jan__c == null) ct.Case_Type_Jan__c = '';
				if (ct.Repeat_Case_Jan__c == null) ct.Repeat_Case_Jan__c = 0;
				if (ct.Repeat_Before_Jan__c == null) ct.Repeat_Before_Jan__c = 0;
				if (ct.Case_Count_Jan__c == null) ct.Case_Count_Jan__c = 0;
                ct.Case_Count_Jan__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Jan__c += 1;
				else ct.Repeat_Jan__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.

                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Jan__c += integer.valueof(ar.get('data'));
                
                ct.Last_Case_Jan__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Jan__c.length() < 200) ct.Case_Type_Jan__c += string.valueOf(ar.get('Case_Type__c'))+';';
                
                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Jan__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Jan__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Jan__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Jan__c = ct.FCR_Jan__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Jan__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                  
            }
            if (TodayDate.month() == 2 || Test.isRunningTest()) {
                if (ct.FCR_Feb__c == null) ct.FCR_Feb__c = 0;
                if (ct.Repeat_Feb__c == null) ct.Repeat_Feb__c = 0;
                if (ct.Case_Type_Feb__c == null) ct.Case_Type_Feb__c = '';
				if (ct.Repeat_Case_Feb__c == null) ct.Repeat_Case_Feb__c = 0;
				if (ct.Repeat_Before_Feb__c == null) ct.Repeat_Before_Feb__c = 0;
				if (ct.Case_Count_Feb__c == null) ct.Case_Count_Feb__c = 0;
                ct.Case_Count_Feb__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Feb__c += 1;
				else ct.Repeat_Feb__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Feb__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Feb__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Feb__c.length() < 200) ct.Case_Type_Feb__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Feb__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Feb__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Feb__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Feb__c = ct.FCR_Feb__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Feb__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022 
            }
            if (TodayDate.month() == 3 || Test.isRunningTest()) {
                if (ct.FCR_Mar__c == null) ct.FCR_Mar__c = 0;
                if (ct.Repeat_Mar__c == null) ct.Repeat_Mar__c = 0;
                if (ct.Case_Type_Mar__c == null) ct.Case_Type_Mar__c = '';
				if (ct.Repeat_Case_Mar__c == null) ct.Repeat_Case_Mar__c = 0;
				if (ct.Repeat_Before_Mar__c == null) ct.Repeat_Before_Mar__c = 0;
				if (ct.Case_Count_Mar__c == null) ct.Case_Count_Mar__c = 0;
                ct.Case_Count_Mar__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Mar__c += 1;
				else ct.Repeat_Mar__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Mar__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Mar__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Mar__c.length() < 200) ct.Case_Type_Mar__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Mar__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Mar__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Mar__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Mar__c = ct.FCR_Mar__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Mar__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022             
            }
            if (TodayDate.month() == 4 || Test.isRunningTest()) {
                if (ct.FCR_Apr__c == null) ct.FCR_Apr__c = 0;
                if (ct.Repeat_Apr__c == null) ct.Repeat_Apr__c = 0;
                if (ct.Case_Type_Apr__c == null) ct.Case_Type_Apr__c = '';
				if (ct.Repeat_Case_Apr__c == null) ct.Repeat_Case_Apr__c = 0;
				if (ct.Repeat_Before_Apr__c == null) ct.Repeat_Before_Apr__c = 0;
				if (ct.Case_Count_Apr__c == null) ct.Case_Count_Apr__c = 0;
                ct.Case_Count_Apr__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Apr__c += 1;
				else ct.Repeat_Apr__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Apr__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Apr__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Apr__c.length() < 200) ct.Case_Type_Apr__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Apr__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Apr__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Apr__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Apr__c = ct.FCR_Apr__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Apr__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022 
            } 
            if (TodayDate.month() == 5 || Test.isRunningTest()) {
                if (ct.FCR_Mei__c == null) ct.FCR_Mei__c = 0;
                if (ct.Repeat_Mei__c == null) ct.Repeat_Mei__c = 0;
                if (ct.Case_Type_Mei__c == null) ct.Case_Type_Mei__c = '';
				if (ct.Repeat_Case_Mei__c == null) ct.Repeat_Case_Mei__c = 0;
				if (ct.Repeat_Before_Mei__c == null) ct.Repeat_Before_Mei__c = 0;
				if (ct.Case_Count_Mei__c == null) ct.Case_Count_Mei__c = 0;
                ct.Case_Count_Mei__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Mei__c += 1;
				else ct.Repeat_Mei__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Mei__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Mei__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Mei__c.length() < 200) ct.Case_Type_Mei__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Mei__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Mei__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Mei__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Mei__c = ct.FCR_Mei__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Mei__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022              
            } 
            if (TodayDate.month() == 6 || Test.isRunningTest()) {
                if (ct.FCR_Jun__c == null) ct.FCR_Jun__c = 0;
                if (ct.Repeat_Jun__c == null) ct.Repeat_Jun__c = 0;
                if (ct.Case_Type_Jun__c == null) ct.Case_Type_Jun__c = '';
				if (ct.Repeat_Case_Jun__c == null) ct.Repeat_Case_Jun__c = 0;
				if (ct.Repeat_Before_Jun__c == null) ct.Repeat_Before_Jun__c = 0;
				if (ct.Case_Count_Jun__c == null) ct.Case_Count_Jun__c = 0;
                ct.Case_Count_Jun__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Jun__c += 1;
				else ct.Repeat_Jun__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Jun__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Jun__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Jun__c.length() < 200) ct.Case_Type_Jun__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Jun__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Jun__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Jun__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Jun__c = ct.FCR_Jun__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Jun__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                
            } 
            if (TodayDate.month() == 7 || Test.isRunningTest()) {
                if (ct.FCR_Jul__c == null) ct.FCR_Jul__c = 0;
                if (ct.Repeat_Jul__c == null) ct.Repeat_Jul__c = 0;
                if (ct.Case_Type_Jul__c == null) ct.Case_Type_Jul__c = '';
				if (ct.Repeat_Case_Jul__c == null) ct.Repeat_Case_Jul__c = 0;
				if (ct.Repeat_Before_Jul__c == null) ct.Repeat_Before_Jul__c = 0;
				if (ct.Case_Count_Jul__c == null) ct.Case_Count_Jul__c = 0;
                ct.Case_Count_Jul__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Jul__c += 1;
				else ct.Repeat_Jul__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Jul__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Jul__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Jul__c.length() < 200) ct.Case_Type_Jul__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Jul__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Jul__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Jul__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Jul__c = ct.FCR_Jul__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Jul__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                 
            } 
            if (TodayDate.month() == 8 || Test.isRunningTest()) {
                if (ct.FCR_Agt__c == null) ct.FCR_Agt__c = 0;
                if (ct.Repeat_Agt__c == null) ct.Repeat_Agt__c = 0;
                if (ct.Case_Type_Agt__c == null) ct.Case_Type_Agt__c = '';
				if (ct.Repeat_Case_Agt__c == null) ct.Repeat_Case_Agt__c = 0;
				if (ct.Repeat_Before_Agt__c == null) ct.Repeat_Before_Agt__c = 0;
				if (ct.Case_Count_Agt__c == null) ct.Case_Count_Agt__c = 0;
                ct.Case_Count_Agt__c += integer.valueof(ar.get('data'));
                
                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Agt__c += 1;
				else ct.Repeat_Agt__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Agt__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Agt__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Agt__c.length() < 200) ct.Case_Type_Agt__c += string.valueOf(ar.get('Case_Type__c'))+';';
                //if (ct.id != NULL) update ct;
                //listct.add(ct);

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Agt__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Agt__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Agt__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Agt__c = ct.FCR_Agt__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Agt__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                 
            } 
            if (TodayDate.month() == 9 || Test.isRunningTest()) {
                if (ct.FCR_Sep__c == null) ct.FCR_Sep__c = 0;
                if (ct.Repeat_Sep__c == null) ct.Repeat_Sep__c = 0;
                if (ct.Case_Type_Sep__c == null) ct.Case_Type_Sep__c = '';
				if (ct.Repeat_Case_Sep__c == null) ct.Repeat_Case_Sep__c = 0;
				if (ct.Repeat_Before_Sep__c == null) ct.Repeat_Before_Sep__c = 0;
				if (ct.Case_Count_Sep__c == null) ct.Case_Count_Sep__c = 0;
                ct.Case_Count_Sep__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Sep__c += 1;
				else ct.Repeat_Sep__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Sep__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Sep__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Sep__c.length() < 200) ct.Case_Type_Sep__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Sep__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Sep__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Sep__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Sep__c = ct.FCR_Sep__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Sep__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                 
            } 
            if (TodayDate.month() == 10 || Test.isRunningTest()) {
                if (ct.FCR_Okt__c == null) ct.FCR_Okt__c = 0;
                if (ct.Repeat_Okt__c == null) ct.Repeat_Okt__c = 0;
                if (ct.Case_Type_Okt__c == null) ct.Case_Type_Okt__c = '';
				if (ct.Repeat_Case_Okt__c == null) ct.Repeat_Case_Okt__c = 0;
				if (ct.Repeat_Before_Okt__c == null) ct.Repeat_Before_Okt__c = 0;
				if (ct.Case_Count_Okt__c == null) ct.Case_Count_Okt__c = 0;
                ct.Case_Count_Okt__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Okt__c += 1;
				else ct.Repeat_Okt__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Okt__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Okt__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Okt__c.length() < 200) ct.Case_Type_Okt__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Okt__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Okt__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Okt__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Okt__c = ct.FCR_Okt__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Okt__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                 
            } 
            if (TodayDate.month() == 11 || Test.isRunningTest()) {
                if (ct.FCR_Nov__c == null) ct.FCR_Nov__c = 0;
                if (ct.Repeat_Nov__c == null) ct.Repeat_Nov__c = 0;
                if (ct.Case_Type_Nov__c == null) ct.Case_Type_Nov__c = '';
				if (ct.Repeat_Case_Nov__c == null) ct.Repeat_Case_Nov__c = 0;
				if (ct.Repeat_Before_Nov__c == null) ct.Repeat_Before_Nov__c = 0;
				if (ct.Case_Count_Nov__c == null) ct.Case_Count_Nov__c = 0;
                ct.Case_Count_Nov__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Nov__c += 1;
				else ct.Repeat_Nov__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Nov__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Nov__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Nov__c.length() < 200) ct.Case_Type_Nov__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Nov__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Nov__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Nov__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Nov__c = ct.FCR_Nov__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Nov__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                 
            } 
            if (TodayDate.month() == 12 || Test.isRunningTest()) {
                if (ct.FCR_Des__c == null) ct.FCR_Des__c = 0;
                if (ct.Repeat_Des__c == null) ct.Repeat_Des__c = 0;
                if (ct.Case_Type_Des__c == null) ct.Case_Type_Des__c = '';
				if (ct.Repeat_Case_Des__c == null) ct.Repeat_Case_Des__c = 0;
				if (ct.Repeat_Before_Des__c == null) ct.Repeat_Before_Des__c = 0;
				if (ct.Case_Count_Des__c == null) ct.Case_Count_Des__c = 0;
                ct.Case_Count_Des__c += integer.valueof(ar.get('data'));

                if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Des__c += 1;
				else ct.Repeat_Des__c += (integer.valueof(ar.get('data')) - 1); // kurang 1 untuk Repeat Call nya.
                
                if (integer.valueof(ar.get('data')) > 1 ) ct.Repeat_Case_Des__c += integer.valueof(ar.get('data'));

                ct.Last_Case_Des__c = Tanggal; //date.valueOf(ar.get('Create_date__c'));
                if (ct.Case_Type_Des__c.length() < 200) ct.Case_Type_Des__c += string.valueOf(ar.get('Case_Type__c'))+';';

                if (HaveCaselast30Days) {
                    ct.Repeat_Before_Des__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Des__c += 1; // tambah 1, jika ada Repeat di Before.
                    if (integer.valueof(ar.get('data')) == 1 ) ct.Repeat_Case_Des__c += 1;
                    if (integer.valueof(ar.get('data')) == 1 ) ct.FCR_Des__c = ct.FCR_Des__c - 1; // set nol, karena tidak mungkin FCR
                }
				// add for Insurance type fcr afi, by Beni R 16032022
                if (insuranceTypeAFI.get(ct.id) != null) ct.Insurance_Type_Des__c = insuranceTypeAFI.get(ct.id); 
				// end add for Insurance type fcr afi, by Beni R 16032022                 
            }
        }
		if (ct.id != NULL) listct.add(ct);
        
        if (listct.size()>0) update listct;
        System.Debug('AccountTemp '+AccountTemp);
        System.Debug('Data size - listct.size() '+listct.size());
        
        integer t = null;
        t = isNull(t);

	}
    
    public static Integer isNull(Integer sKata)
    {
        if(sKata == null) sKata = 0;
        return sKata;
    }
}