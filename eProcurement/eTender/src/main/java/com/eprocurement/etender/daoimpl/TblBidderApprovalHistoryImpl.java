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
import com.eprocurement.etender.daointerface.TblBidderApprovalHistoryDao;
import com.eprocurement.etender.model.TblBidderApprovalHistory;

/**
 *
 * @author branpariya
 */
@Repository
public class TblBidderApprovalHistoryImpl extends HibernateAbstractClass<TblBidderApprovalHistory> implements TblBidderApprovalHistoryDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblBidderApprovalHistory(TblBidderApprovalHistory tblBidderApprovalHistory){
        super.addEntity(tblBidderApprovalHistory);
    }

    @Override
    public void deleteTblBidderApprovalHistory(TblBidderApprovalHistory tblBidderApprovalHistory) {
        super.deleteEntity(tblBidderApprovalHistory);
    }

    @Override
    public void updateTblBidderApprovalHistory(TblBidderApprovalHistory tblBidderApprovalHistory) {
        super.updateEntity(tblBidderApprovalHistory);
    }

    @Override
    public List<TblBidderApprovalHistory> getAllTblBidderApprovalHistory() {
        return super.getAllEntity();
    }

    @Override
    public List<TblBidderApprovalHistory> findTblBidderApprovalHistory(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblBidderApprovalHistoryCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblBidderApprovalHistory> findByCountTblBidderApprovalHistory(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblBidderApprovalHistory(List<TblBidderApprovalHistory> tblBidderApprovalHistorys){
        super.updateAll(tblBidderApprovalHistorys);
    }
}
