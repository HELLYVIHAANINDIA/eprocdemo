/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

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
import com.eprocurement.common.daointerface.TblCompanyDao;
import com.eprocurement.common.daointerface.TblQuestionAnswerDao;
import com.eprocurement.common.daointerface.TblSeekClarificationDao;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblQuestionAnswer;
import com.eprocurement.etender.model.TblSeekClarification;


@Service
public class ClarificationService{

    @Autowired
    HibernateQueryDao hibernateQueryDao;    
    @Autowired
    TblSeekClarificationDao tblSeekClarificationDao;
    @Autowired
    TblCompanyDao tblCompanyDao;
    @Autowired
    TblQuestionAnswerDao tblQuestionAnswerDao;
    @Autowired
    CommonDAO commonDAO;
    
     

    /**
     * Add seekclarification date
     * @param tblseekclarification
     * @return
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public  boolean addTblSeekClarification(TblSeekClarification tblseekclarification,String clarificationId) throws Exception{
    boolean bSuccess = false;             
        if(clarificationId == null) {
            tblSeekClarificationDao.addTblSeekClarification(tblseekclarification);
        } else {
            updateOldConfigureDate(Integer.parseInt(clarificationId));
            tblSeekClarificationDao.addTblSeekClarification(tblseekclarification);
        }
            bSuccess=true;        
        return bSuccess;

    }
    
     /**
     * get seekclarification details of clarification Id
     * @param clarificationId
     * @return
     * @throws Exception 
     */
    public  TblSeekClarification getSeekClarificationById(int clarificationId) throws Exception{
            List<TblSeekClarification> list = null;        
        list = tblSeekClarificationDao.findTblSeekClarification("clarificationId",Operation_enum.EQ,clarificationId);                
            return (list!=null && !list.isEmpty()) ? list.get(0) : null;            
    }
    
    /**
     * To get Response End date and company name for display
     * @param tenderId
     * @param envelopeId
     * @param companyId
     * @return
     * @throws Exception 
     */
    @Transactional
    public List<Object[]> getConfigureDateData(int tenderId,int envelopeId,int bidderId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("envelopeId",envelopeId);
        var.put("bidderId",bidderId);
        list = hibernateQueryDao.createNewQuery("select tblseekclarification.clarificationId, tblseekclarification.responseEndDate, tblBidder.bidderId from TblSeekClarification tblseekclarification inner join tblseekclarification.tblBidder tblBidder where tblseekclarification.tblTender.tenderId=:tenderId and tblseekclarification.tblTenderEnvelope.envelopeId=:envelopeId and tblseekclarification.tblBidder.bidderId=:bidderId and tblseekclarification.isActive=1",var);                
        return list;        

    }
    /**
     * get Comapny details
     * @param companyId
     * @return
     * @throws Exception 
     */
    public  TblCompany getCompanyById(int companyId) throws Exception{
            List<TblCompany> list = null;        
        list = tblCompanyDao.findTblCompany("companyid",Operation_enum.EQ,companyId);                
            return (list!=null && !list.isEmpty()) ? list.get(0) : null;            

    }
    
    /**
     * udpate status of  old date of selected clarificationId
     * @param clarificationId
     * @return
     * @throws Exception 
     */
    public boolean updateOldConfigureDate(int clarificationId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("clarificationId",clarificationId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblSeekClarification set isActive=0 where clarificationId=:clarificationId",var);        
        return cnt!=0;

    }
    
    /**
     * get evaluate bidder list envelope wise
     * @param tenderId
     * @param envelopeId
     * @param envelopeType
     * @param sortOrder
     * @return
     * @throws Exception 
     */
    public List<Object[]> getEvaluateBidderList(int tenderId,int envelopeId,int envelopeType,int sortOrder) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("envelopeId",envelopeId);
        //var.put("envelopeType",envelopeType);
        StringBuilder query = new StringBuilder();
        if(envelopeType == 1 || (envelopeType == 2 && sortOrder == 1)){
	query.append("select tblseekclarification.clarificationId, tblcompany.companyId, tblcompany.companyName, tblseekclarification.responseEndDate, tblfinalsubmission.tblUserDetail.userDetailId ");
	query.append("from TblFinalSubmission tblfinalsubmission ");
	query.append("inner join tblfinalsubmission.tblCompany tblcompany ");
	query.append("left join tblcompany.tblSeekClarification tblseekclarification with tblseekclarification.tblTenderEnvelope.envelopeId =:envelopeId and tblseekclarification.isActive = 1 ");
	query.append("where tblfinalsubmission.tblTender.tenderId =:tenderId and tblfinalsubmission.isActive = 1 and tblfinalsubmission.partnerType <> 3");
        } else { 
//            var.put("sortOrder",sortOrder);
	query.append("select  tblseekclarification.clarificationId, tblcompany.companyId, tblcompany.companyName, tblseekclarification.responseEndDate,tblfinalsubmission.tblUserDetail.userDetailId ");
	query.append("from TblBidderApprovalDetail tblbidderapprovaldetail ");
	query.append("inner join tblbidderapprovaldetail.tblCompany tblcompany ");
	    query.append("inner join tblbidderapprovaldetail.tblTenderEnvelope tbltenderenvelope with tbltenderenvelope.sortOrder=").append(sortOrder-1).append(" ");
	query.append("inner join tblbidderapprovaldetail.tblFinalSubmission tblfinalsubmission ");
	query.append("left join tblcompany.tblSeekClarification tblseekclarification with tblseekclarification.tblTenderEnvelope.envelopeId=:envelopeId and tblseekclarification.isActive = 1 ");
	query.append("where tblbidderapprovaldetail.tblTender.tenderId=:tenderId and tblbidderapprovaldetail.isApproved = 1 and tblfinalsubmission.partnerType <> 3");
        }
        list = hibernateQueryDao.createNewQuery(query.toString(),var);                
        return list;        

    }
    
     /**
     * get userId by clarification Id for sending mail
     * @param clarificationId
     * @return
     * @throws Exception 
     */
    public Object getUserIdClarificationId(int clarificationId) throws Exception{
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("clarificationId",clarificationId);
        list = hibernateQueryDao.getSingleColQuery("select tbluserdetail.tblUserLogin.userId from  TblSeekClarification tblseekclarification  inner join  tblseekclarification.tblUserDetail tbluserdetail where tblseekclarification.clarificationId=:clarificationId",var);                
        return list != null && !list.isEmpty() ? list.get(0) : "0";

    }
    
    
    /**
     * get list for check is enrty or not
     * @return
     * @throws Exception 
     */
    @Transactional
	public  List<TblSeekClarification> getSeekClarificationDtls(int tenderId,int envelopeId,int bidderId) throws Exception{
        List<TblSeekClarification> list = null;        
        list = tblSeekClarificationDao.findTblSeekClarification("tblTender.tenderId",Operation_enum.EQ,tenderId,"tblTenderEnvelope.envelopeId",Operation_enum.EQ,envelopeId,"tblBidder.bidderId",Operation_enum.EQ,bidderId);                
        return list;            
	}

	public List<Object[]> getResponseEndDateandCompayDetails(int clariBroadCastId)throws Exception 
	{
		  StringBuilder query = new StringBuilder();
	       Map<String, Object> var = new HashMap<String, Object>();
	       List<Object[]> list = null;
	       var.put("clariBroadCastId", clariBroadCastId);
	       query.append("select tblSeekClarification.clarificationId,tblCompany.companyId,tblCompany.companyName,tblSeekClarification.responseEndDate,tblQuestion.questionText,tblQuestion.questionId from TblBroadCastQuestionMapping  tblBroadCastQuestionMapping "); 
	       query.append("INNER JOIN tblBroadCastQuestionMapping.tblQuestion tblQuestion "); 
	       query.append("INNER JOIN tblBroadCastQuestionMapping.tblClarificationBroadCast tblClarificationBroadCast "); 
	       query.append("with tblClarificationBroadCast.clariBroadCastId =:clariBroadCastId,TblSeekClarification tblSeekClarification ");
	       query.append("INNER JOIN tblSeekClarification.tblCompany tblCompany where tblSeekClarification.clarificationId=tblQuestion.parentId");
	       list = hibernateQueryDao.createNewQuery(query.toString(),var); 
	       return list!=null && !list.isEmpty() ? list : null;
	}
	
    /**
     * 
     * @param questionId
     * @return
     * @throws Exception 
     */
    public  TblQuestionAnswer getQuestionById(int questionId) throws Exception{
            List<TblQuestionAnswer> list = null;
            TblQuestionAnswer questionAnswer = null;
            list = tblQuestionAnswerDao.findTblQuestionAnswer("questionId",Operation_enum.EQ,questionId);
            if(list!=null && !list.isEmpty()) {
            	questionAnswer = list.get(0);
            }
            return questionAnswer;            
    }
    
    
    /**
     * 
     * @param questionId
     * @return
     * @throws Exception 
     */
    public  List<TblQuestionAnswer> getQuestionByEventId(int eventId) throws Exception{
            List<TblQuestionAnswer> list = null;        
            list = tblQuestionAnswerDao.findTblQuestionAnswer("eventId",Operation_enum.EQ,eventId);                
            return list;            
    }
    
    @Transactional
    public List<Object[]> getQuestionAnswerByQuestionId(int questionId,int userType) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("questionId",questionId);
        if(userType == 1) {
            list = hibernateQueryDao.createNewQuery("select tblQuestionAnswer.question, tblQuestionAnswer.questionDate, tblQuestionAnswer.answer, tblQuestionAnswer.answerDate, tblQuestionAnswer.questionId, tblQuestionAnswer.questionId  from  TblQuestionAnswer tblQuestionAnswer where tblQuestionAnswer.questionId=:questionId",var);                
        } else {
        	list = hibernateQueryDao.createNewQuery("select tblQuestionAnswer.question, tblQuestionAnswer.questionDate, tblQuestionAnswer.answer, tblQuestionAnswer.answerDate, tblQuestionAnswer.questionId, tblQuestionAnswer.questionId  from  TblQuestionAnswer tblQuestionAnswer where tblQuestionAnswer.questionId=:questionId",var);                
        }
        return list;        

    }
    
    

    /**
     *
     * @param tblquestion
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addTblQuestion(TblQuestionAnswer tblquestion) throws Exception {
	boolean bSuccess = false;
	tblQuestionAnswerDao.saveOrUpdateEntity(tblquestion);
	bSuccess = true;
	return bSuccess;

    }
    
    
    /**
     * udpate status of  old date of selected clarificationId
     * @param clarificationId
     * @return
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean updateBidderDocStatus(int questionId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("otherSubChildId",questionId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblBidderdocument set cstatus=1 where otherSubChildId=:otherSubChildId",var);        
        return cnt!=0;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean updateOfficerDocStatus(int questionId,int clarificationId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("questionId",questionId);
        var.put("otherSubChildId",clarificationId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblOfficerdocument set otherSubChildId=:questionId where otherSubChildId=:otherSubChildId",var);        
        return cnt!=0;
    }
    
    public Set<String> getTECofficerEmailIds(int tenderId){
		Integer cType = 2;
		Set<String> emailIds = new HashSet<String>();
		
		StringBuilder emailId = new StringBuilder();
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
				if(committeeUser != null){
					for(int i = 0; i < committeeUser.length; i++){
						user += committeeUser[i]+",";
						emailId.append(committeeUserEmailId[i]).append(",");
						emailIds.add(committeeUserEmailId[i]);
					}
				}
			}
			return emailIds;
    	}
}
