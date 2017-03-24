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
import com.eprocurement.common.daointerface.TblDepartmentDao;
import com.eprocurement.common.daointerface.TblOfficerDao;
import com.eprocurement.etender.model.TblDepartment;

/**
 *
 */
@Repository
public class TblDepartmentDaoImpl extends HibernateAbstractClass<TblDepartment> implements TblDepartmentDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblDepartment(TblDepartment tblDepartment){
        super.addEntity(tblDepartment);
    }

    @Override
    public void deleteTblDepartment(TblDepartment tblDepartment) {
        super.deleteEntity(tblDepartment);
    }

    @Override
    public void updateTblDepartment(TblDepartment tblDepartment) {
        super.updateEntity(tblDepartment);
    }

    @Override
    public List<TblDepartment> getAllTblDepartment() {
        return super.getAllEntity();
    }

    @Override
    public List<TblDepartment> findTblDepartment(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblDepartmentCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblDepartment> findByCountTblDepartment(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblDepartment(List<TblDepartment> tblDepartment){
        super.updateAll(tblDepartment);
    }
}
