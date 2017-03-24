/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.common.daointerface;

import java.util.List;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.common.model.TblMailMessage;

/**
 *
 */
public interface TblMailMessageDao extends GenericDao<TblMailMessage> {

    public void addTblMailMessage(TblMailMessage TblMailMessage);

    public void deleteTblMailMessage(TblMailMessage TblMailMessage);

    public void updateTblMailMessage(TblMailMessage TblMailMessage);

    public List<TblMailMessage> getAllTblMailMessage();

    public List<TblMailMessage> findTblMailMessage(Object... values) throws Exception;

    public List<TblMailMessage> findByCountTblMailMessage(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblMailMessageCount();

    public void saveUpdateAllTblMailMessage(List<TblMailMessage> TblMailMessage);
}
