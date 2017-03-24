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
import com.eprocurement.etender.daointerface.TblItemSelectionDao;
import com.eprocurement.etender.model.TblItemSelection;


@Repository
public class TblItemSelectionImpl extends HibernateAbstractClass<TblItemSelection> implements TblItemSelectionDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblItemSelection(TblItemSelection tblItemSelection){
        super.addEntity(tblItemSelection);
    }

    @Override
    public void deleteTblItemSelection(TblItemSelection tblItemSelection) {
        super.deleteEntity(tblItemSelection);
    }

    @Override
    public void updateTblItemSelection(TblItemSelection tblItemSelection) {
        super.updateEntity(tblItemSelection);
    }

    @Override
    public List<TblItemSelection> getAllTblItemSelection() {
        return super.getAllEntity();
    }

    @Override
    public List<TblItemSelection> findTblItemSelection(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblItemSelectionCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblItemSelection> findByCountTblItemSelection(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblItemSelection(List<TblItemSelection> tblItemSelections){
        super.updateAll(tblItemSelections);
    }

	/*@Override
	public void deleteAll(Collection<TblItemSelection> collection) {
		// TODO Auto-generated method stub
		
	}*/
}
