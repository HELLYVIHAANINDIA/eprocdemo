package com.eprocurement.etender.daointerface;


/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblItemSelection;

public interface TblItemSelectionDao extends GenericDao<TblItemSelection> {

    public void addTblItemSelection(TblItemSelection tblItemSelection);

    public void deleteTblItemSelection(TblItemSelection tblItemSelection);

    public void updateTblItemSelection(TblItemSelection tblItemSelection);

    public List<TblItemSelection> getAllTblItemSelection();

    public List<TblItemSelection> findTblItemSelection(Object... values) throws Exception;

    public List<TblItemSelection> findByCountTblItemSelection(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblItemSelectionCount();

    public void saveUpdateAllTblItemSelection(List<TblItemSelection> tblItemSelections);
}