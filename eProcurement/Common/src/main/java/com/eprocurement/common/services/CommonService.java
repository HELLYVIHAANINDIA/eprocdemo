package com.eprocurement.common.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.conn.ssl.X509HostnameVerifier;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.SingleClientConnManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.cahoot.bean.CahootResponse;
import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daoimpl.HibernateQueryImpl;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.model.CommonListing;
import com.eprocurement.common.model.TblMailMessage;
import com.eprocurement.common.model.TblMarquee;
import com.eprocurement.common.model.TblTimezone;
import com.eprocurement.common.utility.SessionBean;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@Service
public class CommonService {

	
	@Autowired
	HibernateQueryImpl hibernateQueryImpl;
	@Autowired
	CommonDAO commonDAO;
	@Autowired
	HibernateQueryDao hibernateQueryDao;
	@Autowired
	ExceptionHandlerService exceptionHandlerService;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	@Value("#{etenderProperties['sql_dateformate_without_timestamp']}")
    private String sql_dateformate_without_timestamp;
	@Value("#{etenderProperties['client_dateformate']}")
    private String client_dateformate;
	@Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['default_offsettime']}")
    private String default_offsettime;
	
	public final static String SESSIONOBJECT = "sessionObject";
	
	public String setListingData(HttpServletRequest request) {
		// TODO Auto-generated method stub
			String whereClause =  getWhereClauseForSearchResultsDynamic(request);
			String actionItem = request.getParameter("actionItem");
			String commonAction = request.getParameter("commonAction");
                        String fromClause = request.getParameter("fromClause");
			String isHQL = request.getParameter("isHQL");
			String srnoCol = request.getParameter("srnoCol");
			String columnName = request.getParameter("columnName");
                        if(columnName.startsWith(",")){
				columnName = columnName.substring(1);
			}
			fromClause += whereClause;
			
			if(fromClause.indexOf("$sessionOfficerId") != -1){
				SessionBean sessionBean = (SessionBean) request.getSession().getAttribute(SESSIONOBJECT);
		        Integer officerId = Integer.parseInt(sessionBean.getOfficerId()+"");
				fromClause = fromClause.replaceAll("\\$sessionOfficerId", officerId+"");
			}
			
		    String[] cols =columnName.split(",");
		     
		    Map result = new HashMap();
		    int amount = 10;
		    int start = 0;
		    int col = 0;
		    String res="";
		 
		    String dir = "asc";
		    String sStart = request.getParameter("iDisplayStart");
		    String sAmount = request.getParameter("iDisplayLength");
		    //String sEcho = request.getParameter("sEcho");
		    String sCol = request.getParameter("iSortCol_0");
		    String sdir = request.getParameter("sSortDir_0");
		    
		    /*for(int i = 0; i <cols.length;i++){
			    engine = request.getParameter("sSearch_"+i);

		    }*/
		   /* engine = request.getParameter("sSearch_0");
		    browser = request.getParameter("sSearch_1");
		    platform = request.getParameter("sSearch_2");
		    version = request.getParameter("sSearch_3");
		    grade = request.getParameter("sSearch_4");
		     */
		    List<String> sArray = new ArrayList<String>();
		    for(int i = 0; i <cols.length;i++){
			    if(StringUtils.hasLength(request.getParameter("sSearch_"+i))) {
			        String sEngine = cols[i]+"  like '%" + request.getParameter("sSearch_"+i) + "%'";
			        sArray.add(sEngine);
			    }
		    }
		
		    String individualSearch = "";
		    if(sArray.size()==1){
		        individualSearch = sArray.get(0);
		    }else if(sArray.size()>1){
		        for(int i=0;i<sArray.size()-1;i++){
		            individualSearch += sArray.get(i)+ " and ";
		        }
		        individualSearch += sArray.get(sArray.size()-1);
		    }
		     
		    if (sStart != null) {
		        start = Integer.parseInt(sStart);
		        if (start < 0)
		            start = 0;
		    }
		    if (sAmount != null) {
		        amount = Integer.parseInt(sAmount);
		        if (amount < 10 || amount > 100)
		            amount = 10;
		    }
		    /*if (sEcho != null) {
		        echo = Integer.parseInt(sEcho);
		    }*/
		    if (sCol != null) {
		        col = Integer.parseInt(sCol);
		        if (col < 0)
		            col = 0;
		    }
		    if (sdir != null) {
		        if (!sdir.equals("asc"))
		            dir = "desc";
		    }
		    String colName = cols[col];
		    if(StringUtils.hasLength(srnoCol) && "1".equals(srnoCol) && col != 0){
		    	colName = cols[col-1];	// because due to sr no column index shift
		    }
		   
		    String total = "0";
		    try {
		       // String query = "SELECT count(*) FROM "+table;
		    	 String query = "SELECT count(1) as count "+fromClause;
		    	 Map<String,Object> map = new HashMap<String, Object>(); 
		    	 map.put("alias", "map");
		         List<Map<String,Object>> listMap = null;
		         if("1".equals(isHQL)){
		        	 listMap =commonDAO.executeSelect(query, map);
		         }else{
		        	 listMap = commonDAO.executeSqlSelect(query, map);
		         }
		         map = listMap.get(0);
		         total = map.get("count").toString();
		    }catch(Exception e){
		         
		    }
		    String totalAfterFilter = total;
		    //result.put("sEcho",echo); 
		 
		    try {
		        String searchSQL = "";
		        if(StringUtils.hasLength(commonAction)){
		        	commonAction ="'checkbox' as checkbox," ;
		        }
		        if(StringUtils.hasLength(srnoCol) && "1".equals(srnoCol)){
		        	srnoCol ="'1' as SrnoCol," ;
		        }else{
		        	srnoCol = "";
		        }
		        
		        if(StringUtils.hasLength(actionItem)){
		        	actionItem =",'actionitem' as actionitem " ;
		        }
		       // String sql = "SELECT 'checkbox' as checkbox,*,'actionitem' as actionitem FROM "+table;
		        columnName = columnName.replaceAll(",actionitem", "");
		        columnName = columnName.replaceAll("checkbox,", "");
		        String sql = "SELECT "+commonAction+srnoCol+columnName+actionItem+" "+fromClause;
		        String searchTerm = request.getParameter("sSearch");
		        String whereCls = "";
		        if(StringUtils.hasLength(searchTerm)){
			        whereCls = " and ( ";
			        boolean isFirstCol = false;
		        	for(int i = 0; i <cols.length;i++){
		        		if(!"checkbox".equalsIgnoreCase(cols[i]) && !"actionitem".equalsIgnoreCase(cols[i])){
		        			if(isFirstCol){
		        				whereCls += " or ";
		        			}
		        			if(cols[i].indexOf(" as ") != -1){
		        				String column =  cols[i].substring(0, cols[i].indexOf(" as ") +1);
		        				whereCls += column+"  like '%" + searchTerm + "%'";
		        			}else{
		        				whereCls += cols[i]+"  like '%" + searchTerm + "%'";
		        			}
		        			isFirstCol = true;
		        		}
				    } 	
		        	whereCls +=" ) ";
		        }
		        if(searchTerm!="" && individualSearch!=""){
		            searchSQL = whereCls + " and " + individualSearch;
		        }
		        else if(individualSearch!=""){
		            searchSQL = " where " + individualSearch;
		        }else if(searchTerm!=""){
		            searchSQL=whereCls;
		        }
		        sql += searchSQL;
		        
		        if(colName.indexOf(" as ") != -1){
		        	colName =  colName.substring(0, colName.indexOf(" as ") +1);
    			}
		        sql += " order by " + colName + " " + dir;
		        Map<String,Object> map = new HashMap<String,Object>();
		        if(!"-1".equals(sAmount)){
			        map.put("firstIndex", start);
			        map.put("maxResult", amount);
		        }
		        List list = null;
		        if(sql.indexOf("$userTimeZone") != -1){
		        	sql = sql.replaceAll("\\$userTimeZone",",'"+getUserTimeZone()+"'");
		        	sql = sql.replaceAll("\\$utcTimeZone",",'+00:00'");
		        }
		         if("1".equals(isHQL)){
		        	 list =commonDAO.executeSelect(sql, map);
		         }else{
		        	 list = commonDAO.executeSqlSelect(sql, map);
		         }
		        map = new HashMap<String, Object>(); 
		    	map.put("alias", "map");
		        String sql2 = "SELECT count(1) count  "+fromClause;
		        if (searchTerm != "") {
		            sql2 += searchSQL;
		            if(sql2.indexOf("$userTimeZone") != -1){
		            	sql2 = sql2.replaceAll("\\$userTimeZone",",'"+getUserTimeZone()+"'");
		            	sql2 = sql2.replaceAll("\\$utcTimeZone",",'+00:00'");
			        }
		            List<Map<String,Object>> listMap = null;
		            if("1".equals(isHQL)){
		            	listMap = commonDAO.executeSelect(sql2, map);
		            }else{
		            	listMap = commonDAO.executeSqlSelect(sql2, map);

		            }
			        map = listMap.get(0);
			         totalAfterFilter = map.get("count").toString();
		        }
		        result.put("iTotalRecords", total);
		        result.put("iTotalDisplayRecords", totalAfterFilter);
		        result.put("aaData", list);
		        res = new Gson().toJson(result);
		    } catch (Exception e) {
		    	exceptionHandlerService.writeLog(e);
		    }
			return res;
	}

	public String convertToGsonStr(Object obj){
		return new Gson().toJson(obj);
	}
	public List<CommonListing> getCommonListPageData(Integer listId) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("listingId", listId);
		List<CommonListing> list =  commonDAO.getListByRistrictions(CommonListing.class,map,null,null);
		return list;
	}

	public String getWhereClauseForSearchResultsDynamic(HttpServletRequest request){
		StringBuilder whereclause = new StringBuilder("");

		try{
			System.out.println(request.getParameter("jsonSearchCriteria"));
			String jsonSearchCriteria = request.getParameter("jsonSearchCriteria");
			if(jsonSearchCriteria == null || "".equals(jsonSearchCriteria)){
				return "";
			}
			
			JsonObject jObject = getJsonObject(jsonSearchCriteria);

			Set<Map.Entry<String, JsonElement>> entries = jObject.entrySet();//will return members of your object
			for (Map.Entry<String, JsonElement> entry: entries) {
				String value = jObject.get(entry.getKey()).getAsString();

				value = value.replace("[", "").replace("]", "");
			    String valueArray[] = value.replace("\"", "").split("~");

			    for(String condition : valueArray){
			    	if(condition != null && !"".equals(condition)){
				    	whereclause.append(" and ");
						whereclause.append(condition);
			    	}
				}
			}
			
			System.out.println(whereclause + "");
			
			return whereclause.toString();
		
		}catch(Exception e){
			exceptionHandlerService.writeLog(e);
			return null;
		}finally{
			whereclause = null;
		}
	}
	
	public JsonObject getJsonObject(String jsonStr){
		JsonParser parser = new JsonParser();
		JsonObject json = parser.parse(jsonStr).getAsJsonObject();
		return json; 
	}
	// Get utc date
	public Date getServerDateTime() {
		try{
			SimpleDateFormat dateFormatGmt = new SimpleDateFormat(sql_dateformate);
			dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT"));
			//Local time zone   
			SimpleDateFormat dateFormatLocal = new SimpleDateFormat(sql_dateformate);
			//Time in GMT
			return dateFormatLocal.parse( dateFormatGmt.format(new Date()));
		}catch(Exception e){
			return new Date();
		}
	}
	
/*	public Date convertStirngToDate1(String dateformat,String date) throws ParseException{
		if(StringUtils.hasLength(date)){
			Date returnDate = null;
			if(dateformat.contains(sql_dateformate)){
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateformat);
				simpleDateFormat.setTimeZone(TimeZone.getTimeZone("GMT"+getUserTimeZone()));
				returnDate = simpleDateFormat.parse(date);
			}else{
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateformat);
				returnDate = simpleDateFormat.parse(date);
			}
			return returnDate;
		}else{
			return null;
		}
	}
	public Date convertStirngToUTCDate(String dateformat,String date) throws ParseException{
		if(StringUtils.hasLength(date)){
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateformat);
			simpleDateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
			return simpleDateFormat.parse(date);
		}else{
			return null;
		}
	}*/

	/*// old
    public String convertToDBDate1(String dateFormate, String convertToFormate,String date) throws ParseException{
    	String returnData = "";
    	if(date != null && !date.isEmpty()){
    		Date cDate;
    		if(dateFormate.contains(sql_dateformate)){
    			cDate = convertStirngToUTCDate(dateFormate,date);
    		}else{
    			cDate = convertStirngToDate1(dateFormate,date);
    		}
	    	returnData = convertDateToString(convertToFormate, cDate);
    	}
    	return returnData;
	}*/
	public Date convertStirngToUTCDate(String fromDateformat,String date) throws ParseException{
		if(StringUtils.hasLength(date)){
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(fromDateformat);
			Date cDate = simpleDateFormat.parse(date);
			String sqlFormateDate = convertDateToString(sql_dateformate, cDate);
			String newDate = convertDateTimeZone(sqlFormateDate.toString(),getUserTimeZone(),"+00:00");
			simpleDateFormat = new SimpleDateFormat(sql_dateformate);
			return simpleDateFormat.parse(newDate);
		}else{
			return null;
		}
	}
	
	public Date convertStirngToUTCDateWithoutTimeStamp(String fromDateformat,String date) throws ParseException{
		if(StringUtils.hasLength(date)){
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(fromDateformat);
			Date cDate = simpleDateFormat.parse(date);
			String sqlFormateDate = convertDateToString(sql_dateformate_without_timestamp, cDate);
			String newDate = convertDateTimeZone(sqlFormateDate.toString(),getUserTimeZone(),"+00:00");
			simpleDateFormat = new SimpleDateFormat(sql_dateformate_without_timestamp);
			return simpleDateFormat.parse(newDate);
		}else{
			return null;
		}
	}
	
	public Date convertDateToUTCDate(Date cDate) throws ParseException{
			String sqlFormateDate = convertDateToString(sql_dateformate, cDate);
			String newDate = convertDateTimeZone(sqlFormateDate.toString(),getUserTimeZone(),"+00:00");
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(sql_dateformate);
			return simpleDateFormat.parse(newDate);
	}
	public Date convertDateToClientDate(Date cDate) throws ParseException{
		String sqlFormateDate = convertDateToString(sql_dateformate, cDate);
		String newDate = convertDateTimeZone(sqlFormateDate.toString(),"+00:00",getUserTimeZone());
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(sql_dateformate);
		return simpleDateFormat.parse(newDate);
    }
    public String convertToDBDate(String fromFormate, String toFormate,String date) throws ParseException{
    	String returnData = "";
    	Date cDate = null;
    	if(date != null && !date.isEmpty()){
    		if(fromFormate.contains(sql_dateformate)){
    			String newDate = convertDateTimeZone(date.toString(),"+00:00",getUserTimeZone());
    			cDate = convertStringToDate(fromFormate, newDate);
    		}else{
    			cDate = convertStringToDate(fromFormate,date);
    		}
    		//Date cDate = convertStringToDate(fromFormate,date);
    		if(toFormate.contains(sql_dateformate)){
    			String sqlFormateDate = convertDateToString(toFormate, cDate);
    			String newDate = convertDateTimeZone(sqlFormateDate.toString(),getUserTimeZone(),"+00:00");
    			cDate = convertStringToDate(toFormate, newDate);
    		}
    		returnData = convertDateToString(toFormate, cDate);
    	}
    	return returnData;
	}

	public String convertDateToString(String dateformat,Date date) throws ParseException{
		if(date != null){
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateformat);
			return simpleDateFormat.format(date);
		}else{
			return null;
		}
	}
	
	public Date convertStringToDate(String dateformat,String date) throws ParseException{
		if(date != null && !date.isEmpty()){
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateformat);
			return simpleDateFormat.parse(date);
		}else{
			return null;
		}
	}

	/**
	 * Final method for datetime with timezone
	 * @param dateformat
	 * @param date	// should be timestamp formate
	 * @return
	 * @throws ParseException
	 */
	public String convertSqlToClientDate(String dateformat,Date date) throws ParseException{
		if(date != null){
			String newDate = convertDateTimeZone(date.toString(),"+00:00",getUserTimeZone());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(sql_dateformate);
			Date newDateObj = simpleDateFormat.parse(newDate);
			SimpleDateFormat newSimpleDateFormat = new SimpleDateFormat(dateformat);
			String returnDate = newSimpleDateFormat.format(newDateObj);
			return returnDate;
		}else{
			return null;
		}
	}
	/**
	 * Final method for datetime with timezone
	 * @param dateformat
	 * @param date	// should be timestamp format
	 * @return
	 * @throws ParseException
	 */
	public String convertSqlToClientDate(String dateformat,String date) throws ParseException{
		if(date != null && !date.isEmpty()){
			String newDate = convertDateTimeZone(date.toString(),"+00:00",getUserTimeZone());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(sql_dateformate);
			Date newDateObj = simpleDateFormat.parse(newDate);
			//SimpleDateFormat newSimpleDateFormat = new SimpleDateFormat(client_dateformate_hhmm);
                        SimpleDateFormat newSimpleDateFormat = new SimpleDateFormat(dateformat);
			String returnDate = newSimpleDateFormat.format(newDateObj);
			return returnDate;
		}else{
			return null;
		}
	}
	/**
	 * Final method for datetime with timezone
	 * @param dateformat
	 * @param date	// should be timestamp format
	 * @return
	 * @throws ParseException
	 */
	public String convertDateTimeZone(String sqlFormatDate,String formTimeZone,String toTimeZone){
		Map<String,Object> column = new HashMap<String, Object>();
		column.put("sqlFormatDate", sqlFormatDate);
		column.put("formTimeZone", formTimeZone);
		column.put("toTimeZone", toTimeZone);
		List<Object[]> obj = commonDAO.executeSqlSelect("SELECT CONVERT_TZ(:sqlFormatDate,:formTimeZone,:toTimeZone)",column);
		return obj.get(0)+"";
	}

	public String getUserTimeZone() {
		String timeZoneOffset = default_offsettime;
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession session = attr.getRequest().getSession();
        if (session != null) {
        	SessionBean sessionBean = (SessionBean) session.getAttribute("sessionObject");
        	if(sessionBean != null) {
        		timeZoneOffset = sessionBean.getTimeZoneOffset();
        	}
        }
        return timeZoneOffset;
    }
	public Integer getSessionUserId(HttpServletRequest request) {
		HttpSession sesson = request.getSession();
		SessionBean sessionBean =  (SessionBean) sesson.getAttribute(SESSIONOBJECT);
		return sessionBean != null ? Integer.parseInt(sessionBean.getUserId()+"") : 0;
	}

	public int getSessionUserDetailId(HttpServletRequest request) {
		HttpSession sesson = request.getSession();
		SessionBean sessionBean =  (SessionBean) sesson.getAttribute(SESSIONOBJECT);
		return sessionBean != null ? sessionBean.getUserDetailId() : 0;
	}

	public int getSessionClientId(HttpServletRequest request) {
		HttpSession sesson = request.getSession();
		SessionBean sessionBean =  (SessionBean) sesson.getAttribute(SESSIONOBJECT);
		return sessionBean != null ? sessionBean.getUserDetailId() : 0;	
		}

	public Object getSessionUserTypeId(HttpServletRequest request) {
		HttpSession sesson = request.getSession();
		SessionBean sessionBean =  (SessionBean) sesson.getAttribute(SESSIONOBJECT);
		return sessionBean != null  ? sessionBean.getUserTypeId() : 0;
	}
	
	 public List<SelectItem> convert(List<Object[]> list) {
	        List<SelectItem> items = new ArrayList<SelectItem>();
	        if (list != null) {
	            for (Object[] objects : list) {
	                if (objects.length >= 2) {
	                    items.add(new SelectItem(objects[1], objects[0]));
	                }                
	            }
	        }
	        return items;
	}
	    
    public static String replaceSpecialChars(String data){
        return data.replaceAll("â€˜","&#0145;").replaceAll("â€™","&#0146;").replaceAll("â€œ","&#0147;").replaceAll("â€�","&#0148;").replaceAll("'","&#39;").replaceAll("\"","&#34;").replaceAll("Â¨","&#168;").replaceAll("Â´","&#180;").replaceAll("`","&#96;").replaceAll("â€¢","&#8226;").replaceAll("â€”","&#8212;").replaceAll("=","&#61;").replaceAll("-","&#45;").replaceAll("+","&#43;").replaceAll("\\","&#92;");
    }
    
    public static String reverseReplaceSpecialChars(String data){
    	return data.replace("%26", "&").replace("&amp;","&").replace("&#0145;","â€˜").replace("&#0146;","â€™").replace("&#0147;","â€œ").replace("&#0148;","â€�").replace("&#39;","'").replace("&#34;","\"").replace("&#168;","Â¨").replace("&#180;","Â´").replace("&#96;","`").replace("&#8226;","â€¢").replace("&#8212;","â€”").replace("&#61;","=").replace("&#45;","-").replace("&#43;","+").replace("&#xa;"," ").replace("&#xd;"," ").replace("&#x9;"," ").replace("&#92;","\\").replace("&times;","X").replace("&yen;", "¥").replace("&pound;", "£").replace("&quot;", "\"").replace("%26", "&");
    			//.replace("&lt;", "<").replace("&gt;", ">"); //commented this code because of CR:#29753 (Text not displayed proper)
    }

    @Transactional
	public List<Integer> getUserRoleByUserId(Long userId){
	 List<Object[]> list = null;
	 List<Integer> userRoles = new ArrayList<Integer>();
   	 Map<String, Object> var = new HashMap<String, Object>();
        var.put("userId",userId);
        StringBuilder query = new StringBuilder();
        query.append(" select tblUserRoleMapping.tblRoles.roleId,tblUserRoleMapping.tblRoles.roleId from TblUserRoleMapping tblUserRoleMapping    ")
        .append(" where tblUserRoleMapping.tblUserlogin.userId=:userId ");
        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        if(list!=null && !list.isEmpty()) {
        	for (Object[] object : list) {
        		userRoles.add((Integer)object[0]);
			}
        }
        return userRoles; 
	 }
	
	
	@Transactional
	public Set<Object[]> getLinkDetailsByRoleId(List<Integer> roleIds){
	 List<Object[]> list = null;
	 Set<Object[]> linkDtl = new HashSet<Object[]>();
	 Set<String> links = new HashSet<String>();
   	 Map<String, Object> var = new HashMap<String, Object>();
        var.put("roleIds",roleIds);
        StringBuilder query = new StringBuilder();
        query.append(" select tblLink.linkId,tblLink.link,tblLink.description from TblRoleLinkMapping tblRoleLinkMapping  inner join tblRoleLinkMapping.tblLink tblLink  ")
        .append(" where tblRoleLinkMapping.tblRoles.roleId in (:roleIds)");
        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        if(list!=null && !list.isEmpty()) {
        	for (Object[] object : list) {
        		linkDtl.add(object);
			}
        }
        return linkDtl; 
	 }
	
	/**
	 * 
	 * @return
	 * @throws Exception 
	 */
	public List<Object[]> getRoles() throws Exception{
			String query = "select roleId,roleName from TblRoles where isShown=1";
			List<Object[]> list = commonDAO.executeSelect(query, null);
	    	return list;
	}
	
	
	/**
	 * 
	 * @return
	 * @throws Exception 
	 */
	public List<Object[]> getBidderSectors() throws Exception{
			String query = "SELECT 	SectorMst_Pk,SecM_SectorName FROM sectormst_tbl ";
			List<Object[]> list = commonDAO.executeSqlSelect(query, null);
	    	return list;
	}
	
	
	public List<Map<String,String>> getApproveReject() throws Exception{
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		Map<String,String> approveRejectList= new HashMap<String, String>();
		approveRejectList.put("Approve","1");
		approveRejectList.put("Reject","2");
		list.add(approveRejectList);
    	return list;
}
	
	/**
	 * 
	 * @return
	 * @throws Exception 
	 */
	public List<Object[]> getCountries() throws Exception{
			String query = "select countryId,countryName from TblCountry  where countryId != 0 order by countryId";
			List<Object[]> list = commonDAO.executeSelect(query, null);
	    	return list;
	}
	
	public List<Object[]> getStates(int countryId) throws Exception{
		String query = "select stateId,stateName from TblState where tblCountry.countryId="+countryId +" order by stateName";
		List<Object[]> list = commonDAO.executeSelect(query, null);
    	return list;
   }
	
	public CahootResponse getCountry() {
		// String jsonInString = "";
		String jsonInString = getJson("https://demo.businessgateways.net/index.php?r=webservice/countrymst");
//		System.out.println(jsonInString);		
        CahootResponse jsonObjList = new Gson().fromJson(jsonInString, CahootResponse.class);		
		return jsonObjList;
	}

	public CahootResponse getState() {
		String jsonInString = getJson("https://demo.businessgateways.net/index.php?r=webservice/statemst");
//		System.out.println(jsonInString);
		 CahootResponse jsonObjList = new Gson().fromJson(jsonInString, CahootResponse.class);		
		return jsonObjList;
	}

	public CahootResponse getCity() {
		String jsonInString = getJson("https://demo.businessgateways.net/index.php?r=webservice/citymst");
//		System.out.println(jsonInString);
		CahootResponse jsonObjList = new Gson().fromJson(jsonInString, CahootResponse.class);
		return jsonObjList;
	}

	public String getJson(String url) {
		String returnStr = "";
		try {

			HostnameVerifier hostnameVerifier = org.apache.http.conn.ssl.SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER;
			DefaultHttpClient client = new DefaultHttpClient();

			SchemeRegistry registry = new SchemeRegistry();
			SSLSocketFactory socketFactory = SSLSocketFactory
					.getSocketFactory();
			socketFactory
					.setHostnameVerifier((X509HostnameVerifier) hostnameVerifier);
			registry.register(new Scheme("https", socketFactory, 443));
			SingleClientConnManager mgr = new SingleClientConnManager(
					client.getParams(), registry);
			DefaultHttpClient httpClient = new DefaultHttpClient(mgr,
					client.getParams());

			// Set verifier
			HttpsURLConnection.setDefaultHostnameVerifier(hostnameVerifier);

			// Example send http request
			HttpGet getRequest = new HttpGet(url);
			getRequest.addHeader("accept", "application/json");
			HttpResponse response = httpClient.execute(getRequest);

			if (response.getStatusLine().getStatusCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
						+ response.getStatusLine().getStatusCode());
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(
					(response.getEntity().getContent())));

			String output;
			while ((output = br.readLine()) != null) {
				returnStr = output;
			}
			httpClient.getConnectionManager().shutdown();

		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			exceptionHandlerService.writeLog(e);	
		} catch (IOException e) {
			// TODO Auto-generated catch block
			exceptionHandlerService.writeLog(e);	
		}
		return returnStr;
	}
	public void saveMarquee(TblMarquee tblMarquee) {
		// TODO Auto-generated method stub
		commonDAO.saveOrUpdate(tblMarquee);
	}
	// this method will be used for tender specific as well global note
	public List<TblMarquee> getTblMarquee(int tenderId,int processId,int marqueeTo) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("maxResults", 1);
		Map<String,Object> conditionMap = new HashMap<String, Object>();
		conditionMap.put("isActive", 1);
		conditionMap.put("tblProcess.processId", processId);
		conditionMap.put("tenderId", tenderId);	
		/*if(marqueeTo != 0){
			conditionMap.put("marqueeTo", marqueeTo);	
		}*/
		
		List<TblMarquee> tbl = commonDAO.findEntity(TblMarquee.class, "isActive",Operation_enum.EQ,1,"tblProcess.processId",Operation_enum.EQ,processId,"tenderId",Operation_enum.EQ,tenderId);
		return tbl;
	}

	public void deleteMarqueeById(Integer marqueeId) {
		commonDAO.executeUpdate("update TblMarquee set isActive=0 where marqueeId="+marqueeId, null);
	}
	
	/**
	 * 
	 * @param userId
	 * @return
	 */
	@Transactional
	public List<Object[]> getOfficerDtls(long userId){
		List<Object[]> officerDtls = new ArrayList<Object[]>();
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("userId",userId);
		officerDtls = hibernateQueryDao.createNewQuery("select tblOfficer.emailid,tblOfficer.officername,tbluserlogin.userId,tblOfficer.id from TblOfficer tblOfficer inner join tblOfficer.tblUserlogin tbluserlogin  where tbluserlogin.userId=:userId",var);
		return officerDtls;
	}
	
	/**
	 * 
	 * @param userId
	 * @return
	 */
	@Transactional
	public List<Object[]> getBidderDtls(long userId){
		List<Object[]> bidderDtls = new ArrayList<Object[]>();
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("userId",userId);
		bidderDtls = hibernateQueryDao.createNewQuery("select tblBidder.emailId,tblBidder.personName,tblBidder.companyName,tblBidder.cstatus,tbluserlogin.userId,tblCompany.companyid,tblBidder.bidderId,tblBidder.isEmailVerified from TblBidder tblBidder inner join tblBidder.tblUserlogin tbluserlogin inner join tblBidder.tblCompany tblCompany  where tbluserlogin.userId=:userId",var);	
		return bidderDtls;
	}
	
	/**
	 * 
	 * @param userId
	 * @param forgotPasswordHash
	 * @return
	 */
	@Transactional
	public int updateForgotPasswordHash(long userId,String forgotPasswordHash) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("userId", userId);
        parameters.put("forgotpwdHash", forgotPasswordHash);
        parameters.put("forgotpwdExpiryDate", getServerDateTime());
        String query = "update TblUserLogin set forgotpwdHash=:forgotpwdHash,forgotpwdExpiryDate=:forgotpwdExpiryDate  where userId=:userId";
        return commonDAO.executeUpdate(query, parameters);
    }
	
	
	/**
	 * 
	 * @param userId
	 * @param forgotPasswordHash
	 * @return
	 */
	@Transactional
	public int updateIsEmailVerified(long userId,String type) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        String query = "";
        if(type.equals("org")){
        	parameters.put("userId", (int)userId);
            query = "update TblDepartment tblDepartment set isEmailVerified=1 where tblDepartment.deptId=:userId";
        }else{
        	parameters.put("userId", userId);
            query = "update TblBidder set isEmailVerified=1 where tblUserlogin.userId=:userId";
        }
        return commonDAO.executeUpdate(query, parameters);
    }
	
	@Transactional
	public int updateLastLogin(long userId,Date lastLoginDateAndTime) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("userId", userId);
        parameters.put("lastLogin", lastLoginDateAndTime);
        String query = "update TblUserLogin set lastLogin=:lastLogin  where userId=:userId";
        return commonDAO.executeUpdate(query, parameters);
    }
	
	
	@Transactional
	public boolean resetPassword(long userId,String password) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("userId", userId);
        parameters.put("password", password);
        parameters.put("forgotpwdHash", null);
        parameters.put("forgotpwdExpiryDate", null);
        String query = "update TblUserLogin set password=:password,forgotpwdHash=:forgotpwdHash,forgotpwdExpiryDate=:forgotpwdExpiryDate,isFirstLogin=0 where userId=:userId";
        return commonDAO.executeUpdate(query, parameters)!=0;
    }
	
	/**
	 * 
	 * @param userId
	 * @return
	 */
	@Transactional
	public List<Object[]> getUserLoginDetailById(long userId){
		List<Object[]> userLoginDtl = null;
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("userId",userId);
        userLoginDtl = hibernateQueryDao.createNewQuery("select tbluserlogin.userId,tbluserlogin.forgotpwdHash,tbluserlogin.forgotpwdExpiryDate,tbluserlogin.password from TblUserLogin tbluserlogin where tbluserlogin.userId=:userId",var);	
		return userLoginDtl;
	}
	

	@Transactional
	public String getDeptDetailByUserId(long officerId) throws Exception{
		StringBuilder deptDetail=new StringBuilder();
		List<Object[]> officerDtls = new ArrayList<Object[]>();
		List<Object[]> deptDtls = new ArrayList<Object[]>();
		Map<String, Object> var = new HashMap<String, Object>();
		Map<String, Object> deptVar = new HashMap<String, Object>();
        var.put("officerId",officerId);
		officerDtls = hibernateQueryDao.createNewQuery("select tblOfficer.emailid,tblOfficer.officername,tbluserlogin.userId,tblOfficer.id,tblOfficer.tblDepartment.deptId from TblOfficer tblOfficer inner join tblOfficer.tblUserlogin tbluserlogin  where tblOfficer.id=:officerId",var);
		if(officerDtls!=null && !officerDtls.isEmpty()){
			int deptId = (Integer)officerDtls.get(0)[4];
			deptVar.put("deptId", deptId);
			deptDtls = hibernateQueryDao.createNewQuery("select tblDepartment.grandParentDeptId,tblDepartment.parentDeptId,tblDepartment.deptId from TblDepartment tblDepartment where tblDepartment.deptId=:deptId",deptVar);
			if(deptDtls!=null && !deptDtls.isEmpty()){
				deptDetail.append(deptDtls.get(0)[0]).append(":").append(deptDtls.get(0)[1]).append(":").append(deptDtls.get(0)[2]);
			}
			
		}
		return deptDetail.toString();
	}
	
	public List<TblTimezone> getTimezoneList(Integer timezoneId) {
		Map<String,Object> map = new HashMap<String, Object>();
		if(timezoneId != 0){
			map.put("timezoneId", timezoneId);
		}
		return commonDAO.getListByRistrictions(TblTimezone.class,map,null,null);
	}
	
	@Transactional
	public String getCountryById(int countryId) {
		String country="";
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("countryId",countryId);
        List<Object[]> list = hibernateQueryDao.createNewQuery("select tblCountry.countryName,tblCountry.countryName from TblCountry tblCountry where tblCountry.countryId=:countryId",var);
        if(list!=null && !list.isEmpty()) {
        	country = list.get(0)[0].toString();
        }
		return country;
	}
	
	@Transactional
	public String getStateById(int stateId) {
		String state="";
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("stateId",stateId);
        List<Object[]> list = hibernateQueryDao.createNewQuery("select tblState.stateName,tblState.stateId from TblState tblState where tblState.stateId=:stateId",var);
        if(list!=null && !list.isEmpty()) {
        	state = list.get(0)[0].toString();
        }
		return state;
	}

	public List<Object[]> getCurrencyList(int currencyId) {
		String query = "select currencyId,currencyName from TblCurrency where isActive =1 ";
		if(currencyId != 0){
			query += " and  currencyId="+currencyId;	
		}
		List<Object[]> list = commonDAO.executeSelect(query, null);
    	return list;
	}
	@Transactional
	public String getTimeZonebyId(int timeZoneId) {
		String timeZone="";
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("timezoneId",timeZoneId);
        List<Object[]> list = hibernateQueryDao.createNewQuery("select tblTimezone.countryName,tblTimezone.utcOffset from TblTimezone tblTimezone where tblTimezone.timezoneId=:timezoneId",var);
        if(list!=null && !list.isEmpty()) {
        	timeZone = list.get(0)[0].toString()+" "+list.get(0)[1].toString();
        }
		return timeZone;
	}
	
	@Transactional
	public List<Integer> getDeptDetailByUserId(SessionBean sessionBean) throws Exception{
		List<Integer> deptDtlIds = new ArrayList<Integer>();
		List<Object[]> list = new ArrayList<Object[]>();
		if(sessionBean.getParentDeptId()==0 && sessionBean.getGrandParentDeptId()==0) {
			Map<String, Object> deptVar = new HashMap<String, Object>();
			deptVar.put("grandParentDeptId", sessionBean.getDeptId());
			list = hibernateQueryDao.createNewQuery("select tblDepartment.grandParentDeptId,tblDepartment.parentDeptId,tblDepartment.deptId from TblDepartment tblDepartment where tblDepartment.grandParentDeptId=:grandParentDeptId",deptVar);
			if(list!=null && !list.isEmpty()){
				for (Object[] objects : list) {
					deptDtlIds.add((Integer)objects[2]);
				}
			}
		}else if (sessionBean.getParentDeptId()==0 && sessionBean.getGrandParentDeptId()!=0) {
			Map<String, Object> deptVar = new HashMap<String, Object>();
			deptVar.put("grandParentDeptId", sessionBean.getGrandParentDeptId());
			deptVar.put("parentDeptId", sessionBean.getDeptId());
			list = hibernateQueryDao.createNewQuery("select tblDepartment.grandParentDeptId,tblDepartment.parentDeptId,tblDepartment.deptId from TblDepartment tblDepartment where tblDepartment.grandParentDeptId=:grandParentDeptId and tblDepartment.parentDeptId=:parentDeptId",deptVar);
			if(list!=null && !list.isEmpty()){
				for (Object[] objects : list) {
					deptDtlIds.add((Integer)objects[2]);
				}
			}
		}else if(sessionBean.getParentDeptId()!=0 && sessionBean.getGrandParentDeptId()!=0) {
			Map<String, Object> deptVar = new HashMap<String, Object>();
			deptVar.put("grandParentDeptId", sessionBean.getGrandParentDeptId());
			deptVar.put("parentDeptId", sessionBean.getParentDeptId());
			list = hibernateQueryDao.createNewQuery("select tblDepartment.grandParentDeptId,tblDepartment.parentDeptId,tblDepartment.deptId from TblDepartment tblDepartment where tblDepartment.grandParentDeptId=:grandParentDeptId and tblDepartment.parentDeptId=:parentDeptId",deptVar);
			if(list!=null && !list.isEmpty()){
				for (Object[] objects : list) {
					deptDtlIds.add((Integer)objects[2]);
				}
			}
			
		}
		int deptId = sessionBean.getDeptId();
		if(!deptDtlIds.contains(deptId)){
			deptDtlIds.add(deptId);
		}
		return deptDtlIds;
	}
	
	
	
	@Transactional
	public List<Integer> getDeptDetailByDeptIds(int grandParentId,int parentDeptId,int deptId) throws Exception{
		List<Integer> deptDtlIds = new ArrayList<Integer>();
		List<Object[]> list = new ArrayList<Object[]>();
		if(parentDeptId<1 && grandParentId!=0) {
			Map<String, Object> deptVar = new HashMap<String, Object>();
			deptVar.put("grandParentDeptId", grandParentId);
			list = hibernateQueryDao.createNewQuery("select tblDepartment.grandParentDeptId,tblDepartment.parentDeptId,tblDepartment.deptId from TblDepartment tblDepartment where tblDepartment.grandParentDeptId=:grandParentDeptId",deptVar);
			if(list!=null && !list.isEmpty()){
				for (Object[] objects : list) {
					deptDtlIds.add((Integer)objects[2]);
				}
			}
		}else if (parentDeptId!=0 && grandParentId!=0 && deptId<1) {
			Map<String, Object> deptVar = new HashMap<String, Object>();
			deptVar.put("grandParentDeptId",grandParentId);
			deptVar.put("parentDeptId",parentDeptId);
			list = hibernateQueryDao.createNewQuery("select tblDepartment.grandParentDeptId,tblDepartment.parentDeptId,tblDepartment.deptId from TblDepartment tblDepartment where tblDepartment.grandParentDeptId=:grandParentDeptId and tblDepartment.parentDeptId=:parentDeptId",deptVar);
			if(list!=null && !list.isEmpty()){
				for (Object[] objects : list) {
					deptDtlIds.add((Integer)objects[2]);
				}
			}
			}else if (parentDeptId>0 && grandParentId>0 && deptId>0) {
			Map<String, Object> deptVar = new HashMap<String, Object>();
			deptVar.put("grandParentDeptId", grandParentId);
			deptVar.put("parentDeptId", parentDeptId);
			deptVar.put("deptId", deptId);
			list = hibernateQueryDao.createNewQuery("select tblDepartment.grandParentDeptId,tblDepartment.parentDeptId,tblDepartment.deptId from TblDepartment tblDepartment where tblDepartment.grandParentDeptId=:grandParentDeptId and tblDepartment.parentDeptId=:parentDeptId and tblDepartment.deptId=:deptId",deptVar);
			if(list!=null && !list.isEmpty()){
				for (Object[] objects : list) {
					deptDtlIds.add((Integer)objects[2]);
				}
			}
			
		}
		if(!deptDtlIds.contains(deptId)){
			deptDtlIds.add(deptId);
		}
		if(!deptDtlIds.contains(parentDeptId)){
			deptDtlIds.add(parentDeptId);
		}
//		if(!deptDtlIds.contains(grandParentId)){
//			deptDtlIds.add(grandParentId);
//		}
		return deptDtlIds;
	}
	
	
	/**
	 * List to comma separated value
	 * @param list
	 * @return
	 */
	public String convertListToCommaseparated(List<Integer> list) {
		StringBuilder csvBuilder = new StringBuilder("");
		String SEPARATOR = ",";
		String response = "";
		if(list != null && !list.isEmpty()){
		  for(Integer obj : list){
		    csvBuilder.append(obj.toString());
		    csvBuilder.append(SEPARATOR);
		  }
		  response = csvBuilder.toString();
          if(response != null && !response.isEmpty()){
        	  response = response.substring(0, response.length()-1);
          }
		}
		return response;
	}
	
	 /**
	  * Department by id
	  * @param departmentId
	  * @return
	  */
	public List<Object[]> getDepartmentById(int departmentId) {
	        StringBuilder query = new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        query.append("select deptId,deptName,isEmailVerified from TblDepartment where 1=1");
	        if(departmentId != 0){
	        	var.put("deptId", departmentId);
		        query.append(" and deptId=:deptId");
	        }
	        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
	        return data;
	}

	public List<Object[]> getCurrencyMapList(Integer departmentId) {
		StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("departmentId", departmentId);
        query.append("select currencyId,departmentId from TblCurrencyMap where departmentId=:departmentId");
        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
        return data;
	}

	public List<TblMailMessage> getTblMailMessage() throws Exception {
		return commonDAO.findEntity(TblMailMessage.class, "mailSent",Operation_enum.EQ,0);
	}
	
	public boolean updateTblMailMessage(String mailmessageid) {
        String query = "UPDATE TblMailMessage SET mailSent = 1 WHERE mailmessageid IN ("+mailmessageid+")";
		return  commonDAO.executeUpdate(query, null)!=0;
	}
	
	
}