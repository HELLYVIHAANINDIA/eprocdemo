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
import com.eprocurement.etender.daointerface.TblL1H1ReportDao;
import com.eprocurement.etender.model.TblL1H1Report;

@Repository
public class TblL1H1ReportDaoImpl extends HibernateAbstractClass<TblL1H1Report> implements TblL1H1ReportDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblL1H1Report(TblL1H1Report TblL1H1Report){
        super.addEntity(TblL1H1Report);
    }

    @Override
    public void deleteTblL1H1Report(TblL1H1Report TblL1H1Report) {
        super.deleteEntity(TblL1H1Report);
    }

    @Override
    public void updateTblL1H1Report(TblL1H1Report TblL1H1Report) {
        super.updateEntity(TblL1H1Report);
    }

    @Override
    public List<TblL1H1Report> getAllTblL1H1Report() {
        return super.getAllEntity();
    }

    @Override
    public List<TblL1H1Report> findTblL1H1Report(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblL1H1ReportCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblL1H1Report> findByCountTblL1H1Report(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblL1H1Report(List<TblL1H1Report> TblL1H1Reports){
        super.updateAll(TblL1H1Reports);
    }
}
