package com.eprocurement.etender.daointerface;



/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidDetail;

public interface TblBidDetailDao extends GenericDao<TblBidDetail> {

    public void addTblBidDetail(TblBidDetail tblBidDetail);

    public void deleteTblBidDetail(TblBidDetail tblBidDetail);

    public void updateTblBidDetail(TblBidDetail tblBidDetail);

    public List<TblBidDetail> getAllTblBidDetail();

    public List<TblBidDetail> findTblBidDetail(Object... values) throws Exception;

    public List<TblBidDetail> findByCountTblBidDetail(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidDetailCount();

    public void saveUpdateAllTblBidDetail(List<TblBidDetail> tblBidDetails);
    
    public void updateAllTblBidDetail(List<TblBidDetail> tblBidDetails);
}