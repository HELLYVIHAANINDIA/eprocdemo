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
import com.eprocurement.etender.daointerface.TblTenderBidConfirmationDao;
import com.eprocurement.etender.model.TblTenderbidconfirmation;

@Repository
public class TblTenderBidConfirmationImpl extends HibernateAbstractClass<TblTenderbidconfirmation> implements TblTenderBidConfirmationDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderBidConfirmation(TblTenderbidconfirmation tblTenderBidConfirmation){
        super.addEntity(tblTenderBidConfirmation);
    }

    @Override
    public void deleteTblTenderBidConfirmation(TblTenderbidconfirmation tblTenderBidConfirmation) {
        super.deleteEntity(tblTenderBidConfirmation);
    }

    @Override
    public void updateTblTenderBidConfirmation(TblTenderbidconfirmation tblTenderBidConfirmation) {
        super.updateEntity(tblTenderBidConfirmation);
    }

    @Override
    public List<TblTenderbidconfirmation> getAllTblTenderBidConfirmation() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderbidconfirmation> findTblTenderBidConfirmation(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderBidConfirmationCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderbidconfirmation> findByCountTblTenderBidConfirmation(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderBidConfirmation(List<TblTenderbidconfirmation> tblTenderBidConfirmations){
        super.updateAll(tblTenderBidConfirmations);
    }
}
