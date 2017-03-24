/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/notloggedin";
    private static final int FINALSUBMISSION_REQUEST_TYPE_POST = 1;
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
    private static final String HIDDEN_TENDER_ID = "hdTenderId";
    private final static String XFORWARDEDFOR = "X-FORWARDED-FOR";
    private final static String REDIRECTBIDDERDASHBOARD = "redirect:/etender/bidder/biddingTenderDashboard/";
    private final static String REDIRECTBIDDERDASHBOARDCONTENT = "redirect:/etender/bidder/biddingtenderdashboardcontent/";
    
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
	//	    		tblTenderBidConfirmation.setEncodedname(spCompanyNameEncoded.executeProcedure(tenderModuleId,tenderId));
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
//                if(bidderStatus != null && bidderStatus[1] == 1){
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
        } finally {
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()),deleteBid ,deleteBidAudit , tenderId, bidId);
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
	    				success = true;
	    				if(success){
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
    	finally{
//    			auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), bidWithdrawalLinkId,auditMsg, tenderId, 0);
    	}
    	return retVal;
    }
    
    @RequestMapping(value = "/bidform/{tenderId}/{envelopeId}/{formId}/{bidId}", method = RequestMethod.GET)
    public String bidForm(@PathVariable("tenderId") Integer tenderId,@PathVariable("envelopeId") Integer envelopeId, @PathVariable("formId") Integer formId,@PathVariable("bidId") Integer bidId, ModelMap modelMap, HttpServletRequest request) {
    	TblTenderForm tblTenderForm = null;
    	boolean isEncCertVerified = false;
    	try{
	    	HttpSession session = request.getSession();
	    	SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
	    	if(sessionBean!= null && sessionBean.getUserTypeId() == 2 ){
	    		tblTenderForm = tenderFormService.getTenderFormById(formId);
	    		if(tblTenderForm.getIsEncryptionReq() == 1){
		    		int isCertRequired = Integer.parseInt(tenderCommonService.getTenderField(tenderId, "isCertRequired").toString());
		//    		isEncCertVerified = commonService.checkIsCertificateVerified(isCertRequired,2,request);
		    	}
		    	else{
		    		isEncCertVerified = true;    		
		    	}
		    	request.getSession().setAttribute("isEncCertVerified",isEncCertVerified);
		    	if(!isEncCertVerified){
	    			return REDIRECTBIDDERDASHBOARD+"/"+tenderId;
	    		}
	    		else{
    				
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
    	            modelMap.addAttribute("CLIENT_DATETIME",client_dateformate_hhmm);
    	            modelMap.addAttribute("rebateCellId", eventBidSubmissionService.getRebateCellId(formId));
    				return "/etender/bidder/BidForm";
	    		}
	    	}else{
	    		return REDIRECT_SESSION_EXPIRED;
	    	}
		} catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), bidId==0 ? bidFormCreate : bidFormEdit, bidId==0 ? bidFormAudit : bidFormEditAudit, tenderId, formId);
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
//	   	 		setBidFormData(modelMap, request, tenderId,0);
	   			
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
	   			
	   			modelMap.put("rebateFormList", rebateFormList);
	   			modelMap.addAttribute("tblTenderRebateDtls", tenderFormService.getTblTenderRebate(tenderId,companyId));
	   			
	            retVal = "etender/bidder/AddRebate";
        	}
        }
        catch(Exception e){
        	return exceptionHandlerService.writeLog(e);
        } finally {
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), addEdtFlage==1?addRebateDetailLinkId:addEdtFlage==2?editRebateDetailLinkId:viewRebateDetailLinkId, createrebatepercentagepage, tenderId, rebateId);
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
        }finally {
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), editRebateDetailLinkId, success ? rebatepercentageupdate : rebatepercentageupdatefail,tenderId,rebateId);
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
        /*if((Integer)modelMap.get("encryptionReq")==1){
        	List<Object[]> pkeyList = new ArrayList<Object[]>();
//            List<Object[]> pkeyList = eventBidSubmissionService.getOfficerPublicKey(tenderId, envelopeId);
           
            if(level==1){                    
                List<String> levelonepkey = new ArrayList<String>();
                for (Object[] pkey : pkeyList) {
                    if((Integer)pkey[1]==1){
                        levelonepkey.add(pkey[0].toString());
                    }
                }
                modelMap.addAttribute("levelonepkey",levelonepkey);
            }
            if(level==2){                    
                List<String> levelonepkey = new ArrayList<String>();
                List<String> leveltwopkey = new ArrayList<String>();
                for (Object[] pkey : pkeyList) {
                    if((Integer)pkey[1]==1){
                        levelonepkey.add(pkey[0].toString());
                    }
                    if((Integer)pkey[1]==2){
                        leveltwopkey.add(pkey[0].toString());
                    }
                }
                modelMap.addAttribute("levelonepkey",levelonepkey);
                modelMap.addAttribute("leveltwopkey",leveltwopkey);
            }
        }*/
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
        }finally {
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), addRebateDetailLinkId, success ? rebatepercentageadd : rebatepercentageaddfail,tenderId,rebateId);
        }
        retVal = "redirect:/etender/bidder/biddingtenderdashboardcontent/" + tenderId+"/"+5;
        redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_success_bidder_rebate_add" : "msg_error_bidder_rebate_add");
        return retVal;
    }   
}

