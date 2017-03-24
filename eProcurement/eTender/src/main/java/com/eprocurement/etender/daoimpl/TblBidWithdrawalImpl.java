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
import com.eprocurement.etender.daointerface.TblBidWithdrawalDao;
import com.eprocurement.etender.model.TblBidWithdrawal;

@Repository
public class TblBidWithdrawalImpl extends HibernateAbstractClass<TblBidWithdrawal> implements TblBidWithdrawalDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidWithdrawal(TblBidWithdrawal tblBidWithdrawal){
        super.addEntity(tblBidWithdrawal);
    }

    @Override
    public void deleteTblBidWithdrawal(TblBidWithdrawal tblBidWithdrawal) {
        super.deleteEntity(tblBidWithdrawal);
    }

    @Override
    public void updateTblBidWithdrawal(TblBidWithdrawal tblBidWithdrawal) {
        super.updateEntity(tblBidWithdrawal);
    }

    @Override
    public List<TblBidWithdrawal> getAllTblBidWithdrawal() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidWithdrawal> findTblBidWithdrawal(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidWithdrawalCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidWithdrawal> findByCountTblBidWithdrawal(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidWithdrawal(List<TblBidWithdrawal> tblBidWithdrawals){
        super.updateAll(tblBidWithdrawals);
    }
}

