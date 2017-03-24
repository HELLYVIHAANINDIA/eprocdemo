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
import com.eprocurement.common.daointerface.TblRolesDao;
import com.eprocurement.etender.model.TblRoles;

/**
 *
 */
@Repository
public class TblRolesImpl extends HibernateAbstractClass<TblRoles> implements TblRolesDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblRoles(TblRoles TblRoles){
        super.addEntity(TblRoles);
    }

    @Override
    public void deleteTblRoles(TblRoles TblRoles) {
        super.deleteEntity(TblRoles);
    }

    @Override
    public void updateTblRoles(TblRoles TblRoles) {
        super.updateEntity(TblRoles);
    }

    @Override
    public List<TblRoles> getAllTblRoles() {
        return super.getAllEntity();
    }

    @Override
    public List<TblRoles> findTblRoles(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblRolesCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblRoles> findByCountTblRoles(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblRoles(List<TblRoles> TblRoles){
        super.updateAll(TblRoles);
    }
}
