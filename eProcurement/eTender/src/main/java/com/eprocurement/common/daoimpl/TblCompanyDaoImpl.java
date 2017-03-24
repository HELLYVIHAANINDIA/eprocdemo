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
import com.eprocurement.common.daointerface.TblCompanyDao;
import com.eprocurement.etender.model.TblCompany;

/**
 *
 */
@Repository
public class TblCompanyDaoImpl extends HibernateAbstractClass<TblCompany> implements TblCompanyDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblCompany(TblCompany TblCompany){
        super.addEntity(TblCompany);
    }

    @Override
    public void deleteTblCompany(TblCompany TblCompany) {
        super.deleteEntity(TblCompany);
    }

    @Override
    public void updateTblCompany(TblCompany TblCompany) {
        super.updateEntity(TblCompany);
    }

    @Override
    public List<TblCompany> getAllTblCompany() {
        return super.getAllEntity();
    }

    @Override
    public List<TblCompany> findTblCompany(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblCompanyCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblCompany> findByCountTblCompany(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblCompany(List<TblCompany> TblCompany){
        super.updateAll(TblCompany);
    }
}
