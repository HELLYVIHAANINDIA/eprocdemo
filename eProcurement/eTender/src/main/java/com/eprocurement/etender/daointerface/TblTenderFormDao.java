package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderForm;

public interface TblTenderFormDao extends GenericDao<TblTenderForm> {

    public void addTblTenderForm(TblTenderForm tblTenderForm);

    public void deleteTblTenderForm(TblTenderForm tblTenderForm);

    public void updateTblTenderForm(TblTenderForm tblTenderForm);

    public List<TblTenderForm> getAllTblTenderForm();

    public List<TblTenderForm> findTblTenderForm(Object... values) throws Exception;

    public List<TblTenderForm> findByCountTblTenderForm(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderFormCount();

    public void saveUpdateAllTblTenderForm(List<TblTenderForm> tblTenderForms);
}