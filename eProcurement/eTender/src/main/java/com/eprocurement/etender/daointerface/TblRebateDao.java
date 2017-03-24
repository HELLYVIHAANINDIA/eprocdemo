package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblRebate;

public interface TblRebateDao extends GenericDao<TblRebate> {

    public void addTblRebate(TblRebate tblRebate);

    public void deleteTblRebate(TblRebate tblRebate);

    public void updateTblRebate(TblRebate tblRebate);

    public List<TblRebate> getAllTblRebate();

    public List<TblRebate> findTblRebate(Object... values) throws Exception;

    public List<TblRebate> findByCountTblRebate(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblRebateCount();

    public void saveUpdateAllTblRebate(List<TblRebate> tblRebates);
}