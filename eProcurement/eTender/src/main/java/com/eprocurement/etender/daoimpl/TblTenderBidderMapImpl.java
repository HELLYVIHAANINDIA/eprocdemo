package com.eprocurement.etender.daoimpl;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.List;


import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.etender.daointerface.TblTenderBidderMapDao;
import com.eprocurement.etender.model.TblTenderBidderMap;

/**
 *
 */
@Repository
public class TblTenderBidderMapImpl extends HibernateAbstractClass<TblTenderBidderMap> implements TblTenderBidderMapDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderBidderMap(TblTenderBidderMap tblTenderBidderMap) {
        super.addEntity(tblTenderBidderMap);
    }

    @Override
    public void deleteTblTenderBidderMap(TblTenderBidderMap tblTenderBidderMap) {
        super.deleteEntity(tblTenderBidderMap);
    }

    @Override
    public void updateTblTenderBidderMap(TblTenderBidderMap tblTenderBidderMap) {
        super.updateEntity(tblTenderBidderMap);
    }

    @Override
    public List<TblTenderBidderMap> getAllTblTenderBidderMap() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderBidderMap> findTblTenderBidderMap(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderBidderMapCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderBidderMap> findByCountTblTenderBidderMap(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderBidderMap(List<TblTenderBidderMap> tblTenderBidderMaps) {
        super.updateAll(tblTenderBidderMaps);
    }
}