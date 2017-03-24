/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daoimpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.etender.daointerface.TblTenderBidDao;
import com.eprocurement.etender.model.TblTenderBid;

@Repository
public class TblTenderBidImpl extends HibernateAbstractClass<TblTenderBid> implements TblTenderBidDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderBid(TblTenderBid tblTenderBid){
        super.addEntity(tblTenderBid);
    }

    @Override
    public void deleteTblTenderBid(TblTenderBid tblTenderBid) {
        super.deleteEntity(tblTenderBid);
    }

    @Override
    public void updateTblTenderBid(TblTenderBid tblTenderBid) {
        super.updateEntity(tblTenderBid);
    }

    @Override
    public List<TblTenderBid> getAllTblTenderBid() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderBid> findTblTenderBid(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderBidCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderBid> findByCountTblTenderBid(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderBid(List<TblTenderBid> tblTenderBids){
        super.updateAll(tblTenderBids);
    }
}

