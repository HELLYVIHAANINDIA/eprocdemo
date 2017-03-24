/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidder;

/**
 *
 */
public interface TblBidderDao extends GenericDao<TblBidder> {

    public void addTblBidder(TblBidder TblBidder);

    public void deleteTblBidder(TblBidder TblBidder);

    public void updateTblBidder(TblBidder TblBidder);

    public List<TblBidder> getAllTblBidder();

    public List<TblBidder> findTblBidder(Object... values) throws Exception;

    public List<TblBidder> findByCountTblBidder(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidderCount();

    public void saveUpdateAllTblBidder(List<TblBidder> TblBidder);
}
