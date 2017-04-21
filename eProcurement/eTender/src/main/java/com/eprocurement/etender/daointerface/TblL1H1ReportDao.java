/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblL1H1Report;

/**
 *
 */
public interface TblL1H1ReportDao extends GenericDao<TblL1H1Report> {

    public void addTblL1H1Report(TblL1H1Report TblL1H1Report);

    public void deleteTblL1H1Report(TblL1H1Report TblL1H1Report);

    public void updateTblL1H1Report(TblL1H1Report TblL1H1Report);

    public List<TblL1H1Report> getAllTblL1H1Report();

    public List<TblL1H1Report> findTblL1H1Report(Object... values) throws Exception;

    public List<TblL1H1Report> findByCountTblL1H1Report(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblL1H1ReportCount();

    public void saveUpdateAllTblL1H1Report(List<TblL1H1Report> TblL1H1Report);
}
