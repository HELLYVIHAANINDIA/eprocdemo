package com.eprocurement.etender.daoimpl;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.stereotype.Repository;

import com.eprocurement.etender.daointerface.TblTenderAuditTrailDao;
import com.eprocurement.etender.model.TblTenderAuditTrail;

/**
 *
 */
@Repository
public class TblTenderAuditTrailImpl implements TblTenderAuditTrailDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
       // setSessionFactory(sessionFactory);
    }

  /*  @Override
    public void addTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail){
        super.addEntity(tblTenderAuditTrail);
    }

    @Override
    public void deleteTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail) {
        super.deleteEntity(tblTenderAuditTrail);
    }

    @Override
    public void updateTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail) {
        super.updateEntity(tblTenderAuditTrail);
    }

    @Override
    public List<TblTenderAuditTrail> getAllTblTenderAuditTrail() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTenderAuditTrail> findTblTenderAuditTrail(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderAuditTrailCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTenderAuditTrail> findByCountTblTenderAuditTrail(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTenderAuditTrail(List<TblTenderAuditTrail> tblTenderAuditTrails){
        super.updateAll(tblTenderAuditTrails);
    }
*/
	@Override
	public void addEntity(TblTenderAuditTrail entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteEntity(TblTenderAuditTrail entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteAll(Collection<TblTenderAuditTrail> collection) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateEntity(TblTenderAuditTrail entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateEntityBySession(TblTenderAuditTrail entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveOrUpdateEntity(TblTenderAuditTrail entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateAll(Collection<TblTenderAuditTrail> collection) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TblTenderAuditTrail> getAllEntity() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblTenderAuditTrail> findEntity(Object... values) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblTenderAuditTrail> findByCountEntity(int firstResult, int maxResult, Object... values)
			throws Exception {
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
	public List<Object[]> createSQLQuery(String query, Map<String, Object> var, int[] ncharsIndex, int colcount) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object[]> createByCountQuery(String query, Map<String, Object> var, int firstResult, int maxResult) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long countForQuery(String from, String countOn, String where, Map<String, Object> var) throws Exception {
		// TODO Auto-generated method stub
		return 0;
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
	public List nativeQueryToBean(String query, Class classAlias, Map<String, Object> var)
			throws DataAccessResourceFailureException, HibernateException, IllegalStateException,
			ClassNotFoundException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TblTenderAuditTrail> getAllTblTenderAuditTrail() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblTenderAuditTrail> findTblTenderAuditTrail(Object... values) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblTenderAuditTrail> findByCountTblTenderAuditTrail(int firstResult, int maxResult, Object... values)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getTblTenderAuditTrailCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void saveUpdateAllTblTenderAuditTrail(List<TblTenderAuditTrail> tblTenderAuditTrails) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveAll(Collection<TblTenderAuditTrail> collection) {
		// TODO Auto-generated method stub
		
	}
}
