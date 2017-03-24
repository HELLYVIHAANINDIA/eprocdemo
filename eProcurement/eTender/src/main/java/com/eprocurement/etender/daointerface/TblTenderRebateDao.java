package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderRebate;

public interface TblTenderRebateDao extends GenericDao<TblTenderRebate> {

    public void addTblTenderRebate(TblTenderRebate tblTenderRebate);

    public void deleteTblTenderRebate(TblTenderRebate tblTenderRebate);

    public void updateTblTenderRebate(TblTenderRebate tblTenderRebate);

    public List<TblTenderRebate> getAllTblTenderRebate();

    public List<TblTenderRebate> findTblTenderRebate(Object... values) throws Exception;

    public List<TblTenderRebate> findByCountTblTenderRebate(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderRebateCount();

    public void saveUpdateAllTblTenderRebate(List<TblTenderRebate> tblTenderRebates);
}