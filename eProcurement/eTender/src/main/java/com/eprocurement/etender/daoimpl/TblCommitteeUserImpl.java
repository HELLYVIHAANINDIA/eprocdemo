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
import com.eprocurement.etender.daointerface.TblCommitteeUserDao;
import com.eprocurement.etender.model.TblCommitteeUser;

/**
 *
 */
@Repository
public class TblCommitteeUserImpl extends HibernateAbstractClass<TblCommitteeUser> implements TblCommitteeUserDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblCommitteeUser(TblCommitteeUser tblCommitteeUser){
        super.addEntity(tblCommitteeUser);
    }

    @Override
    public void deleteTblCommitteeUser(TblCommitteeUser tblCommitteeUser) {
        super.deleteEntity(tblCommitteeUser);
    }

    @Override
    public void updateTblCommitteeUser(TblCommitteeUser tblCommitteeUser) {
        super.updateEntity(tblCommitteeUser);
    }

    @Override
    public List<TblCommitteeUser> getAllTblCommitteeUser() {
        return super.getAllEntity();
    }

    @Override
    public List<TblCommitteeUser> findTblCommitteeUser(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblCommitteeUserCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblCommitteeUser> findByCountTblCommitteeUser(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblCommitteeUser(List<TblCommitteeUser> tblCommitteeUsers){
        super.updateAll(tblCommitteeUsers);
    }
}

