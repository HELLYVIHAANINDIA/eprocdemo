/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.daointerface;

import com.eprocurement.common.daogeneric.GenericDao;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderDocument;
import java.util.List;

/**
 *
 * @author BigGoal
 */

public interface TblTenderDocumentDao extends GenericDao<TblTenderDocument> {

     public void addTblTenderDocument(TblTenderDocument tblTenderDocument);

    public void deleteTblTenderDocument(TblTenderDocument tblTenderDocument);

    public void updateTblTenderDocument(TblTenderDocument tblTenderDocument);

    public List<TblTenderDocument> getAllTblTenderDocument();

    public List<TblTenderDocument> findTblTenderDocument(Object... values) throws Exception;

    public List<TblTenderDocument> findByCountTblTenderDocument(int firstResult,int maxResult,Object... values) throws Exception;

    public long getTblTenderDocumentCount();

    public void saveUpdateAllTblTenderDocument(List<TblTenderDocument> tblTendersDocuments);

}
