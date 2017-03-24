/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daoimpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.etender.daointerface.TblCommitteeDao;
import com.eprocurement.etender.model.TblCommittee;

/**
 *
 */
@Repository
public class TblCommitteeImpl extends HibernateAbstractClass<TblCommittee> implements TblCommitteeDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblCommittee(TblCommittee tblCommittee){
        super.addEntity(tblCommittee);
    }

    @Override
    public void deleteTblCommittee(TblCommittee tblCommittee) {
        super.deleteEntity(tblCommittee);
    }

    @Override
    public void updateTblCommittee(TblCommittee tblCommittee) {
        super.updateEntity(tblCommittee);
    }

    @Override
    public List<TblCommittee> getAllTblCommittee() {
        return super.getAllEntity();
    }

    @Override
    public List<TblCommittee> findTblCommittee(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblCommitteeCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblCommittee> findByCountTblCommittee(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblCommittee(List<TblCommittee> tblCommittees){
        super.updateAll(tblCommittees);
    }
}
