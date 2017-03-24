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
import com.eprocurement.etender.daointerface.TblCommitteeEnvelopeDao;
import com.eprocurement.etender.model.TblCommitteeEnvelope;

/**
 *
 */
@Repository
public class TblCommitteeEnvelopeImpl extends HibernateAbstractClass<TblCommitteeEnvelope> implements TblCommitteeEnvelopeDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblCommitteeEnvelope(TblCommitteeEnvelope tblCommitteeEnvelope){
        super.addEntity(tblCommitteeEnvelope);
    }

    @Override
    public void deleteTblCommitteeEnvelope(TblCommitteeEnvelope tblCommitteeEnvelope) {
        super.deleteEntity(tblCommitteeEnvelope);
    }

    @Override
    public void updateTblCommitteeEnvelope(TblCommitteeEnvelope tblCommitteeEnvelope) {
        super.updateEntity(tblCommitteeEnvelope);
    }

    @Override
    public List<TblCommitteeEnvelope> getAllTblCommitteeEnvelope() {
        return super.getAllEntity();
    }

    @Override
    public List<TblCommitteeEnvelope> findTblCommitteeEnvelope(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblCommitteeEnvelopeCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblCommitteeEnvelope> findByCountTblCommitteeEnvelope(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblCommitteeEnvelope(List<TblCommitteeEnvelope> tblCommitteeEnvelopes){
        super.updateAll(tblCommitteeEnvelopes);
    }
}