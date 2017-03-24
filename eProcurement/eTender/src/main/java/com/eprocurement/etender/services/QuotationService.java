/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.etender.daointerface.TblPurchaseorderDao;
import com.eprocurement.etender.model.TblPurchaseorder;


@Service
public class QuotationService {

    @Autowired
    TblPurchaseorderDao tblPurchaseorderDao;
    @Autowired
    CommonDAO commonDAO;

   
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
    public boolean addPurchaseOrder(TblPurchaseorder tblPurchaseorder,String optType) throws Exception {
        boolean bSuccess = false;
        if(optType.equals("edit")) {
        	tblPurchaseorderDao.saveOrUpdateEntity(tblPurchaseorder);
        }else {
        	tblPurchaseorderDao.addTblPurchaseorder(tblPurchaseorder);
        }
        bSuccess=true;
        return bSuccess;
    }
    
    
    @Transactional(propagation = Propagation.REQUIRED)
    public TblPurchaseorder getPurchaseOrderById(int poId) throws Exception {
    	TblPurchaseorder tblPurchaseorder = null;
    	List<TblPurchaseorder> tblPurchaseorders = tblPurchaseorderDao.findTblPurchaseorder("poid",Operation_enum.EQ,poId);
    	if(tblPurchaseorders!=null && !tblPurchaseorders.isEmpty()) {
    		tblPurchaseorder=tblPurchaseorders.get(0);
    	}
    	return tblPurchaseorder;
    }
    
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean publishPurchaseorder(int poId) throws Exception {
    	boolean bSuccess = false;
    	Map<String,Object> column = new HashMap<String, Object>();
		column.put("poId", poId);
		String query = "update TblPurchaseorder set cstatus=1 where poId=:poId";
		commonDAO.executeUpdate(query, column);
		bSuccess=true;
		return bSuccess;
    }
    
    
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean cancelPurchaseorder(int poId) throws Exception {
    	boolean bSuccess = false;
    	Map<String,Object> column = new HashMap<String, Object>();
		column.put("poId", poId);
		String query = "update TblPurchaseorder set cstatus=2 where poId=:poId";
		commonDAO.executeUpdate(query, column);
		bSuccess=true;
		return bSuccess;
    }
    
    
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean acknowledgePurchaseOrder(int poId,String remarks,int isAcknowledge) throws Exception {
    	boolean bSuccess = false;
    	Map<String,Object> column = new HashMap<String, Object>();
		column.put("poId", poId);
		column.put("remarks", remarks);
		column.put("isAcknowledge", isAcknowledge);
		String query = "update TblPurchaseorder set isAcknowledge=:isAcknowledge,remarks=:remarks where poId=:poId";
		commonDAO.executeUpdate(query, column);
		bSuccess=true;
		return bSuccess;
    }
    
    
    @Transactional(propagation = Propagation.REQUIRED)
    public TblPurchaseorder getPurchaseOrderByTenderAndBidderId(int tenderId,int bidderId) throws Exception {
    	TblPurchaseorder tblPurchaseorder = null;
    	List<TblPurchaseorder> tblPurchaseorders = tblPurchaseorderDao.findTblPurchaseorder("bidderid",Operation_enum.EQ,bidderId,"tenderId",Operation_enum.EQ,tenderId);
    	if(tblPurchaseorders!=null && !tblPurchaseorders.isEmpty()) {
    		tblPurchaseorder=tblPurchaseorders.get(0);
    	}
    	return tblPurchaseorder;
    }
    
    
    @Transactional(propagation = Propagation.REQUIRED)
    public List<TblPurchaseorder> getPurchaseOrderByTenderId(int tenderId) throws Exception {
    	TblPurchaseorder tblPurchaseorder = null;
    	List<TblPurchaseorder> tblPurchaseorders = tblPurchaseorderDao.findTblPurchaseorder("tenderId",Operation_enum.EQ,tenderId);
    	if(tblPurchaseorders!=null && !tblPurchaseorders.isEmpty()) {
    	}
    	return tblPurchaseorders;
    }
    
}
