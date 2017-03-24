/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblRoleLinkMapping;

/**
 *
 */
public interface TblRoleLinkMappingDao extends GenericDao<TblRoleLinkMapping> {

    public void addTblRoleLinkMapping(TblRoleLinkMapping TblRoleLinkMapping);

    public void deleteTblRoleLinkMapping(TblRoleLinkMapping TblRoleLinkMapping);

    public void updateTblRoleLinkMapping(TblRoleLinkMapping TblRoleLinkMapping);

    public List<TblRoleLinkMapping> getAllTblRoleLinkMapping();

    public List<TblRoleLinkMapping> findTblRoleLinkMapping(Object... values) throws Exception;

    public List<TblRoleLinkMapping> findByCountTblRoleLinkMapping(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblRoleLinkMappingCount();

    public void saveUpdateAllTblRoleLinkMapping(List<TblRoleLinkMapping> TblRoleLinkMapping);
}
