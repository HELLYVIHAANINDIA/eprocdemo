/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblBidderSectorMapping;

/**
 *
 */
public interface TblBidderSectorMappingDao extends GenericDao<TblBidderSectorMapping> {

    public void addTblBidderSectorMapping(TblBidderSectorMapping TblBidderSectorMapping);

    public void deleteTblBidderSectorMapping(TblBidderSectorMapping TblBidderSectorMapping);

    public void updateTblBidderSectorMapping(TblBidderSectorMapping TblBidderSectorMapping);

    public List<TblBidderSectorMapping> getAllTblBidderSectorMapping();

    public List<TblBidderSectorMapping> findTblBidderSectorMapping(Object... values) throws Exception;

    public List<TblBidderSectorMapping> findByCountTblBidderSectorMapping(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblBidderSectorMappingCount();

    public void saveUpdateAllTblBidderSectorMapping(List<TblBidderSectorMapping> TblBidderSectorMapping);
}
