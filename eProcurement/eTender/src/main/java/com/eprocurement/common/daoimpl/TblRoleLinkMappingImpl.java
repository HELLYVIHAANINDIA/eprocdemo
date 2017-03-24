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
import com.eprocurement.common.daointerface.TblRoleLinkMappingDao;
import com.eprocurement.etender.model.TblRoleLinkMapping;

/**
 *
 */
@Repository
public class TblRoleLinkMappingImpl extends HibernateAbstractClass<TblRoleLinkMapping> implements TblRoleLinkMappingDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblRoleLinkMapping(TblRoleLinkMapping TblRoleLinkMapping){
        super.addEntity(TblRoleLinkMapping);
    }

    @Override
    public void deleteTblRoleLinkMapping(TblRoleLinkMapping TblRoleLinkMapping) {
        super.deleteEntity(TblRoleLinkMapping);
    }

    @Override
    public void updateTblRoleLinkMapping(TblRoleLinkMapping TblRoleLinkMapping) {
        super.updateEntity(TblRoleLinkMapping);
    }

    @Override
    public List<TblRoleLinkMapping> getAllTblRoleLinkMapping() {
        return super.getAllEntity();
    }

    @Override
    public List<TblRoleLinkMapping> findTblRoleLinkMapping(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblRoleLinkMappingCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblRoleLinkMapping> findByCountTblRoleLinkMapping(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblRoleLinkMapping(List<TblRoleLinkMapping> TblRoleLinkMapping){
        super.updateAll(TblRoleLinkMapping);
    }
}
