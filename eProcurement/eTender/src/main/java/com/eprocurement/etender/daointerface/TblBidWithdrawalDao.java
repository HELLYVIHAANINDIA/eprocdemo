package com.eprocurement.etender.daointerface;


/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidWithdrawal;

public interface TblBidWithdrawalDao extends GenericDao<TblBidWithdrawal> {

    public void addTblBidWithdrawal(TblBidWithdrawal tblBidWithdrawal);

    public void deleteTblBidWithdrawal(TblBidWithdrawal tblBidWithdrawal);

    public void updateTblBidWithdrawal(TblBidWithdrawal tblBidWithdrawal);

    public List<TblBidWithdrawal> getAllTblBidWithdrawal();

    public List<TblBidWithdrawal> findTblBidWithdrawal(Object... values) throws Exception;

    public List<TblBidWithdrawal> findByCountTblBidWithdrawal(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidWithdrawalCount();

    public void saveUpdateAllTblBidWithdrawal(List<TblBidWithdrawal> tblBidWithdrawals);
}
