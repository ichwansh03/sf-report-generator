public with sharing class AMFSCollectionMonitoringCtrl {

    public string header {get;set;}
    public string footer {get;set;}

    public string MonthName {get;set;}

    public string ByCase {get;set;}
    public string ByAmount {get;set;}
    public string ByDateCase {get;set;}
    public string ByDateAmount {get;set;}
    public string paramContactId {get;set;}    
    public Call_List__c filterdata {get;set;}    
    public List<SelectOption> listOfCaseType;
    public map<string, Double> userSisaWaktu {get;set;}
    public map<string, Double> TargetConserved {get;set;}

    //--Generate picklist payment type
    public List<SelectOption> getlistOfCaseType() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('Renewal Reminder', 'Renewal Reminder')); // Big RTU, 
        tempList.add(new SelectOption('Lapse Konven', 'Lapse Konven')); // Done
        tempList.add(new SelectOption('MKP', 'MKP')); // DONE
        tempList.add(new SelectOption('Cuti Premi', 'Cuti Premi')); // ????
        tempList.add(new SelectOption('Redemption & Withdrawal', 'Redemption & Withdrawal')); //Redemption Konven + Withdrawal
        tempList.add(new SelectOption('Withdrawal', 'Withdrawal')); //Redemption Konven
        tempList.add(new SelectOption('Redemption Konven', 'Redemption Konven')); //Redemption Konven + Withdrawal
        tempList.add(new SelectOption('RTU', 'RTU')); // ????
        tempList.add(new SelectOption('Lapse TM', 'Lapse TM'));
        tempList.add(new SelectOption('Redemption TM', 'Redemption TM'));
        return tempList;
    }
    
    public AMFSCollectionMonitoringCtrl(){        
        getHeaderFooter();
        //getdata();
        paramContactId = ApexPages.currentPage().getParameters().get('contactID');
        
        //accountList = [select id, name from Account LIMIT 50];
        //contactList = [Select id, name, account.name, email from Contact LIMIT 50];
        filterdata = new Call_List__c(
            RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId(),
            Activity__c = 'Collection'
        );
        system.debug('#RecordType : '+Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId());
        //filterdata.RecordTypeId = Schema.SObjectType.Call_List__c.getRecordTypeInfosByName().get('Collection AMFS').getRecordTypeId();
        //filterdata.Activity__c = 'Collection';

        date datetoday = date.today();
        filterdata.List_Date__c = date.newInstance(datetoday.year(), datetoday.month(), 1);
        date datenext = datetoday.addMonths(1);
        filterdata.Expired_Date__c = datetoday; //date.newInstance(datenext.year(), datenext.month(), 1) - 1;
        //filterdata.Courier__c
        //Due_Date__c // Start 
        //Closed_Date__c = // end
        String ExportToExcel = ApexPages.currentPage().getParameters().get('ExportToExcel');
        String DateForm = ApexPages.currentPage().getParameters().get('DateFrom');
        String DateTo = ApexPages.currentPage().getParameters().get('DateTo');
        String Courier = ApexPages.currentPage().getParameters().get('Courier');
        
        if (DateForm != NULL || DateTo != NULL || Courier != NULL || ExportToExcel == 'TRUE')
            getdata();
    }

    public void getHeaderFooter(){
        header = '';
        footer = '';
        
        header += '<html>';
        header += '<head>';
        header += '<style>';
        header += 'table {';
        header += '  font-family: arial, sans-serif;';
        header += '  border-collapse: collapse;';
        header += '  width: 100%;';
        header += '}';
        header += '';
        header += 'td, th {';
        header += '  border: 1px solid #dddddd;';
        header += '  text-align: left;';
        header += '  padding: 8px;';
        header += '}';
        header += '';
        header += 'tr:nth-child(2) {';
        header += '  background-color: #dddddd;';
        header += '}';
        header += 'tr:nth-child(4) {';
        header += '  background-color: #dddddd;';
        header += '}';
        header += 'tr:nth-child(10) {';
        header += '  background-color: #00FFFF;';
        header += '}';
        header += '</style>';
        header += '</head>';
        header += '<body>';
        
        footer += '</body>';
        footer += '</html>';
    }

    public PageReference getdata(){
        //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,'Waiting..'));
        
        //filterdata.List_Date__c = date.newInstance(filterdata.List_Date__c.year(), filterdata.List_Date__c.month(), 1);

        if (filterdata.Expired_Date__c.month() == 1) MonthName = 'January';
        if (filterdata.Expired_Date__c.month() == 2) MonthName = 'February';
        if (filterdata.Expired_Date__c.month() == 3) MonthName = 'Maret';
        if (filterdata.Expired_Date__c.month() == 4) MonthName = 'April';
        if (filterdata.Expired_Date__c.month() == 5) MonthName = 'May';
        if (filterdata.Expired_Date__c.month() == 6) MonthName = 'June';
        if (filterdata.Expired_Date__c.month() == 7) MonthName = 'July';
        if (filterdata.Expired_Date__c.month() == 8) MonthName = 'August';
        if (filterdata.Expired_Date__c.month() == 9) MonthName = 'September';
        if (filterdata.Expired_Date__c.month() == 10) MonthName = 'October';
        if (filterdata.Expired_Date__c.month() == 11) MonthName = 'November';
        if (filterdata.Expired_Date__c.month() == 12) MonthName = 'December';

        if (filterdata.Case_Type__c == 'Lapse Konven' || filterdata.Case_Type__c == 'MKP' || filterdata.Case_Type__c == 'Renewal Reminder') {
            getdataLapseAsOff();
            getdataLapse();
        }
        if (filterdata.Case_Type__c == 'Redemption & Withdrawal' || filterdata.Case_Type__c == 'Redemption Konven' || filterdata.Case_Type__c == 'Withdrawal' || filterdata.Case_Type__c == 'Redemption TM') {
            getdataLapseAsOff_RW();
            getdataLapse_RW();
        }
        if (filterdata.Case_Type__c == 'Lapse TM' || filterdata.Case_Type__c == 'Cuti Premi' || filterdata.Case_Type__c == 'RTU') {
            getdataLapseAsOff();
            getdataLapse();
        }

        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Get Data successfully'));
        return null;

    }
    
    public void getdataLapse(){        
        // query data by Case
        map<string, string> username = new map<string, string>();
        for (User us2 : [SELECT id, Name FROM User]) {
            username.put(us2.id, us2.Name);
        }
        String RowCaseAgent = '';
        String RowCaseTotal = '';
        String RowCaseContacted = '';
        String RowCaseApproved = '';
        String RowCaseNotApproved = '';
        String RowCaseUnContacted = '';
        String RowCaseNotYetCall = '';
        String RowCaseConserved = '';
        String RowCasePaybySystem = '';
        String RowCaseOther = '';
        
        String RowAmountAgent = '';
        String RowAmountTotal = '';
        String RowAmountContacted = '';
        String RowAmountApproved = '';
        String RowAmountNotApproved = '';
        String RowAmountUnContacted = '';
        String RowAmountNotYetCall = '';
        String RowAmountConserved = '';
        String RowAmountPaybySystem = '';
        String RowAmountOther = '';

        String AgentName = '';
        String CallStatus = '';

        Double Amountcase = 0;
        Double TotalAmount = 0;
        Double AmountContacted = 0;
        Double AmountApproved = 0;
        Double AmountNotApproved = 0;
        Double AmountUnContacted = 0;
        Double AmountNotYetCall = 0;
        Double AmountConserved = 0;
        Double AmountPaybySystem = 0;
        Double AmountOther = 0;

        integer countcase = 0; 
        integer totalCount = 0;
        integer countContacted = 0;
        integer countApproved = 0;
        integer countNotApproved = 0;
        integer countUnContacted = 0;
        integer countNotYetCall = 0;
        integer countConserved = 0;
        integer countPaybySystem = 0;
        integer countOther = 0;

        // Grand Total
        Double GrandTotalAmount = 0;
        Double TotalAmountContacted = 0;
        Double TotalAmountApproved = 0;
        Double TotalAmountNotApproved = 0;
        Double TotalAmountUnContacted = 0;
        Double TotalAmountNotYetCall = 0;
        Double TotalAmountConserved = 0;
        Double TotalAmountPaybySystem = 0;
        Double TotalAmountOther = 0;

        integer GrandtotalCount = 0;
        integer TotalcountContacted = 0;
        integer TotalcountApproved = 0;
        integer TotalcountNotApproved = 0;
        integer TotalcountUnContacted = 0;
        integer TotalcountNotYetCall = 0;
        integer TotalcountConserved = 0;
        integer TotalcountPaybySystem = 0;
        integer TotalcountOther = 0;

        string tempagent = '';

        AggregateResult[] groupedResults;
        if(Test.isRunningTest())            
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                  GROUP BY Agent__c, Call_Status_Config__c];
        else
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type_Config__c =: filterdata.Case_Type__c and ((Call_Status_Config__c = NULL) OR (Call_Status_Config__c != NULL AND Call_Date__c =: filterdata.Expired_Date__c))
                    WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type_Config__c =: filterdata.Case_Type__c and ((Call_Status_Config__c = NULL) OR (Call_Status_Config__c != NULL AND Collection_Call_Date_F__c =: filterdata.Expired_Date__c))
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type_Config__c =: filterdata.Case_Type__c and (Call_Status_Config__c != NULL AND Collection_Call_Date_F__c =: filterdata.Expired_Date__c)
                  GROUP BY Agent__c, Call_Status_Config__c];
        for (AggregateResult ar : groupedResults)  {
            AgentName = username.get(string.valueof(ar.get('Agent__c')));
            CallStatus = string.valueof(ar.get('Call_Status_Config__c'));
            Amountcase = double.valueof(ar.get('expr0'));
            countcase = integer.valueof(ar.get('expr1'));
                
            System.debug('Agent__c : ' + ar.get('Agent__c'));
            System.debug('Agent Name : ' +AgentName);

            System.debug('Call_Status_Config__c : ' + CallStatus);
            System.debug('Sum APE Convery' + Amountcase);
            System.debug('Count : ' + countcase);
            
            if (tempagent != AgentName) {
                // ByCase ==============================
                if (totalCount == 0) CountConserved = 0;
                else CountConserved = CountApproved * 100 / totalCount;
                
                system.debug('totalCount : '+totalCount);
                system.debug('CountApproved : '+CountApproved);
                system.debug('CountConserved : '+CountConserved);

                RowCaseAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row.
                if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
                if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
                if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
                if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
                if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
                if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
                if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
                if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
                if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalCount += totalCount;
                TotalcountContacted += countContacted;
                TotalcountApproved += countApproved;
                TotalcountNotApproved += countNotApproved;
                TotalcountUnContacted += countUnContacted;
                TotalcountNotYetCall += countNotYetCall;
                TotalcountConserved += countConserved;
                TotalcountPaybySystem += countPaybySystem;
                TotalcountOther += countOther;

                totalCount = 0;
                CountContacted = 0;
                CountApproved = 0;
                CountNotApproved = 0;
                CountUnContacted = 0;
                CountNotYetCall = 0;
                CountConserved = 0;
                CountPaybySystem = 0;
                CountOther = 0;
                
                // ByAmount ==============================
                if (totalAmount == 0) AmountConserved = 0;
                else AmountConserved = AmountApproved * 100 / totalAmount;
                
                AmountConserved = AmountConserved.round();
                
                system.debug('2. totalAmount : '+totalAmount);
                system.debug('2. AmountApproved : '+AmountApproved);
                system.debug('2. AmountConserved : '+AmountConserved);

                RowAmountAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row. // Terbilang.AmountText(math.round(CPFieldList[i-1].Sales_Price__c))
                if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
                if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
                
                //if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
                //integer sisawaktu = 1;
                double TargetDaily = 0;
                //if (userSisaWaktu.get(tempagent) != NULL)
                //    sisawaktu = userSisaWaktu.get(tempagent)
                if (TargetConserved.get(tempagent) != NULL)
                    TargetDaily = TargetConserved.get(tempagent);
                //double Target65 = 0;
                
                if (tempagent != '') if (AmountApproved < TargetDaily) RowAmountApproved += '<td bgcolor="#FF0000">'+Terbilang.AmountText(AmountApproved)+'</td>';
                                        else RowAmountApproved += '<td bgcolor="#008000">'+Terbilang.AmountText(AmountApproved)+'</td>';

                if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
                if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
                if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';
                if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
                if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
                if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalAmount += totalAmount;
                TotalAmountContacted += AmountContacted;
                TotalAmountApproved += AmountApproved;
                TotalAmountNotApproved += AmountNotApproved;
                TotalAmountUnContacted += AmountUnContacted;
                TotalAmountNotYetCall += AmountNotYetCall;
                TotalAmountConserved += AmountConserved;
                TotalAmountPaybySystem += AmountPaybySystem;
                TotalAmountOther += AmountOther;

                totalAmount = 0;
                AmountContacted = 0;
                AmountApproved = 0;
                AmountNotApproved = 0;
                AmountUnContacted = 0;
                AmountNotYetCall = 0;
                AmountConserved = 0;
                AmountPaybySystem = 0;
                AmountOther = 0;

                tempagent = AgentName;
            }

            // by Count ============================
            // 19 Mar20, CountNotYetCall, not counter.
            if (CallStatus != '' && CallStatus != NULL && CallStatus != 'NULL') totalCount += countcase;
            if (CallStatus == 'Approved' || CallStatus == 'Not Approved') CountContacted += countcase;
            
            if (CallStatus == 'Approved') CountApproved += countcase;
            else if (CallStatus == 'Not Approved') CountNotApproved += countcase;
            else if (CallStatus == 'Uncontacted') CountUnContacted += countcase;
            else if (CallStatus == 'Sudah Pay By System') CountPaybySystem += countcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') CountNotYetCall += countcase;
            else CountOther += countcase;
            
            // by Amount  ============================
            // 19 Mar20, CountNotYetCall, not counter.
            if (CallStatus != '' && CallStatus != NULL && CallStatus != 'NULL') totalAmount += Amountcase;
            if (CallStatus == 'Approved' || CallStatus == 'Not Approved') AmountContacted += Amountcase;
            
            if (CallStatus == 'Approved') AmountApproved += Amountcase;
            else if (CallStatus == 'Not Approved') AmountNotApproved += Amountcase;
            else if (CallStatus == 'Uncontacted') AmountUnContacted += Amountcase;
            else if (CallStatus == 'Sudah Pay By System') AmountPaybySystem += Amountcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') AmountNotYetCall += Amountcase;
            else AmountOther += Amountcase;
            
        } // end loop
        
        // By Count ============================
        // Grand Total, setelah selesai loop
        if (totalCount == 0) CountConserved = 0;
        else CountConserved = CountApproved * 100 / totalCount;

        GrandtotalCount += totalCount;
        TotalcountContacted += countContacted;
        TotalcountApproved += countApproved;
        TotalcountNotApproved += countNotApproved;
        TotalcountUnContacted += countUnContacted;
        TotalcountNotYetCall += countNotYetCall;
        
        TotalcountPaybySystem += countPaybySystem;
        TotalcountOther += countOther;

        if (GrandtotalCount == 0) TotalcountConserved = 0;
        else TotalcountConserved = TotalCountApproved * 100 / GrandtotalCount;

        if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
        if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';
        
        // grand total
        if (tempagent != '') RowCaseAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+TotalCountOther+'</td>';

        ByCase = header;
        ByCase += '<table>';
        ByCase += '<tr><th width="200">Row Labels</th>'+RowCaseAgent+'</tr>';
        ByCase += '<tr><td>Total Data Daily</td>'+RowCaseTotal+'</tr>';
        ByCase += '<tr><td>* Contacted</td>'+RowCaseContacted+'</tr>';
        ByCase += '<tr><td>** Approved</td>'+RowCaseApproved+'</tr>';
        ByCase += '<tr><td>** Not Approved</td>'+RowCaseNotApproved+'</tr>';
        ByCase += '<tr><td>* Uncontacted</td>'+RowCaseUnContacted+'</tr>';
        ByCase += '<tr><td>* Sudah Pay by System</td>'+RowCasePaybySystem+'</tr>';
        ByCase += '<tr><td>* Other</td>'+RowCaseOther+'</tr>';
        //ByCase += '<tr><td>* Not Yet Call</td>'+RowCaseNotYetCall+'</tr>';
        ByCase += '<tr><td>% Conserved</th>'+RowCaseConserved+' %</tr>';
        ByCase += '</table>';
        ByCase += footer;

        // By Amount ============================
        // Grand Total, setelah selesai loop
        if (totalAmount == 0) AmountConserved = 0;
        else AmountConserved = AmountApproved * 100 / totalAmount;
        
        AmountConserved = AmountConserved.round();

        GrandtotalAmount += totalAmount;
        TotalAmountContacted += AmountContacted;
        TotalAmountApproved += AmountApproved;
        TotalAmountNotApproved += AmountNotApproved;
        TotalAmountUnContacted += AmountUnContacted;
        TotalAmountNotYetCall += AmountNotYetCall;
        
        TotalAmountPaybySystem += AmountPaybySystem;
        TotalAmountOther += AmountOther;

        if (GrandtotalAmount == 0) TotalAmountConserved = 0;
        else TotalAmountConserved = TotalAmountApproved * 100 / GrandtotalAmount;
        
        TotalAmountConserved = TotalAmountConserved.round();

        if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
        //if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
        double TargetDaily = 0;
        if (TargetConserved.get(tempagent) != NULL)
            TargetDaily = TargetConserved.get(tempagent);
        //double Target65 = 0;
        
        if (tempagent != '') if (AmountApproved < TargetDaily) RowAmountApproved += '<td bgcolor="#FF0000">'+Terbilang.AmountText(AmountApproved)+'</td>';
        else RowAmountApproved += '<td bgcolor="#008000">'+Terbilang.AmountText(AmountApproved)+'</td>';
        
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';
        
        // grand total
        if (tempagent != '') RowAmountAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(TotalAmountContacted)+'</td>';
        //if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(TotalAmountApproved)+'</td>';
        if (TargetConserved.get('Total') != NULL)
            TargetDaily = TargetConserved.get('Total');

        if (tempagent != '') if (AmountApproved < TargetDaily) RowAmountApproved += '<td bgcolor="#FF0000">'+Terbilang.AmountText(TotalAmountApproved)+'</td>';
        else RowAmountApproved += '<td bgcolor="#008000">'+Terbilang.AmountText(TotalAmountApproved)+'</td>';
        
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(TotalAmountOther)+'</td>';

        ByAmount = header;
        ByAmount += '<table>';
        ByAmount += '<tr><th width="200">Row Labels</th>'+RowAmountAgent+'</tr>';
        ByAmount += '<tr><td>Total Data Daily</td>'+RowAmountTotal+'</tr>';
        ByAmount += '<tr><td>* Contacted</td>'+RowAmountContacted+'</tr>';
        ByAmount += '<tr><td>** Approved</td>'+RowAmountApproved+'</tr>';
        ByAmount += '<tr><td>** Not Approved</td>'+RowAmountNotApproved+'</tr>';
        ByAmount += '<tr><td>* Uncontacted</td>'+RowAmountUnContacted+'</tr>';
        ByAmount += '<tr><td>* Sudah Pay by System</td>'+RowAmountPaybySystem+'</tr>';
        ByAmount += '<tr><td>* Other</td>'+RowAmountOther+'</tr>';
        //ByAmount += '<tr><td>* Not Yet Call</td>'+RowAmountNotYetCall+'</tr>';
        ByAmount += '<tr><td>% Conserved</th>'+RowAmountConserved+'</tr>';
        ByAmount += '</table>';
        ByAmount += footer;

    }
    
    public void getdataLapseAsOff(){
        
        // query data by Case
        map<string, string> username = new map<string, string>();
        for (User us2 : [SELECT id, Name FROM User]) {
            username.put(us2.id, us2.Name);
        }

        // query data by User Detail, get Sisa Waktu Follow Up
        userSisaWaktu = new map<string, Double>();
        for (User_Detail__c ud : [SELECT id, Name, User__c, User__r.Name, Sisa_Waktu_Follow_Up__c FROM User_Detail__c]) {
            userSisaWaktu.put(ud.User__r.Name, ud.Sisa_Waktu_Follow_Up__c);
        }
        // tampung target.
        TargetConserved = new map<string, Double>();

        String RowCaseAgent = '';
        String RowCaseTotal = '';
        String RowCaseContacted = '';
        String RowCaseApproved = '';
        String RowCaseNotApproved = '';
        String RowCaseUnContacted = '';
        String RowCaseNotYetCall = '';
        String RowCaseConserved = '';
        String RowCasePaybySystem = '';
        String RowCaseOther = '';
        
        String RowAmountAgent = '';
        String RowAmountTotal = '';
        String RowAmountContacted = '';
        String RowAmountApproved = '';
        String RowAmountNotApproved = '';
        String RowAmountUnContacted = '';
        String RowAmountNotYetCall = '';
        String RowAmountConserved = '';
        String RowAmountPaybySystem = '';
        String RowAmountOther = '';
        
        String RowAmountAgreeToPayContacted = '';
        String RowAmountTargetPTD = '';
        String RowAmountKekuranganConserved = '';
        String RowAmountKekuranganConservedPerHari = '';
        String RowSisaWaktuFollowUp = '';

        String AgentName = '';
        String CallStatus = '';

        Double Amountcase = 0;
        Double TotalAmount = 0;
        Double AmountContacted = 0;
        Double AmountApproved = 0;
        Double AmountNotApproved = 0;
        Double AmountUnContacted = 0;
        Double AmountNotYetCall = 0;
        Double AmountConserved = 0;
        Double AmountPaybySystem = 0;
        Double AmountOther = 0;

        Double AmountAgreeToPayContacted = 0;
        Double AmountTargetPTD = 0;
        Double AmountKekuranganConserved = 0;
        Double AmountKekuranganConservedPerHari = 0;

        Integer SisaWaktuFollowUp = 0;
    
        integer countcase = 0; 
        integer totalCount = 0;
        integer countContacted = 0;
        integer countApproved = 0;
        integer countNotApproved = 0;
        integer countUnContacted = 0;
        integer countNotYetCall = 0;
        integer countConserved = 0;
        integer countPaybySystem = 0;
        integer countOther = 0;

        // Grand Total
        Double GrandTotalAmount = 0;
        Double TotalAmountContacted = 0;
        Double TotalAmountApproved = 0;
        Double TotalAmountNotApproved = 0;
        Double TotalAmountUnContacted = 0;
        Double TotalAmountNotYetCall = 0;
        Double TotalAmountConserved = 0;
        Double TotalAmountPaybySystem = 0;
        Double TotalAmountOther = 0;

        Double TotalAmountAgreeToPayContacted = 0;
        Double TotalAmountTargetPTD = 0;
        Double TotalAmountKekuranganConserved = 0;
        Double TotalAmountKekuranganConservedPerHari = 0;
        Integer TotalSisaWaktuFollowUp = 0;
        
        integer GrandtotalCount = 0;
        integer TotalcountContacted = 0;
        integer TotalcountApproved = 0;
        integer TotalcountNotApproved = 0;
        integer TotalcountUnContacted = 0;
        integer TotalcountNotYetCall = 0;
        integer TotalcountConserved = 0;
        integer TotalcountPaybySystem = 0;
        integer TotalcountOther = 0;

        string tempagent = '';

        SisaWaktuFollowUp = 1;

        AggregateResult[] groupedResults;
        if(Test.isRunningTest())            
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
              FROM Call_Line__c
              GROUP BY Agent__c, Call_Status_Config__c];
        else 
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
              FROM Call_Line__c
                //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type_Config__c =: filterdata.Case_Type__c and Call_List__r.Generated_Date__c >=: filterdata.List_Date__c and (Call_Date__c <=: filterdata.Expired_Date__c OR Call_Date__c = NULL)
                WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type_Config__c =: filterdata.Case_Type__c and Call_List__r.Generated_Date__c >=: filterdata.List_Date__c and (Collection_Call_Date_F__c <=: filterdata.Expired_Date__c OR Collection_Call_Date_F__c = NULL)
              GROUP BY Agent__c, Call_Status_Config__c];
        for (AggregateResult ar : groupedResults)  {
            AgentName = username.get(string.valueof(ar.get('Agent__c')));
            CallStatus = string.valueof(ar.get('Call_Status_Config__c'));
            Amountcase = double.valueof(ar.get('expr0'));
            countcase = integer.valueof(ar.get('expr1'));
            
            System.debug('Agent__c : ' + ar.get('Agent__c'));
            System.debug('Agent Name : ' +AgentName);

            System.debug('Call_Status_Config__c : ' + CallStatus);
            System.debug('Sum APE Convery' + Amountcase);
            System.debug('Count : ' + countcase);
            
            if (tempagent != AgentName) {
                // ByCase ==============================
                if (totalCount == 0) CountConserved = 0;
                else CountConserved = CountApproved * 100 / totalCount;
                
                system.debug('totalCount : '+totalCount);
                system.debug('CountApproved : '+CountApproved);
                system.debug('CountConserved : '+CountConserved);

                RowCaseAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row.
                if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
                if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
                if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
                if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
                if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
                if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
                if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
                if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
                if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalCount += totalCount;
                TotalcountContacted += countContacted;
                TotalcountApproved += countApproved;
                TotalcountNotApproved += countNotApproved;
                TotalcountUnContacted += countUnContacted;
                TotalcountNotYetCall += countNotYetCall;
                TotalcountConserved += countConserved;
                TotalcountPaybySystem += countPaybySystem;
                TotalcountOther += countOther;

                totalCount = 0;
                CountContacted = 0;
                CountApproved = 0;
                CountNotApproved = 0;
                CountUnContacted = 0;
                CountNotYetCall = 0;
                CountConserved = 0;
                CountPaybySystem = 0;
                CountOther = 0;
                
                // ByAmount ==============================
                if (totalAmount == 0) AmountConserved = 0;
                else AmountConserved = AmountApproved * 100 / totalAmount;
                AmountConserved = AmountConserved.round();
                
                if (AmountContacted == 0) AmountAgreeToPayContacted = 0;
                else AmountAgreeToPayContacted = AmountApproved * 100 / AmountContacted;
                AmountAgreeToPayContacted = AmountAgreeToPayContacted.round();
                
                AmountTargetPTD = totalAmount * 66/100 ;
                AmountKekuranganConserved = AmountTargetPTD - AmountApproved;
                
                // ambil dari User Detail
                if (userSisaWaktu.get(tempagent) != NULL)
                    SisaWaktuFollowUp = integer.valueof(userSisaWaktu.get(tempagent));

                if (SisaWaktuFollowUp <= 0) AmountKekuranganConservedPerHari = AmountKekuranganConserved;
                else AmountKekuranganConservedPerHari = AmountKekuranganConserved / SisaWaktuFollowUp;
                
                // add to map, untuk di pakai daily.
                TargetConserved.put(tempagent, AmountKekuranganConservedPerHari);

                system.debug('2. totalAmount : '+totalAmount);
                system.debug('2. AmountApproved : '+AmountApproved);
                system.debug('2. AmountConserved : '+AmountConserved);

                RowAmountAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row. // Terbilang.AmountText(math.round(CPFieldList[i-1].Sales_Price__c))
                if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
                if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
                if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
                if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
                if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
                if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';

                if (tempagent != '') if (AmountConserved < 65) RowAmountConserved += '<td bgcolor="#FF0000">'+AmountConserved+' %</td>';
                                        else RowAmountConserved += '<td bgcolor="#008000">'+AmountConserved+' %</td>';
                //if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
                if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
                if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';

                if (tempagent != '') RowAmountAgreeToPayContacted += '<td>'+AmountAgreeToPayContacted+' %</td>';
                if (tempagent != '') RowAmountTargetPTD += '<td>'+Terbilang.AmountText(AmountTargetPTD)+'</td>';
                if (tempagent != '') RowAmountKekuranganConserved += '<td>'+Terbilang.AmountText(AmountKekuranganConserved)+'</td>';
                if (tempagent != '') RowAmountKekuranganConservedPerHari += '<td>'+Terbilang.AmountText(AmountKekuranganConservedPerHari)+'</td>';
                if (tempagent != '') RowSisaWaktuFollowUp += '<td>'+SisaWaktuFollowUp+'</td>';
                //if (tempagent != '') RowSisaWaktuFollowUp += '<td>'+userSisaWaktu.get(AgentName)+'</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalAmount += totalAmount;
                TotalAmountContacted += AmountContacted;
                TotalAmountApproved += AmountApproved;
                TotalAmountNotApproved += AmountNotApproved;
                TotalAmountUnContacted += AmountUnContacted;
                TotalAmountNotYetCall += AmountNotYetCall;
                TotalAmountConserved += AmountConserved;
                TotalAmountPaybySystem += AmountPaybySystem;
                TotalAmountOther += AmountOther;

                TotalAmountAgreeToPayContacted += AmountAgreeToPayContacted;
                TotalAmountTargetPTD += AmountTargetPTD;
                TotalAmountKekuranganConserved += AmountKekuranganConserved;
                TotalAmountKekuranganConservedPerHari += AmountKekuranganConservedPerHari;
    
                totalAmount = 0;
                AmountContacted = 0;
                AmountApproved = 0;
                AmountNotApproved = 0;
                AmountUnContacted = 0;
                AmountNotYetCall = 0;
                AmountConserved = 0;
                AmountPaybySystem = 0;
                AmountOther = 0;

                tempagent = AgentName;
            }

            // by Count ============================
            totalCount += countcase;
            if (CallStatus == 'Approved' || CallStatus == 'Not Approved') CountContacted += countcase;
            
            if (CallStatus == 'Approved') CountApproved += countcase;
            else if (CallStatus == 'Not Approved') CountNotApproved += countcase;
            else if (CallStatus == 'Uncontacted') CountUnContacted += countcase;
            else if (CallStatus == 'Sudah Pay By System') CountPaybySystem += countcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') CountNotYetCall += countcase;
            else CountOther += countcase;
            
            // by Amount  ============================
            totalAmount += Amountcase;
            if (CallStatus == 'Approved' || CallStatus == 'Not Approved') AmountContacted += Amountcase;
            
            if (CallStatus == 'Approved') AmountApproved += Amountcase;
            else if (CallStatus == 'Not Approved') AmountNotApproved += Amountcase;
            else if (CallStatus == 'Uncontacted') AmountUnContacted += Amountcase;
            else if (CallStatus == 'Sudah Pay By System') AmountPaybySystem += Amountcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') AmountNotYetCall += Amountcase;
            else AmountOther += Amountcase;
            
        } // end loop
        
        // By Count ============================
        // Grand Total, setelah selesai loop
        if (totalCount == 0) CountConserved = 0;
        else CountConserved = CountApproved * 100 / totalCount;

        GrandtotalCount += totalCount;
        TotalcountContacted += countContacted;
        TotalcountApproved += countApproved;
        TotalcountNotApproved += countNotApproved;
        TotalcountUnContacted += countUnContacted;
        TotalcountNotYetCall += countNotYetCall;
        
        TotalcountPaybySystem += countPaybySystem;
        TotalcountOther += countOther;

        if (GrandtotalCount == 0) TotalcountConserved = 0;
        else TotalcountConserved = TotalCountApproved * 100 / GrandtotalCount;

        if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
        if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';
        
        // grand total
        if (tempagent != '') RowCaseAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+TotalCountOther+'</td>';

        ByDateCase = header;
        ByDateCase += '<table>';
        ByDateCase += '<tr><th width="200">Row Labels</th>'+RowCaseAgent+'</tr>';
        ByDateCase += '<tr><td>Total Data Daily</td>'+RowCaseTotal+'</tr>';
        ByDateCase += '<tr><td>* Contacted</td>'+RowCaseContacted+'</tr>';
        ByDateCase += '<tr><td>** Approved</td>'+RowCaseApproved+'</tr>';
        ByDateCase += '<tr><td>** Not Approved</td>'+RowCaseNotApproved+'</tr>';
        ByDateCase += '<tr><td>* Uncontacted</td>'+RowCaseUnContacted+'</tr>';
        ByDateCase += '<tr><td>* Sudah Pay by System</td>'+RowCasePaybySystem+'</tr>';
        ByDateCase += '<tr><td>* Other</td>'+RowCaseOther+'</tr>';
        ByDateCase += '<tr><td>* Not Yet Call</td>'+RowCaseNotYetCall+'</tr>';
        ByDateCase += '<tr><td>% Agree to Pay</th>'+RowCaseConserved+'</tr>';
        ByDateCase += '</table>';
        ByDateCase += footer;

        // By Amount ============================
        // Grand Total, setelah selesai loop
        if (totalAmount == 0) AmountConserved = 0;
        else AmountConserved = AmountApproved * 100 / totalAmount;        
        AmountConserved = AmountConserved.round();

        if (AmountContacted == 0) AmountAgreeToPayContacted = 0;
        else AmountAgreeToPayContacted = AmountApproved * 100 / AmountContacted;
        AmountAgreeToPayContacted = AmountAgreeToPayContacted.round();
        
        AmountTargetPTD = totalAmount* 66/100;
        AmountKekuranganConserved = AmountTargetPTD - AmountApproved;

        // ambil dari userdetail        
        if (userSisaWaktu.get(tempagent) != NULL)
            SisaWaktuFollowUp = integer.valueof(userSisaWaktu.get(tempagent));

        if (SisaWaktuFollowUp <= 0) AmountKekuranganConservedPerHari = AmountKekuranganConserved;
        else AmountKekuranganConservedPerHari = AmountKekuranganConserved / SisaWaktuFollowUp;

        // add to map, untuk di pakai daily.
        TargetConserved.put(tempagent, AmountKekuranganConservedPerHari);
        
        GrandtotalAmount += totalAmount;
        TotalAmountContacted += AmountContacted;
        TotalAmountApproved += AmountApproved;
        TotalAmountNotApproved += AmountNotApproved;
        TotalAmountUnContacted += AmountUnContacted;
        TotalAmountNotYetCall += AmountNotYetCall;
        
        TotalAmountPaybySystem += AmountPaybySystem;
        TotalAmountOther += AmountOther;

        if (GrandtotalAmount == 0) TotalAmountConserved = 0;
        else TotalAmountConserved = TotalAmountApproved * 100 / GrandtotalAmount;        
        TotalAmountConserved = TotalAmountConserved.round();

        if (TotalAmountContacted == 0) TotalAmountAgreeToPayContacted = 0;
        else TotalAmountAgreeToPayContacted = TotalAmountApproved * 100 / TotalAmountContacted;
        TotalAmountAgreeToPayContacted = TotalAmountAgreeToPayContacted.round();
        
        TotalAmountTargetPTD += AmountTargetPTD;
        TotalAmountKekuranganConserved += AmountKekuranganConserved;
        TotalAmountKekuranganConservedPerHari += AmountKekuranganConservedPerHari;

        TargetConserved.put('Total', AmountKekuranganConservedPerHari);
        
        if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';

        if (tempagent != '') if (AmountConserved < 65) RowAmountConserved += '<td bgcolor="#FF0000">'+AmountConserved+' %</td>';
                                else RowAmountConserved += '<td bgcolor="#008000">'+AmountConserved+' %</td>';

        //if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
        
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';

        if (tempagent != '') RowAmountAgreeToPayContacted += '<td>'+AmountAgreeToPayContacted+' %</td>';
        if (tempagent != '') RowAmountTargetPTD += '<td>'+Terbilang.AmountText(AmountTargetPTD)+'</td>';
        if (tempagent != '') RowAmountKekuranganConserved += '<td>'+Terbilang.AmountText(AmountKekuranganConserved)+'</td>';
        if (tempagent != '') RowAmountKekuranganConservedPerHari += '<td>'+Terbilang.AmountText(AmountKekuranganConservedPerHari)+'</td>';

        if (tempagent != '') RowSisaWaktuFollowUp += '<td>'+SisaWaktuFollowUp+'</td>';
        
        // grand total
        if (tempagent != '') RowAmountAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(TotalAmountNotYetCall)+'</td>';
            // green or red
        if (tempagent != '') if (TotalAmountConserved < 65) RowAmountConserved += '<td bgcolor="#FF0000">'+TotalAmountConserved+' %</td>';
                                else RowAmountConserved += '<td bgcolor="#008000">'+TotalAmountConserved+' %</td>';
        
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(TotalAmountOther)+'</td>';

        if (tempagent != '') RowAmountAgreeToPayContacted += '<td>'+TotalAmountAgreeToPayContacted+' %</td>';
        if (tempagent != '') RowAmountTargetPTD += '<td>'+Terbilang.AmountText(TotalAmountTargetPTD)+'</td>';
        if (tempagent != '') RowAmountKekuranganConserved += '<td>'+Terbilang.AmountText(TotalAmountKekuranganConserved)+'</td>';
        if (tempagent != '') RowAmountKekuranganConservedPerHari += '<td>'+Terbilang.AmountText(TotalAmountKekuranganConservedPerHari)+'</td>';
        if (tempagent != '') RowSisaWaktuFollowUp += '<td>'+SisaWaktuFollowUp+'</td>';

        ByDateAmount = header;
        ByDateAmount += '<table>';
        ByDateAmount += '<tr><th width="200">Row Labels</th>'+RowAmountAgent+'</tr>';
        ByDateAmount += '<tr><td>Total Data Daily</td>'+RowAmountTotal+'</tr>';
        ByDateAmount += '<tr><td>* Contacted</td>'+RowAmountContacted+'</tr>';
        ByDateAmount += '<tr><td>** Agree to Pay</td>'+RowAmountApproved+'</tr>';
        ByDateAmount += '<tr><td>** Not Approved</td>'+RowAmountNotApproved+'</tr>';
        ByDateAmount += '<tr><td>* Uncontacted</td>'+RowAmountUnContacted+'</tr>';
        ByDateAmount += '<tr><td>* Sudah Pay by System</td>'+RowAmountPaybySystem+'</tr>';
        ByDateAmount += '<tr><td>* Other</td>'+RowAmountOther+'</tr>';
        ByDateAmount += '<tr><td>* Not Yet Call</td>'+RowAmountNotYetCall+'</tr>';
        ByDateAmount += '<tr><td>% Agree to Pay vs Contacted</th>'+RowAmountAgreeToPayContacted+'</tr>';
        ByDateAmount += '<tr><td>% Agree to Pay</th>'+RowAmountConserved+'</tr>';
        ByDateAmount += '<tr><td>Target PTD Des/user</th>'+RowAmountTargetPTD+'</tr>';
        ByDateAmount += '<tr><td>Kekurangan Conserved cycle 2</th>'+RowAmountKekuranganConserved+'</tr>';
        ByDateAmount += '<tr><td>Kekurangan Conserved perhari</th>'+RowAmountKekuranganConservedPerHari+'</tr>';
        ByDateAmount += '<tr><td>Sisa waktu Follow up</th>'+RowSisaWaktuFollowUp+'</tr>';
        ByDateAmount += '</table>';
        ByDateAmount += footer;

    }

    public void getdataLapse_RW(){        
        // query data by Case
        map<string, string> username = new map<string, string>();
        for (User us2 : [SELECT id, Name FROM User]) {
            username.put(us2.id, us2.Name);
        }
        map<string, string> userlevel = new map<string, string>();
        for (User_Detail__c ud : [SELECT id, Name, User__c, Level__c FROM User_Detail__c WHERE Level__c != NULL]) {
            userlevel.put(ud.User__c, ud.Level__c);
        }
        
        String RowCaseAgent = '';
        String RowCaseTotal = '';
        String RowCaseContacted = '';
        String RowCaseApproved = ''; // Considering
        String RowCaseNotApproved = ''; // Agree to Cancel
        String RowCaseUnContacted = '';
        String RowCaseNotYetCall = '';
        String RowCaseConserved = '';
        String RowCasePaybySystem = '';
        String RowCaseOther = '';
        String RowCaseAgreeCancel = '';
    
        String RowAmountAgent = '';
        String RowAmountTotal = '';
        String RowAmountContacted = '';
        String RowAmountApproved = ''; // Considering
        String RowAmountNotApproved = ''; // Agree to Cancel
        String RowAmountUnContacted = '';
        String RowAmountNotYetCall = '';
        String RowAmountConserved = '';
        String RowAmountPaybySystem = '';
        String RowAmountOther = '';
        String RowAmountAgreeCancel = '';

        String AgentName = '';
        String AgentLevel = '';
        String CallStatus = '';

        Double Amountcase = 0;
        Double TotalAmount = 0;
        Double AmountContacted = 0;
        Double AmountApproved = 0;
        Double AmountNotApproved = 0;
        Double AmountUnContacted = 0;
        Double AmountNotYetCall = 0;
        Double AmountConserved = 0;
        Double AmountPaybySystem = 0;
        Double AmountOther = 0;
        Double AmountAgreeCancel = 0;

        integer countcase = 0; 
        integer totalCount = 0;
        integer countContacted = 0;
        integer countApproved = 0;
        integer countNotApproved = 0;
        integer countUnContacted = 0;
        integer countNotYetCall = 0;
        integer countConserved = 0;
        integer countPaybySystem = 0;
        integer countOther = 0;
        integer countAgreeCancel = 0;

        // Grand Total
        Double GrandTotalAmount = 0;
        Double TotalAmountContacted = 0;
        Double TotalAmountApproved = 0;
        Double TotalAmountNotApproved = 0;
        Double TotalAmountUnContacted = 0;
        Double TotalAmountNotYetCall = 0;
        Double TotalAmountConserved = 0;
        Double TotalAmountPaybySystem = 0;
        Double TotalAmountOther = 0;
        Double TotalAmountAgreeCancel = 0;

        integer GrandtotalCount = 0;
        integer TotalcountContacted = 0;
        integer TotalcountApproved = 0;
        integer TotalcountNotApproved = 0;
        integer TotalcountUnContacted = 0;
        integer TotalcountNotYetCall = 0;
        integer TotalcountConserved = 0;
        integer TotalcountPaybySystem = 0;
        integer TotalcountOther = 0;
        integer TotalcountAgreeCancel = 0;

        // Level 1
        Double Lvl1_GrandTotalAmount = 0;
        Double Lvl1_TotalAmountContacted = 0;
        Double Lvl1_TotalAmountApproved = 0;
        Double Lvl1_TotalAmountNotApproved = 0;
        Double Lvl1_TotalAmountUnContacted = 0;
        Double Lvl1_TotalAmountNotYetCall = 0;
        Double Lvl1_TotalAmountConserved = 0;
        Double Lvl1_TotalAmountPaybySystem = 0;
        Double Lvl1_TotalAmountOther = 0;
        Double Lvl1_TotalAmountAgreeCancel = 0;

        integer Lvl1_GrandtotalCount = 0;
        integer Lvl1_TotalcountContacted = 0;
        integer Lvl1_TotalcountApproved = 0;
        integer Lvl1_TotalcountNotApproved = 0;
        integer Lvl1_TotalcountUnContacted = 0;
        integer Lvl1_TotalcountNotYetCall = 0;
        integer Lvl1_TotalcountConserved = 0;
        integer Lvl1_TotalcountPaybySystem = 0;
        integer Lvl1_TotalcountOther = 0;
        integer Lvl1_TotalcountAgreeCancel = 0;

        // Level 2
        Double Lvl2_GrandTotalAmount = 0;
        Double Lvl2_TotalAmountContacted = 0;
        Double Lvl2_TotalAmountApproved = 0;
        Double Lvl2_TotalAmountNotApproved = 0;
        Double Lvl2_TotalAmountUnContacted = 0;
        Double Lvl2_TotalAmountNotYetCall = 0;
        Double Lvl2_TotalAmountConserved = 0;
        Double Lvl2_TotalAmountPaybySystem = 0;
        Double Lvl2_TotalAmountOther = 0;
        Double Lvl2_TotalAmountAgreeCancel = 0;

        integer Lvl2_GrandtotalCount = 0;
        integer Lvl2_TotalcountContacted = 0;
        integer Lvl2_TotalcountApproved = 0;
        integer Lvl2_TotalcountNotApproved = 0;
        integer Lvl2_TotalcountUnContacted = 0;
        integer Lvl2_TotalcountNotYetCall = 0;
        integer Lvl2_TotalcountConserved = 0;
        integer Lvl2_TotalcountPaybySystem = 0;
        integer Lvl2_TotalcountOther = 0;
        integer Lvl2_TotalcountAgreeCancel = 0;

        // Level 0
        Double Lvl0_GrandTotalAmount = 0;
        Double Lvl0_TotalAmountContacted = 0;
        Double Lvl0_TotalAmountApproved = 0;
        Double Lvl0_TotalAmountNotApproved = 0;
        Double Lvl0_TotalAmountUnContacted = 0;
        Double Lvl0_TotalAmountNotYetCall = 0;
        Double Lvl0_TotalAmountConserved = 0;
        Double Lvl0_TotalAmountPaybySystem = 0;
        Double Lvl0_TotalAmountOther = 0;
        Double Lvl0_TotalAmountAgreeCancel = 0;

        integer Lvl0_GrandtotalCount = 0;
        integer Lvl0_TotalcountContacted = 0;
        integer Lvl0_TotalcountApproved = 0;
        integer Lvl0_TotalcountNotApproved = 0;
        integer Lvl0_TotalcountUnContacted = 0;
        integer Lvl0_TotalcountNotYetCall = 0;
        integer Lvl0_TotalcountConserved = 0;
        integer Lvl0_TotalcountPaybySystem = 0;
        integer Lvl0_TotalcountOther = 0;
        integer Lvl0_TotalcountAgreeCancel = 0;

        string tempagent = '';

        AggregateResult[] groupedResults;
        if(Test.isRunningTest()) {
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                  GROUP BY Agent__c, Call_Status_Config__c];            
        }
        else {
            if (filterdata.Case_Type__c == 'Redemption & Withdrawal') 
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and (Case_Type__c = 'Withdrawal' OR Case_Type__c = 'Redemption Konven') and ((Call_Status_Config__c = NULL) OR (Call_Status_Config__c != NULL AND Call_Date__c =: filterdata.Expired_Date__c))
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and (Case_Type__c = 'Withdrawal' OR Case_Type__c = 'Redemption Konven') and ((Call_Status_Config__c = NULL) OR (Call_Status_Config__c != NULL AND Collection_Call_Date_F__c =: filterdata.Expired_Date__c))
                    WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and (Case_Type__c = 'Withdrawal' OR Case_Type__c = 'Redemption Konven') and (Call_Status_Config__c != NULL AND Collection_Call_Date_F__c =: filterdata.Expired_Date__c)
                  GROUP BY Agent__c, Call_Status_Config__c];
            else 
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type__c =: filterdata.Case_Type__c and ((Call_Status_Config__c = NULL) OR (Call_Status_Config__c != NULL AND Call_Date__c =: filterdata.Expired_Date__c))
                    WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type__c =: filterdata.Case_Type__c and ((Call_Status_Config__c = NULL) OR (Call_Status_Config__c != NULL AND Collection_Call_Date_F__c =: filterdata.Expired_Date__c))
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type__c =: filterdata.Case_Type__c and (Call_Status_Config__c != NULL AND Collection_Call_Date_F__c =: filterdata.Expired_Date__c)
                  GROUP BY Agent__c, Call_Status_Config__c];
        }

        for (AggregateResult ar : groupedResults)  {
            AgentName = username.get(string.valueof(ar.get('Agent__c')));
            if (userlevel.get(string.valueof(ar.get('Agent__c'))) == NULL) AgentLevel = '0';
            else AgentLevel = userlevel.get(string.valueof(ar.get('Agent__c')));

            CallStatus = string.valueof(ar.get('Call_Status_Config__c'));
            Amountcase = double.valueof(ar.get('expr0'));
            countcase = integer.valueof(ar.get('expr1'));
                
            System.debug('Agent__c : ' + ar.get('Agent__c'));
            System.debug('Agent Name : ' +AgentName);

            System.debug('Call_Status_Config__c : ' + CallStatus);
            System.debug('Sum APE Convery' + Amountcase);
            System.debug('Count : ' + countcase);
            
            if (tempagent != AgentName) {
                // ByCase ==============================
                if (totalCount == 0) CountConserved = 0;
                else CountConserved = CountContacted * 100 / totalCount;

                if (CountContacted == 0) CountAgreeCancel = 0;
                else CountAgreeCancel = CountApproved * 100 / CountContacted;

                system.debug('totalCount : '+totalCount);
                system.debug('CountApproved : '+CountApproved);
                system.debug('CountConserved : '+CountConserved);

                RowCaseAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row.
                if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
                if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
                if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
                if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
                if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
                if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
                if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
                if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
                if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';
                if (tempagent != '') RowCaseAgreeCancel += '<td>'+CountAgreeCancel+' %</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalCount += totalCount;
                TotalcountContacted += countContacted;
                TotalcountApproved += countApproved;
                TotalcountNotApproved += countNotApproved;
                TotalcountUnContacted += countUnContacted;
                TotalcountNotYetCall += countNotYetCall;
                TotalcountConserved += countConserved;
                TotalcountPaybySystem += countPaybySystem;
                TotalcountOther += countOther;

                // Level 1 ?
                if (agentlevel == '1') {
                    lvl1_GrandtotalCount += totalCount;
                    lvl1_TotalcountContacted += countContacted;
                    lvl1_TotalcountApproved += countApproved;
                    lvl1_TotalcountNotApproved += countNotApproved;
                    lvl1_TotalcountUnContacted += countUnContacted;
                    lvl1_TotalcountNotYetCall += countNotYetCall;
                    lvl1_TotalcountConserved += countConserved;
                    lvl1_TotalcountPaybySystem += countPaybySystem;
                    lvl1_TotalcountOther += countOther;
                }

                // Level 2
                if (agentlevel == '2') {
                    lvl2_GrandtotalCount += totalCount;
                    lvl2_TotalcountContacted += countContacted;
                    lvl2_TotalcountApproved += countApproved;
                    lvl2_TotalcountNotApproved += countNotApproved;
                    lvl2_TotalcountUnContacted += countUnContacted;
                    lvl2_TotalcountNotYetCall += countNotYetCall;
                    lvl2_TotalcountConserved += countConserved;
                    lvl2_TotalcountPaybySystem += countPaybySystem;
                    lvl2_TotalcountOther += countOther;
                }

                // Level 0
                if (agentlevel == '0') {
                    lvl0_GrandtotalCount += totalCount;
                    lvl0_TotalcountContacted += countContacted;
                    lvl0_TotalcountApproved += countApproved;
                    lvl0_TotalcountNotApproved += countNotApproved;
                    lvl0_TotalcountUnContacted += countUnContacted;
                    lvl0_TotalcountNotYetCall += countNotYetCall;
                    lvl0_TotalcountConserved += countConserved;
                    lvl0_TotalcountPaybySystem += countPaybySystem;
                    lvl0_TotalcountOther += countOther;
                }

                totalCount = 0;
                CountContacted = 0;
                CountApproved = 0;
                CountNotApproved = 0;
                CountUnContacted = 0;
                CountNotYetCall = 0;
                CountConserved = 0;
                CountPaybySystem = 0;
                CountOther = 0;
                
                // ByAmount ==============================
                if (totalAmount == 0) AmountConserved = 0;
                else AmountConserved = AmountContacted * 100 / totalAmount;                
                AmountConserved = AmountConserved.round();
                
                if (AmountContacted == 0) AmountAgreeCancel = 0;
                else AmountAgreeCancel = AmountApproved * 100 / AmountContacted;                
                AmountAgreeCancel = AmountAgreeCancel.round();

                system.debug('2. totalAmount : '+totalAmount);
                system.debug('2. AmountApproved : '+AmountApproved);
                system.debug('2. AmountConserved : '+AmountConserved);

                RowAmountAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row. // Terbilang.AmountText(math.round(CPFieldList[i-1].Sales_Price__c))
                if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
                if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
                if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
                if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
                if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
                if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';
                if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
                if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
                if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';
                if (tempagent != '') RowAmountAgreeCancel += '<td>'+AmountAgreeCancel+' %</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalAmount += totalAmount;
                TotalAmountContacted += AmountContacted;
                TotalAmountApproved += AmountApproved;
                TotalAmountNotApproved += AmountNotApproved;
                TotalAmountUnContacted += AmountUnContacted;
                TotalAmountNotYetCall += AmountNotYetCall;
                TotalAmountConserved += AmountConserved;
                TotalAmountPaybySystem += AmountPaybySystem;
                TotalAmountOther += AmountOther;

                // Level 1
                if (AgentLevel == '1') {
                    lvl1_GrandtotalAmount += totalAmount;
                    lvl1_TotalAmountContacted += AmountContacted;
                    lvl1_TotalAmountApproved += AmountApproved;
                    lvl1_TotalAmountNotApproved += AmountNotApproved;
                    lvl1_TotalAmountUnContacted += AmountUnContacted;
                    lvl1_TotalAmountNotYetCall += AmountNotYetCall;
                    lvl1_TotalAmountConserved += AmountConserved;
                    lvl1_TotalAmountPaybySystem += AmountPaybySystem;
                    lvl1_TotalAmountOther += AmountOther;
                }

                // Level 2
                if (AgentLevel == '2') {
                    lvl2_GrandtotalAmount += totalAmount;
                    lvl2_TotalAmountContacted += AmountContacted;
                    lvl2_TotalAmountApproved += AmountApproved;
                    lvl2_TotalAmountNotApproved += AmountNotApproved;
                    lvl2_TotalAmountUnContacted += AmountUnContacted;
                    lvl2_TotalAmountNotYetCall += AmountNotYetCall;
                    lvl2_TotalAmountConserved += AmountConserved;
                    lvl2_TotalAmountPaybySystem += AmountPaybySystem;
                    lvl2_TotalAmountOther += AmountOther;
                }

                // Level 0
                if (AgentLevel == '0') {
                    lvl0_GrandtotalAmount += totalAmount;
                    lvl0_TotalAmountContacted += AmountContacted;
                    lvl0_TotalAmountApproved += AmountApproved;
                    lvl0_TotalAmountNotApproved += AmountNotApproved;
                    lvl0_TotalAmountUnContacted += AmountUnContacted;
                    lvl0_TotalAmountNotYetCall += AmountNotYetCall;
                    lvl0_TotalAmountConserved += AmountConserved;
                    lvl0_TotalAmountPaybySystem += AmountPaybySystem;
                    lvl0_TotalAmountOther += AmountOther;
                }

                totalAmount = 0;
                AmountContacted = 0;
                AmountApproved = 0;
                AmountNotApproved = 0;
                AmountUnContacted = 0;
                AmountNotYetCall = 0;
                AmountConserved = 0;
                AmountPaybySystem = 0;
                AmountOther = 0;

                tempagent = AgentName;
            }

            // by Count ============================
            // Taufik, 19 mar20, if countnotyetcall not count
            if (CallStatus != '' && CallStatus != NULL && CallStatus != 'NULL') totalCount += countcase;
            if (CallStatus == 'P' || CallStatus == 'Y' || CallStatus == 'N') CountContacted += countcase;
            
            if (CallStatus == 'P') CountApproved += countcase;
            else if (CallStatus == 'Y') CountNotApproved += countcase;
            else if (CallStatus == 'F') CountUnContacted += countcase;
            else if (CallStatus == 'Sudah Pay By System') CountPaybySystem += countcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') CountNotYetCall += countcase;
            else if (CallStatus != 'N') CountOther += countcase;
            
            // by Amount  ============================
            // Taufik, 19 mar20, if countnotyetcall not count
            if (CallStatus != '' && CallStatus != NULL && CallStatus != 'NULL') totalAmount += Amountcase;
            if (CallStatus == 'P' || CallStatus == 'Y' || CallStatus == 'N') AmountContacted += Amountcase;
            
            if (CallStatus == 'P') AmountApproved += Amountcase;
            else if (CallStatus == 'Y') AmountNotApproved += Amountcase;
            else if (CallStatus == 'F') AmountUnContacted += Amountcase;
            else if (CallStatus == 'Sudah Pay By System') AmountPaybySystem += Amountcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') AmountNotYetCall += Amountcase;
            else if (CallStatus != 'N') AmountOther += Amountcase;
            
        } // end loop
        
        // By Count ============================
        // Grand Total, setelah selesai loop
        if (totalCount == 0) CountConserved = 0;
        else CountConserved = CountContacted * 100 / totalCount;
        
        if (CountContacted == 0) CountAgreeCancel = 0;
        else CountAgreeCancel = CountApproved * 100 / CountContacted;

        GrandtotalCount += totalCount;
        TotalcountContacted += countContacted;
        TotalcountApproved += countApproved;
        TotalcountNotApproved += countNotApproved;
        TotalcountUnContacted += countUnContacted;
        TotalcountNotYetCall += countNotYetCall;
        
        TotalcountPaybySystem += countPaybySystem;
        TotalcountOther += countOther;

        if (GrandtotalCount == 0) TotalcountConserved = 0;
        else TotalcountConserved = TotalCountContacted * 100 / GrandtotalCount;

        if (TotalCountContacted == 0) TotalcountAgreeCancel = 0;
        else TotalcountAgreeCancel = TotalCountApproved * 100 / TotalCountContacted;

        // level 1
        if (AgentLevel == '1') {
            lvl1_GrandtotalCount += totalCount;
            lvl1_TotalcountContacted += countContacted;
            lvl1_TotalcountApproved += countApproved;
            lvl1_TotalcountNotApproved += countNotApproved;
            lvl1_TotalcountUnContacted += countUnContacted;
            lvl1_TotalcountNotYetCall += countNotYetCall;
            
            lvl1_TotalcountPaybySystem += countPaybySystem;
            lvl1_TotalcountOther += countOther;
    
            if (lvl1_GrandtotalCount == 0) lvl1_TotalcountConserved = 0;
            else lvl1_TotalcountConserved = lvl1_TotalCountContacted * 100 / lvl1_GrandtotalCount;
    
            if (lvl1_TotalCountContacted == 0) lvl1_TotalcountAgreeCancel = 0;
            else lvl1_TotalcountAgreeCancel = lvl1_TotalCountApproved * 100 / lvl1_TotalCountContacted;
            
        }

        // level 2
        if (AgentLevel == '2') {
            lvl2_GrandtotalCount += totalCount;
            lvl2_TotalcountContacted += countContacted;
            lvl2_TotalcountApproved += countApproved;
            lvl2_TotalcountNotApproved += countNotApproved;
            lvl2_TotalcountUnContacted += countUnContacted;
            lvl2_TotalcountNotYetCall += countNotYetCall;
            
            lvl2_TotalcountPaybySystem += countPaybySystem;
            lvl2_TotalcountOther += countOther;
    
            if (lvl2_GrandtotalCount == 0) lvl2_TotalcountConserved = 0;
            else lvl2_TotalcountConserved = lvl2_TotalCountContacted * 100 / lvl2_GrandtotalCount;
    
            if (lvl2_TotalCountContacted == 0) lvl2_TotalcountAgreeCancel = 0;
            else lvl2_TotalcountAgreeCancel = lvl2_TotalCountApproved * 100 / lvl2_TotalCountContacted;
        }

        // level 0
        if (AgentLevel == '0') {
            lvl0_GrandtotalCount += totalCount;
            lvl0_TotalcountContacted += countContacted;
            lvl0_TotalcountApproved += countApproved;
            lvl0_TotalcountNotApproved += countNotApproved;
            lvl0_TotalcountUnContacted += countUnContacted;
            lvl0_TotalcountNotYetCall += countNotYetCall;
            
            lvl0_TotalcountPaybySystem += countPaybySystem;
            lvl0_TotalcountOther += countOther;
    
            if (lvl0_GrandtotalCount == 0) lvl0_TotalcountConserved = 0;
            else lvl0_TotalcountConserved = lvl0_TotalCountContacted * 100 / lvl0_GrandtotalCount;
    
            if (lvl0_TotalCountContacted == 0) lvl0_TotalcountAgreeCancel = 0;
            else lvl0_TotalcountAgreeCancel = lvl0_TotalCountApproved * 100 / lvl0_TotalCountContacted;
        }

        // add to Table
        if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
        if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+CountAgreeCancel+' %</td>';
        
        // grand total
        if (tempagent != '') RowCaseAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+TotalCountAgreeCancel+' %</td>';

        // level 1
        if (tempagent != '') RowCaseAgent += '<th> Level 1 </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+lvl1_GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+lvl1_TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+lvl1_TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+lvl1_TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+lvl1_TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+lvl1_TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+lvl1_TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+lvl1_TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+lvl1_TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+lvl1_TotalCountAgreeCancel+' %</td>';

        // level 2
        if (tempagent != '') RowCaseAgent += '<th> Level 2 </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+lvl2_GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+lvl2_TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+lvl2_TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+lvl2_TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+lvl2_TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+lvl2_TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+lvl2_TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+lvl2_TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+lvl2_TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+lvl2_TotalCountAgreeCancel+' %</td>';

        // level 0
        if (tempagent != '') RowCaseAgent += '<th> No Have Level  </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+lvl0_GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+lvl0_TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+lvl0_TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+lvl0_TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+lvl0_TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+lvl0_TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+lvl0_TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+lvl0_TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+lvl0_TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+lvl0_TotalCountAgreeCancel+' %</td>';

        ByCase = header;
        ByCase += '<table>';
        ByCase += '<tr><th width="200">Row Labels</th>'+RowCaseAgent+'</tr>';
        ByCase += '<tr><td>Total Data </td>'+RowCaseTotal+'</tr>';
        ByCase += '<tr><td>* Contacted</td>'+RowCaseContacted+'</tr>';
        ByCase += '<tr><td>** Considering to Cancelled Redemption & Withdrawal</td>'+RowCaseApproved+'</tr>';
        ByCase += '<tr><td>** Agree to Cancelled Redemption & Withdrawal</td>'+RowCaseNotApproved+'</tr>';
        ByCase += '<tr><td>* Uncontacted</td>'+RowCaseUnContacted+'</tr>';
        ByCase += '<tr><td>* Sudah Pay by System</td>'+RowCasePaybySystem+'</tr>';
        ByCase += '<tr><td>* Other</td>'+RowCaseOther+'</tr>';
        //ByCase += '<tr><td>* Not Yet Call</td>'+RowCaseNotYetCall+'</tr>';
        ByCase += '<tr><td>% Contacted</th>'+RowCaseConserved+'</tr>';
        ByCase += '<tr><td>% Agree to Cancelled Redemption & Withdrawal</th>'+RowCaseAgreeCancel+'</tr>';
        ByCase += '</table>';
        ByCase += footer;

        // By Amount ============================
        // Grand Total, setelah selesai loop
        if (totalAmount == 0) AmountConserved = 0;
        else AmountConserved = AmountContacted * 100 / totalAmount;
        AmountConserved = AmountConserved.round();

        if (AmountContacted == 0) AmountAgreeCancel = 0;
        else AmountAgreeCancel = AmountApproved * 100 / AmountContacted;
        AmountAgreeCancel = AmountAgreeCancel.round();

        GrandtotalAmount += totalAmount;
        TotalAmountContacted += AmountContacted;
        TotalAmountApproved += AmountApproved;
        TotalAmountNotApproved += AmountNotApproved;
        TotalAmountUnContacted += AmountUnContacted;
        TotalAmountNotYetCall += AmountNotYetCall;
        
        TotalAmountPaybySystem += AmountPaybySystem;
        TotalAmountOther += AmountOther;

        if (GrandtotalAmount == 0) TotalAmountConserved = 0;
        else TotalAmountConserved = TotalAmountContacted * 100 / GrandtotalAmount;        
        TotalAmountConserved = TotalAmountConserved.round();

        if (TotalAmountContacted == 0) TotalAmountAgreeCancel = 0;
        else TotalAmountAgreeCancel = TotalAmountApproved * 100 / TotalAmountContacted;
        TotalAmountAgreeCancel = TotalAmountAgreeCancel.round();

        // level 1
        if (AgentLevel == '1') {
            lvl1_GrandtotalAmount += totalAmount;
            lvl1_TotalAmountContacted += AmountContacted;
            lvl1_TotalAmountApproved += AmountApproved;
            lvl1_TotalAmountNotApproved += AmountNotApproved;
            lvl1_TotalAmountUnContacted += AmountUnContacted;
            lvl1_TotalAmountNotYetCall += AmountNotYetCall;
            
            lvl1_TotalAmountPaybySystem += AmountPaybySystem;
            lvl1_TotalAmountOther += AmountOther;
    
            if (lvl1_GrandtotalAmount == 0) lvl1_TotalAmountConserved = 0;
            else lvl1_TotalAmountConserved = lvl1_TotalAmountContacted * 100 / lvl1_GrandtotalAmount;        
            lvl1_TotalAmountConserved = lvl1_TotalAmountConserved.round();
    
            if (lvl1_TotalAmountContacted == 0) lvl1_TotalAmountAgreeCancel = 0;
            else lvl1_TotalAmountAgreeCancel = lvl1_TotalAmountApproved * 100 / lvl1_TotalAmountContacted;
            lvl1_TotalAmountAgreeCancel = lvl1_TotalAmountAgreeCancel.round();
        }

        // level 2
        if (AgentLevel == '2') {
            lvl2_GrandtotalAmount += totalAmount;
            lvl2_TotalAmountContacted += AmountContacted;
            lvl2_TotalAmountApproved += AmountApproved;
            lvl2_TotalAmountNotApproved += AmountNotApproved;
            lvl2_TotalAmountUnContacted += AmountUnContacted;
            lvl2_TotalAmountNotYetCall += AmountNotYetCall;
            
            lvl2_TotalAmountPaybySystem += AmountPaybySystem;
            lvl2_TotalAmountOther += AmountOther;
    
            if (lvl2_GrandtotalAmount == 0) lvl2_TotalAmountConserved = 0;
            else lvl2_TotalAmountConserved = lvl2_TotalAmountContacted * 100 / lvl2_GrandtotalAmount;        
            lvl2_TotalAmountConserved = lvl2_TotalAmountConserved.round();
    
            if (lvl2_TotalAmountContacted == 0) lvl2_TotalAmountAgreeCancel = 0;
            else lvl2_TotalAmountAgreeCancel = lvl2_TotalAmountApproved * 100 / lvl2_TotalAmountContacted;
            lvl2_TotalAmountAgreeCancel = lvl2_TotalAmountAgreeCancel.round();
        }

        // level 0
        if (AgentLevel == '0') {
            lvl0_GrandtotalAmount += totalAmount;
            lvl0_TotalAmountContacted += AmountContacted;
            lvl0_TotalAmountApproved += AmountApproved;
            lvl0_TotalAmountNotApproved += AmountNotApproved;
            lvl0_TotalAmountUnContacted += AmountUnContacted;
            lvl0_TotalAmountNotYetCall += AmountNotYetCall;
            
            lvl0_TotalAmountPaybySystem += AmountPaybySystem;
            lvl0_TotalAmountOther += AmountOther;
    
            if (lvl0_GrandtotalAmount == 0) lvl0_TotalAmountConserved = 0;
            else lvl0_TotalAmountConserved = lvl0_TotalAmountContacted * 100 / lvl0_GrandtotalAmount;        
            lvl0_TotalAmountConserved = lvl0_TotalAmountConserved.round();
    
            if (lvl0_TotalAmountContacted == 0) lvl0_TotalAmountAgreeCancel = 0;
            else lvl0_TotalAmountAgreeCancel = lvl0_TotalAmountApproved * 100 / lvl0_TotalAmountContacted;
            lvl0_TotalAmountAgreeCancel = lvl0_TotalAmountAgreeCancel.round();
        }
        
        // add to table
        if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(AmountAgreeCancel)+' %</td>';
        
        // grand total
        if (tempagent != '') RowAmountAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(TotalAmountAgreeCancel)+' %</td>';

        // level 1
        if (tempagent != '') RowAmountAgent += '<th> Level 1 </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(lvl1_GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(lvl1_TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(lvl1_TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(lvl1_TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(lvl1_TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(lvl1_TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+lvl1_TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(lvl1_TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(lvl1_TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(lvl1_TotalAmountAgreeCancel)+' %</td>';

        // level 2
        if (tempagent != '') RowAmountAgent += '<th> Level 2 </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(lvl2_GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(lvl2_TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(lvl2_TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(lvl2_TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(lvl2_TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(lvl2_TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+lvl2_TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(lvl2_TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(lvl2_TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(lvl2_TotalAmountAgreeCancel)+' %</td>';

        // level 0
        if (tempagent != '') RowAmountAgent += '<th> No Have Level </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(lvl0_GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(lvl0_TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(lvl0_TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(lvl0_TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(lvl0_TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(lvl0_TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+lvl0_TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(lvl0_TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(lvl0_TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(lvl0_TotalAmountAgreeCancel)+' %</td>';

        ByAmount = header;
        ByAmount += '<table>';
        ByAmount += '<tr><th width="200">Row Labels</th>'+RowAmountAgent+'</tr>';
        ByAmount += '<tr><td>Total Data </td>'+RowAmountTotal+'</tr>';
        ByAmount += '<tr><td>* Contacted</td>'+RowAmountContacted+'</tr>';
        ByAmount += '<tr><td>** Considering to Cancelled Redemption & Withdrawal</td>'+RowAmountApproved+'</tr>';
        ByAmount += '<tr><td>** Agree to Cancelled Redemption & Withdrawal</td>'+RowAmountNotApproved+'</tr>';
        ByAmount += '<tr><td>* Uncontacted</td>'+RowAmountUnContacted+'</tr>';
        ByAmount += '<tr><td>* Sudah Pay by System</td>'+RowAmountPaybySystem+'</tr>';
        ByAmount += '<tr><td>* Other</td>'+RowAmountOther+'</tr>';
        //ByAmount += '<tr><td>* Not Yet Call</td>'+RowAmountNotYetCall+'</tr>';
        ByAmount += '<tr><td>% Contacted</th>'+RowAmountConserved+'</tr>';
        ByAmount += '<tr><td>% Agree to Cancelled Redemption & Withdrawal</th>'+RowAmountAgreeCancel+'</tr>';
        ByAmount += '</table>';
        ByAmount += footer;

    }

    public void getdataLapseAsOff_RW(){        
        // query data by Case
        map<string, string> username = new map<string, string>();
        for (User us2 : [SELECT id, Name FROM User]) {
            username.put(us2.id, us2.Name);
        }
        map<string, string> userlevel = new map<string, string>();
        for (User_Detail__c ud : [SELECT id, Name, User__c, Level__c FROM User_Detail__c WHERE Level__c != NULL]) {
            userlevel.put(ud.User__c, ud.Level__c);
        }
        
        String RowCaseAgent = '';
        String RowCaseTotal = '';
        String RowCaseContacted = '';
        String RowCaseApproved = ''; // Considering
        String RowCaseNotApproved = ''; // Agree to Cancel
        String RowCaseUnContacted = '';
        String RowCaseNotYetCall = '';
        String RowCaseConserved = '';
        String RowCasePaybySystem = '';
        String RowCaseOther = '';
        String RowCaseAgreeCancel = '';
    
        String RowAmountAgent = '';
        String RowAmountTotal = '';
        String RowAmountContacted = '';
        String RowAmountApproved = ''; // Considering
        String RowAmountNotApproved = ''; // Agree to Cancel
        String RowAmountUnContacted = '';
        String RowAmountNotYetCall = '';
        String RowAmountConserved = '';
        String RowAmountPaybySystem = '';
        String RowAmountOther = '';
        String RowAmountAgreeCancel = '';

        String AgentName = '';
        String AgentLevel = '';
        String CallStatus = '';

        Double Amountcase = 0;
        Double TotalAmount = 0;
        Double AmountContacted = 0;
        Double AmountApproved = 0;
        Double AmountNotApproved = 0;
        Double AmountUnContacted = 0;
        Double AmountNotYetCall = 0;
        Double AmountConserved = 0;
        Double AmountPaybySystem = 0;
        Double AmountOther = 0;
        Double AmountAgreeCancel = 0;

        integer countcase = 0; 
        integer totalCount = 0;
        integer countContacted = 0;
        integer countApproved = 0;
        integer countNotApproved = 0;
        integer countUnContacted = 0;
        integer countNotYetCall = 0;
        integer countConserved = 0;
        integer countPaybySystem = 0;
        integer countOther = 0;
        integer countAgreeCancel = 0;

        // Grand Total
        Double GrandTotalAmount = 0;
        Double TotalAmountContacted = 0;
        Double TotalAmountApproved = 0;
        Double TotalAmountNotApproved = 0;
        Double TotalAmountUnContacted = 0;
        Double TotalAmountNotYetCall = 0;
        Double TotalAmountConserved = 0;
        Double TotalAmountPaybySystem = 0;
        Double TotalAmountOther = 0;
        Double TotalAmountAgreeCancel = 0;

        integer GrandtotalCount = 0;
        integer TotalcountContacted = 0;
        integer TotalcountApproved = 0;
        integer TotalcountNotApproved = 0;
        integer TotalcountUnContacted = 0;
        integer TotalcountNotYetCall = 0;
        integer TotalcountConserved = 0;
        integer TotalcountPaybySystem = 0;
        integer TotalcountOther = 0;
        integer TotalcountAgreeCancel = 0;

        // Level 1
        Double Lvl1_GrandTotalAmount = 0;
        Double Lvl1_TotalAmountContacted = 0;
        Double Lvl1_TotalAmountApproved = 0;
        Double Lvl1_TotalAmountNotApproved = 0;
        Double Lvl1_TotalAmountUnContacted = 0;
        Double Lvl1_TotalAmountNotYetCall = 0;
        Double Lvl1_TotalAmountConserved = 0;
        Double Lvl1_TotalAmountPaybySystem = 0;
        Double Lvl1_TotalAmountOther = 0;
        Double Lvl1_TotalAmountAgreeCancel = 0;

        integer Lvl1_GrandtotalCount = 0;
        integer Lvl1_TotalcountContacted = 0;
        integer Lvl1_TotalcountApproved = 0;
        integer Lvl1_TotalcountNotApproved = 0;
        integer Lvl1_TotalcountUnContacted = 0;
        integer Lvl1_TotalcountNotYetCall = 0;
        integer Lvl1_TotalcountConserved = 0;
        integer Lvl1_TotalcountPaybySystem = 0;
        integer Lvl1_TotalcountOther = 0;
        integer Lvl1_TotalcountAgreeCancel = 0;

        // Level 2
        Double Lvl2_GrandTotalAmount = 0;
        Double Lvl2_TotalAmountContacted = 0;
        Double Lvl2_TotalAmountApproved = 0;
        Double Lvl2_TotalAmountNotApproved = 0;
        Double Lvl2_TotalAmountUnContacted = 0;
        Double Lvl2_TotalAmountNotYetCall = 0;
        Double Lvl2_TotalAmountConserved = 0;
        Double Lvl2_TotalAmountPaybySystem = 0;
        Double Lvl2_TotalAmountOther = 0;
        Double Lvl2_TotalAmountAgreeCancel = 0;

        integer Lvl2_GrandtotalCount = 0;
        integer Lvl2_TotalcountContacted = 0;
        integer Lvl2_TotalcountApproved = 0;
        integer Lvl2_TotalcountNotApproved = 0;
        integer Lvl2_TotalcountUnContacted = 0;
        integer Lvl2_TotalcountNotYetCall = 0;
        integer Lvl2_TotalcountConserved = 0;
        integer Lvl2_TotalcountPaybySystem = 0;
        integer Lvl2_TotalcountOther = 0;
        integer Lvl2_TotalcountAgreeCancel = 0;

        // Level 0
        Double Lvl0_GrandTotalAmount = 0;
        Double Lvl0_TotalAmountContacted = 0;
        Double Lvl0_TotalAmountApproved = 0;
        Double Lvl0_TotalAmountNotApproved = 0;
        Double Lvl0_TotalAmountUnContacted = 0;
        Double Lvl0_TotalAmountNotYetCall = 0;
        Double Lvl0_TotalAmountConserved = 0;
        Double Lvl0_TotalAmountPaybySystem = 0;
        Double Lvl0_TotalAmountOther = 0;
        Double Lvl0_TotalAmountAgreeCancel = 0;

        integer Lvl0_GrandtotalCount = 0;
        integer Lvl0_TotalcountContacted = 0;
        integer Lvl0_TotalcountApproved = 0;
        integer Lvl0_TotalcountNotApproved = 0;
        integer Lvl0_TotalcountUnContacted = 0;
        integer Lvl0_TotalcountNotYetCall = 0;
        integer Lvl0_TotalcountConserved = 0;
        integer Lvl0_TotalcountPaybySystem = 0;
        integer Lvl0_TotalcountOther = 0;
        integer Lvl0_TotalcountAgreeCancel = 0;

        string tempagent = '';
            
        AggregateResult[] groupedResults;
        if(Test.isRunningTest()) {
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                  GROUP BY Agent__c, Call_Status_Config__c];            
        }
        else {
                
            if (filterdata.Case_Type__c == 'Redemption & Withdrawal') 
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and (Case_Type__c = 'Withdrawal' OR Case_Type__c = 'Redemption Konven') and Call_List__r.Generated_Date__c >=: filterdata.List_Date__c and (Call_Date__c <=: filterdata.Expired_Date__c OR Call_Date__c = NULL)
                    WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and (Case_Type__c = 'Withdrawal' OR Case_Type__c = 'Redemption Konven') and Call_List__r.Generated_Date__c >=: filterdata.List_Date__c and (Collection_Call_Date_F__c <=: filterdata.Expired_Date__c OR Collection_Call_Date_F__c = NULL)
                  GROUP BY Agent__c, Call_Status_Config__c];
            else 
            groupedResults = [SELECT Agent__c, Call_Status_Config__c, SUM(APE_Convert__c), Count(id)
                  FROM Call_Line__c
                    //WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type__c =: filterdata.Case_Type__c and Call_List__r.Generated_Date__c >=: filterdata.List_Date__c and (Call_Date__c <=: filterdata.Expired_Date__c OR Call_Date__c = NULL)
                    WHERE Call_List__r.RecordType.Name = 'Collection AMFS' and Case_Type__c =: filterdata.Case_Type__c and Call_List__r.Generated_Date__c >=: filterdata.List_Date__c and (Collection_Call_Date_F__c <=: filterdata.Expired_Date__c OR Collection_Call_Date_F__c = NULL)
                  GROUP BY Agent__c, Call_Status_Config__c];
        }

        for (AggregateResult ar : groupedResults)  {
            AgentName = username.get(string.valueof(ar.get('Agent__c')));
            if (userlevel.get(string.valueof(ar.get('Agent__c'))) == NULL) AgentLevel = '0';
            else AgentLevel = userlevel.get(string.valueof(ar.get('Agent__c')));

            CallStatus = string.valueof(ar.get('Call_Status_Config__c'));
            Amountcase = double.valueof(ar.get('expr0'));
            countcase = integer.valueof(ar.get('expr1'));
                
            System.debug('Agent__c : ' + ar.get('Agent__c'));
            System.debug('Agent Name : ' +AgentName);

            System.debug('Call_Status_Config__c : ' + CallStatus);
            System.debug('Sum APE Convery' + Amountcase);
            System.debug('Count : ' + countcase);
            
            if (tempagent != AgentName) {
                // ByCase ==============================
                if (totalCount == 0) CountConserved = 0;
                else CountConserved = CountContacted * 100 / totalCount;

                if (CountContacted == 0) CountAgreeCancel = 0;
                else CountAgreeCancel = CountApproved * 100 / CountContacted;

                system.debug('totalCount : '+totalCount);
                system.debug('CountApproved : '+CountApproved);
                system.debug('CountConserved : '+CountConserved);

                RowCaseAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row.
                if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
                if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
                if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
                if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
                if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
                if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
                if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
                if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
                if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';
                if (tempagent != '') RowCaseAgreeCancel += '<td>'+CountAgreeCancel+' %</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalCount += totalCount;
                TotalcountContacted += countContacted;
                TotalcountApproved += countApproved;
                TotalcountNotApproved += countNotApproved;
                TotalcountUnContacted += countUnContacted;
                TotalcountNotYetCall += countNotYetCall;
                TotalcountConserved += countConserved;
                TotalcountPaybySystem += countPaybySystem;
                TotalcountOther += countOther;

                // Level 1 ?
                if (agentlevel == '1') {
                    lvl1_GrandtotalCount += totalCount;
                    lvl1_TotalcountContacted += countContacted;
                    lvl1_TotalcountApproved += countApproved;
                    lvl1_TotalcountNotApproved += countNotApproved;
                    lvl1_TotalcountUnContacted += countUnContacted;
                    lvl1_TotalcountNotYetCall += countNotYetCall;
                    lvl1_TotalcountConserved += countConserved;
                    lvl1_TotalcountPaybySystem += countPaybySystem;
                    lvl1_TotalcountOther += countOther;
                }

                // Level 2
                if (agentlevel == '2') {
                    lvl2_GrandtotalCount += totalCount;
                    lvl2_TotalcountContacted += countContacted;
                    lvl2_TotalcountApproved += countApproved;
                    lvl2_TotalcountNotApproved += countNotApproved;
                    lvl2_TotalcountUnContacted += countUnContacted;
                    lvl2_TotalcountNotYetCall += countNotYetCall;
                    lvl2_TotalcountConserved += countConserved;
                    lvl2_TotalcountPaybySystem += countPaybySystem;
                    lvl2_TotalcountOther += countOther;
                }

                // Level 0
                if (agentlevel == '0') {
                    lvl0_GrandtotalCount += totalCount;
                    lvl0_TotalcountContacted += countContacted;
                    lvl0_TotalcountApproved += countApproved;
                    lvl0_TotalcountNotApproved += countNotApproved;
                    lvl0_TotalcountUnContacted += countUnContacted;
                    lvl0_TotalcountNotYetCall += countNotYetCall;
                    lvl0_TotalcountConserved += countConserved;
                    lvl0_TotalcountPaybySystem += countPaybySystem;
                    lvl0_TotalcountOther += countOther;
                }

                totalCount = 0;
                CountContacted = 0;
                CountApproved = 0;
                CountNotApproved = 0;
                CountUnContacted = 0;
                CountNotYetCall = 0;
                CountConserved = 0;
                CountPaybySystem = 0;
                CountOther = 0;
                
                // ByAmount ==============================
                if (totalAmount == 0) AmountConserved = 0;
                else AmountConserved = AmountContacted * 100 / totalAmount;                
                AmountConserved = AmountConserved.round();
                
                if (AmountContacted == 0) AmountAgreeCancel = 0;
                else AmountAgreeCancel = AmountApproved * 100 / AmountContacted;                
                AmountAgreeCancel = AmountAgreeCancel.round();

                system.debug('2. totalAmount : '+totalAmount);
                system.debug('2. AmountApproved : '+AmountApproved);
                system.debug('2. AmountConserved : '+AmountConserved);

                RowAmountAgent += '<th>'+AgentName+'</th>';
                // jika ganti agent, isi ke Row. // Terbilang.AmountText(math.round(CPFieldList[i-1].Sales_Price__c))
                if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
                if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
                if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
                if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
                if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
                if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';
                if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
                if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
                if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';
                if (tempagent != '') RowAmountAgreeCancel += '<td>'+AmountAgreeCancel+' %</td>';

                // Grand Total, sebelum di reset jadi nol
                GrandtotalAmount += totalAmount;
                TotalAmountContacted += AmountContacted;
                TotalAmountApproved += AmountApproved;
                TotalAmountNotApproved += AmountNotApproved;
                TotalAmountUnContacted += AmountUnContacted;
                TotalAmountNotYetCall += AmountNotYetCall;
                TotalAmountConserved += AmountConserved;
                TotalAmountPaybySystem += AmountPaybySystem;
                TotalAmountOther += AmountOther;

                // Level 1
                if (AgentLevel == '1') {
                    lvl1_GrandtotalAmount += totalAmount;
                    lvl1_TotalAmountContacted += AmountContacted;
                    lvl1_TotalAmountApproved += AmountApproved;
                    lvl1_TotalAmountNotApproved += AmountNotApproved;
                    lvl1_TotalAmountUnContacted += AmountUnContacted;
                    lvl1_TotalAmountNotYetCall += AmountNotYetCall;
                    lvl1_TotalAmountConserved += AmountConserved;
                    lvl1_TotalAmountPaybySystem += AmountPaybySystem;
                    lvl1_TotalAmountOther += AmountOther;
                }

                // Level 2
                if (AgentLevel == '2') {
                    lvl2_GrandtotalAmount += totalAmount;
                    lvl2_TotalAmountContacted += AmountContacted;
                    lvl2_TotalAmountApproved += AmountApproved;
                    lvl2_TotalAmountNotApproved += AmountNotApproved;
                    lvl2_TotalAmountUnContacted += AmountUnContacted;
                    lvl2_TotalAmountNotYetCall += AmountNotYetCall;
                    lvl2_TotalAmountConserved += AmountConserved;
                    lvl2_TotalAmountPaybySystem += AmountPaybySystem;
                    lvl2_TotalAmountOther += AmountOther;
                }

                // Level 0
                if (AgentLevel == '0') {
                    lvl0_GrandtotalAmount += totalAmount;
                    lvl0_TotalAmountContacted += AmountContacted;
                    lvl0_TotalAmountApproved += AmountApproved;
                    lvl0_TotalAmountNotApproved += AmountNotApproved;
                    lvl0_TotalAmountUnContacted += AmountUnContacted;
                    lvl0_TotalAmountNotYetCall += AmountNotYetCall;
                    lvl0_TotalAmountConserved += AmountConserved;
                    lvl0_TotalAmountPaybySystem += AmountPaybySystem;
                    lvl0_TotalAmountOther += AmountOther;
                }

                totalAmount = 0;
                AmountContacted = 0;
                AmountApproved = 0;
                AmountNotApproved = 0;
                AmountUnContacted = 0;
                AmountNotYetCall = 0;
                AmountConserved = 0;
                AmountPaybySystem = 0;
                AmountOther = 0;

                tempagent = AgentName;
            }

            // by Count ============================
            totalCount += countcase;
            if (CallStatus == 'P' || CallStatus == 'Y' || CallStatus == 'N') CountContacted += countcase;
            
            if (CallStatus == 'P' ) CountApproved += countcase;
            else if (CallStatus == 'Y') CountNotApproved += countcase;
            else if (CallStatus == 'F') CountUnContacted += countcase;
            else if (CallStatus == 'Sudah Pay By System') CountPaybySystem += countcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') CountNotYetCall += countcase;
            else if (CallStatus != 'N') CountOther += countcase;
            
            // by Amount  ============================
            totalAmount += Amountcase;
            if (CallStatus == 'P' || CallStatus == 'Y' || CallStatus == 'N') AmountContacted += Amountcase;
            
            if (CallStatus == 'P' || CallStatus == 'Y') AmountApproved += Amountcase;
            else if (CallStatus == 'Y') AmountNotApproved += Amountcase;
            else if (CallStatus == 'F') AmountUnContacted += Amountcase;
            else if (CallStatus == 'Sudah Pay By System') AmountPaybySystem += Amountcase;
            else if (CallStatus == '' || CallStatus == NULL || CallStatus == 'NULL') AmountNotYetCall += Amountcase;
            else if (CallStatus != 'N') AmountOther += Amountcase;
            
        } // end loop
        
        // By Count ============================
        // Grand Total, setelah selesai loop
        if (totalCount == 0) CountConserved = 0;
        else CountConserved = CountContacted * 100 / totalCount;
        
        if (CountContacted == 0) CountAgreeCancel = 0;
        else CountAgreeCancel = CountApproved * 100 / CountContacted;

        GrandtotalCount += totalCount;
        TotalcountContacted += countContacted;
        TotalcountApproved += countApproved;
        TotalcountNotApproved += countNotApproved;
        TotalcountUnContacted += countUnContacted;
        TotalcountNotYetCall += countNotYetCall;
        
        TotalcountPaybySystem += countPaybySystem;
        TotalcountOther += countOther;

        if (GrandtotalCount == 0) TotalcountConserved = 0;
        else TotalcountConserved = TotalCountContacted * 100 / GrandtotalCount;

        if (TotalCountContacted == 0) TotalcountAgreeCancel = 0;
        else TotalcountAgreeCancel = TotalCountApproved * 100 / TotalCountContacted;

        // level 1
        if (AgentLevel == '1') {
            lvl1_GrandtotalCount += totalCount;
            lvl1_TotalcountContacted += countContacted;
            lvl1_TotalcountApproved += countApproved;
            lvl1_TotalcountNotApproved += countNotApproved;
            lvl1_TotalcountUnContacted += countUnContacted;
            lvl1_TotalcountNotYetCall += countNotYetCall;
            
            lvl1_TotalcountPaybySystem += countPaybySystem;
            lvl1_TotalcountOther += countOther;
    
            if (lvl1_GrandtotalCount == 0) lvl1_TotalcountConserved = 0;
            else lvl1_TotalcountConserved = lvl1_TotalCountContacted * 100 / lvl1_GrandtotalCount;
    
            if (lvl1_TotalCountContacted == 0) lvl1_TotalcountAgreeCancel = 0;
            else lvl1_TotalcountAgreeCancel = lvl1_TotalCountApproved * 100 / lvl1_TotalCountContacted;
            
        }

        // level 2
        if (AgentLevel == '2') {
            lvl2_GrandtotalCount += totalCount;
            lvl2_TotalcountContacted += countContacted;
            lvl2_TotalcountApproved += countApproved;
            lvl2_TotalcountNotApproved += countNotApproved;
            lvl2_TotalcountUnContacted += countUnContacted;
            lvl2_TotalcountNotYetCall += countNotYetCall;
            
            lvl2_TotalcountPaybySystem += countPaybySystem;
            lvl2_TotalcountOther += countOther;
    
            if (lvl2_GrandtotalCount == 0) lvl2_TotalcountConserved = 0;
            else lvl2_TotalcountConserved = lvl2_TotalCountContacted * 100 / lvl2_GrandtotalCount;
    
            if (lvl2_TotalCountContacted == 0) lvl2_TotalcountAgreeCancel = 0;
            else lvl2_TotalcountAgreeCancel = lvl2_TotalCountApproved * 100 / lvl2_TotalCountContacted;
        }

        // level 0
        if (AgentLevel == '0') {
            lvl0_GrandtotalCount += totalCount;
            lvl0_TotalcountContacted += countContacted;
            lvl0_TotalcountApproved += countApproved;
            lvl0_TotalcountNotApproved += countNotApproved;
            lvl0_TotalcountUnContacted += countUnContacted;
            lvl0_TotalcountNotYetCall += countNotYetCall;
            
            lvl0_TotalcountPaybySystem += countPaybySystem;
            lvl0_TotalcountOther += countOther;
    
            if (lvl0_GrandtotalCount == 0) lvl0_TotalcountConserved = 0;
            else lvl0_TotalcountConserved = lvl0_TotalCountContacted * 100 / lvl0_GrandtotalCount;
    
            if (lvl0_TotalCountContacted == 0) lvl0_TotalcountAgreeCancel = 0;
            else lvl0_TotalcountAgreeCancel = lvl0_TotalCountApproved * 100 / lvl0_TotalCountContacted;
        }

        // add to Table
        if (tempagent != '') RowCaseTotal += '<th>'+totalCount+'</th>';
        if (tempagent != '') RowCaseContacted += '<td>'+CountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+CountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+CountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+CountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+CountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+CountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+CountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+CountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+CountAgreeCancel+' %</td>';
        
        // grand total
        if (tempagent != '') RowCaseAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+TotalCountAgreeCancel+' %</td>';

        // level 1
        if (tempagent != '') RowCaseAgent += '<th> Level 1 </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+lvl1_GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+lvl1_TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+lvl1_TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+lvl1_TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+lvl1_TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+lvl1_TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+lvl1_TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+lvl1_TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+lvl1_TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+lvl1_TotalCountAgreeCancel+' %</td>';

        // level 2
        if (tempagent != '') RowCaseAgent += '<th> Level 2 </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+lvl2_GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+lvl2_TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+lvl2_TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+lvl2_TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+lvl2_TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+lvl2_TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+lvl2_TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+lvl2_TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+lvl2_TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+lvl2_TotalCountAgreeCancel+' %</td>';

        // level 0
        if (tempagent != '') RowCaseAgent += '<th> No Have Level  </th>';
        if (tempagent != '') RowCaseTotal += '<td>'+lvl0_GrandtotalCount+'</td>';
        if (tempagent != '') RowCaseContacted += '<td>'+lvl0_TotalCountContacted+'</td>';
        if (tempagent != '') RowCaseApproved += '<td>'+lvl0_TotalCountApproved+'</td>';
        if (tempagent != '') RowCaseNotApproved += '<td>'+lvl0_TotalCountNotApproved+'</td>';
        if (tempagent != '') RowCaseUnContacted += '<td>'+lvl0_TotalCountUnContacted+'</td>';
        if (tempagent != '') RowCaseNotYetCall += '<td>'+lvl0_TotalCountNotYetCall+'</td>';
        if (tempagent != '') RowCaseConserved += '<td>'+lvl0_TotalCountConserved+' %</td>';
        if (tempagent != '') RowCasePaybySystem += '<td>'+lvl0_TotalCountPaybySystem+'</td>';
        if (tempagent != '') RowCaseOther += '<td>'+lvl0_TotalCountOther+'</td>';
        if (tempagent != '') RowCaseAgreeCancel += '<td>'+lvl0_TotalCountAgreeCancel+' %</td>';

        ByDateCase = header;
        ByDateCase += '<table>';
        ByDateCase += '<tr><th width="200">Row Labels</th>'+RowCaseAgent+'</tr>';
        ByDateCase += '<tr><td>Total Data </td>'+RowCaseTotal+'</tr>';
        ByDateCase += '<tr><td>* Contacted</td>'+RowCaseContacted+'</tr>';
        ByDateCase += '<tr><td>** Considering to Cancelled Redemption & Withdrawal</td>'+RowCaseApproved+'</tr>';
        ByDateCase += '<tr><td>** Agree to Cancelled Redemption & Withdrawal</td>'+RowCaseNotApproved+'</tr>';
        ByDateCase += '<tr><td>* Uncontacted</td>'+RowCaseUnContacted+'</tr>';
        ByDateCase += '<tr><td>* Sudah Pay by System</td>'+RowCasePaybySystem+'</tr>';
        ByDateCase += '<tr><td>* Other</td>'+RowCaseOther+'</tr>';
        ByDateCase += '<tr><td>* Not Yet Call</td>'+RowCaseNotYetCall+'</tr>';
        ByDateCase += '<tr><td>% Contacted</th>'+RowCaseConserved+'</tr>';
        ByDateCase += '<tr><td>% Agree to Cancelled Redemption & Withdrawal</th>'+RowCaseAgreeCancel+'</tr>';
        ByDateCase += '</table>';
        ByDateCase += footer;

        // By Amount ============================
        // Grand Total, setelah selesai loop
        if (totalAmount == 0) AmountConserved = 0;
        else AmountConserved = AmountContacted * 100 / totalAmount;
        AmountConserved = AmountConserved.round();

        if (AmountContacted == 0) AmountAgreeCancel = 0;
        else AmountAgreeCancel = AmountApproved * 100 / AmountContacted;
        AmountAgreeCancel = AmountAgreeCancel.round();

        GrandtotalAmount += totalAmount;
        TotalAmountContacted += AmountContacted;
        TotalAmountApproved += AmountApproved;
        TotalAmountNotApproved += AmountNotApproved;
        TotalAmountUnContacted += AmountUnContacted;
        TotalAmountNotYetCall += AmountNotYetCall;
        
        TotalAmountPaybySystem += AmountPaybySystem;
        TotalAmountOther += AmountOther;

        if (GrandtotalAmount == 0) TotalAmountConserved = 0;
        else TotalAmountConserved = TotalAmountContacted * 100 / GrandtotalAmount;        
        TotalAmountConserved = TotalAmountConserved.round();

        if (TotalAmountContacted == 0) TotalAmountAgreeCancel = 0;
        else TotalAmountAgreeCancel = TotalAmountApproved * 100 / TotalAmountContacted;
        TotalAmountAgreeCancel = TotalAmountAgreeCancel.round();

        // level 1
        if (AgentLevel == '1') {
            lvl1_GrandtotalAmount += totalAmount;
            lvl1_TotalAmountContacted += AmountContacted;
            lvl1_TotalAmountApproved += AmountApproved;
            lvl1_TotalAmountNotApproved += AmountNotApproved;
            lvl1_TotalAmountUnContacted += AmountUnContacted;
            lvl1_TotalAmountNotYetCall += AmountNotYetCall;
            
            lvl1_TotalAmountPaybySystem += AmountPaybySystem;
            lvl1_TotalAmountOther += AmountOther;
    
            if (lvl1_GrandtotalAmount == 0) lvl1_TotalAmountConserved = 0;
            else lvl1_TotalAmountConserved = lvl1_TotalAmountContacted * 100 / lvl1_GrandtotalAmount;        
            lvl1_TotalAmountConserved = lvl1_TotalAmountConserved.round();
    
            if (lvl1_TotalAmountContacted == 0) lvl1_TotalAmountAgreeCancel = 0;
            else lvl1_TotalAmountAgreeCancel = lvl1_TotalAmountApproved * 100 / lvl1_TotalAmountContacted;
            lvl1_TotalAmountAgreeCancel = lvl1_TotalAmountAgreeCancel.round();
        }

        // level 2
        if (AgentLevel == '2') {
            lvl2_GrandtotalAmount += totalAmount;
            lvl2_TotalAmountContacted += AmountContacted;
            lvl2_TotalAmountApproved += AmountApproved;
            lvl2_TotalAmountNotApproved += AmountNotApproved;
            lvl2_TotalAmountUnContacted += AmountUnContacted;
            lvl2_TotalAmountNotYetCall += AmountNotYetCall;
            
            lvl2_TotalAmountPaybySystem += AmountPaybySystem;
            lvl2_TotalAmountOther += AmountOther;
    
            if (lvl2_GrandtotalAmount == 0) lvl2_TotalAmountConserved = 0;
            else lvl2_TotalAmountConserved = lvl2_TotalAmountContacted * 100 / lvl2_GrandtotalAmount;        
            lvl2_TotalAmountConserved = lvl2_TotalAmountConserved.round();
    
            if (lvl2_TotalAmountContacted == 0) lvl2_TotalAmountAgreeCancel = 0;
            else lvl2_TotalAmountAgreeCancel = lvl2_TotalAmountApproved * 100 / lvl2_TotalAmountContacted;
            lvl2_TotalAmountAgreeCancel = lvl2_TotalAmountAgreeCancel.round();
        }

        // level 0
        if (AgentLevel == '0') {
            lvl0_GrandtotalAmount += totalAmount;
            lvl0_TotalAmountContacted += AmountContacted;
            lvl0_TotalAmountApproved += AmountApproved;
            lvl0_TotalAmountNotApproved += AmountNotApproved;
            lvl0_TotalAmountUnContacted += AmountUnContacted;
            lvl0_TotalAmountNotYetCall += AmountNotYetCall;
            
            lvl0_TotalAmountPaybySystem += AmountPaybySystem;
            lvl0_TotalAmountOther += AmountOther;
    
            if (lvl0_GrandtotalAmount == 0) lvl0_TotalAmountConserved = 0;
            else lvl0_TotalAmountConserved = lvl0_TotalAmountContacted * 100 / lvl0_GrandtotalAmount;        
            lvl0_TotalAmountConserved = lvl0_TotalAmountConserved.round();
    
            if (lvl0_TotalAmountContacted == 0) lvl0_TotalAmountAgreeCancel = 0;
            else lvl0_TotalAmountAgreeCancel = lvl0_TotalAmountApproved * 100 / lvl0_TotalAmountContacted;
            lvl0_TotalAmountAgreeCancel = lvl0_TotalAmountAgreeCancel.round();
        }
        
        // add to table
        if (tempagent != '') RowAmountTotal += '<th>'+Terbilang.AmountText(totalAmount)+'</th>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(AmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(AmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(AmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(AmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(AmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+AmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(AmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(AmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(AmountAgreeCancel)+' %</td>';
        
        // grand total
        if (tempagent != '') RowAmountAgent += '<th> Grand Total </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(TotalAmountAgreeCancel)+' %</td>';

        // level 1
        if (tempagent != '') RowAmountAgent += '<th> Level 1 </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(lvl1_GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(lvl1_TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(lvl1_TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(lvl1_TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(lvl1_TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(lvl1_TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+lvl1_TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(lvl1_TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(lvl1_TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(lvl1_TotalAmountAgreeCancel)+' %</td>';

        // level 2
        if (tempagent != '') RowAmountAgent += '<th> Level 2 </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(lvl2_GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(lvl2_TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(lvl2_TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(lvl2_TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(lvl2_TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(lvl2_TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+lvl2_TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(lvl2_TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(lvl2_TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(lvl2_TotalAmountAgreeCancel)+' %</td>';

        // level 0
        if (tempagent != '') RowAmountAgent += '<th> No Have Level </th>';
        if (tempagent != '') RowAmountTotal += '<td>'+Terbilang.AmountText(lvl0_GrandtotalAmount)+'</td>';
        if (tempagent != '') RowAmountContacted += '<td>'+Terbilang.AmountText(lvl0_TotalAmountContacted)+'</td>';
        if (tempagent != '') RowAmountApproved += '<td>'+Terbilang.AmountText(lvl0_TotalAmountApproved)+'</td>';
        if (tempagent != '') RowAmountNotApproved += '<td>'+Terbilang.AmountText(lvl0_TotalAmountNotApproved)+'</td>';
        if (tempagent != '') RowAmountUnContacted += '<td>'+Terbilang.AmountText(lvl0_TotalAmountUnContacted)+'</td>';
        if (tempagent != '') RowAmountNotYetCall += '<td>'+Terbilang.AmountText(lvl0_TotalAmountNotYetCall)+'</td>';
        if (tempagent != '') RowAmountConserved += '<td>'+lvl0_TotalAmountConserved+' %</td>';
        if (tempagent != '') RowAmountPaybySystem += '<td>'+Terbilang.AmountText(lvl0_TotalAmountPaybySystem)+'</td>';
        if (tempagent != '') RowAmountOther += '<td>'+Terbilang.AmountText(lvl0_TotalAmountOther)+'</td>';
        if (tempagent != '') RowAmountAgreeCancel += '<td>'+Terbilang.AmountText(lvl0_TotalAmountAgreeCancel)+' %</td>';

        ByDateAmount = header;
        ByDateAmount += '<table>';
        ByDateAmount += '<tr><th width="200">Row Labels</th>'+RowAmountAgent+'</tr>';
        ByDateAmount += '<tr><td>Total Data </td>'+RowAmountTotal+'</tr>';
        ByDateAmount += '<tr><td>* Contacted</td>'+RowAmountContacted+'</tr>';
        ByDateAmount += '<tr><td>** Considering to Cancelled Redemption & Withdrawal</td>'+RowAmountApproved+'</tr>';
        ByDateAmount += '<tr><td>** Agree to Cancelled Redemption & Withdrawal</td>'+RowAmountNotApproved+'</tr>';
        ByDateAmount += '<tr><td>* Uncontacted</td>'+RowAmountUnContacted+'</tr>';
        ByDateAmount += '<tr><td>* Sudah Pay by System</td>'+RowAmountPaybySystem+'</tr>';
        ByDateAmount += '<tr><td>* Other</td>'+RowAmountOther+'</tr>';
        ByDateAmount += '<tr><td>* Not Yet Call</td>'+RowAmountNotYetCall+'</tr>';
        ByDateAmount += '<tr><td>% Contacted</th>'+RowAmountConserved+'</tr>';
        ByDateAmount += '<tr><td>% Agree to Cancelled Redemption & Withdrawal</th>'+RowAmountAgreeCancel+'</tr>';
        ByDateAmount += '</table>';
        ByDateAmount += footer;

    }
    
    public void getdata2() {
        /*
        countCOA = 0;
        countInquiry = 0;
        countInvest = 0;
        countBTO = 0;
        countRedel = 0;
        string filtercourier = '';
        if (filterdata.courier__c != 'null' && filterdata.courier__c != NULL && filterdata.courier__c != '') filtercourier = ' AND courier__c = \''+filterdata.courier__c+'\' ';
            
        string filterDate = '';
        if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c >= '+filterdata.Due_Date__c+' AND Create_Date__c <= '+filterdata.Closed_Date__c+' ' ;
        else if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c == NULL) filterDate = ' AND Create_Date__c = '+filterdata.Due_Date__c+' ' ;
        else if (filterdata.Due_Date__c == NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c = '+filterdata.Closed_Date__c+' ' ;
        else filterDate = '' ;
        
        filterDate = filterDate.replace('00:00:00', '');

        //if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c >= \''+filterdata.Due_Date__c+'\' AND Create_Date__c <= \''+filterdata.Closed_Date__c+'\' ' ;
        //else if (filterdata.Due_Date__c != NULL && filterdata.Closed_Date__c == NULL) filterDate = ' AND Create_Date__c = \''+filterdata.Due_Date__c+'\' ' ;
        //else if (filterdata.Due_Date__c == NULL && filterdata.Closed_Date__c != NULL) filterDate = ' AND Create_Date__c = \''+filterdata.Closed_Date__c+'\' ' ;
        //else filterDate = ' AND Create_Date__c = \''+filterdata.Due_Date__c+'\' ' ;
        
        // QUERY DATA
        string queryStr = '';
        // == COA ==
        queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
        queryStr += ' Type = \'Request\' AND ';
        queryStr += ' Case_Type__c = \'Request_Courier Delivery ? Change of Address\' ';
        queryStr += filtercourier;
        queryStr += filterDate;
        
        system.debug('## COA : '+queryStr);
        
        coaList = new list<coa>();
        for (case cs : Database.query(queryStr))
        {
            countCOA += 1;
            
            coa newdata = new coa();
            
            newdata.DATA_ID = cs.CaseNumber; //'';
            newdata.REQUEST_NO = cs.CaseNumber; //'';
            newdata.CUSTOMER_NAME = cs.Contact.Name; //'';
            newdata.REQUEST_STATUS = '';
            newdata.RECEIVED_DATE = string.valueof(cs.CreatedDate); //'';
            newdata.CATEGORY = cs.Case_Type__c; //'';
            newdata.REQUESTOR = 'AMFS - DMU Queue';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.COMPLAIN = 'Customer';
            newdata.DESCRIPTION = cs.Description; //'';
            newdata.OTHERINFORMATION = '';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone  +'/'+ cs.Contact.HomePhone; //'';
            newdata.KOTA = '';
            newdata.REMARK_FROM_AXA = '';
            newdata.SENDDATE = string.valueof(date.Today()); //'';
            newdata.STATUS = '';
            newdata.PENERIMA = '';
            newdata.HUBUNGAN = '';
            newdata.TGLTERIMA = '';
            newdata.REMARK_FROM_NCS = '';
            newdata.DATECLOSED = '';
            newdata.STATUSCHS = 'OPEN';
            newdata.KURIR = filterdata.Courier__c;
            
            coaList.add(newdata);
        }
        // == INQUIRY ==
        queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
        queryStr += ' Type = \'Request\' AND ';
        queryStr += ' ( ';
        queryStr += ' Case_Type__c = \'Request_Courier Delivery ? Speed Up Delivery\' OR ';
        queryStr += ' Case_Type__c = \'Request_Courier Delivery - Inquiry Receipt\' ';
        queryStr += ' ) ';
        queryStr += filtercourier;
        queryStr += filterDate;
        
        system.debug('## Inquiry : '+queryStr);
                
        inquiryList = new list<inquiry>();
        for (case cs : Database.query(queryStr))
        {
            countInquiry += 1;
                
            inquiry newdata = new inquiry();
            newdata.DATA_ID = cs.CaseNumber; //'';
            newdata.REQUEST_NO = cs.CaseNumber; //'';
            newdata.CUSTOMER_NAME = cs.Contact.Name; //'';
            newdata.REQUEST_STATUS = '';
            newdata.RECEIVED_DATE = string.valueOf(cs.CreatedDate); //'';
            newdata.CATEGORY = cs.Case_Type__c; //'';
            newdata.REQUESTOR = 'AMFS - DMU Queue';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.COMPLAIN = 'Customer';
            newdata.DESCRIPTION = cs.Description; //'';
            newdata.OTHERINFORMATION = '';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone +'/'+ cs.Contact.HomePhone; //'';
            newdata.KOTA = '';
            newdata.REMARK_FROM_AXA = 'DMU: REQUEST SPEED UP TO KURIR';
            newdata.SENDDATE = string.valueof(date.Today()); //'';
            newdata.STATUS = '';
            newdata.PENERIMA = '';
            newdata.HUBUNGAN = '';
            newdata.TGLTERIMA = '';
            newdata.REMARK_FROM_NCS = '';
            newdata.DATECLOSED = '';
            newdata.STATUSCHS = 'OPEN';
            newdata.KURIR = filterdata.Courier__c;
            
            inquiryList.add(newdata);
        }

        
        // == INVEST ==
        queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
        queryStr += ' Type = \'Complaint\' AND ';
        queryStr += ' ( ';
        queryStr += ' Category__c = \'Courier Delivery - Investigation\' OR ';
        queryStr += ' Category__c = \'Courier Investigation - Delivery\' ';
        queryStr += ' ) ';
        queryStr += filtercourier;
        queryStr += filterDate;

        system.debug('## Invest : '+queryStr);

        investList = new list<invest>();
        for (case cs : Database.query(queryStr))
        {
            countInvest += 1;
            
            invest newdata = new invest();

            newdata.NUM = cs.CaseNumber; //'';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.CONSIGNEE = cs.Contact.Name; //'';
            newdata.NO_INVESTIGASI = 'DMU / '+cs.CaseNumber+' / Investigasi /'+cs.CreatedDate.year();
            newdata.KOTA = '';
            newdata.SLA = '';
            newdata.DATA_CASE = cs.Description; //'';
            newdata.REMARK_AXA = 'DMU: REQUEST INVESTIGASI TO KURIR';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone +'/'+ cs.Contact.HomePhone; //'';
            newdata.DATE_REQUEST = string.valueof(date.today()); //string.valueof(cs.CreatedDate); //'';
            newdata.TGLHASILINVESTIGASI = '';
            newdata.HASIL_INVESTIGASI = '';
            newdata.AGING_PINALTY = '';
            newdata.PINALTY = '';
            newdata.REMARK = '';
            newdata.KESIMPULAN_HASIL_INVESTIGASI = '';
            newdata.SLA_OVERDUE_OK = '';
            newdata.COMPLAIN = 'CUSTOMER';
            newdata.Kurir = filterdata.Courier__c;
            newdata.Category = cs.Case_Type__c; //'';
            newdata.No_request = cs.CaseNumber; //'';
            
            investList.add(newdata);
        }

        
        // == BTO ==
        queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
        queryStr += ' Type = \'Request\' AND ';
        queryStr += ' ( ';
        queryStr += ' Case_Type__c = \'BTO\' OR ';
        queryStr += ' Case_Type__c = \'BTO2\' ';
        queryStr += ' ) ';
        queryStr += filtercourier;
        queryStr += filterDate;

        system.debug('## BTO : '+queryStr);

        btoList = new list<bto>();
        for (case cs :Database.query(queryStr))
        {
            countBTO += 1;
            
            bto newdata = new bto();
            newdata.Policy_Number = cs.contact.Policy_No__c; //'';
            newdata.Tujuan_Keluar = '';
            newdata.Lokasi_Custody = '';
            newdata.Tgl_Upload = '';
            
            btoList.add(newdata);
        }

        // == REDEL ==
        queryStr = 'SELECT id, CaseNumber, Contact.Name, CreatedDate, Case_Type__c, Contact.Policy_No__c, Description, Contact.MobilePhone, Contact.Phone, Contact.HomePhone FROM Case ';
        queryStr += ' WHERE Entity_Backup__c = \'AMFS\' and ';
        if (filterdata.ContactId != NULL) queryStr += ' ContactId = \''+filterdata.ContactId+'\' AND ';
        queryStr += ' Type = \'Request\' AND ';
        queryStr += ' ( ';
        queryStr += ' Case_Type__c = \'Request_Courier Delivery ? Policy Retur\' OR ';
        queryStr += ' Case_Type__c = \'Request_Courier Delivery-Surat Retur\' ';
        queryStr += ' ) ';
        queryStr += filtercourier;
        queryStr += filterDate;

        system.debug('## REDEL : '+queryStr);

        redelList = new list<redel>();
        for (case cs : Database.query(queryStr))
        {
            countRedel += 1;
            
            redel newdata = new redel();
            newdata.DATA_ID = cs.CaseNumber; //'';
            newdata.REQUEST_NO = cs.CaseNumber; //'';
            newdata.CUSTOMER_NAME = cs.Contact.Name; //'';
            newdata.REQUEST_STATUS = '';
            newdata.RECEIVED_DATE = string.valueof(cs.CreatedDate); //'';
            newdata.CATEGORY = cs.Case_Type__c; //'';
            newdata.REQUESTOR = 'AMFS - DMU Queue';
            newdata.POLIS = cs.Contact.Policy_No__c; //'';
            newdata.COMPLAIN = 'Customer';
            newdata.DESCRIPTION = cs.Description; //'';
            newdata.OTHERINFORMATION = '';
            newdata.TELP = cs.Contact.MobilePhone +'/'+ cs.Contact.Phone  +'/'+ cs.Contact.HomePhone; //'';
            newdata.KOTA = '';
            newdata.REMARK_FROM_AXA = '';
            newdata.SENDDATE = string.valueof(date.Today()); //'';
            newdata.STATUS = '';
            newdata.PENERIMA = '';
            newdata.HUBUNGAN = '';
            newdata.TGLTERIMA = '';
            newdata.REMARK_FROM_NCS = '';
            newdata.DATECLOSED = '';
            newdata.STATUSCHS = 'OPEN';
            newdata.KURIR = filterdata.Courier__c;

            redelList.add(newdata);
        }        
*/
    }
     
}