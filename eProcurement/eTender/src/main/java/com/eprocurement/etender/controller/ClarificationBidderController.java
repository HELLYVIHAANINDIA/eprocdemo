/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.convert.ConversionService;
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
import com.eprocurement.common.utility.CommonValidations;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.model.TblQuestionAnswer;
import com.eprocurement.etender.model.TblSeekClarification;
import com.eprocurement.etender.services.AuditTrailService;
import com.eprocurement.etender.services.BidderSubmissionService;
import com.eprocurement.etender.services.ClarificationService;
import com.eprocurement.etender.services.DocumentService;
import com.eprocurement.etender.services.TenderCommonService;

@Controller
@RequestMapping("/etender")
public class ClarificationBidderController {

    @Autowired
    private CommonService commonService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private AuditTrailService auditTrailService;
    @Autowired
    private ClarificationService seekClarificationService;
    @Autowired
    private DocumentService fileUploadService;
    @Autowired
    private ConversionService conversionService;
    @Autowired
    private CommonValidations commonValidations;
    @Autowired
    private BidderSubmissionService eventBidSubmissionService;
    @Autowired
    private CommonService commonservice;
    
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	@Value("#{projectProperties['tenderSeekClarificationBidderObjectId']}")
    private String tenderSeekClarificationBidderObjectId;
    
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/sessionexpired";
   
    @RequestMapping(value = "/bidder/responseQueryView/{tenderId}/{envelopeId}/{bidderId}/{questionId}", method = RequestMethod.GET)
    public String responseQueryView(@PathVariable("tenderId") int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("bidderId") int bidderId, @PathVariable("questionId") int questionId, ModelMap modelMap, HttpServletRequest request) {
            int answerId = 0;
            String questionTxt = "";
        try {
            int EventId = 0;
            List<Object[]> queAnsList;
            List<Object[]> configureDateList = seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
            if (configureDateList != null && !configureDateList.isEmpty()) {
                modelMap.put("responseEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, (Date)configureDateList.get(0)[1]));
            } 
            queAnsList = seekClarificationService.getQuestionAnswerByQuestionId(questionId, 2);
            if(queAnsList != null && !queAnsList.isEmpty()) {
                answerId = queAnsList.get(0)[4]!=null  ? Integer.parseInt(queAnsList.get(0)[4].toString()) : 0;
                questionTxt =queAnsList.get(0)[0].toString();
            }
            modelMap.put("questionId", questionId);
            modelMap.put("queAnsList", queAnsList);
            modelMap.put("questionTxt", questionTxt);
            
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("objectId", tenderSeekClarificationBidderObjectId);
            modelMap.addAttribute("childId", envelopeId);
            modelMap.addAttribute("subChildId", bidderId);
            modelMap.addAttribute("otherSubChildId", questionId);
            return "/etender/bidder/ResponseSeekClarificationQuery";
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        }
    }

    @RequestMapping(value = "/bidder/responseQueryPost", method = RequestMethod.POST)
    public String responseQueryPost(HttpSession session, HttpServletRequest request, ModelMap modelMap, RedirectAttributes redirectAttributes) {
        String retVal = REDIRECT_SESSION_EXPIRED;
        boolean isSuccess = false;
        SessionBean sessionBean = session != null && session.getAttribute("sessionObject") != null ? (SessionBean) session.getAttribute("sessionObject") : null;
        int bidderId = (int) sessionBean.getBidderId();
        int questionId = StringUtils.hasLength(request.getParameter("hdQuestion")) ? Integer.parseInt(request.getParameter("hdQuestion")) : 0;
        int envelopeId = StringUtils.hasLength(request.getParameter("hdEnvelopeId")) ? Integer.parseInt(request.getParameter("hdEnvelopeId")) : 0;
        int tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
        String redirectMsg = "msg_clarification_updatereply_sucess";
        String errorMsg="redirect_failure_common";
        try {
            String answer = StringUtils.hasLength(request.getParameter("txtaAnswer")) ? request.getParameter("txtaAnswer") : "";
            if (sessionBean.getUserId() != 0 && !answer.equals("")) {
                List<Object[]> configureDateList = seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
                if (configureDateList != null && !configureDateList.isEmpty() && commonValidations.compareWithSysDate(conversionService.convert(configureDateList.get(0)[1], Date.class)) > 0) {
                    errorMsg = "msg_reply_clarification_time_over";
                } else {
                	TblQuestionAnswer tblQuestionAnswer = seekClarificationService.getQuestionById(questionId);
                	tblQuestionAnswer.setAnswer(answer);
                	tblQuestionAnswer.setAnswerBy(bidderId);
                	tblQuestionAnswer.setAnswerDate(commonService.getServerDateTime());
                	seekClarificationService.addTblQuestion(tblQuestionAnswer);
                	seekClarificationService.updateBidderDocStatus(questionId);
                }
                StringBuilder redirectUrl = new StringBuilder();
                redirectUrl.append("redirect:/etender/bidder/viewQueries/").append(tenderId).append("/").append(envelopeId).append("/").append(bidderId);
                retVal = redirectUrl.toString();
            }
        } catch (Exception ex) {
            retVal = exceptionHandlerService.writeLog(ex);
        } finally {
        }
        redirectAttributes.addFlashAttribute(isSuccess ? CommonKeywords.SUCCESS_MSG.toString() : CommonKeywords.ERROR_MSG.toString(), isSuccess ? redirectMsg : errorMsg);
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
    @RequestMapping(value = "/bidder/viewQueries/{tenderId}/{envelopeId}/{bidderId}", method = RequestMethod.GET)
    public String viewQueries(@PathVariable("tenderId") int tenderId,@PathVariable("envelopeId") int envelopeId, @PathVariable("bidderId") int bidderId, HttpServletRequest request, ModelMap modelMap) {
        try {
        	tenderCommonService.tenderSummary(tenderId, modelMap);
            List<Object[]> list = seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
            List<TblSeekClarification> seekClarifications = seekClarificationService.getSeekClarificationDtls(tenderId, envelopeId, bidderId);
            List<TblQuestionAnswer> tblQuestionAnswers  = null;
            if(list != null && !list.isEmpty()) {
                modelMap.addAttribute("configureDateList", list.get(0));
                tblQuestionAnswers = seekClarificationService.getQuestionByEventId((Integer)list.get(0)[0]);
            }
            if(seekClarifications != null && !seekClarifications.isEmpty()) {
                modelMap.addAttribute("seekClarifications", seekClarifications);
            }
            modelMap.addAttribute("currentDate", commonService.getServerDateTime());
            modelMap.addAttribute("tblQuestionAnswersLst", tblQuestionAnswers);
        } catch (Exception ex) {
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/bidder/ViewSeekClarificationQueriesBidder";
    }
    
    /**
     * To view query and response in details
     * @Author 
     * @param questionId
     * @param request
     * @param modelMap
     * @return 
     */
    @RequestMapping(value = "/bidder/viewQuestionAnswer/{tenderId}/{envelopeId}/{bidderId}/{questionId}", method = RequestMethod.GET)
    public String viewQuestionAnswer(@PathVariable("tenderId") int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("bidderId") int bidderId,@PathVariable("questionId") int questionId, HttpServletRequest request, ModelMap modelMap) {
        try {
            List<Object[]> configureDateList = seekClarificationService.getConfigureDateData(tenderId, envelopeId, bidderId);
            if (configureDateList != null && !configureDateList.isEmpty()) {
                modelMap.put("responseEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, (Date)configureDateList.get(0)[1]));
            }
            List<Object[]> questionAnswer = seekClarificationService.getQuestionAnswerByQuestionId(questionId, 2);
            if(questionAnswer != null && !questionAnswer.isEmpty()) {
                modelMap.addAttribute("questionAns", questionAnswer.get(0));
            }
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("objectId", tenderSeekClarificationBidderObjectId);
            modelMap.addAttribute("childId", envelopeId);
            modelMap.addAttribute("subChildId", bidderId);
            modelMap.addAttribute("otherSubChildId", questionId);
        } catch (Exception ex) {
            return exceptionHandlerService.writeLog(ex);
        } finally {
        }
        return "/etender/bidder/ViewSeekClarificationQueAns";
    }
}
