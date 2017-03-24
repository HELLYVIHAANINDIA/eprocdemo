/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.EncrptDecryptUtils;
import com.eprocurement.etender.daointerface.TblBidDetailDao;
import com.eprocurement.etender.daointerface.TblShareReportDao;
import com.eprocurement.etender.daointerface.TblShareReportDetailDao;
import com.eprocurement.etender.daointerface.TblTenderBidDetailDao;
import com.eprocurement.etender.daointerface.TblTenderCellGrandTotalDao;
import com.eprocurement.etender.model.TblBidDetail;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblShareReport;
import com.eprocurement.etender.model.TblShareReportDetail;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderBidDetail;
import com.eprocurement.etender.model.TblTenderBidMatrix;
import com.eprocurement.etender.model.TblTenderCell;
import com.eprocurement.etender.model.TblTenderCellGrandTotal;
import com.eprocurement.etender.model.TblTenderColumn;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderTable;
import com.eprocurement.etender.model.TblTenderopen;

@Service
public class ReportService {
   
    @Autowired
    HibernateQueryDao hibernateQueryDao;
    @Autowired
    TblShareReportDao tblShareReportDao;
    @Autowired
    TenderCommonService tenderCommonService;
    @Autowired
    CommonService commonService;
    @Autowired
    TblTenderBidDetailDao  tblTenderBidDetailDao;
    @Autowired
    TenderService tenderFormService;
    @Autowired
    TblTenderCellGrandTotalDao tblTenderCellGrandTotalDao;
    @Autowired
    CommonDAO commonDAO;
    @Autowired
    EncrptDecryptUtils encrptDecryptUtils;
    @Autowired
    TblBidDetailDao tblBidDetailDao;
    @Autowired
    TblShareReportDetailDao tblShareReportDetailDao;
    
    
    /**
     * Use case: Result sharing for opening / Evaluation process
     * Used to get form details by shareReportId
     * @param shareReportId
     * @return {@codeList<Object[]>}
     * @throws Exception 
     */
    @Transactional
    public List<Object[]> getShareReportDetailsByReportId(int shareReportId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("shareReportId",shareReportId);
        list = hibernateQueryDao.createNewQuery("select tblsharereportdetail.shareIndividualReport, tblsharereportdetail.shareComparativeReport, tblsharereportdetail.shareDocument, tblsharereportdetail.shareReportDetailId, tblsharereportdetail.tblTenderForm.formId from TblShareReportDetail tblsharereportdetail where tblsharereportdetail.tblShareReport.shareReportId=:shareReportId order by tblsharereportdetail.tblTenderForm.formId ",var);                
        return list;        
    }
    
    /**
     * Use case: Result sharing for opening / Evaluation process
     * @param reportId
     * @return boolean
     * @throws Exception 
     */
    public boolean deActivateShareReport(int shareReportId) throws Exception{
        int cnt = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("shareReportId",shareReportId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblShareReport set isActive=0 where shareReportId=:shareReportId",var);        
        return cnt!=0;
    }
    
    /**
     * Use case: Result sharing for opening / Evaluation process
     * @param tenderId
     * @return {@codeList<Object[]>}
     * @throws Exception 
     */
    @Transactional
    public List<Object[]> getShareReports(int tenderId) throws Exception{
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append(" select tblsharereport.shareReport, tblsharereport.showResultBeforeLogin, tblsharereport.showL1Report, tblsharereport.showAbstractReport, tblsharereport.shareBidderStatus, tblsharereport.shareClarificationReport, tblsharereport.shareEvaluationReport, tblsharereport.shareReportId,tblsharereport.createdBy from TblShareReport tblsharereport where tblsharereport.tblTender.tenderId=:tenderId and tblsharereport.isActive=1 ");
        return hibernateQueryDao.createNewQuery(query.toString(),var);                
    }
    
    /**
     * Use case: Result sharing for opening / Evaluation process
     * @param tblShareReport
     * @param tblShareReportDetails
     * @param isForOpening
     * @return boolean
     * @throws Exception 
     */
    
    /**
     * Use case : Result Sharing of Opening Process
     * @return
     * @throws Exception 
     */
    public  List<String> getChartList() throws Exception{
        List<String> criteriaList = new ArrayList<String>();
        criteriaList.add("Individual");
        criteriaList.add("Comparative");
//        criteriaList.add("L1 Report");
//        criteriaList.add(new SelectItem(messageSource.getMessage("field_sup_doc",  null, LocaleContextHolder.getLocale()),3));
        return criteriaList;        
    }
    
    public  List<String> getReportstWith() throws Exception{
        List<String> criteriaList = new ArrayList<String>();
        criteriaList.add("All Bidders");
        criteriaList.add("Qualified Bidders");
//        criteriaList.add(new SelectItem(messageSource.getMessage("field_sup_doc",  null, LocaleContextHolder.getLocale()),3));
        return criteriaList;        
    }
    
    /**
     * Use case : Result Sharing of Opening Process
     * @param tenderId
     * @return
     * @throws Exception 
     */
    @Transactional
    public List<Object[]> getTenderFormForResultShare(int tenderId) throws Exception{
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append(" SELECT tbltenderform.formId,tbltenderform.formName,tbltenderform.tblTenderEnvelope.envelopeId, tbltenderform.sortOrder");
        query.append(" from TblTenderForm tbltenderform where tbltenderform.tblTender.tenderId=:tenderId and tbltenderform.cstatus=1 order by tbltenderform.formId");
        list = hibernateQueryDao.createNewQuery(query.toString(),var);                
        return list;        
    }
   
    
    @Transactional
    public Map<String, List<Object[]>> getL1H1ReportDetail(int tenderId,int biddingVariant,int isRebateApplicable,int isItemwiseWinner,int formId) throws Exception{
    	return spTenderReport(tenderId,formId,1,biddingVariant,isRebateApplicable,isItemwiseWinner);
    }
    
    @Transactional
	private Map<String, List<Object[]>> spTenderReport(int tenderId, int formId, int reportTypeId,int biddingVariant,int isRebateApplicable,int isItemwiseWinner) throws Exception {
		Map<String, List<Object[]>> map = new HashMap<String, List<Object[]>>();
		
		if(isItemwiseWinner==1){
			/* Getting TenderTable Details - Item wise*/
			List<Object[]> tableList = tenderFormService.getTenderTableById(formId);
			if(tableList!=null && !tableList.isEmpty()){
				map.put("#result-set-2", tableList);
			}
			List<Object> tables = new ArrayList<Object>() ;
			for (Object[] objects : tableList) {
				tables.add(objects[0]);
			}
			/* Get bidder's bid value */
			List<Object[]> bidList = getItemWiseBidValue(tenderId);
			if(bidList!=null && !bidList.isEmpty()){
				map.put("#result-set-3", bidList);
			}
			
			/* Get bidder's value for rank*/
			List<Object[]> cellList = getItemWiseRank(tables);
			if(cellList!=null && !cellList.isEmpty()){
				//map.put("#result-set-4", cellList);
				Map<String,String> pMap = new HashMap<String,String>();
				//TTCE.cellValue,TTCE.rowId,TCC.tableid,TCC.columnHeader
				for(Object[] obj : cellList){
					if(pMap.containsKey(obj[1]+"_"+obj[2])){
						String val = pMap.get(obj[1]+"_"+obj[2]);
						val += ", "+obj[3]+"("+obj[0]+")";
						pMap.put(obj[1]+"_"+obj[2], val);
					}else{
						pMap.put(obj[1]+"_"+obj[2], obj[3]+"("+obj[0]+")");
					}
				}
				List<Object[]> obj = new ArrayList<Object[]>();
				for(Map.Entry<String, String> entiry : pMap.entrySet()){
					Object[] o = new Object[3];
					String val = entiry.getKey();
					 val.split("_");
					o[0] = entiry.getValue();
					o[1] = Integer.parseInt(val.split("_")[0]);
					o[2] = Integer.parseInt(val.split("_")[1]);
					obj.add(o);	
 				}
				map.put("#result-set-4", obj);
			}
		}else{
			/* Get bidder's total value in order of their rank- Grand Total */
			List<Object[]> rankList = getGTWiseRank(tenderId,biddingVariant,isRebateApplicable);
			if(rankList!=null && !rankList.isEmpty()){
				map.put("#result-set-1", rankList);
			}
		}
		
		return map;
	}
    @Transactional
    private List<Object[]> getItemWiseRank(List<Object> tables) {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tables",tables);
        StringBuilder query = new StringBuilder();
        query.append(" select TTCE.cellValue,TTCE.rowId,TCC.tableid,TCC.columnHeader");
        query.append(" from tbl_tendercolumn TCC");
        query.append(" inner join tbl_tendercell TTCE on TCC.columnid = TTCE.columnid");
        query.append(" where TCC.tableid in (:tables) and filledBy = 1");
        query.append(" order by TCC.tableid,TTCE.rowId;");
        return hibernateQueryDao.createSQLQuery(query.toString(), var);
    }

	@Transactional
    private List<Object[]> getItemWiseBidValue(int tenderId) {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append(" select cast(TBD.cellValue as decimal(10,2)) as cellVal,TCM.companyName,TTCE.rowid,FS.bidderid");
        query.append(" from tbl_biddetail TBD");
        query.append(" inner join tbl_tenderform TTF on TBD.formid = TTF.formid");
        query.append(" INNER JOIN tbl_finalsubmission FS ON FS.tenderId = TTF.tenderId AND TBD.companyId = FS.companyId");
        query.append(" inner join tbl_bidderapprovaldetail TBAD ON TBAD.finalsubmissionId = FS.finalsubmissionid AND TBAD.isapproved =1");
        query.append(" inner join tbl_company TCM on TCM.companyID = FS.companyId");
        query.append(" inner join tbl_tendergovcolumn TTGC on TTGC.formid = TBD.formid ");
        query.append(" inner join tbl_tendercolumn TTC on TTC.columnid = TTGC.columnid");
        query.append(" inner join tbl_tendercell TTCE on TTCE.columnid = TTC.columnid AND TTCE.cellID = TBD.cellId");
        query.append(" inner join tbl_bidderitems TBI on TBI.formId = TTF.formid  AND TBI.companyId = FS.companyId AND TBI.rowId = TTCE.rowId AND TBI.isapproved = 1");
        query.append(" where TTF.tenderid =:tenderId and TTF.ispricebid = 1 and TTF.cstatus = 1");
        query.append(" group by FS.companyId,TTCE.rowId");
        query.append("  order by TTCE.rowId,cellVal");
        return hibernateQueryDao.createSQLQuery(query.toString(), var);
	}

	@Transactional
    private List<Object[]> getGTWiseRank(int tenderId,int biddingVariant,int isRebateApplicable) throws Exception {
    	Map<String, Object> var = new HashMap<String, Object>();
    	
    	int envelopeId = tenderFormService.getLastEnvelopeId(tenderId);
        var.put("tenderId",tenderId);
        var.put("envelopeId",envelopeId);
        
        StringBuilder query = new StringBuilder();
        query.append(" select SUM(cast(GT.GTValue as decimal(10,2))) as GTValue,FS.companyId,FS.bidderid,TCM.companyName ");
        if(isRebateApplicable == 1){
        	query.append(" ,cast(TR.rebateValue as decimal(10,2)) finalAmt");
	        /*if(biddingVariant == 1){
	        	query.append(" ,(((GT.GTValue*TR.rebateValue) /100) - GT.GTValue) as finalAmt");
	        }else{
	        	query.append(" ,(GT.GTValue + ((GT.GTValue*TR.rebateValue) /100)) as finalAmt");
	        }*/
        }
        
        query.append(" from tbl_tendercellgrandtotal GT ");
        query.append(" inner join tbl_tendercolumn TC on GT.columnId = TC.columnID");
        query.append(" INNER JOIN tbl_finalsubmission FS ON FS.tenderId = GT.tenderId AND GT.bidderId = FS.bidderId");
        query.append(" inner join tbl_company TCM on TCM.companyID = FS.companyId");
        query.append(" inner join tbl_bidderapprovaldetail TBAD on TBAD.tenderId=FS.tenderId AND FS.bidderid=TBAD.bidderId AND TBAD.envelopeId=:envelopeId AND TBAD.isApproved=1");
        if(isRebateApplicable == 1){        	
        	query.append(" inner join tbl_tenderrebate TR on TR.tenderid = FS.tenderid and TR.companyId = TCM.companyId");
        }
        query.append(" where FS.tenderid =:tenderId and TC.ispricesummary = 1 group by GT.bidderId");
        if(biddingVariant == 1){
        	if(isRebateApplicable == 1){     
        		query.append(" order by finalAmt asc");
        	}else{
        		query.append(" order by GTValue asc");
        	}
        
        }else{
        	if(isRebateApplicable == 1){  
        		query.append(" order by finalAmt desc");
        	}else{
        		query.append(" order by GTValue desc");
        	}
        	
        }
        
        return hibernateQueryDao.createSQLQuery(query.toString(), var);
	}

	@Transactional
	private List<Object[]> getFormWiseGT(int tenderId) throws Exception {
    	Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append(" select Fs.companyId,FS.bidderId,GT.formId,GT.GTValue from tbl_tendercellgrandtotal GT");
        query.append(" inner join tbl_finalsubmission FS on FS.tenderid = GT.tenderId");
        query.append("where FS.tenderid =:tenderId and FS.isactive =1 AND FS.bidderId=GT.bidderId");
        return hibernateQueryDao.createSQLQuery(query.toString(), var);
    }
    
    
	/**
     * Method use for get Individual Report Detail from Store procedure.
     * @param tenderId
     * @param envelopId
     * @param formId
     * @return {@code<Map<String, Object>>}
     */
    @Transactional
    public Map<String,List<Object[]>> getIndividualReportDetail(int tenderId, int envelopId, int formId) throws Exception
    {
        return sPTenderOpeningReport(tenderId, envelopId, 0, 0,formId, 1);
    }  
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public boolean vefifyNdecryptBid(int tenderId,int formId) throws Exception{
    	int cnt = 0;
    	boolean bSucess = false;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId",formId);
        cnt = hibernateQueryDao.updateDeleteNewQuery("update TblTenderopen set decryptionlevel=1 where tblTenderform.formId=:formId",var);        
        bSucess =  cnt!=0;
        
        TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
        
       if(bSucess){
        	bSucess = decryptTblBidDetail(formId,tblTender.getRandPass().substring(0, 16).getBytes());
        }
        if(bSucess){
        	bSucess = decryptTblTenderBidDetail(formId,tblTender.getRandPass().substring(0, 16).getBytes());
        }
        
        if(bSucess){
        	bSucess = decryptTblTenderCellGrandTotal(formId,tblTender.getRandPass().substring(0, 16).getBytes());
        }
		return bSucess;
	}
    @Transactional
    private List<TblBidDetail> getTblBidDetail(int formId,byte[] key) throws Exception{
    	List<Object[]> list = null;
    	 Map<String, Object> var = new HashMap<String, Object>();
         var.put("formId",formId);
         StringBuffer query = new StringBuffer("SELECT tblBidDetail.bidDetailId,tblBidDetail.cellId,tblBidDetail.cellValue,tblBidDetail.tblCompany.companyid,tblBidDetail.tblTenderForm.formId");
         query.append(" FROM  TblBidDetail tblBidDetail");
         query.append(" WHERE tblBidDetail.tblTenderForm.formId=:formId");
         list = hibernateQueryDao.createNewQuery(query.toString(),var);
         
	   	 List<TblBidDetail> newlist = new ArrayList<TblBidDetail>();
	     for (Object[] obj : list) {
	    	 TblBidDetail tblBidDetail = new TblBidDetail();
	    	 tblBidDetail.setBidDetailId(Integer.parseInt(obj[0].toString()));
	    	 tblBidDetail.setCellId(Integer.parseInt(obj[1].toString()));
	    	 tblBidDetail.setCellValue(encrptDecryptUtils.decrypt(obj[2].toString(),key));
	    	 tblBidDetail.setTblCompany(new TblCompany(Integer.parseInt(obj[3].toString())));
	    	 tblBidDetail.setTblTenderForm(new TblTenderForm(Integer.parseInt(obj[4].toString())));
	    	 newlist.add(tblBidDetail);
	     }
	     return newlist;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
     private boolean decryptTblBidDetail(int formId,byte[] key) throws Exception {
    	 boolean bSucess = false;
         tblBidDetailDao.updateAllTblBidDetail(getTblBidDetail(formId,key));
         bSucess = true;
    	 return bSucess;
		
	}
    @Transactional
    private List<TblTenderBidDetail> getTblTenderBidDetail(int formId,byte[] key) throws Exception{

    	List<Object[]> tblTenderBidDetailList = null;
    	 Map<String, Object> var = new HashMap<String, Object>();
         var.put("formId",formId);
         StringBuffer query = new StringBuffer("SELECT tblTenderBidDetail.biddetailid,tblTenderBidDetail.cellno,tblTenderBidDetail.cellvalue,tblTenderBidDetail.tblTendercell.cellId,tblTenderBidDetail.tblTenderbidmatrix.bidtableid");
         query.append(" FROM  TblTenderBidMatrix tblTenderBidMatrix,TblTenderTable tblTenderTable,TblTenderBidDetail tblTenderBidDetail");
         query.append(" WHERE tblTenderBidMatrix.tblTendertable.tableId = tblTenderTable.tableId");
         query.append(" AND tblTenderBidDetail.tblTenderbidmatrix.bidtableid=tblTenderBidMatrix.bidtableid");
         query.append(" AND tblTenderTable.formId=:formId");
         tblTenderBidDetailList = hibernateQueryDao.createNewQuery(query.toString(),var);
         
         tblTenderBidDetailList = hibernateQueryDao.createNewQuery(query.toString(),var);
         List<TblTenderBidDetail> tblTenderBidDetails = new ArrayList<TblTenderBidDetail>();
         if(tblTenderBidDetailList != null && !tblTenderBidDetailList.isEmpty()){
        	for(Object[] obj : tblTenderBidDetailList){
        		TblTenderBidDetail tblTenderBidDetail = new TblTenderBidDetail();
        		tblTenderBidDetail.setBiddetailid(Integer.parseInt(obj[0].toString()));
        		tblTenderBidDetail.setCellno(Integer.parseInt(obj[1].toString()));
        		tblTenderBidDetail.setCellvalue(encrptDecryptUtils.decrypt(obj[2].toString(),key));
        		tblTenderBidDetail.setTblTendercell(new TblTenderCell(Integer.parseInt(obj[3].toString())));
        		tblTenderBidDetail.setTblTenderbidmatrix(new TblTenderBidMatrix(Integer.parseInt(obj[4].toString())));
        		tblTenderBidDetails.add(tblTenderBidDetail);
        	}
         }
         return tblTenderBidDetails;
    
    }
     @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
     private boolean decryptTblTenderBidDetail(int formId,byte[] key) throws Exception {
    	 boolean bSucess = false;
    	 tblTenderBidDetailDao.updateAllTblTenderBidDetail(getTblTenderBidDetail(formId,key));
    	 bSucess = true;
    	 return bSucess;
	}
     @Transactional
     private List<TblTenderCellGrandTotal> getTblTenderCellGrandTotal(int formId,byte[] key,boolean bool) throws Exception{
    	 List<Object[]> list = null;
         Map<String, Object> var = new HashMap<String, Object>();
         var.put("formId",formId);
         StringBuffer query = new StringBuffer("SELECT tblTenderCellGrandTotal.cellGrandTotalId,tblTenderCellGrandTotal.tblTenderTable.tableId,tblTenderCellGrandTotal.tblTenderForm.formId,tblTenderCellGrandTotal.tblTender.tenderId,tblTenderCellGrandTotal.tblTenderColumn.columnId,tblTenderCellGrandTotal.tblBidder.bidderId,tblTenderCellGrandTotal.GTValue");
         query.append(" FROM  TblTenderCellGrandTotal tblTenderCellGrandTotal");
         query.append(" WHERE tblTenderCellGrandTotal.tblTenderForm.formId=:formId");
         list = hibernateQueryDao.createNewQuery(query.toString(),var);
         
         List<TblTenderCellGrandTotal> newlist = new ArrayList<TblTenderCellGrandTotal>();
         for (Object[] obj : list) {
         	TblTenderCellGrandTotal tenderCellGrandTotal = new TblTenderCellGrandTotal();
         	tenderCellGrandTotal.setCellGrandTotalId(Integer.parseInt(obj[0].toString()));
         	tenderCellGrandTotal.setTblTenderTable(new TblTenderTable(Integer.parseInt(obj[1].toString())));
         	tenderCellGrandTotal.setTblTenderForm(new TblTenderForm(Integer.parseInt(obj[2].toString())));
         	tenderCellGrandTotal.setTblTender(new TblTender(Integer.parseInt(obj[3].toString())));
         	tenderCellGrandTotal.setTblTenderColumn(new TblTenderColumn(Integer.parseInt(obj[4].toString())));
         	tenderCellGrandTotal.setTblBidder(new TblBidder(Integer.parseInt(obj[5].toString())));
         	if(bool){
         		tenderCellGrandTotal.setGTValue(encrptDecryptUtils.decrypt(obj[6].toString(),key));
         	}else{
         		tenderCellGrandTotal.setGTValue(obj[6].toString());
         	}
         	newlist.add(tenderCellGrandTotal);
 		}
         return newlist;
     }
     @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
     private boolean decryptTblTenderCellGrandTotal(int formId,byte[] key) throws Exception {
    	boolean bSucess = false;
        tblTenderCellGrandTotalDao.updateAllTblTenderCellGrandTotal(getTblTenderCellGrandTotal(formId,key,true));
        bSucess  = true;
    	return bSucess;
		
	}


	/**
     * Method use for get Comparative Report Detail from Store procedure.
     * @param tenderId
     * @param envelopId
     * @param formId
     * @return {@code<Map<String, Object>>}
     */
    @Transactional
    public Map<String,List<Object[]>> getComparativeReportDetail(int tenderId, int envelopId, int formId) throws Exception
    {
        return sPTenderOpeningReport(tenderId, envelopId, 0,0, formId, 2);
    }
    
    /**
     * Method use for get Bidder wise abstract Report Detail from Store procedure.
     * @param tenderId
     * @param envelopId
     * @param formId
     * @param consortiumId
     * @return {@code<Map<String, Object>>}
     */
    @Transactional
    public Map<String,List<Object[]>> getBidderWiseReportDetail(int tenderId, int envelopId, int bidderId, int consortiumId) throws Exception
    {
        return sPTenderOpeningReport(tenderId, envelopId, bidderId, consortiumId,0, 3);
    }
    @Transactional
	private Map<String, List<Object[]>> sPTenderOpeningReport(int tenderId,	int envelopId, int bidderId, int consortiumId, int formId, int reportTypeId) throws Exception {
		TblTenderEnvelope tblTenderEnvelope = tenderCommonService.getTenderEnvelopeById(envelopId);
		int envelopeSortOrder = tblTenderEnvelope.getSortOrder();
		int previousEnvelopeId = 0;
		if(envelopeSortOrder > 1){
			previousEnvelopeId = getTenderEnvelopeBySortOrder(envelopeSortOrder-1,tenderId).getEnvelopeId();
		}
		List<Object> bidderIds = null; 
		if(bidderId!=0){
			bidderIds = new ArrayList<Object>();
			bidderIds.add( String.valueOf(bidderId));
		}
		
		Map<String, List<Object[]>> map = new HashMap<String, List<Object[]>>();
		/* Getting Tender Details */	
		TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
		/* Getting TenderForm Details */
		List<Object[]> formList = getTenderFormList(tenderId,envelopId,formId,bidderId,consortiumId,tblTender.getAutoResultSharing());
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-1", formList);
		}
		/* Getting TenderTable Details */
		List<Object[]> tableList = getTenderTableList(tenderId,envelopId,formId,bidderId,consortiumId);
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-2", tableList);
		}
		/* Getting TenderColumn Details */
		List<Object[]> columnList = getTenderColumnList(tenderId,envelopId,formId,bidderId,consortiumId);
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-3", columnList);
		}
		
		/* Getting TenderCell Details which filled by is officer*/
		List<Object[]> cellList = getTenderCellList(tenderId,envelopId,formId,bidderId,consortiumId,reportTypeId);
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-4", cellList);
		}
		
		List<Object[]> bidderList = getTenderBidderList(tenderId,envelopId,formId,bidderIds,consortiumId,envelopeSortOrder,previousEnvelopeId,tblTender.getIsEncodedName(),tblTender.getEnvelopeType(),tblTender.getIsConsortiumAllowed(),tblTender.getBiddingType());
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-5", bidderList);
		}
		
		List<Object[]> bidList = getTenderBidList(tenderId,envelopId,formId,bidderIds,consortiumId,null,null);
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-6", bidList);
		}
		List<Object[]> bidFormList = getTenderBidFormList(tenderId,envelopId,formId,bidderIds);
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-7", bidFormList);
		}
		List<Object[]> bidTableList = getTenderBidTableList(tenderId,envelopId,formId,bidderIds);
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-8", bidTableList);
		}
		
		/*Hemal 10-02-17*/
                List<Object[]> tenderCurrencyExchange=getTenderCurrencyExchageRate(tenderId, bidderIds);
                
                if(tenderCurrencyExchange!=null && !tenderCurrencyExchange.isEmpty()){
                    map.put("#result-set-14",tenderCurrencyExchange);
                }
                /*Hemal 10-02-17*/
		/*List<Object[]> itemWiseBidderList = getTenderItemWiseList(tenderId,envelopId,formId,bidderId);
		if(formList!=null && !formList.isEmpty()){
			map.put("#result-set-13", itemWiseBidderList);
		}*/
		return map;
	}
    @Transactional
    public List<Object[]> getTenderCurrencyExchageRate(int tenderId,List<Object> bidderIds)throws Exception{
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId",tenderId);
        StringBuilder query=new StringBuilder();
        query.append("select tc.currencyId,tc.exchangeRate,bidderId,tb.userId from tbl_tenderbidcurrency tb ");
        query.append(" inner join tbl_tendercurrency tc on tc.tenderCurrencyId=tb.tenderCurrencyId ");
        query.append(" inner join tbl_bidder bd on bd.userId=tb.userId ");
        query.append(" where tenderId= :tenderId");
        if(bidderIds!=null && !bidderIds.isEmpty()){
        	var.put("bidderId",bidderIds);
        	query.append(" and bidderId in (:bidderId)");
        }
        List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        return lst;
    }
	@Transactional
	private List<Object[]> getTenderItemWiseList(int tenderId, int envelopId,int formId,int bidderId)throws Exception {
		StringBuilder query = new StringBuilder();
		Map<String, Object> var = new HashMap<String, Object>();
	    var.put("tenderId", tenderId);
	    if(envelopId !=0 ){
	    	var.put("envelopId", envelopId);
	    }
	    if(formId !=0 ){
	    	var.put("formId", formId);
	    }
	    query.append(" SELECT TBM.companyId,TBM.bidderId,IBM.tableId,IBM.rowId ");
	    query.append(" FROM tbl_TenderBidderMap TBM");
	    query.append(" INNER JOIN tbl_ItemBidderMap IBM on TBM.mapBidderId = IBM.mapBidderId");
	    query.append(" INNER JOIN tbl_TenderTable TT on TT.tableId = IBM.tableId");
	    query.append(" INNER JOIN tbl_tenderform TF on TF.formId = TT.formId");
	    query.append(" WHERE TBM.tenderId =:tenderId ");
	    if(bidderId !=0 ){
	    	query.append(" AND TBM.bidderId =:bidderId");
	    }
	    if(formId !=0 ){
	    	query.append(" AND TF.formId =:formId ");
	    }
	    if(envelopId !=0 ){
	    	query.append(" AND TF.envelopeId =:envelopId");
	    }
	    return hibernateQueryDao.createSQLQuery(query.toString(), var);
	}
	@Transactional
	private List<Object[]> getTenderBidTableList(int tenderId, int envelopId,int formId, List<Object> bidderIds)throws Exception {
		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     query.append(" SELECT TB.bidId,TBM.bidTableId,TBM.tableId");
	    	 query.append(" FROM tbl_tenderbid TB");
	    	 query.append(" INNER JOIN tbl_tenderbidmatrix TBM on TB.bidId = TBM.bidId");
	    	 query.append(" WHERE TB.tenderId =:tenderId ");
	    
	    	 if(bidderIds!=null && !bidderIds.isEmpty()){
	    		 var.put("bidderIds", bidderIds);
	    		 query.append(" AND TB.bidderId IN (:bidderIds)");
	    	 }
	     if(formId !=0 ){
	    	 query.append(" AND TB.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TB.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY TB.envelopeId, TB.formId, TB.bidId,TB.companyid,TBM.tableId,TBM.bidTableId");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
		}

	@Transactional
	public List<Object[]> getTenderBidFormWithFormDetail(int tenderId, int envelopId,int formId, String bidderIds)throws Exception {

		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     query.append(" SELECT DISTINCT TB.bidId,TB.tenderId,TB.envelopeId,TB.formId,TB.companyid,TB.bidderId,UD.companyname,TB.formBidWeight,TF.formName,TF.formWeight");
	    	 query.append(" FROM tbl_tenderbid TB");
	    	 query.append(" INNER JOIN tbl_finalsubmission FS ON TB.companyid=FS.companyid and TB.tenderId=FS.TenderId");
	    	 query.append(" INNER JOIN tbl_tenderform TF ON TB.formId=TF.formId and TF.isMandatory=1 ");
	    	 query.append(" INNER JOIN tbl_company UD on FS.companyid = UD.companyid");
	     
	     query.append(" WHERE TB.tenderId =:tenderId and FS.isActive=1 ");
	     if(bidderIds!=null && !bidderIds.isEmpty() && !"0".equals(bidderIds)){
	    	 var.put("bidderIds", bidderIds);
	    	 query.append(" AND TB.bidderId IN(:bidderIds)");
	     }
	     if(formId !=0 ){
	    	 query.append(" AND TB.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TB.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY TB.envelopeId, TB.formId,UD.companyname, TB.companyid ");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	
		
		}
	@Transactional
	public List<Object[]> getTenderBidFormList(int tenderId, int envelopId,int formId, List<Object> bidderIds)throws Exception {

		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     query.append(" SELECT DISTINCT TB.bidId,TB.tenderId,TB.envelopeId,TB.formId,TB.companyid,TB.bidderId,UD.companyname,TB.formBidWeight");
	    	 query.append(" FROM tbl_tenderbid TB");
	    	 query.append(" INNER JOIN tbl_finalsubmission FS ON TB.companyid=FS.companyid and TB.tenderId=FS.TenderId");
	    	 query.append(" INNER JOIN tbl_company UD on FS.companyid = UD.companyid");
	     
	     query.append(" WHERE TB.tenderId =:tenderId ");
	     if(bidderIds!=null && !bidderIds.isEmpty() && !bidderIds.equals("0")){
	    	 var.put("bidderIds", bidderIds);
	    	 query.append(" AND TB.bidderId IN(:bidderIds)");
	     }
	     if(formId !=0 ){
	    	 query.append(" AND TB.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TB.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY TB.envelopeId, TB.formId,UD.companyname, TB.companyid ");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	
		
		}

	@Transactional
	private List<Object[]> getTenderBidList(int tenderId, int envelopId,int formId, List<Object> bidderIds, int consortiumId,List<Object> columnIds,List<Object> rowIds) throws Exception{
		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	    	 
	     query.append(" SELECT TB.bidId, TB.bidderId,TBD.bidTableId, TC.formId, TC.tableId, TC.rowId, TC.columnId, TC.dataType, TBD.cellId, TBD.cellNo, TBD.cellValue,TCC.filledby");
	     query.append(" FROM tbl_tenderbiddetail TBD");
	     query.append(" INNER JOIN tbl_tendercell TC on TBD.cellId = TC.cellId ");
	     query.append("  INNER JOIN tbl_tendercolumn TCC on TCC.columnId = TC.columnId");
	     query.append("  INNER JOIN tbl_tenderbidmatrix TBM ON TBM.bidTableId = TBD.bidTableId");
	     query.append("  INNER JOIN tbl_tenderbid TB ON TB.bidId = TBM.bidId");
	     query.append("  INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TB.tenderId AND TOA.formId = TC.formId and TOA.bidderId = TB.bidderId and TOA.decryptionLevel = 1 ");
	     query.append(" INNER JOIN tbl_finalsubmission fs on TB.companyid=fs.companyid and fs.tenderid=TB.tenderid ");
	    
	     if(consortiumId !=0){
	    	 var.put("consortiumId", consortiumId);
	    	 query.append(" INNER JOIN apptenderbid.tbl_ConsortiumDetail CSD ON TOA.bidderId = CSD.bidderId and CSD.consortiumId =:consortiumId");
	     }
	     
	     query.append(" WHERE TB.tenderId =:tenderId ");
	     if(bidderIds!=null && !bidderIds.isEmpty()){
	    	 var.put("bidderIds", bidderIds);
	    	 query.append(" AND TOA.bidderId IN (:bidderIds)");
	     }
	     if(columnIds!=null && !columnIds.isEmpty()){
	    	 var.put("columnIds", columnIds);
	    	 query.append(" AND TCC.columnId IN (:columnIds)");
	     }
	     if(rowIds!= null && !rowIds.isEmpty()){
	    	 var.put("rowIds", rowIds);
	    	 query.append(" AND TC.rowId IN (:rowIds)");
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	    	 query.append(" AND TOA.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	    	 query.append(" AND TOA.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY TC.formId,TC.tableId,TC.rowId,TB.bidderId,TBD.bidTableId,TCC.sortOrder ");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	}
	@Transactional
	private List<Object[]> getTenderBidderList(int tenderId, int envelopId,	int formId, List<Object> bidderIds, int consortiumId, int envelopeSortOrder,int previousEnvelopeId,int isEncodedName,int tenderStage,int isConsortiumAllow,int biddingType)throws Exception {
		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(consortiumId !=0){
	    	 var.put("consortiumId", consortiumId);
	     }
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     if(envelopeSortOrder > 1 && tenderStage == 2){
	    	 var.put("previousEnvelopeId", previousEnvelopeId);
	     }
	     query.append(" SELECT DISTINCT FS.companyid,FS.bidderId,FS.finalsubmissionid, UD.companyname, FS.consortiumId,");
	     if(isEncodedName == 1){
	    	 query.append(" CASE WHEN TF.isPriceBid = 1 THEN TBC.encodedName ELSE UD.companyname END encodedName,");
	     }else{
	    	 query.append(" UD.companyname encodedName,");
	     }
	     query.append("  FS.partnerType  ");
	     if(biddingType == 2){
	    	 query.append(" ,TC.currencyName, TTC.isDefault  ");
	     }
	     query.append("  FROM tbl_finalsubmission FS ");
	     query.append("  INNER JOIN tbl_company UD on FS.companyid = UD.companyid");
	     query.append("  INNER JOIN tbl_tenderopen TOA ON TOA.tenderID = FS.tenderId AND FS.bidderId = TOA.bidderId  and TOA.decryptionLevel = 1 ");
	     if(envelopeSortOrder > 1 && tenderStage == 2){
	    	 query.append(" INNER JOIN Tbl_BidderApprovalDetail BAD ON BAD.envelopeId = :previousEnvelopeId AND BAD.finalSubmissionId = FS.finalSubmissionId AND BAD.isApproved = 1");
	     }
	     if(consortiumId !=0){
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSD ON TOA.bidderId = CSD.bidderId and CSD.consortiumId =:consortiumId and csd.cstatus=1");
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSDL ON CSDL.consortiumId =CSD.consortiumId and CSDL.partnerType!=3 ");
	    	 query.append(" INNER JOIN tbl_finalsubmission FSL on FSL.consortiumId = CSD.consortiumId and FSL.isActive=1 and FSL.companyid = CSDL.companyid");
	     }else if(isConsortiumAllow == 1){
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSD ON TOA.bidderId = CSD.bidderId and CSD.consortiumId = FS.consortiumId and csd.cstatus=1");
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSDL ON CSDL.consortiumId =CSD.consortiumId and CSDL.partnerType!=3 ");
	    	 query.append(" INNER JOIN tbl_finalsubmission FSL on FSL.consortiumId = CSD.consortiumId and FSL.isActive=1 and FSL.companyid = CSDL.companyid");
	     }
	     
	     if(isEncodedName == 1){
	    	 query.append(" INNER JOIN tbl_tenderform TF ON TF.formId = TOA.formId");
	    	 query.append(" INNER JOIN tbl_TenderBidConfirmation TBC on TBC.tenderId = FS.tenderId AND TBC.bidderId = FS.bidderId");
	     }
	     if(biddingType == 2){
		    	query.append(" INNER JOIN Tbl_TenderBidCurrency TTBC ON TTBC.companyid= FS.companyid ");
		    	query.append(" INNER JOIN tbl_tendercurrency TTC ON TTC.tenderCurrencyId = TTBC.tenderCurrencyId AND TTC.tenderid = FS.tenderid");
		    	query.append(" INNER JOIN tbl_currency TC ON TC.currencyId = TTC.currencyId");
		 }
	     
	     query.append(" WHERE FS.tenderId =:tenderId AND FS.isActive = 1 ");
	     if(bidderIds !=null && !bidderIds.isEmpty()){
	    	 var.put("bidderIds", bidderIds);
	    	 query.append(" AND FS.bidderId IN(:bidderIds)");
	     }
	     if(formId !=0 ){
	    	 query.append(" AND TOA.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TOA.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY companyname ");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	
		}
	@Transactional
	private List<Object[]> getTenderCellList(int tenderId, int envelopId,int formId, int bidderId, int consortiumId, int reportTypeId) throws Exception{

		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(bidderId !=0 ){
	    	 var.put("bidderId", bidderId);
	     }
	     if(consortiumId !=0){
	    	 var.put("consortiumId", consortiumId);
	     }
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     query.append(" SELECT DISTINCT TCC.cellId,TCC.formId, TCC.tableId, TCC.columnId, TCC.rowId, TCC.cellValue, TCC.cellNo, TCC.dataType,");
	     query.append("  TF.sortOrder as formSortOrder,TC.filledBy,TC.sortOrder  ");
	     query.append("  FROM tbl_tendercell TCC");
	     query.append("  INNER JOIN tbl_tenderform TF ON TCC.formId = TF.formId ");
	     query.append("  INNER JOIN tbl_tendercolumn TC on TCC.columnId = TC.columnId ");
	     if(bidderId !=0 ){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId AND TOA.formId = TF.formId AND TOA.bidderId =:bidderId and TOA.decryptionLevel = 1");
	     }
	     if(consortiumId !=0){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId  AND TOA.formId = TF.formId  and TOA.decryptionLevel = 1");
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSD ON TOA.bidderId = CSD.bidderId and CSD.consortiumId =:consortiumId");
	     }
	     query.append(" WHERE TF.tenderId =:tenderId AND TF.cstatus =1 ");
	     if(reportTypeId != 2){
	    	 query.append(" AND TC.filledBy = 1");
	     }
	     if(formId !=0 ){
	    	 query.append(" AND TF.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TF.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY TF.sortOrder,TCC.tableId, TCC.rowId,TC.filledBy,TC.sortOrder ");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	
	}

	@Transactional
	private List<Object[]> getTenderColumnList(int tenderId, int envelopId,	int formId, int bidderId, int consortiumId) throws Exception{
		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(bidderId !=0 ){
	    	 var.put("bidderId", bidderId);
	     }
	     if(consortiumId !=0){
	    	 var.put("consortiumId", consortiumId);
	     }
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     query.append(" SELECT DISTINCT TC.columnId,TC.tableId, TC.columnNo, TC.columnTypeId, TC.columnHeader, TC.filledBy, TC.isShown,TC.isCurrConvReq,TFF.formula,");
	     query.append("  TF.sortOrder as formSortOrder,TC.sortOrder,case when filledBy=1 then 1 else TC.sortOrder end As columnOrder,TC.isGTColumn,TC.isPriceSummary ");
	     query.append("  FROM tbl_tendercolumn TC");
	     query.append("  INNER JOIN tbl_tenderform TF ON TC.formId = TF.formId");
	     query.append("  LEFT OUTER JOIN tbl_tenderformula TFF on TFF.columnId = TC.columnId AND (TFF.formula LIKE 'WORD%' OR TFF.formula LIKE 'TOTAL%') AND TFF.tableId= TC.tableId AND TFF.formId = TF.formId");
	     if(bidderId !=0 ){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId AND TOA.formId = TF.formId AND TOA.bidderId =:bidderId and TOA.decryptionLevel = 1");
	     }
	     if(consortiumId !=0){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId  AND TOA.formId = TF.formId  and TOA.decryptionLevel = 1");
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSD ON TOA.bidderId = CSD.bidderId and CSD.consortiumId =:consortiumId");
	     }
	     query.append(" WHERE TF.tenderId =:tenderId AND TF.cstatus =1 ");
	     if(formId !=0 ){
	    	 query.append(" AND TF.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TF.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY TF.sortOrder,TC.tableId,columnOrder,TC.columnNo");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	}

	@Transactional
	private List<Object[]> getTenderTableList(int tenderId, int envelopId,int formId, int bidderId, int consortiumId) throws Exception{
		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(bidderId !=0 ){
	    	 var.put("bidderId", bidderId);
	     }
	     if(consortiumId !=0){
	    	 var.put("consortiumId", consortiumId);
	     }
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     query.append(" SELECT DISTINCT TT.formId,TT.tableId, TT.tableName, TT.tableHeader, TT.tableFooter, TT.noOfRows, TT.noOfCols, TT.isMultipleFilling,TT.hasGTRow,  TF.sortOrder as formSortOrder, TT.sortOrder");
	     query.append("  FROM tbl_tendertable TT");
	     query.append(" INNER JOIN tbl_tenderform TF on TT.formId = TF.formId");
	     if(bidderId !=0 ){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId AND TOA.formId = TF.formId AND TOA.bidderId = :bidderId and TOA.decryptionLevel = 1");
	     }
	     if(consortiumId !=0){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId  AND TOA.formId = TF.formId and TOA.decryptionLevel = 1");
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSD ON TOA.bidderId = CSD.bidderId and CSD.consortiumId =:consortiumId");
	     }
	     query.append(" WHERE TF.tenderId =:tenderId AND TF.cstatus =1 ");
	     if(formId !=0 ){
	    	 query.append(" AND TF.formId =:formId ");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TF.envelopeId =:envelopId");
	     }
	     query.append(" ORDER BY TF.sortOrder, TT.sortOrder ");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	}

	@Transactional
	 private List<Object[]> getTenderFormList(int tenderId, int envelopId,int formId,int bidderId,int consortiumId,int autoResultSharing) throws Exception{
		 StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     if(envelopId !=0 ){
	    	 var.put("envelopId", envelopId);
	     }
	     if(formId !=0 ){
	    	 var.put("formId", formId);
	     }
	     if(bidderId !=0 ){
	    	 var.put("bidderId", bidderId);
	     }
	     if(consortiumId !=0){
	    	 var.put("consortiumId", consortiumId);
	     }
	     
	     query.append(" SELECT DISTINCT TF.formId, TF.formName, TF.formHeader, TF.formFooter, TF.noOfTables, TF.isMultipleFilling, TF.isDocumentReq, TF.isEncryptedDocument, TF.isSecondary, TF.isPriceBid, TF.sortOrder,");
	     if(autoResultSharing == 0){
	    	 query.append("1 AS showDocuments ");
	     }else{
	    	 query.append(" COALESCE(SAD.shareDocument,0) AS showDocuments ");	 
	     }
	     query.append(" ,formWeight ");
	     query.append(" FROM tbl_tenderform TF ");
	     if(bidderId !=0 ){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId AND TOA.formId = TF.formId AND TOA.bidderId =:bidderId and TOA.decryptionLevel = 1");
	     }
	     if(consortiumId !=0){
	    	 query.append(" INNER JOIN tbl_tenderopen TOA ON TOA.tenderId = TF.tenderId AND TOA.envelopeId = TF.envelopeId  AND TOA.formId = TF.formId  and TOA.decryptionLevel = 1");
	    	 query.append(" INNER JOIN tbl_ConsortiumDetail CSD ON TOA.bidderId = CSD.bidderId and CSD.consortiumId =:consortiumId");
	     }
	     if(autoResultSharing != 0){
	    	 query.append(" LEFT JOIN tbl_ShareReport SA ON SA.tenderId = TF.tenderId AND SA.isActive = 1");
	    	 query.append(" LEFT JOIN tbl_ShareReportDetail SAD ON SAD.shareReportId = SA.shareReportId AND SAD.formId = TF.formId");
	     }
	     query.append(" WHERE TF.tenderId =:tenderId AND TF.cstatus = 1");
	     if(formId !=0 ){
	    	 query.append(" AND TF.formId =:formId");
	     }
	     if(envelopId !=0 ){
	    	 query.append(" AND TF.envelopeId =:envelopId ");
	     }
	     query.append(" ORDER BY TF.sortOrder");
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	}
	 
	 @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	    public boolean addTenderResultConfig(TblShareReport tblShareReport,List<TblShareReportDetail> tblShareReportDetails) throws Exception{
	    	boolean bSuccess = false;
	    	List<Object[]> shareReportsData=getShareReports(tblShareReport.getTblTender().getTenderId());
			if(shareReportsData!=null && !shareReportsData.isEmpty()){// If update case
				Object[] data= shareReportsData.get(0);
				tblShareReport.setIsActive(1);
					tblShareReport.setShowAbstractReport((Integer)data[3]);
					tblShareReport.setShareBidderStatus((Integer)data[4]);
					tblShareReport.setShareClarificationReport((Integer)data[5]);
					tblShareReport.setShareEvaluationReport((Integer)data[6]);
					tblShareReport.setShareReportId((Integer)data[7]);
					deActivateShareReport(tblShareReport.getShareReportId());//old data deactivate
					
					/*
					 *Here For opening process insertion is : Old data deactivate and new insertion for tblsharereport table and also for  tblShareReportDetail
					 */
					tblShareReport.setShareReportId(0);
					tblShareReportDao.addTblShareReport(tblShareReport);
		    		for (int i = 0; i < tblShareReportDetails.size(); i++) {
		    			tblShareReportDetails.get(i).setTblShareReport(tblShareReport);
					}
		        	tblShareReportDetailDao.saveUpdateAllTblShareReportDetail(tblShareReportDetails);
			}else{// If Add case
					//By default value of evaluation field is do not share
					tblShareReport.setShowAbstractReport(0);
					tblShareReport.setShareBidderStatus(4);
					tblShareReport.setShareClarificationReport(4);
					tblShareReport.setShareEvaluationReport(4);
		    		tblShareReportDao.addTblShareReport(tblShareReport);
		    		for (int i = 0; i < tblShareReportDetails.size(); i++) {
		    			tblShareReportDetails.get(i).setTblShareReport(tblShareReport);
					}
		        	tblShareReportDetailDao.saveUpdateAllTblShareReportDetail(tblShareReportDetails);
			}
	    	bSuccess=true;        
	    	return bSuccess;

	    }
	 @Transactional
		public TblTenderopen getTblTenderopen(int formId,int bidderId) throws Exception {
	        List<TblTenderopen> list = null;
	        list = commonDAO.findEntity(TblTenderopen.class, "tblTenderform.formId", Operation_enum.EQ, formId,"decryptionlevel",Operation_enum.EQ,1,"bidderid",Operation_enum.EQ,bidderId);
	        return (list != null && !list.isEmpty()) ? list.get(0) : null;
		 }  
	 
	 @Transactional
	public TblTenderEnvelope getTenderEnvelopeBySortOrder(int sortOrder,int tenderId) throws Exception {
        List<TblTenderEnvelope> list = null;
        list = commonDAO.findEntity(TblTenderEnvelope.class, "tblTender.tenderId", Operation_enum.EQ, tenderId,"sortOrder",Operation_enum.EQ,sortOrder);
        return (list != null && !list.isEmpty()) ? list.get(0) : null;
	 }
	 @Transactional
	public Map<String, List<Object[]>> getCustomizeReportConfigDtl(int tenderId,int formId,List<Object> bidderIds, List<Object> columnIds, List<Object> rowIds) throws Exception {
		 return sPGenerateCustomReport(tenderId,formId,1,bidderIds,columnIds,rowIds);
	}
	 public void updateBidWeightage(String[] bidderIds, String[] weightVals, int tenderId, int formId) {
			// TODO Auto-generated method stub
			for(int i = 0; i < bidderIds.length;i++){
				Integer bidderId =  Integer.parseInt(bidderIds[i]);
				Double weightVal = Double.parseDouble(weightVals[i]);
				
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("formBidWeight", weightVal);
				map.put("bidderId", bidderId);
				map.put("formId", formId);
				map.put("tenderId", tenderId);
				commonDAO.executeUpdate("update TblTenderBid set formBidWeight=:formBidWeight where tblTender.tenderId=:tenderId and tblTenderform.formId=:formId and bidderid=:bidderId", map);
			}
		}
	 
	@Transactional
	private Map<String, List<Object[]>> sPGenerateCustomReport(int tenderId,int formId, int flag, List<Object> bidderIds, List<Object> columnIds, List<Object> rowIds) throws Exception {
		 Map<String, List<Object[]>> map = new HashMap<String, List<Object[]>>();
		 int envelopeId = 0;
		 
		 
//		 if(flag==1){
			 /* Getting TenderForm Details */
			 List<Object[]> formList = tenderFormService.getTenderFormById(formId,-1);
			 if(formList!=null && !formList.isEmpty()){
				 map.put("#result-set-1", formList);
			 }
			 for (Object[] objects : formList) {
				 envelopeId = Integer.parseInt(objects[6].toString());
			}
			 TblTenderEnvelope tblTenderEnvelope = tenderCommonService.getTenderEnvelopeById(envelopeId);
			 int envelopeSortOrder = tblTenderEnvelope.getSortOrder();
			 int previousEnvelopeId = 0;
				if(envelopeSortOrder > 1){
					previousEnvelopeId = getTenderEnvelopeBySortOrder(envelopeSortOrder,tenderId).getEnvelopeId();
				}
			 /* Geting TenderTable Details */
			 List<Object[]> tableList = tenderFormService.getTenderTableById(formId);
			 if(tableList!=null && !tableList.isEmpty()){
				 map.put("#result-set-2", tableList);
			 }
			 /* Geting TenderColumn Details */
			 List<Object[]> columnList = tenderFormService.getColumnById(formId,columnIds);
			 if(columnList!=null && !columnList.isEmpty()){
				 map.put("#result-set-3", columnList);
			 }
			// Tender cell - Filled by Officer
			 List<Object[]> cellList = tenderFormService.getTenderCellById(formId,columnIds,rowIds);
			 if(cellList!=null && !cellList.isEmpty()){
				 map.put("#result-set-4", cellList);
			 }
			 TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
			 List<Object[]> bidderList = tenderFormService.getBidderById(tenderId,envelopeId,formId,envelopeSortOrder,previousEnvelopeId,tblTender.getEnvelopeType(),bidderIds);
			 if(bidderList!=null && !bidderList.isEmpty()){
				 map.put("#result-set-5", bidderList);
			 }
			 
			 List<Object[]> bidList = getTenderBidList(tenderId,envelopeId,formId,bidderIds,0,columnIds,rowIds);
				if(bidList!=null && !bidList.isEmpty()){
					map.put("#result-set-6", bidList);
				}
				
				List<Object[]> bidFormList = getTenderBidFormList(tenderId,envelopeId,formId,bidderIds);
				if(bidFormList!=null && !bidFormList.isEmpty()){
					map.put("#result-set-7", bidFormList);
				}
				
				List<Object[]> bidTableList = getTenderBidTableList(tenderId,envelopeId,formId,bidderIds);
				if(bidTableList!=null && !bidTableList.isEmpty()){
					map.put("#result-set-8", bidTableList);
				}
				
		 return map;
	}
	
	@Transactional
	public List<Object[]> getItemDetailsForPO(int tenderId, int tableId, int rowId) throws Exception{

		StringBuilder query = new StringBuilder();
		 Map<String, Object> var = new HashMap<String, Object>();
	     var.put("tenderId", tenderId);
	     var.put("tableId",tableId);
	     var.put("rowId", rowId);
	     query.append(" SELECT DISTINCT TCC.cellId, TCC.cellValue, TCC.cellNo,");
	     query.append("  TC.filledBy,TC.sortOrder  ");
	     query.append("  FROM tbl_tendercell TCC");
	     query.append("  INNER JOIN tbl_tenderform TF ON TCC.formId = TF.formId ");
	     query.append("  INNER JOIN tbl_tendercolumn TC on TCC.columnId = TC.columnId ");
	     query.append(" WHERE TF.tenderId =:tenderId AND TF.cstatus =1 and TCC.tableId=:tableId and TCC.rowId=:rowId ");
	     query.append(" AND TC.filledBy = 1 AND TCC.cellNo = 0 ");
	     query.append(" ORDER BY TCC.cellId, TCC.cellValue, TCC.cellNo,TC.filledBy,TC.sortOrder ");
	     
	     return hibernateQueryDao.createSQLQuery(query.toString(), var);
	
	}
	
	
   }
