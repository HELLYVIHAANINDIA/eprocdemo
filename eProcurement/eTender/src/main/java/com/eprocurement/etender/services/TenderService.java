package com.eprocurement.etender.services;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.SelectItem;
import com.eprocurement.etender.daointerface.TblBidderApprovalDetailDao;
import com.eprocurement.etender.daointerface.TblBidderApprovalHistoryDao;
import com.eprocurement.etender.daointerface.TblBidderItemsDao;
import com.eprocurement.etender.daointerface.TblFinalSubmissionDao;
import com.eprocurement.etender.daointerface.TblRebateDao;
import com.eprocurement.etender.daointerface.TblTenderBidDetailDao;
import com.eprocurement.etender.daointerface.TblTenderBidMatrixDao;
import com.eprocurement.etender.daointerface.TblTenderBidOpenSignDao;
import com.eprocurement.etender.daointerface.TblTenderColumnDao;
import com.eprocurement.etender.daointerface.TblTenderCurrencyDao;
import com.eprocurement.etender.daointerface.TblTenderEnvelopeDao;
import com.eprocurement.etender.daointerface.TblTenderFormDao;
import com.eprocurement.etender.daointerface.TblTenderOpenDao;
import com.eprocurement.etender.daointerface.TblTenderRebateDao;
import com.eprocurement.etender.daointerface.TblTenderTableDao;
import com.eprocurement.etender.model.TblBidderApprovalDetail;
import com.eprocurement.etender.model.TblBidderApprovalHistory;
import com.eprocurement.etender.model.TblBidderItems;
import com.eprocurement.etender.model.TblFinalsubmission;
import com.eprocurement.etender.model.TblRebate;
import com.eprocurement.etender.model.TblTenderBid;
import com.eprocurement.etender.model.TblTenderBidDetail;
import com.eprocurement.etender.model.TblTenderBidMatrix;
import com.eprocurement.etender.model.TblTenderBidOpenSign;
import com.eprocurement.etender.model.TblTenderCell;
import com.eprocurement.etender.model.TblTenderColumn;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderRebate;
import com.eprocurement.etender.model.TblTenderTable;
import com.eprocurement.etender.model.TblTenderopen;

@Service
public class TenderService {
	
    @Autowired
    HibernateQueryDao hibernateQueryDao;
    @Autowired
    TenderCommonService tenderCommonService;
    @Autowired
    TblBidderApprovalDetailDao tblBidderApprovalDetailDao;
    @Autowired
    TblBidderApprovalHistoryDao tblBidderApprovalHistoryDao;
    @Autowired
    TblTenderOpenDao tblTenderOpenDao;
    @Autowired
    TblBidderItemsDao tblBidderItemsDao;
    @Autowired
    TblTenderBidOpenSignDao tblTenderBidOpenSignDao;
    @Autowired
    TblTenderBidDetailDao tblTenderBidDetailDao;
    @Autowired
    TblTenderCurrencyDao tblTenderCurrencyDao;
    @Autowired
    CommonService commonService;
    @Autowired
    TblTenderFormDao tblTenderFormDao;
    @Autowired
    TblTenderTableDao tblTenderTableDao;
    @Autowired
    TblTenderBidMatrixDao tblTenderBidMatrixDao;
    @Autowired
    TblTenderColumnDao tblTenderColumnDao;
    @Autowired
    TblRebateDao tblRebateDao;
    @Autowired
    TblTenderEnvelopeDao tblTenderEnvelopeDao;
    @Autowired
    TblTenderRebateDao tblTenderRebateDao;
    @Autowired
    TblFinalSubmissionDao tblFinalsubmissionDao;
    @Autowired
    ReportService reportService;
    
    @Autowired
	CommonDAO commonDAO;
    
    private final String TABLEID = "tableId";
    private final String FORMID = "formId";
    private final String COLUMNID = "columnId";
    private final String SORTORDER = "sortOrder";
    private final String ENVELOPE_ID = "envelopeId";
    private final String TENDER_ID = "tenderId";
    private final int ISAPPROVEYES = 1;
	@Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
    private final String FEILD_MIN_FORMS_REQ_FOR_BIDDING="minFormsReqForBidding";
    @Value("#{etenderProperties['filledby_proxy']?:4}")
    private int proxy;
    private static final String TOTAL = "TOTAL(";   
    @Value("#{etenderProperties['bidding_form_processing_fees']?:11}")
    private int processingFeesId;
    @Value("#{etenderProperties['bidding_form_document_fees']?:9}")
    private int documentFeesId;
    @Value("#{etenderProperties['bidding_form_document_fees_by_officer']?:31}")
    private int documentFeesByOfficerId;
    @Value("#{etenderProperties['bidding_form_emd_amount']?:10}")
    private int emdAmountId;
    @Value("#{etenderProperties['bidding_form_emd_by_officer_fees']?:18}")
    private int emdAmountByOfficerId;
    @Value("#{etenderProperties['bidding_form_participation_fees_by_officer']?:32}")
    private int participationFeesByOfficerId;
    @Value("#{etenderProperties['bidding_form_encr_not_req']?:20}")
    private int notEncrReqId;
    @Value("#{etenderProperties['bidding_form_loading_factor']?:23}")
    private int loadingFactor;
    @Value("#{etenderProperties['datatype_combo']?:6}")
    private int combobox;
    @Value("#{etenderProperties['datatype_master_field']?:8}")
    private int masterField;
    @Value("#{etenderProperties['datatype_listbox']?:9}")
    private int listBox;

    @Transactional
    public boolean isOnlyOneEnvelopBuTenderId(int tenderId) throws Exception {
		 long count = 0;
	        Map<String, Object> var = new HashMap<String, Object>();
	        var.put("tenderId", tenderId);
	        count = hibernateQueryDao.countForNewQuery("TblTenderEnvelope tblTenderEnvelope ", "tblTenderEnvelope.envelopeId ", "tblTenderEnvelope.tblTender.tenderId=:tenderId and  tblTenderEnvelope.cstatus=1", var);
	       return count == 1 ? true : false;
	}
    @Transactional
    public List<Object[]> getBidderIdForOnlyOneEnvelop(int tenderId) {
		Map<String, Object> var = new HashMap<String, Object>();        
		var.put("tenderId",tenderId);
		 StringBuilder query = new StringBuilder();
	     query.append("select tblFinalSubmission.bidderid,finalsubmissionid from TblFinalsubmission tblFinalSubmission where tblFinalSubmission.tblTender.tenderId =:tenderId ");
	     return hibernateQueryDao.createNewQuery(query.toString(), var);
	}
    @Transactional
    public List<Object[]> getApprovalDetlsOfTechnicalEnvlop(int tenderId, int envelopeId,int bidderId,int createdBy) {
		Map<String, Object> var = new HashMap<String, Object>();
		List<Object> EnvlopeIds= new ArrayList<Object>();
		 StringBuilder query = new StringBuilder();
		 var.put("tenderId",tenderId);
		 if(envelopeId==0){
		 query.append("select tblTenderEnvelope.envelopeId from TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId =:tenderId and tblTenderEnvelope.openingDateStatus=1 and tblTenderEnvelope.tblEnvelope.envId not in(4,5) group by tblTenderEnvelope.envelopeId, ");
	     query.append("tblTenderEnvelope.tblEnvelope.envId having max(tblTenderEnvelope.tblEnvelope.envId)=tblTenderEnvelope.tblEnvelope.envId order by tblTenderEnvelope.tblEnvelope.envId desc"); 
	     EnvlopeIds = hibernateQueryDao.getSingleColQuery(query.toString(), var);
		     if(EnvlopeIds!=null && !EnvlopeIds.isEmpty()){
			     var.put("envelopeId",EnvlopeIds.get(0));
		     }
		 }else{
				 var.put("envelopeId",envelopeId);
		}
		query = new StringBuilder();
		if(bidderId!=0){
			var.put("bidderId",bidderId);
			var.put("createdBy",createdBy);
	     }
	     query.append("select tblBidderApprovalDetail.bidderid,tblBidderApprovalDetail.isapproved,tblBidderApprovalDetail.remarks,tblBidderApprovalDetail.createdby");
	     query.append(" from TblBidderApprovalDetail tblBidderApprovalDetail");
	     query.append(" inner join tblBidderApprovalDetail.tblTenderEnvelope tblTenderEnvelope");		     
	     query.append(" where tblTenderEnvelope.tblTender.tenderId =:tenderId and");
	     if(bidderId!=0){
	    	 query.append(" tblBidderApprovalDetail.bidderid =:bidderId and tblBidderApprovalDetail.createdby =:createdBy and");
	     }
//	     query.append("tblBidderApprovalDetail.tblTenderEnvelope.envelopeId in (select tblTenderEnvelope.envelopeId from TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId =:tenderId ");
	     if(envelopeId==0){
	    	 if(EnvlopeIds!=null && !EnvlopeIds.isEmpty()){
	    		 query.append(" tblTenderEnvelope.envelopeId =:envelopeId and ");
	    	 }
	     }else{
	    	 query.append(" tblTenderEnvelope.envelopeId =:envelopeId and ");
	     }
//	     query.append("and tblTenderEnvelope.cstatus =1)");
	     query.append("  tblTenderEnvelope.cstatus =1"); 
	     return hibernateQueryDao.createNewQuery(query.toString(), var);
}
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addEachBidderAprvalDtls(List<TblBidderApprovalDetail> tblBidderApprovalDtls) {
    	boolean bSuccess = false;
		tblBidderApprovalDetailDao.saveUpdateAllTblBidderApprovalDetail(tblBidderApprovalDtls);
		bSuccess = true;
		return bSuccess;
	}
    
    @Transactional
    public TblFinalsubmission getFinalSubmissionId(int tenderId, int bidderId) throws Exception {
		Map<String, Object> var = new HashMap<String, Object>();        
       var.put("tenderId",tenderId);
       var.put("bidderId",bidderId);
       List<TblFinalsubmission> list = null;
       list = tblFinalsubmissionDao.findTblFinalSubmission("tblTender.tenderId", Operation_enum.EQ, tenderId,"bidderid", Operation_enum.EQ, bidderId,"isactive", Operation_enum.EQ, 1);
       return (list != null && !list.isEmpty()) ? list.get(0) : null;
	}
    
    @Transactional
    public  boolean checkEntryBidderAppDtlsBidderWise(int tenderId,int envelopeId,int bidderId) throws Exception{
        List<TblBidderApprovalDetail> list = null;        
        list = tblBidderApprovalDetailDao.findTblBidderApprovalDetail("tblTender.tenderId",Operation_enum.EQ,tenderId,"tblTenderEnvelope.envelopeId",Operation_enum.EQ,envelopeId,"bidderid",Operation_enum.EQ,bidderId);                
        if(!list.isEmpty()){
       	 return false;
        }else{
       	 return true;
        }             

}
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean saveAllTblBidderItemsWiseEvaluation(List<TblBidderItems> tblBidderItems) throws Exception{
        boolean bSuccess = false;
        tblBidderItemsDao.saveUpdateAllTblBidderItems(tblBidderItems);
        bSuccess = true;
        return bSuccess;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean updateUserComiteByComiteUserId(int tenderId,int envelopeId,int committeeUserId,int committeeId, int approvedBy,String remark,int minOpeningMember,int committeeType) throws Exception{
   	 boolean success=false;
   	 int cnt = 0;
   	 int isOpenCount = 0;
        int minEvaluator = -1;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeUserId",committeeUserId);
        var.put("approvedBy",approvedBy);
        var.put("remark",remark);
        var.put("isApproved",ISAPPROVEYES);
        
        /*** Code to update TblCommitteeUser **/
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblCommitteeUser set isApproved=:isApproved , approvedBy=:approvedBy , approvedOn=UTC_TIMESTAMP() , remarks=:remark where committeeUserId=:committeeUserId",var); 
        
        if(cnt!=0){
       	
       	 /*** Services Call to get CommitteeUser by envelopeId and CommitteeId where is approved status is yes like 1**/
       	 isOpenCount = getComiteUserByComiteIdAndEnvId(committeeId, envelopeId, ISAPPROVEYES);
       	 if(minOpeningMember == isOpenCount){
   			 
       		 /*** Services Call for update status in TblTenderEnvelope table**/
       		 success = updateTenderEnvelopeByEnvId(envelopeId, ISAPPROVEYES,committeeType);
                        
                        /*List<Object[]> lstEnvelope = getTenderEnvelopeData(tenderId,envelopeId);
                        if(!lstEnvelope.isEmpty()){
                            minEvaluator = Integer.parseInt(lstEnvelope.get(0)[0].toString());
                        }*/
       		 			int tenderStage = (Integer)tenderCommonService.getTenderField(tenderId,"envelopeType");
                        if(success && tenderStage==1){
                       	 	 boolean isCommitteePublished = getPendingCommittee(tenderId,2,0);
	                             
	                             if(tenderStage==1){/*
	                                 // multiple stage(manual opening and auto evaluation)
	                                 autoOpeningEvaluation(tenderId,envelopeId,approvedBy,"fromEvaluatioTab",isCommitteePublished);
	                             }else{*/
	                                 // single stage(manual opening and auto evaluation)
//	                                 autoOpeningEvaluation(tenderId,envelopeId,approvedBy,committeeType==1 ? "fromOpeningTab" : "fromEvaluatioTab",isCommitteePublished);
	                             }
                       }
//       		 return success;
   		 }
       	 success = true;
//       	 return success;
        }
        return success;
    }
    
    @Transactional
    public int checkConsentGiverorNotById(int committeeUserId) throws Exception{
        int data=0;
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeUserId",committeeUserId);
        list = hibernateQueryDao.getSingleColQuery("SELECT committeeUserId FROM TblCommitteeUser tblcommitteeuser where committeeUserId=:committeeUserId and isApproved = 1",var);
        if(list != null && ! list.isEmpty()){
        	data = list.size();
        }
        return data;

    }
    @Transactional
    public int getComiteUserByComiteIdAndEnvId(int committeeId,int envelopeId,int isApproved) throws Exception{
        int data=0;
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeId",committeeId);
        var.put("envelopeId",envelopeId);
        var.put("isApproved",isApproved);
        list = hibernateQueryDao.getSingleColQuery("select tblcommitteeuser.isApproved, tblcommitteeuser.tblCommittee.committeeId, tblcommitteeuser.childId from TblCommitteeUser tblcommitteeuser where tblcommitteeuser.tblCommittee.committeeId=:committeeId and tblcommitteeuser.childId=:envelopeId and tblcommitteeuser.isApproved=:isApproved",var);
        if(list != null && ! list.isEmpty()){
       	 data = list.size();
        }
        return data;

    }
    @Transactional
    public boolean updateTenderEnvelopeByEnvId(int envelopeId,int isOpened,int committeeType) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("envelopeId",envelopeId);
        StringBuilder query = new StringBuilder();
        
        if(committeeType == 1){
       	 var.put("isOpened",isOpened);
       	 query.append("update TblTenderEnvelope set isOpened=:isOpened where envelopeId=:envelopeId");	 
        }
        else if(committeeType == 2){
       	 var.put("isEvaluated",isOpened);
       	 query.append("update TblTenderEnvelope set isEvaluated=:isEvaluated where envelopeId=:envelopeId");
        }
        
        cnt = hibernateQueryDao.updateDeleteNewQuery(query.toString(),var);        
        return cnt!=0;

    }
    @Transactional
    public List<Object[]>  getTenderEnvelopeData(int tenderId,int envelopeId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("envelopeId",envelopeId);
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append("select tbltenderenvelope.minEvaluator,tbltenderenvelope.minOpeningMember ");
        query.append("from TblTenderEnvelope tbltenderenvelope ");
        query.append("where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.envelopeId=:envelopeId");
        return hibernateQueryDao.createNewQuery(query.toString(),var);
    }
    
    /**
     * @author Lipi Shah
     * @return
     * @throws Exception 
     */
    @Transactional
    public boolean getPendingCommittee(int tenderId,int committeeType,int isApproved) throws Exception {
    	List<Object> list = null;
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("committeeType",committeeType);
        var.put("isApproved", isApproved);
        list = hibernateQueryDao.getSingleColQuery("SELECT tblCommittee.committeeId FROM TblCommittee tblCommittee WHERE tblCommittee.tblTender.tenderId=:tenderId AND committeeType=:committeeType AND isApproved=:isApproved ORDER BY tblCommittee.committeeId",var);
        return list!=null && !list.isEmpty()?true:false;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class}) 
    public boolean autoOpeningEvaluation(int tenderId,int envelopeId,int userDetailId,String from,boolean isCommitteePublished) throws Exception{
        boolean bSuccess = false;
        updateTenderEnvelope(tenderId,envelopeId,from,isCommitteePublished);
        updateCommitteeUser(tenderId,envelopeId,userDetailId,from,isCommitteePublished);
        bSuccess = true;
        return bSuccess;
    }
    
    public boolean updateTenderEnvelope(int tenderId,int envelopeId,String from,boolean isCommitteePublished) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        StringBuilder query = null;
        if("fromOpeningTab".equalsIgnoreCase(from)){
           //auto opening and manual evaluation case
            var.put("tenderId",tenderId);
            query = new StringBuilder();
//           query.append("update TblTenderEnvelope set isOpened=1 where envelopeId=:envelopeId");
           query.append("update TblTenderEnvelope set isOpened=1 where tblTender.tenderId=:tenderId");
        } else if("fromAuto".equalsIgnoreCase(from)){
           //auto opening as well as auto evaluation case
            var.put("envelopeId",envelopeId);
            query = new StringBuilder();
           query.append("update TblTenderEnvelope set isOpened=1,isEvaluated=1 where envelopeId=:envelopeId");	 
        } else if("fromEvaluatioTab".equalsIgnoreCase(from) && !isCommitteePublished){
           //set isevaluated=1 for particular envelope - manual opening and auto evaluation case(multiple stage)
            var.put("envelopeId",envelopeId);
            query = new StringBuilder();
           query.append("update TblTenderEnvelope set isEvaluated=1 where envelopeId=:envelopeId");	   
        } else if("fromEvaluatioTabSingleStage".equalsIgnoreCase(from) && !isCommitteePublished){
           //set isevaluated=1 for all envelope base on tenderid - manual opening and auto evaluation case(single stage)
           var.put("tenderId",tenderId);
           query = new StringBuilder();
           query.append("update TblTenderEnvelope tbltenderenvelope set tbltenderenvelope.isEvaluated=1 where tbltenderenvelope.tblTender.tenderId=:tenderId");	   
        }
        if(query!=null){
       	 int cnt = hibernateQueryDao.updateDeleteNewQuery(query.toString(),var);
       	 return cnt!=0;
        }
        return true;
    }
    
    public boolean updateCommitteeUser(int tenderId,int envelopeId,int userDetailId,String from,boolean isCommitteePublished) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        StringBuilder query = null;
        var.put("userDetailId", userDetailId);//hard code
        if("fromOpeningTab".equalsIgnoreCase(from)){
            //auto opening and manual evaluation case
            var.put("tenderId",tenderId);
            var.put("envelopeId",envelopeId);
            query = new StringBuilder();
            query.append("update TblCommitteeUser tblcommitteeuser ");	 
            query.append("set tblcommitteeuser.isApproved=1,tblcommitteeuser.approvedOn=UTC_TIMESTAMP(),tblcommitteeuser.approvedBy=:userDetailId ");	 
            query.append("where tblcommitteeuser.childId=:envelopeId and tblcommitteeuser.tblCommittee.committeeId in (");	 
            query.append("select tblcommittee.committeeId from TblCommittee tblcommittee where tblcommittee.tblTender.tenderId=:tenderId and tblcommittee.committeeType=1)");
        }else if("fromEvaluatioTab".equalsIgnoreCase(from) && !isCommitteePublished){
            //manual opening and auto evaluation case(multiple stage)
            var.put("tenderId",tenderId);
            var.put("envelopeId",envelopeId);
            query = new StringBuilder();
            query.append("update TblCommitteeUser tblcommitteeuser ");	 
            query.append("set tblcommitteeuser.isApproved=1,tblcommitteeuser.approvedOn=UTC_TIMESTAMP(),tblcommitteeuser.approvedBy=:userDetailId ");	 
            query.append("where tblcommitteeuser.childId=:envelopeId and tblcommitteeuser.tblCommittee.committeeId in (");	 
            query.append("select tblcommittee.committeeId from TblCommittee tblcommittee where tblcommittee.tblTender.tenderId=:tenderId and tblcommittee.committeeType=2)");
        }else if("fromEvaluatioTabSingleStage".equalsIgnoreCase(from) && !isCommitteePublished){
            //manual opening and auto evaluation case(single stage)
            var.put("tenderId",tenderId);
            query = new StringBuilder();
            query.append("update TblCommitteeUser tblcommitteeuser ");	 
            query.append("set tblcommitteeuser.isApproved=1,tblcommitteeuser.approvedOn=UTC_TIMESTAMP(),tblcommitteeuser.approvedBy=:userDetailId ");	 
            query.append("where tblcommitteeuser.tblCommittee.committeeId in (");	 
            query.append("select tblcommittee.committeeId from TblCommittee tblcommittee where tblcommittee.tblTender.tenderId=:tenderId and tblcommittee.committeeType=2)");
        }else if(!isCommitteePublished){
            //auto opening as well as auto evaluation case
            var.put("envelopeId",envelopeId);
            query = new StringBuilder();
            query.append("update TblCommitteeUser tblcommitteeuser set tblcommitteeuser.isApproved=1,tblcommitteeuser.approvedOn=UTC_TIMESTAMP(),tblcommitteeuser.approvedBy=:userDetailId  where tblcommitteeuser.childId=:envelopeId");	 
        }
        if(query!=null){
       	 int cnt = hibernateQueryDao.updateDeleteNewQuery(query.toString(),var);
       	 return cnt!=0;
        }
        return true;
    }
    /**
     * to get tender envelope details
     * @param tenderId
     * @param envelopeId
     * @return
     * @throws Exception 
     */
    @Transactional
    public List<Object[]> getTenderEnvelopeDetails(int envelopeId,int reportType) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("envelopeId",envelopeId);
        StringBuilder query=new StringBuilder("select ");
        if(reportType == 1){
        	query.append(" tbltenderenvelope.minOpeningMember ");
        }else if(reportType == 2){
        	query.append(" tbltenderenvelope.minEvaluator ");
        }
        query.append(" , tbltenderenvelope.cstatus,tbltenderenvelope.envelopeName,tbltenderenvelope.openingDate from TblTenderEnvelope tbltenderenvelope where  tbltenderenvelope.envelopeId=:envelopeId ");
        return hibernateQueryDao.createNewQuery(query.toString(),var);        
    }
    /**
     * to update price bid opening date
     * @param tenderId
     * @param envelopeId
     * @param openingDate
     * @return
     * @throws Exception 
     */
    @Transactional
    public boolean updatePriceBidOpeningDate(int tenderId,int envelopeId,String openingDate) throws Exception{
        boolean success = false;
//        Map<String, Object> var = new HashMap<String, Object>();
//        var.put("tenderId",tenderId);
//        var.put("envelopeId",envelopeId);
//        Date openingDate1 = commonService.convertStringToDate(client_dateformate_hhmm,openingDate);
        
//        var.put("openingDate",openingDate);
        
        TblTenderEnvelope tblTenderEnvelope = getTblTenderEnvelope(tenderId,envelopeId);
        tblTenderEnvelope.setOpeningDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,openingDate));
        tblTenderEnvelopeDao.updateEntity(tblTenderEnvelope);
        success=true;
//        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblTenderEnvelope set openingDate=:openingDate where envelopeId=:envelopeId and tblTender.tenderId=:tenderId",var);        
        return success;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean updatePriceBidICB(List<TblTenderCurrency> tblTenderCurrencyList) throws Exception{
    	boolean bSuccess = false;    
    	tblTenderCurrencyDao.updateAllTblTenderCurrency(tblTenderCurrencyList);
    	bSuccess = true;
    	return bSuccess;
    }
    /**
     * 
     * @param tenderId
     * @param envelopeId
     * @return
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean publishPriceOpeningBid(int tenderId,int envelopeId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("envelopeId",envelopeId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblTenderEnvelope set openingDateStatus=1, openingDatePublishedOn=UTC_TIMESTAMP(),openingDatePublishedBy=1 where envelopeId=:envelopeId and tblTender.tenderId=:tenderId",var);//hard code   
        return cnt!=0;

    }
    @Transactional
    public List<Object[]> ChkandgetItemWiseEvaluationData(int tenderId,int envelopeId, int sessionUserId, int bidderId) {
		Map<String, Object> var = new HashMap<String, Object>();        
       var.put("tenderId",tenderId);
       var.put("envelopeId",envelopeId);
       var.put("sessionUserId",sessionUserId);
       var.put("bidderId",bidderId);
       StringBuilder query = new StringBuilder();
       query.append("select tblBidderItems.bidderItemId,tblBidderItems.rowId,tblBidderItems.remarks,tblBidderItems.tblTenderForm.formId,tblBidderItems.isApproved from TblBidderItems tblBidderItems ");//,COALESCE(tblBidderItems.tblTenderTable.tableId,0),
       query.append("inner join tblBidderItems.tblTender tblTender ");
       query.append("inner join tblBidderItems.tblBidder tblBidder ");
       query.append("inner join tblBidderItems.tblTenderEnvelope tblTenderEnvelope ");
       query.append("where tblBidderItems.tblTender.tenderId =:tenderId and tblBidderItems.tblBidder.bidderId =:bidderId and tblBidderItems.createdBy =:sessionUserId and tblTenderEnvelope.envelopeId =:envelopeId ");
       List<Object[]> chkdata=hibernateQueryDao.createNewQuery(query.toString(), var);
       return chkdata;
	}
    @Transactional
    public List<Object[]> getUserRoleId(int tenderId,int envlopeId,int committeeType,int officerId){
	        List<Object[]> list = null;
	        Map<String, Object> var = new HashMap<String, Object>();        
	        var.put("tenderId",tenderId);
	        var.put("childId",envlopeId);
	        var.put("committeeType",committeeType);
	        if(officerId!=0){
	        	var.put("officerId",officerId);
	        }
	        StringBuilder query = new StringBuilder();
	        	   query.append("SELECT tblCommitteeUser.userRoleId,tblCommitteeUser.encryptionLevel,tblCommitteeUser.tblOfficer.tblUserlogin.userId,tblCommitteeUser.isDecryptor");
	        	   query.append(" FROM TblCommittee tblCommittee");
               query.append(" INNER JOIN tblCommittee.tblCommitteeUser tblCommitteeUser");
               query.append(" WHERE tblCommittee.tblTender.tenderId =:tenderId");
               query.append(" AND tblCommittee.isActive = 1 AND tblCommittee.committeeType=:committeeType");
               query.append(" AND tblCommitteeUser.childId=:childId");
               if(officerId!=0){
            	   query.append(" AND tblCommitteeUser.tblOfficer.tblUserlogin.userId=:officerId");
               }else{
            	   query.append(" ORDER BY tblCommitteeUser.userRoleId DESC");
               }
               
	        list = hibernateQueryDao.createNewQuery(query.toString(), var);
	        return list;
	    }
    
    @Transactional
    public List<Object[]> getAllEnvelopeTypeByTenderId(int tenderId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select tblTenderEnvelope.envelopeId,tblTenderEnvelope.tblEnvelope.envId from TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId=:tenderId and tblTenderEnvelope.cstatus = 1 order by tblTenderEnvelope.tblEnvelope.envId");
        List<Object[]> data = hibernateQueryDao.createNewQuery(query.toString(), var);
        return data;
    }
    @Transactional
    public long getCountofFinalSubmissionWithConsourtium(int tenderId, int isConsortiumAllowed) throws Exception {
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        String whereCondition = isConsortiumAllowed == 1 ? "tblFinalSubmission.tblTender.tenderId =:tenderId and tblFinalSubmission.isactive = 1 and tblFinalSubmission.partnertype in (1,2)" : "tblFinalSubmission.tblTender.tenderId =:tenderId and tblFinalSubmission.isactive = 1";
		long finalSubCnt = hibernateQueryDao.countForNewQuery("TblFinalsubmission tblFinalSubmission ", "tblFinalSubmission.finalsubmissionid ", whereCondition, var);
		return finalSubCnt;
	}
    @Transactional
    public long getCountofBidderItems(int tenderId,int envelopeId) throws Exception {
		long count = 0;
		Map<String,Object> column = new HashMap<String, Object>();
		column.put("tenderId", tenderId);
		column.put("envelopeId", envelopeId);
		List<Object> result = commonDAO.executeSelect("select count(distinct tblBidderItems.tblCompany.companyid) as count from TblBidderItems tblBidderItems where tblBidderItems.tblTender.tenderId=:tenderId AND tblBidderItems.tblTenderEnvelope.envelopeId=:envelopeId", column);
		if(result!=null && !result.isEmpty()) {
			count = (Long)result.get(0);
		}
		return count;
	}
    @Transactional
    public long getCountofBidderapprovaldetail(int tenderId,int envelopeId) throws Exception {
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("envelopeId",envelopeId);
		long finalSubCnt = hibernateQueryDao.countForNewQuery("TblBidderApprovalDetail tblBidderApprovalDetail ", "tblBidderApprovalDetail.companyid", "tblBidderApprovalDetail.tblTender.tenderId =:tenderId and tblBidderApprovalDetail.tblTenderEnvelope.envelopeId =:envelopeId", var);
		return finalSubCnt;
	}
    
    
    @Transactional
    public long getCountofFinalSubmission(int tenderId) throws Exception {
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
		long finalSubCnt = hibernateQueryDao.countForNewQuery("TblFinalsubmission tblFinalSubmission ", "tblFinalSubmission.finalsubmissionid ", "tblFinalSubmission.tblTender.tenderId =:tenderId and tblFinalSubmission.isactive = 1", var);
		return finalSubCnt;
	}
    @Transactional
    public Integer isEnvelopeWiseEvaluationDone(int tenderId, int envelopeId,
			long finalSubmissionCnt, int previousEnvId) {
		if(previousEnvId == -1 || previousEnvId == 0){
			return isEnvelopeWiseEvaluationDone(tenderId,envelopeId,finalSubmissionCnt);
		}else{
			StringBuilder query = new StringBuilder();
			List<Object> list = new ArrayList<Object>();
	   	 	Map<String, Object> var = new HashMap<String, Object>();
	   	 	var.put("tenderId",tenderId);
	        var.put("envelopeId",envelopeId);
	        var.put("prevEnvelopeId",previousEnvId);
			query.append("SELECT DISTINCT CASE WHEN (SELECT COUNT(tblBidderApprovalDetail.bidderapprovalid) FROM TblBidderApprovalDetail tblBidderApprovalDetail WHERE tblBidderApprovalDetail.tblTender.tenderId =:tenderId AND ");
			query.append("tblBidderApprovalDetail.tblTenderEnvelope.envelopeId =:prevEnvelopeId AND tblBidderApprovalDetail.isapproved = 1) = ");
	        query.append("(SELECT COUNT(tblBidderApprovalDetail.bidderapprovalid) FROM TblBidderApprovalDetail tblBidderApprovalDetail WHERE tblBidderApprovalDetail.tblTender.tenderId =:tenderId AND ");
	        query.append("tblBidderApprovalDetail.tblTenderEnvelope.envelopeId =:envelopeId) THEN 1 ELSE 0 END FROM TblFinalsubmission tblFinalSubmission");
	        list = hibernateQueryDao.singleColQuery(query.toString(),var);
	        return list.size() != 0 && !list.isEmpty() ? Integer.parseInt(list.get(0).toString()) : 0 ;
		}
	}
    @Transactional
    public Integer isEnvelopeWiseEvaluationDone(int tenderId, int envelopeId, long finalSubmissionCnt) {
		StringBuilder query = new StringBuilder();
		List<Object> list = new ArrayList<Object>();
   	 	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("envelopeId",envelopeId);
        var.put("finalSubmissionCnt",finalSubmissionCnt);
        query.append("SELECT DISTINCT CASE WHEN (:finalSubmissionCnt) = ");
        query.append("(SELECT COUNT(tblBidderApprovalDetail.bidderapprovalid) FROM TblBidderApprovalDetail tblBidderApprovalDetail WHERE tblBidderApprovalDetail.tblTender.tenderId =:tenderId AND ");
        query.append("tblBidderApprovalDetail.tblTenderEnvelope.envelopeId =:envelopeId) THEN 1 ELSE 0 END FROM TblFinalsubmission tblFinalSubmission");
        list = hibernateQueryDao.singleColQuery(query.toString(),var);
		return list.size() != 0 && !list.isEmpty() ? Integer.parseInt(list.get(0).toString()) : 0 ;
	}
    @Transactional
    public List<Object> getOfficerEvaluationDateAndTime(int tenderId,int envelopeId){
		StringBuilder strQuery = new StringBuilder();
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("tenderId", tenderId);
        parameters.put("envelopeId", envelopeId);
        strQuery.append("select tblBidderApprovalDetail.createdon from TblBidderApprovalDetail tblBidderApprovalDetail ");
        strQuery.append(" where tblBidderApprovalDetail.tblTender.tenderId=:tenderId  and tblBidderApprovalDetail.tblTenderEnvelope.envelopeId=:envelopeId order by tblBidderApprovalDetail.createdon desc");
        return hibernateQueryDao.getSingleColQuery(strQuery.toString(), parameters);
	 }
    @Transactional
    public long getCountofTenderEnvelope(int tenderId) throws Exception {
		Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
		long finalSubCnt = hibernateQueryDao.countForNewQuery("TblTenderEnvelope trblTenderEnvelope ", "trblTenderEnvelope.envelopeId ", "trblTenderEnvelope.tblTender.tenderId =:tenderId", var);
		return finalSubCnt;
	}    
    @Transactional
    public List<Object[]> getTenderEnvelopeList(int tenderId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDER_ID, tenderId);
        StringBuilder query = new StringBuilder();
        query.append(" select tbltenderenvelope.tblEnvelope.envId, tbltenderenvelope.envelopeName,tbltenderenvelope.envelopeId,");
        query.append(" tbltenderenvelope.isOpened,CASE WHEN tbltenderenvelope.openingDate <= UTC_TIMESTAMP() AND tbltenderenvelope.cstatus = 1 THEN 1 ELSE 0 END,");
        query.append(" tbltenderenvelope.isEvaluated,tbltenderenvelope.minOpeningMember,tbltenderenvelope.minEvaluator,tbltenderenvelope.tblEnvelope.envId ");
        query.append(" from TblTenderEnvelope tbltenderenvelope");
        query.append(" where tbltenderenvelope.tblTender.tenderId=:tenderId");
        query.append(" ORDER BY tbltenderenvelope.sortOrder ");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    
    @Transactional
    public boolean isEvaluationRemarksDone(int tenderId,int envelopeId) throws Exception {
    	boolean remarksDone = false;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDER_ID, tenderId);
        var.put("envelopeId", envelopeId);
        StringBuilder query = new StringBuilder();
        query.append(" select tblBidderApprovalDetail.remarks,tblBidderApprovalDetail.isapproved ");
        query.append(" from TblBidderApprovalDetail tblBidderApprovalDetail ");
        query.append(" where tblBidderApprovalDetail.tblTender.tenderId=:tenderId and tblBidderApprovalDetail.tblTenderEnvelope.envelopeId=:envelopeId and tblBidderApprovalDetail.remarks!=NULL");
        List <Object[]> lstBidderApprovalDetails = hibernateQueryDao.createNewQuery(query.toString(), var);
        if(lstBidderApprovalDetails!=null){
        	remarksDone = lstBidderApprovalDetails.size()>0?true:false;  
        }
        return remarksDone;
    }
    
    @Transactional
    public int getCommitteeId(int tenderId) throws Exception {
        int data = 0;
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        StringBuilder query = new StringBuilder();
        query.append(" select tblcommittee.committeeId");
        query.append(" from TblCommittee tblcommittee");
        query.append(" where tblcommittee.tblTender.tenderId=:tenderId and tblcommittee.committeeType=2 and tblcommittee.isActive=1 and tblcommittee.isApproved=1 ");
        list = hibernateQueryDao.singleColQuery(query.toString(), var);
        if (!list.isEmpty()) {
            data =(Integer) list.get(0);
        }
        return data;
    }
    @Transactional
    public List<Object> getCommitteeOfficerCount(int committeeId,int encryptionLevel,int userRoleId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeId", committeeId);
        var.put("userRoleId", userRoleId);
        var.put("encryptionLevel", encryptionLevel);
        return hibernateQueryDao.singleColQuery("select distinct tblCommitteeUser.tblOfficer.tblUserlogin.userId from TblCommitteeUser tblcommitteeuser where tblcommitteeuser.tblCommittee.committeeId=:committeeId and tblcommitteeuser.encryptionLevel=:encryptionLevel and tblcommitteeuser.userRoleId=:userRoleId", var);        
    }
    @Transactional
    public List<Object[]> getDistinctBidderItems(int tenderId,List<Object> prevUserId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("prevUserId", prevUserId);
        StringBuilder query = new StringBuilder();
        query.append(" select tblbidderitems.tblCompany.companyid,COUNT(distinct tblbidderitems.createdBy)");
        query.append(" from TblBidderItems tblbidderitems");
        query.append(" where tblbidderitems.tblTender.tenderId=:tenderId and tblbidderitems.childId=0");
        if(prevUserId!=null){
            var.put("prevUserId", prevUserId);
            query.append("  and tblbidderitems.createdBy in (:prevUserId)");
        }
        query.append(" group by tblbidderitems.tblCompany.companyid");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    @Transactional
    public long getBidderItemCount(int tenderId,int userId,int companyId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("userId", userId);
        var.put("companyId", companyId);
        count = hibernateQueryDao.countForNewQuery("TblBidderItems tblbidderitems ", "tblbidderitems.bidderItemId ", "tblbidderitems.tblTender.tenderId=:tenderId and tblbidderitems.tblCompany.companyid=:companyId and tblbidderitems.createdBy=:userId and tblbidderitems.childId=0", var);
        return count;
    }
     
    public int showItemSelection(int userId,int envelopeId,int companyId,int tenderId,int totalCmpCount) throws Exception {
        int showLink = 0;//hide link
        int committeeId = getCommitteeId(tenderId);
        List<Object> prevUser = null;
        long committeeOfficerCount = 0;
        prevUser =getCommitteeOfficerCount(committeeId,1,1);
        committeeOfficerCount =prevUser.size();
        /*if(askedToLevel-1 ==1){
            prevUser = getCommitteeOfficerCount(committeeId,1,2);
            committeeOfficerCount = prevUser.size();
        }else if(askedToLevel-1 == 2){
            prevUser =getCommitteeOfficerCount(committeeId,1,1);
            committeeOfficerCount =prevUser.size();
        }else if(askedToLevel-1 == 3){
            prevUser =getCommitteeOfficerCount(committeeId,2,2);
            committeeOfficerCount = prevUser.size();
        }else if(askedToLevel-1 == 4){
            prevUser =getCommitteeOfficerCount(committeeId,2,1);
            committeeOfficerCount = prevUser.size();
        }*/
        List<Object[]> lstBidderItems = getDistinctBidderItems(tenderId,prevUser);
        long bidderItemCount = getBidderItemCount(tenderId,userId,companyId);
        boolean isPrevRemarksReceived4=false;
        if(lstBidderItems!=null && !lstBidderItems.isEmpty() && lstBidderItems.size()>=totalCmpCount){
            int cnt = 0;
            for(int i=0;i<lstBidderItems.size();i++){
                long bidderWiseCount = Long.parseLong(lstBidderItems.get(i)[1].toString());
                if(bidderWiseCount==committeeOfficerCount){
                    cnt = cnt+1;
                }
            }
            if(cnt==lstBidderItems.size()){
                isPrevRemarksReceived4=true;
            }
        }
        if(isPrevRemarksReceived4){
            if(bidderItemCount==0){
                showLink = 1;//show link
            }else if(bidderItemCount>0){
                showLink = 2;//show label Evaluated
            }
        }
        return showLink;
    }    

	@Transactional
    public List<Object[]> getNextEnvelopFormIdList(int tenderId,int sortOrder) throws Exception{
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("sortOrder",sortOrder);
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append("SELECT tblTenderForm.formId,tblTenderForm.formName ");
        query.append("FROM TblTenderForm tblTenderForm ");
        query.append("INNER JOIN tblTenderForm.tblTenderEnvelope tbltenderenvelope ");
        query.append("where tbltenderenvelope.tblTender.tenderId=:tenderId AND tblTenderForm.cstatus = 1 AND tblTenderForm.isEncryptionReq=0 AND tbltenderenvelope.sortOrder =:sortOrder + 1");
        return hibernateQueryDao.createNewQuery(query.toString(),var);    
	}
    @Transactional
    public  boolean checkEntryBidderAppDtls(int tenderId,int envelopeId) throws Exception{
        List<TblBidderApprovalDetail> list = null;        
        list = tblBidderApprovalDetailDao.findTblBidderApprovalDetail("tblTender.tenderId",Operation_enum.EQ,tenderId,"tblTenderEnvelope.envelopeId",Operation_enum.EQ,envelopeId);                
        if(!list.isEmpty()){
       	 return false;
        }else{
       	 return true;
        }             

    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBidderAprvalDtls(List<TblBidderApprovalDetail> tblBidderApprovalDetails) throws Exception{
    boolean bSuccess = false;    
    				/*** Code to insert row in TblBidderApprovalDetail by list **/
                tblBidderApprovalDetailDao.saveUpdateAllTblBidderApprovalDetail(tblBidderApprovalDetails);
                
                /*** Code to insert row in TblBidderApprovalDetail history table **/
                bSuccess = addBidderAprvalDtlsHist(tblBidderApprovalDetails);
        return bSuccess;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean updateBidderAprvalDtls(int envelopeId,List<TblBidderApprovalDetail> tblBidderApprovalDetails) throws Exception{
    boolean bSuccess = false;
    
			     /*** Code to get all row from TblBidderApprovalDetail by envelopeId and insert in history table **/
    			bSuccess = addBidderAprvalDtlsHist(getBidderApprovalDetail(envelopeId));
			    
    			/*** Code to delete all row from TblBidderApprovalDetail by envelopeId **/
    			if(bSuccess){
    				bSuccess = deleteBiderAprvalDtlsByEnvelopeId(envelopeId);	
    			}else{
    				bSuccess = false;
    			}
    			
    			/*** Code to add new row in TblBidderApprovalDetail by list **/
    			if(bSuccess){
    				tblBidderApprovalDetailDao.saveUpdateAllTblBidderApprovalDetail(tblBidderApprovalDetails);	
    			}else{
    				bSuccess = false;
    			}
            return bSuccess;

    }
    @Transactional
    public  List<TblBidderApprovalDetail> getBidderApprovalDetail(int envelopeId) throws Exception{
        List<TblBidderApprovalDetail> list = null;        
        list = tblBidderApprovalDetailDao.findTblBidderApprovalDetail("tblTenderEnvelope.envelopeId",Operation_enum.EQ,envelopeId,"isApproved",Operation_enum.EQ,1);                
        return list;

    }
    @Transactional
    public boolean deleteBiderAprvalDtlsByEnvelopeId(int envelopeId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("envelopeId",envelopeId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete  from TblBidderApprovalDetail tblbidderapprovaldetail where tblbidderapprovaldetail.tblTenderEnvelope.envelopeId=:envelopeId",var);        
        return cnt!=0;

    }
    @Transactional
    public TblTenderEnvelope getTblTenderEnvelope(int tenderId,int envelopeId) throws Exception {
        List<TblTenderEnvelope> list = null;
        list = tblTenderEnvelopeDao.findTblTenderEnvelope("tblTender.tenderId", Operation_enum.EQ, tenderId,"envelopeId", Operation_enum.EQ, envelopeId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    @Transactional
    public TblTenderEnvelope getTblTenderEnvelope(int tenderId) throws Exception {
        List<TblTenderEnvelope> list = null;
        list = tblTenderEnvelopeDao.findTblTenderEnvelope("tblTender.tenderId", Operation_enum.EQ, tenderId,"sortOrder", Operation_enum.ORDERBY, Operation_enum.DESC);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean updateTblTender(int tenderId) throws Exception{
    	boolean bSuccess = false;
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
    	hibernateQueryDao.updateDeleteNewQuery("update TblTender set isEvaluationDone=1  where tenderId=:tenderId",var);
    	bSuccess = true;
    	return bSuccess;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBidderAprvalDtls(List<TblBidderApprovalDetail> tblBidderApprovalDetails,List<TblTenderopen> tblTenderOpenList,List<TblTenderBidOpenSign> tblTenderBidOpenSignList,List<TblTenderBidDetail> tblTenderBidDetailList) throws Exception{
    boolean bSuccess = false;    
    				/*** Code to insert row in TblBidderApprovalDetail by list **/
                tblBidderApprovalDetailDao.saveUpdateAllTblBidderApprovalDetail(tblBidderApprovalDetails);
                
                /*** Code to insert row in TblBidderApprovalDetail history table **/
                bSuccess = addBidderAprvalDtlsHist(tblBidderApprovalDetails);
                
                /*** Code to insert row in TblTenderOpen ,TblTenderBidOpenSign, TblTenderBidDetail **/
                if(tblTenderOpenList != null && !tblTenderOpenList.isEmpty() )
                	addTenderBidOpenDetails(tblTenderOpenList, tblTenderBidOpenSignList, tblTenderBidDetailList);
               	if(tblTenderBidOpenSignList != null && !tblTenderBidOpenSignList.isEmpty() &&
               	tblTenderBidDetailList != null && !tblTenderBidDetailList.isEmpty()){
               		addTenderBidOpenDetails(tblTenderOpenList, tblTenderBidOpenSignList, tblTenderBidDetailList);//hardcode	 
                }
                
                
        return bSuccess;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addTenderBidOpenDetails(List<TblTenderopen> tblTenderOpenList, List<TblTenderBidOpenSign> tblTenderBidOpenSignList, List<TblTenderBidDetail> tblTenderBidDetailList) throws Exception {
        boolean bSuccess = false;
        if(!tblTenderOpenList.isEmpty())
        	tblTenderOpenDao.saveUpdateAllTblTenderOpen(tblTenderOpenList);
        if(!tblTenderBidDetailList.isEmpty() && !tblTenderBidDetailList.isEmpty()){//hardcode
        	tblTenderBidOpenSignDao.saveUpdateAllTblTenderBidOpenSign(tblTenderBidOpenSignList);
        	tblTenderBidDetailDao.saveUpdateAllTblTenderBidDetail(tblTenderBidDetailList);
        }
        bSuccess = true;
        return bSuccess;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBidderAprvalDtlsHist(List<TblBidderApprovalDetail> tblBidderApprovalDetails) throws Exception{
        boolean bSuccess = false; 
        
        List<TblBidderApprovalHistory> tblBidderAprvlHistList = new ArrayList<TblBidderApprovalHistory>();
        
        for(TblBidderApprovalDetail tblBidderApprovalDtls:tblBidderApprovalDetails){
	       	 TblBidderApprovalHistory tblBidderAprvlHist = new TblBidderApprovalHistory();
	       	 //tblBidderAprvlHist.setBidderApprovalHistoryId();
	       	 tblBidderAprvlHist.setTenderid(tblBidderApprovalDtls.getTblTender().getTenderId());
	       	tblBidderAprvlHist.setEnvelopeid(tblBidderApprovalDtls.getTblTenderenvelope().getEnvelopeId());
	       	 tblBidderAprvlHist.setCompanyid(tblBidderApprovalDtls.getCompanyid());
	       	 tblBidderAprvlHist.setBidderid(tblBidderApprovalDtls.getBidderid());
	//       	 tblBidderAprvlHist.setUserDetailId(tblBidderApprovalDtls.getTblUserDetail().getUserDetailId());
	       	 tblBidderAprvlHist.setFinalsubmissionid(tblBidderApprovalDtls.getTblFinalsubmission().getFinalsubmissionid());
	       	 tblBidderAprvlHist.setRemarks(tblBidderApprovalDtls.getRemarks());
	       	 tblBidderAprvlHist.setCreatedby(tblBidderApprovalDtls.getCreatedby());
	       	 tblBidderAprvlHist.setIsapproved(tblBidderApprovalDtls.getIsapproved());
	       	 
	       	 tblBidderAprvlHistList.add(tblBidderAprvlHist);
        }
        tblBidderApprovalHistoryDao.saveUpdateAllTblBidderApprovalHistory(tblBidderAprvlHistList);
        bSuccess=true;        
        return bSuccess;

    }
    @Transactional
    public boolean getApprovedFormCount(int tenderId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        long count = hibernateQueryDao.countForNewQuery("TblTenderForm tbltenderform ","tbltenderform.formId ","tbltenderform.tblTender.tenderId=:tenderId and tbltenderform.cstatus=1",var);
        return count!=0;
    }
    @Transactional
    public List<Object[]> getProxyColumnData(int tenderId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append("select b.tableId,c.columnId,d.cellId,d.rowId from tbl_tenderform a inner join tbl_TenderTable b on a.formId=b.formId ");
        query.append(" inner join  tbl_TenderColumn c on b.tableId=c.tableId and c.filledBy=4 ");
        query.append(" inner join tbl_tendercell d on c.columnId=d.columnId where a.tenderId=:tenderId  and a.cstatus = 1 ");
        return hibernateQueryDao.createSQLQuery(query.toString(),var);        
    }
  /*  @Transactional
    public List<Object[]> getRebateByTenderNCompanyId(int tenderId,int companyId) throws Exception{
        StringBuilder query = new StringBuilder();
   	 Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        query.append("select tblrebate.rebateId,tblrebate.reportName,tblrebate.isRebateForm,COALESCE(tbltenderrebate.tenderRebateId,0) ")
        .append("from TblRebate tblrebate ")
        .append("left join tblrebate.tblTenderRebate tbltenderrebate ")
        .append("where tblrebate.tblTender.tenderId = :tenderId AND tbltenderrebate.tblCompany.companyid = :companyId");
        
        return hibernateQueryDao.createNewQuery(query.toString(),var);
    }*/
    @Transactional
    public TblTenderRebate getTblTenderRebate(int tenderId,int companyId) throws Exception {
        List<TblTenderRebate> list = null;
        list = tblTenderRebateDao.findTblTenderRebate("tblTender.tenderId", Operation_enum.EQ, tenderId,"tblCompany.companyid", Operation_enum.EQ, companyId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    @Transactional
    public List<TblTenderRebate> getTblTenderRebate(int tenderId) throws Exception {
       return tblTenderRebateDao.findTblTenderRebate("tblTender.tenderId", Operation_enum.EQ, tenderId);
    }
    @Transactional
    public TblRebate getTblRebate(int tenderId) throws Exception {
        List<TblRebate> list = null;
        list = tblRebateDao.findTblRebate("tblTender.tenderId", Operation_enum.EQ, tenderId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    
    @Transactional
    public List<Object[]> getRebateByTenderNCompanyId(int tenderId,int companyId) throws Exception{
        StringBuilder query = new StringBuilder();
   	 Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        query.append("select tblrebate.rebateId,tblrebate.reportName,tblrebate.isRebateForm ")
        .append("from TblRebate tblrebate ")
        .append("left join tblrebate.tblTenderRebate tbltenderrebate ")
        .append("where tblrebate.tblTender.tenderId = :tenderId AND tbltenderrebate.tblCompany.companyid = :companyId");
        
        return hibernateQueryDao.createNewQuery(query.toString(),var);
    }
    
    @Transactional
    public List<Object[]> getRebateList(int tenderId,int bidderId) throws Exception{
    	StringBuilder query = new StringBuilder();
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
//        var.put("rebateId",rebateId);
        var.put("tenderId",tenderId);    
        var.put("bidderId",bidderId);        
        query.append(" SELECT tbltenderform.formName,tbltendetable.tablename,tbltendeColumn.columnHeader,tblTenderCellGrandTotal.GTvalue,tbltenderbidmatrix.bidID ,tbltendeColumn.columnId");
        query.append(" from tbl_tendercellgrandtotal  tblTenderCellGrandTotal");
        query.append(" inner join tbl_tenderform tbltenderform on tblTenderCellGrandTotal.formId = tbltenderform.formId");
        query.append(" inner join tbl_tendertable tbltendetable on tblTenderCellGrandTotal.tableId = tbltendetable.tableId");
        query.append(" inner join tbl_tendercolumn tbltendeColumn on tblTenderCellGrandTotal.columnId = tbltendeColumn.columnId AND tbltendeColumn.isPriceSummary = 1");
        query.append(" inner join tbl_tenderbidmatrix tbltenderbidmatrix on tbltenderbidmatrix.tableId = tbltendetable.tableId");
        query.append(" inner join tbl_tenderbid tbltenderbid on tbltenderbidmatrix.bidID = tbltenderbid.bidID");
        query.append(" where tblTenderCellGrandTotal.tenderid =:tenderId and tblTenderCellGrandTotal.bidderId =:bidderId and tbltenderform.isPriceBid = 1 and tbltenderbid.cstatus = 2");
        query.append(" group by tbltendeColumn.columnId");
        
        list = hibernateQueryDao.createSQLQuery(query.toString(),var);                
        return list;        

    }
    @Transactional
    public TblTenderForm getTenderFormById(int formId) throws Exception {
        List<TblTenderForm> list = null;
        list = tblTenderFormDao.findTblTenderForm(FORMID, Operation_enum.EQ, formId);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    
    
    @Transactional
    public List<Object[]> getColumnById(int formId,List<Object> columnIds) throws Exception {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        StringBuilder query = new StringBuilder();
        List<Object[]> list = new ArrayList<Object[]>();
        query.append(" SELECT DISTINCT TC.columnId,TC.tableId, TC.columnNo, TC.columnTypeId, TC.columnHeader, TC.filledBy, TC.isShown,TC.isCurrConvReq,TFF.displayFormula, TF.sortOrder, TF.formId  ");
        query.append(" FROM tbl_TenderColumn TC ");
        query.append(" INNER JOIN tbl_tenderform TF ON TC.formId = TF.formId ");
        query.append(" LEFT OUTER JOIN tbl_tenderformula TFF on TFF.columnId = TC.columnId  AND TFF.tableId= TC.tableId AND TFF.formId = TF.formId ");
        query.append(" WHERE TF.cstatus = 1  AND TF.formId =:formId ");
        if(columnIds!=null && !columnIds.isEmpty()){
        	var.put("columnIds",columnIds);
        	query.append(" AND TC.columnId IN (:columnIds)");
        }
        query.append(" ORDER BY TF.sortOrder,TC.tableId,TC.columnNo");
        list = hibernateQueryDao.createSQLQuery(query.toString(),var);
        return list;
    } 
    
    @Transactional
    public List<Object[]> getBidderById(int tenderId,int envelopeId,int formId,int envelopeSortOrder,int previousEnvelopeId,int tenderStage,List<Object> bidderIds) throws Exception {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("formId",formId);
        StringBuilder query = new StringBuilder();
        query.append(" SELECT DISTINCT FS.companyId,FS.bidderId, Tc.companyName,TBC.encodedName ");
        query.append(" FROM tbl_finalsubmission FS ");
        query.append(" INNER JOIN tbl_tenderform TF ON TF.tenderId = FS.tenderId ");
        query.append(" inner join tbl_company TC on TC.companyId = FS.companyId ");
        query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderID = FS.tenderId AND TOA.formId = TF.formId AND FS.bidderId = TOA.bidderId and TOA.decryptionLevel = 1  ");
        if(envelopeSortOrder > 1 && tenderStage == 2){
        	var.put("previousEnvelopeId",previousEnvelopeId);
        	query.append(" INNER JOIN Tbl_BidderApprovalDetail BAD ON BAD.envelopeId =:previousEnvelopeId AND BAD.finalSubmissionId = FS.finalSubmissionId AND BAD.isApproved = 1");
        }
        query.append(" INNER JOIN tbl_TenderBidConfirmation TBC on TBC.tenderId = FS.tenderId AND TBC.bidderId = FS.bidderId");
        query.append(" WHERE FS.tenderId =:tenderId AND FS.isActive = 1 AND TOA.formId =:formId");
        if(bidderIds!=null && !bidderIds.isEmpty()){
        	var.put("bidderIds",bidderIds);
        	query.append(" AND FS.bidderId IN (:bidderIds)");
        }
        return hibernateQueryDao.createSQLQuery(query.toString(),var);
    } 
    
    @Transactional
    public List<Object[]> getTenderCellById(int formId,List<Object> columnIds,List<Object> rowIds) throws Exception {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        StringBuilder query = new StringBuilder();
        query.append(" SELECT  TCC.cellId,TCC.formId, TCC.tableId, TCC.columnId, TCC.rowId, TCC.cellValue, TCC.cellNo, TCC.dataType ");
        query.append(" FROM tbl_tendercell TCC");
        query.append(" INNER JOIN tbl_tenderform TF ON TCC.formId = TF.formId ");
        query.append(" INNER JOIN tbl_TenderColumn TC on TCC.columnId = TC.columnId  ");
        query.append(" WHERE TF.cstatus = 1 AND TF.formId =:formId ");
        if(columnIds!=null && !columnIds.isEmpty()){
        	var.put("columnIds",columnIds);
        	query.append(" AND TC.columnId IN (:columnIds)");
        }
        if(rowIds!=null && !rowIds.isEmpty()){
        	var.put("rowIds",rowIds);
        	query.append(" AND TCC.rowId IN (:rowIds)");
        }
        query.append(" ORDER BY TCC.tableId, TCC.rowId,TC.columnNo ");
        return hibernateQueryDao.createSQLQuery(query.toString(),var);
    } 
    @Transactional
    public List<Object[]> getTenderFormById(int formId,int isPriceBid) throws Exception {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        if(isPriceBid != -1){
        	var.put("isPriceBid",isPriceBid);
        }
        StringBuilder query = new StringBuilder();
        query.append(" SELECT tblTenderForm.formId,tblTenderForm.formName,tblTenderForm.formHeader,tblTenderForm.formFooter,tblTenderForm.isPriceBid,tblTenderForm.isMultipleFilling,tblTenderForm.tblTenderEnvelope.envelopeId ");
        query.append(" from TblTenderForm tblTenderForm");
        query.append(" where tblTenderForm.formId=:formId and tblTenderForm.cstatus=1");
        if(isPriceBid != -1){
        	query.append(" and tblTenderForm.isPriceBid=:isPriceBid");
        }
        query.append(" ORDER BY tblTenderForm.sortOrder");
        return hibernateQueryDao.createNewQuery(query.toString(),var);
    }    
    @Transactional
    public List<Object[]> getTenderTableById(int formId) throws Exception {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        return hibernateQueryDao.createNewQuery("SELECT tblTenderTable.tableId,tblTenderTable.tableName,tblTenderTable.formId,tblTenderTable.tableName,tblTenderTable.tableHeader,tblTenderTable.tableFooter,tblTenderTable.noOfRows,tblTenderTable.noOfCols,tblTenderTable.isMultipleFilling,tblTenderTable.hasGTRow,tblTenderTable.sortOrder from TblTenderTable tblTenderTable where tblTenderTable.formId=:formId",var);
    }    
    

    @Transactional
    public List<TblTenderTable> getTenderTableByFormId(int formId) throws Exception {
        List<TblTenderTable> list = null;
        list = tblTenderTableDao.findTblTenderTable("formId", Operation_enum.EQ,formId,"tableId",Operation_enum.ORDERBY, Operation_enum.ASC);
        return list;

    }
    @Transactional
    public List<Object[]> getSelectedRowsForBidding(int formId,int companyId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        var.put("companyId",companyId);
        return hibernateQueryDao.createNewQuery("select tblitemselection.tblTenderTable.tableId, tblitemselection.rowId from TblItemSelection tblitemselection where tblitemselection.tblCompany.companyid=:companyId and tblitemselection.tblTenderForm.formId=:formId and tblitemselection.isSelected=1",var);                
    }
    @Transactional
    public List<TblTenderBidMatrix> getTenderBidMatrixByBidId(int bidId) throws Exception {
        List<TblTenderBidMatrix> list = null;
        list = tblTenderBidMatrixDao.findTblTenderBidMatrix("tblTenderbid", Operation_enum.EQ, new TblTenderBid(bidId));
        return list;

    }
    
    /*
     @Transactional
     public List<Object[]> getBidderItem(int tenderId,int userId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("userId",userId);
        list = hibernateQueryDao.createNewQuery("select tblitembiddermap.tblTenderTable.tableId,tblitembiddermap.rowId from  TblItemBidderMap tblitembiddermap  inner join  tblitembiddermap.tblTenderBidderMap tbltenderbiddermap where tbltenderbiddermap.tblTender.tenderId=:tenderId and tbltenderbiddermap.tblUserLogin.userId=:userId",var);                
        return list;        

	}*/
    @Transactional
    public int getLastEnvelopeId(int tenderId) throws Exception{
        int data=0;
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        list = hibernateQueryDao.getSingleColQuery("SELECT tblTenderEnvelope.envelopeId FROM TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId=:tenderId Order by tblTenderEnvelope.sortOrder desc",var);
        if(list != null && ! list.isEmpty()){
        	data = Integer.parseInt(list.get(0).toString());
        }
        return data;

    }
    
    @Transactional
    public List<Object[]> getFormulaColId(int tableId) throws Exception {
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tableId", tableId);
        list = hibernateQueryDao.createNewQuery("select tbltenderformula.tblTenderColumn.columnId, tbltenderformula.cellId, tbltenderformula.formula,tbltenderformula.formulaId, tbltenderformula.displayFormula,tbltenderformula.columnNo,tbltenderformula.validationMessage,tbltenderformula.formulaType,tbltenderformula.cellNo from TblTenderFormula tbltenderformula where tbltenderformula.tblTenderTable.tableId=:tableId", var);
        return list;

    }
    @Transactional
    public List<TblTenderColumn> getTenderColumnByTableId(int tableId) throws Exception {
        return tblTenderColumnDao.findTblTenderColumn("tblTenderTable", Operation_enum.EQ, new TblTenderTable(tableId), "sortOrder", Operation_enum.ORDERBY, Operation_enum.ASC);
    }
    @Transactional
    public List<Object[]> getProxyCellData(int tableId,int companyId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tableId",tableId);
        var.put("companyId",companyId);
        list = hibernateQueryDao.createNewQuery("select tbltenderproxybid.tblTenderCell.cellId, tbltenderproxybid.cellValue from TblTenderProxyBid tbltenderproxybid where tbltenderproxybid.tblCompany.companyid=:companyId and tbltenderproxybid.tblTenderTable.tableId=:tableId",var);                
        return list;        

    }
    @Transactional
    public String getTableJson(int tableId) throws Exception {
        String data = null;
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tableId", tableId);
        list = hibernateQueryDao.getSingleColQuery("select tbltendermatrixjson.jsonData from TblTenderMatrixJson tbltendermatrixjson where tbltendermatrixjson.tblTenderTable.tableId=:tableId", var);
        if (!list.isEmpty()) {
            data = list.get(0).toString().replace("\\r\\n", "<br/>");
        }
        return data;
    }
    
    public List<TblTenderCell> _toCellMasters(String json) throws JSONException {
        List<TblTenderCell> cellMasters = new ArrayList<TblTenderCell>();
        if (json != null && !json.isEmpty()) {
            JSONArray jsonArray = new JSONArray(json);
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jSONObject = jsonArray.getJSONObject(i);
                for (Iterator it = jSONObject.keys(); it.hasNext();) {
                    String key = it.next().toString();
                    String[] values = key.split("_");
                    cellMasters.add(new TblTenderCell(Integer.parseInt(values[6]), Integer.parseInt(values[0]), new TblTenderColumn(Integer.parseInt(values[5])), Integer.parseInt(values[3]), Integer.parseInt(values[2]), new TblTenderTable(Integer.parseInt(values[4])), jSONObject.getString(key),values.length==8 ? Integer.parseInt(values[7]) : 0));
                }
            }
        }
        return cellMasters;
    }
    public HttpServletRequest getServletRequest() {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attr.getRequest();
    }
    @Transactional
    public void setViewFormNFormula(int formId, Map<String, Object> modelMap, int tenderId,int userId) throws Exception {
    	List<Integer> tableIds = new ArrayList<Integer>();
        TblTenderForm tblTenderForm = getTenderFormById(formId);
        modelMap.put("tblTenderForm", tblTenderForm);
        modelMap.put("formName", tblTenderForm.getFormName());
        modelMap.put("formHeader", tblTenderForm.getFormHeader());
        modelMap.put("formFooter", tblTenderForm.getFormFooter());
        modelMap.put("noOfTables", tblTenderForm.getNoOfTables());
        modelMap.put("itemsToLoad", tblTenderForm.getLoadNoOfItems());
        modelMap.put("itemsIncremental", tblTenderForm.getIncrementItems());
        modelMap.put("encryptionReq", tblTenderForm.getIsEncryptionReq());
        modelMap.put("itemWiseDocAllowed",tblTenderForm.getIsItemWiseDocAllowed()==1?true:false);
        List<TblTenderTable> tables = getTenderTableByFormId(formId);
        /*if(tables.size()>0)
        	{
        		Collections.sort(tables);
        	}*/
        List<Object[]> visibleRows = new ArrayList<Object[]>();
        List<SelectItem> currency = null;
        Set<Integer> comboBoxs = new HashSet<Integer>();
        Set<Integer> listBoxs = new HashSet<Integer>();
        Set<Integer> masterFields = new HashSet<Integer>();
        List<Integer> formulaColId = new ArrayList<Integer>();        
        List<Integer> emdColId = new ArrayList<Integer>();
        List<Integer> emdColOfficerId = new ArrayList<Integer>();
        List<Integer> participationColOfficerId = new ArrayList<Integer>();
        List<Integer> notEncrColId = new ArrayList<Integer>(); 
        List<Integer> docColId = new ArrayList<Integer>();
        List<Integer> docColOfficerId = new ArrayList<Integer>();
        List<Integer> processColId = new ArrayList<Integer>();        
        List<Integer> emdCellId = new ArrayList<Integer>(); 
        List<Integer> docCellOfficerId = new ArrayList<Integer>(); 
        List<Integer> emdCellOfficerId = new ArrayList<Integer>();
        List<Integer> participationCellOfficerId = new ArrayList<Integer>(); 
        List<Integer> notEncrCellId = new ArrayList<Integer>();
        List<Integer> docCellId = new ArrayList<Integer>();        
        List<Integer> processCellId = new ArrayList<Integer>();        
        List<Integer> formulaColNo = new ArrayList<Integer>();
        List<Integer> negotiationLoadingCells = new ArrayList<Integer>();
        List<Integer> negotiationLoadingColumns = new ArrayList<Integer>();
        List<Map<String, Object>> tableList = new ArrayList<Map<String, Object>>();   
        Map<Integer,String> proxyData = new HashMap<Integer, String>();
        int bidId = 0;
        boolean showDownload = true;
        boolean fromBidForm = false;
        boolean frombidfactor = false;
        boolean negotiationBuyerForLoading = false;
        boolean negotiationBidderForLoading = false;
        List<TblTenderBidMatrix> bidMatrixs = null;                        
//        List<TblMasterBid> masterBids = null;             
        if(modelMap.get("fromBidForm")!=null){
            fromBidForm = (Boolean)modelMap.get("fromBidForm");            
        }
        if(modelMap.get("negotiationBuyerForLoading")!=null){ 		//Start CR : 25886
        	negotiationBuyerForLoading = (Boolean)modelMap.get("negotiationBuyerForLoading");            
        }
        if(modelMap.get("negotiationBidderForLoading")!=null){
        	negotiationBidderForLoading = (Boolean)modelMap.get("negotiationBidderForLoading");            
        }
        if(modelMap.get("isItemSelectionPageRequired")!=null && (Integer) modelMap.get("isItemSelectionPageRequired")==1){
            if(tblTenderForm.getIsPriceBid()==1){
               visibleRows = getSelectedRowsForBidding(formId, (Integer) modelMap.get("companyId"));
            }else{
                modelMap.put("isItemSelectionPageRequired", 0);
            }
        }else{            
            modelMap.put("isItemSelectionPageRequired", 0);
        }
        if(modelMap.get("bidId")!=null && (Integer)modelMap.get("bidId")!=0){
            bidId = (Integer)modelMap.get("bidId");
            bidMatrixs = getTenderBidMatrixByBidId(bidId);
        }
        if(fromBidForm && bidId==0 && tblTenderForm.getMasterFormId()!=0){
//            masterBids = masterFormService.getMasterBid(tblTenderForm.getMasterFormId(),(Integer) modelMap.get("companyId"));
        }
        if(modelMap.get("frombidfactor")!=null){
            frombidfactor = (Boolean)modelMap.get("frombidfactor");            
        }
        boolean isBidRowLimited = false;
        List<Object[]> bidTableRow = null;
        //Below Condition Modified Because of bug id : #25751
        if(fromBidForm && ((Integer)modelMap.get("tenderMode")==2 || (Integer)modelMap.get("tenderMode")==3 || (Integer)modelMap.get("tenderMode")==4) && (Integer)modelMap.get("tenderResult")==2 && tblTenderForm.getIsPriceBid()==1){
            isBidRowLimited = true;
            bidTableRow = getBidderItem(tenderId, (Integer)modelMap.get("bidderId"));
        }    
        int isFillByBidder = 0;
        modelMap.put("isBidRowLimited", isBidRowLimited);
        for (TblTenderTable tenderTable : tables) {
            Map<String, Object> tableInfo = new HashMap<String, Object>();
            boolean isGTWise = tenderTable.getHasGTRow() == 1;
            List<Object[]> allFormula = getFormulaColId(tenderTable.getTableId());
            for (Object[] formula : allFormula) {
                if (formula[2].toString().startsWith(TOTAL)) {
                    formulaColId.add((Integer) formula[0]);
                    formulaColNo.add((Integer) formula[5]);
                }
            }            
            if(bidId!=0){
                List<String> bidDatas = new ArrayList<String>();
                List<String> bidTableIds = new ArrayList<String>();
                List<Object[]> itemWiseDocs = new ArrayList<Object[]>();
                Map<String,List<Object[]>> docMap = new HashMap<String, List<Object[]>>();
                for (TblTenderBidMatrix tblTenderBidMatrix : bidMatrixs) {
                      if(tblTenderBidMatrix.getTblTendertable().getTableId() == tenderTable.getTableId()){
                          bidDatas.add(tblTenderBidMatrix.getBidjson());
                          bidTableIds.add(String.valueOf(tblTenderBidMatrix.getBidtableid()));
                          itemWiseDocs = getItemWiseDocs(tblTenderBidMatrix.getBidtableid());
                          for(Object[] docs : itemWiseDocs){
                        	  List<Object[]> list = null;
                        	  if(docMap.containsKey(docs[1].toString()+"_"+docs[3].toString())){
                        		 list = docMap.get(docs[1].toString()+"_"+docs[3].toString());                        		 
                        	  }else{
                        		  list = new ArrayList<Object[]>();                        		  
                        	  }
                        	  if(list!=null){
	                        	  list.add(docs);
	                     		  docMap.put(docs[1].toString()+"_"+docs[3].toString(), list);
                        	  }
                          }
                      }
                }
                tableInfo.put("bidData", bidDatas);
                tableInfo.put("bidTableId", bidTableIds);
                tableInfo.put("itemWiseDocs", docMap);
            }
            List<Integer> visibleRow = new ArrayList<Integer>();
            for (Object[] rows : visibleRows) {
                if((Integer)rows[0] == tenderTable.getTableId()){
                    visibleRow.add((Integer)rows[1]);
                }
            }
            tableInfo.put("visibleRow", visibleRow);
            tableInfo.put("rowcount", isGTWise ? (tenderTable.getNoOfRows() - 1) : tenderTable.getNoOfRows());
            tableInfo.put("multipleFill", tenderTable.getIsMultipleFilling());
            tableInfo.put("colcount", tenderTable.getNoOfCols());
            tableInfo.put("tableName", tenderTable.getTableName());
            tableInfo.put("tableHeader", tenderTable.getTableHeader());
            tableInfo.put("tableFooter", tenderTable.getTableFooter());
            tableInfo.put(TABLEID, tenderTable.getTableId());
            tableIds.add(tenderTable.getTableId());
            tableInfo.put("formulaColId", formulaColId);
            tableInfo.put("formulaColNo", formulaColNo);
            tableInfo.put("isGTWise", isGTWise);
            tableInfo.put("formulas", allFormula);
            tableInfo.put("isPartialFillingAllowed", tenderTable.getIsPartialFillingAllowed());
            tableInfo.put("isMandatory", tenderTable.getIsMandatory());
            List<TblTenderColumn> columns = getTenderColumnByTableId(tenderTable.getTableId());
            boolean isCurrency = false;
            boolean hasProxyCol = false;
            StringBuilder colFilledBy = new StringBuilder();
            for (TblTenderColumn tblTenderColumn : columns) {
	            	if(negotiationBuyerForLoading==true || negotiationBidderForLoading==true) //For Negotiation Loading Factor Condition  //Start CR : 25886
	            	{
	            		if(tblTenderColumn.getTblColumnType().getColumnTypeId()==23 || tblTenderColumn.getTblColumnType().getColumnTypeId()==26 || tblTenderColumn.getTblColumnType().getColumnTypeId()==27){
	            			tblTenderColumn.setIsShown(1);
	            			if(negotiationBidderForLoading==true){
	                			negotiationLoadingColumns.add(tblTenderColumn.getColumnId());
	                		}
	            		}
	            		tableInfo.put("negotiationLoadingColumns", negotiationLoadingColumns);
	            	}
	            	 //End CR : 25886
                colFilledBy.append("'").append(tblTenderColumn.getColumnNo()).append("@@").append(tblTenderColumn.getFilledBy()).append("_").append(tblTenderColumn.getTblColumnType().getColumnTypeId()).append("_").append(tblTenderColumn.getIsShown()).append("'").append(",");
                if (tblTenderColumn.getTblColumnType().getColumnTypeId() == 8) {
                    isCurrency = true;                    
                }
//                for (Integer columnId : formulaColId) {
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == processingFeesId) {
                        processColId.add(tblTenderColumn.getColumnId());
                    }            
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == documentFeesId) {
                        docColId.add(tblTenderColumn.getColumnId());
                        isFillByBidder=1;
                    }
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == documentFeesByOfficerId) {
                        docColOfficerId.add(tblTenderColumn.getColumnId());
                        isFillByBidder=2;
                    }  
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == emdAmountId) {
                        emdColId.add(tblTenderColumn.getColumnId());
                        isFillByBidder=1;
                    }
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == emdAmountByOfficerId) {
                        emdColOfficerId.add(tblTenderColumn.getColumnId());
                        isFillByBidder=2;
                    }
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == participationFeesByOfficerId) {
                    	participationColOfficerId.add(tblTenderColumn.getColumnId());
                        isFillByBidder=2;
                    }
                    
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == notEncrReqId) {
                        notEncrColId.add(tblTenderColumn.getColumnId());
                    }
                    
                    if (tblTenderColumn.getTblColumnType().getColumnTypeId() == loadingFactor && tblTenderColumn.getFilledBy() == 4) {
                    	if(modelMap.containsKey("loadingFactorForm"))
                    	{
                    		Map<Object,Object> loadingFactorForm = (Map<Object, Object>) modelMap.get("loadingFactorForm");
                    		loadingFactorForm.put(tblTenderColumn.getTblTenderForm().getFormId(), tblTenderColumn.getTblTenderForm().getFormId());
                    	}else{
                    		Map<Object,Object> loadingFactorForm = new HashMap<Object, Object>();
                    		loadingFactorForm.put(tblTenderColumn.getTblTenderForm().getFormId(), tblTenderColumn.getTblTenderForm().getFormId());
                    		modelMap.put("loadingFactorForm",loadingFactorForm);
                    	}
                    	if(modelMap.containsKey("loadingFactorTable"))
                    	{
                    		Map<Object,Object> loadingFactorTable= (Map<Object, Object>) modelMap.get("loadingFactorTable");
                    		loadingFactorTable.put(tblTenderColumn.getTblTenderTable().getTableId(), tblTenderColumn.getTblTenderTable().getTableId());
                    	}else{
                    		Map<Object,Object> loadingFactorTable = new HashMap<Object, Object>();
                    		loadingFactorTable.put(tblTenderColumn.getTblTenderTable().getTableId(), tblTenderColumn.getTblTenderTable().getTableId());
                    		modelMap.put("loadingFactorTable",loadingFactorTable);
                    	}
                    }
//                }
                if (tblTenderColumn.getFilledBy() == proxy) {
                    hasProxyCol = true;                    
                }
                if((isFillByBidder==1 ||  isFillByBidder == 2) && modelMap.get("companyId")!=null ){
//                	List <TblEventFees> lstTenderFees= new ArrayList<TblEventFees>();
                	if(bidId!=0){
//                		lstTenderFees = getTenderFeesPaymentDetail(tenderId,(Integer)modelMap.get("companyId"),formId, tblTenderColumn.getTblTenderTable().getTableId(),-1, bidId,0);
                	}else{
//                    		lstTenderFees = getTenderFeesPaymentDetail(tenderId,(Integer)modelMap.get("companyId"),formId, tblTenderColumn.getTblTenderTable().getTableId(),-1, 0,0);	
                	}
                		/*if(lstTenderFees!=null && !lstTenderFees.isEmpty()  ){
            			  Map<String,Integer> rowId = new HashMap<String,Integer>();
	            			for (TblEventFees tblTenderFees :lstTenderFees){
	            					rowId.put(tblTenderFees.getRowId()+"_"+tblTenderFees.getFeeType(),tblTenderFees.getFeeType());
	            			}
	            			modelMap.put("rowId",rowId);
            			}*/
            		}
            }
            if (colFilledBy.length() != 0) {
                tableInfo.put("colFilledBy", colFilledBy.delete(colFilledBy.length() - 1, colFilledBy.length()));                
            }
            if(hasProxyCol && (fromBidForm || frombidfactor)){
                List<Object[]> proxyColData = getProxyCellData(tenderTable.getTableId(), (Integer)modelMap.get("companyId"));                                
                JSONArray jSONArray = new JSONArray();        
                for (int i=0;i<proxyColData.size();i++) {
                    Object[] proxyD = proxyColData.get(i);
                    JSONObject jSONObject = new JSONObject();
                    jSONObject.put(proxyD[0].toString(),proxyD[1].toString());
                    if(frombidfactor){
                        proxyData.put((Integer)proxyD[0], proxyD[1].toString());
                    }
                    jSONArray.put(i, jSONObject);
                }
                tableInfo.put("proxyData", jSONArray.toString());
                tableInfo.put("cellValueProxyData",proxyData); //For NegotiationHistory  //Start CR : 25886
            }
            if (isCurrency) {
                showDownload=false;
                tableInfo.put("tenderCurrency", currency);
            }
            tableInfo.put("columns", columns);
            if (!columns.isEmpty()) {
//                    List<TblTenderCell> cells = getCellMasterByTableId(tenderTable.getTableId(), isGTWise ? (rowCount) : 0);
                String tableJson = getTableJson(tenderTable.getTableId());                
                tableInfo.put("tableJson", tableJson);
                List<TblTenderCell> cells = _toCellMasters(tableJson);
                List<TblTenderCell> bidcells = new ArrayList<TblTenderCell>();
                Set<Integer>  bidderRow = new TreeSet<Integer>();                                
                for (TblTenderCell tenderCell : cells) {
                	
                	if(negotiationBidderForLoading==true) //For Negotiation Loading Factor Condition  Start CR : 25886
                	{
                		for(Integer column :negotiationLoadingColumns){
                			if(column==tenderCell.getTblTenderColumn().getColumnId()){
                				negotiationLoadingCells.add(tenderCell.getCellId());
                			}
                		}
                		tableInfo.put("negotiationLoadingCells", negotiationLoadingCells);
                	}  //End CR : 25886
                	if(isBidRowLimited && bidTableRow!=null){
                        for (Object[] bidcell: bidTableRow) {
                            if((Integer)bidcell[0] == tenderTable.getTableId() && (Integer)bidcell[1] == tenderCell.getRowId()){                                
                                bidderRow.add(tenderCell.getRowId());
                                bidcells.add(tenderCell);
                            }
                        }
                        if(isGTWise && tenderTable.getNoOfRows() == tenderCell.getRowId()){
                            bidderRow.add(tenderCell.getRowId());
                            bidcells.add(tenderCell);
                        }
                    }
                    if(tenderCell.getDataType()==combobox){
                        comboBoxs.add(tenderCell.getObjectId());
                    }else if(tenderCell.getDataType()==masterField){                        
                        masterFields.add(tenderCell.getObjectId());
                    }else if(tenderCell.getDataType()==listBox){                        
                        listBoxs.add(tenderCell.getObjectId());
                    }
                    for (Integer emd : emdColId) {
                        boolean gotGTCell = false;
                        if(formulaColId.contains(emd) && tenderCell.getTblTenderColumn().getColumnId() == emd) {
                            if(tenderCell.getDataType()==0){
                                emdCellId.add(tenderCell.getCellId());
                            }
                            gotGTCell=true;
                        }
                        if(!gotGTCell){
                            if(tenderCell.getTblTenderColumn().getColumnId() == emd){
                                emdCellId.add(tenderCell.getCellId());
                            }
                        }
                    }
                    for (Integer emd : emdColOfficerId) {
                        boolean gotGTCell = false;
                        if(formulaColId.contains(emd) && tenderCell.getTblTenderColumn().getColumnId() == emd) {
                            if(tenderCell.getDataType()==0){
                                emdCellOfficerId.add(tenderCell.getCellId());
                            }
                            gotGTCell=true;
                        }
                        if(!gotGTCell){
                            if(tenderCell.getTblTenderColumn().getColumnId() == emd){
                            	emdCellOfficerId.add(tenderCell.getCellId());
                            }
                        }
                    }
                    for (Integer participation : participationColOfficerId) {
                        boolean gotGTCell = false;
                        if(formulaColId.contains(participation) && tenderCell.getTblTenderColumn().getColumnId() == participation) {
                            if(tenderCell.getDataType()==0){
                                participationCellOfficerId.add(tenderCell.getCellId());
                            }
                            gotGTCell=true;
                        }
                        if(!gotGTCell){
                            if(tenderCell.getTblTenderColumn().getColumnId() == participation){
                            	participationCellOfficerId.add(tenderCell.getCellId());
                            }
                        }
                    }
                    
                    for (Integer doc : docColId) {
                        boolean gotGTCell = false;
                        if(formulaColId.contains(doc) && tenderCell.getTblTenderColumn().getColumnId() == doc) {
                            if(tenderCell.getDataType()==0){
                                docCellId.add(tenderCell.getCellId());
                            }
                            gotGTCell=true;
                        }
                        if(!gotGTCell){
                            if(tenderCell.getTblTenderColumn().getColumnId() == doc){
                                docCellId.add(tenderCell.getCellId());
                            }
                        }
                    }
                    for (Integer doc : docColOfficerId) {
                        boolean gotGTCell = false;
                        if(formulaColId.contains(doc) && tenderCell.getTblTenderColumn().getColumnId() == doc) {
                            if(tenderCell.getDataType()==0){
                                docCellOfficerId.add(tenderCell.getCellId());
                            }
                            gotGTCell=true;
                        }
                        if(!gotGTCell){
                            if(tenderCell.getTblTenderColumn().getColumnId() == doc){
                            	docCellOfficerId.add(tenderCell.getCellId());
                            }
                        }
                    }
                    
                    for (Integer process : processColId) {
                        boolean gotGTCell = false;
                        if(formulaColId.contains(process) && tenderCell.getTblTenderColumn().getColumnId() == process) {
                            if(tenderCell.getDataType()==0){                                
                                processCellId.add(tenderCell.getCellId());
                            }
                            gotGTCell=true;
                        }
                        if(!gotGTCell){
                            if(tenderCell.getTblTenderColumn().getColumnId() == process){
                                processCellId.add(tenderCell.getCellId());
                            }
                        }
                    }
                    for (Integer nonEnc : notEncrColId) {
                        if(tenderCell.getTblTenderColumn().getColumnId() == nonEnc) {
                             notEncrCellId.add(tenderCell.getCellId());
                        }
                    }
                }
                Object[] bd =  bidderRow.toArray();
                Set<Integer>  bidderRowFinal = new TreeSet<Integer>();                
                for (int i = 0; i < bd.length; i++) {
                    if(i>=tblTenderForm.getLoadNoOfItems()){
                        bidderRowFinal.add((Integer)bd[i]);
                    }                    
                }
                tableInfo.put("bidderRow", bidderRowFinal);                
                tableInfo.put("emdCellId", emdCellId);
                tableInfo.put("notEncrCellId", notEncrCellId);
                tableInfo.put("docCellId", docCellId);
                tableInfo.put("processCellId", processCellId);
                tableInfo.put("emdCellOfficerId", emdCellOfficerId);
                tableInfo.put("participationCellOfficerId", participationCellOfficerId);
                tableInfo.put("docCellOfficerId", docCellOfficerId);
                if(isBidRowLimited){                    
                    int bidCellCnt=0;
                    for (Object[] bidcell: bidTableRow) {
                        if((Integer)bidcell[0] == tenderTable.getTableId()){
                               bidCellCnt++;
                        }
                    }    
                    tableInfo.put("rowcount", bidCellCnt);//todo
                    tableInfo.put("cells", bidcells);
                }else{                    
                    tableInfo.put("cells", cells);
                }
            }
            if(fromBidForm && bidId==0 && tblTenderForm.getMasterFormId()!=0){
                List<String> bidDatas = new ArrayList<String>();
                /*for (TblMasterBid masterBid : masterBids) {
                    if (masterBid.getTblTableMaster().getSortOrder() == tenderTable.getSortOrder()) {                        
                        bidDatas.add(replaceCellId(masterBid.getBidjson(),tableInfo.get("tableJson").toString()));
                    }
                }*/
                tableInfo.put("bidData", bidDatas);
                if(!bidDatas.isEmpty()){
                    modelMap.put("masterbid", true);
                }
            }
            tableList.add(tableInfo);
        }
        if(!comboBoxs.isEmpty()){            
//            modelMap.put("comboList", getComboDetailByComboId(comboBoxs.toArray()));
        }
        if(!proxyData.isEmpty()){            
            modelMap.put("proxyData", proxyData);
        }
        if(!listBoxs.isEmpty()){
            showDownload=false;
//            modelMap.put("listboxList", getComboDetailByComboId(listBoxs.toArray()));
        }
        if(!masterFields.isEmpty()){
            showDownload=false;
            HttpServletRequest request = getServletRequest();            
//            modelMap.put("masterFieldList", getBidderMasterFieldValue(userId,masterFields.toArray(),bidderMasterField)); 
        }
        // BPCL - doc upload/download for Tech Env - start
        if(tblTenderForm.getIsPriceBid()==0 && !tableIds.isEmpty()){
        	List<Object[]> lstDocumentDetails = new ArrayList<Object[]>();
        	if(lstDocumentDetails!=null && !lstDocumentDetails.isEmpty()){
        		modelMap.put("isItemWiseDocAvail", true);
                Map<String, List<Object[]>> docsMaps = new HashMap<String, List<Object[]>>();
            	for(Object[] objDocs : lstDocumentDetails){
            		List<Object[]> lstDocs = null;
            		if(docsMaps.containsKey(objDocs[1].toString()+"_"+objDocs[3].toString())){
            			lstDocs = docsMaps.get(objDocs[1].toString()+"_"+objDocs[3].toString()); 
            		}else{
            			lstDocs = new ArrayList<Object[]>();
            		}
            		lstDocs.add(objDocs);
            		docsMaps.put(objDocs[1].toString()+"_"+objDocs[3].toString(), lstDocs);
            	}
            	modelMap.put("listOfDocs", docsMaps);
        	}
        	else{
        		modelMap.put("isItemWiseDocAvail", false);
        	}
        }
        //BPCL - doc upload/download for Tech Env - End
        modelMap.put("showDownload", showDownload);
        modelMap.put("tableList", tableList);
        modelMap.put("isFillByBidder",isFillByBidder);
    }
    @Transactional
    private List<Object[]> getItemWiseDocs(int bidTableId){
   	 StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("bidTableId",bidTableId);
        List<Object[]> list = new ArrayList<Object[]>();
//        query.append("select tblbidderdocument.bidderDocId,tblbidderdocmapping.objectId,tblbidderdocument.description,tblbidderdocmapping.childId ")
//        		.append(" from TblBidderDocMapping tblbidderdocmapping ")
//        		.append(" inner join tblbidderdocmapping.tblBidderDocument tblbidderdocument ")
//        		.append(" where tblbidderdocmapping.cstatus=1 and tblbidderdocmapping.objectId=:bidTableId and tblbidderdocmapping.tblLink.linkId=808");
//        return hibernateQueryDao.createNewQuery(query.toString(),var);
        		return list;
   }
    @Transactional
    public List<Object[]> getTenderEnvelopeForPublish(int tenderId,boolean... isForResultSharing) throws Exception{
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDER_ID,tenderId);
        query.append("select distinct tblTenderEnvelope.envelopeId,tblTenderEnvelope.envelopeName,tblTenderEnvelope.sortOrder from TblTenderForm tblTenderForm ");
    	query.append(" inner join tblTenderForm.tblTenderEnvelope tblTenderEnvelope");
    	query.append(" where tblTenderEnvelope.tblTender.tenderId=:tenderId ");
    	if(!(isForResultSharing.length>1)){
    		if(isForResultSharing[0]){
        		query.append(" and tblTenderForm.cstatus = 1");    		
        	}else{
        		query.append(" and tblTenderForm.cstatus = 0 ");
        	}	
    	}
    	query.append(" order by tblTenderEnvelope.sortOrder");
        return  hibernateQueryDao.createNewQuery(query.toString(),var);                
    }
    
    @Transactional
    public List<Object[]> getBidderItem(int tenderId,int userId) throws Exception{
        List<Object[]> list = new ArrayList<Object[]>();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("userId",userId);
//        list = hibernateQueryDao.createNewQuery("select tblitembiddermap.tblTenderTable.tableId,tblitembiddermap.rowId from  TblItemBidderMap tblitembiddermap  inner join  tblitembiddermap.tblTenderBidderMap tbltenderbiddermap where tbltenderbiddermap.tblTender.tenderId=:tenderId and tbltenderbiddermap.tblUserLogin.userId=:userId",var);                
        return list;        

    }
    @Transactional
    public int checkIsEvaluationDone(int tenderId,int envelopeType) throws Exception {
		Map<String, Object> var = new HashMap<String, Object>();
		List<Object> data = new ArrayList<Object>();
		StringBuilder query = new StringBuilder();
		long secondLastEnvDetailscount = 0;
		long finalSubCnt = 0 ;
		var.put("tenderId",tenderId);
	    query.append("select envelopeId from TblTenderEnvelope tblTenderEnvelope where tblTenderEnvelope.tblTender.tenderId =:tenderId order by tblTenderEnvelope.sortOrder desc");
	    
	    data = hibernateQueryDao.getSingleColQuery(query.toString(), var);
	    int lastEnvelopeId = Integer.parseInt(data.get(0).toString());
	    if(data.size() > 1){//condition for only one envelope in tender
	    	int secondLastEnvelopeId = Integer.parseInt(data.get(1).toString());
		    if(envelopeType==1){
		    	finalSubCnt = hibernateQueryDao.countForNewQuery("TblFinalSubmission tblFinalSubmission ", "tblFinalSubmission.tblUserLogin.userId ", "tblFinalSubmission.tblTender.tenderId =:tenderId and tblFinalSubmission.isActive = 1", var);
			    if(finalSubCnt == 0){
			    	return 0;
			    }
		    }else{
		    	var.put("envelopId",secondLastEnvelopeId);
		    	secondLastEnvDetailscount = hibernateQueryDao.countForNewQuery("TblBidderApprovalDetail tblBidderApprovalDetail inner join tblBidderApprovalDetail.tblTenderEnvelope tblTenderEnvelope ", "tblBidderApprovalDetail.tblUserLogin.userId ", "tblTenderEnvelope.tblTender.tenderId =:tenderId and tblTenderEnvelope.envelopeId =:envelopId AND tblBidderApprovalDetail.isApproved=1", var);
		    }
	    }else{
	    	finalSubCnt = hibernateQueryDao.countForNewQuery("TblFinalSubmission tblFinalSubmission ", "tblFinalSubmission.tblUserLogin.userId ", "tblFinalSubmission.tblTender.tenderId =:tenderId and tblFinalSubmission.isActive = 1", var);
		    if(finalSubCnt == 0){
		    	return 0;
		    }
	    }
	    
	    var.put("envelopId",lastEnvelopeId);
	    long lastEnvDetailscount = hibernateQueryDao.countForNewQuery("TblBidderApprovalDetail tblBidderApprovalDetail inner join tblBidderApprovalDetail.tblTenderEnvelope tblTenderEnvelope ", "tblBidderApprovalDetail.tblUserLogin.userId ", "tblTenderEnvelope.tblTender.tenderId =:tenderId and tblTenderEnvelope.envelopeId =:envelopId", var);
	    if(envelopeType==1){
	    	return lastEnvDetailscount == finalSubCnt ? 1 : 0;
	    }else{
	    	return (lastEnvDetailscount!=0 && secondLastEnvDetailscount!=0 && lastEnvDetailscount == secondLastEnvDetailscount) ? 1 : 0;
	    }
	}
	public Map<Integer,Object> checkIsEvaluationScoreDone(int tenderId) throws Exception {
		List<Object[]> result = reportService.getTenderBidFormWithFormDetail(tenderId,0,0,"0");
		Map<Integer,Object> envelope = new HashMap<Integer, Object>();
		if(result != null && !result.isEmpty()){
			for(Object[] obj : result){
				Float weight = (Float) obj[7];
				Integer envelopeId = (Integer)obj[2];
				if(!envelope.containsKey(envelopeId) && weight == 0){
					envelope.put((Integer)obj[2],0);
				}
			}
		}
		return envelope;
	}
}
