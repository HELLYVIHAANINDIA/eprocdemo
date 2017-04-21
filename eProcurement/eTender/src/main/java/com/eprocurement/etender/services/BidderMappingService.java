/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.etender.daointerface.TblTenderBidderMapDao;
import com.eprocurement.etender.model.TblTenderBidderMap;


@Service
public class BidderMappingService {

    @Autowired
    HibernateQueryDao hibernateQueryDao;
    @Autowired
    TblTenderBidderMapDao tblTenderBidderMapDao;

    
    /**
     * @return
     */
    public HttpServletRequest getServletRequest() {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attr.getRequest();
    }

    /**
     *
     * @param params
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    @Transactional
    public List<Object[]> getUnmappedBidder(String searchTxt, int... params) throws Exception {
    	StringBuilder query = new StringBuilder();
        int chkCategoryUser = params[4];
        List<Object[]> bidderList = new ArrayList<Object[]>();
        Long[] userIdArray = null;
        Map<String, Object> var = new HashMap<String, Object>();
        if(chkCategoryUser ==1){
        	bidderList = hibernateQueryDao.createNewQuery("select categoryCode,userId from TblCategoryMap where categoryCode in (select categoryCode from TblCategoryMap where tenderId="+params[0]+")  and userId != 0 ",null);
        	if(bidderList != null && !bidderList.isEmpty()){
        		userIdArray = new Long[bidderList.size()];
        		for(int i= 0;i<bidderList.size();i++){
        			userIdArray[i] = Long.parseLong(bidderList.get(i)[1].toString());
        		}
        	}
        }
        var.clear();
        var.put("tenderId", params[0]);
        query.append("select distinct ");
        query.append("tbluserlogin.userId, tblbidder.companyName, tbluserlogin.loginid ");
        query.append(" , tblbidder.phoneno ,tblbidder.tblCountry.countryName,tblbidder.tblState.stateName ,tblbidder.bidderId ");
        query.append(" from  TblUserLogin tbluserlogin ")
              .append(" inner join tbluserlogin.tblBidder tblbidder where 1=1 ");
        if(searchTxt != null && !searchTxt.isEmpty()){
	        if (params[2] == 1) {
	            query.append("and tbluserlogin.loginid like '%").append(searchTxt).append("%'");
	        } else if(params[2] == 3) {
	            query.append("and tblbidder.companyName like '%").append(searchTxt).append("%'");
	        } else if(params[2] == 4) {
	            query.append("and tblbidder.keyword like '%").append(searchTxt).append("%'");
	        }
        }
        query.append(" and tblbidder.cstatus=1 and tblbidder.bidderId not in (")
        .append("select tblbidder.bidderId from TblTenderBidderMap tbltenderbiddermap inner join tbltenderbiddermap.tblBidder tblbidder ")
        .append("where tbltenderbiddermap.tblTender.tenderId=:tenderId) ");
        if(chkCategoryUser ==1){
        	var.put("userIdArray", userIdArray);
        	query.append(" and tbluserlogin.userId in (:userIdArray) ");
        }
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }

    /**
     *
     * @param lstTblTenderBidderMap
     * @param lstTblTenderMapBidderHistory
     * @param mappingType
     * @param lstItemBidderMap
     * @return boolean
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean addAllTenderBidderMap(List<TblTenderBidderMap> lstTblTenderBidderMap, int mappingType) throws Exception {
        boolean bSuccess = false;
        if (!lstTblTenderBidderMap.isEmpty()) {
            tblTenderBidderMapDao.saveUpdateAllTblTenderBidderMap(lstTblTenderBidderMap);
        }
        bSuccess = true;
        return bSuccess;

    }

    /**
     * Remove already mapped bidders
     *
     * @param mapBidderIds
     * @param lstTenderMapBidderHistory
     * @return int
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED)
    public int removeMappedBidders(String mapBidderIds, int mappingType,String mapBiddersIds) throws Exception {
        int cnt = 0;
        StringBuilder query = new StringBuilder();
        query.append("delete from TblTenderBidderMap tbltenderbiddermap where tbltenderbiddermap.mapBidderId in (").append(mapBidderIds).append(")");
        cnt = hibernateQueryDao.updateDeleteNewQuery(query.toString(), null);
        return cnt;
    }

    
    /**
     * return Long
     */
    
    public long getCountFromItemBidderMap(int tenderId)throws Exception{
    	long count=0;
    	
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        StringBuilder selectSQL=new StringBuilder();
        selectSQL.append("select count(tblItemBidderMap.tblTenderBidderMap.mapBidderId) from TblItemBidderMap tblItemBidderMap");
        selectSQL.append(" where tblItemBidderMap.tblTenderBidderMap.mapBidderId in (select tblTenderBidderMap.mapBidderId  from TblTenderBidderMap tblTenderBidderMap where tblTenderBidderMap.tblTender.tenderId=:tenderId)");
    	List<Object> list=hibernateQueryDao.singleColQuery(selectSQL.toString(), var);
    	if(!list.isEmpty()){
    		count=(Long) list.get(0);
    	}
    	return count;    	
    }
    

    /**
     * @return
     * @throws Exception 
     */
    public int deleteTenderBidderMap(int tenderId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderBidderMap tbltenderbiddermap where tbltenderbiddermap.tblTender.tenderId=:tenderId",var);        
        return cnt;
    }

    
    

    /**
     *
     * @param tenderId
     * @param searchTxt
     * @return boolean
     * @throws Exception
     */
    @Transactional
    public boolean isTenderBiddermapped(int tenderId, String searchTxt, int mappingType, int tableId, int rowId) throws Exception {
        long count = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("loginId", searchTxt);
        query.append("select COUNT(tbltenderbiddermap.mapBidderId) ")
             .append(" from TblTenderBidderMap tbltenderbiddermap ")
    		 .append(" inner join tbltenderbiddermap.tblUserLogin tbluserlogin ");
        query.append(" where tbltenderbiddermap.tblTender.tenderId=:tenderId and tbluserlogin.loginid=:loginId");
        List<Object> data = hibernateQueryDao.singleColQuery(query.toString(), var);
        if(!data.isEmpty()){
            count = (Long) data.get(0);
        }        
        return count != 0;
    }
    
    @Transactional
    public boolean isTenderBiddermapped(int tenderId, int companyId) throws Exception {
        long count = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);
        query.append("SELECT COUNT(tbltenderbiddermap.mapBidderId) ");
        query.append(" FROM TblTenderBidderMap tbltenderbiddermap ");
        query.append(" WHERE tbltenderbiddermap.tblTender.tenderId=:tenderId and tbltenderbiddermap.tblBidder.tblCompany.companyid=:companyId ");
        List<Object> data = hibernateQueryDao.singleColQuery(query.toString(), var);
        if(!data.isEmpty()){
            count = (Long) data.get(0);
        }        
        return count != 0;
    }

    /**
     *
     * @param tenderId
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    @Transactional
    public List<Object[]> getTenderBidderMap(int tenderId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);

        query.append("select mapBidderId,tblTenderBidderMap.tblBidder.bidderId,tblTenderBidderMap.tblUserLogin.userId from TblTenderBidderMap tblTenderBidderMap where tblTender.tenderId=:tenderId");
        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }

    
    /**
     *
     * @param tenderId
     * @param companyIds
     * @return {@code List<Object>}
     * @throws Exception
     */
    public List<Object> getFinalSubmissionCompanyDtls(int tenderId, String companyIds) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);

        query.append("select tblCompany.companyId from TblFinalSubmission where tblTender.tenderId=:tenderId and tblCompany.companyId in (")
                .append(companyIds).append(")");

        return hibernateQueryDao.getSingleColQuery(query.toString(), var);
    }

    /**
     *
     * @param mappedBidderId
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    public List<Object[]> GetMappedBidderTableDtls(int mappedBidderId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("mappedBidderId", mappedBidderId);

        query.append("select tbltendertable.tableId,tbltendercell.cellValue,tbltendertable.tableName,tbltendercolumn.columnHeader ")
                .append(" from TblItemBidderMap tblitembiddermap ")
                .append(" inner join tblitembiddermap.tblTenderTable tbltendertable ")
                .append(" inner join tbltendertable.tblTenderColumn tbltendercolumn with tbltendercolumn.tblColumnType.columnTypeId=1 ")
                .append(" inner join tbltendercolumn.tblTenderCell tbltendercell ")
                .append(" where tblitembiddermap.tblTenderBidderMap.mapBidderId=:mappedBidderId and tblitembiddermap.rowId = tbltendercell.rowId ")
                .append(" order by tbltendertable.tableId ,tbltendercell.rowId ");

        return hibernateQueryDao.createNewQuery(query.toString(), var);

    }

    /**
     *
     * @param mappedBidderId
     * @param clientId
     * @return {@code List<Object[]>}
     * @throws Exception
     */
    public List<Object[]> getUserDtlsByMappedBidderId(int mappedBidderId, int clientId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("mappedBidderId", mappedBidderId);
        var.put("clientId", clientId);

        query.append("select tbluserlogin.loginId,tblcompany.companyName  ")
                .append(" from TblTenderBidderMap tbltenderbiddermap ")
                .append(" inner join tbltenderbiddermap.tblUserLogin tbluserlogin ")
                .append(" inner join tbluserlogin.tblBidderStatus tblbidderstatus with tblbidderstatus.tblClient.clientId=:clientId")
                .append(" inner join tblbidderstatus.tblCompany tblcompany ")
                .append(" where mapBidderId=:mappedBidderId");

        return hibernateQueryDao.createNewQuery(query.toString(), var);
    }

    /**
     *
     * @param tenderId
     * @return boolean
     * @throws Exception
     */
    @Transactional
    public boolean isSingleBidderMapped(int tenderId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        count = hibernateQueryDao.countForNewQuery("TblTenderBidderMap tbltenderbiddermap ", "tbltenderbiddermap.mapBidderId ", "tbltenderbiddermap.tblTender.tenderId=:tenderId", var);
        return count == 1;
    }
    
    /**
     * 
     * @param tenderId
     * @param companyId
     * @return boolean
     * @throws Exception 
     */
    public boolean isCompanyMapped(int tenderId, int companyId,int tenderResult) throws Exception{
        long count = 0;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("companyId", companyId);
        query.append("select COUNT(tbltenderbiddermap.mapBidderId) ")
             .append(" from TblTenderBidderMap tbltenderbiddermap ");
        if(tenderResult == 2){
                query.append(" inner join tbltenderbiddermap.tblItemBidderMap tblitembiddermap ");
        }
        query.append(" where tbltenderbiddermap.tblTender.tenderId=:tenderId and tbltenderbiddermap.tblCompany.companyId=:companyId");
        //System.out.println("query isCompanyMapped isCompanyMapped= " + query.toString());
        List<Object> data = hibernateQueryDao.singleColQuery(query.toString(), var);
        if(!data.isEmpty()){
            count = (Long) data.get(0);
        }        
        return count != 0;
    }
     /**
     * 
     * @param tenderId
     * @param columnTypeId
     * @return
     * @throws Exception 
     */
    public List<Object[]> GetMappedItemsByTenderId(int tenderId,int columnTypeId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        StringBuilder queryString = new StringBuilder();
        var.put("tenderId",tenderId);
        var.put("columnTypeId",columnTypeId);
        queryString.append("select tbltenderbiddermap.mapBidderId,tbltendercell.cellValue from TblItemBidderMap tblItemBidderMap ")
                .append("inner join tblItemBidderMap.tblTenderBidderMap tbltenderbiddermap with tbltenderbiddermap.tblTender.tenderId =:tenderId ")
                .append("inner join tblItemBidderMap.tblTenderTable tbltendertable ")
                .append("inner join tbltendertable.tblTenderCell tbltendercell ")
                .append("inner join tbltendercell.tblTenderColumn tbltendercolumn with tbltendercolumn.tblColumnType.columnTypeId =:columnTypeId ")
                .append("inner join tbltendertable.tblTenderForm tblTenderForm with tblTenderForm.cstatus != 2 ")
                .append("where tblItemBidderMap.rowId = tbltendercell.rowId");
        list = hibernateQueryDao.createNewQuery(queryString.toString(),var);                
        return list;        

    }
    /**
     * @param tenderId
     */
    public void deleteMappedBidder(int tenderId,int tenderResult){
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        if(tenderResult==2 || tenderResult==3 ){
        	hibernateQueryDao.updateDeleteNewQuery("delete  from TblItemBidderMap tblItemBidderMap where tblItemBidderMap.tblTenderBidderMap.mapBidderId in (select mapBidderId from TblTenderBidderMap tbltenderbiddermap where tbltenderbiddermap.tblTender.tenderId=:tenderId)",var);
        }
        
        hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderBidderMap tbltenderbiddermap where tbltenderbiddermap.tblTender.tenderId=:tenderId",var);
        
        hibernateQueryDao.updateDeleteNewQuery("delete  from TblTenderMapBidderHistory tblTenderMapBidderHistory where tblTenderMapBidderHistory.tblTender.tenderId=:tenderId",var);
    }
}
