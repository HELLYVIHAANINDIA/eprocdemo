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
import com.eprocurement.etender.daointerface.TblTenderBidDetailDao;
import com.eprocurement.etender.model.TblTenderBidDetail;

@Repository
public class TblTenderBidDetailImpl extends HibernateAbstractClass<TblTenderBidDetail> implements TblTenderBidDetailDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderBidDetail(TblTenderBidDetail tblTenderBidDetail){
        super.addEntity(tblTenderBidDetail);
    }

    @Override
    public void deleteTblTenderBidDetail(TblTenderBidDetail tblTenderBidDetail) {
        super.deleteEntity(tblTenderBidDetail);
    }

    @Override
    public void updateTblTenderBidDetail(TblTenderBidDetail tblTenderBidDetail) {
        super.updateEntity(tblTenderBidDetail);
    }

    @Override
    public List<TblTenderBidDetail> getAllTblTenderBidDetail() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderBidDetail> findTblTenderBidDetail(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderBidDetailCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderBidDetail> findByCountTblTenderBidDetail(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderBidDetail(List<TblTenderBidDetail> tblTenderBidDetails){
        super.updateAll(tblTenderBidDetails);
    }
    
    @Override
    public void updateAllTblTenderBidDetail(List<TblTenderBidDetail> tblTenderBidDetails){
        super.saveAll(tblTenderBidDetails);
    }
}
