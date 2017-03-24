package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblFinalsubmission;

public interface TblFinalSubmissionDao extends GenericDao<TblFinalsubmission> {

    public void addTblFinalSubmission(TblFinalsubmission tblFinalSubmission);

    public void deleteTblFinalSubmission(TblFinalsubmission tblFinalSubmission);

    public void updateTblFinalSubmission(TblFinalsubmission tblFinalSubmission);

    public List<TblFinalsubmission> getAllTblFinalSubmission();

    public List<TblFinalsubmission> findTblFinalSubmission(Object... values) throws Exception;

    public List<TblFinalsubmission> findByCountTblFinalSubmission(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblFinalSubmissionCount();

    public void saveUpdateAllTblFinalSubmission(List<TblFinalsubmission> tblFinalSubmissions);
}