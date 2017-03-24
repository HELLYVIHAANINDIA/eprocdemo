package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidderItems;

public interface TblBidderItemsDao extends GenericDao<TblBidderItems> {

    public void addTblBidderItems(TblBidderItems tblBidderItems);

    public void deleteTblBidderItems(TblBidderItems tblBidderItems);

    public void updateTblBidderItems(TblBidderItems tblBidderItems);

    public List<TblBidderItems> getAllTblBidderItems();

    public List<TblBidderItems> findTblBidderItems(Object... values) throws Exception;

    public List<TblBidderItems> findByCountTblBidderItems(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidderItemsCount();

    public void saveUpdateAllTblBidderItems(List<TblBidderItems> tblBidderItemss);
}