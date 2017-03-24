/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daoimpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.common.daointerface.TblLinkDao;
import com.eprocurement.etender.model.TblLink;

/**
 *
 */
@Repository
public class TblLinkDaoImpl extends HibernateAbstractClass<TblLink> implements TblLinkDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblLink(TblLink TblLink){
        super.addEntity(TblLink);
    }

    @Override
    public void deleteTblLink(TblLink TblLink) {
        super.deleteEntity(TblLink);
    }

    @Override
    public void updateTblLink(TblLink TblLink) {
        super.updateEntity(TblLink);
    }

    @Override
    public List<TblLink> getAllTblLink() {
        return super.getAllEntity();
    }

    @Override
    public List<TblLink> findTblLink(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblLinkCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblLink> findByCountTblLink(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblLink(List<TblLink> TblLink){
        super.updateAll(TblLink);
    }
}
