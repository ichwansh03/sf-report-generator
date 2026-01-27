public with sharing class PointVerifikasi {
    
    public Call_Line__c cLine {get;set;}
    
    public String jawabanNama {get;set;}
    public String jawabanDOB {get;set;}
    public String jawabanAlamat {get;set;}
    public String jawabanTelepon {get;set;}
    public String jawabanEmail {get;set;}
    public String jawabanAgentValidation {get;set;}
    public String jawabanUnderstandProduct {get;set;}
    public String jawabanEPolicy {get;set;}
    
    public Boolean showErrorNama {get;set;}
    public Boolean showErrorDOB {get;set;}
    public Boolean showErrorAlamat {get;set;}
    public Boolean showErrorTelepon {get;set;}
    public Boolean showErrorEmail {get;set;}
    public Boolean showErrorAgentValidation {get;set;}
    public Boolean showErrorUnderstandProduct {get;set;}
    public Boolean showErrorEPolicy {get;set;}
    
    public Boolean showRemarksNama {get;set;}
    public Boolean showRemarksDOB {get;set;}
    public Boolean showRemarksAlamat {get;set;}
    public Boolean showRemarksTelepon {get;set;}
    public Boolean showRemarksEmail {get;set;}
    public Boolean showRemarksAgentValidation {get;set;}
    public Boolean showRemarksUnderstandProduct {get;set;}
    public Boolean showRemarksEPolicy {get;set;}

    public List<SelectOption> getJawabanOptions() {
        List<SelectOption> jawabanOptions = new List<SelectOption>();
        jawabanOptions.add(new selectOption('','--None--'));
        jawabanOptions.add(new selectOption('Ya','Ya'));
        jawabanOptions.add(new selectOption('Tidak','Tidak'));
        return jawabanOptions;
    }

    public void updateFieldVisibility() {
        if(jawabanNama == 'Tidak'){
            showErrorNama = true;
            showRemarksNama = true;
        } else {
            showErrorNama = false;
            showRemarksNama = false;
        }
        
        if(jawabanDOB == 'Tidak'){
            showErrorDOB = true;
            showRemarksDOB = true;
        } else {
            showErrorDOB = false;
            showRemarksDOB = false;
        }
        
        if(jawabanAlamat == 'Tidak'){
            showErrorAlamat = true;
            showRemarksAlamat = true;
        } else {
            showErrorAlamat = false;
            showRemarksAlamat = false;
        }
        
        if(jawabanTelepon == 'Tidak'){
            showErrorTelepon = true;
            showRemarksTelepon = true;
        } else {
            showErrorTelepon = false;
            showRemarksTelepon = false;
        }
        
        if(jawabanEmail == 'Tidak'){
            showErrorEmail = true;
            showRemarksEmail = true;
        } else {
            showErrorEmail = false;
            showRemarksEmail = false;
        }
        
        if(jawabanAgentValidation == 'Tidak'){
            showErrorAgentValidation = true;
            showRemarksAgentValidation = true;
        } else {
            showErrorAgentValidation = false;
            showRemarksAgentValidation = false;
        }
        
        if(jawabanUnderstandProduct == 'Tidak'){
            showErrorUnderstandProduct = true;
            showRemarksUnderstandProduct = true;
        } else {
            showErrorUnderstandProduct = false;
            showRemarksUnderstandProduct = false;
        }
        
        if(jawabanEPolicy == 'Tidak'){
            showErrorEPolicy = true;
            showRemarksEPolicy = true;
        } else {
            showErrorEPolicy = false;
            showRemarksEPolicy = false;
        }
    }
    
    public PointVerifikasi() {
        cLine = [SELECT Id, Name, Error_Nama_PP_TT__c, Jawaban_Nama_PP_TT__c, Remarks_Nama_PP_TT__c, 
                 Error_DOB__c, Jawaban_DOB__c, Remarks_DOB__c, 
                 Error_Alamat__c, Jawaban_Alamat__c, Remarks_Alamat__c, 
                 Error_Telepon__c, Jawaban_Telepon__c, Remarks_Telepon__c, 
                 Error_Email__c, Jawaban_Email__c, Remarks_Email__c, 
                 Error_Agent_Validation__c, Jawaban_Agent_Validation__c, Remarks_Agent_Validation__c, 
                 Error_Understand_Product__c, Jawaban_Understand_Product__c, Remarks_Understand_Product__c, 
                 Error_ePolicy_Buku_Polis__c, Jawaban_ePolicy_Buku_Polis__c, Remarks_ePolicy_Buku_Polis__c, 
                 Call_Status_Config__c, Reason_Status_Config__c FROM Call_Line__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
    
    public PageReference save() {
        cLine.Error_Nama_PP_TT__c = cLine.Error_Nama_PP_TT__c;
        cLine.Jawaban_Nama_PP_TT__c = jawabanNama;
        cLine.Remarks_Nama_PP_TT__c = cLine.Remarks_Nama_PP_TT__c;
        
        cLine.Error_DOB__c = cLine.Error_DOB__c;
        cLine.Jawaban_DOB__c = jawabanDOB;
        cLine.Remarks_DOB__c = cLine.Remarks_DOB__c;
        
        cLine.Error_Alamat__c = cLine.Error_Alamat__c;
        cLine.Jawaban_Alamat__c = jawabanAlamat;
        cLine.Remarks_Alamat__c = cLine.Remarks_Alamat__c;
        
        cLine.Error_Telepon__c = cLine.Error_Telepon__c;
        cLine.Jawaban_Telepon__c = jawabanTelepon;
        cLine.Remarks_Telepon__c = cLine.Remarks_Telepon__c;
        
        cLine.Error_Email__c = cLine.Error_Email__c;
        cLine.Jawaban_Email__c = jawabanEmail;
        cLine.Remarks_Email__c = cLine.Remarks_Email__c;
        
        cLine.Error_Agent_Validation__c = cLine.Error_Agent_Validation__c;
        cLine.Jawaban_Agent_Validation__c = jawabanAgentValidation;
        cLine.Remarks_Agent_Validation__c = cLine.Remarks_Agent_Validation__c;
        
        cLine.Error_Understand_Product__c = cLine.Error_Understand_Product__c;
        cLine.Jawaban_Understand_Product__c = jawabanUnderstandProduct;
        cLine.Remarks_Understand_Product__c = cLine.Remarks_Understand_Product__c;
        
        cLine.Error_ePolicy_Buku_Polis__c = cLine.Error_ePolicy_Buku_Polis__c;
        cLine.Jawaban_ePolicy_Buku_Polis__c = jawabanEPolicy;
        cLine.Remarks_ePolicy_Buku_Polis__c = cLine.Remarks_ePolicy_Buku_Polis__c;
        
        update cLine;
        return new pagereference('/'+cLine.Id);
    }
    
    public PageReference cancel() {
        return new pagereference('/'+cLine.Id);
    }
    
}