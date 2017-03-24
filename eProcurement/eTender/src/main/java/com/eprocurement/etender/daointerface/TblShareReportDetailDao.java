package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblShareReportDetail;

public interface TblShareReportDetailDao extends GenericDao<TblShareReportDetail> {

    public void addTblShareReportDetail(TblShareReportDetail tblShareReportDetail);

    public void deleteTblShareReportDetail(TblShareReportDetail tblShareReportDetail);

    public void updateTblShareReportDetail(TblShareReportDetail tblShareReportDetail);

    public List<TblShareReportDetail> getAllTblShareReportDetail();

    public List<TblShareReportDetail> findTblShareReportDetail(Object... values) throws Exception;

    public List<TblShareReportDetail> findByCountTblShareReportDetail(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblShareReportDetailCount();

    public void saveUpdateAllTblShareReportDetail(List<TblShareReportDetail> tblShareReportDetails);
}