package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblCommitteeEnvelope;

public interface TblCommitteeEnvelopeDao extends GenericDao<TblCommitteeEnvelope> {

    public void addTblCommitteeEnvelope(TblCommitteeEnvelope tblCommitteeEnvelope);

    public void deleteTblCommitteeEnvelope(TblCommitteeEnvelope tblCommitteeEnvelope);

    public void updateTblCommitteeEnvelope(TblCommitteeEnvelope tblCommitteeEnvelope);

    public List<TblCommitteeEnvelope> getAllTblCommitteeEnvelope();

    public List<TblCommitteeEnvelope> findTblCommitteeEnvelope(Object... values) throws Exception;

    public List<TblCommitteeEnvelope> findByCountTblCommitteeEnvelope(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblCommitteeEnvelopeCount();

    public void saveUpdateAllTblCommitteeEnvelope(List<TblCommitteeEnvelope> tblCommitteeEnvelopes);
}