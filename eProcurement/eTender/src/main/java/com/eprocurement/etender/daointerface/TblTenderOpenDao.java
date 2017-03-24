/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;
import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderopen;

public interface TblTenderOpenDao extends GenericDao<TblTenderopen> {

    public void addTblTenderOpen(TblTenderopen tblTenderOpen);

    public void deleteTblTenderOpen(TblTenderopen tblTenderOpen);

    public void updateTblTenderOpen(TblTenderopen tblTenderOpen);

    public List<TblTenderopen> getAllTblTenderOpen();

    public List<TblTenderopen> findTblTenderOpen(Object... values) throws Exception;

    public List<TblTenderopen> findByCountTblTenderOpen(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderOpenCount();

    public void saveUpdateAllTblTenderOpen(List<TblTenderopen> tblTenderOpens);
}