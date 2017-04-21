/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.eprocurement.common.services.EncrptDecryptUtils;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.TenderRebateDetailBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblFinalsubmission;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderBidCurrency;
import com.eprocurement.etender.model.TblTenderCell;
import com.eprocurement.etender.model.TblTenderColumn;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderProxyBid;
import com.eprocurement.etender.model.TblTenderRebate;
import com.eprocurement.etender.model.TblTenderTable;
import com.eprocurement.etender.model.TblTenderbidconfirmation;
import com.eprocurement.etender.services.BidderSubmissionService;
import com.eprocurement.etender.services.EProcureCreationService;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.OfficerService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;

@Controller
@RequestMapping("/etender/bidder")
public class BidderSubmissionController {
   
	@Autowired
	EProcureCreationService eventCreationService;
    @Autowired
	private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private BidderSubmissionService eventBidSubmissionService;
    @Autowired
    private TenderService tenderFormService;
    @Autowired
    private EncrptDecryptUtils encrptDecryptUtils;
    @Autowired
    OfficerService officerService;
    @Autowired
    private FormService formService;
    @Autowired
    private MessageSource messageSource;
    
    @Value("#{projectProperties['mail.from']}")
    private String mailFrom;
    @Value("#{projectProperties['file.drive']}")
    private String drive;
    @Value("#{projectProperties['file.upload']}")
    private String upload;
    
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/notloggedin";
    private static final int FINALSUBMISSION_REQUEST_TYPE_POST = 1;
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String clientDateformatehhmm;
    private static final String HIDDEN_TENDER_ID = "hdTenderId";
    private static final String XFORWARDEDFOR = "X-FORWARDED-FOR";
    private static final String REDIRECTBIDDERDASHBOARD = "redirect:/etender/bidder/biddingTenderDashboard/";
    private static final String REDIRECTBIDDERDASHBOARDCONTENT = "redirect:/etender/bidder/biddingtenderdashboardcontent/";
    @Value("#{etenderProperties['decimalPoint']}")
    private int decimalPoint;
    /**
     * @param request
     */  
    @RequestMapping(value= "/bidderIagree" , method = RequestMethod.POST )
    public String  bidderAgreeFormSubmit(RedirectAttributes redirectAttributes,HttpServletRequest request, ModelMap modelMap){
    	int tenderId=Integer.parseInt(request.getParameter(HIDDEN_TENDER_ID));
    	String page = REDIRECT_SESSION_EXPIRED;
		try{
                   
    		HttpSession session = request.getSession();
    	    SessionBean sessionBean=(SessionBean)session.getAttribute(CommonKeywords.SESSION_OBJ.toString());
    	     
    	     if(sessionBean!=null){
    	    	 long userId =  sessionBean.getUserId(); 
    	    	 TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
	    	     int companyId = tblBidder.getTblCompany().getCompanyid();    	     
	    	     int bidderId = tblBidder.getBidderId();
	    	     
    	    	 boolean isRepeated = eventBidSubmissionService.isTenderIdRepeated(tenderId,bidderId);
    	    	 if(!isRepeated){
    	    		 String ipAdress = request.getHeader(XFORWARDEDFOR) != null ? request.getHeader(XFORWARDEDFOR) : request.getRemoteAddr();
		    	     int  clientBidtermId = Integer.parseInt(request.getParameter("hdClientBidTermId"));
		    	     TblTender tblTender = tenderCommonService.getTenderById(tenderId);
		    	     List<TblTenderProxyBid>lstTblTenderProxyBid = new ArrayList<TblTenderProxyBid>();
		    	     List<Object[]> cellValues = tenderFormService.getProxyColumnData(tenderId);
		        	 if(cellValues!=null && !cellValues.isEmpty()){
		        		for(int i=0; i<cellValues.size(); i++){
		        			TblTenderProxyBid tblTenderProxyBid = new TblTenderProxyBid();
			        		tblTenderProxyBid.setTblTender(new TblTender(tenderId));
			        		tblTenderProxyBid.setTblTenderTable(new TblTenderTable((Integer)cellValues.get(i)[0]));
			        		tblTenderProxyBid.setTblTenderColumn(new TblTenderColumn((Integer)cellValues.get(i)[1]));
			        		tblTenderProxyBid.setTblTenderCell(new TblTenderCell((Integer)cellValues.get(i)[2]));
			        		tblTenderProxyBid.setRowId((Short)cellValues.get(i)[3]);
			        		tblTenderProxyBid.setTblCompany(new TblCompany(companyId));
			        		tblTenderProxyBid.setCellValue("1");
			        		tblTenderProxyBid.setIpAddress(ipAdress);
			        		tblTenderProxyBid.setIsUpdatedFrom(1);
			        		tblTenderProxyBid.setCreatedBy((int)userId);
			        		lstTblTenderProxyBid.add(tblTenderProxyBid);
			        	}
		        	}	
		        	TblTenderbidconfirmation tblTenderBidConfirmation = new TblTenderbidconfirmation();
		    		tblTenderBidConfirmation.setTblTender( new TblTender(tenderId));
		    		tblTenderBidConfirmation.setTblCompany(new TblCompany(companyId));
		    		tblTenderBidConfirmation.setTermNcondId(clientBidtermId);
		    		tblTenderBidConfirmation.setEncodedname("test");//hardcode
		    		tblTenderBidConfirmation.setIpaddress(ipAdress);
		    		tblTenderBidConfirmation.setCreatedby((int)userId);
		    		tblTenderBidConfirmation.setBidderid(bidderId);
		    		
		    		int currencyId = 0;
		    		if(tblTender.getBiddingType()==2){
		    			String currencyList[] = null ;
		    			currencyList= request.getParameterValues("rdCurrency");
		    			if(currencyList!= null && currencyList.length>0){
		    				currencyId = Integer.parseInt(currencyList[0]);
         				}
		    			TblTenderBidCurrency tblTenderBidCurrency = new TblTenderBidCurrency();	
		    			tblTenderBidCurrency.setTblCompany(new TblCompany(companyId));
		    			tblTenderBidCurrency.setTblTenderCurrency(new TblTenderCurrency(currencyId));
		    			tblTenderBidCurrency.setUserId((int)userId);
		    			eventBidSubmissionService.addTenderBidCurrency(tblTenderBidCurrency);
		    		}
		    		
		    		eventBidSubmissionService.addTenderBidConfm(tblTenderBidConfirmation,lstTblTenderProxyBid);
		    		modelMap.addAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_already_iagreed");
					page =REDIRECTBIDDERDASHBOARDCONTENT+tenderId+"/"+2;
	    	    }else{
	    	    	modelMap.addAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_already_iagreed");
	    	    	redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_already_iagreed");
	    	    	page =REDIRECTBIDDERDASHBOARDCONTENT+tenderId+"/"+2;
    	    	}
    	    }
    	}
    	catch (Exception e) {
    		exceptionHandlerService.writeLog(e);
		}
        	
    	return page;
	}
    
    @RequestMapping(value = "/finalsubmission", method = RequestMethod.POST)
    public String finalSubmission(HttpServletRequest request, ModelMap modelMap, RedirectAttributes redirectAttributes) {
        int tenderId = 0;
        String pageView = REDIRECT_SESSION_EXPIRED;
        int bidderId = 0;
        try {
            if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
                SessionBean sessionBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                tenderId = StringUtils.hasLength(request.getParameter(HIDDEN_TENDER_ID)) ? Integer.parseInt(request.getParameter(HIDDEN_TENDER_ID)) : 0;
                bidderId = StringUtils.hasLength(request.getParameter("hdBidderId")) ? Integer.parseInt(request.getParameter("hdBidderId")) : 0;
                int companyId = StringUtils.hasLength(request.getParameter("hdComapnyId")) ? Integer.parseInt(request.getParameter("hdComapnyId")) : 0;
                String ipAddress = request.getHeader(XFORWARDEDFOR) != null ? request.getHeader(XFORWARDEDFOR) : request.getRemoteAddr();
                boolean isFinalSubmissionDone = false;
                int userId = (int) sessionBean.getUserId();
                if(eventBidSubmissionService.isTenderIdRepeated(tenderId, bidderId)){
                    if(eventBidSubmissionService.isFinalSubmissionDone(tenderId,companyId)){
                        redirectAttributes.addFlashAttribute("errorMsg", "msg_final_submission_already_completed");
                        isFinalSubmissionDone = true;
                    }
	                
	                TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
	                String finalSubmissionMsg = !isFinalSubmissionDone ? tenderCommonService.allowFinalSubmission(ipAddress, tenderId, companyId, bidderId, FINALSUBMISSION_REQUEST_TYPE_POST,userId,tblTender.getEnvelopeType(),tblTender.getIsRebateForm()) : "";
	                if (finalSubmissionMsg.contains("msg_tender_fs_finalsubmission_done")) {
	                    modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg.split("@")[0]);
	                    modelMap.addAttribute("msgArgumentOne", finalSubmissionMsg.split("@")[1]);
	                    modelMap.addAttribute("msgArgumentTwo", finalSubmissionMsg.split("@")[2]);//CommonUtility.convertTimezone(finalSubmissionMsg.split("@")[2]));
	                } else {
	                	//mail
	                    String subject = "You have successfully submitted your bid in tender ID:" + tenderId;
	                    String text = "Dear User, \n \n You have successfully submitted your bid in the following Tender: \n\n Tender ID :" + tenderId + "\n Reference No." +tblTender.getTenderNo()+ "\n Brief :"+tblTender.getTenderBrief()+"\n";
	                    officerService.addMail(officerService.setTblMailMessage(formService.getTblBidderCompanyId(companyId).getEmailId(),mailFrom, subject,text,subject));
	                    modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg);
	                }
                }else{
                    redirectAttributes.addFlashAttribute("errorMsg", "msg_temder_err_iagree");
                }
                /*}else{
                	int varBidderStatus = 0;
                	if(bidderStatus != null){
                		varBidderStatus = bidderStatus[1];
                	}
                	if(varBidderStatus == 3){
                		redirectAttributes.addFlashAttribute("errorMsg", "msg_user_not_approved_blacklisted");
                	}else if(varBidderStatus == 4){
                		redirectAttributes.addFlashAttribute("errorMsg", "msg_user_not_approved_expired");
                	}else if(varBidderStatus == 7){
                		redirectAttributes.addFlashAttribute("errorMsg", "msg_user_not_approved_rejected");
                	}else{
                		redirectAttributes.addFlashAttribute("errorMsg", "msg_user_not_approved");
                	}
                }*/
                pageView = "redirect:/etender/bidder/biddingtenderdashboardcontent/" + tenderId+"/"+6;
            }
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), linkFinalSubmission, postFinalSubmission, tenderId, 0);
        }
        return pageView;
    }
    @RequestMapping(value = "/deletebid/{tenderId}/{formId}/{bidId}", method = RequestMethod.GET)
    public String deleteBid(@PathVariable("tenderId") Integer tenderId, @PathVariable("formId") Integer formId, @PathVariable("bidId") Integer bidId, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String pageName = REDIRECT_SESSION_EXPIRED;
        try {
            SessionBean sessionBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
            if (sessionBean != null) {
            	int userId = (int)sessionBean.getUserId();
    	        TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
    	        String f = tenderCommonService.isSubmissionDateLapsed(tenderId).get(0).toString();
    	        if("false".equalsIgnoreCase(f)){
                    if (!eventBidSubmissionService.isFinalSubmissionDone(tenderId,tblBidder.getTblCompany().getCompanyid())) {
                            boolean success = eventBidSubmissionService.deleteBidSubmitted(bidId,tenderId,formId,tblBidder.getTblCompany().getCompanyid(),tblBidder.getBidderId());
                            redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(),success ?  "redirect_success_bid_delete" : "redirect_error_bid_delete");
                    } else {
                        redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "redirect_error_bid_submission_done");
                    }
                } else {
                    redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_submission_date_lapsed");
                }
    			pageName = "redirect:/etender/bidder/biddingtenderdashboardcontent/" + tenderId+"/"+5;
            }
        } catch (Exception e) {
            pageName = exceptionHandlerService.writeLog(e);
        }
        return pageName;
    }
    
    @RequestMapping(value = "/showbidwithdraw/{tenderId}", method = RequestMethod.GET)
    public String showBidWithdraw(@PathVariable("tenderId") int tenderId, ModelMap modelMap, HttpServletRequest request) {
    	String retVal = "etender/bidder/BidWithdrawDashboard";
        try {
            tenderCommonService.tenderSummary(tenderId, modelMap);
            modelMap.addAttribute("tenderId", tenderId);
        } catch (Exception e) {
            retVal =  exceptionHandlerService.writeLog(e);
        } finally {
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), bidWithdrawalLinkId, getBidwithdrawal, tenderId, 0);
        }
        return retVal;
    }
    
    @RequestMapping(value="/withdrawbid/{tenderId}", method=RequestMethod.POST)
    public String withdrawBid(@PathVariable("tenderId")int tenderId, ModelMap modelMap, HttpServletRequest request, RedirectAttributes redirectAttributes){
    	boolean success = false;
    	boolean isFinalSubmissionDone = false;
    	String remarks = null;
    	String redirectUrl = "etender/bidder/showbidwithdraw/";
    	String retVal="redirect:/sessionexpired";
    	String successMsgCode=null;
    	String failureMsgCode=CommonKeywords.ERROR_MSG_KEY.toString();
    	try {
    		remarks = StringUtils.hasLength(request.getParameter("txtaRemarks")) ? request.getParameter("txtaRemarks") : null;
    		SessionBean sessionBean = (SessionBean)request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
    		long userId =  sessionBean.getUserId(); 
	    	 TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
    		int bidderId = tblBidder.getBidderId();
    		if(sessionBean!=null && !"".equalsIgnoreCase(remarks) && remarks!=null){
    			String ipAddress = request.getHeader(XFORWARDEDFOR) != null ? request.getHeader(XFORWARDEDFOR) : request.getRemoteAddr();
    			int companyId = tblBidder.getTblCompany().getCompanyid();
    			isFinalSubmissionDone = eventBidSubmissionService.isFinalSubmissionDone(tenderId, companyId);
    			String f = tenderCommonService.isSubmissionDateLapsed(tenderId).get(0).toString();

    			if("false".equalsIgnoreCase(f)){
	    			if(isFinalSubmissionDone){
	    				TblFinalsubmission tblFinalsubmission =  tenderCommonService.getTblFinalsubmissionById(tenderId,companyId);
	    				success = eventBidSubmissionService.withdrawBid(tenderId, bidderId,  companyId, remarks, ipAddress,(int)userId,tblFinalsubmission);
	    				if(success){
		                    //mail
	    					TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
		                    String subject = "You have withdrawn your bid in tender ID:" + tenderId;
		                    String text = "Dear User, \n \n You have successfully withdrawn your bid in the following Tender: \n\n Tender ID :" + tenderId + "\n Reference No." +tblTender.getTenderNo()+ "\n Brief :"+tblTender.getTenderBrief()+"\n";
		                    officerService.addMail(officerService.setTblMailMessage(tblBidder.getEmailId(),mailFrom, subject,text,subject));

	    					retVal=REDIRECTBIDDERDASHBOARD+tenderId;
	        				successMsgCode = "msg_withdrawn_bid";
	        			}
	    				else {
	    					retVal="redirect:/"+redirectUrl+tenderId;
	    				}
	    			}else{
	    				success=false;
	    				failureMsgCode = "msg_final_submission_not_done";
	    				retVal="redirect:/"+redirectUrl+tenderId;
	    			}
    	        }else{
    	        	success=false;
    				failureMsgCode = "msg_submission_date_lapsed";
    				retVal="redirect:/"+redirectUrl+tenderId;
    	        }
    			redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? successMsgCode : failureMsgCode);
    		}
		} catch (Exception e) {
			retVal =  exceptionHandlerService.writeLog(e);
		}
    	return retVal;
    }
    
    @RequestMapping(value = "/bidform/{tenderId}/{envelopeId}/{formId}/{bidId}", method = RequestMethod.GET)
    public String bidForm(@PathVariable("tenderId") Integer tenderId,@PathVariable("envelopeId") Integer envelopeId, @PathVariable("formId") Integer formId,@PathVariable("bidId") Integer bidId, ModelMap modelMap, HttpServletRequest request) {
    	TblTenderForm tblTenderForm = null;
    	try{
	    	HttpSession session = request.getSession();
	    	SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
	    	if(sessionBean!= null && sessionBean.getUserTypeId() == 2 ){
	    		tblTenderForm = tenderFormService.getTenderFormById(formId);
    				modelMap.addAttribute("tblTenderForm", tblTenderForm);
    			    modelMap.addAttribute("bidId", bidId);
    	            modelMap.addAttribute("fromBidForm", true);
    	            tenderCommonService.tenderSummary(tenderId, modelMap);            
    	            modelMap.addAttribute("isCertRequired", Integer.parseInt(tenderCommonService.getTenderField(tenderId, "isCertRequired").toString()));
    	            modelMap.addAttribute("isItemSelectionPageRequired", Integer.parseInt(tenderCommonService.getTenderField(tenderId, "isItemSelectionPageRequired").toString()));
    	            modelMap.addAttribute("isPartialFillingAllowedForTender", Integer.parseInt(tenderCommonService.getTenderField(tenderId, "isPartialFillingAllowed").toString()));
    	            modelMap.addAttribute("bidderId",sessionBean.getUserId());
    	            modelMap.addAttribute("companyId", sessionBean.getCompanyId());
    	            tenderFormService.setViewFormNFormula(formId, modelMap, tenderId,(int)sessionBean.getUserId());
    	            setBidFormData(modelMap, request, tenderId, envelopeId);
    	            modelMap.addAttribute("CLIENT_DATETIME",clientDateformatehhmm);
    	            modelMap.addAttribute("rebateCellId", eventBidSubmissionService.getRebateCellId(formId));
    				return "/etender/bidder/BidForm";
	    	}else{
	    		return REDIRECT_SESSION_EXPIRED;
	    	}
		} catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
		}
    }
    
    @RequestMapping(value = "/crteditrebate/{tenderId}/{companyId}/{addEdtFlage}", method = RequestMethod.GET)             
    public String crtEditRebate(@PathVariable("tenderId") int tenderId,@PathVariable("companyId") int companyId,
   		 @PathVariable("addEdtFlage") int addEdtFlage,ModelMap modelMap, HttpServletResponse response, HttpServletRequest request){
    	String retVal = REDIRECT_SESSION_EXPIRED;
        try{
        	if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
        		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
        		int userId = (int)sBean.getUserId();
        		TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
	   			tenderCommonService.tenderSummary(tenderId, modelMap);
	   			
	   			List<Object[]> rebateFormDtls = tenderFormService.getRebateList(tenderId,tblBidder.getBidderId());
	   			List<TenderRebateDetailBean>  rebateFormList = new ArrayList<TenderRebateDetailBean>();
	   			for (Object[] objects : rebateFormDtls) {
	   				TenderRebateDetailBean detailBean = new TenderRebateDetailBean();
	   				detailBean.setFormName(objects[0].toString());
	   				detailBean.setTableName(objects[1].toString());
	   				detailBean.setColumnHeader(objects[2].toString());
	   				detailBean.setGTValue(encrptDecryptUtils.decrypt(objects[3].toString(),modelMap.get("randPass").toString().substring(0, 16).getBytes()));
	   				detailBean.setBidId(Integer.parseInt(objects[4].toString()));
	   				detailBean.setColumnId(Integer.parseInt(objects[5].toString()));
	   				rebateFormList.add(detailBean);
				}
	   			modelMap.put("decimalPoint", decimalPoint);
	   			modelMap.put("rebateFormList", rebateFormList);
	   			modelMap.addAttribute("tblTenderRebateDtls", tenderFormService.getTblTenderRebate(tenderId,companyId));
	   			
	            retVal = "etender/bidder/AddRebate";
        	}
        }
        catch(Exception e){
        	return exceptionHandlerService.writeLog(e);
        }
        return retVal;
    }
    @RequestMapping(value = "/editrebate", method = RequestMethod.POST)
    public String editRebate(RedirectAttributes redirectAttributes, HttpServletRequest request) {
    	boolean success=false;
    	String retVal = REDIRECT_SESSION_EXPIRED;
    	int tenderId = 0 ;
     	int companyId = 0;
        try{
        	if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
        		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
        		int userId = (int)sBean.getUserId();
        		tenderId = StringUtils.hasLength(request.getParameter(HIDDEN_TENDER_ID))? Integer.parseInt(request.getParameter(HIDDEN_TENDER_ID)):0;
        		companyId = StringUtils.hasLength(request.getParameter("hdCompanyId"))? Integer.parseInt(request.getParameter("hdCompanyId")):0;
        		String encryptVal = StringUtils.hasLength(request.getParameter("perEncVal"))? request.getParameter("perEncVal"):"";
         	
         	 	if( StringUtils.hasLength(encryptVal) && StringUtils.hasLength(encryptVal)){
         	 
	   	      	 	TblTenderRebate tblTenderRebate = new TblTenderRebate();
	   	      	 	tblTenderRebate.setRebateEncrypt(encryptVal);
	   	      	 	tblTenderRebate.setTblCompany(new TblCompany(companyId));
	   	      	 	tblTenderRebate.setTblTender(new TblTender(tenderId));
	   	      	 	tblTenderRebate.setRebateValue(encryptVal);
	   	      	 	tblTenderRebate.setRebateEncrypt(encryptVal);
	   	      	 	tblTenderRebate.setCreatedBy(userId);
   	          	
   	      		/*** Start Code to insert in TblTenderRebate table**/
   	      		success = eventBidSubmissionService.editTenderRebate(tenderId,tblTenderRebate,companyId);
         	 	}
       	 }	
         		
        }catch(Exception e){
        	return exceptionHandlerService.writeLog(e);
        }
        retVal = "redirect:/etender/bidder/biddingtenderdashboardcontent/" + tenderId+"/"+5;
        redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_success_bidder_rebate_add" : "msg_error_bidder_rebate_add");
        return retVal;
    }
    private void setBidFormData(ModelMap modelMap,HttpServletRequest request,int tenderId,int envelopeId)throws Exception{
        List<Object[]> tenderData = tenderCommonService.getTenderFields(tenderId, "encryptionLevel,decimalValueUpto,isItemSelectionPageRequired"); 
        int level = !tenderData.isEmpty() ? (Integer) tenderData.get(0)[0] : 0 ;
        int decimalUpto = !tenderData.isEmpty() ? (Integer) tenderData.get(0)[1] : 0 ;
        int isItemSelectionPageRequired = !tenderData.isEmpty() ? (Integer) tenderData.get(0)[2] : 0 ;
        modelMap.addAttribute("decimalUpto",decimalUpto);
        modelMap.addAttribute("isItemSelectionPageRequired",isItemSelectionPageRequired);
        modelMap.addAttribute("level",level);
}
    
    @RequestMapping(value = "/addrebate", method = RequestMethod.POST)
    public String addRebate(RedirectAttributes redirectAttributes, HttpServletRequest request) {
    	boolean success=false;
    	String retVal = REDIRECT_SESSION_EXPIRED;
    	int tenderId = 0 ;
    	int companyId = 0;
        try{
            if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
      	        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());

       	  	tenderId = StringUtils.hasLength(request.getParameter(HIDDEN_TENDER_ID))? Integer.parseInt(request.getParameter(HIDDEN_TENDER_ID)):0;
       	  	
       	  	companyId = StringUtils.hasLength(request.getParameter("hdCompanyId"))? Integer.parseInt(request.getParameter("hdCompanyId")):0;
       	  	String encryptVal = request.getParameter("perEncVal");
         	 	if(encryptVal!= null && StringUtils.hasLength(encryptVal)){
	         	 	TblTenderRebate tblTenderRebate = new TblTenderRebate();
	         	 	tblTenderRebate.setTblCompany(new TblCompany(companyId));
	         	 	tblTenderRebate.setTblTender(new TblTender(tenderId));
	         	 	tblTenderRebate.setRebateValue(encryptVal);
	         	 	tblTenderRebate.setRebateEncrypt(encryptVal);
	         	 	tblTenderRebate.setCreatedBy((int) sBean.getUserId());
	         		/*** Start Code to insert in TblTenderRebate table**/
	         		success = eventBidSubmissionService.addTenderRebate(tblTenderRebate);
         	 	}
       	 }	
        }catch(Exception e){
        	return exceptionHandlerService.writeLog(e);
        }
        retVal = "redirect:/etender/bidder/biddingtenderdashboardcontent/" + tenderId+"/"+5;
        redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_success_bidder_rebate_add" : "msg_error_bidder_rebate_add");
        return retVal;
    }   
    
    
    @RequestMapping(value ={"/uploadform"}, method = RequestMethod.POST)
    @ResponseBody
    public String uploadform(@RequestParam("hdFormId") String hdFormId, @RequestParam(HIDDEN_TENDER_ID) String hdTenderId,HttpSession session, HttpServletRequest request,@RequestParam("uploadFormData") CommonsMultipartFile multipartFile) {
    	
    	String data = null;
        boolean isValidate = true;   
        try {
        	SessionBean sessionBean= (SessionBean) session.getAttribute("sessionObject")!=null?(SessionBean) session.getAttribute("sessionObject"):new SessionBean();
        	 int userId = (int) sessionBean.getUserId();
        	 DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
             fileItemFactory.setSizeThreshold(1 * 1024 * 1024);
             ServletFileUpload uploadHandler = new ServletFileUpload(fileItemFactory);
             List items = uploadHandler.parseRequest(request);
             
            File file = null;
            File tmpDir = null;
            long fileSize = 0;
            String fileName = null;
            long fileMaxSize = 1024 * 1024;//1 MB
            String fileExtensions = "xls";

            Iterator itr = items.iterator();
            FileItem item = multipartFile.getFileItem();
                if (!item.isFormField()) {
                    fileSize = item.getSize();
                    if (item.getName().lastIndexOf("\\") != -1) {
                        fileName = item.getName().substring(item.getName().lastIndexOf("\\") + 1, item.getName().length());
                    } else {
                        fileName = item.getName();
                    }
                    if (fileName != null && !fileName.equalsIgnoreCase("")) {
                        if (fileSize == 0) {
                        	data=messageSource.getMessage("msg_tender_emptyfile", null, LocaleContextHolder.getLocale());
                            isValidate = false;
                        }
                        if (!checkFileSize(fileSize, fileMaxSize)) {
                        	data= messageSource.getMessage("msg_tender_filesizeexceeds", new Object[]{fileMaxSize / (1024*1024)}, LocaleContextHolder.getLocale());
                            isValidate = false;
                        }
                        if (!checkFileExn(fileName, fileExtensions)) {
                        	data=messageSource.getMessage("msg_tender_fileformatnotsupp", null, LocaleContextHolder.getLocale());
                            isValidate = false;
                        } else {
                            /* if destination directory not exist then create it*/
                            String tmpDirPath = drive + upload + "\\OfflineBid";
                            tmpDir = new File(tmpDirPath);
                            if (!tmpDir.isDirectory()) {
                                tmpDir.mkdir();
                            }
                            tmpDirPath = tmpDirPath + "\\" + hdFormId + "\\" + userId;
                            tmpDir = new File(tmpDirPath);
                            if (!tmpDir.isDirectory()) {
                                tmpDir.mkdirs();
                            }
                            file = new File(tmpDir, fileName);
                            item.write(file);
                        }
                    }
                }
            if (isValidate && file.exists()) {
                        FileInputStream fis = new FileInputStream(file);
                        HSSFWorkbook workbook = new HSSFWorkbook(fis);
                        //Get first sheet from the workbook
                        StringBuffer jsons = new StringBuffer();
                        List<Object[]> tables = formService.getTenderTableListByFormId(Integer.parseInt(hdFormId));
                        for (Object[] table : tables) {
                        	//abcUtility.reverseReplaceSpecialChars();
                            String tableName = table[1].toString().toString();
                            String sheetName = (tableName.length()>15 ? tableName.substring(0, 15) : tableName)+"-"+table[0].toString();                            
                            HSSFSheet sheet = workbook.getSheet(sheetName);
                            //Iterate through each rows from first sheet
                            Iterator<Row> rowIterator = sheet.iterator();
                            JSONArray jSONArray = new JSONArray();
                            int cellcount = 0;
                            int rowcount = 0;
                            while (rowIterator.hasNext()) {
                                Row row = rowIterator.next();
                                JSONObject jSONObject = new JSONObject();
                                //For each row, iterate through each columns
                                Iterator<Cell> cellIterator = row.cellIterator();
                                int cellno = 0;
                                int colcount = 0;
                                while (cellIterator.hasNext()) {
                                    if (rowcount == 0) {
                                        colcount++;
                                    }
                                    Cell cell = cellIterator.next();
                                    switch (cell.getCellType()) {
                                        case Cell.CELL_TYPE_NUMERIC:
                                            jSONObject.put(rowcount == 0 ? String.valueOf(cellcount) : (rowcount - 1) + "_" + cellno, cell.getNumericCellValue());
                                            break;
                                        case Cell.CELL_TYPE_STRING:
                                            jSONObject.put(rowcount == 0 ? String.valueOf(cellcount) : (rowcount - 1) + "_" + cellno, cell.getRichStringCellValue().toString());
                                            break;
                                        case Cell.CELL_TYPE_FORMULA:
                                            jSONObject.put(rowcount == 0 ? String.valueOf(cellcount) : (rowcount - 1) + "_" + cellno, cell.getNumericCellValue());
                                            break;
                                    }
                                    cellno++;
                                    cellcount++;
                                }
                                jSONArray.put(rowcount, jSONObject);
    //                                System.out.println("");
                                rowcount++;
                            }
                            jsons.append(jSONArray.toString()).append("@@@");
                        }
                        
                        data = jsons.length()>3 ? jsons.substring(0,jsons.length()-3) : jsons.toString();
                        fis.close();
            }
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        }
        System.out.println("data:----> "+ data);
        return isValidate ? data : "ERROR::" + data;
    }
    private boolean checkFileSize(long fielSize, long maxFileSize) {
        boolean chextn = false;
        if (maxFileSize > fielSize) {
            chextn = true;
        } else {
            chextn = false;
        }
        return chextn;
    }
    private boolean checkFileExn(String fileName, String allowExtensions) {
        boolean chextn = false;
        int j = fileName.lastIndexOf('.');
        String lst = fileName.substring(j + 1);
        String str = allowExtensions;
        String[] str1 = str.split(",");
        for (int i = 0; i < str1.length; i++) {
            if (str1[i].trim().equalsIgnoreCase(lst)) {
                chextn = true;
            }
        }
        return chextn;
    }
    @RequestMapping(value = {"/downloadform/{tenderId}/{formId}"}, method = RequestMethod.GET)
    public void donwloadform(@PathVariable("tenderId") int tenderId, @PathVariable("formId") int formId, HttpServletResponse response,HttpServletRequest request) {
        try {
            StringBuilder path = new StringBuilder();
            TblTenderForm tblTenderForm = tenderFormService.getTenderFormById(formId);
            path.append(drive).append(upload).append("\\OfflineBidForm\\").append(tenderId).append("\\").append(formId).append("\\");
            File folder = new File(path.toString());
            if(!folder.exists()){
                folder.mkdirs();
            }
            //correctFileName,reverseReplaceSpecialChars
            File file = new File(path.toString() + tblTenderForm.getFormName() + ".xls");
            if (true || !file.exists()) {
                Workbook wb = new HSSFWorkbook(); // Create New WorkBook
                List<Object[]> tables = formService.getTenderTableListByFormId(formId);
                for (Object[] table : tables) {                    
                int tableId = (Integer)table[0];
                List<Object[]> tableList = formService.getTenderTableDetails(tableId);                
                List<Object[]> headerList = formService.getTenderColumn(tableId);
                Map<Integer,Integer> sortVsColNo = new HashMap<Integer, Integer>();
                String tableName = !tableList.isEmpty() ? tableList.get(0)[2].toString(): "";
                int lastLocation = !tableList.isEmpty() ? (Integer) tableList.get(0)[6] : 0;
                List<TblTenderCell> contentList = formService.getTenderCellByTableIdNewOrderBy(tableId, 0);
                List<Object[]> formulaList = formService.getFormulaColId(tableId);
                int headerCount = 0;
                int contentCount = 0;
                int rowCount = 0;
                boolean isTotal = false;
                
                SessionBean sessionBean = (SessionBean)request.getSession().getAttribute("sessionObject");
                List<Object[]> visibleRows = null;
                Map<Integer,List<Integer>> tableRows = new HashMap<Integer, List<Integer>>();
                int isItemSelectionPageRequired = 0;
                if(sessionBean.getCompanyId()!=0){
                    isItemSelectionPageRequired = (Integer)tenderCommonService.getTenderField(tenderId, "isItemSelectionPageRequired");
                    visibleRows = tenderFormService.getSelectedRowsForBidding(formId, sessionBean.getCompanyId());
                    for (Object[] rows : visibleRows) {
                        List<Integer> rowIds = null;
                        if(tableRows.containsKey(rows[0])){                            
                            rowIds = tableRows.get(rows[0]);
                        }else{
                            rowIds = new ArrayList<Integer>();
                        }
                        rowIds.add((Integer)rows[1]);
                        tableRows.put((Integer)rows[0],rowIds);
                    }
                }
                
                Sheet sheet = wb.createSheet((tableName.length()>15 ? tableName.replaceAll("/", "").substring(0, 15) : tableName.replaceAll("/", ""))+"-"+tableId);// Create WorkSheet
                sheet.protectSheet("password"); //Protect WorkSheet                

                Font font = wb.createFont();  // Apply Font
                font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  // Font Face

                CellStyle headingStyle = wb.createCellStyle();// Object that create Style
                headingStyle.setLocked(true); // Lock Cell
                headingStyle.setFillForegroundColor(IndexedColors.BLUE_GREY.getIndex());
                font.setColor(IndexedColors.WHITE.getIndex());
                headingStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
                headingStyle.setAlignment(CellStyle.ALIGN_CENTER);
                headingStyle.setFont(font);

                CellStyle contentStyle = wb.createCellStyle();
                contentStyle.setLocked(true);                
//                contentStyle.setAlignment(CellStyle.ALIGN_RIGHT);//

                CellStyle enterNumeric = wb.createCellStyle();
                enterNumeric.setLocked(false); // Unlock Cell
//            
//            CellStyle totalStyle = wb.createCellStyle();
//            totalStyle.setAlignment(CellStyle.ALIGN_RIGHT);
//            totalStyle.setFont(font);
//            totalStyle.setLocked(true);

                int iscellAvail = -1;
                if (!headerList.isEmpty()) {
                    Row rowHeader = sheet.createRow(0);
                    for (Object[] head : headerList) {//List that Print Header in EXCEL
                        sortVsColNo.put((Integer)head[3], (Integer)head[4]);
                        String headerData = head[0].toString().replace("\\<.*?\\>", "");
                        Cell cell = rowHeader.createCell(headerCount);
                        cell.setCellValue(headerData);
                        cell.setCellStyle(headingStyle);
                        sheet.setColumnWidth(headerCount, 7000);
                        if((Integer)head[2]==0){                            
                            sheet.setColumnHidden(headerCount, true);
                        }
                        headerCount++;
                    }
                }
                int cellNum = 0;
                int columnNo = 0;
                int location = 0;
                int dataType = 0;
                int objectId = 0;
                int colNo = 0;
                String contentData;
                String formula;
                boolean addRow = false;
                boolean isnum = false;
                Row rowContent = sheet.createRow(1);                
                if (!contentList.isEmpty()) {// Loop until List is Not Empty
                    for (TblTenderCell obj2 : contentList) {// condition that is used to create new Row
                    	columnNo = obj2.getTblTenderColumn().getColumnNo();// ColId at CellMaster                                                
                    	location = obj2.getRowId() + 1;// Location +1 Because We have to Skip Header Part in EXCEL
                    	dataType = obj2.getDataType();                        
                    	objectId = obj2.getObjectId();
                    	contentData = obj2.getCellValue();// Data Located at cellMaster
                        if (contentCount % headerCount == 0) {// until formula list is not empty
                            rowCount++;
                            cellNum = 0;
                            addRow = false;
                            if(isItemSelectionPageRequired == 0 || tblTenderForm.getIsPriceBid() == 0 || (isItemSelectionPageRequired == 1 && tableRows.containsKey(tableId) && tableRows.get(tableId).contains(rowCount))){                                    
                                rowContent = sheet.createRow(rowCount);//Compare Formula colid to CellMaster colid and if Match then create formula Based On EXCEl                             
                                addRow = true;
                            }else{
                            	rowContent = sheet.createRow(rowCount);
                            	sheet.getRow(rowCount).setZeroHeight(true);
                            }                             
                        }
                        if(addRow){
                          if (!formulaList.isEmpty()) {//List that take each and every Formula from FormulaMaster 
                            for (Object[] obj1 : formulaList) {// until formula list is not empty
                                if (obj1[2].toString().startsWith("txtcell_")) {
                                	colNo = (Integer) obj1[5];
                                	formula = obj1[2].toString();
                                    if (colNo == columnNo) {//Compare Formula colid to CellMaster colid and if Match then create formula Based On EXCEl 
                                        StringBuilder finalFormula = new StringBuilder();
                                        if (dataType!=0){//else for (2*3) or (2*3+N_35) like Formula
                                            List<String> formulaArr = new ArrayList<String>();
                                            isnum = false;                                            
                                            for (int c = 0; c < formula.length(); c++) {
                                                char cc = formula.charAt(c);
                                                if (cc != 'N' && cc != '_') {
                                                    if (!isNumeric(String.valueOf(cc)) && cc != '.') {
                                                        formulaArr.add(String.valueOf(cc));
                                                        isnum = false;
                                                    } else {
                                                        if (isnum) {
                                                            formulaArr.set(formulaArr.size()-1, formulaArr.get(formulaArr.size()-1) + cc);
                                                        } else {
                                                            formulaArr.add(String.valueOf(cc));                                                            
                                                        }
                                                        isnum = true;
                                                    }
                                                }
                                            }                                            
                                            String formulaStr = formula.replaceAll("[_]", "").replaceAll("[\\+]", "_").replaceAll("[-]", "_").replaceAll("[\\)]", "_").replaceAll("[\\(]", "_").replaceAll("[\\*]", "_").replaceAll("[/]", "_");
                                            String[] arr = formulaStr.split("_");
                                            List<String> columns = new ArrayList<String>();
                                            for (int i = 0; i < arr.length; i++) {                        
                                                if (arr[i] != "" && arr[i].indexOf('N') == -1) {
                                                    columns.add(arr[i]);
                                                }
                                            }
                                            for (int cnt2 = 0; cnt2 < columns.size(); cnt2++) {
                                                for (int cnt3 = 0; cnt3 < formulaArr.size(); cnt3++) {
                                                    if (columns.get(cnt2).equals(formulaArr.get(cnt3))) {
                                                      formulaArr.set(cnt3, CellReference.convertNumToColString(sortVsColNo.get(Integer.parseInt(formulaArr.get(cnt3))) - 1)+location);
                                                    }
                                                }
                                            }
                                            for (String formulaChunk : formulaArr) {
                                                finalFormula.append(formulaChunk);
                                            }
                                            Cell cellContentFormula = rowContent.createCell(cellNum);
                                            cellContentFormula.setCellType(Cell.CELL_TYPE_STRING);
//                                            cellContentFormula.setCellFormula((finalFormula.toString()));
                                            cellContentFormula.setCellStyle(contentStyle);
                                            iscellAvail = cellNum;
                                       }
                                    } else {
                                        if (!(iscellAvail == cellNum)) {//To Protect OverWritting Data
                                            if (dataType==3 || dataType==4 || dataType==5) {// If data is Numeric create Cell Numeric Type
                                                Cell cellContentData = rowContent.createCell(cellNum);
                                                cellContentData.setCellType(Cell.CELL_TYPE_NUMERIC);
                                                if (StringUtils.hasLength(contentData)) {
                                                    cellContentData.setCellStyle(contentStyle);
                                                    cellContentData.setCellValue(Double.parseDouble(contentData));
                                                } else {
                                                    cellContentData.setCellStyle(enterNumeric);
                                                }
                                            } else { // Create Cell String Type
                                                if(dataType == 7){//date
                                                    Cell cellContentData = rowContent.createCell(cellNum);
                                                    CreationHelper createHelper = wb.getCreationHelper();
                                                    CellStyle cellStyle = wb.createCellStyle();                                        
                                                    String dateFormat = WebUtils.getCookie(request, "dateFormat").getValue();
                                                    cellStyle.setDataFormat(createHelper.createDataFormat().getFormat(dateFormat.replace("M", "m").replace("Y", "y")));                                        
                                                    cellStyle.setLocked(false);
                                                    cellContentData.setCellStyle(cellStyle);
                                                }else if(dataType ==6){//combo
                                                    /*List<TblComboDetail> comboDetail = tenderFormService.getComboDetailByComboId(new Object[]{objectId});
                                                    String[] combo = new String[comboDetail.size()];
                                                    for (int i = 0; i < combo.length; i++) {
                                                        combo[i] = comboDetail.get(i).getOptionValue();

                                                    }                                        
                                                    CellRangeAddressList addressList = new CellRangeAddressList(rowCount, rowCount, columnNo-1, columnNo-1);                                        
                                                    DVConstraint dvConstraint = DVConstraint.createExplicitListConstraint(combo);
                                                    DataValidation dataValidation = new HSSFDataValidation(addressList, dvConstraint);
                                                    dataValidation.setSuppressDropDownArrow(false);
                                                    sheet.addValidationData(dataValidation);                                        
                                                    Cell cellContentData = rowContent.createCell(cellNum);                                                                                
                                                    cellContentData.setCellStyle(enterNumeric);*/
                                                }else{
                                                    Cell cellContentData = rowContent.createCell(cellNum);                                        
                                                    cellContentData.setCellType(Cell.CELL_TYPE_STRING);
                                                    if (StringUtils.hasLength(contentData)) {
                                                        cellContentData.setCellStyle(contentStyle);
                                                        //reverseReplaceSpecialChars
                                                        cellContentData.setCellValue(contentData.replace("\\<.*?\\>", ""));
                                                    } else {
                                                        cellContentData.setCellStyle(enterNumeric);
                                                    }                                        
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }else{
                            if (!(iscellAvail == cellNum)) {//To Protect OverWritting Data
                            	if (dataType==3 || dataType==4 || dataType==5) {// If data is Numeric create Cell Numeric Type
                                    Cell cellContentData = rowContent.createCell(cellNum);
                                    cellContentData.setCellType(Cell.CELL_TYPE_NUMERIC);
                                    if (StringUtils.hasLength(contentData)) {
                                        cellContentData.setCellStyle(contentStyle);
                                        cellContentData.setCellValue(Double.parseDouble(contentData));
                                    } else {                                            
                                        cellContentData.setCellStyle(enterNumeric);
                                    }
                                } else// Create Cell String Type
                                {
                                    if(dataType == 7){//date
                                        Cell cellContentData = rowContent.createCell(cellNum);
                                        CreationHelper createHelper = wb.getCreationHelper();
                                        CellStyle cellStyle = wb.createCellStyle();                                        
                                        String dateFormat = WebUtils.getCookie(request, "dateFormat").getValue();
                                        cellStyle.setDataFormat(createHelper.createDataFormat().getFormat(dateFormat.replace("M", "m").replace("Y", "y")));                                        
                                        cellStyle.setLocked(false);
                                        cellContentData.setCellStyle(cellStyle);
                                    }else if(dataType ==6){//combo
                                        /*List<TblComboDetail> comboDetail = tenderFormService.getComboDetailByComboId(new Object[]{objectId});
                                        String[] combo = new String[comboDetail.size()];
                                        for (int i = 0; i < combo.length; i++) {
                                            combo[i] = comboDetail.get(i).getOptionValue();
                                            
                                        }
                                        CellRangeAddressList addressList = new CellRangeAddressList(rowCount, rowCount, columnNo-1, columnNo-1);                                        
                                        DVConstraint dvConstraint = DVConstraint.createExplicitListConstraint(combo);
                                        DataValidation dataValidation = new HSSFDataValidation(addressList, dvConstraint);
                                        dataValidation.setSuppressDropDownArrow(false);
                                        sheet.addValidationData(dataValidation);                                        
                                        Cell cellContentData = rowContent.createCell(cellNum);                                                                                
                                        cellContentData.setCellStyle(enterNumeric);*/
                                    }else{
                                        Cell cellContentData = rowContent.createCell(cellNum);                                        
                                        cellContentData.setCellType(Cell.CELL_TYPE_STRING);
                                        //reverseReplaceSpecialChars
                                        cellContentData.setCellValue(contentData.replace("\\<.*?\\>", ""));
                                        if (StringUtils.hasLength(contentData)) {
                                            cellContentData.setCellStyle(contentStyle);
                                        } else {
                                            cellContentData.setCellStyle(enterNumeric);
                                        }                                        
                                    }
                                }
                                }
                            }
                        }            
                        cellNum++;// Increment Cell and When new Row is Created Initialize  with 0
                        contentCount++; // content count used to create New Row
                    }
                    if (isTotal) {//isTotal=True at that time we have to Display Grand Total
                        Row rowTotal;
                        if (sheet.getRow(lastLocation) != null) {
                            rowTotal = sheet.getRow(lastLocation);
                        } else {
                            rowTotal = sheet.createRow(lastLocation);
                        }
                        Cell cellGrandTotal = rowTotal.createCell(0);
                        cellGrandTotal.setCellValue("Grand Total");
                        cellGrandTotal.setCellStyle(headingStyle);
                    }
                }
                    for (int i = 0; i < headerCount; i++) {                        
                        sheet.autoSizeColumn(i);
                    }
                }
                FileOutputStream fout = new FileOutputStream(file);// Write File
                wb.write(fout);
                fout.flush();
                fout.close();
            }
            InputStream fis = new FileInputStream(file);
            byte[] buf = new byte[fis.available()];
            int offset = 0;
            int numRead = 0;
            while ((offset < buf.length) && ((numRead = fis.read(buf, offset, buf.length - offset)) >= 0)) {
                offset += numRead;
            }
            ServletOutputStream outputStream = response.getOutputStream();
            response.setContentType("application/octet-stream");
            //reverseReplaceSpecialChars
            response.setHeader("Content-Disposition", "attachment;filename=\"" + tblTenderForm.getFormName() + ".xls\"");            
            outputStream.write(buf);
            outputStream.flush();
            outputStream.close();
        } catch (Exception ex) {
            exceptionHandlerService.writeLog(ex);
        }
    }
    private boolean isNumeric(String contentData){// Check Wether Data is Numeric 
        List<Integer> numbers = Arrays.asList(new Integer[]{46, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57});
        int numCnt = 0;
        char[] c = contentData.toCharArray();
        for (int d : c) {
            if (numbers.contains(d)) {
                numCnt++;
            }
        }
        return StringUtils.hasLength(contentData) && numCnt == c.length;
    }
}

