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
import com.eprocurement.common.daointerface.TblEventTermAndConditionsDao;
import com.eprocurement.etender.model.TblEventTermAndConditions;

/**
 *
 */
@Repository
public class TblEventTermAndConditionsDaoImpl extends HibernateAbstractClass<TblEventTermAndConditions> implements TblEventTermAndConditionsDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblEventTermAndConditions(TblEventTermAndConditions TblEventTermAndConditions){
        super.addEntity(TblEventTermAndConditions);
    }

    @Override
    public void deleteTblEventTermAndConditions(TblEventTermAndConditions TblEventTermAndConditions) {
        super.deleteEntity(TblEventTermAndConditions);
    }

    @Override
    public void updateTblEventTermAndConditions(TblEventTermAndConditions TblEventTermAndConditions) {
        super.updateEntity(TblEventTermAndConditions);
    }

    @Override
    public List<TblEventTermAndConditions> getAllTblEventTermAndConditions() {
        return super.getAllEntity();
    }

    @Override
    public List<TblEventTermAndConditions> findTblEventTermAndConditions(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblEventTermAndConditionsCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblEventTermAndConditions> findByCountTblEventTermAndConditions(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblEventTermAndConditions(List<TblEventTermAndConditions> TblEventTermAndConditions){
        super.updateAll(TblEventTermAndConditions);
    }
}
