global class TabTaskListCtrl {
    public Id clId {get; set;}
    public String productCode {get; set;}
    private static String PRODUCT_TYPE_SYARIAH = 'SYARIAH';
    private static String PRODUCT_TYPE_KONVENSIONAL = 'KONVENSIONAL';
    private static String TAB_SESI_PERTANYAAN = 'Sesi Pertanyaan';
    private static String TAB_SESI_INFORMASI = 'Sesi Informasi Produk dan Pertanyaan Pelayanan FA';
    //private static String TAB_SURVEY = 'Survey';
    private static String TAB_INFORMASI_PRODUCT = 'Informasi Product';
    private static String TAB_PRODUCT = 'Product';
    private static String TAB_DETAIL_PRODUCT = 'Detail Product';
    //private static String TAB_KONFIRMASI = 'Konfirmasi ke FA';

    public TabTaskListCtrl(ApexPages.StandardController controller){
       clId = controller.getId();
    }
    
    public void createNewSurveyTakerbyCL(){
        Call_line__c cl = [Select id, name, Case_Type__c, contact__c, ownerid, Product__c, Formula_Product__c from call_line__c where id =: clId];
        System.debug('CL '+cl);
        List<SurveyTaker__c> svTaker = [Select id from SurveyTaker__c where (WelcomeCall_CallLine__c =: cl.Id OR Call_Line_Survey__c =: cl.Id)];
        System.debug('svTaker '+svTaker);
        if(svTaker.isEmpty()){
            SurveyTaker__c svT = new SurveyTaker__c();
            svT.OwnerId = userinfo.getUserId();
            svt.Contact__c = cl.Contact__c;
            if (cl.Case_Type__c != null && cl.Case_Type__c == 'Welcome Call') {
                svt.WelcomeCall_CallLine__c = cl.Id;
            } else {
                svt.Call_Line_Survey__c = cl.Id;
            }
            svt.User__c = svT.OwnerId;
            
            insert svt;
            System.debug('=== succeed create new survey taker for call line ==='+cl.Name);
        }
        productCode = cl.Formula_Product__c;
    }
    
    @RemoteAction
    global static List<WelcomeCall_Script__c> getTabsTaskList(String productCode){
        // get product detail
        List<WelcomeCall_Script__c> tabsName = new List<WelcomeCall_Script__c>();
        List<WelcomeCall_Product__c> products = [Select name, WelcomeCall_Product_Name__c, WelcomeCall_Product_Group__c from WelcomeCall_Product__c where name =: productCode and WelcomeCall_Fg_Active__c = true];
        if(products.size() > 0){
            String productType = products[0].WelcomeCall_Product_Group__c;
        
            List<aggregateResult> values = [select  COUNT_DISTINCT(id), WelcomeCall_Order__c urut, WelcomeCall_Tab_Name__c tabs from WelcomeCall_Script__c 
                                            where WelcomeCall_Tab_Name__c != null
                                            group by WelcomeCall_Order__c, WelcomeCall_Tab_Name__c order by WelcomeCall_Order__c, WelcomeCall_Tab_Name__c ];
            System.debug('values '+values);
            for(AggregateResult value : values){
                WelcomeCall_Script__c tab = new WelcomeCall_Script__c();
                tab.WelcomeCall_Tab_Name__c = String.valueOf(value.get('tabs'));
                system.debug(tab.WelcomeCall_Tab_Name__c);
                // check for syariah and konven by Catur 26-11-2019
                if(((tab.WelcomeCall_Tab_Name__c.equals(TAB_SESI_PERTANYAAN)  || tab.WelcomeCall_Tab_Name__c.equals(TAB_PRODUCT)) && productType.equals(PRODUCT_TYPE_SYARIAH)) || ((tab.WelcomeCall_Tab_Name__c.equals(TAB_SESI_PERTANYAAN) || tab.WelcomeCall_Tab_Name__c.equals(TAB_PRODUCT)) && productType.equals(PRODUCT_TYPE_KONVENSIONAL)))
                    continue;
                else
                    tabsName.add(tab);
               System.debug('tabs '+tab.WelcomeCall_Tab_Name__c);
            }
        }
        return tabsName;
    }
}