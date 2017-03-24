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
import com.eprocurement.common.daointerface.TblOfficerDao;
import com.eprocurement.etender.model.TblOfficer;

/**
 *
 */
@Repository
public class TblOfficerDaoImpl extends HibernateAbstractClass<TblOfficer> implements TblOfficerDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblOfficer(TblOfficer tblOfficer){
        super.addEntity(tblOfficer);
    }

    @Override
    public void deleteTblOfficer(TblOfficer tblOfficer) {
        super.deleteEntity(tblOfficer);
    }

    @Override
    public void updateTblOfficer(TblOfficer tblOfficer) {
        super.updateEntity(tblOfficer);
    }

    @Override
    public List<TblOfficer> getAllTblOfficer() {
        return super.getAllEntity();
    }

    @Override
    public List<TblOfficer> findTblOfficer(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblOfficerCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblOfficer> findByCountTblOfficer(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblOfficer(List<TblOfficer> tblOfficer){
        super.updateAll(tblOfficer);
    }
}
