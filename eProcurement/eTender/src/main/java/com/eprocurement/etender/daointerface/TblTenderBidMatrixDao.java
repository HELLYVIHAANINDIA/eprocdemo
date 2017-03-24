/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderBidMatrix;

/**
 *
 */
public interface TblTenderBidMatrixDao extends GenericDao<TblTenderBidMatrix> {

    public void addTblTenderBidMatrix(TblTenderBidMatrix tblTenderBidMatrix);

    public void deleteTblTenderBidMatrix(TblTenderBidMatrix tblTenderBidMatrix);

    public void updateTblTenderBidMatrix(TblTenderBidMatrix tblTenderBidMatrix);

    public List<TblTenderBidMatrix> getAllTblTenderBidMatrix();

    public List<TblTenderBidMatrix> findTblTenderBidMatrix(Object... values) throws Exception;

    public List<TblTenderBidMatrix> findByCountTblTenderBidMatrix(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderBidMatrixCount();

    public void saveUpdateAllTblTenderBidMatrix(List<TblTenderBidMatrix> tblTenderBidMatrixs);
}
