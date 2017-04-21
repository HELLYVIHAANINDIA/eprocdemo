/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.EvaluateBiddersDataBean;
import com.eprocurement.etender.databean.TenderDataBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblBidderApprovalDetail;
import com.eprocurement.etender.model.TblBidderItems;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblCurrency;
import com.eprocurement.etender.model.TblFinalsubmission;
import com.eprocurement.etender.model.TblShareReport;
import com.eprocurement.etender.model.TblShareReportDetail;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderBid;
import com.eprocurement.etender.model.TblTenderBidDetail;
import com.eprocurement.etender.model.TblTenderBidMatrix;
import com.eprocurement.etender.model.TblTenderBidOpenSign;
import com.eprocurement.etender.model.TblTenderCell;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderTable;
import com.eprocurement.etender.model.TblTenderopen;
import com.eprocurement.etender.services.BidderSubmissionService;
import com.eprocurement.etender.services.CommitteeService;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.OfficerService;
import com.eprocurement.etender.services.ReportService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;

@Controller
@RequestMapping("/etender/buyer")
public class EProcureDashboardController {
   
    @Autowired
	private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private CommitteeService committeeFormationService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private TenderService tenderService;
    @Autowired
    private BidderSubmissionService eventBidSubmissionService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private TenderService tenderFormService;
    @Autowired
    private ReportService reportService;
    @Autowired
    FormService biddingFormService;
    @Autowired
    OfficerService officerService;
    
    private static final String TENDERID = "tenderId";
    private static final String TABID = "tabId";
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/notloggedin";
    @Value("#{projectProperties['tenderPrebidObjectId']}")
    private String tenderPrebidObjectId;
    private static final String OPTYPE= "opType"; 
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String clientdateformatehhmm;
    
    @RequestMapping(value = "/gettabcontent/{tenderId}/{tabId}", method = RequestMethod.GET)
    public String getTabContent(@PathVariable(TENDERID) int tenderId,@PathVariable(TABID) int tabId, ModelMap modelMap, HttpServletRequest request) {
    	String retVal="/etender/buyer/TenderOpening";
		try {
			tenderCommonService.tenderSummary(tenderId, modelMap);
			modelMap.put("clientDateFormate",clientdateformatehhmm);
			modelMap.put("sessionUserId", commonService.getSessionUserId(request));
			setTenderOpeningEvaluationData(tenderId,modelMap,tabId);
			TblTender tblTender = tenderCommonService.getTenderById(tenderId);
			modelMap.addAttribute("tblTender",tblTender);
		    if(tabId==3) {
		    	retVal="/etender/buyer/TenderPrebidTab";
		    }else if (tabId==2) {
		    	modelMap.addAttribute("evaluationCommitteeId",committeeFormationService.getCommitteeId(tenderId,2));
		    	int isEvaluationRequired = (Integer) modelMap.get("isEvaluationRequired");
		    	int isEvaluationByCommittee = (Integer) modelMap.get("isEvaluationByCommittee");
		    	if(isEvaluationByCommittee == 1 || (isEvaluationByCommittee == 0 && isEvaluationRequired == 1))
					setEvaluationStatus(tenderId,modelMap);
		    	if(tblTender.getIsWeightageEvaluationRequired() == 1){	// for Weightage
		    		modelMap.addAttribute("isEvaluationScoreDone",tenderFormService.checkIsEvaluationScoreDone(tenderId));
					List<Object[]> data = reportService.getWeightageReportData(tenderId);
					if(data != null && !data.isEmpty()){
						modelMap.addAttribute("isWeightageDataSaved", true);
					}
		    	}
		    	retVal="/etender/buyer/TenderEvaluation";
		    	
		    }else if(tabId==1) {
		    	modelMap.addAttribute("isResultShareDone", tenderCommonService.isResultShareDone(tenderId));
		    	if(tblTender.getBiddingType() == 2){
		    		modelMap.addAttribute("exchangeRatePending", false);
			    	List<Object[]> exchangeRate  = tenderCommonService.getICBDetailsByTender(tenderId,1);
			    	if(exchangeRate != null && !exchangeRate.isEmpty()){
			    		modelMap.addAttribute("exchangeRatePending", true);
			    	}
			    	boolean isdecryptionlevelStarted  = reportService.isdecryptionlevel(tenderId);
			    	modelMap.addAttribute("isdecryptionlevelStarted", isdecryptionlevelStarted);
		    	}
		    	retVal="/etender/buyer/TenderOpening";
		    }
		    
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		}
		return retVal;
    } 
    private void setEvaluationStatus(int tenderId,ModelMap modelMap) throws Exception{
    	List<Object[]> envList = tenderFormService.getAllEnvelopeTypeByTenderId(tenderId);
    	long finalSubmissionCnt = tenderFormService.getCountofFinalSubmissionWithConsourtium(tenderId,(Integer)modelMap.get("isConsortiumAllowed"));
    	long finalSubmissionCntwithSecondaryPartner = tenderFormService.getCountofFinalSubmission(tenderId);
    	List<Object[]> tenderDetails = tenderCommonService.getTenderFields(tenderId, "isTwoStageEvaluation,envelopeType");
   		int envelopType = 0;
   		List<Integer> rejectdBidder=new ArrayList<Integer>();
   		if(tenderDetails != null && !tenderDetails.isEmpty()){
   			envelopType = Integer.parseInt(tenderDetails.get(0)[1].toString());
   			
   		}
   		Map<Integer,String> evaluationStatusMap = new HashMap<Integer, String>();
   		int evaluationDoneEnv = 0;
   		int previousEnvId = 0;
   		int pervEvaluationDoneEnv = -1;
		 for(Object[] tenderEnvelop : envList){
			 if(pervEvaluationDoneEnv != 0 && finalSubmissionCnt != 0){
				 finalSubmissionCnt = envelopType == 2 ? finalSubmissionCnt : ((Integer)tenderEnvelop[1] == 4 || (Integer)tenderEnvelop[1] == 5 ? finalSubmissionCntwithSecondaryPartner : finalSubmissionCnt);
				 previousEnvId = envelopType == 2 ? previousEnvId : -1;
				evaluationDoneEnv = tenderFormService.isEnvelopeWiseEvaluationDone(tenderId,(Integer)tenderEnvelop[0],finalSubmissionCnt,previousEnvId);
			 }else{
				evaluationDoneEnv = 0;
			 }
			 List<Object> lstEvaluationDateAndTime =tenderFormService.getOfficerEvaluationDateAndTime(tenderId,(Integer)tenderEnvelop[0]);
			 evaluationStatusMap.put((Integer)tenderEnvelop[0], evaluationDoneEnv == 0 ? "Pending" : (lstEvaluationDateAndTime!=null && !lstEvaluationDateAndTime.isEmpty())?lstEvaluationDateAndTime.get(0).toString():"");
			 previousEnvId = (Integer)tenderEnvelop[0];
			 pervEvaluationDoneEnv = evaluationDoneEnv;
		 }
		 boolean isOnlyOneEnvelop = tenderFormService.isOnlyOneEnvelopBuTenderId(tenderId);
		 List<Object[]> evaluatedEvlopeData=new ArrayList<Object[]>();
		 if(isOnlyOneEnvelop){
				evaluatedEvlopeData=tenderFormService.getBidderIdForOnlyOneEnvelop(tenderId);
			}else{
				evaluatedEvlopeData=tenderFormService.getApprovalDetlsOfTechnicalEnvlop(tenderId,0,0,0);
			}
		 List<Integer> bidderIdList=new ArrayList<Integer>();
			for (int j=0;j<evaluatedEvlopeData.size();j++) {
        		if(Integer.parseInt(evaluatedEvlopeData.get(j)[1].toString())==1){
        			bidderIdList.add(Integer.parseInt(evaluatedEvlopeData.get(j)[0].toString()));
        		}
        		else{
        			if((Integer) modelMap.get("envelopeType")==1){
        				bidderIdList.add(Integer.parseInt(evaluatedEvlopeData.get(j)[0].toString()));
        			}
        			if(!isOnlyOneEnvelop){
        				rejectdBidder.add(Integer.parseInt(evaluatedEvlopeData.get(j)[0].toString()));
        			}
        		}
    		}
			modelMap.put("rejectedBidder", rejectdBidder);
   		modelMap.addAttribute("evaluationStatusMap", evaluationStatusMap);
    }

    private void setTenderOpeningEvaluationData(int tenderId,ModelMap modelMap,int tabId) throws Exception{
    	List<Object[]> envWiseBidderEligibility = new ArrayList<Object[]>();
    	modelMap.addAttribute("envList",committeeFormationService.getTenderEnvelopeList(tenderId,tabId));
    	
    	List<Object[]> data = committeeFormationService.getTenderOpeningCommitteeMemberList(tenderId,tabId);
  	   if(data  != null ){
  		   for(Object[] obj : data ){
  			   if(obj[4] != null && !"".equals(obj[4].toString())){
  				   String date = obj[4].toString();
  				   obj[4] = commonService.convertSqlToClientDate(clientdateformatehhmm, date);
  			  }
  		   }
  	   }
	    modelMap.addAttribute("commMemList",data);
	    List<Object[]> bidderList = committeeFormationService.getTenderBidderList(tenderId,0);
	    modelMap.addAttribute("bidderList",bidderList);
	    List<Object[]> bidderFormList = committeeFormationService.getTenderBidderFormList(tenderId,tabId);
	    modelMap.addAttribute("bidderFormList",bidderFormList);
	    if(modelMap !=null && modelMap.get("biddingType") != null && Integer.parseInt(modelMap.get("biddingType").toString()) == 2){ 
	    	modelMap.addAttribute("ICBDetails",tenderCommonService.getICBDetailsByTender(tenderId,1));
	    }
	    
	    int envelopeType = modelMap !=null && modelMap.get("envelopeType") != null ? Integer.parseInt(modelMap.get("envelopeType").toString()) : 0;
	    List<Object[]> tenderDetailList = committeeFormationService.getTenderDetails(tenderId,tabId,envelopeType);
	    TenderDataBean tenderDataBean = new TenderDataBean();
	    if(tenderDetailList!=null && !tenderDetailList.isEmpty()){
	    	for(Object[] obj : tenderDetailList){
	    		tenderDataBean.setIsConsortiumAllowed(Integer.parseInt(obj[0].toString()));
	    		tenderDataBean.setEnvelopeType(Integer.parseInt(obj[1].toString()));
	    		tenderDataBean.setIsEncodedName(obj[2].toString());
	    		tenderDataBean.setAutoResultSharing(Integer.parseInt(obj[3].toString()));
	    		tenderDataBean.setTenderOpeningTimeLapsed(Integer.parseInt(obj[4].toString()));
	    		tenderDataBean.setEventTypeId(Integer.parseInt(obj[5].toString()));
	    		tenderDataBean.setTotalNoOfBidders(Integer.parseInt(obj[6].toString()));
	    		tenderDataBean.setIsRebateApplicable(Integer.parseInt(obj[7].toString()));
	    	}
	    }
	    modelMap.addAttribute("tenderDetailList",tenderDataBean);
	    modelMap.addAttribute("rejectedBidderMap",committeeFormationService.getRejectedBidderAppDtls(tenderId));
	    
        int userId = modelMap !=null && modelMap.get("sessionUserId") != null ? Integer.parseInt(modelMap.get("sessionUserId").toString()) : 0;
        int technicalEnvelopeId = 0;
        List<Object[]> lstEnvelope = tenderFormService.getTenderEnvelopeList(tenderId);
        LinkedHashMap<Integer, Boolean> envOpenStatus = new LinkedHashMap<Integer, Boolean>();
        LinkedHashMap<Integer, Boolean> envEvalStatus = new LinkedHashMap<Integer, Boolean>();
        for (int i=0 ; i<lstEnvelope.size() ; i++) {
        	 int envelopeId = Integer.parseInt(lstEnvelope.get(i)[2].toString());
        	 boolean remarksDone = tenderFormService.isEvaluationRemarksDone(tenderId,envelopeId);
        	 envOpenStatus.put(envelopeId, (Integer)lstEnvelope.get(i)[3]>0);
        	 envEvalStatus.put(envelopeId, (Integer)lstEnvelope.get(i)[5]>0 && remarksDone);
        	 int envId = Integer.parseInt(lstEnvelope.get(i)[0].toString());
        	 if (envId==3){
                 technicalEnvelopeId = envelopeId;                
             }
        	 int currentTotalBidder = 0;
             int prevTotalEligibleBidder = 0;
             int currentTotalEligibleBidder = 0;
             if (!bidderList.isEmpty()) {
                 for (Object[] lstBidder1 : bidderList) {
                	 Integer bidderEnvelopeId = Integer.parseInt(lstBidder1[0].toString()); 
                     if (envelopeId == bidderEnvelopeId) {
                         currentTotalBidder++;
                         if (lstBidder1[4] != null && !lstBidder1[0].toString().equals("null") && StringUtils.hasLength(lstBidder1[0].toString()) && bidderEnvelopeId == 1) {
                                 currentTotalEligibleBidder++;
                         }
                     }
                 }
             }
             envWiseBidderEligibility.add(new Object[]{envelopeId, currentTotalBidder, prevTotalEligibleBidder, currentTotalEligibleBidder});
             int prevRecord = envWiseBidderEligibility.size() - 2;
             if (prevRecord >= 0) {
                 Object[] prevEnv = envWiseBidderEligibility.get(prevRecord);
                 Object[] currEnv = envWiseBidderEligibility.get(prevRecord+1);
                 currEnv[2]=prevEnv[3];
                 envWiseBidderEligibility.add(prevRecord+1, currEnv);
             }
        }
        
        Map<Integer,Integer> isItemWiseLinkShowMap = new HashMap<Integer, Integer>();
        for(Object[] lstBidder1 : bidderList) {
            if(Integer.parseInt(lstBidder1[0].toString())==technicalEnvelopeId){
                int cmpId = Integer.parseInt(lstBidder1[1].toString());
                isItemWiseLinkShowMap.put(cmpId,tenderFormService.showItemSelection(userId, technicalEnvelopeId, cmpId,tenderId,companyCount(technicalEnvelopeId,envWiseBidderEligibility)));
            }
        }
        modelMap.addAttribute("isItemWiseLinkShowMap", isItemWiseLinkShowMap);
        modelMap.addAttribute("envOpenStatus", envOpenStatus);
        modelMap.addAttribute("envEvalStatus", envEvalStatus);
    }
    public int companyCount(int currentEnvId, List<Object[]> lst) {
        int cmpCount = 0;
        if (!lst.isEmpty()) {
            for (int i = 0; i < lst.size(); i++) {
                int envId = Integer.parseInt(lst.get(i)[0].toString());
                if (envId == currentEnvId) {
                    int totalBidder = Integer.parseInt(lst.get(i)[1].toString());
                    int totalPrevEligibleBidder = Integer.parseInt(lst.get(i)[2].toString());
                    int totalCurrentEligibleBidder = Integer.parseInt(lst.get(i)[3].toString());
                    if (totalCurrentEligibleBidder != 0) {
                        cmpCount = totalCurrentEligibleBidder;
                        break;
                    }else if (totalPrevEligibleBidder != 0) {
                        cmpCount = totalPrevEligibleBidder;
                        break;
                    } else {
                        cmpCount = totalBidder;
                        break;
                    }
                }
            }
        }
        return cmpCount;
    }
    /**
   	 * @return
   	 */
     @RequestMapping(value = "/getcommitteeuserremark/{tenderId}/{envelopeId}/{committeeUserId}/{committeeId}/{minOpeningMember}/{committeeType}", method = RequestMethod.GET)
      public String getCommitteeUserRemark(@PathVariable("tenderId") int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("committeeUserId") int committeeUserId,@PathVariable("committeeId") int committeeId,@PathVariable("minOpeningMember") int minOpeningMember,@PathVariable("committeeType") int committeeType,ModelMap modelMap,HttpServletRequest request) {
    	 String page="";
    	 try {
		        TblTenderEnvelope tblTenderEnvelope = tenderService.getTblTenderEnvelope(tenderId,envelopeId);
		    	modelMap.put("envelopeName", tenderCommonService.getEnvelopeNameById(tblTenderEnvelope.getTblEnvelope().getEnvId()));
		    	modelMap.put("minOpeningMember", minOpeningMember);
		   		page ="etender/buyer/GetCommitteeUserRemark";
          } catch (Exception e) {
              return exceptionHandlerService.writeLog(e);
          }
    	 return page;
      }
     
     @RequestMapping(value = "/addusercommitteeremarks", method = RequestMethod.POST)
     public String addUserComitRemarks(RedirectAttributes redirectAttributes, HttpServletRequest request,ModelMap modelMap) {
     	boolean success=false;
     	int tenderId = 0;
     	int envelopeId = 0;
     	int committeeUserId = 0;
     	int committeeId = 0;
     	int minOpeningMember = 0;
     	int committeeType = 0;
     	String remark=null;
     	String retVal=REDIRECT_SESSION_EXPIRED;
     	try{
     		int sessionUserId = commonService.getSessionUserId(request);
         	if(sessionUserId!=0){
	        	tenderId = StringUtils.hasLength(request.getParameter("hdTenderId"))? Integer.parseInt(request.getParameter("hdTenderId")):0;
	        	committeeType = StringUtils.hasLength(request.getParameter("hdCommitteeType")) ? Integer.parseInt(request.getParameter("hdCommitteeType")):0;
	        	committeeUserId = StringUtils.hasLength(request.getParameter("hdCommitteeUserId")) ? Integer.parseInt(request.getParameter("hdCommitteeUserId")):0;
	        	if (tenderFormService.checkConsentGiverorNotById(committeeUserId)==0){
		            envelopeId = StringUtils.hasLength(request.getParameter("hdEnvelopeId")) ? Integer.parseInt(request.getParameter("hdEnvelopeId")):0;
		            committeeId = StringUtils.hasLength(request.getParameter("hdCommitteeId")) ? Integer.parseInt(request.getParameter("hdCommitteeId")):0;
		            minOpeningMember = StringUtils.hasLength(request.getParameter("hdMinOpeningMember")) ? Integer.parseInt(request.getParameter("hdMinOpeningMember")):0;
		            remark = StringUtils.hasLength(request.getParameter("txtaRemarks")) ? request.getParameter("txtaRemarks"):null;
			        tenderFormService.updateUserComiteByComiteUserId(tenderId,envelopeId,committeeUserId,committeeId,sessionUserId,remark,minOpeningMember,committeeType);
	        	 }
	        	 else{
	        		 redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_success_usercommittee_consent_add" : "msg_error_usercommittee_consent_add" );
	        	 }
        	 retVal = "redirect:/etender/buyer/gettabcontent/"+tenderId+"/"+committeeType;
         	}
         }catch(Exception e){
         	return exceptionHandlerService.writeLog(e);
             
         }
         return retVal;
     }
     @RequestMapping(value = {"/pricebidICB/{tenderId}/{oprType}"}, method = RequestMethod.GET)
     public String getpricebidICB(@PathVariable("tenderId") int tenderId,@PathVariable("oprType") int oprType,HttpServletRequest request, ModelMap modelMap) {
 		try {
 			tenderCommonService.tenderSummary(tenderId, modelMap);
 			if(modelMap !=null && modelMap.get("biddingType") != null && Integer.parseInt(modelMap.get("biddingType").toString()) == 2){ 
 		    	modelMap.addAttribute("ICBDetails",tenderCommonService.getICBDetailsByTender(tenderId,3));
 		    }
//            redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_bid_converted_successfully");
//            retVal = "redirect:/etender/buyer/tenderDashboard/" + tenderId;
 		}catch (Exception e) {
 			return exceptionHandlerService.writeLog(e);
 		}
 		return "etender/buyer/PriceBidICBDetail";
     }
     /**
      * to get price opening date configuration page
      * @param tenderId
      * @param envelopeId
      * @param oprType ==1 for create, oprType == 2 for edit,oprType ==3 for publish,oprType ==4 for view,
      * @param request
      * @param modelMap
      * @return
      */
     @RequestMapping(value = {"/pricebidopeningdate/{tenderId}/{envelopeId}/{previousEnvlpId}/{oprType}","/editpricebidopeningdate/{tenderId}/{envelopeId}/{previousEnvlpId}/{oprType}","/publishpricebidopeningdate/{tenderId}/{envelopeId}/{previousEnvlpId}/{oprType}","/viewpricebidopeningdate/{tenderId}/{envelopeId}/{previousEnvlpId}/{oprType}"}, method = RequestMethod.GET)
     public String getPriceBidOpeningDate(@PathVariable("tenderId") int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("previousEnvlpId") int previousEnvlpId,@PathVariable("oprType") int oprType,HttpServletRequest request, ModelMap modelMap) {
 		try {
 				List<Object[]> listObjects=tenderFormService.getTenderEnvelopeDetails(envelopeId,1);
 				if(listObjects!=null && !listObjects.isEmpty() && oprType!=1){
 					modelMap.addAttribute("tenderEnvelopeDetailsList",listObjects);
 					modelMap.addAttribute("openingDateStr",commonService.convertSqlToClientDate(clientdateformatehhmm, listObjects.get(0)[3].toString()));
 					
 				}
 			tenderCommonService.tenderSummary(tenderId, modelMap);
 			if(request.getRequestURI().toString().contains("/buyer/viewpricebidopeningdateforwrkflw")){
 				modelMap.addAttribute("workFlowViewFlag", 1);
 			}else{
 				modelMap.addAttribute("workFlowViewFlag", 0);
 			}
 			modelMap.put("client_dateformate_hhmm",clientdateformatehhmm);
 		}catch (Exception e) {
 		    return exceptionHandlerService.writeLog(e);
 		}
 		return "etender/buyer/PriceBidOpeningDate";
     }
     /**
      * to update price bid ICB rate
      * @param redirectAttributes
      * @param request
      * @return
      */
     @RequestMapping(value = "/updatepricebidICB", method = RequestMethod.POST)
     public String updatePricebidICB(ModelMap modelMap,RedirectAttributes redirectAttributes, HttpServletRequest request) {
         String retVal = REDIRECT_SESSION_EXPIRED;
         int tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
         int oprType = StringUtils.hasLength(request.getParameter("hdOprType")) ? Integer.parseInt(request.getParameter("hdOprType")) : 0;
         int currencyId;
         int isDefault;
         String exchangeRate;
         int tenderCurrencyId;
         int hdRowCount = StringUtils.hasLength(request.getParameter("hdRowCount")) ? Integer.parseInt(request.getParameter("hdRowCount")):0;
         boolean success = false;
         try {
         	  int sessionUserId=commonService.getSessionUserId(request);
         	  if(sessionUserId != 0){
         		 List<TblTenderCurrency> tblTenderCurrencyList = new ArrayList<TblTenderCurrency>();
         		 for(int i=0;i<hdRowCount;i++){
         			currencyId = StringUtils.hasLength(request.getParameter("hdCurrencyId"+i)) ? Integer.parseInt(request.getParameter("hdCurrencyId"+i)):0;
         			tenderCurrencyId = StringUtils.hasLength(request.getParameter("hdTenderCurrencyId"+i)) ? Integer.parseInt(request.getParameter("hdTenderCurrencyId"+i)):0;
         			exchangeRate = StringUtils.hasLength(request.getParameter("txtExchangeRate"+i)) ? request.getParameter("txtExchangeRate"+i): "0";
         			isDefault = StringUtils.hasLength(request.getParameter("hdTenderDefault"+i)) ? Integer.parseInt(request.getParameter("hdTenderDefault"+i)):0;
         			
         			TblTenderCurrency tblTenderCurrency = new TblTenderCurrency(tenderCurrencyId);
         			tblTenderCurrency.setTblCurrency(new TblCurrency(currencyId));
         			tblTenderCurrency.setIsDefault(isDefault);
         			tblTenderCurrency.setExchangeRate(new BigDecimal(exchangeRate));
         			tblTenderCurrency.setTblTender(new TblTender(tenderId));
         			tblTenderCurrency.setIsActive(1);
         			tblTenderCurrencyList.add(tblTenderCurrency);
         		 }
         		 success = tenderFormService.updatePriceBidICB(tblTenderCurrencyList);
         			 retVal="redirect:/etender/buyer/gettabcontent/"+tenderId+"/1";
         		 }
         		 redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? (oprType == 1 || oprType == 2) ? "msg_success_pricebidICB" : "msg_success_pricebidICBpublish" : CommonKeywords.ERROR_MSG_KEY.toString());
         	  
         } catch (Exception ex) {
        	 retVal= exceptionHandlerService.writeLog(ex);
         }
         return retVal;
     }
     
     @RequestMapping(value = "/updatepricebidopeningdate", method = RequestMethod.POST)
     public String updatepricebidopeningdate(ModelMap modelMap,RedirectAttributes redirectAttributes, HttpServletRequest request) {
         String retVal = REDIRECT_SESSION_EXPIRED;
         int tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
         int envelopeId = StringUtils.hasLength(request.getParameter("hdEnvelopeId")) ? Integer.parseInt(request.getParameter("hdEnvelopeId")) : 0;
         int previousEnvlpId = StringUtils.hasLength(request.getParameter("hdPreviousEnvlpId")) ? Integer.parseInt(request.getParameter("hdPreviousEnvlpId")) : 0;
         int oprType = StringUtils.hasLength(request.getParameter("hdOprType")) ? Integer.parseInt(request.getParameter("hdOprType")) : 0;
         String priceOpeningDate=StringUtils.hasText(request.getParameter("txtPriceBidOpeningDate")) ? request.getParameter("txtPriceBidOpeningDate") : "";
         boolean success = false;
         try {
         	  int sessionUserId=commonService.getSessionUserId(request);
         	  if(sessionUserId != 0){
 	              if("".equals(priceOpeningDate) && (oprType == 1 || oprType == 2)){
 	            	  retVal="redirect:/etender/buyer/pricebidopeningdate/"+tenderId+"/"+envelopeId+"/"+previousEnvlpId+"/"+oprType;  
 	              }else{
 		        	  	if(oprType == 1 || oprType == 2){//create/edit
 		        		  success=tenderFormService.updatePriceBidOpeningDate(tenderId,envelopeId,priceOpeningDate);
 		        	  	}else if(oprType == 3){//publish
 		        	  		success=tenderFormService.publishPriceOpeningBid(tenderId,envelopeId);
 		        	  	}
 	            	    if(success){
 	            		  retVal="redirect:/etender/buyer/gettabcontent/"+tenderId+"/1";
 	            	    }
 	              }
 	              redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? (oprType == 1 || oprType == 2) ? "msg_success_pricebidopeningdate" : "msg_success_pricebidopeningdatepublish" : CommonKeywords.ERROR_MSG_KEY.toString());
         	  }
         } catch (Exception ex) {
         	retVal= exceptionHandlerService.writeLog(ex);
         }
         return retVal;
     }
     
     @RequestMapping(value = "/evaluatebidders/{tenderId}/{envelopeId}/{createEditFlage}/{envlopTypFlg}/{sortOrder}/{preEnvelopeId}/{isView}", method = RequestMethod.GET)
     public String getEvaluateBidders(@PathVariable("tenderId") int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("createEditFlage") int createEditFlage,@PathVariable("envlopTypFlg") int envlopTypFlg,@PathVariable("sortOrder") int sortOrder,@PathVariable("preEnvelopeId") int preEnvelopeId ,@PathVariable("isView") boolean isView,ModelMap modelMap,HttpServletRequest request) {
         try {
      	   StringBuilder formIds = new StringBuilder();
  	          	
       	  	/*** Get Common Services for tender detail **/
  			tenderCommonService.tenderSummary(tenderId, modelMap);
  			/*** get Yes No list from common services **/
  			modelMap.addAttribute("mandatoryList", commonService.getApproveReject());
  			
  			/*** Get TenderEnvelope details for tender Envelope name **/
  			TblTenderEnvelope tblTenderEnvelope = tenderCommonService.getTenderEnvelopeById(envelopeId);
              List <EvaluateBiddersDataBean> evaluateBiddersList = new ArrayList<EvaluateBiddersDataBean>();
  			/*** Get Evaluate bidders detail **/
  			@SuppressWarnings("unchecked")
  			List<Object[]> evaluateBiddersListObj = committeeFormationService.getEvaluateBiddersList(tenderId, envelopeId, preEnvelopeId,envlopTypFlg,sortOrder, createEditFlage);
  			List<Object[]> nextEnvelopFormIds =  tenderFormService.getNextEnvelopFormIdList(tenderId,sortOrder);
  			ArrayList<String> bidderIdList = new ArrayList<String>();
  			if(evaluateBiddersListObj!= null && !evaluateBiddersListObj.isEmpty()){
  				for(Object[] evalMap:evaluateBiddersListObj){
  					EvaluateBiddersDataBean evaluateBiddersDB = new EvaluateBiddersDataBean();
  					String bidderIdStr = evalMap[1].toString();
  					String[] bidderIdArr   = bidderIdStr.split("\\|~\\|"); 
  					bidderIdList.add(bidderIdArr[2]);
  					evaluateBiddersDB.setBidderIds(evalMap[1].toString());
  					evaluateBiddersDB.setCompanyName(evalMap[0].toString().substring(0,evalMap[0].toString().length()-1));
  					evaluateBiddersDB.setBidderApprovalId(evalMap[2].toString());
  					evaluateBiddersDB.setRemarks(evalMap[3].toString());
  					evaluateBiddersDB.setIsApproved(evalMap[4].toString());
  					evaluateBiddersList.add(evaluateBiddersDB);
  				}
  			}
  			if(!nextEnvelopFormIds.isEmpty()){
  				for(Object[] formMap:nextEnvelopFormIds){
  					formIds.append(formMap[0].toString()).append(",");
  				}
  			}
  			modelMap.put("bidderIdList", bidderIdList);
  			modelMap.put("tabId", 2);
  			modelMap.put("evaluateBiddersMap", evaluateBiddersList);
  			modelMap.put("tblTenderEnvelope",tblTenderEnvelope);
  			modelMap.put("formIds",formIds);
  			
         } catch (Exception e) {
             return exceptionHandlerService.writeLog(e);
         }
         return "/etender/buyer/Evaluatebidders";
     }
     
     @RequestMapping(value = "/saveevlutbiderstatus", method = RequestMethod.POST)
     public String saveEvlutBiderStatus(RedirectAttributes redirectAttributes, HttpServletRequest request) {
     	boolean success=false;
     	boolean tblEntryChk=false;
     	String retVal=REDIRECT_SESSION_EXPIRED;
        int tenderId=0;
        int envelopeId=0;
        int envlopTypFlg=0;
        String formIds="";
         try{
        	int sessionUserId = commonService.getSessionUserId(request);
        	if(sessionUserId!=0){
	        	tenderId = StringUtils.hasLength(request.getParameter("hdTenderId"))? Integer.parseInt(request.getParameter("hdTenderId")):0;  
	            envelopeId = StringUtils.hasLength(request.getParameter("hdEnvelopeId")) ? Integer.parseInt(request.getParameter("hdEnvelopeId")):0;
	            formIds = StringUtils.hasLength(request.getParameter("hdFormIds")) ? request.getParameter("hdFormIds") : "";
	            envlopTypFlg = StringUtils.hasLength(request.getParameter("hdEnvlopTypFlg")) ? Integer.parseInt(request.getParameter("hdEnvlopTypFlg")):0;
	        	int hdRowCount = StringUtils.hasLength(request.getParameter("hdRowCount")) ? Integer.parseInt(request.getParameter("hdRowCount")):0;
	        	TblBidderApprovalDetail tblBidderApprovalDetail;
	          	List<TblBidderApprovalDetail> tblBidderApprovalDtls=new ArrayList<TblBidderApprovalDetail>();
	          	String ipAddress = request.getHeader("X-FORWARDED-FOR") != null ? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
	          	tblEntryChk = tenderFormService.checkEntryBidderAppDtls(tenderId, envelopeId);
	          	if(tblEntryChk){
	          	List<Integer> companyIds = new ArrayList<Integer>();
	          	int bidderAprvYesNo;
	          	String bidstatus ="";
	          	TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
	          	for(int i=0;i<hdRowCount;i++){
          			bidderAprvYesNo = StringUtils.hasLength(request.getParameter("rdBidderAprvYesNo_"+i)) ? Integer.parseInt(request.getParameter("rdBidderAprvYesNo_"+i)):0;
          			String remarks = StringUtils.hasLength(request.getParameter("txtaRemarks_"+i)) ? request.getParameter("txtaRemarks_"+i):null;
          			String allBidderVal = StringUtils.hasLength(request.getParameter("hdAllValues_"+i)) ? request.getParameter("hdAllValues_"+i):null;
          			
          				
          					String[] singleBidderVal = (allBidderVal != null ? allBidderVal.split("\\|~~~\\|") : null);
          						if(singleBidderVal != null){
          							for(int j=0;j<singleBidderVal.length;j++){
          								String[] singleBidderIds = singleBidderVal[j].split("\\|~\\|");
          								if(singleBidderVal != null){
          									
          									tblBidderApprovalDetail = new TblBidderApprovalDetail();
                                  			tblBidderApprovalDetail.setTblTender(new TblTender(tenderId));
                                          	tblBidderApprovalDetail.setTblTenderenvelope(new TblTenderEnvelope(envelopeId));
                                          	tblBidderApprovalDetail.setCompanyid(Integer.parseInt(singleBidderIds[1]));
                                          	tblBidderApprovalDetail.setBidderid(Integer.parseInt(singleBidderIds[2]));
                                          	tblBidderApprovalDetail.setTblFinalsubmission(new TblFinalsubmission(Integer.parseInt(singleBidderIds[0])));
                                          	if(bidderAprvYesNo == 0){
                                          		bidstatus = "Rejected";
                                          		tblBidderApprovalDetail.setRemarks("Not Eligible");
                                          	}else{
                                          		bidstatus = "Accepted";
                                          		tblBidderApprovalDetail.setRemarks(remarks);	
                                          	}
                                          	
                                          	tblBidderApprovalDetail.setCreatedby(sessionUserId);
                                          	tblBidderApprovalDetail.setIsapproved(bidderAprvYesNo);
                                          	companyIds.add(Integer.parseInt(singleBidderIds[1]));
                                          	
                                          	tblBidderApprovalDtls.add(tblBidderApprovalDetail);	
                                          	
                                          //mail
                                          	
//                    	                    String subject = "Your Bid evaluation status for Tender ID: " + tenderId;
//                    	                    String text = "Dear User, \n \n This is to inform you that evaluation committee has "+bidstatus+" bid in the following Tender: \n\n Tender ID :" + tenderId + "\n Reference No." +tblTender.getTenderNo()+ "\n ";
//                    	                    officerService.addMail(officerService.setTblMailMessage(formService.getTblBidderCompanyId(companyId).getEmailId(),mailFrom, subject,text,subject));
          								}
          							}		
          						}
	          			}
	          	
	          	if(envlopTypFlg == 2 && !"0".equals(formIds)){
	          		String[] strArray = formIds.split(",");
	          		List<Integer> tblTenderFormList = new ArrayList<Integer>();
		          	for(int i = 0; i < strArray.length; i++) {
		          		tblTenderFormList.add(Integer.parseInt(strArray[i]));
		          	}
		          	
	        		List<TblTenderBid> tblTenderBidList = eventBidSubmissionService.getTenderBid(tenderId, companyIds.toArray(),tblTenderFormList.toArray());
	        		
	        		if(tblTenderBidList != null && !tblTenderBidList.isEmpty()){
	        			List<TblTenderopen> tblTenderOpenList = new ArrayList<TblTenderopen>();
	        			List<TblTenderBidOpenSign> tblTenderBidOpenSignList = new ArrayList<TblTenderBidOpenSign>();
	        			List<TblTenderBidDetail> tblTenderBidDetailList = new ArrayList<TblTenderBidDetail>();
	        			List<String> userFormIds = new ArrayList<String>();
	        			
	            		for(TblTenderBid tblTenderBid : tblTenderBidList){
	            			String userFormId = tblTenderBid.getTblTenderform().getFormId() + "~" + tblTenderBid.getTblCompany().getCompanyid(); 
	            			if(!userFormIds.contains(userFormId)){
		            			TblTenderopen tblTenderOpen = new TblTenderopen();
		            			tblTenderOpen.setTblTender(tblTenderBid.getTblTender());
		            			tblTenderOpen.setTblTenderenvelope(tblTenderBid.getTblTenderenvelope());
		            			tblTenderOpen.setTblTenderForm(tblTenderBid.getTblTenderform());
		            			tblTenderOpen.setTblCompany(tblTenderBid.getTblCompany());
		            			tblTenderOpen.setBidderid(tblTenderBid.getBidderid());
		            			tblTenderOpen.setDecryptionlevel(0);
		            			tblTenderOpen.setIpaddress(ipAddress);
		            			tblTenderOpen.setCreatedby(sessionUserId);
		            			tblTenderOpenList.add(tblTenderOpen);
	            			}
	            			
	            			List<TblTenderBidMatrix> tblTenderBidMatrixList = eventBidSubmissionService.getTableBidMatrix(tblTenderBid.getBidid());
	            			
	            			if(tblTenderBidMatrixList != null && !tblTenderBidMatrixList.isEmpty()){
	            				for(TblTenderBidMatrix tblTenderBidMatrix : tblTenderBidMatrixList){
	            					TblTenderBidOpenSign tblTenderBidOpenSign = new TblTenderBidOpenSign();
	            					tblTenderBidOpenSign.setTblTenderbidmatrix(tblTenderBidMatrix);
	            					tblTenderBidOpenSign.setDecryptedbid(tblTenderBidMatrix.getBidjson());
	            					tblTenderBidOpenSign.setBidsigntext(tblTenderBidMatrix.getBidjson());
	            					tblTenderBidOpenSign.setCreatedby(sessionUserId);
	            					tblTenderBidOpenSignList.add(tblTenderBidOpenSign);
	            					
	            					JSONArray jsonArray = new JSONArray(tblTenderBidMatrix.getBidjson());
	            					for (int i = 0; i < jsonArray.length(); i++) {
	            						JSONObject jSONObject = jsonArray.getJSONObject(i);
	            						for (Iterator it = jSONObject.keys(); it.hasNext();) {
	            							String key = it.next().toString();
	            							String[] keyValues = key.split("_");
	            							String jsonValue = jSONObject.getString(key);
	            							
	            							TblTenderBidDetail tblTenderBidDetail = new TblTenderBidDetail();
	            							tblTenderBidDetail.setTblTenderbidmatrix(tblTenderBidMatrix);
	            							tblTenderBidDetail.setTblTendercell(new TblTenderCell(Integer.parseInt(keyValues[0])));
	            							tblTenderBidDetail.setCellno(Integer.parseInt(keyValues[1]));
	            							tblTenderBidDetail.setCellvalue(jsonValue);
	            							tblTenderBidDetailList.add(tblTenderBidDetail);
	                                    }
	            					}
	            				}
	            			}
	            		}
	            		success = tenderFormService.addBidderAprvalDtls(tblBidderApprovalDtls,tblTenderOpenList, tblTenderBidOpenSignList, tblTenderBidDetailList);
	            		
	            		if(success){
	            			TblTenderEnvelope tblTenderEnvelope = tenderFormService.getTblTenderEnvelope(tenderId);
	            			if (tblTenderEnvelope.getEnvelopeId() == envelopeId){
	            				tenderFormService.updateTblTender(tenderId);
	            			}
	            		}
	        		}
	          	}
	          	else
	          	{
	          		success = tenderFormService.addBidderAprvalDtls(tblBidderApprovalDtls);
	          		if(success){
            			TblTenderEnvelope tblTenderEnvelope = tenderFormService.getTblTenderEnvelope(tenderId);
            			if (tblTenderEnvelope.getEnvelopeId() == envelopeId){
            				tenderFormService.updateTblTender(tenderId);
            			}
            		}
	          	}
          	}else{
          		retVal="redirect:/etender/buyer/gettabcontent/"+tenderId+"/2";
         		redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_already_evaluate_bidders_status_add");
                return retVal;
          	}
    	} 		
          		
         }catch(Exception e){
         	return exceptionHandlerService.writeLog(e);
         }
         retVal=success ? "etender/buyer/gettabcontent/"+tenderId+"/2" : "etender/buyer/evaluatebidders/"+tenderId+"/"+envelopeId+"/"+2;
  		 retVal="redirect:/" + retVal ;
  		 redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_success_evaluate_bidders_status_add" : CommonKeywords.ERROR_MSG_KEY.toString());
         return retVal;
     }
     /**
 	 * Use for Price Bid Item Wise Evaluation
 	 * @param request
	 	 * @param ModelMap
	 	 * @throws Exception
	 	 * @return
 	 */
     @RequestMapping(value = "/bidderWiseevaluation/{tenderId}/{envelopeId}/{bidderId}/{companyId}/{commiteeType}/{isView}/{tenderResult}/{rejectFlag}", method = RequestMethod.GET)
     public String getEvaluateBiddersWise(@PathVariable("tenderId") int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("bidderId") int bidderId,@PathVariable("companyId") int companyId,@PathVariable("commiteeType") int commiteeType,@PathVariable("isView") boolean isView,@PathVariable("tenderResult") int tenderResult,@PathVariable("rejectFlag") String rejectFlag,ModelMap modelMap,HttpServletRequest request) {
         try {
        	 tenderCommonService.tenderSummary(tenderId, modelMap);
        	 List<Object[]> formAndTableDetalisList=tenderCommonService.getTenderFormAndTableByTenderId(tenderId,bidderId,0);
        	 modelMap.addAttribute("formAndTableDetalisList",formAndTableDetalisList);
        	 int sessionUserId = commonService.getSessionUserId(request);
        	 modelMap.addAttribute("CompanyDetls",tenderCommonService.getTblCompany(companyId));
        	 modelMap.addAttribute("companyId",companyId);
        	 List<Object[]> userRoleEncryptionLeval=tenderFormService.getUserRoleId(tenderId, envelopeId, commiteeType, sessionUserId);
        	 List<Integer> tblIds=new ArrayList<Integer>();
        	 for(int i=0;i<formAndTableDetalisList.size();i++){
        		 tblIds.add((Integer)formAndTableDetalisList.get(i)[4]);
        	 }
        	 List<Object[]> colmList=tenderCommonService.getColumnDetailsFromTableId(tblIds);
        	 List<Integer> clmIds=new ArrayList<Integer>();
        	 for(int i=0;i<colmList.size();i++){
        		 clmIds.add((Integer)colmList.get(i)[0]);
        	 }
        	 modelMap.addAttribute("ListColumDtls",colmList);
        	 List<Object[]> cellList = new ArrayList<Object[]>();
        		 cellList=tenderCommonService.getCellDetailsFromColumnId(clmIds);
        	 int cellListSize=cellList.size();
        	Map<String, List<Map<Integer, List<String>>>> CelldataMap=new HashMap<String, List<Map<Integer, List<String>>>>();
 			String rowStr=null;
 			for (int i = 0; i < cellList.size(); i++) {
 				if(i<cellListSize){
 					rowStr=cellList.get(i)[2].toString();
 				}else{
 					String dwVal  = cellList.get(i)[2]!=null ? cellList.get(i)[2].toString() : "";
 					rowStr=dwVal+cellList.get(i)[5].toString();
 				}if(CelldataMap.containsKey(cellList.get(i)[4].toString())){
 					List<Map<Integer, List<String>>> rowMap=CelldataMap.get(cellList.get(i)[4].toString());
 					boolean flag=false;
 					for (int j = 0; j < rowMap.size(); j++) {
 						if(rowMap.get(j).containsKey(cellList.get(i)[1])){
 							Map<Integer, List<String>> oneMap=rowMap.get(j);
 							List<String> rowddta=oneMap.get(cellList.get(i)[1]);
 							rowddta.add(rowStr);
 							oneMap.put((Integer)cellList.get(i)[1],rowddta);
 							rowMap.set(j, oneMap);
 							CelldataMap.put(cellList.get(i)[4].toString(), rowMap);
 							flag=true;
 							break;
 						}
 					}
 					if(!flag){
 						Map<Integer, List<String>> oneMap=new HashMap<Integer,List<String>>();
 						List<String> s=new ArrayList<String>();
 						s.add(rowStr);
 						oneMap.put((Integer)cellList.get(i)[1], s);
 						rowMap.add(oneMap);
 						CelldataMap.put(cellList.get(i)[4].toString(), rowMap);
 					}	
 				}else{
 					List<Map<Integer, List<String>>> rowMap=new ArrayList<Map<Integer,List<String>>>();
 					Map<Integer, List<String>> oneMapp=new HashMap<Integer,List<String>>();
 					List<String> rowList=new ArrayList<String>();
 					rowList.add(rowStr);
 					oneMapp.put((Integer)cellList.get(i)[1], rowList);
 					rowMap.add(oneMapp);
 					CelldataMap.put(cellList.get(i)[4].toString(), rowMap);
 				}
 			}
        	 if(((Integer)userRoleEncryptionLeval.get(0)[1]==0 || (Integer)userRoleEncryptionLeval.get(0)[1]==2) && (Integer)userRoleEncryptionLeval.get(0)[0]==1){
        		 modelMap.put("isChairPersonReq","1");
        	}else{
        		modelMap.put("isChairPersonReq","0");
        	}
        	modelMap.addAttribute("ListCellDtls",CelldataMap);
        	modelMap.addAttribute("ApprovedRejectList", commonService.getApproveReject());
        	modelMap.put("userRoleId", userRoleEncryptionLeval.get(0)[0]);
        	modelMap.put("encryptionLevel",userRoleEncryptionLeval.get(0)[1]);
	        modelMap.put("tenderId", tenderId);
			modelMap.put("envelopeId", envelopeId);
			modelMap.put("bidderId", bidderId);
			modelMap.put("committeeType",commiteeType);

            boolean isAnyPriceBid = false;
            if(tenderResult != 1){
            	List<Object[]> isAnyPriceBidlist = tenderCommonService.getTenderFormAndTableByTenderId(tenderId,bidderId,1);
            	isAnyPriceBid = !isAnyPriceBidlist.isEmpty() && isAnyPriceBidlist.size() != 0 ? true : false;
            }
            modelMap.addAttribute("isAnyPriceBid",isAnyPriceBid);
         } catch (Exception e) {
             return exceptionHandlerService.writeLog(e);
         }
         return "/etender/buyer/EvaluateBidderWise";
     }
     //Item wise Tender
     @RequestMapping(value = "/saveBidderWiseEvaluation", method = RequestMethod.POST)
     public String saveBidderWiseEvaluation(RedirectAttributes redirectAttributes, HttpServletRequest request) {
     	boolean success=false;
     	String retVal;
        int tenderId=0;
        int envelopeId=0;
        int companyId =0;
        int bidderId =0;
         try{
        	 int sessionUserId = commonService.getSessionUserId(request);
	    	 if(sessionUserId!=0){
		     tenderId = StringUtils.hasLength(request.getParameter("hdTenderId"))? Integer.parseInt(request.getParameter("hdTenderId")):0;  
		     envelopeId = StringUtils.hasLength(request.getParameter("hdEnvelopeId")) ? Integer.parseInt(request.getParameter("hdEnvelopeId")):0;
		     bidderId = StringUtils.hasLength(request.getParameter("hdBidderId"))? Integer.parseInt(request.getParameter("hdBidderId")):0;
	         int userRoleId = StringUtils.hasLength(request.getParameter("hdUserRoleId"))? Integer.parseInt(request.getParameter("hdUserRoleId")):0;
	         companyId = StringUtils.hasLength(request.getParameter("hdCompanyId"))? Integer.parseInt(request.getParameter("hdCompanyId")):0;
	         TblBidderApprovalDetail tblBidderApprovalDetail;
       		 List<TblBidderApprovalDetail> tblBidderApprovalDtls=new ArrayList<TblBidderApprovalDetail>();
       		 int hdRowCount = StringUtils.hasLength(request.getParameter("hdRowCount")) ? Integer.parseInt(request.getParameter("hdRowCount")):0;
       		 int bidderAprvYesNo;
       		 List<Object[]> bidderwiseItmEntry = tenderFormService.ChkandgetItemWiseEvaluationData(tenderId,envelopeId,sessionUserId,bidderId);
       		 List<TblBidderItems> bidderItemsList = new ArrayList<TblBidderItems>();
       		 int isBidderAprvl=0;
       		 int formId=0;
       		 int tableId;
       		 int rowId;
		     if(bidderwiseItmEntry.isEmpty()){
	          		for(int i=0;i<hdRowCount;i++){
		          		String allValue = StringUtils.hasLength(request.getParameter("hdAllValues_"+i)) ? request.getParameter("hdAllValues_"+i):null;
	          			bidderAprvYesNo = StringUtils.hasLength(request.getParameter("rdBidderAprvYesNo_"+allValue)) ? Integer.parseInt(request.getParameter("rdBidderAprvYesNo_"+allValue)):0;	          				
	          			String remarks = StringUtils.hasLength(request.getParameter("txtaRemarks_"+allValue)) ? request.getParameter("txtaRemarks_"+allValue):null;
	          			String allIds[]=allValue.split("_");
	          			if(allIds[1] != null){
	          				formId=Integer.parseInt(allIds[1]);
	          			}
	          			if(bidderAprvYesNo==1){
	          				isBidderAprvl=1;
	          			}
          				tableId = Integer.parseInt(allIds[2]);
          				rowId = Integer.parseInt(allIds[3]);
	          			TblBidderItems tblBidderItems = new TblBidderItems();
	          			tblBidderItems.setTblTender(new TblTender(tenderId));
	          			tblBidderItems.setUserRoleId(userRoleId);
                    	 tblBidderItems.setIsCPRemarks(0);	 
                    	 tblBidderItems.setUserRoleId(0);
 	                	tblBidderItems.setTblTenderEnvelope(new TblTenderEnvelope(envelopeId));
 	                	tblBidderItems.setTblTenderForm(new TblTenderForm(formId));//formId
 	                		tblBidderItems.setTblTenderTable(new TblTenderTable(tableId));//tableId
 	                	tblBidderItems.setRemarks(remarks);
 	                	tblBidderItems.setRowId(rowId);//rowId
 	                	tblBidderItems.setTblBidder(new TblBidder(bidderId));
 	                	tblBidderItems.setTblCompany(new TblCompany(companyId));
 	                	tblBidderItems.setCreatedBy(sessionUserId); // user login id.
 	                	tblBidderItems.setIsActive(1);//1 for approve items
 	                	tblBidderItems.setChildId(0);
 	                	tblBidderItems.setIsApproved(bidderAprvYesNo);//1 for approve items
 	                    bidderItemsList.add(tblBidderItems);
		          	}
	          		if(bidderItemsList != null && !bidderItemsList.isEmpty()){
	          			success = tenderFormService.saveAllTblBidderItemsWiseEvaluation(bidderItemsList);
	                 }
		       }
	          	boolean bidderwiseItmApprovalEntry = tenderFormService.checkEntryBidderAppDtlsBidderWise(tenderId, envelopeId,bidderId);
	          	if(success && bidderwiseItmApprovalEntry){
	          		int finalSubmissionId = tenderFormService.getFinalSubmissionId(tenderId,bidderId) != null ? tenderFormService.getFinalSubmissionId(tenderId,bidderId).getFinalsubmissionid() : 0;
	          		tblBidderApprovalDetail = new TblBidderApprovalDetail();
	          		tblBidderApprovalDetail.setTblTender(new TblTender(tenderId));
	              	tblBidderApprovalDetail.setTblTenderenvelope(new TblTenderEnvelope(envelopeId));
	              	tblBidderApprovalDetail.setCompanyid(companyId);
	              	tblBidderApprovalDetail.setBidderid(bidderId);
	              	tblBidderApprovalDetail.setTblFinalsubmission(new TblFinalsubmission(finalSubmissionId));
	              	tblBidderApprovalDetail.setRemarks("Item Wise Auto Remarks");
	              	tblBidderApprovalDetail.setCreatedby(sessionUserId);
	              	tblBidderApprovalDetail.setIsapproved(isBidderAprvl);
	              	tblBidderApprovalDtls.add(tblBidderApprovalDetail);
	              	success = tenderFormService.addEachBidderAprvalDtls(tblBidderApprovalDtls);
	          	}
	          	if(tenderFormService.getCountofBidderItems(tenderId,envelopeId) == tenderFormService.getCountofBidderapprovaldetail(tenderId,envelopeId)){
	          		tenderFormService.updateTblTender(tenderId);
	          	}
	        }
        } 		
	     catch(Exception e){
	     	return exceptionHandlerService.writeLog(e);
	     }
	     retVal="etender/buyer/gettabcontent/"+tenderId+"/2" ;
  		 retVal="redirect:/" + retVal ;
  		 redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_success_evaluate_bidders_status_add" : CommonKeywords.ERROR_MSG_KEY.toString());
	     return retVal;
     }
     
     @RequestMapping(value = "/updateevlutbiderstatus", method = RequestMethod.POST)
     public String updateEvlutBiderStatus(RedirectAttributes redirectAttributes, HttpServletRequest request) {
     	boolean success=false;
     	String retVal=REDIRECT_SESSION_EXPIRED;
        int tenderId=0;
        int envelopeId=0;
               
         try{
        	 int sessionUserId = commonService.getSessionUserId(request);
         	if(sessionUserId!=0){
        	 tenderId = StringUtils.hasLength(request.getParameter("hdTenderId"))? Integer.parseInt(request.getParameter("hdTenderId")):0;  
             envelopeId = StringUtils.hasLength(request.getParameter("hdEnvelopeId")) ? Integer.parseInt(request.getParameter("hdEnvelopeId")):0;	 
        	 int hdRowCount = StringUtils.hasLength(request.getParameter("hdRowCount")) ? Integer.parseInt(request.getParameter("hdRowCount")):0;
        	TblBidderApprovalDetail tblBidderApprovalDetail;
          	List<TblBidderApprovalDetail> tblBidderApprovalDtls=new ArrayList<TblBidderApprovalDetail>();
          	 int bidderAprvYesNo;
          	for(int i=0;i<hdRowCount;i++){
      			bidderAprvYesNo = StringUtils.hasLength(request.getParameter("rdBidderAprvYesNo_"+i)) ? Integer.parseInt(request.getParameter("rdBidderAprvYesNo_"+i)):0;
      			String remarks = StringUtils.hasLength(request.getParameter("txtaRemarks_"+i)) ? request.getParameter("txtaRemarks_"+i):null;
      			String allBidderVal = StringUtils.hasLength(request.getParameter("hdAllValues_"+i)) ? request.getParameter("hdAllValues_"+i):null;
					String[] singleBidderVal = (allBidderVal != null ? allBidderVal.split("\\|~~~\\|") : null);
					if(singleBidderVal != null){
						for(int j=0;j<singleBidderVal.length;j++){
							String[] singleBidderIds = singleBidderVal[j].split("\\|~\\|");
							if(singleBidderVal != null){
								tblBidderApprovalDetail = new TblBidderApprovalDetail();
                      			tblBidderApprovalDetail.setTblTender(new TblTender(tenderId));
                      			tblBidderApprovalDetail.setTblTenderenvelope(new TblTenderEnvelope(envelopeId));
                              	tblBidderApprovalDetail.setCompanyid(Integer.parseInt(singleBidderIds[1]));
                              	tblBidderApprovalDetail.setBidderid(Integer.parseInt(singleBidderIds[2]));
                              	tblBidderApprovalDetail.setTblFinalsubmission(new TblFinalsubmission(Integer.parseInt(singleBidderIds[0])));
                              	tblBidderApprovalDetail.setRemarks(remarks);
                              	tblBidderApprovalDetail.setIsapproved(bidderAprvYesNo);
                              	
                              	tblBidderApprovalDtls.add(tblBidderApprovalDetail);	
							}
						}		
					}
  				}
          	
          		success = tenderFormService.updateBidderAprvalDtls(envelopeId, tblBidderApprovalDtls);
          		retVal=success ? "etender/buyer/gettabcontent/"+tenderId+"/2" : "etender/buyer/evaluatebidders/"+tenderId+"/"+envelopeId+"/"+2;
         		retVal="redirect:/" + retVal ;
         	}
         }catch(Exception e){
         	return exceptionHandlerService.writeLog(e);
         }
         
  		 redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_success_evaluate_bidders_status_update" : CommonKeywords.ERROR_MSG_KEY.toString());
         return retVal;
     }
     private void setViewDataForReportConfit(ModelMap modelMap, Object[] reportDetail) {
 		if(reportDetail!=null && reportDetail.length>0){
 				if((Integer)reportDetail[0]==1){//shareReport For All Bidder
 					modelMap.addAttribute("shareReport","All bidders");
 				}else if((Integer)reportDetail[0]==2){//shareReport For Qualified Bidder
 					modelMap.addAttribute("shareReport","Qualified bidders");
 				}else if((Integer)reportDetail[0]==3){//shareReport For Participated Bidder
 					modelMap.addAttribute("shareReport","Participated bidders");
 				}
 				
 				if((Integer)reportDetail[1]==1){//showResultBeforeLogin
 					modelMap.addAttribute("showResultBeforeLogin","Yes");
 				}else{
 					modelMap.addAttribute("showResultBeforeLogin","No");
 				}
 				
 				if((Integer)reportDetail[2]==1){//showL1Report
 					modelMap.addAttribute("showL1Report","Yes");
 				}else{
 					modelMap.addAttribute("showL1Report","No");
 				}
 				
 				
 		}
 	}
     @RequestMapping(value = "/getresultsharing/{tenderId}/{flag}", method = RequestMethod.GET)
     public String getResultSharingPage(@PathVariable("tenderId") int tenderId,@PathVariable("flag") int flag,ModelMap modelMap,HttpServletRequest request) {
         try {
        	 List<Object[]> reportData=reportService.getShareReports(tenderId);
        	 List<Object[]> formDetalisList =reportService.getTenderFormForResultShare(tenderId);
        	 modelMap.addAttribute("formDetalisList",formDetalisList);
        	 modelMap.addAttribute("envelopeList",tenderFormService.getTenderEnvelopeForPublish(tenderId,true));
        	 if(reportData!=null && !reportData.isEmpty() && formDetalisList!=null && !formDetalisList.isEmpty()){
					Object[] reportDetail=reportData.get(0);
					modelMap.addAttribute("shareReportsData",reportDetail);

					if(flag==2){//In View Case show label field instead of input type
						setViewDataForReportConfit(modelMap,reportDetail);
						modelMap.addAttribute(OPTYPE,"view");
					}else{
						modelMap.addAttribute(OPTYPE,"update");
					}
					
					List<Object[]> formReportsData=reportService.getShareReportDetailsByReportId((Integer)reportData.get(0)[7]);
					List<String> formChartList= new ArrayList<String>();
					if(formReportsData!=null && !formReportsData.isEmpty() ){
						for(Object[] formReport: formReportsData){
							for(Object[] formDetail: formDetalisList){
								if(formDetail[0].toString().equals(formReport[4].toString())){
									if((Integer)formReport[0] ==1){//Individual
										formChartList.add("1");
									}else{
										formChartList.add("11");
									}
									if((Integer)formReport[1] ==1){//Comparative
										formChartList.add("2");
									}else{
										formChartList.add("22");
									}
								}
							}
						}
					}
					modelMap.addAttribute("formChartList", formChartList);
					modelMap.addAttribute("formReportsData", formReportsData);
					
				}
        	 modelMap.addAttribute("chartList", reportService.getChartList());
			modelMap.addAttribute("chartListWith", reportService.getReportstWith());
         }catch (Exception e) {
  			return exceptionHandlerService.writeLog(e);
  		}
  		return "etender/buyer/SharingResult";
     }
     
     @RequestMapping(value = "/addtenderresultconfig", method = RequestMethod.POST)                       
     public String addTenderResultConfig(RedirectAttributes redirectAttributes, HttpServletRequest request){
     	String retVal=REDIRECT_SESSION_EXPIRED;
     	int tenderId=0;
     	boolean success = false;
     	try{
     		if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
				SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
     			tenderId = StringUtils.hasLength(request.getParameter("hdTenderId"))?Integer.parseInt(request.getParameter("hdTenderId")):0;
     			String l1Reports[];
     			l1Reports= request.getParameterValues("l1Reports");
     			TblShareReport tblShareReport = new TblShareReport();
     			String shareDiffReports[]; 
     			String shareReportwith[];
     				String formIds = request.getParameter("hdFormIds");
     				if(tenderId!=0 && StringUtils.hasLength(formIds)){
     					tblShareReport.setCreatedBy((int) sBean.getUserId());
     					tblShareReport.setIsActive(1);
     					tblShareReport.setTblTender(new TblTender(tenderId));
         				if(formIds.length()>1 && formIds.startsWith(",")){
         					formIds=formIds.substring(1,formIds.length());
         				}
         				List<TblShareReportDetail> tblShareReportDetails= new ArrayList<TblShareReportDetail>();
         				for (String formId:formIds.split(",")) {
         					if(formId.trim().equals("")){
         						continue;
         					}
         					TblShareReportDetail tblShareReportDetail= new TblShareReportDetail();
         					tblShareReportDetail.setTblTenderForm(new TblTenderForm(Integer.parseInt(formId)));
         					int hdShareReportCount = request.getParameter("hdShareReportCount") !=null ? Integer.parseInt( request.getParameter("hdShareReportCount").toString()) : 0;
         					for(int i = 0 ; i <= hdShareReportCount ; i++){
         						shareDiffReports = request.getParameterValues("reports_"+formId+"_"+i);
             					if(shareDiffReports!=null && shareDiffReports.length>0){
             						for(String value:shareDiffReports){
             							
             							if(value.equals("Individual")){
             								tblShareReportDetail.setShareIndividualReport(1);
             							}else if(value.equals("Comparative")){
             								tblShareReportDetail.setShareComparativeReport(1);
             							}
             						}
             					}
             					tblShareReportDetails.add(tblShareReportDetail);
         					}
         				}
         				shareReportwith =  request.getParameterValues("rptwith");
         				if(shareReportwith!= null && shareReportwith.length>0){
         					if(shareReportwith[0].equals("All Bidders")){
         						tblShareReport.setShareReport(1);
         					}
         					if(shareReportwith[0].equals("Qualified Bidders")){
         						tblShareReport.setShareReport(2);
         					}
         					
         				}
       					tblShareReport.setShowResultBeforeLogin(1);
         				if(l1Reports!= null && l1Reports.length>0){
         					tblShareReport.setShowL1Report(Integer.parseInt(l1Reports[0]));
         				}
         				success=reportService.addTenderResultConfig(tblShareReport,tblShareReportDetails);
         				retVal="etender/buyer/tenderDashboard/"+tenderId ;
                 		retVal="redirect:/" + retVal ;
         			}
     		}
     	}
     	catch(Exception ex){
     		retVal= exceptionHandlerService.writeLog(ex);
     	}
     	redirectAttributes.addFlashAttribute(success ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), success ? "msg_open_rslt_share_config" : "msg_open_rslt_error_share_config");
     	return retVal;
     }
     @RequestMapping(value = "/getresult/{tenderId}", method = RequestMethod.GET)
     public String getResult(@PathVariable(TENDERID) int tenderId, ModelMap modelMap, HttpServletRequest request,RedirectAttributes redirectAttributes) {
     	String retVal = REDIRECT_SESSION_EXPIRED;
 		try {
 			if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
 				SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
 				TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
 				 modelMap.addAttribute("isResultShareDone", tenderCommonService.isResultShareDone(tenderId));
                 modelMap.addAttribute("envList",committeeFormationService.getTenderEnvelopeList(tenderId,3));//result-set-2
                 List<Object[]> bidderList = committeeFormationService.getTenderBidderList(tenderId,0);
         	    modelMap.addAttribute("bidderList",bidderList);//result-set-3
         	    List<Object[]> bidderFormList = committeeFormationService.getTenderBidderFormList(tenderId,3);//#result-set-4
         	    modelMap.addAttribute("bidderFormList",bidderFormList);
         	    TblShareReport tblShareReport =  tenderCommonService.getTblShareReportById(tenderId);
         	    modelMap.addAttribute("tblShareReport",tblShareReport);
         	   modelMap.addAttribute("tblTender",tblTender);
         	  modelMap.addAttribute("fromOfficer",true);
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
         	   modelMap.addAttribute("sessionUserTypeId", sBean.getUserTypeId());
         	    modelMap.addAttribute("tenderDetailList",tenderDataBean);
         	    retVal="etender/bidder/TenderResult";
 			}
		} catch (Exception ex) {
		    exceptionHandlerService.writeLog(ex);
		}
		return retVal;
    }
    

}

