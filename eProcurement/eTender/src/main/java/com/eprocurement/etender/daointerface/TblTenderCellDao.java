/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderCell;

/**
 *
 */
public interface TblTenderCellDao extends GenericDao<TblTenderCell> {

    public void addTblTenderCell(TblTenderCell tblTenderCell);

    public void deleteTblTenderCell(TblTenderCell tblTenderCell);

    public void updateTblTenderCell(TblTenderCell tblTenderCell);

    public List<TblTenderCell> getAllTblTenderCell();

    public List<TblTenderCell> findTblTenderCell(Object... values) throws Exception;

    public List<TblTenderCell> findByCountTblTenderCell(int firstResult, int maxResult, Object... values) throws Exception;

    public long getTblTenderCellCount();

    public void saveUpdateAllTblTenderCell(List<TblTenderCell> tblTenderCells);
}
