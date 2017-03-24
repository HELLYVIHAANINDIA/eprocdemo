/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.model.TblMarquee;
import com.eprocurement.common.model.TblProcess;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.utility.SpringMailSender;
import com.eprocurement.etender.daointerface.TblFinalSubmissionDao;
import com.eprocurement.etender.daointerface.TblShareReportDao;
import com.eprocurement.etender.daointerface.TblTenderDao;
import com.eprocurement.etender.daointerface.TblTenderFormDao;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblBidderdocument;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblEnvelope;
import com.eprocurement.etender.model.TblEventType;
import com.eprocurement.etender.model.TblFinalsubmission;
import com.eprocurement.etender.model.TblRebate;
import com.eprocurement.etender.model.TblShareReport;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderDocument;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderRebate;

/**
 *
 * 
 */
@Service
public class TenderCommonService {

    @Autowired
    HibernateQueryDao hibernateQueryDao;
    @Autowired
    CommonDAO commonDAO;
    @Autowired
    BidderSubmissionService eventBidSubmissionService;
    @Autowired
    TblTenderFormDao tblTenderFormDao;
    @Autowired
    TblFinalSubmissionDao tblFinalSubmissionDao;
    @Autowired
    TblTenderDao tblTenderDao;
    @Autowired
    TenderService tenderFormService;
    @Autowired
    FormService formService;
    @Autowired
    CommonService commonService;
    @Autowired
    BidderMappingService eventBidderMapService;
    @Autowired
    EProcureCreationService eventCreationService;
    @Autowired
    TblShareReportDao tblShareReportDao;
	@Autowired
	OfficerService officerService;
	@Value("#{projectProperties['mail.from']}")
    private String mailFrom;
    
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	@Autowired
	private SpringMailSender mailSender;
	@Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	private static final String TENDER_ID = "tenderId";
    /**
     * Method use to fetch specific columns from TblTender. Pass comma separated filed. Do not pass space between comma and field name
     *
     * @param tenderId
     * @param field ex: field1,field2,...
     * @return {@code List<Object[]>}
     */
    @Transactional
    public List<Object[]> getTenderFields(int tenderId, String field) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDER_ID, tenderId);
        StringBuilder strQuery = new StringBuilder();
        strQuery.append(" select ").append(field).append(" from TblTender ");
        strQuery.append(" where tenderId=:tenderId");
        return commonDAO.executeSelect(strQuery.toString(), var);
    }
    
    /**
     * Method use to fetch specific columns from TblTender. Pass comma separated filed. Do not pass space between comma and field name
     *
     * @param tenderId
     * @param field ex: field1,field2,...
     * @return {@code List<Object[]>}
     */
    @Transactional
    public Object getTenderField(int tenderId, String field) {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(TENDER_ID, tenderId);
        StringBuilder strQuery = new StringBuilder();
        strQuery.append(" select ").append(field).append(" from TblTender ");
        strQuery.append(" where tenderId=:tenderId");
        List<Object> ls = commonDAO.executeSelect(strQuery.toString(), parameters);
        if (ls != null && !ls.isEmpty()) {
            return ls.get(0);
        }
        return null;
    }
    
    public List<Object[]>  getCountFormMandDocs(int tenderId,int bidderId,List<Integer> formIds ,List<Integer> documentIds ){
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(TENDER_ID, tenderId);
        parameters.put("bidderId", bidderId);
        if(!formIds.isEmpty() && formIds!=null){
        	parameters.put("formIds", formIds);
        }
        if(!documentIds.isEmpty() && documentIds!=null){
        	parameters.put("documentIds", documentIds);
        }
        StringBuilder strQuery = new StringBuilder();
        strQuery.append(" select distinct(mandatoryDocId)");
        strQuery.append(" from tbl_bidderdocument tblbidderdocument");
        strQuery.append(" LEFT join tbl_tenderdocument tbltenderdocument on tblbidderdocument.tenderId = tbltenderdocument.tenderId");
        strQuery.append(" where tblbidderdocument.tenderId = :tenderId and bidderId =:bidderId AND isMandatory = 1 ");
        if(!formIds.isEmpty() && formIds!=null){
            strQuery.append("and childId IN (:formIds)");
        }
        if(!documentIds.isEmpty() && documentIds!=null){
        	strQuery.append("and mandatoryDocId IN (:documentIds)");
        }
                
        List<Object[]> ls = hibernateQueryDao.createSQLQuery(strQuery.toString(),parameters);
        if (ls != null && !ls.isEmpty()) {
           return ls;
        }
        return null;    
    }
    
    public List<Object[]>  getFirstEnvelopeId(int tenderId)
    {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(TENDER_ID, tenderId);
        StringBuilder strQuery = new StringBuilder();
        strQuery.append(" select envelopeId,isOpened,isEvaluated,envId from apptender.tbl_tenderenvelope a where a.tenderId=:tenderId and sortOrder = 1 and cstatus in (1,3); ");
        List<Object[]> ls = hibernateQueryDao.createSQLQuery(strQuery.toString(),parameters);
        if (ls != null && !ls.isEmpty()) {
           return ls;
        }
        return null;
    }
    public Boolean isAnyEnvelopeOpened(int tenderId)
    {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(TENDER_ID, tenderId);
        StringBuilder strQuery = new StringBuilder();
        strQuery.append(" select isOpened,isEvaluated,envId from apptender.tbl_tenderenvelope a where a.tenderId=:tenderId and cstatus in (1,3); ");
        List<Object[]> ls = hibernateQueryDao.createSQLQuery(strQuery.toString(),parameters);
        if (ls != null && !ls.isEmpty()) 
        {
        	for(int i=0;i<ls.size();i++)
        	{
        		Byte value = (Byte) ls.get(i)[0];
        		if(value == 1)
        		{
        			return true;
        		}
        	}
        }
        return false;
    	
    }
    

    /**
     *
     * @param tenderId
     * @return
     * @throws Exception
     */
    @Transactional
    public List<Object[]> getTenderEnvelopeByTenderId(int tenderId,boolean isMapBidder,List<Integer> cStatus) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("cStatus", cStatus);
        query.append("select distinct tbltenderenvelope.envelopeId,tbltenderenvelope.envelopeName,tbltenderenvelope.tblEnvelope.envId,tbltenderenvelope.minFormsReqForBidding,tbltenderenvelope.cstatus from TblTenderEnvelope tbltenderenvelope ");
       /* if (isConsortium) {
            query.append(" inner join tbltenderenvelope.tblTenderForm tbltenderform with tbltenderform.isSecondary=1 and tbltenderform.cstatus in (1,2)");
        }*/
        query.append(" where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.cstatus in (:cStatus)");
        if(isMapBidder){
            query.append(" and tbltenderenvelope.tblEnvelope.envId=4 ");
        }
        query.append(" order by tbltenderenvelope.tblEnvelope.envId");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    
    /**
     *
     * @param tenderId
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    @Transactional
    public List<Object[]> getTenderFormByTenderId(boolean isBidder, int... objectId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", objectId[0]);
        query.append(" select tbltenderform.formId,tbltenderform.formName,tbltenderform.tblTenderEnvelope.envelopeId, ")
                .append(" case when tbltenderform.cstatus=0 then 'Pending' ")
                .append(" when tbltenderform.cstatus=1 then 'Approved' end ")//when tbltenderform.cstatus=2 then 'Cancelled'
                .append(" ,tbltenderform.sortOrder ,tbltenderform.isMandatory ,tbltenderform.isSecondary ,tbltenderform.isPriceBid ")
                .append(" ,tbltenderform.isEncryptionReq ,tbltenderform.isMultipleFilling ,tbltenderform.isDocumentReq")
                .append(" ,1 ");
        query.append(" ,tbltenderform.isItemWiseDocAllowed,tbltenderform.tblTenderEnvelope.minFormsReqForBidding,tbltenderform.minTablesReqForBidding,tbltenderform.formWeight from TblTenderForm tbltenderform where tbltenderform.tblTender.tenderId=:tenderId ");
        if (objectId.length > 1 && objectId[1] == 0) {
            query.append(" and tbltenderform.cstatus=0 ");
        }
        if (isBidder) {
            if (objectId.length > 1 && objectId[1] == 1) {
                query.append(" and tbltenderform.cstatus=1");
            } else {
                query.append(" and tbltenderform.cstatus in (1)");//cancel status
            }
           /* if (isConsortium) {
                query.append(" and tbltenderform.isSecondary=1");
            }*/
        }
        if((objectId.length == 5) && (objectId[2] == 2 || objectId[2] == 3 || objectId[2] == 4) && (objectId[3] == 1)){
            query.append(" and tbltenderform.formId in (");
            query.append(" select distinct tbltenderform.formId");
            query.append(" from TblTenderTable tbltendertable,TblTenderForm tbltenderform");
            query.append(" where tbltenderform.formId = tbltendertable.formId AND tbltenderform.tblTender.tenderId=:tenderId and tbltenderform.cstatus in (1,2)) ");
        }
        query.append(" order by tbltenderform.tblTenderEnvelope.envelopeId,tbltenderform.sortOrder");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    
    
    
    /**
     *
     * @param tenderId
     * @param Object>
     * @param clientId
     * @return
     * @throws Exception
     */
    @Transactional
    public void tenderSummary(int tenderId, Map<String, Object> hashMap) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        StringBuilder query = new StringBuilder("select tbltender.evaluationMode, tbltender.isConsortiumAllowed, tbltender.tenderMode, tbltender.biddingType, tbltender.tenderResult,");
        query.append(" tbltender.tenderNo, tbltender.tenderNo,tbltender.eventTypeId,tbltender.documentStartDate,")
                .append("tbltender.documentEndDate,tbltender.downloadDocument,tbltender.submissionEndDate,tbltender.openingDate,")
                .append("tbltender.isCertRequired,tbltender.isMandatoryDocument,tbltender.isOpeningByCommittee,tbltender.isRebateForm,tbltender.tenderBrief,tbltender.corrigendumCount,tbltender.decimalValueUpto ")
                .append(",tbltender.brdMode,tbltender.tenderNo,tbltender.isEvaluationByCommittee, tbltender.cstatus,tbltender.biddingVariant ")
                .append(",tbltender.isItemwiseWinner,tbltender.isEvaluationRequired,tbltender.officerId,tbltender.sorVariation,tbltender.isSORApplicable,tbltender.submissionMode,tbltender.isWorkflowRequired,tbltender.isEncodedName,tbltender.docFeePaymentMode,tbltender.emdPaymentMode,tbltender.isBidWithdrawal ")
                .append(",tbltender.isPartialFillingAllowed,tbltender.isEMDApplicable,tbltender.isItemSelectionPageRequired")
                .append(",tbltender.multiLevelEvaluationReq,tbltender.isTwoStageEvaluation,tbltender.isTwoStageOpening, tbltender.envelopeType,tbltender.assignUserId,tbltender.autoResultSharing,tbltender.isEvaluationDone ,tbltender.randPass")
                .append(" from  TblTender tbltender ")
                .append(" where tbltender.tenderId=:tenderId ");
        List<Object[]> list = hibernateQueryDao.createNewQuery(query.toString(), var);
        if (list != null && !list.isEmpty()) {
        	hashMap.put("tenderId",tenderId);
            hashMap.put("evaluationMode", list.get(0)[0]);
            hashMap.put("isConsortiumAllowed", list.get(0)[1]);
            hashMap.put("tenderMode", list.get(0)[2]);
            hashMap.put("biddingType", list.get(0)[3]);
            hashMap.put("tenderResult", list.get(0)[4]);
            hashMap.put("tenderNo", list.get(0)[5]);
            hashMap.put("eventTypeId", list.get(0)[7]);
            hashMap.put("documentStartDate", list.get(0)[8]);
            hashMap.put("documentEndDate", list.get(0)[9]);
            hashMap.put("downloadDocument", list.get(0)[10]);
            if(list.get(0)[11] != null){
            	hashMap.put("submissionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,list.get(0)[11].toString()));
            }
            if(list.get(0)[12] != null){
            	hashMap.put("openingDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,list.get(0)[12].toString()));
            }
            hashMap.put("isCertRequired", list.get(0)[13]);
            hashMap.put("isMandatoryDocument", list.get(0)[14]);
            hashMap.put("isOpeningByCommittee",list.get(0)[15]);
            hashMap.put("isRebateForm",list.get(0)[16]);
            hashMap.put("tenderBrief",list.get(0)[17]);
            hashMap.put("endDateOfsubmission", list.get(0)[11]);
            hashMap.put("decimalValueUpto", list.get(0)[19]);
            if(((Integer)list.get(0)[18]) > 0){
                hashMap.put("isCorrigendumPublished",1);
            }
            hashMap.put("brdMode", list.get(0)[20]);
            hashMap.put("isEvaluationByCommittee", list.get(0)[22]);
            hashMap.put("cstatus", list.get(0)[23]);
            hashMap.put("biddingVariant", list.get(0)[24]);
            hashMap.put("isItemwiseWinner", list.get(0)[25]);
            if(list.get(0)[25].equals(1)){
            	hashMap.put("isItemSelectionPageRequired", list.get(0)[38]);
            }
            hashMap.put("isEvaluationRequired", list.get(0)[26]);
            hashMap.put("eventOfficerId", list.get(0)[27]);
            hashMap.put("sorVariation", list.get(0)[28]);
            hashMap.put("isSORApplicable", list.get(0)[29]);
            hashMap.put("submissionMode", list.get(0)[30]);
            hashMap.put("isWorkflowRequired", list.get(0)[31]);
            hashMap.put("isEncodedName", list.get(0)[32]);
            hashMap.put("docFeePaymentMode", list.get(0)[33]);
            hashMap.put("emdPaymentMode", list.get(0)[34]);
            hashMap.put("isBidWithdrawal", list.get(0)[35]);
            hashMap.put("isPartialFillingAllowed", list.get(0)[36]);
            hashMap.put("isEMDApplicable", list.get(0)[37]);
            hashMap.put("multiLevelEvaluationReq", list.get(0)[39]);
            hashMap.put("isTwoStageEvaluation", list.get(0)[40]);
            hashMap.put("isTwoStageOpening", list.get(0)[41]);
            hashMap.put("envelopeType", list.get(0)[42]);
            hashMap.put("assignUserId", ((Object[])list.get(0))[43]);
            hashMap.put("autoResultSharing", ((Object[])list.get(0))[44]);
            hashMap.put("isEvaluationDone", list.get(0)[45]);
            
            hashMap.put("randPass", list.get(0)[46]);
        }
    }

    @Transactional
    public List<Object[]> getTenderMappedBidderDetails(int tenderId, int mappingType) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select distinct ");
        query.append(" tbltenderbiddermap.mapBidderId,tbluserlogin.userId, tblbidder.companyName, tbluserlogin.loginid ");
        query.append(" , tblbidder.phoneno ,tblbidder.tblCountry.countryName,tblbidder.tblState.stateName , tblbidder.bidderId ");
        query.append(" from  TblTenderBidderMap tbltenderbiddermap ").append(" inner join tbltenderbiddermap.tblUserLogin tbluserlogin ")
              .append(" inner join tbluserlogin.tblBidder tblbidder ");
        query.append(" where tbltenderbiddermap.tblTender.tenderId=:tenderId ");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }

    /**
     *
     * @param tenderId
     * @param companyId
     * @return
     * @throws Exception
     */
    @Transactional
    public boolean isFinalBidSubmision(int tenderId, int companyId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);
        count = hibernateQueryDao.countForNewQuery("TblFinalsubmission tblfinalsubmission ", "tblfinalsubmission.finalsubmissionid ", "tblfinalsubmission.tblCompany.companyid=:companyId and tblfinalsubmission.tblTender.tenderId=:tenderId", var);
        return count != 0;
    }
    
    @Transactional
    public boolean isBidderFilledBid(int tenderId, int companyId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);
        count = hibernateQueryDao.countForNewQuery("TblTenderBid tblTenderBid ", "tblTenderBid.bidid ", "tblTenderBid.tblCompany.companyid=:companyId and tblTenderBid.tblTender.tenderId=:tenderId", var);
        return count != 0;
    }
    @Transactional
    public boolean isBidderFilledAsDraftBid(int tenderId, int companyId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);
        count = hibernateQueryDao.countForNewQuery("TblTenderBid tblTenderBid ", "tblTenderBid.bidid ", "tblTenderBid.tblCompany.companyid=:companyId and tblTenderBid.tblTender.tenderId=:tenderId and tblTenderBid.cstatus=1 and tblTenderBid.tblTenderform.cstatus=1", var);
        return count != 0;
    }

    /**
     *
     * @param tenderId
     * @return
     * @throws Exception
     */
    @Transactional
    public List<Object> isSubmissionDateLapsed(int tenderId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        
        query.append("SELECT CASE WHEN case when tbltender.isAuction=1 then tbltender.auctionEndDate when tbltender.isAuction=0 then tbltender.submissionEndDate end < UTC_TIMESTAMP() THEN true ELSE false END");
        query.append(" FROM TblTender tbltender WHERE tbltender.tenderId=:tenderId ");

        return hibernateQueryDao.singleColQuery(query.toString(), var);

    }
    @Transactional
    public List<Object> isSubmissionDateLapsed(int tenderId,int isAuction) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        if(isAuction == 0)
        {
        query.append("SELECT CASE WHEN tbltender.submissionEndDate < UTC_TIMESTAMP() THEN true ELSE false END");
        }
        else
        {
          query.append("SELECT CASE WHEN tbltender.auctionEndDate < UTC_TIMESTAMP() THEN true ELSE false END");  
        }
        query.append(" FROM TblTender tbltender WHERE tbltender.tenderId=:tenderId ");

        return hibernateQueryDao.singleColQuery(query.toString(), var);

    }
    @Transactional
    public List<Object> checkAuctionIsStop(int tenderId)throws Exception
    {
        StringBuilder query=new StringBuilder();
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId",tenderId);
        query.append("select case when tbltender.isAuctionStop = 0 then true else  false end from TblTender tbltender where tbltender.tenderId=:tenderId");
        
        return hibernateQueryDao.singleColQuery(query.toString(), var);
    }
    /**
     *
     * @param tenderId
     * @param companyId
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    @Transactional
    public List<Object[]> getTenderBidDtls(int tenderId, int companyId, boolean isFinalSubmission) throws Exception {
        List<Object[]> list = null;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);

        query.append("select ");
        if (!isFinalSubmission) {
            query.append(" bidid,tblTenderenvelope.envelopeId,");
        } else {
            query.append("COUNT(tblTenderform.formId),");
        }
        query.append(" tblTenderform.formId ");
        if (!isFinalSubmission) {
            query.append(" ,cstatus ");
        }
        query.append(" from TblTenderBid where tblTender.tenderId=:tenderId and tblCompany.companyid=:companyId ");
        if (isFinalSubmission) {
            query.append(" group by tblTenderform.formId");
        }
        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        return list;

    }

    
    /**
     * 
     * @param fromId
     * @param tableId
     * @param rowId
     * @return List<Object[]>
     * @throws Exception
     */
    public List<Object[]> getItemNameWithFormNameAndTableName(int fromId, int tableId,int rowId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("fromId", fromId);
        var.put("tableId", tableId);
        var.put("rowId", rowId);
        query.append("select tbltenderform.formName,tblTenderTable.tableName,tbltendercell.cellValue  from TblTenderForm tbltenderform")
                .append(" inner join tbltenderform.tblTenderTable tblTenderTable")
                .append(" inner join tblTenderTable.tblTenderColumn tbltendercolumn with tbltendercolumn.tblColumnType.columnTypeId=1")
                .append(" inner join tbltendercolumn.tblTenderCell tbltendercell  with tbltendercell.rowId=:rowId")
                .append(" where tbltenderform.formId=:fromId and tblTenderTable.tableId=:tableId");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    
   
    
    public List<Object[]> getTenderBidderMandatoryDocs(List<Integer> mandatoryDocId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("mandatoryDocId", mandatoryDocId);
        query.append("select tblbidderdocument.description,tblbidderdocument.bidderDocId,tblbidderdocmapping.documentId,tbltenderbid.bidId");
        query.append(" from TblTenderBid tbltenderbid,TblBidderDocMapping tblbidderdocmapping ");
        query.append(" inner join tblbidderdocmapping.tblBidderDocument tblbidderdocument ");
        query.append(" where  tbltenderbid.bidId=tblbidderdocmapping.objectId  and tblbidderdocmapping.documentId in (:mandatoryDocId)");
        query.append(" order by tblbidderdocmapping.documentId");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }

    public int isConsortiumByTenderId(int tenderId) throws Exception {
        String query = new String();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query = "select isConsortiumAllowed from TblTender where tenderId=:tenderId";
        List<Object> list = hibernateQueryDao.singleColQuery(query.toString(), var);
        int result = (list != null && !list.isEmpty()) ? Integer.parseInt(list.get(0).toString()) : 0;
        return result;
    }

    /**
     *
     * @param tenderId
     * @return
     * @throws Exception
     */
    @Transactional
    public Object[] getTenderPrebidDetailByTenderId(int tenderId) throws Exception {
        List<Object[]> list = null;
        Object[] preBidDtl = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        list = hibernateQueryDao.createNewQuery("select tbltender.isPreBidMeeting, tbltender.preBidMode, tbltender.preBidStartDate, tbltender.preBidEndDate, tbltender.preBidAddress, tbltender.submissionEndDate,tbltender.cstatus from TblTender tbltender where tbltender.tenderId=:tenderId", var);
        if(list!=null && !list.isEmpty()) {
        	preBidDtl=list.get(0);
        }
        return preBidDtl;
    }

    /**
     *
     * @param tenderId
     * @return
     * @throws Exception
     */
    public boolean isTenderPublicKeyMapped(int tenderId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);

        count = hibernateQueryDao.countForNewQuery("TblTenderPublicKey tbltenderpublickey ", "tbltenderpublickey.tenderPublicKeyId ", "tbltenderpublickey.tblTender.tenderId=:tenderId", var);
        return count != 0;
    }

    /**
     *
     * @param tenderId
     * @param companyId
     * @return int
     * @throws Exception
     */
    @Transactional
    public int[] getConsortiumPartnerType(int tenderId, int companyId) throws Exception {
        int[] consortFields = null;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);

        query.append("select tblconsortium.consortiumId,tblconsortiumdetail.partnerType  ")
                .append(" from TblConsortium tblconsortium ")
                .append(" inner join tblconsortium.tblConsortiumDetail tblconsortiumdetail ")
                .append(" with tblconsortiumdetail.tblCompany.companyid=:companyId AND tblconsortiumdetail.cstatus=1")
                .append(" where tblconsortium.tblTender.tenderId=:tenderId AND tblconsortium.isActive=1");

        List<Object[]> lstPartnerType = hibernateQueryDao.createNewQuery(query.toString(), var);
        if (!lstPartnerType.isEmpty()) {
        	consortFields = new int[2];
        	consortFields[0] = (Integer) lstPartnerType.get(0)[0];
            consortFields[1] = (Integer) lstPartnerType.get(0)[1];
        }
        return consortFields;
    }

    

    /**
     * get form wise count of mandatory tender documents
     *
     * @param isConsortium
     * @param tenderId
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    public List<Object[]> getMandatoryDocsCounts(boolean isConsortium, int tenderId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);

        query.append("select COUNT(DISTINCT tbldocument.documentId),tbltenderform.formId ")
                .append(" FROM TblDocument tbldocument,TblTenderForm tbltenderform ")
                .append(" WHERE tbltenderform.tblTender.tenderId=:tenderId and tbldocument.tblLink.linkId = 317 AND tbldocument.isMandatory = 1 ")
                .append("AND tbldocument.objectId = tbltenderform.formId AND tbltenderform.cstatus = 1 ");
        if (isConsortium) {
            query.append(" AND tbltenderform.isSecondary = 1");
        }
        query.append(" group by tbltenderform.formId");

        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }

    /**
     * get form wise count of mandatory documents uploaded by company
     *
     * @param tenderId
     * @param companyId
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    public List<Object[]> getManDocsUploadedCount(int tenderId, int companyId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);

        query.append("select COUNT(DISTINCT tblbidderdocmapping.documentId),tbltenderform.formId ")
                .append(" FROM TblDocument tbldocument,TblTenderForm tbltenderform, TblBidderDocMapping tblbidderdocmapping ")
                .append(" INNER JOIN tbltenderform.tblTenderBid TB with TB.tblCompany.companyid =:companyId AND TB.cstatus = 2 ")
                .append(" WHERE tbltenderform.tblTender.tenderId=:tenderId and tbldocument.tblLink.linkId = 317 AND ")
                .append(" tbldocument.isMandatory = 1 AND tbldocument.objectId = tbltenderform.formId AND tbltenderform.cstatus = 1 ")
                .append(" AND  tbldocument.documentId = tblbidderdocmapping.documentId AND TB.bidId = tblbidderdocmapping.objectId ")
                .append(" AND tblbidderdocmapping.tblLink.linkId=237 AND tblbidderdocmapping.cstatus = 1 group by tbltenderform.formId");

        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }

    /**
     *
     * @param tenderId
     * @return
     * @throws Exception
     */
    @Transactional
    public boolean isTenderFormDocsMandatory(int tenderId) throws Exception {

        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        count = hibernateQueryDao.countForNewQuery("TblTenderForm tbltenderform ", "tbltenderform.formId ", "tbltenderform.tblTender.tenderId=:tenderId and tbltenderform.isDocumentReq=1", var);
        return count != 0;
    }
    public TblCompany getTblCompany(int companyId) throws Exception {
        List<TblCompany> list = null;
        list = commonDAO.findEntity(TblCompany.class, "companyid", Operation_enum.EQ, companyId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    /**
     *
     * @param envelopeId
     * @return
     * @throws Exception
     */
    public TblTenderEnvelope getTenderEnvelopeById(int envelopeId) throws Exception {
        List<TblTenderEnvelope> list = null;
        list = commonDAO.findEntity(TblTenderEnvelope.class, "envelopeId", Operation_enum.EQ, envelopeId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;

    }
    public TblEventType getTblEventTypeById(int eventTypeId) throws Exception {
        List<TblEventType> list = null;
        list = commonDAO.findEntity(TblEventType.class, "eventTypeId", Operation_enum.EQ, eventTypeId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;

    }

    public TblRebate getTblRebateById(int tenderId) throws Exception {
        List<TblRebate> list = null;
        list = commonDAO.findEntity(TblRebate.class, "tblTender.tenderId", Operation_enum.EQ, tenderId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;

    }

    public TblFinalsubmission getTblFinalsubmissionById(int tenderId,int companyId) throws Exception {
        List<TblFinalsubmission> list = null;
        list = commonDAO.findEntity(TblFinalsubmission.class, "tblTender.tenderId", Operation_enum.EQ, tenderId,"tblCompany.companyid", Operation_enum.EQ,companyId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;

    }
    
    public TblBidder getTblBidderId(long userId) throws Exception {
        List<TblBidder> list = null;
        list = commonDAO.findEntity(TblBidder.class, "tblUserlogin.userId", Operation_enum.EQ, userId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    @Transactional
    public TblCompany getTblCompanyId(int companyId) throws Exception {
        List<TblCompany> list = null;
        list = commonDAO.findEntity(TblCompany.class, "companyid", Operation_enum.EQ, companyId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    
    public List<TblBidderdocument> getTblBidderdocument(int tenderId,int bidderId,int objectId) throws Exception {
        return  commonDAO.findEntity(TblBidderdocument.class,"tenderId", Operation_enum.EQ, tenderId,"bidderId", Operation_enum.EQ, bidderId,"objectId", Operation_enum.EQ, objectId);
    }
    public List<TblBidderdocument> getTblBidderdocument(int tenderId,int objectId) throws Exception {
        return  commonDAO.findEntity(TblBidderdocument.class,"tenderId", Operation_enum.EQ, tenderId,"objectId", Operation_enum.EQ, objectId);
    }
    public List<TblTenderDocument> getTblTenderDocument(int tenderId) throws Exception {
        return  commonDAO.findEntity(TblTenderDocument.class,"tblTender.tenderId", Operation_enum.EQ, tenderId,"isMandatory", Operation_enum.EQ,1);
    }
    
    /**
     * Method user for get TblTender object for given tenderId
     *
     * @param tenderId
     * @return TblTender object
     * @throws Exception
     */
    public TblTender getTenderById(int tenderId) throws Exception {
        List<TblTender> list = null;
        list = tblTenderDao.findTblTender("tenderId", Operation_enum.EQ, tenderId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;

    }
    public TblShareReport getTblShareReportById(int tenderId) throws Exception {
        List<TblShareReport> list = null;
        list = tblShareReportDao.findTblShareReport("tblTender.tenderId", Operation_enum.EQ, tenderId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    
    public TblTenderForm getTblTenderFormById(int tenderId) throws Exception {
        List<TblTenderForm> list = null;
        list = tblTenderFormDao.findTblTenderForm("tblTender.tenderId", Operation_enum.EQ, tenderId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;

    }
    public List<TblTenderForm> getTblTenderFormByEnvlopeId(int envelopeId) throws Exception {
        List<TblTenderForm> list = null;
        list = tblTenderFormDao.findTblTenderForm("tblTenderEnvelope.envelopeId", Operation_enum.EQ, envelopeId,"cstatus", Operation_enum.EQ,1,"isMandatory",Operation_enum.EQ,1);
        return list;

    }
    
    /**
     * 
     * @param tableId
     * @return {@code  List<Object[]>}
     * @throws Exception 
     */
    public List<Object[]> getItemBidderMapDtls(int tableId,boolean isSearch) throws Exception{
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tableId", tableId);
        
        if(isSearch){
            query.append("select tbltendercell.rowId,tbltendercell.cellValue from TblTenderTable tbltendertable ")
                    .append(" inner join tbltendertable.tblTenderColumn tbltendercolumn ")
                    .append(" inner join tbltendercolumn.tblTenderCell tbltendercell ")
                    .append(" where tbltendertable.tableId=:tableId and tbltendercolumn.tblColumnType.columnTypeId=1 ")
                    .append(" and (case when tbltendertable.hasGTRow = 1 then (tbltendertable.noOfRows-1) else tbltendertable.noOfRows end) >= tbltendercell.rowId ")
                    .append(" order by tbltendercell.rowId ");
        }else{
            query.append("select tblitembiddermap.mapBidderItemId,tbltenderbiddermap.mapBidderId,tbltenderbiddermap.tblUserLogin.userId,tblitembiddermap.rowId,tbltendercell.cellValue ")
                    .append(" from TblItemBidderMap tblitembiddermap ")
                    .append(" inner join tblitembiddermap.tblTenderBidderMap tbltenderbiddermap ")
                    .append(" inner join tblitembiddermap.tblTenderTable tbltendertable ")
                    .append(" inner join tbltendertable.tblTenderColumn tbltendercolumn ")
                    .append(" inner join tbltendercolumn.tblTenderCell tbltendercell ")
                    .append(" where tblitembiddermap.tblTenderTable.tableId=:tableId ")
                    .append(" and tbltendercolumn.tblColumnType.columnTypeId=1 and tbltendercell.rowId=tblitembiddermap.rowId ")
                    .append(" and (case when tbltendertable.hasGTRow = 1 then (tbltendertable.noOfRows-1) else tbltendertable.noOfRows end) >= tbltendercell.rowId ")
                    .append(" order by tbltenderbiddermap.tblUserLogin.userId,tblitembiddermap.rowId");
        }
        
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    
    
   
    
    public int isEventFuture(int tenderId) throws Exception{
        int isEventFuture = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select case when getutcdate() < submissionStartDate then 1 else 0 end  from TblTender where tenderId=:tenderId and cstatus=1");
        List<Object> lstObject = hibernateQueryDao.getSingleColQuery(query.toString(), var);
        if(!lstObject.isEmpty()){
            isEventFuture = (Integer) lstObject.get(0);
        }
        return isEventFuture;
    }
    
    @Transactional
    public boolean isEventLive(int tenderId) throws Exception{
        int isEventFuture = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select case when getutcdate() > submissionStartDate then 1 else 0 end  from TblTender where tenderId=:tenderId and cstatus=1");
        List<Object> lstObject = hibernateQueryDao.getSingleColQuery(query.toString(), var);
        if(!lstObject.isEmpty()){
            isEventFuture = (Integer) lstObject.get(0);
        }
        return isEventFuture!=0;
    }
    @Transactional
    public int isEventLiveBidder(int tenderId) throws Exception{
        int isLive = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        
        query.append("select case when  UTC_TIMESTAMP() >= submissionStartDate then ")
                .append("   case when UTC_TIMESTAMP() < submissionEndDate then 1 else -1 end else 0 end ")
            .append(" from TblTender where tenderId=:tenderId and cstatus=1");
        
        List<Object> lstObject = hibernateQueryDao.getSingleColQuery(query.toString(), var);
        if(!lstObject.isEmpty()){
            isLive = (Integer) lstObject.get(0);
        }
        return isLive;
    }
    /**
     * @param tenderId
     * @return int
     * @throws Exception
     */
    public int getLeadPartnerBidderId(int tenderId) throws Exception {
        int bidderId = 0;
        List<Object> list = null;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        
        query.append("select tblconsortiumdetail.tblUserLogin.userId  ")
                .append(" from TblConsortium tblconsortium ")
                .append(" inner join tblconsortium.tblConsortiumDetail tblconsortiumdetail with tblconsortiumdetail.partnerType <> 3 ")
                .append(" where tblconsortium.tblTender.tenderId=:tenderId and tblconsortium.isActive=1 ");
        
        list = hibernateQueryDao.getSingleColQuery(query.toString(), var);
        
        if(!list.isEmpty()){
            bidderId = (Integer) list.get(0);
        }
        return bidderId;

    }
    
    /**
     * @param tenderId
     * @return
     * @throws Exception
     */
    public List<Object[]> getTenderPaymentAmount(int tenderId,int payFor,int isGivenByBidder,int companyId,int rowId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        if(isGivenByBidder == 0){
        	query.append("select ");
        	if(payFor == 1){
        		query.append("documentFee,0 ");
        	}else if(payFor == 2){
        		query.append("emdAmount,0 ");
        	}else{
        		query.append("registrationCharges,0");
        	}
        	query.append(" from TblTender where tenderId=:tenderId");
        }else{
        	query.append("SELECT tbleventfees.eventFee,tbleventfees.uniqueId FROM TblEventFees tbleventfees,TblTender tbltender");
        	query.append(" INNER JOIN tbltender.tblTenderForm tbltenderform with tbltenderform.cstatus = 1");
        	query.append(" INNER JOIN tbltenderform .tblTenderColumn tbltendercolumn WITH tbltendercolumn.tblColumnType.columnTypeId = :columnTypeId");
        	query.append(" INNER JOIN tbltenderform.tblTenderBid tbltenderbid ");
        	query.append(" WHERE tbleventfees.feeType = :feeType AND tbleventfees.tblCompany.companyid = :companyId");
        	query.append(" AND tbltenderbid.bidId = tbleventfees.bidId ");
        	query.append(" AND tbltender.tenderId = :tenderId and tbleventfees.cstatus = 0 and isActive = 1 ");
        	if(rowId!=0){
        		var.put("rowId", rowId);
        		query.append(" AND  tbleventfees.rowId = :rowId  ");
        	}
        	if(payFor == 1){
        		var.put("columnTypeId", isGivenByBidder==1?9:31);
        		var.put("feeType", 2);
        	}else if (payFor == 2){
        		var.put("columnTypeId", isGivenByBidder==1?10:18);
        		var.put("feeType", 3);
        	}else {
        		var.put("columnTypeId", 32);
        		var.put("feeType", 8);
        	}
        	var.put("companyId", companyId);
        }
        List<Object[]> list = hibernateQueryDao.createNewQuery(query.toString(), var);
        return list;
    }
    
    
    
    public HttpServletRequest getServletRequest() {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attr.getRequest();
    }
    
    
    
    
    /**
     * @param formId
     * @return boolean
     * @throws Exception
     * used to get count of result sharing done or not
     */
    @Transactional
    public boolean isResultShareDone(int tenderId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        int count=0;
        List<Object> list = hibernateQueryDao.getSingleColQuery("select COUNT(shareReportId) from TblShareReport tblsharereport where tblsharereport.tblTender.tenderId=:tenderId AND tblsharereport.isActive=1",var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count>0;
    }
    
    
    public BigDecimal getTenderEstimatedValue(int tenderId){
    	BigDecimal estimatedValue=BigDecimal.ZERO;
    	Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("tenderId", tenderId);
        StringBuilder strQuery=new StringBuilder("Select prevEstimatedValue from TblTender  where tenderId=:tenderId");
        List<Object> lst = hibernateQueryDao.singleColQuery(strQuery.toString(), parameters);
        if (lst != null && !lst.isEmpty()) {
        	estimatedValue = new BigDecimal(lst.get(0).toString()); //BigDecimal.valueOf(Double.parseDouble(lst.get(0).toString()));
        }
    	return estimatedValue;
    }
    @Transactional
     public int isSecondaryPartner(int tenderId,int companyId) throws Exception{
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        int count=0;
        StringBuilder query = new StringBuilder();
        query.append(" select count(tblconsortiumdetail.consortiumDetailId)");
        query.append(" from TblConsortiumDetail tblconsortiumdetail");
        query.append(" inner join tblconsortiumdetail.tblConsortium tblconsortium");
        query.append(" where tblconsortium.tblTender.tenderId=:tenderId and tblconsortiumdetail.tblCompany.companyid=:companyId and tblconsortiumdetail.partnerType = 3");
        query.append(" and tblconsortiumdetail.cstatus=1 and tblconsortium.isActive=1");
        list = hibernateQueryDao.getSingleColQuery(query.toString(),var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
    }

     /**
      * 
      * @param tenderId
      * @return
      * @throws Exception
      */
     public boolean isEvaluationCompleteForAllEnv(int tenderId) throws Exception{
    	 boolean isEvaluatedAnyEnvl = false;
         Map<String, Object> var = new HashMap<String, Object>();
         var.put("tenderId",tenderId);
         List<Object> list = hibernateQueryDao.getSingleColQuery("select tblBidderApprovalDetail.tblTenderEnvelope.envelopeId from TblBidderApprovalDetail tblBidderApprovalDetail where tblBidderApprovalDetail.tblTenderEnvelope.tblTender.tenderId=:tenderId and tblBidderApprovalDetail.isApproved=1",var);
         if(list!=null && !list.isEmpty()){
        	 isEvaluatedAnyEnvl = list.size() > 0 ? true : false; 
         }
         return isEvaluatedAnyEnvl;
     }
     
     /**
     *
     * @param tenderId
     * @param searchTxt
     * @return boolean
     * @throws Exception
     */
    public boolean isBiddermappedByTenderId(int tenderId) throws Exception {
        long count = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select COUNT(tbltenderbiddermap.mapBidderId) from TblTenderBidderMap tbltenderbiddermap ");
        query.append(" where tbltenderbiddermap.tblTender.tenderId=:tenderId ");
        List<Object> data = hibernateQueryDao.singleColQuery(query.toString(), var);
        if(data!=null && !data.isEmpty()){
            count = (Long) data.get(0);
        }        
        return count != 0;
    }
    
    /** 
     * @param tenderId
     * @return
     * @throws Exception 
     */
     public List<Object[]> getEnvelopeTypeByTenderId(int tenderId) throws Exception {
        long count = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select tblTenderEnvelope.envelopeId,tblTenderEnvelope.envelopeName,tblEnvelope.envId from TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId=:tenderId");
        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
        return data;
    }
     /**
     * @param committeeId
     * @return
     * @throws Exception
     */
    public boolean consentGivenOrNot(int committeeId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeId", committeeId);
        count = hibernateQueryDao.countForNewQuery("TblCommitteeUser tblCommitteeUser", "tblCommitteeUser.committeeUserId", "tblCommitteeUser.tblCommittee.committeeId=:committeeId AND tblCommitteeUser.isApproved=1", var);
        return count != 0;
    }
    /**
     * @param tenderId
     * @param commiteeType
     * @return
     * @throws Exception
     */
    public int getActiveCommittee(int tenderId, int committeeType) throws Exception {
    	int committeeId = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("committeeType", committeeType);
        List<Object> list = hibernateQueryDao.getSingleColQuery("SELECT committeeId FROM TblCommittee tblCommittee WHERE tblCommittee.tblTender.tenderId=:tenderId AND tblCommittee.committeeType=:committeeType AND tblCommittee.isActive=1", var);
        if(list!=null && !list.isEmpty()){
        	committeeId = Integer.parseInt(list.get(0).toString());
        }
        return committeeId;
    }
    
    /**
     * This method returns flag whether bidder has accepted terms and condition for particular tender 
     * @param tenderId
     * @param companyId
     * @return
     */
    public boolean isBidderAcceptTermsCondition(int tenderId,int companyId){
    	int count=0;
    	boolean flag=false;
    	Map<String,Object> var = new HashMap<String,Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);
    	StringBuffer selectHQL=new StringBuffer("select COUNT(bidConfirmationId) from TblTenderBidConfirmation where tenderId=:tenderId and companyId=:companyId");
    	List<Object> list=hibernateQueryDao.singleColQuery(selectHQL.toString(), var);
    	if(!list.isEmpty()){
    		count=Integer.parseInt(list.get(0).toString());
    	}
    	if(count>0){
    		flag=true;
    	}
    	return flag;
    }

	
	/**
	 * get bidder detail 
	 * @param tenderId
	 * @param tenderMode
	 * @return
	 */
	public List<Object[]> getTenderBidderDetail(int tenderId,int tenderMode) {
		StringBuilder query = new StringBuilder();
	    Map<String, Object> var = new HashMap<String, Object>();
	    var.put("tenderId", tenderId);
	    if(tenderMode == 2 || tenderMode == 3 ){ // Limited and single
	    	query.append(" select tbltenderbidderMap.tblUserLogin.userId,tbltenderbidderMap.tblCompany.companyid,tbltenderbidderMap.tblUserDetail.userDetailId from TblTenderBidderMap tbltenderbidderMap where tbltenderbidderMap.tblTender.tenderId=:tenderId ");
	    }else if(tenderMode == 1){ // Open
	    	query.append(" select tbltenderbidconfirmation.tblUserLogin.userId,tbltenderbidconfirmation.tblCompany.companyid,tbltenderbidconfirmation.tblUserDetail.userDetailId ");
			query.append(" from TblTenderBidConfirmation tbltenderbidconfirmation where tbltenderbidconfirmation.tblTender.tenderId=:tenderId ");
	    }
	    List<Object[]> res = null;
	    if(query != null && query.length() > 0){
	    	res = hibernateQueryDao.createNewQuery(query.toString(), var);
	    }
	    return res;
	}
    
    /**This method is used to give domain name by passing tenderId
     * @return
     */
  	public List<Object[]> getDomainNamebyTenderId(int tenderId) {
  		 List<Object[]> list = null;
  		 StringBuilder query = new StringBuilder();
  	      Map<String, Object> var = new HashMap<String, Object>();
  	      var.put("tenderId", tenderId);
  	      query.append("select tblclient.clientId , tblclient.domainName from TblTender tbltender  ");
  	      query.append("inner join tbltender.tblDepartment tbldepartment ");
  	      query.append("inner join tbldepartment.tblClient tblclient ");
  	      query.append("where tbltender.tenderId =:tenderId ");
  	      list = hibernateQueryDao.createNewQuery(query.toString(), var);
  	  return list;
  	}
  	
  	 /**
     * @param tenderId
     * @return 
     * @throws Exception
     */
    public List<Object[]> getConsortiumPartnerDetail(int tenderId) throws Exception {        
        List<Object[]> list = null;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);        
        query.append("select tblconsortiumdetail.tblUserLogin.userId ,tblconsortiumdetail.tblCompany.companyName,tblconsortiumdetail.tblUserLogin.loginId")
                .append(" from TblConsortium tblconsortium ")
                .append(" inner join tblconsortium.tblConsortiumDetail tblconsortiumdetail with tblconsortiumdetail.partnerType <> 0 ")
                .append(" where tblconsortium.tblTender.tenderId=:tenderId and tblconsortium.isActive=1 ");        
        list = hibernateQueryDao.createNewQuery(query.toString(), var);    
        return list;

    }
    
    public boolean isPriceBidOpen(int tenderId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select tblTenderEnvelope.envelopeId,tblTenderEnvelope.isOpened from TblTenderEnvelope tblTenderEnvelope ");
        query.append(" where tblTenderEnvelope.tblEnvelope.envId in (4,5) and tblTenderEnvelope.tblTender.isOpeningByCommittee = 1 and tblTenderEnvelope.tblTender.tenderId = :tenderId ");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        boolean flag = true;
        if(lst.size() > 0 && lst.get(0)[1] != null && (Integer)lst.get(0)[1] != 1){
        	flag = false;
        }
        return flag;
    }

    /**
     * Get opening committeId
     * @param tenderId
     * @return
     */
    public int getOpeningCommittee(int tenderId,int commiteeType){
    	int committeeId = 0;
    	Map<String,Object> var = new HashMap<String,Object>();
        var.put("tenderId", tenderId);
        var.put("commiteeType", commiteeType);
    	StringBuffer selectHQL=new StringBuffer("select committeeId from TblCommittee tblCommittee where tblCommittee.tblTender.tenderId=:tenderId and tblCommittee.isActive = 1 and tblCommittee.isApproved = 1 and tblCommittee.committeeType =:commiteeType");
    	List<Object> list=hibernateQueryDao.singleColQuery(selectHQL.toString(), var);
    	if(!list.isEmpty()){
    		committeeId=Integer.parseInt(list.get(0).toString());
    	}
    	return committeeId;
    }
    @Transactional
	public List<Object[]> getTenderFormAndTableByTenderId(int tenderId, int bidderId, int isPriceBidCondition) {
		 StringBuilder query = new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        var.put("tenderId", tenderId);
	        if(bidderId != 0){
	        	var.put("bidderId", bidderId);
	        }
			 query.append("select tblTenderForm.formId,tblTenderForm.formHeader,tblTenderForm.formFooter,tblTenderForm.formName,tblTenderTable.tableId,tblTenderTable.tableName,tblTenderForm.isPriceBid from TblItemSelection tblItemSelection");  
			  query.append(" inner join tblItemSelection.tblTenderForm tblTenderForm");  
			  query.append(" inner join tblItemSelection.tblTenderTable tblTenderTable"); 
			  query.append(" where  tblTenderForm.tblTender.tenderId=:tenderId");
			  if(bidderId != 0){
				  query.append(" and tblItemSelection.bidderId=:bidderId");
			  }
			  if(isPriceBidCondition != 0)
				  query.append(" and tblTenderForm.isPriceBid=1");
			  query.append(" and tblTenderForm.tblTenderEnvelope.tblEnvelope.envId in (4,5) and tblItemSelection.isBidded = 1 and tblTenderForm.cstatus = 1");
			  query.append(" group by tblTenderForm.formId,tblTenderForm.formHeader,tblTenderForm.formFooter,tblTenderForm.formName,tblTenderTable.tableId,tblTenderTable.tableName,tblTenderForm.isPriceBid");
			 
			 
			 return hibernateQueryDao.createNewQuery(query.toString(), var);
		
	}
	@Transactional
	public List<Object[]> getColumnDetailsFromTableId(List<Integer> tblIds) {
		 StringBuilder query = new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        
	        query.append("select tblTenderColumn.columnId,tblTenderTable.tableId,tblTenderForm.formId,tblTenderColumn.columnHeader,tblTenderColumn.tblColumnType.columnTypeId from TblTenderColumn tblTenderColumn ");
	        query.append("inner join tblTenderColumn.tblTenderTable tblTenderTable ");
	        query.append("inner join tblTenderColumn.tblTenderForm tblTenderForm ");
	        query.append("where tblTenderColumn.filledBy=1");
	        if(tblIds.size() > 0){
	        	var.put("tblIds", tblIds);
	        	query.append(" and tblTenderTable.tableId IN (:tblIds)");	
	        }
	        return hibernateQueryDao.createNewQuery(query.toString(), var);
	}
	@Transactional
	public List<Object[]> getCellDetailsFromColumnId(List<Integer> clmIds) {
		StringBuilder query = new StringBuilder();
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("clmIds", clmIds);
        query.append("select tblTenderCell.cellId,tblTenderCell.rowId,tblTenderCell.cellValue,tblTenderColumn.columnId,tblTenderTable.tableId,tblTenderColumn.columnHeader,tblTenderCell.tblTenderForm.formId from TblTenderCell tblTenderCell ");
        query.append("inner join tblTenderCell.tblTenderColumn tblTenderColumn ");
        query.append("inner join tblTenderColumn.tblTenderTable tblTenderTable ");
        query.append("where  tblTenderColumn.columnId in (:clmIds)"); 
        query.append(" order by tblTenderCell.rowId");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
	} 

	/*
     * @param companyId
     * @param clientId
     * @return 
     * @throws Exception
	 */
	@Transactional
	public List<Object[]> getFinalSubmissionReceipt(int companyId) {		
		StringBuilder query = new StringBuilder();
		Map<String, Object> var = new HashMap<String, Object>();
		List<Object[]> list = null;       
		var.put("companyId", companyId);
      	query.append("select tbluserlogin.loginId,tblcompany.companyName, tbluserlogin.mobileNo, tblcompany.address")
		.append(" ,tblcompany.city,tblcompany.phoneNo,tbluserlogin.userId ");		
		 query.append(" from TblCompany tblcompany ")
		 .append("inner join tblcompany.tblBidderStatus tblbidderstatus " )
		 .append("inner join tblbidderstatus.tblUserLogin tbluserlogin ")
		 .append("inner join tblcompany.tblCountry tblcountry ")
		 .append("where tblcompany.companyid=:companyId");		 
		 list = hibernateQueryDao.createNewQuery(query.toString(), var);	
		 return list;		
	}	
	/*
     * @param tenderId
     * @param companyId
     * @return 
     * @throws Exception
	 */
	@Transactional
	public Object getConsortiumDetail(int tenderId,int companyId) throws Exception {
		StringBuilder query = new StringBuilder();
		Object companyName = null;
		Map<String, Object> var = new HashMap<String, Object>();
		List<Object[]> list = null; 
		var.put("tenderId", tenderId);	
		var.put("companyId", companyId);
		query.append("select tblcompany.companyName from TblConsortiumDetail tblConsortiumDetail")
		.append(" inner join tblConsortiumDetail.tblConsortium tblconsortium")
		.append(" inner join tblConsortiumDetail.tblCompany tblcompany where tblConsortiumDetail.tblConsortium.consortiumId in ") 
		.append(" (select  tblconsortium.consortiumId from TblConsortium tblconsortium")  
		.append(" inner join tblconsortium.tblConsortiumDetail tblconsortiumdetail ")
		.append(" where tblconsortium.tblTender.tenderId=:tenderId and tblconsortium.isActive=1 and tblconsortiumdetail.tblCompany.companyid=:companyId) and tblConsortiumDetail.partnerType=2");  
		list = hibernateQueryDao.createNewQuery(query.toString(), var);	
		 if (list != null && !list.isEmpty()) {
			 companyName =   list.get(0);
	     }	
		 return companyName;	
	}
	/**
	 * @param tenderId
	 * @return
	 * @throws Exception
	 */
	public boolean isL1H1Generated(int tenderId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        count = hibernateQueryDao.countForNewQuery("TblDynReportCell tblDynReportCell ", "tblDynReportCell.cellId ", "tblDynReportCell.tblDynReport.tblTender.tenderId=:tenderId", var);
        return count != 0;
    }
	
	
	/**
	 * @param objectId
	 * @return
	 */
	public boolean isCorrgendumPrepare(int objectId){
		boolean flag=false;
		StringBuilder query = new StringBuilder();
		Map<String, Object> var = new HashMap<String, Object>();
		List<Object[]> list = null; 
		var.put("objectId", objectId);	
		query.append("select tblCorrigendum.corrigendumId from TblCorrigendum tblCorrigendum");
		query.append(" where tblCorrigendum.cstatus in (0,3) and tblCorrigendum.objectId=:objectId");
		list = hibernateQueryDao.createNewQuery(query.toString(), var);	
		 if (list != null && !list.isEmpty()) {
			 flag=true;
	     }	
		 return flag;
	}
	
	 @Transactional	
	 public String getDeptNameByTenderId(int tenderId) throws Exception{
	        StringBuilder data=new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        var.put("tenderId",tenderId);
	        List<Object[]> list  = hibernateQueryDao.createSQLQuery("select tbldepartment.deptName,(select a.deptName from tbl_department a where a.deptId=tbldepartment.parentDeptId),(select a.deptName from tbl_department a where a.deptId=tbldepartment.grandParentDeptId) from tbl_department tbldepartment where tbldepartment.deptId in (select departmentId from tbl_tender where tenderId=:tenderId)", var);
	        if(!list.isEmpty()){
	        	 String deptName = list.get(0)[0] == null ? "" : list.get(0)[0].toString();
	        	 String parentDeptName = list.get(0)[1] == null ? "" : list.get(0)[1].toString()+"/";
	        	 String grandDeptName = list.get(0)[2] == null ? "" : list.get(0)[2].toString()+"/";
	        	 data.append(grandDeptName).append(parentDeptName).append(deptName);
	        }
	        return data.toString();
	    }
	 
	 public List<Object[]> getTenderColumnType(int tenderId){
    	 Map<String, Object> var = new HashMap<String, Object>();
         var.put("tenderId",tenderId);
         StringBuilder query = new StringBuilder();
         query.append(" select columnTypeId,t.tenderId from apptender.tbl_tender t  ")
         .append(" inner join apptender.tbl_tenderform tf on t.tenderId = tf.tenderId ")
         .append(" inner join apptender.tbl_TenderColumn tc on tf.formId = tc.formId ")
         .append(" where t.tenderId=:tenderId and tf.cstatus = 1 ");
         return hibernateQueryDao.createSQLQuery(query.toString(), var);
	 }
	 /**
	     * get Rest of auction money payment details
	     * @param objectId
	     * @param paymentFor
	     * @return
	     * @throws Exception
	     */
	    public List<Object[]> getRestOfTenderDetails(int objectId,int companyId,int moduleId,int transactionTypeId,int paymentTypeId,List<Integer> rowId) throws Exception{
	   	 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("objectId",objectId);
	     var.put("moduleId",moduleId);
	     var.put("transactionTypeId", transactionTypeId);
	     var.put("feeType", 3);
	     boolean isItemwise= (getIsItemWise( objectId, moduleId)==2);
	     StringBuilder query = new StringBuilder();
	     query.append(" select TB.companyId as c0,UD.companyName as c1,(CAST(EF.eventFee as decimal)) as c2,payment.paymentId as c3,(CAST(TBD.cellValue as decimal)) as c4,0 as c5,(CAST(TBD.cellValue as decimal))-(CAST(EF.eventFee as decimal)) as c6,emdTransactionDetail.amount as c7,0 as c8,0 as c9, 0 as c10, 0 as c11,D.[1] as c12, TCL.rowId as c13 ")
	    .append(" from apptender.tbl_TenderGovColumn TGC    ")
	    .append(" INNER JOIN apptender.tbl_tenderform TF ON TGC.formId=TF.formId and TF.cstatus=1 and TGC.tenderId=:objectId ")
	    .append(" INNER JOIN apptender.tbl_TenderColumn TC ON TGC.columnId=TC.columnId and TF.formId=TC.formId and TGC.tableId=TC.tableId  ")
	    .append(" INNER JOIN apptender.tbl_tendercell TCL ON TCL.columnId=TC.columnId and TCL.formId=TC.formId and TCL.tableId=TC.tableId ") 
	    .append(" INNER JOIN apptenderbid.tbl_tenderbid TB ON TB.cstatus = 2 and TB.formId=TC.formId ")  
	    .append(" INNER JOIN apptenderbid.tbl_tenderbidmatrix TBM ON TBM.bidId=TB.bidId   ")
	    .append(" INNER JOIN apptenderresult.tbl_tenderbiddetail TBD ON TBD.bidTableId=TBM.bidTableId and TBD.cellId=TCL.cellId ")   
	    .append(" INNER JOIN apptenderbid.tbl_finalsubmission FS ON FS.tenderId = TB.tenderId AND TB.companyId = FS.companyId AND FS.partnerType IN (0, 1, 2) ")  
	    .append(" INNER JOIN appuser.tbl_UserDetail UD ON UD.userDetailId=FS.userDetailId ")
	    .append(" INNER JOIN  appuser.tbl_EmdTransactionDetail emdTransactionDetail on emdTransactionDetail.objectId = TGC.tenderId and emdTransactionDetail.cstatus=2 and emdTransactionDetail.companyId= FS.companyId and TCL.rowId=emdTransactionDetail.rowId ");
	    if(rowId!=null){
	    	 var.put("rowId",rowId);
		     query.append(" and emdTransactionDetail.rowId in (:rowId) ");
	    }
	    if(companyId!=0){
	      	 var.put("companyId",companyId);
	      	query.append(" and FS.companyId =:companyId ");
	       }
	    query.append(" inner join appuser.tbl_Payment payment on payment.paymentId=emdTransactionDetail.paymentId and emdTransactionDetail.objectId=payment.objectId ")
	    .append(" INNER JOIN apppayment.tbl_EventFees EF ON  EF.objectId=TGC.tenderId and EF.companyId= FS.companyId and TCL.rowId=EF.rowId and EF.uniqueId=payment.uniqueId ")
	    .append("    LEFT OUTER JOIN (SELECT [formId],[tableId],[rowId],[1],[2]  FROM ( ")
	    .append("   SELECT DISTINCT TCC1.formId, TCC1.tableId, TCC1.rowId, TCC1.cellValue , TC1.columnTypeId   FROM apptender.tbl_TenderGovColumn TGC1 ")   
	    .append("   INNER JOIN  apptender.tbl_tenderform TF1 ON TGC1.formId = TF1.formId and TGC1.tenderId = :objectId ") 
	    .append("   AND TF1.cstatus = 1  INNER JOIN apptender.tbl_tendercell TCC1 ON TCC1.formId=TF1.formId ")  
	    .append("  INNER JOIN apptender.tbl_TenderColumn TC1 on TCC1.columnId = TC1.columnId  ")
	    .append("   WHERE TC1.filledBy = 1 and TC1.columnTypeId in (1,2)) AS A  PIVOT (MAX(cellValue) FOR columnTypeId IN ([1], [2])) AS P ) AS D ON D.formId=TF.formId ") 
	    .append("    and D.tableId=TBM.tableId and TCl.rowId=D.rowId and  emdTransactionDetail.transactionTypeId =:transactionTypeId ")
	    .append("    and EF.isActive=1 and EF.cstatus=1 and EF.feeType=:feeType and payment.moduleId=:moduleId ");
	    if(rowId!=null){
	    	 var.put("rowId",rowId);
		     query.append(" and emdTransactionDetail.rowId in (:rowId) ");
	    }
		
		 query.append("  order by TCl.rowId ");
	   	 int nVarCharColumnIndex [] = {1,9,12};
	      	return hibernateQueryDao.createSQLQuery(query.toString(),var,nVarCharColumnIndex,14);
	}
	 public int getIsItemWise(int objectId,int moduleId) throws Exception{
			int isEMDApplicable=0;
			if(moduleId==3){
	  		List<Object[]> l = getTenderFields(objectId, "isEMDApplicable,isCertRequired");
	  		if(!l.isEmpty()){
	  			Object[] tenderData = l.get(0);
	  			isEMDApplicable = Integer.parseInt(tenderData[0].toString());
	  		}
			}else if(moduleId==5){
				isEMDApplicable=0;
			}
		  return isEMDApplicable;
	  }
	 
	 
	 
	
	/**
     * @param objectId
     * @param companyId
     * @return
     * @throws Exception
     */
    public boolean isRestofEventCongfigured(int objectId,int companyId,int transactionTypeId,int cstatus)throws Exception{
    	 boolean isAccessTab=false;
    	 Map<String, Object> map = new HashMap<String, Object>();
    	 map.put("objectId", objectId);
    	 map.put("transactionTypeId", transactionTypeId);
    	 map.put("cstatus", cstatus);
    	 StringBuilder query = new StringBuilder();
    	 query.append(" select count(emdTransactionId) from TblEMDTransactionDetail tblEMDTransactionDetail INNER JOIN tblEMDTransactionDetail.tblCompany tblCompany INNER JOIN tblEMDTransactionDetail.tblTransactionType tblTransactionType where tblEMDTransactionDetail.objectId=:objectId ");
    	 if(companyId !=0){
    		 map.put("companyId", companyId);
    		 query.append(" and tblCompany.companyid=:companyId ");
    	 }
    	 query.append(" and tblEMDTransactionDetail.cstatus=:cstatus and tblTransactionType.transactionTypeId=:transactionTypeId ");
    	 List<Object> list = hibernateQueryDao.getSingleColQuery(query.toString(),map);
         if(list!=null && !list.isEmpty()){
        	 if(Integer.parseInt(list.get(0).toString())>0){
        		 isAccessTab=true;
        	 }
         }
         return isAccessTab;
    }
    
    
    /**
     * @param objectId
     * @param companyId
     * @param moduleId
     * @param transactionTypeId
     * @param paymentTypeId
     * @return
     * @throws Exception
     */
    public List<Object[]> getRestOfTenderDetailsForGT(int objectId,int companyId,int moduleId,int transactionTypeId,int paymentTypeId) throws Exception{
	   	 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("objectId",objectId);
	     var.put("companyId",companyId);
	     var.put("transactionTypeId",transactionTypeId);
	     StringBuilder query = new StringBuilder();
	     int isEMD=-1;
         int isItemwiseWinner=-1;
         var.put("objectId",objectId);
         
         List<Object[]> l = getTenderFields(objectId, "isEMDApplicable,isItemwiseWinner");
	  		if(!l.isEmpty()){
	  			Object[] tenderData = l.get(0);
	  			isEMD = Integer.parseInt(tenderData[0].toString());
	  			isItemwiseWinner =  Integer.parseInt(tenderData[1].toString());// 0 for Grand total wise, 1 for Item wise, 2 for Lot wise
	  		}
	     query.append(" select TB.companyId as c0,UD.companyName as c1, isnull(tblpayment0_.amount,0) as c2,isnull(tblpayment0_.paymentId,0) as c3,(CAST(TBD.cellValue as decimal)) AS c4,0 as c5,(CAST(TBD.cellValue as decimal))-(ISNULL(tblpayment0_.amount, 0)) as c6,emdTransactionDetail.amount as c7   ,isnull(tblPaymentType0_.paymentTypeId,0) as c8,tblPaymentType0_.lang1 as c9 ")
	   .append(" from apptender.tbl_Rebate TR  ")
	    .append(" INNER JOIN apptender.tbl_RebateForm RF ON TR.rebateId=RF.rebateId   ")
	    .append(" INNER JOIN apptender.tbl_tenderform TF ON RF.formId=TF.formId and TF.cstatus=1   ")   
	    .append(" INNER JOIN apptender.tbl_tendercell TCL ON TCL.formId=RF.formId and RF.cellId=TCL.cellId  ")  
	    .append(" INNER JOIN apptenderbid.tbl_tenderbid TB ON TB.cstatus = 2 and TB.formId=TF.formId   ") // and TB.companyId=tblpayment0_.companyId
	    .append(" INNER JOIN apptenderbid.tbl_tenderbidmatrix TBM ON TBM.bidId=TB.bidId   ")
	    .append(" INNER JOIN apptenderresult.tbl_tenderbiddetail TBD ON TBD.bidTableId=TBM.bidTableId  and TBD.cellId=TCL.cellId   ")
	    .append(" INNER JOIN apptenderbid.tbl_finalsubmission FS ON FS.tenderId = TB.tenderId AND TB.companyId = FS.companyId AND FS.partnerType IN (0, 1, 2)   ")
	    .append(" INNER JOIN appuser.tbl_UserDetail UD ON UD.userDetailId=FS.userDetailId  ")
	    .append(" INNER JOIN  appuser.tbl_EmdTransactionDetail emdTransactionDetail on emdTransactionDetail.objectId = FS.tenderId  and emdTransactionDetail.cstatus=2    ")   //and  emdTransactionDetail.paymentid = tblpayment0_.paymentid
	     .append(" LEFT JOIN appuser.Tbl_Payment tblpayment0_  ON TR.tenderid = tblpayment0_.objectId and tblpayment0_.cstatus=1  and tblpayment0_.paymentFor=2 and tblpayment0_.companyId =:companyId  ")
	    .append(" LEFT JOIN appuser.Tbl_OnlinePayment tblonlinep1_ on tblpayment0_.paymentId=tblonlinep1_.paymentid and tblonlinep1_.responseCode='0300'  ")
	    .append(" LEFT JOIN appuser.Tbl_OfflinePayment tblofflinep4_ on tblpayment0_.paymentId=tblofflinep4_.paymentid   ")
	    .append(" INNER JOIN appuser.Tbl_Company tblcompany2_ on FS.companyId=tblcompany2_.companyId and tblcompany2_.companyId =:companyId  ")   
	    .append(" LEFT JOIN appmaster.tbl_PaymentType tblPaymentType0_  on tblPaymentType0_.paymentTypeId = tblpayment0_.paymentTypeId   ")  
	    .append(" WHERE 1=1 ");
	    if(isEMD!=0){
	    	 var.put("moduleId",moduleId);
	    	query.append("  and tblpayment0_.moduleid=:moduleId   ") 
		    .append(" and tblPaymentType0_.paymentTypeId=tblpayment0_.paymentTypeId      ");  
	    }
	     query.append(" and emdTransactionDetail.transactionTypeId =:transactionTypeId and TR.tenderid = :objectId   ");
	    
	    int nVarCharColumnIndex [] = {1,9};
	    return hibernateQueryDao.createSQLQuery(query.toString(),var,nVarCharColumnIndex,10);
	}
    
    public int advanceFormulaCount(int tenderId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        int count=0;
        StringBuilder query = new StringBuilder();
        query.append(" select COUNT(tblTenderFormula.tblTenderForm.formId) from TblTenderFormula tblTenderFormula where tblTenderFormula.tblTenderForm.tblTender.tenderId=:tenderId ");
        query.append(" and tblTenderFormula.tblTenderForm.isPriceBid=1 and tblTenderFormula.tblTenderForm.cstatus <> 2 ");
        query.append(" and (tblTenderFormula.formula LIKE 'VCF_%' OR tblTenderFormula.formula LIKE 'VF_%' OR tblTenderFormula.formula LIKE 'SPF_%') ");
        List<Object> list = hibernateQueryDao.getSingleColQuery(query.toString(),var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
    }
    public List<TblEnvelope> getEnvelopeById(int envId) throws Exception{
    	List<TblEnvelope> list = null;
    	if(envId != 0){
    		list = commonDAO.findEntity(TblEnvelope.class,"isActive",Operation_enum.EQ,1,"envId",Operation_enum.EQ,envId);
    	}else{
        	list = commonDAO.findEntity(TblEnvelope.class,"isActive",Operation_enum.EQ,1);
    	}
    	return list;
    }

	public String getEnvelopeNameById(int envId) {
   		List<Object[]> list = commonDAO.executeSelect("select lang1,lang2 from TblEnvelope where envId="+envId, null);
    	return list.get(0)[0].toString();
	}

	 public List<Object[]> getEventType(){
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        query.append("select eventTypeId,eventTypeName,isActive from TblEventType");
        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
        return data;
	 }

	 public List<Object[]> getCurrencyByTenderId(int tenderId) throws Exception {
	        StringBuilder query = new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        var.put("tenderId", tenderId);
	        query.append("select tblCurrency.currencyId,exchangeRate,isDefault,tblCurrency.currencyName from TblTenderCurrency tblTenderCurrency where tblTenderCurrency.tblTender.tenderId=:tenderId");
	        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
	        return data;
	    }
 
	 /**
	  * Officer by id
	  * @param officerId
	  * @return deptName
	  */
	public List<Object[]> getOfficerById(int officerId) {
	        StringBuilder query = new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        query.append("select id,officername from TblOfficer tblOfficer where cStatus=1");
	        if(officerId != 0){
	        	var.put("id", Long.valueOf(officerId));
		        query.append(" and id=:id");
	        }
	        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
	        return data;
	}
	 /**
	  * Department by id
	  * @param departmentId
	  * @return
	  */
	public List<Object[]> getDepartmentById(int departmentId) {
	        StringBuilder query = new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        query.append("select deptId,deptName from TblDepartment where 1=1");
	        if(departmentId != 0){
	        	var.put("deptId", departmentId);
		        query.append(" and deptId=:deptId");
	        }
	        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
	        return data;
	}

	public List<Object[]> getProcurementNatureById(int procurementNatureId) {
		StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        query.append("select procurementNatureId,procurementName from TblProcurementNature where cStatus=1");
        if(procurementNatureId != 0){
        	var.put("procurementNatureId", procurementNatureId);
	        query.append(" and procurementNatureId=:procurementNatureId");
        }
        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
        return data;
	}
	@Transactional
	public List<Object[]> getICBDetailsByTender(int tenderId,int oprType) {
		StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("SELECT tblCurrency.currencyId,tblCurrency.currencyName,tblTenderCurrency.isDefault,tblTenderCurrency.tenderCurrencyId,tblTenderCurrency.exchangeRate");
        query.append(" FROM TblTenderCurrency tblTenderCurrency,TblCurrency tblCurrency");
        query.append(" WHERE tblCurrency.currencyId=tblTenderCurrency.tblCurrency.currencyId ");
        query.append(" AND tblTenderCurrency.tblTender.tenderId=:tenderId AND tblTenderCurrency.isActive=1");
        query.append(" AND tblCurrency.isActive=1 ");
        if(oprType == 1)
        	query.append(" AND tblTenderCurrency.exchangeRate=0.0");
        if(oprType == 2)
        	query.append(" AND tblTenderCurrency.isDefault!=1");
        return hibernateQueryDao.createNewQuery(query.toString(),var);
	}

	public HashMap<String, String> getOfficerNameIdMap(Integer officerId) {
		List<Object[]> tblOfficerList = getOfficerById(officerId);
		HashMap<String,String> officerNameMap = new HashMap<String, String>();
		if(tblOfficerList != null && !tblOfficerList.isEmpty()){
			for(Object[] obj : tblOfficerList){
				officerNameMap.put(obj[0].toString(), obj[1].toString());
			}
		}
		return officerNameMap;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public String allowFinalSubmission(String ipAddress, int... params) throws Exception {
        String msgCode = sPTenderFinalSubmission(params[0], params[1], params[2],ipAddress, params[3],params[4]);
         /*tenderId = 0 ,
         companyId =1 ,
         userId =2 ,
         userDetailId =3 ,
         FINALSUBMISSION_REQUEST_TYPE_POST =  ,
         (Integer) lstTenderFields.get(0)[2] =5 (isCertRequired) ,
         (Integer) lstTenderFields.get(0)[3]= 6 (envelopeType),
         (Integer) lstTenderFields.get(0)[5] = 7 (isRebateForm),
         certiType) : "" = 8;*/
        if(msgCode!=null && (msgCode.equalsIgnoreCase("Success") || msgCode.contains("msg_tender_fs_finalsubmission_done"))){
        	if(params[3] == 1){
            	eventBidSubmissionService.addTenderBidOpenDetails(ipAddress, params);
            }
        }
        return msgCode;
    }

	private String sPTenderFinalSubmission(int tenderId,int companyId, int bidderId, String ipAddress, int isFinalSubmission,int userId) throws Exception {
		int allowFinalSubmission = 1;
		String result = "Success";
		TblTender tblTender =  getTenderById(tenderId);
		int isBidderMapped = 0;
		if(allowFinalSubmission == 1){
			if(tblTender.getTenderMode() == 2 || tblTender.getTenderMode() == 3 || tblTender.getTenderMode() == 4){/* 2 for Limited, 3 for Proprietary, 4 for Nomination  */
				if(eventBidderMapService.isTenderBiddermapped(tenderId,companyId))
					isBidderMapped = 1;
			}else{/* Open Tender */
				isBidderMapped = 1;
			}
				if(!isFinalBidSubmision(tenderId,companyId)){
					/* Check whether the submission end date is lapsed or not */
					String f = isSubmissionDateLapsed(tenderId).get(0).toString();
	                if(f.equalsIgnoreCase("false")){/* Archieve tender */
						/* Check whether that particular bidder is mapped to the tender or not */
						if(isBidderMapped == 1){
							if(formService.checkBidderIsDisabledOrNot(userId).equalsIgnoreCase("true")){
							/* Check whether the bidder has filled atleast one bidding form */
								if(isBidderFilledBid(tenderId,companyId)){
									if(isBidderFilledAsDraftBid(tenderId,companyId)){
										result = "msg_tender_fs_fillall_draft_forms";
										allowFinalSubmission = 0;
									}
								}else{
									result = "msg_tender_fs_fillatleast_one_biddingform";
									allowFinalSubmission = 0;
								}
							}else{
								result = "msg_Bidder_Deactivated";
								allowFinalSubmission = 0;
							}
						}else{
							result = "msg_tender_fs_bidder_not_mapped";
							allowFinalSubmission = 0;
						}
					}else{
						result = "msg_tender_fs_submissionenddt_lapse";
						allowFinalSubmission = 0;
					}
				}else{
					TblFinalsubmission tblFinalsubmission = getTblFinalsubmissionById(tenderId,companyId);
					result = "msg_tender_fs_finalsubmission_done@"+tblFinalsubmission.getIpaddress()+'@'+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblFinalsubmission.getCreatedon());
				}
		if(allowFinalSubmission == 1)	{
			int envelopeId = 0;
			int mandatoryForCreated = 0;
			int minReqFormFilling = 0;
			int remainingMinReqFormFilling = 0;
			int mandatoryBiddedForm = 0;
			int nonMandatoryBiddedForm = 0;
			int minReqTablesFilling = 0;
			int mandatoryTableCreated = 0;
			int nonMandatoryTableCreated = 0;
			int remainingMinReqTableFilling = 0;
			int mandatoryBiddedtable = 0;
			int nonMandatoryBiddedTable = 0;
			int itemSelected = 0;
			int itemBidded = 0;
			
			List<Object[]> lst = getTblTenderEnvelopeList(tenderId,tblTender.getIsConsortiumAllowed()==1 ? true : false);
			if(lst != null){
			for(Object[] envelopeList : lst){
				envelopeId = Integer.parseInt(envelopeList[0].toString());
				minReqFormFilling =Integer.parseInt(envelopeList[1].toString());
				List<TblTenderForm> tblTenderFormList = getTblTenderFormByEnvlopeId(envelopeId);
				mandatoryForCreated = tblTenderFormList.size();
				
				remainingMinReqFormFilling = minReqFormFilling - mandatoryForCreated;
				mandatoryBiddedForm = getBidderForm(tenderId,companyId,envelopeId,1,tblTender.getIsConsortiumAllowed()==1 ? true : false);
				nonMandatoryBiddedForm = getBidderForm(tenderId,companyId,envelopeId,0,tblTender.getIsConsortiumAllowed()==1 ? true : false);
				
				if((mandatoryForCreated - mandatoryBiddedForm) == 0){
					if(nonMandatoryBiddedForm < remainingMinReqFormFilling){
						result = "msg_tender_fs_fillnonmandatory_forms";
					}else{
						List<TblTenderForm> formList = eventCreationService.getTblTenderFormList(tenderId);
						int formId = 0;
						for(int j = 0 ; j < formList.size() ; j++){
							formId = formList.get(j).getFormId();
							minReqTablesFilling =  formList.get(j).getMinTablesReqForBidding();
							mandatoryTableCreated = getBidderTable(tenderId,formId,1,tblTender.getIsConsortiumAllowed()==1 ? true : false);
							nonMandatoryTableCreated = getBidderTable(tenderId,formId,0,tblTender.getIsConsortiumAllowed()==1 ? true : false);
							remainingMinReqTableFilling = minReqTablesFilling - mandatoryTableCreated;
							
							mandatoryBiddedtable = getBiddedItem(tenderId,companyId,formId,1);
							nonMandatoryBiddedTable = getBiddedItem(tenderId,companyId,formId,0);
							if(true || mandatoryTableCreated == mandatoryBiddedtable){//hardcode
								if(remainingMinReqTableFilling !=0 && nonMandatoryBiddedTable < remainingMinReqTableFilling){
									result = "msg_tender_fs_fillnonmandatory_tables";
								}else{
									itemSelected = getItemSelected(tenderId,companyId,false);
									itemBidded = getItemSelected(tenderId,companyId,true);
									if(itemSelected!=0 && itemSelected != itemBidded){
										result = "msg_tender_fs_bidding_pending";
									}
								}
							}else{
								result = "msg_tender_fs_fillmandatory_tables";
							}
						}
					}
				}else{
					result = "msg_tender_fs_fillmandatory_forms";
				}
			}
		}
		}else{
			allowFinalSubmission = 0;
		}
			if(allowFinalSubmission== 1){
				List<TblTenderDocument> tblTenderDocumentlst = getTblTenderDocument(tenderId);
				List<Integer> formList = new ArrayList<Integer>();
				List<Integer> documentIds = new ArrayList<Integer>();
				for (TblTenderDocument tblTenderDocument : tblTenderDocumentlst) {
					formList.add(tblTenderDocument.getTblTenderForm().getFormId());
					documentIds.add(tblTenderDocument.getDocumentId());
				}
				List<Object[]> list = getCountFormMandDocs(tenderId,bidderId,formList,documentIds);
				if(tblTenderDocumentlst!=null && !tblTenderDocumentlst.isEmpty() && list == null ||  (list!=null &&  list.size() != tblTenderDocumentlst.size())){
					allowFinalSubmission = 0;
					result = "msg_tender_fs_uploadall_mandatory_docs";
				}
			}
			if(allowFinalSubmission== 1 &&tblTender.getIsRebateApplicable()==1){
				TblTenderRebate tblTenderRebate = tenderFormService.getTblTenderRebate(tenderId,companyId);
				if(tblTenderRebate==null){
					allowFinalSubmission = 0;
					result = "msg_tender_fs_rebate_detail_not_given";
				}
			}
			/*0 - For Validation
			1 - Insertion*/
			if(allowFinalSubmission == 1 && isFinalSubmission == 1){
				TblFinalsubmission tblFinalsubmission = new TblFinalsubmission();
				tblFinalsubmission.setTblTender(new TblTender(tenderId));
				tblFinalsubmission.setTblCompany(new TblCompany(companyId));
				tblFinalsubmission.setBidderid(bidderId);
//				tblFinalsubmission.setConsortiumid(consortiumData[0]);
				tblFinalsubmission.setPartnertype(0);
				tblFinalsubmission.setIpaddress(ipAddress);
				tblFinalsubmission.setIsactive(1);
				tblFinalsubmission.setCreatedby(userId);
				tblFinalSubmissionDao.addTblFinalSubmission(tblFinalsubmission);
			}
		}
		return result;
	}
	@Transactional
	public int checkRebateBidSubmit(int tenderId,int companyId) throws Exception {
		int count = 0;
	       StringBuilder query = new StringBuilder();
	       Map<String, Object> var = new HashMap<String, Object>();
	       var.put("tenderId", tenderId);
	       var.put("companyId", companyId);
	       query.append(" SELECT COUNT(DISTINCT CD.companyId) - COUNT(DISTINCT FS.companyId)");
	       query.append(" FROM TblTenderRebate tblTenderRebate ");
	       query.append(" WHERE tblTenderRebate.tblRebate.isRebateForm=1 AND tblTenderRebate.tblRebate.tblTender.tenderId=:tenderId AND tblTenderRebate.tblCompany.companyid=:companyId");
	       List<Object> list = hibernateQueryDao.getSingleColQuery(query.toString(),var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
	}
	@Transactional
	public int checkSecondaryBidSubmit(int consortiumId) throws Exception {
		int count = 0;
	       StringBuilder query = new StringBuilder();
	       Map<String, Object> var = new HashMap<String, Object>();
	       var.put("consortiumId", consortiumId);
	       query.append(" SELECT COUNT(DISTINCT CD.companyId) - COUNT(DISTINCT FS.companyId)");
	       query.append(" FROM tbl_consortium CM ");
	       query.append(" INNER JOIN tbl_consortiumdetail CD ON CM.consortiumId = CD.consortiumId AND CD.cstatus = 1 AND CD.partnerType = 3");
	       query.append(" LEFT OUTER JOIN tbl_finalsubmission FS ON CM.tenderId = FS.tenderId AND CD.companyId = FS.companyId ");
	       query.append(" WHERE CM.consortiumId =:consortiumId AND CM.isActive = 1");
	       List<Object> list = hibernateQueryDao.getSingleColQuery(query.toString(),var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
	}
	
	@Transactional
	public List<Object[]> isItemWiseDocAllowed(int tenderId) throws Exception {
	       StringBuilder query = new StringBuilder();
	       Map<String, Object> var = new HashMap<String, Object>();
	       var.put("tenderId", tenderId);
	       query.append("select isItemWiseDocAllowed From TblTenderForm WHERE tenderId=:tenderId AND isItemWiseDocAllowed = 1 ");
	       return hibernateQueryDao.createNewQuery(query.toString(), var);       
	   }
	@Transactional
	public int getBidderForm(int tenderId,int companyId, int envelopeId,int isMandatory,boolean isConsortium) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        var.put("envelopeId",envelopeId);
        var.put("isMandatory",isMandatory);
        StringBuilder query = new StringBuilder();
        int count=0;
        query.append(" SELECT COUNT(tblTenderForm.formId) FROM TblTenderForm tblTenderForm ");
        query.append(" ,TblTenderBid tblTenderBid");
        query.append(" where tblTenderBid.tblTender.tenderId=:tenderId AND tblTenderBid.tblTenderform.formId=tblTenderForm.formId AND tblTenderBid.tblTenderenvelope.envelopeId = tblTenderForm.tblTenderEnvelope.envelopeId");
        query.append(" AND tblTenderBid.tblCompany.companyid=:companyId AND tblTenderForm.tblTenderEnvelope.envelopeId=:envelopeId");
        query.append(" AND tblTenderForm.isMandatory=:isMandatory AND tblTenderBid.cstatus = 2 AND tblTenderForm.cstatus = 1");
        if(isConsortium){
        	query.append(" AND tblTenderForm.isSecondary = 1");
        }
        List<Object> list = hibernateQueryDao.getSingleColQuery(query.toString(),var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
    }
	@Transactional
	public int getBiddedItem(int tenderId,int companyId, int formId,int isMandatory) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        var.put("formId",formId);
        var.put("isMandatory",isMandatory);
        int count=0;
        List<Object> list = hibernateQueryDao.getSingleColQuery("SELECT COUNT(tblItemSelection.tblTenderTable.tableId) FROM TblItemSelection tblItemSelection "
        		+ "where tblItemSelection.tblTender.tenderId=:tenderId AND tblItemSelection.tblTenderForm.formId=:formId AND tblItemSelection.tblCompany.companyid=:companyId"
        		+ " AND tblItemSelection.tblTenderTable.isMandatory=:isMandatory AND tblItemSelection.tblTenderForm.cstatus=1",var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
    }
	@Transactional
	public int getItemSelected(int tenderId,int companyId,boolean flag) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        int count=0;
        StringBuilder strQuery = new StringBuilder();
        strQuery.append("SELECT COUNT(bidderItemId) FROM TblItemSelection tblItemSelection");
        strQuery.append(" where tblItemSelection.tblCompany.companyid=:companyId AND tblItemSelection.tblTender.tenderId=:tenderId");
        strQuery.append(" AND tblItemSelection.isSelected = 1");
        if(flag)
        	strQuery.append("AND tblItemSelection.isBidded = 1");
        List<Object> list = hibernateQueryDao.getSingleColQuery(strQuery.toString(),var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
    }
	@Transactional
	public int getBidderTable(int tenderId,int formId,int isMandatory,boolean isConsortium) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("formId",formId);
        var.put("isMandatory",isMandatory);
        int count=0;
        StringBuilder strQuery = new StringBuilder();
        strQuery.append(" SELECT COUNT(tblTenderForm.formId) FROM TblTenderTable tblTenderTable ");
        strQuery.append(" ,TblTenderForm tblTenderForm");
        strQuery.append(" WHERE tblTenderForm.tblTender.tenderId=:tenderId AND tblTenderTable.formId = tblTenderForm.formId");
        strQuery.append(" AND tblTenderTable.isMandatory=:isMandatory AND tblTenderForm.cstatus = 1 AND tblTenderForm.formId=:formId");
        if(isConsortium){
        	strQuery.append(" AND tblTenderForm.isSecondary=1");
        }
        List<Object> list = hibernateQueryDao.getSingleColQuery(strQuery.toString(),var);
        if(list!=null && !list.isEmpty()){
            count = Integer.parseInt(list.get(0).toString());
        }
        return count;
    }
	@Transactional
	public List<Object[]> getTblTenderEnvelopeList(int tenderId,boolean isConsortium) throws Exception{
		Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put(TENDER_ID, tenderId);
        StringBuilder strQuery = new StringBuilder();
        strQuery.append(" SELECT tblTenderForm.tblTenderEnvelope.envelopeId,tblTenderForm.tblTenderEnvelope.minFormsReqForBidding FROM TblTenderForm tblTenderForm WHERE tblTenderForm.cstatus=1");
        if(isConsortium){
        	strQuery.append(" AND tblTenderForm.isSecondary = 1");
        }
        strQuery.append(" AND tblTenderForm.tblTender.tenderId =:tenderId");
        List<Object[]> ls = hibernateQueryDao.createNewQuery(strQuery.toString(),parameters);
        if (ls != null && !ls.isEmpty()) {
           return ls;
        }
        return null;		
	}
	@Transactional
	public List<Object[]> getSubEndDtAndManDocs(int tenderId) throws Exception {
        List<Object[]> list = null;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);

        query.append("select case when tbltender.submissionEndDate < UTC_TIMESTAMP() then true else false end,tbltender.isMandatoryDocument,isConsortiumAllowed,isBidWithdrawal,isRebateForm ")
                .append(" from TblTender tbltender where tbltender.tenderId=:tenderId ");

        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        return list;

    }

	public Integer getOffcerIdByUserId(Integer sessionUserId) {
		Integer officerId = 0;
		List<Object[]> data = getOfficerByUserId(sessionUserId);
		if(data != null && !data.isEmpty()){
			officerId = Integer.parseInt((getOfficerByUserId(sessionUserId).get(0)[0]).toString());
		}
		return officerId;
	}
	
	/**
	  * Officer by id
	  * @param officerId
	  * @return deptName
	  */
	public List<Object[]> getOfficerByUserId(int userId) {
	        StringBuilder query = new StringBuilder();
	        Map<String, Object> var = new HashMap<String, Object>();
	        query.append("select id,officername from TblOfficer tblOfficer where cStatus=1");
	        if(userId != 0){
	        	var.put("userId", Long.valueOf(userId));
		        query.append(" and tblUserlogin.userId=:userId");
	        }
	        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
	        return data;
	}
	public List<Object[]> getUserByOfficerId(int[] officerId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        query.append("select id,officername,tblUserlogin.userId from TblOfficer tblOfficer where cStatus=1 ");
        var.put("officerId",officerId);
	    query.append(" and id in (:officerId)");
        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
        return data;
}
	public List<Object[]> getUserByOfficerId(Long officerId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        query.append("select id,officername,tblUserlogin.userId from TblOfficer tblOfficer where cStatus=1");
        if(officerId != 0){
        	var.put("id", Long.valueOf(officerId));
	        query.append(" and id=:id");
        }
        List<Object[]> data = commonDAO.executeSelect(query.toString(), var);
        return data;
	}
	/**
	 * 
	 * @param tenderId
	 * @param parameter	: only require parameter will be passed
	 * @param loginUserId
	 * @param processId
	 * @throws Exception 
	 */
	public void insertNotification(Integer tenderId,Map<String,Object> parameter,Integer loginUserId,Integer processId) throws Exception{
		TblProcess tblProcess = null;
		Map<String,Object> queryParam = new HashMap<String, Object>();
		queryParam.put("processId", processId);
		List<TblProcess> tblProcessList = commonDAO.getListByRistrictions(TblProcess.class, queryParam, null, null);
		TblTender tblTender = getTenderById(tenderId);
		tblProcess = tblProcessList.get(0);
		List<TblMarquee> marqueesList = new ArrayList<TblMarquee>();
		String user = "";
		boolean isForEmail = false;
		if(parameter.containsKey("userId")){
			user = parameter.get("userId").toString();
		}else if(parameter.containsKey("emailId")){
			user = parameter.get("emailId").toString();
			isForEmail = true;
		}
		
		String[] userId = user.split(",");
		
		for(int i = 0; i < userId.length;i++){
			if(userId[i] != null && !userId[i].isEmpty()){
				String text = tblProcess.getProcessText();
				text = text.replaceAll("\\{tenderId\\}", tblTender.getTenderId()+"");
				text = text.replaceAll("\\{tenderNo\\}", tblTender.getTenderNo());
				if(parameter.containsKey("committeeType")){
					if(parameter.get("committeeType").equals("prebid")){
						text = text.replaceAll("\\{committeeType\\}", "Prebid committee");
					}else{
						text = text.replaceAll("\\{committeeType\\}", parameter.get("committeeType").toString());
					}
				}
				if(!isForEmail){
					TblMarquee marquee = new TblMarquee();
					marquee.setCreatedBy(loginUserId);
					marquee.setMarqueeText(text);
					marquee.setMarqueeTo(Integer.parseInt(userId[i]));
					marquee.setTblProcess(tblProcess);	// 0: open, processId: particular process
					Date serverDateTime = commonService.getServerDateTime();
					marquee.setStartDate(serverDateTime);
					marquee.setCreatedOn(serverDateTime);
					marquee.setIsActive(1);
					marquee.setTenderId(tblTender.getTenderId());
					marqueesList.add(marquee);
				}else{
					//mailSender.sendMail(userId[i], text, "eprocurement.help@gmail.com", userId[i], text);
					String subject;
					if(parameter.containsKey("committeeType")){
						subject = "Dear committee member";
					}else{
						subject = "Dear bidder";
					}
					officerService.addMail(officerService.setTblMailMessage(userId[i],mailFrom, subject,text,subject));
				}
			}
		}
		OfficerService.notificationData.clear();
		if(marqueesList != null && !marqueesList.isEmpty()){
			commonDAO.saveOrUpdateAll(marqueesList);
		}
	}

	public void updateTblTenderFormWithWeight(String[] formIds, String[] txtWeightage) {
		for(int i = 0; i < formIds.length; i++){
			String form= formIds[i];
			String weightage= txtWeightage[i];
			String query = "update TblTenderForm set formWeight="+weightage+" where formId="+form;
			commonDAO.executeUpdate(query, null);
		}
	}

}
