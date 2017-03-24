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
    private String sql_dateformate;
    
    
    private static final String TENDERID = "tenderId";
    private static final String TABID = "tabId";
    private final static String REDIRECTBIDDERDASHBOARD = "redirect:/etender/bidder/biddingTenderDashboard/";
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/notloggedin";
    private static final int TAB_DECLARATION = 2;
    private static final int TAB_PREPARE_BID = 5;
    private static final int TAB_FINAL_SUBMISSION = 6;
    private static final int TAB_RESULT = 7;
    private static final int TAB_PRE_BID= 8;
    
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
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
    public ModelAndView createEvent1(@PathVariable("isAuction")Integer isAuction,HttpServletRequest request) throws Exception {
    	String retVal = REDIRECT_SESSION_EXPIRED;
    	ModelAndView modelAndView = new ModelAndView(retVal);
    	try {
	    	if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
                   		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
	            long userId = sBean.getUserId();
		        retVal = "/etender/bidder/BidderTenderListing";
                        modelAndView = new ModelAndView(retVal);
		        Map<String,Object> tenderCount = eventCreationService.getTenderCount(isAuction);
		        modelAndView.addObject("tenderCount", tenderCount);
		        TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
		        int bidderId = tblBidder.getBidderId();
		        modelAndView.addObject("bidderId", bidderId);
                        if(isAuction==1)
                             modelAndView.addObject("isAuction", 1);
                        else
                             modelAndView.addObject("isAuction", 0);
                        modelAndView.addObject("userId", userId);
                            
	    	}
    	} catch (Exception ex) {
    	    exceptionHandlerService.writeLog(ex);
    	}
  
        return modelAndView;
    }
    
    /*@RequestMapping(value = {"/viewtender/{tenderId}"}, method = RequestMethod.GET)
    public ModelAndView viewTender(@PathVariable(TENDERID) Integer tenderId, ModelMap modelMap, HttpServletRequest request) {
    	String retVal = "/etender/bidder/ViewTender";
    try{
    	TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
    	if(tenderId != null && tenderId != 0){
    		boolean checkpricebid = false;
			List<Object[]> tenderEnvelopeList = tenderCommonService.getEnvelopeTypeByTenderId(tenderId);
			String currencyName = "";
			String envolopeName = "";
			if(tenderEnvelopeList != null && !tenderEnvelopeList.isEmpty()){
				for(Object[] obj : tenderEnvelopeList){
					if("4".equals(obj[0].toString())){
						checkpricebid = true;
					}
					envolopeName += obj[1].toString()+",";
				}
			}
			//List<Object[]> tenderCurrency= tenderCommonService.getCurrencyList(tblTender.getCurrencyId());
			List<Object[]> tenderICBCurrency= tenderCommonService.getCurrencyByTenderId(tenderId);
			String internationalCurrency = "";
			if(tenderICBCurrency != null && !tenderICBCurrency.isEmpty()){
				for(Object[] obj : tenderICBCurrency){
					if("1".equals(obj[2].toString())){
						currencyName += commonService.getCurrencyList(Integer.parseInt(obj[0].toString())).get(0)[1]+",";
					}else if(tblTender.getBiddingType() == 2){
						internationalCurrency += commonService.getCurrencyList(Integer.parseInt(obj[0].toString())).get(0)[1]+",";
					}

				}
			}
			String departmentName = ""; 
			List<Object[]> tenderDepartment= tenderCommonService.getDepartmentById(tblTender.getDepartmentId());
			if(tenderDepartment != null && !tenderDepartment.isEmpty()){
				for(Object[] obj : tenderDepartment){
					departmentName += obj[1].toString()+",";
				} 
			}
			String officerName = ""; 
			List<Object[]> tenderOfficer= tenderCommonService.getOfficerById(tblTender.getOfficerId());
			if(tenderOfficer != null && !tenderOfficer.isEmpty()){
				for(Object[] obj : tenderOfficer){
					officerName += obj[1].toString()+",";
				}
			}

			String procurementNature = ""; 
			List<Object[]> tblProcurementNature= tenderCommonService.getProcurementNatureById(tblTender.getProcurementNatureId());
			if(tenderOfficer != null && !tblProcurementNature.isEmpty()){
				for(Object[] obj : tblProcurementNature){
					procurementNature += obj[1].toString()+",";
				}
			}

        	modelMap.addAttribute("procurementNature",procurementNature);
            modelMap.addAttribute("tblTender", tblTender);
            String eventTypeName = (tenderCommonService.getTblEventTypeById(tblTender.getEventTypeId()) != null) ? tenderCommonService.getTblEventTypeById(tblTender.getEventTypeId()).getEventTypeName() : "";
            modelMap.addAttribute("eventTypeName",  eventTypeName);
            modelMap.addAttribute("currencyName", currencyName);
            modelMap.addAttribute("internationalCurrency", internationalCurrency);
            modelMap.addAttribute("departmentName", departmentName);
            modelMap.addAttribute("officerName", officerName);
            modelMap.addAttribute("envolopeName", envolopeName);
            modelMap.addAttribute("checkpricebid", checkpricebid);
            modelMap.addAttribute("tenderNITObjectId", tenderNITObjectId);
            modelMap.addAttribute("isCategoryAllow", 0);
            modelMap.addAttribute("documentStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getDocumentStartDate()));
            modelMap.addAttribute("documentEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getDocumentEndDate()));
            modelMap.addAttribute("preBidEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getPreBidEndDate()));
            modelMap.addAttribute("preBidStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getPreBidStartDate()));
            modelMap.addAttribute("queStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getQuestionAnswerStartDate()));
            modelMap.addAttribute("queEndtDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getQuestionAnswerEndDate()));
            modelMap.addAttribute("openingDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getOpeningDate()));
            modelMap.addAttribute("submissionStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionStartDate()));
            modelMap.addAttribute("submissionEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionEndDate()));
}
    	}catch(Exception e)
    	{
    		e.printStackTrace();
    	}
        ModelAndView modelAndView = new ModelAndView(retVal);
        return modelAndView;
    }*/

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
                submissionEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getSubmissionEndDate().toString());
                }
                else
                {
                submissionEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getAuctionEndDate().toString());    
                }
                           
                Date serverDateTime = commonService.getServerDateTime();
    	        if(serverDateTime.compareTo(submissionEndDate) > 0){
                    modelMap.addAttribute("submissionDateOver", true);
    	        }
                if(tblTender.getisAuction()==0)
                {
                    modelMap.addAttribute("submissionEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionEndDate()));
                modelMap.addAttribute("submissionEndDateForCounter",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionEndDate()));
                }
                else
                {
                     modelMap.addAttribute("submissionEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getAuctionEndDate()));
                modelMap.addAttribute("submissionEndDateForCounter",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getAuctionEndDate()));
                }
                
                modelMap.put("isRepeated", eventBidSubmissionService.isTenderIdRepeated(tenderId, tblBidder.getBidderId()));
                modelMap.addAttribute("tblTender", tblTender);
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
                modelMap.put("clientDateFormate",client_dateformate_hhmm);
                TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
                modelMap.addAttribute("tblBidder", tblBidder);
                int bidderId = tblBidder.getBidderId();
                int companyId = tblBidder.getTblCompany().getCompanyid();    	  
				modelMap.put("sessionUserId", commonService.getSessionUserId(request));
				int formStatus = -1;
				TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
				modelMap.addAttribute("tblTender", tblTender);
				int isFormConfirmationReq = tblTender.getIsFormConfirmationReq();
                List<Object> lstTndrSubManDocsDtls = tenderCommonService.isSubmissionDateLapsed(tenderId);
                modelMap.addAttribute("submissionEndDtLapse", lstTndrSubManDocsDtls.get(0));
                modelMap.addAttribute("isBidWithdrawal", tblTender.getIsBidWithdrawal());
            	Date submissionEndDate=new Date();
                if(tblTender.getisAuction()==1)
                {
                    submissionEndDate = commonService.convertStringToDate(sql_dateformate,tblTender.getAuctionEndDate().toString());
                    
                }
                else
                {
                    submissionEndDate = commonService.convertStringToDate(sql_dateformate, tblTender.getSubmissionEndDate().toString());
                }
                
    	        Date serverDateTime = commonService.getServerDateTime();
    	        if(serverDateTime.compareTo(submissionEndDate) > 0){
    	        	modelMap.addAttribute("submissionDateOver", true);
    	        }
                
                if(tblTender.getisAuction()==1)
                {
                    modelMap.addAttribute("submissionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getAuctionEndDate()));            

                }
                else
                {
                    modelMap.addAttribute("submissionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionEndDate()));            

                }
                            
				switch (tabId) {
					case TAB_DECLARATION:
	//                    auditMsg = postajaxBiddingTenderDashboardContentDEC;
	//                    String languageId = WebUtils.getCookie(request, "locale").getValue();
	                    
	                    boolean isRepeated = eventBidSubmissionService.isTenderIdRepeated(tenderId, bidderId);
	                    TblEventTermAndConditions condition = eventBidSubmissionService.getTermAndConditionByEventId(tenderId);
	                    List<Object[]> termAndconditions = null;
	                    if(condition==null) {
                                
                                termAndconditions = eventBidSubmissionService.getTenderBidConfirmForm();
                                
	                    	
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
                        
                        /*if(isDocUploaded){
                            for (TblBidderdocument objects : lstTenderBidderDocs) {
                                String fPath = docUploadPath.concat((String)objects.getFileName());
                                File f = new File(fPath);
                            }
                         }*/
                        String finalSubmissionMsg1 = tenderCommonService.allowFinalSubmission(sBean.getIpAddress(),tenderId, companyId, bidderId,FINALSUBMISSION_REQUEST_TYPE_GET,(int)userId);
                        if (finalSubmissionMsg1 != null && finalSubmissionMsg1.contains("msg_tender_fs_finalsubmission_done")) {
                            modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg1.split("@")[0]);
//                            modelMap.addAttribute("msgArgumentOne", finalSubmissionMsg1.split("@")[1]);
//                            modelMap.addAttribute("msgArgumentTwo", CommonUtility.convertTimezone(finalSubmissionMsg1.split("@")[2]));
                        } else {
                            modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg1);
                        }
                        
                        if(isFormConfirmationReq == 1 && lstTenderBidDtls.size()>0){
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
									//tenderFormService.getBidderFromItemSelection(tenderId, userId, 0, false, false);
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
                		if(isWeightageEvaluationRequired && isGrandTotalWiseTenderResult){
//                			setWeightageEvaluation(tenderId,modelMap);
                		}
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
    	                    modelMap.addAttribute("msgArgumentTwo", finalSubmissionMsg.split("@")[2]);//CommonUtility.convertTimezone(finalSubmissionMsg.split("@")[2]));
                        } else {
                            modelMap.addAttribute("allowFinalSubmission", finalSubmissionMsg);
                        }
                        modelMap.addAttribute("lstTenderBid", tenderCommonService.getTenderBidDtls(tenderId, companyId, false));
                        modelMap.addAttribute("lstTenderBidCount", tenderCommonService.getTenderBidDtls(tenderId, companyId, true));
                        modelMap.addAttribute("bidWithdrawalDtls", eventBidSubmissionService.getBidWithDrawaldtls(tenderId, companyId));
                        
                        List<Object[]> lstTenderBidDtl = tenderCommonService.getTenderBidDtls(tenderId, companyId, false);
                        if(isFormConfirmationReq==1 && lstTenderBidDtl.size()>0){
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
                	  				   obj[4] = commonService.convertSqlToClientDate(client_dateformate_hhmm, date);
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
//                	    		tenderDataBean.setRebateId(obj[8]!=null?Integer.parseInt(obj[8].toString()):0);	    		
//                	    		tenderDataBean.setReportName(obj[9]!=null?obj[9].toString():"");
//                	    		tenderDataBean.setRebateCount(Integer.parseInt(obj[10].toString()));
//                	    		tenderDataBean.setDecryptVerifyCount(Integer.parseInt(obj[11].toString()));
                	    		tenderDataBean.setBidderCount(Integer.parseInt(obj[8].toString()));
                	    		tenderDataBean.setShowNoOfBidders(Integer.parseInt(obj[9].toString()));
                	    		
                	    	}
                	    }
                	    modelMap.addAttribute("tenderDetailList",tenderDataBean);
                            if(tblTender.getisAuction()==1)
                            {
                                modelMap.addAttribute("bidHistory", biddingFormService.getBidHistoryByBidderId(tblBidder.getBidderId(),tblTender.getTenderId()));
                            }
                            retVal="etender/bidder/TenderResult";
	                	break;
	                case TAB_PRE_BID:
	                	modelMap.addAttribute("tblTender",tblTender);
	                	int prebidCommitteeId = committeeFormationService.getCommitteeId(tenderId, 3);
	        	    	Object[] prebidDtls = tenderCommonService.getTenderPrebidDetailByTenderId(tenderId);
	        	    	if(prebidDtls!=null){
	        	    		modelMap.put("prebidstartdate", commonService.convertSqlToClientDate(client_dateformate_hhmm, prebidDtls[2].toString()));
	        	    		modelMap.put("prebidenddate", commonService.convertSqlToClientDate(client_dateformate_hhmm, prebidDtls[3].toString()));
	        	    	}
	        	    	modelMap.put("isCommitteeCreated", prebidCommitteeId!=0);
	        	    	modelMap.put("prebidDtls", prebidDtls);
	        	    	modelMap.put("tenderId", tenderId);
	        	    	modelMap.put("objectId", tenderPrebidObjectId);
	        	    	modelMap.put("childId", prebidCommitteeId);
	        	    	modelMap.put("currentDate", new Date());
	        	    	modelMap.put("subChildId", 0);
	        	    	modelMap.put("otherSubChildId", 0);
	                	retVal="etender/bidder/PrebidDashboardTabBidder";
				}
				List<Integer> cStatusList=new ArrayList<Integer>();
                cStatusList.add(1);
                modelMap.addAttribute("isAuction",tblTender.getisAuction());
                modelMap.addAttribute("clientDateFormate",client_dateformate_hhmm);
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
        modelAndView.addObject("tenderId", tenderId);
        modelAndView.addObject("objectId", bidderMapDocObjectId);
        modelAndView.addObject("childId", formId);
        modelAndView.addObject("subChildId", 0);
        modelAndView.addObject("otherSubChildId", 0);
        TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
        modelAndView.addObject("isAuction", tblTender.getisAuction());
        return modelAndView;
    }
    
    @RequestMapping(value = "/mandatorydocupload/{tenderId}/{formId}/{objectId}/{bidderId}", method = RequestMethod.GET)
    public ModelAndView getTenderReferenceDocument(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("objectId")Integer objectId,@PathVariable("bidderId")Integer bidderId, HttpServletRequest request) throws Exception {
        String retVal = "/etender/bidder/TenderReferenceDocument";
        ModelAndView modelAndView = new ModelAndView(retVal);
        modelAndView.addObject("tenderId", tenderId);
        modelAndView.addObject("docList",fileUploadService.getOfficerDocuments(tenderId, Integer.parseInt(bidderMandetoryMapDocObjectId), formId,0,0,2,bidderId));
        modelAndView.addObject("objectId", bidderMandetoryMapDocObjectId);
        modelAndView.addObject("childId", formId);
        modelAndView.addObject("subChildId", 0);
        modelAndView.addObject("otherSubChildId", 0);
        TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
        modelAndView.addObject("isAuction", tblTender.getisAuction());
        return modelAndView;
    }
    
    
         
}

