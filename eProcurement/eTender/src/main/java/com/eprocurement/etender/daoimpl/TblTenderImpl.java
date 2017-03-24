package com.eprocurement.etender.daoimpl;

/**
 *
 * @author branpariya
 */
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eprocurement.common.daogeneric.HibernateAbstractClass;
import com.eprocurement.etender.daointerface.TblTenderDao;
import com.eprocurement.etender.model.TblTender;

/**
 *
 */
@Repository
public class TblTenderImpl extends HibernateAbstractClass<TblTender> implements TblTenderDao {

    @Autowired
    @Qualifier("sessionFactory")
    public void init(SessionFactory sessionFactory) {
        setSessionFactory(sessionFactory);
    }

    @Override
    public void addTblTender(TblTender tblTender){
        super.addEntity(tblTender);
    }

    @Override
    public void deleteTblTender(TblTender tblTender) {
        super.deleteEntity(tblTender);
    }

    @Override
    public void updateTblTender(TblTender tblTender) {
        super.updateEntity(tblTender);
    }

    @Override
    public List<TblTender> getAllTblTender() {
        return super.getAllEntity();
    }

    @Override
    public List<TblTender> findTblTender(Object... values) throws Exception {
        return super.findEntity(values);
    }

    @Override
    public long getTblTenderCount() {
        return super.getEntityCount();
    }

    @Override
    public List<TblTender> findByCountTblTender(int firstResult, int maxResult, Object... values) throws Exception {
        return super.findByCountEntity(firstResult, maxResult, values);
    }

    @Override
    public void saveUpdateAllTblTender(List<TblTender> tblTenders){
        super.updateAll(tblTenders);
    }
}


