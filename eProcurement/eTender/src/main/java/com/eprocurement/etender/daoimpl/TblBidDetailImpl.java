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
import com.eprocurement.etender.daointerface.TblBidDetailDao;
import com.eprocurement.etender.model.TblBidDetail;


@Repository
public class TblBidDetailImpl extends HibernateAbstractClass<TblBidDetail> implements TblBidDetailDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidDetail(TblBidDetail tblBidDetail){
        super.addEntity(tblBidDetail);
    }

    @Override
    public void deleteTblBidDetail(TblBidDetail tblBidDetail) {
        super.deleteEntity(tblBidDetail);
    }

    @Override
    public void updateTblBidDetail(TblBidDetail tblBidDetail) {
        super.updateEntity(tblBidDetail);
    }

    @Override
    public List<TblBidDetail> getAllTblBidDetail() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidDetail> findTblBidDetail(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidDetailCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidDetail> findByCountTblBidDetail(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidDetail(List<TblBidDetail> tblBidDetails){
        super.updateAll(tblBidDetails);
    }
    @Override
    public void updateAllTblBidDetail(List<TblBidDetail> tblBidDetails){
        super.saveAll(tblBidDetails);
    }
}
