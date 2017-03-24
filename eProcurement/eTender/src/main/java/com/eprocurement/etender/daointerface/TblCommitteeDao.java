/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblCommittee;

/**
 *
 */
public interface TblCommitteeDao extends GenericDao<TblCommittee> {

    public void addTblCommittee(TblCommittee tblCommittee);

    public void deleteTblCommittee(TblCommittee tblCommittee);

    public void updateTblCommittee(TblCommittee tblCommittee);

    public List<TblCommittee> getAllTblCommittee();

    public List<TblCommittee> findTblCommittee(Object... values) throws Exception;

    public List<TblCommittee> findByCountTblCommittee(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblCommitteeCount();

    public void saveUpdateAllTblCommittee(List<TblCommittee> tblCommittees);
}
