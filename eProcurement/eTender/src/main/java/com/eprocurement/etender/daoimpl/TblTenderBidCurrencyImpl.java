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
import com.eprocurement.etender.daointerface.TblTenderBidCurrencyDao;
import com.eprocurement.etender.model.TblBidderApprovalDetail;
import com.eprocurement.etender.model.TblTenderBidCurrency;

@Repository
public class TblTenderBidCurrencyImpl extends HibernateAbstractClass<TblTenderBidCurrency> implements TblTenderBidCurrencyDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

	@Override
	public void addTblTenderBidCurrency(
			TblTenderBidCurrency tblTenderBidCurrency) {
		// TODO Auto-generated method stub
		super.addEntity(tblTenderBidCurrency);
		
	}

	@Override
	public void deleteTblTenderBidCurrency(
			TblTenderBidCurrency tblTenderBidCurrency) {
		// TODO Auto-generated method stub
		super.deleteEntity(tblTenderBidCurrency);
		
	}

	@Override
	public void updateTblTenderBidCurrency(
			TblTenderBidCurrency tblTenderBidCurrency) {
		// TODO Auto-generated method stub
		super.updateEntity(tblTenderBidCurrency);
	}

	@Override
	public List<TblTenderBidCurrency> getAllTblTenderBidCurrency() {
		// TODO Auto-generated method stub
		return super.getAllEntity();
	}

	@Override
	public List<TblTenderBidCurrency> findTblTenderBidCurrency(Object... values)
			throws Exception {
		// TODO Auto-generated method stub
		return super.findEntity(values);
	}

	@Override
	public List<TblTenderBidCurrency> findByCountTblTenderBidCurrency(
			int firstResult, int maxResult, Object... values) throws Exception {
		// TODO Auto-generated method stub
		return super.findByCountEntity(firstResult, maxResult, values);
	}

	@Override
	public long getTblTenderBidCurrencyCount() {
		// TODO Auto-generated method stub
		return super.getEntityCount();
	}

	@Override
	public void saveUpdateAllTblTenderBidCurrency(
			List<TblTenderBidCurrency> tblTenderBidCurrencys) {
		// TODO Auto-generated method stub
		super.updateAll(tblTenderBidCurrencys);
		
	}

}
