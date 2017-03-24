package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderProxyBid;

public interface TblTenderProxyBidDao extends GenericDao<TblTenderProxyBid> {

    public void addTblTenderProxyBid(TblTenderProxyBid tblTenderProxyBid);

    public void deleteTblTenderProxyBid(TblTenderProxyBid tblTenderProxyBid);

    public void updateTblTenderProxyBid(TblTenderProxyBid tblTenderProxyBid);

    public List<TblTenderProxyBid> getAllTblTenderProxyBid();

    public List<TblTenderProxyBid> findTblTenderProxyBid(Object... values) throws Exception;

    public List<TblTenderProxyBid> findByCountTblTenderProxyBid(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderProxyBidCount();

    public void saveUpdateAllTblTenderProxyBid(List<TblTenderProxyBid> tblTenderProxyBids);
}
