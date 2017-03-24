/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblDepartment;

/**
 *
 */
public interface TblDepartmentDao extends GenericDao<TblDepartment> {

    public void addTblDepartment(TblDepartment TblDepartment);

    public void deleteTblDepartment(TblDepartment TblDepartment);

    public void updateTblDepartment(TblDepartment TblDepartment);

    public List<TblDepartment> getAllTblDepartment();

    public List<TblDepartment> findTblDepartment(Object... values) throws Exception;

    public List<TblDepartment> findByCountTblDepartment(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblDepartmentCount();

    public void saveUpdateAllTblDepartment(List<TblDepartment> TblDepartment);
}
