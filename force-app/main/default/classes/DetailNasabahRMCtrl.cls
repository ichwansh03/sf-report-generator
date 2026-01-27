public class DetailNasabahRMCtrl {
    public DetailTask dTask {get;set;}
    private Boolean isIncludeRLS = false;
    private Contact ct = new Contact();
    private Call_line__c cl = new Call_line__c();
    
    public DetailNasabahRMCtrl(ApexPages.StandardController controller) {
        try {   
            cl = (Call_Line__c)controller.getRecord();
            cl = [Select id, name, contact__c, createddate, WelcomeCall_Days__c, WelcomeCall_Call_Line_Status__c from Call_Line__c where id =: cl.Id];
            ct =[Select id, name, policy_no__c, entity__c, policyApp__c, phone, Agent_Code__c ,
                         welcomecall_ape__c, welcomecall_issued_date__c, welcomecall_product_code_plan__c, email,
                         WelcomeCall_Payment_Type_Name__c, welcomecall_effective_date__c, MobilePhone,
                         Birthdate, Total_Premium__c, Freeze_Complaint_End_Date__c
                         from contact where id =: cl.Contact__c];
            EIPJson eip = EIPConnector.getPolicyDetails('Policy Details',ct.Entity__c, ct.PolicyApp__c,ct.policy_no__c);
            system.debug('insurancePolicy = '+eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0]);
            dTask =  new DetailTask(eip.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0]);

        }catch(EIPConnector.NoDataException e){
            system.debug(e.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Backend sedang offline.'));
        }catch(EIPConnector.EIPConnectorException e){
            system.debug('unexpected error');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }catch (exception E){
            System.debug('=== ERROR MESSAGE === '+E.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        
    }
    
    public void loadDataEip(){}
    
    public class DetailTask{
        public Date birthDate {get;set;}
        public Decimal totalPremium {get;set;}
        public Date dueDate {get;set;}

        public DetailTask(EIPJson.EIP_AgSa_InsurancePolicy insurancePolicy){
            system.debug('detail task started...'+ insurancePolicy.premiumAMT);
            totalPremium = CCCUtils.strToDec(insurancePolicy.premiumAMT);
            system.debug('total premium done');
            dueDate = CCCUtils.strToDate(insurancePolicy.policyDueDt,'yyyymmdd');
            system.debug('due date done');
            birthDate = CCCUtils.strToDate(insurancePolicy.hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT,'yyyymmdd');
            system.debug('birthDate done');
        }
    }
}