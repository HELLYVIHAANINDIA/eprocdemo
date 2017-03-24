/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblRoles;

/**
 *
 */
public interface TblRolesDao extends GenericDao<TblRoles> {

    public void addTblRoles(TblRoles TblRoles);

    public void deleteTblRoles(TblRoles TblRoles);

    public void updateTblRoles(TblRoles TblRoles);

    public List<TblRoles> getAllTblRoles();

    public List<TblRoles> findTblRoles(Object... values) throws Exception;

    public List<TblRoles> findByCountTblRoles(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblRolesCount();

    public void saveUpdateAllTblRoles(List<TblRoles> TblRoles);
}
