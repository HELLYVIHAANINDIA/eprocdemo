package com.eprocurement.etender.daoimpl;

/*
 
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
import com.eprocurement.etender.daointerface.TblBidderItemsDao;
import com.eprocurement.etender.model.TblBidderItems;


@Repository
public class TblBidderItemsImpl extends HibernateAbstractClass<TblBidderItems> implements TblBidderItemsDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidderItems(TblBidderItems tblBidderItems){
        super.addEntity(tblBidderItems);
    }

    @Override
    public void deleteTblBidderItems(TblBidderItems tblBidderItems) {
        super.deleteEntity(tblBidderItems);
    }

    @Override
    public void updateTblBidderItems(TblBidderItems tblBidderItems) {
        super.updateEntity(tblBidderItems);
    }

    @Override
    public List<TblBidderItems> getAllTblBidderItems() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidderItems> findTblBidderItems(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidderItemsCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidderItems> findByCountTblBidderItems(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidderItems(List<TblBidderItems> tblBidderItemss){
        super.updateAll(tblBidderItemss);
    }
}
