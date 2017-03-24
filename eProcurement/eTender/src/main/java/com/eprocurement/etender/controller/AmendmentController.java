/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.convert.ConversionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.model.TblCategoryMap;
import com.eprocurement.common.model.TblProcess;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.services.SelectItem;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.CommonValidators;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.daointerface.TblTenderDao;
import com.eprocurement.etender.databean.TenderCorrigendumDetailDtBean;
import com.eprocurement.etender.databean.TenderCorrigendumDocumentDtBean;
import com.eprocurement.etender.databean.TenderCorrigendumDtBean;
import com.eprocurement.etender.databean.TenderCurrencyCorrigendumDtBean;
import com.eprocurement.etender.databean.TenderDtBean;
import com.eprocurement.etender.databean.TenderEnvelopeCorrigendumDtBean;
import com.eprocurement.etender.databean.TenderFormCorrigendumDtBean;
import com.eprocurement.etender.model.TblCorrigendum;
import com.eprocurement.etender.model.TblCorrigendumDetail;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblEnvelope;
import com.eprocurement.etender.model.TblProcurementNature;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.services.AuditTrailService;
import com.eprocurement.etender.services.EProcureCreationService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.CorrigendumService;
import com.eprocurement.etender.services.OfficerService;
import com.google.gson.Gson;

/**
 *
 */
@Controller
public class AmendmentController {

    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private CorrigendumService tenderCorrigendumService;
    @Autowired
    private EProcureCreationService eventCreationService;
    @Autowired
    private OfficerService userService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private ReloadableResourceBundleMessageSource messageSource;
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
    private  static final String LBL_ALLOW = "label_allow::1";
    private  static final String LBL_DONTALLOW = "label_dontallow::0";
    private static final String LBL_EVENTWISE = "label_eventwise::1";
    private static final String LBL_ITEMWISE = "label_itemwise::2";
    private static final String LBL_NOTREQUIRED = "label_notrequired::0";
    private static final String SESSIONOBJECT = "sessionObject";
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;


 
    private void corrigendumDetails(int tenderId, ModelMap modelMap, HttpServletRequest request) {
        try {
            List<TenderCorrigendumDtBean> resultList = new ArrayList<TenderCorrigendumDtBean>();
            List<TenderCorrigendumDtBean> detailCurrencyList = new ArrayList<TenderCorrigendumDtBean>();
            List<TblCorrigendum> corrigendumList = tenderCorrigendumService.getAllCorrigendumByTenderId(tenderId);
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
                List<TblCorrigendumDetail> corrigendumDetailList = tenderCorrigendumService.getCorrigendumDetailWithProcessId(corrigendumList.get(j).getCorrigendumId());
                for (int i = 0; i < corrigendumDetailList.size(); i++) {
                    //if (corrigendumDetailList.get(i).getFieldName().equals("tenderCurrency") || corrigendumDetailList.get(i).getFieldName().equals("baseCurrency")) {
                	if (corrigendumDetailList.get(i).getTblProcess().getProcessId() == 2) {
                        TenderCurrencyCorrigendumDtBean tenderCurrencyDtBean = new TenderCurrencyCorrigendumDtBean();
                        String currencyName = tenderCorrigendumService.getCurrencyNameById(corrigendumDetailList.get(i).getObjectId(), tenderId);
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
                    } //else if (corrigendumDetailList.get(i).getFieldLabel().equals("tenderForm")) {
                      else if (corrigendumDetailList.get(i).getTblProcess().getProcessId() == 4) {
                        TenderFormCorrigendumDtBean tenderFormCorrigendumDtBean = new TenderFormCorrigendumDtBean();
                        String formName = tenderCorrigendumService.getFormNameById(corrigendumDetailList.get(i).getObjectId());
                        tenderFormCorrigendumDtBean.setFormName(formName);
                        if (corrigendumDetailList.get(i).getActionType() == 3) {
                            tenderFormCorrigendumDtBean.setAction("Cancel");
                        } else {
                            tenderFormCorrigendumDtBean.setAction("New");
                        }
                        formList.add(tenderFormCorrigendumDtBean);
                    } //else if (corrigendumDetailList.get(i).getFieldName().equals("envelopeForm")) {
                      else if (corrigendumDetailList.get(i).getTblProcess().getProcessId() == 3) {
                        TenderEnvelopeCorrigendumDtBean tenderEnvelopCorrigendumDtBean = new TenderEnvelopeCorrigendumDtBean();
                        String envelopeName = tenderCorrigendumService.getEnvelopeNameById(corrigendumDetailList.get(i).getObjectId());
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
                                tcddb.setOldValue(generateDataForView(corrigendumDetailList.get(i).getOldValue()));
                            } else {
                                if (corrigendumDetailList.get(i).getFieldName().contains("Date")) {
                                    tcddb.setOldValue(commonService.convertSqlToClientDate( client_dateformate_hhmm, corrigendumDetailList.get(i).getOldValue()));//CommonUtility.convertTimezone(corrigendumDetailList.get(i).getOldValue()));
                                } else {
                                    tcddb.setOldValue(corrigendumDetailList.get(i).getOldValue());
                                }
                            }
                            if (corrigendumDetailList.get(i).getNewValue().contains("::")) {
                                tcddb.setNewValue(generateDataForView(corrigendumDetailList.get(i).getNewValue()));
                            } else {
                                if (corrigendumDetailList.get(i).getFieldName().contains("Date")) {
                                    tcddb.setNewValue(commonService.convertSqlToClientDate( client_dateformate_hhmm,corrigendumDetailList.get(i).getNewValue()));//CommonUtility.convertTimezone(corrigendumDetailList.get(i).getNewValue()));
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
            List<TblCorrigendumDetail> corrigendumDetailList = tenderCorrigendumService.getCorrigendumDetailByTenderId(tenderId);
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
        List<TenderCorrigendumDetailDtBean> tenderCorrigendumDetail = tenderCorrigendumService.getCorrigendumDetailForEditByTenderId(corrigendumId);
        if (tenderCorrigendumDetail != null) {
            Map<Integer, BigDecimal> tenderCurr = new LinkedHashMap<Integer, BigDecimal>();
            StringBuffer currList = new StringBuffer();
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
                if (tenderCorrigendumDetail.get(j).getFieldName().equals("registrationCharges")) {
                    if (StringUtils.hasLength(tenderCorrigendumDetail.get(j).getNewValue())) {
                        BigDecimal txtRegAmt = new BigDecimal(tenderCorrigendumDetail.get(j).getNewValue());
                        tenderDtBean.setTxtRegistrationCharges((txtRegAmt.setScale(2, 2)).toString());
                    }
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

                    //currList.append(tenderCorrigendumDetail.get(j).getNewValue());
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
    	TblCorrigendum tblCorrigendum = null;
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
    	ModelAndView modelAndView = new ModelAndView(retVal);
    	return modelAndView;
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
        String retVal = SEND_TO_SESSION_EXPIRED;
        ModelAndView modelMap = null; 
        retVal = "/etender/buyer/TenderCorrigendum";
        modelMap = new ModelAndView(retVal);
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
	    		String keywords = "";
				for(String category : categoryList){
					String[] cat = category.split("###");
					keywords +=cat[1]+", ";
	    		}
				tenderDtBean.setTxtaKeyword(keywords);
	            prepareCorrigendumData(tenderDtBean, corrigendumId,tenderId,lst,currIdList,currencyId,envelopeType, userDetailId, labelMap);
            	userService.saveCategoryData(0, 0l,0,corrigendumId,request.getParameter("categoryText"));
	        }
	        retVal = "redirect:/etender/buyer/viewcorrigendum/"+tenderId+"/0";
	   
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        } finally {
            //auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), corrigendumEdit, auditMessage, tenderId, 0);
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
            List<TblCorrigendum> corrigendumList = tenderCorrigendumService.getPendingCorrigendumByTenderId(tenderId);
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("corrigendumList", corrigendumList);
            if(corrigendumList.isEmpty() || corrigendumList==null){
            	String msg = "";
                 List<TblCorrigendum> tblCorrigendumList = tenderCorrigendumService.getCorrigendumByCorrigendumId(corrigendumId);
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
        } finally {
            //auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), corrigendumPublishLinkId, getPublishcorrigendum, tenderId, 0);
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
        String pageView = "redirect:/sessionexpired";
        int clientId = commonService.getSessionClientId(request);
        int tenderId = 0;
        List<String> lstParams = new ArrayList<String>();
        Map<String,Object> paramValue = new HashMap<String, Object>();
        boolean isPublish = false;
        ModelAndView modelAndView = null;
        tenderId = StringUtils.hasLength(request.getParameter("hdTenderId")) ? Integer.parseInt(request.getParameter("hdTenderId")) : 0;
        pageView = "redirect:/etender/buyer/tenderDashboard/" + tenderId;
        modelAndView = new ModelAndView(pageView);
        String msg=CommonKeywords.ERROR_MSG_KEY.toString();
        try {
            if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
            	int corrigendumId = StringUtils.hasLength(request.getParameter("hdCorrigendumId")) ? Integer.parseInt(request.getParameter("hdCorrigendumId")) : 0;
            	List<Object[]> lst = tenderCommonService.getTenderFields(tenderId, "isOpeningByCommittee,isEvaluationByCommittee,isEvaluationRequired");
            	List<TblCorrigendum> tblCorrigendumList = tenderCorrigendumService.getCorrigendumByCorrigendumId(corrigendumId);
            	if (!lst.isEmpty()) {
            		int isOpeningByCommittee = Integer.parseInt(lst.get(0)[0].toString());
            		int isEvaluationByCommittee = Integer.parseInt(lst.get(0)[1].toString());
            		int isEvaluationRequired = Integer.parseInt(lst.get(0)[2].toString());
            		boolean isNegotiationStated = false;// negotiationService.isNegotiationAllowedAndNegotiationStarted(tenderId,negotiation_negotiation_process_invite_for_negotiation);
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
            			boolean isEvalutaionStart = false;//tenderFormService.checkEntryBidderAppDtls(tenderId);
            			if(isEvaluationRequired==1 && !isEvalutaionStart){
            				isPublish = true;
            				msg = "msg_publish_corrigendum_evastart";
            			}
            			if(!isPublish && isNegotiationStated){
            				isPublish = true;
            				msg = "msg_publish_corrigendum_negotiationstart";
            			}
            		}else{
            			List<Object> isTenderOpenedDtls = new ArrayList<Object>();//tenderFormService.isTenderEnvOpened(tenderId);
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
			                    List<TblCorrigendumDetail> lstCorrigendumDtls = tenderCorrigendumService.getCorrigendumDetailWithProcessId(corrigendumId);
			                    for (TblCorrigendumDetail tblCorrigendumDetail : lstCorrigendumDtls) {
			                    	if(!tblCorrigendumDetail.getNewValue().contains("label_") && tblCorrigendumDetail.getTblProcess().getProcessId() == 1){	
				                    	 Class<? extends Object> clazz = tenderForCorringendum.getClass();
				                    	 boolean tblPresent = false;
				                    	 if(tblCorrigendumDetail.getFieldName().equalsIgnoreCase("deptId")){
				                    		 tblPresent = true;
				                        	 Method getMethod = clazz.getDeclaredMethod("getDepartmentId");
				                        	 Method setMethod = clazz.getDeclaredMethod("setDepartmentId",getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                        	 setMethod.invoke(tenderForCorringendum,toObject(clazz1, tblCorrigendumDetail.getNewValue()));
				                    	 }
				                    	 if(tblCorrigendumDetail.getFieldName().equalsIgnoreCase("procurementNatureId")){
				                    		 tblPresent = true;
				                        	 Method getMethod = clazz.getDeclaredMethod("getProcurementNatureId");
				                        	 Method setMethod = clazz.getDeclaredMethod("setProcurementNatureId",getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                        	 setMethod.invoke(tenderForCorringendum,toObject(clazz1, tblCorrigendumDetail.getNewValue()));
				                    	 }
				                    	 if(tblCorrigendumDetail.getFieldName().equalsIgnoreCase("eventTypeId")){
				                    		 tblPresent = true;
				                        	 Method getMethod = clazz.getDeclaredMethod("getEventTypeId");
				                        	 Method setMethod = clazz.getDeclaredMethod("setTblEventType",getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                        	 setMethod.invoke(tenderForCorringendum,toObject(clazz1, tblCorrigendumDetail.getNewValue()));
				                    	 }
				                    	 if(!tblPresent && StringUtils.hasLength(tblCorrigendumDetail.getFieldName())){
				                        	 Method getMethod = clazz.getDeclaredMethod("get" + StringUtils.capitalize(tblCorrigendumDetail.getFieldName()));
				                        	 Method setMethod = clazz.getDeclaredMethod("set" + StringUtils.capitalize(tblCorrigendumDetail.getFieldName()),getMethod.getReturnType());
				                        	 Class<? extends Object> clazz1 = getMethod.getReturnType();                    	 
				                             setMethod.invoke(tenderForCorringendum,toObject(clazz1, tblCorrigendumDetail.getNewValue()));
				                        	 
				                        	 Map<String,List<String>> corrTypeMap = getCorrigendumStatus();
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
	                    List<String> lstQueries = getCorrigendumDtlQueries(remarks,queryFields,tenderId, corrigendumId,userDetailId);
	                    int corrigendumCount = (Integer) tenderCommonService.getTenderField(tenderId, "corrigendumCount");
	                    String keywordTxt = tenderCorrigendumService.getCorrigendumDtlKeywordTxt(corrigendumId);
	                    String ipAddress = request.getHeader("X-FORWARDED-FOR") != null ? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
	                    paramValue.put("ipAddress", ipAddress);
	                    if (tenderCorrigendumService.executeCorrigendumDtlsQueries(lstQueries, queryFields,tblCorrigendum, keywordTxt,paramValue, (corrigendumCount + 1), tenderId,0,clientId) != 0) {
	                        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), msg_success_corrigendum_published);
	                    } else {
	                        redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(),msg);
	                    }
	                    tenderCorrigendumService.updateMinMandatoryFormsIfnotOrganize(tenderId, corrigendumId);
	                }
            	}
            	redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), msg_success_corrigendum_published);	
            }
        } catch (Exception e) {
        	exceptionHandlerService.writeLog(e);
        } finally {
            //auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), corrigendumPublishLinkId, postPublishcorrigendum, tenderId, 0);
        }
        return modelAndView;
    }
  
    /**
     * @param data
     * @return
     */
    private String generateDataForView(String data) {
        String[] dataValue = data.split("::");
        return messageSource.getMessage(dataValue[0], null, LocaleContextHolder.getLocale());
    }

  /**
   * 
   * @param remark
   * @param queryParameter
   * @param objectId
   * @return
   * @throws Exception
   */
    
    private List<String> getCorrigendumDtlQueries(String remark,Map<String,Map<String,Object>> queryParameter, int... objectId) throws Exception {
        List<String> lstQueries = new ArrayList<String>();
        Map<String, Object> tblTender = new HashMap<String, Object>();
        List<Object[]> lstCorrigendumDtls = tenderCorrigendumService.getTenderCorrigendumDtls(objectId[1]);
        List<Object> lstProcess = tenderCorrigendumService.getCorrigendumProcessTbls(objectId[1]);
        StringBuilder query = new StringBuilder();
        StringBuilder param = new StringBuilder();
        boolean isEnvelopeNotPublished=false;
        boolean isKeywordChange = false;
        for (int i = 0; i < lstProcess.size(); i++) {
            String tblName = (String) lstProcess.get(i);
            if ("TblTender".equals(tblName)) {
                query.delete(0, query.length());
                query.append("update TblTender set $fieldvalues where tenderId=$tenderId");
            } else if ("TblTenderCurrency".equals(tblName)) {
                query.delete(0, query.length());
                query.append("update TblTenderCurrency set isActive=$fieldvalues where tenderCurrencyId in ('$tenderCurrencyId')");

            } else if ("TblTenderForm".equals(tblName) && isEnvelopeNotPublished) {
                query.delete(0, query.length());
                query.append("update TblTenderForm set cstatus=$fieldvalues,$addlCols where formId in ('$formId')");

            } else if ("TblTenderEnvelope".equals(tblName) && isEnvelopeNotPublished) {
                query.delete(0, query.length());
                query.append("update TblTenderEnvelope set cstatus=$fieldvalues,openingDate='$tenderOpeningDt',$addlCols where envelopeId in ('$envelopeId')");

            }
            for (int j = 0; j < lstCorrigendumDtls.size(); j++) {
                if (tblName.equals(lstCorrigendumDtls.get(j)[1])) {
                    if ("TblTender".equals(lstCorrigendumDtls.get(j)[1])) {
                        param.append((String) lstCorrigendumDtls.get(j)[3]).append("=:").append((String) lstCorrigendumDtls.get(j)[3]).append(",");
                        if((lstCorrigendumDtls.get(j)[3]).toString().equalsIgnoreCase("biddingVariant") && lstCorrigendumDtls.get(j)[4].toString().equals("2")) //if variant is sell then rebate value will be 0.
                        {
                            param.append("isRebateForm").append("=:").append("isRebateForm").append(",");
                            tblTender.put("isRebateForm",0);
                        }else if((lstCorrigendumDtls.get(j)[3]).toString().equalsIgnoreCase("keywordText"))
                        {
                        	isKeywordChange = true;
                        }
                        tblTender.put((String) lstCorrigendumDtls.get(j)[3],(String) lstCorrigendumDtls.get(j)[4]);
                    } else if ("TblTenderCurrency".equals(lstCorrigendumDtls.get(j)[1])) {
                        if ("cancel".equals(lstCorrigendumDtls.get(j)[2])) {
                            int indx = 0;
                            String regex = "[update TblTenderCurrency set isActive=2 where tenderCurrencyId in (]+['\\d',+]+?[)]+";
                            String tempHql = query.toString().replace("$fieldvalues", "2").replace("$tenderCurrencyId", regex);
                            for (int k = 0; k < lstQueries.size(); k++) {
                                if (lstQueries.get(k).toString().matches(regex)) {
                                    indx = k;
                                    break;
                                }
                            }
                            if (indx == 0) {
                                lstQueries.add(tempHql.replace(regex, String.valueOf(lstCorrigendumDtls.get(j)[0])));
                            } else {
                                tempHql = lstQueries.get(indx).toString().replace(")", ",'" + lstCorrigendumDtls.get(j)[0] + "')");
                                lstQueries.remove(indx);
                                lstQueries.add(indx, tempHql);
                            }
                        } else if ("insert".equals(lstCorrigendumDtls.get(j)[2])) {
                            int indx = 0;
                            String regex = "[update TblTenderCurrency set isActive=1 where tenderCurrencyId in (]+['\\d',+]+?[)]+";
                            String tempHql = query.toString().replace("$fieldvalues", "1").replace("$tenderCurrencyId", regex);

                            for (int k = 0; k < lstQueries.size(); k++) {
                                if (lstQueries.get(k).toString().matches(regex)) {
                                    indx = k;
                                    break;
                                }
                            }
                            if (indx == 0) {
                                lstQueries.add(tempHql.replace(regex, String.valueOf(lstCorrigendumDtls.get(j)[0])));
                            } else {
                                tempHql = lstQueries.get(indx).toString().replace(")", ",'" + lstCorrigendumDtls.get(j)[0] + "')");
                                lstQueries.remove(indx);
                                lstQueries.add(indx, tempHql);
                            }
                        }
                    }             }
                if (j == (lstCorrigendumDtls.size() - 1)) {
                    if (param.length() != 0) {
                        String finalHqlQuery = query.toString().replace("$fieldvalues", param.replace(param.lastIndexOf(","), param.lastIndexOf(",") + 1, "")).replace("$tenderId", String.valueOf(objectId[0]));
                        param.delete(0, param.length());
                        lstQueries.add(finalHqlQuery);
                    }
                }
            }
        }
        if(tblTender!=null)
        {
        	if(!tblTender.isEmpty() && tblTender.size()>0)
            {
            	queryParameter.put("tblTender",tblTender);	
            }	
        }
        if(isKeywordChange){
        	userService.updateCategoryToTender(objectId[0],objectId[1]);
        }else{
        	userService.deleteOldCategory(0l,0,objectId[1]);
        }
        return lstQueries;
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
        	if (tenderCorrigendumService.deletePendingCorrigendum(tenderId,corrigendumId)) {
				List<Integer> lstEnvelopeId = eventCreationService.getEnvelopeIdList(tenderId);
        		for (int i = 0; i < lstEnvelopeId.size(); i++) {
                	eventCreationService.updateEnvelopeSortOrder(lstEnvelopeId.get(i), tenderId, i + 1);
                }
            }else{
            	String msg = CommonKeywords.ERROR_MSG.toString();
            	List<TblCorrigendum> tblCorrigendumList = tenderCorrigendumService.getCorrigendumByCorrigendumId(corrigendumId) ;
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
        } finally {
            //auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), corrigendumDelete, deletecorrigendum, tenderId, 0);
        }
        return retVal;
    }

    /**
     * 
     * @param tenderDtBean
     * @param corrigendumId
     * @param objectId
     * @param lst
     * @param currIdList
     * @param currencyId
     * @param envelopeType
     * @param userDetailId
     * @param labelMap
     * @return
     * @throws Exception
     */
    public boolean prepareCorrigendumData(TenderDtBean tenderDtBean,int corrigendumId,int objectId,String[] lst,String currIdList,String currencyId,int envelopeType, int userDetailId, Map<String, Object> labelMap) throws Exception {
       
        String newValue = "";
        String oldValue = "";
        List<TblCorrigendumDetail> tblCorrigendumDetails = new ArrayList<TblCorrigendumDetail>();       
        
        if (objectId > 0) {
            TblTender oriTender = tenderCommonService.getTenderById(objectId);
            if (oriTender != null) {
                    if (tenderDtBean.getSelProcurementNatureId() != oriTender.getProcurementNatureId()) {
                        setCorrigendumDetailBean("procurementNatureId", labelMap.get("procurementNatureId").toString(), String.valueOf(oriTender.getProcurementNatureId()), String.valueOf(tenderDtBean.getSelProcurementNatureId()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    if(tenderDtBean.getSelProcurementNatureId()==5){
                         if (!tenderDtBean.getTxtOtherProcNature().equals(oriTender.getOtherProcurementNature())) {
                                setCorrigendumDetailBean("otherProcurementNature",("field_otherProcurementNature"), oriTender.getOtherProcurementNature(), tenderDtBean.getTxtOtherProcNature() ,userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                         }
                      }
                    if (!tenderDtBean.getTxtProjectDuration().equals("") && !tenderDtBean.getTxtProjectDuration().equals(0)) {
                        if (!tenderDtBean.getTxtProjectDuration().equals(oriTender.getProjectDuration().toString())) {
                            setCorrigendumDetailBean("projectDuration", labelMap.get("projectDuration").toString(), oriTender.getProjectDuration().toString(), tenderDtBean.getTxtProjectDuration(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                        }
                    }
                   if (StringUtils.hasLength(tenderDtBean.getTxtTenderValue()) && !new BigDecimal(tenderDtBean.getTxtTenderValue()).setScale(5).toString().equals(new BigDecimal(oriTender.getTenderValue().toString()).setScale(5).toString())) {
                        setCorrigendumDetailBean("tenderValue", labelMap.get("tenderValue").toString(), oriTender.getTenderValue().toString(), tenderDtBean.getTxtTenderValue(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                
                if (!String.valueOf(tenderDtBean.getSelIsItemwiseWinner()).equals(String.valueOf(oriTender.getIsItemwiseWinner()))) {
                    if (tenderDtBean.getSelIsItemwiseWinner() == 1) {
                        newValue = LBL_ALLOW ;
                        oldValue = LBL_DONTALLOW;
                    } else {
                        newValue = LBL_DONTALLOW;
                        oldValue = LBL_ALLOW ;
                    }
                    setCorrigendumDetailBean("isItemwiseWinner", labelMap.get("isItemwiseWinner").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getSelTenderMode() != 0) {
                    if (!String.valueOf(tenderDtBean.getSelTenderMode()).equals(String.valueOf(oriTender.getTenderMode()))) {
                        if (tenderDtBean.getSelTenderMode() == 1) {
                            newValue = "label_open::1";
                        } else if (tenderDtBean.getSelTenderMode() == 2) {
                            newValue = "label_limited::2";

                        } else if (tenderDtBean.getSelTenderMode() == 3) {
                        	newValue = "lbl_single::3";
                        }
                        if (oriTender.getTenderMode() == 1) {
                            oldValue = "label_open::1";
                        } else if (oriTender.getTenderMode() == 2) {
                            oldValue = "label_limited::2";

                        } else if (oriTender.getTenderMode() == 3) {
                        	newValue = "lbl_single::3";
                        }
                        setCorrigendumDetailBean("tenderMode", labelMap.get("tenderMode").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                    if (!String.valueOf(tenderDtBean.getSelIsBidWithdrawal()).equals(String.valueOf(oriTender.getIsBidWithdrawal()))) {
                        if (tenderDtBean.getSelIsBidWithdrawal() == 0) {
                            newValue = LBL_DONTALLOW;
                            oldValue = LBL_ALLOW ;
                        } else {
                            newValue = LBL_ALLOW ;
                            oldValue = LBL_DONTALLOW;
                        }
                        setCorrigendumDetailBean("isBidWithdrawal", labelMap.get("isBidWithdrawal").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    if (!String.valueOf(tenderDtBean.getSelBiddingVariant()).equals(String.valueOf(oriTender.getBiddingVariant()))) {
                        if (tenderDtBean.getSelBiddingVariant() == 1) {
                            newValue = "label_buy::1";
                            oldValue = "label_sell::2";
                        } else {
                            newValue = "label_sell::2";
                            oldValue = "label_buy::1";
                        }
                        setCorrigendumDetailBean("biddingVariant", labelMap.get("biddingVariant").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    if (!String.valueOf(tenderDtBean.getSelIsPreBidMeeting()).equals(String.valueOf(oriTender.getIsPreBidMeeting()))) {
                        if (tenderDtBean.getSelIsPreBidMeeting() == 0) {
                            newValue = LBL_DONTALLOW;
                            oldValue = LBL_ALLOW ;
                        } else {
                            newValue = LBL_ALLOW ;
                            oldValue = LBL_DONTALLOW;
                        }
                        setCorrigendumDetailBean("isPreBidMeeting", labelMap.get("isPreBidMeeting").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    
                    if (!tenderDtBean.getTxtaPreBidAddress().equals(oriTender.getPreBidAddress())) {
                        setCorrigendumDetailBean("preBidAddress", labelMap.get("preBidAddress").toString(), oriTender.getPreBidAddress(), tenderDtBean.getTxtaPreBidAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);

                    }
               // compair with utc date time sql format
                    if (!tenderDtBean.getTxtDocumentEndDate().equals("")) {
                        if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtDocumentEndDate())+".0").equals(oriTender.getDocumentEndDate().toString())) {
                            if(oriTender.getDocumentEndDate()==null){
                                setCorrigendumDetailBean("documentEndDate", labelMap.get("documentEndDate").toString(), "", commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtDocumentEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                            }
                            else{
                                setCorrigendumDetailBean("documentEndDate", labelMap.get("documentEndDate").toString(), oriTender.getDocumentEndDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtDocumentEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                            }
                         }
                    }
               
                if (!tenderDtBean.getTxtSubmissionEndDate().equals("")) {
                    if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtSubmissionEndDate())+".0").equals(oriTender.getSubmissionEndDate().toString())) {
                         if(oriTender.getSubmissionEndDate()==null){
                            setCorrigendumDetailBean("submissionEndDate", labelMap.get("submissionEndDate").toString(),"", commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtSubmissionEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                         }
                         else{
                             setCorrigendumDetailBean("submissionEndDate", labelMap.get("submissionEndDate").toString(), oriTender.getSubmissionEndDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm, sql_dateformate, tenderDtBean.getTxtSubmissionEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                         }
                    }
                }
                if (tenderDtBean.getSelIsPreBidMeeting() == 1) {
                    if (!tenderDtBean.getTxtPreBidStartDate().equals("")) {
                        if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidStartDate())+".0").equals(oriTender.getPreBidStartDate().toString())) {
                             if(oriTender.getPreBidStartDate()==null){
                                setCorrigendumDetailBean("preBidStartDate", labelMap.get("preBidStartDate").toString(), "", commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidStartDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                             else{
                                 setCorrigendumDetailBean("preBidStartDate", labelMap.get("preBidStartDate").toString(), oriTender.getPreBidStartDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidStartDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                        }
                    }
                }
                if (tenderDtBean.getSelIsPreBidMeeting() == 1) {
                    if (!tenderDtBean.getTxtPreBidEndDate().equals("")) {
                        if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidEndDate())+".0").equals(oriTender.getPreBidEndDate().toString())) {
                             if(oriTender.getPreBidEndDate()==null){
                                setCorrigendumDetailBean("preBidEndDate", labelMap.get("preBidEndDate").toString(), "", commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                             else{
                                 setCorrigendumDetailBean("preBidEndDate", labelMap.get("preBidEndDate").toString(), oriTender.getPreBidEndDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                        }
                    }
                }
                if (!tenderDtBean.getTxtBidOpenDate().equals("")) {
                    if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtBidOpenDate())+".0").equals(oriTender.getOpeningDate().toString())) {
                          if(oriTender.getOpeningDate()==null){
                            setCorrigendumDetailBean("openingDate", labelMap.get("openingDate").toString(), "", commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtBidOpenDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                          }
                          else{
                              setCorrigendumDetailBean("openingDate", labelMap.get("openingDate").toString(), oriTender.getOpeningDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtBidOpenDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                          }
                    }
                }
                if (!String.valueOf(tenderDtBean.getSelIsDocfeesApplicable()).equals(String.valueOf(oriTender.getIsDocfeesApplicable()))) {
                	newValue=tenderDtBean.getSelIsDocfeesApplicable()==0?LBL_DONTALLOW:LBL_ALLOW ;
                	oldValue=oriTender.getIsDocfeesApplicable()==0?LBL_DONTALLOW:LBL_ALLOW ;
                    setCorrigendumDetailBean("isDocfeesApplicable", labelMap.get("isDocfeesApplicable").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                
                if (tenderDtBean.getSelIsDocfeesApplicable() == 1) {
                	 String txtDocAmtNew = new BigDecimal(tenderDtBean.getTxtDocumentFee()).setScale(2,BigDecimal.ROUND_UP).toString();
                	 String txtDocAmtOld =  oriTender.getIsDocfeesApplicable()==0?"-": new BigDecimal(oriTender.getDocumentFee()!=null && oriTender.getDocumentFee().length()!=0 ? oriTender.getDocumentFee() : "0.00").setScale(2,BigDecimal.ROUND_UP).toString();
                    if (!txtDocAmtNew.equals(String.valueOf(txtDocAmtOld))) {
                        setCorrigendumDetailBean("documentFee", labelMap.get("documentFee").toString(), txtDocAmtOld, txtDocAmtNew, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                if (tenderDtBean.getSelIsDocfeesApplicable() == 1) {
                    if (!tenderDtBean.getTxtaDocFeePaymentAddress().equals(oriTender.getDocFeePaymentAddress())) {
                        setCorrigendumDetailBean("docFeePaymentAddress", labelMap.get("docFeePaymentAddress").toString(), oriTender.getDocFeePaymentAddress(), tenderDtBean.getTxtaDocFeePaymentAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                    if (!String.valueOf(tenderDtBean.getSelIsSecurityfeesApplicable()).equals(String.valueOf(oriTender.getIsSecurityfeesApplicable()))) {
                        if (tenderDtBean.getSelIsSecurityfeesApplicable() == 1) {
                            newValue = LBL_ALLOW ;
                            oldValue =LBL_DONTALLOW;
                        } else {
                            newValue =LBL_DONTALLOW;
                            oldValue = LBL_ALLOW ;
                        }
                    	setCorrigendumDetailBean("isSecurityfeesApplicable", labelMap.get("isSecurityfeesApplicable").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                if (tenderDtBean.getSelIsSecurityfeesApplicable() == 1) {
                	String txtSecAmtNew = new BigDecimal(tenderDtBean.getTxtSecurityFee()).setScale(2,BigDecimal.ROUND_UP).toString();
               	 	String txtSecAmtOld = new BigDecimal(oriTender.getSecurityFee()!=null && oriTender.getSecurityFee().length()!=0 ? oriTender.getSecurityFee() : "0.00").setScale(2,BigDecimal.ROUND_UP).toString();
                    if (!txtSecAmtNew.equals(txtSecAmtOld)) {
                        setCorrigendumDetailBean("securityFee", labelMap.get("securityFee").toString(), txtSecAmtOld, txtSecAmtNew, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                if (tenderDtBean.getSelIsSecurityfeesApplicable() == 1) {
                    if (!tenderDtBean.getTxtaSecFeePaymentAddress().equals(oriTender.getSecFeePaymentAddress())) {
                        setCorrigendumDetailBean("secFeePaymentAddress", labelMap.get("secFeePaymentAddress").toString(), oriTender.getSecFeePaymentAddress(), tenderDtBean.getTxtaSecFeePaymentAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                    if (!String.valueOf(tenderDtBean.getSelIsEMDApplicable()).equals(String.valueOf(oriTender.getIsEMDApplicable()))) {
                    	newValue=tenderDtBean.getSelIsEMDApplicable()==1?LBL_EVENTWISE:tenderDtBean.getSelIsEMDApplicable()==2?LBL_ITEMWISE:LBL_NOTREQUIRED;
                    	oldValue=oriTender.getIsEMDApplicable()==1?LBL_EVENTWISE:oriTender.getIsEMDApplicable()==2?LBL_ITEMWISE:LBL_NOTREQUIRED;
                        setCorrigendumDetailBean("isEMDApplicable", labelMap.get("isEMDApplicable").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                if (tenderDtBean.getSelIsEMDApplicable() == 1) {
                	String txtEmdAmtNew = new BigDecimal(tenderDtBean.getTxtEmdAmount()).setScale(2,BigDecimal.ROUND_UP).toString();
                	String txtEmdAmtOld = oriTender.getIsEMDApplicable()==0?"-": new BigDecimal(oriTender.getEmdAmount()!=null && oriTender.getEmdAmount().length()!=0 ? oriTender.getEmdAmount() : "0.00").setScale(2,BigDecimal.ROUND_UP).toString();
                    if (!txtEmdAmtNew.equals(txtEmdAmtOld)) {
                        setCorrigendumDetailBean("emdAmount", labelMap.get("emdAmount").toString(), txtEmdAmtOld, txtEmdAmtNew, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                if (tenderDtBean.getSelIsEMDApplicable() == 1) {
                    if (!tenderDtBean.getTxtaEmdPaymentAddress().equals(oriTender.getEmdPaymentAddress())) {
                        setCorrigendumDetailBean("emdPaymentAddress", labelMap.get("emdPaymentAddress").toString(), oriTender.getEmdPaymentAddress(), tenderDtBean.getTxtaEmdPaymentAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                if (tenderDtBean.getTxtaKeyword() != null && !tenderDtBean.getTxtaKeyword().equalsIgnoreCase(oriTender.getKeywordText())) {
                    setCorrigendumDetailBean("keywordText", (labelMap.get("keywordText").toString()), oriTender.getKeywordText(), tenderDtBean.getTxtaKeyword().substring(tenderDtBean.getTxtaKeyword().length()-1).equals(",") ? tenderDtBean.getTxtaKeyword().substring(0, tenderDtBean.getTxtaKeyword().length()-1) : tenderDtBean.getTxtaKeyword(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getTxtTenderNo() != null && !tenderDtBean.getTxtTenderNo().equalsIgnoreCase(oriTender.getTenderNo())) {
                    setCorrigendumDetailBean("tenderNo", (labelMap.get("tenderNo").toString()), oriTender.getTenderNo(), tenderDtBean.getTxtTenderNo(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getTxtaTenderBrief() != null && !tenderDtBean.getTxtaTenderBrief().equalsIgnoreCase(oriTender.getTenderBrief())) {
                    setCorrigendumDetailBean("tenderBrief", (labelMap.get("tenderBrief").toString()), oriTender.getTenderBrief(), tenderDtBean.getTxtaTenderBrief(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getRtfTenderDetail() != null && !tenderDtBean.getRtfTenderDetail().equalsIgnoreCase(oriTender.getTenderDetail())) {
                    setCorrigendumDetailBean("tenderDetail", (labelMap.get("tenderDetail").toString()), oriTender.getTenderDetail(), tenderDtBean.getRtfTenderDetail(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                List<Integer> oldEnvList = new ArrayList<Integer>();
                if (lst!=null && lst.length>0) {                    
                    for (int i = 0; i < lst.length; i++) {
                        oldEnvList.add(Integer.valueOf(lst[i]));
                    }
                } else {
                    oldEnvList.add(0);
                }
               
                List<String> currencyNewList = new ArrayList<String>();
                List<String> currencyOldList = new ArrayList<String>();
                List<Object> lstTenderDetail = eventCreationService.getTenderDetail(objectId);
                int baseCurrency = 0;
               
                    if (!String.valueOf(tenderDtBean.getSelCurrencyId()).equals(currencyId)) {
                        baseCurrency = tenderDtBean.getSelCurrencyId();
                    }
                    if (currIdList.length() > 0) {
                       String[] currentValue=   currIdList.split(",");
                       for(int i=0;i<currentValue.length;i++){
                           currencyNewList.add(currentValue[i]);
                       }
                    }
                    Map<Integer, BigDecimal> currencyMap = (Map<Integer, BigDecimal>) lstTenderDetail.get(1);
                    for (Map.Entry<Integer, BigDecimal> entry : currencyMap.entrySet()) { 
                         currencyOldList.add(entry.getKey().toString());
                     }
               
               tenderCorrigendumService.saveCorrigendumData(tblCorrigendumDetails, corrigendumId, currencyOldList, currencyNewList, baseCurrency, oldEnvList, envelopeType, tenderDtBean.getSelFormType(), tenderDtBean.getTxtBidOpenDate(), objectId, userDetailId);
             }
        return true;
    }
    /**
     * 
     * @param fieldName
     * @param fieldLabel
     * @param oldValue
     * @param newValue
     * @param userDetailId
     * @param corrigendumId
     * @param objectId
     * @param tblCorrigendumDetails 
     */
    private void setCorrigendumDetailBean(String fieldName, String fieldLabel, String oldValue, String newValue, int userDetailId, int corrigendumId, int objectId, List<TblCorrigendumDetail> tblCorrigendumDetails) {
        if (oldValue == null) {
            oldValue = "";
        }
        if (newValue == null) {
            newValue = "";
        }
        TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();
        TblProcess tblProcess = new TblProcess(1);
        TblCorrigendum tblCorrigendum = new TblCorrigendum(corrigendumId);
        tblCorrigendumDetail.setFieldName(fieldName);
        tblCorrigendumDetail.setFieldLabel(fieldLabel);
        tblCorrigendumDetail.setOldValue(oldValue);
        tblCorrigendumDetail.setNewValue(newValue);
        tblCorrigendumDetail.setObjectId(objectId);
        tblCorrigendumDetail.setActionType(2);
        tblCorrigendumDetail.setTblProcess(tblProcess);
        tblCorrigendumDetail.setCreatedBy(userDetailId);
        tblCorrigendumDetail.setTblCorrigendum(tblCorrigendum);
        tblCorrigendumDetails.add(tblCorrigendumDetail);
    }
     /**
      * @param clazz
      * @param value
      * @return
      * @throws ParseException 
      */
     private static Object toObject( Class clazz, String value ) throws ParseException {
 	    if( Boolean.class == clazz ) return Boolean.parseBoolean( value );
 	    if( boolean.class == clazz ) return Boolean.parseBoolean( value );
 	    if( Byte.class == clazz ) return Byte.parseByte( value );
 	    if( byte.class == clazz ) return Byte.parseByte( value );
 	    if( Integer.class == clazz ) return Integer.parseInt(value);
 	    if( int.class == clazz ) return Integer.parseInt(value);
 	    if( Double.class == clazz ) return Double.parseDouble( value );
 	    if( double.class == clazz ) return Double.parseDouble( value );
 	    if( BigDecimal.class == clazz ) return new BigDecimal( value );
 	   // if( TblEventType.class == clazz ) return new TblEventType(Integer.parseInt(value));
 	    if( TblProcurementNature.class == clazz ) return new TblProcurementNature(Integer.parseInt(value));
 	    if( TblDepartment.class == clazz ) return new TblDepartment(Integer.parseInt(value));
 	    if(Date.class==clazz)
 	    {
 	    	DateFormat formatter = null;
 	        Date convertedDate = null;
 	    	String date = value;
 	        formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
 	        convertedDate = (Date) formatter.parse(date);
 	        return convertedDate;
 	    }	
 	    return value;
 	} 
     
     /**
      * @return
      */
     private Map<String,List<String>> getCorrigendumStatus(){
     	Map<String,List<String>> map = new HashMap<String, List<String>>();
     	ArrayList<String> dates = new ArrayList<String>();
     	dates.add("documentStartDate");
     	dates.add("documentEndDate");
     	dates.add("submissionStartDate");
     	dates.add("submissionEndDate");
     	dates.add("preBidStartDate");
     	dates.add("preBidEndDate");
     	dates.add("openingDate");
     	map.put("DATES", dates);
     	return map;
     }
}