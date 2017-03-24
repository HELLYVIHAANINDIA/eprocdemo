/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.daointerface.TblBidderDocumentDao;
import com.eprocurement.common.daointerface.TblOfficerDocumentDao;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.etender.model.TblBidderdocument;
import com.eprocurement.etender.model.TblOfficerdocument;

@Service
public class DocumentService {

	@Autowired
	TblOfficerDocumentDao tblOfficerDocumentDao;
	@Autowired
	HibernateQueryDao hibernateQueryDao;
	@Autowired
	TblBidderDocumentDao tblBidderDocumentDao;
	@Autowired
	CommonDAO commonDAO;
	
	/**
     * to add bidder document
     * @param tblBidderDocument
     * @return boolean
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addOfficerDocument(TblOfficerdocument tblOfficerDocument) throws Exception{
    	boolean bSuccess = false;             
        tblOfficerDocumentDao.addTblOfficerdocument(tblOfficerDocument);
        bSuccess=true;
        return bSuccess;
    }
    
    /**
     * 
     * @param tblBidderDocument
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBidderDocument(TblBidderdocument tblBidderDocument) throws Exception{
    	boolean bSuccess = false;             
        tblBidderDocumentDao.addTblBidderdocument(tblBidderDocument);
        bSuccess=true;
        return bSuccess;
    }
    
    
    /**
     * to get bidder folder
     * @param userId
     * @return {@code List<Object[]>}
     * @throws Exception 
     */
    @Transactional
    public List<Object[]> getOfficerDocuments(int tenderId,int objectId,int childId,int subChildId,int otherSubChildId,int userType,int bidderId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        var.put("objectId",objectId);
        var.put("childId",childId);
        var.put("subChildId",subChildId);
        var.put("otherSubChildId",otherSubChildId);
        StringBuilder query=null;
        if(userType==1) {
        	query = new StringBuilder("select tblOfficerdocument.officerDocId,tblOfficerdocument.fileName,tblOfficerdocument.description,tblOfficerdocument.fileType,tblOfficerdocument.cstatus,tblOfficerdocument.createdOn,tblOfficerdocument.fileSize,'' from TblOfficerdocument tblOfficerdocument where ");
            query.append(" tblOfficerdocument.tenderId=:tenderId and tblOfficerdocument.objectId=:objectId and tblOfficerdocument.childId=:childId and tblOfficerdocument.subChildId=:subChildId and tblOfficerdocument.otherSubChildId=:otherSubChildId order by createdOn desc ");
        }else if (userType==2) {
        	query = new StringBuilder("select tblBidderdocument.bidderDocId,tblBidderdocument.fileName,tblBidderdocument.description,tblBidderdocument.fileType,tblBidderdocument.cstatus,tblBidderdocument.createdOn,tblBidderdocument.fileSize,tblBidderdocument.mandatoryDocName from TblBidderdocument tblBidderdocument where ");
            query.append(" tblBidderdocument.tenderId=:tenderId and tblBidderdocument.objectId=:objectId and tblBidderdocument.childId=:childId and tblBidderdocument.subChildId=:subChildId and tblBidderdocument.otherSubChildId=:otherSubChildId ");
            if(bidderId!=0){
            	var.put("bidderId",bidderId);
            	query.append(" and tblBidderdocument.bidderId=:bidderId");
            }
            query.append(" order by createdOn desc  ");
        }
        return hibernateQueryDao.createNewQuery(query.toString(),var);        
    }
    
    
    /**
     * to get bidder doc details based on the doc id
     * @param docId
     * @return
     * @throws Exception 
     */
    @Transactional
    public List<Object[]> getOfficerDocument(int docId,int userType) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("docId",docId);
        if(userType==1) {
        	return hibernateQueryDao.createNewQuery("select tblOfficerdocument.fileName, tblOfficerdocument.path from TblOfficerdocument tblOfficerdocument where tblOfficerdocument.officerDocId=:docId order by createdOn desc ",var);
        }else if(userType==2 || userType==0) {
        	return hibernateQueryDao.createNewQuery("select tblBidderdocument.fileName, tblBidderdocument.path from TblBidderdocument tblBidderdocument where tblBidderdocument.bidderDocId=:docId order by createdOn desc  ",var);
        }
        return null;        
    }
    

    /**
     * to change the status of the bidder documents
     * @param docId
     * @param cStatusDoc
     * @return
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean cancelOfficerDocStatus(String docId,int cStatusDoc) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("docId", docId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblOfficerdocument set cstatus=2 where officerDocId in (:docId)",var);
        return cnt!=0;

    }
    
    /**
     * to change the status of the bidder documents
     * @param docId
     * @param cStatusDoc
     * @return
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean updateOfficerDocStatus(String docId,int cStatusDoc,int userType) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("docId", docId);
        if(userType==1) {
        	cnt = hibernateQueryDao.updateDeleteNewQuery("delete from TblOfficerdocument where officerDocId in (:docId)",var);
        }else if(userType==2) {
        	cnt = hibernateQueryDao.updateDeleteNewQuery("delete from TblBidderdocument where bidderDocId in (:docId)",var);
        }
        return cnt!=0;
    }
    
    
    /**
	 * 
	 * @param tenderId
	 * @return
	 * @throws Exception
	 */
	public List<Object[]> getTenderDocumentById(int documentId) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("documentId", documentId);
		String query = "select tblTenderDocument.documentId,tblTenderDocument.documentName from TblTenderDocument tblTenderDocument where tblTenderDocument.documentId=:documentId";
        List<Object[]> lst = commonDAO.executeSelect(query, parameters);
        return lst;
	}
	
    /**
     * to delete the file physically
     * @param filePath
     * @return boolean
     */
    public boolean changeDirectoryName(String dirPath,String newFolderName) {
        boolean flg = false;
        try {
        	File dir = new File(dirPath);
    		if (dir.isDirectory()) {
    			System.err.println("There is no directory @ given path");
	    		File newDir = new File(dir.getParent() + File.separator + newFolderName);
	    		dir.renameTo(newDir);
    		}
        } catch (Exception ex) {
        	ex.printStackTrace();
        }
        return flg;
    }

}                
