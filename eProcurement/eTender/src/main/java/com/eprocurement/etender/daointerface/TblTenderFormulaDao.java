package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderFormula;

public interface TblTenderFormulaDao extends GenericDao<TblTenderFormula> {

    public void addTblTenderFormula(TblTenderFormula tblTenderFormula);

    public void deleteTblTenderFormula(TblTenderFormula tblTenderFormula);

    public void updateTblTenderFormula(TblTenderFormula tblTenderFormula);

    public List<TblTenderFormula> getAllTblTenderFormula();

    public List<TblTenderFormula> findTblTenderFormula(Object... values) throws Exception;

    public List<TblTenderFormula> findByCountTblTenderFormula(int firstResult, int maxResult, Object... values) throws Exception;

    public long getTblTenderFormulaCount();

    public void saveUpdateAllTblTenderFormula(List<TblTenderFormula> tblTenderFormulas);
}