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
import com.eprocurement.etender.daointerface.TblTenderTableDao;
import com.eprocurement.etender.model.TblTenderTable;

@Repository
public class TblTenderTableImpl extends HibernateAbstractClass<TblTenderTable> implements TblTenderTableDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderTable(TblTenderTable tblTenderTable){
        super.addEntity(tblTenderTable);
    }

    @Override
    public void deleteTblTenderTable(TblTenderTable tblTenderTable) {
        super.deleteEntity(tblTenderTable);
    }

    @Override
    public void updateTblTenderTable(TblTenderTable tblTenderTable) {
        super.updateEntity(tblTenderTable);
    }

    @Override
    public List<TblTenderTable> getAllTblTenderTable() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderTable> findTblTenderTable(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderTableCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderTable> findByCountTblTenderTable(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderTable(List<TblTenderTable> tblTenderTables){
        super.updateAll(tblTenderTables);
    }
}
