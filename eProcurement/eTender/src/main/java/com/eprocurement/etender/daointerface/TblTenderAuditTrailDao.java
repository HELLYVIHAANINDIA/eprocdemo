package com.eprocurement.etender.daointerface;

/**
 *
 * @author branpariya
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderAuditTrail;
import java.util.List;

public interface TblTenderAuditTrailDao extends GenericDao<TblTenderAuditTrail> {

    public void addTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail);

    public void deleteTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail);

    public void updateTblTenderAuditTrail(TblTenderAuditTrail tblTenderAuditTrail);

    public List<TblTenderAuditTrail> getAllTblTenderAuditTrail();

    public List<TblTenderAuditTrail> findTblTenderAuditTrail(Object... values) throws Exception;

    public List<TblTenderAuditTrail> findByCountTblTenderAuditTrail(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderAuditTrailCount();

    public void saveUpdateAllTblTenderAuditTrail(List<TblTenderAuditTrail> tblTenderAuditTrails);
}
