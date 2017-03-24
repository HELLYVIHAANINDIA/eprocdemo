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
import com.eprocurement.etender.daointerface.TblBidderApprovalDetailDao;
import com.eprocurement.etender.model.TblBidderApprovalDetail;

@Repository
public class TblBidderApprovalDetailImpl extends HibernateAbstractClass<TblBidderApprovalDetail> implements TblBidderApprovalDetailDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidderApprovalDetail(TblBidderApprovalDetail tblBidderApprovalDetail){
        super.addEntity(tblBidderApprovalDetail);
    }

    @Override
    public void deleteTblBidderApprovalDetail(TblBidderApprovalDetail tblBidderApprovalDetail) {
        super.deleteEntity(tblBidderApprovalDetail);
    }

    @Override
    public void updateTblBidderApprovalDetail(TblBidderApprovalDetail tblBidderApprovalDetail) {
        super.updateEntity(tblBidderApprovalDetail);
    }

    @Override
    public List<TblBidderApprovalDetail> getAllTblBidderApprovalDetail() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidderApprovalDetail> findTblBidderApprovalDetail(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidderApprovalDetailCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidderApprovalDetail> findByCountTblBidderApprovalDetail(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidderApprovalDetail(List<TblBidderApprovalDetail> tblBidderApprovalDetails){
        super.updateAll(tblBidderApprovalDetails);
    }
}
