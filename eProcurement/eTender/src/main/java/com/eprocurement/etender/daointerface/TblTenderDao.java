package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTender;
import java.util.List;

public interface TblTenderDao extends GenericDao<TblTender> {

    public void addTblTender(TblTender tblTender);

    public void deleteTblTender(TblTender tblTender);

    public void updateTblTender(TblTender tblTender);

    public List<TblTender> getAllTblTender();

    public List<TblTender> findTblTender(Object... values) throws Exception;

    public List<TblTender> findByCountTblTender(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderCount();

    public void saveUpdateAllTblTender(List<TblTender> tblTenders);
}
