/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblOfficer;

/**
 *
 */
public interface TblOfficerDao extends GenericDao<TblOfficer> {

    public void addTblOfficer(TblOfficer tblOfficer);

    public void deleteTblOfficer(TblOfficer tblOfficer);

    public void updateTblOfficer(TblOfficer tblOfficer);

    public List<TblOfficer> getAllTblOfficer();

    public List<TblOfficer> findTblOfficer(Object... values) throws Exception;

    public List<TblOfficer> findByCountTblOfficer(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblOfficerCount();

    public void saveUpdateAllTblOfficer(List<TblOfficer> tblOfficer);
}
