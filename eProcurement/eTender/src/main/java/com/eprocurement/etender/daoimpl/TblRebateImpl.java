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
import com.eprocurement.etender.daointerface.TblRebateDao;
import com.eprocurement.etender.model.TblRebate;


@Repository
public class TblRebateImpl extends HibernateAbstractClass<TblRebate> implements TblRebateDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    //@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
    public void addTblRebate(TblRebate tblRebate){
        super.addEntity(tblRebate);
    }

    @Override
    public void deleteTblRebate(TblRebate tblRebate) {
        super.deleteEntity(tblRebate);
    }

    @Override
    public void updateTblRebate(TblRebate tblRebate) {
        super.updateEntity(tblRebate);
    }

    @Override
    public List<TblRebate> getAllTblRebate() {
        return super.getAllEntity();
    }

    @Override
    public List<TblRebate> findTblRebate(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblRebateCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblRebate> findByCountTblRebate(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblRebate(List<TblRebate> tblRebates){
        super.updateAll(tblRebates);
    }
}
