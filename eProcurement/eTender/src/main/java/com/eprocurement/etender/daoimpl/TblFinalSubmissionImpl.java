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
import com.eprocurement.etender.daointerface.TblFinalSubmissionDao;
import com.eprocurement.etender.model.TblFinalsubmission;


@Repository
public class TblFinalSubmissionImpl extends HibernateAbstractClass<TblFinalsubmission> implements TblFinalSubmissionDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblFinalSubmission(TblFinalsubmission tblFinalSubmission){
        super.addEntity(tblFinalSubmission);
    }

    @Override
    public void deleteTblFinalSubmission(TblFinalsubmission tblFinalSubmission) {
        super.deleteEntity(tblFinalSubmission);
    }

    @Override
    public void updateTblFinalSubmission(TblFinalsubmission tblFinalSubmission) {
        super.updateEntity(tblFinalSubmission);
    }

    @Override
    public List<TblFinalsubmission> getAllTblFinalSubmission() {
        return super.getAllEntity();
    }

    @Override
    public List<TblFinalsubmission> findTblFinalSubmission(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblFinalSubmissionCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblFinalsubmission> findByCountTblFinalSubmission(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblFinalSubmission(List<TblFinalsubmission> tblFinalSubmissions){
        super.updateAll(tblFinalSubmissions);
    }
}
