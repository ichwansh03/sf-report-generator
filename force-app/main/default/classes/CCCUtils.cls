public with sharing class CCCUtils {


    public static string stripJsonNulls(string JsonString)
    {
        if(JsonString != null)      
        {
            JsonString = JsonString.replaceAll('\"[^\"]*\":null',''); //basic removeal of null values
            JsonString = JsonString.replaceAll(',{2,}', ','); //remove duplicate/multiple commas
            JsonString = JsonString.replace('{,', '{'); //prevent opening brace from having a comma after it
            JsonString = JsonString.replace(',}', '}'); //prevent closing brace from having a comma before it
            JsonString = JsonString.replace('[,', '['); //prevent opening bracket from having a comma after it
            JsonString = JsonString.replace(',]', ']'); //prevent closing bracket from having a comma before it
            
            //'"canBeIndividual":{}'
            JsonString = JsonString.replaceAll('\"[^\"]*\":\\{\\}',''); //basic removeal of null values
            JsonString = JsonString.replaceAll(',{2,}', ','); //remove duplicate/multiple commas
            JsonString = JsonString.replace('{,', '{'); //prevent opening brace from having a comma after it
            JsonString = JsonString.replace(',}', '}'); //prevent closing brace from having a comma before it
            JsonString = JsonString.replace('[,', '['); //prevent opening bracket from having a comma after it
            JsonString = JsonString.replace(',]', ']'); //prevent closing bracket from having a comma before it 
            
            //'"hasAccountDetailsIn":[]'
            JsonString = JsonString.replaceAll('\"[^\"]*\":\\[\\]',''); //basic removeal of null values  
            JsonString = JsonString.replaceAll(',[2,]', ','); //remove duplicate/multiple commas
            JsonString = JsonString.replaceAll(',{2,}', ','); //remove duplicate/multiple commas
            JsonString = JsonString.replace('{,', '{'); //prevent opening brace from having a comma after it
            JsonString = JsonString.replace(',}', '}'); //prevent closing brace from having a comma before it
            JsonString = JsonString.replace('[,', '['); //prevent opening bracket from having a comma after it
            JsonString = JsonString.replace(',]', ']'); //prevent closing bracket from having a comma before it  
            
            
            
        }   
        return JsonString;
    }
    
    public static string getStringDataOnMap(Map<String, Object> m, string keysets) 
    {
        system.debug ('=');
        system.debug ('====== GET KEYSET VALUE');
        system.debug ('====== KEYSETS Name  : ' + keysets );
        List<string> keysetList = keysets.split('::');
    
        Map<String, Object>  mTemp = new Map<String, Object>(); 
        string s='';
        integer i=0;
        for (string keyset : keysetList) {
            system.debug ('====== Keyset Value ' + keyset );
            if (i < keysetList.size()-1) {
                mTemp = new Map<String, Object>();
                try {
                    if (keyset.contains('[') ) {
                        integer index = integer.valueOf( keyset.substring(keyset.indexOf('[')+1, keyset.indexOf(']') ));
                        List<Object> tmpLo = (List<Object>) m.get(keyset.substring(0,keyset.indexOf('[')) );
                        mTemp = (Map<String, Object>) tmpLo[index];
                    }   
                    else {
       
                        boolean b = isCollection(m.get(keyset));
       
                        if (b) {
                            List<Object> tmpLo = (List<Object>) m.get(keyset);
                            mTemp = (Map<String, Object>) tmpLo[0];
                        }
                        else {
                            mTemp = (Map<String, Object>) m.get(keyset);
                        }
  
                    }
                } catch (Exception e) {
                    system.debug ('== getStringDataOnMap ERROR get MAP Object (' + keyset + ') :' + e.getMessage());
  
                }
                m = mTemp;
            } 
            else {
                try {
            
                    if (m.containsKey(keyset)) {
                        s = (string) String.valueOf (m.get(keyset));
                        system.debug ('================ GET : ' + keyset + ' <-- ' + s);
                    
                    } else { 
                        system.debug ('== Keyset NOT found  : (' + keyset + ') ## Keysets : ' + keysets ); }
                    
                    
                    
                } catch (Exception e) {
                    system.debug ('================ getStringDataOnMap ERROR get MAP String (' + keyset + ') :' + e.getMessage());
                }
            }
            i++;
        }

        
        return s ; 
    }    
    
    public static List<Object> getListDataOnMap(Map<String, Object> m, string keysets) {
        system.debug ('=');
        system.debug ('====== GET LIST OBJECT');
        system.debug ('====== KEYSETS Name  : ' + keysets );
        
        List<string> keysetList = keysets.split('::');
    
        Map<String, Object>  mTemp = new Map<String, Object>(); 
        List<Object> lo = null;
        
        integer i=0;
        for (string keyset : keysetList) {
            
            if (i < keysetList.size()-1) {
                mTemp = new Map<String, Object>();
                try {
                    if (keyset.contains('[') ) {
                        system.debug('ini');
                        integer index = integer.valueOf( keyset.substring(keyset.indexOf('[')+1, keyset.indexOf(']') ));
                        
                        
                        List<Object> tmpLo = (List<Object>) m.get(keyset.substring(0,keyset.indexOf('[')) );
                        
                        
                        mTemp = (Map<String, Object>) tmpLo[index];
                        
                    }
                    else {
                        boolean b = isCollection(m.get(keyset));
                        
                        if (b) {
                            List<Object> tmpLo = (List<Object>) m.get(keyset);
                            mTemp = (Map<String, Object>) tmpLo[0];
                        }
                        else {
                            mTemp = (Map<String, Object>) m.get(keyset);
                        }
                    }
                } catch (Exception e) {
                    system.debug ('================ getListDataOnMap ERROR get MAP Object (' + keyset + ') :' + e.getMessage());
                }
                m = mTemp;
            } 
            else {
                try {
                    if (m.containsKey(keyset)) {
                   
                        lo = (List<Object>) m.get(keyset);
                        system.debug ('================ GET : ' + keyset + ' <-- ' + lo);
                    
                    } else {system.debug ('== Keyset NOT found  : (' + keyset + ') ## Keysets : ' + keysets ); }
                    
                } catch (Exception e) {
                    system.debug ('================ getListDataOnMap ERROR get MAP Object List (' + keyset + ') :' + e.getMessage());
                }
            }
            i++;
        }
        return lo ; 
    }
    
    public static Boolean isCollection(Object input)
    {
        object test;
        try{
           test = (List<Object>)input;
           return true;
        }
        catch(System.TypeException ex)
        {
            String message = ex.getMessage();
                         
            return false;
        }
        return false;
    }
    
    public static String printableDate(String s,String f){
        String dd;
        String mm;
        String yyyy;
        String d;
        if (f=='dd MMMM yyyy'){
            if (s != '' &&  s!=null && s != '00000000') {
                dd = s.substring(8,10);
                mm = s.substring(5,7);
                yyyy = s.substring(0,4);
                try {
                    if(mm.equals('01')) { mm = 'Januari'; }
                    if(mm.equals('02')) { mm = 'Februari'; }
                    if(mm.equals('03')) { mm = 'Maret'; }
                    if(mm.equals('04')) { mm = 'April'; }
                    if(mm.equals('05')) { mm = 'Mei'; }
                    if(mm.equals('06')) { mm = 'Juni'; }
                    if(mm.equals('07')) { mm = 'Juli'; }
                    if(mm.equals('08')) { mm = 'Agustus'; }
                    if(mm.equals('09')) { mm = 'September'; }
                    if(mm.equals('10')) { mm = 'Oktober'; }
                    if(mm.equals('11')) { mm = 'November'; }
                    if(mm.equals('12')) { mm = 'Desember'; }
                    d = dd + ' ' + mm + ' ' + yyyy;
                }
                catch(Exception e) {
                    d = null;
                    system.debug ('============= printableDate message1 : ' + e.getMessage() );
                }
            }
            else {
                dd = '01';
                mm = 'Januari';
                yyyy = '1900';
                d = null;
            }
        }
        return d;
    }
    
    public static Date strToDate(string s, string f){ 
        string dd;
        string mm;
        string yyyy;
        date d=null;
        
        s = s.trim();
        
        try {
            if (f==''){
                s = s.replaceAll('-','').replaceAll('/', '').replaceAll('\\.', '');
                f = 'yyyymmdd';
            }
                
            if (f=='yyyy-mm-dd'){
                s = s.replaceAll('-','');
                f = 'yyyymmdd';
            }
        
        
            if (f=='yyyymmdd'){
                if (s != '' &&  s!=null && s != '00000000') {
                    dd = s.substring(6,8);
                    mm = s.substring(4,6);
                    yyyy = s.substring(0,4);
                    try {
                        d = Date.newInstance(integer.valueOf(yyyy), integer.valueOf(mm), integer.valueOf(dd) );
                    }
                    catch(Exception e) {
                        d = null;
                        system.debug ('============= strToDate message1 = ' + e.getMessage() );
                    }
                }
                else {
                    dd = '01';
                    mm = '01';
                    yyyy = '1900';
                    d = null;
                }
            }
            if (f=='yyyy/mm/dd'){  ///persiapan !!!
                if (s != '' &&  s!=null) {
                    dd = s.substring(6,8);
                    mm = s.substring(4,6);
                    yyyy = s.substring(0,4);
                    try {
                        d = Date.newInstance(integer.valueOf(yyyy), integer.valueOf(mm), integer.valueOf(dd) );
                    }
                    catch(Exception e) {
                        d = null;
                        system.debug ('============= strToDate message1 : ' + e.getMessage() );
                    }
                }
                else {
                    dd = '01';
                    mm = '01';
                    yyyy = '1900';
                    d = null;
                }
            }
            if (f=='ddyyyymm'){
                if (s != '' &&  s!=null && s != '00000000') {
                    dd = s.substring(0,2);
                    mm = s.substring(6,8);
                    yyyy = s.substring(2,6);
                    try {
                        if(dd != '00'){
                            d = Date.newInstance(integer.valueOf(yyyy), integer.valueOf(mm), integer.valueOf(dd) );
                        } else {
                            d = Date.newInstance(integer.valueOf(yyyy), integer.valueOf(mm), 0 )+1;
                        }
                    }
                    catch(Exception e) {
                        d = null;
                        system.debug ('============= strToDate message1 : ' + e.getMessage() );
                    }
                }
                else {
                    dd = '01';
                    mm = '01';
                    yyyy = '1900';
                    d = null;
                }
            }
        }
        catch(Exception e) {
                    d = null;
                    system.debug ('============= strToDate message2 : ' + e.getMessage() );
                }
                
        return d;       
    } 
    
    
    
    public static DateTime strToDateTime (string s, string f){ 
        string dd;
        string mm;
        string yyyy;
        string hh;
        string nn;
        string ss;
        
        
        DateTime d=null;

        
        s = s.trim();
        
        try {
            if (f==''){
                s = s.replaceAll('-','').replaceAll('/', '').replaceAll('\\.', '');
                f = 'yyyymmdd';
            }
                
            if (f=='yyyy-mm-dd'){
                s = s.replaceAll('-','');
                f = 'yyyymmdd';
            }
            
            if (f=='yyyymmdd'){
                if (s != '' &&  s!=null) {
                    dd = s.substring(6,8);
                    mm = s.substring(4,6);
                    yyyy = s.substring(0,4);
                    try {
                        d = DateTime.newInstance(integer.valueOf(yyyy), integer.valueOf(mm), integer.valueOf(dd) );
                        //DateTime myDateTime = DateTime.newInstance(1997, 1, 31, 7, 8, 16)
                    }
                    catch(Exception e) {
                        d = null;
                        system.debug ('============= strToDateTime message1 : ' + e.getMessage() );
                    }
                }
                else {
                    dd = '01';
                    mm = '01';
                    yyyy = '1900';
                    d = null;
                }
            }
            else if (f=='yyyy-mm-dd hh:mm:ss') {
                if (s != '' &&  s!=null) {
                    yyyy = s.substring(0,4);
                    mm = s.substring(5,7);
                    dd = s.substring(8,10);
                    
                    hh = s.substring(11,13);
                    nn = s.substring(14,16);
                    ss = s.substring(17,19);
                    
                    system.debug('==full datetime : '+ s);
                    system.debug('==part of datetime : '+ yyyy + '::'+ mm + '::'+ dd + '::'+ hh + '::'+ nn + '::'+ ss + '::');
                    
                    
                    try {
                        d = Datetime.newInstance(integer.valueOf(yyyy), integer.valueOf(mm), integer.valueOf(dd), integer.valueOf(hh), integer.valueOf(nn), integer.valueOf(ss) );
                        system.debug('==test d1: '+ d);     
                    }
                    catch(Exception e) {
                        d = null;
                        system.debug ('============= strToDateTime message2 : ' + e.getMessage() );
                    }
                }
                else {
                    dd = '01';
                    mm = '01';
                    yyyy = '1900';
                    d = null;
                }
            }
            else if (f=='yyyymmddhhmmss') {
                if (s != '' &&  s!=null) {
                    yyyy = s.substring(0,4);
                    mm = s.substring(4,6);
                    dd = s.substring(6,8);
                    
                    hh = s.substring(8,10);
                    nn = s.substring(10,12);
                    ss = s.substring(12,14);
                    
                    system.debug('==full datetime : '+ s);
                    system.debug('==part of datetime : '+ yyyy + '::'+ mm + '::'+ dd + '::'+ hh + '::'+ nn + '::'+ ss + '::');
                    
                    
                    try {
                        d = Datetime.newInstance(integer.valueOf(yyyy), integer.valueOf(mm), integer.valueOf(dd), integer.valueOf(hh), integer.valueOf(nn), integer.valueOf(ss) );
                        system.debug('==test d1: '+ d);     
                    }
                    catch(Exception e) {
                        d = null;
                        system.debug ('============= strToDateTime message2 : ' + e.getMessage() );
                    }
                }
                else {
                    dd = '01';
                    mm = '01';
                    yyyy = '1900';
                    d = null;
                }
            }
        }
        catch(Exception e) {
                    d = null;
                }
        system.debug('==test d2: '+ d);     
        return d;       
    } 
    
    public static string birthToAge(Date birthDate){ 
        
        if (birthDate == null) return null;
        else {
            Age a = new Age(birthDate);
         
            return  a.years  + ' years';
        }
        
    }
    
    public class Age {
        public integer years ;
        public integer months ;
        public integer days ;
        
        public Age(Date birthDate){
        
            integer r = birthDate.daysBetween(Date.Today());
            
                    
            DateTime start_date_time;
            DateTime end_date_time;
             
            start_date_time = birthDate;
            end_date_time = Date.Today();
            
            Integer start_year_as_int = start_date_time.year(); //grab the start year
            Integer start_day_as_int = start_date_time.dayOfYear(); //grab the start day
            Integer start_hour_as_int = start_date_time.hour(); //grab the start hour
            Integer start_minute_as_int = start_date_time.minute(); //grab the start minute
            Integer start_second_as_int = start_date_time.second(); //grab the start second
            Integer start_in_seconds = (start_year_as_int * 31556926) + (start_day_as_int * 86400) + (start_hour_as_int * 3600) + (start_minute_as_int * 60) + (start_second_as_int * 1); //convert the start date to a value in seconds
            //there are 31556926 seconds in one year and that is why we are mutiplying the start_year_as_int value by 31556926 > this same logic applies to the days, hours & minutes logic which is why there are weird multipliers in that line of code
            Integer end_year_as_int = end_date_time.year(); //grab the end year
            Integer end_day_as_int = end_date_time.dayOfYear(); //grab the end day
            Integer end_hour_as_int = end_date_time.hour(); //grab the end hour
            Integer end_minute_as_int = end_date_time.minute(); //grab the end minute
            Integer end_second_as_int = end_date_time.second(); //grab the end second
            Integer end_in_seconds = (end_year_as_int * 31556926) + (end_day_as_int * 86400) + (end_hour_as_int * 3600) + (end_minute_as_int * 60) + (end_second_as_int * 1); //convert the end date to a value in seconds
            
            Integer total_duration_in_seconds = end_in_seconds - start_in_seconds; //duration in seconds
            Integer year_result = math.mod(math.floor(total_duration_in_seconds/31556926).intValue(),10000000); //number of years
            
            years = year_result;
            
             
        }
        
        //IF(ISNULL(DateofBirth__c),"",TEXT(FLOOR((TODAY()-DateofBirth__c)/365.2425)) & " year's " & TEXT(FLOOR(MOD((TODAY()-DateofBirth__c),365.2425)/30)) & " Month's " & Text(Floor(MOD(Floor(MOD((TODAY()-DateofBirth__c),365.2425)),30))) & " Day's ",
//NULL

    }
    
    public static decimal strToDec(string s){ 
        decimal d=null;
        s = s.trim();
        try {
            d = (s==null || s=='') ? null: (decimal) decimal.valueOf(s);
        }
        catch(Exception e) {
            d = null;
            system.debug ('============= strToDec message : ' + e.getMessage() );
        }
        return d;
    }   
    
    
    public static string getNewGUID() 
    {
        // Generate GUID
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        system.debug('========= guid :' + guid);
        
        return guid;
    }   

    public static string getUniqueNumber(){
        String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd'));
        Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
        String hexDigest = EncodingUtil.convertToHex(hash);
        system.debug('##########' + hexDigest );        
        return hexDigest;
    }
    
    public static string getSessionID() {
         return  UserInfo.getUserId() +'-' + Datetime.now().format('yyyyMMdd') +'-'+ CCCUtils.getUniqueNumber();
    }
    
    public class SecurityKeys {
        public String cypher {get; set;}
        public String userName {get; set;} 
        public String password {get; set;}
        public String token {get; set;}
        
        public SecurityKeys () {
            generate();
        }
        
        public void generate(){
            //function to randomize query result
            //Integer recCount = [SELECT COUNT() FROM Hashkey__c LIMIT 2000]; //limit 2000 to avoid OFFSET governor limit
            //Integer rand = Math.floor(Math.random()*recCount).intValue();
            //system.debug('integer random: ' +rand);
            //Hashkey__c hash = [SELECT Name, Username__c, Password__c, Cypher__c FROM Hashkey__c WHERE CreatedDate >= 2015-04-01T00:00:01Z LIMIT 1 OFFSET :rand]; //Live: 2015-05-01T00:00:01Z sandbox: 2015-03-10T00:00:01Z
            //system.debug('Query: '+hash);
            
            //cypher = hash.Cypher__c;
            //username = hash.Username__c;
            //password = hash.Password__c;
            
            //String gabungan =  username+'|'+password+'|'+cypher;
            //system.debug('Gabungan string: '+gabungan);
            //blob blobs = blob.valueof(gabungan);
            //blob md5Hash = Crypto.generateDigest('MD5', blobs); //convert to MD5
            //token = EncodingUtil.convertToHex(md5Hash).ToUpperCase(); //convert to Base16
        
            //system.debug('>>>> token: '+ token);
            
            //just for test TODO: CHANGE to real authentication 
            username = Label.EIP_Username;
            password = Label.EIP_Password;
            //password ='SFDCEIP123!';
            token ='Dummytoken-1234DMTM';
            system.debug('>>>> token: '+ token);
            //-------------------------------------------------
            
        }
    }
    
    
    public static List<Data_Load_Sequence__c> getDataLoadSequenceList(string source, string entity, string PolicyApp, string information, string pageName){
        
        List<Data_Load_Sequence__c> dataLoadSequenceList = null;
        
        if (source=='Backend') {
            if (PolicyApp=='BIS') dataLoadSequenceList =[Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,   IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and BIS__C=true and isDisplay__c = true and information__c =: information and page_Name__c =: pageName order by ORDER__c ];   
            else if (PolicyApp=='Clipper') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C, IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and Clipper__C=true and isDisplay__c = true and information__c =: information and page_Name__c =: pageName  order by ORDER__c ];
            else if (PolicyApp=='RLS') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C, IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and RLS__C=true and isDisplay__c = true and information__c =: information and page_Name__c =: pageName  order by ORDER__c ];
            else if (PolicyApp=='DMTM') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and DMTM__C=true and isDisplay__c = true and information__c =: information and page_Name__c =: pageName  order by ORDER__c ];
            else if (PolicyApp=='CARE') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and CARE__C=true and isDisplay__c = true and information__c =: information and page_Name__c =: pageName  order by ORDER__c ];
            else if (PolicyApp=='PSEA') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and PSEA__C=true and isDisplay__c = true and information__c =: information and page_Name__c =: pageName  order by ORDER__c ];
        }
        else if (source=='SFDC') {
            //dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,  IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
        }
        
        return dataLoadSequenceList;
    }
    
    public static integer getRowPerPage(string source, string entity, string PolicyApp, string information, string pageName){
        integer rowPerPage=0;
        
        system.debug ('== getRowPerPage');
        system.debug ('== source : ' + source);
        system.debug ('== entity : ' + entity);
        system.debug ('== PolicyApp : ' + PolicyApp);
        system.debug ('== information : ' + information);
        system.debug ('== pageName : ' + pageName);
        
        List<Data_Load_Sequence__c> dataLoadSequenceList = getDataLoadSequenceList(source, entity, PolicyApp, information, pageName);
        if (dataLoadSequenceList != null)
        {
            if (dataLoadSequenceList.size()>0){
                rowPerPage= integer.valueOf(dataLoadSequenceList[0].RowPerPage__c);
            }
        }
        system.debug ('== RowPerPage' + information + ' : ' + rowPerPage);
        
        return rowPerPage;
    }
    
    public static Map<String, Object> getMapPackageFromJSON (string jsonStr){
        Map<String, Object> mapWS = new Map<String, Object>();
            
        try {
            // deserializeUntyped to mapData
            Map<String, Object> mapData = (Map<String, Object>) JSON.deserializeUntyped(jsonStr); 
            String status= CCCUtils.getStringDataOnMap(mapData, 'Body::status');    
            String service = CCCUtils.getStringDataOnMap(mapData, 'Body::service');     
            String operation = CCCUtils.getStringDataOnMap(mapData, 'Body::operation');     
            String appID = CCCUtils.getStringDataOnMap(mapData, 'Body::appID');     
            String entity = CCCUtils.getStringDataOnMap(mapData, 'Body::entity');   
            String transactionId = CCCUtils.getStringDataOnMap(mapData, 'Body::transactionId');     
            String exceptionMessage ='';
            String exceptionBackEndError ='';
            String exceptionCode ='';
            
            
            if (status=='0') {
                  exceptionMessage = CCCUtils.getStringDataOnMap(mapData, 'Body::exception::message');
                  exceptionBackEndError = CCCUtils.getStringDataOnMap(mapData, 'Body::exception::backEndError');
                  exceptionCode = CCCUtils.getStringDataOnMap(mapData, 'Body::exception::code');
            }   
            
            
            mapWS.put('status', status);
            mapWS.put('exceptionMessage', exceptionMessage);
            mapWS.put('exceptionBackEndError', exceptionBackEndError);
            mapWS.put('exceptionCode', exceptionCode);
            mapWS.put('service', service);
            mapWS.put('operation', operation);
            mapWS.put('appID', appID);
            mapWS.put('entity', entity);
            mapWS.put('transactionId', transactionId);
            mapWS.put('mapData', mapData);  
            mapWS.put('jsonStr', jsonStr);      
        } 
        catch (Exception e) {
            mapWS.put('status', '-1');    // <<-- error on deserializeUntyped
            mapWS.put('mapData', 'null');
            mapWS.put('jsonStr', jsonStr);
            system.debug('============ error on try deserializeUntyped :' + e.getMessage());
        }
        
        return mapWS;
    }
    
    /*
    public static Integer GetSecondsElapsed(Time startTime, Time endTime) { 
        return GetElapsedTime(startTime, endTime).second();
    }    
    
    public static Time GetElapsedTime(Time startTime, Time endTime)
    {
        if(startTime == null || endTime == null)
            return Time.newInstance(0, 0, 0, 0);
    
        Integer elapsedHours = endTime.hour() - startTime.hour();
        Integer elapsedMinutes = endTime.minute() - startTime.minute();
        Integer elapsedSeconds = endTime.second() - startTime.second();
        Integer elapsedMiliseconds = endTime.millisecond() - startTime.millisecond();
    
        return Time.newInstance(elapsedHours, elapsedMinutes, elapsedSeconds, elapsedMiliseconds);
    }   
    
    public static Datetime getGMT(Datetime l)
    {    
        Date d = l.dateGmt();
        Time t = l.timeGmt();
         return Datetime.newInstance(d,t);
    }   
    
    */
    
    public static Datetime addHours(Datetime l, integer h)
    {    
         return l.addHours(h);
    }    
    
    public static decimal getDecimalOrNull (string value) {
        return  (value==null || value=='') ? null: (decimal) decimal.valueOf( value);               
    } 
    
    public static string getStringOrNull (string value) {
        return  (value==null) ? null: (string) value;               
    } 
    
    public static  List<Session_Data__c> addSessionDataToList (List<Session_Data__c> sessionDataList, string sessionID, string service, string operation, string classType, string refNo,
        string dataName, string dataTittle, string entity, string pageName, string sequenceNo, integer orderNo, string pageNo, string stringRespondData, string stringRequestData){  
        
        return addSessionDataToList(sessionDataList, sessionID, service, operation, classType, refNo, dataName, dataTittle, entity, pageName, sequenceNo, orderNo, pageNo, stringRespondData, stringRequestData, null);
                    
    }
    
    //TERUPDATE - nambahin parameter signatureData
    public static  List<Session_Data__c> addSessionDataToList (List<Session_Data__c> sessionDataList, string sessionID, string service, string operation, string classType, string refNo,
        string dataName, string dataTittle, string entity, string pageName, string sequenceNo, integer orderNo, string pageNo, string stringRespondData, string stringRequestData, string signatureData){
        //List<Session_Data__c> sessionDataList = new List<Session_Data__c>();
        
        if(stringRespondData != null && stringRespondData.length() < 70000){
            Session_Data__c sessionData = new Session_Data__c();

            //session_id : contactID-userid-yyymmdd-generatenumber
            sessionData.session_id__c = sessionID; 
            sessionData.service__c = service; 
            sessionData.operation__c = operation; 
            sessionData.classtype__c = classType; 
            sessionData.refNo__c = refNo; 
            
            sessionData.data_name__c = dataName; //infoList[i].Information__c;
            sessionData.data_tittle__c = dataTittle; //infoList[i].Information__c;
            sessionData.Entity__c = entity; //infoList[i].ENTITY__C;
            sessionData.page_name__c = pageName; //infoList[i].PAGE_NAME__C;
            sessionData.sequenceno__c = sequenceNo; //infoList[i].Sequence__c; 
            sessionData.order__c = orderNo; //infoList[i].ORDER__c;
            sessionData.Page_No__c = pageNo;
            sessionData.data__c = stringRespondData; //respond;
            sessionData.data_request__c = stringRequestData; //request
            sessionData.signature_data__c = signatureData;
            sessionDataList.add(sessionData);
        }
        
        return sessionDataList;
                    
    }
    
    
    public static void debugDataLoad(string mode, string service, string operation, string entity, string policyApp, Datetime dtStart, Datetime dtEnd  ){
        
        if (mode=='start'){
            system.debug ('.');system.debug ('.');system.debug ('.');
            //DateTime dtStart = DateTime.now();
            system.debug ('######################################## DATA LOAD ########################################');
            system.debug ('================== Service    : ' + service);
            system.debug ('================== Operation  : ' + operation);
            system.debug ('================== Entity     : ' + entity );
            system.debug ('================== App        : ' + policyApp );
            system.debug ('================== Starting   : ' + dtStart + ' ('+ dtStart.addHours(7)+')' );
            system.debug ('.');
        }       
        else if (mode=='end'){
            //DateTime dtEnd = DateTime.now();
            long d =  dtEnd.getTime() - dtStart.getTime() ;
            system.debug ('============ Starting at         : ' + dtStart + ' ('+ dtStart.addHours(7) +')' );
            system.debug ('============ End at              : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')' );
            system.debug ('============ Data Load Duration  : ' + d + ' milliseconds' );
            system.debug ('.');
            system.debug ('.');   
        }
    }
    
    
    public static boolean isNoDataError (string errCode){
        return label.WS_NoData_ErrCode.contains(errCode);
    }
    
    public static ID getRecordTypeCaseId(String Recordtype){
        return Schema.SObjectType.Case.getRecordTypeInfosByName().get(Recordtype).getRecordTypeId();
    }
    
    public static ID getContactIdByPolicyNo(String policyNo, String entity){
        String query = '';
        if(String.isEmpty(policyNo)){
            String policyNoNumeric = 'Non Customer '+entity.toUpperCase();
            query = 'Select Id from Contact where Policy_No_Numeric__c = \''+policyNoNumeric+'\' limit 1';
        }else{
            query = 'Select Id from Contact where Policy_No__c = \''+policyNo+'\' and entity__c = \''+entity + '\' limit 1';
        }
        system.debug('query : '+query);
        List<Contact> contact = Database.query(query);
        if(contact.size() > 0) {
            return contact[0].ID;
        } else {
            return null;
        }
    }
    
    public static String getCaseNumberByCaseId(ID caseId){
        system.debug('starting get case number with ID : '+ caseId);
        List<Case> cases = [Select CaseNumber from Case where Id =: caseId];
        if(cases.size() > 0){
            System.debug('case number : '+cases[0].caseNumber);
            return cases[0].caseNumber;
        }else{
            return null;
        }
    }
    
    public static String renderLineSpaceToHtml(String content){
        if(String.isNotBlank(content)){
            content = content.trim();
            content = content.replaceAll('\\n','<br/>').replace(' ','&nbsp;');
        }
        return content;
    }
}