package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderBidDetail;

public interface TblTenderBidDetailDao extends GenericDao<TblTenderBidDetail> {

    public void addTblTenderBidDetail(TblTenderBidDetail tblTenderBidDetail);

    public void deleteTblTenderBidDetail(TblTenderBidDetail tblTenderBidDetail);

    public void updateTblTenderBidDetail(TblTenderBidDetail tblTenderBidDetail);

    public List<TblTenderBidDetail> getAllTblTenderBidDetail();

    public List<TblTenderBidDetail> findTblTenderBidDetail(Object... values) throws Exception;

    public List<TblTenderBidDetail> findByCountTblTenderBidDetail(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderBidDetailCount();

    public void saveUpdateAllTblTenderBidDetail(List<TblTenderBidDetail> tblTenderBidDetails);
    
    public void updateAllTblTenderBidDetail(List<TblTenderBidDetail> tblTenderBidDetails);
}