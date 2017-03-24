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
import com.eprocurement.common.daointerface.TblSeekClarificationDao;
import com.eprocurement.etender.model.TblSeekClarification;

/**
 *
 */
@Repository
public class TblSeekClarificationDaoImpl extends HibernateAbstractClass<TblSeekClarification> implements TblSeekClarificationDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblSeekClarification(TblSeekClarification TblSeekClarification){
        super.addEntity(TblSeekClarification);
    }

    @Override
    public void deleteTblSeekClarification(TblSeekClarification TblSeekClarification) {
        super.deleteEntity(TblSeekClarification);
    }

    @Override
    public void updateTblSeekClarification(TblSeekClarification TblSeekClarification) {
        super.updateEntity(TblSeekClarification);
    }

    @Override
    public List<TblSeekClarification> getAllTblSeekClarification() {
        return super.getAllEntity();
    }

    @Override
    public List<TblSeekClarification> findTblSeekClarification(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblSeekClarificationCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblSeekClarification> findByCountTblSeekClarification(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblSeekClarification(List<TblSeekClarification> TblSeekClarification){
        super.updateAll(TblSeekClarification);
    }
}
