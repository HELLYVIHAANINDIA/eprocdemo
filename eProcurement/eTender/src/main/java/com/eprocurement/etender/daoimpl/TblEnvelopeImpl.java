package com.eprocurement.etender.daoimpl;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.etender.daointerface.TblEnvelopeDao;
import com.eprocurement.etender.model.TblEnvelope;

/**
 *
 */
@Repository
public class TblEnvelopeImpl extends HibernateAbstractClass<TblEnvelope> implements TblEnvelopeDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblEnvelope(TblEnvelope tblEnvelope){
        super.addEntity(tblEnvelope);
    }

    @Override
    public void deleteTblEnvelope(TblEnvelope tblEnvelope) {
        super.deleteEntity(tblEnvelope);
    }

    @Override
    public void updateTblEnvelope(TblEnvelope tblEnvelope) {
        super.updateEntity(tblEnvelope);
    }

    @Override
    public List<TblEnvelope> getAllTblEnvelope() {
        return super.getAllEntity();
    }

    @Override
    public List<TblEnvelope> findTblEnvelope(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblEnvelopeCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblEnvelope> findByCountTblEnvelope(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblEnvelope(List<TblEnvelope> tblEnvelopes){
        super.updateAll(tblEnvelopes);
    }
}
