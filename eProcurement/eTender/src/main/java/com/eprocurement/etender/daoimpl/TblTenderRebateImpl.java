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
import com.eprocurement.etender.daointerface.TblTenderRebateDao;
import com.eprocurement.etender.model.TblTenderRebate;


@Repository
public class TblTenderRebateImpl extends HibernateAbstractClass<TblTenderRebate> implements TblTenderRebateDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderRebate(TblTenderRebate tblTenderRebate){
        super.addEntity(tblTenderRebate);
    }

    @Override
    public void deleteTblTenderRebate(TblTenderRebate tblTenderRebate) {
        super.deleteEntity(tblTenderRebate);
    }

    @Override
    public void updateTblTenderRebate(TblTenderRebate tblTenderRebate) {
        super.updateEntity(tblTenderRebate);
    }

    @Override
    public List<TblTenderRebate> getAllTblTenderRebate() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderRebate> findTblTenderRebate(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderRebateCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderRebate> findByCountTblTenderRebate(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderRebate(List<TblTenderRebate> tblTenderRebates){
        super.updateAll(tblTenderRebates);
    }
}
