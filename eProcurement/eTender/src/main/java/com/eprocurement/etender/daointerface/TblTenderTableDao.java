package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderTable;

public interface TblTenderTableDao extends GenericDao<TblTenderTable> {

    public void addTblTenderTable(TblTenderTable tblTenderTable);

    public void deleteTblTenderTable(TblTenderTable tblTenderTable);

    public void updateTblTenderTable(TblTenderTable tblTenderTable);

    public List<TblTenderTable> getAllTblTenderTable();

    public List<TblTenderTable> findTblTenderTable(Object... values) throws Exception;

    public List<TblTenderTable> findByCountTblTenderTable(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderTableCount();

    public void saveUpdateAllTblTenderTable(List<TblTenderTable> tblTenderTables);
}