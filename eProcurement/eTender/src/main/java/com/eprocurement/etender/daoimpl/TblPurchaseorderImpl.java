package com.eprocurement.etender.daoimpl;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import com.eprocurement.etender.daointerface.TblPurchaseorderDao;
import com.eprocurement.etender.model.TblPurchaseorder;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;


@Repository
public class TblPurchaseorderImpl extends HibernateAbstractClass<TblPurchaseorder> implements TblPurchaseorderDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblPurchaseorder(TblPurchaseorder TblPurchaseorder){
        super.addEntity(TblPurchaseorder);
    }

    @Override
    public void deleteTblPurchaseorder(TblPurchaseorder TblPurchaseorder) {
        super.deleteEntity(TblPurchaseorder);
    }

    @Override
    public void updateTblPurchaseorder(TblPurchaseorder TblPurchaseorder) {
        super.updateEntity(TblPurchaseorder);
    }

    @Override
    public List<TblPurchaseorder> getAllTblPurchaseorder() {
        return super.getAllEntity();
    }

    @Override
    public List<TblPurchaseorder> findTblPurchaseorder(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblPurchaseorderCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblPurchaseorder> findByCountTblPurchaseorder(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblPurchaseorder(List<TblPurchaseorder> TblPurchaseorders){
        super.updateAll(TblPurchaseorders);
    }
}
