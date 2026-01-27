public class WelcomeCallUtils {
    
    public String hari;
    public Datetime now = Datetime.now();
    public Integer offset = UserInfo.getTimezone().getOffset(now);
    public Datetime dt = now.addSeconds(offset/1000);
    public String strDt = dt.formatGmt('d MMMMMMMM yyyy');
    public String strDay = now.format('E');
    public WelcomeCall_Product__c productSt = new WelcomeCall_Product__c();
    public String VerifikasiData='';
    
    
    
    /**
     * Get Images in Document by folder Name
     */
    public List<Document> getImageinDocumentByFolderName(String folderName){
        List<Document> docImages = [SELECT Id, FolderId, Folder.Name, name, developername FROM Document WHERE Folder.Name like : folderName];
        return docImages;
    }
    
    
    /**
     * populate map of document by folder name
     */
    public Map<String, Document> populateMapDocumentbyKeyName(String folderName){
        Map<String, Document> mapDocImage = new Map<String, Document>();
        List<Document> docImages = getImageinDocumentByFolderName(folderName);
        System.debug('doc.id '+docImages);
        for(Document doc : docImages){
            mapDocImage.put(doc.developername, doc);
        }
        return mapDocImage;
    }
    
    public String getDataChangesInVerifikasiData(String clId, String section){
            
            List<string> sections = new List<string>{section};
            List<Survey_Response__c> respon = getResponseByParams(sections, clId);
            String responStr = '<b>Tidak ada perubahan data</b>';
            if(!respon.isEmpty()){
                responStr = '<br>' +
                                '<ul>'+
                                    '<li>Alamat 1: '+(respon[0].WelcomeCall_Address_1__c == null ? '-' : respon[0].WelcomeCall_Address_1__c)+'</li>'+
                                    '<li>Alamat 2: '+(respon[0].WelcomeCall_Address_2__c == null ? '-' : respon[0].WelcomeCall_Address_2__c)+'</li>'+
                                    '<li>Alamat 3: '+(respon[0].WelcomeCall_Address_3__c == null ? '-' : respon[0].WelcomeCall_Address_3__c)+'</li>'+
                                    '<li>Alamat 4: '+(respon[0].WelcomeCall_Address_4__c == null ? '-' : respon[0].WelcomeCall_Address_4__c)+'</li>'+
                                    '<li>Email: '+(respon[0].WelcomeCall_Email__c == null ? '-' : respon[0].WelcomeCall_Email__c)+'</li>'+
                                    '<li>Other: '+(respon[0].WelcomeCall_Others__c == null ? '-' : respon[0].WelcomeCall_Others__c)+'</li>'+
                                '</ul>';
            }
        return responStr;
    }
    /**
     * Get script in custom setting by tab name
     */
    public List<WelcomeCall_Script__c> getScriptByTab(String tab){
        system.debug('OCEN 22 nih' + tab);
        List<WelcomeCall_Script__c> scripts = [Select Name, WelcomeCall_Content_Answer__c, WelcomeCall_Content_Question__c, WelcomeCall_Fg_Closing__c, WelcomeCall_Fg_Note__c,
                                               WelcomeCall_Fg_Reschedule__c, WelcomeCall_Fg_Product__c, WelcomeCall_Fg_Survey__c, WelcomeCall_Lookup_Label__c, WelcomeCall_Parent__c, WelcomeCall_Product_Name__c, WelcomeCall_Section__c,
                                               WelcomeCall_Tab_Name__c, WelcomeCall_Type__c , WelcomeCall_Group_Type__c, WelcomeCall_Content_Question_2__c,
                                               welcomeCall_Lookup_Label_2__c, WelcomeCall_fgLegalStatement__c, WelcomeCall_GroupOrder__c, WelcomeCall_ImageContent_c__c,
                                               WelcomeCall_ImageAnswer_c__c, WelcomeCall_Parent_Dependency__c, WelcomeCall_Fg_InfoProduct__c
                                               from WelcomeCall_Script__c where WelcomeCall_Tab_Name__c =: tab
                                              order by name, WelcomeCall_Tab_Name__c];
        system.debug('OCEN 23 nih' + scripts);
        return scripts;
    }
    
    /**
     * Get next script by parent
     */
    public List<WelcomeCall_Script__c> getNextbyParent(String parent){
        List<WelcomeCall_Script__c> scripts = [Select Id, Name, WelcomeCall_Tab_Name__c, WelcomeCall_Section__c
                                               from WelcomeCall_Script__c where WelcomeCall_Parent__c =: parent
                                              order by name, WelcomeCall_Tab_Name__c];
        return scripts;
    }
    
    /**
     * Get Product Name in custom setting by code
     */
    public List<WelcomeCall_Product__c> getListofProductNameByCode(String productCode){
        List<WelcomeCall_Product__c> products = [Select name, WelcomeCall_Product_Name__c
                     from WelcomeCall_Product__c where name =: productCode];
        if(!products.isEmpty()){
            productSt = products.get(0);
        } else {
            productSt.WelcomeCall_Product_Name__c = productCode;
        }
        return products;
    }
    
    /**
     * get Contact Data by Id
     */
    public Contact getContactById(Id contactId){
        // add WelcomeCall_GenderName__c, entity__c, policyApp__c, Agent_Code__c , MobilePhone by Faizir 25-11-2019
        return [Select name, phone, welcomecall_issued_date__c, welcomecall_product_code_plan__c, Policy_No__c, Agent_Name__c,
                Agent_Profile_Address1__c, Agent_Profile_Address2__c, Agent_Profile_Address3__c, Agent_Profile_Address4__c, Email, Other_Email__c,
                WelcomeCall_Lump_Sum__c, Premium__c, WelcomeCall_Status_Polis__c, WelcomeCall_APE__c, WelcomeCall_Effective_Date__c, WelcomeCall_Payment_Type__c,
                WelcomeCall_Payment_Type_Name__c, WelcomeCall_Status_Polis2__c, Total_Premium__c, WelcomeCall_CurrencyName__c, WelcomeCall_GenderName__c, 
                entity__c, policyApp__c, Agent_Code__c , MobilePhone
               from contact
               where id =: contactId];
    }
    
    public List<Survey_Response__c> getResponseByParams(List<string> sections, String clId){
        String query = 'SELECT WelcomeCall_Address_1__c, WelcomeCall_Address_2__c, WelcomeCall_Address_3__c, WelcomeCall_Address_4__c,'+
                       ' WelcomeCall_Email__c, WelcomeCall_Others__c, Answer_1__c, WelcomeCall_Section__c, Question_1__c, Question_2__c '+
                       ' FROM Survey_Response__c '+
                       ' WHERE WelcomeCall_Call_Line__c =: clId ';
        if(!sections.isEmpty()){
            query = query + ' and WelcomeCall_Section__c in : sections ';
        }

        return Database.query(query);
    }
    
    public String getBagianHari(){
        
        Time startPagi = Time.newInstance(6, 0, 0, 0);
        Time startSiang = Time.newInstance(11, 0, 0, 0);
        Time startSore = Time.newInstance(15, 0, 0, 0);
        
        Time endPagi = Time.newInstance(10, 59, 59, 59);
        Time endSiang = Time.newInstance(14, 59, 59, 59);
        Time endSore = Time.newInstance(17, 59, 59, 59);
        if(startPagi <= now.time() && now.time()<= endPagi){
            hari ='Pagi';
        } else if(startSiang <= now.time() && now.time()<= endSiang){
            hari ='Siang';
        } else {
            hari ='Sore';
        }
        return hari;
    }
    
    /**
     * get Call Line Data by Id
     */
    public Call_Line__c getCLById(Id cLId){
        return [ Select Id, name, owner.name, welcomecall_attempt__c, welcomecall_call_line_status__c, Contact__c, 
                Activity_Result__c, Verification__c, WelcomeCall_Cooling_Off__c, WelcomeCall_Cooling_Off2__c, WelcomeCall_Detail_Status__c,WelcomeCall_Days__c,
                WelcomeCall_Reason_Detail_Status__c, Notes__c
                from call_line__c
                where id =: cLId
                ];
    }
    
    /**
     * Format money to string
     */
    public String formatMoney(Decimal money){
        String s = String.valueOf(money);
        if(money != null){
            List<String> args = new String[]{'0','number','###,###,##0.00'};
            s = String.format(money.format(), args);
        }
        return s;
    }
    
    /**
     * Format Date DD MMMMMMMM YYYY to string
     */
    public String formatDateTime(Datetime dtTime){
        if(dtTime == null){
            return '';
        }
        String strDt = dtTime.formatGmt('d MMMMMMMM yyyy');
        return strDt;
    }
    
    public Integer getDay(Datetime dtTime){
        Integer strDt;
        if(dtTime != null){
            strDt = Integer.valueOf(dtTime.formatGmt('d'));
        }
        return strDt;
    }
    
    public String getMonth(Datetime dtTime){
        String strDt;
        if(dtTime != null){
            strDt = dtTime.formatGmt('MMMMMMMM');
        }
        return strDt;
    }
    
    public Integer getYear(Datetime dtTime){
        Integer strDt;
        if(dtTime != null){
            strDt = Integer.valueOf(dtTime.formatGmt('yyyy'));
        }
        return strDt;
    }
    
    public String faName {get;set;}
    public String tanggalPenandatanganan {get;set;}
    public String lumpsumAmount {get;set;}
    public String fundCD {get;set;}
    public String fundNM {get;set;}
    
    public void setDataAgent(EIPJson dataAgentEIP){
        try{
            string firstName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.firstNM;
            string middleName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.middleNM;
            string lastName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.lastNM;
            faName = (firstName == null ? '' : firstName)+' '+(middleName == null ? '' : middleName)+' '+(lastName == null ? '' : lastName);
            faName = faName.replaceAll('\'','\\`');
        }catch(Exception e){
            System.debug('Error in Detail Task setDataAgent');
        }
    }
    
    public void setDataPolicy(EIPJson dataPolicyEIP){
        try{
            tanggalPenandatanganan = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM;
            lumpsumAmount = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].initialLumpsumPremiumAMT.trim();
        }catch(Exception e){
            System.debug('Error in Detail Task setDataPolicy');
        }
    }
    
    public void setDataFund(EIPJson dataFundEIP){
        try{
            String description;
            EIPJson.EIP_AgSa_InsurancePolicy fund = dataFundEIP.Body.AgSa_InsurancePolicy_Type;
            fundCD = fund.hasAccountDetailsIn[0].hasInvestmentFundDetailsIn[0].investmentFundCd.trim();
            EIP_Code_Properties__c result = EIP_Code_Properties__c.getValues(fundCD);
            fundNM = result.description__c;
        }catch(Exception e){
            System.debug('Error in Detail Task setDataFund');
        }
    }
    
    public PageReference populateDetailNasabah(Contact contact, Call_Line__c call_line){
        system.debug('== START populateDetailNasabah ==');
        Axa2_Json jsonUtil = new Axa2_Json();
        String servicingCD;
        
        //get data customer
        system.debug('== START get data customer ==');
        EIPJson dataCustomerEIP;
        EIPJson dataAgentEIP;
        EIPJson dataPolicyEIP;
        EIPJson dataFundEIP;
        try{
            dataCustomerEIP = EIPConnector.getCustomerInfo(EIPConstant.OPERATION_CUST_PROFILE, contact.Entity__c, contact.PolicyApp__c, contact.Policy_No__c);
            servicingCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD;
            servicingCD = (servicingCD == null) ? '' : servicingCD.substring(9, 15);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        try{
            dataAgentEIP = EIPConnector.getAgentInfo(EIPConstant.OPERATION_AGENT_INFO, contact.Entity__c, contact.PolicyApp__c, servicingCD, null, true);
            setDataAgent(dataAgentEIP);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        try{
            // get Policy Details
            dataPolicyEIP = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_POLICY_DETAIL, contact.Entity__c, contact.PolicyApp__c, contact.policy_no__c);
            setDataPolicy(dataPolicyEIP);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        try{
            dataFundEIP  = EIPConnector.getFundDetail(EIPConstant.OPERATION_FUND,  contact.Entity__c, contact.PolicyApp__c, contact.Policy_No__c);
            setDataFund(dataFundEIP);
        }catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        return null;
    }
    
    public String replaceVariableQuestion(String question, Contact contact, call_line__c call_line){
        try{
            System.debug('=====================================');
            System.debug('================ question : '+question);
            System.debug('=====================================');
            Integer day;
            Integer month;
            Integer year;
            String signedDate;
            Decimal premium;
            System.debug('lumpsumAmount :'+lumpsumAmount);
            System.debug('');
            premium = (lumpsumAmount != null && !String.isBlank(lumpsumAmount)) ? (Decimal.valueOf(lumpsumAmount)+contact.Total_Premium__c) : (contact.WelcomeCall_Lump_Sum__c+contact.Total_Premium__c);
            if(tanggalPenandatanganan != null){
                day = Integer.valueOf(tanggalPenandatanganan.substring(6,8));
                month = Integer.valueOf(tanggalPenandatanganan.substring(4,6));
                year = Integer.valueOf(tanggalPenandatanganan.substring(0,4));
                DateTime myDate = DateTime.newInstance(year, month, day);
                myDate = myDate+1;
                signedDate = myDate.formatGmt('d MMMMMMMM yyyy');
            }
            if(strDay == 'Mon'){
                strDay = 'Senin';
            }
            else if(strDay == 'Tue'){
                strDay = 'Selasa';
            }
            else if(strDay == 'Wed'){
                strDay = 'Rabu';
            }
            else if(strDay == 'Thu'){
                strDay = 'Kamis';
            }
            else if(strDay == 'Fri'){
                strDay = 'Jumat';
            }
            
            question = question.replace('!Contact.Name', '<b>'+contact.name+'</b>');
            question = question.replace('!Contact.Phone', '<b>'+(contact.Phone==null? 'Tidak Tersedia' : contact.Phone)+'</b>');
            question = question.replace('!Contact.MobilePhone', '<b>'+(contact.MobilePhone==null? 'Tidak Tersedia' : contact.MobilePhone)+'</b>');
            question = question.replace('!Contact.Total_Premium__c', '<b>'+formatMoney(premium)+'</b>');
            question = question.replace('!Contact.WelcomeCall_Issued_Date__c', '<b>'+formatDateTime(contact.welcomecall_issued_date__c)+'</b>');
            question = question.replace('!Contact.Premium__c', '<b>'+formatMoney(contact.Premium__c)+'</b>');
            question = question.replace('!Contact.WelcomeCall_Status_Polis__c', '<b>'+contact.WelcomeCall_Status_Polis__c+'</b>');
            question = question.replace('!Contact.WelcomeCall_APE__c', '<b>'+formatMoney(contact.WelcomeCall_APE__c)+'</b>');
            question = question.replace('!Contact.WelcomeCall_Effective_Date__c', '<b>'+formatDateTime(contact.WelcomeCall_Effective_Date__c)+'</b>');
            question = question.replace('!Contact.WelcomeCall_Payment_Type__c', '<b>'+contact.WelcomeCall_Payment_Type_Name__c+'</b>');
            question = question.replace('!Contact.WelcomeCall_Payment_Type_Name__c', '<b>'+contact.WelcomeCall_Payment_Type_Name__c+'</b>');
            question = question.replace('!Contact.WelcomeCall_Status_Polis2__c', '<b>'+formatDateTime(contact.WelcomeCall_Status_Polis2__c)+'</b>');
            question = question.replace('!Contact.WelcomeCall_GenderName', '<b>'+contact.WelcomeCall_GenderName__c+'</b>');
            question = question.replace('!Contact.WelcomeCall_CurrencyName', '<b>'+contact.WelcomeCall_CurrencyName__c+'</b>');
            question = question.replace('!Contact.WelcomeCall_Product_Code_Plan__c', '<b>'+productSt.WelcomeCall_Product_Name__c+'</b>');
            question = question.replace('!WelcomeCall_Product.WelcomeCall_Product_Name__c', '<b>'+productSt.WelcomeCall_Product_Name__c+'</b>');
            
            question = question.replace('!Contact.Policy_No__c', '<b>'+contact.Policy_No__c+'</b>');
            question = question.replace('!Contact.Email', '<b>'+(contact.Email==null? 'Tidak Tersedia' : contact.Email)+'</b>');
            question = question.replace('!Call_Line.Owner', '<b>'+call_line.owner.name+'</b>');
            question = question.replace('!Call_Line.WelcomeCall_Cooling_Off__c', '<b>'+call_line.WelcomeCall_Cooling_Off__c+'</b>');
            question = question.replace('!Call_Line.WelcomeCall_Cooling_Off2__c', '<b>'+call_line.WelcomeCall_Cooling_Off2__c+'</b>');
            question = question.replace('!Call_Line__c.Owner', '<b>'+call_line.owner.name+'</b>');
            question = question.replace('!Time', '<b>'+getBagianHari()+'</b>');
            question = question.replace('DAY()', '<b>'+strDay+'</b>');
            question = question.replace('NOW()', '<b>'+strDt+'</b>');
            question = question.replace('!FundCD', '<b>'+fundNM+'</b>');
            question = question.replace('!FAName', '<b>'+faName+'</b>');
            question = question.replace('!TanggalPenandatanganan', '<b>'+signedDate+'</b>');
            
            question = question.replace('!VerifikasiData', getDataChangesInVerifikasiData(call_line.id, 'Verifikasi Data'));
            
            // Add Premium Payment Period MSW by Faizir (2021-01-19)
            // Mengambil nilai dari Product Plan nya. MSW5A berarti 5 Tahun, MSW10A berarti 10 Tahun
            question = question.replace('!Premium_Payment_Period_MSW','<b>'+(contact.WelcomeCall_Product_Code_Plan__c.length() == 5 ? contact.WelcomeCall_Product_Code_Plan__c.substring(3, 4) : contact.WelcomeCall_Product_Code_Plan__c.substring(3, 5))+'</b>');
            
            if(question.contains('!Coverage_Period_MSW')){
                // Add Label Add Coverage by Faizir (2021-01-19)
                // 5 Tahun berarti Coverage Period MSW5A = 10 Tahun
                // 10 Tahun berarti Coverage Period MSW10A = 15 Tahun
                Integer addCoverage = Integer.valueOf(Label.WelcomeCall_MSW_Add_Coverage);
                question = question.replace('!Coverage_Period_MSW','<b>'+(contact.WelcomeCall_Product_Code_Plan__c.length() == 5 ? String.valueOf(Integer.valueOf(contact.WelcomeCall_Product_Code_Plan__c.substring(3, 4))+addCoverage) : String.valueOf(Integer.valueOf(contact.WelcomeCall_Product_Code_Plan__c.substring(3, 5))+addCoverage))+'</b>');
            }
            
            if(question.contains('!Contact.Product_Type')){
                System.debug('Masuk Product Type');
                System.debug('isi = '+ contact.WelcomeCall_Product_Code_Plan__c);
                List<WelcomeCall_Product__c> products = [Select name, WelcomeCall_Product_Name__c, WelcomeCall_Type__c from WelcomeCall_Product__c where name =: contact.WelcomeCall_Product_Code_Plan__c and WelcomeCall_Fg_Active__c = true limit 1];
                String productType;
                if(products.size() > 0){
                    productType = products[0].WelcomeCall_Type__c;
                    if(productType == 'Murni Kesehatan'){
                        productType = 'Kesehatan';
                    }else if(productType == 'Tradisional' || productType == 'Traditional'){
                        productType = 'Asuransi Jiwa';
                    }else if(productType == 'Unit Link'){
                        productType = 'Asuransi Jiwa Unit Link';
                    }
                }
                question = question.replace('!Contact.Product_Type', '<b>'+productType+'</b>');
            }
            
            String dueDate;
            if(contact.WelcomeCall_Payment_Type_Name__c == 'Tahun'){
                dueDate = String.valueOf(getDay(contact.WelcomeCall_Effective_Date__c)) + ' ' +getMonth(contact.WelcomeCall_Effective_Date__c);
            }else if (contact.WelcomeCall_Payment_Type_Name__c != 'Tahun'){
                dueDate = String.valueOf(getDay(contact.WelcomeCall_Effective_Date__c));
            }
            
            question = question.replace('!Contact.WelcomeCall_Due_Date__c', '<b>'+dueDate+'</b>');

        } catch (Exception e){
            System.debug('===ERROR=== '+e.getMessage()+'in line '+e.getLineNumber());
        }
        
        return question;
    }
    
    /**
     * Dynamically get custom label value by custom label name
     */
    public String getCustomLabelValue(String customLabel){
        if(customLabel == ''){
            return '';
        }
        customLabel = customLabel.replace(' ','');
        customLabel = customLabel.remove(';');
        Component.Apex.OutputText output;
        output = new Component.Apex.OutputText();
        output.expressions.value = '{!$Label.' + customLabel + '}';
       return string.valueOf(output.value); 
    }
    /**
     * Delete Response by tab and Call line Id
     */
    public void deleteResponseByTabCLId(String tab, String callLineId){
        List<Survey_Response__c> responses = [Select id from Survey_Response__c where WelcomeCall_Tab__c =: tab and WelcomeCall_Call_Line__c =: callLineId];
        if(!responses.isEmpty()){
            System.debug('===Before Delete Response===');
            delete responses;
        }
    }
}