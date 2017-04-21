
package com.eprocurement.etender.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.EncrptDecryptUtils;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.common.utility.SpringMailSender;
import com.eprocurement.common.utility.VerifyRecaptcha;
import com.eprocurement.etender.databean.TblLinksRolesDataBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblBidderSectorMapping;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblCountry;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblDesignation;
import com.eprocurement.etender.model.TblLink;
import com.eprocurement.etender.model.TblOfficer;
import com.eprocurement.etender.model.TblRoleLinkMapping;
import com.eprocurement.etender.model.TblRoles;
import com.eprocurement.etender.model.TblState;
import com.eprocurement.etender.model.TblUserLogin;
import com.eprocurement.etender.model.TblUserRoleMapping;
import com.eprocurement.etender.services.OfficerService;
@Controller
public class OfficerController {

	@Autowired
    private ExceptionHandlerService exceptionHandlerService;
	@Autowired
    private OfficerService officerService;
	@Autowired
    private CommonService commonService;
		
	
	@Value("#{etenderProperties['msg_bidder_create_successfully']}")
    private String msg_bidder_create_successfully;
	@Value("#{etenderProperties['msg_bidder_edit_successfully']}")
    private String msg_bidder_edit_successfully;
	@Value("#{etenderProperties['msg_officer_create_successfully']}")
    private String msg_officer_create_successfully;
	@Value("#{etenderProperties['msg_bidder_create_successfully']}")
    private String msg_officer_edit_successfully;
	@Value("#{projectProperties['bidderRegistrationObjectId']}")
    private String bidderRegistrationObjectId;
	@Value("#{projectProperties['tenderAuthorityRegistrationObjectId']}")
    private Integer tenderAuthorityRegistrationObjectId;
	@Value("#{projectProperties['isProductionServer']}")
    private Boolean isProductionServer;
	@Autowired
    private MessageSource messageSource;
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
    @Value("#{etenderProperties['client_dateformate']}")
    private String client_dateformate;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	@Autowired
	private SpringMailSender mailSender;
	@Autowired
    private EncrptDecryptUtils encrptDecryptUtils;
	@Value("#{projectProperties['stagingurl']}")
    private String stagingurl;
	@Value("#{projectProperties['registrationkey']}")
    private String registrationkey;
	@Value("#{projectProperties['passwordkey']}")
    private String passwordkey;
	@Value("#{projectProperties['mail.from']}")
    private String mailFrom;
	
	private static String BIDDERSTATUSCHANGE="Bidder status change";
	private static String BIDDERID="bidderId";
	

    @ResponseBody
    @RequestMapping(value = "/common/user/getNotificationCount/{userId}/{tenderId}", method = RequestMethod.GET)
    public String getNotificationCount(@PathVariable("userId") Integer userId,@PathVariable("tenderId") Integer tenderId) {
	    String jsonStr = "";
		try {
			    List<Map<String,Object>> obj = officerService.getNotificaitonCount(userId,tenderId);
			    jsonStr = commonService.convertToGsonStr(obj);
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
	return jsonStr;
    }
    
    /**
     * 
     * @param searchParam
     * @param level
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/getCategoryData/{level}")
    public String getCategoryData(HttpServletRequest request,@PathVariable("level") String level) {
	    String jsonStr = "";
		try {	
				String searchParam = request.getParameter("term");
			    List<Object[]> obj = officerService.getCategoryData(searchParam,level);
			    jsonStr = commonService.convertToGsonStr(obj);
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
	return jsonStr;
    }
    /**
     * 
     * @param searchParam
     * @param level
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/getUNSPSCCategoryData")
    public String getUNSPSCCategoryData(HttpServletRequest request) {
	    String jsonStr = "";
		try {	
				String searchParam = request.getParameter("term");
				String dataFrom = request.getParameter("dataFrom");
			    List<Object[]> obj = officerService.getUNSPSCCategoryData(searchParam,dataFrom);
			    jsonStr = commonService.convertToGsonStr(obj);
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} finally {
		}
	return jsonStr;
    }

    @ResponseBody
    @RequestMapping(value = "/common/user/updateNotificationStatus/{userId}/{tenderId}", method = RequestMethod.GET)
    public String updateNotificationStatus(@PathVariable("userId") Integer userId,@PathVariable("tenderId") Integer tenderId) {
	    String returnStr = "";
		try {
			    returnStr = officerService.updateNotificationStatus(userId,tenderId);
			    if(OfficerService.notificationData.containsKey(userId+"_"+tenderId)){
			    	OfficerService.notificationData.remove(userId+"_"+tenderId);	
			    }
			    
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
	return returnStr;
    }
    
    @RequestMapping(value = "/common/user/currencyMapping/{departmentId}", method = RequestMethod.GET)
    public ModelAndView currencyMapping(@PathVariable("departmentId") Integer departmentId,HttpServletRequest request) {
	    ModelAndView modelAndView = null;
		try {
				modelAndView = new ModelAndView("/common/currencyMapping");
				SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
				if(sessionBean != null && sessionBean.getIsOrgenizationUser() == 1){
					List<Object[]> tblCurrencyList = commonService.getCurrencyList(0);
					List<Object[]> tblCurrencyMapList = commonService.getCurrencyMapList(departmentId);
					List<Object[]> deptList = commonService.getDepartmentById(departmentId);
					if(tblCurrencyMapList != null){
						Map<Integer,Integer> map = new HashMap<Integer, Integer>();
						for(Object[] obj : tblCurrencyMapList){
							map.put((Integer)obj[0], (Integer)obj[0]);
						}
						modelAndView.addObject("tblCurrencyMapList", map);
					}
					if(deptList != null){
						Map<Integer,String> map = new HashMap<Integer, String>();
						for(Object[] obj : deptList){
							map.put((Integer)obj[0], obj[1].toString());
						}
						modelAndView.addObject("departmentMap", map);
					}
					
					modelAndView.addObject("currencyList", tblCurrencyList);
					modelAndView.addObject("deptList", tblCurrencyList);
				}else{
					modelAndView = new ModelAndView("/sessionexpired");
				}
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
	return modelAndView ;
    }
    
    /**
     * 
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/common/user/updateCurrencyMapping", method = RequestMethod.POST)
    public ModelAndView currencyMapping(HttpServletRequest request,RedirectAttributes redirectAttributes) {
	    ModelAndView modelAndView = null;
		try {
				String deptId = request.getParameter("departmentId");
				Integer departmentId = Integer.parseInt(deptId);
				modelAndView = new ModelAndView("redirect:/common/user/currencyMapping/"+departmentId);	
				String[] currencyIds = request.getParameterValues("selCurrencyId");
				SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
				boolean response =  officerService.updateCurrencyMap(sessionBean,currencyIds,departmentId);
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_currencymapping_save");
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
		
	return modelAndView ;
    }
    
    
    @RequestMapping(value = "/common/user/notificationTab/{userId}/{tenderId}", method = RequestMethod.GET)
    public ModelAndView notificationTab(@PathVariable("userId") Integer userId,@PathVariable("tenderId") Integer tenderId) {
	   ModelAndView model = new ModelAndView("/common/NotificationTab");
	return model;
    }	
    /**
     * 
     * @param searchValue
     * @param keyword
     * @param modelMap
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/isdepartmentexist/{searchValue}/{keyword}", method = RequestMethod.POST)
    public String getIsDepartmentExists(@PathVariable("searchValue") String searchValue,@PathVariable("keyword") String keyword,ModelMap modelMap, HttpServletRequest request) {
	    boolean isExist = false;
	    String jsonStr = "[{";
		try {
				jsonStr=jsonStr+"\"isExists\":\""+isExist+"\"}]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
		
	return jsonStr;
    }
    
    
    
    @ResponseBody
    @RequestMapping(value = "/ajaxhit/common/user/isemailidexists/{searchValue}/", method = RequestMethod.POST)
    public String getIsEmailIdExists(@PathVariable("searchValue") String searchValue,ModelMap modelMap, HttpServletRequest request) {
	    boolean isExist = false;
	    String jsonStr = "[{";
		try {
				isExist=officerService.isEmailIdExists(searchValue);
				jsonStr=jsonStr+"\"isExists\":\""+isExist+"\"}]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
		
	return jsonStr;
    }
    
    
    @ResponseBody
    @RequestMapping(value = "/ajaxhit/common/user/iscompanyexists/{searchValue}/{type}", method = RequestMethod.POST)
    public String getIsCompanyExists(@PathVariable("searchValue") String searchValue,@PathVariable("type") String type,ModelMap modelMap, HttpServletRequest request) {
	    boolean isExist = false;
	    String jsonStr = "[{";
		try {
				isExist=officerService.isCompanyExists(searchValue,type);
				jsonStr=jsonStr+"\"isExists\":\""+isExist+"\"}]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
		
	return jsonStr;
    }
    
    
    @ResponseBody
    @RequestMapping(value = "/ajaxhit/common/user/iscompanyregnoexists/{searchValue}/{type}", method = RequestMethod.POST)
    public String getIsCompanyRegNoExists(@PathVariable("searchValue") String searchValue,@PathVariable("type") String type,ModelMap modelMap, HttpServletRequest request) {
	    boolean isExist = false;
	    String jsonStr = "[{";
		try {
				isExist=officerService.isCompanyRegNoExists(searchValue,type);
				jsonStr=jsonStr+"\"isExists\":\""+isExist+"\"}]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
		
	return jsonStr;
    }
    
    /**
     * 
     * @param searchValue
     * @param keyword
     * @param modelMap
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/getsubdepartments/{parentdeptid}", method = RequestMethod.POST)
    public String getSubDepartments(@PathVariable("parentdeptid") String parentdeptid,ModelMap modelMap, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
	    String jsonStr = "";
	    int parentdeptId = 0;
	    String deptLevel="";
    	try {
    		parentdeptId = Integer.parseInt(parentdeptid.split("@@")[0].toString());
    		deptLevel= parentdeptid.split("@@")[1];
				jsonStr = getSubDeptListJson(parentdeptId,deptLevel);
			    modelMap.addAttribute("tblDepartments", jsonStr);
			} catch (Exception ex) {
				ex.printStackTrace();
			     exceptionHandlerService.writeLog(ex);
			} 
		
	return jsonStr;
    }
    
    
    /**
     * 
     * @param searchValue
     * @param keyword
     * @param modelMap
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/getdesignationbydeptid/{deptid}", method = RequestMethod.POST)
    public String getDesignationByDeptId(@PathVariable("deptid") int deptid,ModelMap modelMap, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
	    String jsonStr = "";
    	try {
				jsonStr = getDesignationsByDeptId(deptid);
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
		
	return jsonStr;
    }
    

    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/getClientDateTime", method = RequestMethod.GET)
    public Long getClientDateTime(HttpServletRequest request) {
    Date date = null;
	try {
    	date = commonService.getServerDateTime();
    	date = commonService.convertDateToClientDate(date);
	}catch (Exception  ex) {
    exceptionHandlerService.writeLog(ex);
    }
	return date.getTime();
    }
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/getorganization", method = RequestMethod.GET)
    public String getOrganization(ModelMap modelMap, HttpServletRequest request) {
    String countryJson = "";	
    try {
    	countryJson=getContryJson();
		TblDepartment tblDepartment = new TblDepartment();
		int randNumber = Math.abs(new Random().nextInt());
		modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
	    modelMap.addAttribute("tblDepartment", tblDepartment);
	    modelMap.addAttribute("optType", "new");
	    modelMap.addAttribute("tenderId", randNumber);
		modelMap.addAttribute("objectId", tenderAuthorityRegistrationObjectId);
		modelMap.addAttribute("childId", randNumber);
		modelMap.addAttribute("subChildId", 0);
		modelMap.addAttribute("countryJson", countryJson);
		modelMap.addAttribute("otherSubChildId", 0);
		modelMap.addAttribute("bidderSector", getSectorJson());
	    
	}catch (Exception  ex) {
    exceptionHandlerService.writeLog(ex);
    }
	return "/common/CreateOrganization";
    }	
    
    @RequestMapping(value = "/common/user/addOrganization", method = RequestMethod.POST)
    public String addOrganization(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDepartment") TblDepartment department,final RedirectAttributes redirectAttributes){
    String retVal = "redirect:/login";
    String personName="";
	String emailId="";
	String phoneNo="";
	String mobileNo="";
	String password="";
	String keywords="";
	String optType="";
	int countryId=0;
	int stateId=0;
	String city="";
	String companyName="";
	String address="";
	int selTimezoneId;
	String website="";
	long userId=0;
	int bidderId=0;
	boolean bSuccess=false;
	String redirect="";
	SessionBean sessionBean=null;
	TblCompany tblCompany = null;
	Object[] bidderDtl = null;
	int bidderDocId = 0;
	String lastName="";
	String middleName="";
	String addressLine1="";
			
	try {
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		System.out.println(gRecaptchaResponse);
		boolean verify = false;
		if(isProductionServer){
			verify = VerifyRecaptcha.verify(gRecaptchaResponse);
		}else{
			verify = true;
		}
		sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		if(sessionBean!=null) {
			if(sessionBean.getUserTypeId()==2) {
				redirect = "redirect:/etender/bidder/bidderTenderListing/0";
			}else {
				redirect="redirect:/common/user/getmanagebidder";
			}
		}else {
			redirect="redirect:/registersuccess";
		}
		String categoryText="";
		    categoryText = StringUtils.hasLength(request.getParameter("categoryText")) ? request.getParameter("categoryText") :"";
		if(verify) {
			personName = StringUtils.hasLength(request.getParameter("txtFullName")) ? request.getParameter("txtFullName") :"";
			lastName = StringUtils.hasLength(request.getParameter("txtLastName")) ? request.getParameter("txtLastName") :"";
			middleName = StringUtils.hasLength(request.getParameter("txtMiddleName")) ? request.getParameter("txtMiddleName") :"";
			emailId = StringUtils.hasLength(request.getParameter("txtEmailId")) ? request.getParameter("txtEmailId") : "";
			phoneNo = StringUtils.hasLength(request.getParameter("txtPhoneNo")) ? request.getParameter("txtPhoneNo") :"";
			mobileNo = StringUtils.hasLength(request.getParameter("txtMobileNo")) ? request.getParameter("txtMobileNo") : "";
			password = StringUtils.hasLength(request.getParameter("txtPassword")) ? request.getParameter("txtPassword") : "";
			optType = StringUtils.hasLength(request.getParameter("hdOptType")) ? request.getParameter("hdOptType") : "";
			keywords = StringUtils.hasLength(request.getParameter("selKeywords")) ? request.getParameter("selKeywords") : "";
			mobileNo = StringUtils.hasLength(request.getParameter("txtMobileNo")) ? request.getParameter("txtMobileNo") : "";
			countryId = StringUtils.hasLength(request.getParameter("selCountry")) ? Integer.parseInt(request.getParameter("selCountry")) : 0;
			stateId = StringUtils.hasLength(request.getParameter("selState")) ? Integer.parseInt(request.getParameter("selState")) : 0;
			city = StringUtils.hasLength(request.getParameter("txtCity")) ? request.getParameter("txtCity") : "";
			companyName = StringUtils.hasLength(request.getParameter("txtCompanyName")) ? request.getParameter("txtCompanyName") : "";
			website = StringUtils.hasLength(request.getParameter("txtWebsite")) ? request.getParameter("txtWebsite") : "";
			address = StringUtils.hasLength(request.getParameter("txtaAddress")) ? request.getParameter("txtaAddress") : "";
			selTimezoneId = StringUtils.hasLength(request.getParameter("selTimezoneId")) ? Integer.parseInt(request.getParameter("selTimezoneId")) : 0;
			bidderDocId = StringUtils.hasLength(request.getParameter("bidderDocId")) ? Integer.parseInt(request.getParameter("bidderDocId")) : 0;
			addressLine1 = StringUtils.hasLength(request.getParameter("txtaAddressLine2")) ? request.getParameter("txtaAddressLine2") : "";
			int selOriginCountryId = StringUtils.hasLength(request.getParameter("selOriginCountryId")) ? Integer.parseInt(request.getParameter("selOriginCountryId")) : 0;
			String commercialRegNo = StringUtils.hasLength(request.getParameter("txtCommercialRegNo")) ? request.getParameter("txtCommercialRegNo") : "";
			String txtEstablishDate  = StringUtils.hasLength(request.getParameter("txtEstablishDate")) ? request.getParameter("txtEstablishDate") : "";
			String txtPostalAddressLine1 = StringUtils.hasLength(request.getParameter("txtPostalAddressLine1")) ? request.getParameter("txtPostalAddressLine1") : "";
			String txtPostalAddressLine2 = StringUtils.hasLength(request.getParameter("txtPostalAddressLine2")) ? request.getParameter("txtPostalAddressLine2") : "";
			int selPostalStateId = StringUtils.hasLength(request.getParameter("selPostalStateId")) ? Integer.parseInt(request.getParameter("selPostalStateId")) : 0;
			String txtPostalCity = StringUtils.hasLength(request.getParameter("txtPostalCity")) ? request.getParameter("txtPostalCity") : "";
			String txtDesignationName = StringUtils.hasLength(request.getParameter("txtDesignationName")) ? request.getParameter("txtDesignationName") : "";
			String txtPersonalMobileNo = StringUtils.hasLength(request.getParameter("txtPersonalMobileNo")) ? request.getParameter("txtPersonalMobileNo") : "";
			String txtPersonalPhoneNo = StringUtils.hasLength(request.getParameter("txtPersonalPhoneNo")) ? request.getParameter("txtPersonalPhoneNo") : "";
			password= "Officer@"+Math.abs(new Random().nextInt());
			String txtRegisterType = "R";
			//String [] selBidderSector = request.getParameterValues("selBidderSector");

			String [] sector = request.getParameterValues("sector");
			String [] industry = request.getParameterValues("industry");
			String [] activity = request.getParameterValues("activity");
			
			TblDepartment tblDepartment = new TblDepartment();
			tblDepartment.setAddress(address);
			tblDepartment.setCity(city);
			tblDepartment.setDeptName(companyName);
			tblDepartment.setCstatus(0);
			tblDepartment.setEmailId(emailId);
			tblDepartment.setMobileNo(mobileNo);
			tblDepartment.setPersonName(personName);
			tblDepartment.setPhoneno(phoneNo);
			tblDepartment.setCountryId(countryId);
			tblDepartment.setStateId(stateId);
			tblDepartment.setWebsite(website);
			tblDepartment.setTimezoneId(selTimezoneId);
			tblDepartment.setDeptDocId(bidderDocId);
			tblDepartment.setAddressline2(addressLine1);
			tblDepartment.setCommercialRegNo(commercialRegNo);
			tblDepartment.setDesignationName(txtDesignationName);
			tblDepartment.setEstablishDate(commonService.convertStirngToUTCDate(client_dateformate,txtEstablishDate));
			tblDepartment.setOriginCountryId(selOriginCountryId);
			tblDepartment.setPersonalMobileNo(txtPersonalMobileNo);
			tblDepartment.setPersonalPhoneNo(txtPersonalPhoneNo);
			tblDepartment.setPostalAddressLine1(txtPostalAddressLine1);
			tblDepartment.setPostalAddressLine2(txtPostalAddressLine2);
			tblDepartment.setPostalCity(txtPostalCity);
			tblDepartment.setPostalStateId(selPostalStateId);
			tblDepartment.setRegisterType(txtRegisterType);
			tblDepartment.setParentDeptId(0);
			tblDepartment.setGrandParentDeptId(0);
			tblDepartment.setCstatus(0);
			tblDepartment.setTenderAuthorityFirstTimePassword(password);
			tblDepartment.setCreatedOn(commonService.getServerDateTime());
			
			
			List<TblBidderSectorMapping> bidderSectorMappings = new ArrayList<TblBidderSectorMapping>();
			for (int i=0; i < sector.length; i++) {
				TblBidderSectorMapping bidderSectorMapping = new TblBidderSectorMapping();
				bidderSectorMapping.setSectorId(Integer.parseInt(sector[i]));
				bidderSectorMapping.setIndustry(Integer.parseInt(industry[i]));
				bidderSectorMapping.setActivity(Integer.parseInt(activity[i]));
				bidderSectorMappings.add(bidderSectorMapping);
			}	
			bSuccess = officerService.addOrganization(tblDepartment, bidderSectorMappings);
			TblDesignation tblDesignationOrgAdmin = new TblDesignation();
			tblDesignationOrgAdmin.setDeptId(tblDepartment.getDeptId());
			tblDesignationOrgAdmin.setDesignationName("Org Admin");
			tblDesignationOrgAdmin.setCreateDate(commonService.getServerDateTime());
			tblDesignationOrgAdmin.setCreatedBy(1);
			
			addTenderAuthorityUser(modelMap, request, tblDepartment.getDeptId(),tblDesignationOrgAdmin,password);
			
			try {
				String hash = encrptDecryptUtils.encrypt(String.valueOf(tblDepartment.getDeptId()), registrationkey.substring(0, 16).getBytes()).replace("/", "~d~");
				String url = "http://"+stagingurl+"/eProcurement/verifyregistration/org/"+hash;
				String href = "<a href=\""+url+"\" />";
               String content = "Thank you for registration click here to verify your registration : " + href;
               officerService.addMail(officerService.setTblMailMessage(emailId,mailFrom, "Registration details ",content,"Registration details "));
               
               String contentforadmin = "TenderAuthority registered in our system," + emailId;
               officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, "Registration details",contentforadmin,"Registration details"));
            } 
            catch (Exception e) 
            {
            	exceptionHandlerService.writeLog(e);
            }
			redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_org_create_successfully");
			if(!categoryText.isEmpty()){
				officerService.saveCategoryData(tblDepartment.getDeptId(), tblDepartment.getDeptId().longValue(),0,0,categoryText);
			}
		}else {
			redirect="redirect:/common/user/register";	
			redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_org_create_fail");
		}
	} catch (Exception ex) {
		redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_org_create_fail");
	    exceptionHandlerService.writeLog(ex);
	} 
	return retVal;
    }
    
    
    @RequestMapping(value = "/common/user/manageorganization", method = RequestMethod.GET)
    public String manageorganization(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDepartment") TblDepartment department,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/Manageorganization";
		try {
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return retVal;
    }
    
    @RequestMapping(value = "/common/user/editOrganization", method = RequestMethod.POST)
    public String editOrganization(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDepartment") TblDepartment department,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/manageorganization";
    int orgstatus = request.getParameter("orgstatus")!=null ? Integer.parseInt(request.getParameter("orgstatus")) : 0;
    String remarks = request.getParameter("txtaremarks")!=null ? request.getParameter("txtaremarks") : "";
    int deptId = request.getParameter("deptId")!=null ? Integer.parseInt(request.getParameter("deptId")) : 0;
    
		try {
			if (department!=null) {
				TblDepartment department2 = officerService.getDepartmentById(deptId);
				department2.setParentDeptId(0);
				department2.setGrandParentDeptId(0);
				department2.setCstatus(orgstatus);
				department2.setRemarks(remarks);
				officerService.addDepartment(department2,"edit");
			  if(orgstatus==2){ 
				String contentforadmin = "Tender Authority is rejected successfully," + department2.getDeptName()+"("+department2.getEmailId()+")";
	            String url = "http://"+stagingurl+"/eProcurement/";
	            String href = "<a href=\""+url+"\" />";
	            String contentforbidder = "Your profile is rejected.re-register by clicking this link ," + href;
	            officerService.addMail(officerService.setTblMailMessage(department2.getEmailId(),mailFrom, "Your profile has been rejected",contentforbidder,"Your profile has been rejected"));
	            officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, "Tender Authority status change",contentforadmin,"Tender Authority status change "));
	            redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_org_rejected_successfully");
			}else if(orgstatus==1) {
				String contentforadmin = " Tender Authority is approved successfully," + department2.getDeptName()+"("+department2.getEmailId()+")";
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_org_approved_successfully");
				String contentforbidder = "Your profile has been approved and password for the system is : "+department2.getTenderAuthorityFirstTimePassword();
	            officerService.addMail(officerService.setTblMailMessage(department2.getEmailId(),mailFrom,"Your profile has been approved",contentforbidder,"Your profile has been approved"));
	            officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom,"Tender Authority status change",contentforadmin,"Tender Authority status change "));
			}else if(orgstatus==3) {
				String contentforadmin = " Tender Authority is de-activated successfully," + department2.getDeptName()+"("+department2.getEmailId()+")";
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_org_de_activated_successfully");
				String contentforbidder = "Your profile has been de-activated .";
	            officerService.addMail(officerService.setTblMailMessage(department2.getEmailId(),mailFrom, "Your profile has been de-activated",contentforbidder,"Your profile has been de-activated "));
	            officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, "Tender Authority status change",contentforadmin,"Tender Authority status change "));
			}
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/geteditorganization/{deptid}/{deptstatus}/{tabId}/{isview}", method = RequestMethod.GET)
    public String getEditOrganization(ModelMap modelMap, HttpServletRequest request,@PathVariable("deptstatus")int deptstatus,@PathVariable("deptid")int deptId,@PathVariable("tabId")int tabId,@PathVariable("isview")int isView) {
    String  countryJson = "";
    String userStatusLabel = "";
    
	try {
		userStatusLabel="Approve Organization";
		modelMap.addAttribute("userStatusLabel", userStatusLabel);
		modelMap.addAttribute("deptId", deptId);
		modelMap.addAttribute("userstatus", 0);
		modelMap.addAttribute("tabId", tabId);
		modelMap.addAttribute("deptstatus", deptstatus);
		countryJson = getContryJson();
		TblDepartment tblDepartment = new TblDepartment();
		tblDepartment = officerService.getDepartmentById(deptId);
		modelMap.addAttribute("countryJson", countryJson);
		modelMap.addAttribute("optType", "Edit");    
		modelMap.addAttribute("tblDepartment", tblDepartment);
		modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
		modelMap.addAttribute("country", commonService.getCountryById((Integer)tblDepartment.getCountryId()));
		modelMap.addAttribute("origincountry", commonService.getCountryById((Integer)tblDepartment.getOriginCountryId()));
	    modelMap.addAttribute("state", commonService.getStateById((Integer)tblDepartment.getStateId()));
	    modelMap.addAttribute("postalState", commonService.getStateById((Integer)tblDepartment.getPostalStateId()));
	    modelMap.addAttribute("timeZone", commonService.getTimeZonebyId((Integer)tblDepartment.getTimezoneId()));
	    modelMap.addAttribute("objectId", tenderAuthorityRegistrationObjectId);
	    modelMap.addAttribute("childId", tblDepartment.getDeptDocId());
	    modelMap.addAttribute("isview", isView);
	    String remarks = "";
	    if(isView==1){
	    	remarks = officerService.getStatusRemarks(deptId, deptstatus, 2);
	    }
	    modelMap.addAttribute("remarks", remarks);
	    
	    
	    StringBuilder sectors = new StringBuilder();
	    List<TblBidderSectorMapping> bidderSectorMappings = officerService.getSectorMappingById(deptId);
	   /* for (TblBidderSectorMapping tblBidderSectorMapping : bidderSectorMappings) {
			sectors.append(officerService.getSectorNameById(tblBidderSectorMapping.getSectorId())).append(",");
		}*/
	    modelMap.addAttribute("bidderSectorMappings", bidderSectorMappings);
	    //modelMap.addAttribute("sectors", sectors);
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} 
	return "/common/ViewOrganization";
    }
    
    
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/getlocationdepartment", method = RequestMethod.GET)
    public String getLocationOrDepartment(ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    String grandParentDeptJson="";
    SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
    try {
    	if(sessionBean!=null){
    		TblDepartment tblParentDepartment ;
    		grandParentDeptJson=getGrandParentDeptList();
    		tblParentDepartment = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
    		TblDepartment tblDepartment = new TblDepartment();
    		tblDepartment.setGrandParentDeptId(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
    	    modelMap.addAttribute("tblDepartment", tblDepartment);
    	    modelMap.addAttribute("tblParentDepartment", tblParentDepartment);
    	    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
    	    modelMap.addAttribute("optType", "new");
    	}
	}catch (Exception  ex) {
    exceptionHandlerService.writeLog(ex);
    }
	return "/common/CreateDepartment";
    }	
    
    @RequestMapping(value = "/common/user/addlocationdepartment", method = RequestMethod.POST)
    public String addLocationDepartment(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDepartment") TblDepartment department,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/getlocationdepartment";
		try {
			if (department!=null) {
				if(!officerService.isDepartmentNameExists(department.getDeptName(),department.getGrandParentDeptId())){
				department.setParentDeptId(0);
				officerService.addDepartment(department,"new");
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_location_create_successfully");
				}else{
					redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_location_already_created");
				}
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    
 
    @RequestMapping(value = "/common/user/editlocationdepartment", method = RequestMethod.POST)
    public String editLocationDepartment(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDepartment") TblDepartment department,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/getlocationdepartment";
		try {
			boolean isDeptExist = false;
			if (department!=null) {
				TblDepartment editDept = officerService.getDepartmentById(department.getDeptId());
				if(!editDept.getDeptName().equals(department.getDeptName())){
					isDeptExist = officerService.isDepartmentNameExists(department.getDeptName(),department.getGrandParentDeptId());	
				}
				if(!isDeptExist){
				department.setParentDeptId(0);
				officerService.addDepartment(department,"edit");
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_location_edit_successfully");
				}else{
					redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_location_already_created");
				}
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/geteditlocationdepartment/{deptid}", method = RequestMethod.GET)
    public String getEditLocationDepartment(ModelMap modelMap, HttpServletRequest request,@PathVariable("deptid")int deptId,HttpSession session) {
    	String grandParentDeptJson="";
    	SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
        try {
        	if(sessionBean!=null){
        		grandParentDeptJson=getGrandParentDeptList();
        		TblDepartment tblParentDepartment = new TblDepartment();
        		TblDepartment tblDepartment = officerService.getDepartmentById(deptId);
        		if(sessionBean.getIsOrgenizationUser()==1) {
        			tblParentDepartment = officerService.getDepartmentById(deptId);
            		modelMap.addAttribute("grandParentDeptId", tblDepartment.getGrandParentDeptId());	
        		}else {
        			tblParentDepartment = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
            		tblDepartment.setGrandParentDeptId(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
            		modelMap.addAttribute("grandParentDeptId", sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
        		}
        	    modelMap.addAttribute("tblDepartment", tblDepartment);
        	    modelMap.addAttribute("tblParentDepartment", tblParentDepartment);
        	    modelMap.addAttribute("optType", "edit");
        	    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
        	}
    	}catch (Exception  ex) {
        exceptionHandlerService.writeLog(ex);
        }
	return "/common/CreateDepartment";
    }
    
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/getdepartments", method = RequestMethod.GET)
    public String getEditCommitee(ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    	String grandParentDeptJson="";
    	SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
        try {
        	if(sessionBean!=null){
			TblDepartment tblDepartment = new TblDepartment();
			tblDepartment.setGrandParentDeptId(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
			grandParentDeptJson=getGrandParentDeptList();
			TblDepartment tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		    List<TblDepartment> tblDepartments = officerService.getSubDepartments(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId(), "0");
		    Map<String,String> parentDeptLst = new LinkedHashMap<String,String>();
		    parentDeptLst.put(String.valueOf(-1), "Please select");
		    for (TblDepartment tblDepartment2 : tblDepartments) {
		    	parentDeptLst.put(tblDepartment2.getDeptId().toString(), tblDepartment2.getDeptName().toString());
			}
		    modelMap.addAttribute("tblDepartment", tblDepartment);
		    modelMap.addAttribute("parentDeptLst", parentDeptLst);
		    modelMap.addAttribute("tblGrandParentDept", tblGrandParentDept);
		    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
        	}
        }catch (Exception  ex) {
        		exceptionHandlerService.writeLog(ex);
		    }
	return "/common/CreateSubDepartment";
    }	
    
    @RequestMapping(value = "/common/user/addDept", method = RequestMethod.POST)
    public String addDepartment(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDepartment") TblDepartment department,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/getdepartments";
		try {
			if (department!=null) {
				if(!officerService.isSubDepartmentNameExists(department.getDeptName(),department.getParentDeptId())){
				if(department.getParentDeptId()==-1) {
					department.setParentDeptId(0);
				}else if(department.getGrandParentDeptId()==-1){
					department.setGrandParentDeptId(0);
				}
				officerService.addDepartment(department,"new");
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_sub_dept_create_successfully");
				}else{
					redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_subdepartment_already_created");
				}
			}
			List<TblDepartment> tblDepartments = officerService.getDepartments();
		    modelMap.addAttribute("tblDepartments", tblDepartments);
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/geteditdepartment/{deptid}", method = RequestMethod.GET)
    public String getEditCommitee(ModelMap modelMap, HttpServletRequest request,@PathVariable("deptid")int deptId,HttpSession session) {
    	String grandParentDeptJson="";
    	SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
        try {
        if(sessionBean!=null){
        TblDepartment tblGrandParentDept  = null;
        List<TblDepartment> tblDepartments  = null;
		TblDepartment tblDepartment = new TblDepartment();
		tblDepartment = officerService.getDepartmentById(deptId);
		
		if(sessionBean.getIsOrgenizationUser()==1) {
			tblGrandParentDept  = officerService.getDepartmentById(deptId);
		    tblDepartments = officerService.getSubDepartments(tblGrandParentDept.getGrandParentDeptId(), "0");
		    modelMap.addAttribute("grandParentDeptId", tblGrandParentDept.getGrandParentDeptId());
		    modelMap.addAttribute("parentDeptId", tblGrandParentDept.getParentDeptId());
		}else {
			tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		    tblDepartments = officerService.getSubDepartments(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId(), "0");
		    modelMap.addAttribute("grandParentDeptId", sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		    modelMap.addAttribute("parentDeptId", sessionBean.getParentDeptId());
		}
	    Map<String,String> parentDeptLst = new LinkedHashMap<String,String>();
	    parentDeptLst.put(String.valueOf("0"), "Please select department");
	    for (TblDepartment tblDepartment2 : tblDepartments) {
	    	if(tblDepartment2.getDeptId()!=deptId) {
	    	parentDeptLst.put(tblDepartment2.getDeptId().toString(), tblDepartment2.getDeptName().toString());
	    	}
		}
	    grandParentDeptJson=getGrandParentDeptList();
	    modelMap.addAttribute("tblDepartments", tblDepartments);
	    modelMap.addAttribute("tblDepartment", tblDepartment);
	    modelMap.addAttribute("parentDeptLst", parentDeptLst);
	    modelMap.addAttribute("tblGrandParentDept", tblGrandParentDept);
	    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
	    modelMap.addAttribute("optType", "edit");
        	}
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} 
	return "/common/CreateSubDepartment";
    }
    
    
    @RequestMapping(value = "/common/user/editDept", method = RequestMethod.POST)
    public String editDepartment(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDepartment") TblDepartment department,RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/getdepartments";
		try {
			boolean isDeptExist = false;
			if (department!=null) {
					TblDepartment editDept = officerService.getDepartmentById(department.getDeptId());
					if(!editDept.getDeptName().equals(department.getDeptName())){
						isDeptExist = officerService.isSubDepartmentNameExists(department.getDeptName(),department.getParentDeptId());	
					}
					if(!isDeptExist){
				if(department.getParentDeptId()==-1) {
					department.setParentDeptId(0);
				}else if(department.getGrandParentDeptId()==-1){
					department.setGrandParentDeptId(0);
				}
				officerService.addDepartment(department,"edit");
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_sub_dept_edit_successfully");
				}else{
					redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_subdepartment_already_created");
				}
			}
			List<TblDepartment> tblDepartments = officerService.getDepartments();
		    modelMap.addAttribute("tblDepartments", tblDepartments);
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/getdesignation", method = RequestMethod.GET)
    public String getDesignation(ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    String grandParentDeptJson="";	
    SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
    try {
    if(sessionBean!=null){
		TblDesignation tblDesignation = new TblDesignation();
		TblDepartment tblGrandParentDept = null;
		if(sessionBean.getIsOrgenizationUser()==1) {
			tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
			tblDesignation.setDeptId(tblGrandParentDept.getDeptId());
		}else {
			tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
			tblDesignation.setDeptId(tblGrandParentDept.getDeptId());
		}
		
//	    List<TblDepartment> tblDepartments = officerService.getParentDepartments();
//	    Map<String,String> parentDeptLst = new LinkedHashMap<String,String>();
//	    parentDeptLst.put("-1", "Please select department");
//	    for (TblDepartment tblDepartment2 : tblDepartments) {
//	    	parentDeptLst.put(tblDepartment2.getDeptId().toString(), tblDepartment2.getDeptName().toString());
//		}
	    grandParentDeptJson=getGrandParentDeptList();
	    
//	    modelMap.addAttribute("parentDeptLst", parentDeptLst);
	    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
	    modelMap.addAttribute("tblDesignation", tblDesignation);
	    modelMap.addAttribute("tblGrandParentDept", tblGrandParentDept);
     }
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} 
	return "/common/CreateDesignation";
    }
    
    @RequestMapping(value = "/common/user/addDesignation", method = RequestMethod.POST)
    public String addDesignation(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDesignation") TblDesignation tblDesignation,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/getdesignation";
    	int subDeptId=0; 
    	int grandParentDeptId=0;
    	int parentDeptId=0;
		try {
			subDeptId = StringUtils.hasLength(request.getParameter("subDeptId")) ? Integer.parseInt(request.getParameter("subDeptId"))!=-1 ?Integer.parseInt(request.getParameter("subDeptId")) : 0 : 0;
			grandParentDeptId = StringUtils.hasLength(request.getParameter("grandParentDeptId")) ? Integer.parseInt(request.getParameter("grandParentDeptId")) !=-1 ? Integer.parseInt(request.getParameter("grandParentDeptId")) : 0 : 0;
			parentDeptId = tblDesignation.getDeptId()!=null ? tblDesignation.getDeptId()!=-1 ?tblDesignation.getDeptId() : 0 : 0;
			if (tblDesignation!=null) {
				if(!officerService.isDesignationExists(tblDesignation.getDesignationName(), new Integer[]{tblDesignation.getDeptId()})){
					tblDesignation.setCreatedBy(1);
					tblDesignation.setCreateDate(commonService.getServerDateTime());
					tblDesignation.setDeptId(tblDesignation.getDeptId());
//					if(subDeptId!=0 && grandParentDeptId!=0 && parentDeptId!=0) {
//						tblDesignation.setDeptId(subDeptId);
//					}else if(subDeptId==0 && grandParentDeptId!=0 && parentDeptId==0) {
//						tblDesignation.setDeptId(grandParentDeptId);
//					}else if(subDeptId==0 && grandParentDeptId!=0 && parentDeptId!=0) {
//						tblDesignation.setDeptId(parentDeptId);
//					}
					officerService.addDesignation(tblDesignation,"new");
					redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_designation_create_successfully");
				}else{
					redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_designation_already_created");
				}
				
			}
			List<TblDepartment> tblDepartments = officerService.getDepartments();
		    modelMap.addAttribute("tblDepartments", tblDepartments);
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/geteditdesignation/{designationId}", method = RequestMethod.GET)
    public String getEditDesignation(ModelMap modelMap, HttpServletRequest request,@PathVariable("designationId")int designationId,HttpSession session) {
    	TblDesignation tblDesignation = new TblDesignation();
    	TblDepartment tblDepartment=null;
    	String subDeptJson="";
    	String parentDeptJson="";
    	int subDeptId = 0;
    	int grandParentDeptId=0;
    	int parentDeptId=0;
    	String grandParentDeptJson="";
    	SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
        try {
        if(sessionBean!=null){
	    List<TblDepartment> tblDepartments = officerService.getDepartments();
	    tblDesignation = officerService.getDesignationById(designationId);
	    tblDepartment = officerService.getDepartmentById(tblDesignation.getDeptId());
	    TblDepartment tblGrandParentDept = null;
	    if(sessionBean.getIsOrgenizationUser()==1) {
	    	tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		    grandParentDeptId=sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId();
		}else {
			tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
		    grandParentDeptId=sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId();
		}
	    
//		if(tblDepartment!=null) {
//			grandParentDeptId=tblDepartment.getGrandParentDeptId();
//			if(grandParentDeptId!=0 && tblDepartment.getParentDeptId()!=0) {
//				subDeptId = tblDesignation.getDeptId();
//				tblDesignation.setDeptId(tblDepartment.getParentDeptId());
//				subDeptJson = getSubDeptListJson(tblDepartment.getParentDeptId(),"1");
//				parentDeptId = tblDepartment.getParentDeptId();
//				parentDeptJson = getSubDeptListJson(grandParentDeptId,"0");
//			}else if (grandParentDeptId!=0 && tblDepartment.getParentDeptId()==0) {
//				tblDesignation.setDeptId(tblDepartment.getDeptId());
//				parentDeptId = tblDesignation.getDeptId();
//				parentDeptJson = getSubDeptListJson(grandParentDeptId,"0");
//			}else if (grandParentDeptId==0 && tblDepartment.getParentDeptId()==0) {
//				grandParentDeptId=tblDepartment.getDeptId();
//			}
//		}
	    grandParentDeptJson=getGrandParentDeptList();
	    modelMap.addAttribute("tblDepartment", tblDepartment);
	    modelMap.addAttribute("tblDesignation", tblDesignation);
	    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
	    modelMap.addAttribute("parentDeptJson", parentDeptJson);
	    modelMap.addAttribute("parentDeptId", parentDeptId);
	    modelMap.addAttribute("subDeptJson", subDeptJson);
	    modelMap.addAttribute("subDeptId", subDeptId);
	    modelMap.addAttribute("grandParentDeptId", grandParentDeptId);
	    modelMap.addAttribute("optType", "edit");
	    modelMap.addAttribute("tblGrandParentDept", tblGrandParentDept);
	    
        }
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	    
	} 
	return "/common/CreateDesignation";
    }
    
    @RequestMapping(value = "/common/user/editDesignation", method = RequestMethod.POST)
    public String editDesignation(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblDesignation") TblDesignation tblDesignation,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/getdesignation";
    TblDepartment department = null;
    int grandParentDeptId=0;
    int subDeptId=0;
    int parentDeptId=0;
    boolean isDesignationExists=false;
		try {
			subDeptId = StringUtils.hasLength(request.getParameter("subDeptId")) ? Integer.parseInt(request.getParameter("subDeptId"))!=-1 ? Integer.parseInt(request.getParameter("subDeptId")) : 0 : 0;
			grandParentDeptId = StringUtils.hasLength(request.getParameter("grandParentDeptId")) ? Integer.parseInt(request.getParameter("grandParentDeptId"))!=-1 ? Integer.parseInt(request.getParameter("grandParentDeptId")) : 0 : 0;
			parentDeptId = tblDesignation.getDeptId()!=null? tblDesignation.getDeptId()!=-1?tblDesignation.getDeptId():0:0;
			TblDesignation editDesignation = officerService.getDesignationById(tblDesignation.getDesignationId());
			if (tblDesignation!=null) {
				if(!editDesignation.getDesignationName().equals(tblDesignation.getDesignationName())){
					isDesignationExists=officerService.isDesignationExists(tblDesignation.getDesignationName(), new Integer[]{tblDesignation.getDeptId()});
				}
				if(!isDesignationExists){
					if(subDeptId!=0 && grandParentDeptId!=0 && parentDeptId!=0) {
						tblDesignation.setDeptId(subDeptId);
					}else if(subDeptId==0 && grandParentDeptId!=0 && parentDeptId==0) {
						tblDesignation.setDeptId(grandParentDeptId);
					}else if(subDeptId==0 && grandParentDeptId!=0 && parentDeptId!=0) {
						tblDesignation.setDeptId(parentDeptId);
					}
					tblDesignation.setModifiedBy(1);
					tblDesignation.setModifiedDate(commonService.getServerDateTime());
					tblDesignation.setCreatedBy(1);
					tblDesignation.setCreateDate(commonService.getServerDateTime());
					officerService.addDesignation(tblDesignation,"edit");
					redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_designation_edit_successfully");
				}else{
					redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_designation_already_created");
				}
			}
			
			List<TblDepartment> tblDepartments = officerService.getDepartments();
			Map<String,String> parentDeptLst = new LinkedHashMap<String,String>();
		    parentDeptLst.put("-1", "Please select department");
		    for (TblDepartment tblDepartment2 : tblDepartments) {
		    	parentDeptLst.put(tblDepartment2.getDeptId().toString(), tblDepartment2.getDeptName().toString());
			}
		    modelMap.addAttribute("parentDeptLst", parentDeptLst);
		    modelMap.addAttribute("tblDepartments", tblDepartments);
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    /**
     * 
     * @param searchValue
     * @param keyword
     * @param modelMap
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/isdesignationexists/{searchValue}/{keyword}", method = RequestMethod.POST)
    public boolean getIsDesignationExists(@PathVariable("searchValue") String searchValue,@PathVariable("keyword") String keyword,ModelMap modelMap, HttpServletRequest request) {
	    boolean isExist = false;
	    String designationName = searchValue.split("@@")[0];
	    Integer[] deptIds = new Integer[3];
	    deptIds[0] = Integer.parseInt(searchValue.split("@@")[1]);
	    deptIds[1] = Integer.parseInt(searchValue.split("@@")[2]!=""?searchValue.split("@@")[2]:"0");
	    deptIds[2] = Integer.parseInt(searchValue.split("@@")[3]!=""?searchValue.split("@@")[3]:"0");
		try {
			isExist=officerService.isDesignationExists(designationName, deptIds);
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
	return isExist;
    }
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/getcreateofficer", method = RequestMethod.GET)
    public String getCreateOfficer(ModelMap modelMap, HttpServletRequest request) {
    	StringBuilder json = new StringBuilder("[");
    	String jsonStr="";
    	String rolesJson = "";
    	SessionBean sessionBean = null;
    	List<Integer> tblUserRoles = new ArrayList<Integer>();
    	String redirect ="etender/buyer/CreateOfficer";
    	String grandParentDeptJson="";
    	String countryJson = "";
	try {
		sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		if(sessionBean!=null) {
			grandParentDeptJson=getGrandParentDeptList();
			TblDepartment tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
			rolesJson = getRolesJson();
			countryJson=getContryJson();
		    modelMap.addAttribute("rolesJson", rolesJson);
		    modelMap.addAttribute("tblUserRoles", tblUserRoles);
		    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
		    modelMap.addAttribute("tblGrandParentDept", tblGrandParentDept);
		    modelMap.addAttribute("countryJson", countryJson);
		    modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
	    }else{
	    	redirect="redirect:loginfailed";
	    }
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} 
	return redirect;
    }
    
    /**
     * Method to view edit committee details page
     *
     * @param tenderId
     * @param comitteeId
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/common/user/geteditofficer/{officerId}/{editfrom}", method = RequestMethod.GET)
    public String getEditOfficer(ModelMap modelMap, HttpServletRequest request,@PathVariable("officerId") int officerId,@PathVariable("editfrom") String editfrom,HttpSession session) {
    	String jsonStr="";
    	String rolesJson = "";
    	List<Integer> tblUserRoles = null;
    	String grandParentDeptJson="";
    	int grandParentDeptId=0;
    	int parentDeptId=0;
    	int subDeptId=0;
    	String subDeptJson="";
    	String parentDeptJson="";
    	SessionBean sessionBean = null;
    	String countryJson = "";
	try {
		sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		if(sessionBean!=null) {
	    Object[] officerDtl = officerService.getOfficerDetails(officerId);
	    TblDepartment tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
	    rolesJson = getRolesJson();
	    if(officerDtl!=null) {
	    	tblUserRoles = commonService.getUserRoleByUserId((Long)officerDtl[4]);
	    	TblDepartment  tblDepartment = officerService.getDepartmentById((Integer)officerDtl[6]); 
	    	if(tblDepartment!=null) {
	    		grandParentDeptId=tblDepartment.getGrandParentDeptId();
				if(grandParentDeptId!=0 && tblDepartment.getParentDeptId()!=0) {
					subDeptId = tblDepartment.getDeptId();
					subDeptJson = getSubDeptListJson(tblDepartment.getParentDeptId(),"1");
					parentDeptId = tblDepartment.getParentDeptId();
					parentDeptJson = getSubDeptListJson(grandParentDeptId,"0");
				}else if (grandParentDeptId!=0 && tblDepartment.getParentDeptId()==0) {
					parentDeptId = tblDepartment.getDeptId();
					parentDeptJson = getSubDeptListJson(grandParentDeptId,"0");
				}else if (grandParentDeptId==0 && tblDepartment.getParentDeptId()==0) {
					grandParentDeptId=tblDepartment.getDeptId();
				}
	    	}
	    	modelMap.addAttribute("designationId", (Integer)officerDtl[7]);
	    	modelMap.addAttribute("parentDeptId", parentDeptId);
    		modelMap.addAttribute("subDeptId", subDeptId);
    		modelMap.addAttribute("grandParentDeptId", grandParentDeptId);
	    }
	    countryJson = getContryJson();
	    grandParentDeptJson=getGrandParentDeptList();
	    modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
	    modelMap.addAttribute("deptLst", jsonStr);
	    modelMap.addAttribute("officerDtl", officerDtl);
	    modelMap.addAttribute("optType", "Edit");
	    modelMap.addAttribute("rolesJson", rolesJson);
	    modelMap.addAttribute("tblUserRoles", tblUserRoles);
	    modelMap.addAttribute("grandParentDeptJson", grandParentDeptJson);
	    modelMap.addAttribute("subDeptJson", subDeptJson);
	    modelMap.addAttribute("parentDeptJson", parentDeptJson);
	    modelMap.addAttribute("tblGrandParentDept", tblGrandParentDept);
	    modelMap.addAttribute("countryJson", countryJson);
	    modelMap.addAttribute("editfrom", editfrom);
	    if(!officerDtl[2].equals("")){
	    	modelMap.addAttribute("txtPhoneNo1", officerDtl[2].toString().split("-")[0]);
		    modelMap.addAttribute("txtPhoneNo2", officerDtl[2].toString().split("-")[1]);
		    modelMap.addAttribute("txtPhoneNo", officerDtl[2].toString().split("-").length>2 ? officerDtl[2].toString().split("-")[2]:"");
	    }
	    
	    if(!officerDtl[1].equals("")){
	    modelMap.addAttribute("txtMobileNo1", officerDtl[1].toString().split("-")[0]);
	    modelMap.addAttribute("txtMobileNo", officerDtl[1].toString().split("-")[1]);
	    }
		    if(officerDtl[13].toString().equals("1")){ // is orgenizationuser
			    List<Object[]> tblCurrencyList = commonService.getCurrencyList(0);	
			    modelMap.addAttribute("currencyList", tblCurrencyList);
		    }
	    }
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} 
	return "etender/buyer/CreateOfficer";
    }
    
    @RequestMapping(value = "/common/user/deleteuser/{officerId}", method = RequestMethod.GET)
    public String deleteUser(ModelMap modelMap, HttpServletRequest request,@PathVariable("officerId") String officerId,HttpSession session) {
    	SessionBean sessionBean = null;
    	String pageName =  "redirect:/sessionexpired";
		try {
			sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
			if(sessionBean!=null) {
				
				officerService.deleteUser(officerId);
				pageName = "redirect:/common/user/getmanageuser"; 
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		}
		return pageName;
    }
    
    
    @RequestMapping(value = "/common/user/adduser", method = RequestMethod.POST)
    public String addUser(ModelMap modelMap, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
    String retVal = "/common/user/getmanageuser";
    	String officerName="";
    	String emailId="";
    	String phoneNo="";
    	String mobileNo="";
    	String password="";
    	int designationId=0;
    	int selTimezoneId = 0;
    	String optType="";
    	long userId=0;
    	long officerId=0;
    	int subDeptId=0;
    	boolean bSuccess=false;
    	String [] roleIds = null;
    	int grandParentDeptId=0;
    	int parentDeptId=0;
    	int selCountry=0;
    	int selState=0;
    	String txtCity="";
    	String txtaAddress="";
    	String editfrom="";
    	List<TblUserRoleMapping> userRoleMappingLst = new ArrayList<TblUserRoleMapping>();
    	SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		try {
			editfrom = StringUtils.hasLength(request.getParameter("editfrom")) ? request.getParameter("editfrom") :"";
			parentDeptId = StringUtils.hasLength(request.getParameter("selDepartment"))? Integer.parseInt(request.getParameter("selDepartment"))!=-1 ? Integer.parseInt(request.getParameter("selDepartment")) : 0 : 0;
			subDeptId = StringUtils.hasLength(request.getParameter("subDeptId")) ? Integer.parseInt(request.getParameter("subDeptId"))!=-1 ? Integer.parseInt(request.getParameter("subDeptId")): 0 : 0;
			grandParentDeptId = StringUtils.hasLength(request.getParameter("grandParentDeptId")) ? Integer.parseInt(request.getParameter("grandParentDeptId"))!=-1 ? Integer.parseInt(request.getParameter("grandParentDeptId")) : 0 : 0;
			officerName = StringUtils.hasLength(request.getParameter("txtFullName")) ? request.getParameter("txtFullName") :"";
			emailId = StringUtils.hasLength(request.getParameter("txtEmailId")) ? request.getParameter("txtEmailId") : "";
			phoneNo = StringUtils.hasLength(request.getParameter("txtPhoneNo")) ? request.getParameter("txtPhoneNo") :"";
			mobileNo = StringUtils.hasLength(request.getParameter("txtMobileNo")) ? request.getParameter("txtMobileNo") : "";
//			password = StringUtils.hasLength(request.getParameter("txtPassword")) ? request.getParameter("txtPassword") : "";
			password="Officer@"+Math.abs(new Random().nextInt());
			selTimezoneId = StringUtils.hasLength(request.getParameter("selTimezoneId")) ? Integer.parseInt(request.getParameter("selTimezoneId")) : 0;
			selCountry = StringUtils.hasLength(request.getParameter("selCountry"))? Integer.parseInt(request.getParameter("selCountry"))  : 0;
			selState = StringUtils.hasLength(request.getParameter("selState"))? Integer.parseInt(request.getParameter("selState"))  : 0;
			txtCity = StringUtils.hasLength(request.getParameter("txtCity"))? request.getParameter("txtCity")  : "";
			txtaAddress = StringUtils.hasLength(request.getParameter("txtaAddress"))? request.getParameter("txtaAddress")  : "";
			roleIds = request.getParameterValues("selUserRoles"); 
			designationId = StringUtils.hasLength(request.getParameter("selDesignation")) ? Integer.parseInt(request.getParameter("selDesignation")) : 0;
			optType = StringUtils.hasLength(request.getParameter("hdOptType")) ? request.getParameter("hdOptType") : "";
			Object[] officerDb = null;
			TblDesignation tblDesignation = null;
			List<Object[]> tblUserLoginDb = null;
			TblUserLogin tblUserLogin = null;
			TblOfficer tblOfficer  = null;
			if(optType.equalsIgnoreCase("Edit")) {
				userId = StringUtils.hasLength(request.getParameter("hdUserId")) ? Integer.parseInt(request.getParameter("hdUserId")) : 0;
				officerId = StringUtils.hasLength(request.getParameter("hdOfficerId")) ? Integer.parseInt(request.getParameter("hdOfficerId")) : 0;
				officerDb = officerService.getOfficerDetailsByUserId((int) userId);
				tblUserLoginDb = commonService.getUserLoginDetailById(userId);
				tblUserLogin = officerService.getTblUseloginbyUserId(userId);
				tblOfficer = officerService.getTblOfficerbyUserId(officerId);
			}else {
				tblUserLogin = new TblUserLogin();
				tblOfficer = new TblOfficer();
			}
			if(editfrom.equals("buyer")) {
		    	retVal = "etenderdashboard";
		    	if(officerDb!=null) {
		    		tblDesignation = officerService.getDesignationById((Integer) officerDb[7]);
		    	}
		    }else {
		    	tblDesignation = officerService.getDesignationById(designationId);
		    }
			
			tblUserLogin.setCstatus(1);
			tblUserLogin.setLoginid(emailId);
			tblUserLogin.setTblDesignation(tblDesignation);
			tblUserLogin.setCreatedby(1);
			tblUserLogin.setUserType(1);
			tblUserLogin.setFailedattempt(0);
			tblUserLogin.setTimezoneId(selTimezoneId);
			if(sessionBean.getIsCTPLUser() == 1){
				tblUserLogin.setIsOrgenizationUser(1);
			}
			if(optType.equalsIgnoreCase("Edit")) {
				tblUserLogin.setModifiedby(1);
				tblUserLogin.setDatemodified(commonService.getServerDateTime());
				tblUserLogin.setUserId(userId);
				if(tblUserLoginDb!=null) {
					tblUserLogin.setPassword((String)tblUserLoginDb.get(0)[3]);
				}
			}else {
				tblUserLogin.setDatecreated(commonService.getServerDateTime());
				tblUserLogin.setIsFirstLogin(1);
				tblUserLogin.setPassword(encrptDecryptUtils.encrypt(password,passwordkey.substring(0, 16).toString().getBytes()));
			}
			tblOfficer.setEmailid(emailId);
			tblOfficer.setMobileno(mobileNo);
			tblOfficer.setOfficername(officerName);
			tblOfficer.setTblDesignation(tblDesignation);
			tblOfficer.setCstatus(1);
			tblOfficer.setPhoneNo(phoneNo);
			tblOfficer.setCreatedby(1);
			tblOfficer.setDatemodified(commonService.getServerDateTime());
			
			if(!editfrom.equals("buyer")) {//restrict this operation on buyer edit profile
				if(subDeptId!=0 && grandParentDeptId!=0 && parentDeptId!=0) {
					tblOfficer.setTblDepartment(new TblDepartment(subDeptId));
				}else if(subDeptId==0 && grandParentDeptId!=0 && parentDeptId==0) {
					tblOfficer.setTblDepartment(new TblDepartment(grandParentDeptId));
				}else if(subDeptId==0 && grandParentDeptId!=0 && parentDeptId!=0) {
					tblOfficer.setTblDepartment(new TblDepartment(parentDeptId));
				}
		    }else {
		    	if(officerDb!=null) {
		    		tblOfficer.setTblDepartment(new TblDepartment((Integer)officerDb[6]));
		    	}
		    }
			
			tblOfficer.setCountryid(selCountry);
			tblOfficer.setStateid(selState);
			tblOfficer.setCity(txtCity);
			tblOfficer.setAddress(txtaAddress);
			if(optType.equalsIgnoreCase("edit")) {
				tblOfficer.setModifiedby(1);
				tblOfficer.setDatemodified(commonService.getServerDateTime());
				tblOfficer.setId(officerId);
				tblOfficer.setDatecreated(commonService.getServerDateTime());
			}else {
				tblOfficer.setDatecreated(commonService.getServerDateTime());
			}
			
			if(!editfrom.equals("buyer")) {//restrict this operation on buyer edit profile
				for (String roleId : roleIds) {
					TblUserRoleMapping userRoleMapping = new TblUserRoleMapping();
					userRoleMapping.setTblRoles(new TblRoles(Integer.parseInt(roleId)));
					userRoleMapping.setTblUserlogin(tblUserLogin);
					userRoleMappingLst.add(userRoleMapping);
				}
			}else {
				userRoleMappingLst = officerService.getUserRoleMappingByUserId(userId);
			}
			
			if(optType.equalsIgnoreCase("Edit")) {
				bSuccess = officerService.addUser(tblOfficer, tblUserLogin,userRoleMappingLst, "edit");
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_officer_edit_successfully");
			}else {
				bSuccess = officerService.addUser(tblOfficer, tblUserLogin,userRoleMappingLst, "new");
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_officer_create_successfully");
			}

			if(!optType.equalsIgnoreCase("Edit")) {
			try {
					String hash = encrptDecryptUtils.encrypt(String.valueOf(tblUserLogin.getUserId()), registrationkey.substring(0, 16).getBytes()).replace("/", "~d~");
					String url = "http://"+stagingurl+"/eProcurement/verifyregistration/bidder/"+hash;
					String href = "<a href=\""+url+"\" />";
	               String content = "Thank you for registration. Your password is : "+password;
	               officerService.addMail(officerService.setTblMailMessage(emailId,mailFrom, "Registration details",content,"Registration details "));
	               String contentforadmin = "user registered in our system," + emailId;
	               officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, "Registration details",contentforadmin,"Registration details "));
				}catch (Exception e){
					exceptionHandlerService.writeLog(e);
                }
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return "redirect:/" + retVal;
    }
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/common/user/addbidder", method = RequestMethod.POST)
    public String addbidder(ModelMap modelMap, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
    	
    	String personName="";
    	String emailId="";
    	String phoneNo="";
    	String mobileNo="";
    	String password="";
    	String keywords="";
    	String optType="";
    	int countryId=0;
    	int stateId=0;
    	String city="";
    	String companyName="";
    	String address="";
    	int selTimezoneId;
    	String website="";
    	long userId=0;
    	int bidderId=0;
    	boolean bSuccess=false;
    	String redirect="";
    	SessionBean sessionBean=null;
    	TblCompany tblCompany = null;
    	Object[] bidderDtl = null;
    	int bidderDocId = 0;
    	String lastName="";
    	String middleName="";
    	String addressLine1="";
    			
		try {
			List<TblBidderSectorMapping> bidderSectorMappings = new ArrayList<TblBidderSectorMapping>();
			optType = StringUtils.hasLength(request.getParameter("hdOptType")) ? request.getParameter("hdOptType") : "";
			String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
			System.out.println(gRecaptchaResponse);
			boolean verify = false;
			if(isProductionServer && !optType.equalsIgnoreCase("edit")){
				verify = VerifyRecaptcha.verify(gRecaptchaResponse);
			}else{
				verify = true;
			}
			sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
			if(sessionBean!=null) {
				if(sessionBean.getUserTypeId()==2) {
					redirect = "redirect:/etender/bidder/bidderTenderListing/0";
				}else {
					redirect="redirect:/common/user/getmanagebidder";
				}
			}else {
				redirect="redirect:/registersuccess";
			}
			String categoryText="";
			    categoryText = StringUtils.hasLength(request.getParameter("categoryText")) ? request.getParameter("categoryText") :"";
			if(verify) {
				personName = StringUtils.hasLength(request.getParameter("txtFullName")) ? request.getParameter("txtFullName") :"";
				lastName = StringUtils.hasLength(request.getParameter("txtLastName")) ? request.getParameter("txtLastName") :"";
				middleName = StringUtils.hasLength(request.getParameter("txtMiddleName")) ? request.getParameter("txtMiddleName") :"";
				emailId = StringUtils.hasLength(request.getParameter("txtEmailId")) ? request.getParameter("txtEmailId") : "";
				phoneNo = StringUtils.hasLength(request.getParameter("txtPhoneNo")) ? request.getParameter("txtPhoneNo") :"";
				mobileNo = StringUtils.hasLength(request.getParameter("txtMobileNo")) ? request.getParameter("txtMobileNo") : "";
				password = StringUtils.hasLength(request.getParameter("txtPassword")) ? request.getParameter("txtPassword") : "";
				
				keywords = StringUtils.hasLength(request.getParameter("selKeywords")) ? request.getParameter("selKeywords") : "";
				mobileNo = StringUtils.hasLength(request.getParameter("txtMobileNo")) ? request.getParameter("txtMobileNo") : "";
				countryId = StringUtils.hasLength(request.getParameter("selCountry")) ? Integer.parseInt(request.getParameter("selCountry")) : 0;
				stateId = StringUtils.hasLength(request.getParameter("selState")) ? Integer.parseInt(request.getParameter("selState")) : 0;
				city = StringUtils.hasLength(request.getParameter("txtCity")) ? request.getParameter("txtCity") : "";
				companyName = StringUtils.hasLength(request.getParameter("txtCompanyName")) ? request.getParameter("txtCompanyName") : "";
				website = StringUtils.hasLength(request.getParameter("txtWebsite")) ? request.getParameter("txtWebsite") : "";
				address = StringUtils.hasLength(request.getParameter("txtaAddress")) ? request.getParameter("txtaAddress") : "";
				selTimezoneId = StringUtils.hasLength(request.getParameter("selTimezoneId")) ? Integer.parseInt(request.getParameter("selTimezoneId")) : 0;
				bidderDocId = StringUtils.hasLength(request.getParameter("bidderDocId")) ? Integer.parseInt(request.getParameter("bidderDocId")) : 0;
				addressLine1 = StringUtils.hasLength(request.getParameter("txtaAddressLine2")) ? request.getParameter("txtaAddressLine2") : "";
				int selOriginCountryId = StringUtils.hasLength(request.getParameter("selOriginCountryId")) ? Integer.parseInt(request.getParameter("selOriginCountryId")) : 0;
				String commercialRegNo = StringUtils.hasLength(request.getParameter("txtCommercialRegNo")) ? request.getParameter("txtCommercialRegNo") : "";
				String txtEstablishDate  = StringUtils.hasLength(request.getParameter("txtEstablishDate")) ? request.getParameter("txtEstablishDate") : "";
				String txtPostalAddressLine1 = StringUtils.hasLength(request.getParameter("txtPostalAddressLine1")) ? request.getParameter("txtPostalAddressLine1") : "";
				String txtPostalAddressLine2 = StringUtils.hasLength(request.getParameter("txtPostalAddressLine2")) ? request.getParameter("txtPostalAddressLine2") : "";
				int selPostalStateId = StringUtils.hasLength(request.getParameter("selPostalStateId")) ? Integer.parseInt(request.getParameter("selPostalStateId")) : 0;
				String txtPostalCity = StringUtils.hasLength(request.getParameter("txtPostalCity")) ? request.getParameter("txtPostalCity") : "";
				String txtDesignationName = StringUtils.hasLength(request.getParameter("txtDesignationName")) ? request.getParameter("txtDesignationName") : "";
				String txtPersonalMobileNo = StringUtils.hasLength(request.getParameter("txtPersonalMobileNo")) ? request.getParameter("txtPersonalMobileNo") : "";
				String txtPersonalPhoneNo = StringUtils.hasLength(request.getParameter("txtPersonalPhoneNo")) ? request.getParameter("txtPersonalPhoneNo") : "";
				String txtRegisterType = "R";
				
				String [] sector = request.getParameterValues("sector");
				String [] industry = request.getParameterValues("industry");
				String [] activity = request.getParameterValues("activity");
				
				if(optType.equalsIgnoreCase("edit")) {
					userId = StringUtils.hasLength(request.getParameter("hdUserId")) ? Integer.parseInt(request.getParameter("hdUserId")) : 0;
					bidderId = StringUtils.hasLength(request.getParameter("hdBidderId")) ? Integer.parseInt(request.getParameter("hdBidderId")) : 0;
					bidderDtl = officerService.getBiddderDetails(bidderId);
				}
				TblDesignation tblDesignation = new TblDesignation(0);
				TblUserLogin tblUserLogin = new TblUserLogin();
				tblUserLogin.setCstatus(0);
				tblUserLogin.setLoginid(emailId);
				if(optType.equalsIgnoreCase("edit")) {
					if(bidderDtl!=null) {
						tblUserLogin.setPassword(encrptDecryptUtils.encrypt(bidderDtl[13].toString(),passwordkey.substring(0, 16).toString().getBytes()));
					}
				}else {
						tblUserLogin.setPassword(encrptDecryptUtils.encrypt(password,passwordkey.substring(0, 16).toString().getBytes()));
				}
				tblUserLogin.setTblDesignation(tblDesignation);
				tblUserLogin.setCreatedby(1);
				tblUserLogin.setUserType(2);
				String pwd = "Bidder@"+Math.abs(new Random().nextInt());
				tblUserLogin.setPassword(encrptDecryptUtils.encrypt(pwd,passwordkey.substring(0, 16).toString().getBytes()));
				if(optType.equalsIgnoreCase("edit")) {
					tblUserLogin.setModifiedby(1);
					tblUserLogin.setDatemodified(commonService.getServerDateTime());
					tblUserLogin.setUserId(userId);
				}else {
					tblUserLogin.setIsFirstLogin(1);
					tblUserLogin.setDatecreated(commonService.getServerDateTime());
				}
				tblUserLogin.setTimezoneId(selTimezoneId);
				TblBidder tblBidder = new TblBidder();
				tblBidder.setAddress(address);
				tblBidder.setCity(city);
				tblBidder.setCompanyName(companyName);
				tblBidder.setCstatus(0);
				tblBidder.setEmailId(emailId);
				//tblBidder.setKeyword(keywords);
				tblBidder.setMobileno(mobileNo);
				tblBidder.setPersonName(personName);
				tblBidder.setLastName(lastName);
				tblBidder.setMiddleName(middleName);
				tblBidder.setPhoneno(phoneNo);
				tblBidder.setTblCountry(new TblCountry(0));
				tblBidder.setTblState(new TblState(stateId));
				tblBidder.setWebsite(website);
				tblBidder.setCreatedby(1);
				tblBidder.setTimezoneId(selTimezoneId);
				tblBidder.setBidderDocId(bidderDocId);
				tblBidder.setAddressline2(addressLine1);
				tblBidder.setCommercialRegNo(commercialRegNo);
				tblBidder.setDesignationName(txtDesignationName);
				tblBidder.setEstablishDate(commonService.convertStirngToUTCDate(client_dateformate,txtEstablishDate));
				tblBidder.setOriginCountryId(selOriginCountryId);
				tblBidder.setPersonalMobileNo(txtPersonalMobileNo);
				tblBidder.setPersonalPhoneNo(txtPersonalPhoneNo);
				tblBidder.setPostalAddressLine1(txtPostalAddressLine1);
				tblBidder.setPostalAddressLine2(txtPostalAddressLine2);
				tblBidder.setPostalCity(txtPostalCity);
				tblBidder.setPostalStateId(selPostalStateId);
				tblBidder.setRegisterType(txtRegisterType);
				if(optType.equalsIgnoreCase("edit")) {
					tblBidder.setModifiedby(1);
					tblBidder.setDatemodified(commonService.getServerDateTime());
					tblBidder.setBidderId(bidderId);
					tblBidder.setDatecreated(commonService.getServerDateTime());
				}else {
					tblBidder.setDatecreated(commonService.getServerDateTime());
				}
				tblCompany = new TblCompany();
				tblCompany.setCompanyname(companyName);
				tblCompany.setCreatedby(1);
				tblCompany.setCreatedon(commonService.getServerDateTime());
				if(optType.equalsIgnoreCase("edit")) {
					if(bidderDtl!=null) {
						tblCompany.setCompanyid((Integer)bidderDtl[14]);
					}
				}
				
				TblUserRoleMapping userRoleMapping = new TblUserRoleMapping();
				userRoleMapping.setTblRoles(new TblRoles(5));//bidder role = 5
				userRoleMapping.setTblUserlogin(tblUserLogin);
				for (int i = 0; i < sector.length; i++) {
					TblBidderSectorMapping bidderSectorMapping = new TblBidderSectorMapping();
					bidderSectorMapping.setSectorId(Integer.parseInt(sector[i]));
					bidderSectorMapping.setIndustry(Integer.parseInt(industry[i]));
					bidderSectorMapping.setActivity(Integer.parseInt(activity[i]));
					if(optType.equalsIgnoreCase("edit")) {
						bidderSectorMapping.setBidderId(tblBidder.getBidderId());
					}
					bidderSectorMappings.add(bidderSectorMapping);
				}
				if(optType.equalsIgnoreCase("edit")) {
					//bidderSectorMappings = officerService.getSectorMappingById(bidderId);
					bSuccess = officerService.addBidder(tblBidder, tblUserLogin,tblCompany, "edit",userRoleMapping,bidderSectorMappings);
					redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_bidder_edit_successfully");
				}else {
					
					bSuccess = officerService.addBidder(tblBidder, tblUserLogin,tblCompany, "new",userRoleMapping,bidderSectorMappings);
					redirectAttributes.addFlashAttribute("message", msg_bidder_create_successfully);
				}
				
				
				if(!optType.equalsIgnoreCase("edit")) {
					try {
						String hash = encrptDecryptUtils.encrypt(String.valueOf(tblUserLogin.getUserId()), registrationkey.substring(0, 16).getBytes()).replace("/", "~d~");
						String url = "http://"+stagingurl+"/eProcurement/verifyregistration/bidder/"+hash;
						String href = "<a href=\""+url+"\" />";
	                   String content = "Thank you for registration. Your password is : "+pwd+" </br> Click here to verify your email address : " + href;
	                   officerService.addMail(officerService.setTblMailMessage(emailId,mailFrom, "Registration details",content,"Registration details "));
	                   String contentforadmin = "Bidder registered in our system," + emailId;
	                   officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, "Registration details",contentforadmin,"Registration details "));
	                }catch (Exception e) {
	                	exceptionHandlerService.writeLog(e);
	                }
				}
				
				if(!categoryText.isEmpty()){
					officerService.saveCategoryData(tblBidder.getBidderId(), tblBidder.getTblUserlogin().getUserId(),0,0,categoryText);
				}
				//code to send password in mail
				
			}else {
				redirect="redirect:/common/user/register";	
				redirectAttributes.addFlashAttribute("message", "please enter valid captcha");
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return redirect;
    }
    
    
    /**
     * 
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/common/user/getmanageuser", method = RequestMethod.GET)
    public String getManageUser(ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    SessionBean sessionBean = null;
		try {
			sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
			if(sessionBean!=null) {
				TblDepartment tblGrandParentDept  = officerService.getDepartmentById(sessionBean.getGrandParentDeptId()==0?sessionBean.getDeptId():sessionBean.getGrandParentDeptId());
				modelMap.addAttribute("tblGrandParentDept", tblGrandParentDept);
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return "etender/buyer/ManageOfficers";
    }
    
    
   
    
    /**
     * 
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/common/user/getmanagebidder", method = RequestMethod.GET)
    public String getManageBidder(ModelMap modelMap, HttpServletRequest request) {
		try {
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return "etender/bidder/ManageBidders";
    }
    
    
    
    /**
     * 
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = {"/common/user/register"}, method = RequestMethod.GET)
    public String getBidderRegistration(ModelMap modelMap, HttpServletRequest request) {
    String redirect ="etender/bidder/CreateBidder";
    String countryJson = "";
	try {
		countryJson = getContryJson();
		int randNumber = Math.abs(new Random().nextInt());
		modelMap.addAttribute("countryJson", countryJson);
		modelMap.addAttribute("optType", "new");
		modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
		modelMap.addAttribute("tenderId", randNumber);
		modelMap.addAttribute("objectId", bidderRegistrationObjectId);
		modelMap.addAttribute("childId", randNumber);
		modelMap.addAttribute("subChildId", 0);
		modelMap.addAttribute("otherSubChildId", 0);
		modelMap.addAttribute("bidderSector", getSectorJson());
		
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} 
	return redirect;
    }

    @ResponseBody
    @RequestMapping(value = "/common/user/getstatebycountry/{countryId}", method = RequestMethod.GET)
    public String getStatebyCountry(@PathVariable("countryId") int countryId,ModelMap modelMap, HttpServletRequest request) {
    String countryJson = "[]";
	try {
		List<Object[]> countryList = commonService.getStates(countryId);
		if(countryList != null && !countryList.isEmpty()){
			countryJson = commonService.convertToGsonStr(countryList);
		}
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	}
	return countryJson;
    }

    
    /**
     * 
     * @param modelMap
     * @param request
     * @param officerId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/getIndustryData/{sector}", method = RequestMethod.GET)
    public List<Map<String,Object>> getIndustryData(ModelMap modelMap, HttpServletRequest request,@PathVariable("sector") int sector) {
    	return officerService.getIndustryData(sector);
    
    }
    
    @ResponseBody
    @RequestMapping(value = "/common/user/getActivityData/{sector}/{industry}", method = RequestMethod.GET)
    public List<Map<String,Object>> getActivityData(ModelMap modelMap, HttpServletRequest request,@PathVariable("sector") int sector,@PathVariable("industry") int industry) {
    	return officerService.getActivityData(sector,industry);
    }
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param officerId
     * @return
     */
    @RequestMapping(value = "/common/user/geteditbidder/{bidderId}/{editfrom}", method = RequestMethod.GET)
    public String getEditBidder(ModelMap modelMap, HttpServletRequest request,@PathVariable("bidderId") int bidderId,@PathVariable("editfrom") int editfrom) {
   	String redirect ="etender/bidder/CreateBidder";
   	String countryJson = "";
   	//List<Integer> tblBidderSector  = new ArrayList<Integer>();
   	//List<Object[]> bidderSectorLst = new ArrayList<Object[]>();
		try {
			countryJson = getContryJson();
			modelMap.addAttribute("countryJson", countryJson);
			Object[] bidderDtls = officerService.getBiddderDetails(bidderId);
			modelMap.addAttribute("optType", "Edit");    
			modelMap.addAttribute("bidderDtls", bidderDtls);
			modelMap.addAttribute(BIDDERID, bidderId);
			modelMap.addAttribute("editfrom", editfrom);
			modelMap.addAttribute("bidderSector", getSectorJson());
			modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
			if(!bidderDtls[5].equals("")){
		    	modelMap.addAttribute("txtPhoneNo1", bidderDtls[5].toString().split("-")[0]);
			    modelMap.addAttribute("txtPhoneNo2", bidderDtls[5].toString().split("-")[1]);
			    modelMap.addAttribute("txtPhoneNo", bidderDtls[5].toString().split("-").length>2 ? bidderDtls[5].toString().split("-")[2]:"");
		    }
		    if(!bidderDtls[5].equals("")){
		    modelMap.addAttribute("txtMobileNo1", bidderDtls[5].toString().split("-")[0]);
		    modelMap.addAttribute("txtMobileNo", bidderDtls[5].toString().split("-")[1]);
		    }
		    modelMap.addAttribute("establishDate", commonService.convertSqlToClientDate(client_dateformate, (Date)bidderDtls[22]));
			modelMap.addAttribute(BIDDERID, bidderId);
			modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
			modelMap.addAttribute("country", commonService.getCountryById((Integer)bidderDtls[9]));
			modelMap.addAttribute("origincountry", commonService.getCountryById((Integer)bidderDtls[20]));
		    modelMap.addAttribute("state", commonService.getStateById((Integer)bidderDtls[8]));
		    modelMap.addAttribute("postalState", commonService.getStateById((Integer)bidderDtls[31]));
		    modelMap.addAttribute("timeZone", commonService.getTimeZonebyId((Integer)bidderDtls[15]));
		    modelMap.addAttribute("objectId", bidderRegistrationObjectId);
		    StringBuilder sectors = new StringBuilder();
		    List<TblBidderSectorMapping> bidderSectorMappings = officerService.getSectorMappingById(bidderId);
		    /*for (TblBidderSectorMapping tblBidderSectorMapping : bidderSectorMappings) {
				sectors.append(officerService.getSectorNameById(tblBidderSectorMapping.getSectorId())).append(",");
				tblBidderSector.add(tblBidderSectorMapping.getSectorId());
				Object[] bidderSectorArray = new Object[2];
				bidderSectorArray[0] = tblBidderSectorMapping.getSectorId();
				bidderSectorArray[1] = officerService.getSectorNameById(tblBidderSectorMapping.getSectorId());
				bidderSectorLst.add(bidderSectorArray);
			}*/
		    
		    modelMap.addAttribute("bidderSectorMappings", bidderSectorMappings);
		    modelMap.addAttribute("sectors", sectors);
			List<Object[]> data = officerService.getCategoryMap(Integer.parseInt(bidderDtls[12].toString()),0,0);
			if(data != null && !data.isEmpty()){
				modelMap.addAttribute("categoryList", data);
			}
			//modelMap.addAttribute("tblBidderSector", tblBidderSector);
			//modelMap.addAttribute("bidderSectorLst", bidderSectorLst);
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return redirect;
    }
    
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param officerId
     * @return
     */
    @RequestMapping(value = "/common/user/getuserstatus/{bidderId}/{userstatus}/{tabId}/{isview}", method = RequestMethod.GET)
    public String getChangeUserStatus(ModelMap modelMap, HttpServletRequest request,@PathVariable("bidderId") int bidderId,@PathVariable("userstatus") int userstatus,@PathVariable("tabId") int tabId,@PathVariable("isview") int isView) {
   	String redirect="etender/bidder/Changebidderstatus";
   	String userStatusLabel = "";
   	String countryJson = "";
		try {
			if(userstatus==1) {
				if(tabId==0){
					userStatusLabel="Profile";
				}else if(tabId==28 && isView == 1){
					userStatusLabel="Reject bidder";
				}else if(tabId==25 && isView == 0){
					userStatusLabel="Activate bidder";
				}else{
					userStatusLabel="View Request (New bidder)";
				}
			}else if(userstatus==3) {
				userStatusLabel="Deactivate bidder";
			}
			modelMap.addAttribute("userStatusLabel", userStatusLabel);
			modelMap.addAttribute(BIDDERID, bidderId);
			modelMap.addAttribute("userstatus", userstatus);
			countryJson = getContryJson();
			modelMap.addAttribute("countryJson", countryJson);
			Object[] bidderDtls = officerService.getBiddderDetails(bidderId);
			modelMap.addAttribute("optType", "Edit");    
			modelMap.addAttribute("bidderDtls", bidderDtls);
			modelMap.addAttribute("establishDate", bidderDtls[22].toString());
			modelMap.addAttribute(BIDDERID, bidderId);
			modelMap.addAttribute("timezonelist", commonService.getTimezoneList(0));
			modelMap.addAttribute("country", commonService.getCountryById((Integer)bidderDtls[9]));
			modelMap.addAttribute("origincountry", commonService.getCountryById((Integer)bidderDtls[20]));
		    modelMap.addAttribute("state", commonService.getStateById((Integer)bidderDtls[8]));
		    modelMap.addAttribute("postalState", commonService.getStateById((Integer)bidderDtls[8]));
		    modelMap.addAttribute("timeZone", commonService.getTimeZonebyId((Integer)bidderDtls[15]));
		    modelMap.addAttribute("objectId", bidderRegistrationObjectId);
		    modelMap.addAttribute("tabId", tabId);
		    modelMap.addAttribute("isview", isView);
		    String remarks = "";
		    if(isView==1){
		    	remarks = officerService.getStatusRemarks(bidderId, userstatus, 1);
		    }
		    modelMap.addAttribute("remarks", remarks);
		    //StringBuilder sectors = new StringBuilder();
		    List<TblBidderSectorMapping> bidderSectorMappings = officerService.getSectorMappingById(bidderId);
		    /*for (TblBidderSectorMapping tblBidderSectorMapping : bidderSectorMappings) {
				sectors.append(officerService.getSectorNameById(tblBidderSectorMapping.getSectorId())).append(",");
			}*/
		    modelMap.addAttribute("bidderSectorMappings", bidderSectorMappings);
//		    modelMap.addAttribute("sectors", sectors);
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return redirect;
    }
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/common/user/addbidderstatus", method = RequestMethod.POST)
    public String addbidderStatus(ModelMap modelMap, HttpServletRequest request,final RedirectAttributes redirectAttributes) {
    	boolean bSuccess=false;
    	String redirect="";
    	SessionBean sessionBean=null;
    	String remarks="";
    	int userstatus=0;
    	int bidderId=0;
    	int tabId=0;
		try {
			sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
			if(sessionBean!=null) {
			redirect="redirect:/common/user/getmanagebidder";
			remarks = StringUtils.hasLength(request.getParameter("remarks")) ? request.getParameter("remarks") : "";
			userstatus = StringUtils.hasLength(request.getParameter("userstatus")) ? Integer.parseInt(request.getParameter("userstatus")) : 0;
			tabId = StringUtils.hasLength(request.getParameter("tabId")) ? Integer.parseInt(request.getParameter("tabId")) : 0;
			bidderId = StringUtils.hasLength(request.getParameter(BIDDERID)) ? Integer.parseInt(request.getParameter(BIDDERID)) : 0;
			Object[] bidderDtl  = officerService.getBiddderDetails(bidderId);
			officerService.updateBidderstatus(bidderId, userstatus,remarks);
			if(userstatus==1) {
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_bidder_approved_successfully");
				String url = "http://"+stagingurl+"/eProcurement/";
	            String href = "<a href=\""+url+"\" />";
	            String contentforbidder = "Your request for new bidder registration is approved. ";
	            officerService.addMail(officerService.setTblMailMessage(bidderDtl[0].toString(),mailFrom, "Your profile has been approved",contentforbidder,BIDDERSTATUSCHANGE));
				String contentforadmin = "New bidder request is approved successfully," + bidderDtl[1].toString()+"("+bidderDtl[0].toString()+")";
	            officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, BIDDERSTATUSCHANGE,contentforadmin,BIDDERSTATUSCHANGE));
			}else if(userstatus==2) {
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_bidder_rejected_successfully");
				String contentforadmin = "New bidder request is rejected," + bidderDtl[1].toString()+"("+bidderDtl[0].toString()+")";
				officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, BIDDERSTATUSCHANGE,contentforadmin,BIDDERSTATUSCHANGE));
				String url = "http://"+stagingurl+"/eProcurement/";
	            String href = "<a href=\""+url+"\" />";
	            String contentforbidder = "Your request for new bidder registration is rejected. You can re-register by clicking this link .." + href;
	            officerService.addMail(officerService.setTblMailMessage(bidderDtl[0].toString(),mailFrom, "Your profile has been rejected",contentforbidder,"Bidder Profile Rejection"));
			}else if(userstatus==3) {
				String url = "http://"+stagingurl+"/eProcurement/";
	            String href = "<a href=\""+url+"\" />";
	            String contentforbidder = "Your profile has been deactivated ";
	            officerService.addMail(officerService.setTblMailMessage(bidderDtl[0].toString(),mailFrom, "Your profile has been de-activated",contentforbidder,"Your profile has been de-activated"));
				redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_bidder_blacklisted_successfully");
				String contentforadmin = "Bidder is deactivated," + bidderDtl[1].toString()+"("+bidderDtl[0].toString()+")";
	            officerService.addMail(officerService.setTblMailMessage("sapan@cahoot-technologies.com",mailFrom, BIDDERSTATUSCHANGE,contentforadmin,BIDDERSTATUSCHANGE)); 
			}
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
		return redirect;
    }
    
    
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param officerId
     * @return
     */
    @RequestMapping(value = "/common/user/getaddlink", method = RequestMethod.GET)
    public String getAddLink(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblLink") TblLink tblLink) {
   	String redirect ="/common/AddLink";
		try {
			modelMap.addAttribute("tblLink", tblLink);
			modelMap.addAttribute("optType", "new");
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return redirect;
    }
    
    
    @RequestMapping(value = "/common/user/geteditlink/{linkId}", method = RequestMethod.GET)
    public String getEditLink(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblLink") TblLink tblLink,@PathVariable("linkId") int linkId) {
   	String redirect ="/common/AddLink";
		try {
			tblLink= officerService.getTblLinkById(linkId);
			modelMap.addAttribute("tblLink", tblLink);
			modelMap.addAttribute("optType", "edit");
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return redirect;
    }
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param officerId
     * @return
     */
    @RequestMapping(value = "/common/user/addlink", method = RequestMethod.POST)
    public String addLink(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblLink") TblLink tblLink,final RedirectAttributes redirectAttributes) {
   	String redirect ="redirect:/common/user/getaddlink";
   	String optType = "";
		try {
			optType = StringUtils.hasLength(request.getParameter("optType")) ? request.getParameter("optType") : "";
			officerService.addLink(tblLink,optType);
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return redirect;
    }
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param requestData
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/common/user/islinkexists", method = RequestMethod.POST)
    public String getIsDepartmentExists(ModelMap modelMap, HttpServletRequest request,@RequestBody String requestData) {
	    boolean isExist = false;
	    String link = "";
		try {
			link=requestData.split("=")[1].replaceAll("%2F", "/");
			isExist=officerService.isLinkExists(link);
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
	return String.valueOf(isExist);
    }
    
    
    /**
     * 
     * @param modelMap
     * @param request
     * @param officerId
     * @return
     */
    @RequestMapping(value = "/common/user/getroleslink", method = RequestMethod.GET)
    public String getRolesLink(ModelMap modelMap, HttpServletRequest request,@ModelAttribute("tblLink") TblLink tblLink) {
   	String redirect ="/common/RolesLink";
		try {
			modelMap.addAttribute("tblLink", tblLink);
			modelMap.addAttribute("optType", "new");
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return redirect;
    }
    
    
    /**
     * 
     * @param requestData
     * @param request
     * @param modelMap
     * @return
     */
   @RequestMapping(value = "/common/user/searchlinksbyrole", method = RequestMethod.POST)
   public String retriveUnMappedBidder(@RequestBody String requestData,HttpServletRequest request, ModelMap modelMap,final RedirectAttributes redirectAttributes) {
   	int roleId=0;
   	Map<String,List<TblLink>> linksMap = new HashMap<String, List<TblLink>>();
      try {
   	   if(""!=requestData && requestData!=null) {
   		roleId=Integer.parseInt(requestData.split("=")[1]);
   	   }
   	   List<TblRoleLinkMapping> roleLinkMappings = officerService.getLinksByRoleId(roleId);
   	   List<String> chkRooleLinkId = new ArrayList<String>();
           if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
               List<TblLink> tblLinkLst = officerService.getTblLinks();
               if(tblLinkLst!=null && !tblLinkLst.isEmpty()) {
            	   for (TblLink tblLink : tblLinkLst) {
            		   if(linksMap.containsKey(tblLink.getModule())) {
            			   ArrayList<TblLink> links = (ArrayList<TblLink>) linksMap.get(tblLink.getModule());
            			   links.add(tblLink);
            			   linksMap.put(tblLink.getModule(), links);
            		   }else {
            			   ArrayList<TblLink> links = new ArrayList<TblLink>();
            			   links.add(tblLink);
            			   linksMap.put(tblLink.getModule(), links);
            		   }
            	   }
            	   if(roleLinkMappings!=null && !roleLinkMappings.isEmpty()) {
            		for (TblRoleLinkMapping rolelink : roleLinkMappings) {
            			chkRooleLinkId.add(rolelink.getTblLink().getLinkId().toString());
					}
            	   }
            	   modelMap.addAttribute("linksMap", linksMap);
            	   modelMap.addAttribute("chkRooleLinkId", chkRooleLinkId);
            	   
               }
           } else {
               modelMap.addAttribute("sessionExpired", true);
           }
       } catch (Exception e) {
           exceptionHandlerService.writeLog(e);
       } 
       return "/common/SearchRolesLink";
   }
   
   
   /**
    * 
    * @param requestData
    * @param request
    * @param modelMap
    * @return
    */
  @RequestMapping(value = "/common/user/addlinkstorole", method = RequestMethod.POST)
  public String addLinksToRole(HttpServletRequest request, ModelMap modelMap,@ModelAttribute("tblLinksRolesDataBean") TblLinksRolesDataBean tblLinksRolesDataBean,final RedirectAttributes redirectAttributes) {
  	int roleId=0;
     try {
    	 roleId = StringUtils.hasLength(request.getParameter("hdRoleId")) ? Integer.parseInt(request.getParameter("hdRoleId")) : 0;
          if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
        	  if(tblLinksRolesDataBean.getChkLinkId()!=null && tblLinksRolesDataBean.getChkLinkId().length > 0) {
        		  String[] linkIds = tblLinksRolesDataBean.getChkLinkId();
        		  List<TblRoleLinkMapping> roleLinkMappings = new ArrayList<TblRoleLinkMapping>();
        		  for (int i = 0; i < linkIds.length; i++) {
        			  TblRoleLinkMapping roleLinkMapping = new TblRoleLinkMapping();
        			  roleLinkMapping.setTblLink(new TblLink(Integer.parseInt(linkIds[i])));
        			  roleLinkMapping.setTblRoles(new TblRoles(roleId));
        			  roleLinkMappings.add(roleLinkMapping);
        		  }	
        		  officerService.addRoleLinks(roleLinkMappings,roleId);
        		  redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_assignrights_successfully");
        	  }
          } else {
              modelMap.addAttribute("sessionExpired", true);
          }
      } catch (Exception e) {
          exceptionHandlerService.writeLog(e);
      } 
      return "redirect:/common/user/getroleslink";
  }

  
  /**
   * 
   * @param modelMap
   * @param request
   * @return
   */
  @RequestMapping(value = "/common/user/managelinks", method = RequestMethod.GET)
  public String getManageLinks(ModelMap modelMap, HttpServletRequest request) {
		try {
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		} 
	return "common/ManageLinks";
  }
    
  
  @RequestMapping(value = "/common/user/viewuser/{userId}/{usertype}", method = RequestMethod.GET)
  public String viewUserDetail(ModelMap modelMap, HttpServletRequest request,@PathVariable("userId") int userId,@PathVariable("usertype") int usertype,HttpSession session) {
  	List<Integer> tblUserRoles = null;
  	int grandParentDeptId=0;
  	SessionBean sessionBean = null;
  	String redirect="";
	try {
		sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		if(sessionBean!=null) {
			
		if(usertype==1) {	
	    Object[] officerDtl = officerService.getOfficerDetails(userId);
	    if(officerDtl!=null) {
	    	tblUserRoles = commonService.getUserRoleByUserId((Long)officerDtl[4]);
	    	TblDepartment  tblDepartment = officerService.getDepartmentById((Integer)officerDtl[6]); 
	    	if(tblDepartment!=null) {
	    		grandParentDeptId=tblDepartment.getGrandParentDeptId();
				if(grandParentDeptId!=0 && tblDepartment.getParentDeptId()!=0) {
					TblDepartment  tblParentDepartment = officerService.getDepartmentById(tblDepartment.getParentDeptId());
					TblDepartment  tblGrandParentDepartment = officerService.getDepartmentById(tblDepartment.getGrandParentDeptId());
					modelMap.addAttribute("grandParentDeptName", tblGrandParentDepartment.getDeptName());
					modelMap.addAttribute("parentDeptName", tblParentDepartment.getDeptName());
					modelMap.addAttribute("subDeptName", tblDepartment.getDeptName());
				}else if (grandParentDeptId!=0 && tblDepartment.getParentDeptId()==0) {
					TblDepartment  tblGrandParentDepartment = officerService.getDepartmentById(tblDepartment.getGrandParentDeptId());
					modelMap.addAttribute("grandParentDeptName", tblGrandParentDepartment.getDeptName());
					modelMap.addAttribute("parentDeptName", tblDepartment.getDeptName());
					modelMap.addAttribute("subDeptName", "-");
				}else if (grandParentDeptId==0 && tblDepartment.getParentDeptId()==0) {
					modelMap.addAttribute("grandParentDeptName", tblDepartment.getDeptName());
					modelMap.addAttribute("parentDeptName", "-");
					modelMap.addAttribute("subDeptName", "-");
				}
	    	}
	    	modelMap.addAttribute("designation", officerService.getDesignationById((Integer)officerDtl[7]).getDesignationName());
	    	redirect="etender/buyer/ViewOfficer";
		    modelMap.addAttribute("officerDtl", officerDtl);
		    modelMap.addAttribute("country", commonService.getCountryById((Integer)officerDtl[9]));
		    modelMap.addAttribute("state", commonService.getStateById((Integer)officerDtl[10]));
		    modelMap.addAttribute("timeZone", commonService.getTimeZonebyId((Integer)officerDtl[8]));
		    modelMap.addAttribute("officerDtl", officerDtl);
	      }
		}else if (usertype==2) {
			
		}
	    }
	} catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	} 
	return redirect;
  }
  
  private void addTenderAuthorityUser(ModelMap modelMap, HttpServletRequest request,int organizationId,TblDesignation tblDesignation,String password) {
	    	String officerName="";
	    	String emailId="";
	    	String phoneNo="";
	    	String mobileNo="";
	    	int selTimezoneId = 0;
	    	boolean bSuccess=false;
	    	String [] roleIds = null;
	    	int grandParentDeptId=0;
	    	int selCountry=0;
	    	int selState=0;
	    	String txtCity="";
	    	String txtaAddress="";
	    	String editfrom="";
	    	List<TblUserRoleMapping> userRoleMappingLst = new ArrayList<TblUserRoleMapping>();
	    	SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
			try {
				grandParentDeptId = organizationId;
				officerName = StringUtils.hasLength(request.getParameter("txtFullName")) ? request.getParameter("txtFullName") :"";
				emailId = StringUtils.hasLength(request.getParameter("txtEmailId")) ? request.getParameter("txtEmailId") : "";
				phoneNo = StringUtils.hasLength(request.getParameter("txtPhoneNo")) ? request.getParameter("txtPhoneNo") :"";
				mobileNo = StringUtils.hasLength(request.getParameter("txtMobileNo")) ? request.getParameter("txtMobileNo") : "";
				selTimezoneId = StringUtils.hasLength(request.getParameter("selTimezoneId")) ? Integer.parseInt(request.getParameter("selTimezoneId")) : 0;
				selCountry = StringUtils.hasLength(request.getParameter("selCountry"))? Integer.parseInt(request.getParameter("selCountry"))  : 0;
				selState = StringUtils.hasLength(request.getParameter("selState"))? Integer.parseInt(request.getParameter("selState"))  : 0;
				txtCity = StringUtils.hasLength(request.getParameter("txtCity"))? request.getParameter("txtCity")  : "";
				txtaAddress = StringUtils.hasLength(request.getParameter("txtaAddress"))? request.getParameter("txtaAddress")  : "";
				String txtPersonalMobileNo = StringUtils.hasLength(request.getParameter("txtPersonalMobileNo")) ? request.getParameter("txtPersonalMobileNo") : "";
				String txtPersonalPhoneNo = StringUtils.hasLength(request.getParameter("txtPersonalPhoneNo")) ? request.getParameter("txtPersonalPhoneNo") : "";
				roleIds = new String[]{"6"}; 
				TblUserLogin tblUserLogin = null;
				TblOfficer tblOfficer  = null;
				tblUserLogin = new TblUserLogin();
				tblOfficer = new TblOfficer();
				officerService.addDesignation(tblDesignation, "new");
				tblUserLogin.setCstatus(1);
				tblUserLogin.setLoginid(emailId);
				tblUserLogin.setTblDesignation(tblDesignation);
				tblUserLogin.setCreatedby(1);
				tblUserLogin.setUserType(1);
				tblUserLogin.setFailedattempt(0);
				tblUserLogin.setTimezoneId(selTimezoneId);
				tblUserLogin.setIsOrgenizationUser(1);
				tblUserLogin.setDatecreated(commonService.getServerDateTime());
				tblUserLogin.setIsFirstLogin(1);
				tblUserLogin.setPassword(password);
				tblUserLogin.setPassword(encrptDecryptUtils.encrypt(password,passwordkey.substring(0, 16).toString().getBytes()));
				
				tblOfficer.setEmailid(emailId);
				tblOfficer.setMobileno(txtPersonalMobileNo);
				tblOfficer.setOfficername(officerName);
				tblOfficer.setTblDesignation(tblDesignation);
				tblOfficer.setCstatus(1);
				tblOfficer.setPhoneNo(txtPersonalPhoneNo);
				tblOfficer.setCreatedby(1);
				tblOfficer.setDatemodified(commonService.getServerDateTime());
				tblOfficer.setTblDepartment(new TblDepartment(grandParentDeptId));
				tblOfficer.setCountryid(selCountry);
				tblOfficer.setStateid(selState);
				tblOfficer.setCity(txtCity);
				tblOfficer.setAddress(txtaAddress);
				tblOfficer.setDatecreated(commonService.getServerDateTime());
				
					for (String roleId : roleIds) {
						TblUserRoleMapping userRoleMapping = new TblUserRoleMapping();
						userRoleMapping.setTblRoles(new TblRoles(Integer.parseInt(roleId)));
						userRoleMapping.setTblUserlogin(tblUserLogin);
						userRoleMappingLst.add(userRoleMapping);
					}
					bSuccess = officerService.addUser(tblOfficer, tblUserLogin,userRoleMappingLst, "new");
				
			} catch (Exception ex) {
			    exceptionHandlerService.writeLog(ex);
			} 
	    }
  
  
  
  
    /**
     * 
     * @param parentDeptId
     * @return
     */
    private String getSubDeptListJson(int parentDeptId,String deptLevel) {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<TblDepartment> tblDepartments = officerService.getSubDepartments(parentDeptId,deptLevel);
				json.append("{\"value\":\"-1\",\"label\":\"Please select\"}").append(",");
				if(tblDepartments!=null && !tblDepartments.isEmpty()){
					for (TblDepartment tblDepartment : tblDepartments) {
						json.append("{\"value\":\""+tblDepartment.getDeptId()+"\",\"label\":\""+tblDepartment.getDeptName()+"\"}").append(",");
					}
				}
				jsonStr = json.toString().replaceAll(",$", "");
				jsonStr=jsonStr+"]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
    	return jsonStr;
    }
    
    /**
     * 
     * @param parentDeptId
     * @return
     */
    private String getGrandParentDeptList() {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<TblDepartment> tblDepartments = officerService.getGrandParentDepartments();
				json.append("{\"value\":\"-1\",\"label\":\"Please select\"}").append(",");
				if(tblDepartments!=null && !tblDepartments.isEmpty()){
					for (TblDepartment tblDepartment : tblDepartments) {
						json.append("{\"value\":\""+tblDepartment.getDeptId()+"\",\"label\":\""+tblDepartment.getDeptName()+"\"}").append(",");
					}
				}
				jsonStr = json.toString().replaceAll(",$", "");
				jsonStr=jsonStr+"]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
    	return jsonStr;
    }
    
    
    /**
     * 
     * @param parentDeptId
     * @return
     */
    private String getDesignationsByDeptId(int deptId) {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<TblDesignation> tblDesignations = officerService.getDesignationBydeptId(deptId);
				json.append("{\"value\":\"-1\",\"label\":\"Please select\"}").append(",");
				if(tblDesignations!=null && !tblDesignations.isEmpty()){
					for (TblDesignation tblDesignation : tblDesignations) {
						json.append("{\"value\":\""+tblDesignation.getDesignationId()+"\",\"label\":\""+tblDesignation.getDesignationName()+"\"}").append(",");
					}
				}
				jsonStr = json.toString().replaceAll(",$", "");
				jsonStr=jsonStr+"]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
    	return jsonStr;
    }
    
    /*
     * 
     */
    private String getRolesJson() {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<Object[]> tblRoles = commonService.getRoles();
				if(tblRoles!=null && !tblRoles.isEmpty()){
					for (Object[] object : tblRoles) {
						json.append("{\"value\":\""+object[0]+"\",\"label\":\""+object[1]+"\"}").append(",");
					}
				}
				jsonStr = json.toString().replaceAll(",$", "");
				jsonStr=jsonStr+"]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
    	return jsonStr;
    }
    
    
    private String getSectorJson() {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<Object[]> tblRoles = commonService.getBidderSectors();
				if(tblRoles!=null && !tblRoles.isEmpty()){
					for (Object[] object : tblRoles) {
						json.append("{\"value\":\""+object[0]+"\",\"label\":\""+object[1]+"\"}").append(",");
					}
				}
				jsonStr = json.toString().replaceAll(",$", "");
				jsonStr=jsonStr+"]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
    	return jsonStr;
    }
    
    
    /**
     * µ
     * @return
     */
    private String getContryJson() {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<Object[]> tblCountries = commonService.getCountries();
				if(tblCountries!=null && !tblCountries.isEmpty()){
					for (Object[] object : tblCountries) {
						json.append("{\"value\":\""+object[0]+"\",\"label\":\""+object[1]+"\"}").append(",");
					}
				}
				jsonStr = json.toString().replaceAll(",$", "");
				jsonStr=jsonStr+"]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} 
    	return jsonStr;
    }
}

