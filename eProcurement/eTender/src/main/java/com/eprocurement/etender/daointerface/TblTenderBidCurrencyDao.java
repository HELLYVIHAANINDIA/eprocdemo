package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderBidCurrency;

public interface TblTenderBidCurrencyDao extends GenericDao<TblTenderBidCurrency> {

    public void addTblTenderBidCurrency(TblTenderBidCurrency tblTenderBidCurrency);

    public void deleteTblTenderBidCurrency(TblTenderBidCurrency tblTenderBidCurrency);

    public void updateTblTenderBidCurrency(TblTenderBidCurrency tblTenderBidCurrency);

    public List<TblTenderBidCurrency> getAllTblTenderBidCurrency();

    public List<TblTenderBidCurrency> findTblTenderBidCurrency(Object... values) throws Exception;

    public List<TblTenderBidCurrency> findByCountTblTenderBidCurrency(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderBidCurrencyCount();

    public void saveUpdateAllTblTenderBidCurrency(List<TblTenderBidCurrency> tblTenderBidCurrencys);
}