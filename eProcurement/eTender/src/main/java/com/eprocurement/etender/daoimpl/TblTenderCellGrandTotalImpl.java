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
import com.eprocurement.etender.daointerface.TblTenderCellGrandTotalDao;
import com.eprocurement.etender.model.TblTenderCellGrandTotal;

/**
 *
 */
@Repository
public class TblTenderCellGrandTotalImpl extends HibernateAbstractClass<TblTenderCellGrandTotal> implements TblTenderCellGrandTotalDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderCellGrandTotal(TblTenderCellGrandTotal tblTenderCellGrandTotal){
        super.addEntity(tblTenderCellGrandTotal);
    }

    @Override
    public void deleteTblTenderCellGrandTotal(TblTenderCellGrandTotal tblTenderCellGrandTotal) {
        super.deleteEntity(tblTenderCellGrandTotal);
    }

    @Override
    public void updateTblTenderCellGrandTotal(TblTenderCellGrandTotal tblTenderCellGrandTotal) {
        super.updateEntity(tblTenderCellGrandTotal);
    }

    @Override
    public List<TblTenderCellGrandTotal> getAllTblTenderCellGrandTotal() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderCellGrandTotal> findTblTenderCellGrandTotal(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderCellGrandTotalCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderCellGrandTotal> findByCountTblTenderCellGrandTotal(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderCellGrandTotal(List<TblTenderCellGrandTotal> tblTenderCellGrandTotals){
        super.updateAll(tblTenderCellGrandTotals);
    }
    @Override
    public void updateAllTblTenderCellGrandTotal(List<TblTenderCellGrandTotal> tblTenderCellGrandTotals){
        super.saveAll(tblTenderCellGrandTotals);
    }
}
