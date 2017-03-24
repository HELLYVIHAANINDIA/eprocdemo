/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblLink;

/**
 *
 */
public interface TblLinkDao extends GenericDao<TblLink> {

    public void addTblLink(TblLink TblLink);

    public void deleteTblLink(TblLink TblLink);

    public void updateTblLink(TblLink TblLink);

    public List<TblLink> getAllTblLink();

    public List<TblLink> findTblLink(Object... values) throws Exception;

    public List<TblLink> findByCountTblLink(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblLinkCount();

    public void saveUpdateAllTblLink(List<TblLink> TblLink);
}
