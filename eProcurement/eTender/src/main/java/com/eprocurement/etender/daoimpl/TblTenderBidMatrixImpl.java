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
import com.eprocurement.etender.daointerface.TblTenderBidMatrixDao;
import com.eprocurement.etender.model.TblTenderBidMatrix;

/**
 *
 * @author branpariya
 */
@Repository
public class TblTenderBidMatrixImpl extends HibernateAbstractClass<TblTenderBidMatrix> implements TblTenderBidMatrixDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderBidMatrix(TblTenderBidMatrix tblTenderBidMatrix){
        super.addEntity(tblTenderBidMatrix);
    }

    @Override
    public void deleteTblTenderBidMatrix(TblTenderBidMatrix tblTenderBidMatrix) {
        super.deleteEntity(tblTenderBidMatrix);
    }

    @Override
    public void updateTblTenderBidMatrix(TblTenderBidMatrix tblTenderBidMatrix) {
        super.updateEntity(tblTenderBidMatrix);
    }

    @Override
    public List<TblTenderBidMatrix> getAllTblTenderBidMatrix() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderBidMatrix> findTblTenderBidMatrix(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderBidMatrixCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderBidMatrix> findByCountTblTenderBidMatrix(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderBidMatrix(List<TblTenderBidMatrix> tblTenderBidMatrixs){
        super.updateAll(tblTenderBidMatrixs);
    }
}

