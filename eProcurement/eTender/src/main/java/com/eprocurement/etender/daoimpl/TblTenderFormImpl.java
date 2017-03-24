package com.eprocurement.etender.daoimpl;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.etender.daointerface.TblTenderFormDao;
import com.eprocurement.etender.model.TblTenderForm;


/**
 *
 * @author branpariya
 */
@Repository
public class TblTenderFormImpl extends HibernateAbstractClass<TblTenderForm> implements TblTenderFormDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTenderForm(TblTenderForm tblTenderForm){
        super.addEntity(tblTenderForm);
    }

    @Override
    public void deleteTblTenderForm(TblTenderForm tblTenderForm) {
        super.deleteEntity(tblTenderForm);
    }

    @Override
    public void updateTblTenderForm(TblTenderForm tblTenderForm) {
        super.updateEntity(tblTenderForm);
    }

    @Override
    public List<TblTenderForm> getAllTblTenderForm() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderForm> findTblTenderForm(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderFormCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderForm> findByCountTblTenderForm(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderForm(List<TblTenderForm> tblTenderForms){
        super.updateAll(tblTenderForms);
    }

	@Override
	public void addEntity(TblTenderForm entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteEntity(TblTenderForm entity) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void updateEntity(TblTenderForm entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateEntityBySession(TblTenderForm entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveOrUpdateEntity(TblTenderForm entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateAll(Collection<TblTenderForm> collection) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TblTenderForm> getAllEntity() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblTenderForm> findEntity(Object... values) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblTenderForm> findByCountEntity(int firstResult,
			int maxResult, Object... values) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getEntityCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Object[]> createQuery(String query, Map<String, Object> var) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object[]> createSQLQuery(String query, Map<String, Object> var) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object[]> createSQLQuery(String query, Map<String, Object> var,
			int[] ncharsIndex, int colcount) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object[]> createByCountQuery(String query,
			Map<String, Object> var, int firstResult, int maxResult) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public List<Object> singleColQuery(String query, Map<String, Object> var) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateDeleteQuery(String query, Map<String, Object> var) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateDeleteSQLQuery(String query, Map<String, Object> var) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List nativeQueryToBean(String query, Class classAlias,
			Map<String, Object> var) throws DataAccessResourceFailureException,
			HibernateException, IllegalStateException, ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}
}
