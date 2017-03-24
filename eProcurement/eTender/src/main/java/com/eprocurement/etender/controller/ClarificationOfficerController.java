/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.CommonUtility;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.TenderDataBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblOfficer;
import com.eprocurement.etender.model.TblQuestionAnswer;
import com.eprocurement.etender.model.TblSeekClarification;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.services.AuditTrailService;
import com.eprocurement.etender.services.ClarificationService;
import com.eprocurement.etender.services.CommitteeService;
import com.eprocurement.etender.services.DocumentService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;

@Controller
@RequestMapping("/etender")
public class ClarificationOfficerController {

    @Autowired
    private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private AuditTrailService auditTrailService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private DocumentService fileUploadService;
    @Autowired
    private CommitteeService committeeFormationService;
    @Autowired
    private TenderService tenderFormService;
    @Autowired
    private ClarificationService seekClarificationService;
    @Value("#{projectProperties['officer.docstatus.approve']?:1}")
    private int officerDocStatusApprove;
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	@Value("#{projectProperties['tenderSeekClarificationObjectId']}")
    private String tenderSeekClarificationObjectId;
	@Value("#{projectProperties['tenderSeekClarificationBidderObjectId']}")
    private String tenderSeekClarificationBidderObjectId;

    private static final int CLARIFICATION_MODULE_TYPE = 2;
    private static final String ENVELOPE_ID = "envelopeId";
    private static final String COMPANY_ID = "companyId";
    private static final String TENDER_ID = "tenderId";
    private static final String CONFIG_TYPE = "configType";
    private static final String ENVELOPE_TYPE = "envelopeType";
    private static final String ISEVAL_DONE = "isEvalDone";
    private static final String SORT_ORDER = "sortOrder";
    private static final String HDENVELOPE_TYPE = "EnvelopeType";
    private static final String HDSORT_ORDER = "SortOrder";
    private static final String HDCONFIG_TYPE = "ConfigType";
    private static final String HDISEVAL_DONE = "IsEvalDone";
    private static final String OPER_TYPE = "operType";
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/sessionexpired";
    
    
        /**
     * To view create seek clarification page
     *
     * @Author Shreyansh.shah
     * @param tenderId
     * @param questionId
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/buyer/createSeekClarificationQueryView/{tenderId}/{envelopeId}/{bidderId}/{questionId}/{isEvalDone}/{clarification}", method = RequestMethod.GET)
    public String createSeekClarificationQueryView(@PathVariable(TENDER_ID) int tenderId,@PathVariable(ENVELOPE_ID) int envelopeId,@PathVariable("bidderId") int bidderId, @PathVariable("questionId") int questionId,@PathVariable(ISEVAL_DONE) String isEvalDone,@PathVariable("clarification") int clarificationId, ModelMap modelMap, HttpServletRequest request) {
        try {
            int eventId = 0;
            if(questionId!=0) {
            	TblQuestionAnswer tblQuestion = seekClarificationService.getQuestionById(questionId);
            	modelMap.addAttribute("query", tblQuestion.getQuestion());
            }
            tenderCommonService.tenderSummary(tenderId, modelMap);
            List<Object[]> configureDateList=  seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
            if(configureDateList!=null && !configureDateList.isEmpty()) {
                modelMap.addAttribute("responseEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, (Date)configureDateList.get(0)[1]));
                modelMap.addAttribute("configureDateList",configureDateList.get(0));
            }
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("objectId", tenderSeekClarificationObjectId);
            modelMap.addAttribute("childId", envelopeId);
            modelMap.addAttribute("subChildId", bidderId);
            modelMap.addAttribute("otherSubChildId", clarificationId);
            return "/etender/buyer/CreateSeekClarificationQuery";
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        }
    }

    /**
     * To Submit query created by buyer Author 
     * @param request
     * @param modelMap
     * @param redirectAttributes
     * @param tenderId
     * @return
     */
    @RequestMapping(value = "/buyer/postQuery", method = RequestMethod.POST)
    public String postQuery(HttpServletRequest request, ModelMap modelMap, RedirectAttributes redirectAttributes, @RequestParam("TenderId") int tenderId,@RequestParam("EnvelopeId") int envelopeId,@RequestParam("CompanyId") int companyId) {
        String retVal = REDIRECT_SESSION_EXPIRED;
        boolean isSuccess = false;
        Map<String, Object> mailParams = new HashMap<String, Object>();
        int questionStatus = CommonUtility.checkValue(request.getParameter("txtQueryStatus"));
        int questionId = request.getParameter("hdQuestionId")!=null ? Integer.parseInt(request.getParameter("hdQuestionId")) : 0;  
        int envelopeType = CommonUtility.checkValue(request.getParameter(HDENVELOPE_TYPE));
        int sortOrder = CommonUtility.checkValue(request.getParameter(HDSORT_ORDER));
        int configType = CommonUtility.checkValue(request.getParameter(HDCONFIG_TYPE)); 
        String isEvalDone = CommonUtility.checkNull(request.getParameter(HDISEVAL_DONE));
        String redirectMsg="";
        TblQuestionAnswer tblQuestion = new TblQuestionAnswer();
        if(questionStatus==0)
        {
        	redirectMsg = "msg_clarification_savequery_sucess";
        }
        else
        {
        	redirectMsg = "msg_clarification_updatequery_sucess";
        }
        String errorMsg="redirect_failure_common";
        List<Object> lstLoginId = null;
        try {
            String strQuery = CommonUtility.checkNull(request.getParameter("txtaQuery"));
            int sessionUserId = 1;
            if (sessionUserId != 0 && !strQuery.equals("")) {
                List<Object[]> configureDateList = seekClarificationService.getConfigureDateData(tenderId, envelopeId, companyId);
                int clarificationId = CommonUtility.checkValue(request.getParameter("hdClarificationId"));
                    if (questionId != 0) {
                        tblQuestion.setQuestionId(questionId);
                    }
                    tblQuestion.setQuestion(strQuery);
                    tblQuestion.setQuestionDate(commonService.getServerDateTime());
                    tblQuestion.setEventId(clarificationId);
                    isSuccess = seekClarificationService.addTblQuestion(tblQuestion);
                    seekClarificationService.updateOfficerDocStatus(tblQuestion.getQuestionId(),clarificationId);
                StringBuilder redirectUrl = new StringBuilder();
                redirectUrl.append("redirect:/etender/buyer/viewClarificationQueries/").append(tenderId).append("/").append(envelopeId).append("/").append(companyId).append("/").append(isEvalDone);
                retVal =  redirectUrl.toString();
            }
        } catch (Exception ex) {
            retVal = exceptionHandlerService.writeLog(ex);
        } finally {
        }
        redirectAttributes.addFlashAttribute(isSuccess ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), isSuccess ? redirectMsg : errorMsg);
        return retVal;
    }

    /**
     * To Display list of qualified bidders to post query
     * @param tenderId
     * @param envelopeId
     * @param envelopeType
     * @param sortOrder
     * @param isEvalDone
     * @param configType  1-Configure seek calrification, 2- Update Seek clarification, 3- view seek clarification
     * @param request
     * @param modelMap
     * @return 
     */
    @RequestMapping(value = "/buyer/bidderwiseclaficationlist/{tenderId}/{envelopeId}/{isEvalDone}", method = RequestMethod.GET)
    public String bidderWiseClaricationList(@PathVariable(TENDER_ID) int tenderId, @PathVariable(ENVELOPE_ID) int envelopeId,@PathVariable(ISEVAL_DONE) String isEvalDone,HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, modelMap);
            modelMap.addAttribute("currentDate", commonService.getServerDateTime());
            modelMap.addAttribute("seekEnvelopeId", envelopeId);
            setTenderOpeningEvaluationDataForSeekClarification(tenderId, modelMap, 2);
        } catch (Exception ex) { 
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/buyer/SeekClarificationBidderList";
    }
  
    /**
     * To view configure Date for seek clarification 
     * @Author 
     * @param tenderId
     * @param request
     * @param modelMap
     * @return 
     */
    
    @RequestMapping(value = "/buyer/configuredate/{tenderId}/{envelopeId}/{bidderId}/{officerId}/{isEvalDone}", method = RequestMethod.GET)
    public String configureDate(@PathVariable(TENDER_ID) int tenderId,@PathVariable(ENVELOPE_ID) int envelopeId,@PathVariable("bidderId") int bidderId,@PathVariable("officerId") int officerId,@PathVariable(ISEVAL_DONE) String isEvalDone, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, modelMap);
//            TblCompany tblCompany= seekClarificationService.getCompanyById(bidderId);
//            modelMap.addAttribute("companyName", tblCompany.getCompanyname());
            modelMap.addAttribute(OPER_TYPE, "create");
        } catch (Exception ex) {
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/buyer/ConfigureSeekClarificationDate";
    }
    
     /**
     * To view configure Date for seek clarification 
     * @Author 
     * @param tenderId
     * @param request
     * @param modelMap
     * @return 
     */
    @RequestMapping(value = "/buyer/editconfiguredate/{tenderId}/{envelopeId}/{bidderId}/{userDetailsId}/{isEvalDone}", method = RequestMethod.GET)
    public String editConfigureDate(@PathVariable(TENDER_ID) int tenderId,@PathVariable(ENVELOPE_ID) int envelopeId,@PathVariable("bidderId") int bidderId,@PathVariable(ISEVAL_DONE) String isEvalDone,HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, modelMap);
            List<Object[]> list = seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
            if(list != null && !list.isEmpty()) {
                modelMap.addAttribute("clarificationList", list.get(0));
            }
            modelMap.addAttribute("currentDate", commonService.getServerDateTime());
            modelMap.addAttribute(OPER_TYPE, "Edit");
        } catch (Exception ex) {
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/buyer/ConfigureSeekClarificationDate";
    }

    /**
     * To post seekclarification configure date.
     * Author 
     * @param request
     * @param modelMap
     * @param redirectAttributes
     * @param tenderId
     * @return 
     */
    @RequestMapping(value = "/buyer/postConfigureDate", method = RequestMethod.POST)
    public String saveConfigureDate(HttpServletRequest request, ModelMap modelMap, RedirectAttributes redirectAttributes,HttpSession session) {
        String retVal = REDIRECT_SESSION_EXPIRED;
        int questionId = 0;
        boolean isSuccess = false;
        TblSeekClarification tblSeekClarification = null;
        String clarificationId = request.getParameter("hdClarificationId");
        String editOrReconfig = StringUtils.hasLength(request.getParameter("hdDateConfig")) ? request.getParameter("hdDateConfig") : null;
        String responseEndDate = request.getParameter("txtResponseEndDate");
        int tenderId = StringUtils.hasLength(request.getParameter("TenderId")) ? Integer.parseInt(request.getParameter("TenderId")) : 0;
        int EnvelopeId = StringUtils.hasLength(request.getParameter("EnvelopeId")) ? Integer.parseInt(request.getParameter("EnvelopeId")) : 0;
        int bidderId = StringUtils.hasLength(request.getParameter("BidderId")) ? Integer.parseInt(request.getParameter("BidderId")) : 0;
        int configType = StringUtils.hasLength(request.getParameter(HDCONFIG_TYPE)) ? Integer.parseInt(request.getParameter(HDCONFIG_TYPE)) : 0;
        String isEvalDone = StringUtils.hasLength(request.getParameter(HDISEVAL_DONE)) ? request.getParameter(HDISEVAL_DONE) : "";
        SessionBean sessionBean = session != null && session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null ? (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) : null;
        try {
            if(true) {
                tblSeekClarification = new TblSeekClarification();
                //seekClarificationService.updateOldConfigureDate(Integer.parseInt(clarificationId));
                int userDetailsId = StringUtils.hasLength(request.getParameter("hdUserDetailsId")) ? Integer.parseInt(request.getParameter("hdUserDetailsId")) : 0;
                tblSeekClarification.setTblTender(new TblTender(tenderId));
                tblSeekClarification.setTblTenderEnvelope(new TblTenderEnvelope(EnvelopeId));
                tblSeekClarification.setTblBidder(new TblBidder(bidderId));
                DateFormat df = new SimpleDateFormat(client_dateformate_hhmm); 
                tblSeekClarification.setResponseEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,responseEndDate));
                tblSeekClarification.setCreatedBy((int)sessionBean.getUserId());
                tblSeekClarification.setIsActive(1);
                tblSeekClarification.setTblOfficer(new TblOfficer(sessionBean.getOfficerId()));
                tblSeekClarification.setCreatedOn(commonService.getServerDateTime());
                isSuccess = seekClarificationService.addTblSeekClarification(tblSeekClarification,clarificationId);
                if(isSuccess) {
                	redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_clarification_date_sucess");
                	retVal="redirect:/etender/buyer/gettabcontent/"+tenderId+"/2";
                }
            }
        } catch (Exception ex) {
            retVal = exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return retVal;
    }

    /**
     * View list of queries and response posted by bidder
     * @Author 
     * @param tenderId
     * @param userId
     * @param request
     * @param modelMap
     * @return 
     */
    @RequestMapping(value = "/buyer/viewClarificationQueries/{tenderId}/{envelopeId}/{bidderId}/{isEvalDone}", method = RequestMethod.GET)
    public String viewClarificationQueries(@PathVariable(TENDER_ID) int tenderId,@PathVariable(ENVELOPE_ID) int envelopeId,@PathVariable("bidderId") int bidderId,@PathVariable(ISEVAL_DONE) String isEvalDone, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, modelMap);
            List<Object[]> list = seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
            List<TblSeekClarification> seekClarifications = seekClarificationService.getSeekClarificationDtls(tenderId, envelopeId, bidderId);
            List<TblQuestionAnswer> tblQuestionAnswers  = null;
            if(list != null && !list.isEmpty()) {
                modelMap.addAttribute("configureDateList", list.get(0));
                modelMap.addAttribute("responseEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, (Date)list.get(0)[1]));
                tblQuestionAnswers = seekClarificationService.getQuestionByEventId((Integer)list.get(0)[0]);
            }
            if(seekClarifications != null && !seekClarifications.isEmpty()) {
                modelMap.addAttribute("seekClarifications", seekClarifications);
            }
            modelMap.addAttribute("currentDate", commonService.getServerDateTime());
            modelMap.addAttribute("tblQuestionAnswersLst", tblQuestionAnswers);
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("objectId", tenderSeekClarificationObjectId);
            modelMap.addAttribute("objectIdBidderSide", tenderSeekClarificationBidderObjectId);
            modelMap.addAttribute("childId", envelopeId);
            modelMap.addAttribute("subChildId", bidderId);
        } catch (Exception ex) {
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/buyer/ViewSeekClarificationQueries";
    }

    /**
     * To view query and response in details
     * @Author 
     * @param questionId
     * @param request
     * @param modelMap
     * @return 
     */
    @RequestMapping(value = "/buyer/viewQuestionAnswer/{tenderId}/{questionId}/{companyId}/{enc}", method = RequestMethod.GET)
    public String viewQuestionAnswer(@PathVariable("tenderId") int tenderId,@PathVariable("questionId") int questionId, @PathVariable(COMPANY_ID) int companyId,HttpServletRequest request, ModelMap modelMap) {
        try {
             int answerId = 0;
            List<Object[]> questionAnswer = seekClarificationService.getQuestionAnswerByQuestionId(questionId,1);
            if(questionAnswer != null && !questionAnswer.isEmpty()) {
                modelMap.addAttribute("questionAns", questionAnswer.get(0));
                answerId =  questionAnswer.get(0)[4] != null ? Integer.parseInt(questionAnswer.get(0)[4].toString()) : 0;
            }
            List<Object[]> bidderDocList = null;
//            if(answerId != 0) {
//                bidderDocList = fileUploadService.getBidderDocs(answerId, bidderReplyLinkId, 1,0);
//            }
//            if(clientService.getCompanyNamebySeekclarification(tenderId,companyId)!=null)
//            {
//            	modelMap.addAttribute("CompanyName", clientService.getCompanyNamebySeekclarification(tenderId,companyId));
//            }
            modelMap.addAttribute("cStatusDocView", officerDocStatusApprove);
            modelMap.addAttribute("isReadOnly", "Y");
            modelMap.addAttribute("bidderDocList", bidderDocList);
            modelMap.addAttribute("isPopUp","Y");
        } catch (Exception ex) {
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/common/ViewSeekClarificationQueAns";
    }
    
     /**
     * To view configure Date for seek clarification 
     * @Author 
     * @param tenderId
     * @param request
     * @param modelMap
     * @return 
     */
    @RequestMapping(value = "/buyer/reconfiguredate/{tenderId}/{envelopeId}/{bidderId}/{officerId}/{isEvalDone}/{configType}", method = RequestMethod.GET)
    public String reconfiguredate(@PathVariable(TENDER_ID) int tenderId,@PathVariable(ENVELOPE_ID) int envelopeId,@PathVariable("bidderId") int bidderId,@PathVariable("officerId") int officerId,@PathVariable(ISEVAL_DONE) String isEvalDone,@PathVariable(CONFIG_TYPE) int configType ,HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, modelMap);
            List<Object[]> list = seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
            if(list != null && !list.isEmpty()) {
                modelMap.addAttribute("clarificationList", list.get(0));
            }
            modelMap.addAttribute(OPER_TYPE, "Reconfig");
        } catch (Exception ex) {
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/buyer/ConfigureSeekClarificationDate";
    }
    
    private void setTenderOpeningEvaluationDataForSeekClarification(int tenderId,ModelMap modelMap,int tabId) throws Exception{
    	modelMap.addAttribute("envList",committeeFormationService.getTenderEnvelopeList(tenderId,tabId));
    	List<Object[]> data = committeeFormationService.getTenderOpeningCommitteeMemberList(tenderId,tabId);
   	   if(data  != null ){
   		   for(Object[] obj : data ){
   			   if(obj[4] != null && !"".equals(obj[4].toString())){
   				   String date = obj[4].toString();
   				   obj[4] = commonService.convertSqlToClientDate(client_dateformate_hhmm, date);
   			  }
   		   }
   	   }
    	
	    modelMap.addAttribute("commMemList",committeeFormationService.getTenderOpeningCommitteeMemberList(tenderId,tabId));
	    List<Object[]> bidderList = committeeFormationService.getTenderBidderList(tenderId,0);
	    modelMap.addAttribute("bidderList",bidderList);
	    List<Object[]> bidderFormList = committeeFormationService.getTenderBidderFormList(tenderId,tabId);
	    modelMap.addAttribute("bidderFormList",bidderFormList);
	    int envelopeType = modelMap !=null && modelMap.get("envelopeType") != null ? Integer.parseInt(modelMap.get("envelopeType").toString()) : 0;
	    List<Object[]> tenderDetailList = committeeFormationService.getTenderDetails(tenderId,tabId,envelopeType);
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
	    	}
	    }
	    modelMap.addAttribute("tenderDetailList",tenderDataBean);
        HashMap<String, Integer> bidderClarificationDtl = new HashMap<String, Integer>();
        List<Object[]> lstEnvelope = tenderFormService.getTenderEnvelopeList(tenderId);
        LinkedHashMap<Integer, Boolean> envOpenStatus = new LinkedHashMap<Integer, Boolean>();
        LinkedHashMap<Integer, Boolean> envEvalStatus = new LinkedHashMap<Integer, Boolean>();
        for (int i=0 ; i<lstEnvelope.size() ; i++) {
        	 int envelopeId = Integer.parseInt(lstEnvelope.get(i)[2].toString());
        	 boolean remarksDone = tenderFormService.isEvaluationRemarksDone(tenderId,envelopeId);
        	 envOpenStatus.put(envelopeId, (Integer)lstEnvelope.get(i)[3]>0);
        	 envEvalStatus.put(envelopeId, (Integer)lstEnvelope.get(i)[5]>0 && remarksDone);
             if (!bidderList.isEmpty()) {
                 for (Object[] lstBidder1 : bidderList) {
                     List<Object[]> list = seekClarificationService.getConfigureDateData(tenderId, envelopeId, Integer.parseInt(lstBidder1[0].toString()));
                     if(list!=null && !list.isEmpty()) {
                    	 int clarificationId= (Integer)list.get(0)[0];
                    	 bidderClarificationDtl.put(tenderId+"_"+envelopeId+"_"+Integer.parseInt(lstBidder1[0].toString()), clarificationId);
                     }else {
                    	 bidderClarificationDtl.put(tenderId+"_"+envelopeId+"_"+Integer.parseInt(lstBidder1[0].toString()), 0);
                     }
                 }
             }
        }
        modelMap.addAttribute("bidderClarificationDtl", bidderClarificationDtl);
        modelMap.addAttribute("envOpenStatus", envOpenStatus);
        modelMap.addAttribute("envEvalStatus", envEvalStatus);
    }
}
