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
import com.eprocurement.etender.daointerface.TblRebateDetailDao;
import com.eprocurement.etender.model.TblRebateDetail;


@Repository
public class TblRebateDetailImpl extends HibernateAbstractClass<TblRebateDetail> implements TblRebateDetailDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblRebateDetail(TblRebateDetail tblRebateDetail) {
        super.addEntity(tblRebateDetail);
    }

    @Override
    public void deleteTblRebateDetail(TblRebateDetail tblRebateDetail) {
        super.deleteEntity(tblRebateDetail);
    }

    @Override
    public void updateTblRebateDetail(TblRebateDetail tblRebateDetail) {
        super.updateEntity(tblRebateDetail);
    }

    @Override
    public List<TblRebateDetail> getAllTblRebateDetail() {
        return super.getAllEntity();
    }

    @Override
    public List<TblRebateDetail> findTblRebateDetail(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblRebateDetailCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblRebateDetail> findByCountTblRebateDetail(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblRebateDetail(List<TblRebateDetail> tblRebateDetails) {
        super.updateAll(tblRebateDetails);
    }
}
