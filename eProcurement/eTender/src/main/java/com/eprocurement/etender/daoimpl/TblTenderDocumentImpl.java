/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daoimpl;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.etender.daointerface.TblTenderDocumentDao;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderDocument;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

/**
 *
 * @author BigGoal
 */
public class TblTenderDocumentImpl extends HibernateAbstractClass<TblTenderDocument> implements TblTenderDocumentDao {
    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderDocument(TblTenderDocument tblTenderDocument){
        super.addEntity(tblTenderDocument);
    }

    @Override
    public void deleteTblTenderDocument(TblTenderDocument tblTenderDocument) {
        super.deleteEntity(tblTenderDocument);
    }

    @Override
    public void updateTblTenderDocument(TblTenderDocument tblTenderDocument) {
        super.updateEntity(tblTenderDocument);
    }

    @Override
    public List<TblTenderDocument> getAllTblTenderDocument() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderDocument> findTblTenderDocument(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderDocumentCount() {
        return super.getEntityCount();
    }

    

    @Override
    public void saveUpdateAllTblTenderDocument(List<TblTenderDocument> tblTenderDocuments){
        super.updateAll(tblTenderDocuments);
    }

    @Override
    public List<TblTenderDocument> findByCountTblTenderDocument(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }
}
