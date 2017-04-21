/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.TenderDataBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblBidderdocument;
import com.eprocurement.etender.model.TblEventTermAndConditions;
import com.eprocurement.etender.model.TblPurchaseorder;
import com.eprocurement.etender.model.TblShareReport;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.CommitteeService;
import com.eprocurement.etender.services.BidderSubmissionService;
import com.eprocurement.etender.services.BidderMappingService;
import com.eprocurement.etender.services.EProcureCreationService;
import com.eprocurement.etender.services.DocumentService;
import com.eprocurement.etender.services.QuotationService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;

@Controller
@RequestMapping("/etender/bidder")
public class BidderHallController {
   
	@Autowired
	EProcureCreationService eventCreationService;
    @Autowired
	private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private BidderSubmissionService eventBidSubmissionService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private TenderService tenderFormService;
    @Autowired
    private BidderMappingService eventBidderMapService;
    @Autowired
    private CommitteeService committeeFormationService;
	@Autowired
    private QuotationService poService;
        @Autowired
        private FormService biddingFormService;
    @Value("#{etenderProperties['sql_dateformate']}")
    private String sqldateformate;
    
    
    private static final String TENDERID = "tenderId";
    private static final String TBLTENDER = "tblTender";
    private static final String ISAUCTION = "isAuction";
    private static final String TABID = "tabId";
    private static final  String REDIRECTBIDDERDASHBOARD = "redirect:/etender/bidder/biddingTenderDashboard/";
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/notloggedin";
    private static final int TAB_DECLARATION = 2;
    private static final int TAB_PREPARE_BID = 5;
    private static final int TAB_FINAL_SUBMISSION = 6;
    private static final int TAB_RESULT = 7;
    private static final int TAB_PRE_BID= 8;
    
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String clientdateformatehhmm;
    @Value("#{projectProperties['doc_upload_path']}")
    private String docUploadPath;
    @Value("#{projectProperties['tenderPrebidObjectId']}")
    private String tenderPrebidObjectId;
    private static final int FINALSUBMISSION_REQUEST_TYPE_GET = 0;
    @Value("#{projectProperties['tenderNITObjectId']}")
    private String tenderNITObjectId;
    @Value("#{projectProperties['bidderMapDocObjectId']}")
    private String bidderMapDocObjectId;
    @Value("#{projectProperties['bidderMandetoryMapDocObjectId']}")
    private String bidderMandetoryMapDocObjectId;
    @Autowired
	private DocumentService fileUploadService;
	
    
	
    
    @RequestMapping(value = "/bidderTenderListing/{isAuction}", method = RequestMethod.GET)
    public ModelAndView createEvent1(@PathVariable(ISAUCTION)Integer isAuction,HttpServletRequest request) throws Exception {
    	String retVal = REDIRECT_SESSION_EXPIRED;
    	ModelAndView modelAndView = new ModelAndView(retVal);
    	try {
	    	if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
                   		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
				if (sBean.getUserTypeId() == 2) {
					long userId = sBean.getUserId();
					retVal = "/etender/bidder/BidderTenderListing";
					modelAndView = new ModelAndView(retVal);
					Map<String, Object> tenderCount = eventCreationService.getTenderCount(isAuction, userId);
					modelAndView.addObject("tenderCount", tenderCount);
					TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
					int bidderId = tblBidder.getBidderId();
					modelAndView.addObject("bidderId", bidderId);
					if (isAuction == 1)
						modelAndView.addObject(ISAUCTION, 1);
					else
						modelAndView.addObject(ISAUCTION, 0);
					modelAndView.addObject("userId", userId);
				}
	    	}
    	} catch (Exception ex) {
    	    exceptionHandlerService.writeLog(ex);
    	}
  
        return modelAndView;
    }
    

    @RequestMapping(value = "/biddingTenderDashboard/{tenderId}", method = RequestMethod.GET)
    public String biddingTenderDashboard(@PathVariable("tenderId")Integer tenderId, HttpServletRequest request, ModelMap modelMap) throws Exception {
        String retVal = REDIRECT_SESSION_EXPIRED;
        try {
			if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
				SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                long userId = sBean.getUserId();
                TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
                TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
                Date submissionEndDate=new Date();
                if(tblTender.getisAuction()==0)
                {
                submissionEndDate = commonService.convertStringToDate(sqldateformate, tblTender.getSubmissionEndDate().toString());
                }
                else
                {
                submissionEndDate = commonService.convertStringToDate(sqldateformate, tblTender.getAuctionEndDate().toString());    
                }
                           
                Date serverDateTime = commonService.getServerDateTime();
    	        if(serverDateTime.compareTo(submissionEndDate) > 0){
                    modelMap.addAttribute("submissionDateOver", true);
    	        }
                if(tblTender.getisAuction()==0)
                {
                    modelMap.addAttribute("submissionEndDate",commonService.convertSqlToClientDate(clientdateformatehhmm, tblTender.getSubmissionEndDate()));
                modelMap.addAttribute("submissionEndDateForCounter",commonService.convertSqlToClientDate(clientdateformatehhmm, tblTender.getSubmissionEndDate()));
                }
                else
                {
                     modelMap.addAttribute("submissionEndDate",commonService.convertSqlToClientDate(clientdateformatehhmm, tblTender.getAuctionEndDate()));
                modelMap.addAttribute("submissionEndDateForCounter",commonService.convertSqlToClientDate(clientdateformatehhmm, tblTender.getAuctionEndDate()));
                }
                
                modelMap.put("isRepeated", eventBidSubmissionService.isTenderIdRepeated(tenderId, tblBidder.getBidderId()));
                modelMap.addAttribute(TBLTENDER, tblTender);
                if(tblTender.getisAuction()==1)
                {
                    modelMap.addAttribute("formId",biddingFormService.getFormIdByTenderId(tenderId));
                    modelMap.addAttribute("bid",biddingFormService.getBidIdByTenderandBidderId(tenderId, tblBidder.getBidderId()));
                    
                }
                retVal = "/etender/bidder/BidderTenderDashboard";
			}
    } catch (Exception ex) {
	    exceptionHandlerService.writeLog(ex);
	}      
        
        return retVal;
    }
    @RequestMapping(value = "/biddingtenderdashboardcontent/{tenderId}/{tabId}", method = RequestMethod.GET)
    public String getTabContent(@PathVariable(TENDERID) int tenderId,@PathVariable(TABID) int tabId, ModelMap modelMap, HttpServletRequest request,RedirectAttributes redirectAttributes) {
    	String retVal = REDIRECT_SESSION_EXPIRED;
		try {
			if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
				SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
				modelMap.put("sessionUserTypeId", sBean.getUserTypeId());
                long userId = sBean.getUserId();
                modelMap.put("clientDateFormate",clientdateformatehhmm);
                TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
                modelMap.addAttribute("tblBidder", tblBidder);
                int bidderId = tblBidder.getBidderId();
                int companyId = tblBidder.getTblCompany().getCompanyid();    	  
				modelMap.put("sessionUserId", commonService.getSessionUserId(request));
				int formStatus = -1;
				TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
				modelMap.addAttribute(TBLTENDER, tblTender);
				int isFormConfirmationReq = tblTender.getIsFormConfirmationReq();
                List<Object> lstTndrSubManDocsDtls = tenderCommonService.isSubmissionDateLapsed(tenderId);
                modelMap.addAttribute("submissionEndDtLapse", lstTndrSubManDocsDtls.get(0));
                modelMap.addAttribute("isBidWithdrawal", tblTender.getIsBidWithdrawal());
            	Date submissionEndDate=new Date();
                if(tblTender.getisAuction()==1)
                {
                    submissionEndDate = commonService.convertStringToDate(sqldateformate,tblTender.getAuctionEndDate().toString());
                    
                }
                else
                {
                    submissionEndDate = commonService.convertStringToDate(sqldateformate, tblTender.getSubmissionEndDate().toString());
                }
                
    	        Date serverDateTime = commonService.getServerDateTime();
    	        if(serverDateTime.compareTo(submissionEndDate) > 0){
    	        	modelMap.addAttribute("submissionDateOver", true);
    	        }
                
                if(tblTender.getisAuction()==1)
                {
                    modelMap.addAttribute("submissionEndDate", commonService.convertSqlToClientDate(clientdateformatehhmm, tblTender.getAuctionEndDate()));            

                }
                else
                {
                    modelMap.addAttribute("submissionEndDate", commonService.convertSqlToClientDate(clientdateformatehhmm, tblTender.getSubmissionEndDate()));            

                }
                            
				switch (tabId) {
					case TAB_DECLARATION:
	                    boolean isRepeated = eventBidSubmissionService.isTenderIdRepeated(tenderId, bidderId);
	                    TblEventTermAndConditions condition = eventBidSubmissionService.getTermAndConditionByEventId(tenderId);
	                    List<Object[]> termAndconditions = null;
	                    if(condition==null) {
                                if(tblTender.getisAuction()==0)
                                {
                                    termAndconditions = eventBidSubmissionService.getTenderBidConfirmForm();
                                }
                                else
                                {
                                    termAndconditions = biddingFormService.getAuctionBidConfirmForm();
                                }
	                    	
	                    }
	                    List<Object[]> currencyList = null;
	                    String selectedCurrency = "";
	                    currencyList = eventBidSubmissionService.getCurrencies(tenderId,companyId,false);
	                    if (tblTender.getBiddingType() == 2) {
	                       if(isRepeated){
	                    	   selectedCurrency=eventBidSubmissionService.getCurrencies(tenderId, companyId, true).get(0)[1].toString();    //tenderFormService.getBidderCurrency(tenderId, companyId).get(0)[0].toString();
	                       }
	                    }else if(tblTender.getBiddingType() == 1) {
		                	selectedCurrency = currencyList != null ? currencyList.get(0)[1].toString() : "";
		                }
	                    String conditionForBidder = null;
	                    int clientBidTermId = 0;
	                    if(condition==null) {
	                        conditionForBidder = termAndconditions.get(0)[1].toString();
	                        clientBidTermId = (Integer)termAndconditions.get(0)[0];
	                    }else {
	                    	conditionForBidder = condition.getTermNcondition();
	                        clientBidTermId = condition.getTermNcondId();
	                    }
	                    if (!isRepeated) {
	                        int errCode = tenderCommonService.isEventLiveBidder(tenderId);
	                        if (errCode != 1) {
	                            if (errCode == 0) {
	                                modelMap.addAttribute("err_bidsub_dt", "msg_tender_err_msg_bidsub_dt_notarrived");
	                            } else {
	                                modelMap.addAttribute("err_bidsub_dt", "msg_tender_err_msg_bidsub_end_dt_lapse");
	                            }
	                        }
	                    }
	                    if(clientBidTermId==0){
	                    	modelMap.addAttribute("err_iagree_config_pending", "msg_ten_iagree_config_pending");
	                    }
	                    modelMap.addAttribute("conditionForBidder", conditionForBidder);
                                        
	                    modelMap.addAttribute("clientBidTermId", clientBidTermId);
	                    modelMap.put("listOfCurrency", currencyList);
	                    modelMap.put("isRepeated", isRepeated);
	                    modelMap.put("selectedCurrency", selectedCurrency);
	                    modelMap.put("biddingType", tblTender.getBiddingType());
	                    modelMap.put("isAtleastOneFormApproved",tenderFormService.getApprovedFormCount(tenderId));
                            
	                    retVal="etender/bidder/BidderDeclaration";
	                    break;
	                    
	                    
	                case TAB_PREPARE_BID :
	                	boolean isCompanyMapped = true;
	                    modelMap.addAttribute("isCompanyMapped", isCompanyMapped);
	                	Boolean isEncCertVerified = false;
                    	if (request.getSession().getAttribute("isEncCertVerified") != null)
                    	{
                    		isEncCertVerified = Boolean.parseBoolean(request.getSession().getAttribute("isEncCertVerified").toString());
                    		modelMap.addAttribute("isEncCertVerified", isEncCertVerified);
                    		request.getSession().removeAttribute("isEncCertVerified");	
                    	}
                        formStatus = -1;
                        boolean isBidPrepared = false;
                        List<Object[]> lstTenderBidDtls = tenderCommonService.getTenderBidDtls(tenderId, companyId, false);


                        if (!lstTenderBidDtls.isEmpty()) {
                            isBidPrepared = true;
                            modelMap.addAttribute("lstTenderBidDtls", lstTenderBidDtls);
                        }
                        
                        String finalSubmissionMsg1 = tenderCommonService.allowFinalSubmission(sBean.getIpAddress(),tenderId, companyId, bidderId,FINALSUBMISSION_REQUEST_TYPE_GET,(int)userId);
                        if (finalSubmissionMsg1 != null && finalSubmissionMsg1.contains("msg_tender_fs_finalsubmission_done")) {
                            modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg1.split("@")[0]);
    	                    modelMap.addAttribute("msgArgumentOne", finalSubmissionMsg1.split("@")[1]);
    	                    modelMap.addAttribute("msgArgumentTwo", finalSubmissionMsg1.split("@")[2]);
                        } else {
                            modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg1);
                        }
                        
                        if(isFormConfirmationReq == 1 && !lstTenderBidDtls.isEmpty()){
                            List<Integer> bidLst = new ArrayList<Integer>();
                            for (Object[] bidDetail : lstTenderBidDtls) {
                                bidLst.add(Integer.parseInt(bidDetail[0].toString()));
                            }
                            modelMap.addAttribute("bidIds", bidLst.toString().replace(" ", "").replace("[", "").replace("]", ""));
                        }
                        /**
                         * * get rebate List by tender Id *
                         */
                        if (tblTender.getIsItemSelectionPageRequired() == 1) {
							List<Object[]> itemselected = new ArrayList<Object[]>(); 
							Map<Object, Boolean> selectedForm = new HashMap<Object, Boolean>();
							if (itemselected != null && !itemselected.isEmpty()) {
								for (Object[] obj : itemselected) {
									if (obj[3].equals(1)) {
										selectedForm.put(obj[0], true);
									}
								}
								modelMap.addAttribute("selFormByItemSelection", selectedForm);
								modelMap.addAttribute("biditemselected",1);
							} else {
								modelMap.addAttribute("biditemselected",0);
							}
						}
                        modelMap.addAttribute("isBidPrepared", isBidPrepared);
                        boolean isWeightageEvaluationRequired = tblTender.getIsWeightageEvaluationRequired() == 1;
                		boolean isGrandTotalWiseTenderResult =  tblTender.getTenderResult() == 1;
                		modelMap.addAttribute("isSecondaryPartner", tenderCommonService.isSecondaryPartner(tenderId,companyId)>0 ? true : false);
                		modelMap.addAttribute("isFinalSubmission", tenderCommonService.isFinalBidSubmision(tenderId, companyId));
                		modelMap.addAttribute("tblTenderForm", tenderCommonService.getTblTenderFormById(tenderId));
                		modelMap.addAttribute("tblRebateGTBidded",tenderFormService.getRebateList(tenderId,tblBidder.getBidderId()));
                		modelMap.addAttribute("tblTenderRebateDtls", tenderFormService.getTblTenderRebate(tenderId,companyId));
                		retVal="etender/bidder/BidderPreparation";
                        break;
	                case TAB_FINAL_SUBMISSION :
                        formStatus = 1;
                        if(eventBidSubmissionService.isTenderIdRepeated(tenderId, bidderId)){
                        
                        String finalSubmissionMsg = tenderCommonService.allowFinalSubmission(sBean.getIpAddress(), tenderId, companyId, bidderId,FINALSUBMISSION_REQUEST_TYPE_GET,(int)userId);
                        
                        boolean isDocsMandatory = tenderCommonService.isTenderFormDocsMandatory(tenderId);
                        if (isDocsMandatory) {
                            Map<Integer, Long> pendingDocUploadCount = new HashMap<Integer, Long>();
                            List<Object[]> lstManDocUploadedCount = new ArrayList<Object[]>();
                            Map<Integer, Long> docUploadCount = new HashMap<Integer, Long>();
                            for (Object[] manDocs : lstManDocUploadedCount) {
                                docUploadCount.put((Integer) manDocs[1], (Long) manDocs[0]);
                            }
                            List<Object[]> lstMandatoryDocsCount = new ArrayList<Object[]>();
                            for (Object[] manDoc : lstMandatoryDocsCount) {
                                if (docUploadCount.containsKey((Integer) manDoc[1])) {
                                    pendingDocUploadCount.put((Integer) manDoc[1], (Long) manDoc[0] - docUploadCount.get((Integer) manDoc[1]));
                                } else {
                                    pendingDocUploadCount.put((Integer) manDoc[1], (Long) manDoc[0]);
                                }
                            }
                            
                            modelMap.addAttribute("PendingDocsCount", pendingDocUploadCount);
                            List<TblBidderdocument> lstTenderBidderDocs = tenderCommonService.getTblBidderdocument(tenderId, bidderId,10);//need to create tables for document
                        	if (!lstTenderBidderDocs.isEmpty()) {
                                modelMap.addAttribute("isDocUploaded", false);
                                modelMap.addAttribute("lstTenderBidderDocs", lstTenderBidderDocs);
                            }
                        }

                        if (finalSubmissionMsg.contains("msg_tender_fs_finalsubmission_done")) {
                        	modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg.split("@")[0]);
    	                    modelMap.addAttribute("msgArgumentOne", finalSubmissionMsg.split("@")[1]);
    	                    modelMap.addAttribute("msgArgumentTwo", finalSubmissionMsg.split("@")[2]);
                        } else {
                            modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg);
                        }
                        modelMap.addAttribute("lstTenderBid", tenderCommonService.getTenderBidDtls(tenderId, companyId, false));
                        modelMap.addAttribute("lstTenderBidCount", tenderCommonService.getTenderBidDtls(tenderId, companyId, true));
                        modelMap.addAttribute("bidWithdrawalDtls", eventBidSubmissionService.getBidWithDrawaldtls(tenderId, companyId));
                        
                        List<Object[]> lstTenderBidDtl = tenderCommonService.getTenderBidDtls(tenderId, companyId, false);
                        if(isFormConfirmationReq==1 && !lstTenderBidDtl.isEmpty()){
                            List<Integer> bidsLst = new ArrayList<Integer>();
                            for (Object[] bidDetail : lstTenderBidDtl) {
                                bidsLst.add(Integer.parseInt(bidDetail[0].toString()));
                            }
                            modelMap.addAttribute("bidIds", bidsLst.toString().replace(" ", "").replace("[", "").replace("]", ""));
                        }
                        	retVal="etender/bidder/FinalSubmission";
                        }else{
                        	redirectAttributes.addFlashAttribute("errorMsg", "msg_temder_err_iagree");
                        	retVal=REDIRECTBIDDERDASHBOARD+tenderId;
                        }
	                	break;
	                case TAB_RESULT:
                        modelMap.addAttribute("isResultShareDone", tenderCommonService.isResultShareDone(tenderId));
                        modelMap.addAttribute("fromOfficer",false);
                        modelMap.addAttribute("envList",committeeFormationService.getTenderEnvelopeList(tenderId,3));//result-set-2
                        List<Object[]> bidderList = committeeFormationService.getTenderBidderList(tenderId,0);
                	    modelMap.addAttribute("bidderList",bidderList);//result-set-3
                	    List<Object[]> bidderFormList = committeeFormationService.getTenderBidderFormList(tenderId,3);//#result-set-4
                	    modelMap.addAttribute("bidderFormList",bidderFormList);
                	    TblShareReport tblShareReport =  tenderCommonService.getTblShareReportById(tenderId);
                	    modelMap.addAttribute("tblShareReport",tblShareReport);
                	    int autoResultSharing = tblTender.getAutoResultSharing();
                	    List<Object[]> data = committeeFormationService.getTenderOpeningCommitteeMemberList(tenderId,1);
                	  	   if(data  != null ){
                	  		   for(Object[] obj : data ){
                	  			   if(obj[4] != null && !"".equals(obj[4].toString())){
                	  				   String date = obj[4].toString();
                	  				   obj[4] = commonService.convertSqlToClientDate(clientdateformatehhmm, date);
                	  			  }
                	  		   }
                	  	   }
                	    modelMap.addAttribute("commMemList",data);
                	    modelMap.addAttribute("autoResultSharing", autoResultSharing);
                	    TblPurchaseorder tblPurchaseorder = poService.getPurchaseOrderByTenderAndBidderId(tenderId, bidderId); 
						modelMap.addAttribute("poId", tblPurchaseorder!=null?tblPurchaseorder.getPoid():0);
                	    List<Object[]> tenderDetailList = committeeFormationService.getTenderDetails(tenderId,1,tblTender.getEnvelopeType());
                	    TenderDataBean tenderDataBean = new TenderDataBean();
                	    if(tenderDetailList!=null && !tenderDetailList.isEmpty()){
                	    	for(Object[] obj : tenderDetailList){
                	    		tenderDataBean.setEnvelopeType(Integer.parseInt(obj[1].toString()));
                	    		tenderDataBean.setIsEncodedName(obj[2].toString());
                	    		tenderDataBean.setAutoResultSharing(Integer.parseInt(obj[3].toString()));
                	    		tenderDataBean.setTenderOpeningTimeLapsed(Integer.parseInt(obj[4].toString()));
                	    		tenderDataBean.setEventTypeId(Integer.parseInt(obj[5].toString()));
                	    		tenderDataBean.setTotalNoOfBidders(Integer.parseInt(obj[6].toString()));
                	    		tenderDataBean.setIsRebateApplicable(Integer.parseInt(obj[7].toString()));
                	    		tenderDataBean.setBidderCount(Integer.parseInt(obj[8].toString()));
                	    		tenderDataBean.setShowNoOfBidders(Integer.parseInt(obj[9].toString()));
                	    	}
                	    }
                	    modelMap.addAttribute("tenderDetailList",tenderDataBean);
                            if(tblTender.getisAuction()==1)
                            {
                                modelMap.addAttribute("bidHistory", biddingFormService.getBidHistoryByBidderId(tblBidder.getBidderId(),tblTender.getTenderId()));
                                if(tblTender.getBiddingType()==2)
                                {
                                    float ExchangeRate = 0;
                                    List<Object[]> lst = biddingFormService.getBidderCurrencyDetailByTenderId(tenderId);
                                    for(int i=0;i<lst.size();i++)
                                    {
                                        if(Integer.parseInt(lst.get(i)[2].toString())==tblBidder.getBidderId())
                                        {
                                            ExchangeRate = Float.parseFloat(lst.get(i)[1].toString());
                                        }
                                    }
                                    modelMap.addAttribute("ExchangeRate", ExchangeRate);
                                }
                            }
                            retVal="etender/bidder/TenderResult";
	                	break;
	                case TAB_PRE_BID:
	                	modelMap.addAttribute(TBLTENDER,tblTender);
	                	int prebidCommitteeId = committeeFormationService.getCommitteeId(tenderId, 3);
	        	    	Object[] prebidDtls = tenderCommonService.getTenderPrebidDetailByTenderId(tenderId);
	        	    	if(prebidDtls!=null){
	        	    		modelMap.put("prebidstartdate", commonService.convertSqlToClientDate(clientdateformatehhmm, prebidDtls[2].toString()));
	        	    		modelMap.put("prebidenddate", commonService.convertSqlToClientDate(clientdateformatehhmm, prebidDtls[3].toString()));
	        	    	}
	        	    	modelMap.put("isCommitteeCreated", prebidCommitteeId!=0);
	        	    	modelMap.put("prebidDtls", prebidDtls);
	        	    	modelMap.put(TENDERID, tenderId);
	        	    	modelMap.put("objectId", tenderPrebidObjectId);
	        	    	modelMap.put("childId", prebidCommitteeId);
	        	    	modelMap.put("currentDate", commonService.getServerDateTime());
	        	    	modelMap.put("subChildId", 0);
	        	    	modelMap.put("otherSubChildId", 0);
	                	retVal="etender/bidder/PrebidDashboardTabBidder";
				}
				List<Integer> cStatusList=new ArrayList<Integer>();
                cStatusList.add(1);
                modelMap.addAttribute(ISAUCTION,tblTender.getisAuction());
                modelMap.addAttribute("clientDateFormate",clientdateformatehhmm);
				modelMap.addAttribute("tenderEnvelopeLst", tenderCommonService.getTenderEnvelopeByTenderId(tenderId,false,cStatusList));
				modelMap.addAttribute("tenderFormLst", tenderCommonService.getTenderFormByTenderId(true, tenderId, formStatus,tblTender.getTenderMode(),tblTender.getIsItemwiseWinner(),companyId));
			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
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
    @RequestMapping(value = "/mapbidderdocument/{tenderId}/{formId}/{objectId}/{bidderId}", method = RequestMethod.GET)
    public ModelAndView getTenderNITDocument(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("objectId")Integer objectId,@PathVariable("bidderId")Integer bidderId, HttpServletRequest request) throws Exception {
        String retVal = "/etender/bidder/TenderMapBidderDocument";
        ModelAndView modelAndView = new ModelAndView(retVal);
        modelAndView.addObject(TENDERID, tenderId);
        modelAndView.addObject("objectId", bidderMapDocObjectId);
        modelAndView.addObject("childId", formId);
        modelAndView.addObject("subChildId", 0);
        modelAndView.addObject("otherSubChildId", 0);
        TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
        modelAndView.addObject(ISAUCTION, tblTender.getisAuction());
        return modelAndView;
    }
    
    @RequestMapping(value = "/mandatorydocupload/{tenderId}/{formId}/{objectId}/{bidderId}", method = RequestMethod.GET)
    public ModelAndView getTenderReferenceDocument(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("objectId")Integer objectId,@PathVariable("bidderId")Integer bidderId, HttpServletRequest request) throws Exception {
        String retVal = "/etender/bidder/TenderReferenceDocument";
        ModelAndView modelAndView = new ModelAndView(retVal);
        modelAndView.addObject(TENDERID, tenderId);
        modelAndView.addObject("docList",fileUploadService.getOfficerDocuments(tenderId, Integer.parseInt(bidderMandetoryMapDocObjectId), formId,0,0,2,bidderId));
        modelAndView.addObject("objectId", bidderMandetoryMapDocObjectId);
        modelAndView.addObject("childId", formId);
        modelAndView.addObject("subChildId", 0);
        modelAndView.addObject("otherSubChildId", 0);
        TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
        modelAndView.addObject(ISAUCTION, tblTender.getisAuction());
        return modelAndView;
    }
    
    
         
}

