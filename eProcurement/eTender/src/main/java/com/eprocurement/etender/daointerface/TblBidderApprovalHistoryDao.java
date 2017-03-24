package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidderApprovalHistory;

public interface TblBidderApprovalHistoryDao extends GenericDao<TblBidderApprovalHistory> {

    public void addTblBidderApprovalHistory(TblBidderApprovalHistory tblBidderApprovalHistory);

    public void deleteTblBidderApprovalHistory(TblBidderApprovalHistory tblBidderApprovalHistory);

    public void updateTblBidderApprovalHistory(TblBidderApprovalHistory tblBidderApprovalHistory);

    public List<TblBidderApprovalHistory> getAllTblBidderApprovalHistory();

    public List<TblBidderApprovalHistory> findTblBidderApprovalHistory(Object... values) throws Exception;

    public List<TblBidderApprovalHistory> findByCountTblBidderApprovalHistory(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidderApprovalHistoryCount();

    public void saveUpdateAllTblBidderApprovalHistory(List<TblBidderApprovalHistory> tblBidderApprovalHistorys);
}