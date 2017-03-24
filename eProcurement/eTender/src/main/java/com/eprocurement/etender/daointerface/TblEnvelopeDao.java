package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblEnvelope;

public interface TblEnvelopeDao extends GenericDao<TblEnvelope> {

    public void addTblEnvelope(TblEnvelope tblEnvelope);

    public void deleteTblEnvelope(TblEnvelope tblEnvelope);

    public void updateTblEnvelope(TblEnvelope tblEnvelope);

    public List<TblEnvelope> getAllTblEnvelope();

    public List<TblEnvelope> findTblEnvelope(Object... values) throws Exception;

    public List<TblEnvelope> findByCountTblEnvelope(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblEnvelopeCount();

    public void saveUpdateAllTblEnvelope(List<TblEnvelope> tblEnvelopes);
}