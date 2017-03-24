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
import com.eprocurement.common.daointerface.TblBidderDao;
import com.eprocurement.etender.model.TblBidder;

/**
 *
 */
@Repository
public class TblBidderDaoImpl extends HibernateAbstractClass<TblBidder> implements TblBidderDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidder(TblBidder TblBidder){
        super.addEntity(TblBidder);
    }

    @Override
    public void deleteTblBidder(TblBidder TblBidder) {
        super.deleteEntity(TblBidder);
    }

    @Override
    public void updateTblBidder(TblBidder TblBidder) {
        super.updateEntity(TblBidder);
    }

    @Override
    public List<TblBidder> getAllTblBidder() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidder> findTblBidder(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidderCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidder> findByCountTblBidder(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidder(List<TblBidder> TblBidder){
        super.updateAll(TblBidder);
    }
}
