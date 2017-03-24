/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblQuestionAnswer;

/**
 *
 */
public interface TblQuestionAnswerDao extends GenericDao<TblQuestionAnswer> {

    public void addTblQuestionAnswer(TblQuestionAnswer TblQuestionAnswer);

    public void deleteTblQuestionAnswer(TblQuestionAnswer TblQuestionAnswer);

    public void updateTblQuestionAnswer(TblQuestionAnswer TblQuestionAnswer);

    public List<TblQuestionAnswer> getAllTblQuestionAnswer();

    public List<TblQuestionAnswer> findTblQuestionAnswer(Object... values) throws Exception;

    public List<TblQuestionAnswer> findByCountTblQuestionAnswer(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblQuestionAnswerCount();

    public void saveUpdateAllTblQuestionAnswer(List<TblQuestionAnswer> TblQuestionAnswer);
}
