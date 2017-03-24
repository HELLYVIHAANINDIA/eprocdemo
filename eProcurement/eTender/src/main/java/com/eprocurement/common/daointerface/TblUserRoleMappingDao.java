/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblUserRoleMapping;

/**
 *
 */
public interface TblUserRoleMappingDao extends GenericDao<TblUserRoleMapping> {

    public void addTblUserRoleMapping(TblUserRoleMapping TblUserRoleMapping);

    public void deleteTblUserRoleMapping(TblUserRoleMapping TblUserRoleMapping);

    public void updateTblUserRoleMapping(TblUserRoleMapping TblUserRoleMapping);

    public List<TblUserRoleMapping> getAllTblUserRoleMapping();

    public List<TblUserRoleMapping> findTblUserRoleMapping(Object... values) throws Exception;

    public List<TblUserRoleMapping> findByCountTblUserRoleMapping(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblUserRoleMappingCount();

    public void saveUpdateAllTblUserRoleMapping(List<TblUserRoleMapping> TblUserRoleMapping);
}
