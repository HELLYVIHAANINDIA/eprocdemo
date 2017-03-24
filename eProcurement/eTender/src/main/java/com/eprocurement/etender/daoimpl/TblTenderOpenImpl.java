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
import com.eprocurement.etender.daointerface.TblTenderOpenDao;
import com.eprocurement.etender.model.TblTenderopen;

@Repository
public class TblTenderOpenImpl extends HibernateAbstractClass<TblTenderopen> implements TblTenderOpenDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderOpen(TblTenderopen tblTenderOpen){
        super.addEntity(tblTenderOpen);
    }

    @Override
    public void deleteTblTenderOpen(TblTenderopen tblTenderOpen) {
        super.deleteEntity(tblTenderOpen);
    }

    @Override
    public void updateTblTenderOpen(TblTenderopen tblTenderOpen) {
        super.updateEntity(tblTenderOpen);
    }

    @Override
    public List<TblTenderopen> getAllTblTenderOpen() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderopen> findTblTenderOpen(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderOpenCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderopen> findByCountTblTenderOpen(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderOpen(List<TblTenderopen> tblTenderOpens){
        super.updateAll(tblTenderOpens);
    }
}
