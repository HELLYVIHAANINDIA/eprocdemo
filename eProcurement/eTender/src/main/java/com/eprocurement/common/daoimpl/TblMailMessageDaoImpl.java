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
import com.eprocurement.common.daointerface.TblMailMessageDao;
import com.eprocurement.common.model.TblMailMessage;

/**
 *
 */
@Repository
public class TblMailMessageDaoImpl extends HibernateAbstractClass<TblMailMessage> implements TblMailMessageDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblMailMessage(TblMailMessage TblMailMessage){
        super.addEntity(TblMailMessage);
    }

    @Override
    public void deleteTblMailMessage(TblMailMessage TblMailMessage) {
        super.deleteEntity(TblMailMessage);
    }

    @Override
    public void updateTblMailMessage(TblMailMessage TblMailMessage) {
        super.updateEntity(TblMailMessage);
    }

    @Override
    public List<TblMailMessage> getAllTblMailMessage() {
        return super.getAllEntity();
    }

    @Override
    public List<TblMailMessage> findTblMailMessage(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblMailMessageCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblMailMessage> findByCountTblMailMessage(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblMailMessage(List<TblMailMessage> TblMailMessage){
        super.updateAll(TblMailMessage);
    }
}
