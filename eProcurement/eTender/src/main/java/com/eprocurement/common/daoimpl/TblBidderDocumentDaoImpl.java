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
import com.eprocurement.common.daointerface.TblBidderDocumentDao;
import com.eprocurement.etender.model.TblBidderdocument;

/**
 *
 */
@Repository
public class TblBidderDocumentDaoImpl extends HibernateAbstractClass<TblBidderdocument> implements TblBidderDocumentDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidderdocument(TblBidderdocument TblBidderdocument){
        super.addEntity(TblBidderdocument);
    }

    @Override
    public void deleteTblBidderdocument(TblBidderdocument TblBidderdocument) {
        super.deleteEntity(TblBidderdocument);
    }

    @Override
    public void updateTblBidderdocument(TblBidderdocument TblBidderdocument) {
        super.updateEntity(TblBidderdocument);
    }

    @Override
    public List<TblBidderdocument> getAllTblBidderdocument() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidderdocument> findTblBidderdocument(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidderdocumentCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidderdocument> findByCountTblBidderdocument(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidderdocument(List<TblBidderdocument> TblBidderdocument){
        super.updateAll(TblBidderdocument);
    }
}
