/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderCurrency;
import java.util.List;

public interface TblTenderCurrencyDao extends GenericDao<TblTenderCurrency> {

    public void addTblTenderCurrency(TblTenderCurrency tblTenderCurrency);

    public void deleteTblTenderCurrency(TblTenderCurrency tblTenderCurrency);

    public void updateTblTenderCurrency(TblTenderCurrency tblTenderCurrency);

    public List<TblTenderCurrency> getAllTblTenderCurrency();

    public List<TblTenderCurrency> findTblTenderCurrency(Object... values) throws Exception;

    public List<TblTenderCurrency> findByCountTblTenderCurrency(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderCurrencyCount();

    public void saveUpdateAllTblTenderCurrency(List<TblTenderCurrency> tblTenderCurrencys);
    
    public void updateAllTblTenderCurrency(List<TblTenderCurrency> tblTenderCurrencys);
}