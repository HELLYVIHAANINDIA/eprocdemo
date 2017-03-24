package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderbidconfirmation;

public interface TblTenderBidConfirmationDao extends GenericDao<TblTenderbidconfirmation> {

    public void addTblTenderBidConfirmation(TblTenderbidconfirmation tblTenderBidConfirmation);

    public void deleteTblTenderBidConfirmation(TblTenderbidconfirmation tblTenderBidConfirmation);

    public void updateTblTenderBidConfirmation(TblTenderbidconfirmation tblTenderBidConfirmation);

    public List<TblTenderbidconfirmation> getAllTblTenderBidConfirmation();

    public List<TblTenderbidconfirmation> findTblTenderBidConfirmation(Object... values) throws Exception;

    public List<TblTenderbidconfirmation> findByCountTblTenderBidConfirmation(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderBidConfirmationCount();

    public void saveUpdateAllTblTenderBidConfirmation(List<TblTenderbidconfirmation> tblTenderBidConfirmations);
}