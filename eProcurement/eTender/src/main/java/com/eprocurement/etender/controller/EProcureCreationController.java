/* * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.io.File;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.EncrptDecryptUtils;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.TenderDtBean;
import com.eprocurement.etender.model.TblCorrigendum;
import com.eprocurement.etender.model.TblCurrency;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblEnvelope;
import com.eprocurement.etender.model.TblEventTermAndConditions;
import com.eprocurement.etender.model.TblOfficer;
import com.eprocurement.etender.model.TblPurchaseorder;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderWorkflow;
import com.eprocurement.etender.services.BidderSubmissionService;
import com.eprocurement.etender.services.CommitteeService;
import com.eprocurement.etender.services.DocumentService;
import com.eprocurement.etender.services.EProcureCreationService;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.OfficerService;
import com.eprocurement.etender.services.QuotationService;
import com.eprocurement.etender.services.ReportService;
import com.eprocurement.etender.services.TenderCommonService;
import com.google.gson.Gson;

/**
 *
 * @author branpariya
 */
@Controller
public class EProcureCreationController {

	@Autowired
	EProcureCreationService eProcureCreationService;
	@Value("#{projectProperties['doc_upload_path']}")
	private String docUploadPath;
	@Autowired
	DocumentService documentService;
	@Autowired
	EncrptDecryptUtils encryptDecryptUtils;

	@Autowired
	ExceptionHandlerService exceptionHandlerService;
	
	@Autowired
	TenderCommonService tenderCommonService;
	@Autowired
	CommonService commonService;
	@Autowired
	CommonDAO commonDAO;
	@Autowired
	CommitteeService committeeService;
    @Autowired
	FormService biddingFormService;
    @Autowired
    OfficerService officerService;
    @Autowired
    BidderSubmissionService eventBidSubmissionService;
    @Autowired
    QuotationService poService;
    @Autowired
    private ReportService reportService;
    
	
	static final String CREATE = "create";
	static final String EDIT = "edit"; 
	static final String TENDERID = "tenderId"; 
	static final String USERTYPE = "userType";
	static final String TBLTENDER = "tblTender";
	static final String VIEW = "view";
	
	
	

	static final String SESSIONOBJECT = "sessionObject"; 
	@Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	@Value("#{etenderProperties['msg_update_tender']}")
    private String msg_update_tender;
	@Value("#{etenderProperties['msg_create_tender']}")
    private String msg_create_tender;
	@Value("#{etenderProperties['msg_cancel_tender']}")
    private String msg_cancel_tender;
	@Value("#{projectProperties['tenderNITObjectId']}")
    private String tenderNITObjectId;
	@Value("#{projectProperties['tenderWorkflowObjectId']}")
    private String tenderWorkflowObjectId;
	@Value("#{etenderProperties['msg_publish_success']}")
    private String msg_publish_success;
	
	/**
     * submit and redirect createTender page TenderDtBean is ModelAttribute
     *
     * @param tenderDtBean
     * @param modelMap
     * @param request
     * @return String
     */
    @RequestMapping(value = "/etender/buyer/createevent/{tenderId}", method = RequestMethod.GET)
    public ModelAndView createEvent(@PathVariable(TENDERID)Integer tenderId, ModelMap modelMap, HttpServletRequest request) {
    	int clientId = 0;
        String retVal = "redirect:/sessionexpired";
        ModelAndView modelAndView = null; 
        TblDepartment tblOfficerDepartment = null;
        try {
        	
        	SessionBean sessionBean = (SessionBean) request.getSession().getAttribute(SESSIONOBJECT);
            if (sessionBean != null) {
            	Object[] officerDtls = officerService.getOfficerDetailsByUserId((int)sessionBean.getUserId());
            	
            	 List<Object[]> eventTypeList = tenderCommonService.getEventType();
            	 modelMap.addAttribute("eventTypeList",eventTypeList);
             	
                clientId = commonService.getSessionClientId(request);
                modelMap.addAttribute("eventName", "ENV");
                TenderDtBean tenderDtBean;
                if(tenderId != null && tenderId != 0){
                	tenderDtBean = eProcureCreationService.settTenderDataToTenderDtBean(tenderId);
                	modelMap.addAttribute("tenderDeptId",tenderDtBean.getSelDepartment());
            		modelMap.addAttribute("tenderOfficerId",tenderDtBean.getSelDeptOfficial());
    				List<Object[]> tenderEnvelopeList = tenderCommonService.getEnvelopeTypeByTenderId(tenderId);
    				modelMap.addAttribute("tenderEnvelopeList",tenderEnvelopeList);
    				modelMap.addAttribute("tenderOfficer",tenderDtBean.getSelDeptOfficial());
    				
    				List<Object[]> tenderCurrency= tenderCommonService.getCurrencyByTenderId(tenderId);
    				if(tenderCurrency != null && !tenderCurrency.isEmpty()){
    					for(Object[] obj : tenderCurrency){
    						int currencyId = Integer.parseInt(obj[0].toString());
    						tenderDtBean.setSelCurrencyId(currencyId);
    					}
    				}
                    modelMap.addAttribute("tenderDtBean", new Gson().toJson(tenderDtBean));
                    if(tenderDtBean.getSelBiddingType() ==2){
	                    List<Object[]> tblTenderCurrency = tenderCommonService.getCurrencyByTenderId(tenderId);
	                	modelMap.addAttribute("tblTenderCurrency",tblTenderCurrency);
                    }
                    tblOfficerDepartment = officerService.getDepartmentById(tenderDtBean.getTxtParentDepartment());
                }
                Integer deptId = sessionBean.getGrandParentDeptId();
                if(sessionBean.getIsOrgenizationUser() == 1){
                	deptId = sessionBean.getDeptId();	
                }else if(deptId == 0){
                	deptId = sessionBean.getParentDeptId();
                }
                List<Object[]> tblCurrencyMapList = commonService.getCurrencyMapList(deptId);
                if(tblCurrencyMapList != null){
					Map<Integer,Integer> map = new HashMap();
					for(Object[] obj : tblCurrencyMapList){
						map.put((Integer)obj[0], (Integer)obj[0]); //due to this we can direct check contains
					}
					modelMap.addAttribute("tblCurrencyMapList", map);
				}
                List<TblEnvelope> listTblEnv = tenderCommonService.getEnvelopeById(0);
                List<Object[]> tblCurrencyList = commonService.getCurrencyList(0);
                
                List<Object[]> tblOfficerList = tenderCommonService.getOfficerById(0);
                List<Object[]> tblDepartmentList = tenderCommonService.getDepartmentById(0);
                if(officerDtls!=null && tenderId==0) {
            		tblOfficerDepartment = officerService.getDepartmentById((Integer)officerDtls[6]);
                }
                
                if(tblOfficerDepartment!= null && tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
                	modelMap.addAttribute("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getGrandParentDeptId(), "0"));
                	modelMap.addAttribute("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
                	modelMap.addAttribute("parentDeptId",tblOfficerDepartment.getParentDeptId());
                    modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",officerService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
                }else if(tblOfficerDepartment!= null && tblOfficerDepartment.getParentDeptId()!=0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
                	modelMap.addAttribute("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
                	modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("parentDeptId",tblOfficerDepartment.getParentDeptId());
                	modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("subDeptName",officerService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
                	modelMap.addAttribute("organization",officerService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
                	modelMap.addAttribute("parentDeptName",officerService.getDepartmentById(tblOfficerDepartment.getParentDeptId()).getDeptName());
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
                }else if(tblOfficerDepartment!= null && tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()==0) {
                	modelMap.addAttribute("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getDeptId(), "0"));
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",officerService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
                	modelMap.addAttribute("parentDeptId",0);
                    modelMap.addAttribute("subDeptId",0);
                }
                List<Object[]> tblProcurementNature = tenderCommonService.getProcurementNatureById(0);
            	modelMap.addAttribute("tblCurrencyList",tblCurrencyList);
            	modelMap.addAttribute("officerName",sessionBean.getFullName());
            	modelMap.addAttribute("officerId",sessionBean.getOfficerId());
            	modelMap.addAttribute("tblProcurementNature",tblProcurementNature);
            	modelMap.addAttribute("listTblEnv",listTblEnv);
            	modelMap.addAttribute("clientId",clientId); 
            	modelMap.addAttribute("tblOfficerList",tblOfficerList);
            	modelMap.addAttribute("tblDepartmentList",tblDepartmentList);
				modelMap.addAttribute("objectId", 0);
				if(tenderId != 0){
				List<Object[]> data = officerService.getCategoryMap(0,tenderId,0);
					if(data != null && !data.isEmpty()){
						modelMap.addAttribute("categoryList", data);
					}
				}
                retVal = "/etender/buyer/CreateTender";
                modelAndView = new ModelAndView(retVal);
            }
        } catch (Exception e) {
        	exceptionHandlerService.writeLog(e);
        } finally {
        }
        return modelAndView;
    }

    @RequestMapping(value = {"/etender/buyer/viewtender/{tenderId}/{fromPublishTender}","/etender/bidder/viewtender/{tenderId}/{fromPublishTender}"}, method = RequestMethod.GET)
    public String viewTender(@PathVariable(TENDERID) Integer tenderId,@PathVariable("fromPublishTender") Integer fromPublishTender, ModelMap modelMap, HttpServletRequest request) {
    	String retVal = "redirect:/sessionexpired";
    	try{
    		
	        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
	        eProcureCreationService.viewTenderData(tenderId,modelMap);
    		modelMap.addAttribute("fromPublishTender", fromPublishTender);
    		TblTender tblTender = (TblTender) modelMap.get(TBLTENDER);
    		if(sBean != null && sBean.getUserTypeId() != 2){
    			modelMap.addAttribute("sessionUserTypeId", sBean.getUserTypeId());
    		}else{
    			modelMap.addAttribute("sessionUserTypeId", 2);
    		}
        	TblDepartment tblOfficerDepartment = officerService.getDepartmentById(tblTender.getDepartmentId());
        	if(tblOfficerDepartment!=null && tblOfficerDepartment.getGrandParentDeptId()!=0){
        		modelMap.addAttribute("organization",officerService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
                modelMap.addAttribute("subDeptName",officerService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());	
        	}
    		
    		retVal = "/etender/buyer/ViewTender";
    		
    	}catch(Exception e){
    		exceptionHandlerService.writeLog(e);
    	}
        return retVal;
    }
   
    @ResponseBody
    @RequestMapping(value ={"/etender/buyer/tenderListingCount/{type}"}, method = RequestMethod.POST)
    public Map<String,Object> tenderListingCount(HttpServletRequest request,@PathVariable("type") Integer type) throws Exception  {
    	HttpSession sesson = request.getSession();
    	SessionBean sessionBean =  (SessionBean) sesson.getAttribute(SESSIONOBJECT);
    	if(type == 1){//Tender
    		return eProcureCreationService.getTenderCount(sessionBean);
    	}else if(type == 2) {	// auction
    		return biddingFormService.getAuctionCount();
    	}else if(type == 3){	// bidder tender
    		long userId = sessionBean.getUserId();
	        return eProcureCreationService.getTenderCount(0,userId);
    	}else if(type == 4){	// bidder auction
    		long userId = sessionBean.getUserId();
	        return eProcureCreationService.getTenderCount(1,userId);
    	}
		return null;
    }
	@RequestMapping(value ={"/etender/buyer/tenderListing"}, method = RequestMethod.GET)
    public ModelAndView tenderListing(HttpServletRequest request)  {
        String retVal = "/etender/buyer/tenderListing";
        String sessionOut = "redirect:/sessionexpired";
        ModelAndView modelAndView = new ModelAndView(retVal);
    try{
        HttpSession sesson = request.getSession();
        if(sesson == null){
        	modelAndView = new ModelAndView(sessionOut);
        	return modelAndView;
        }
		SessionBean sessionBean =  (SessionBean) sesson.getAttribute(SESSIONOBJECT);
		if(sessionBean == null || sessionBean.getUserTypeId() == 2){
        	modelAndView = new ModelAndView(sessionOut);
        	return modelAndView;
        }
        Map<String,Object> tenderCount = eProcureCreationService.getTenderCount(sessionBean);
        List<Integer> deptId = commonService.getDeptDetailByUserId(sessionBean);
        String deptIdStr = commonService.convertListToCommaseparated(deptId);
        modelAndView.addObject("tenderCount", tenderCount);
        modelAndView.addObject("deptIdStr", deptIdStr);
        TblDepartment tblOfficerDepartment;
        Object[] officerDtls = officerService.getOfficerDetailsByUserId((int)sessionBean.getUserId());
        if(officerDtls!=null){
    		tblOfficerDepartment = officerService.getDepartmentById((Integer)officerDtls[6]);
        if(tblOfficerDepartment!= null && tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
        	modelAndView.addObject("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getGrandParentDeptId(), "0"));
        	modelAndView.addObject("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
        	modelAndView.addObject("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
        	modelAndView.addObject("parentDeptId",tblOfficerDepartment.getParentDeptId());
        	modelAndView.addObject("subDeptId",tblOfficerDepartment.getDeptId());
        	modelAndView.addObject("organization",officerService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
        }else if(tblOfficerDepartment!= null && tblOfficerDepartment.getParentDeptId()!=0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
        	modelAndView.addObject("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
        	modelAndView.addObject("subDeptId",tblOfficerDepartment.getDeptId());
        	modelAndView.addObject("parentDeptId",tblOfficerDepartment.getParentDeptId());
        	modelAndView.addObject("subDeptId",tblOfficerDepartment.getDeptId());
        	modelAndView.addObject("subDeptName",officerService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
        	modelAndView.addObject("organization",officerService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
        	modelAndView.addObject("parentDeptName",officerService.getDepartmentById(tblOfficerDepartment.getParentDeptId()).getDeptName());
        	modelAndView.addObject("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
        }else if(tblOfficerDepartment!= null && tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()==0) {
        	modelAndView.addObject("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getDeptId(), "0"));
        	modelAndView.addObject("grandParentDeptId",tblOfficerDepartment.getDeptId());
        	modelAndView.addObject("organization",officerService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
        	modelAndView.addObject("parentDeptId",0);
        	modelAndView.addObject("subDeptId",0);
        }
        }
	}catch(Exception e){
		exceptionHandlerService.writeLog(e);
	}
        return modelAndView;
    }
	@RequestMapping(value = "/etender/buyer/getEvaluationList/{committeeType}", method = RequestMethod.GET)
    public ModelAndView getpendingevaluation(HttpServletRequest request,@PathVariable("committeeType")Integer committeeType) {
        String retVal = "/etender/buyer/PendingEvaluationListing";
        ModelAndView modelAndView = new ModelAndView(retVal);
    try{
        SessionBean sessionBean = (SessionBean) request.getSession().getAttribute(SESSIONOBJECT);
        Integer officerId = Integer.parseInt(sessionBean.getOfficerId()+"");
        Map<String,Object> tenderEvaluationPendingCount = eProcureCreationService.getCommitteeEvaluationCount(officerId,0,committeeType);
        Map<String,Object> tenderEvaluationProcessCount = eProcureCreationService.getCommitteeEvaluationCount(officerId,1,committeeType);
        modelAndView.addObject("tenderEvaluationPendingCount", tenderEvaluationPendingCount);
        modelAndView.addObject("tenderEvaluationProcessCount", tenderEvaluationProcessCount);
    }catch(Exception e){
		exceptionHandlerService.writeLog(e);
	}
        return modelAndView;
    }
	@ResponseBody
	@RequestMapping(value = "/etender/buyer/validatePublishtender/{tenderId}", method = RequestMethod.GET)
    public String validatePublishtender(@PathVariable(TENDERID)Integer tenderId,ModelMap model, HttpServletRequest request,RedirectAttributes redirectAttributes) {
	  try{
			TblTender tblTender = tenderCommonService.getTenderById(tenderId);
			List<String> validationList = eProcureCreationService.validatePublishTender(tblTender);
			if(validationList != null && !validationList.isEmpty()){
				return commonService.convertToGsonStr(validationList);
			}
		}catch(Exception e){
			exceptionHandlerService.writeLog(e);
		}
		return "";
	}
	
	/**
	 * 
	 * @param tenderId
	 * @param request
	 * @param redirectAttributes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/etender/buyer/publishtender/{tenderId}", method = RequestMethod.GET)
    public String publishtender(@PathVariable(TENDERID)Integer tenderId,ModelMap model, HttpServletRequest request,RedirectAttributes redirectAttributes) throws Exception {
		String retVal;
		TblTender tblTender = tenderCommonService.getTenderById(tenderId);
		List<String> validationList = eProcureCreationService.validatePublishTender(tblTender);
		if(validationList == null || validationList.isEmpty()){
			retVal = "/etender/buyer/PublishTender";
			model.addAttribute(TBLTENDER, tblTender);
			if(tblTender.getisAuction() == 0){
				model.addAttribute("documentStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getDocumentStartDate()));
				model.addAttribute("documentEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getDocumentEndDate()));
				model.addAttribute("preBidEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getPreBidEndDate()));
				model.addAttribute("preBidStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getPreBidStartDate()));
				model.addAttribute("openingDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getOpeningDate()));
				model.addAttribute("submissionStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionStartDate()));
				model.addAttribute("submissionEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionEndDate()));
			}else{
				model.addAttribute("auctionStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getAuctionStartDate()));
				model.addAttribute("auctionEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getAuctionEndDate()));
			}
			
		}else{
			retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
			redirectAttributes.addFlashAttribute("publishTenderError",commonService.convertToGsonStr(validationList).toString());
		}
        return retVal;
    }
	
	/**
	 * 
	 * @param tenderId
	 * @param request
	 * @param redirectAttributes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/etender/buyer/submitPublishtender", method = RequestMethod.POST)
    public ModelAndView submitPublishtender(HttpServletRequest request,RedirectAttributes redirectAttributes) throws Exception {
		Integer tenderId = Integer.parseInt(request.getParameter(TENDERID));
		String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
		ModelAndView model = new ModelAndView(retVal);
		TblTender tblTender = null;
		try{
                    /*Envelope MinFormRequiredForBidding count Update*/
                    
            List<TblTenderEnvelope> lstTblTenderEnvelope=new ArrayList<TblTenderEnvelope>();
            lstTblTenderEnvelope=biddingFormService.getMinimumFormCountForBidding(tenderId);
            biddingFormService.updateMinimumBiddingFormReqForBidding(lstTblTenderEnvelope);
            tblTender = tenderCommonService.getTenderById(tenderId);
            if(tblTender.getIsWeightageEvaluationRequired() == 1){
            	biddingFormService.copyWeightageForCorrigendum(tenderId);
            }
			setUpdatedDateForPublish(request,tblTender);
			Integer userId = commonService.getSessionUserId(request);
			eProcureCreationService.publishTender(tblTender,userId);
                        
		}catch(Exception e){
			exceptionHandlerService.writeLog(e);
		}
		if(tblTender != null && tblTender.getisAuction() == 0){
			redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), msg_publish_success);
		}else{
			redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_auction_publish_success");
		}
        return model;
    }
	private void setUpdatedDateForPublish(HttpServletRequest request,TblTender tblTender) throws ParseException {
		TenderDtBean tenderDtBean = new TenderDtBean();
		tenderDtBean.setTxtDocumentStartDate(request.getParameter("txtDocumentStartDate"));
		tenderDtBean.setTxtDocumentEndDate(request.getParameter("txtDocumentEndDate"));
		tenderDtBean.setTxtSubmissionStartDate(request.getParameter("txtSubmissionStartDate"));
		tenderDtBean.setTxtSubmissionEndDate(request.getParameter("txtSubmissionEndDate"));
		tenderDtBean.setTxtBidOpenDate(request.getParameter("txtBidOpenDate"));
		tenderDtBean.setTxtPreBidStartDate(request.getParameter("txtPreBidStartDate"));
		tenderDtBean.setTxtPreBidEndDate(request.getParameter("txtPreBidEndDate"));
    	if(tblTender.getisAuction() == 1){
			String auctionStartDate = request.getParameter("txtAuctionStartDate");
			String auctionEndDate = request.getParameter("txtAuctionEndDate");
			tblTender.setAuctionStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,auctionStartDate));	
	    	tblTender.setAuctionEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,auctionEndDate));	
    	}
		tblTender.setDocumentStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtDocumentStartDate()));	
    	tblTender.setDocumentEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtDocumentEndDate()));	
        tblTender.setSubmissionStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtSubmissionStartDate()));
        tblTender.setSubmissionEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtSubmissionEndDate()));
        tblTender.setOpeningDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtBidOpenDate()));
        tblTender.setPreBidStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtPreBidStartDate()));
        tblTender.setPreBidEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtPreBidEndDate()));
    	tblTender.setRemark(request.getParameter("txtaRemarks"));
	}
	/**
	 * Show list of workflow
	 * @param userId
	 * @param processstatus
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/etender/buyer/workflowlist/{userId}/{processstatus}", method = RequestMethod.GET)
    public ModelAndView workflowlist(@PathVariable("userId")Integer userId,@PathVariable("processstatus") Integer processstatus, HttpServletRequest request) throws Exception {
		String retVal = "/etender/buyer/workflowList";
		ModelAndView model = new ModelAndView(retVal);
		model.addObject("officerId", tenderCommonService.getOffcerIdByUserId(userId));
        return model;
    }
	
	@RequestMapping(value = "/etender/buyer/addworkflow", method = RequestMethod.POST)
    public ModelAndView addWorkflow(HttpServletRequest request) {
		String actionId = request.getParameter("actionId");
		Integer tenderId = Integer.parseInt(request.getParameter(TENDERID));
		String workflowId = request.getParameter("workflowId");
		String uploadedDocumentId = request.getParameter("uploadedDocumentId");
		String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
		Integer loginUserId = commonService.getSessionUserId(request);
		ModelAndView model = new ModelAndView(retVal);
	try{
		Integer loginOfficerId = tenderCommonService.getOffcerIdByUserId(loginUserId);
		Integer corrigendumId = Integer.parseInt(request.getParameter("corrigendumId"));
		TblTenderWorkflow tblTenderWorkflow = new TblTenderWorkflow();
		tblTenderWorkflow.setAction(request.getParameter("actionId"));
		tblTenderWorkflow.setIsAuction(Integer.parseInt(request.getParameter("isAuction")));
		tblTenderWorkflow.setRemarks(request.getParameter("remarks"));
		tblTenderWorkflow.setTblTender(new TblTender(tenderId));
		tblTenderWorkflow.setCreatedDate(commonService.getServerDateTime());
		tblTenderWorkflow.setCreatedById(loginOfficerId);
		tblTenderWorkflow.setCorrigendumId(corrigendumId);

		if(workflowId != null && !workflowId.isEmpty() && !"0".equals(workflowId)){
			tblTenderWorkflow.setModifiedById(loginOfficerId);
			tblTenderWorkflow.setWorkflowId(Integer.parseInt(request.getParameter("workflowId")));
		}
		if("3".equals(actionId) || "4".equals(actionId) || "2".equals(actionId)){	// if approve,reject or return then give back to creator.
			List<Map<String,Object>> workflowMap = eProcureCreationService.getWorkflowDetail(tenderId,true,corrigendumId);
			for(Map<String,Object> map : workflowMap){
				String creator = map.get("forwardedBy").toString(); 
				tblTenderWorkflow.setTblOfficer(new TblOfficer(Integer.parseInt(creator)));
				if("2".equals(actionId)){
					tblTenderWorkflow.setCstatus(2);	// workflow is approve
				}
			}
		}else{
			tblTenderWorkflow.setTblOfficer(new TblOfficer(Integer.parseInt(request.getParameter("officerId"))));
		}
		if("2".equals(actionId)){
			eProcureCreationService.updateOldWorkflow(tenderId,corrigendumId,2);
		}else{
			eProcureCreationService.updateOldWorkflow(tenderId,corrigendumId,1);
		}
		tblTenderWorkflow.setWorkflowId(null);
		eProcureCreationService.saveOrUpdateWorkflow(tblTenderWorkflow);
		workflowId = tblTenderWorkflow.getWorkflowId().toString();
		if(uploadedDocumentId != null && !uploadedDocumentId.isEmpty()){
			String path = docUploadPath+File.separator+"Tender"+File.separator+tenderId+File.separator+tenderWorkflowObjectId+File.separator+corrigendumId+File.separator+"-1";
			documentService.changeDirectoryName(path,workflowId);
			eProcureCreationService.updateWorkflowDocumentDetail(workflowId,uploadedDocumentId);
		}
		/* for notification*/
		Map<String,Object> parameter = new HashMap();
		Long officerId = tblTenderWorkflow.getTblOfficer().getId();
		List<Object[]> userDetail= tenderCommonService.getUserByOfficerId(officerId);
		Integer userId = Integer.parseInt(userDetail.get(0)[2].toString());
		parameter.put("userId", userId);
		tenderCommonService.insertNotification(tenderId, parameter, loginUserId,5); // 5 for workflow notification. stored in tblprocess
	 }catch(Exception e){
		exceptionHandlerService.writeLog(e);
	 }
		return model;
    }
	
	@RequestMapping(value = "/etender/buyer/tenderDashboard/{tenderId}", method = RequestMethod.GET)
    public ModelAndView tenderDashboard(@PathVariable(TENDERID)Integer tenderId, HttpServletRequest request,RedirectAttributes redirectAttributes) {
        String retVal = "/etender/buyer/TenderDashboard";
        ModelAndView modelAndView = new ModelAndView(retVal);
        Date serverDateTime = commonService.getServerDateTime();
	try{
        if(request.getParameter("publishTenderError") != null){
			redirectAttributes.addFlashAttribute("publishTenderError",request.getParameter("publishTenderError"));
		}
        TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
        if(tblTender.getCstatus() == 1){
                if(tblTender.getisAuction()==1)
                {
                    Date submissionEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getAuctionEndDate().toString());
                    if(serverDateTime.compareTo(submissionEndDate) > 0){
                            modelAndView.addObject("AuctionDateOver", true);
                    }
                }
                else
                {
	        Date submissionEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getSubmissionEndDate().toString());
	        if(serverDateTime.compareTo(submissionEndDate) > 0){
	        	modelAndView.addObject("submissionDateOver", true);
	        }
	        Date openingDate = commonService.convertStringToDate(sql_dateformate, tblTender.getOpeningDate().toString());
                    
	        if(serverDateTime.compareTo(openingDate) > 0){
                    modelAndView.addObject("openingDateOver", true);
	        }
	        if(tblTender.getDocumentEndDate() != null){
		        Date documentEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getDocumentEndDate().toString());
		        if(serverDateTime.compareTo(documentEndDate) > 0){
		        	modelAndView.addObject("documentEndDateOver", true);
		        	boolean isAnyConsentReceived = eProcureCreationService.isAnyConsentReceived(tenderId);
		        	modelAndView.addObject("isAnyConsentReceived", isAnyConsentReceived);
		        }
	        }
	        if(tblTender.getPreBidEndDate()!= null){
		        Date prebidEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getPreBidEndDate().toString());
		        if(serverDateTime.compareTo(prebidEndDate) > 0){
		        	modelAndView.addObject("prebidEndDateOver", true);
		        }
	        }
	        
	        if(tblTender.getPreBidEndDate()!= null && tblTender.getPreBidStartDate()!=null){
		        Date prebidEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getPreBidEndDate().toString());
		        if(serverDateTime.compareTo(tblTender.getPreBidStartDate()) > 0 &&  serverDateTime.compareTo(prebidEndDate) < 0){
		        	modelAndView.addObject("prebidlive", true);
		        }
	        }
                }
        }
        Integer tenderCreatorUser = tblTender.getCreatedBy();
        Integer tenderCreatorOfficer = tenderCommonService.getOffcerIdByUserId(tenderCreatorUser);
        List<TblCorrigendum> tblCorrigendum = null;
        TblCorrigendum currentCorrigendum = null;
        if(tblTender.getCstatus() != 0){ // if tender published then only show corrigendum
	        tblCorrigendum = eProcureCreationService.getCorrigendumByTender(tenderId);
	        
	        for(TblCorrigendum corrigendum : tblCorrigendum){
	        	if(corrigendum.getCstatus() == 0){
	        		currentCorrigendum = corrigendum;
	        		modelAndView.addObject("currentCorrigendum", currentCorrigendum);
	        		break;
	        	}
	        }
	        modelAndView.addObject("tblCorrigendum", tblCorrigendum);
        }
        List<TblPurchaseorder> tblPurchaseorder = poService.getPurchaseOrderByTenderId(tenderId);
        Integer userId = commonService.getSessionUserId(request);
        Integer officerId = tenderCommonService.getOffcerIdByUserId(userId);	// workflow work on officerId
//        start for workflow
        if(tblTender.getIsWorkflowRequired() == 1){
        	/* workflow for tender */
        	List<Map<String,Object>> workflow = eProcureCreationService.getWorkflowDetail(tenderId,false,0);
        	String workflowInitiator = "";
        	Map<String,Object> workflowToMe = new HashMap<String, Object>();
	        if(workflow != null && !workflow.isEmpty()){
	        	for(Map<String,Object> map : workflow){
	        		if(workflowInitiator.isEmpty()){
	        			workflowInitiator = map.get("forwardedBy").toString();
	        		}
	        		if("0".equals(map.get("cstatus").toString()) && (map.get("forwardedTo").toString()).equals(officerId.toString())){ //workflow request for user
	        			if(workflowInitiator.equals(map.get("forwardedTo").toString())){	// check workflow return to initiator 
	        				modelAndView.addObject("workflowToInitiator", true);
	        			}
	        			workflowToMe = map;
	        		}else if("2".equals(map.get("cstatus").toString())){ // if workflow approve once then will not initiate again.
	        			modelAndView.addObject("workflowDone", true); // this will only true if workflow is approved.
	        			if((map.get("forwardedTo").toString()).equals(officerId.toString())){
		        			if(workflowInitiator.equals(map.get("forwardedTo").toString())){	// check workflow return to initiator 
		        				modelAndView.addObject("workflowToInitiator", true);
		        				break;
		        			}
	        			}
	       		        
	        		}
	        	}
	        	modelAndView.addObject("isTenderWorkflowStarted",true);
	        }else if(tblTender.getOfficerId() == officerId || tenderCreatorOfficer == officerId){
			    modelAndView.addObject("allowToCreateWorkflow",true); // Allow create workflow
	        }else{
	        	modelAndView.addObject("allowToCreateWorkflow",false); // Dont Allow create workflow
	        }
	        modelAndView.addObject("workflowToMe",workflowToMe); // workflow request reach to current user.
	        
	        /* workflow for tender End */
	        /* workflow for corrigendum start */
	        boolean isCurrentWorkflowStart = false;
        	if(tblTender.getCstatus()== 1 && tblCorrigendum != null && !tblCorrigendum.isEmpty()){	// workflow for current corrigendum only.
        		List<Map<String,Object>> corrigendumWorkflowList = new ArrayList<Map<String,Object>>();
        		workflowInitiator = "";
        		for(TblCorrigendum corrigendum :  tblCorrigendum){
        			Map<String,Object> cWorkflowMap = new HashMap();
	        		List<Map<String,Object>> corrigendumWorkflow = eProcureCreationService.getWorkflowDetail(tenderId,false,corrigendum.getCorrigendumId());
	        		boolean corrigendumWorkflowToMe = false;
	        		cWorkflowMap.put("isCorrigendumWorkflowStarted",false);
	    	        if(corrigendumWorkflow != null && !corrigendumWorkflow.isEmpty()){
	    	        	for(Map<String,Object> map : corrigendumWorkflow){
	    	        		if(workflowInitiator.isEmpty()){
	    	        			workflowInitiator = map.get("forwardedBy").toString();
	    	        		}
	    	        		if("0".equals(map.get("cstatus").toString()) && (map.get("forwardedTo").toString()).equals(officerId.toString())){ //workflow request for user
	    	        			if(workflowInitiator.equals(map.get("forwardedTo").toString())){	// check workflow return to initiator 
	    	        				modelAndView.addObject("corrigendumWorkflowToInitiator", true);
	    	        			}
	    	        			corrigendumWorkflowToMe = true;
	    	        			modelAndView.addObject("isCorrigendumWorkflowStarted",true);
	    	        		}else if("0".equals(map.get("cstatus").toString())){
	    	        			
	    	        			modelAndView.addObject("isCorrigendumWorkflowStarted",true);
	    	        			
	    	        		}else if("2".equals(map.get("cstatus").toString())){ // if workflow approve once then will not initiate again.
	    	        			modelAndView.addObject("corrigendumWorkflowDone", true); // this will only true if workflow is approved.
	    	        			if((map.get("forwardedTo").toString()).equals(officerId.toString())){
	    		        			if(workflowInitiator.equals(map.get("forwardedTo").toString())){	// check workflow return to initiator 
	    		        				modelAndView.addObject("corrigendumWorkflowToInitiator", true);
	    		        			}
	    		        			// is workflow initated for current corrigendum then dont allow edit corrigendum
	    	        			}
	    	       		       
	    	        		}
	    	        		if(currentCorrigendum != null && (currentCorrigendum.getCorrigendumId()+"").equals(map.get("corrigendumId").toString())){
	    	        			isCurrentWorkflowStart = true;
	            			}
	    	        	}
	    	        	cWorkflowMap.put("isCorrigendumWorkflowStarted",true);
	    	        }else if(tblTender.getOfficerId() == officerId || tenderCreatorOfficer == officerId){
	    	        	cWorkflowMap.put("corrigendumAllowToCreateWorkflow",true); // Allow to create workflow
	    	        	modelAndView.addObject("hideCorrigendumPublish",true);
	    	        }else{
	    	        	cWorkflowMap.put("corrigendumAllowToCreateWorkflow",false); // Dont Allow to create workflow
	    	        }
	    	        cWorkflowMap.put("corrigendumWorkflowToMe",corrigendumWorkflowToMe); // workflow request reach to current user.
	    	        cWorkflowMap.put("corrigendumId",corrigendum.getCorrigendumId()); 

	    	        corrigendumWorkflowList.add(cWorkflowMap);
        		}
    	       modelAndView.addObject("corrigendumWorkflowList",corrigendumWorkflowList);
    	       modelAndView.addObject("isCurrentWorkflowStart",isCurrentWorkflowStart);
        	}
        	/* workflow for corrigendum end */
	        /* Workflow status*/
        }
        modelAndView.addObject("prebidCommitteeId", committeeService.getCommitteeId(tenderId, 3));
        modelAndView.addObject("openingCommitteeId", committeeService.getCommitteeId(tenderId, 1));
        modelAndView.addObject("evaluationCommitteeId", committeeService.getCommitteeId(tenderId, 2));
        modelAndView.addObject("priceSummaryMap",biddingFormService.checkIfPriceSummryCreated(tenderId));
        modelAndView.addObject("evaluationMap", biddingFormService.checkIfEvaluationColumnSet(tenderId));
        modelAndView.addObject("biddingForm", biddingFormService.FormListing(tenderId));
        modelAndView.addObject("isSingleEnvelopeOpened", committeeService.isSingleEnvelopeIsOpened(tenderId));
        modelAndView.addObject("isSingleEnvelopeIsEvaluated", committeeService.isSingleEnvelopeIsEvaluated(tenderId));
        modelAndView.addObject("copyTenderRequired", eProcureCreationService.coyTenderLinkRequired(tblTender));
        modelAndView.addObject(TBLTENDER, tblTender);
        modelAndView.addObject("tenderNITObjectId", tenderNITObjectId);
        modelAndView.addObject("FormStatusLst",biddingFormService.getFormStatus(tenderId));
        modelAndView.addObject("currentDate",commonService.getServerDateTime());
        modelAndView.addObject("isAuction",tblTender.getisAuction());
        modelAndView.addObject("poId",tblPurchaseorder!=null && !tblPurchaseorder.isEmpty()?tblPurchaseorder.get(0).getPoid():0);
        modelAndView.addObject("isResultShareDone", tenderCommonService.isResultShareDone(tenderId));
        boolean isdecryptionlevelStarted  = reportService.isdecryptionlevel(tenderId);
        modelAndView.addObject("isdecryptionlevelStarted", isdecryptionlevelStarted);
	 }catch(Exception e){
		exceptionHandlerService.writeLog(e);
	 }
        return modelAndView;
    }
	
	@RequestMapping(value = "/etender/buyer/viewtenderworkflow/{tenderId}/{corrigendumId}", method = RequestMethod.GET)
    public ModelAndView viewTenderWorkflow(@PathVariable(TENDERID)Integer tenderId,@PathVariable("corrigendumId")Integer corrigendumId, HttpServletRequest request) {
        String retVal = "/etender/buyer/ViewTenderWorkflow";
        ModelAndView modelAndView = new ModelAndView(retVal);
       try{
        TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
        Integer loginUserId =  commonService.getSessionUserId(request);
        Integer officerId = tenderCommonService.getOffcerIdByUserId(loginUserId);	// workflow work on officerId
        /* Workflow status*/
        HashMap<String,String> officerNameMap =  tenderCommonService.getOfficerNameIdMap(0);
		modelAndView.addObject("officerNameMap", officerNameMap);
		List<String> processedOfficer = new ArrayList<String>();	// use for avoid duplicate user in process.
		processedOfficer.add(officerId.toString());	// because user can not to same user.
		Integer tenderCreatorUser = tblTender.getCreatedBy();
        Integer tenderCreatorOfficer = tenderCommonService.getOffcerIdByUserId(tenderCreatorUser);
        
        List<Map<String,Object>> workflowMap = eProcureCreationService.getWorkflowDetail(tenderId,false,corrigendumId);
        String workFlowIniatior = "";
        if(workflowMap != null && !workflowMap.isEmpty()){
        	
        	for(Map<String,Object> map : workflowMap){
        		if(workFlowIniatior.isEmpty()){
        			workFlowIniatior = map.get("forwardedBy").toString();	// first record will be initiator due to order by createddate asc.
        	        modelAndView.addObject("workFlowIniatior", workFlowIniatior);
        	        processedOfficer.add(workFlowIniatior);
        		}else if(!workFlowIniatior.equals(officerId.toString())){
	        		processedOfficer.add(map.get("forwardedTo").toString());
	        		processedOfficer.add(map.get("forwardedBy").toString());
        		}
        		String createdDate = map.get("createdDate").toString();
        		createdDate = commonService.convertSqlToClientDate(client_dateformate_hhmm, createdDate);
        		map.put("createdDate",createdDate);
        		if("0".equals(map.get("cstatus").toString()) && officerId.toString().equals(map.get("forwardedTo").toString())){
        	        modelAndView.addObject("allowCreateWF", true);
        		}else if("2".equals(map.get("cstatus").toString())){
                	modelAndView.addObject("allowCreateWF", false);	// workflow is approved so will not initiate again.
        		}
	        }
        }else{
        	if((tblTender.getCstatus() == 0 || (tblTender.getCstatus() == 1 && corrigendumId != 0)) && (officerId == tblTender.getOfficerId() || officerId == tenderCreatorOfficer)){
    	        modelAndView.addObject("allowCreateWF", true);
    		}
        }
        modelAndView.addObject(TENDERID, tenderId);
        modelAndView.addObject("objectId", tenderWorkflowObjectId);
        modelAndView.addObject("childId", corrigendumId);
        modelAndView.addObject("subChildId", -1);
        modelAndView.addObject("otherSubChildId", 0);
        
	    StringBuilder json = new StringBuilder("[");
        List<TblDepartment> tblDepartments = officerService.getParentDepartments();
    	json.append("{\"value\":\"0\",\"label\":\"Please select\"}").append(",");
		if(tblDepartments!=null && !tblDepartments.isEmpty()){
			for (TblDepartment tblDepartment : tblDepartments) {
				json.append("{\"value\":\""+tblDepartment.getDeptId()+"\",\"label\":\""+tblDepartment.getDeptName()+"\"}").append(",");
			}
		}
		String jsonStr = json.toString().replaceAll(",$", "");
		jsonStr=jsonStr+"]";
		
		modelAndView.addObject("deptLst", jsonStr);	
        modelAndView.addObject("processedOfficer", processedOfficer);
        modelAndView.addObject("officerNameMap", officerNameMap);
        modelAndView.addObject("tblWorkflowForUser", workflowMap);
        modelAndView.addObject(TBLTENDER, tblTender);
       }catch(Exception e){
    	   exceptionHandlerService.writeLog(e);
       }
        return modelAndView;
    }

	
    @RequestMapping(value = "/etender/buyer/addtender", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView addTender(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes) {  
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        TenderDtBean tenderDtBean =  eProcureCreationService.setTenderParameters(request);
        boolean success = true;
        TblTender tblTender = new TblTender();
        TblTenderCurrency tblTenderCurrency = null;
        List<TblTenderCurrency> tblTenderCurrencys = null;
        TblTenderEnvelope tblTenderEnvelope = null;
        TblEnvelope tblEnvelope = null;	
        List<TblTenderEnvelope> lstTenderEnvelope = new ArrayList();
        String retVal = "redirect:/sessionexpired";
        String redirectMessage = null;
        TblTenderCurrency tblTenderCurrency1 = null;
        TblCurrency tblCurrency = new TblCurrency();
        int userId = 0;
        int tenderId = 0;
        String opType = null;
        int userDetailId = 0;
        boolean tenderPublishChk=true;
        int isItemWiseWinner = 0;
        try {
        	tenderId = tenderDtBean.getHdTenderId();
            opType = tenderDtBean.getHdOpType();
                userId = commonService.getSessionUserId(request);
                userDetailId = commonService.getSessionUserId(request);
                if (CREATE.equals(opType)) {
                    tenderPublishChk=true;
                } else {
                    tblTender = eProcureCreationService.getTenderMaster(tenderId);
                   tenderPublishChk = (tblTender.getCstatus()!=1);
                }
                if (tenderPublishChk) {
                    String currIdList = request.getParameter("txtCommaSepCur");
                    StringTokenizer stcurrIdList = null;

                    if (StringUtils.hasLength(currIdList)) {
                        stcurrIdList = new StringTokenizer(currIdList, ",");
                    }
                    if (StringUtils.hasLength(tenderDtBean.getTxtaTenderBrief()) && StringUtils.hasLength(tenderDtBean.getRtfTenderDetail()) && StringUtils.hasLength(tenderDtBean.getTxtTenderNo()) ) {
                    	
                    	if(tenderDtBean.getOrganization()!=0 && tenderDtBean.getSubDept()!=0) {
                    		tblTender.setDepartmentId(tenderDtBean.getSubDept());
                    	}else if (tenderDtBean.getOrganization()!=0 && tenderDtBean.getSelDepartment()!=0 && tenderDtBean.getSubDept()==0) {
                    		tblTender.setDepartmentId(tenderDtBean.getSelDepartment());
                    	}else if (tenderDtBean.getOrganization()!=0 && tenderDtBean.getSelDepartment()==0 && tenderDtBean.getSubDept()==0) {
                    		tblTender.setDepartmentId(tenderDtBean.getOrganization());
                    	}
                        if(tenderDtBean.getSelIsItemwiseWinner() == 1){
                            tblTender.setTenderResult(2);
                            isItemWiseWinner = 1;
                        }else if(tenderDtBean.getSelIsItemwiseWinner() == 0){
                            tblTender.setTenderResult(1);
                            isItemWiseWinner = 0;
                        }
                        tblTender.setOfficerId(tenderDtBean.getSelDeptOfficial());
                        tblTender.setTenderNo(tenderDtBean.getTxtTenderNo());
                        tblTender.setTenderBrief(tenderDtBean.getTxtaTenderBrief());
                        tblTender.setRandPass("This is encryption decryption key");
                        tblTender.setCstatus(0);
                        if (CREATE.equalsIgnoreCase(opType)) {
                            tblTender.setCreatedBy(userDetailId);
                        }
                        tblTender.setAssignUserId(userId);
                        tblTender.setUpdatedBy(userDetailId);
                        if (opType.equals(CREATE)) {
                                tblTender.setIsOpeningByCommittee(tenderDtBean.getIsOpeningByCommittee());
                            	tblTender.setIsPartialFillingAllowed(tenderDtBean.getIsPartialFillingAllowed());
                            	tblTender.setIsWorkflowRequired(tenderDtBean.getSelIsWorkflowRequired());
                                tblTender.setBiddingVariant(tenderDtBean.getSelBiddingVariant());
                                tblTender.setIsEncodedName(tenderDtBean.getIsEncodedName());
                                tblTender.setIsMandatoryDocument(tenderDtBean.getIsMandatoryDocument());
                                tblTender.setIsEncDocumentOnly(tenderDtBean.getIsEncDocumentOnly());
                                tblTender.setSorVariation(tenderDtBean.getSorVariation());
                            if(isItemWiseWinner==1){ 
                            	 tblTender.setIsRebateForm(0);
                            }else{
                                 tblTender.setIsRebateForm(tenderDtBean.getIsRebateForm());
                            }
                                tblTender.setDecryptorRequired(tenderDtBean.getDecryptorRequired());
                                tblTender.setAutoResultSharing(tenderDtBean.getAutoResultSharing());
                    		 tblTender.setIsEvaluationRequired(1);
                    		 tblTender.setWinningReportMode(tenderDtBean.getWinningReportMode());
                        	 tblTender.setEventTypeId(tenderDtBean.getHdEventTypeId());
                        }
                        else if(opType.equals(EDIT))
                        {
                        	if (tenderDtBean.getSelTenderMode() == 1) {
                            	tblTender.setBrdMode(0);
                            }
                        	if(isItemWiseWinner==1){ // Grand total or Lot wise
                           	 tblTender.setIsRebateForm(0);
                        	}
                        }
                        tblTender.setIsWeightageEvaluationRequired(tenderDtBean.getSelIsWeightageEvaluationRequired());
                        
                        tblTender.setTenderDetail(tenderDtBean.getRtfTenderDetail());
                        tblTender.setBiddingType(tenderDtBean.getSelBiddingType());
                        tblTender.setEnvelopeType(tenderDtBean.getSelEnvelopeType());
                        if (tenderDtBean.getSelProcurementNatureId() == 5) {
                            tblTender.setOtherProcurementNature(tenderDtBean.getTxtOtherProcNature());
                        } else {
                            tblTender.setOtherProcurementNature("");
                        }
                        tblTender.setProcurementNatureId(tenderDtBean.getSelProcurementNatureId());
                        tblTender.setIsWorkflowRequired(tenderDtBean.getSelIsWorkflowRequired());
                        tblTender.setRemark("");
                        tblTender.setUpdatedOn(commonService.getServerDateTime());
                        if (StringUtils.hasLength(tenderDtBean.getTxtTenderValue())) {
                            tblTender.setTenderValue(new BigDecimal(tenderDtBean.getTxtTenderValue()).setScale(tenderDtBean.getSelDecimalValueUpto(), 2));
                        } else {
                            tblTender.setTenderValue(BigDecimal.ZERO);
                        }
                        tblTender.setIsItemwiseWinner(tenderDtBean.getSelIsItemwiseWinner());
                        if(tblTender.getIsItemwiseWinner() == 0)
                        {
                        	tblTender.setIsItemSelectionPageRequired(0);
                        }
                        tblTender.setBiddingVariant(tenderDtBean.getSelBiddingVariant());
                        if(tblTender.getBiddingVariant() == 2) 
                        {
                        	tblTender.setIsRebateForm(0); 
                        }
                        tblTender.setTenderMode(tenderDtBean.getSelTenderMode());
                        tblTender.setEventTypeId(tenderDtBean.getHdEventTypeId());
                        if (StringUtils.hasLength(tenderDtBean.getTxtProjectDuration())) {
                            tblTender.setProjectDuration(tenderDtBean.getTxtProjectDuration());
                        } else {
                            tblTender.setProjectDuration("0");
                        }
                        tblTender.setIsConsortiumAllowed(0);
                        tblTender.setIsFormBasedConsortium(tenderDtBean.getSelIsFormBasedConsortium());
                        tblTender.setIsBidWithdrawal(tenderDtBean.getSelIsBidWithdrawal());
                        tblTender.setIsPreBidMeeting(tenderDtBean.getSelIsPreBidMeeting());
                        if (tblTender.getIsPreBidMeeting() == 1) {
                            tblTender.setPreBidStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtPreBidStartDate()));
                            tblTender.setPreBidEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtPreBidEndDate()));
                            tblTender.setPreBidAddress(tenderDtBean.getTxtaPreBidAddress());
                        } else {
                            tblTender.setPreBidAddress("");
                            tblTender.setPreBidMode(2);
                        }
                        if(tenderDtBean.getTxtDocumentStartDate() != "" && tenderDtBean.getTxtDocumentStartDate() != null){
                        	tblTender.setDocumentStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtDocumentStartDate()));	
                        }
                        if(tenderDtBean.getTxtDocumentEndDate() != "" && tenderDtBean.getTxtDocumentEndDate() != null){
                        	tblTender.setDocumentEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtDocumentEndDate()));	
                        }
                        
                        tblTender.setSubmissionStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtSubmissionStartDate()));
                        tblTender.setSubmissionEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtSubmissionEndDate()));
                        tblTender.setOpeningDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtBidOpenDate()));
                        tblTender.setIsDocfeesApplicable(tenderDtBean.getSelIsDocfeesApplicable());
                        if (tblTender.getIsDocfeesApplicable() == 1) {
                            tblTender.setDocFeePaymentMode(tenderDtBean.getSelDocFeePaymentMode());
                            tblTender.setDocumentFee(new BigDecimal(tenderDtBean.getTxtDocumentFee() == null ? "0" : tenderDtBean.getTxtDocumentFee()).setScale(tenderDtBean.getSelDecimalValueUpto(), 2).toString());
                            tblTender.setDocFeePaymentAddress(tenderDtBean.getTxtaDocFeePaymentAddress());
                        } else {
                            tblTender.setDocumentFee("");
                            tblTender.setDocFeePaymentAddress("");
                        }
                        tblTender.setIsSecurityfeesApplicable(tenderDtBean.getSelIsSecurityfeesApplicable());
                        if (tblTender.getIsSecurityfeesApplicable() == 1) {
                            tblTender.setSecurityFee(new BigDecimal(tenderDtBean.getTxtSecurityFee()).setScale(tenderDtBean.getSelDecimalValueUpto(), 2).toString());
                            tblTender.setSecFeePaymentAddress(tenderDtBean.getTxtaSecFeePaymentAddress());
                        } else {
                            tblTender.setSecurityFee("");
                            tblTender.setSecFeePaymentAddress("");
                        }
                        tblTender.setIsEMDApplicable(tenderDtBean.getSelIsEMDApplicable());
                        if (tblTender.getIsEMDApplicable() == 1) {
                        	tblTender.setEmdAmount(new BigDecimal(tenderDtBean.getTxtEmdAmount() == null ? "0" : tenderDtBean.getTxtEmdAmount()).setScale(tenderDtBean.getSelDecimalValueUpto(), 2).toString());
                            tblTender.setEmdPaymentAddress(tenderDtBean.getTxtaEmdPaymentAddress());
                        } else {
                            tblTender.setEmdAmount("");
                            tblTender.setEmdPaymentAddress("");
                        }
                        tblTender.setCurrencyId(1);
                    }
                    tblTender.setAutoResultSharing(tenderDtBean.getSelAutoResultSharing());
                    tblTender.setIsRebateApplicable(tenderDtBean.getSelIsRebateApplicable());
                    tblCurrency.setCurrencyId(tenderDtBean.getSelCurrencyId());
                    tblTenderCurrency = new TblTenderCurrency();
                    tblTenderCurrency.setTblTender(tblTender);
                    tblTenderCurrency.setTblCurrency(new TblCurrency(tenderDtBean.getSelCurrencyId()));
                    tblTenderCurrency.setIsDefault(1);
                    tblTenderCurrency.setIsActive(1);
                    tblTenderCurrency.setExchangeRate(BigDecimal.ONE);
                    if (stcurrIdList != null && tblTender.getBiddingType() == 2) {
                        tblTenderCurrencys = new ArrayList();
                        while (stcurrIdList.hasMoreTokens()) {
                            String selCurId = stcurrIdList.nextToken();
                            if (Integer.parseInt(selCurId) != tenderDtBean.getSelCurrencyId()) {
                                tblCurrency.setCurrencyId(Integer.parseInt(selCurId));
                                tblTenderCurrency1 = new TblTenderCurrency();
                                tblTenderCurrency1.setTblTender(tblTender);
                                tblTenderCurrency1.setIsDefault(0);
                                tblTenderCurrency1.setTblCurrency(new TblCurrency(Integer.parseInt(selCurId)));
                                tblTenderCurrency1.setExchangeRate(BigDecimal.ZERO);
                                tblTenderCurrency1.setIsActive(1);
                                tblTenderCurrencys.add(tblTenderCurrency1);
                            }
                        }
                    }
                    if (tenderDtBean.getSelFormType() != null) {
                    	if(tblTender.getIsItemwiseWinner() != 0){
                        	boolean isGrandTotalWiseWinner = true;
	                    	for (int i = 0; i < tenderDtBean.getSelFormType().length; i++) {
	                    	
	                    		if(tenderDtBean.getSelFormType()[i].equals("4") || tenderDtBean.getSelFormType()[i].equals("5")) 
	                    		{
	                    			isGrandTotalWiseWinner = false;
	                    		}
	                    	}
	                    	if(isGrandTotalWiseWinner)
	                    	{
	                    		tblTender.setIsItemwiseWinner(0);
	                    	}
                    	}
                        for (int i = 0; i < tenderDtBean.getSelFormType().length; i++) {
                            tblTenderEnvelope = new TblTenderEnvelope();
                            tblTenderEnvelope.setEnvelopeName(tenderCommonService.getEnvelopeNameById(Integer.parseInt(tenderDtBean.getSelFormType()[i])));
                            tblTenderEnvelope.setTblTender(tblTender);
                            tblEnvelope = new TblEnvelope();
                            tblEnvelope.setEnvId(Integer.parseInt(tenderDtBean.getSelFormType()[i]));
                            if (tenderDtBean.getSelEventType() == 2) {
                                tblTenderEnvelope.setOpeningDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,tenderDtBean.getTxtBidOpenDate()));
                            }
                            tblTenderEnvelope.setSortOrder(i + 1);
                            tblTenderEnvelope.setNoOfFormsReq(0);
                            tblTenderEnvelope.setMinOpeningMember(0);
                            tblTenderEnvelope.setMinEvaluator(0);
                            tblTenderEnvelope.setIsOpened(0);
                            tblTenderEnvelope.setIsEvaluated(0);
                            tblTenderEnvelope.setCreatedBy(userDetailId);
                            tblTenderEnvelope.setCreatedOn(commonService.getServerDateTime());
                            tblTenderEnvelope.setCstatus(1);
                            tblTenderEnvelope.setTblEnvelope(tblEnvelope);
                            tblTenderEnvelope.setRemark("");
                            tblTenderEnvelope.setEnvelopeId(null);
                            lstTenderEnvelope.add(tblTenderEnvelope);
                            
                        }
                    }
                    if (CREATE.equals(opType)) {
                        success = eProcureCreationService.addTenderAllDetails(tblTender, tblTenderCurrency,tblTenderCurrencys,lstTenderEnvelope);
                    } else {
                        List<Integer> lstFormEnv = new ArrayList();
                        String txtRmvForm = tenderDtBean.getTxtRmvFormList();
                        StringTokenizer stRmvForm = null;
                        if (StringUtils.hasLength(txtRmvForm)) {
                            stRmvForm = new StringTokenizer(txtRmvForm, ",");
                        }
                        if (stRmvForm != null) {
                            while (stRmvForm.hasMoreTokens()) {
                                lstFormEnv.add(Integer.parseInt(stRmvForm.nextToken()));
                            }
                        }	
                        success = eProcureCreationService.updateTenderAllDetails(tblTender,lstTenderEnvelope,tblTenderCurrency,tblTenderCurrencys,lstFormEnv);
                    }
                    if (success) {
                    	officerService.saveCategoryData(0, 0l,tblTender.getTenderId(),0,request.getParameter("categoryText"));
                        if (EDIT.equals(opType)) {
                            redirectMessage = msg_update_tender;
                            retVal = "redirect:/etender/buyer/tenderDashboard/"+tblTender.getTenderId()+"?enc="+encryptDecryptUtils.encryptParam("/etender/buyer/tenderDashboard/"+tblTender.getTenderId());
                        } else {
                            redirectMessage = msg_create_tender;
                            retVal = "redirect:/etender/buyer/viewtender/"+tblTender.getTenderId()+"/0";
                        }
                    } else {
                        redirectMessage = CommonKeywords.ERROR_MSG_KEY.toString();
                        retVal = "redirect:/etender/buyer/tenderListing";
                    }
                   modelAndView = new ModelAndView(retVal);
                }
		} catch (Exception e) {
            success = false;
            exceptionHandlerService.writeLog(e);
        }
        redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), redirectMessage);
    	return modelAndView;
    }
    
    /**
     * 
     * @param tenderId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/etender/buyer/tendernitdocument/{tenderId}/{corrigendumId}", method = RequestMethod.GET)
    public ModelAndView getTenderNITDocument(@PathVariable(TENDERID)Integer tenderId,@PathVariable("corrigendumId")Integer corrigendumId, HttpServletRequest request,RedirectAttributes redirectAttributes) {
        String retVal = "/etender/buyer/TenderDocument";
        ModelAndView modelAndView = new ModelAndView(retVal);
       try{
        modelAndView.addObject(TENDERID, tenderId);
        modelAndView.addObject("objectId", tenderNITObjectId);
        modelAndView.addObject("childId", tenderId);
        modelAndView.addObject("subChildId", corrigendumId);
        modelAndView.addObject("otherSubChildId", 0);
        TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
        modelAndView.addObject("isAuction", tblTender.getisAuction());
      }catch(Exception e){
    	exceptionHandlerService.writeLog(e);
      }
        return modelAndView;
    }
    
    /**
     * 
     * @param tenderId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/etender/buyer/getcreatetermandconditions/{tenderId}", method = RequestMethod.GET)
    public ModelAndView getcreateTermAndConditions(@PathVariable(TENDERID)Integer tenderId, HttpServletRequest request) {
        String retVal = "/etender/buyer/EventTermAndCondition";
        ModelAndView modelAndView = new ModelAndView(retVal);
      try{
        TblEventTermAndConditions termAndConditions = eProcureCreationService.getTermAndConditionByEventId(tenderId);
        List<Object[]> clientTermAndCond = eventBidSubmissionService.getTenderBidConfirmForm(); 
        if(termAndConditions==null) {
        	modelAndView.addObject(TENDERID, tenderId);
        	if(clientTermAndCond!=null && !clientTermAndCond.isEmpty()) {
        		modelAndView.addObject("termAndCondition", clientTermAndCond.get(0)[1]);
        	}
        }else {
        	modelAndView.addObject(TENDERID, tenderId);
        	modelAndView.addObject("termAndCondition", termAndConditions.getTermNcondition());
        }
      }catch(Exception e){
    	exceptionHandlerService.writeLog(e);
      }
        return modelAndView;
    }
    
    @RequestMapping(value = "/etender/buyer/deleteTender/{tenderId}", method = RequestMethod.GET)
    public ModelAndView deleteTender(@PathVariable(TENDERID)Integer tenderId, HttpServletRequest request,RedirectAttributes attributes) {
        String retVal = "redirect:/etender/buyer/tenderListing";
        ModelAndView modelAndView=null;
        boolean success = false;
        String returnMsg="";
      try{
        TblTender tender = tenderCommonService.getTenderById(tenderId);
        
        if(tender.getCstatus() == 0){
        	eProcureCreationService.deleteTender(tenderId);
        	success = true;
        	returnMsg = "msg_tender_delete_success";
        	retVal = "redirect:/etender/buyer/tenderListing";
            modelAndView = new ModelAndView(retVal);
            	
        }else{
        	returnMsg = "msg_tender_can_notdelete";
        	retVal = "redirect:/etender/buyer/tenderDashboard";
            modelAndView = new ModelAndView(retVal);
            
        }
      }catch(Exception e){
    	exceptionHandlerService.writeLog(e);
      }
        attributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), returnMsg);
        return modelAndView;
    }
    
    /**
     * 
     * @param tenderId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/etender/buyer/addtermandconditions", method = RequestMethod.POST)
    public String addTermAndConditions(HttpServletRequest request) {
    	int tenderId  = 0;
        String retVal = "";
        String termAndCondition="";
        TblEventTermAndConditions termAndConditions = null;
        try {
        	tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
        	termAndCondition = StringUtils.hasLength(request.getParameter("termAndCondition")) ? request.getParameter("termAndCondition"): "";
        	termAndConditions = eProcureCreationService.getTermAndConditionByEventId(tenderId);
        	if(termAndConditions!=null) {
        		termAndConditions.setTermNcondition(termAndCondition);
        		eProcureCreationService.addTermAndCondition(termAndConditions, 1);
            }else {
            	termAndConditions = new TblEventTermAndConditions();
            	termAndConditions.setEventId(tenderId);
            	termAndConditions.setEventType(1);
            	termAndConditions.setTermNcondition(termAndCondition);
            	eProcureCreationService.addTermAndCondition(termAndConditions, 0);
            }
        	retVal ="redirect:/etender/buyer/tenderDashboard/"+tenderId;
        }catch(Exception e) {
        	exceptionHandlerService.writeLog(e);
        }
        return retVal;
    }
    
    
    /**
     * 
     * @param tenderId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/etender/buyer/getcanceltender/{tenderId}", method = RequestMethod.GET)
    public ModelAndView getCancelTender(@PathVariable(TENDERID)Integer tenderId, HttpServletRequest request) {
        String retVal = "/etender/buyer/CancelTender";
        ModelAndView modelAndView = new ModelAndView(retVal);
      try{
       TblTender tblTender= tenderCommonService.getTenderById(tenderId);
        modelAndView.addObject("isAuction",tblTender.getisAuction());
        modelAndView.addObject(TENDERID, tenderId);
      }catch(Exception e){
       	exceptionHandlerService.writeLog(e);
      }
        return modelAndView;
    }
    
    
    /**
     * 
     * @param tenderId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/etender/buyer/copytender/{tenderId}", method = RequestMethod.GET)
    public String copyTender(HttpServletRequest request,@PathVariable(TENDERID)Integer tenderId,HttpServletResponse response, RedirectAttributes redirectAttributes,HttpSession session) {
        String retVal = "";
        SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
        Map mapData=new LinkedHashMap();
        try {
        	if(sessionBean!=null) {
        		mapData = eProcureCreationService.copyTender(tenderId, (int)sessionBean.getUserId());
        		Map mapEnvelope=(Map)mapData.get("envIds");
        		int newTenderId = Integer.parseInt(mapData.get("newTenderId")+"");
        		try{
        			biddingFormService.copyFormForTenderCopy(String.valueOf(tenderId),String.valueOf(newTenderId),mapEnvelope);
                }catch(Exception e){
                    e.printStackTrace();
                }
        	    retVal ="redirect:/etender/buyer/tenderDashboard/"+newTenderId;
        	    if (newTenderId!=0) {
        	        redirectAttributes.addFlashAttribute(newTenderId!=0 ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), "Tender Copied successfully");
        	    }
        	}
        }catch(Exception e) {
        	exceptionHandlerService.writeLog(e);
        }
        return retVal;
    }
    
    
    /**
     * 
     * @param tenderId
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/etender/buyer/canceltender", method = RequestMethod.POST)
    public String cancelTender(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes) {
    	int tenderId  = 0;
        String retVal = "";
        String cancelTenderRemarks="";
        boolean bSuccess=false;
        String redirectMessage="";
        try {
        	SessionBean sessionBean = (SessionBean) request.getSession().getAttribute(SESSIONOBJECT);
        	if(sessionBean!=null) {
            	tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
            	cancelTenderRemarks = StringUtils.hasLength(request.getParameter("remarks")) ? request.getParameter("remarks"): "";
            	bSuccess= eProcureCreationService.cancelTender(cancelTenderRemarks,(int)sessionBean.getUserId(),tenderId);
            	redirectMessage = msg_cancel_tender;
            	retVal ="redirect:/etender/buyer/tenderDashboard/"+tenderId;
            	if (bSuccess) {
                    redirectAttributes.addFlashAttribute(bSuccess ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), redirectMessage);
                }
        	}
        }catch(Exception e) {
        	exceptionHandlerService.writeLog(e);
        }
        return retVal;
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
}  