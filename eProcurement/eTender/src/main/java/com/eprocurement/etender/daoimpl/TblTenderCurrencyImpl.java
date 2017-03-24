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
import com.eprocurement.etender.daointerface.TblTenderCurrencyDao;
import com.eprocurement.etender.model.TblTenderCurrency;

@Repository
public class TblTenderCurrencyImpl extends HibernateAbstractClass<TblTenderCurrency> implements TblTenderCurrencyDao {

	@Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

	@Override
	public void saveUpdateAllTblTenderCurrency(List<TblTenderCurrency> tblTenderCurrencys) {
		// TODO Auto-generated method stub
		super.updateAll(tblTenderCurrencys);
	}

	@Override
	public void updateAllTblTenderCurrency(List<TblTenderCurrency> tblTenderCurrencys) {
		// TODO Auto-generated method stub
		super.saveAll(tblTenderCurrencys);
	}
	
	@Override
	public void addTblTenderCurrency(TblTenderCurrency tblTenderCurrency) {
		// TODO Auto-generated method stub
		super.addEntity(tblTenderCurrency);
		
	}

	@Override
	public void deleteTblTenderCurrency(TblTenderCurrency tblTenderCurrency) {
		// TODO Auto-generated method stub
		super.deleteEntity(tblTenderCurrency);
	}

	@Override
	public void updateTblTenderCurrency(TblTenderCurrency tblTenderCurrency) {
		// TODO Auto-generated method stub
		super.updateEntity(tblTenderCurrency);
		
	}

	@Override
	public List<TblTenderCurrency> getAllTblTenderCurrency() {
		// TODO Auto-generated method stub
		return super.getAllEntity();
	}

	@Override
	public List<TblTenderCurrency> findTblTenderCurrency(Object... values)
			throws Exception {
		// TODO Auto-generated method stub
		return super.findEntity(values);
	}

	@Override
	public List<TblTenderCurrency> findByCountTblTenderCurrency(
			int firstResult, int maxResult, Object... values) throws Exception {
		// TODO Auto-generated method stub
		return super.findByCountEntity(firstResult, maxResult, values);
	}

	@Override
	public long getTblTenderCurrencyCount() {
		// TODO Auto-generated method stub
		return super.getEntityCount();
	}

   
}

