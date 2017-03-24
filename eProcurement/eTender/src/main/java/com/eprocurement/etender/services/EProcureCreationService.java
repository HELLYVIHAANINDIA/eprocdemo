/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.daointerface.TblEventTermAndConditionsDao;
import com.eprocurement.common.model.TblCategoryMap;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.daointerface.TblBidderApprovalDetailDao;
import com.eprocurement.etender.daointerface.TblCommitteeDao;
import com.eprocurement.etender.daointerface.TblCommitteeEnvelopeDao;
import com.eprocurement.etender.daointerface.TblCommitteeUserDao;
import com.eprocurement.etender.daointerface.TblTenderBidderMapDao;
import com.eprocurement.etender.daointerface.TblTenderCurrencyDao;
import com.eprocurement.etender.daointerface.TblTenderDao;
import com.eprocurement.etender.daointerface.TblTenderEnvelopeDao;
import com.eprocurement.etender.databean.TenderDtBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblBidderApprovalDetail;
import com.eprocurement.etender.model.TblCommittee;
import com.eprocurement.etender.model.TblCommitteeEnvelope;
import com.eprocurement.etender.model.TblCommitteeUser;
import com.eprocurement.etender.model.TblCorrigendum;
import com.eprocurement.etender.model.TblEventTermAndConditions;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderBidderMap;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderWorkflow;
import com.eprocurement.etender.model.TblUserLogin;

/**
 *
 */
@Service
public class EProcureCreationService {

	@Autowired
	CommonDAO commonDAO;
	@Autowired
	CommonService commonService;
	@Autowired
	TblEventTermAndConditionsDao termAndConditionsDao;
	@Autowired
	MessageSource messageSource;
	@Autowired
	HibernateQueryDao hibernateQueryDao;
	@Autowired
	FormService biddingFormService;
	@Autowired
	TblTenderDao tenderDao;
	@Autowired
	TblTenderCurrencyDao currencyDao;
	@Autowired
	TblTenderEnvelopeDao tblTenderEnvelopeDao;
	@Autowired
	TblCommitteeDao tblCommitteeDao;
	@Autowired
	TblCommitteeEnvelopeDao tblCommitteeEnvelopeDao;
	@Autowired
	TblCommitteeUserDao tblCommitteeUserDao;
	@Autowired
	TblBidderApprovalDetailDao tblBidderApprovalDetailDao;
	@Autowired
	TblTenderBidderMapDao tenderBidderMapDao;
	@Autowired
	OfficerService userService;
	@Autowired
	TenderCommonService tenderCommonService;
	
	private static final String TBLTENDERTENDERID = "tblTender.tenderId";
	@Value("#{etenderProperties['client_dateformate']}")
    private String client_dateformate;
	@Value("#{etenderProperties['isProductionServer']}")
    private Boolean isProductionServer;
	@Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	static final String TENDERID = "tenderId";
	static final String ISAUCTION = "isAuction";
	@Value("#{projectProperties['tenderNITObjectId']}")
    private String tenderNITObjectId;
	
	
	
	public TenderDtBean setTenderParameters(HttpServletRequest request) {

		TenderDtBean tenderDtBean = new TenderDtBean();
		tenderDtBean.setHdIsDateValidationAllow(pInt(request,"hdIsDateValidationAllow"));
		tenderDtBean.setHdIsCategoryAllow(pInt(request, "hdIsCategoryAllow"));
		tenderDtBean.setHdBrdMode(pInt(request, "hdBrdMode"));
		tenderDtBean.setIsPastEvent(pInt(request, "isPastEvent"));
		tenderDtBean.setSelDecimalValueUpto(pInt(request, "selDecimalValueUpto"));
		tenderDtBean.setTxtParentDepartment(pInt(request,"txtParentDepartment"));
		tenderDtBean.setSelFormType(request.getParameterValues("selFormType"));
		tenderDtBean.setSelDeptOfficial(pInt(request, "selDeptOfficial"));
		tenderDtBean.setTxtTenderNo(request.getParameter("txtTenderNo"));
		tenderDtBean.setTxtaTenderBrief(request.getParameter("txtaTenderBrief"));
		tenderDtBean.setRtfTenderDetail(request.getParameter("rtfTenderDetail"));
		tenderDtBean.setTxtaKeyword(request.getParameter("txtaKeyword"));                                                            
		tenderDtBean.setSelEnvelopeType(pInt(request, "selEnvelopeType"));
		tenderDtBean.setTxtValidityPeriod(request.getParameter("txtValidityPeriod"));
		tenderDtBean.setSelDownloadDocument(pInt(request, "selDownloadDocument"));
		tenderDtBean.setSelProcurementNatureId(pInt(request, "selProcurementNatureId"));
		tenderDtBean.setTxtOtherProcNature(request.getParameter("txtOtherProcNature"));
		tenderDtBean.setTxtProjectDuration(request.getParameter("txtProjectDuration"));
		tenderDtBean.setTxtTenderValue(request.getParameter("txtTenderValue"));
		tenderDtBean.setTxtRmvFormList(request.getParameter("txtRmvFormList"));
		tenderDtBean.setSelIsItemwiseWinner(pInt(request, "selIsItemwiseWinner"));
		tenderDtBean.setSelTenderMode(pInt(request, "selTenderMode"));
		tenderDtBean.setSelAutoResultSharing(pInt(request, "selAutoResultSharing"));
		tenderDtBean.setSelIsRebateApplicable(pInt(request, "selIsRebateApplicable"));
		tenderDtBean.setSelIsWeightageEvaluationRequired(pInt(request,"selIsWeightageEvaluationRequired"));
		tenderDtBean.setSelCurrencyId(pInt(request, "selCurrencyId"));
		tenderDtBean.setSelBiddingType(pInt(request, "selBiddingType"));
		tenderDtBean.setTxtEmdAmount(request.getParameter("txtEmdAmount"));
		tenderDtBean.setSelIsConsortiumAllowed(pInt(request, "selIsConsortiumAllowed"));
		tenderDtBean.setSelIsFormBasedConsortium(pInt(request, "selIsFormBasedConsortium"));
		tenderDtBean.setSelIsBidWithdrawal(pInt(request, "selIsBidWithdrawal"));
		tenderDtBean.setSelBiddingVariant(pInt(request, "selBiddingVariant"));
		tenderDtBean.setSelIsPreBidMeeting(pInt(request, "selIsPreBidMeeting"));
		tenderDtBean.setSelPreBidMode(pInt(request, "selPreBidMode"));
		tenderDtBean.setTxtaPreBidAddress(request.getParameter("txtaPreBidAddress"));
		tenderDtBean.setSelIsWorkflowRequired(pInt(request, "selIsWorkflowRequired"));
		tenderDtBean.setSelWorkflowType(3); // only any to any
		tenderDtBean.setSelWorkflowType(pInt(request, "selWorkflowType"));
		tenderDtBean.setTxtDocumentStartDate(request.getParameter("txtDocumentStartDate"));
		tenderDtBean.setTxtDocumentEndDate(request.getParameter("txtDocumentEndDate"));
		tenderDtBean.setTxtSubmissionStartDate(request.getParameter("txtSubmissionStartDate"));
		tenderDtBean.setTxtSubmissionEndDate(request.getParameter("txtSubmissionEndDate"));
		tenderDtBean.setTxtBidOpenDate(request.getParameter("txtBidOpenDate"));
		tenderDtBean.setTxtPreBidStartDate(request.getParameter("txtPreBidStartDate"));
		tenderDtBean.setTxtPreBidEndDate(request.getParameter("txtPreBidEndDate"));
		tenderDtBean.setSelIsDocfeesApplicable(pInt(request, "selIsDocfeesApplicable"));
		tenderDtBean.setSelDocFeePaymentMode(pInt(request, "selDocFeePaymentMode"));
		tenderDtBean.setTxtDocumentFee(request.getParameter("txtDocumentFee"));
		tenderDtBean.setTxtaDocFeePaymentAddress(request.getParameter("txtaDocFeePaymentAddress"));
		tenderDtBean.setSelIsSecurityfeesApplicable(pInt(request, "selIsSecurityfeesApplicable"));
		tenderDtBean.setSelSecFeePaymentMode(pInt(request, "selSecFeePaymentMode"));
		tenderDtBean.setTxtSecurityFee(request.getParameter("txtSecurityFee"));
		tenderDtBean.setTxtaSecFeePaymentAddress(request.getParameter("txtaSecFeePaymentAddress"));
		tenderDtBean.setSelIsEMDApplicable(pInt(request, "selIsEMDApplicable"));
		tenderDtBean.setSelEmdPaymentMode(pInt(request, "selEmdPaymentMode"));
		tenderDtBean.setSelEmdPaymentMode(pInt(request, "selEmdPaymentMode"));
		tenderDtBean.setTxtaEmdPaymentAddress(request.getParameter("txtaEmdPaymentAddress"));
		tenderDtBean.setSelIsRegistrationCharges(pInt(request, "selIsRegistrationCharges"));
		tenderDtBean.setSelRegistrationChargesMode(pInt(request, "selRegistrationChargesMode"));
		tenderDtBean.setTxtRegistrationCharges(request.getParameter("txtRegistrationCharges"));
		tenderDtBean.setSelDepartment(request.getParameter("selDepartment")!=null ? Integer.parseInt(request.getParameter("selDepartment")) : 0);
		tenderDtBean.setSubDept(request.getParameter("subDept") !=null ? Integer.parseInt(request.getParameter("subDept")) : 0);
		tenderDtBean.setOrganization(request.getParameter("organization") !=null ? Integer.parseInt(request.getParameter("organization")) : 0);
		tenderDtBean.setHdEventTypeId(pInt(request, "hdEventTypeId"));
		tenderDtBean.setHdOpType(request.getParameter("hdOpType"));
		tenderDtBean.setHdTenderId(pInt(request, "hdTenderId"));
		
		return tenderDtBean;
	}


	public Integer pInt(HttpServletRequest request, String val){
		if(request.getParameter(val) != null && !"".equals(request.getParameter(val))){
			return Integer.parseInt(request.getParameter(val));
		}
		return 0;
	}

	public List<Object> getTenderDetailForCorrigendum(int tenderId) throws Exception {
        TblTender tblTender;
        Map<Integer, BigDecimal> tenderCurr = new HashMap();
        List<TblTenderCurrency> lstTenderCurr;
        List<Object> lstTenderDetail = new ArrayList();
        tblTender = getTenderMaster(tenderId);
        List<TblTenderEnvelope> lstTblTenderEnvelope;
        lstTenderDetail.add(tblTender);
        lstTenderCurr = commonDAO.findEntity(TblTenderCurrency.class,TBLTENDERTENDERID, Operation_enum.EQ, tenderId);
        for (TblTenderCurrency ob : lstTenderCurr) {
            tenderCurr.put(ob.getTblCurrency().getCurrencyId(), ob.getExchangeRate());
        }
        lstTblTenderEnvelope = getTblTenderEnvelopeList(tenderId);
        lstTenderDetail.add(tenderCurr);
        lstTenderDetail.add(lstTblTenderEnvelope);
        lstTenderDetail.add(lstTenderCurr);

        return lstTenderDetail;
    }
	
	public List<TblTenderEnvelope> getTblTenderEnvelopeList(int tenderId) throws Exception  {
        return commonDAO.findEntity(TblTenderEnvelope.class,TBLTENDERTENDERID, Operation_enum.EQ, tenderId,"cstatus",Operation_enum.EQ,1, "tblEnvelope.envId", Operation_enum.ORDERBY, Operation_enum.ASC);
    }
	
	public List<TblTenderForm> getTblTenderFormList(int tenderId) throws Exception {
			return commonDAO.findEntity(TblTenderForm.class,TBLTENDERTENDERID, Operation_enum.EQ, tenderId,"cstatus",Operation_enum.EQ,1);
	}
	 /**
     * get tender Detail for view and edit auction
     *
     * @param int tenderId
     * @return int
     * @throws Exception
     */
    public List<Object> getTenderDetail(int tenderId) throws Exception {
        TblTender tblTender;
        Map<Integer, BigDecimal> tenderCurr = new HashMap<Integer, BigDecimal>();
        List<TblTenderCurrency> lstTenderCurr;
        List<Object> lstTenderDetail = new ArrayList();
        tblTender = getTenderMaster(tenderId);
        List<TblTenderEnvelope> lstTblTenderEnvelope;
        lstTenderDetail.add(tblTender);
        lstTenderCurr = commonDAO.findEntity(TblTenderCurrency.class,TBLTENDERTENDERID, Operation_enum.EQ, tenderId, "isActive", Operation_enum.EQ, 1);
        for (TblTenderCurrency ob : lstTenderCurr) {
            tenderCurr.put(ob.getTblCurrency().getCurrencyId(), ob.getExchangeRate());
        }
        lstTblTenderEnvelope = getTblTenderEnvelopeList(tenderId);
        lstTenderDetail.add(tenderCurr);
        lstTenderDetail.add(lstTblTenderEnvelope);

        return lstTenderDetail;
    }

    public List<Object[]> getTenderSummeryData(int tenderId) throws Exception {
        StringBuilder strQuery = new StringBuilder();
        Map<String, Object> parameters = new HashMap();
        parameters.put(TENDERID, tenderId);
        strQuery.append(" select tbltender.tblDepartment.deptName,tbluserlogin.userName,tbltendercurrency.tblCurrency.lang1 ");
        strQuery.append(" from TblTender tbltender, TblUserLogin tbluserlogin ");
        strQuery.append(" inner join tbltender.tblDepartment tbldepartment ");
        strQuery.append(" inner join tbltender.tblTenderCurrency tbltendercurrency WITH  tbltendercurrency.isDefault = 1 and tbltendercurrency.isActive = 1 ");
        strQuery.append(" where tbltender.tenderId = :tenderId and tbltender.officerId = tbluserlogin.userId  ");
        return commonDAO.executeSelect(strQuery.toString(), parameters);
    }

	/**
	 * 
	 * @param tenderId
	 * @return
	 * @throws Exception
	 */
	public TblTender getTenderMaster(int tenderId) throws Exception {
		List<TblTender> tender = commonDAO.findEntity(TblTender.class,TENDERID,Operation_enum.EQ, tenderId);
		return tender.get(0);
	}
	
	
	/**
	 * 
	 * @param tenderId
	 * @return
	 * @throws Exception
	 */
	public List<Object[]> getTenderDocumentChecklist(int tenderId) throws Exception {
		Map<String, Object> parameters = new HashMap();
        parameters.put(TENDERID, tenderId);
		String query = "select tblTenderDocument.documentId,tblTenderDocument.documentName from TblTenderDocument tblTenderDocument where tblTenderDocument.tblTender.tenderId=:tenderId";
        return commonDAO.executeSelect(query, parameters);
	}
	
   
	public boolean updateTender(TblTender tblTender) throws Exception {
		commonDAO.merge(tblTender);
		return true;
	}
    public boolean deleteTenderEnvelope(List<Integer> lstEnvelopeId, Integer tenderId) throws Exception {

        if (lstEnvelopeId != null && !lstEnvelopeId.isEmpty()) {
            StringBuilder strQuery = new StringBuilder();
            Map<String, Object> parameters = new HashMap();
            List<Integer> lstEnvId = new ArrayList();
            parameters.put(TENDERID, tenderId);
            parameters.put("envIds", lstEnvelopeId);
            strQuery.append("select tbltenderenvelope.envelopeId  from TblTenderEnvelope tbltenderenvelope where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.tblEnvelope.envId in (:envIds)");
            List<Object> lst = commonDAO.executeSelect(strQuery.toString(), parameters);
            if (lst != null && !lst.isEmpty()) {
                for (Object o : lst) {
                    lstEnvId.add((Integer) o);
                }
            }
            
            parameters = new HashMap();
            parameters.put("envelopeId", lstEnvId);
            try
            {
            strQuery=new StringBuilder();
            strQuery.append("select formId from tbl_tenderform where envelopeid IN ( :envelopeId)");
            List<Object[]> lstForm=hibernateQueryDao.createSQLQuery(strQuery.toString(), parameters);
            
            List<Integer> formLst=new ArrayList();
            if(lst !=null && !lst.isEmpty())
            {
                for(Object o:lstForm){
                	formLst.add((Integer)o);
                }
            }
                
             
            Map<String, Object> formParameters = new HashMap();
            formParameters.put("formId", formLst);
            
            strQuery =new StringBuilder();
            strQuery.append("delete from TblTenderDocument where tblTenderForm.formId IN (:formId)");
            commonDAO.executeUpdate(strQuery.toString(),formParameters);
             strQuery=new StringBuilder();
            strQuery.append("delete from TblTenderGovColumn where tblTenderForm.formId IN (:formId)");
            commonDAO.executeUpdate(strQuery.toString(),formParameters);
            strQuery=new StringBuilder();
            strQuery.append("delete from TblTenderFormula where tblTenderForm.formId IN (:formId)");
            commonDAO.executeUpdate(strQuery.toString(),formParameters);
            strQuery=new StringBuilder();
            strQuery.append("delete from TblTenderCell where tblTenderForm.formId IN (:formId)");
            commonDAO.executeUpdate(strQuery.toString(),formParameters);
            strQuery=new StringBuilder();
            strQuery.append("delete from TblTenderColumn where tblTenderForm.formId IN (:formId)");
            commonDAO.executeUpdate(strQuery.toString(),formParameters);
            strQuery=new StringBuilder();
            strQuery.append("delete from TblTenderTable where formId IN (:formId)");
            commonDAO.executeUpdate(strQuery.toString(),formParameters);
            strQuery = new StringBuilder();
            strQuery.append("delete from TblTenderForm where tblTenderEnvelope.envelopeId in (:envelopeId)");
            commonDAO.executeUpdate(strQuery.toString(), parameters);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            strQuery = new StringBuilder();
           strQuery.append("delete from TblCommitteeUser where childId IN (:envelopeId) ");
            commonDAO.executeUpdate(strQuery.toString(), parameters);
            
            strQuery = new StringBuilder();
            strQuery.append("delete from TblCommitteeEnvelope where tblTenderEnvelope.envelopeId IN (:envelopeId)");
            commonDAO.executeUpdate(strQuery.toString(), parameters);
            
            strQuery = new StringBuilder();
            parameters = new HashMap();
            parameters.put(TENDERID, tenderId);
            parameters.put("envIds", lstEnvelopeId);
            strQuery.append("Delete from TblTenderEnvelope tbltenderenvelope where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.tblEnvelope.envId in (:envIds)");
            commonDAO.executeUpdate(strQuery.toString(), parameters);
           
            
        }
        return true;
    }

    public List<Integer> getEnvelopeIdList(int tenderId) throws Exception {
        String query = "select tbltenderenvelope.tblEnvelope.envId from TblTenderEnvelope tbltenderenvelope where tbltenderenvelope.tblTender.tenderId=:tenderId  order by tbltenderenvelope.tblEnvelope.envId";
        Map<String, Object> parameters = new HashMap();
        parameters.put(TENDERID, tenderId);
        List<Integer> lstEnvId = new ArrayList();
        List<Object> lst = commonDAO.executeSelect(query, parameters);
        for (Object evnId : lst) {
            lstEnvId.add(Integer.parseInt(evnId.toString()));
        }
        return lstEnvId;
    }
    
    public boolean addTenderEnvelopeList(List<TblTenderEnvelope> tblTenderEnvelopes) throws Exception {
        boolean bSuccess;
        commonDAO.saveOrUpdateAll(tblTenderEnvelopes);
        bSuccess = true;
        return bSuccess;
    }
	 @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	    public boolean updateTenderAllDetails(TblTender tblTender,List<TblTenderEnvelope> tblTenderEnvelopes,TblTenderCurrency tblTenderCurrency,List<TblTenderCurrency> tblTenderCurrencys,List<Integer> lstEnvelopeId) throws Exception {
	        boolean success;
	        updateTender(tblTender);
	     
	        List<TblTenderEnvelope> lsttblTenderEnvelope = new ArrayList();

	        success = deleteTenderEnvelope(lstEnvelopeId, tblTender.getTenderId());
	        lstEnvelopeId = getEnvelopeIdList(tblTender.getTenderId());
	        for (TblTenderEnvelope tblTenderEnvelope : tblTenderEnvelopes) {
	            if (!lstEnvelopeId.contains(tblTenderEnvelope.getTblEnvelope().getEnvId())) {
	                lsttblTenderEnvelope.add(tblTenderEnvelope);
	            }
	        }

	        if (success && lsttblTenderEnvelope != null && !lsttblTenderEnvelope.isEmpty()) {
	            success = addTenderEnvelopeList(lsttblTenderEnvelope);
	        }
	        lstEnvelopeId = getEnvelopeIdList(tblTender.getTenderId());
	        for (int i = 0; i < lstEnvelopeId.size(); i++) {
	            updateEnvelopeSortOrder(lstEnvelopeId.get(i), tblTender.getTenderId(), i + 1);
	        }
	        insertTenderCurrency(tblTenderCurrency,tblTender.getTenderId());
	        if (tblTenderCurrencys != null && !tblTenderCurrencys.isEmpty()) {
	            success = addTenderCurrencyList(tblTenderCurrencys);
	        }

	        return true;
	    }
	 public int updateEnvelopeSortOrder(int envId, int tenderId, int sortOrder) {
	        Map<String, Object> parameters = new HashMap<String, Object>();
	        parameters.put(TENDERID, tenderId);
	        parameters.put("envId", envId);
	        parameters.put("sortOrder", sortOrder);
	        String query = "update TblTenderEnvelope tbltenderenvelope set tbltenderenvelope.sortOrder=:sortOrder where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.tblEnvelope.envId=:envId";
	        return commonDAO.executeUpdate(query, parameters);
	    }
        
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addTenderAllDetails(TblTender tblTender, TblTenderCurrency tblTenderCurrency,List<TblTenderCurrency> tblTenderCurrencys , List<TblTenderEnvelope> tblTenderEnvelopes) throws Exception {
        boolean success = true;
        addTender(tblTender);
        insertTenderCurrency(tblTenderCurrency,tblTender.getTenderId());
        if (tblTenderCurrencys != null && !tblTenderCurrencys.isEmpty()) {
            success = addTenderCurrencyList(tblTenderCurrencys);
        }
        insertTenderEnvelope(tblTenderEnvelopes,tblTender.getTenderId());
        return success;
    }
   public boolean addTenderCurrencyList(List<TblTenderCurrency> tblTenderCurrencys) throws Exception {
        boolean bSuccess;
        commonDAO.saveOrUpdateAll(tblTenderCurrencys);
        bSuccess = true;
        return bSuccess;
    }
	
    public void insertTenderEnvelope(List<TblTenderEnvelope> tblTenderEnvelopes,Integer tenderId) throws Exception {
    	 if (tblTenderEnvelopes != null && !tblTenderEnvelopes.isEmpty()) {
         	commonDAO.executeUpdate("delete TblTenderEnvelope where tblTender.tenderId="+tenderId, null);
             commonDAO.saveOrUpdateAll(tblTenderEnvelopes);
         }
    }
    public void insertTenderCurrency(TblTenderCurrency tblTenderCurrencys,Integer tenderId) throws Exception {
   	 if (tblTenderCurrencys != null) {
        	commonDAO.executeUpdate("delete TblTenderCurrency where tblTender.tenderId="+tenderId, null);
            commonDAO.save(tblTenderCurrencys);
        }
   }
    
    /**
     * Add new tender
     *
     * @param TblTender tblTender
     * @return boolean
     * @throws Exception
     */
    public boolean addTender(TblTender tblTender) throws Exception {
        boolean bSuccess;
        tblTender.setTenderId(null);
        tblTender.setCreatedOn(commonService.getServerDateTime());
        commonDAO.save(tblTender);
        bSuccess = true;
        return bSuccess;
    }


	public TenderDtBean settTenderDataToTenderDtBean(int tenderId) throws Exception {
		List<TblTender> tenderList = commonDAO.findEntity(TblTender.class, TENDERID,Operation_enum.EQ,tenderId);
		TblTender tender = tenderList.get(0);
		TenderDtBean tenderDtBean = new TenderDtBean();
		tenderDtBean.setHdOpType("edit");
		tenderDtBean.setIsPastEvent( tender.getIsPastEvent());
		tenderDtBean.setSelDecimalValueUpto( tender.getDecimalValueUpto());
		tenderDtBean.setTxtParentDepartment( tender.getDepartmentId());
		tenderDtBean.setSelDeptOfficial( tender.getOfficerId());
		tenderDtBean.setTxtTenderNo(tender.getTenderNo());
		tenderDtBean.setTxtaTenderBrief(tender.getTenderBrief());
		tenderDtBean.setRtfTenderDetail(tender.getTenderDetail());
		tenderDtBean.setTxtaKeyword(tender.getKeywordText());                                                            
		tenderDtBean.setSelEnvelopeType( tender.getEnvelopeType());
		tenderDtBean.setTxtValidityPeriod(""+tender.getValidityPeriod());
		tenderDtBean.setSelDownloadDocument( tender.getDownloadDocument());
		tenderDtBean.setSelProcurementNatureId(tender.getProcurementNatureId());
		tenderDtBean.setTxtOtherProcNature(tender.getOtherProcurementNature());
		tenderDtBean.setTxtProjectDuration(tender.getProjectDuration());
		tenderDtBean.setTxtTenderValue(""+tender.getTenderValue());
		tenderDtBean.setSelIsItemwiseWinner( tender.getIsItemwiseWinner());
		tenderDtBean.setSelTenderMode( tender.getTenderMode());
		tenderDtBean.setSelAutoResultSharing(tender.getAutoResultSharing());
		tenderDtBean.setSelIsRebateApplicable(tender.getIsRebateApplicable());
		tenderDtBean.setSelIsWeightageEvaluationRequired(tender.getIsWeightageEvaluationRequired());
		tenderDtBean.setSelCurrencyId( tender.getCurrencyId());
		tenderDtBean.setSelBiddingType( tender.getBiddingType());
		tenderDtBean.setSelIsConsortiumAllowed( tender.getIsConsortiumAllowed());
		tenderDtBean.setSelIsFormBasedConsortium(tender.getIsFormBasedConsortium());
		tenderDtBean.setSelIsBidWithdrawal( tender.getIsBidWithdrawal());
		tenderDtBean.setSelBiddingVariant( tender.getBiddingVariant());
		tenderDtBean.setSelIsPreBidMeeting( tender.getIsPreBidMeeting());
		tenderDtBean.setSelPreBidMode( tender.getPreBidMode());
		tenderDtBean.setTxtaPreBidAddress(tender.getPreBidAddress());
		tenderDtBean.setSelIsWorkflowRequired( tender.getIsWorkflowRequired());
		tenderDtBean.setSelWorkflowType( tender.getWorkflowTypeId());
		tenderDtBean.setTxtDocumentStartDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tender.getDocumentStartDate()));
		tenderDtBean.setTxtDocumentEndDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tender.getDocumentEndDate()));
		tenderDtBean.setTxtSubmissionStartDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tender.getSubmissionStartDate()));
		tenderDtBean.setTxtSubmissionEndDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tender.getSubmissionEndDate()));
		tenderDtBean.setTxtBidOpenDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tender.getOpeningDate()));
		tenderDtBean.setTxtPreBidStartDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tender.getPreBidStartDate()));
		tenderDtBean.setTxtPreBidEndDate(commonService.convertSqlToClientDate(client_dateformate_hhmm,tender.getPreBidEndDate()));
		tenderDtBean.setSelIsDocfeesApplicable( tender.getIsDocfeesApplicable());
		tenderDtBean.setSelDocFeePaymentMode( tender.getDocFeePaymentMode());
		tenderDtBean.setTxtDocumentFee(tender.getDocumentFee());
		tenderDtBean.setTxtaDocFeePaymentAddress(tender.getDocFeePaymentAddress());
		tenderDtBean.setSelIsSecurityfeesApplicable( tender.getIsSecurityfeesApplicable());
		tenderDtBean.setSelSecFeePaymentMode( tender.getSecFeePaymentMode());
		tenderDtBean.setTxtSecurityFee(tender.getSecurityFee());
		tenderDtBean.setTxtaSecFeePaymentAddress(tender.getSecFeePaymentAddress());
		tenderDtBean.setSelIsEMDApplicable( tender.getIsEMDApplicable());
		tenderDtBean.setSelEmdPaymentMode( tender.getEmdPaymentMode());
		tenderDtBean.setSelEmdPaymentMode( tender.getEmdPaymentMode());
		tenderDtBean.setTxtaEmdPaymentAddress(tender.getEmdPaymentAddress());
		tenderDtBean.setSelIsRegistrationCharges( tender.getIsRegistrationCharges());
		tenderDtBean.setSelRegistrationChargesMode( tender.getRegistrationChargesMode());
		tenderDtBean.setTxtRegistrationCharges(tender.getRegistrationCharges());
		tenderDtBean.setTxtEmdAmount(tender.getEmdAmount());
		tenderDtBean.setTxtEventType(tender.getEventTypeId());
		tenderDtBean.setHdEventTypeId(tender.getEventTypeId());
		tenderDtBean.setHdOpType("edit");
		tenderDtBean.setHdTenderId( tender.getTenderId());
		return tenderDtBean;
	}


	public List<TblCorrigendum> getCorrigendumDetail(Integer corrigendumId) throws Exception {
		return commonDAO.findEntity(TblCorrigendum.class, "corrigendumId",Operation_enum.EQ,corrigendumId);
	}

	public List<TblCorrigendum> getCorrigendumByTender(Integer tenderId) throws Exception {
		return commonDAO.findEntity(TblCorrigendum.class, "objectId",Operation_enum.EQ,tenderId,"tblProcess.processId",Operation_enum.EQ,1);
	}
	/**
	 * 
	 * @param tblCorrigendum
	 */
	public void saveOrUpdateCorrigendum(TblCorrigendum tblCorrigendum) {
		commonDAO.saveOrUpdate(tblCorrigendum);
	}

	
	/**
	 * Get field property name mapping.
	 * @return
	 */
	public Map<String,Object>  getFieldDisplyName() {
		List<Object[]> lstConfigFields =  commonDAO.executeSelect("select labelName,displayProperty from TblFildnameMapping", null);
		Map<String,Object> labelMap = new HashMap();
		if (lstConfigFields != null) {
            for (int i = 0; i < lstConfigFields.size(); i++) {
                labelMap.put(lstConfigFields.get(i)[0].toString(), lstConfigFields.get(i)[1].toString());
            }
        }
		return labelMap;
	}

    public void viewTenderData( Integer tenderId, ModelMap modelMap) throws Exception{
    	TblTender tblTender;
    	if(tenderId != null && tenderId != 0){
    		List<TblTender> list = commonDAO.findEntity(TblTender.class, TENDERID,Operation_enum.EQ,tenderId);
    		tblTender = list.get(0);
    		boolean checkpricebid = false;
			List<Object[]> tenderEnvelopeList = tenderCommonService.getEnvelopeTypeByTenderId(tenderId);
			StringBuilder currencyName = new StringBuilder();;
			StringBuilder envolopeName = new StringBuilder();
			boolean technocommerce = false;
			
			if(tenderEnvelopeList != null && !tenderEnvelopeList.isEmpty()){
				for(Object[] obj : tenderEnvelopeList){
					if("4".equals(obj[2].toString()) || "5".equals(obj[2].toString())){
						checkpricebid = true;
					}else if("5".equals(obj[2].toString())){
						technocommerce = true;
					}
					envolopeName.append(obj[1].toString()).append(",");
				}
			}
			List<Object[]> tenderICBCurrency= tenderCommonService.getCurrencyByTenderId(tblTender.getTenderId());
			StringBuilder internationalCurrency = new StringBuilder();
			if(tenderICBCurrency != null && !tenderICBCurrency.isEmpty()){
				for(Object[] obj : tenderICBCurrency){
					if("1".equals(obj[2].toString())){
						currencyName.append(obj[3]);
					}else if(tblTender.getBiddingType() == 2){
						internationalCurrency.append(obj[3]).append(",");
					}

				}
			}
			StringBuilder departmentName = new StringBuilder(); 
			List<Object[]> tenderDepartment= tenderCommonService.getDepartmentById(tblTender.getDepartmentId());
			if(tenderDepartment != null && !tenderDepartment.isEmpty()){
				for(Object[] obj : tenderDepartment){
					departmentName.append(obj[1].toString()).append(",");
				} 
			}
			StringBuilder officerName = new StringBuilder(); 
			List<Object[]> tenderOfficer= tenderCommonService.getOfficerById(tblTender.getOfficerId());
			if(tenderOfficer != null && !tenderOfficer.isEmpty()){
				for(Object[] obj : tenderOfficer){
					officerName.append(obj[1]).append(",");
				}
			}

			StringBuilder procurementNature = new StringBuilder(); 
			List<Object[]> tblProcurementNature= tenderCommonService.getProcurementNatureById(tblTender.getProcurementNatureId());
			if(tenderOfficer != null && !tblProcurementNature.isEmpty()){
				for(Object[] obj : tblProcurementNature){
					procurementNature.append(obj[1]).append(",");
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
            modelMap.addAttribute("isCategoryAllow", 0);
            modelMap.addAttribute("technocommerce", technocommerce);
            modelMap.addAttribute("documentStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getDocumentStartDate()));
            modelMap.addAttribute("documentEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getDocumentEndDate()));
            modelMap.addAttribute("preBidEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getPreBidEndDate()));
            modelMap.addAttribute("preBidStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getPreBidStartDate()));
            modelMap.addAttribute("openingDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getOpeningDate()));
            modelMap.addAttribute("submissionStartDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionStartDate()));
            modelMap.addAttribute("submissionEndDate",commonService.convertSqlToClientDate(client_dateformate_hhmm, tblTender.getSubmissionEndDate()));
            modelMap.addAttribute("tenderNITObjectId", tenderNITObjectId);
            
    	  }
   }	
   
	
	/**
	 * 
	 * @param tblTender
	 * @param userId
	 * @throws Exception
	 */

	public void publishTender(TblTender tblTender,Integer userId) throws Exception {
        try{
        	biddingFormService.publishFormTender(tblTender);
        }
        catch(Exception e)
        {
           e.printStackTrace();
        } 
        UUID uuid = UUID.randomUUID();
        tblTender.setRandPass(uuid.toString());
		tblTender.setCstatus(1);
		commonDAO.update(tblTender);
		publishCommittee(tblTender, userId);
		if(tblTender.getIsWeightageEvaluationRequired() == 1){
			updateWeightageForNonMandatoryForm(tblTender);
		}
		sendNotoficationToBidderForNewTender(tblTender.getTenderMode(),tblTender.getTenderId() ,userId);
		sendNotoficationToCommitteMember(tblTender.getIsPreBidMeeting(),tblTender.getTenderId() ,userId);
	}

	private void updateWeightageForNonMandatoryForm(TblTender tblTender) {
		commonDAO.executeUpdate("update TblTenderForm tblTenderForm set formWeight=0 where tblTenderForm.tblTender.tenderId="+tblTender.getTenderId()+" and tblTenderForm.isMandatory=0", null);
	}
	/**
	 * 
	 * @param isPrebid
	 * @param tenderId
	 * @param userId
	 * @throws Exception
	 */
	private void sendNotoficationToCommitteMember(Integer isPrebid, Integer tenderId, Integer userId) throws Exception {
		Map<Integer,String> committeeType = new HashMap();
		committeeType.put(1, "Opening Committee");
		committeeType.put(2, "Evaluation Committee");
		if(isPrebid == 1){
			committeeType.put(3, "Prebid Committee");
		}
		for(Map.Entry<Integer,String> entity : committeeType.entrySet()){
		Integer cType = entity.getKey();
		String cText = entity.getValue();
		String committeeQuery = "select tblOfficer.tblUserlogin.userId,tblOfficer.id,tblCommittee.committeeType,tblOfficer.emailid from TblCommitteeUser tblCommitteeUser inner join tblCommitteeUser.tblOfficer tblOfficer inner join  tblCommitteeUser.tblCommittee tblCommittee where tblCommitteeUser.tblCommittee.isActive=1 "
				+ "and tblCommittee.tblTender.tenderId="+tenderId +" and tblCommittee.committeeType="+cType;
			List<Object[]> oldCommittees = commonDAO.executeSelect(committeeQuery, null);
			int[] committeeUser = null;
			String[] committeeUserEmailId = null;
			if(oldCommittees != null && !oldCommittees.isEmpty()){
				committeeUser = new int[oldCommittees.size()];
				committeeUserEmailId = new String[oldCommittees.size()];
				for(int i = 0; i < oldCommittees.size(); i++){
					committeeUser[i] = Integer.parseInt(oldCommittees.get(i)[0].toString());
					committeeUserEmailId[i] = oldCommittees.get(i)[3].toString();
				}
			}
			if(committeeUser != null){
				String user = "";
				StringBuilder emailId = new StringBuilder();
				if(committeeUser != null){
					for(int i = 0; i < committeeUser.length; i++){
						user += committeeUser[i]+",";
						emailId.append(committeeUserEmailId[i]).append(",");
					}
				}
				Map<String,Object> parameter = new HashMap();
				parameter.put("userId", user);
				parameter.put("committeeType", cText);
				tenderCommonService.insertNotification(tenderId, parameter, userId,6);
				if(committeeUserEmailId != null && isProductionServer != null && isProductionServer){
					parameter.clear();
					parameter.put("emailId", emailId);
					parameter.put("committeeType", cText);
					tenderCommonService.insertNotification(tenderId, parameter, userId,6);
				}
			}
		}
	}

	/**
	 * Send notification to all
	 * @param tenderMode
	 * @param tenderId
	 * @param userId
	 * @throws Exception
	 */
	private void sendNotoficationToBidderForNewTender(Integer tenderMode ,Integer tenderId,Integer userId) throws Exception {
		Map<String,Object> parameter = new HashMap();
		StringBuilder bidder = new StringBuilder(); 
		StringBuilder bidderEmailId = new StringBuilder(); 
		List<Object[]> approvedBidder;
		if(tenderMode == 1){
			approvedBidder =  getApprovedBidder();
		}else{	// Limited
			approvedBidder =  commonDAO.executeSelect("select tblBidder.bidderId,tblBidder.emailId,tblUserLogin.userId from TblTenderBidderMap where tblTender.tenderId="+tenderId, null);
		}
		if(approvedBidder != null && !approvedBidder.isEmpty()){
			for(Object[] obj : approvedBidder){
				bidder.append(obj[2]).append(",");
				bidderEmailId.append(obj[1]).append(",");
			}
		}
		parameter.put("userId", bidder);
		tenderCommonService.insertNotification(tenderId, parameter, userId,9);
		
		if(bidderEmailId.length() > 0 && isProductionServer != null && isProductionServer){
			parameter.clear();
			parameter.put("emailId", bidderEmailId);
			tenderCommonService.insertNotification(tenderId, parameter, userId,9);
		}

	}


	private List<Object[]> getApprovedBidder() {
		return commonDAO.executeSelect("select tblBidder.bidderId,tblBidder.emailId,tblUserlogin.userId from TblBidder tblBidder where tblBidder.cstatus = 1 ", null);
	}

	public Map<String, Object> getCommitteeEvaluationCount(Integer officerId,Integer status,Integer committeeType) {
		Map<String, Object> countMap = new HashMap();
		countMap.put("officerId", officerId);
		countMap.put("status", status);
		countMap.put("committeeType", committeeType);
		List<Object> list;
		StringBuilder builder = new StringBuilder();
		builder.append("SELECT COUNT(1) AS pendingEvaluationCount FROM Tbl_Tender t , tbl_committee c  WHERE c.tenderId = t.tenderId " )
		.append(" and c.committeeType=:committeeType AND c.committeeId  ")  
		.append(" IN ( SELECT tcu.committeeId FROM tbl_committeeuser tcu WHERE tcu.committeeId = c.committeeId AND tcu.officerId =:officerId)")
		.append(" AND t.cstatus = 1 AND  t.isEvaluationDone =:status ");
		list = commonDAO.executeSqlSelect(builder.toString() , countMap);
		countMap.clear();
		if(list != null && !list.isEmpty()){
			countMap.put("pending", list.get(0));
		}
		return countMap;
	}
	

	public Map<String, Object> getTenderCount(SessionBean sessionBean) throws Exception {
		List<Integer> deptId = commonService.getDeptDetailByUserId(sessionBean);
		Map<String, Object> countMap = new HashMap();
		List<Object> list;
		Map<String, Object> colValMap = new HashMap();
		Date serverDateTime = commonService.getServerDateTime();
		colValMap.put("departmentId", deptId);
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 0 and departmentId in (:departmentId)", colValMap);
		if(list != null && !list.isEmpty()){
			countMap.put("pending", list.get(0));
		}
		Map<String,Object> column = new HashMap<String,Object>();
		column.put("submissionStartDate", serverDateTime);
		column.put("submissionEndDate", serverDateTime);
		column.put("departmentId", deptId);
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and submissionStartDate<:submissionStartDate and submissionEndDate>:submissionEndDate and departmentId in (:departmentId)", column);
		if(list != null && !list.isEmpty()){
			countMap.put("live", list.get(0));
		}
		column.clear();
		column.put("submissionEndDate", serverDateTime);
		column.put("departmentId", deptId);
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and submissionEndDate<:submissionEndDate  and departmentId in (:departmentId)", column);
		if(list != null && !list.isEmpty()){
			countMap.put("archive", list.get(0));
		}
		column.clear();
		column.put("submissionStartDate", serverDateTime);
		column.put("departmentId", deptId);
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and submissionStartDate>:submissionStartDate  and departmentId in (:departmentId)", column);
		if(list != null && !list.isEmpty()){
			countMap.put("future", list.get(0));
		}
		
		column.clear();
		column.put("departmentId", deptId);
		list = commonDAO.executeSelect("select count(1) as cancelCount from TblTender where cstatus = 2  and departmentId in (:departmentId)", column);
		if(list != null && !list.isEmpty()){
			countMap.put("cancel", list.get(0));
		}
		column.clear();
		column.put("departmentId", deptId);
		list = commonDAO.executeSelect("select count(1) as totalCount from TblTender where departmentId in (:departmentId)", column);
		if(list != null && !list.isEmpty()){
			countMap.put("total", list.get(0));
		}

		return countMap;
	}

	public Map<String, Object> getTenderCount(Integer isAuction) throws Exception {
		Map<String, Object> countMap = new HashMap();
		List<Object> list;
		Map<String, Object> colValMap = new HashMap();
		Date serverDateTime = commonService.getServerDateTime();
        colValMap.put(ISAUCTION, isAuction);
                
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 0 and  isAuction= :isAuction ", colValMap);
		if(list != null && !list.isEmpty()){
			countMap.put("pending", list.get(0));
		}
		Map<String,Object> column = new HashMap();
		column.put("submissionStartDate", serverDateTime);
		column.put("submissionEndDate", serverDateTime);
                column.put(ISAUCTION, isAuction);
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and case when isAuction=1 then auctionStartDate when isAuction=0 then submissionStartDate end<:submissionStartDate and case when isAuction=1 then auctionEndDate when isAuction=0 then submissionEndDate end>:submissionEndDate and  isAuction= :isAuction", column);
		if(list != null && !list.isEmpty()){
			countMap.put("live", list.get(0));
		}
		column.clear();
		column.put("submissionEndDate", serverDateTime);
                column.put(ISAUCTION, isAuction);
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and case when isAuction=1 then auctionEndDate when isAuction=0 then submissionEndDate end<:submissionEndDate and  isAuction= :isAuction ", column);
		if(list != null && !list.isEmpty()){
			countMap.put("archive", list.get(0));
		}
		column.clear();
		column.put("submissionStartDate", serverDateTime);
                column.put(ISAUCTION, isAuction);
		list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and case when isAuction=1 then auctionStartDate when isAuction=0 then submissionStartDate end>:submissionStartDate  and  isAuction= :isAuction", column);
		if(list != null && !list.isEmpty()){
			countMap.put("future", list.get(0));
		}
		
		column.clear();
                column.put(ISAUCTION, isAuction);
		list = commonDAO.executeSelect("select count(1) as cancelCount from TblTender where cstatus = 2  and  isAuction= :isAuction", column);
		if(list != null && !list.isEmpty()){
			countMap.put("cancel", list.get(0));
		}
		column.clear();
                column.put(ISAUCTION, isAuction);
		list = commonDAO.executeSelect("select count(1) as totalCount from TblTender WHERE  isAuction=:isAuction", column);
		if(list != null && !list.isEmpty()){
			countMap.put("total", list.get(0));
		}

		return countMap;
	}


	public List<Map<String,Object>> getWorkflowDetail(Integer tenderId2,boolean getFirst,Integer corrigendumId) {
		Map<String,Object> column = new HashMap();
		column.put(TENDERID, tenderId2);
		column.put("alias", "map");
		String query = "select workflowId as workflowId,createdById as forwardedBy,tblOfficer.id as forwardedTo,action as action,createdDate as createdDate,cstatus as cstatus,remarks as remarks,corrigendumId as corrigendumId from TblTenderWorkflow where tblTender.tenderId=:tenderId " ;
		if(corrigendumId != null && corrigendumId != 0){
			column.put("corrigendumId", corrigendumId);
			query += " and corrigendumId=:corrigendumId";
		}else{
			query += " and corrigendumId=0";
		}
		if(getFirst){
			column.put("maxResult", 1);
		}
		query +=" order by createdDate asc";
		return commonDAO.executeSelect(query, column); 
	}

	public List<Map<String,Object>> getWorkflowCount(Integer tenderId2) {
		Map<String,Object> column = new HashMap();
		column.put(TENDERID, tenderId2);
		column.put("alias", "map");
		return commonDAO.executeSelect("select count(1) count from TblTenderWorkflow where tblTender.tenderId=:tenderId", column); 
	}

	
	public void saveOrUpdateWorkflow(TblTenderWorkflow tblTenderWorkflow) {
		commonDAO.saveOrUpdate(tblTenderWorkflow);
	}

	/**
	 * Update all old workflow with different status.
	 * @param tenderId
	 * @param corrigendumId
	 * @param cStatus
	 * @return
	 */
	public Integer updateOldWorkflow(Integer tenderId,Integer corrigendumId,Integer cStatus) {
		Map<String,Object> column = new HashMap();
		column.put(TENDERID, tenderId);
		column.put("cStatus", cStatus);
		column.put("corrigendumId", corrigendumId);
		return commonDAO.executeUpdate("update TblTenderWorkflow set cstatus=:cStatus where tblTender.tenderId=:tenderId and corrigendumId=:corrigendumId", column); 
	}

	/**
	 * Update subchild id as new generated workflow id.
	 */
	public Integer updateWorkflowDocumentDetail(String workflowId, String uploadedDocumentId) {
		String query = "update TblOfficerdocument set subChildId="+workflowId+",path=replace(path,'-1','"+workflowId+"') where officerDocId in ("+uploadedDocumentId+")";
		return commonDAO.executeUpdate(query, null); 
	}

	/**
	 * 
	 * @param eventId
	 * @return
	 * @throws Exception 
	 */
	public TblEventTermAndConditions getTermAndConditionByEventId(int eventId) throws Exception {
		TblEventTermAndConditions tblEventTermAndConditions = null;
		List<TblEventTermAndConditions> tblEventTermAndConditionsLst; 
		tblEventTermAndConditionsLst = termAndConditionsDao.findTblEventTermAndConditions("eventId",Operation_enum.EQ,eventId);
		if(tblEventTermAndConditionsLst!=null && !tblEventTermAndConditionsLst.isEmpty()) {
			tblEventTermAndConditions = tblEventTermAndConditionsLst.get(0);
		}
		return tblEventTermAndConditions;		
	}
	
	/**
	 * 
	 * @param eventId
	 * @return
	 * @throws Exception 
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public boolean addTermAndCondition(TblEventTermAndConditions tblEventTermAndConditions,int type) throws Exception {
		boolean bSuccess;
		if(type==0) {
			termAndConditionsDao.addTblEventTermAndConditions(tblEventTermAndConditions);
		}else {
			termAndConditionsDao.saveOrUpdateEntity(tblEventTermAndConditions);
		}
		bSuccess=true;
		return bSuccess;
	}
	
	public List<String> validatePublishTender(TblTender tblTender) {
		List<String> list = new ArrayList();
		List<String> tenderValidlist = isTenderValidForPublish(tblTender);
		if(tenderValidlist != null && !tenderValidlist.isEmpty())
		{
			list.addAll(tenderValidlist);
		}
        if(tblTender.getisAuction()==0) //condition if auction
        {
            List<String> commottValidlist = isCommitteesCanPublish(tblTender);
            if(commottValidlist != null && !commottValidlist.isEmpty())
            {
                    list.addAll(commottValidlist);
            }
        }
        if(tblTender.getisAuction()==0 || (tblTender.getisAuction()==1 && tblTender.getbiddingAccess()==0)) //condition if auction and bidding access is limited
        {
			List<String> bidderValidlist = isBidderMapped(tblTender);
			if(bidderValidlist != null && !bidderValidlist.isEmpty())
			{
				list.addAll(bidderValidlist);
			}
        }
        if(tblTender.getIsItemwiseWinner() == 0 && tblTender.getIsWeightageEvaluationRequired() == 1){
            List<Object[]> lst=biddingFormService.getFormForTender(tblTender.getTenderId());
            if(lst == null || lst.isEmpty()){
            	list.add(messageSource.getMessage("msg_all_form_mushave_weight", null, LocaleContextHolder.getLocale()));
            }else{
            	double totalWeight = 0;
            	for(int i = 0; i < lst.size(); i++){
            		Object[] data = lst.get(i);
            		if(data[5] == null || (data[5].toString()).isEmpty() || (data[5].toString()).equals("0.0")){
                    	list.add(messageSource.getMessage("msg_all_form_mushave_weight", null, LocaleContextHolder.getLocale()));
            			break;
            		}else{
            			double weight =Double.parseDouble(data[5].toString());
            			totalWeight = totalWeight + weight;
            		}
            	}
            	if(totalWeight > 100){
            		list.add(messageSource.getMessage("msg_weight_can_not_gt", null, LocaleContextHolder.getLocale()));
            	}
            }
        }
		return list;
	}


	private List<String> isTenderValidForPublish(TblTender tblTender) {
            List<String> list = new ArrayList();
            try
            {
                list=biddingFormService.PublishFormValidation(tblTender);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public boolean cancelTender(String remarks,int userId,int tenderId) throws Exception {
		Map<String, Object> parameters = new HashMap();
        parameters.put(TENDERID, tenderId);
        parameters.put("cancelRemarks", remarks);
        parameters.put("cancelDate", commonService.getServerDateTime());
        parameters.put("cancelBy", userId);
        String query = "update TblTender tblTender set tblTender.cancelRemarks=:cancelRemarks,tblTender.cancelDate=:cancelDate,tblTender.cancelBy=:cancelBy,cstatus=2 where tblTender.tenderId=:tenderId";
        int cnt = commonDAO.executeUpdate(query, parameters);
		return cnt!=0;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public Map copyTender(int tenderId,int userId) throws Exception {	
		int newTenderId = 0;
                int envId=0;
		List<TblTender> oldTblTenders = tenderDao.findTblTender(TENDERID,Operation_enum.EQ,tenderId);
		List<Object[]> oldTblCategoryMap = userService.getCategoryMap(0,tenderId,0);

		List<TblTenderCurrency> oldTblTenderCurrencies = currencyDao.findTblTenderCurrency("tblTender.tenderId",Operation_enum.EQ,tenderId);
		List<TblTenderEnvelope> oldTblTenderEnvelopes= tblTenderEnvelopeDao.findTblTenderEnvelope("tblTender.tenderId",Operation_enum.EQ,tenderId);
		List<Integer> newEvelopeIdLst = new ArrayList();
		List<Integer> newCommitteeIdLst = new ArrayList();
		List<TblCommittee> oldCommittees = tblCommitteeDao.findTblCommittee("tblTender.tenderId",Operation_enum.EQ,tenderId);
		List<TblTenderEnvelope> newTblTenderEnvelope = new ArrayList();
		TblTender newTender = new TblTender();
        Map<Integer,Integer> envelopeIds=new LinkedHashMap();
        Map mapData=new LinkedHashMap();
		//Code to copy tender
		if(oldTblTenders!=null && !oldTblTenders.isEmpty()) {
			BeanUtils.copyProperties(oldTblTenders.get(0), newTender,new String[]{"tblCommittee"});//add set and variable which needs to be ignore at the time of copy
			newTender.setTenderId(null);
			newTender.setCopyFrom(tenderId);
			newTender.setCreatedBy(userId);
			newTender.setCreatedOn(commonService.getServerDateTime());
			newTender.setCorrigendumCount(0);
			newTender.setCstatus(0);
			newTender.setIsEvaluationDone(0);
			newTender.setPublishedBy(0);
			newTender.setPublishedOn(null);
			newTender.setisBidConverted(0);
			commonDAO.save(newTender);
		}
		newTenderId = newTender.getTenderId();
		//Code to copy tendercurrencies
		if (oldTblTenderCurrencies != null && !oldTblTenderCurrencies.isEmpty()) {
			List<TblTenderCurrency> newTblTenderCurrency = new ArrayList();
			for (TblTenderCurrency tblTenderCurrency : oldTblTenderCurrencies) {
				TblTenderCurrency newTblTenderCur = new TblTenderCurrency();
				BeanUtils.copyProperties(tblTenderCurrency, newTblTenderCur);
				if(tblTenderCurrency.getIsDefault()==1){
					newTblTenderCur.setExchangeRate(BigDecimal.valueOf(1.00));
				}else{
					newTblTenderCur.setExchangeRate(BigDecimal.valueOf(0.00));
				}
				
				newTblTenderCur.setTenderCurrencyId(0);
				newTblTenderCur.setTblTender(newTender);
				newTblTenderCurrency.add(newTblTenderCur);
			}
			commonDAO.saveOrUpdateAll(newTblTenderCurrency);
        }
		if (oldTblCategoryMap != null && !oldTblCategoryMap.isEmpty()) {
			List<TblCategoryMap> newTblCategoryMap = new ArrayList();
			for (Object[] object : oldTblCategoryMap) {
				TblCategoryMap categoryMap = new TblCategoryMap();
				 categoryMap.setCategoryCode(Integer.parseInt(object[0].toString()));
				 categoryMap.setCategoryText(object[1].toString());
				 categoryMap.setTenderId(newTenderId);
				 newTblCategoryMap.add(categoryMap);
			}
			commonDAO.saveOrUpdateAll(newTblCategoryMap);
        }
		
		//Code to copy tenderEnvelope
		if (oldTblTenderEnvelopes != null && !oldTblTenderEnvelopes.isEmpty()) {
			for (TblTenderEnvelope tblTenderEnvelope : oldTblTenderEnvelopes) {
				TblTenderEnvelope newTblTenderEnvelope2 = new TblTenderEnvelope(); 
				BeanUtils.copyProperties(tblTenderEnvelope, newTblTenderEnvelope2,new String[] {"tblCommitteeEnvelope"});
                envId=newTblTenderEnvelope2.getEnvelopeId();
                newTblTenderEnvelope2.setEnvelopeId(0);
				newTblTenderEnvelope2.setCreatedBy(userId);
				newTblTenderEnvelope2.setCreatedOn(commonService.getServerDateTime());
				newTblTenderEnvelope2.setIsEvaluated(0);
				newTblTenderEnvelope2.setIsOpened(0);
				newTblTenderEnvelope2.setMinEvaluator(0);
				newTblTenderEnvelope2.setMinOpeningMember(0);
				newTblTenderEnvelope2.setOpeningDate(null);
				newTblTenderEnvelope2.setOpeningDatePublishedBy(0);
				newTblTenderEnvelope2.setOpeningDatePublishedOn(null);
				newTblTenderEnvelope2.setTblTender(newTender);
				newTblTenderEnvelope.add(newTblTenderEnvelope2);
				tblTenderEnvelopeDao.addTblTenderEnvelope(newTblTenderEnvelope2);
				newEvelopeIdLst.add(newTblTenderEnvelope2.getEnvelopeId());
                envelopeIds.put(envId, newTblTenderEnvelope2.getEnvelopeId());
                                
			}
			
		}
		
		//code to copy committees
		if(oldCommittees!=null && !oldCommittees.isEmpty()) {
			List<TblCommittee> newTblCommittees = new ArrayList();
			for (TblCommittee tblCommittee : oldCommittees) {
				commonDAO.evict(tblCommittee);
				tblCommittee.setCommitteeId(0);
				tblCommittee.setCreatedBy(userId);
				tblCommittee.setCreatedOn(commonService.getServerDateTime());
				tblCommittee.setIsApproved(0);
				tblCommittee.setPublishedBy(0);
				tblCommittee.setPublishedOn(null);
				tblCommittee.setTblTender(newTender);
				newTblCommittees.add(tblCommittee);
			}
			tblCommitteeDao.saveUpdateAllTblCommittee(newTblCommittees);
			
			for (TblCommittee tblCommittee : newTblCommittees) {
				newCommitteeIdLst.add(tblCommittee.getCommitteeId());
			}
			
			//code to copy committee envelope
			int committeCount=0;
			oldCommittees = tblCommitteeDao.findTblCommittee("tblTender.tenderId",Operation_enum.EQ,tenderId);
			for (TblCommittee tblCommittee : oldCommittees) {
				List<TblCommitteeEnvelope> oldTblCommitteeEnvelopes = tblCommitteeEnvelopeDao.findTblCommitteeEnvelope("tblCommittee.committeeId",Operation_enum.EQ,tblCommittee.getCommitteeId());
				if(oldTblCommitteeEnvelopes!=null && !oldTblCommitteeEnvelopes.isEmpty()) {
					int cnt=0;
					List<TblCommitteeEnvelope> newTblCommitteeEnvelopes = new ArrayList(); 
					for (TblCommitteeEnvelope tblCommitteeEnvelope : oldTblCommitteeEnvelopes) {
						commonDAO.evict(tblCommitteeEnvelope);
						tblCommitteeEnvelope.setCommitteeEnvelopeId(0);
						tblCommitteeEnvelope.setTblTenderEnvelope(new TblTenderEnvelope(newEvelopeIdLst.get(cnt)));
						tblCommitteeEnvelope.setTblCommittee(new TblCommittee(newCommitteeIdLst.get(committeCount)));
						newTblCommitteeEnvelopes.add(tblCommitteeEnvelope);
						cnt++;
					}
					tblCommitteeEnvelopeDao.saveUpdateAllTblCommitteeEnvelope(newTblCommitteeEnvelopes);
				}
				committeCount++;
			}
			
			//code to copy committee user
			int committeCountForUser=0;
			for (TblCommittee tblCommittee : oldCommittees) {
				List<TblCommitteeUser> oldTblCommitteeUser = tblCommitteeUserDao.findTblCommitteeUser("tblCommittee.committeeId",Operation_enum.EQ,tblCommittee.getCommitteeId());
				if(oldTblCommitteeUser!=null && !oldTblCommitteeUser.isEmpty()) {
					List<TblCommitteeUser> newTblCommitteeUser = new ArrayList();
					if(tblCommittee.getCommitteeType()==3) {
						//Copy prebid committee related user
						for (TblCommitteeUser tblCommitteeUser : oldTblCommitteeUser) {
								commonDAO.evict(tblCommitteeUser);
								tblCommitteeUser.setCommitteeUserId(0);
								tblCommitteeUser.setCreatedBy(userId);
								tblCommitteeUser.setCreatedOn(commonService.getServerDateTime());
								tblCommitteeUser.setTblCommittee(new TblCommittee(newCommitteeIdLst.get(committeCountForUser)));
								tblCommitteeUser.setChildId(0);
								newTblCommitteeUser.add(tblCommitteeUser);
						}
					}else {
						oldTblTenderEnvelopes= tblTenderEnvelopeDao.findTblTenderEnvelope("tblTender.tenderId",Operation_enum.EQ,tenderId);
						for (TblTenderEnvelope tblTenderEnvelope : oldTblTenderEnvelopes) {
							for (TblCommitteeUser tblCommitteeUser : oldTblCommitteeUser) {
								if(tblTenderEnvelope.getEnvelopeId()==tblCommitteeUser.getChildId()) {
									commonDAO.evict(tblCommitteeUser);
									tblCommitteeUser.setCommitteeUserId(0);
									tblCommitteeUser.setCreatedBy(userId);
									tblCommitteeUser.setCreatedOn(commonService.getServerDateTime());
									tblCommitteeUser.setTblCommittee(new TblCommittee(newCommitteeIdLst.get(committeCountForUser)));
									tblCommitteeUser.setChildId(envelopeIds.get(tblTenderEnvelope.getEnvelopeId()));
									tblCommitteeUser.setIsApproved(0);
									tblCommitteeUser.setApprovedBy(0);
									newTblCommitteeUser.add(tblCommitteeUser);
								}
							}
						}
						
					}
					tblCommitteeUserDao.saveUpdateAllTblCommitteeUser(newTblCommitteeUser);
				}
				committeCountForUser++;
			}
			//copy mapped bidder
			oldTblTenderEnvelopes= tblTenderEnvelopeDao.findTblTenderEnvelope("tblTender.tenderId",Operation_enum.EQ,tenderId);
			List<TblTenderBidderMap> tblTenderBidderMaps = new ArrayList();
			for (TblTenderEnvelope envelope : oldTblTenderEnvelopes) {
				if(envelope.getTblEnvelope().getEnvId()==3) {
					List<TblBidderApprovalDetail> tblBidderApprovalDetail = tblBidderApprovalDetailDao.findTblBidderApprovalDetail("tblTender.tenderId",Operation_enum.EQ,tenderId,"tblTenderEnvelope.envelopeId",Operation_enum.EQ,envelope.getEnvelopeId());
					for (TblBidderApprovalDetail tblBidderApprovalDetail2 : tblBidderApprovalDetail) {
						TblTenderBidderMap bidderMap = new TblTenderBidderMap();
						bidderMap.setTblBidder(new TblBidder(tblBidderApprovalDetail2.getBidderid()));
						bidderMap.setTblTender(tblBidderApprovalDetail2.getTblTender());
						bidderMap.setCreatedBy(userId);
						long bidderUserId = 0;
						Object[] bidderDtls = userService.getBiddderDetails(tblBidderApprovalDetail2.getBidderid());
						if(bidderDtls!=null) {
							bidderUserId=(Long)bidderDtls[12];
						}
						bidderMap.setTblUserLogin(new TblUserLogin(bidderUserId));
						bidderMap.setCreatedOn(commonService.getServerDateTime());
						bidderMap.setIpAddress("");
						bidderMap.setTblTender(new TblTender(newTenderId));
						tblTenderBidderMaps.add(bidderMap);
					}
				}
			}
			tenderBidderMapDao.saveUpdateAllTblTenderBidderMap(tblTenderBidderMaps);	
		}
                //copy form code
                
                mapData.put("newTenderId", newTenderId);
                mapData.put("envIds", envelopeIds);
                return mapData;
		//return newTenderId;
	}
	
	/**
	 * 
	 * @param tenderId
	 * @return
	 */
	public List<String> isCommitteesCanPublish(TblTender tblTender){
		List<String> errorMsg = new ArrayList();
		
		//code for per bid committe check
		if(tblTender.getIsPreBidMeeting()==1) {
			Map<String,Object> column = new HashMap();
			column.put(TENDERID, tblTender.getTenderId());
			column.put("committeeType", 3);
			List<Object[]> result = commonDAO.executeSelect("select count(1) as count,committeeId as committeeId from TblCommittee tblCommittee where tblCommittee.tblTender.tenderId=:tenderId and tblCommittee.committeeType=:committeeType", column);
			if(result!=null && !result.isEmpty()) {
				long count =  (Long)result.get(0)[0];
				int committeeId = (Integer)(result.get(0)[1]!=null?result.get(0)[1]:0);
				if(count==0) {
					errorMsg.add(messageSource.getMessage("msg_prebid_committee_pending", null, LocaleContextHolder.getLocale()));
				}else {
					Map<String,Object> committeUserColumn = new HashMap();
					committeUserColumn.put("committeeId", committeeId);
					List<Object> committeUserResult = commonDAO.executeSelect("select count(1) as count from TblCommitteeUser tblCommitteeUser where tblCommitteeUser.tblCommittee.committeeId=:committeeId", committeUserColumn);
					if(committeUserResult!=null && !committeUserResult.isEmpty()) {
						long countCommitteeUser = (Long)committeUserResult.get(0);
						if(countCommitteeUser==0) {
							errorMsg.add(messageSource.getMessage("msg_prebid_committee_member_not_added", null, LocaleContextHolder.getLocale()));
						}
					}
				}
			}
		}
		//code for bid opening committee check 
			Map<String,Object> columnBidOpening = new HashMap();
			columnBidOpening.put(TENDERID, tblTender.getTenderId());
			columnBidOpening.put("committeeType", 1);
			List<Object[]> resultBidOpening = commonDAO.executeSelect("select count(1) as count,committeeId as committeeId from TblCommittee tblCommittee where tblCommittee.tblTender.tenderId=:tenderId and tblCommittee.committeeType=:committeeType", columnBidOpening);
			if(resultBidOpening!=null && !resultBidOpening.isEmpty()) {
				long count =  (Long)resultBidOpening.get(0)[0];
				int committeeId = (Integer)(resultBidOpening.get(0)[1]!=null?resultBidOpening.get(0)[1]:0);
				if(count==0) {
					errorMsg.add(messageSource.getMessage("msg_bidopening_committee_pending", null, LocaleContextHolder.getLocale()));
				}else {
					Map<String,Object> committeUserColumn = new HashMap();
					committeUserColumn.put("committeeId", committeeId);
					List<Object> committeUserResult = commonDAO.executeSelect("select count(1) as count from TblCommitteeUser tblCommitteeUser where tblCommitteeUser.tblCommittee.committeeId=:committeeId", committeUserColumn);
					if(committeUserResult!=null && !committeUserResult.isEmpty()) {
						long countCommitteeUser = (Long)committeUserResult.get(0);
						if(countCommitteeUser==0) {
							errorMsg.add(messageSource.getMessage("msg_opening_committee_member_not_added", null, LocaleContextHolder.getLocale()));
						}
					}else {
						Map<String,Object> committeEnvUserColumn = new HashMap();
						committeEnvUserColumn.put("committeeId", committeeId);
						committeEnvUserColumn.put(TENDERID, tblTender.getTenderId());
						List<Object[]> committeEnvUserResult = commonDAO.executeSelect("select count(distinct childId) as count , (select count( distict tblTenderEnvelope.envelopeId) from TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId=:tenderId) as envCount from TblCommitteeUser tblCommitteeUser where tblCommitteeUser.tblCommittee.committeeId=:committeeId", committeEnvUserColumn);
						
						if(committeEnvUserResult!=null && !committeEnvUserResult.isEmpty()) {
							long countCommitteeEnvUser = (Long)committeEnvUserResult.get(0)[0];
							int envCount = (Integer)(committeEnvUserResult.get(0)[1]!=null?committeEnvUserResult.get(0)[1]:0);
							if(envCount!=countCommitteeEnvUser) {
								errorMsg.add(messageSource.getMessage("msg_opening_committee_member_not_added", null, LocaleContextHolder.getLocale()));
							}
						}
						
					}
					
				}
			}
			//CODE FOR BID EVALUATION CHECK 
			Map<String,Object> columnBidEvaluation = new HashMap();
			columnBidEvaluation.put(TENDERID, tblTender.getTenderId());
			columnBidEvaluation.put("committeeType", 2);
			List<Object[]> resultBidEvaluation = commonDAO.executeSelect("select count(1) as count,committeeId as committeeId from TblCommittee tblCommittee where tblCommittee.tblTender.tenderId=:tenderId and tblCommittee.committeeType=:committeeType", columnBidEvaluation);
			if(resultBidEvaluation!=null && !resultBidEvaluation.isEmpty()) {
				long count = (Long)resultBidEvaluation.get(0)[0];
				int committeeId = (Integer)(resultBidEvaluation.get(0)[1]!=null?resultBidEvaluation.get(0)[1]:0);
				if(count==0) {
					errorMsg.add(messageSource.getMessage("msg_evaluation_committee_pending", null, LocaleContextHolder.getLocale()));
				}else {
					Map<String,Object> committeUserColumn = new HashMap();
					committeUserColumn.put("committeeId", committeeId);
					List<Object> committeUserResult = commonDAO.executeSelect("select count(1) as count from TblCommitteeUser tblCommitteeUser where tblCommitteeUser.tblCommittee.committeeId=:committeeId", committeUserColumn);
					if(committeUserResult!=null && !committeUserResult.isEmpty()) {
						long countCommitteeUser = (Long)committeUserResult.get(0);
						if(countCommitteeUser==0) {
							errorMsg.add(messageSource.getMessage("msg_evaluation_committee_member_not_added", null, LocaleContextHolder.getLocale()));
						}
					}else {
						Map<String,Object> committeEnvUserColumn = new HashMap();
						committeEnvUserColumn.put("committeeId", committeeId);
						committeEnvUserColumn.put(TENDERID, tblTender.getTenderId());
						List<Object[]> committeEnvUserResult = commonDAO.executeSelect("select count(distinct childId) as count , (select count( distict tblTenderEnvelope.envelopeId) from TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId=:tenderId) as envCount from TblCommitteeUser tblCommitteeUser where tblCommitteeUser.tblCommittee.committeeId=:committeeId", committeEnvUserColumn);
						
						if(committeEnvUserResult!=null && !committeEnvUserResult.isEmpty()) {
							long countCommitteeEnvUser = (Long)committeEnvUserResult.get(0)[0];
							int envCount = (Integer)committeEnvUserResult.get(0)[1];
							if(envCount!=countCommitteeEnvUser) {
								errorMsg.add(messageSource.getMessage("msg_evaluation_committee_member_not_added", null, LocaleContextHolder.getLocale()));
							}
						}
						
					}
					
				}
		}
		return errorMsg;
	}
	
	public List<String> isBidderMapped(TblTender tblTender){
		List<String> errorMsg = new ArrayList();
		if(tblTender.getTenderMode()!=1) {
			Map<String,Object> column = new HashMap();
			column.put(TENDERID, tblTender.getTenderId());
			List<Object> result = commonDAO.executeSelect("select count(distinct mapBidderId) as count from TblTenderBidderMap tblTenderBidderMap where tblTenderBidderMap.tblTender.tenderId=:tenderId", column);
			if(result!=null && !result.isEmpty()) {
				long count = (Long)result.get(0);
				if(count==0) {
					errorMsg.add(messageSource.getMessage("msg_mapbidder_not_added", null, LocaleContextHolder.getLocale()));
				}
			}
		}
		return errorMsg;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public int publishCommittee(TblTender tblTender,int userId) {
		Map<String, Object> tenderDoc = new HashMap();
		tenderDoc.put(TENDERID, tblTender.getTenderId());
		tenderDoc.put("objectId", 1);
		tenderDoc.put("cstatus", 1);
		String docQuery;
		docQuery = "update TblOfficerdocument tblOfficerdocument set tblOfficerdocument.cstatus=:cstatus where tblOfficerdocument.tenderId=:tenderId and tblOfficerdocument.objectId=:objectId ";
        commonDAO.executeUpdate(docQuery, tenderDoc);
		
		Map<String, Object> parameters = new HashMap();
        parameters.put(TENDERID, tblTender.getTenderId());
        parameters.put("openingDate", tblTender.getOpeningDate());
        parameters.put("openingDatePublishedBy", userId);
        parameters.put("openingDatePublishedOn", commonService.getServerDateTime());
        String query;
        if(tblTender.getEnvelopeType()==1) {
        	query = "update TblTenderEnvelope tbltenderenvelope set tbltenderenvelope.openingDate=:openingDate,tbltenderenvelope.openingDatePublishedBy=:openingDatePublishedBy,tbltenderenvelope.openingDatePublishedOn=:openingDatePublishedOn,tbltenderenvelope.openingDateStatus=1 where tbltenderenvelope.tblTender.tenderId=:tenderId";
        }else {
        	query = "update TblTenderEnvelope tbltenderenvelope set tbltenderenvelope.openingDate=:openingDate,tbltenderenvelope.openingDatePublishedBy=:openingDatePublishedBy,tbltenderenvelope.openingDatePublishedOn=:openingDatePublishedOn,tbltenderenvelope.openingDateStatus=1 where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.sortOrder=1";
        }
        commonDAO.executeUpdate(query, parameters);
        Map<String, Object> committeeParameters = new HashMap();
        committeeParameters.put(TENDERID, tblTender.getTenderId());
        String committeeQuery = "update TblCommittee tblCommittee set tblCommittee.isApproved=1,tblCommittee.isActive=1 where tblCommittee.tblTender.tenderId=:tenderId";
        int cnt =  commonDAO.executeUpdate(committeeQuery, committeeParameters);
        return cnt;
	}
	
	
	public boolean coyTenderLinkRequired(TblTender tblTender){
		boolean bSuccess = false;
		StringBuilder strQuery = new StringBuilder();
        Map<String, Object> parameters = new HashMap();
        parameters.put(TENDERID, tblTender.getTenderId());
        strQuery.append("select tbltenderenvelope.isEvaluated  from TblTenderEnvelope tbltenderenvelope where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.tblEnvelope.envId=3");
        List<Object> lst = commonDAO.executeSelect(strQuery.toString(), parameters);
        if(lst!=null && !lst.isEmpty()) {
        	int isEvaluated = (Integer)lst.get(0);
        	if(isEvaluated>0) {
        		bSuccess=true;
        	}
        }
        return bSuccess;
	}
	
	public void deleteTender(Integer tenderId) {
		commonDAO.executeUpdate("update TblTender set cstatus=4 where tenderId="+tenderId, null);
	}


	public boolean isAnyConsentReceived(Integer tenderId) {
		boolean bSuccess = false;
		StringBuilder strQuery = new StringBuilder();
        Map<String, Object> parameters = new HashMap();
        parameters.put(TENDERID, tenderId);
        strQuery.append("select count(1) as count  from TblCommitteeUser tblCommitteeUser join tblCommitteeUser.tblCommittee tblCommittee join tblCommittee.tblTender tblTender where tblTender.tenderId=:tenderId and tblCommitteeUser.remarks != null and tblCommitteeUser.remarks != '' and tblCommitteeUser.isApproved=1");
        List<Object> lst = commonDAO.executeSelect(strQuery.toString(), parameters);
        if(lst!=null && !lst.isEmpty()) {
        	Long isEvaluated = (Long)lst.get(0);
        	if(isEvaluated>0) {
        		bSuccess=true;
        	}
        }
		return bSuccess;
	}
}
