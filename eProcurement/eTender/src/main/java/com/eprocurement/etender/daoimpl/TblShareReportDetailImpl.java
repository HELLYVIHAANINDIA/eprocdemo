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
import com.eprocurement.etender.daointerface.TblShareReportDetailDao;
import com.eprocurement.etender.model.TblShareReportDetail;

@Repository
public class TblShareReportDetailImpl extends HibernateAbstractClass<TblShareReportDetail> implements TblShareReportDetailDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblShareReportDetail(TblShareReportDetail tblShareReportDetail){
        super.addEntity(tblShareReportDetail);
    }

    @Override
    public void deleteTblShareReportDetail(TblShareReportDetail tblShareReportDetail) {
        super.deleteEntity(tblShareReportDetail);
    }

    @Override
    public void updateTblShareReportDetail(TblShareReportDetail tblShareReportDetail) {
        super.updateEntity(tblShareReportDetail);
    }

    @Override
    public List<TblShareReportDetail> getAllTblShareReportDetail() {
        return super.getAllEntity();
    }

    @Override
    public List<TblShareReportDetail> findTblShareReportDetail(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblShareReportDetailCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblShareReportDetail> findByCountTblShareReportDetail(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblShareReportDetail(List<TblShareReportDetail> tblShareReportDetails){
        super.updateAll(tblShareReportDetails);
    }
}
