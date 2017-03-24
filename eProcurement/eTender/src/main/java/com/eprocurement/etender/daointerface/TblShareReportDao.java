package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblShareReport;

public interface TblShareReportDao extends GenericDao<TblShareReport> {

    public void addTblShareReport(TblShareReport tblShareReport);

    public void deleteTblShareReport(TblShareReport tblShareReport);

    public void updateTblShareReport(TblShareReport tblShareReport);

    public List<TblShareReport> getAllTblShareReport();

    public List<TblShareReport> findTblShareReport(Object... values) throws Exception;

    public List<TblShareReport> findByCountTblShareReport(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblShareReportCount();

    public void saveUpdateAllTblShareReport(List<TblShareReport> tblShareReports);
}