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
import com.eprocurement.etender.daointerface.TblShareReportDao;
import com.eprocurement.etender.model.TblShareReport;

@Repository
public class TblShareReportImpl extends HibernateAbstractClass<TblShareReport> implements TblShareReportDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblShareReport(TblShareReport tblShareReport){
        super.addEntity(tblShareReport);
    }

    @Override
    public void deleteTblShareReport(TblShareReport tblShareReport) {
        super.deleteEntity(tblShareReport);
    }

    @Override
    public void updateTblShareReport(TblShareReport tblShareReport) {
        super.updateEntity(tblShareReport);
    }

    @Override
    public List<TblShareReport> getAllTblShareReport() {
        return super.getAllEntity();
    }

    @Override
    public List<TblShareReport> findTblShareReport(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblShareReportCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblShareReport> findByCountTblShareReport(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblShareReport(List<TblShareReport> tblShareReports){
        super.updateAll(tblShareReports);
    }
}
