package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidderApprovalDetail;

public interface TblBidderApprovalDetailDao extends GenericDao<TblBidderApprovalDetail> {

    public void addTblBidderApprovalDetail(TblBidderApprovalDetail tblBidderApprovalDetail);

    public void deleteTblBidderApprovalDetail(TblBidderApprovalDetail tblBidderApprovalDetail);

    public void updateTblBidderApprovalDetail(TblBidderApprovalDetail tblBidderApprovalDetail);

    public List<TblBidderApprovalDetail> getAllTblBidderApprovalDetail();

    public List<TblBidderApprovalDetail> findTblBidderApprovalDetail(Object... values) throws Exception;

    public List<TblBidderApprovalDetail> findByCountTblBidderApprovalDetail(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidderApprovalDetailCount();

    public void saveUpdateAllTblBidderApprovalDetail(List<TblBidderApprovalDetail> tblBidderApprovalDetails);
}