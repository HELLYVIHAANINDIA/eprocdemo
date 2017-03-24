package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderEnvelope;

public interface TblTenderEnvelopeDao extends GenericDao<TblTenderEnvelope> {

    public void addTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope);

    public void deleteTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope);

    public void updateTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope);

    public List<TblTenderEnvelope> getAllTblTenderEnvelope();

    public List<TblTenderEnvelope> findTblTenderEnvelope(Object... values) throws Exception;

    public List<TblTenderEnvelope> findByCountTblTenderEnvelope(int firstResult, int maxResult, Object... values) throws Exception;

    public long getTblTenderEnvelopeCount();

    public void saveUpdateAllTblTenderEnvelope(List<TblTenderEnvelope> tblTenderEnvelopes);
}