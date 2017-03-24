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
import com.eprocurement.common.daointerface.TblOfficerDocumentDao;
import com.eprocurement.etender.model.TblOfficerdocument;

/**
 *
 */
@Repository
public class TblOfficerDocumentDaoImpl extends HibernateAbstractClass<TblOfficerdocument> implements TblOfficerDocumentDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblOfficerdocument(TblOfficerdocument TblOfficerdocument){
        super.addEntity(TblOfficerdocument);
    }

    @Override
    public void deleteTblOfficerdocument(TblOfficerdocument TblOfficerdocument) {
        super.deleteEntity(TblOfficerdocument);
    }

    @Override
    public void updateTblOfficerdocument(TblOfficerdocument TblOfficerdocument) {
        super.updateEntity(TblOfficerdocument);
    }

    @Override
    public List<TblOfficerdocument> getAllTblOfficerdocument() {
        return super.getAllEntity();
    }

    @Override
    public List<TblOfficerdocument> findTblOfficerdocument(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblOfficerdocumentCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblOfficerdocument> findByCountTblOfficerdocument(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblOfficerdocument(List<TblOfficerdocument> TblOfficerdocument){
        super.updateAll(TblOfficerdocument);
    }
}
