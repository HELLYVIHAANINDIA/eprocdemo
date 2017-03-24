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
import com.eprocurement.etender.daointerface.TblTenderColumnDao;
import com.eprocurement.etender.model.TblTenderColumn;

@Repository
public class TblTenderColumnImpl extends HibernateAbstractClass<TblTenderColumn> implements TblTenderColumnDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderColumn(TblTenderColumn tblTenderColumn){
        super.addEntity(tblTenderColumn);
    }

    @Override
    public void deleteTblTenderColumn(TblTenderColumn tblTenderColumn) {
        super.deleteEntity(tblTenderColumn);
    }

    @Override
    public void updateTblTenderColumn(TblTenderColumn tblTenderColumn) {
        super.updateEntity(tblTenderColumn);
    }

    @Override
    public List<TblTenderColumn> getAllTblTenderColumn() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderColumn> findTblTenderColumn(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderColumnCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderColumn> findByCountTblTenderColumn(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderColumn(List<TblTenderColumn> tblTenderColumns){
        super.updateAll(tblTenderColumns);
    }
}
