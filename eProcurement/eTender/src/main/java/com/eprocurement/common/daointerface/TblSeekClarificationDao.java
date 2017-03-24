/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblSeekClarification;

/**
 *
 */
public interface TblSeekClarificationDao extends GenericDao<TblSeekClarification> {

    public void addTblSeekClarification(TblSeekClarification TblSeekClarification);

    public void deleteTblSeekClarification(TblSeekClarification TblSeekClarification);

    public void updateTblSeekClarification(TblSeekClarification TblSeekClarification);

    public List<TblSeekClarification> getAllTblSeekClarification();

    public List<TblSeekClarification> findTblSeekClarification(Object... values) throws Exception;

    public List<TblSeekClarification> findByCountTblSeekClarification(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblSeekClarificationCount();

    public void saveUpdateAllTblSeekClarification(List<TblSeekClarification> TblSeekClarification);
}
