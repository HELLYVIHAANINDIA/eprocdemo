/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.daointerface.TblBidderDao;
import com.eprocurement.common.model.TblColumnType;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.EncrptDecryptUtils;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.EncryptDecryptUtils;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.daointerface.TblTenderCellGrandTotalDao;
import com.eprocurement.etender.databean.BiddingFormBean;
import com.eprocurement.etender.databean.BiddingFormColumnBean;
import com.eprocurement.etender.databean.BiddingFormTableBean;
import com.eprocurement.etender.databean.LoginReportBean;
import com.eprocurement.etender.databean.TenderBidBean;
import com.eprocurement.etender.databean.ValidationMessage;
import com.eprocurement.etender.model.TblAuctionExtension;
import com.eprocurement.etender.model.TblAuctionStopResume;
import com.eprocurement.etender.model.TblBidDetail;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblEnvelope;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderBid;
import com.eprocurement.etender.model.TblTenderBidDetail;
import com.eprocurement.etender.model.TblTenderBidHistory;
import com.eprocurement.etender.model.TblTenderBidMatrix;
import com.eprocurement.etender.model.TblTenderCell;
import com.eprocurement.etender.model.TblTenderCellGrandTotal;
import com.eprocurement.etender.model.TblTenderColumn;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderDocument;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;
import com.eprocurement.etender.model.TblTenderFormula;
import com.eprocurement.etender.model.TblTenderGovColumn;
import com.eprocurement.etender.model.TblTenderRebate;
import com.eprocurement.etender.model.TblTenderTable;
import java.util.Map.Entry;

@Service
public class FormService {

    @Autowired
    HibernateQueryDao hibernateQueryDao;
    @Autowired
    CommonDAO commonDAO;
    @Autowired
    TblTenderCellGrandTotalDao tblTenderCellGrandTotalDao;
    @Autowired
    EncrptDecryptUtils encrptDecryptUtils;
    @Autowired
    TenderCommonService tenderCommonService;
    @Autowired
    CommonService commonService;
    @Autowired
    TblBidderDao tblBidderDao;
    @Autowired
    ReportService reportService;
    

    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;

    public BiddingFormBean setBiddingFormParameters(HttpServletRequest request) throws Exception {
        BiddingFormBean biddingFormBean = new BiddingFormBean();
        biddingFormBean.setFormName(checkRequestNull(request, "FormName"));
        biddingFormBean.setFormHeader(checkRequestNull(request, "FromHeader"));
        biddingFormBean.setFormFooter(checkRequestNull(request, "FormFooter"));

        biddingFormBean.setIsDocumentReq(convertInt(checkRequestNull(request, "RequiredSupportingDoc")));
        biddingFormBean.setIsMandatory(convertInt(checkRequestNull(request, "IsMandatory")));
        biddingFormBean.setIsPriceBid(convertInt(checkRequestNull(request, "rdbPriceBidding")));
        biddingFormBean.setNoOfTables(convertInt(checkRequestNull(request, "NoOfTable")));
        biddingFormBean.setIsEncryptedDocument(convertInt(checkRequestNull(request, "Encrypted")));
        biddingFormBean.setIsEncryptionReq(convertInt(checkRequestNull(request, "EncryptionReq")));
        biddingFormBean.setIsEvaluationReq(convertInt(checkRequestNull(request, "IsEvaluation")));
        biddingFormBean.setIsItemWiseDocAllowed(convertInt(checkRequestNull(request, "IsItemWiseDoc")));
        biddingFormBean.setIsMultipleFilling(convertInt(checkRequestNull(request, "IsMultiple")));
        biddingFormBean.setIsSecondary(convertInt(checkRequestNull(request, "rdbsecondaryPartner")));

        biddingFormBean.setEnvelopeid(convertInt(checkRequestNull(request, "optFormType"))); 
        
        biddingFormBean.setTenderid(convertInt(checkRequestNull(request, "tenderId")));

        biddingFormBean.setCstatus(0);
        biddingFormBean.setIncrementItems(convertInt(checkRequestNull(request, "")));

        biddingFormBean.setLoadNoOfItems(1);
        biddingFormBean.setMasterFormId(1);
        biddingFormBean.setMinTablesReqForBidding(1);
        biddingFormBean.setParentFormId(1);
        biddingFormBean.setPublishedBy(1);
        biddingFormBean.setCancelledBy(1);
        biddingFormBean.setCreatedOn(new Date());
        HttpSession session = request.getSession();
        SessionBean sessionBean = (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString());
        long userId = 1;
        if (sessionBean != null) {
            userId = sessionBean.getUserId();
        }
        biddingFormBean.setCreatedBy((int) userId);
        if (checkRequestNull(request, "hdnFormId").trim().length() > 0) {
            biddingFormBean.setFormId(convertInt(checkRequestNull(request, "hdnFormId")));
        }
        if (checkRequestNull(request, "formWeight").trim().length() > 0) {
            biddingFormBean.setFormWeight((Double.parseDouble((checkRequestNull(request, "formWeight")))));
        } else {
            biddingFormBean.setFormWeight(new Double(0));
        }

        return biddingFormBean;

    }

    public TblTenderForm setBiddingFormParameterToTable(BiddingFormBean biddingFormBean) throws Exception {
        TblTenderForm tblTenderForm = new TblTenderForm();
        TblTender tblender = new TblTender();
        TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();
        tblTenderForm.setCreatedBy(biddingFormBean.getCreatedBy());
        tblTenderForm.setCreatedOn(new Date());
        tblTenderForm.setCstatus(biddingFormBean.getCstatus());
        tblTenderForm.setFormFooter(biddingFormBean.getFormFooter());
        tblTenderForm.setFormHeader(biddingFormBean.getFormHeader());
        tblTenderForm.setFormName(biddingFormBean.getFormName());
        tblTenderForm.setIncrementItems(biddingFormBean.getIncrementItems());
        tblTenderForm.setIsDocumentReq(biddingFormBean.getIsDocumentReq());
        tblTenderForm.setIsEncryptedDocument(biddingFormBean.getIsEncryptionReq());
        tblTenderForm.setIsEncryptionReq(biddingFormBean.getIsEncryptionReq());
        tblTenderForm.setIsEvaluationReq(biddingFormBean.getIsEvaluationReq());
        tblTenderForm.setIsItemWiseDocAllowed(biddingFormBean.getIsItemWiseDocAllowed());
        tblTenderForm.setIsMandatory(biddingFormBean.getIsMandatory());
        tblTenderForm.setIsMultipleFilling(biddingFormBean.getIsMultipleFilling());
        tblTenderForm.setIsPriceBid(biddingFormBean.getIsPriceBid());
        tblTenderForm.setIsSecondary(biddingFormBean.getIsSecondary());
        tblTenderForm.setLoadNoOfItems(biddingFormBean.getLoadNoOfItems());
        tblTenderForm.setMasterFormId(biddingFormBean.getMasterFormId());
        tblTenderForm.setMinTablesReqForBidding(biddingFormBean.getMinTablesReqForBidding());
        tblTenderForm.setNoOfTables(biddingFormBean.getNoOfTables());
        tblTenderForm.setParentFormId(biddingFormBean.getParentFormId());
        tblTenderForm.setPublishedBy(biddingFormBean.getPublishedBy());
        tblTenderForm.setSortOrder(1);
        tblTenderForm.setFormWeight(biddingFormBean.getFormWeight());
        tblender.setTenderId(biddingFormBean.getTenderid());
        tblTenderForm.setTblTender(tblender);
        tblTenderEnvelope.setEnvelopeId(biddingFormBean.getEnvelopeid());
        //code for edit only
        if (biddingFormBean.getFormId() != 0) {
            tblTenderForm.setFormId(biddingFormBean.getFormId());
        }

        tblTenderForm.setTblTenderEnvelope(tblTenderEnvelope);

        return tblTenderForm;

    }

    public HashMap setBiddingFormTableParameters(HttpServletRequest request) throws Exception {
        BiddingFormTableBean biddingFormTableBean = new BiddingFormTableBean();
        HashMap hsMain = new HashMap();
        List<BiddingFormColumnBean> lstBiddingFormColumnBean = new ArrayList<BiddingFormColumnBean>();
        List<BiddingFormTableBean> lstBiddingFormTableBean = new ArrayList<BiddingFormTableBean>();
        String key;
        String json = checkRequestNull(request, "txtJson");
        int formId = convertInt(checkRequestNull(request, "hdnFormId"));
        int tenderId = convertInt(checkRequestNull(request, "tenderId"));
        long userId = 1;
        HttpSession session = request.getSession();
        SessionBean sessionBean = (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString());

        if (sessionBean != null) {
            userId = sessionBean.getUserId();
        }
        JSONObject jobj = new JSONObject(json);
        JSONObject jsonObjTable = jobj.getJSONObject("TableJson");
        Iterator itr = jsonObjTable.keys();
        while (itr.hasNext()) {
            String k = (String) itr.next();
            JSONObject jsonObj = jsonObjTable.getJSONObject(k);
            biddingFormTableBean = new BiddingFormTableBean();
            biddingFormTableBean.setCreatedBy((int) userId);
            biddingFormTableBean.setCreatedOn(new Date());
            biddingFormTableBean.setHasGTRow(0);
            biddingFormTableBean.setIsMandatory(jsonObj.getInt("IsMandatory"));
            biddingFormTableBean.setIsMultipleFilling(0);
            biddingFormTableBean.setIsPartialFillingAllowed(0);
            biddingFormTableBean.setNoOfCols(convertInt(jsonObj.getString("txtnumcol")));
            biddingFormTableBean.setNoOfRows(convertInt(jsonObj.getString("NoOfRows")));
            biddingFormTableBean.setTableFooter(jsonObj.getString("TableFooter"));
            biddingFormTableBean.setTableHeader(jsonObj.getString("textAreaTableHeader"));
            biddingFormTableBean.setTableName(jsonObj.getString("TableName"));
            biddingFormTableBean.setUpdatedBy(1);
            biddingFormTableBean.setUpdatedOn(new Date());
            biddingFormTableBean.setFormId(formId);
            biddingFormTableBean.setTenderId(tenderId);

            //code for edit only
            if (!jsonObj.isNull("TableId")) {
                biddingFormTableBean.setTableId(jsonObj.getInt("TableId"));

            }

            JSONObject jsonObj2 = jsonObj.getJSONObject("ColumnJson");
            Iterator itr2 = jsonObj2.keys();
            lstBiddingFormColumnBean = new ArrayList();
            while (itr2.hasNext()) {
                key = (String) itr2.next();
                JSONObject jsonObj3 = jsonObj2.getJSONObject(key);
                BiddingFormColumnBean biddingFormColumnBean = new BiddingFormColumnBean();

                biddingFormColumnBean.setColumnNo(convertInt(jsonObj3.getString("ComumnNo")));

                biddingFormColumnBean.setColumnHeader(jsonObj3.getString("ColumnHeader"));
                biddingFormColumnBean.setColumntypeid(convertInt(jsonObj3.getString("ColumnType")));
                biddingFormColumnBean.setDataType(convertInt(jsonObj3.getString("DataType")));
                biddingFormColumnBean.setFilledBy(convertInt(jsonObj3.getString("FilledBy")));
                biddingFormColumnBean.setIsCurrConvReq(jsonObj3.getInt("IsCurrencyConvert"));
                biddingFormColumnBean.setIsGTColumn(convertInt(jsonObj3.getInt("isGTColumn")));
                biddingFormColumnBean.setIsPriceSummary(convertInt(jsonObj3.getInt("isPriceSummary")));
                biddingFormColumnBean.setFormid(biddingFormTableBean.getFormId());
                biddingFormColumnBean.setTableid(biddingFormTableBean.getTableId());
                String showHide = jsonObj3.getString("ShowHide");
                if (showHide.equalsIgnoreCase("on")) {
                    biddingFormColumnBean.setIsShown(1);
                } else {
                    biddingFormColumnBean.setIsShown(0);
                }

                //code for edit only
                if (!jsonObj3.isNull("ColumnId")) {
                    biddingFormColumnBean.setColumnId(jsonObj3.getInt("ColumnId"));

                }
                biddingFormColumnBean.setTableid(biddingFormTableBean.getTableId());

                lstBiddingFormColumnBean.add(biddingFormColumnBean);

            }
            hsMain.put(biddingFormTableBean, lstBiddingFormColumnBean);
        }
        return hsMain;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBiddingFormDetails(TblTenderForm tblTenderForm) throws Exception {
        boolean success = false;
        success = addBiddingForm(tblTenderForm);
        return success;
    }

    /**
     * Add new tender
     *
     * @param TblTender tblTender
     * @return boolean
     * @throws Exception
     */
    public boolean addBiddingForm(TblTenderForm tblTenderForm) throws Exception {
        boolean bSuccess = false;
        commonDAO.clear();
        commonDAO.save(tblTenderForm);
        if (tblTenderForm.getTblTender().getisAuction() == 0) {
            int TotalMandatoryForm = 0;
            if (tblTenderForm.getIsMandatory() == 1) {
                Map<String, Object> var = new HashMap<String, Object>();
                var.put("EnvId", tblTenderForm.getTblTenderEnvelope().getEnvelopeId());
                StringBuilder query = new StringBuilder();
                query.append("select noOfFormsReq,envelopeId from tbl_tenderenvelope where envelopeId=:EnvId");
                List<Object[]> lst = hibernateQueryDao.createSQLQuery(query.toString(), var);
                for (int i = 0; i < lst.size(); i++) {
                    TotalMandatoryForm = convertInt(lst.get(i)[0].toString());
                }
                TotalMandatoryForm++;
                Map<String, Object> column = new HashMap<String, Object>();
                column.put("EnvId", tblTenderForm.getTblTenderEnvelope().getEnvelopeId());
                column.put("TotalMandatoryForm", TotalMandatoryForm);
                commonDAO.executeUpdate("update TblTenderEnvelope set noOfFormsReq = :TotalMandatoryForm where envelopeId=:EnvId", column);

            }
        }
        bSuccess = true;
        return bSuccess;
    }

    public List<BiddingFormColumnBean> setBiddingFormColumnParameters(HttpServletRequest request) {
        List<BiddingFormColumnBean> lstBiddingFormColumnBean = new ArrayList<BiddingFormColumnBean>();
        BiddingFormColumnBean biddingFormColumnBean = new BiddingFormColumnBean();
        biddingFormColumnBean.setColumnHeader("header");
        biddingFormColumnBean.setColumnNo(1);
        biddingFormColumnBean.setColumntypeid(1);
        biddingFormColumnBean.setDataType(1);
        biddingFormColumnBean.setFilledBy(1);
        biddingFormColumnBean.setIsCurrConvReq(1);
        biddingFormColumnBean.setIsShown(1);
        biddingFormColumnBean.setTableid(1);
        lstBiddingFormColumnBean.add(biddingFormColumnBean);
        return lstBiddingFormColumnBean;
    }

    public TblTenderColumn setBiddingFormColumnParameterToTable(BiddingFormColumnBean biddingFormColumnBean) {
        TblTenderColumn tblTenderColumn = new TblTenderColumn();
        tblTenderColumn.setColumnHeader(biddingFormColumnBean.getColumnHeader());
        TblColumnType tblColumnType = new TblColumnType();
        tblColumnType.setColumnTypeId(biddingFormColumnBean.getColumntypeid());
        tblTenderColumn.setTblColumnType(tblColumnType);
        tblTenderColumn.setColumnNo(biddingFormColumnBean.getColumnNo());
        tblTenderColumn.setDataType(biddingFormColumnBean.getDataType());
        tblTenderColumn.setFilledBy(biddingFormColumnBean.getFilledBy());
        tblTenderColumn.setIsCurrConvReq(biddingFormColumnBean.getIsCurrConvReq());
        tblTenderColumn.setIsShown(biddingFormColumnBean.getIsShown());
        tblTenderColumn.setisGTColumn(biddingFormColumnBean.getIsGTColumn());
        tblTenderColumn.setIsPriceSummary(biddingFormColumnBean.getIsPriceSummary());
        tblTenderColumn.setSortOrder(1);
        //in edit only
        if (biddingFormColumnBean.getColumnId() != 0) {
            tblTenderColumn.setColumnId(biddingFormColumnBean.getColumnId());
        }
        return tblTenderColumn;
    }

    public TblTenderTable setBiddingFormTableParameterToTable(BiddingFormTableBean biddingFormTableBean) {
        TblTenderTable tblTenderTable = new TblTenderTable();
        tblTenderTable.setHasGTRow(biddingFormTableBean.getHasGTRow());
        tblTenderTable.setIsMandatory(biddingFormTableBean.getIsMandatory());
        tblTenderTable.setIsMultipleFilling(biddingFormTableBean.getIsMultipleFilling());
        tblTenderTable.setIsPartialFillingAllowed(biddingFormTableBean.getIsPartialFillingAllowed());
        tblTenderTable.setNoOfCols(biddingFormTableBean.getNoOfCols());
        tblTenderTable.setNoOfRows(biddingFormTableBean.getNoOfRows());

        tblTenderTable.setTableFooter(biddingFormTableBean.getTableFooter());
        tblTenderTable.setTableHeader(biddingFormTableBean.getTableHeader());
        tblTenderTable.setTableName(biddingFormTableBean.getTableName());

        tblTenderTable.setCreatedBy(biddingFormTableBean.getCreatedBy());
        tblTenderTable.setCreatedOn(biddingFormTableBean.getCreatedOn());

        tblTenderTable.setUpdatedBy(biddingFormTableBean.getUpdatedBy());
        tblTenderTable.setUpdatedOn(biddingFormTableBean.getUpdatedOn());

        tblTenderTable.setFormId(biddingFormTableBean.getFormId());
        tblTenderTable.setSortOrder(1);
        //for edit only
        if (biddingFormTableBean.getTableId() != 0) {
            tblTenderTable.setTableId(biddingFormTableBean.getTableId());
        }
        return tblTenderTable;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBiddingFormColumnDetails(List<TblTenderColumn> lstTblTenderColumn) throws Exception {
        boolean success = false;
        success = addBiddingFormColumn(lstTblTenderColumn);
        return success;
    }

    /**
     * Add new tender
     *
     * @param TblTender tblTender
     * @return boolean
     * @throws Exception
     */
    public boolean addBiddingFormColumn(List<TblTenderColumn> lstTblTenderColumn) throws Exception {
        boolean bSuccess = false;
        commonDAO.saveOrUpdateAll(lstTblTenderColumn);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addBiddingFormTableDetails(List<TblTenderTable> lstTblTenderTable) throws Exception {
        boolean success = false;
        success = addBiddingFormTable(lstTblTenderTable);
        return success;
    }

    /**
     * Add new tender
     *
     * @param TblTender tblTender
     * @return boolean
     * @throws Exception
     */
    public boolean addBiddingFormTable(List<TblTenderTable> lstTblTenderTable) throws Exception {
        boolean bSuccess = false;
        commonDAO.saveOrUpdateAll(lstTblTenderTable);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void updateTableCount(List<TblTenderTable> lstTblTenderTable) throws Exception {
        int tableMandatoryCount = 0;
        int formId = 0;
        for (TblTenderTable TblTenderTable : lstTblTenderTable) {
            formId = TblTenderTable.getFormId();
            if (TblTenderTable.getIsMandatory() == 1) {
                tableMandatoryCount++;
            }
        }
        Map<String, Object> column = new HashMap<String, Object>();
        column.put("formId", formId);
        column.put("tableMandatoryCount", tableMandatoryCount);
        StringBuilder query = new StringBuilder();
        query.append("update tbl_tenderform set minTablesReqForBidding = :tableMandatoryCount where formId=:formId");
        int cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), column);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<Object[]> ViewTenderForm(String formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        //Do not change the sequance of the column in query
        query.append("select "
                + " a.columnId,a.dataType,a.filledBy,a.columnHeader,a.isShown,"
                + " c.tableId,c.tableName ,c.tableHeader,c.tableFooter,c.noOfRows,"
                + " c.noOfCols,c.isMandatory,c.isPartialFillingAllowed,c.isMultipleFilling,c.hasGTRow,"
                + " d.formName , d.formId,d.formHeader,d.formFooter,d.noOfTables, "
                + " tblTenderCell.cellId,tblTenderCell.cellNo,tblTenderCell.cellValue,tblTenderCell.rowId,tblTenderCell.columnid,d.tenderid,a.columntypeid,a.columnNo,d.isDocumentReq,d.isMandatory formIsMandatory,d.isPriceBid ,a.isPriceSummary,a.isGTColumn,a.isCurrConvReq"
                + " from tbl_tendercell tblTenderCell "
                + " right join tbl_tendercolumn a on  tblTenderCell.columnid=a.columnId "
                + " right join tbl_tendertable c on a.tableid=c.tableId "
                + " right join tbl_tenderform d  on c.formid=d.formId "
                + " where d.formId= :formId order by c.tableId,a.columnNo,tblTenderCell.rowId,tblTenderCell.cellNo,tblTenderCell.columnid");

        List<Object[]> ls = hibernateQueryDao.createSQLQuery(query.toString(), var);
        return ls;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public TblTenderEnvelope getEnvlopeNameIdForEdit(String formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        query.append(" select t.envelopeid,e.envelopeName from tbl_tenderform t inner join tbl_tenderenvelope e on t.envelopeid=e.envelopeId and t.formId= :formId");
        List<Object[]> ls = hibernateQueryDao.createSQLQuery(query.toString(), var);
        TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();

        for (int i = 0; i < ls.size(); i++) {
            tblTenderEnvelope.setEnvelopeId(convertInt(ls.get(i)[0]));
            tblTenderEnvelope.setEnvelopeName((String) (ls.get(i)[1]));

        }
        return tblTenderEnvelope;
    }

    @Transactional
    public Map setView(List<Object[]> lst) throws Exception {
        TblTenderColumn tblTenderColumn = new TblTenderColumn();
        TblTenderTable tblTenderTable = new TblTenderTable();
        TblTenderForm tblTenderForm = new TblTenderForm();
        Map TableColumn = new HashMap();
        Map formStructure = new HashMap<String, Object>();
        Map cell = new LinkedHashMap();
        List column = new ArrayList();
        List table = new ArrayList();
        List columnStructureNo = new ArrayList();
        int tableId;
        int tenderId = 0;
        List bidderCell = new ArrayList<TblTenderCell>();
        int formId = 0;
        TblTenderCell tblTenderCell = null;
        for (int i = 0; i < lst.size(); i++) {
            tableId = convertInt(lst.get(i)[5]);
            tenderId = convertInt(lst.get(i)[25]);
            if (i == 0) {
                formId = convertInt(lst.get(i)[16]);
                tblTenderForm.setFormId(convertInt(lst.get(i)[16]));
                tblTenderForm.setFormName((String) lst.get(i)[15]);
                tblTenderForm.setFormHeader((String) lst.get(i)[17]);
                tblTenderForm.setFormFooter((String) lst.get(i)[18]);
                tblTenderForm.setNoOfTables(convertInt(lst.get(i)[19]));
                tblTenderForm.setIsDocumentReq((Integer) lst.get(i)[28]);
                tblTenderForm.setIsMandatory((Integer) lst.get(i)[29]);
                tblTenderForm.setIsPriceBid((Integer) lst.get(i)[30]);
            }
            
            tblTenderTable = new TblTenderTable();
            tblTenderTable.setTableId(tableId);
            tblTenderTable.setTableName((String) lst.get(i)[6]);
            tblTenderTable.setTableHeader((String) lst.get(i)[7]);
            tblTenderTable.setTableFooter((String) lst.get(i)[8]);
            tblTenderTable.setNoOfRows(convertInt(lst.get(i)[9]));
            tblTenderTable.setNoOfCols(convertInt(lst.get(i)[10]));
            tblTenderTable.setIsMandatory(convertInt(lst.get(i)[11]));
            tblTenderTable.setIsPartialFillingAllowed(convertInt(lst.get(i)[12]));
            tblTenderTable.setIsMultipleFilling(convertInt(lst.get(i)[13]));
            tblTenderTable.setHasGTRow(convertInt(lst.get(i)[14]));

            tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId(convertInt(lst.get(i)[0]));
            tblTenderColumn.setDataType(convertInt(lst.get(i)[1]));
            tblTenderColumn.setFilledBy(convertInt(lst.get(i)[2]));
            tblTenderColumn.setColumnHeader((String) lst.get(i)[3]);
            tblTenderColumn.setIsShown(convertInt(lst.get(i)[4]));
            tblTenderColumn.setSortOrder(convertInt(lst.get(i)[26]));
            tblTenderColumn.setColumnNo(convertInt(lst.get(i)[27]));
            tblTenderColumn.setTblTenderTable(new TblTenderTable(tableId));
            tblTenderColumn.setisGTColumn(convertInt(lst.get(i)[32]));
            tblTenderColumn.setIsPriceSummary(convertInt(lst.get(i)[31]));
            tblTenderColumn.setIsCurrConvReq(convertInt(lst.get(i)[33]));

            tblTenderCell = new TblTenderCell();
            tblTenderCell.setCellId(convertInt(lst.get(i)[20]));
            tblTenderCell.setCellNo(convertInt(lst.get(i)[21]));
            tblTenderCell.setCellValue((String) lst.get(i)[22]);
            tblTenderCell.setRowId(convertInt(lst.get(i)[23]));
            tblTenderCell.setObjectId(convertInt(lst.get(i)[24]));//setObjectId is used to set  column id in this logic

            //Form info could be same in every row so need to take one time
            if (TableColumn.containsKey(tableId)) {
                if (!columnStructureNo.contains(tblTenderColumn.getColumnId())) {
                    column = (ArrayList) TableColumn.get(tableId);
                    column.add(tblTenderColumn);
                    TableColumn.put(tableId, column);
                    columnStructureNo.add(tblTenderColumn.getColumnId());
                }
            } else {
                column = new ArrayList();
                column.add(tblTenderColumn);
                columnStructureNo.add(tblTenderColumn.getColumnId());
                TableColumn.put(tableId, column);
                table.add(tblTenderTable);
            }
            if (tblTenderCell != null) {
                cell.put(tableId + "_" + tblTenderColumn.getColumnId() + "_" + tblTenderCell.getRowId() + "_" + tblTenderCell.getCellNo(), tblTenderCell);
            }

        }
        formStructure.put("tender", tenderId + "");
        formStructure.put("form", tblTenderForm);
        formStructure.put("table", table);
        formStructure.put("column", TableColumn);
        formStructure.put("cell", cell);
        return formStructure;
    }

    @Transactional
    public Map setView(List<Object[]> lst, int companyId, boolean fromBidder, int bidderId) throws Exception {

        TblTenderColumn tblTenderColumn = new TblTenderColumn();
        TblTenderTable tblTenderTable = new TblTenderTable();
        TblTenderForm tblTenderForm = new TblTenderForm();
        Map TableColumn = new HashMap();
        Map formStructure = new HashMap<String, Object>();
        Map cell = new LinkedHashMap();
        List column = new ArrayList();
        List table = new ArrayList();
        List columnStructureNo = new ArrayList();
        int tableId;
        int tenderId = 0;
        List bidderCell = new ArrayList<TblTenderCell>();
        int formId = 0;
        TblTenderCell tblTenderCell = null;
        TblTender tblTender = null;
        for (int i = 0; i < lst.size(); i++) {
            tableId = convertInt(lst.get(i)[5]);
            tenderId = convertInt(lst.get(i)[25]);
            if (i == 0) {
                tblTender = tenderCommonService.getTenderById(tenderId);
                formId = convertInt(lst.get(i)[16]);
                tblTenderForm.setFormId(convertInt(lst.get(i)[16]));
                tblTenderForm.setFormName((String) lst.get(i)[15]);
                tblTenderForm.setFormHeader((String) lst.get(i)[17]);
                tblTenderForm.setFormFooter((String) lst.get(i)[18]);
                tblTenderForm.setNoOfTables(convertInt(lst.get(i)[19]));
                tblTenderForm.setIsDocumentReq((Integer) lst.get(i)[28]);
                tblTenderForm.setIsMandatory((Integer) lst.get(i)[29]);
                tblTenderForm.setIsPriceBid((Integer) lst.get(i)[30]);
            }

            tblTenderTable = new TblTenderTable();
            tblTenderTable.setTableId(tableId);
            tblTenderTable.setTableName((String) lst.get(i)[6]);
            tblTenderTable.setTableHeader((String) lst.get(i)[7]);
            tblTenderTable.setTableFooter((String) lst.get(i)[8]);
            tblTenderTable.setNoOfRows(convertInt(lst.get(i)[9]));
            tblTenderTable.setNoOfCols(convertInt(lst.get(i)[10]));
            tblTenderTable.setIsMandatory(convertInt(lst.get(i)[11]));
            tblTenderTable.setIsPartialFillingAllowed(convertInt(lst.get(i)[12]));
            tblTenderTable.setIsMultipleFilling(convertInt(lst.get(i)[13]));
            tblTenderTable.setHasGTRow(convertInt(lst.get(i)[14]));

            tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId(convertInt(lst.get(i)[0]));
            tblTenderColumn.setDataType(convertInt(lst.get(i)[1]));
            tblTenderColumn.setFilledBy(convertInt(lst.get(i)[2]));
            tblTenderColumn.setColumnHeader((String) lst.get(i)[3]);
            tblTenderColumn.setIsShown(convertInt(lst.get(i)[4]));
            tblTenderColumn.setSortOrder(convertInt(lst.get(i)[26]));
            tblTenderColumn.setColumnNo(convertInt(lst.get(i)[27]));
            tblTenderColumn.setTblTenderTable(new TblTenderTable(tableId));
            tblTenderColumn.setisGTColumn(convertInt(lst.get(i)[32]));
            tblTenderColumn.setIsPriceSummary(convertInt(lst.get(i)[31]));
            tblTenderColumn.setIsCurrConvReq(convertInt(lst.get(i)[33]));

            if (fromBidder) {
                if (i == 0) {
                    List<TblTenderCell> bidDetaillst = getTblBidDetail(formId, companyId, bidderId);
                    for (TblTenderCell bid : bidDetaillst) {
                        TblTenderCell bidderCell_cell = new TblTenderCell();
                        bidderCell_cell.setCellId(bid.getCellId());
                        bidderCell_cell.setCellNo(bid.getCellNo());
                        if((reportService.getTblTenderopen(formId,bidderId) == null) ||(reportService.getTblTenderopen(formId,bidderId) !=null && reportService.getTblTenderopen(formId,bidderId).getDecryptionlevel() !=1)){
                        	bidderCell_cell.setCellValue(encrptDecryptUtils.decrypt(bid.getCellValue(), tblTender.getRandPass().substring(0, 16).getBytes()));
                        }else{
                        	bidderCell_cell.setCellValue(bid.getCellValue());
                        }
                        bidderCell_cell.setRowId(bid.getRowId());
                        bidderCell_cell.setObjectId(bid.getObjectId());
                        bidderCell_cell.setTblTenderTable(bid.getTblTenderTable());
                        bidderCell_cell.setTblTenderColumn(bid.getTblTenderColumn());
                        bidderCell.add(bidderCell_cell);
                    }
                }
            } else {
                tblTenderCell = new TblTenderCell();
                tblTenderCell.setCellId(convertInt(lst.get(i)[20]));
                tblTenderCell.setCellNo(convertInt(lst.get(i)[21]));
                tblTenderCell.setCellValue((String) lst.get(i)[22]);
                tblTenderCell.setRowId(convertInt(lst.get(i)[23]));
                tblTenderCell.setObjectId(convertInt(lst.get(i)[24]));//setObjectId is used to set  column id in this logic
            }

            //Form info could be same in every row so need to take one time
            if (TableColumn.containsKey(tableId)) {

                if (!columnStructureNo.contains(tblTenderColumn.getColumnId())) {
                    column = (ArrayList) TableColumn.get(tableId);
                    column.add(tblTenderColumn);
                    TableColumn.put(tableId, column);
                    columnStructureNo.add(tblTenderColumn.getColumnId());
                }
            } else {
                column = new ArrayList();
                column.add(tblTenderColumn);
                columnStructureNo.add(tblTenderColumn.getColumnId());
                TableColumn.put(tableId, column);
                table.add(tblTenderTable);
            }
            if (tblTenderCell != null) {
                cell.put(tableId + "_" + tblTenderColumn.getColumnId() + "_" + tblTenderCell.getRowId() + "_" + tblTenderCell.getCellNo(), tblTenderCell);
            }

        }
        if (fromBidder) {
            List<TblTenderCellGrandTotal> tblTenderCellGrandTotal = getTblTenderCellGrandTotal(tenderId, bidderId, formId);
            formStructure.put("TenderCellGrandTotalList", tblTenderCellGrandTotal);
        }
        formStructure.put("tender", tenderId + "");
        formStructure.put("form", tblTenderForm);
        formStructure.put("table", table);
        if (fromBidder) {
            formStructure.put("column", TableColumn);
            formStructure.put("cell", bidderCell);
        } else {
            formStructure.put("column", TableColumn);
            formStructure.put("cell", cell);
        }

        return formStructure;
    }

    @Transactional
    public List<TblTenderCellGrandTotal> getTblTenderCellGrandTotal(int tenderId, Object[] bidderIds, int formId, boolean bool) throws Exception {
        List<TblTenderCellGrandTotal> list = new ArrayList<TblTenderCellGrandTotal>();
        list = tblTenderCellGrandTotalDao.findTblTenderCellGrandTotal("tblTender.tenderId", Operation_enum.EQ, tenderId, "tblBidder.bidderId", Operation_enum.IN, bidderIds, "tblTenderForm.formId", Operation_enum.EQ, formId, "tblBidder.bidderId", Operation_enum.ORDERBY, Operation_enum.ASC, "tblTenderColumn.columnId", Operation_enum.ORDERBY, Operation_enum.ASC);
        if (bool) {
            return decryptGrandTotal(tenderId, list);
        } else {
            return list;
        }
    }
    
    
    @Transactional
    public TblBidder getTblBidderCompanyId(int companyId) throws Exception {
    	List<TblBidder> list = tblBidderDao.findTblBidder("tblCompany.companyid", Operation_enum.EQ, companyId);
    	return (list != null && !list.isEmpty()) ? list.get(0) : null;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<Object[]> getFormLibraryByEnvType(Integer[] formType, Integer tenderId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        if(formType != null && formType.length > 0){
        	var.put("formType", formType);
        }
        query.append("select f.formId,f.formName,f.envelopeId,e.envId,e.envelopeName,f.formWeight from tbl_tenderform f "
                + " inner join tbl_tender t on f.tenderId=t.tenderId "
                + " inner join tbl_tenderenvelope e on e.envelopeId = f.envelopeId where 1 =1 ");
                if(formType != null && formType.length > 0){
                    
                	query.append(" and e.envid in (:formType)  ");
                }
                query.append(" and t.tenderId =:tenderId  and f.cstatus<>2  order by e.envId");

        List<Object[]> lst = hibernateQueryDao.createSQLQuery(query.toString(), var);
        return lst;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<Object[]> getFormForTender(Integer tenderId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        query.append("select f.formId,f.formName,f.envelopeId,e.envId,e.envelopeName,f.formWeight,f.isMandatory from tbl_tenderform f "
                + " inner join tbl_tender t on f.tenderId=t.tenderId "
                + " inner join tbl_tenderenvelope e on e.envelopeId = f.envelopeId where isMandatory=1 ");
                query.append(" and t.tenderId =:tenderId  and f.cstatus<>2  order by e.envId");

        List<Object[]> lst = hibernateQueryDao.createSQLQuery(query.toString(), var);
        return lst;
    }
    
    @Transactional
    private List<TblTenderCellGrandTotal> decryptGrandTotal(int tenderId, List<TblTenderCellGrandTotal> list) throws Exception {
        TblTender tblTender = tenderCommonService.getTenderById(tenderId);
        List<TblTenderCellGrandTotal> newlist = new ArrayList<TblTenderCellGrandTotal>();
        for (TblTenderCellGrandTotal tblTenderCellGrandTotal : list) {
            TblTenderCellGrandTotal tenderCellGrandTotal = new TblTenderCellGrandTotal();
            tenderCellGrandTotal.setCellGrandTotalId(tblTenderCellGrandTotal.getCellGrandTotalId());
            if((reportService.getTblTenderopen(tblTenderCellGrandTotal.getTblTenderForm().getFormId(),tblTenderCellGrandTotal.getTblBidder().getBidderId()) == null ) || (reportService.getTblTenderopen(tblTenderCellGrandTotal.getTblTenderForm().getFormId(),tblTenderCellGrandTotal.getTblBidder().getBidderId()) != null && reportService.getTblTenderopen(tblTenderCellGrandTotal.getTblTenderForm().getFormId(),tblTenderCellGrandTotal.getTblBidder().getBidderId()).getDecryptionlevel() !=1)){
            	tenderCellGrandTotal.setGTValue(encrptDecryptUtils.decrypt(tblTenderCellGrandTotal.getGTValue(), tblTender.getRandPass().substring(0, 16).getBytes()));
            }else{
            	tenderCellGrandTotal.setGTValue(tblTenderCellGrandTotal.getGTValue());
            }
            
            tenderCellGrandTotal.setTblBidder(tblTenderCellGrandTotal.getTblBidder());
            tenderCellGrandTotal.setTblTender(tblTenderCellGrandTotal.getTblTender());
            tenderCellGrandTotal.setTblTenderColumn(tblTenderCellGrandTotal.getTblTenderColumn());
            tenderCellGrandTotal.setTblTenderForm(tblTenderCellGrandTotal.getTblTenderForm());
            tenderCellGrandTotal.setTblTenderTable(tblTenderCellGrandTotal.getTblTenderTable());
            newlist.add(tenderCellGrandTotal);
        }
        return newlist;
    }
    
    @Transactional
    public List<TblTenderCellGrandTotal> getTblTenderCellGrandTotal(int tenderId, int bidderId, int formId) throws Exception {
        List<TblTenderCellGrandTotal> list = new ArrayList<TblTenderCellGrandTotal>();
        list = tblTenderCellGrandTotalDao.findTblTenderCellGrandTotal("tblTender.tenderId", Operation_enum.EQ, tenderId, "tblBidder.bidderId", Operation_enum.EQ, bidderId, "tblTenderForm.formId", Operation_enum.EQ, formId);
        return decryptGrandTotal(tenderId, list);
    }

   /* @Transactional
    public List<TblTenderCell> getTblBidDetail(int formId, int companyId,int bidderId) throws Exception {
        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        
        var.put("formId", formId);
        var.put("bidderId",bidderId);
        StringBuffer query = new StringBuffer();
        query.append("SELECT distinct case when cl.filledby=2 then ifnull(bd.cellId,0) ");
        query.append("when cl.filledby=1 then ifnull(tc.cellId,0) ");
        query.append("when cl.filledby=3 then ifnull(bd.cellId,0)end as cellId, ");
        query.append("ifnull(tc.cellNo,0) cellNo, ");
        query.append(" case when cl.filledby=2 then ifnull(bd.cellValue,'0') " );
        query.append(" when cl.filledby=1 then ifnull(tc.cellValue,'0')  " );
        query.append(" when cl.filledby=3 then ifnull(bd.cellValue,'0') " );
        query.append(" end as cellVal, " );
        query.append(" ifnull(cl.dataType,0) dataType, " );
        query.append(" ifnull(tc.objectId,0) objectId, " );
        query.append(" ifnull(tc.rowId,0) rowId, ");
        query.append(" cl.columnId, " );
        query.append(" cl.formId, " );
        query.append(" tt.tableId,cl.filledby,cl.isGTColumn " );
        query.append(" FROM Tbl_tendertable tt " );
        query.append(" inner join Tbl_tendercolumn cl on tt.formid=cl.formid " );
        query.append(" left outer join Tbl_TenderCell tc on cl.formid=tc.formId and cl.columnId=tc.columnid " );
        query.append(" left outer join Tbl_BidDetail bd on cl.formid=bd.formId and cl.columnId=bd.columnid and bd.cellid = tc.cellId " );//and bd.cellid = tc.cellId added cond later
        query.append(" inner join tbl_bidder b on b.companyId=bd.companyId " );
        query.append(" WHERE tt.formId=:formId and b.bidderId=:bidderId");
        

        list = hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        List<TblTenderCell> tblTenderCellList = new ArrayList<TblTenderCell>();
        for (Object[] obj : list) {
            TblTenderCell tblTenderCell = new TblTenderCell();
            tblTenderCell.setCellId(Integer.parseInt(obj[0].toString()));
            tblTenderCell.setCellNo(Integer.parseInt(obj[1].toString()));
            TblTenderColumn tblTenderColumn=new TblTenderColumn();
            tblTenderColumn.setFilledBy((Integer)obj[9]);
            tblTenderColumn.setColumnId(Integer.parseInt(obj[6].toString()));
            tblTenderColumn.setisGTColumn((Integer)obj[10]);
            tblTenderCell.setCellValue(obj[2].toString());
            tblTenderCell.setDataType(Integer.parseInt(obj[3].toString()));
            tblTenderCell.setObjectId(Integer.parseInt(obj[4].toString()));
            tblTenderCell.setRowId(Integer.parseInt(obj[5].toString()));
            tblTenderCell.setTblTenderColumn(tblTenderColumn);
            tblTenderCell.setTblTenderForm(new TblTenderForm(Integer.parseInt(obj[7].toString())));
            tblTenderCell.setTblTenderTable(new TblTenderTable(Integer.parseInt(obj[8].toString())));
            
            tblTenderCellList.add(tblTenderCell);
        }
        
        return tblTenderCellList;

    }*/
    /**
    *
    * @author Lipi Shah
    */
    @Transactional
    public List<TblTenderCell> getTblBidDetail(int formId, int companyId, int bidderId) throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        var.put("companyId", companyId);
        StringBuffer query = new StringBuffer();
        query.append(" SELECT tblBidDetail.cellId, tblTenderCell.cellNo,tblBidDetail.cellValue,tblTenderCell.dataType,tblTenderCell.objectId");
        query.append(" ,tblTenderCell.rowId,tblTenderCell.tblTenderColumn.columnId,tblBidDetail.tblTenderForm.formId,tblTenderCell.tblTenderTable.tableId");
        query.append(" FROM TblBidDetail tblBidDetail,TblTenderCell tblTenderCell");
        query.append(" WHERE tblBidDetail.tblCompany.companyid =:companyId");
        query.append(" AND tblBidDetail.cellId=tblTenderCell.cellId");
        query.append(" AND tblBidDetail.tblTenderForm.formId=:formId");
        query.append(" GROUP BY tblBidDetail.cellId");
        query.append(" ORDER BY tblTenderCell.rowId");

        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderCell> tblTenderCellList = new ArrayList<TblTenderCell>();
        for (Object[] obj : list) {
            TblTenderCell tblTenderCell = new TblTenderCell();
            tblTenderCell.setCellId(Integer.parseInt(obj[0].toString()));
            tblTenderCell.setCellNo(Integer.parseInt(obj[1].toString()));
            tblTenderCell.setCellValue(obj[2].toString());
            tblTenderCell.setDataType(Integer.parseInt(obj[3].toString()));
            tblTenderCell.setObjectId(Integer.parseInt(obj[4].toString()));
            tblTenderCell.setRowId(Integer.parseInt(obj[5].toString()));
            tblTenderCell.setTblTenderColumn(new TblTenderColumn(Integer.parseInt(obj[6].toString())));
            tblTenderCell.setTblTenderForm(new TblTenderForm(Integer.parseInt(obj[7].toString())));
            tblTenderCell.setTblTenderTable(new TblTenderTable(Integer.parseInt(obj[8].toString())));
            tblTenderCellList.add(tblTenderCell);
        }
        return tblTenderCellList;

    }
    @Transactional
    public Map getFormula(int formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        query.append("select f.formula,c.columnId,c.formId from tbl_tenderformula f inner join tbl_tendercolumn c "
                + " on f.columnId=c.columnId where c.formId= :formId");
        List<Object[]> lst = hibernateQueryDao.createSQLQuery(query.toString(), var);
        Map<String, String> FormulaAndColumn = new LinkedHashMap<String, String>();
        for (int i = 0; i < lst.size(); i++) {
            FormulaAndColumn.put(lst.get(i)[1].toString(), lst.get(i)[0].toString());
        }
        return FormulaAndColumn;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map getFormulaPerColumn(String formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        //Do not change the sequance of the column in query
        query.append("select f.formula,c.columnId,c.formId from tbl_tenderformula f inner join tbl_tendercolumn c "
                + " on f.columnId=c.columnId where c.formId= :formId");
        List<Object[]> lst = hibernateQueryDao.createSQLQuery(query.toString(), var);
        Map FormulaAndColumn = new LinkedHashMap();
        for (int i = 0; i < lst.size(); i++) {
            FormulaAndColumn.put(lst.get(i)[1] + "", lst.get(i)[0] + "");
        }
        return FormulaAndColumn;
    }

    public List getLastFormulaColumn(Map FormulaAndColumn) {
        Collection<String> collectionValues = FormulaAndColumn.values();
        List LastFormulaColumn = new ArrayList<Integer>();
        for (String formula : collectionValues) {
            if (formula != null) {
                LastFormulaColumn.add(convertInt(formula.substring(formula.lastIndexOf("_") + 1).trim()));
            }
        }
        return LastFormulaColumn;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderCell> setJsonValueForBiddingForm(HttpServletRequest request) throws Exception {
        String json = checkRequestNull(request, "txtJson");
        String formId = "";
        JSONObject jobj = new JSONObject(json);
        Iterator itr = jobj.keys();
        List<TblTenderCell> lstCell = new ArrayList<TblTenderCell>();

        while (itr.hasNext()) {
            String k = (String) itr.next();
            JSONObject jsonObj = jobj.getJSONObject(k);

            TblTenderForm tblTenderForm = new TblTenderForm();
            TblTenderTable tblTenderTable = new TblTenderTable();
            formId = jsonObj.getString("FormId");
            tblTenderForm.setFormId(convertInt(jsonObj.getString("FormId")));
            tblTenderTable.setTableId(convertInt(jsonObj.getString("TableId")));
            JSONObject jsonObj3 = jsonObj.getJSONObject("ColumnJsonval");
            Iterator itr2 = jsonObj3.keys();
            while (itr2.hasNext()) {
                String keyCol = (String) itr2.next();
                TblTenderColumn tblTenderColumn = new TblTenderColumn();
                JSONObject jsonObjColumn = jsonObj3.getJSONObject(keyCol);
                TblTenderCell tblTenderCell = new TblTenderCell();
                tblTenderCell.setCellNo(convertInt(jsonObjColumn.getString("colNo")));
                tblTenderCell.setDataType(0);
                tblTenderCell.setObjectId(1);
                tblTenderCell.setCellValue(jsonObjColumn.getString("val"));
                tblTenderCell.setRowId(convertInt(jsonObjColumn.getString("row")));
                tblTenderColumn.setColumnId(convertInt(jsonObjColumn.getString("key")));
                tblTenderCell.setTblTenderColumn(tblTenderColumn);
                tblTenderCell.setTblTenderForm(tblTenderForm);
                tblTenderCell.setTblTenderTable(tblTenderTable);
                lstCell.add(tblTenderCell);
            }
        }
        removeCell(formId);
        return lstCell;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderCell> addBidderBid(HttpServletRequest request) throws Exception {
        String json = checkRequestNull(request, "txtJson");
        String formId = "";
        JSONObject jobj = new JSONObject(json);
        Iterator itr = jobj.keys();
        List<TblTenderCell> lstCell = new ArrayList<TblTenderCell>();

        while (itr.hasNext()) {
            String k = (String) itr.next();
            JSONObject jsonObj = jobj.getJSONObject(k);

            TblTenderForm tblTenderForm = new TblTenderForm();
            TblTenderTable tblTenderTable = new TblTenderTable();
            formId = jsonObj.getString("FormId");
            tblTenderForm.setFormId(convertInt(jsonObj.getString("FormId")));
            tblTenderTable.setTableId(convertInt(jsonObj.getString("TableId")));
            JSONObject jsonObj3 = jsonObj.getJSONObject("ColumnJsonval");
            Iterator itr2 = jsonObj3.keys();
            while (itr2.hasNext()) {
                String keyCol = (String) itr2.next();
                TblTenderColumn tblTenderColumn = new TblTenderColumn();
                JSONObject jsonObjColumn = jsonObj3.getJSONObject(keyCol);
                TblTenderCell tblTenderCell = new TblTenderCell();
                tblTenderCell.setCellNo(convertInt(jsonObjColumn.getString("colNo")));
                tblTenderCell.setDataType(0);
                tblTenderCell.setObjectId(1);
                tblTenderCell.setCellValue(jsonObjColumn.getString("val"));
                tblTenderCell.setRowId(convertInt(jsonObjColumn.getString("row")));
                tblTenderColumn.setColumnId(convertInt(jsonObjColumn.getString("key")));
                tblTenderCell.setTblTenderColumn(tblTenderColumn);
                tblTenderCell.setTblTenderForm(tblTenderForm);
                tblTenderCell.setTblTenderTable(tblTenderTable);
                lstCell.add(tblTenderCell);
            }
        }

        removeCell(formId);
        return lstCell;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean removeCell(String formId) throws Exception {
        boolean success = false;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        int cnt = 0;
        var.put("formId", formId);
        query.append("delete from tbl_tendercell  where formid = :formId");
        cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);
        return cnt != 0;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addCell(List<TblTenderCell> lstTblTenderCell) throws Exception {
        boolean success = false;
        success = addCellForm(lstTblTenderCell);
        return success;
    }

    public boolean addCellForm(List<TblTenderCell> lstTblTenderCell) throws Exception {
        boolean bSuccess = false;
        commonDAO.saveOrUpdateAll(lstTblTenderCell);
        bSuccess = true;
        return bSuccess;
    }

    public boolean addAuctionStopResume(TblAuctionStopResume tblAuctionStopResume) throws Exception {
        boolean bSuccess = false;
        commonDAO.saveOrUpdate(tblAuctionStopResume);
        bSuccess = true;
        return bSuccess;
    }
    
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public TblAuctionStopResume getLastAuctionStopId(Integer tenderId)throws Exception
    {
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId", tenderId);
        StringBuilder query=new StringBuilder();
        query.append("select auctionstopresumeId,remark,status,createdon,createdby,auctionstartdate,auctionenddate,tenderId from tbl_auctionstopresume where tenderId=:tenderId and status=1 order by auctionstopresumeId desc limit 1");
        List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
        tblAuctionStopResume.setTblTender(new TblTender(tenderId));
        tblAuctionStopResume.setauctionstopresumeId((Integer)lst.get(0)[0]);
        tblAuctionStopResume.setremark((String)lst.get(0)[1]);
        tblAuctionStopResume.setstatus((Integer)lst.get(0)[2]);
        tblAuctionStopResume.setcreatedon((Date)lst.get(0)[3]);
        tblAuctionStopResume.setcreatedby((Integer)lst.get(0)[4]);
        tblAuctionStopResume.setauctionstartdate((Date)lst.get(0)[5]);
        tblAuctionStopResume.setauctionenddate((Date)lst.get(0)[6]);
        return tblAuctionStopResume;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void updateLastAuctionStopEndDate(TblAuctionStopResume tblAuctionStopResume) throws Exception {
        commonDAO.saveOrUpdate(tblAuctionStopResume);
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void StopAuction(TblTender tblTender) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        if (tblTender.getIsAuctionStop() == 1) {
            tblTender.setIsAuctionStop(0);
            commonDAO.saveOrUpdate(tblTender);
        } else {
            var.put("tenderId", tblTender.getTenderId());
            query.append("update tbl_tender set isAuctionStop=1 where tenderId=:tenderId");
            int cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);
        }

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderForm> FormListing(int tenderId) throws Exception{
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);

        //Do not change the sequance of the column in query
        /* query.append("select tblTenderForm.formId,tblTenderForm.formName,tblTenderForm.cstatus,a.envelopeId,a.envelopeName,"
                + " tblTenderForm.isDocumentReq,tblTenderForm.isPriceBid,"
                + " (select count(filledBy) from tbl_tendercolumn where formId=tblTenderForm.formId and filledBy=3 ) isAuto, "
                + " (select count(formulaId) from tbl_tenderformula where formId=tblTenderForm.formId  )isFormulaCreated ,tblTenderForm.isMandatory"
                + " ,e.envId from tbl_tenderform tblTenderForm "
                + " inner join tbl_tenderenvelope a "
                + " on tblTenderForm.envelopeId=a.envelopeId "
               + " inner join tbl_envelope e on a.envid=e.envId"
               
                + " where tblTenderForm.Tenderid = :tenderId and tblTenderForm.cstatus!=2 order by e.envId "
                + "");
         */
        query.append("select "
                + "f.formId,f.formName,f.cstatus,e.envelopeId,e.envelopeName,"
                + "                 f.isDocumentReq,f.isPriceBid,"
                + "                 (select count(filledBy) from tbl_tendercolumn where formId=f.formId and filledBy=3 ) isAuto, "
                + "                 (select count(formulaId) from tbl_tenderformula where formId=f.formId  )isFormulaCreated ,f.isMandatory"
                + "                 ,en.envId"
                + " from tbl_envelope en "
                + " inner join tbl_tenderenvelope e on en.envId=e.envid"
                + " left outer join tbl_tenderform f on f.envelopeid=e.envelopeId AND f.CSTATUS!=2"
                + " where e.tenderid=:tenderId order by en.envId");
        List<Object[]> ls = hibernateQueryDao.createSQLQuery(query.toString(), var);
        List<TblTenderForm> lstForm = new ArrayList();
        TblTenderForm tblTenderForm = new TblTenderForm();
        for (int i = 0; i < ls.size(); i++) {

            tblTenderForm = new TblTenderForm();
            tblTenderForm.setFormId(convertInt(ls.get(i)[0]));
            tblTenderForm.setFormName((String) ls.get(i)[1]);
            tblTenderForm.setCstatus(convertInt(ls.get(i)[2]));
            TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();
            tblTenderEnvelope.setEnvelopeName((String) ls.get(i)[4]);
            tblTenderEnvelope.setEnvelopeId(convertInt(ls.get(i)[10]));
            tblTenderForm.setTblTenderEnvelope(tblTenderEnvelope);
            tblTenderForm.setIsDocumentReq(convertInt(ls.get(i)[5]));
            tblTenderForm.setIsPriceBid(convertInt(ls.get(i)[6]));
            tblTenderForm.setLoadNoOfItems(convertInt(ls.get(i)[7])); //this method is use to check if any auto column is available or not
            tblTenderForm.setIsEncryptionReq(convertInt(ls.get(i)[8])); // THIS METHOD IS USED TO CHECK WHETHER FORMULA IS CREATED OR NOT
            tblTenderForm.setIsMandatory(convertInt(ls.get(i)[9]));
          //  tblTenderForm.setIsPriceSummryDone(checkIfPriceSummryCreated(tblTenderForm.getFormId()));
            lstForm.add(tblTenderForm);
        }
        return lstForm;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTender> TenderListing() {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        //Do not change the sequance of the column in query
        query.append("select TblTender.tenderId,TblTender.tenderNo,TblTender.tenderBrief"
                + " from TblTender TblTender ");

        List<Object[]> ls = hibernateQueryDao.createQuery(query.toString(), var);
        List<TblTender> lstTender = new ArrayList();
        TblTender tblTender = new TblTender();
        for (int i = 0; i < ls.size(); i++) {

            tblTender = new TblTender();
            tblTender.setTenderId(convertInt(ls.get(i)[0]));
            tblTender.setTenderNo((String) ls.get(i)[1]);
            tblTender.setTenderBrief((String) ls.get(i)[2]);
            lstTender.add(tblTender);
        }

        return lstTender;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderEnvelope> EnvelopeFromTenderId(String tenderId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        //Do not change the sequance of the column in query
        query.append("select tblTenderEnvelope.envelopeId,a.lang1"
                + " from TblTenderEnvelope tblTenderEnvelope "
                + " inner join tblTenderEnvelope.tblEnvelope a"
                + " where  tblTenderEnvelope.tblTender = :tenderId");

        List<Object[]> ls = hibernateQueryDao.createQuery(query.toString(), var);
        List<TblTenderEnvelope> lstEnvelope = new ArrayList();
        TblTenderEnvelope TblTenderEnvelope = new TblTenderEnvelope();
        for (int i = 0; i < ls.size(); i++) {

            TblTenderEnvelope = new TblTenderEnvelope();
            TblTenderEnvelope.setEnvelopeId(convertInt(ls.get(i)[0]));
            TblTenderEnvelope.setEnvelopeName((String) ls.get(i)[1]);
            lstEnvelope.add(TblTenderEnvelope);
        }

        return lstEnvelope;
    }

    @Transactional

    public void copyFormForTenderCopy(String fromTenderId, String toTenderId, Map envIds) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", fromTenderId);
        //Do not change the sequance of the column in query
        query.append("select TblTenderForm.formId,TblTenderForm.formName"
                + " from    TblTenderForm TblTenderForm              "
                + " where  TblTenderForm.tblTender.tenderId = :tenderId and  TblTenderForm.cstatus!=2");

        List<Object[]> ls = hibernateQueryDao.createQuery(query.toString(), var);
        String[] formId = new String[ls.size()];
        for (int i = 0; i < ls.size(); i++) {
            formId[i] = ls.get(i)[0] + "";
        }
        copyForm(formId, toTenderId, envIds);

    }

    @Transactional
    public void copyForm(String[] formIds, String tenderId, Map mapFormId) throws Exception {
        Map TenderFormDetails = new LinkedHashMap();
        int count = 0;
        long userId = 1;

        for (String form : formIds) {
            Map formStructure = setCopyForm(CopyTenderForm(form));

            TenderFormDetails.put(count++, formStructure);
        }
        for (int i = 0; i < TenderFormDetails.size(); i++) {
            Map formStructure = (Map) TenderFormDetails.get(i);
            List<TblTenderTable> lstTblTenderTable = new ArrayList<TblTenderTable>();
            List<TblTenderColumn> lstTblTenderColumn = new ArrayList<TblTenderColumn>();
            List<TblTenderCell> lstTblTenderCell = new ArrayList<TblTenderCell>();
            List<TblTenderFormula> lstTblTenderFormula = new ArrayList<TblTenderFormula>();
            List<TblTenderGovColumn> lstTblTenderGovColumn = new ArrayList<TblTenderGovColumn>();
            List<TblTenderDocument> lstTblTenderDoc = new ArrayList<TblTenderDocument>();
            List<TblTenderCellGrandTotal> lstTblTenderGrandTotal = new ArrayList<TblTenderCellGrandTotal>();
            Map ColIdsMap = new LinkedHashMap();
            TblTenderForm tblTenderForm = (TblTenderForm) formStructure.get("form");
            int formId = tblTenderForm.getFormId();
            tblTenderForm.setFormId(0);
            tblTenderForm.setCreatedOn(new Date());
            tblTenderForm.setCstatus(0);

            TblTender tblTender = new TblTender();
            tblTender.setTenderId(convertInt(tenderId));
            tblTenderForm.setTblTender(tblTender);

            Integer eId = (Integer.parseInt(mapFormId.get(tblTenderForm.getTblTenderEnvelope().getEnvelopeId()) + ""));
            TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();
            Integer newEid = eId;
            tblTenderEnvelope.setEnvelopeId(newEid);
            tblTenderForm.setTblTenderEnvelope(tblTenderEnvelope);

            boolean status = addBiddingFormDetails(tblTenderForm);
            List<TblTenderTable> lstTable = (List) formStructure.get("table");
            Map TableColumn = (Map) formStructure.get("column");
            Map Cell = (Map) formStructure.get("cellNew");
            for (TblTenderTable tblTenderTable : lstTable) {
                int tblId = tblTenderTable.getTableId();
                tblTenderTable.setFormId(tblTenderForm.getFormId());
                tblTenderTable.setCreatedOn(new Date());
                tblTenderTable.setUpdatedOn(new Date());
                tblTenderTable.setTableId(0);
                tblTenderTable.setSortOrder(0);
                lstTblTenderTable.add(tblTenderTable);

                List lstColumn = (List) TableColumn.get(tblId);
                for (int j = 0; j < lstColumn.size(); j++) {
                    TblTenderColumn tblTenderColumn = (TblTenderColumn) lstColumn.get(j);
                    int colId = tblTenderColumn.getColumnId();

                    List lstCell = (List) Cell.get(tblTenderColumn.getColumnId());

                    List<TblTenderFormula> lstFormula = (List) getColumnFormulaForCopyForm(formId, tblTenderColumn.getColumnId());
                    List<TblTenderGovColumn> lstGovColumn = (List) getGovColumnForCopyForm(formId, tblTenderColumn.getColumnId(), tblId);
                    tblTenderColumn.setColumnId(0);
                    tblTenderColumn.setTblTenderForm(tblTenderForm);
                    tblTenderColumn.setTblTenderTable(tblTenderTable);

                    lstTblTenderColumn.add(tblTenderColumn);
                    if (tblTenderForm.getIsPriceBid() != 1) {
                        for (int k = 0; k < lstCell.size(); k++) {
                            TblTenderCell tblTenderCell = (TblTenderCell) lstCell.get(k);
                            tblTenderCell.setCellId(0);
                            tblTenderCell.setTblTenderColumn(tblTenderColumn);
                            tblTenderCell.setTblTenderTable(tblTenderTable);
                            tblTenderCell.setTblTenderForm(tblTenderForm);
                            lstTblTenderCell.add(tblTenderCell);

                        }

                    }
                    ColIdsMap.put(colId, tblTenderColumn);

                    for (TblTenderFormula tblTenderFormula : lstFormula) {
                        tblTenderFormula.setFormulaId(0);
                        tblTenderFormula.setTblTenderForm(tblTenderForm);
                        tblTenderFormula.setTblTenderColumn(tblTenderColumn);
                        tblTenderFormula.setTblTenderTable(tblTenderTable);
                        lstTblTenderFormula.add(tblTenderFormula);
                    }
                    for (TblTenderGovColumn tblTenderGovColumn : lstGovColumn) {
                        tblTenderGovColumn.setGovColumnId(0);
                        tblTenderGovColumn.setTblTenderForm(tblTenderForm);
                        tblTenderGovColumn.setTblTenderColumn(tblTenderColumn);
                        tblTenderGovColumn.setTblTenderTable(tblTenderTable);
                        tblTenderGovColumn.setTblTender(tblTender);
                        lstTblTenderGovColumn.add(tblTenderGovColumn);
                    }

                }

            }
            List<TblTenderDocument> tblTenderDoc = getDocumentForCopyForm(formId);
            for (TblTenderDocument tblTenderDocument : tblTenderDoc) {
                tblTenderDocument.setDocumentId(0);
                tblTenderDocument.setTblTenderForm(tblTenderForm);
                tblTenderDocument.setTblTender(tblTender);
                lstTblTenderDoc.add(tblTenderDocument);
            }
            status = addBiddingFormTableDetails(lstTblTenderTable);
            status = addBiddingFormColumnDetails(lstTblTenderColumn);
            if (tblTenderForm.getIsPriceBid() != 1) {
                status = addCell(lstTblTenderCell);
            }
            Set<Integer> colKeys = ColIdsMap.keySet();
            List<TblTenderFormula> lstTblTenderFormulaWithFormula = new ArrayList<TblTenderFormula>();

            for (TblTenderFormula tblTenderFormula : lstTblTenderFormula) {
                String formula = tblTenderFormula.getFormula();
                for (Integer key : colKeys) {

                    if (formula.contains(key + "")) {
                        TblTenderColumn tblTenderColumn = (TblTenderColumn) ColIdsMap.get(key);
                        formula = formula.replaceAll(key + "", tblTenderColumn.getColumnId() + "");
                    }
                }
                tblTenderFormula.setFormula(formula);

                lstTblTenderFormulaWithFormula.add(tblTenderFormula);
            }
            status = addDocumentform(lstTblTenderDoc);
            status = addEvaluationColumn(lstTblTenderGovColumn);
            status = addFormula(lstTblTenderFormulaWithFormula);
        }

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void copyForm(String[] formIds, String tenderId, String envId, HttpServletRequest request) throws Exception {
        Map TenderFormDetails = new LinkedHashMap();
        int count = 0;
        HttpSession session = request.getSession();
        SessionBean sessionBean = (SessionBean) session.getAttribute(CommonKeywords.SESSION_OBJ.toString());
        long userId = 1;

        if (sessionBean != null) {
            userId = sessionBean.getUserId();
        }

        for (String form : formIds) {

            Map formStructure = setCopyForm(CopyTenderForm(form));
            TenderFormDetails.put(count++, formStructure);
        }

        for (int i = 0; i < TenderFormDetails.size(); i++) {
            Map formStructure = (Map) TenderFormDetails.get(i);
            List<TblTenderTable> lstTblTenderTable = new ArrayList<TblTenderTable>();
            List<TblTenderColumn> lstTblTenderColumn = new ArrayList<TblTenderColumn>();
            List<TblTenderCell> lstTblTenderCell = new ArrayList<TblTenderCell>();
            List<TblTenderFormula> lstTblTenderFormula = new ArrayList<TblTenderFormula>();
            List<TblTenderGovColumn> lstTblTenderGovColumn = new ArrayList<TblTenderGovColumn>();
            List<TblTenderDocument> lstTblTenderDoc = new ArrayList<TblTenderDocument>();
            TblTenderForm tblTenderForm = (TblTenderForm) formStructure.get("form");

            Map ColIdsMap = new LinkedHashMap();
            int formId = tblTenderForm.getFormId();
            tblTenderForm.setFormId(0);
            tblTenderForm.setCstatus(0);
            tblTenderForm.setCreatedOn(new Date());
            tblTenderForm.setCreatedBy(((int) userId));
            TblTender tblTender = new TblTender();
            tblTender.setTenderId(convertInt(tenderId));

            tblTenderForm.setTblTender(tblTender);
            TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();

            if (tblTender.getisAuction() == 0) {
                tblTenderEnvelope.setEnvelopeId(convertInt(envId));

            } else {
                tblTenderEnvelope = TenderEnvelope(convertInt(tenderId));

            }
            tblTenderForm.setTblTenderEnvelope(tblTenderEnvelope);

            boolean status = addBiddingFormDetails(tblTenderForm);

            List<TblTenderTable> lstTable = (List) formStructure.get("table");
            Map TableColumn = (Map) formStructure.get("column");
            Map Cell = (Map) formStructure.get("cellNew");

            for (TblTenderTable tblTenderTable : lstTable) {
                int tblId = tblTenderTable.getTableId();
                tblTenderTable.setFormId(tblTenderForm.getFormId());
                tblTenderTable.setCreatedOn(new Date());
                tblTenderTable.setUpdatedOn(new Date());
                tblTenderTable.setTableId(0);
                tblTenderTable.setSortOrder(0);
                tblTenderTable.setCreatedBy(((int) userId));
                lstTblTenderTable.add(tblTenderTable);

                List lstColumn = (List) TableColumn.get(tblId);
                for (int j = 0; j < lstColumn.size(); j++) {
                    TblTenderColumn tblTenderColumn = (TblTenderColumn) lstColumn.get(j);
                    int colId = tblTenderColumn.getColumnId();
                    List lstCell = (List) Cell.get(colId);
                    List<TblTenderFormula> lstFormula = (List) getColumnFormulaForCopyForm(formId, colId);
                    List<TblTenderGovColumn> lstGovColumn = (List) getGovColumnForCopyForm(formId, colId, tblId);
                    tblTenderColumn.setColumnId(0);
                    tblTenderColumn.setTblTenderForm(tblTenderForm);
                    tblTenderColumn.setTblTenderTable(tblTenderTable);
                    lstTblTenderColumn.add(tblTenderColumn);

                    if (tblTenderForm.getIsPriceBid() != 1) {
                        for (int k = 0; k < lstCell.size(); k++) {
                            TblTenderCell tblTenderCell = (TblTenderCell) lstCell.get(k);
                            tblTenderCell.setCellId(0);
                            tblTenderCell.setTblTenderColumn(tblTenderColumn);
                            tblTenderCell.setTblTenderTable(tblTenderTable);
                            tblTenderCell.setTblTenderForm(tblTenderForm);
                            lstTblTenderCell.add(tblTenderCell);

                        }
                    }
                    ColIdsMap.put(colId, tblTenderColumn);

                    for (TblTenderFormula tblTenderFormula : lstFormula) {
                        tblTenderFormula.setFormulaId(0);
                        tblTenderFormula.setTblTenderForm(tblTenderForm);
                        tblTenderFormula.setTblTenderColumn(tblTenderColumn);
                        tblTenderFormula.setTblTenderTable(tblTenderTable);
                        lstTblTenderFormula.add(tblTenderFormula);
                    }

                    for (TblTenderGovColumn tblTenderGovColumn : lstGovColumn) {
                        tblTenderGovColumn.setGovColumnId(0);
                        tblTenderGovColumn.setTblTenderForm(tblTenderForm);
                        tblTenderGovColumn.setTblTenderColumn(tblTenderColumn);
                        tblTenderGovColumn.setTblTenderTable(tblTenderTable);
                        tblTenderGovColumn.setTblTender(tblTender);
                        lstTblTenderGovColumn.add(tblTenderGovColumn);
                    }

                }

            }

            List<TblTenderDocument> tblTenderDoc = getDocumentForCopyForm(formId);
            for (TblTenderDocument tblTenderDocument : tblTenderDoc) {
                tblTenderDocument.setDocumentId(0);
                tblTenderDocument.setTblTenderForm(tblTenderForm);
                tblTenderDocument.setTblTender(tblTender);
                lstTblTenderDoc.add(tblTenderDocument);
            }

            status = addBiddingFormTableDetails(lstTblTenderTable);
            status = addBiddingFormColumnDetails(lstTblTenderColumn);
            if (tblTenderForm.getIsPriceBid() != 1) {
                status = addCell(lstTblTenderCell);
            }
            Set<Integer> colKeys = ColIdsMap.keySet();
            List<TblTenderFormula> lstTblTenderFormulaWithFormula = new ArrayList<TblTenderFormula>();

            for (TblTenderFormula tblTenderFormula : lstTblTenderFormula) {
                String formula = tblTenderFormula.getFormula();
                for (Integer key : colKeys) {

                    if (formula.contains(key + "")) {
                        TblTenderColumn tblTenderColumn = (TblTenderColumn) ColIdsMap.get(key);
                        formula = formula.replaceAll(key + "", tblTenderColumn.getColumnId() + "");
                    }
                }
                tblTenderFormula.setFormula(formula);

                lstTblTenderFormulaWithFormula.add(tblTenderFormula);
            }
            status = addDocumentform(lstTblTenderDoc);
            status = addEvaluationColumn(lstTblTenderGovColumn);
            status = addFormula(lstTblTenderFormulaWithFormula);

        }

    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public TblTenderEnvelope TenderEnvelope(Integer tenderId) throws Exception {
        List<TblTenderEnvelope> list = commonDAO.findEntity(TblTenderEnvelope.class, "tblTender.tenderId", Operation_enum.EQ, tenderId);
        TblTenderEnvelope tblTenderEnvelope = list.get(0);
        return tblTenderEnvelope;
    }

    /**
     * ********hemal changes*******************
     */
    /**
     * **************************************
     */
    /**
     * **need to add***************************
     */
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public TblTender BiddingTypeFromTender(Integer tenderId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        //Do not change the sequance of the column in query
        query.append("select tblTender.biddingType,tblTender.tenderId,tblTender.isAuction,tblTender.isItemwiseWinner"
                + " from TblTender tblTender "
                + " where  tblTender.tenderId = :tenderId");

        List<Object[]> ls = hibernateQueryDao.createQuery(query.toString(), var);
        TblTender tblTender = new TblTender();
        for (int i = 0; i < ls.size(); i++) {
            tblTender.setBiddingType((Integer) ls.get(i)[0]);
            tblTender.setTenderId((Integer) ls.get(i)[1]);
            tblTender.setisAuction((Integer) ls.get(i)[2]);
            tblTender.setIsItemwiseWinner((Integer) ls.get(i)[3]);
        }
        return tblTender;
    }

    
    
    public List<TblTenderForm> getFormById(Integer formId) throws Exception {
        return commonDAO.findEntity(TblTenderForm.class, "formId", Operation_enum.EQ, formId);
    }
    
    /**
     * ********hemal changes*******************
     */

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderForm> FormData(Integer formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        //Do not change the sequance of the column in query
        query.append("select tblTenderForm.formId,tblTenderForm.formName,tblTenderForm.formHeader,"
                + " tblTenderForm.formFooter,tblTenderForm.incrementItems,tblTenderForm.isDocumentReq,tblTenderForm.isEncryptedDocument,tblTenderForm.isEncryptionReq,"
                + " tblTenderForm.isMandatory,tblTenderForm.isMultipleFilling,tblTenderForm.isEvaluationReq,"
                + " tblTenderForm.isPriceBid,tblTenderForm.isSecondary,tblTenderForm.noOfTables"
                + " from TblTenderForm tblTenderForm where tblTenderForm.formId = :formId");

        List<Object[]> ls = hibernateQueryDao.createQuery(query.toString(), var);
        List<TblTenderForm> lstForm = new ArrayList();
        TblTenderForm tblTenderForm = new TblTenderForm();
        for (int i = 0; i < ls.size(); i++) {

            tblTenderForm = new TblTenderForm();
            tblTenderForm.setFormId(convertInt(ls.get(i)[0]));
            tblTenderForm.setFormName((String) ls.get(i)[1]);
            tblTenderForm.setFormHeader((String) ls.get(i)[2]);
            tblTenderForm.setFormFooter((String) ls.get(i)[3]);
            tblTenderForm.setIsDocumentReq(convertInt(ls.get(i)[5]));
            tblTenderForm.setIsMandatory(convertInt(ls.get(i)[8]));

            lstForm.add(tblTenderForm);
        }

        return lstForm;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void publishForm(Integer formId) {
        Map<String, Object> column = new HashMap<String, Object>();
        column.put("formId", formId);

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map getTableStructure(Integer formId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        TblTenderColumn tblTenderColumn = new TblTenderColumn();
        TblTenderTable tblTenderTable = new TblTenderTable();
        TblTenderForm tblTenderForm = new TblTenderForm();
        Map TableColumn = new HashMap();
        Map formStructure = new HashMap();
        List column = new ArrayList();
        List table = new ArrayList();
        List columnStructureNo = new ArrayList();
        int tableId;
        int tenderId = 0;
        StringBuilder tblColumn;

        query.append("select tblTenderColumn.columnId,tblTenderColumn.dataType,tblTenderColumn.filledBy,tblTenderColumn.columnHeader,tblTenderColumn.isShown,"
                + "c.tableId,c.tableName ,c.tableHeader,c.tableFooter,c.noOfRows,c.noOfCols,c.isMandatory,c.isPartialFillingAllowed,"
                + "c.isMultipleFilling,c.hasGTRow,d.formName ,d.formId,d.formHeader,d.formFooter,d.noOfTables from TblTenderColumn tblTenderColumn "
                + " inner join tblTenderColumn.tblTenderTable c"
                + " inner join tblTenderColumn.tblTenderForm d "
                + " "
                + ""
                + "where d.formId= :formId");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);

        for (int i = 0; i < lst.size(); i++) {

            tblTenderColumn = new TblTenderColumn();
            tblColumn = new StringBuilder();
            tblTenderTable = new TblTenderTable();

            tblColumn.append("columnId:" + convertInt(lst.get(i)[0]) + "#dataType:" + convertInt(lst.get(i)[1]) + "#filledBy" + convertInt(lst.get(i)[2]) + "#columnHeader" + (String) lst.get(i)[3] + "#isShown" + convertInt(lst.get(i)[4]));
            tblTenderColumn.setColumnId(convertInt(lst.get(i)[0]));
            tblTenderColumn.setDataType(convertInt(lst.get(i)[1]));
            tblTenderColumn.setFilledBy(convertInt(lst.get(i)[2]));
            tblTenderColumn.setColumnHeader((String) lst.get(i)[3]);
            tblTenderColumn.setIsShown(convertInt(lst.get(i)[4]));

            tableId = convertInt(lst.get(i)[5]);
            tblTenderTable.setTableId(tableId);
            tblTenderTable.setTableName((String) lst.get(i)[6]);
            tblTenderTable.setTableHeader((String) lst.get(i)[7]);
            tblTenderTable.setTableFooter((String) lst.get(i)[8]);
            tblTenderTable.setNoOfRows(convertInt(lst.get(i)[9]));
            tblTenderTable.setNoOfCols(convertInt(lst.get(i)[10]));
            tblTenderTable.setIsMandatory(convertInt(lst.get(i)[11]));
            tblTenderTable.setIsPartialFillingAllowed(convertInt(lst.get(i)[12]));
            tblTenderTable.setIsMultipleFilling(convertInt(lst.get(i)[13]));
            tblTenderTable.setHasGTRow(convertInt(lst.get(i)[14]));
            //Form info could be same in every row so need to take one time
            if (i == 0) {
                tblTenderForm.setFormId(convertInt(lst.get(i)[16]));
                tblTenderForm.setFormName((String) lst.get(i)[15]);
                tblTenderForm.setFormHeader((String) lst.get(i)[17]);
                tblTenderForm.setFormFooter((String) lst.get(i)[18]);
                tblTenderForm.setNoOfTables(convertInt(lst.get(i)[19]));
            }
            if (TableColumn.containsKey(tableId)) {

                if (!columnStructureNo.contains(tblTenderColumn.getColumnId())) {
                    column = (ArrayList) TableColumn.get(tableId);
                    column.add(tblTenderColumn);
                    TableColumn.put(tableId, column);
                    columnStructureNo.add(tblTenderColumn.getColumnId());
                }
            } else {
                column = new ArrayList();
                column.add(tblTenderColumn);
                columnStructureNo.add(tblTenderColumn.getColumnId());

                TableColumn.put(tableId, column);
                table.add(tblTenderTable);
            }

        }
        formStructure.put("table", table);
        formStructure.put("column", TableColumn);

        return formStructure;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map GetFormulaColumns(Integer formId) {

        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        query.append("select t.columnId,t.columnHeader,t.columnNo,t.dataType,t.filledBy,t.tblTenderTable "
                + " from TblTenderColumn t where (t.dataType=3 or t.dataType=4 or t.dataType=5 or t.filledBy=3 ) "
                + " and t.tblTenderForm.formId= :formId ");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        TblTenderColumn tblTenderColumn;
        int filledBy = 0;
        Map AutoColumnMap = new LinkedHashMap();
        Map ColumnMap = new LinkedHashMap();
        Map formulaColumnMap = new LinkedHashMap();
        List lstColumn = new ArrayList();
        for (int i = 0; i < lst.size(); i++) {

            tblTenderColumn = new TblTenderColumn();

            tblTenderColumn.setColumnId(convertInt(lst.get(i)[0]));
            tblTenderColumn.setColumnHeader((String) lst.get(i)[1]);
            TblTenderTable o = (TblTenderTable) lst.get(i)[5];
            filledBy = convertInt(lst.get(i)[4]);
            if (filledBy == 3) {
            
                AutoColumnMap.put(o.getTableId() + "_" + tblTenderColumn.getColumnId(), tblTenderColumn);
            }

            if (!ColumnMap.containsKey(o.getTableId() + "")) {
                lstColumn = new ArrayList();
            }
            lstColumn.add(tblTenderColumn);
            ColumnMap.put(o.getTableId() + "", lstColumn);

        }
        formulaColumnMap.put("formId", formId.toString());
        formulaColumnMap.put("AutoColumn", AutoColumnMap);
        formulaColumnMap.put("columnList", ColumnMap);

        return formulaColumnMap;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List getBidForConversion(Integer tenderId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        StringBuilder query = new StringBuilder();
        query.append("select bd.bidDetailId,bd.cellId,bd.cellValue,tc.filledBy,tc.isCurrConvReq,tc.columnId,tc.formId,tc.tableId,tt.randPass,tb.bidderId from tbl_biddetail bd "
                + " inner join tbl_bidder tb on tb.companyId=bd.companyId  "
                + " inner join tbl_tenderform tf on tf.formId=bd.formId  "
                + " inner join tbl_tender tt on tt.tenderId=tf.tenderId  "
                + " inner join tbl_tendercell tc1 on tc1.cellId=bd.cellId "
                + " inner join tbl_tendercolumn tc on tc.columnId=tc1.columnId "
                + " where tt.tenderId=:tenderId and tc.filledBy in (2,3)");
        List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        List<TblBidDetail> lstBidDetail = new ArrayList<TblBidDetail>();
        for (int i = 0; i < lst.size(); i++) {
            TblBidDetail tblBidDetail = new TblBidDetail();
            tblBidDetail.setBidDetailId((Integer) lst.get(i)[0]);
            tblBidDetail.setCellId((Integer) lst.get(i)[1]);
            String randPass = (String) lst.get(i)[8];
            tblBidDetail.setCellValue((String) lst.get(i)[2]);
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId((Integer) lst.get(i)[5]);
            tblTenderColumn.setFilledBy((Integer) lst.get(i)[3]);
            tblTenderColumn.setIsCurrConvReq((Integer) lst.get(i)[4]);
            tblTenderColumn.setTblTenderForm(new TblTenderForm((Integer) lst.get(i)[6]));
            tblTenderColumn.setTblTenderTable(new TblTenderTable((Integer) lst.get(i)[7]));
            tblBidDetail.setTblTenderColumn(tblTenderColumn);
            tblBidDetail.setTblCompany(new TblCompany((Integer) lst.get(i)[9]));

            lstBidDetail.add(tblBidDetail);
        }
        return lstBidDetail;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List GetFormulaGrid(Integer formId) {

        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        query.append("select t.formulaId,t.displayFormula,t.tblTenderColumn,t.formula "
                + " from TblTenderFormula t where  t.tblTenderForm.formId= :formId");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        TblTenderColumn tblTenderColumn;
        TblTenderFormula tblTenderFormula;
        List lstColumnFormula = new ArrayList();

        for (int i = 0; i < lst.size(); i++) {
            tblTenderFormula = new TblTenderFormula();
            tblTenderFormula.setFormulaId(convertInt(lst.get(i)[0]));
            tblTenderFormula.setDisplayFormula((String) (lst.get(i)[1]));
            tblTenderFormula.setFormula((String) (lst.get(i)[3]));
            tblTenderColumn = new TblTenderColumn();
            tblTenderFormula.setTblTenderColumn((TblTenderColumn) lst.get(i)[2]);
            lstColumnFormula.add(tblTenderFormula);

        }

        return lstColumnFormula;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})

    public int SaveFormula(HttpServletRequest request) {
        String formula = checkRequestNull(request, "frmFormFormula");
        String formId = checkRequestNull(request, "hdnFormId");
        String formulaToDisplay = checkRequestNull(request, "txtaFormFormula");
        String colId = checkRequestNull(request, "formulaColumn");
        String formulaId = checkRequestNull(request, "hdnFormulaId");

        TblTenderFormula tblTenderFormula = new TblTenderFormula();
        if (formulaId.trim().length() != 0) {
            tblTenderFormula.setFormulaId(convertInt(formulaId));
        }
        TblTenderForm tblTenderForm = new TblTenderForm();
        TblTenderColumn tblTenderColumn = new TblTenderColumn();
        TblTenderTable tblTenderTable = new TblTenderTable();
        boolean bSuccess = false;
        tblTenderFormula.setDisplayFormula(formulaToDisplay);
        tblTenderFormula.setFormula(formula);

        tblTenderForm.setFormId(convertInt(formId));
        tblTenderFormula.setTblTenderForm(tblTenderForm);
        tblTenderColumn.setColumnId(convertInt(colId));
        tblTenderFormula.setTblTenderColumn(tblTenderColumn);

        tblTenderTable.setTableId(19);
        tblTenderFormula.setTblTenderTable(tblTenderTable);

        tblTenderFormula.setCellId(0);
        tblTenderFormula.setCellNo(0);
        tblTenderFormula.setColFormula("");
        tblTenderFormula.setColumnNo(0);
        tblTenderFormula.setFormulaId(0);
        tblTenderFormula.setValidationMessage("");
        //tblTenderFormula.set

        if (formulaId.trim().length() != 0) {
            tblTenderFormula.setFormulaId(convertInt(formulaId));
            StringBuilder query = new StringBuilder();
            Map<String, Object> var = new HashMap<String, Object>();
            int cnt = 0;
            var.put("formulaId", formulaId);
            var.put("formulaToDisplay", formulaToDisplay);
            var.put("colId", colId);
            var.put("formula", formula);

            query.append("update tbl_tenderformula set displayFormula= :formulaToDisplay,formula= :formula,columnId= :colId  where formulaId = :formulaId");
            cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);
            return 2;
        } else {
            StringBuilder query = new StringBuilder();
            Map<String, Object> var = new HashMap<String, Object>();
            int cnt = 0;
            var.put("colId", colId);

            query.append("select TblTenderFormula.formulaId,TblTenderFormula.formula from TblTenderFormula TblTenderFormula where TblTenderFormula.tblTenderColumn.columnId= :colId");
            List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
            if (lst.size() > 0) {
                return 0;
            }

            commonDAO.saveOrUpdate(tblTenderFormula);
            return 1;
        }

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean RemoveFormula(Integer formulaId) {
        boolean success = false;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        int cnt = 0;
        var.put("formulaId", formulaId);
        query.append("delete from tbl_tenderformula  where formulaId = :formulaId");
        cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);
        return cnt != 0;
    }

    public ArrayList<TblTenderDocument> setDocumentFormParameters(HttpServletRequest request) throws Exception {
        ArrayList<TblTenderDocument> lstFormDocumentBean = new ArrayList<TblTenderDocument>();
        String formId = checkRequestNull(request, "formId");
        String tenderId = checkRequestNull(request, "tenderId");
        String json = checkRequestNull(request, "DocumentJson");
        JSONObject jobj = new JSONObject(json);
        JSONObject jsonObjTable = jobj.getJSONObject("DocumentJsonObj");
        Iterator itr = jsonObjTable.keys();
        while (itr.hasNext()) {
            String k = (String) itr.next();
            JSONObject jsonObj = jsonObjTable.getJSONObject(k);
            TblTenderDocument tblTenderDocument = new TblTenderDocument();
            tblTenderDocument.setDocumentName(jsonObj.getString("DocumentName"));
            tblTenderDocument.setIsMandatory(jsonObj.getInt("IsMandatory"));
            TblTender tblTender = new TblTender();
            tblTender.setTenderId(Integer.parseInt(tenderId));
            tblTenderDocument.setTblTender(tblTender);
            TblTenderForm tblTenderForm = new TblTenderForm();
            tblTenderForm.setFormId(Integer.parseInt(formId));
            tblTenderDocument.setTblTenderForm(tblTenderForm);
            lstFormDocumentBean.add(tblTenderDocument);
        }
        return lstFormDocumentBean;
    }

    public ArrayList<TblTenderGovColumn> setJsonValueForEvaluationColumn(HttpServletRequest request) throws Exception {
        ArrayList<TblTenderGovColumn> lstTblTenderGovColumn = new ArrayList<TblTenderGovColumn>();
        String formId = checkRequestNull(request, "formId");
        String tenderId = checkRequestNull(request, "tenderId");
        String json = checkRequestNull(request, "EvaluationColumnJson");

        JSONObject jsonObject = new JSONObject(json);
        JSONObject colJsonObject = jsonObject.getJSONObject("EvaluationColumnJsonObj");
        Iterator iterator = colJsonObject.keys();
        while (iterator.hasNext()) {
            String key = (String) iterator.next();
            TblTenderForm tblTenderForm = new TblTenderForm();
            tblTenderForm.setFormId(colJsonObject.getInt("formId"));
            TblTender tblTender = new TblTender();
            tblTender.setTenderId(colJsonObject.getInt("tenderId"));
            if (key.equals("EavluationColumnObj")) {
                JSONObject EvaluationJsonObj = colJsonObject.getJSONObject("EavluationColumnObj");
                Iterator itr = EvaluationJsonObj.keys();
                while (itr.hasNext()) {
                    String k = (String) itr.next();
                    JSONObject jobj = EvaluationJsonObj.getJSONObject(k);
                    TblTenderGovColumn tblTenderGovColumn = new TblTenderGovColumn();
                    tblTenderGovColumn.setCellId(0);
                    tblTenderGovColumn.setColumnNo(0);
                    tblTenderGovColumn.setGovColumnId(0);
                    tblTenderGovColumn.setIpAddress("0.0.0.0");
                    TblTenderColumn tblTenderColumn = new TblTenderColumn();
                    tblTenderColumn.setColumnId(jobj.getInt("columnId"));
                    TblTenderTable tblTenderTable = new TblTenderTable();
                    tblTenderTable.setTableId(jobj.getInt("tableId"));
                    tblTenderGovColumn.setTblTenderColumn(tblTenderColumn);
                    tblTenderGovColumn.setTblTenderTable(tblTenderTable);
                    tblTenderGovColumn.setTblTenderForm(tblTenderForm);
                    tblTenderGovColumn.setTblTender(tblTender);
                    lstTblTenderGovColumn.add(tblTenderGovColumn);
                }
            }

        }
        return lstTblTenderGovColumn;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public StringBuilder getEvaluationColumnName(List<TblTenderGovColumn> lstTblTenderGovColumns) {

        StringBuilder query = new StringBuilder();
        StringBuilder msg = new StringBuilder();
        StringBuilder saveMsg = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();

        for (TblTenderGovColumn TblTenderGovColumn : lstTblTenderGovColumns) {
            query = new StringBuilder();
            var = new HashMap<String, Object>();
            var.put("columnId", TblTenderGovColumn.getTblTenderColumn().getColumnId());
            
           // query.append("select TblTenderColumn.columnId,TblTenderColumn.columnHeader from TblTenderColumn TblTenderColumn where TblTenderColumn.columnId= :columnId");
           query.append("select tblTenderColumn.columnId,tblTenderColumn.columnHeader from TblTenderColumn tblTenderColumn where tblTenderColumn.columnId= :columnId"); 
           List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
            msg.append(lst.get(0)[1] + ",");
        }
        if (msg != null && msg.length() > 0) {
            saveMsg.append(msg.substring(0, msg.length() - 1) + " is(are) selected as Evalution column(s).");
        }
        return saveMsg;

    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map<Integer,Integer> checkIfEvaluationColumnSet(Integer tenderId)throws Exception
    {
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId",tenderId);
        Map<Integer,Integer> map=new HashMap<Integer,Integer>();
        StringBuilder query=new StringBuilder();
        query.append("select tc.formId,count(case when tc.columnId=tg.columnid then 1 end) from tbl_tendercolumn tc " +
                    " left join tbl_tendergovcolumn tg on tg.columnid=tc.columnId " +
                    " where tc.formId In (select formId from tbl_tenderform where tenderId=:tenderId)  " +
                    " group by tc.formId");
        List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        if(lst != null && !lst.isEmpty()&& lst.size()>0){
            for(int i=0;i<lst.size();i++){
                map.put(Integer.parseInt(lst.get(i)[0].toString()),Integer.parseInt(lst.get(i)[1].toString()));
            }
        }
        return map;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addEvaluationColumn(List<TblTenderGovColumn> lstTblTenderGovColumns) {
        boolean bSuccess = false;
        commonDAO.saveOrUpdateAll(lstTblTenderGovColumns);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addGTColumn(List<TblTenderCellGrandTotal> lstTblTenderCellGrandTotal) {
        boolean bSuccess = false;
        commonDAO.saveOrUpdateAll(lstTblTenderCellGrandTotal);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addDocumentform(List<TblTenderDocument> lstTblTenderDocument) {
        boolean bSuccess = false;
        commonDAO.saveOrUpdateAll(lstTblTenderDocument);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean addFormula(List<TblTenderFormula> lstTblTenderFormula) {
        boolean bSuccess = false;
        commonDAO.saveOrUpdateAll(lstTblTenderFormula);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map getDocumentFormDetail(Integer formId) {
        Map map = new HashMap();
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        query.append("select tblTenderForm.formId,tblTenderForm.createdOn,tblTenderForm.formName,tblTenderForm.isDocumentReq,tblTenderForm.isMandatory,"
                + "tblTenderForm.isPriceBid,te.envelopeName,tblTenderForm.formWeight,te.tblEnvelope.envId from TblTenderForm tblTenderForm "
                + " inner join tblTenderForm.tblTenderEnvelope te  "
                + "where tblTenderForm.formId= :formId");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        if(lst!=null && lst.size()>0)
        {
        map.put("FormId", lst.get(0)[0]);
        map.put("CreatedOn", lst.get(0)[1]);
        map.put("FormName", lst.get(0)[2]);
        map.put("IsDocReq", lst.get(0)[3]);
        map.put("IsMandatory", lst.get(0)[4]);
        map.put("IsPriceBid", lst.get(0)[5]);
        map.put("envelopeName", lst.get(0)[6]);
        map.put("formWeight", lst.get(0)[7]);
        map.put("envId", lst.get(0)[8]);
        }
        return map;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public ArrayList getColumnsForGrandTotal(Integer formId) {
        ArrayList<TblTenderColumn> lstGrandTotal = new ArrayList<TblTenderColumn>();
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        //Do not change the sequance of the column in query
        query.append("select tblTenderColumn.columnId,tblTenderColumn.columnHeader,tblTenderColumn.isGTColumn"
                + " from TblTenderColumn tblTenderColumn "
                + " inner join tblTenderColumn.tblTenderForm d "
                + "where d.formId= :formId and tblTenderColumn.dataType in (3,4,5) and tblTenderColumn.tblColumnType.columnTypeId != 2");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        for (int i = 0; i < lst.size(); i++) {
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId(convertInt(lst.get(i)[0]));
            tblTenderColumn.setColumnHeader((String) lst.get(i)[1]);
            tblTenderColumn.setisGTColumn(convertInt(lst.get(i)[2]));
            lstGrandTotal.add(tblTenderColumn);
        }

        return lstGrandTotal;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public TblTender getTenderDetails(Integer tenderId) {
        ArrayList<TblTenderColumn> lstGrandTotal = new ArrayList<TblTenderColumn>();
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);

        //Do not change the sequance of the column in query
        query.append("select t.isItemwiseWinner,t.tenderId from TblTender t where t.tenderId= :tenderId");

        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        TblTender tblTender = new TblTender();

        for (int i = 0; i < lst.size(); i++) {
            tblTender.setIsItemwiseWinner(convertInt(lst.get(i)[0]));
        }

        return tblTender;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map getColumnsForPriceSummury(Integer formId) {
        Map map = new HashMap();
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        //Do not change the sequance of the column in query
        query.append("select tblTenderColumn.columnId,tblTenderColumn.columnHeader,t.tableId,t.tableName"
                + " from TblTenderColumn tblTenderColumn "
                + " inner join tblTenderColumn.tblTenderForm d "
                + " inner join tblTenderColumn.tblTenderTable t"
                + ""
                + "where d.formId= :formId and tblTenderColumn.tblColumnType in (3,4)");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        ArrayList<TblTenderColumn> lstTblTenderColumn = new ArrayList<TblTenderColumn>();
        for (int i = 0; i < lst.size(); i++) {
            TblTenderTable tblTenderTable = new TblTenderTable();
            tblTenderTable.setTableId((Integer) lst.get(i)[2]);
            tblTenderTable.setTableName((String) lst.get(i)[3]);
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId((Integer) lst.get(i)[0]);
            tblTenderColumn.setColumnHeader((String) lst.get(i)[1]);
            lstTblTenderColumn.add(tblTenderColumn);
            if (!map.containsKey(tblTenderTable)) {

            }
        }

        return map;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})

    public Map getEvaluationColumn(Integer formId,int operation) {
        Map map = new HashMap();
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        //Do not change the sequance of the column in query
        
        if(operation==1){
            query.append("select tblTenderColumn.columnId,tblTenderColumn.dataType,tblTenderColumn.filledBy,tblTenderColumn.columnHeader,tblTenderColumn.isShown,"
                + "c.tableId,c.tableName ,c.tableHeader,c.tableFooter,c.noOfRows,c.noOfCols,c.isMandatory,c.isPartialFillingAllowed,"
                + "c.isMultipleFilling,c.hasGTRow,d.formName ,d.formId,d.formHeader,d.formFooter,d.noOfTables from TblTenderColumn tblTenderColumn "
                + " inner join tblTenderColumn.tblTenderTable c"
                + " inner join tblTenderColumn.tblTenderForm d "
                + " "
                + ""
                + "where d.formId= :formId and tblTenderColumn.tblColumnType.columnTypeId in (4,3) ");
        }
        else{
        query.append("select tblTenderColumn.columnId,tblTenderColumn.dataType,tblTenderColumn.filledBy,tblTenderColumn.columnHeader,tblTenderColumn.isShown,"
                + "c.tableId,c.tableName ,c.tableHeader,c.tableFooter,c.noOfRows,c.noOfCols,c.isMandatory,c.isPartialFillingAllowed,"
                + "c.isMultipleFilling,c.hasGTRow,d.formName ,d.formId,d.formHeader,d.formFooter,d.noOfTables from TblTenderColumn tblTenderColumn "
                + " inner join tblTenderColumn.tblTenderTable c"
                + " inner join tblTenderColumn.tblTenderForm d "
                + " "
                + ""
                + "where d.formId= :formId and tblTenderColumn.tblColumnType.columnTypeId in (4,3) "
                + " and tblTenderColumn.columnId not in(select tg.tblTenderColumn.columnId from TblTenderGovColumn tg  where tg.tblTenderForm.formId= :formId  ) ");
        }
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        List tbllst = new ArrayList();
        for (int i = 0; i < lst.size(); i++) {
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId((Integer) lst.get(i)[0]);
            tblTenderColumn.setColumnHeader((String) lst.get(i)[3]);
            Integer tblId = (Integer) lst.get(i)[5];
            String tblName = (String) lst.get(i)[6];
            String key = tblName + "$" + tblId;
            if (!map.containsKey(key)) {
                tbllst = new ArrayList();

            }
            tbllst.add(new JSONObject(tblTenderColumn));

            map.put(key, tbllst);

        }
        Map evaluationMap = new HashMap();
        evaluationMap.put("EvaluationColumn", map);

        return evaluationMap;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderDocument> getAllDocumentDetail(Integer formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        query.append("select tblTenderDocument.documentId,tblTenderDocument.isMandatory,tblTenderDocument.documentName"
                + " from TblTenderDocument tblTenderDocument "
                + " inner join tblTenderDocument.tblTenderForm tblTenderForm"
                + " where tblTenderForm.formId= :formId");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderDocument> lstTblTenderDocument = new ArrayList<TblTenderDocument>();
        for (int i = 0; i < lst.size(); i++) {
            TblTenderDocument tblTenderDocument = new TblTenderDocument();
            tblTenderDocument.setDocumentId((Integer) lst.get(i)[0]);
            tblTenderDocument.setIsMandatory((Integer) lst.get(i)[1]);
            tblTenderDocument.setDocumentName((String) lst.get(i)[2]);
            TblTenderForm tblTenderForm = new TblTenderForm();
            tblTenderForm.setFormId(formId);
            tblTenderDocument.setTblTenderForm(tblTenderForm);
            lstTblTenderDocument.add(tblTenderDocument);
        }
        return lstTblTenderDocument;
    }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderGovColumn> getAllEvaluationColumn(Integer formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        query.append("select tblTenderGovColumn.govColumnId,tblTenderTable.tableName,tblTenderColumn.columnHeader,tblTenderTable.tableId,tblTenderColumn.columnId,"
                + " tblTenderGovColumn.cellId,tblTenderGovColumn.columnNo,tblTenderGovColumn.ipAddress"
                + " from TblTenderGovColumn tblTenderGovColumn "
                + " inner join tblTenderGovColumn.tblTenderColumn tblTenderColumn"
                + " inner join tblTenderGovColumn.tblTenderForm tblTenderForm"
                + " inner join tblTenderGovColumn.tblTenderTable tblTenderTable"
                + " where tblTenderForm.formId= :formId");
        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderGovColumn> lstTblTenderGovColumn = new ArrayList<TblTenderGovColumn>();
        for (int i = 0; i < lst.size(); i++) {
            TblTenderGovColumn tblTenderGovColumn = new TblTenderGovColumn();
            tblTenderGovColumn.setGovColumnId((Integer) lst.get(i)[0]);
            TblTenderTable tblTenderTable = new TblTenderTable();
            tblTenderTable.setTableId((Integer) lst.get(i)[3]);
            tblTenderTable.setTableName((String) lst.get(i)[1]);
            tblTenderGovColumn.setTblTenderTable(tblTenderTable);
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId((Integer) lst.get(i)[4]);
            tblTenderColumn.setColumnHeader((String) lst.get(i)[2]);
            tblTenderGovColumn.setTblTenderColumn(tblTenderColumn);
            tblTenderGovColumn.setCellId((Integer) lst.get(i)[5]);
            tblTenderGovColumn.setColumnNo((Integer) lst.get(i)[6]);
            tblTenderGovColumn.setIpAddress((String) lst.get(i)[7]);
            lstTblTenderGovColumn.add(tblTenderGovColumn);
        }
        return lstTblTenderGovColumn;
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean UpdateDocumentForm(TblTenderDocument tblTenderDocument) {
        boolean bSuccess = false;
        commonDAO.saveOrUpdate(tblTenderDocument);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean UpdateEvaluationColumn(TblTenderGovColumn tblTenderGovColumn) {
        boolean bSuccess = false;
        commonDAO.saveOrUpdate(tblTenderGovColumn);
        bSuccess = true;
        return bSuccess;
    }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean DeleteDocumentForm(TblTenderDocument tblTenderDocument) {
        boolean bSuccess = false;
        commonDAO.delete(tblTenderDocument);
        bSuccess = true;
        return bSuccess;
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean DeleteEvaluationColumn(TblTenderGovColumn tblTenderGovColumn) {
        boolean bSuccess = false;
        commonDAO.delete(tblTenderGovColumn);
        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean EditBiddingForm(TblTenderForm tblTenderForm) throws Exception {
        boolean bSuccess = false;

        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", tblTenderForm.getFormId());
        query.append("select isMandatory,formId from TblTenderForm where formId= :formId");

        List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);
        int isMandatory = 0;
        int MandatoryCount = 0;
        for (int i = 0; i < lst.size(); i++) {
            isMandatory = (Integer) lst.get(i)[0];
        }

        query = new StringBuilder();
        var = new HashMap<String, Object>();
        var.put("envId", tblTenderForm.getTblTenderEnvelope().getEnvelopeId());
        query.append("select TblTenderEnvelope.noOfFormsReq,TblTenderEnvelope.envelopeName from TblTenderEnvelope TblTenderEnvelope where TblTenderEnvelope.envelopeId= :envId");

        List<Object[]> lst1 = hibernateQueryDao.createNewQuery(query.toString(), var);
        MandatoryCount = convertInt(lst1.get(0)[0]);
        if (isMandatory != tblTenderForm.getIsMandatory()) {
            if (tblTenderForm.getIsMandatory() == 1) {
                MandatoryCount++;
            } else {
                MandatoryCount--;
            }

        }
        commonDAO.update(tblTenderForm);

        query = new StringBuilder();
        var = new HashMap<String, Object>();
        var.put("MandatoryCount", MandatoryCount);
        var.put("envelopeId", tblTenderForm.getTblTenderEnvelope().getEnvelopeId());

        query.append("update tbl_tenderenvelope set noOfFormsReq=:MandatoryCount where envelopeId= :envelopeId");
        int cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);

        bSuccess = true;
        return bSuccess;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})

    public boolean editBiddingFormTable(TblTenderTable lstTblTenderTable) throws Exception {

        StringBuilder query = new StringBuilder();
        boolean bSuccess = false;
        commonDAO.saveOrUpdate(lstTblTenderTable);
        bSuccess = true;
        return bSuccess;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})

    public boolean editBiddingFormColumn(TblTenderColumn lstTblTenderColumn) throws Exception {
        StringBuilder query = new StringBuilder();
        boolean bSuccess = false;
        commonDAO.saveOrUpdate(lstTblTenderColumn);
        bSuccess = true;
        return bSuccess;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public String DeleteBiddingFormColumn(TblTenderColumn tblTenderColumn) {
        boolean success = false;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        int cnt = 0, status = 0;
        String errorMsg = "";
        var.put("columnId", tblTenderColumn.getColumnId());
        TblTenderTable tblTenderTable = new TblTenderTable();
        tblTenderTable = (TblTenderTable) tblTenderColumn.getTblTenderTable();

        StringBuilder query2 = new StringBuilder();
        query2.append("select columnId from tbl_tenderformula  where columnId= :columnId");
        List<Object[]> lst2 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);

        if (lst2.size() > 0) {
            status = 1;
            errorMsg = "You can not delete a column, column is used in formula";
        } else {
            query2 = new StringBuilder();
            query2.append("select columnid from tbl_tendergovcolumn  where columnid= :columnId");
            List<Object[]> lst3 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);
            if (lst3.size() > 0) {
                status = 1;
                errorMsg = "You can not delete a column, column is used as govt column";

            } else {
                query2 = new StringBuilder();
                query2.append("select columnId from tbl_tendercolumn  where columnId= :columnId and isGTColumn=1");
                List<Object[]> lst4 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);

                if (lst4.size() > 0) {
                    status = 1;
                    errorMsg = "You can not delete a column, column is used as GT Column";

                } else {
                    query2 = new StringBuilder();
                    query2.append("select columnId from tbl_tendercellgrandtotal  where columnId= :columnId ");
                    List<Object[]> lst5 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);

                    if (lst4.size() > 0) {
                        status = 1;
                        errorMsg = "You can not delete a column, column is used as GT Column";

                    }
                }
            }

        }

        // StringBuilder query2 = new StringBuilder();
        if (status == 0) {
            query2 = new StringBuilder();
            query2.append("delete from tbl_tendergovcolumn where columnid= :columnId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query2 = new StringBuilder();
            query2.append("delete from tbl_tenderformula where columnid= :columnId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query2 = new StringBuilder();
            query2.append("delete from tbl_tendercellgrandtotal   where columnId = :columnId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query2 = new StringBuilder();
            query2.append("delete from tbl_tendercell where columnid=:columnId");
            int c = hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query.append("delete from tbl_tendercolumn  where columnId = :columnId");
            cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);

            Map<String, Object> var1 = new HashMap<String, Object>();
            var1.put("tableId", tblTenderTable.getTableId());

            query2 = new StringBuilder();
            query2.append("select noOfCols,tableId from tbl_tendertable where tableId= :tableId");
            List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query2.toString(), var1);
            Integer NoOfCols = (Integer) lst.get(0)[0] - 1;

            var1.put("noOfCols", NoOfCols);
            query2 = new StringBuilder();
            query2.append("update tbl_tendertable set noOfCols=:noOfCols where tableId=:tableId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var1);
            errorMsg = "Column deleted successfully";
        }

        return errorMsg;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public boolean UpdateFormStatusForDelete(Integer formId) {
        boolean success = false;
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        query.append("update tbl_tenderform set cstatus=2 where formId= :formId");
        int cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);
        return cnt != 0;
    }
    
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public List<TblTenderEnvelope> getMinimumFormCountForBidding(Integer tenderId)throws Exception
    {
        List<TblTenderEnvelope> lstTblTenderEnvelope=new ArrayList<TblTenderEnvelope>();
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId",tenderId);
        List<Object[]> lst=new ArrayList<Object[]>();
        lst=hibernateQueryDao.nativeSQLQuery("select count(*),envelopeId from tbl_tenderform where tenderId=:tenderId and cstatus!=2 group by envelopeId", var);
        for(int i=0;i<lst.size();i++){
            TblTenderEnvelope tblTenderEnvelope=new TblTenderEnvelope();
            tblTenderEnvelope.setEnvelopeId((Integer)lst.get(i)[1]);
            BigInteger cnt=(BigInteger)lst.get(i)[0];
            tblTenderEnvelope.setMinFormsReqForBidding(cnt.intValue());
            lstTblTenderEnvelope.add(tblTenderEnvelope);
        }
        return lstTblTenderEnvelope;
    }
    
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public void updateMinimumBiddingFormReqForBidding(List<TblTenderEnvelope> lstTblTenderEnvelope)throws Exception{
            Map<String,Object> var=new HashMap<String,Object>();
        for(int i=0;i<lstTblTenderEnvelope.size();i++){
            TblTenderEnvelope tblTenderEnvelope=lstTblTenderEnvelope.get(i);
            var=new HashMap<String,Object>();
            var.put("envelopeId",tblTenderEnvelope.getEnvelopeId());
            var.put("count",tblTenderEnvelope.getMinFormsReqForBidding());
            int c=hibernateQueryDao.updateDeleteSQLQuery("update tbl_tenderenvelope set minFormsReqForBidding=:count where envelopeId=:envelopeId", var);
        }
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public ArrayList getFormStatus(Integer tenderId) throws Exception {
        BigInteger cntFormula = null;
        BigInteger cntCells = null;
        BigInteger BigZero = new BigInteger("0");
        String status = " ";
        StringBuilder Formquery = new StringBuilder();
        Map<String, Object> tenderVar = new HashMap<String, Object>();
        tenderVar.put("tenderId", tenderId);
        Formquery.append("select tblTenderForm.formId, tblTenderForm.formName from TblTenderForm tblTenderForm "
                + " inner join tblTenderForm.tblTender tblTender"
                + " where tblTender.tenderId= :tenderId and tblTenderForm.cstatus!=2"
        );
        List<Object[]> formLst = hibernateQueryDao.createNewQuery(Formquery.toString(), tenderVar);
        StringBuilder query = new StringBuilder();
        ArrayList lstStatus = new ArrayList();
        Map<String, Object> var = new HashMap<String, Object>();
        for (int i = 0; i < formLst.size(); i++) {

            var = new HashMap<String, Object>();
            query = new StringBuilder();
            cntFormula = null;
            Integer formId = (Integer) formLst.get(i)[0];

            var.put("formId", formId);

            /*    query.append("select count(*),tblTenderForm.formId"
                    + " from TblTenderFormula tblTenderFormula "
                    + " inner join tblTenderFormula.tblTenderForm tblTenderForm"
                    + " where tblTenderForm.formId= :formId");
            List<Object[]> lst = hibernateQueryDao.createNewQuery(query.toString(), var);*/
            query.append("select count(*),tt.formId from tbl_tenderformula tt"
                    + " where tt.formId= :formId");
            List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query.toString(), var);
            // count=(Integer)lst.get(0)[0
            //  cntFormula = (Long) lst.get(0)[0];
            cntFormula = (BigInteger) lst.get(0)[0];
            StringBuilder query1 = new StringBuilder();
            query1.append("select count(*),tc.formid from tbl_tendercell tc "
                    + " inner join tbl_tendercolumn t on t.columnid=tc.columnid  "
                    + " where t.filledby=1 and tc.formid= :formId");
            List<Object[]> lst1 = hibernateQueryDao.nativeSQLQuery(query1.toString(), var);
            cntCells = (BigInteger) lst1.get(0)[0];

            StringBuilder query2 = new StringBuilder();
            query2.append("select count(*),tc.formid from tbl_tendercolumn tc where tc.formid= :formId and tc.filledBy=3");
            List<Object[]> lst2 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);

            StringBuilder queryForDocument = new StringBuilder();
            queryForDocument.append("select f.formId, "
                    + " case when d.documentId is null and f.isPriceBid <>1 and f.isDocumentReq=1 then 1 else 0 end as DocStatus "
                    + " from tbl_tenderform f "
                    + " left outer join tbl_tenderdocument d on d.formId=f.formId "
                    + " where f.formId= :formId ");
            List<Object[]> lstDocumentList = hibernateQueryDao.nativeSQLQuery(queryForDocument.toString(), var);
            int statusDoc = convertInt(lstDocumentList.get(0)[1]);

            if ((cntCells.compareTo(BigZero) != 0) && ((cntFormula.compareTo((BigInteger) lst2.get(0)[0])) == 0) && (statusDoc == 0)) {
                status = " ";
            } else if ((cntCells.compareTo(BigZero) == 0)) {
                status = "Incomplete";
            } else if ((cntFormula.compareTo((BigInteger) lst2.get(0)[0]) != 0)) {
                status = "Formula Pending";
            } else if (statusDoc == 1) {
                status = "Document Not inserted";
            }
            lstStatus.add(status + "_" + formId);
        }
        return lstStatus;
    }

    /// Method That Checks Validation For Tender Publish , Related to Bidding Forms
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<String> PublishFormValidation(TblTender tblTender) throws Exception {
        List<String> lstValidation = new ArrayList<String>();
        Integer tenderId=tblTender.getTenderId();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        BigInteger BigZero = new BigInteger("0");
        // 1. Check If Tender Has any Bidding Form
        StringBuilder queryForBiddingFormNotCreated = new StringBuilder();
        queryForBiddingFormNotCreated.append("select count(1),tblTender.tenderId from TblTenderForm tblTenderForm "
                + " inner join tblTenderForm.tblTender tblTender"
                + " where tblTender.tenderId= :tenderId and tblTenderForm.cstatus!=2");
        List<Object[]> lstForBiddingFormNotCreated = hibernateQueryDao.createNewQuery(queryForBiddingFormNotCreated.toString(), var);
        Long countForBiddingForm = (Long) lstForBiddingFormNotCreated.get(0)[0];
        if (countForBiddingForm == 0) {
            lstValidation.add(ValidationMessage.BIDDING_FORM_NOT_CREATED);
        } else {
            if(tblTender.getisAuction()==0)
            {
            // 2. Check if any envelop with No Bidding form
            StringBuilder queryForGetEnvelopeForm = new StringBuilder();
            queryForGetEnvelopeForm.append("SELECT COUNT(F.formId),E.envelopeId,E.envelopeName FROM tbl_tenderform F "
                    + "RIGHT OUTER JOIN tbl_tenderenvelope E ON F.envelopeid=E.envelopeId AND F.CSTATUS!=2 "
                    + "WHERE E.tenderid=:tenderId "
                    + "GROUP BY E.envelopeId");
            List<Object[]> lstGetEnvelopeCount = hibernateQueryDao.nativeSQLQuery(queryForGetEnvelopeForm.toString(), var);
            boolean status = true;
            for (int i = 0; i < lstGetEnvelopeCount.size(); i++) {
                if (BigZero.compareTo((BigInteger) lstGetEnvelopeCount.get(i)[0]) == 0) {
                    lstValidation.add(ValidationMessage.NO_BIDDING_FORM_CREATED_FOR_ENVELOPE + " : " + lstGetEnvelopeCount.get(i)[2]);
                }
            }
            }
            // 3. Check if Bidding Form is Incomplete or what
            StringBuilder queryForGetTenderForm = new StringBuilder();
            queryForGetTenderForm.append("select tf.formid,tf.formname,e.envid,tf.isPriceBid,tt.isItemwiseWinner from tbl_tenderform tf "
                    + " inner join tbl_tender tt on tt.tenderid=tf.tenderid "
                    + " inner join tbl_tenderenvelope te on te.envelopeid=tf.envelopeid "
                    + " inner join tbl_envelope e on e.envid=te.envid "
                    + " where tf.tenderid= :tenderId and tf.cstatus!=2");
            List<Object[]> lstForTenderForm = hibernateQueryDao.nativeSQLQuery(queryForGetTenderForm.toString(), var);
            for (int i = 0; i < lstForTenderForm.size(); i++) {
                Integer formId = (Integer) lstForTenderForm.get(i)[0];
                Map<String, Object> varForFormId = new HashMap<String, Object>();

                varForFormId.put("formId", formId);

                StringBuilder queryForGetCellCount = new StringBuilder();
                queryForGetCellCount.append("select count(*),tc.formid from tbl_tendercell tc "
                        + " inner join tbl_tendercolumn t on t.columnid=tc.columnid  "
                        + " where t.filledby=1 and tc.formid= :formId");
                List<Object[]> lstCellCount = hibernateQueryDao.nativeSQLQuery(queryForGetCellCount.toString(), varForFormId);
                BigInteger CountForCell = (BigInteger) lstCellCount.get(0)[0];
                if (CountForCell.compareTo(BigZero) == 0) {
                    lstValidation.add(ValidationMessage.BIDDING_FROM_STATUS_INCOMPLETE + " : " + lstForTenderForm.get(i)[1]);
                }

                // 4. Check if Bidding Form Formulas are created or not
                StringBuilder queryForGetFormulaCount = new StringBuilder();
                queryForGetFormulaCount.append("select count(*),tt.formId from tbl_tenderformula tt "
                        + " inner join tbl_tenderform tf on tf.formId=tt.formId "
                        + " where tt.formId= :formId and tf.isPriceBid=1 ");
//                                                and tf.loadNoOfItems=(select count(tc.filledBy) from tbl_tendercolumn tc where tc.formId=:formId and tc.filledBy=3)");
                List<Object[]> lstFormulaCount = hibernateQueryDao.nativeSQLQuery(queryForGetFormulaCount.toString(), varForFormId);
                BigInteger countForFormula = (BigInteger) lstFormulaCount.get(0)[0];

                StringBuilder queryForGetFormulaColumn = new StringBuilder();
                queryForGetFormulaColumn.append("select count(filledBy),tf.formId from tbl_tendercolumn tc "
                        + " inner join tbl_tenderform tf on tf.formid=tc.formid "
                        + " where tf.formId= :formId and tc.filledBy=3 and tf.ispricebid=1");
                List<Object[]> lstAutoColumn = hibernateQueryDao.nativeSQLQuery(queryForGetFormulaColumn.toString(), varForFormId);
                BigInteger countForAutoColumn = (BigInteger) lstAutoColumn.get(0)[0];
                // Only if PriceBid is 1.     
                if (countForFormula.compareTo(countForAutoColumn) != 0 && convertInt(lstForTenderForm.get(i)[3]) == 1) {

                    lstValidation.add(ValidationMessage.FORMULA_CREATION_IS_PENDING + " : " + lstForTenderForm.get(i)[1]);
                }
                if(tblTender.getisAuction()==0)
                {
                // 5. Check if Bidding Form contains Evalution Columns
                StringBuilder queryForGetEvaluationColumnCount = new StringBuilder();
                queryForGetEvaluationColumnCount.append("select count(*),tg.formid from tbl_tendergovcolumn tg where tg.formid= :formId");
                List<Object[]> lstEvaluationColumn = hibernateQueryDao.nativeSQLQuery(queryForGetEvaluationColumnCount.toString(), varForFormId);
                BigInteger countForEvaluationColumn = (BigInteger) lstEvaluationColumn.get(0)[0];

                /*
                    StringBuilder queryForGetEvaluationColumn = new StringBuilder();
                    queryForGetEvaluationColumn.append("select count(*),tc.formid from tbl_tendercolumn tc where tc.formid=:formId and tc.filledBy in(2,3)");
                    List<Object[]> lstEvaluation = hibernateQueryDao.nativeSQLQuery(queryForGetEvaluationColumn.toString(), varForFormId);
                    BigInteger countForEvaluation = (BigInteger) lstEvaluation.get(0)[0];
                 */
                if (countForEvaluationColumn.compareTo(BigZero) == 0 && convertInt(lstForTenderForm.get(i)[3]) == 1 && convertInt(lstForTenderForm.get(i)[4]) == 1) {
                    lstValidation.add(ValidationMessage.EVALUATION_COLUMN_NOT_CREATED + " : " + lstForTenderForm.get(i)[1]);
                }
                }
                 StringBuilder queryForDocumentCheckList = new StringBuilder();
                if(tblTender.getisAuction()==0)
                {
                // 6. Check if Bidding Form contains Mandatory Documents Uploaded or what
               
                queryForDocumentCheckList.append("select count(*),td.formId,tf.isDocumentReq from tbl_tenderdocument td "
                        + " inner join tbl_tenderform tf on tf.formId=td.formId "
                        + " where td.formId=:formId");
                List<Object[]> lstDocument = hibernateQueryDao.nativeSQLQuery(queryForDocumentCheckList.toString(), varForFormId);
                BigInteger countForDocumentcheckList = (BigInteger) lstDocument.get(0)[0];

                // No Need to Check if Envelop Type is Price Bid'
                if (countForDocumentcheckList.compareTo(BigZero) == 0 && convertInt(lstForTenderForm.get(i)[2]) != 4 && convertInt(lstDocument.get(0)[2]) == 1) {
                    lstValidation.add(ValidationMessage.DOCUMENT_CHECKLIST_NOT_CREATED + " : " + lstForTenderForm.get(i)[1]);
                }
              
                queryForDocumentCheckList = new StringBuilder();
                queryForDocumentCheckList.append("select f.formId,f.isPriceBid from tbl_tenderform f "
                        + " inner join tbl_tender t on t.tenderId=f.tenderid"
                        + " and t.isItemwiseWinner=0"
                        + " where f.isPriceBid=1 and f.isMandatory =1 and f.formId=:formId ");
                List<Object[]> lstPriseBid = hibernateQueryDao.nativeSQLQuery(queryForDocumentCheckList.toString(), varForFormId);
                // BigInteger countForPriceBidList = (BigInteger) lstPriseBid.get(0)[0];

                // No Need to Check if Envelop Type is Price Bid'
                if (lstPriseBid.size() != 0) {

                    StringBuilder queryForCheckList = new StringBuilder();
                    queryForCheckList.append("select columnId,isGTColumn from tbl_tendercolumn where formid = :formId and isGTColumn=1 ");
                    List<Object[]> lstManPriseBid = hibernateQueryDao.nativeSQLQuery(queryForCheckList.toString(), varForFormId);
                    //  BigInteger countForManPriceBidList = (BigInteger) lstPriseBid.get(0)[0];

                    if (lstManPriseBid.size() == 0) {
                        lstValidation.add(ValidationMessage.PriceBidForm + " : " + lstForTenderForm.get(i)[1]);
                    }
                }
                
                StringBuilder queryForDocument = new StringBuilder();
                queryForDocument.append("select f.formId, "
                        + " case when d.documentId is null and f.isPriceBid <>1 and f.isDocumentReq=1 then 1 else 0 end as DocStatus "
                        + " from tbl_tenderform f "
                        + " left outer join tbl_tenderdocument d on d.formId=f.formId "
                        + " where f.formId= :formId ");
                List<Object[]> lstDocumentList = hibernateQueryDao.nativeSQLQuery(queryForDocument.toString(), varForFormId);
                int statusDoc = convertInt(lstDocumentList.get(0)[1]);
                if (statusDoc == 1) {
                    lstValidation.add(ValidationMessage.DocumentCheckListForm + " : " + lstForTenderForm.get(i)[1]);
                }
                //for price summary
                 var.put("formId", formId);
                StringBuilder queryForPriceSummary = new StringBuilder();
                queryForPriceSummary.append("select f.formName," +
                                        " (select count(isPriceSummary) from tbl_tendercolumn where isPriceSummary=1 and formid=f.formId ) as PriceCount " +
                                        " from tbl_tenderform f " +
                                        " inner join tbl_tender t on t.tenderid=f.tenderid" +
                                        " inner join tbl_tendercolumn c on c.formId=f.formId" +
                                        " where f.tenderid=:tenderId and t.isItemwiseWinner!=1 and f.isPriceBid=1 and f.cstatus!=2 and  f.isMandatory=1 and f.formId=:formId " +
                                        " group by f.formId");
                List<Object[]> lstPriceSummaryList = hibernateQueryDao.nativeSQLQuery(queryForPriceSummary.toString(), var);
                for(int k=0;k<lstPriceSummaryList.size();k++)
                {
                             if( convertInt(lstPriceSummaryList.get(k)[1])==0)
                                    lstValidation.add(ValidationMessage.PRICE_SUMMARY_COLUMN_NOT_SELECTED + " : " + lstPriceSummaryList.get(k)[0]);
                          
               
                }
                }
                if(tblTender.getisAuction()==1)
                {
                    StringBuilder queryForGTColumn=new StringBuilder();
                    queryForGTColumn.append("select count(columnid),columnid from tbl_tendercolumn where formid=:formId and isGTColumn=1 ");
                    List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(queryForGTColumn.toString(), varForFormId);
                    BigInteger cnt=(BigInteger)lst.get(0)[0];
                    if(cnt.compareTo(BigZero)==0)
                    {
                        lstValidation.add(ValidationMessage.NO_GT_COLUMN_SELECTED);
                    }
                }
            }
        }
        return lstValidation;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderCell> setJsonValueForEditBiddingForm(HttpServletRequest request) throws Exception {
        String json = checkRequestNull(request, "txtJson");
        String formId = "";
        JSONObject jobj = new JSONObject(json);
        Iterator itr = jobj.keys();
        List<TblTenderCell> lstCell = new ArrayList<TblTenderCell>();

        while (itr.hasNext()) {
            String k = (String) itr.next();
            JSONObject jsonObj = jobj.getJSONObject(k);

            TblTenderForm tblTenderForm = new TblTenderForm();
            TblTenderTable tblTenderTable = new TblTenderTable();
            formId = jsonObj.getString("FormId");
            tblTenderForm.setFormId(convertInt(jsonObj.getString("FormId")));
            tblTenderTable.setTableId(convertInt(jsonObj.getString("TableId")));
            JSONObject jsonObj3 = jsonObj.getJSONObject("ColumnJsonval");
            Iterator itr2 = jsonObj3.keys();
            while (itr2.hasNext()) {
                
                String keyCol = (String) itr2.next();
                TblTenderColumn tblTenderColumn = new TblTenderColumn();
                JSONObject jsonObjColumn = jsonObj3.getJSONObject(keyCol);
                TblTenderCell tblTenderCell = new TblTenderCell();
                tblTenderCell.setCellId(convertInt(jsonObjColumn.getString("cellId")));
                tblTenderCell.setCellNo(convertInt(jsonObjColumn.getString("colNo")));
                tblTenderCell.setDataType(0);
                tblTenderCell.setObjectId(1);
                tblTenderCell.setCellValue(jsonObjColumn.getString("val"));
                tblTenderCell.setRowId(convertInt(jsonObjColumn.getString("row")));
                tblTenderColumn.setColumnId(convertInt(jsonObjColumn.getString("key")));
                tblTenderCell.setTblTenderColumn(tblTenderColumn);
                tblTenderCell.setTblTenderForm(tblTenderForm);
                tblTenderCell.setTblTenderTable(tblTenderTable);

                lstCell.add(tblTenderCell);
            }
        }
        return lstCell;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})

    public void publishFormTender(TblTender tblTender) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> column = new HashMap<String, Object>();
        column.put("tenderId", tblTender.getTenderId());
        query.append("update tbl_tenderform set cstatus=1  where tenderid = :tenderId and cstatus!=2");
        int cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), column);

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})

    public List<Object[]> CopyTenderForm(String formId) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        //Do not change the sequance of the column in query
        query.append("select "
                + " a.columnId,a.dataType,a.filledBy,a.columnHeader,a.isShown,"
                + " c.tableId,c.tableName ,c.tableHeader,c.tableFooter,c.noOfRows,"
                + "c.noOfCols,c.isMandatory,c.isPartialFillingAllowed,c.isMultipleFilling,c.hasGTRow,"
                + "d.formName , d.formId,d.formHeader,d.formFooter,d.noOfTables, "
                + " tblTenderCell.cellId,tblTenderCell.cellNo,tblTenderCell.cellValue,tblTenderCell.rowId,tblTenderCell.columnid,d.tenderid,a.columntypeid,a.columnNo,d.isDocumentReq,d.isMandatory formIsMandatory,d.isPriceBid, "
                + " d.cstatus,d.incrementItems,d.isEncryptedDocument,d.isEvaluationReq,d.isItemWiseDocAllowed,"
                + " d.isMultipleFilling formMultiple,d.isSecondary,d.loadNoOfItems,d.masterFormId,d.minTablesReqForBidding,d.parentFormId,d.publishedBy,d.publishedOn,d.sortOrder,d.tenderid formTender,d.envelopeid,"
                + " a.columnNo columnnum,a.isCurrConvReq,a.sortOrder colSortOrder ,a.columntypeid colTypeId,a.isGTColumn,a.isPriceSummary,d.formWeight"
                + " from tbl_tendercell tblTenderCell "
                + " right join tbl_tendercolumn a on  tblTenderCell.columnid=a.columnId "
                + " right join tbl_tendertable c on a.tableid=c.tableId "
                + " right join tbl_tenderform d  on c.formid=d.formId "
                + " where d.formId= :formId order by c.tableId,tblTenderCell.rowId,tblTenderCell.cellNo,tblTenderCell.columnid");

        List<Object[]> ls = hibernateQueryDao.createSQLQuery(query.toString(), var);
        return ls;
    }

    @Transactional
    public Map setCopyForm(List<Object[]> lst) throws Exception {
        TblTenderColumn tblTenderColumn = new TblTenderColumn();
        TblTenderTable tblTenderTable = new TblTenderTable();
        TblTenderForm tblTenderForm = new TblTenderForm();
        Map TableColumn = new HashMap();
        Map formStructure = new HashMap<String, Object>();
//        Map formStructure=new HashMap();
        Map cell = new LinkedHashMap();
        Map cellNew = new LinkedHashMap();
        List column = new ArrayList();
        List table = new ArrayList();
        List columnStructureNo = new ArrayList();
        List columnCell = new ArrayList();
        int tableId;
        int tenderId = 0;
        List bidderCell = new ArrayList<TblTenderCell>();
        int formId = 0;
        TblTenderCell tblTenderCell = null;
        for (int i = 0; i < lst.size(); i++) {
            tableId = convertInt(lst.get(i)[5]);
            tenderId = convertInt(lst.get(i)[25]);
            if (i == 0) {
                formId = convertInt(lst.get(i)[16]);
                tblTenderForm.setFormId(convertInt(lst.get(i)[16]));
                tblTenderForm.setFormName((String) lst.get(i)[15]);
                tblTenderForm.setFormHeader((String) lst.get(i)[17]);
                tblTenderForm.setFormFooter((String) lst.get(i)[18]);
                tblTenderForm.setNoOfTables(convertInt(lst.get(i)[19]));
                tblTenderForm.setIsDocumentReq((Integer) lst.get(i)[28]);
                tblTenderForm.setIsMandatory((Integer) lst.get(i)[29]);
                tblTenderForm.setIsPriceBid((Integer) lst.get(i)[30]);
                tblTenderForm.setCstatus((Integer) lst.get(i)[31]);
                tblTenderForm.setIncrementItems((Integer) lst.get(i)[32]);
                tblTenderForm.setIsEncryptedDocument((Integer) lst.get(i)[33]);
                tblTenderForm.setIsEvaluationReq((Integer) lst.get(i)[34]);
                tblTenderForm.setIsItemWiseDocAllowed((Integer) lst.get(i)[35]);
                tblTenderForm.setIsMultipleFilling((Integer) lst.get(i)[36]);
                tblTenderForm.setIsSecondary((Integer) lst.get(i)[37]);
                tblTenderForm.setLoadNoOfItems((Integer) lst.get(i)[38]);
                tblTenderForm.setMasterFormId((Integer) lst.get(i)[39]);
                tblTenderForm.setMinTablesReqForBidding((Integer) lst.get(i)[40]);
                tblTenderForm.setParentFormId((Integer) lst.get(i)[41]);
                tblTenderForm.setPublishedBy((Integer) lst.get(i)[42]);
                // tblTenderForm.setPublishedOn(publishedOn);
                tblTenderForm.setSortOrder((Integer) lst.get(i)[44]);
                TblTender tblTender = new TblTender();
                tblTender.setTenderId((Integer) lst.get(i)[45]);
                tblTenderForm.setTblTender(tblTender);
                TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();
                tblTenderEnvelope.setEnvelopeId((Integer) lst.get(i)[46]);
                tblTenderForm.setTblTenderEnvelope(tblTenderEnvelope);
//                tblTenderForm.setFormWeight((Double)lst.get(i)[53]);

            }

            tblTenderTable = new TblTenderTable();
            tblTenderTable.setTableId(tableId);
            tblTenderTable.setTableName((String) lst.get(i)[6]);
            tblTenderTable.setTableHeader((String) lst.get(i)[7]);
            tblTenderTable.setTableFooter((String) lst.get(i)[8]);
            tblTenderTable.setNoOfRows(convertInt(lst.get(i)[9]));
            tblTenderTable.setNoOfCols(convertInt(lst.get(i)[10]));
            tblTenderTable.setIsMandatory(convertInt(lst.get(i)[11]));
            tblTenderTable.setIsPartialFillingAllowed(convertInt(lst.get(i)[12]));
            tblTenderTable.setIsMultipleFilling(convertInt(lst.get(i)[13]));
            tblTenderTable.setHasGTRow(convertInt(lst.get(i)[14]));

            tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId(convertInt(lst.get(i)[0]));
            tblTenderColumn.setDataType(convertInt(lst.get(i)[1]));
            tblTenderColumn.setFilledBy(convertInt(lst.get(i)[2]));
            tblTenderColumn.setColumnHeader((String) lst.get(i)[3]);
            tblTenderColumn.setIsShown(convertInt(lst.get(i)[4]));
            tblTenderColumn.setSortOrder(convertInt(lst.get(i)[26]));
            tblTenderColumn.setColumnNo(convertInt(lst.get(i)[27]));
            tblTenderColumn.setTblTenderTable(new TblTenderTable(tableId));

            tblTenderColumn.setColumnNo(convertInt(lst.get(i)[47]));
            tblTenderColumn.setIsCurrConvReq(convertInt(lst.get(i)[48]));
            tblTenderColumn.setSortOrder(convertInt(lst.get(i)[49]));
            TblColumnType tblColumnType = new TblColumnType();
            tblColumnType.setColumnTypeId(convertInt(lst.get(i)[50]));
            tblTenderColumn.setTblColumnType(tblColumnType);
            tblTenderColumn.setisGTColumn(convertInt(lst.get(i)[51]));
            tblTenderColumn.setIsPriceSummary(convertInt(lst.get(i)[52]));

            tblTenderCell = new TblTenderCell();
            tblTenderCell.setCellId(convertInt(lst.get(i)[20]));
            tblTenderCell.setCellNo(convertInt(lst.get(i)[21]));
            tblTenderCell.setCellValue((String) lst.get(i)[22]);
            tblTenderCell.setRowId(convertInt(lst.get(i)[23]));
            tblTenderCell.setObjectId(convertInt(lst.get(i)[24]));//setObjectId is used to set  column id in this logic

            //Form info could be same in every row so need to take one time
            if (TableColumn.containsKey(tableId)) {

                if (!columnStructureNo.contains(tblTenderColumn.getColumnId())) {
                    column = (ArrayList) TableColumn.get(tableId);
                    column.add(tblTenderColumn);
                    TableColumn.put(tableId, column);
                    columnStructureNo.add(tblTenderColumn.getColumnId());
                }
            } else {
                column = new ArrayList();
                column.add(tblTenderColumn);
                columnStructureNo.add(tblTenderColumn.getColumnId());
                TableColumn.put(tableId, column);
                table.add(tblTenderTable);
            }
            if (tblTenderCell != null) {

                if (cellNew.containsKey(tblTenderColumn.getColumnId())) {
                    columnCell = (List) cellNew.get(tblTenderColumn.getColumnId());

                } else {
                    columnCell = new ArrayList();
                }
                columnCell.add(tblTenderCell);
                cellNew.put(tblTenderColumn.getColumnId(), columnCell);

                cell.put(tableId + "_" + tblTenderColumn.getColumnId() + "_" + tblTenderCell.getRowId() + "_" + tblTenderCell.getCellNo(), tblTenderCell);
            }

        }
        formStructure.put("tender", tenderId + "");
        formStructure.put("form", tblTenderForm);
        formStructure.put("table", table);

        formStructure.put("column", TableColumn);
        formStructure.put("cell", cell);
        formStructure.put("cellNew", cellNew);

        return formStructure;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderForm> FormLibrary(String formType, String eventId, String formId, String refNo, String formName, String dept,TblTender tblTenderObj) {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();

        if (dept.equalsIgnoreCase("-1")) {
            dept = "";
        }
        if (formType.equalsIgnoreCase("-1")) {
            formType = "";
        }
        Integer isAuction=tblTenderObj.getisAuction();
        var.put("eventId", eventId); //tender id
        var.put("formId", formId);
        var.put("refNo", refNo); //tender no
        var.put("formName", formName);
        var.put("dept", dept);
        var.put("isAuction",isAuction );
        var.put("formType", formType); //envelope type
       
        if(isAuction==0){
             var.put("isItemwiseWinner", tblTenderObj.getIsItemwiseWinner());
         query.append("select f.formId,f.formName,t.tenderId,t.tenderNo,t.departmentId ,d.deptName from tbl_tenderform f "
                + " inner join tbl_tender t on f.tenderId=t.tenderId and t.tenderId  =  (select tenderId from tbl_tenderenvelope where tenderId = t.tenderId and isEvaluated=1 limit 1)"
                + " inner join tbl_department d on t.departmentid=d.deptId"
                + " where (f.formName= :formName or ''= :formName )and (f.formId=:formId or ''=:formId) "
                + " and (t.departmentId=:dept or ''= :dept) and (t.tenderId= :eventId or ''=:eventId ) "
                + " and (t.tenderNo= :refNo or '' = :refNo) and (f.envelopeid in(select envelopeId from tbl_tenderenvelope where envid=:formType ) or  ''=:formType "
                + " ) and t.isAuction =:isAuction and t.isItemwiseWinner=:isItemwiseWinner");
        }else
        {
             query.append("select f.formId,f.formName,t.tenderId,t.tenderNo,t.departmentId ,d.deptName from tbl_tenderform f "
                + " inner join tbl_tender t on f.tenderId=t.tenderId"
                + " inner join tbl_department d on t.departmentid=d.deptId"
                + " where (f.formName= :formName or ''= :formName )and (f.formId=:formId or ''=:formId) "
                + " and (t.departmentId=:dept or ''= :dept) and (t.tenderId= :eventId or ''=:eventId ) "
                + " and (t.tenderNo= :refNo or '' = :refNo) and (f.envelopeid in(select envelopeId from tbl_tenderenvelope where envid=:formType ) or  ''=:formType "
                + " ) and t.isAuction =:isAuction");

        }
        List<Object[]> lst = hibernateQueryDao.createSQLQuery(query.toString(), var);
        TblTender tblTender;
        TblTenderForm tblTenderForm;
        List<TblTenderForm> lstFormListing = new ArrayList<TblTenderForm>();
        for (int i = 0; i < lst.size(); i++) {
            tblTenderForm = new TblTenderForm();
            tblTenderForm.setFormId(convertInt(lst.get(i)[0]));
            tblTenderForm.setFormName((String) (lst.get(i)[1]));

            tblTender = new TblTender();
            tblTender.setTenderId(convertInt(lst.get(i)[2]));
            tblTender.setTenderNo((String) (lst.get(i)[3]));
            tblTender.setDepartmentId(convertInt(lst.get(i)[4]));
            tblTender.setDocumentFee((String) (lst.get(i)[5]));//this field is use to save dept name
            tblTenderForm.setTblTender(tblTender);
            lstFormListing.add(tblTenderForm);

        }
        return lstFormListing;

    }

    @Transactional
    public List<TblDepartment> getDepartment() throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        StringBuffer query = new StringBuffer();
        query.append(" select TblDepartment.deptId,deptId.deptName from TblDepartment TblDepartment");
        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblDepartment> lstDepartment = new ArrayList<TblDepartment>();
        for (Object[] obj : list) {
            TblDepartment tblDepartment = new TblDepartment();
            tblDepartment.setDeptId(convertInt(obj[0]));
            tblDepartment.setDeptName((String) obj[1]);

            lstDepartment.add(tblDepartment);
        }
        return lstDepartment;

    }

    @Transactional
    public List<TblEnvelope> getEnvelope() throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        StringBuffer query = new StringBuffer();
        query.append(" select TblEnvelope.envId,TblEnvelope.lang1 from TblEnvelope TblEnvelope");
        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblEnvelope> lstEnvelope = new ArrayList<TblEnvelope>();
        for (Object[] obj : list) {
            TblEnvelope tblEnvelope = new TblEnvelope();
            tblEnvelope.setEnvId(convertInt(obj[0]));
            tblEnvelope.setLang1((String) obj[1]);

            lstEnvelope.add(tblEnvelope);
        }
        return lstEnvelope;

    }
    
    @Transactional
    public List<TblTenderEnvelope> getFormEnvelope(Integer tenderId) throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        StringBuffer query = new StringBuffer();
        query.append(" select TblTenderEnvelope.envelopeId,TblTenderEnvelope.envelopeName from TblTenderEnvelope TblTenderEnvelope where tblTender.tenderId= :tenderId");
        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderEnvelope> lstTenderEnvelope = new ArrayList<TblTenderEnvelope>();
        for (Object[] obj : list) {
            TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();
            tblTenderEnvelope.setEnvelopeId(convertInt(obj[0]));
            tblTenderEnvelope.setEnvelopeName((String) obj[1]);

            lstTenderEnvelope.add(tblTenderEnvelope);
        }
        return lstTenderEnvelope;

    }

    @Transactional
    public List<TblTenderFormula> getColumnFormulaForCopyForm(int formId, int columnId) throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        var.put("columnId", columnId);
        StringBuffer query = new StringBuffer();
        query.append(" select TblTenderFormula.cellId,TblTenderFormula.cellNo,TblTenderFormula.colFormula,TblTenderFormula.columnNo,TblTenderFormula.displayFormula,TblTenderFormula.formula,TblTenderFormula.formulaType"
                + " ,TblTenderFormula.validationMessage from TblTenderFormula TblTenderFormula");
        query.append(" WHERE TblTenderFormula.tblTenderColumn.columnId =:columnId");
        query.append(" AND TblTenderFormula.tblTenderForm.formId =:formId");
        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderFormula> lstTenderFormula = new ArrayList<TblTenderFormula>();
        for (Object[] obj : list) {
            TblTenderFormula tblTenderFormula = new TblTenderFormula();
            tblTenderFormula.setCellId(convertInt(obj[0]));
            tblTenderFormula.setCellNo(convertInt(obj[1]));
            tblTenderFormula.setColFormula((String) obj[2]);
            tblTenderFormula.setColumnNo(convertInt(obj[3]));
            tblTenderFormula.setDisplayFormula((String) obj[4]);
            tblTenderFormula.setFormula((String) obj[5]);
            tblTenderFormula.setFormulaType(convertInt(obj[6]));
            tblTenderFormula.setValidationMessage((String) obj[7]);

            lstTenderFormula.add(tblTenderFormula);
        }
        return lstTenderFormula;

    }

    @Transactional
    public List<TblTenderGovColumn> getGovColumnForCopyForm(int formId, int columnId, int tableId) throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        var.put("columnId", columnId);
        var.put("tableId", tableId);
        StringBuffer query = new StringBuffer();
        query.append(" select TblTenderGovColumn.cellId,TblTenderGovColumn.columnNo,TblTenderGovColumn.ipAddress from TblTenderGovColumn TblTenderGovColumn");
        query.append(" WHERE TblTenderGovColumn.tblTenderColumn.columnId =:columnId");
        query.append(" AND TblTenderGovColumn.tblTenderForm.formId =:formId");
        query.append(" AND TblTenderGovColumn.tblTenderTable.tableId =:tableId");

        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderGovColumn> lstTenderGovColumn = new ArrayList<TblTenderGovColumn>();
        for (Object[] obj : list) {
            TblTenderGovColumn tblTenderGovColumn = new TblTenderGovColumn();
            tblTenderGovColumn.setCellId(convertInt(obj[0]));
            tblTenderGovColumn.setColumnNo(convertInt(obj[1]));
            tblTenderGovColumn.setIpAddress((String) obj[2]);

            lstTenderGovColumn.add(tblTenderGovColumn);
        }
        return lstTenderGovColumn;

    }

    @Transactional
    public List<TblTenderCellGrandTotal> getGTColumnForCopyForm(int formId, int columnId) throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        var.put("columnId", columnId);
        StringBuffer query = new StringBuffer();
        query.append(" select TblTenderCellGrandTotal.cellGrandTotalId,TblTenderCellGrandTotal.GTValue,TblTenderCellGrandTotal.tblBidder.bidderId from TblTenderCellGrandTotal TblTenderCellGrandTotal");
        query.append(" WHERE TblTenderCellGrandTotal.tblTenderForm.formId =:formId and TblTenderCellGrandTotal.tblTenderColumn.columnId= :columnId");

        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderCellGrandTotal> lstTenderCellGrandTotal = new ArrayList<TblTenderCellGrandTotal>();
        for (Object[] obj : list) {
            TblTenderCellGrandTotal TblTenderCellGrandTotal = new TblTenderCellGrandTotal();
            TblTenderCellGrandTotal.setTblBidder(new TblBidder(convertInt(obj[2])));
            TblTenderCellGrandTotal.setGTValue((String) obj[1]);

            lstTenderCellGrandTotal.add(TblTenderCellGrandTotal);
        }

        return lstTenderCellGrandTotal;

    }

    @Transactional
    public List<TblTenderDocument> getDocumentForCopyForm(int formId) throws Exception {

        List<Object[]> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        StringBuffer query = new StringBuffer();
        query.append(" select TblTenderDocument.isMandatory,TblTenderDocument.documentName from TblTenderDocument TblTenderDocument");
        query.append(" WHERE TblTenderDocument.tblTenderForm.formId =:formId");

        list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderDocument> lstTenderDoc = new ArrayList<TblTenderDocument>();
        for (Object[] obj : list) {
            TblTenderDocument tblTenderDocument = new TblTenderDocument();
            tblTenderDocument.setIsMandatory(convertInt(obj[0]));
            tblTenderDocument.setDocumentName((String) (obj[1]));

            lstTenderDoc.add(tblTenderDocument);
        }
        return lstTenderDoc;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void SaveGrandTotal(String colIds[], Integer formId, Integer tenderId) {
        try {

            StringBuilder query = new StringBuilder();
            Map<String, Object> column = new HashMap<String, Object>();

            column.put("formId", formId);
            query.append("update tbl_tendercolumn set isGTColumn=0 where formid= :formId");

            int cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), column);
            column.remove("formId");
            column.put("colId", colIds);
            query = new StringBuilder();
            query.append("update tbl_tendercolumn set isGTColumn=1 where columnId in (:colId)");

            cnt = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), column);
            query = new StringBuilder();
            query.append("select tableId,columnId from tbl_tendercolumn where columnId in (:colId)");
            List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query.toString(), column);
            List<TblTenderCellGrandTotal> lstTblTenderCellGrandTotal = new ArrayList<TblTenderCellGrandTotal>();
            TblTender tblTender = new TblTender();
            tblTender.setTenderId(tenderId);
            TblTenderForm tblTenderForm = new TblTenderForm();
            tblTenderForm.setFormId(formId);

            TblBidder tblBidder = new TblBidder();
            tblBidder.setBidderId(1);
            for (int i = 0; i < lst.size(); i++) {
                TblTenderCellGrandTotal tblTenderCellGrandTotal = new TblTenderCellGrandTotal();
                tblTenderCellGrandTotal.setTblTenderTable(new TblTenderTable(Integer.parseInt(lst.get(i)[0].toString())));
                tblTenderCellGrandTotal.setTblTenderColumn(new TblTenderColumn(Integer.parseInt(lst.get(i)[1].toString())));
                tblTenderCellGrandTotal.setTblTenderForm(tblTenderForm);
                tblTenderCellGrandTotal.setTblTender(tblTender);
                lstTblTenderCellGrandTotal.add(tblTenderCellGrandTotal);

            }

            //   tblTenderCellGrandTotalDao.saveUpdateAllTblTenderCellGrandTotal(lstTblTenderCellGrandTotal);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})

    public Map getIsGTColumn(Integer formId) throws Exception {
        Map map = new HashMap();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        StringBuilder query = new StringBuilder();
        query.append("select tc.columnId,tc.columnHeader,tt.tablename,tt.tableId from tbl_tenderColumn tc "
                + " inner join tbl_tendertable tt on tt.tableid=tc.tableid "
                + " where tc.isGTColumn=1 and tc.formid= :formId");
        List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        List<TblTenderColumn> lstTblTenderColumn = new ArrayList<TblTenderColumn>();
        List<Integer> lstColumnId = getIsPriceSumaryColumn(formId);
        for (int i = 0; i < lst.size(); i++) {
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId((Integer) lst.get(i)[0]);
            tblTenderColumn.setColumnHeader((String) lst.get(i)[1]);
            String key = lst.get(i)[2] + "_" + lst.get(i)[3];
            if (!map.containsKey(key)) {
                lstTblTenderColumn = new ArrayList<TblTenderColumn>();
            }
            for (int j = 0; j < lstColumnId.size(); j++) {
                if (tblTenderColumn.getColumnId() == lstColumnId.get(j)) {
                    tblTenderColumn.setIsPriceSummary(1);
                }
            }

            lstTblTenderColumn.add(tblTenderColumn);

            map.put(key, lstTblTenderColumn);
        }
        return map;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public int updatePriceSummaryColumn(HttpServletRequest request) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ColumnId", SavePriceSummaryColumn(request));
        StringBuilder query = new StringBuilder();
        query.append("update tbl_tendercolumn set isPriceSummary=1 where columnId in :ColumnId");
        int i = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), map);
        return i;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void priceSummaryColumnUpdate(Integer tableId, Integer ColumnId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tableId", tableId);
        StringBuilder query = new StringBuilder();
        query.append("update tbl_tendercolumn set isPriceSummary=0 where tableId = :tableId");
        int i = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), map);
        map = new HashMap<String, Object>();
        map.put("ColumnId", ColumnId);
        query = new StringBuilder();
        query.append("update tbl_tendercolumn set isPriceSummary=1 where columnId = :ColumnId");
        int i1 = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), map);
    }
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public Map<Integer,Integer> checkIfPriceSummryCreated(Integer tenderId)throws Exception
    {
        Map<Integer,Integer> PriceSummaryMap=new HashMap<Integer,Integer>();
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId",tenderId);
        StringBuilder query=new StringBuilder();
        query.append("select formId,count(case when isPriceSummary=1 then 1 end) from tbl_tendercolumn " +
        " where formId In (select formId from tbl_tenderform where tenderId=:tenderId) " +
        " group by formId");
        List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        Integer count=0;
        if(!lst.isEmpty() && lst!=null){
            for(int i=0;i<lst.size();i++)
            {
                PriceSummaryMap.put(Integer.parseInt(lst.get(i)[0].toString()),Integer.parseInt(lst.get(i)[1].toString()));
            }
            
        }
        return PriceSummaryMap;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map getGridForPriceSummary(Integer formId) throws Exception {
        Map map = new HashMap();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        StringBuilder query = new StringBuilder();
        query.append("select tc.columnId,tc.columnHeader,tt.tablename,tt.tableId from tbl_tenderColumn tc "
                + " inner join tbl_tendertable tt on tt.tableid=tc.tableid "
                + " where tc.isGTColumn=1 and tc.formid= :formId and tc.isPriceSummary=1");
        List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        List<TblTenderColumn> lstTblTenderColumn = new ArrayList<TblTenderColumn>();
        List<Integer> lstColumnId = getIsPriceSumaryColumn(formId);
        for (int i = 0; i < lst.size(); i++) {
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId((Integer) lst.get(i)[0]);
            tblTenderColumn.setColumnHeader((String) lst.get(i)[1]);
            String key = lst.get(i)[2] + "_" + lst.get(i)[3];
            if (!map.containsKey(key)) {
                lstTblTenderColumn = new ArrayList<TblTenderColumn>();
            }
            for (int j = 0; j < lstColumnId.size(); j++) {
                if (tblTenderColumn.getColumnId() == lstColumnId.get(j)) {
                    tblTenderColumn.setIsPriceSummary(1);
                } 
            }

            lstTblTenderColumn.add(tblTenderColumn);

            map.put(key, lstTblTenderColumn);
        }
        return map;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void deletePriceSummaryColumnForTable(Integer tableId) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tableId", tableId);
        StringBuilder query = new StringBuilder();
        query.append("update tbl_tendercolumn set isPriceSummary=0 where tableId = :tableId");
        int i = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), map);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<Integer> SavePriceSummaryColumn(HttpServletRequest request) throws Exception {
        List<Integer> lstColumnId = new ArrayList<Integer>();
        List<Integer> lstTableId = new ArrayList<Integer>();
        JSONObject jsonObj = new JSONObject(request.getParameter("PriceSummryColumn"));
        Iterator itr = jsonObj.keys();
        JSONObject json = jsonObj.getJSONObject("PriceSummaryColumnObj");
        Iterator iterator = json.keys();
        while (iterator.hasNext()) {
            String key = iterator.next().toString();
            JSONObject jobj = json.getJSONObject(key);
            lstColumnId.add(jobj.getInt("columnId"));
            if (!lstTableId.contains(jobj.getInt("tableId"))) {
                lstTableId.add(jobj.getInt("tableId"));
            }
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tableId", lstTableId);
        StringBuilder query = new StringBuilder();
        query.append("update tbl_tendercolumn set isPriceSummary=0 where tableId in :tableId");
        int i = hibernateQueryDao.updateDeleteSQLQuery(query.toString(), map);

        return lstColumnId;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<TblTenderColumn> getTableColumn(Integer tableId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tableId", tableId);

        StringBuilder query = new StringBuilder();
        query.append("select columnId ,columnNo from TblTenderColumn where tblTenderTable.tableId= :tableId");
        List<Object[]> list = hibernateQueryDao.createNewQuery(query.toString(), var);
        List<TblTenderColumn> tblTenderColumnList = new ArrayList<TblTenderColumn>();
        for (Object[] obj : list) {
            TblTenderColumn tblTenderColumn = new TblTenderColumn();
            tblTenderColumn.setColumnId(convertInt(obj[0]));
            tblTenderColumnList.add(tblTenderColumn);
        }
        return tblTenderColumnList;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public int getTableCount(Integer formId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);

        StringBuilder query = new StringBuilder();
        query.append("select noOfTables,formId from TblTenderForm where formId= :formId");
        List<Object[]> list = hibernateQueryDao.createNewQuery(query.toString(), var);
        int columnCount = 0;
        for (Object[] obj : list) {

            columnCount = (convertInt(obj[0]));

        }
        return columnCount;

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public int TableDeletionCheck(List<TblTenderColumn> tblTenderColumnList) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        int status = 0;

        for (TblTenderColumn tblTenderColumn : tblTenderColumnList) {
            var.put("columnId", tblTenderColumn.getColumnId());
            StringBuilder query2 = new StringBuilder();
            query2.append("select columnId from tbl_tenderformula  where columnId= :columnId");
            List<Object[]> lst2 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);

            if (lst2.size() > 0) {
                status = 1;

                return status;
            } else {
                query2 = new StringBuilder();
                query2.append("select columnid from tbl_tendergovcolumn  where columnid= :columnId");
                List<Object[]> lst3 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);
                if (lst3.size() > 0) {
                    status = 1;
                    return status;

                } else {
                    query2 = new StringBuilder();
                    query2.append("select columnId from tbl_tendercolumn  where columnId= :columnId and isGTColumn=1");
                    List<Object[]> lst4 = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);

                    if (lst4.size() > 0) {
                        status = 1;
                        return status;

                    }
                }
            }

        }

        return status;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void deleteTable(List<TblTenderColumn> tblTenderColumnList, Integer tableId, Integer formId) throws Exception {
        StringBuilder query2 = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();

        for (TblTenderColumn tblTenderColumn : tblTenderColumnList) {
            var.put("columnId", tblTenderColumn.getColumnId());
            query2 = new StringBuilder();
            query2.append("delete from tbl_tendergovcolumn where columnid= :columnId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query2 = new StringBuilder();
            query2.append("delete from tbl_tendercellgrandtotal   where columnId = :columnId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query2 = new StringBuilder();
            query2.append("delete from tbl_tenderformula where columnid= :columnId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query2 = new StringBuilder();
            query2.append("delete from tbl_tendercell where columnid=:columnId");
            int c = hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

            query2 = new StringBuilder();
            query2.append("delete from tbl_tendercolumn  where columnId = :columnId");
            hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

        }
        var = new HashMap<String, Object>();

        var.put("tableId", tableId);
        query2 = new StringBuilder();
        query2.append("delete from tbl_tendertable  where tableId = :tableId");
        hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

        var = new HashMap<String, Object>();
        var.put("formId", formId);

        query2 = new StringBuilder();
        query2.append("select noOfTables,formId from tbl_tenderform where formId= :formId");
        List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query2.toString(), var);
        Integer NoOfTable = (Integer) lst.get(0)[0] - 1;

        var.put("NoOfTable", NoOfTable);
        query2 = new StringBuilder();
        query2.append("update tbl_tenderform set noOfTables=:NoOfTable where formId=:formId");
        hibernateQueryDao.updateDeleteSQLQuery(query2.toString(), var);

    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<Integer> getIsPriceSumaryColumn(Integer formId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        StringBuilder query = new StringBuilder();
        query.append("select columnid,tableid from tbl_tenderColumn where formid= :formId and ispricesummary=1");
        List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        List<Integer> lstColumnId = new ArrayList<Integer>();
        for (int i = 0; i < lst.size(); i++) {
            lstColumnId.add((Integer) lst.get(i)[0]);
        }
        return lstColumnId;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public int checkEnvForCopyForm(Integer formId, Integer envId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("formId", formId);
        var.put("envId", envId);
        
        StringBuilder query = new StringBuilder();
        query.append("select e.envId from tbl_tenderenvelope as e "
                + " inner join"
                + " (select envId from tbl_tenderenvelope  where envelopeid in("
                + " select envelopeid from tbl_tenderform  where formId= :formId)) as f"
                + " on e.envid = f.envid"
                + " where e.envelopeid= :envId");
        List<Object[]> lst = hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        if (lst.size() > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void removeCellValue(Integer columnId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("columnId", columnId);
        StringBuilder query = new StringBuilder();
        commonDAO.executeUpdate("update TblTenderCell set cellValue = '' where tblTenderColumn.columnId=:columnId", var);

    }

    /*auction start*/
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public TblTender InsretAuction(TblTender tblTender, TblTenderEnvelope tblTenderEnvelope,String opt,TblTenderCurrency tblTenderCurrency,List<TblTenderCurrency> lsttblTenderCurrency) {
        boolean bSuccess = false;
        commonDAO.saveOrUpdate(tblTender);
        
        if(!opt.equalsIgnoreCase("Edit"))
       {
        commonDAO.saveOrUpdate(tblTenderEnvelope);
        
       }
        
        commonDAO.saveOrUpdate(tblTenderCurrency);
        commonDAO.saveOrUpdateAll(lsttblTenderCurrency);
        bSuccess = true;
        return tblTender;
    }
    @Transactional(propagation = Propagation.REQUIRED ,rollbackFor = {Exception.class})
    public void deletTenderCurrency(TblTender tblTender)
    {
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId", tblTender.getTenderId());
        int i=hibernateQueryDao.updateDeleteSQLQuery("delete from tbl_tenderCurrency where tenderId=:tenderId", var);
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public List<Object[]> getBidderCurrencyDetailByTenderId(Integer tenderId)
    {
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append("select tc.currencyId,tc.exchangeRate,bidderId,tb.userId,c.currencyName,ul.loginId from tbl_tenderbidcurrency tb  " +
" inner join tbl_tendercurrency tc on tc.tenderCurrencyId=tb.tenderCurrencyId " +
" inner join tbl_currency c on c.currencyId=tc.currencyId " +
" inner join tbl_bidder bd on bd.userId=tb.userId " +
" inner join tbl_userlogin ul on ul.userId=tb.userId " +
" where tenderId= :tenderId");
        List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        return lst;
    }
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public void InsertAuctionExtension(TblAuctionExtension tblAuctionExtension)
    {
       commonDAO.saveOrUpdate(tblAuctionExtension);
    }
    
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public void InsertAuctionBidHistory(TblTenderBidHistory tblTenderBidHistory)
    {
        commonDAO.saveOrUpdate(tblTenderBidHistory);
    }
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public List<TblTenderBidHistory> getBidHistoryByBidderId(Integer bidderId,Integer tenderId)throws Exception
    {
        Map<String,Object> var=new HashMap<String,Object>();
        var.put("bidderId",bidderId);
        var.put("tenderId",tenderId);
        StringBuilder query=new StringBuilder();
        List<TblTenderBidHistory> lstTblTenderBidHistory=new ArrayList<TblTenderBidHistory>();
        query.append("select bidValue,biddateTime,isValid from tbl_tenderbidhistory where bidderId=:bidderId and tenderId=:tenderId");
        List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        for(int i=0;i<lst.size();i++){
            TblTenderBidHistory tenderBidHistory=new TblTenderBidHistory();
            tenderBidHistory.setBidValue((String)lst.get(i)[0]);
            tenderBidHistory.setBidDateTime((Date)lst.get(i)[1]);
            tenderBidHistory.setIsValid((Integer)lst.get(i)[2]);
            lstTblTenderBidHistory.add(tenderBidHistory);
        }
        return lstTblTenderBidHistory;
    }
    
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public Map<String, Object> getAuctionCount() {
        Map<String, Object> countMap = new HashMap<String, Object>();
        List<Object> list = new ArrayList<Object>();
        list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 0 and isAuction=1", null);
        if (list != null && !list.isEmpty()) {
            countMap.put("pending", list.get(0));
        }
        Map<String, Object> column = new HashMap<String, Object>();
        column.put("AuctionStartDate", commonService.getServerDateTime());
        column.put("AuctionEndDate", commonService.getServerDateTime());
        list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and AuctionStartDate<:AuctionStartDate and AuctionEndDate>:AuctionEndDate and isAuction=1", column);
        if (list != null && !list.isEmpty()) {
            countMap.put("live", list.get(0));
        }
        column.clear();
        column.put("AuctionEndDate", commonService.getServerDateTime());
        list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and AuctionEndDate<:AuctionEndDate and isAuction=1 ", column);
        if (list != null && !list.isEmpty()) {
            countMap.put("archive", list.get(0));
        }
        column.clear();
        column.put("AuctionStartDate",commonService.getServerDateTime());
        list = commonDAO.executeSelect("select count(1) as pendingCount from TblTender where cstatus = 1 and AuctionStartDate>:AuctionStartDate and isAuction=1 ", column);
        if (list != null && !list.isEmpty()) {
            countMap.put("future", list.get(0));
        }

        column.clear();
        list = commonDAO.executeSelect("select count(1) as cancelCount from TblTender where cstatus = 2 and isAuction=1", column);
        if (list != null && !list.isEmpty()) {
            countMap.put("cancel", list.get(0));
        }
        column.clear();
        list = commonDAO.executeSelect("select count(1) as totalCount from TblTender where isAuction=1", column);
        if (list != null && !list.isEmpty()) {
            countMap.put("total", list.get(0));
        }

        return countMap;
    }

    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public List<LoginReportBean> getLoginReport(Integer tenderId,int userId) throws Exception
   {
       Map<String,Object> var=new HashMap<String,Object>();
      
       var.put("tenderId",tenderId);
       List<LoginReportBean> lstLoginReportBean=new ArrayList<LoginReportBean>();
       StringBuilder query=new StringBuilder();
       query.append("select distinct ta.CREATED_DATE,tb.companyName,tb.cstatus,ta.ENTITY_NAME from tbl_auditlog ta " +
                    " inner join tbl_bidder tb on tb.emailId=ta.ENTITY_NAME " +
                    " where ta.entity_id = :tenderId");
       
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
       LoginReportBean loginReportBean=new LoginReportBean();
       for(int i=0;i<lst.size();i++)
       {
           loginReportBean=new LoginReportBean();
         //String date = commonService.convertSqlToClientDate(client_dateformate_hhmm,lst.get(i)[0].toString());
        	   
           loginReportBean.setCreatedOn(commonService.convertSqlToClientDate(client_dateformate_hhmm,lst.get(i)[0].toString()));
           loginReportBean.setCompanyName((String)lst.get(i)[1]+" ("+(String)lst.get(i)[3]+")");
           loginReportBean.setCstatus((Integer)lst.get(i)[2]);
           loginReportBean.setIPAddress("0.0.0.0");
           lstLoginReportBean.add(loginReportBean);
       }
       return lstLoginReportBean;
   }
   
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public Integer getBidCountByTenderId(Integer tenderId)throws Exception
   {
       Integer count=0;
       Map<String,Object> var=new HashMap<String,Object>();
        var.put("tenderId",tenderId);
        Long count1 = hibernateQueryDao.countForNewQuery("TblTenderBid tblTenderBid ", "tblTenderBid.bidid ", "tblTenderBid.tblTender.tenderId=:tenderId", var);
        count=count1.intValue();
        return count;
   }
   
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public Integer getExtensionCountByTenderId(Integer tenderId)throws Exception
   {
       Integer count=0;
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tenderId);
       Long count1=hibernateQueryDao.countForNewQuery("TblAuctionExtension tblAuctionExtension", "tblAuctionExtension.auctionExtensionId", "tblAuctionExtension.tblTender.tenderId=:tenderId", var);
       count=count1.intValue();
       return count;
   }
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public Integer getBidIdByTenderandBidderId(Integer tenderId,Integer bidderId)
   {
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tenderId);
       var.put("bidderId",bidderId);
       StringBuilder query=new StringBuilder();
       query.append("select bidId,tenderid,bidderId from tbl_tenderbid " +
"where tenderid =:tenderId and bidderId=:bidderId");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
       if(lst != null && !lst.isEmpty()){
           return (Integer)lst.get(0)[0];
       }
       return 0;
   }
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public String validateFormulaColumn(int ColumnId)throws Exception
   {
       String Status="true";
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("columnId",ColumnId);
       StringBuilder query=new StringBuilder();
       query.append("select count(*),columnId from tbl_tenderformula where columnId=:columnId");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
       if(lst != null && !lst.isEmpty()){
           BigInteger bigInt=(BigInteger)lst.get(0)[0];
           
           if(bigInt.equals((BigInteger.ZERO))==true){
               Status="true";
           }
           else
           {
               Status="false";
           }
       }
       return Status;
   }
   
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public List<TenderBidBean> getBidsByTenderId(TblTender tblTender) throws Exception
   {
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tblTender.getTenderId());
       StringBuilder query=new StringBuilder();
//       query.append("SELECT B.BIDDERID,PERSONNAME,BD.CELLVALUE,USERID,(select max(tbh.biddateTime) from tbl_tenderbidhistory tbh where tbh.tenderId=:tenderId and tbh.isValid=1 and tbh.bidderId=b.bidderId) updatedOn FROM TBL_TENDERFORM TF " +
//" INNER JOIN  TBL_BIDDETAIL BD ON TF.FORMID=BD.FORMID " +
//" INNER JOIN TBL_TENDERCOLUMN TC ON TC.COLUMNID=BD.COLUMNID " +
//" INNER JOIN TBL_BIDDER B ON B.COMPANYID=BD.COMPANYID " +
//" INNER JOIN TBL_TENDERBID TB ON TB.FORMID=BD.FORMID AND B.BIDDERID=TB.BIDDERID " +
//" WHERE TF.TENDERID=:tenderId AND TC.FILLEDBY=3 and tc.isgtcolumn=1 ");
query.append("SELECT b.bidderId,b.personname,tg.gtValue,b.userId,"
            + "(SELECT MAX(tbh.biddateTime) FROM tbl_tenderbidhistory tbh WHERE tbh.tenderId=:tenderId AND tbh.isValid=1 AND tbh.bidderId=b.bidderId)"
            + " FROM tbl_tendercellgrandtotal tg " +
             "INNER JOIN tbl_bidder b ON b.bidderId=tg.bidderid " +
             "WHERE tg.tenderId = :tenderId");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
       List<TenderBidBean> lstTenderBidBean=new ArrayList<TenderBidBean>();
       for(int i=0;i<lst.size();i++)
       {
           TenderBidBean tenderBidBean=new TenderBidBean();
           tenderBidBean.setBidderId((Integer)lst.get(i)[0]);
           tenderBidBean.setBidderName((String)lst.get(i)[1]);
           tenderBidBean.setBidValue(encrptDecryptUtils.decrypt((String)lst.get(i)[2], tblTender.getRandPass().substring(0, 16).getBytes()));
           tenderBidBean.setUserId((Integer)lst.get(i)[3]);
           String date = "";
           Date bidingDate = null;
           if(lst.get(i)[4] != null && !lst.get(i)[4].toString().isEmpty()){
        	   date = commonService.convertSqlToClientDate(client_dateformate_hhmm,lst.get(i)[4].toString());
        	   bidingDate = commonService.convertStringToDate(client_dateformate_hhmm, date);
           }
           tenderBidBean.setBiddingDate(bidingDate);
           lstTenderBidBean.add(tenderBidBean);
       }
       Double[] bidVal=new Double[lstTenderBidBean.size()];
     
        for(int i=0;i<lstTenderBidBean.size();i++)
        {
            TenderBidBean tenderBidBean=new TenderBidBean();
            tenderBidBean=lstTenderBidBean.get(i);
            bidVal[i]=Double.parseDouble(tenderBidBean.getBidValue());
      
        }
        if(tblTender.getauctionMethod()==1)
        {
            Arrays.sort(bidVal,Collections.reverseOrder());
          
        }
        else
        {
             Arrays.sort(bidVal);
             
           
        }
        List<TenderBidBean> DupLst=new ArrayList<TenderBidBean>();
        int i=0;
        for(Double bid : bidVal)
        {
            
            for(int j=0;j<lstTenderBidBean.size();j++)
            {
            TenderBidBean tenderBidBean=new TenderBidBean();
            tenderBidBean=lstTenderBidBean.get(j);
            
            if(bid.equals(Double.parseDouble(tenderBidBean.getBidValue())))
            {
                 tenderBidBean.setRank(i+1);
               for(int k=0;k<lstTenderBidBean.size();k++)
               {
                   TenderBidBean obj=new TenderBidBean();
                   obj=lstTenderBidBean.get(k);
                   if(tenderBidBean.getBidderId()!=obj.getBidderId()){
                   if(tenderBidBean.getBidValue().equals(obj.getBidValue())){
                       if(obj.getBiddingDate() != null && tenderBidBean.getBiddingDate().before(obj.getBiddingDate())){
                            int temp=tenderBidBean.getRank();
                            tenderBidBean.setRank(obj.getRank()-1);
                            obj.setRank(temp);
                       }
                       else
                       {
                          int temp=tenderBidBean.getRank();
                            tenderBidBean.setRank(obj.getRank());
                            obj.setRank(temp-1);
                       }
                   }
                   else
                   {
                        tenderBidBean.setRank(i+1);
                   }
                   }
               }
              
               
            }
            
                
            }
           i++;
        }
    
       return lstTenderBidBean;
   }
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public Integer getBidderRank(TblTender tblTender,int userId)throws Exception
    {
        Integer rank=0;
        List<TenderBidBean> lstTenderBidBean=new ArrayList<TenderBidBean>();
        lstTenderBidBean=getBidsByTenderId(tblTender);
        Integer[] bidVal=new Integer[lstTenderBidBean.size()];
        
        for(int i=0;i<lstTenderBidBean.size();i++)
        {
            TenderBidBean tenderBidBean=new TenderBidBean();
            tenderBidBean=lstTenderBidBean.get(i);
            bidVal[i]=Integer.parseInt(tenderBidBean.getBidValue());
          
        }
        if(tblTender.getauctionMethod()==1)
        {
            Arrays.sort(bidVal,Collections.reverseOrder());
            
        }
        else
        {
             Arrays.sort(bidVal);
           
           
        }
       
        List<TenderBidBean> DupLst=new ArrayList<TenderBidBean>();
        int i=0;
        for(Integer bid : bidVal)
        {
            
            for(int j=0;j<lstTenderBidBean.size();j++)
            {
            TenderBidBean tenderBidBean=new TenderBidBean();
            tenderBidBean=lstTenderBidBean.get(j);
            
            if(bid.equals(Integer.parseInt(tenderBidBean.getBidValue())))
            {
                tenderBidBean.setRank(i+1);
               for(int k=0;k<lstTenderBidBean.size();k++)
               {
                   TenderBidBean obj=new TenderBidBean();
                   obj=lstTenderBidBean.get(k);
                   if(tenderBidBean.getBidderId()!=obj.getBidderId()){
                   if(tenderBidBean.getBidValue().equals(obj.getBidValue())){
                       if(obj.getBiddingDate() != null && tenderBidBean.getBiddingDate().before(obj.getBiddingDate())){
                            int temp=tenderBidBean.getRank();
                            tenderBidBean.setRank(obj.getRank()-1);
                            obj.setRank(temp);
                       }
                       else
                       {
                          int temp=tenderBidBean.getRank();
                            tenderBidBean.setRank(obj.getRank());
                            obj.setRank(temp-1);
                       }
                   }
                   else
                   {
                        tenderBidBean.setRank(i+1);
                   }
                   }
               }
               
            }
            
                
            }
           i++;
        }
        
      


        for(int j=0;j<lstTenderBidBean.size();j++)
        {
            TenderBidBean tenderBidBean=new TenderBidBean();
            tenderBidBean=lstTenderBidBean.get(j);
            if(userId==tenderBidBean.getUserId())
            {
               rank=tenderBidBean.getRank();
            }
        }
        return rank;
    }
   
   
   
   
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public Float getLastBidByTender(TblTender tblTender)throws Exception
   {
       Float BidVal=new Float(0);
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tblTender.getTenderId());
       StringBuilder query=new StringBuilder();
       query.append("select bd.cellvalue,bd.formid from tbl_tenderbid tb inner join tbl_bidder b on b.bidderId=tb.bidderid " +
" inner join tbl_biddetail bd on bd.formid=tb.formid " +
" inner join tbl_tendercolumn tc on bd.columnid=tc.columnid " +
" where tb.tenderid=:tenderId and tc.filledby=3 and tc.isGTColumn=1 order by bd.bidDetailId desc limit 1");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
      if(lst != null && !lst.isEmpty()){
           
          BidVal=(Float.parseFloat(encrptDecryptUtils.decrypt((String)lst.get(0)[0], tblTender.getRandPass().substring(0, 16).getBytes())));
        }
      return BidVal;
   }
   
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public Float getLastBidByBidder(TblTender tblTender,int userId) throws Exception
   {
       Float LastBid = new Float(0);
       Map<String,Object> var = new HashMap<String,Object>();
       var.put("tenderId",tblTender.getTenderId());
       var.put("userId",userId);
       StringBuilder query = new StringBuilder();
       query.append("select tg.gtValue,tg.bidderId from tbl_tendercellgrandtotal tg " +
                    " inner join tbl_bidder b on b.bidderId=tg.bidderid " +
                    " where tg.tenderId =:tenderId and b.userId= :userId");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
       if(lst != null  && !lst.isEmpty())
       {
           LastBid = (Float.parseFloat(encrptDecryptUtils.decrypt((String)lst.get(0)[0], tblTender.getRandPass().substring(0, 16).getBytes())));
       }
       return LastBid;
   }
   
   
   @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
   public Double getHighestBidByTenderId(TblTender tblTender) throws Exception
   {
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tblTender.getTenderId());
       StringBuilder query=new StringBuilder();
//       query.append("SELECT B.BIDDERID,PERSONNAME,BD.CELLVALUE,USERID,(select max(tbh.biddateTime) from tbl_tenderbidhistory tbh where tbh.tenderId=:tenderId and tbh.isValid=1 and tbh.bidderId=b.bidderId) updatedOn FROM TBL_TENDERFORM TF " +
//" INNER JOIN  TBL_BIDDETAIL BD ON TF.FORMID=BD.FORMID " +
//" INNER JOIN TBL_TENDERCOLUMN TC ON TC.COLUMNID=BD.COLUMNID " +
//" INNER JOIN TBL_BIDDER B ON B.COMPANYID=BD.COMPANYID " +
//" INNER JOIN TBL_TENDERBID TB ON TB.FORMID=BD.FORMID AND B.BIDDERID=TB.BIDDERID " +
//" WHERE TF.TENDERID=:tenderId AND TC.FILLEDBY=3 and tc.isgtcolumn=1 ");
        query.append("SELECT tg.gtValue,tg.bidderId FROM tbl_tendercellgrandtotal tg " +
        " INNER JOIN tbl_bidder b ON b.bidderId=tg.bidderid " +
        " WHERE tg.tenderId =:tenderId ");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
       List<TenderBidBean> lstTenderBidBean=new ArrayList<TenderBidBean>();
       for(int i=0;i<lst.size();i++)
       {
           TenderBidBean tenderBidBean=new TenderBidBean();
           tenderBidBean.setBidderId((Integer)lst.get(i)[1]);
           tenderBidBean.setBidValue(encrptDecryptUtils.decrypt((String)lst.get(i)[0], tblTender.getRandPass().substring(0, 16).getBytes()));
           
           lstTenderBidBean.add(tenderBidBean);
       }
       Double[] bidVal=new Double[lstTenderBidBean.size()];
     
        for(int i=0;i<lstTenderBidBean.size();i++)
        {
            TenderBidBean tenderBidBean=new TenderBidBean();
            tenderBidBean=lstTenderBidBean.get(i);
            bidVal[i]=Double.parseDouble(tenderBidBean.getBidValue());
      
        }
        if(tblTender.getauctionMethod()==1)
        {
            Arrays.sort(bidVal,Collections.reverseOrder());
          
        }
        else
        {
             Arrays.sort(bidVal);
             
           
        }
        if(bidVal.length > 0)
        {
            return bidVal[0];
        }
        
        return new Double(0);
        
   }
   
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public Integer getIsAuctionStop(Integer tenderId)throws Exception
   {
       Integer isAuctionStop=0;
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tenderId);
       StringBuilder query=new StringBuilder();
       query.append("select isAuctionStop,tenderid from tbl_tender where tenderid=:tenderId");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        if(lst != null && !lst.isEmpty()){
            isAuctionStop=(Integer)lst.get(0)[0];
        }
        return isAuctionStop;
   }
   
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public String checkBidderIsMappedOrNot(Integer tenderId,Integer userId)throws Exception
   {
       String status="true";
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tenderId);
       var.put("userId",userId);
       StringBuilder query=new StringBuilder();
       query.append("SELECT count(*),TM.TENDERID FROM tbl_tenderbiddermap TM " +
                    " WHERE TM.TENDERID=:tenderId and TM.USERID=:userId");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        if(lst != null && !lst.isEmpty()){
          
            BigInteger bigInt=(BigInteger)lst.get(0)[0];
            if(bigInt.intValue()==0){
                status="false";
            }
            else
            {
                status="true";
            }
        }
        return status;
   }
   @Transactional
   public String checkBidderIsDisabledOrNot(Integer userId)throws Exception
   {
       String status="true";
       Map<String,Object> var=new HashMap<String,Object>();
 
       var.put("userId",userId);
       StringBuilder query=new StringBuilder();
       query.append("SELECT CASE WHEN CSTATUS!=3 THEN 'TRUE' ELSE 'FALSE' END,USERID FROM TBL_BIDDER WHERE USERID=:userId");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
        if(lst != null && !lst.isEmpty()){
            status=(String)lst.get(0)[0];
        }
        return status;
   }
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public String checkAuctionStopResume(TblTender tblTender)throws Exception
    { 
        String ValidationMsg="";
        
        List<TblAuctionStopResume> lsttblAuctionStopResume=getAuctionStopResumeDetail(tblTender.getTenderId());
        if(tblTender.getisAuction()==1)//if it is auction or not
        {
            if(tblTender.getCstatus()==2)//if it is cancelled or not
            {
                ValidationMsg="Auction has been cancelled because of "+tblTender.getCancelRemarks();
            }
            else
            {
                if(tblTender.getIsAuctionStop()==1)//1 for Auction is stop and 0  for auction is live or resumed
                {
                    for(int i=0;i<lsttblAuctionStopResume.size();i++)
                    {
                        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                        tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                        if(tblAuctionStopResume.getstatus()==1)
                        {
                            ValidationMsg="Auction has been stopped from "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionstartdate())+" to "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionenddate())+" because of "+tblAuctionStopResume.getremark();
                        }
                    }
                }
                else
                {
                    for(int i=0;i<lsttblAuctionStopResume.size();i++)
                    {
                        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                        tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                        if(tblAuctionStopResume.getstatus()==1)
                        {
                            ValidationMsg="Auction has been stopped from "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionstartdate())+" to "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionenddate())+" because of "+tblAuctionStopResume.getremark();
                        }
                    }
                    for(int i=0;i<lsttblAuctionStopResume.size();i++)
                    {
                        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                        tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                       
                        if(tblAuctionStopResume.getstatus()==0)
                        {
                            if(commonService.getServerDateTime().after(tblAuctionStopResume.getauctionstartdate()))
                            {
                                ValidationMsg="Auction has been resumed, Auction end date and time is "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionEndDate());
                            }
                        }
                    }
                }
            }
        }
        return ValidationMsg;
    }
    @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public String validationForBidSubmission(Integer tenderId,Integer userId)throws Exception
    {
        TblTender tblTender = tenderCommonService.getTenderById(tenderId);
        String ValidationMsg="";
        String BidderMapOrNot = "true";
        String BidderDisabledOrNot = "true";
        List<TblAuctionStopResume> lsttblAuctionStopResume=getAuctionStopResumeDetail(tblTender.getTenderId());
        
        if(tblTender.getisAuction()==1)
        {
            if(tblTender.getCstatus()==2)
            {
                
                ValidationMsg="Auction has been cancelled because of "+tblTender.getCancelRemarks();
                
            }
            else
            {
                if (tblTender.getbiddingAccess() == 0) {
                    BidderMapOrNot = checkBidderIsMappedOrNot(tenderId, userId);
                    
                    
                }
                
                if(BidderMapOrNot.equalsIgnoreCase("false"))
                {
                   ValidationMsg="Bidder is Not Mapped."; 
                }   
                else
                {
                    BidderDisabledOrNot=checkBidderIsDisabledOrNot(userId);
                    System.out.println("BidderDisabled.."+BidderDisabledOrNot);
                    if(BidderDisabledOrNot.equalsIgnoreCase("false"))
                    {
                        ValidationMsg = "Your profile is disabled.";
                    }
                    else
                    {
                        if(commonService.getServerDateTime().after(tblTender.getAuctionEndDate()))
                        {
                               ValidationMsg="Bidding Time is Over.";
                        }
                        else
                        {
                            if(tblTender.getIsAuctionStop()==1)//1 for Auction is stop and 0  for auction is live or resumed
                            {
                                for(int i=0;i<lsttblAuctionStopResume.size();i++)
                                {
                                    TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                                    tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                                    if(tblAuctionStopResume.getstatus()==1)
                                    {
                                        ValidationMsg="Auction has been stopped from "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionstartdate())+" to "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionenddate())+" because of "+tblAuctionStopResume.getremark();
                                    }
                                }
                            }
                            else
                            {
                                for(int i=0;i<lsttblAuctionStopResume.size();i++)
                                {
                                    TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                                    tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                                    if(tblAuctionStopResume.getstatus()==1)
                                    {
                                        ValidationMsg="Auction has been stopped from "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionstartdate())+" to "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblAuctionStopResume.getauctionenddate())+" because of "+tblAuctionStopResume.getremark();
                                    }
                                }
                                for(int i=0;i<lsttblAuctionStopResume.size();i++)
                                {
                                    TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                                    tblAuctionStopResume=lsttblAuctionStopResume.get(i);

                                    if(tblAuctionStopResume.getstatus()==0)
                                    {
                                        if(commonService.getServerDateTime().after(tblAuctionStopResume.getauctionstartdate()))
                                        {
                                            ValidationMsg="Auction has been resumed, Auction end date and time is "+commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionEndDate());
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return ValidationMsg;
    }
     @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
    public String checkAuctionStopResumeForBidSubmission(TblTender tblTender)throws Exception
    {
        String ValidationMsg="";
        List<TblAuctionStopResume> lsttblAuctionStopResume=getAuctionStopResumeDetail(tblTender.getTenderId());
        if(tblTender.getisAuction()==1)//if it is auction or not
        {
            if(tblTender.getCstatus()==2)//if it is cancelled or not
            {
                ValidationMsg="Cancelled";
            }
            else
            {
                if(tblTender.getIsAuctionStop()==1)//1 for Auction is stop and 0  for auction is live or resumed
                {
                    for(int i=0;i<lsttblAuctionStopResume.size();i++)
                    {
                        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                        tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                        if(tblAuctionStopResume.getstatus()==1)
                        {
                            ValidationMsg="Stopped";
                        }
                    }
                }
                else
                {
                    for(int i=0;i<lsttblAuctionStopResume.size();i++)
                    {
                        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                        tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                        if(tblAuctionStopResume.getstatus()==1)
                        {
                            ValidationMsg="Stopped";
                        }
                    }
                    for(int i=0;i<lsttblAuctionStopResume.size();i++)
                    {
                        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
                        tblAuctionStopResume=lsttblAuctionStopResume.get(i);
                       
                        if(tblAuctionStopResume.getstatus()==0)
                        {
                            if((commonService.getServerDateTime().equals(tblAuctionStopResume.getauctionstartdate())) ||(commonService.getServerDateTime().after(tblAuctionStopResume.getauctionstartdate())))
                            {
                                ValidationMsg="";
                            }
                        }
                    }
                }
            }
        }
        return ValidationMsg;
    }
    
    public Date CurrentDateInUTC()throws Exception
    {
        SimpleDateFormat lv_formatter = new SimpleDateFormat(); 
        lv_formatter.setTimeZone(TimeZone.getTimeZone("UTC"));  
        Date dt=new Date(lv_formatter.format(new Date()));
        return dt;
    }
    public Date ConvertInUTC(Date dt)throws Exception
    {
        SimpleDateFormat lv_formatter = new SimpleDateFormat(); 
        lv_formatter.setTimeZone(TimeZone.getTimeZone("UTC"));  
        Date dt1=new Date(lv_formatter.format(dt));
        return dt1;
    }
   @Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
   public List<TblAuctionStopResume> getAuctionStopResumeDetail(Integer tenderId)
   {
       Map<String,Object> var=new HashMap<String,Object>();
       var.put("tenderId",tenderId);
       StringBuilder query=new StringBuilder();
       query.append("select auctionstopresumeId,status,auctionstartdate,auctionenddate,remark from tbl_auctionstopresume where tenderid=:tenderId order by auctionstopresumeId desc limit 2");
       List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
       List<TblAuctionStopResume> lsttblAuctionStopResume=new ArrayList<TblAuctionStopResume>();
       for(int i=0;i<lst.size();i++)
       {
           TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
           tblAuctionStopResume.setauctionstopresumeId((Integer)lst.get(i)[0]);
           tblAuctionStopResume.setstatus((Integer)lst.get(i)[1]);
           tblAuctionStopResume.setauctionstartdate((Date)lst.get(i)[2]);
           tblAuctionStopResume.setauctionenddate((Date)lst.get(i)[3]);
           tblAuctionStopResume.setremark((String)lst.get(i)[4]);
           lsttblAuctionStopResume.add(tblAuctionStopResume);
       }
       return lsttblAuctionStopResume;
   }
   
    /*auction end*/
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
public void updateBidConversion(TblBidDetail tblBidDetail)throws Exception{
  
    StringBuilder query=new StringBuilder();
    Map<String,Object> var=new HashMap<String,Object>();
    var.put("cellValue", tblBidDetail.getCellValue());
    var.put("BidDetailId",tblBidDetail.getBidDetailId());
    query=new StringBuilder();
    query.append("update tbl_bidDetail set cellValue=:cellValue where bidDetailId=:BidDetailId");
    int i=hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);
   
    
} 
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
public List<TblTenderBidDetail> getTenderBidDetailForBidConverstion(Integer tenderId)throws Exception
{
    StringBuilder query=new StringBuilder();
    Map<String,Object> var=new HashMap<String,Object>();
    var.put("tenderId",tenderId);
    query.append("select tbd.cellValue,tbd.bidDetailId,ttc.isCurrConvReq,ttc.filledBy,ttb.bidderId from tbl_tenderbidDetail tbd  " +
" inner join tbl_tendercell tc on tc.cellId=tbd.cellId " +
" inner join tbl_tendercolumn ttc on ttc.columnId=tc.columnId " +
" inner join tbl_tenderbidmatrix tbm on tbm.bidTableId=tbd.bidTableId " +
" inner join tbl_tenderBid ttb on ttb.bidId=tbm.bidId " +
" where ttc.formId in (select formId from tbl_tenderform tf where tf.tenderId=:tenderId) and ttc.filledBy in (2,3)");
    List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
    List<TblTenderBidDetail> lstTblTenderBidDetail=new ArrayList<TblTenderBidDetail>();
    for(int i=0;i<lst.size();i++){
        TblTenderBidDetail tblTenderBidDetail=new TblTenderBidDetail();
        tblTenderBidDetail.setCellvalue((String)lst.get(i)[0]);
        tblTenderBidDetail.setBiddetailid((Integer)lst.get(i)[1]);
        TblTenderColumn tblTenderColumn=new TblTenderColumn();
        tblTenderColumn.setFilledBy((Integer)lst.get(i)[3]);
        tblTenderColumn.setIsCurrConvReq((Integer)lst.get(i)[2]);
        TblTenderCell tblTenderCell=new TblTenderCell();
        tblTenderCell.setTblTenderColumn(tblTenderColumn);
        tblTenderBidDetail.setTblTendercell(tblTenderCell);
       
        TblTenderBidMatrix tblTenderBidMatrix=new TblTenderBidMatrix();
        TblTenderBid tblTenderBid=new TblTenderBid();
        tblTenderBid.setBidderid((Integer)lst.get(i)[4]);
        tblTenderBidMatrix.setTblTenderbid(tblTenderBid);
        tblTenderBidDetail.setTblTenderbidmatrix(tblTenderBidMatrix);
         lstTblTenderBidDetail.add(tblTenderBidDetail);
    }
    return lstTblTenderBidDetail;
}
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
public void updateTblTenderBidDetailForBidConversion(TblTenderBidDetail tblTenderBidDetail)throws Exception{
    StringBuilder query=new StringBuilder();
    Map<String,Object> var=new HashMap<String,Object>();
    var.put("cellValue", tblTenderBidDetail.getCellvalue());
    var.put("bidDetailId",tblTenderBidDetail.getBiddetailid());
    query.append("update tbl_tenderbiddetail set cellValue=:cellValue where bidDetailId=:bidDetailId");
    int i=hibernateQueryDao.updateDeleteSQLQuery(query.toString(), var);
    
}
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
public List<TblTenderCellGrandTotal> getGtCellValueForBidConversion(Integer tenderId)throws Exception{
    StringBuilder query=new StringBuilder();
    Map<String,Object> var=new HashMap<String,Object>();
    var.put("tenderId",tenderId);
    query.append("select cellGrandTotalId,bidderId,GTValue from tbl_tendercellgrandtotal where tenderId=:tenderId");
    List<Object[]> lst=hibernateQueryDao.nativeSQLQuery(query.toString(), var);
    List<TblTenderCellGrandTotal> lstTblTenderCellGrandTotal=new ArrayList<TblTenderCellGrandTotal>();
    for(int i=0;i<lst.size();i++){
        TblTenderCellGrandTotal tblTenderCellGrandTotal=new TblTenderCellGrandTotal();
        tblTenderCellGrandTotal.setCellGrandTotalId((Integer)lst.get(i)[0]);
        tblTenderCellGrandTotal.setTblBidder(new TblBidder((Integer)lst.get(i)[1]));
        tblTenderCellGrandTotal.setGTValue((String)lst.get(i)[2]);
        lstTblTenderCellGrandTotal.add(tblTenderCellGrandTotal);
    }
    return lstTblTenderCellGrandTotal;
}
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
public void updateTblTenderCellGrandTotalForBidConversion(TblTenderCellGrandTotal tblTenderCellGrandTotal)throws Exception{
    Map<String,Object> var=new HashMap<String,Object>();
    var.put("GTValue",tblTenderCellGrandTotal.getGTValue());
    var.put("cellGrandTotalId",tblTenderCellGrandTotal.getCellGrandTotalId());
    int i=hibernateQueryDao.updateDeleteSQLQuery("update tbl_tenderCellGrandTotal set GTValue=:GTValue where cellGrandTotalId=:cellGrandTotalId", var);
}

@Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
public void updateTblTenderRebateForBidConversion(TblTenderRebate tblTenderRebate)throws Exception{
    Map<String,Object> var=new HashMap<String,Object>();
    var.put("rebateValue",tblTenderRebate.getRebateValue());
    var.put("tenderRebateId",tblTenderRebate.getTenderRebateId());
    int i=hibernateQueryDao.updateDeleteSQLQuery("update tbl_tenderrebate set rebateValue=:rebateValue where tenderRebateId=:tenderRebateId", var);
}

@Transactional(propagation = Propagation.REQUIRED,rollbackFor = {Exception.class})
public void updateTblTenderForBidConversion(Integer tenderId)throws Exception{
    Map<String,Object> var=new HashMap<String,Object>();
    var.put("tenderId",tenderId);
    int i=hibernateQueryDao.updateDeleteSQLQuery("update tbl_tender set isBidConverted=1 where tenderId=:tenderId", var);
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public static String checkRequestNull(HttpServletRequest request, String param) {
        String val = "";
        if (request.getParameter(param) != null) {
            return request.getParameter(param).toString().trim();
        }
        return val.trim();
    }

    public static int convertInt(Object param) {
        try {
            if (param != null) {
                return Integer.parseInt(param.toString().trim());
            }
            return -1;
        } catch (NumberFormatException ex) {
            return -1;
        }
    }

    public static String checkStringNull(String param) {
        if (param == null) {
            return "";
        } else {
            return param;
        }
    }
}
