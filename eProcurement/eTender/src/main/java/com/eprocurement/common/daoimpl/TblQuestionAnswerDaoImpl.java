/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daoimpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.common.daointerface.TblQuestionAnswerDao;
import com.eprocurement.etender.model.TblQuestionAnswer;
import com.eprocurement.etender.model.TblQuestionAnswer;

/**
 *
 */
@Repository
public class TblQuestionAnswerDaoImpl extends HibernateAbstractClass<TblQuestionAnswer> implements TblQuestionAnswerDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblQuestionAnswer(TblQuestionAnswer TblQuestionAnswer){
        super.addEntity(TblQuestionAnswer);
    }

    @Override
    public void deleteTblQuestionAnswer(TblQuestionAnswer TblQuestionAnswer) {
        super.deleteEntity(TblQuestionAnswer);
    }

    @Override
    public void updateTblQuestionAnswer(TblQuestionAnswer TblQuestionAnswer) {
        super.updateEntity(TblQuestionAnswer);
    }

    @Override
    public List<TblQuestionAnswer> getAllTblQuestionAnswer() {
        return super.getAllEntity();
    }

    @Override
    public List<TblQuestionAnswer> findTblQuestionAnswer(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblQuestionAnswerCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblQuestionAnswer> findByCountTblQuestionAnswer(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblQuestionAnswer(List<TblQuestionAnswer> TblQuestionAnswer){
        super.updateAll(TblQuestionAnswer);
    }
}
