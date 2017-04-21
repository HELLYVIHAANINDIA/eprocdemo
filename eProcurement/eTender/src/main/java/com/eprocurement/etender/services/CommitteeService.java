/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.daointerface.TblOfficerDao;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.daointerface.TblCommitteeDao;
import com.eprocurement.etender.daointerface.TblCommitteeUserDao;
import com.eprocurement.etender.daointerface.TblTenderDao;
import com.eprocurement.etender.model.TblCommittee;
import com.eprocurement.etender.model.TblCommitteeEnvelope;
import com.eprocurement.etender.model.TblCommitteeUser;
import com.eprocurement.etender.model.TblOfficer;
import com.eprocurement.etender.model.TblTender;

/**
 *
 */
@Service
public class CommitteeService {

	@Autowired
	HibernateQueryDao hibernateQueryDao;

	@Autowired
	TblCommitteeDao tblCommitteeDao;
	
	@Autowired
	TblTenderDao tblTenderDao;
	
	@Autowired
	CommonService commonService;

	@Autowired
	TblCommitteeUserDao tblCommitteeUserDao;

	@Autowired
	TblOfficerDao tblOfficerDao;
	
	@Autowired
	TenderService tenderFormService;
	
	@Autowired
	CommonDAO commonDao;
	

	/**
	 * 
	 * @param committeeName
	 * @param committeeType
	 * @param clientId
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public boolean checkUniqueCommitteeName(String committeeName,
			int committeeType, int clientId) throws Exception {
		long count = 0;
		Map<String, Object> var = new HashMap<String, Object>();
		var.put("committeeName", committeeName);
		var.put("committeeType", committeeType);
		var.put("clientId", clientId);
		count = hibernateQueryDao
				.countForNewQuery(
						"TblCommittee tblcommittee inner join tblcommittee.tblClient tblclient ",
						"tblcommittee.committeeId ",
						"tblcommittee.committeeName=:committeeName and tblcommittee.committeeType=:committeeType and tblcommittee.tblClient.clientId=:clientId",
						var);
		return count != 0;
	}

	/**
	 * 
	 * @param tblcommittee
	 * @param tblcommitteeusers
	 * @param tbltenderenvelopes
	 * @param committeeType
	 * @param action
	 *            0 = Add Committee, 1 = Edit Committee
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public boolean addCommittee(TblCommittee tblCommittee,List<TblCommitteeUser> tblCommitteeUsers,List<TblCommitteeEnvelope> tblCommitteeEnvelopes,int committeeType, int action) throws Exception {
		boolean bSuccess = false;
		if (action == 0) {
			commonDao.saveOrUpdate(tblCommittee);
		}else if (action == 1) {
			deleteMembersByComitteeId(tblCommittee.getCommitteeId());
			deleteCommitteeEnvelope(tblCommittee.getCommitteeId());
		}
		
		if(committeeType==1){
			for (TblCommitteeEnvelope tblCommitteeEnvelope : tblCommitteeEnvelopes) {
				Map<String, Object> parameters = new HashMap<String, Object>();
		        parameters.put("minOpeningMember", tblCommitteeEnvelope.getMinMemberApproval());
		        parameters.put("envelopeId", tblCommitteeEnvelope.getTblTenderEnvelope().getEnvelopeId());
		        String query = "update TblTenderEnvelope tblTenderEnvelope set tblTenderEnvelope.minOpeningMember=:minOpeningMember where tblTenderEnvelope.envelopeId=:envelopeId";
		        commonDao.executeUpdate(query, parameters);
			}
		}else if(committeeType == 2){
			for (TblCommitteeEnvelope tblCommitteeEnvelope : tblCommitteeEnvelopes) {
				Map<String, Object> parameters = new HashMap<String, Object>();
		        parameters.put("minEvaluator", tblCommitteeEnvelope.getMinMemberApproval());
		        parameters.put("envelopeId", tblCommitteeEnvelope.getTblTenderEnvelope().getEnvelopeId());
		        String query = "update TblTenderEnvelope tblTenderEnvelope set tblTenderEnvelope.minEvaluator=:minEvaluator where tblTenderEnvelope.envelopeId=:envelopeId";
		        commonDao.executeUpdate(query, parameters);
			}
		}
		commonDao.evictAll(tblCommitteeUsers);
		commonDao.evictAll(tblCommitteeEnvelopes);
		commonDao.saveOrUpdateAll(tblCommitteeUsers);
		commonDao.saveOrUpdateAll(tblCommitteeEnvelopes);
		
		bSuccess = true;
		return bSuccess;
	}

	/**
	 * 
	 * @param tblcommittee
	 * @return
	 * @throws Exception
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public boolean addTblCommitteeMember(TblCommittee tblcommittee,
			List<TblCommitteeUser> tblcommitteeuser) throws Exception {
		boolean bSuccess = false;
		tblCommitteeDao.addTblCommittee(tblcommittee);
		tblCommitteeUserDao.saveUpdateAllTblCommitteeUser(tblcommitteeuser);
		bSuccess = true;
		return bSuccess;

	}

	/**
	 * 
	 * @param committeeId
	 * @return
	 * @throws Exception
	 */
	public boolean deleteMembersByComitteeId(int committeeId) throws Exception {
		int cnt = 0;
		Map<String, Object> var = new HashMap<String, Object>();
		var.put("committeeId", committeeId);
		cnt = commonDao.executeUpdate("delete  from TblCommitteeUser tblcommitteeuser where tblcommitteeuser.tblCommittee.committeeId=:committeeId",var);
		return cnt != 0;

	}

	/**
	 * 
	 * @param committeeId
	 * @return
	 * @throws Exception
	 */
	public boolean deleteCommitteeEnvelope(int committeeId) throws Exception {
		int cnt = 0;
		Map<String, Object> var = new HashMap<String, Object>();
		var.put("committeeId", committeeId);
		cnt = commonDao.executeUpdate("delete from TblCommitteeEnvelope tblcommitteeenvelope where tblcommitteeenvelope.tblCommittee.committeeId=:committeeId",
						var);
		return cnt != 0;

	}
	
	/**
	 * 
	 * @param tenderId
	 * @return
	 * @throws Exception
	 */
	public TblTender getTenderMaster(int tenderId) throws Exception {
        List<TblTender> lstTblTender = tblTenderDao.findTblTender("tenderId", Operation_enum.EQ, tenderId);
        if (lstTblTender != null && !lstTblTender.isEmpty()) {
            return lstTblTender.get(0);
        } else {
            return null;
        }
    }
	
	/**
	* 
	* @param committeeId
	* @return
	* @throws Exception 
	*/
	@Transactional
	public Set<TblOfficer> getAllCommitteeMemberDetails(int committeeId) throws Exception{
		Set<TblOfficer> committeeUserDetail = new HashSet<TblOfficer>();
		List<TblCommitteeUser> lstCommitteeUser = tblCommitteeUserDao.findTblCommitteeUser("tblCommittee", Operation_enum.EQ, new TblCommittee(committeeId));        
        if (lstCommitteeUser != null && !lstCommitteeUser.isEmpty()) {
        	for (TblCommitteeUser tblCommitteeUser : lstCommitteeUser) {
        		List<TblOfficer> lstTblOfficer = tblOfficerDao.findTblOfficer("id", Operation_enum.EQ,tblCommitteeUser.getTblOfficer().getId());
        		if (lstTblOfficer != null && !lstTblOfficer.isEmpty()) {
        			committeeUserDetail.add(lstTblOfficer.get(0));
        		}
			}
        } else {
            return committeeUserDetail;
        }
        return committeeUserDetail;
	}
	
	/**
     * 
     * @param committeeId
     * @param tblCommitteeUser
     * @return
     * @throws Exception 
     */
    @Transactional(propagation= Propagation.REQUIRED,rollbackFor=Exception.class)
    public boolean updateRemoveCommitteeMembers(int committeeId,List<TblCommitteeUser> tblCommitteeUser) throws Exception{
        int cnt = 0;
        boolean isSuccess = false;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeId",committeeId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete  from TblCommitteeUser tblcommitteeuser where tblcommitteeuser.tblCommittee.committeeId=:committeeId",var);        
        isSuccess =  addTblCommitteeUser(tblCommitteeUser);
        return isSuccess;

    }
    
    /**
     * 
     * @param tblcommitteeuser
     * @return
     * @throws Exception 
     */
    public  boolean addTblCommitteeUser(List<TblCommitteeUser> tblcommitteeuser) throws Exception{
    boolean bSuccess = false;             
                tblCommitteeUserDao.saveUpdateAllTblCommitteeUser(tblcommitteeuser);
            bSuccess=true;        
        return bSuccess;

    }
    
    /**
     * 
     * @param keyword
     * @param value
     * @return
     * @throws Exception
     */
    public List<TblOfficer> getOfficerLst(String keyword,String value,SessionBean sessionBean) throws Exception{
    	List<TblOfficer> lstTblOfficer = null;
    	List<Integer> deptIds = commonService.getDeptDetailByUserId(sessionBean);
    	Object[] deptId =  deptIds.toArray();
    	if(keyword.equalsIgnoreCase("email")){
    		lstTblOfficer = tblOfficerDao.findTblOfficer("emailid", Operation_enum.LIKE,"%"+value+"%","cstatus",Operation_enum.EQ,1,"tblDepartment.deptId",Operation_enum.IN,deptId);
    	}else if(keyword.equalsIgnoreCase("name")){
    		lstTblOfficer = tblOfficerDao.findTblOfficer("officername", Operation_enum.LIKE,"%"+value+"%","cstatus",Operation_enum.EQ,1,"tblDepartment.deptId",Operation_enum.IN,deptId);
    	}else{
    		if(keyword.equalsIgnoreCase("deptId")) {
    			lstTblOfficer = tblOfficerDao.findTblOfficer("tblDepartment.deptId", Operation_enum.EQ,Integer.parseInt(value));
    		}else if(keyword.equalsIgnoreCase("designationId")) {
    			lstTblOfficer = tblOfficerDao.findTblOfficer("tblDesignation.designationId", Operation_enum.EQ,Integer.parseInt(value));
    		}
    	}
		return lstTblOfficer;
    }
    
    
    /**
	 * 
	 * @param tenderId
	 * @return
	 * @throws Exception
	 */
	public boolean isPrebidCommitteeCreated(int tenderId) throws Exception {
		boolean status =false;
        List<TblCommittee> lstTblCommittee = tblCommitteeDao.findEntity("tblTender.tenderId",Operation_enum.EQ,tenderId,"committeeType",Operation_enum.EQ,3);
        if(lstTblCommittee!=null && !lstTblCommittee.isEmpty()){
        	status=true;
        }
        return status;
    }
	
	/**
     * 
     * @param tenderId
     * @return
     * @throws Exception 
     */
	@Transactional
    public List<Object[]> getTenderEnvelopesDetails(int tenderId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        StringBuffer query = new StringBuffer();
        query.append(" select tbltenderenvelope.tblEnvelope.envId, tbltenderenvelope.envelopeName,");
        query.append(" tbltenderenvelope.envelopeId, tbltenderenvelope.isOpened, tbltenderenvelope.isEvaluated");
        query.append(" from TblTenderEnvelope tbltenderenvelope");
        query.append(" where tbltenderenvelope.tblTender.tenderId =:tenderId");
        query.append(" group by tbltenderenvelope.tblEnvelope.envId, tbltenderenvelope.envelopeName, tbltenderenvelope.envelopeId, tbltenderenvelope.isOpened, tbltenderenvelope.isEvaluated, tbltenderenvelope.sortOrder");
        query.append(" order by tbltenderenvelope.sortOrder");
        list = hibernateQueryDao.createNewQuery(query.toString(),var);                
        return list;
    }
    //Lipi Shah
    @Transactional
    public List<Object[]> getTenderOpeningCommitteeMemberList(int tenderId,int committeeType) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("committeeType",committeeType);
        
        StringBuffer query = new StringBuffer();
 
        query.append(" select tblOfficer.officername,tblOfficer.tblUserlogin.loginid,tblOfficer.id,tblCommitteeUser.childId,");
        query.append("  tblCommitteeUser.approvedOn,tblCommitteeUser.committeeUserId,tblOfficer.tblUserlogin.userId");//tblCommitteeUser.tblCommittee.committeeId
        query.append("  ,tblCommittee.committeeId,tblCommitteeUser.isApproved,tblCommitteeUser.isDecryptor");
        query.append(" from TblCommitteeUser tblCommitteeUser");
        query.append(" inner join tblCommitteeUser.tblCommittee  tblCommittee ,TblCommitteeEnvelope tblCommitteeEnvelope");
        query.append(" inner join tblCommitteeUser.tblOfficer tblOfficer");
        query.append(" where tblCommitteeUser.tblCommittee.tblTender.tenderId=:tenderId");
        query.append(" and tblCommitteeEnvelope.tblCommittee.committeeId=tblCommittee.committeeId");
        query.append(" and tblCommitteeEnvelope.tblTenderEnvelope.envelopeId=tblCommitteeUser.childId");
        query.append(" and tblCommittee.committeeType=:committeeType");
        query.append(" and tblCommittee.isActive=1");
        query.append(" and tblCommittee.isApproved=1");
//        query.append(" and tblTenderEnvelope.envelopeId.id=tblCommitteeUser.childId");
        list = hibernateQueryDao.createNewQuery(query.toString(),var);                
        return list;
    }
    
    //Lipi Shah
    @Transactional
    public List<Object[]> getTenderBidderList(int tenderId,int envelopeId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        if(envelopeId != 0){
        	var.put("envelopeId",envelopeId);
        }
        StringBuffer query = new StringBuffer();
        query.append(" SELECT fs.bidderId,fs.companyId, te.envelopeId,TB.cstatus,bad.isApproved,bc.encodedName");
        query.append(" ,fs.partnerType,bad.remarks, (case when (te.sortOrder) > 1 then ");
        query.append(" (select b.isApproved from tbl_bidderapprovaldetail b where b.companyId=fs.companyId and  b.envelopeId in ");
        query.append(" (select c.envelopeId from tbl_tenderenvelope c where c.tenderId=fs.tenderId and c.sortOrder=te.sortOrder-1)");
        query.append(" ) Else -1 End) as previousApprovedBidder,tc.companyname,TB.userid");
        query.append(" FROM tbl_finalsubmission fs");
        query.append(" INNER JOIN tbl_tenderenvelope te on te.tenderId = fs.tenderId");
        query.append(" INNER JOIN tbl_tenderbidconfirmation bc ON bc.tenderId = fs.tenderId and bc.companyId=fs.companyId");
        query.append(" LEFT JOIN tbl_bidderapprovaldetail bad on bad.tenderId = fs.tenderId and te.envelopeId=bad.envelopeId and fs.bidderId=bad.bidderId");
        query.append(" INNER JOIN tbl_bidder TB ON TB.bidderId = fs.bidderId");
        query.append(" INNER JOIN tbl_company tc ON  tc.companyid=fs.companyid");
        query.append(" WHERE fs.tenderId=:tenderId and fs.isActive=1");
        if(envelopeId != 0){
            query.append(" and te.envelopeId=:envelopeId ");
        }
        query.append(" ORDER BY te.envelopeId,fs.partnerType");	
        list = hibernateQueryDao.createSQLQuery(query.toString(),var);                
        return list;
    }
    
    //Lipi Shah
    @Transactional
    public List<Object[]> getTenderBidderFormList(int tenderId,int tabId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        
        StringBuffer query = new StringBuffer();
 
        query.append(" SELECT tf.envelopeId as envelopeId, tf.formId as formId, tf.formName as formName,tf.isPriceBid,tf.isEncryptionReq,COUNT(distinct tb.companyId)-  COUNT(distinct bs.companyId) finalCount ,");
        query.append(" COUNT(distinct tto.companyId) openCount,tf.cstatus,tf.isMandatory");
        if(tabId==3){
        	query.append(" ,srd.shareIndividualReport,srd.shareComparativeReport,srd.shareDocument");//,COUNT(distinct ts.tenderSorId) sorCount
        }
        query.append(" FROM  tbl_tenderenvelope te 	 ");
        query.append(" LEFT JOIN tbl_finalsubmission fs on fs.tenderId = te.tenderId and partnerType in (0,1,2)");
        query.append(" INNER JOIN tbl_tenderform tf ON tf.envelopeId= te.envelopeId");
        query.append(" LEFT JOIN tbl_tenderbid tb ON te.tenderId = tb.tenderId and fs.companyId = tb.companyId  and tf.formId = tb.formId");
        query.append(" LEFT JOIN (select ba.companyId,te.envelopeId");
        query.append(" from tbl_finalsubmission fs inner join tbl_tenderenvelope te ON fs.tenderId=te.tenderId ");
        query.append(" left join (select tle.tenderid,bla.companyid,sortOrder+1 sortoder from tbl_tenderenvelope tle");
        query.append(" inner join tbl_bidderapprovaldetail bla on tle.tenderId=bla.tenderId and tle.envelopeId=bla.envelopeId and bla.tenderId=:tenderId and isApproved=0) ba ");
        query.append(" on te.tenderId=ba.tenderId and te.sortOrder >=ba.sortoder");
        query.append(" and fs.companyId=ba.companyId and fs.tenderId=ba.tenderId");
        query.append(" where fs.tenderId=:tenderId and ba.companyId is not null) bs on tb.companyId=bs.companyId and tb.envelopeId=bs.envelopeId");
        query.append(" LEFT JOIN tbl_tenderopen tto ON tf.tenderId = tto.tenderId and tf.formId = tto.formId and tto.decryptionLevel=1");
        if(tabId==3){
        	query.append(" LEFT  JOIN  tbl_sharereport sr on sr.tenderId=te.tenderId and sr.isActive=1 ");
        	query.append(" LEFT  JOIN  tbl_sharereportdetail srd on srd.shareReportId=sr.shareReportId and srd.formId=tf.formId");
        }
        if(tabId != 3){
//        	query.append(" LEFT JOIN tbl_TenderSOR ts on ts.formId= tf.formId");
        }
        query.append("  WHERE te.tenderId =:tenderId and tf.cstatus in (1)");//cancel status
        query.append(" GROUP BY tf.envelopeId,tf.formId ,tf.formName,tf.isPriceBid,tf.isEncryptionReq,tf.cstatus,tf.isMandatory,tf.sortOrder");
        if(tabId==3){
        	query.append(" ,srd.shareIndividualReport,srd.shareComparativeReport,srd.shareDocument ");
        }
        query.append(" ORDER BY tf.envelopeId,tf.sortOrder");
        list = hibernateQueryDao.nativeSQLQuery(query.toString(),var);                
        return list;
    }

    public List<Object[]> getTenderDetails(int tenderId,int tabId,int envelopeType) throws Exception{
    	List<Object[]> list = null;
    	Map<String, Object> var = new HashMap<String, Object>();
    	var.put("tenderId", tenderId);
    	StringBuffer query = new StringBuffer();
    	query.append(" SELECT assignUserId,envelopeType,isEncodedName,autoResultSharing,CASE WHEN openingDate <= UTC_TIMESTAMP() THEN 1 ELSE 0 END tenderOpeningTimeLapsed,eventTypeId,");
    	query.append(" (CASE WHEN showNoOfBidders = 1 AND openingDate > UTC_TIMESTAMP() THEN 1 ");
    	query.append(" WHEN showNoOfBidders = 2 AND UTC_TIMESTAMP() BETWEEN submissionStartDate AND openingDate THEN 1");
    	query.append(" WHEN showNoOfBidders = 3 AND submissionEndDate <= UTC_TIMESTAMP() THEN 1  ELSE 1 END) TotalNoOfBidders,t.isRebateApplicable");
    	if(tabId == 1){
    		query.append(" ,COALESCE(tfs.bidderCount,0) bidderCount,showNoOfBidders");
    	}
    	query.append(" FROM tbl_tender t ");
    	if(tabId == 1){
    			query.append(" LEFT JOIN ( SELECT COUNT(distinct companyId) bidderCount,tenderId FROM tbl_finalsubmission");
        		query.append(" WHERE tenderId=:tenderId GROUP BY tenderId ) tfs ON tfs.tenderId = t.tenderId ");
    	}
    	query.append("  WHERE t.tenderId=:tenderId");
    	//list = hibernateQueryDao.createSQLQuery(query.toString(),var);
    	list = commonDao.executeSqlSelect(query.toString(),var);
    	return list;
    }
    @Transactional
    public List<Object[]> getTenderEnvelopeList(int tenderId,int tabId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
//        var.put("committeeType",committeeType);
        long envelopeCount = tenderFormService.getCountofTenderEnvelope(tenderId);
        StringBuffer query = new StringBuffer();
        TblTender tblTender = getTenderMaster(tenderId);
        int committeeType = 0;
        if(tabId==1 || tabId==3){
        	committeeType = 1;
        }else if(tabId==2){
        	committeeType = 2;
        }
        
        query.append(" SELECT e.envelopeId,envelopeName,convert_tz(openingDate,'+00:00','"+commonService.getUserTimeZone()+"'),e.envId,cstatus,openingDateStatus, CASE WHEN openingDate <= UTC_TIMESTAMP() ");
        query.append(" AND e.openingDateStatus = 1 THEN 1 ELSE 0 END timeLapsed, e.sortOrder");
        if(tblTender.getIsOpeningByCommittee() == 1 && committeeType == 1){
        	query.append(" ,minOpeningMember as minMember");
        }else if(tblTender.getIsOpeningByCommittee() == 1 && committeeType == 2){
        	query.append(" ,minEvaluator as minMember");
        }
        query.append(" , isOpened,isEvaluated, COALESCE(bad.isEvaluationDone,0) isEvaluationDoneBidder ");
        if(committeeType == 2){
        	query.append(" , A.isEnvelopeOpened");
        }
        if(envelopeCount > 1 && (tabId == 2 ||tabId == 3)){
        	query.append(" , COALESCE(ba.isNextEnvEvalDone,0) isNextEnvEvalDone");
        }
        
        
        query.append(" FROM tbl_tenderenvelope e");
        if(committeeType == 2){
        	query.append(" LEFT JOIN ( SELECT CE.envelopeId, (CASE WHEN CE.minMemberApproval <= COUNT(CU.committeeUserId) THEN 1 ELSE 0 END) isEnvelopeOpened");
            query.append(" FROM tbl_committee CM ");
            query.append(" INNER JOIN tbl_committeeenvelope CE ON CM.committeeId = CE.committeeId"); 
            query.append(" LEFT OUTER JOIN tbl_committeeuser CU ON CM.committeeId = CU.committeeId AND CE.envelopeId = CU.childId AND CU.isApproved = 1"); 
            query.append(" WHERE CM.tenderId =:tenderId AND CM.committeeType = 1 AND CM.isActive = 1 AND CM.isApproved = 1");
            query.append(" GROUP BY CE.envelopeId, CE.minMemberApproval ");
            query.append(" ) A ON e.envelopeId = A.envelopeId ");
        }
        query.append(" LEFT JOIN (SELECT COUNT(bidderApprovalId) isEvaluationDone ,envelopeId FROM tbl_bidderapprovaldetail WHERE tenderId=:tenderId GROUP BY envelopeId) bad on bad.envelopeId=e.envelopeId");
        if(envelopeCount > 1 && (tabId == 2 ||tabId == 3)){
        	query.append(" LEFT JOIN (SELECT COUNT(bidderApprovalId) isNextEnvEvalDone ,env.envelopeId ,env.sortOrder FROM tbl_bidderapprovaldetail b INNER JOIN tbl_tenderenvelope env on env.envelopeId=b.envelopeId WHERE env.tenderId=:tenderId GROUP BY env.envelopeId,env.sortOrder ) ba on ba.sortOrder=e.sortOrder+1");
        }
        query.append(" WHERE e.tenderId=:tenderId AND e.cstatus = 1 ORDER BY e.sortOrder");
        list = hibernateQueryDao.createSQLQuery(query.toString(),var);                
        return list;
    }
    @Transactional
    public List<Object[]> getCommitteeDetails(int tenderId, int committeeType, int isView) throws Exception{
        List<Object[]> list = null;
        StringBuffer query = new StringBuffer();
        query.append("select tblcommittee.committeeId, tblcommittee.committeeName, tblcommittee.isStandard, tblcommittee.isApproved, tblcommittee.isActive,tblcommittee.publishedOn ");
        query.append("from TblCommittee tblcommittee where tblcommittee.tblTender.tenderId=:tenderId and tblcommittee.committeeType=:committeeType ");
        query.append("order by tblcommittee.committeeId desc ");
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("committeeType",committeeType);
        if(isView == 1){
        	list = hibernateQueryDao.createNewQuery(query.toString(), var);
        }
        else {
        	list = hibernateQueryDao.createByCountNewQuery(query.toString(), var, 0, 1);
        }
        return list;
    }
    
    @Transactional
    public List<Object[]> getCommitteeUserDetails(int tenderId, int committeeId) throws Exception{
        List<Object[]> list = null;
        StringBuffer query = new StringBuffer();
        query.append("select tbluserdetail.userName, tbluserdetail.deptName, tbluserdetail.designation, tblcommitteeuser.tblUserLogin.userId, tblcommitteeuser.tblUserDetail.userDetailId, tblcommitteeuser.isDecryptor, ");
        query.append("tblcommitteeuser.encryptionLevel, MAX(tbltenderpublickey.tenderPublicKeyId),tblcommitteeuser.userRoleId,");
        query.append("(select tblUserRole.userRole from TblUserRole tblUserRole where tblUserRole.userRoleId=tblcommitteeuser.userRoleId),tblcommitteeuser.tblUserLogin.loginId");
        query.append(" from TblCommitteeUser tblcommitteeuser inner join ");
        query.append(" tblcommitteeuser.tblOfficer tblOfficer ");
        query.append("tbltenderpublickey.tblTender.tenderId = :tenderId where tblcommitteeuser.tblCommittee.committeeId = :committeeId group by tbluserdetail.userName, tbluserdetail.deptName, tbluserdetail.designation, ");
        query.append("tblcommitteeuser.tblUserLogin.userId, tblcommitteeuser.tblUserDetail.userDetailId, tblcommitteeuser.isDecryptor, tblcommitteeuser.encryptionLevel,tblcommitteeuser.userRoleId,tblcommitteeuser.tblUserLogin.loginId order by MAX(tblcommitteeuser.committeeUserId) ");
        
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("committeeId",committeeId);
        list = hibernateQueryDao.createNewQuery(query.toString(),var);                
        return list;
    }
    
    @Transactional
    public List<Object[]> getCommitteeUserEnvelopeDetails(int committeeId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeId",committeeId);
        list = hibernateQueryDao.createNewQuery("select tblcommitteeuser.tblOfficer.id, tblcommitteeuser.childId, tblcommitteeuser.isApproved from TblCommitteeUser tblcommitteeuser where tblcommitteeuser.tblCommittee.committeeId=:committeeId",var);                
        return list;
    }
    
    @Transactional
    public List<Object[]> getCommitteeMinApproval(int committeeId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("committeeId",committeeId);
        list = hibernateQueryDao.createNewQuery("select tblcommitteeuser.childId, count(tblcommitteeuser.tblOfficer.id) as totalApproval, tblcommitteeenvelope.minMemberApproval, tbltenderenvelope.isOpened, tbltenderenvelope.isEvaluated from TblCommittee tblcommittee inner join tblcommittee.tblCommitteeUser tblcommitteeuser inner join tblcommittee.tblCommitteeEnvelope tblcommitteeenvelope inner join tblcommitteeenvelope.tblTenderEnvelope tbltenderenvelope where tblcommitteeuser.childId = tblcommitteeenvelope.tblTenderEnvelope.envelopeId and tblcommittee.committeeId = :committeeId group by tblcommitteeuser.childId, tblcommitteeenvelope.minMemberApproval, tbltenderenvelope.isOpened, tbltenderenvelope.isEvaluated order by tblcommitteeuser.childId",var);                
        return list;
    }
    

    @Transactional
    public List<TblCommitteeUser> getCommitteeUserApprovalDetails(int committeeId, int isApproved) throws Exception{
        return tblCommitteeUserDao.findTblCommitteeUser("tblCommittee", Operation_enum.EQ, new TblCommittee(committeeId), "isApproved", Operation_enum.EQ, isApproved);        
    }
    
    @Transactional
    public Set<TblOfficer> getOfficerDtlOfCommitte(int committeeid) throws Exception{
    	Set<TblOfficer> tblOfficerLst = new HashSet<TblOfficer>();
    	List<TblCommitteeUser> tblCommitteeUserLSt = tblCommitteeUserDao.findTblCommitteeUser("tblCommittee.committeeId",Operation_enum.EQ,committeeid);
    	if(tblCommitteeUserLSt!=null && !tblCommitteeUserLSt.isEmpty()){
    		for (TblCommitteeUser tblCommitteeUser : tblCommitteeUserLSt) {
    			TblOfficer tblOfficer =  tblOfficerDao.findTblOfficer("id",Operation_enum.EQ,tblCommitteeUser.getTblOfficer().getId()).get(0);
    			tblOfficerLst.add(tblOfficer);	
			}
    	}
		return tblOfficerLst;
    }
   @Transactional
    public Map<Integer, Boolean> getRejectedBidderAppDtls(int tenderId) throws Exception{
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("isApproved", 0);
        StringBuilder query = new StringBuilder();
        query.append(" SELECT DISTINCT tblBidderApprovalDetail.bidderid");
        query.append(" FROM TblBidderApprovalDetail tblBidderApprovalDetail");
        query.append(" WHERE tblBidderApprovalDetail.tblTender.tenderId =:tenderId AND tblBidderApprovalDetail.isapproved =:isApproved ");
        List<Object> rejectedBidderlist = hibernateQueryDao.singleColQuery(query.toString(),var);
        Map<Integer, Boolean> rejectedBidderMap = new HashMap<Integer, Boolean>();
        for (Object bidderId : rejectedBidderlist) {
        	rejectedBidderMap.put((Integer) bidderId, true);
		}
        return rejectedBidderMap;
    }
   @Transactional
   public int getCommitteeId(int tenderId,int committeeType) throws Exception {
       int data = 0;
       List<Object> list = null;
       Map<String, Object> var = new HashMap<String, Object>();
       var.put("tenderId", tenderId);
       var.put("committeeType", committeeType);
       
       StringBuilder query = new StringBuilder();
       query.append(" select tblcommittee.committeeId");
       query.append(" from TblCommittee tblcommittee");
       query.append(" where tblcommittee.tblTender.tenderId=:tenderId and tblcommittee.committeeType=:committeeType and tblcommittee.isActive=1");
       list = hibernateQueryDao.singleColQuery(query.toString(), var);
       if (!list.isEmpty()) {
           data =(Integer) list.get(0);
       }
       return data;
   }
   
   @Transactional
   public boolean isSingleEnvelopeIsOpened(int tenderId) throws Exception {
       boolean bSuccess = false;
       List<Object> list = null;
       Map<String, Object> var = new HashMap<String, Object>();
       var.put("tenderId", tenderId);
       StringBuilder query = new StringBuilder();
       query.append(" select tblTenderEnvelope.isOpened ");
       query.append(" from TblTenderEnvelope tblTenderEnvelope");
       query.append(" where tblTenderEnvelope.tblTender.tenderId=:tenderId and tblTenderEnvelope.isOpened=1");
       list = hibernateQueryDao.singleColQuery(query.toString(), var);
       if (list!=null && !list.isEmpty()) {
    	   bSuccess=true;
       }
       return bSuccess;
   }
   
   
   @Transactional
   public boolean isSingleEnvelopeIsEvaluated(int tenderId) throws Exception {
       boolean bSuccess = false;
       List<Object> list = null;
       Map<String, Object> var = new HashMap<String, Object>();
       var.put("tenderId", tenderId);
       StringBuilder query = new StringBuilder();
       query.append(" select tblTenderEnvelope.isEvaluated ");
       query.append(" from TblTenderEnvelope tblTenderEnvelope");
       query.append(" where tblTenderEnvelope.tblTender.tenderId=:tenderId and tblTenderEnvelope.isEvaluated=1");
       list = hibernateQueryDao.singleColQuery(query.toString(), var);
       if (list!=null && !list.isEmpty()) {
    	   bSuccess=true;
       }
       return bSuccess;
   }
   
   
   @Transactional
   public List<Object[]> getEvaluateBiddersList(int tenderId,int envelopeId,int preEnvelopeId,int envelopeType,int sortOrder,int createEditFlage) throws Exception{
   	List<Object[]> list = null;
  	 if(createEditFlage == 1){ /* For Create - Edit Page */
  		 if(envelopeType == 1){ /* Single Stage Tender */
  				list = GetBidderListForEvaluation(tenderId,preEnvelopeId);
  		 }else{ /* Multi Stage Tender */
  			 if(sortOrder == 1){ /* First Envelope */
  					list = GetBidderListForEvaluation(tenderId,preEnvelopeId);	
  			 }else{
  					list = GetBidderListForEvaluationView(tenderId,preEnvelopeId,envelopeId);	
  			 }
  		 }
  	 }else{ /* View Page */
  			list = GetBidderListForEvaluationView(tenderId,preEnvelopeId,envelopeId);	
	 }
		return list;        
   } 
   
   private List<Object[]> GetBidderListForEvaluationView(int tenderId,int preEnvelopeId,int envelopeId) {
	   	List<Object[]> list = null;
	   	Map<String, Object> var = new HashMap<String, Object>();
	   	var.put("tenderId", tenderId);
	    var.put("preEnvelopeId", preEnvelopeId);
	    var.put("envelopeId", envelopeId);
 		StringBuilder query = new StringBuilder();
 		query.append(" SELECT");
 		query.append(" concat(CP.companyName , ',') AS companyName");
 		query.append(" , concat(CONVERT(FS.finalSubmissionId,char(20)), '|~|' , CONVERT(FS.companyId,char(20)) , '|~|' , CONVERT(FS.bidderId,char(20))) AS bidderIds");
 		query.append(" ,COALESCE(BAD1.bidderApprovalId, '0') AS bidderApprovalId, COALESCE(BAD1.remarks, '') AS remarks, COALESCE(BAD1.isApproved, 1) AS isApproved");
 		query.append(" FROM tbl_finalsubmission FS");
 		query.append(" INNER JOIN tbl_company CP ON CP.companyid = FS.companyid");
 		query.append(" LEFT OUTER JOIN tbl_bidderapprovaldetail BAD ON FS.finalSubmissionId = BAD.finalSubmissionId AND BAD.envelopeId =:envelopeId AND BAD.isApproved = 0");
 		query.append(" LEFT OUTER JOIN tbl_bidderapprovaldetail BAD1 ON FS.finalSubmissionId = BAD1.finalSubmissionId AND BAD1.envelopeId =:preEnvelopeId");
 		query.append(" WHERE FS.tenderId =:tenderId AND FS.isActive = 1");
 		query.append(" ORDER BY FS.createdOn");
 		list = hibernateQueryDao.createSQLQuery(query.toString(),var);
		return list!=null ? list : new ArrayList<Object[]>();
	}
   private List<Object[]> GetBidderListForEvaluation(int tenderId,int preEnvelopeId) {
	   	List<Object[]> list = null;
	   	Map<String, Object> var = new HashMap<String, Object>();
	   	var.put("tenderId", tenderId);
	    var.put("preEnvelopeId", preEnvelopeId);
  		StringBuilder query = new StringBuilder();
  		query.append(" SELECT");
  		query.append(" concat(CP.companyName , ',') AS companyName");
  		query.append(" , concat(CONVERT(FS.finalSubmissionId,char(20)), '|~|' , CONVERT(FS.companyId,char(20)) , '|~|' , CONVERT(FS.bidderId,char(20))) AS bidderIds");
  		query.append(" , '0' AS bidderApprovalId, COALESCE(BAD.remarks, '') AS remarks, COALESCE(BAD.isApproved, 1) AS isApproved");
  		query.append(" FROM tbl_finalsubmission FS");
  		query.append(" INNER JOIN tbl_company CP ON CP.companyid = FS.companyid");
  		query.append(" LEFT OUTER JOIN tbl_bidderapprovaldetail BAD ON FS.finalSubmissionId = BAD.finalSubmissionId AND BAD.envelopeId =:preEnvelopeId AND BAD.isApproved = 0");
  		query.append(" WHERE FS.tenderId =:tenderId AND FS.isActive = 1");
  		query.append(" ORDER BY FS.createdOn");
  		list = hibernateQueryDao.createSQLQuery(query.toString(),var);
		return list!=null ? list : new ArrayList<Object[]>();
	}
   
   
   @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public boolean dumpTOCtoTEC(TblCommittee tblCommittee,List<TblCommitteeUser> tblCommitteeUsers,List<TblCommitteeEnvelope> tblCommitteeEnvelopes,int committeeType, int action) throws Exception {
		boolean bSuccess = false;
		commonDao.saveOrUpdate(tblCommittee);
		commonDao.saveOrUpdateAll(tblCommitteeUsers);
		commonDao.saveOrUpdateAll(tblCommitteeEnvelopes);
		
		for (TblCommitteeEnvelope tblCommitteeEnvelope : tblCommitteeEnvelopes) {
			Map<String, Object> parameters = new HashMap<String, Object>();
	        parameters.put("minEvaluator", tblCommitteeEnvelope.getMinMemberApproval());
	        parameters.put("envelopeId", tblCommitteeEnvelope.getTblTenderEnvelope().getEnvelopeId());
	        String query = "update TblTenderEnvelope tblTenderEnvelope set tblTenderEnvelope.minEvaluator=:minEvaluator where tblTenderEnvelope.envelopeId=:envelopeId";
	        commonDao.executeUpdate(query, parameters);
		}
		
		bSuccess = true;
		return bSuccess;
	}
   
   @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public boolean publishPrebidMOM(int tenderId,int objectId,int childId) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("tenderId", tenderId);
        parameters.put("objectId", objectId);
        parameters.put("childId", childId);
        String query = "update TblOfficerdocument tblOfficerdocument set tblOfficerdocument.cstatus=1 where tblOfficerdocument.tenderId=:tenderId and tblOfficerdocument.objectId=:objectId and tblOfficerdocument.childId=:childId";
        return commonDao.executeUpdate(query, parameters)!=0;
	}
   
}
