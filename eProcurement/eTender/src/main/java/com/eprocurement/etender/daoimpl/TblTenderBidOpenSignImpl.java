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
import com.eprocurement.etender.daointerface.TblTenderBidOpenSignDao;
import com.eprocurement.etender.model.TblTenderBidOpenSign;

@Repository
public class TblTenderBidOpenSignImpl extends HibernateAbstractClass<TblTenderBidOpenSign> implements TblTenderBidOpenSignDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderBidOpenSign(TblTenderBidOpenSign tblTenderBidOpenSign){
        super.addEntity(tblTenderBidOpenSign);
    }

    @Override
    public void deleteTblTenderBidOpenSign(TblTenderBidOpenSign tblTenderBidOpenSign) {
        super.deleteEntity(tblTenderBidOpenSign);
    }

    @Override
    public void updateTblTenderBidOpenSign(TblTenderBidOpenSign tblTenderBidOpenSign) {
        super.updateEntity(tblTenderBidOpenSign);
    }

    @Override
    public List<TblTenderBidOpenSign> getAllTblTenderBidOpenSign() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderBidOpenSign> findTblTenderBidOpenSign(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderBidOpenSignCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderBidOpenSign> findByCountTblTenderBidOpenSign(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderBidOpenSign(List<TblTenderBidOpenSign> tblTenderBidOpenSigns){
        super.updateAll(tblTenderBidOpenSigns);
    }
}