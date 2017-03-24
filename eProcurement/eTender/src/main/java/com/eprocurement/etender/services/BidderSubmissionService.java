/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.daointerface.TblEventTermAndConditionsDao;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.etender.daointerface.TblBidDetailDao;
import com.eprocurement.etender.daointerface.TblBidWithdrawalDao;
import com.eprocurement.etender.daointerface.TblItemSelectionDao;
import com.eprocurement.etender.daointerface.TblTenderBidConfirmationDao;
import com.eprocurement.etender.daointerface.TblTenderBidCurrencyDao;
import com.eprocurement.etender.daointerface.TblTenderBidDao;
import com.eprocurement.etender.daointerface.TblTenderBidDetailDao;
import com.eprocurement.etender.daointerface.TblTenderBidMatrixDao;
import com.eprocurement.etender.daointerface.TblTenderBidOpenSignDao;
import com.eprocurement.etender.daointerface.TblTenderCellGrandTotalDao;
import com.eprocurement.etender.daointerface.TblTenderOpenDao;
import com.eprocurement.etender.daointerface.TblTenderProxyBidDao;
import com.eprocurement.etender.daointerface.TblTenderRebateDao;
import com.eprocurement.etender.model.TblBidDetail;
import com.eprocurement.etender.model.TblBidWithdrawal;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblEventTermAndConditions;
import com.eprocurement.etender.model.TblFinalsubmission;
import com.eprocurement.etender.model.TblItemSelection;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderBid;
import com.eprocurement.etender.model.TblTenderBidCurrency;
import com.eprocurement.etender.model.TblTenderBidDetail;
import com.eprocurement.etender.model.TblTenderBidMatrix;
import com.eprocurement.etender.model.TblTenderBidOpenSign;
import com.eprocurement.etender.model.TblTenderCell;
import com.eprocurement.etender.model.TblTenderCellGrandTotal;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderProxyBid;
import com.eprocurement.etender.model.TblTenderRebate;
import com.eprocurement.etender.model.TblTenderbidconfirmation;
import com.eprocurement.etender.model.TblTenderopen;

@Service
public class BidderSubmissionService {

    @Autowired
    TblTenderBidMatrixDao tblTenderBidMatrixDao;
    
    @Autowired
    HibernateQueryDao hibernateQueryDao;
    
    @Autowired
    TblTenderBidDao tblTenderBidDao;
    
    @Autowired
    CommonService commonService;
    
    
    @Autowired
    TblTenderBidCurrencyDao tblTenderBidCurrencyDao;
    
    @Autowired
    TblTenderBidConfirmationDao tblTenderBidConfirmationDao;
    
    @Autowired
    TblTenderProxyBidDao tblTenderProxyBidDao;
    
    @Autowired
    TblTenderOpenDao tblTenderOpenDao;
    
    @Autowired
    TblTenderBidOpenSignDao tblTenderBidOpenSignDao;
    
    @Autowired
    TblTenderBidDetailDao tblTenderBidDetailDao;
    
    @Autowired
    TblBidWithdrawalDao tblBidWithdrawalDao;
    
    @Autowired
    TblTenderRebateDao tblTenderRebateDao;
    
    @Autowired
    TenderCommonService tenderCommonService;
    
    @Autowired
    TblEventTermAndConditionsDao termAndConditionsDao;
    
    @Autowired
    TblBidDetailDao tblBidDetailDao;
    
    @Autowired
    TblItemSelectionDao tblItemSelectionDao;
    
    @Autowired
    TblTenderCellGrandTotalDao tblTenderCellGrandTotalDao;
    
    private static final String TENDERID = "tenderId";
    private static final String COMPANYID =  "companyId";


    public List<TblTenderBidMatrix> getTableBidMatrix(int bidId) throws Exception {
    	return tblTenderBidMatrixDao.findTblTenderBidMatrix("tblTenderbid", Operation_enum.EQ, new TblTenderBid(bidId));
    }
    @Transactional
    public List<Object[]> getTenderBidConfirmForm() throws Exception{
      	StringBuilder query = new StringBuilder();
  		 Map<String, Object> map = new HashMap<String, Object>();
  	        map.put("isActive", 1);
  	        query.append("SELECT tblclientbidterm.clientBidTermId ,tblclientbidterm.bidTerm ")
             .append(" FROM  TblClientBidTerm tblclientbidterm ")
             .append(" WHERE tblclientbidterm.isActive=:isActive");   
  			return hibernateQueryDao.createNewQuery(query.toString(),map);
      }
    
    @Transactional
    public TblEventTermAndConditions getTermAndConditionByEventId(int eventId) throws Exception {
		TblEventTermAndConditions tblEventTermAndConditions = null;
		List<TblEventTermAndConditions> tblEventTermAndConditionsLst = null; 
		tblEventTermAndConditionsLst = termAndConditionsDao.findTblEventTermAndConditions("eventId",Operation_enum.EQ,eventId);
		if(tblEventTermAndConditionsLst!=null && !tblEventTermAndConditionsLst.isEmpty()) {
			tblEventTermAndConditions = tblEventTermAndConditionsLst.get(0);
		}
		return tblEventTermAndConditions;		
	}
    
    @Transactional
    public List<TblTenderBid> getTenderBid(int tenderId, Object[] companyIds, Object[] formIds) throws Exception {
    	StringBuilder query = new StringBuilder();
	   	Map<String, Object> var = new HashMap<String, Object>();
	   	List<Object[]> list = new ArrayList<Object[]>();
	   	var.put("tenderId", tenderId);
	    var.put("companyIds", companyIds);
	    var.put("formIds", formIds);
	    query.append(" SELECT tblTenderBid.bidid,tblTenderBid.bidderid,tblTenderBid.bidprice,tblTenderBid.createdby,tblTenderBid.createdon,tblTenderBid.cstatus");
	    query.append(" ,tblTenderBid.ipaddress,tblTenderBid.tblCompany.companyid,tblTenderBid.tblTender.tenderId,tblTenderBid.tblTenderenvelope.envelopeId");
	    query.append(" ,tblTenderBid.tblTenderform.formId");
	    query.append(" FROM TblTenderBid tblTenderBid");
	    query.append(" WHERE tblTenderBid.tblTender.tenderId=:tenderId AND tblTenderBid.tblCompany IN(:companyIds) AND tblTenderBid.tblTenderform IN(:formIds)");
	    list = hibernateQueryDao.createNewQuery(query.toString(),var);
	    
	    List<TblTenderBid> tblTenderBidList = new ArrayList<TblTenderBid>();
		for(Object[] bidDetails  : list){
			TblTenderBid tblTenderBid = new TblTenderBid();
			tblTenderBid.setBidid(Integer.parseInt(bidDetails[0].toString()));
			tblTenderBid.setBidderid(Integer.parseInt(bidDetails[1].toString()));
			tblTenderBid.setBidprice(new BigDecimal(bidDetails[2].toString()));
			tblTenderBid.setCreatedby(Integer.parseInt(bidDetails[3].toString()));
			tblTenderBid.setCstatus(Integer.parseInt(bidDetails[5].toString()));
			tblTenderBid.setIpaddress(bidDetails[6].toString());
			tblTenderBid.setTblCompany(new TblCompany(Integer.parseInt(bidDetails[7].toString())));
			tblTenderBid.setTblTender(new TblTender(Integer.parseInt(bidDetails[8].toString())));
			tblTenderBid.setTblTenderenvelope(new TblTenderEnvelope(Integer.parseInt(bidDetails[9].toString())));
			tblTenderBid.setTblTenderform(new TblTenderForm(Integer.parseInt(bidDetails[10].toString())));
			
			tblTenderBidList.add(tblTenderBid);
		}
		return tblTenderBidList;
    }
    
    @Transactional
    public boolean isTenderIdRepeated(int tenderId,long bidderId) throws Exception{
        long count=0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDERID,tenderId);
        var.put("bidderId",bidderId);
        count = hibernateQueryDao.countForNewQuery("TblTenderbidconfirmation tbltenderbidconfirmation ","tbltenderbidconfirmation.bidconfirmationid ","tbltenderbidconfirmation.bidderid=:bidderId and tbltenderbidconfirmation.tblTender.tenderId=:tenderId",var);
        return count!=0;
    }
    @Transactional
    public List<Object[]> getCurrencies(int tenderId, int companyId, boolean isBidCurrency) throws Exception{    	 
 		 StringBuilder query = new StringBuilder();
 		 Map<String, Object> map = new HashMap<String, Object>();
 		 map.put(TENDERID, tenderId);
 		 map.put("isActive", 1);
 		 
 		 query.append(" select tbltendercurrency.tenderCurrencyId, tblcurrency.currencyName");
 		 if(isBidCurrency){
 			query.append(",tbltenderbidcurrency.bidCurrencyId ");
 		 }
 		query.append(" from tbl_tendercurrency tbltendercurrency");
 		 if(isBidCurrency){
 			 map.put("companyId", companyId);
 			 query.append(" inner join Tbl_TenderBidCurrency tbltenderbidcurrency on tbltendercurrency.tenderCurrencyId=tbltenderbidcurrency.tenderCurrencyId and tbltenderbidcurrency.companyId =:companyId");
 		 }
 		
 		 query.append(" inner join tbl_currency tblcurrency on tblcurrency.currencyId=tbltendercurrency.currencyId");	
 			 query.append(" where tbltendercurrency.tenderId =:tenderId and tbltendercurrency.isactive =:isActive");
 		 return hibernateQueryDao.createSQLQuery(query.toString(),map);    
      }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addTenderBidCurrency(TblTenderBidCurrency tblTenderBidCurrency) throws Exception{
        boolean bSuccess = false;             
           tblTenderBidCurrencyDao.addTblTenderBidCurrency(tblTenderBidCurrency);
           bSuccess=true;        
           return bSuccess;

    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addTenderBidConfm(TblTenderbidconfirmation tenderBidConfirmation, List<TblTenderProxyBid>lstTblTenderProxyBid ) throws Exception{
		boolean bSuccess = false;
		tblTenderBidConfirmationDao.addTblTenderBidConfirmation(tenderBidConfirmation);
		if(lstTblTenderProxyBid != null && !lstTblTenderProxyBid.isEmpty()){
			tblTenderProxyBidDao.saveUpdateAllTblTenderProxyBid(lstTblTenderProxyBid);
		}
		bSuccess = true;
		return bSuccess;
  }
    @Transactional
    public List<Object> getTenderBidForms(int tenderId, Object[] companyIds, int envelopeType) throws Exception {
    	StringBuffer query = new StringBuffer();
    	query.append("SELECT tblTenderBid.tblTenderform.formId FROM TblTenderBid tblTenderBid ");
    	query.append(" INNER JOIN tblTenderBid.tblTenderform tblTenderform ");
    	query.append(" INNER JOIN tblTenderBid.tblTenderenvelope tblTenderenvelope ");
    	query.append(" WHERE tblTenderBid.tblTender.tenderId = :tenderId AND tblTenderBid.tblCompany IN (:companyIds) AND tblTenderform.cstatus != 2 ");    	
    	if(envelopeType == 2){
    		query.append(" AND tblTenderenvelope.sortOrder = 1");    		
    	}
    	List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyIds",companyIds);
        list = hibernateQueryDao.getSingleColQuery(query.toString(),var);        
        return list;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addTenderBidOpenDetails(String ipAddress, int... params) throws Exception {
        boolean bSuccess = false;
        Object[] companyIds = {new TblCompany(params[1])};
        TblTender tblTender =  tenderCommonService.getTenderById(params[0]);
        
        List<Object> formIdList = getTenderBidForms(params[0], companyIds, params[4]);
        Object[] formIds = new Object[formIdList.size()];
        for(int i=0; i<formIdList.size(); i++){
        	formIds[i] = new TblTenderForm((Integer) formIdList.get(i));
        }
        
        if(formIds.length > 0){
        	List<TblTenderBid> tblTenderBidList = getTenderBid(params[0], companyIds, formIds);
    		
    		if(tblTenderBidList != null && !tblTenderBidList.isEmpty()){
    			List<TblTenderopen> tblTenderOpenList = new ArrayList<TblTenderopen>();
    			List<TblTenderBidOpenSign> tblTenderBidOpenSignList = new ArrayList<TblTenderBidOpenSign>();
    			List<TblTenderBidDetail> tblTenderBidDetailList = new ArrayList<TblTenderBidDetail>();
    			List<String> userFormIds = new ArrayList<String>();
    			
        		for(TblTenderBid tblTenderBid : tblTenderBidList){
        			String userFormId = tblTenderBid.getTblTenderform().getFormId() + "~" + tblTenderBid.getTblCompany().getCompanyid(); 
        			if(!userFormIds.contains(userFormId)){
        				userFormIds.add(userFormId);
        				TblTenderopen tblTenderOpen = new TblTenderopen();
            			tblTenderOpen.setTblTender(tblTenderBid.getTblTender());
            			tblTenderOpen.setTblTenderenvelope(tblTenderBid.getTblTenderenvelope());
            			tblTenderOpen.setTblTenderForm(tblTenderBid.getTblTenderform());
            			tblTenderOpen.setTblCompany(tblTenderBid.getTblCompany());
            			tblTenderOpen.setBidderid(tblTenderBid.getBidderid());
            			tblTenderOpen.setDecryptionlevel(0);
            			tblTenderOpen.setIpaddress(ipAddress);
            			tblTenderOpen.setCreatedby(params[4]);
            			tblTenderOpenList.add(tblTenderOpen);
        			}
        			
        			List<TblTenderBidMatrix> tblTenderBidMatrixList = getTableBidMatrix(tblTenderBid.getBidid());
        			
        			if(tblTenderBidMatrixList != null && !tblTenderBidMatrixList.isEmpty()){
        				for(TblTenderBidMatrix tblTenderBidMatrix : tblTenderBidMatrixList){
        					TblTenderBidOpenSign tblTenderBidOpenSign = new TblTenderBidOpenSign();
        					tblTenderBidOpenSign.setTblTenderbidmatrix(tblTenderBidMatrix);
        					tblTenderBidOpenSign.setDecryptedbid(tblTenderBidMatrix.getBidjson());
        					tblTenderBidOpenSign.setBidsigntext(tblTenderBidMatrix.getBidjson());
        					tblTenderBidOpenSign.setCreatedby(params[4]);
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
	        							JSONArray bidArray = new JSONArray(jsonValue);
	        								JSONObject jcellValue =  bidArray.getJSONObject(0);
	        								tblTenderBidDetail.setCellvalue(jcellValue.getString("cellValue"));
	        							tblTenderBidDetailList.add(tblTenderBidDetail);
	                                }
	        					}
        				}
        			}
        		}
        		if(!tblTenderOpenList.isEmpty()){
                	tblTenderOpenDao.saveUpdateAllTblTenderOpen(tblTenderOpenList);
                	
                }
        		if(!tblTenderBidDetailList.isEmpty()){
        			tblTenderBidDetailDao.saveUpdateAllTblTenderBidDetail(tblTenderBidDetailList);
        		}
    		}	
        }
        
        bSuccess = true;
        return bSuccess;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public boolean withdrawBid(int tenderId, int bidderId, int companyId, String remark, String ipAddress,int userId,TblFinalsubmission tblFinalsubmission) throws Exception {
 	   	boolean result=false;
 	   	result = spBidWithdrawal(tenderId, companyId, bidderId, ipAddress, remark,userId,tblFinalsubmission);
        deleteBidOpenData(tenderId, companyId);
        deleteTenderRebateDetails(tenderId, companyId);
//        deleteTenderBidderDocs(tenderId, bidderId);
        return result;
    }
    
    @Transactional
   	public boolean deleteTenderBidderDocs(int tenderId,int bidderId) throws Exception{
       	int cnt = 0;
           Map<String, Object> var = new HashMap<String, Object>();
           var.put("tenderId",tenderId);
           var.put("bidderId",bidderId);
           cnt = hibernateQueryDao.updateDeleteNewQuery("delete from TblBidderdocument where bidderId =:bidderId AND tenderId=:tenderId",var);        
           return cnt!=0;
    }
    @Transactional
	public boolean deleteTblFinalsubmission(int tenderId,int companyId) throws Exception{
    	int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete from TblFinalsubmission tblFinalsubmission where tblFinalsubmission.tblTender.tenderId=:tenderId and tblFinalsubmission.tblCompany.companyid=:companyId",var);        
        return cnt!=0;
    }

    @Transactional
    private boolean spBidWithdrawal(int tenderId,int companyId, int bidderId, String ipAddress, String remark,int userId,TblFinalsubmission tblFinalsubmission) throws Exception {
    	boolean result=false;
    	deleteTblBidWithdrawal(tblFinalsubmission,bidderId,remark,ipAddress,userId);
    	deleteTblFinalsubmission(tenderId,companyId);
    	result=true;
		return result;
	}

    @Transactional
	public boolean deleteTblBidWithdrawal(TblFinalsubmission tblFinalsubmission,int bidderId,String remark,String ipAddress,int userId) throws Exception{
    	boolean result=false;
    	TblBidWithdrawal tblBidWithdrawal = new TblBidWithdrawal();
    	tblBidWithdrawal.setTblTender(tblFinalsubmission.getTblTender());
    	tblBidWithdrawal.setTblCompany(tblFinalsubmission.getTblCompany());
    	tblBidWithdrawal.setBidderId(bidderId);
    	tblBidWithdrawal.setRemark(remark);
    	tblBidWithdrawal.setFinalSubmissionDate(tblFinalsubmission.getCreatedon());
    	tblBidWithdrawal.setFinalSubmissionIPAddress(tblFinalsubmission.getIpaddress());
    	tblBidWithdrawal.setIpAddress(ipAddress);
    	tblBidWithdrawal.setCreatedBy(userId);
    	tblBidWithdrawalDao.addTblBidWithdrawal(tblBidWithdrawal);
    	result=true;
		return result;
    }

    @Transactional
	public boolean deleteTenderRebateDetails(int tenderId, int companyId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderRebate tbltenderrebate where tbltenderrebate.tblTender.tenderId=:tenderId and tbltenderrebate.tblCompany.companyid=:companyId",var);
        return cnt!=0;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean deleteBidOpenData(int tenderId, int companyId) throws Exception {
    	boolean bSuccess = false;
    	List<Object> bidIds = null;
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
    	bidIds = hibernateQueryDao.getSingleColQuery("select tblTenderBid.bidid from TblTenderBid tblTenderBid where tblTenderBid.tblTender.tenderId=:tenderId and tblTenderBid.tblCompany.companyid=:companyId",var);
    	
    	List<Object> bidTableIds = null;
    	Map<String, Object> var1 = new HashMap<String, Object>();
        var1.put("bidIds",bidIds);
        bidTableIds = hibernateQueryDao.getSingleColQuery("select tblTenderBidMatrix.bidtableid from TblTenderBidMatrix tblTenderBidMatrix where tblTenderBidMatrix.tblTenderbid.bidid in (:bidIds)",var1);
        
        if(!bidIds.isEmpty() ){
        	deleteTenderOpenData(tenderId, companyId);
        }        
        if(!bidTableIds.isEmpty()){
        	deleteTenderBidDetailData(bidTableIds);        	
        }
        bSuccess = true;
        return bSuccess;
    }
    @Transactional
    public boolean deleteTenderOpenData(int tenderId, int companyId) throws Exception {
   	 int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete from TblTenderopen tblTenderOpen where tblTenderOpen.tblTender.tenderId=:tenderId and tblTenderOpen.tblCompany.companyid=:companyId",var);        
        return cnt!=0;
   }
    @Transactional
    public boolean deleteTenderBidDetailData(List<Object> bidTableIds) throws Exception {
    	int cnt = 0;
    	Map<String, Object> var = new HashMap<String, Object>();
    	var.put("bidTableIds",bidTableIds);
    	cnt = hibernateQueryDao.updateDeleteNewQuery("delete from TblTenderBidDetail tblTenderBidDetail where tblTenderBidDetail.tblTenderbidmatrix.bidtableid in (:bidTableIds)",var);        
    	return cnt!=0;
    }

    @Transactional
    public boolean addTenderRebateDetails(int tenderId, int companyId) throws Exception {
    	int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("INSERT INTO TblRebateDetail (tblTenderRebate, rebateValue, decryptionLevel) select tblTenderRebate, tblTenderRebate.rebateValue, 0 from TblRebate tblRebate inner join tblRebate.tblTenderRebate tblTenderRebate where tblRebate.tblTender.tenderId = :tenderId and tblTenderRebate.tblCompany.companyid = :companyId",var);        
        return cnt!=0;
    }
    
    @Transactional
    public List<Object[]> getRebateFormTenderBidCount(int tenderId, int companyId) throws Exception{
        StringBuilder query = new StringBuilder();
         Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDERID,tenderId);
        var.put(COMPANYID,companyId);
        
        query.append("select count(distinct tblrebateform.tblTenderForm.formId),tbltenderform.cstatus")
        		.append(" ,count(distinct tbltenderbid.bidid) ")
                .append(" from TblRebate tblrebate ")
                .append(" inner join tblrebate.tblRebateForm tblrebateform ")
                .append(" inner join tblrebateform.tblTenderForm tbltenderform with tbltenderform.cstatus=1")
                .append(" left join tbltenderform.tblTenderBid tbltenderbid with tbltenderbid.tblCompany.companyid=:companyId and tbltenderbid.cstatus=2")
                .append(" where tblrebate.tblTender.tenderId=:tenderId");
        
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    @Transactional
    public List<Object> getRebateCellId(int formId) throws Exception{
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        list = hibernateQueryDao.getSingleColQuery("select tblrebateform.tblTenderCell.cellId from TblRebateForm tblrebateform where tblrebateform.tblTenderForm.formId=:formId",var);                
        return list;        

    }
    @Transactional
    public List<Object[]> getBidWithDrawaldtls(int tenderId,int companyId)throws Exception{
        StringBuilder query = new StringBuilder();
         Map<String, Object> var = new HashMap<String, Object>();
	 var.put(TENDERID, tenderId);
	 var.put(COMPANYID, companyId);
        
        query.append("select tblbidwithdrawal.remark,tblbidwithdrawal.finalSubmissionDate,tblbidwithdrawal.finalSubmissionIPAddress,")
                .append("tblbidwithdrawal.ipAddress,tblbidwithdrawal.createdOn ")
                .append(" from TblBidWithdrawal tblbidwithdrawal ")
                .append(" where tblbidwithdrawal.tblTender.tenderId=:tenderId and tblbidwithdrawal.tblCompany.companyid=:companyId")
                .append(" order by tblbidwithdrawal.bidWithdrawalId desc");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }
    @Transactional
    public boolean isFinalSubmissionDone(int tenderId, int companyId) throws Exception {
      	long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDERID, tenderId);
        var.put(COMPANYID, companyId);
        count = hibernateQueryDao.countForNewQuery("TblFinalsubmission tblfinalsubmission ", "tblfinalsubmission.finalsubmissionid ", "tblfinalsubmission.tblCompany.companyid=:companyId and tblfinalsubmission.tblTender.tenderId=:tenderId and tblfinalsubmission.isactive=1", var);
        return count != 0;
   }
    @Transactional
    public boolean checkFormBided(int formId,int companyId) throws Exception{
        long count=0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        var.put("companyId",companyId);
        count = hibernateQueryDao.countForNewQuery("TblTenderBid tbltenderbid ","tbltenderbid.bidid ","tbltenderbid.tblCompany.companyid=:companyId and tbltenderbid.tblTenderform.formId=:formId",var);
        return count==0;
    }
    @Transactional
    public boolean deleteBid(int bidId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("bidId",bidId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderBidMatrix tbltenderbidmatrix where tbltenderbidmatrix.tblTenderbid.bidid=:bidId",var);        
        return cnt!=0;

    }
    @Transactional
    public int getFormRebate(int tenderId,int formId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(TENDERID,tenderId);
        var.put("formId",formId);
        List<Object> list = hibernateQueryDao.getSingleColQuery("select tblrebate.rebateId from TblRebate tblrebate inner join tblrebate.tblRebateForm tblrebateform where tblrebate.tblTender.tenderId=:tenderId and tblrebateform.tblTenderForm.formId=:formId",var);                
        return list.isEmpty() ? 0 : (Integer)list.get(0);
    }
    
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
    public boolean deleteBidSubmitted(int bidId,int tenderId,int formId,int companyId,int bidderId) throws Exception{
        int cnt = 0;
        int cnt1 = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put(COMPANYID,companyId);
        hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderRebate tbltenderrebate where tbltenderrebate.tblTender.tenderId=:tenderId and tbltenderrebate.tblCompany.companyid=:companyId",var);
        
        var.clear();
        var.put(TENDERID,tenderId);
        List<Object> tenderData = hibernateQueryDao.singleColQuery("select isItemSelectionPageRequired from TblTender where tenderId=:tenderId", var);
        var.clear();
        
        var.put("formId",formId);
        List<Object> formData = hibernateQueryDao.singleColQuery("select isPriceBid from TblTenderForm where formId=:formId", var);
        if(!formData.isEmpty()){
        	var.put("companyId",companyId);
            if((Integer)formData.get(0)==0){
                hibernateQueryDao.updateDeleteNewQuery("delete from TblItemSelection where tblTenderForm.formId=:formId and tblCompany.companyid=:companyId", var);                
            }else{
                if(!tenderData.isEmpty()){
                    if((Integer)tenderData.get(0)==1){
                        hibernateQueryDao.updateDeleteNewQuery("update TblItemSelection set isBidded=0 where tblTenderForm.formId=:formId and tblCompany.companyid=:companyId", var);
                    }else if((Integer)tenderData.get(0)==0){
                        hibernateQueryDao.updateDeleteNewQuery("delete from TblItemSelection where tblTenderForm.formId=:formId and tblCompany.companyid=:companyId", var);
                    }
                }
            }
        }
        var.clear();
        var.put("bidId",bidId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderBidMatrix tblTenderBidMatrix where tblTenderBidMatrix.tblTenderbid.bidid=:bidId",var);
        
        var.clear();
        var.put("bidId",bidId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderBid tbltenderbid where tbltenderbid.bidid=:bidId",var);
        
        var.clear();
        var.put(TENDERID,tenderId);
        var.put("formId",formId);
        var.put("bidderId",bidderId);
        cnt1 = hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderCellGrandTotal tblTenderCellGrandTotal where tblTenderCellGrandTotal.tblTender.tenderId=:tenderId AND tblTenderCellGrandTotal.tblBidder.bidderId=:bidderId AND tblTenderCellGrandTotal.tblTenderForm.formId=:formId",var);
        return cnt!=0;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBidderBid(TblTenderBid tblTenderBid, List<TblTenderBidMatrix> tblTenderBidMatrixs,List<TblBidDetail> bidDetails,List<TblItemSelection> itemSelections,List<TblTenderCellGrandTotal> lstTblTenderCellGrandTotal) throws Exception {
        boolean bSuccess = false;
        if(tblTenderBid!=null){
            tblTenderBidDao.addTblTenderBid(tblTenderBid);
        }else{
            if(!tblTenderBidMatrixs.isEmpty()){
                deleteBid(tblTenderBidMatrixs.get(0).getTblTenderbid().getBidid());
            }
        }
        if(!tblTenderBidMatrixs.isEmpty()){
        	tblTenderBidMatrixDao.saveUpdateAllTblTenderBidMatrix(tblTenderBidMatrixs);
        }
       
        if(!bidDetails.isEmpty()){
            Map<String, Object> var = new HashMap<String, Object>();
            var.put("companyId",bidDetails.get(0).getTblCompany().getCompanyid());
            var.put("formId",bidDetails.get(0).getTblTenderForm().getFormId());
            hibernateQueryDao.updateDeleteNewQuery("delete from TblBidDetail where companyId=:companyId and formId=:formId", var);
            tblBidDetailDao.saveUpdateAllTblBidDetail(bidDetails);
        }        
        if(!itemSelections.isEmpty()){
            if(itemSelections.get(0).getIsSelected()==-1){
                Map<String, Object> var = new HashMap<String, Object>();
                var.put("companyId",itemSelections.get(0).getTblCompany().getCompanyid());
                var.put("formId",itemSelections.get(0).getTblTenderForm().getFormId());
                Map<Integer,List<Integer>> tableRows = new HashMap<Integer, List<Integer>>();
                for (TblItemSelection tblItemSelection : itemSelections) {
                    List<Integer> rowId = null;
                    if(tableRows.containsKey(tblItemSelection.getTblTenderTable().getTableId())){
                        rowId = tableRows.get(tblItemSelection.getTblTenderTable().getTableId());
                    }else{                        
                        rowId = new ArrayList<Integer>();
                    }
                    tblItemSelection.setCreatedOn(commonService.getServerDateTime());
                    rowId.add(tblItemSelection.getRowId());
                    tableRows.put(tblItemSelection.getTblTenderTable().getTableId(), rowId);
                }
                for (Integer tableId : tableRows.keySet()) {
                    var.put("tableId",tableId);
                    var.put("rowId",tableRows.get(tableId));
                    hibernateQueryDao.updateDeleteNewQuery("update TblItemSelection set isBidded=1 where tblTenderForm.formId=:formId and tblCompany.companyid=:companyId and tblTenderTable.tableId=:tableId and rowId in (:rowId)", var);
                }
                
            }else{
                Map<String, Object> var = new HashMap<String, Object>();
                var.put("companyId",itemSelections.get(0).getTblCompany().getCompanyid());
                var.put("formId",itemSelections.get(0).getTblTenderForm().getFormId());
                hibernateQueryDao.updateDeleteNewQuery("delete from TblItemSelection where tblTenderForm.formId=:formId and tblCompany.companyid=:companyId", var);
                tblItemSelectionDao.saveUpdateAllTblItemSelection(itemSelections);
            }
        }
        if(!tblTenderBidMatrixs.isEmpty()){
            Map<String, Object> var = new HashMap<String, Object>();
            var.put("bidId",tblTenderBidMatrixs.get(0).getTblTenderbid().getBidid());
            var.put("ipAddress",tblTenderBidMatrixs.get(0).getTblTenderbid().getIpaddress());
            var.put("cstatus",tblTenderBidMatrixs.get(0).getTblTenderbid().getCstatus());
            hibernateQueryDao.updateDeleteNewQuery("update TblTenderBid set ipAddress=:ipAddress,cstatus=:cstatus where bidId=:bidId", var);
        }
        if(!lstTblTenderCellGrandTotal.isEmpty()){
        	 Map<String, Object> var1 = new HashMap<String, Object>();
        	 var1.put("tenderId",lstTblTenderCellGrandTotal.get(0).getTblTender().getTenderId());
        	 var1.put("bidderId",lstTblTenderCellGrandTotal.get(0).getTblBidder().getBidderId());
        	 var1.put("formId",lstTblTenderCellGrandTotal.get(0).getTblTenderForm().getFormId());
             hibernateQueryDao.updateDeleteNewQuery("delete from TblTenderCellGrandTotal tblTenderCellGrandTotal where tblTenderCellGrandTotal.tblTender.tenderId=:tenderId and tblTenderCellGrandTotal.tblBidder.bidderId=:bidderId AND tblTenderCellGrandTotal.tblTenderForm.formId=:formId", var1);
             
        	tblTenderCellGrandTotalDao.saveUpdateAllTblTenderCellGrandTotal(lstTblTenderCellGrandTotal);
        }
        
        bSuccess = true;
        return bSuccess;

    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addTenderRebate(TblTenderRebate tblTenderRebate) throws Exception{
        boolean bSuccess = false;             
        tblTenderRebateDao.addTblTenderRebate(tblTenderRebate);
        bSuccess=true;        
        return bSuccess;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean editTenderRebate(int tenderId,TblTenderRebate tenderRebate,int companyId) throws Exception{
    boolean bSuccess = false;
    boolean dSuccess = false;
    
    	dSuccess = deleteTenderRebate(tenderId,companyId);
    	
    	if(dSuccess){
    		tblTenderRebateDao.addTblTenderRebate(tenderRebate);
            bSuccess=true;
            return bSuccess;
    	}
    	 return bSuccess;
    }
    @Transactional
    public boolean deleteTenderRebate(int tenderId,int companyId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("companyId",companyId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderRebate tbltenderrebate where tbltenderrebate.tblCompany.companyid=:companyId and tbltenderrebate.tblTender.tenderId=:tenderId",var);        
        return cnt!=0;

    }

}
