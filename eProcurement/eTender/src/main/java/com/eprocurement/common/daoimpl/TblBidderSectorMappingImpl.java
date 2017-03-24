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
import com.eprocurement.common.daointerface.TblBidderSectorMappingDao;
import com.eprocurement.etender.model.TblBidderSectorMapping;

/**
 *
 */
@Repository
public class TblBidderSectorMappingImpl extends HibernateAbstractClass<TblBidderSectorMapping> implements TblBidderSectorMappingDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidderSectorMapping(TblBidderSectorMapping TblBidderSectorMapping){
        super.addEntity(TblBidderSectorMapping);
    }

    @Override
    public void deleteTblBidderSectorMapping(TblBidderSectorMapping TblBidderSectorMapping) {
        super.deleteEntity(TblBidderSectorMapping);
    }

    @Override
    public void updateTblBidderSectorMapping(TblBidderSectorMapping TblBidderSectorMapping) {
        super.updateEntity(TblBidderSectorMapping);
    }

    @Override
    public List<TblBidderSectorMapping> getAllTblBidderSectorMapping() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidderSectorMapping> findTblBidderSectorMapping(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidderSectorMappingCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidderSectorMapping> findByCountTblBidderSectorMapping(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidderSectorMapping(List<TblBidderSectorMapping> TblBidderSectorMapping){
        super.updateAll(TblBidderSectorMapping);
    }
}
