package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderCellGrandTotal;

public interface TblTenderCellGrandTotalDao extends GenericDao<TblTenderCellGrandTotal> {

    public void addTblTenderCellGrandTotal(TblTenderCellGrandTotal tblTenderCellGrandTotal);

    public void deleteTblTenderCellGrandTotal(TblTenderCellGrandTotal tblTenderCellGrandTotal);

    public void updateTblTenderCellGrandTotal(TblTenderCellGrandTotal tblTenderCellGrandTotal);

    public List<TblTenderCellGrandTotal> getAllTblTenderCellGrandTotal();

    public List<TblTenderCellGrandTotal> findTblTenderCellGrandTotal(Object... values) throws Exception;

    public List<TblTenderCellGrandTotal> findByCountTblTenderCellGrandTotal(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderCellGrandTotalCount();

    public void saveUpdateAllTblTenderCellGrandTotal(List<TblTenderCellGrandTotal> tblTenderCellGrandTotals);
    
    public void updateAllTblTenderCellGrandTotal(List<TblTenderCellGrandTotal> tblTenderCellGrandTotals);
}
