package com.eprocurement.etender.daointerface;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTenderBidderMap;

public interface TblTenderBidderMapDao extends GenericDao<TblTenderBidderMap> {

    public void addTblTenderBidderMap(TblTenderBidderMap tblTenderBidderMap);

    public void deleteTblTenderBidderMap(TblTenderBidderMap tblTenderBidderMap);

    public void updateTblTenderBidderMap(TblTenderBidderMap tblTenderBidderMap);

    public List<TblTenderBidderMap> getAllTblTenderBidderMap();

    public List<TblTenderBidderMap> findTblTenderBidderMap(Object... values) throws Exception;

    public List<TblTenderBidderMap> findByCountTblTenderBidderMap(int firstResult, int maxResult, Object... values) throws Exception;

    public long getTblTenderBidderMapCount();

    public void saveUpdateAllTblTenderBidderMap(List<TblTenderBidderMap> tblTenderBidderMaps);
}