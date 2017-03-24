/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderBid;

public interface TblTenderBidDao extends GenericDao<TblTenderBid> {

    public void addTblTenderBid(TblTenderBid tblTenderBid);

    public void deleteTblTenderBid(TblTenderBid tblTenderBid);

    public void updateTblTenderBid(TblTenderBid tblTenderBid);

    public List<TblTenderBid> getAllTblTenderBid();

    public List<TblTenderBid> findTblTenderBid(Object... values) throws Exception;

    public List<TblTenderBid> findByCountTblTenderBid(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderBidCount();

    public void saveUpdateAllTblTenderBid(List<TblTenderBid> tblTenderBids);
}
