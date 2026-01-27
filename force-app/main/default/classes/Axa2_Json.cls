/***
 * COPYRIGHT : #YANUAR PRIBADI
 * Path in this class using dot-notation, i.e: RetrievePolicyChangeTransactionDetailsResponse.RLSPolicy.policyTransactions
 * Location is single part of path, i.e: RetrievePolicyChangeTransactionDetailsResponse
 * 
 * Prerequisites:
 * - This parser does not check json validity
 **/

public class Axa2_Json
{
    // constants
    private static final String TYPE_MAP = 'Map';
    private static final String TYPE_LIST = 'List';
    private static final String TYPE_STRING = 'String';
    private static final String CHAR_DOT = '.';
    private static final String REGEX_DOT = '\\.';
    
    // data members
	protected Object m_json;

	/*** CONSTRUCTOR ***/
    public Axa2_Json()
    {
        m_json = null;
    }
    public Axa2_Json(String data)
    {
        setData(data);
    }

    /*** MEMBER FUNCTIONS ***/
    
    public Object getData()
    {
        return m_json;
    }
    public Object getData(String path)
    {
        return getData(m_json, path);
    }
    public Object getData(Object json, String path)
    {
        //System.debug('getData(Object json, String path)');
        if (path == null)
            return json;
        else if (path.trim() == '')
            return json;
        
        List<String> lstLoc = path.split(REGEX_DOT);
        
        Object objJson = json;
        Integer idx = 0;
        Boolean isValid = true;
        String sLoc;
        
        while (isValid)
        {
            //System.debug('objJson: ' + objJson);
            //System.debug('idx: ' + idx + ', lstLoc[idx]: ' + lstLoc[idx]);
            
            sLoc = lstLoc[idx];
            idx++;
            objJson = getLocation(objJson, sLoc);
            
            if (objJson == null || idx == lstLoc.size())
                isValid = false;
        }
        
        return objJson;
    }
    
    public void setData(String data)
    {
        if (data == null)
        {
            m_json = null;
            return;
        }
        if (data.trim() == '')
        {
            m_json = null;
            return;
        }
        
        try
        {
        	m_json = JSON.deserializeUntyped(data);
        }
        catch(Exception e)
        {
            System.debug('*** [' + e.getLineNumber() + '] ' + e.getMessage());
            m_json = null;
        }
    }
    public void setData(Object json, String path)
    {
        m_json = getData(json, path);
    }
    
    public void setPath(String path)
    {
        m_json = getData(m_json, path);
    }
    public Object getLocation(String loc)
    {
        return getLocation(m_json, loc);
    }
    public Object getLocation(Object json, String loc)
    {
        if (loc == null)
            return null;
        if (loc.trim() == '')
            return null;
        
        String sLoc;
        if (loc.contains(CHAR_DOT))
            // prevents error if location supplied with path
            sLoc = loc.split(REGEX_DOT)[0];
        else
            sLoc = loc;
        //System.debug('loc: ' + sLoc);
        
        if (isMapType(json))
        {
            Map<String,Object> mapJson = (Map<String,Object>) json;
            //System.debug('mapJson.found: ' + mapJson.containsKey(sLoc));
            if (mapJson.containsKey(sLoc))
                return mapJson.get(sLoc);
            else
                System.debug('*** mapJson: Loc not found. (' + sLoc + ')');
        }
        else if (isListType(json))
        {
            //System.debug('lstJson.found: ' + sLoc);
            if (sLoc.isNumeric())
            {
            	List<Object> lstJson = (List<Object>) json;
                Integer idx = Integer.valueOf(sLoc);
                //System.debug('lstJson.idx/size: ' + idx + '/' + lstJson.size());
                
                if (lstJson.size() > idx)
                	return lstJson[idx];
                else
                    System.debug('*** lstJson: Loc offset. (' + lstJson.size() + '/' + idx + ')');
            }
            else
                System.debug('*** lstJson: Loc is not numeric. (' + sLoc + ')');
        }
        
        /***
         * conditions at this state:
         * - json is null
         * - mapJson have no current key
         * - lstJson have no current index
         **/
        return null;
    }
    
    public override String toString()
    {
        return JSON.serialize(m_json);
    }
    
    /*** SUPPORT FUNCTIONS ***/
    
    public static Boolean isMapType(Object obj)
    {
        return (getTypeShort(obj) == TYPE_MAP ? true : false);
    }
    public static Boolean isListType(Object obj)
    {
        return (getTypeShort(obj) == TYPE_LIST ? true : false);
    }
    
    /***
     * getType & getTypeShort
     * 	returns datatype of an object
     * i.e:
     * 	getType: Map<String,ANY>
     * 	getTypeShort: Map
     **/
    public static String getType(Object obj)
    {
        String sType = 'Datetime';
        try
        {
            Datetime typeCheck = (Datetime) obj;
        }
        catch(System.TypeException e)
        {
            //System.debug('err: ' + e.getMessage());
            String message = e.getMessage().substringAfter('Invalid conversion from runtime type ');
            sType = message.substringBefore(' to ' + sType);
        }
        
        return sType;
    }
    public static String getTypeShort(Object obj)
    {
        String sType = getType(obj);
        
        if (sType.contains('<'))
            return sType.substringBefore('<');
        return sType;
    }
}