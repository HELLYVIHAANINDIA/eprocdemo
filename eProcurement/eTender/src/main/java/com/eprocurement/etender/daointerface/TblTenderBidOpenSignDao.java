package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderBidOpenSign;

public interface TblTenderBidOpenSignDao extends GenericDao<TblTenderBidOpenSign> {

    public void addTblTenderBidOpenSign(TblTenderBidOpenSign tblTenderBidOpenSign);

    public void deleteTblTenderBidOpenSign(TblTenderBidOpenSign tblTenderBidOpenSign);

    public void updateTblTenderBidOpenSign(TblTenderBidOpenSign tblTenderBidOpenSign);

    public List<TblTenderBidOpenSign> getAllTblTenderBidOpenSign();

    public List<TblTenderBidOpenSign> findTblTenderBidOpenSign(Object... values) throws Exception;

    public List<TblTenderBidOpenSign> findByCountTblTenderBidOpenSign(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderBidOpenSignCount();

    public void saveUpdateAllTblTenderBidOpenSign(List<TblTenderBidOpenSign> tblTenderBidOpenSigns);
}