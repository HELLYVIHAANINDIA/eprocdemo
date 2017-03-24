/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidderdocument;

/**
 *
 */
public interface TblBidderDocumentDao extends GenericDao<TblBidderdocument> {

    public void addTblBidderdocument(TblBidderdocument TblBidderdocument);

    public void deleteTblBidderdocument(TblBidderdocument TblBidderdocument);

    public void updateTblBidderdocument(TblBidderdocument TblBidderdocument);

    public List<TblBidderdocument> getAllTblBidderdocument();

    public List<TblBidderdocument> findTblBidderdocument(Object... values) throws Exception;

    public List<TblBidderdocument> findByCountTblBidderdocument(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidderdocumentCount();

    public void saveUpdateAllTblBidderdocument(List<TblBidderdocument> TblBidderdocument);
}
