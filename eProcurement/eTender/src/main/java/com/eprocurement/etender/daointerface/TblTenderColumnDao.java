package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderColumn;

public interface TblTenderColumnDao extends GenericDao<TblTenderColumn> {

    public void addTblTenderColumn(TblTenderColumn tblTenderColumn);

    public void deleteTblTenderColumn(TblTenderColumn tblTenderColumn);

    public void updateTblTenderColumn(TblTenderColumn tblTenderColumn);

    public List<TblTenderColumn> getAllTblTenderColumn();

    public List<TblTenderColumn> findTblTenderColumn(Object... values) throws Exception;

    public List<TblTenderColumn> findByCountTblTenderColumn(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderColumnCount();

    public void saveUpdateAllTblTenderColumn(List<TblTenderColumn> tblTenderColumns);
}