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
import com.eprocurement.common.daointerface.TblUserRoleMappingDao;
import com.eprocurement.etender.model.TblUserRoleMapping;

/**
 *
 */
@Repository
public class TblUserRoleMappingImpl extends HibernateAbstractClass<TblUserRoleMapping> implements TblUserRoleMappingDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblUserRoleMapping(TblUserRoleMapping TblUserRoleMapping){
        super.addEntity(TblUserRoleMapping);
    }

    @Override
    public void deleteTblUserRoleMapping(TblUserRoleMapping TblUserRoleMapping) {
        super.deleteEntity(TblUserRoleMapping);
    }

    @Override
    public void updateTblUserRoleMapping(TblUserRoleMapping TblUserRoleMapping) {
        super.updateEntity(TblUserRoleMapping);
    }

    @Override
    public List<TblUserRoleMapping> getAllTblUserRoleMapping() {
        return super.getAllEntity();
    }

    @Override
    public List<TblUserRoleMapping> findTblUserRoleMapping(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblUserRoleMappingCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblUserRoleMapping> findByCountTblUserRoleMapping(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblUserRoleMapping(List<TblUserRoleMapping> TblUserRoleMapping){
        super.updateAll(TblUserRoleMapping);
    }
}
