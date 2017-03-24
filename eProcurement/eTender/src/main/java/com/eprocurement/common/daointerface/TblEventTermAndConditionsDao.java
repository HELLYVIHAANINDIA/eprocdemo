/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblEventTermAndConditions;

/**
 *
 */
public interface TblEventTermAndConditionsDao extends GenericDao<TblEventTermAndConditions> {

    public void addTblEventTermAndConditions(TblEventTermAndConditions TblEventTermAndConditions);

    public void deleteTblEventTermAndConditions(TblEventTermAndConditions TblEventTermAndConditions);

    public void updateTblEventTermAndConditions(TblEventTermAndConditions TblEventTermAndConditions);

    public List<TblEventTermAndConditions> getAllTblEventTermAndConditions();

    public List<TblEventTermAndConditions> findTblEventTermAndConditions(Object... values) throws Exception;

    public List<TblEventTermAndConditions> findByCountTblEventTermAndConditions(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblEventTermAndConditionsCount();

    public void saveUpdateAllTblEventTermAndConditions(List<TblEventTermAndConditions> TblEventTermAndConditions);
}
