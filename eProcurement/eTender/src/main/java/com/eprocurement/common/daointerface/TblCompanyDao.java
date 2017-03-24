/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblCompany;

/**
 *
 */
public interface TblCompanyDao extends GenericDao<TblCompany> {

    public void addTblCompany(TblCompany TblCompany);

    public void deleteTblCompany(TblCompany TblCompany);

    public void updateTblCompany(TblCompany TblCompany);

    public List<TblCompany> getAllTblCompany();

    public List<TblCompany> findTblCompany(Object... values) throws Exception;

    public List<TblCompany> findByCountTblCompany(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblCompanyCount();

    public void saveUpdateAllTblCompany(List<TblCompany> TblCompany);
}
