/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;


/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblRebateDetail;

public interface TblRebateDetailDao extends GenericDao<TblRebateDetail> {

    public void addTblRebateDetail(TblRebateDetail tblRebateDetail);

    public void deleteTblRebateDetail(TblRebateDetail tblRebateDetail);

    public void updateTblRebateDetail(TblRebateDetail tblRebateDetail);

    public List<TblRebateDetail> getAllTblRebateDetail();

    public List<TblRebateDetail> findTblRebateDetail(Object... values) throws Exception;

    public List<TblRebateDetail> findByCountTblRebateDetail(int firstResult, int maxResult, Object... values) throws Exception;

    public long getTblRebateDetailCount();

    public void saveUpdateAllTblRebateDetail(List<TblRebateDetail> tblRebateDetails);
}
