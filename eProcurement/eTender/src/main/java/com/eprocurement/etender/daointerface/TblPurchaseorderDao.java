package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblPurchaseorder;

public interface TblPurchaseorderDao extends GenericDao<TblPurchaseorder> {

    public void addTblPurchaseorder(TblPurchaseorder TblPurchaseorder);

    public void deleteTblPurchaseorder(TblPurchaseorder TblPurchaseorder);

    public void updateTblPurchaseorder(TblPurchaseorder TblPurchaseorder);

    public List<TblPurchaseorder> getAllTblPurchaseorder();

    public List<TblPurchaseorder> findTblPurchaseorder(Object... values) throws Exception;

    public List<TblPurchaseorder> findByCountTblPurchaseorder(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblPurchaseorderCount();

    public void saveUpdateAllTblPurchaseorder(List<TblPurchaseorder> TblPurchaseorders);
}