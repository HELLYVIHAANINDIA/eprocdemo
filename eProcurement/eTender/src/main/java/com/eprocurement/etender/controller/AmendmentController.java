/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.eprocurement.common.model.TblProcess;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.CommonValidators;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.TenderCorrigendumDetailDtBean;
import com.eprocurement.etender.databean.TenderCorrigendumDtBean;
import com.eprocurement.etender.databean.TenderCurrencyCorrigendumDtBean;
import com.eprocurement.etender.databean.TenderDtBean;
import com.eprocurement.etender.databean.TenderEnvelopeCorrigendumDtBean;
import com.eprocurement.etender.databean.TenderFormCorrigendumDtBean;
import com.eprocurement.etender.model.TblCorrigendum;
import com.eprocurement.etender.model.TblCorrigendumDetail;
import com.eprocurement.etender.model.TblEnvelope;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.services.AmendmentService;
import com.eprocurement.etender.services.AuditTrailService;
import com.eprocurement.etender.services.EProcureCreationService;
import com.eprocurement.etender.services.OfficerService;
import com.eprocurement.etender.services.TenderCommonService;
import com.google.gson.Gson;

/**
 *
 */
@Controller
public class AmendmentController {

    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private AmendmentService amendmentService;
    @Autowired
    private EProcureCreationService eventCreationService;
    @Autowired
    private OfficerService userService;
    @Autowired
    private CommonService commonService;
    @Autowired
    ExceptionHandlerService exceptionHandlerService;
    @Autowired
    AuditTrailService auditTrailService;
    @Autowired
    CommonValidators commonValidators;
    @Value("#{etenderProperties['msg_corrigendum_already_published']}")
    private String msg_corrigendum_already_published;
    @Value("#{etenderProperties['msg_corrigendum_already_deleted']}")
    private String msg_corrigendum_already_deleted;
    @Value("#{etenderProperties['msg_success_corrigendum_published']}")
    private String msg_success_corrigendum_published;
    @Value("#{projectProperties['tenderNITObjectId']}")
    private String tenderNITObjectId;
	
    
    
    private static final String SEND_TO_SESSION_EXPIRED = "redirect:/sessionexpired";
    public  static final String LBL_ALLOW = "label_allow::1";
    public static final String LBL_DONTALLOW = "label_dontallow::0";
    public static final String LBL_EVENTWISE = "label_eventwise::1";
    public static final String LBL_ITEMWISE = "label_itemwise::2";
    public static final String LBL_NOTREQUIRED = "label_notrequired::0";
    private static final String SESSIONOBJECT = "sessionObject";
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;


 
    private void corrigendumDetails(int tenderId, ModelMap modelMap, HttpServletRequest request) {
        try {
            List<TenderCorrigendumDtBean> resultList = new ArrayList<TenderCorrigendumDtBean>();
            List<TenderCorrigendumDtBean> detailCurrencyList = new ArrayList<TenderCorrigendumDtBean>();
            List<TblCorrigendum> corrigendumList = amendmentService.getAllCorrigendumByTenderId(tenderId);
            tenderCommonService.tenderSummary(tenderId, modelMap);
            for (int j = 0; j < corrigendumList.size(); j++) {
                List<TenderCorrigendumDetailDtBean> detailList = new ArrayList<TenderCorrigendumDetailDtBean>();
                List<TenderCurrencyCorrigendumDtBean> currencyList = new ArrayList<TenderCurrencyCorrigendumDtBean>();
                List<TenderFormCorrigendumDtBean> formList = new ArrayList<TenderFormCorrigendumDtBean>();
                List<TenderEnvelopeCorrigendumDtBean> envelopeList = new ArrayList<TenderEnvelopeCorrigendumDtBean>();
                TenderCorrigendumDtBean corrigendumDtBean = new TenderCorrigendumDtBean();
                corrigendumDtBean.setId(corrigendumList.get(j).getCorrigendumId());
                corrigendumDtBean.setCstatus(corrigendumList.get(j).getCstatus());
                corrigendumDtBean.setCtext(corrigendumList.get(j).getCorrigendumText());
                List<TblCorrigendumDetail> corrigendumDetailList = amendmentService.getAmendmentDetailWithProcessId(corrigendumList.get(j).getCorrigendumId());
                for (int i = 0; i < corrigendumDetailList.size(); i++) {
                	if (corrigendumDetailList.get(i).getTblProcess().getProcessId() == 2) {
                        TenderCurrencyCorrigendumDtBean tenderCurrencyDtBean = new TenderCurrencyCorrigendumDtBean();
                        String currencyName = amendmentService.getCurrencyNameById(corrigendumDetailList.get(i).getObjectId(), tenderId);
                        if (corrigendumDetailList.get(i).getFieldName().equals("baseCurrency")) {
                            tenderCurrencyDtBean.setCurrencyName(currencyName + (" (Base Currency)"));
                        } else {
                            tenderCurrencyDtBean.setCurrencyName(currencyName);
                        }
                        if (corrigendumDetailList.get(i).getActionType() == 3) {
                            tenderCurrencyDtBean.setAction("Cancel");
                        } else {
                            tenderCurrencyDtBean.setAction("New");
                        }
                        currencyList.add(tenderCurrencyDtBean);
                    }
                      else if (corrigendumDetailList.get(i).getTblProcess().getProcessId() == 4) {
                        TenderFormCorrigendumDtBean tenderFormCorrigendumDtBean = new TenderFormCorrigendumDtBean();
                        String formName = amendmentService.getFormNameById(corrigendumDetailList.get(i).getObjectId());
                        tenderFormCorrigendumDtBean.setFormName(formName);
                        if (corrigendumDetailList.get(i).getActionType() == 3) {
                            tenderFormCorrigendumDtBean.setAction("Cancel");
                        } else {
                            tenderFormCorrigendumDtBean.setAction("New");
                        }
                        formList.add(tenderFormCorrigendumDtBean);
                    }
                      else if (corrigendumDetailList.get(i).getTblProcess().getProcessId() == 3) {
                        TenderEnvelopeCorrigendumDtBean tenderEnvelopCorrigendumDtBean = new TenderEnvelopeCorrigendumDtBean();
                        String envelopeName = amendmentService.getEnvelopeNameById(corrigendumDetailList.get(i).getObjectId());
                        tenderEnvelopCorrigendumDtBean.setEnvelopeName(envelopeName);
                        if (corrigendumDetailList.get(i).getActionType() == 3) {
                            tenderEnvelopCorrigendumDtBean.setAction("Cancel");
                        } else {
                            tenderEnvelopCorrigendumDtBean.setAction("New");
                        }
                        envelopeList.add(tenderEnvelopCorrigendumDtBean);
                    } else {
                        TenderCorrigendumDetailDtBean tcddb = new TenderCorrigendumDetailDtBean();
                        tcddb.setCorrigendumId(corrigendumDetailList.get(i).getTblCorrigendum().getCorrigendumId());
                        tcddb.setFieldName(corrigendumDetailList.get(i).getFieldLabel());
                        if (corrigendumDetailList.get(i).getFieldName().equals("procurementNatureId")) {
                            tcddb.setOldValue(tenderCommonService.getProcurementNatureById(Integer.valueOf(corrigendumDetailList.get(i).getOldValue())).get(0)[1].toString());
                            tcddb.setNewValue(tenderCommonService.getProcurementNatureById(Integer.valueOf(corrigendumDetailList.get(i).getNewValue())).get(0)[1].toString());
                        }else {
                            if (corrigendumDetailList.get(i).getOldValue().contains("::")) {
                                tcddb.setOldValue(amendmentService.generateDataForView(corrigendumDetailList.get(i).getOldValue()));
                            } else {
                                if (corrigendumDetailList.get(i).getFieldName().contains("Date")) {
                                    tcddb.setOldValue(commonService.convertSqlToClientDate( client_dateformate_hhmm, corrigendumDetailList.get(i).getOldValue()));
                                } else {
                                    tcddb.setOldValue(corrigendumDetailList.get(i).getOldValue());
                                }
                            }
                            if (corrigendumDetailList.get(i).getNewValue().contains("::")) {
                                tcddb.setNewValue(amendmentService.generateDataForView(corrigendumDetailList.get(i).getNewValue()));
                            } else {
                                if (corrigendumDetailList.get(i).getFieldName().contains("Date")) {
                                    tcddb.setNewValue(commonService.convertSqlToClientDate( client_dateformate_hhmm,corrigendumDetailList.get(i).getNewValue()));
                                } else {
                                    tcddb.setNewValue(corrigendumDetailList.get(i).getNewValue());
                                }
                            }
                        }
                        detailCurrencyList.add(corrigendumDtBean);

                        detailList.add(tcddb);
                    }
                }
                corrigendumDtBean.setDetails(detailList);
                corrigendumDtBean.setCurrencies(currencyList);
                corrigendumDtBean.setForms(formList);
                corrigendumDtBean.setEnvelopes(envelopeList);
                resultList.add(corrigendumDtBean);
            }
            modelMap.addAttribute("resultList", resultList);
            modelMap.addAttribute("detailCurrencyList", detailCurrencyList);
            modelMap.addAttribute("tenderId", tenderId);
            List<TblCorrigendumDetail> corrigendumDetailList = amendmentService.getAmendmentDetailByTenderId(tenderId);
            modelMap.addAttribute("corrigendumList", corrigendumList);
            modelMap.addAttribute("corrigendumDetailList", corrigendumDetailList);
            modelMap.addAttribute("tenderId", tenderId);
        } catch (Exception ex) {
            exceptionHandlerService.writeLog(ex);
        }
    }

    /**
     * 
     * @param tenderId
     * @param pageFrom:{0:local, 1:view tender}
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = {"/etender/buyer/viewcorrigendum/{tenderId}/{pageFrom}"}, method = RequestMethod.GET)
    public String viewCorrigendum(@PathVariable("tenderId") int tenderId,@PathVariable("pageFrom") int pageFrom, ModelMap modelMap, HttpServletRequest request) {
        corrigendumDetails(tenderId, modelMap, request);
        modelMap.addAttribute("userType", commonService.getSessionUserTypeId(request));
        modelMap.addAttribute("isWorkFlow", 0);
        modelMap.addAttribute("tenderNITObjectId", tenderNITObjectId);
        return "/etender/buyer/ViewCorrigendum";
    }
    /**
     * 
     * @param tenderDtBean
     * @param corrigendumId
     * @param tenderId
     * @param modelAndView
     * @throws Exception
     */
    public void corrigendumTenderModelMap(TenderDtBean tenderDtBean,int corrigendumId, int tenderId,ModelAndView modelAndView) throws Exception {
        List<TenderCorrigendumDetailDtBean> tenderCorrigendumDetail = amendmentService.getCorrigendumDetailForEditByTenderId(corrigendumId);
        if (tenderCorrigendumDetail != null) {
            Map<Integer, BigDecimal> tenderCurr = new LinkedHashMap<Integer, BigDecimal>();
            StringBuilder currList = new StringBuilder();
            for (int j = 0; j < tenderCorrigendumDetail.size(); j++) {

                if (tenderCorrigendumDetail.get(j).getFieldName().equals("procurementNatureId")) {
                    tenderDtBean.setSelProcurementNatureId(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("tenderValue")) {
                    tenderDtBean.setTxtTenderValue(tenderCorrigendumDetail.get(j).getNewValue());
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isItemwiseWinner")) {
                    tenderDtBean.setSelIsItemwiseWinner(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("tenderMode")) {
                    tenderDtBean.setSelTenderMode(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                //Need to check
                if (tenderCommonService.getCurrencyByTenderId(tenderId) != null) {
                    if (tenderCorrigendumDetail.get(j).getFieldName().equals("baseCurrency")) {
                        tenderDtBean.setSelCurrencyId(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                    }
                }

                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isConsortiumAllowed")) {
                    tenderDtBean.setSelIsConsortiumAllowed(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isFormBasedConsortium")) {
                    tenderDtBean.setSelIsFormBasedConsortium(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isBidWithdrawal")) {
                    tenderDtBean.setSelIsBidWithdrawal(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("biddingVariant")) {
                    tenderDtBean.setSelBiddingVariant(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isPreBidMeeting")) {
                    tenderDtBean.setSelIsPreBidMeeting(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("preBidMode")) {
                    tenderDtBean.setSelPreBidMode(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("preBidAddress")) {
                    tenderDtBean.setTxtaPreBidAddress(tenderCorrigendumDetail.get(j).getNewValue());
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isWorkflowRequired")) {
                    tenderDtBean.setSelIsWorkflowRequired(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("documentStartDate")) {
                    tenderDtBean.setTxtDocumentStartDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("documentEndDate")) {
                    tenderDtBean.setTxtDocumentEndDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("submissionStartDate")) {
                    tenderDtBean.setTxtSubmissionStartDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("submissionEndDate")) {
                    tenderDtBean.setTxtSubmissionEndDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("preBidStartDate")) {
                    tenderDtBean.setTxtPreBidStartDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("preBidEndDate")) {
                    tenderDtBean.setTxtBidOpenDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isDocfeesApplicable")) {
                    tenderDtBean.setSelIsDocfeesApplicable(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("docFeePaymentMode")) {
                    tenderDtBean.setSelDocFeePaymentMode(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("openingDate")) {
                    tenderDtBean.setTxtBidOpenDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("documentFee")) {
                    if (StringUtils.hasLength(tenderCorrigendumDetail.get(j).getNewValue())) {
                        BigDecimal txtDocumentFees = new BigDecimal(tenderCorrigendumDetail.get(j).getNewValue());
                        tenderDtBean.setTxtDocumentFee((txtDocumentFees.setScale(2, 2)).toString());
                    }
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("docFeePaymentAddress")) {
                    tenderDtBean.setTxtaDocFeePaymentAddress(tenderCorrigendumDetail.get(j).getNewValue());
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isSecurityfeesApplicable")) {
                    tenderDtBean.setSelIsSecurityfeesApplicable(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("securityFee") && StringUtils.hasLength(tenderCorrigendumDetail.get(j).getNewValue())) {                   
                        BigDecimal txtSecurityFees = new BigDecimal(tenderCorrigendumDetail.get(j).getNewValue());
                        tenderDtBean.setTxtSecurityFee((txtSecurityFees.setScale(2, 2)).toString());
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("secFeePaymentAddress")) {
                    tenderDtBean.setTxtaSecFeePaymentAddress(tenderCorrigendumDetail.get(j).getNewValue());
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("emdAmount")) {
                    if (StringUtils.hasLength(tenderCorrigendumDetail.get(j).getNewValue())) {
                        BigDecimal txtEmdAmt = new BigDecimal(tenderCorrigendumDetail.get(j).getNewValue());
                        tenderDtBean.setTxtEmdAmount((txtEmdAmt.setScale(2, 2)).toString());
                    }
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("emdPaymentAddress")) {
                    tenderDtBean.setTxtaEmdPaymentAddress(tenderCorrigendumDetail.get(j).getNewValue());
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("projectDuration")) {
                    tenderDtBean.setTxtProjectDuration(tenderCorrigendumDetail.get(j).getNewValue());
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isEMDApplicable")) {
                    tenderDtBean.setSelIsEMDApplicable(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("isRegistrationCharges")) {
                    tenderDtBean.setSelIsRegistrationCharges(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("registrationChargesMode")) {
                    tenderDtBean.setSelRegistrationChargesMode(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("registrationCharges") && StringUtils.hasLength(tenderCorrigendumDetail.get(j).getNewValue())) {
                    BigDecimal txtRegAmt = new BigDecimal(tenderCorrigendumDetail.get(j).getNewValue());
                    tenderDtBean.setTxtRegistrationCharges((txtRegAmt.setScale(2, 2)).toString());
                }                
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("decimalValueUpto")) {
                    tenderDtBean.setSelDecimalValueUpto(Integer.valueOf(tenderCorrigendumDetail.get(j).getNewValue()));
                }

                if (tenderCorrigendumDetail.get(j).getFieldName().equals("preBidEndDate")) {
                    tenderDtBean.setTxtPreBidEndDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tenderCorrigendumDetail.get(j).getNewValue()));
                }
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("keywordText")) {
                    tenderDtBean.setTxtaKeyword(tenderCorrigendumDetail.get(j).getNewValue());
                }
                if (tenderCorrigendumDetail.get(j).getProcessId()==2 || tenderCorrigendumDetail.get(j).getFieldName().equals("baseCurrency")) {

                    currList.append(tenderCorrigendumDetail.get(j).getObjectId());
                    currList.append(",");
                    tenderCurr.put(Integer.valueOf(tenderCorrigendumDetail.get(j).getObjectId()), new BigDecimal("0.0"));
                }
                 if (tenderCorrigendumDetail.get(j).getFieldName().equals("otherProcurementNature")) {                  
                        tenderDtBean.setTxtOtherProcNature(tenderCorrigendumDetail.get(j).getNewValue());                  
                 }
                 if (tenderCorrigendumDetail.get(j).getFieldName().equals("tenderNo")) {                  
                     tenderDtBean.setTxtTenderNo(tenderCorrigendumDetail.get(j).getNewValue());                  
                 }
                 if (tenderCorrigendumDetail.get(j).getFieldName().equals("tenderBrief")) {                  
                     tenderDtBean.setTxtaTenderBrief(tenderCorrigendumDetail.get(j).getNewValue());                  
                 }
                 if (tenderCorrigendumDetail.get(j).getFieldName().equals("tenderDetail")) {                  
                     tenderDtBean.setRtfTenderDetail(tenderCorrigendumDetail.get(j).getNewValue());                  
                 }
            }

        }
   }
    
    @RequestMapping(value = "/etender/buyer/corrigendumdashboard/{tenderId}", method = RequestMethod.GET)
    public ModelAndView corrigendumDashboard(@PathVariable("tenderId") int tenderId, ModelMap modelMap, HttpServletRequest request) throws Exception {
    	String retVal = "/etender/buyer/CorrigendumDashboard";
    	ModelAndView modelAndView = new ModelAndView(retVal);
        List<TblCorrigendum> tblCorrigendum1 = eventCreationService.getCorrigendumByTender(tenderId);
		if(tblCorrigendum1 != null && !tblCorrigendum1.isEmpty()){
			modelAndView.addObject("opType" , "edit");
			modelAndView.addObject("tblCorrigendum" , tblCorrigendum1);
		}
        return modelAndView;
    }
    @RequestMapping(value = "/etender/buyer/createcorrigendum/{tenderId}", method = RequestMethod.GET)
    public ModelAndView createEventCorrigendum(@PathVariable("tenderId")Integer tenderId, ModelMap modelMap, HttpServletRequest request) throws Exception {
    	String retVal = "/etender/buyer/CreateCorrigendum";
    	ModelAndView modelAndView = new ModelAndView(retVal);
    		List<TblCorrigendum> tblCorrigendum1 = eventCreationService.getCorrigendumByTender(tenderId);
    		if(tblCorrigendum1 != null && !tblCorrigendum1.isEmpty()){
    			modelAndView.addObject("tblCorrigendum" , tblCorrigendum1);
    			modelAndView.addObject("opType" , "edit");
    		}
    	modelAndView.addObject("tenderId" , tenderId);
    	return modelAndView;
    }
    
    @RequestMapping(value = "/etender/buyer/submittendercorrigendum", method = RequestMethod.POST)
    public ModelAndView submitTenderCorrigendum(ModelMap modelMap, HttpServletRequest request) throws Exception {
    	int corrigendumId  = 0;
    	if(StringUtils.hasLength(request.getParameter("corrigendumId"))){
    		corrigendumId = Integer.parseInt(request.getParameter("corrigendumId"));
    	}
    	TblCorrigendum tblCorrigendum;
    	String corrigendumText = request.getParameter("corrigendumText");
    	String tenderId = request.getParameter("tenderId");
    	tblCorrigendum = new TblCorrigendum();
    	if(corrigendumId != 0){
    		tblCorrigendum.setCorrigendumId(corrigendumId);
    	}else{
    		tblCorrigendum.setCreatedOn(new Date());
        	tblCorrigendum.setCreatedBy(commonService.getSessionUserId(request));
    	}
    	tblCorrigendum.setCorrigendumText(corrigendumText);
    	tblCorrigendum.setObjectId(Integer.parseInt(tenderId));
    	tblCorrigendum.setTblProcess(new TblProcess(1));
    	eventCreationService.saveOrUpdateCorrigendum(tblCorrigendum);
    	String retVal = "redirect:/etender/buyer/tendercorrigendum/"+tenderId+"/"+tblCorrigendum.getCorrigendumId();
    	return new ModelAndView(retVal);
    }
    
    /**
     * 
     * @param tenderId
     * @param corrigendumId
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/etender/buyer/tendercorrigendum/{tenderId}/{corrigendumId}", method = RequestMethod.GET)
    public ModelAndView createEventCorrigendum(@PathVariable("tenderId")Integer tenderId,@PathVariable("corrigendumId")Integer corrigendumId, HttpServletRequest request) {
    	int clientId = 0;
        ModelAndView modelMap = new ModelAndView("/etender/buyer/TenderCorrigendum");
        try {
            if (request.getSession().getAttribute(SESSIONOBJECT) != null) {
				SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
                clientId = 1;
                modelMap.addObject("eventName", "ENV");
                TenderDtBean tenderDtBean;
                TblTender tblTender=null;
                if(tenderId != null && tenderId != 0){
                	tblTender = tenderCommonService.getTenderById(tenderId);
                	tenderDtBean = eventCreationService.settTenderDataToTenderDtBean(tenderId);
                	corrigendumTenderModelMap(tenderDtBean,corrigendumId, tenderId,modelMap);
    				List<Object[]> tenderEnvelopeList = tenderCommonService.getEnvelopeTypeByTenderId(tenderId);
    				modelMap.addObject("tenderEnvelopeList",tenderEnvelopeList);
    				 String eventTypeName = (tenderCommonService.getTblEventTypeById(tblTender.getEventTypeId()) != null) ? tenderCommonService.getTblEventTypeById(tblTender.getEventTypeId()).getEventTypeName() : "";
    		        modelMap.addObject("eventTypeName",  eventTypeName);
    				List<Object[]> tenderCurrency= tenderCommonService.getCurrencyByTenderId(tenderId);
    				if(tenderCurrency != null && !tenderCurrency.isEmpty()){
    					for(Object[] obj : tenderCurrency){
    						int currencyId = Integer.parseInt(obj[0].toString());
    						tenderDtBean.setSelCurrencyId(currencyId);
    					}
    				}
                    modelMap.addObject("tenderDtBean", new Gson().toJson(tenderDtBean));
                    if(tenderDtBean.getSelBiddingType() ==2){
	                    List<Object[]> tblTenderCurrency = tenderCommonService.getCurrencyByTenderId(tenderId);
	                	modelMap.addObject("tblTenderCurrency",tblTenderCurrency);
                    }

                }
                Integer deptId = sessionBean.getGrandParentDeptId();
                if(sessionBean.getIsOrgenizationUser() == 1){
                	deptId = sessionBean.getDeptId();	
                }else if(deptId == 0){
                	deptId = sessionBean.getParentDeptId();
                }
                List<Object[]> tblCurrencyMapList = commonService.getCurrencyMapList(deptId);
                if(tblCurrencyMapList != null){
					Map<Integer,Integer> map = new HashMap<Integer, Integer>();
					for(Object[] obj : tblCurrencyMapList){
						map.put((Integer)obj[0], (Integer)obj[0]); //due to this we can direct check contains
					}
					modelMap.addObject("tblCurrencyMapList", map);
				}
                List<TblEnvelope> listTblEnv = tenderCommonService.getEnvelopeById(0);
                List<Object[]> tblCurrencyList = commonService.getCurrencyList(0);
                List<Object[]> tblOfficerList = tenderCommonService.getOfficerById(0);
                List<Object[]> tblProcurementNature = tenderCommonService.getProcurementNatureById(0);
                List<Object[]> tblDepartmentList = tenderCommonService.getDepartmentById(0);
            	modelMap.addObject("tblCurrencyList",tblCurrencyList);
            	modelMap.addObject("tblOfficerList",tblOfficerList);
            	modelMap.addObject("tblProcurementNature",tblProcurementNature);
            	modelMap.addObject("tblDepartmentList",tblDepartmentList);
            	modelMap.addObject("listTblEnv",listTblEnv);
            	modelMap.addObject("clientId",clientId);
            	modelMap.addObject("hdOpType","corrigendum");
				modelMap.addObject("objectId", tenderId);
				modelMap.addObject("tenderId", tenderId);
				modelMap.addObject("tblTender", tblTender);
				List<Object[]> data = userService.getCategoryMap(0,0,corrigendumId);
				if(data != null && !data.isEmpty()){
					modelMap.addObject("categoryList", data);
				}else{
					data = userService.getCategoryMap(0,tenderId,0);
					if(data != null && !data.isEmpty()){
						modelMap.addObject("categoryList", data);
					}
				}
			
            }
        } catch (Exception e) {
        	exceptionHandlerService.writeLog(e);
        } finally {
        }
        return modelMap;
    }


    /**
     * @param tenderDtBean
     * @param tenderId
     * @param redirectAttributes
     * @param request
     * @param bindingResult
     * @param modelMap
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "/etender/buyer/addtenderCorrigendum/{tenderId}", method = RequestMethod.POST)
    public String savetenderCorrigendum( @PathVariable("tenderId") Integer tenderId, RedirectAttributes redirectAttributes, HttpServletRequest request,ModelMap modelMap) throws Exception {
    	TenderDtBean tenderDtBean = eventCreationService.setTenderParameters(request);
        Map<String, Object> labelMap = new HashMap<String, Object>();
        String retVal = SEND_TO_SESSION_EXPIRED;
        try {
            int userDetailId = commonService.getSessionUserId(request);
            int corrigendumId = 0;
            if (request.getParameter("hdcorrigendumId") != null) {
                corrigendumId = Integer.valueOf(request.getParameter("hdcorrigendumId").toString());
            }
            labelMap = eventCreationService.getFieldDisplyName();
	        if (request.getSession().getAttribute(SESSIONOBJECT) != null) {  
	             String[] lst = null;
	            if (request.getParameter("hdFormType") != null) {
	                lst = request.getParameter("hdFormType").toString().split(",");
	            }
	            String currIdList = request.getParameter("txtCommaSepCur");
	            String currencyId=request.getParameter("selCurrencyId");
	            int envelopeType=0;
	            String categoryText = request.getParameter("categoryText");
	            String[] categoryList =  categoryText.split("#@#");
	    		StringBuilder keywords = new StringBuilder();
				for(String category : categoryList){
					String[] cat = category.split("###");
					keywords.append(cat[1]).append(", ");
	    		}
				tenderDtBean.setTxtaKeyword(keywords.toString());
	            amendmentService.setAmendmentData(tenderDtBean, corrigendumId,tenderId,lst,currIdList,currencyId,envelopeType, userDetailId, labelMap);
            	userService.saveCategoryData(0, 0l,0,corrigendumId,request.getParameter("categoryText"));
	        }
	        retVal = "redirect:/etender/buyer/viewcorrigendum/"+tenderId+"/0";
	   
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
       return retVal;
    }

    /**
     *
     * @param tenderId
     * @param request
     * @param modelMap
     * @return to view
     */
    @RequestMapping(value = "/etender/buyer/showpublishcorrigendum/{tenderId}/{corrigendumId}", method = RequestMethod.GET)
    public String showPublishCorrigendum(@PathVariable("tenderId") int tenderId,@PathVariable("corrigendumId") int corrigendumId,
            HttpServletRequest request, ModelMap modelMap, RedirectAttributes redirectAttributes) {
        try {
            tenderCommonService.tenderSummary(tenderId, modelMap);
            List<TblCorrigendum> corrigendumList = amendmentService.getPendingCorrigendumByTenderId(tenderId);
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("corrigendumList", corrigendumList);
            if(corrigendumList==null || corrigendumList.isEmpty()){
            	String msg = "";
                 List<TblCorrigendum> tblCorrigendumList = amendmentService.getAmendmentByCorrigendumId(corrigendumId);
                 if(tblCorrigendumList!=null && !tblCorrigendumList.isEmpty()){
                	 TblCorrigendum tblCorrigendum = tblCorrigendumList.get(0);
                	 if(tblCorrigendum.getCstatus()==1){
                    	 msg = msg_corrigendum_already_published;
                     }
                 }else  {
                	 msg = msg_corrigendum_already_deleted;
                 }
                 String pageView = "redirect:/etender/buyer/tenderdashboard/" + tenderId + "/4"; 
                 redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), msg);
                  return pageView;
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return "/etender/buyer/PublishCorrigendum";
    }

    /**
     *
     * @param request
     * @param redirectAttributes
     * @return to view
     */
    @RequestMapping(value = "/etender/buyer/publishcorrigendum", method = RequestMethod.POST)
    public ModelAndView publishCorrigendum(HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
        List<String> lstParams = new ArrayList<String>();
        Map<String,Object> paramValue = new HashMap<String, Object>();
        boolean isPublish = false;
        int tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
        ModelAndView modelAndView = new ModelAndView("redirect:/etender/buyer/tenderDashboard/" + tenderId);
        String msg=CommonKeywords.ERROR_MSG_KEY.toString();
        try {
            if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
            	SessionBean sessionBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
            	int corrigendumId = StringUtils.hasLength(request.getParameter("hdCorrigendumId")) ? Integer.parseInt(request.getParameter("hdCorrigendumId")) : 0;
            	List<Object[]> lst = tenderCommonService.getTenderFields(tenderId, "isOpeningByCommittee,isEvaluationByCommittee,isEvaluationRequired");
            	List<TblCorrigendum> tblCorrigendumList = amendmentService.getAmendmentByCorrigendumId(corrigendumId);
            	if (!lst.isEmpty()) {
            		int isOpeningByCommittee = Integer.parseInt(lst.get(0)[0].toString());
            		int isEvaluationByCommittee = Integer.parseInt(lst.get(0)[1].toString());
            		int isEvaluationRequired = Integer.parseInt(lst.get(0)[2].toString());
            		if(tblCorrigendumList!=null && !tblCorrigendumList.isEmpty()){
	                   	 TblCorrigendum tblCorrigendum = tblCorrigendumList.get(0);
	                   	 if(tblCorrigendum.getCstatus()==1){
	                   		isPublish = true;
	                       	 msg = "msg_corrigendum_already_published";
	                   	 }
		           		}else {
		           			isPublish = true;
		                  	 msg = "msg_corrigendum_already_deleted";
		               }
            		if(isOpeningByCommittee==0 && isEvaluationByCommittee==0){
            			boolean isEvalutaionStart = false;
            			if(isEvaluationRequired==1 && !isEvalutaionStart){
            				isPublish = true;
            				msg = "msg_publish_corrigendum_evastart";
            			}
            		}else{
            			List<Object> isTenderOpenedDtls = new ArrayList<Object>();
            			if(isTenderOpenedDtls!=null && !isTenderOpenedDtls.isEmpty()){
            				int isTenderEnvOpened = Integer.parseInt(isTenderOpenedDtls.get(0).toString());
            				if(isTenderEnvOpened >= 1){
            					isPublish = true;
            					msg = "msg_publish_corrigendum_envopened";
            				}
            			}
            		}
            	}
            	if(isPublish){
            		redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), msg);
            	}else{
	                if (StringUtils.hasLength(request.getParameter("txtaRemarks"))) {                    
	                    corrigendumId = StringUtils.hasLength(request.getParameter("hdCorrigendumId")) ? Integer.parseInt(request.getParameter("hdCorrigendumId")) : 0;
	                    lstParams.add(String.valueOf(corrigendumId));
	                    int userDetailId = commonService.getSessionUserDetailId(request);
	                    String remarks = request.getParameter("txtaRemarks");
	                    
	                    paramValue.put("objectId",tenderId);
	                    paramValue.put("userDetailId",userDetailId);
	                    
	                    TblCorrigendum tblCorrigendum = new TblCorrigendum(corrigendumId);
	                    tblCorrigendum.setRemarks(remarks);
	                    tblCorrigendum.setPublishedOn(commonService.getServerDateTime());
	                    tblCorrigendum.setPublishedBy(userDetailId);
	                    tblCorrigendum.setObjectId(tenderId);
	                    tblCorrigendum.setCstatus(1);
	                    
	                    
	                    try{
		                   		Set<String> corrtype = new HashSet<String>();
			                    TblTender tenderForCorringendum = eventCreationService.getTenderMaster(tenderId);
			                    List<TblCorrigendumDetail> lstCorrigendumDtls = amendmentService.getAmendmentDetailWithProcessId(corrigendumId);
			                    for (TblCorrigendumDetail tblCorrigendumDetail : lstCorrigendumDtls) {
			                    	if(!tblCorrigendumDetail.getNewValue().contains("label_") && tblCorrigendumDetail.getTblProcess().getProcessId() == 1){	
				                    	 Class<? extends Object> clazz = tenderForCorringendum.getClass();
				                    	 boolean tblPresent = false;
				                    	 if(tblCorrigendumDetail.getFieldName().equalsIgnoreCase("deptId")){
				                    		 tblPresent = true;
				                        	 Method getMethod = clazz.getDeclaredMethod("getDepartmentId");
				                        	 Method setMethod = clazz.getDeclaredMethod("setDepartmentId",getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                        	 setMethod.invoke(tenderForCorringendum,AmendmentService.convertToClsObj(clazz1, tblCorrigendumDetail.getNewValue()));
				                    	 }
				                    	 if(tblCorrigendumDetail.getFieldName().equalsIgnoreCase("procurementNatureId")){
				                    		 tblPresent = true;
				                        	 Method getMethod = clazz.getDeclaredMethod("getProcurementNatureId");
				                        	 Method setMethod = clazz.getDeclaredMethod("setProcurementNatureId",getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                        	 setMethod.invoke(tenderForCorringendum,AmendmentService.convertToClsObj(clazz1, tblCorrigendumDetail.getNewValue()));
				                    	 }
				                    	 if(tblCorrigendumDetail.getFieldName().equalsIgnoreCase("eventTypeId")){
				                    		 tblPresent = true;
				                        	 Method getMethod = clazz.getDeclaredMethod("getEventTypeId");
				                        	 Method setMethod = clazz.getDeclaredMethod("setTblEventType",getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                        	 setMethod.invoke(tenderForCorringendum,AmendmentService.convertToClsObj(clazz1, tblCorrigendumDetail.getNewValue()));
				                    	 }
				                    	 if(!tblPresent && StringUtils.hasLength(tblCorrigendumDetail.getFieldName())){
				                        	 Method getMethod = clazz.getDeclaredMethod("get" + StringUtils.capitalize(tblCorrigendumDetail.getFieldName()));
				                        	 Method setMethod = clazz.getDeclaredMethod("set" + StringUtils.capitalize(tblCorrigendumDetail.getFieldName()),getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                             setMethod.invoke(tenderForCorringendum,AmendmentService.convertToClsObj(clazz1, tblCorrigendumDetail.getNewValue()));
				                        	 
				                        	 Map<String,List<String>> corrTypeMap = amendmentService.getCorrigendumStatus();
				                        	 for (Map.Entry<String, List<String>> entry : corrTypeMap.entrySet())
				                        	 {
				                        	     if(entry.getValue().contains(tblCorrigendumDetail.getFieldName())){
				                        	    	 corrtype.add(entry.getKey());
				                        	    }
				                        	     
				                        	 }
				                        	 
				                    	 }
				                    }
								}
	                   	}catch(Exception ex){
	                   		exceptionHandlerService.writeLog(ex);
	                    }
	                    Map<String,Map<String,Object>>queryFields = new HashMap<String,Map<String,Object>>();
	                    List<String> lstQueries = amendmentService.getCorrigendumDtlQueries(remarks,queryFields,tenderId, corrigendumId,userDetailId);
	                    int corrigendumCount = (Integer) tenderCommonService.getTenderField(tenderId, "corrigendumCount");
	                    if (amendmentService.updateAmendmentDetail(lstQueries, queryFields,tblCorrigendum, (corrigendumCount + 1), tenderId) != 0) {
	                    	TblTender tblTender = tenderCommonService.getTenderById(tenderId);
	                    	amendmentService.sendNotificationForCorrigendum(tblTender,sessionBean.getUserId());
	                        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), msg_success_corrigendum_published);
	                    } else {
	                        redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(),msg);
	                    }
	                }
            	}
            	redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), msg_success_corrigendum_published);	
            }
        } catch (Exception e) {
        	exceptionHandlerService.writeLog(e);
        }
        return modelAndView;
    }
/**
   * 
   * @param tenderId
   * @param corrigendumId
   * @param modelMap
   * @param request
   * @param redirectAttributes
   * @return
   */

    @RequestMapping(value = "/etender/buyer/deletecorrigendum/{tenderId}/{corrigendumId}", method = RequestMethod.GET)
    public String deletecorrigendum(@PathVariable("tenderId") int tenderId,@PathVariable("corrigendumId") int corrigendumId, ModelMap modelMap, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String retVal = SEND_TO_SESSION_EXPIRED;
        try{
        	if (amendmentService.deletePendingCorrigendum(tenderId,corrigendumId)) {
				List<Integer> lstEnvelopeId = eventCreationService.getEnvelopeIdList(tenderId);
        		for (int i = 0; i < lstEnvelopeId.size(); i++) {
                	eventCreationService.updateEnvelopeSortOrder(lstEnvelopeId.get(i), tenderId, i + 1);
                }
            }else{
            	String msg = CommonKeywords.ERROR_MSG.toString();
            	List<TblCorrigendum> tblCorrigendumList = amendmentService.getAmendmentByCorrigendumId(corrigendumId) ;
            	if(tblCorrigendumList!=null && !tblCorrigendumList.isEmpty()){
            		TblCorrigendum tblCorrigendum = tblCorrigendumList.get(0);
            		if(tblCorrigendum.getCstatus()==1){
            			msg = "msg_corrigendum_already_published";
            		}
            	}else{
            		msg = "msg_corrigendum_already_deleted";
            	}
            	redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), msg);
            }
        	retVal = "redirect:/etender/buyer/tenderDashboard/" + tenderId;
        }catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return retVal;
    }
}