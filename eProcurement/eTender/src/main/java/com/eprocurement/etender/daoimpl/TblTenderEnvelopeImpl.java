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
import com.eprocurement.etender.daointerface.TblTenderEnvelopeDao;
import com.eprocurement.etender.model.TblTenderEnvelope;

/**
 *
 */
@Repository
public class TblTenderEnvelopeImpl extends HibernateAbstractClass<TblTenderEnvelope> implements TblTenderEnvelopeDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope) {
        super.addEntity(tblTenderEnvelope);
    }

    @Override
    public void deleteTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope) {
        super.deleteEntity(tblTenderEnvelope);
    }

    @Override
    public void updateTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope) {
        super.updateEntity(tblTenderEnvelope);
    }

    @Override
    public List<TblTenderEnvelope> getAllTblTenderEnvelope() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderEnvelope> findTblTenderEnvelope(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderEnvelopeCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderEnvelope> findByCountTblTenderEnvelope(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderEnvelope(List<TblTenderEnvelope> tblTenderEnvelopes) {
        super.updateAll(tblTenderEnvelopes);
    }
}