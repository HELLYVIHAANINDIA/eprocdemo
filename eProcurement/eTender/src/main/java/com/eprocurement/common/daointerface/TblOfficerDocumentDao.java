/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblOfficerdocument;
import com.eprocurement.etender.model.TblOfficerdocument;

/**
 *
 */
public interface TblOfficerDocumentDao extends GenericDao<TblOfficerdocument> {

    public void addTblOfficerdocument(TblOfficerdocument TblOfficerdocument);

    public void deleteTblOfficerdocument(TblOfficerdocument TblOfficerdocument);

    public void updateTblOfficerdocument(TblOfficerdocument TblOfficerdocument);

    public List<TblOfficerdocument> getAllTblOfficerdocument();

    public List<TblOfficerdocument> findTblOfficerdocument(Object... values) throws Exception;

    public List<TblOfficerdocument> findByCountTblOfficerdocument(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblOfficerdocumentCount();

    public void saveUpdateAllTblOfficerdocument(List<TblOfficerdocument> TblOfficerdocument);
}
