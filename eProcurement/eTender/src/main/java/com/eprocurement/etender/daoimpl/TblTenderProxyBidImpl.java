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
import com.eprocurement.etender.daointerface.TblTenderProxyBidDao;
import com.eprocurement.etender.model.TblTenderProxyBid;

@Repository
public class TblTenderProxyBidImpl extends HibernateAbstractClass<TblTenderProxyBid> implements TblTenderProxyBidDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderProxyBid(TblTenderProxyBid tblTenderProxyBid){
        super.addEntity(tblTenderProxyBid);
    }

    @Override
    public void deleteTblTenderProxyBid(TblTenderProxyBid tblTenderProxyBid) {
        super.deleteEntity(tblTenderProxyBid);
    }

    @Override
    public void updateTblTenderProxyBid(TblTenderProxyBid tblTenderProxyBid) {
        super.updateEntity(tblTenderProxyBid);
    }

    @Override
    public List<TblTenderProxyBid> getAllTblTenderProxyBid() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderProxyBid> findTblTenderProxyBid(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderProxyBidCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderProxyBid> findByCountTblTenderProxyBid(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderProxyBid(List<TblTenderProxyBid> tblTenderProxyBids){
        super.updateAll(tblTenderProxyBids);
    }
}
