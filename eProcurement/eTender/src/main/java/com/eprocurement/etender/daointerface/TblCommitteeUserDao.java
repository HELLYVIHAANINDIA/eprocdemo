/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblCommitteeUser;

/**
 *
 */
public interface TblCommitteeUserDao extends GenericDao<TblCommitteeUser> {

    public void addTblCommitteeUser(TblCommitteeUser tblCommitteeUser);

    public void deleteTblCommitteeUser(TblCommitteeUser tblCommitteeUser);

    public void updateTblCommitteeUser(TblCommitteeUser tblCommitteeUser);

    public List<TblCommitteeUser> getAllTblCommitteeUser();

    public List<TblCommitteeUser> findTblCommitteeUser(Object... values) throws Exception;

    public List<TblCommitteeUser> findByCountTblCommitteeUser(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblCommitteeUserCount();

    public void saveUpdateAllTblCommitteeUser(List<TblCommitteeUser> tblCommitteeUsers);
}
