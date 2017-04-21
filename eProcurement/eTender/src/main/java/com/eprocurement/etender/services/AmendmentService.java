/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.model.TblProcess;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.etender.controller.AmendmentController;
import com.eprocurement.etender.databean.TenderCorrigendumDetailDtBean;
import com.eprocurement.etender.databean.TenderDtBean;
import com.eprocurement.etender.model.TblCorrigendum;
import com.eprocurement.etender.model.TblCorrigendumDetail;
import com.eprocurement.etender.model.TblCurrency;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblProcurementNature;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;

@Service
public class AmendmentService {

    @Autowired
    HibernateQueryDao hibernateQueryDao;
    @Autowired
    EProcureCreationService eventCreationService;
    @Autowired
    TenderCommonService tenderCommonService;
    @Autowired
    CommonService commonService;
    @Autowired
    CommonDAO commonDAO;
	@Value("#{etenderProperties['isProductionServer']}")
    private Boolean isProductionServer;
    @Autowired
    FormService biddingFormService;
    
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
    @Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
    @Value("#{etenderProperties['corrigendum_upload']}")
    private int corrigendumUpload;
    private  static final String OBJECTID = "objectId";
    @Autowired
    OfficerService officerService;
    @Autowired
    private ReloadableResourceBundleMessageSource messageSource;
    public final String EMPTY = "";
    public final String COLON = "::";
    
    /**
     * @param corrigendumText
     * @param tenderId
     * @param corrigendumId
     * @return
     * @throws Exception
     */
    public void updateCorrigendum(String corrigendumText, int tenderId, int corrigendumId) throws Exception {        
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("corrigendumText", corrigendumText);
        var.put(EProcureCreationService.TENDERID, tenderId);
        var.put("corrigendumId", corrigendumId);
        commonDAO.executeUpdate("update TblCorrigendum set corrigendumText=:corrigendumText where objectId=:tenderId and corrigendumId=:corrigendumId", var);;
   }

    /**
     * @param tenderId
     * @return
     * @throws Exception
     */
    public List<TblCorrigendum> getPendingCorrigendumByTenderId(int tenderId) throws Exception {
        return commonDAO.findEntity(TblCorrigendum.class,OBJECTID, Operation_enum.EQ, tenderId, "cstatus", Operation_enum.IN, new Object[]{0, 3});
    }

    /**
     * @param tenderId
     * @return
     * @throws Exception
     */
    public List<TblCorrigendum> getAllCorrigendumByTenderId(int tenderId) throws Exception {
        return commonDAO.findEntity(TblCorrigendum.class,OBJECTID, Operation_enum.EQ, tenderId, "corrigendumId", Operation_enum.ORDERBY, Operation_enum.DESC);
    }

    /**
     * @param corrigendumId
     * @return
     * @throws Exception
     */
    public List<TblCorrigendum> getAmendmentByCorrigendumId(int corrigendumId) throws Exception {
        return commonDAO.findEntity(TblCorrigendum.class,"corrigendumId", Operation_enum.EQ, corrigendumId,"corrigendumId", Operation_enum.ORDERBY, Operation_enum.DESC);
    }
    /**
     * @param corrigendumId
     * @return
     * @throws Exception
     */
    public List<TblCorrigendumDetail> getAmendmentDetailByTenderId(int corrigendumId) throws Exception {
        return commonDAO.findEntity(TblCorrigendumDetail.class,"tblCorrigendum.corrigendumId", Operation_enum.EQ, corrigendumId);
    }

    /**
     * 
     * @param corrigendumId
     * @return
     * @throws Exception
     */
    public List<TblCorrigendumDetail> getAmendmentDetailWithProcessId(int corrigendumId) throws Exception {
    	 Map<String, Object> var = new HashMap<String, Object>();
         var.put("corrigendumId", corrigendumId);
         List<TblCorrigendumDetail> tblCorrigendumDetailList = new ArrayList<TblCorrigendumDetail>(); 
    	 List<Object[]> list= commonDAO.executeSelect("select actionType, corrigendumDetailId,createdBy,createdOn,fieldLabel,fieldName,newValue,objectId,oldValue,tblCorrigendumDetail.tblProcess.processId,tblCorrigendumDetail.tblCorrigendum.corrigendumId from TblCorrigendumDetail tblCorrigendumDetail where tblCorrigendumDetail.tblCorrigendum.corrigendumId=:corrigendumId", var);;
	    	 if(list != null && !list.isEmpty())
	    	 {
	    		 for(Object[] object : list){
	    		 TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();
	    		 tblCorrigendumDetail.setActionType(object[0] != null && !object[0].equals(EMPTY) ? Integer.parseInt(object[0].toString()) : 0);
	    		 tblCorrigendumDetail.setCorrigendumDetailId(object[1] != null && !object[1].equals(EMPTY) ? Integer.parseInt(object[1].toString()) : 0);
	    		 tblCorrigendumDetail.setCreatedBy(object[2] != null && !object[2].equals(EMPTY) ? Integer.parseInt(object[2].toString()) : 0);
	    		 tblCorrigendumDetail.setFieldLabel(object[4] != null && !object[4].equals(EMPTY) ? object[4].toString() : EMPTY);
	    		 tblCorrigendumDetail.setFieldName(object[5] != null && !object[5].equals(EMPTY) ? object[5].toString() : EMPTY);
	    		 tblCorrigendumDetail.setNewValue(object[6] != null && !object[6].equals(EMPTY) ? object[6].toString() : EMPTY);
	    		 tblCorrigendumDetail.setObjectId(object[7] != null && !object[7].equals(EMPTY) ? Integer.parseInt(object[7].toString()) : 0);
	    		 tblCorrigendumDetail.setOldValue(object[8] != null && !object[8].equals(EMPTY) ? object[8].toString() : EMPTY);
	    		 tblCorrigendumDetail.setTblProcess(new TblProcess(object[9] != null && !object[9].equals(EMPTY) ? Integer.parseInt(object[9].toString()) : 0));
	    		 tblCorrigendumDetail.setTblCorrigendum(new TblCorrigendum(object[10] != null && !object[10].equals(EMPTY) ? Integer.parseInt(object[10].toString()) : 0));
	    		 tblCorrigendumDetailList.add(tblCorrigendumDetail);
	    	 }
    	 }
	    	 return tblCorrigendumDetailList;
    }
    
    /**
     * @param currencyId
     * @return
     * @throws Exception
     */
    public String getCurrencyNameById(int tenderCurrencyId, int tenderId) throws Exception {
        String result = EMPTY;
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        List<TblTenderCurrency> lstTenderCurr = commonDAO.findEntity(TblTenderCurrency.class,"tblTender.tenderId", Operation_enum.EQ, tenderId, "tenderCurrencyId", Operation_enum.EQ, tenderCurrencyId);
        if (lstTenderCurr != null && !lstTenderCurr.isEmpty()) {           
                var.put("currencyId", lstTenderCurr.get(0).getTblCurrency().getCurrencyId());
                list = commonDAO.executeSelect("select currencyName from  TblCurrency where currencyId=:currencyId", var);
                    }

        if (list != null) {
            result = list.get(0).toString();
        }
        return result;
    }

    /**
     * @param corrigendumId
     * @return
     * @throws Exception
     */
    public List<TenderCorrigendumDetailDtBean> getCorrigendumDetailForEditByTenderId(int corrigendumId) throws Exception {
        List<TenderCorrigendumDetailDtBean> resultList = new ArrayList<TenderCorrigendumDetailDtBean>();

        List<TblCorrigendumDetail> corrigendumDetailst = commonDAO.findEntity(TblCorrigendumDetail.class,"tblCorrigendum.corrigendumId", Operation_enum.EQ, corrigendumId, "actionType", Operation_enum.NE, 3);
        if (corrigendumDetailst != null) {
            for (int i = 0; i < corrigendumDetailst.size(); i++) {
                TenderCorrigendumDetailDtBean tenderCorrigendumDtBean = new TenderCorrigendumDetailDtBean();
                tenderCorrigendumDtBean.setFieldName(corrigendumDetailst.get(i).getFieldName());
                tenderCorrigendumDtBean.setFieldLabel(corrigendumDetailst.get(i).getFieldLabel());
                if (corrigendumDetailst.get(i).getTblProcess().getProcessId()!=2) {
                    if (corrigendumDetailst.get(i).getNewValue() != null && !corrigendumDetailst.get(i).getNewValue().equals(EMPTY) && corrigendumDetailst.get(i).getNewValue().contains(COLON)) {
                        String newValue[] = corrigendumDetailst.get(i).getNewValue().split(COLON);
                        tenderCorrigendumDtBean.setNewValue(newValue[1]);
                    } else {
                        tenderCorrigendumDtBean.setNewValue(corrigendumDetailst.get(i).getNewValue());
                    }
                } else {
                    List<TblTenderCurrency> lstTenderCurr = commonDAO.findEntity(TblTenderCurrency.class,
                    		"tenderCurrencyId", Operation_enum.EQ, corrigendumDetailst.get(i).getObjectId());
                    if (lstTenderCurr != null) {
                        tenderCorrigendumDtBean.setObjectId(corrigendumDetailst.get(i).getObjectId());
                        tenderCorrigendumDtBean.setProcessId(corrigendumDetailst.get(i).getTblProcess().getProcessId());
                    }
                }
                resultList.add(tenderCorrigendumDtBean);
            }
        }
        return resultList;
    }

    /**
     * @param objectId
     * @return
     */
    public int getPendingCorrigendumId(int objectId) {
        int corrigendumId = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(OBJECTID, objectId);
        var.put("tender_corrigendum_pending", 0);
        List<Object> corrigendumIdList = commonDAO.executeSelect("select corrigendumId from TblCorrigendum where objectId=:objectId and cstatus=:tender_corrigendum_pending", var);
        if (corrigendumIdList != null && !corrigendumIdList.isEmpty()) {
            corrigendumId = Integer.valueOf(corrigendumIdList.get(0).toString());
        }
        return corrigendumId;
    }

   
    /**
     * @param corrigendumId
     * @return {@code List<Object[]>}
     */
    public List<Object[]> getTenderCorrigendumDtls(int corrigendumId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("corrigendumId", corrigendumId);

        query.append("select tblcorrigendumdetail.objectId,")
                .append("concat('Tbl',substring(tblprocess.tableName,locate('_',tblprocess.tableName)+1,length(tblprocess.tableName))),")
                .append(" case when tblcorrigendumdetail.actionType=1 then 'insert' when tblcorrigendumdetail.actionType=2 then 'update' ")
                .append(" when tblcorrigendumdetail.actionType=3 then 'cancel' end,tblcorrigendumdetail.fieldName,")
                .append(" case when tblcorrigendumdetail.newValue like'%"+COLON+"%' then ")
                .append(" substring(tblcorrigendumdetail.newValue,locate('"+COLON+"',tblcorrigendumdetail.newValue)+2,length(tblcorrigendumdetail.newValue)) ")
                .append(" else tblcorrigendumdetail.newValue end")
                .append(" from TblCorrigendumDetail tblcorrigendumdetail ")
                .append(" inner join tblcorrigendumdetail.tblProcess tblprocess ")
                .append(" where tblcorrigendumdetail.tblCorrigendum.corrigendumId=:corrigendumId")
                .append(" order by tblcorrigendumdetail.tblProcess.processId,tblcorrigendumdetail.actionType");

        return commonDAO.executeSelect(query.toString(), var);
    }

    /**
     * @param corrigendumId
     * @return {@code List<Object>}
     */
    public List<Object> getCorrigendumProcessTbls(int corrigendumId) throws Exception {
        StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("corrigendumId", corrigendumId);

        query.append("select distinct ")
                .append(" case when tblcorrigendumdetail.tblProcess.processId=1 then 'TblTender' ")
                .append(" when tblcorrigendumdetail.tblProcess.processId=2 then 'TblTenderCurrency' ")
                .append(" when tblcorrigendumdetail.tblProcess.processId=3 then 'TblTenderEnvelope' ")
                .append(" when tblcorrigendumdetail.tblProcess.processId=4 then 'TblTenderForm' end ")
                .append(" from TblCorrigendumDetail tblcorrigendumdetail ")
                .append(" where tblcorrigendumdetail.tblCorrigendum.corrigendumId=:corrigendumId");

        return commonDAO.executeSelect(query.toString(), var);
    }
    /**
    * 
    * @param fieldName
    * @param fieldLabel
    * @param oldValue
    * @param newValue
    * @param userDetailId
    * @param corrigendumId
    * @param objectId
    * @param tblCorrigendumDetails 
    */
   private void setCorrigendumDetailBean(String fieldName, String fieldLabel, String oldValue, String newValue, int userDetailId, int corrigendumId, int objectId, List<TblCorrigendumDetail> tblCorrigendumDetails) {
       TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();
       TblProcess tblProcess = new TblProcess(1);
       TblCorrigendum tblCorrigendum = new TblCorrigendum(corrigendumId);
       tblCorrigendumDetail.setFieldName(fieldName);
       tblCorrigendumDetail.setFieldLabel(fieldLabel);
       tblCorrigendumDetail.setOldValue(oldValue == null ? EMPTY : oldValue );
       tblCorrigendumDetail.setNewValue(newValue == null ? EMPTY : newValue);
       tblCorrigendumDetail.setObjectId(objectId);
       tblCorrigendumDetail.setActionType(2);
       tblCorrigendumDetail.setTblProcess(tblProcess);
       tblCorrigendumDetail.setCreatedBy(userDetailId);
       tblCorrigendumDetail.setTblCorrigendum(tblCorrigendum);
       tblCorrigendumDetails.add(tblCorrigendumDetail);
   }
 
    /**
     * @return
     */
    public Map<String,List<String>> getCorrigendumStatus(){
    	Map<String,List<String>> map = new HashMap<String, List<String>>();
    	ArrayList<String> dates = new ArrayList<String>();
    	dates.add("documentStartDate");
    	dates.add("documentEndDate");
    	dates.add("submissionStartDate");
    	dates.add("submissionEndDate");
    	dates.add("preBidStartDate");
    	dates.add("preBidEndDate");
    	dates.add("openingDate");
    	map.put("DATES", dates);
    	return map;
    }
    /**
     * 
     * @param tenderDtBean
     * @param corrigendumId
     * @param objectId
     * @param lst
     * @param currIdList
     * @param currencyId
     * @param envelopeType
     * @param userDetailId
     * @param labelMap
     * @return
     * @throws Exception
     */
    public boolean setAmendmentData(TenderDtBean tenderDtBean,int corrigendumId,int objectId,String[] lst,String currIdList,String currencyId,int envelopeType, int userDetailId, Map<String, Object> labelMap) throws Exception {
       
        String newValue = EMPTY;
        String oldValue = EMPTY;
        List<TblCorrigendumDetail> tblCorrigendumDetails = new ArrayList<TblCorrigendumDetail>();       
        
        if (objectId > 0) {
        	List<Object> lstTenderDetail = eventCreationService.getTenderDetail(objectId);
            TblTender oriTender = tenderCommonService.getTenderById(objectId);
            if (oriTender != null) {
                    if (tenderDtBean.getSelProcurementNatureId() != oriTender.getProcurementNatureId()) {
                        setCorrigendumDetailBean("procurementNatureId", labelMap.get("procurementNatureId").toString(), String.valueOf(oriTender.getProcurementNatureId()), String.valueOf(tenderDtBean.getSelProcurementNatureId()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    if(tenderDtBean.getSelProcurementNatureId()==5){
                         if (!tenderDtBean.getTxtOtherProcNature().equals(oriTender.getOtherProcurementNature())) {
                                setCorrigendumDetailBean("otherProcurementNature","field_otherProcurementNature", oriTender.getOtherProcurementNature(), tenderDtBean.getTxtOtherProcNature() ,userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                         }
                      }
                    if (!tenderDtBean.getTxtProjectDuration().isEmpty() && !tenderDtBean.getTxtProjectDuration().equals(0) && !tenderDtBean.getTxtProjectDuration().equals(oriTender.getProjectDuration().toString())) {
                        setCorrigendumDetailBean("projectDuration", labelMap.get("projectDuration").toString(), oriTender.getProjectDuration().toString(), tenderDtBean.getTxtProjectDuration(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                   if (StringUtils.hasLength(tenderDtBean.getTxtTenderValue()) && !new BigDecimal(tenderDtBean.getTxtTenderValue()).setScale(5).toString().equals(new BigDecimal(oriTender.getTenderValue().toString()).setScale(5).toString())) {
                        setCorrigendumDetailBean("tenderValue", labelMap.get("tenderValue").toString(), oriTender.getTenderValue().toString(), tenderDtBean.getTxtTenderValue(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                
                if (!String.valueOf(tenderDtBean.getSelIsItemwiseWinner()).equals(String.valueOf(oriTender.getIsItemwiseWinner()))) {
                    if (tenderDtBean.getSelIsItemwiseWinner() == 1) {
                        newValue = AmendmentController.LBL_ALLOW ;
                        oldValue = AmendmentController.LBL_DONTALLOW;
                    } else {
                        newValue = AmendmentController.LBL_DONTALLOW;
                        oldValue = AmendmentController.LBL_ALLOW;
                    }
                    setCorrigendumDetailBean("isItemwiseWinner", labelMap.get("isItemwiseWinner").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getSelTenderMode() != 0) {
                    if (!String.valueOf(tenderDtBean.getSelTenderMode()).equals(String.valueOf(oriTender.getTenderMode()))) {
                        if (tenderDtBean.getSelTenderMode() == 1) {
                            newValue = "label_open"+COLON+"1";
                        } else if (tenderDtBean.getSelTenderMode() == 2) {
                            newValue = "label_limited"+COLON+"2";

                        } else if (tenderDtBean.getSelTenderMode() == 3) {
                        	newValue = "lbl_single"+COLON+"3";
                        }
                        if (oriTender.getTenderMode() == 1) {
                            oldValue = "label_open"+COLON+"1";
                        } else if (oriTender.getTenderMode() == 2) {
                            oldValue = "label_limited"+COLON+"2";

                        } else if (oriTender.getTenderMode() == 3) {
                        	newValue = "lbl_single"+COLON+"3";
                        }
                        setCorrigendumDetailBean("tenderMode", labelMap.get("tenderMode").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                    if (!String.valueOf(tenderDtBean.getSelIsBidWithdrawal()).equals(String.valueOf(oriTender.getIsBidWithdrawal()))) {
                        if (tenderDtBean.getSelIsBidWithdrawal() == 0) {
                            newValue = AmendmentController.LBL_DONTALLOW;
                            oldValue = AmendmentController.LBL_ALLOW ;
                        } else {
                            newValue = AmendmentController.LBL_ALLOW ;
                            oldValue = AmendmentController.LBL_DONTALLOW;
                        }
                        setCorrigendumDetailBean("isBidWithdrawal", labelMap.get("isBidWithdrawal").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    if (!String.valueOf(tenderDtBean.getSelBiddingVariant()).equals(String.valueOf(oriTender.getBiddingVariant()))) {
                        if (tenderDtBean.getSelBiddingVariant() == 1) {
                            newValue = "label_buy"+COLON+"1";
                            oldValue = "label_sell"+COLON+"2";
                        } else {
                            newValue = "label_sell"+COLON+"2";
                            oldValue = "label_buy"+COLON+"1";
                        }
                        setCorrigendumDetailBean("biddingVariant", labelMap.get("biddingVariant").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    if (!String.valueOf(tenderDtBean.getSelIsPreBidMeeting()).equals(String.valueOf(oriTender.getIsPreBidMeeting()))) {
                        if (tenderDtBean.getSelIsPreBidMeeting() == 0) {
                            newValue = AmendmentController.LBL_DONTALLOW;
                            oldValue = AmendmentController.LBL_ALLOW ;
                        } else {
                            newValue = AmendmentController.LBL_ALLOW ;
                            oldValue = AmendmentController.LBL_DONTALLOW;
                        }
                        setCorrigendumDetailBean("isPreBidMeeting", labelMap.get("isPreBidMeeting").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                    
                    if (!tenderDtBean.getTxtaPreBidAddress().equals(oriTender.getPreBidAddress())) {
                        setCorrigendumDetailBean("preBidAddress", labelMap.get("preBidAddress").toString(), oriTender.getPreBidAddress(), tenderDtBean.getTxtaPreBidAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);

                    }
               // compair with utc date time sql format
                    if (!tenderDtBean.getTxtDocumentEndDate().isEmpty()) {
                        if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtDocumentEndDate())+".0").equals(oriTender.getDocumentEndDate().toString())) {
                            if(oriTender.getDocumentEndDate()==null){
                                setCorrigendumDetailBean("documentEndDate", labelMap.get("documentEndDate").toString(), EMPTY, commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtDocumentEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                            }
                            else{
                                setCorrigendumDetailBean("documentEndDate", labelMap.get("documentEndDate").toString(), oriTender.getDocumentEndDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtDocumentEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                            }
                         }
                    }
               
                if (!tenderDtBean.getTxtSubmissionEndDate().isEmpty()) {
                    if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtSubmissionEndDate())+".0").equals(oriTender.getSubmissionEndDate().toString())) {
                         if(oriTender.getSubmissionEndDate()==null){
                            setCorrigendumDetailBean("submissionEndDate", labelMap.get("submissionEndDate").toString(),EMPTY, commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtSubmissionEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                         }
                         else{
                             setCorrigendumDetailBean("submissionEndDate", labelMap.get("submissionEndDate").toString(), oriTender.getSubmissionEndDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm, sql_dateformate, tenderDtBean.getTxtSubmissionEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                         }
                    }
                }
                if (tenderDtBean.getSelIsPreBidMeeting() == 1) {
                    if (!tenderDtBean.getTxtPreBidStartDate().isEmpty()) {
                        if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidStartDate())+".0").equals(oriTender.getPreBidStartDate().toString())) {
                             if(oriTender.getPreBidStartDate()==null){
                                setCorrigendumDetailBean("preBidStartDate", labelMap.get("preBidStartDate").toString(), EMPTY, commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidStartDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                             else{
                                 setCorrigendumDetailBean("preBidStartDate", labelMap.get("preBidStartDate").toString(), oriTender.getPreBidStartDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidStartDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                        }
                    }
                }
                if (tenderDtBean.getSelIsPreBidMeeting() == 1) {
                    if (!tenderDtBean.getTxtPreBidEndDate().isEmpty()) {
                        if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidEndDate())+".0").equals(oriTender.getPreBidEndDate().toString())) {
                             if(oriTender.getPreBidEndDate()==null){
                                setCorrigendumDetailBean("preBidEndDate", labelMap.get("preBidEndDate").toString(), EMPTY, commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                             else{
                                 setCorrigendumDetailBean("preBidEndDate", labelMap.get("preBidEndDate").toString(), oriTender.getPreBidEndDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtPreBidEndDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                             }
                        }
                    }
                }
                if (!tenderDtBean.getTxtBidOpenDate().isEmpty()) {
                    if (!(commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtBidOpenDate())+".0").equals(oriTender.getOpeningDate().toString())) {
                          if(oriTender.getOpeningDate()==null){
                            setCorrigendumDetailBean("openingDate", labelMap.get("openingDate").toString(), EMPTY, commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtBidOpenDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                          }
                          else{
                              setCorrigendumDetailBean("openingDate", labelMap.get("openingDate").toString(), oriTender.getOpeningDate().toString(), commonService.convertToDBDate(client_dateformate_hhmm,sql_dateformate,tenderDtBean.getTxtBidOpenDate()), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                          }
                    }
                }
                if (!String.valueOf(tenderDtBean.getSelIsDocfeesApplicable()).equals(String.valueOf(oriTender.getIsDocfeesApplicable()))) {
                	newValue=tenderDtBean.getSelIsDocfeesApplicable()==0?AmendmentController.LBL_DONTALLOW:AmendmentController.LBL_ALLOW ;
                	oldValue=oriTender.getIsDocfeesApplicable()==0?AmendmentController.LBL_DONTALLOW:AmendmentController.LBL_ALLOW ;
                    setCorrigendumDetailBean("isDocfeesApplicable", labelMap.get("isDocfeesApplicable").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                
                if (tenderDtBean.getSelIsDocfeesApplicable() == 1) {
                	 String txtDocAmtNew = new BigDecimal(tenderDtBean.getTxtDocumentFee()).setScale(2,BigDecimal.ROUND_UP).toString();
                	 String txtDocAmtOld =  oriTender.getIsDocfeesApplicable()==0?"-": new BigDecimal(oriTender.getDocumentFee()!=null && oriTender.getDocumentFee().length()!=0 ? oriTender.getDocumentFee() : "0.00").setScale(2,BigDecimal.ROUND_UP).toString();
                    if (!txtDocAmtNew.equals(String.valueOf(txtDocAmtOld))) {
                        setCorrigendumDetailBean("documentFee", labelMap.get("documentFee").toString(), txtDocAmtOld, txtDocAmtNew, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                if (tenderDtBean.getSelIsDocfeesApplicable() == 1) {
                    if (!tenderDtBean.getTxtaDocFeePaymentAddress().equals(oriTender.getDocFeePaymentAddress())) {
                        setCorrigendumDetailBean("docFeePaymentAddress", labelMap.get("docFeePaymentAddress").toString(), oriTender.getDocFeePaymentAddress(), tenderDtBean.getTxtaDocFeePaymentAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                    if (!String.valueOf(tenderDtBean.getSelIsSecurityfeesApplicable()).equals(String.valueOf(oriTender.getIsSecurityfeesApplicable()))) {
                        if (tenderDtBean.getSelIsSecurityfeesApplicable() == 1) {
                            newValue = AmendmentController.LBL_ALLOW ;
                            oldValue =AmendmentController.LBL_DONTALLOW;
                        } else {
                            newValue =AmendmentController.LBL_DONTALLOW;
                            oldValue = AmendmentController.LBL_ALLOW ;
                        }
                    	setCorrigendumDetailBean("isSecurityfeesApplicable", labelMap.get("isSecurityfeesApplicable").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                if (tenderDtBean.getSelIsSecurityfeesApplicable() == 1) {
                	String txtSecAmtNew = new BigDecimal(tenderDtBean.getTxtSecurityFee()).setScale(2,BigDecimal.ROUND_UP).toString();
               	 	String txtSecAmtOld = new BigDecimal(oriTender.getSecurityFee()!=null && oriTender.getSecurityFee().length()!=0 ? oriTender.getSecurityFee() : "0.00").setScale(2,BigDecimal.ROUND_UP).toString();
                    if (!txtSecAmtNew.equals(txtSecAmtOld)) {
                        setCorrigendumDetailBean("securityFee", labelMap.get("securityFee").toString(), txtSecAmtOld, txtSecAmtNew, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                if (tenderDtBean.getSelIsSecurityfeesApplicable() == 1) {
                    if (!tenderDtBean.getTxtaSecFeePaymentAddress().equals(oriTender.getSecFeePaymentAddress())) {
                        setCorrigendumDetailBean("secFeePaymentAddress", labelMap.get("secFeePaymentAddress").toString(), oriTender.getSecFeePaymentAddress(), tenderDtBean.getTxtaSecFeePaymentAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                    if (!String.valueOf(tenderDtBean.getSelIsEMDApplicable()).equals(String.valueOf(oriTender.getIsEMDApplicable()))) {
                    	newValue=tenderDtBean.getSelIsEMDApplicable()==1?AmendmentController.LBL_EVENTWISE:tenderDtBean.getSelIsEMDApplicable()==2?AmendmentController.LBL_ITEMWISE:AmendmentController.LBL_NOTREQUIRED;
                    	oldValue=oriTender.getIsEMDApplicable()==1?AmendmentController.LBL_EVENTWISE:oriTender.getIsEMDApplicable()==2?AmendmentController.LBL_ITEMWISE:AmendmentController.LBL_NOTREQUIRED;
                        setCorrigendumDetailBean("isEMDApplicable", labelMap.get("isEMDApplicable").toString(), oldValue, newValue, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                if (tenderDtBean.getSelIsEMDApplicable() == 1) {
                	String txtEmdAmtNew = new BigDecimal(tenderDtBean.getTxtEmdAmount()).setScale(2,BigDecimal.ROUND_UP).toString();
                	String txtEmdAmtOld = oriTender.getIsEMDApplicable()==0?"-": new BigDecimal(oriTender.getEmdAmount()!=null && oriTender.getEmdAmount().length()!=0 ? oriTender.getEmdAmount() : "0.00").setScale(2,BigDecimal.ROUND_UP).toString();
                    if (!txtEmdAmtNew.equals(txtEmdAmtOld)) {
                        setCorrigendumDetailBean("emdAmount", labelMap.get("emdAmount").toString(), txtEmdAmtOld, txtEmdAmtNew, userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                    }
                }
                if (tenderDtBean.getSelIsEMDApplicable() == 1 && !tenderDtBean.getTxtaEmdPaymentAddress().equals(oriTender.getEmdPaymentAddress())) {
                    setCorrigendumDetailBean("emdPaymentAddress", labelMap.get("emdPaymentAddress").toString(), oriTender.getEmdPaymentAddress(), tenderDtBean.getTxtaEmdPaymentAddress(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getTxtaKeyword() != null && !tenderDtBean.getTxtaKeyword().equalsIgnoreCase(oriTender.getKeywordText())) {
                    setCorrigendumDetailBean("keywordText", (labelMap.get("keywordText").toString()), oriTender.getKeywordText(), tenderDtBean.getTxtaKeyword().substring(tenderDtBean.getTxtaKeyword().length()-1).equals(",") ? tenderDtBean.getTxtaKeyword().substring(0, tenderDtBean.getTxtaKeyword().length()-1) : tenderDtBean.getTxtaKeyword(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getTxtTenderNo() != null && !tenderDtBean.getTxtTenderNo().equalsIgnoreCase(oriTender.getTenderNo())) {
                    setCorrigendumDetailBean("tenderNo", (labelMap.get("tenderNo").toString()), oriTender.getTenderNo(), tenderDtBean.getTxtTenderNo(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getTxtaTenderBrief() != null && !tenderDtBean.getTxtaTenderBrief().equalsIgnoreCase(oriTender.getTenderBrief())) {
                    setCorrigendumDetailBean("tenderBrief", (labelMap.get("tenderBrief").toString()), oriTender.getTenderBrief(), tenderDtBean.getTxtaTenderBrief(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                if (tenderDtBean.getRtfTenderDetail() != null && !tenderDtBean.getRtfTenderDetail().equalsIgnoreCase(oriTender.getTenderDetail())) {
                    setCorrigendumDetailBean("tenderDetail", (labelMap.get("tenderDetail").toString()), oriTender.getTenderDetail(), tenderDtBean.getRtfTenderDetail(), userDetailId, corrigendumId, objectId, tblCorrigendumDetails);
                }
                List<Integer> oldEnvList = new ArrayList<Integer>();
                if (lst!=null && lst.length>0) {                    
                    for (int i = 0; i < lst.length; i++) {
                        oldEnvList.add(Integer.valueOf(lst[i]));
                    }
                } else {
                    oldEnvList.add(0);
                }
               
                List<String> currencyNewList = new ArrayList<String>();
                List<String> currencyOldList = new ArrayList<String>();
                int baseCurrency = 0;
               
                    if (!String.valueOf(tenderDtBean.getSelCurrencyId()).equals(currencyId)) {
                        baseCurrency = tenderDtBean.getSelCurrencyId();
                    }
                    if (currIdList.length() > 0) {
                       String[] currentValue=   currIdList.split(",");
                       for(int i=0;i<currentValue.length;i++){
                           currencyNewList.add(currentValue[i]);
                       }
                    }
                    Map<Integer, BigDecimal> currencyMap = (Map<Integer, BigDecimal>) lstTenderDetail.get(1);
                    for (Map.Entry<Integer, BigDecimal> entry : currencyMap.entrySet()) { 
                         currencyOldList.add(entry.getKey().toString());
                     }
               
               saveCorrigendumData(tblCorrigendumDetails, corrigendumId, currencyOldList, currencyNewList, baseCurrency, oldEnvList, envelopeType, tenderDtBean.getSelFormType(), tenderDtBean.getTxtBidOpenDate(), objectId, userDetailId);
             }
        return true;
    }

    /**
     * 
     * @param clazz
     * @param value
     * @return
     * @throws ParseException
     */
    public static Object convertToClsObj( Class clazz, String value ) throws ParseException {
	    if( Boolean.class == clazz ){
	    	return Boolean.parseBoolean( value );
	    }
	    if( boolean.class == clazz ){
	    	return Boolean.parseBoolean( value );
	    }
	    if( Byte.class == clazz ){
	    	return Byte.parseByte( value );
	    }
	    if( byte.class == clazz ){
	    	return Byte.parseByte( value );
	    }
	    if( Integer.class == clazz ){
	    	return Integer.parseInt(value);
	    }
	    if( int.class == clazz ){
	    	return Integer.parseInt(value);
	    }
	    if( Double.class == clazz ){
	    	return Double.parseDouble( value );
	    }
	    if( double.class == clazz ){
	    	return Double.parseDouble( value );
	    }
	    if( BigDecimal.class == clazz ){
	    	return new BigDecimal( value );
	    }
	    if( TblProcurementNature.class == clazz ){
	    	return new TblProcurementNature(Integer.parseInt(value));
	    }
	    if( TblDepartment.class == clazz ){
	    	return new TblDepartment(Integer.parseInt(value));
	    }
	    if(Date.class==clazz)
	    {
	    	String date = value;
	    	DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
	        return (Date) formatter.parse(date);
	    }	
	    return value;
	} 
    
    /**
     * 
     * @param data
     * @return
     */
    public String generateDataForView(String data) {
        String[] dataValue = data.split(COLON);
        return messageSource.getMessage(dataValue[0], null, LocaleContextHolder.getLocale());
    }
    /**
     * 
     * @param queries
     * @param queryFields
     * @param tblCorrigendum
     * @param params
     * @return
     * @throws Exception
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public int updateAmendmentDetail(List<String> queries, Map<String,Map<String,Object>> queryFields,TblCorrigendum tblCorrigendum, int... params) throws Exception {
        int cnt = 0;
        boolean isOpeningDate = false;
        boolean isForm = false;
        if (queries != null && !queries.isEmpty()) {
            for (String query : queries) {
            	if(query != null && query.contains("update TblTender set"))
            	{
            		if(queryFields!= null)
            		{
            			if(!queryFields.isEmpty() && queryFields.size()>0)
                		{
                			for (Map.Entry<String, Map<String,Object>> entry : queryFields.entrySet())
                    		{
                    			if(entry.getKey().equalsIgnoreCase("tblTender"))
                    			{
                    				if(query != null && query.contains("openingDate")){
                    					isOpeningDate = true;
                    				}
                    				query = query.replaceAll("TblTender", "tbl_tender");
                    				Map<String,Object> tblTender = entry.getValue();
                    				cnt += commonDAO.executeSqlUpdate(query, tblTender);
                    			}
                    		}	
                		}	
            		}
            	} else if(query != null && query.contains("update TblTenderForm set"))
            	{
               		int count = commonDAO.executeUpdate("update TblTenderForm set cstatus = 1 where cstatus=0 and isCanceled!=1 and tblTender.tenderId="+params[1], null);
                	if(count > 0){
                		isForm = true;	
                	}
            	} else
            	{
            		cnt += commonDAO.executeUpdate(query, null);	
            	}
                
            }
        }
    		
        StringBuilder query = new StringBuilder();
        query.append("update TblCorrigendum set ")
                .append(" remarks='").append(tblCorrigendum.getRemarks()).append("',")
                .append(" publishedOn='").append(commonService.convertDateToString(sql_dateformate,tblCorrigendum.getPublishedOn())).append("',")
                .append(" publishedBy=").append(tblCorrigendum.getPublishedBy()).append(",")
                .append(" cstatus=").append(tblCorrigendum.getCstatus())
                .append(" where corrigendumId=").append(tblCorrigendum.getCorrigendumId());

        if (commonDAO.executeUpdate(query.toString(), null) != 0) {
            query.delete(0, query.length());
            query.append("update TblTender set corrigendumCount=").append(params[0]).append(" where tenderId=").append(params[1]);

            cnt += commonDAO.executeUpdate(query.toString(), null);
        }
    	Map<String,Object> col = new HashMap<String, Object>();
    	col.put(EProcureCreationService.TENDERID, params[1]);
        if(isOpeningDate){
        	commonDAO.executeSqlUpdate("update Tbl_TenderEnvelope set openingDate=(select openingDate from tbl_tender where tenderId=:tenderId) where tenderId=:tenderId and openingDate <> '' and openingDate is not null ", col);
        }
        if(isForm ){
        	// make form cancel
        	commonDAO.executeUpdate("update TblTenderForm set cstatus=3 where cstatus = 1 and isCanceled=1 and tblTender.tenderId=:tenderId", col);
        	List<TblTenderEnvelope> lstTblTenderEnvelope=biddingFormService.getMinimumFormCountForBidding(params[1]);
        	biddingFormService.updateMinimumBiddingFormReqForBidding(lstTblTenderEnvelope);
        	tenderCommonService.updateFinalsubmission(params[1]);
        }
       return cnt;
    }

    public void sendNotificationForCorrigendum(TblTender tblTender, long userId) throws NumberFormatException, Exception {
    	tenderCommonService.sendNotoficationToBidderForNewTender(tblTender,Integer.parseInt(userId+""));
    }

	/**
     * @param tenderId
     * @return
     */
    public int deletePendingCurrencyByTenderId(int tenderId) {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put(EProcureCreationService.TENDERID, tenderId);
        var.put("pending", 0);
        return commonDAO.executeUpdate("delete from TblTenderCurrency where isActive=:pending and tenderId=:tenderId", var);
    }
  
    /**
     * @param formId
     * @return
     * @throws Exception
     */
    public String getFormNameById(int formId) throws Exception {
         List<TblTenderForm> list = commonDAO.findEntity(TblTenderForm.class, "formId", Operation_enum.EQ, formId);
        return (list != null && !list.isEmpty()) ? list.get(0).getFormName() : null;
    }
    /**
     * 
     * @param envelopeId
     * @return
     * @throws Exception 
     */
    public String getEnvelopeNameById(int envelopeId) throws Exception {
        List<TblTenderEnvelope> list = commonDAO.findEntity(TblTenderEnvelope.class,"envelopeId", Operation_enum.EQ, envelopeId);
        return (list != null && !list.isEmpty()) ? list.get(0).getEnvelopeName() : null;
    }
    /**
     * 
     * @param tblCorrigendumDetails
     * @param corrigendumId
     * @param currencyOldList
     * @param currencyNewList
     * @param baseCurrency
     * @param oldEnvList
     * @param envType
     * @param formType
     * @param bidOpeningDate
     * @param objectId
     * @param userDetailId
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void saveCorrigendumData(List<TblCorrigendumDetail> tblCorrigendumDetails, int corrigendumId, List<String> currencyOldList, List<String> currencyNewList, int baseCurrency, List<Integer> oldEnvList, int envType, String[] formType, String bidOpeningDate, int objectId, int userDetailId) throws Exception {
        Map<String, Object> var = new HashMap<String, Object>();
        List<Integer> processIds=new ArrayList<Integer>();
        processIds.add(1);
        processIds.add(2);
        var.put("corrigendumId", corrigendumId);
        var.put("processId",processIds);
        
        /*** Delete TblCorrigendumDetail old details by corrigendumId **/
        commonDAO.executeUpdate("delete from TblCorrigendumDetail tblCorrigendumDetail where tblCorrigendumDetail.tblCorrigendum.corrigendumId=:corrigendumId and processId IN (:processId)", var);
        
        /*** Delete TblTender Currency old details by where c status =0  and tender id = objectId**/
        Map<String, Object> tenderCurrencyVar = new HashMap<String, Object>();
        tenderCurrencyVar.put(OBJECTID, objectId);
        commonDAO.executeUpdate("delete from TblTenderCurrency tblTenderCurrency where tblTenderCurrency.tblTender.tenderId=:objectId and tblTenderCurrency.isActive=0",tenderCurrencyVar);
        commonDAO.saveOrUpdateAll(tblCorrigendumDetails);
        
        //Currency
        /*** Code insert value for TblTenderCurrency and TblCorrigendumDetail*/
        if(currencyNewList != null && !currencyNewList.isEmpty()){
        	if(currencyOldList != null && !currencyOldList.isEmpty()){
	        	 for(String currency : currencyOldList){
	        		currencyNewList.remove(currency);
	        	 }
        	}
        	addTendeCurrencyOnCorrigendum(currencyNewList, objectId, corrigendumId, userDetailId);
        }
        
    }
    
    /**
     * 
     * @param remark
     * @param queryParameter
     * @param objectId
     * @return
     * @throws Exception
     */
      
      public List<String> getCorrigendumDtlQueries(String remark,Map<String,Map<String,Object>> queryParameter, int... objectId) throws Exception {
          List<String> lstQueries = new ArrayList<String>();
          Map<String, Object> tblTender = new HashMap<String, Object>();
          List<Object[]> lstCorrigendumDtls = getTenderCorrigendumDtls(objectId[1]);
          List<Object> lstProcess = getCorrigendumProcessTbls(objectId[1]);
          StringBuilder query = new StringBuilder();
          StringBuilder param = new StringBuilder();
          boolean isKeywordChange = false;
          for (int i = 0; i < lstProcess.size(); i++) {
              String tblName = (String) lstProcess.get(i);
              if ("TblTender".equals(tblName)) {
                  query.delete(0, query.length());
                  query.append("update TblTender set $fieldvalues where tenderId=$tenderId");
              } else if ("TblTenderCurrency".equals(tblName)) {
                  query.delete(0, query.length());
                  query.append("update TblTenderCurrency set isActive=$fieldvalues where tenderCurrencyId in ('$tenderCurrencyId')");

              } else if ("TblTenderForm".equals(tblName)) {
                  query.delete(0, query.length());
                  query.append("update TblTenderForm set cstatus=1 where formId in ('$formId')");

              } else if ("TblTenderEnvelope".equals(tblName)) {
                  query.delete(0, query.length());
                  query.append("update TblTenderEnvelope set cstatus=$fieldvalues,openingDate='$tenderOpeningDt',$addlCols where envelopeId in ('$envelopeId')");

              }
              for (int j = 0; j < lstCorrigendumDtls.size(); j++) {
                  if (tblName.equals(lstCorrigendumDtls.get(j)[1])) {
                      if ("TblTender".equals(lstCorrigendumDtls.get(j)[1])) {
                          param.append((String) lstCorrigendumDtls.get(j)[3]).append("=:").append((String) lstCorrigendumDtls.get(j)[3]).append(",");
                          if((lstCorrigendumDtls.get(j)[3]).toString().equalsIgnoreCase("biddingVariant") && lstCorrigendumDtls.get(j)[4].toString().equals("2")) //if variant is sell then rebate value will be 0.
                          {
                              param.append("isRebateForm").append("=:").append("isRebateForm").append(",");
                              tblTender.put("isRebateForm",0);
                          }else if((lstCorrigendumDtls.get(j)[3]).toString().equalsIgnoreCase("keywordText"))
                          {
                          	isKeywordChange = true;
                          }
                          tblTender.put((String) lstCorrigendumDtls.get(j)[3],(String) lstCorrigendumDtls.get(j)[4]);
                      }else if ("TblTenderForm".equals(lstCorrigendumDtls.get(j)[1])) {
                    	  lstQueries.add(query.toString());
                      } else if ("TblTenderCurrency".equals(lstCorrigendumDtls.get(j)[1])) {
                          if ("cancel".equals(lstCorrigendumDtls.get(j)[2])) {
                              int indx = 0;
                              String regex = "[update TblTenderCurrency set isActive=2 where tenderCurrencyId in (]+['\\d',+]+?[)]+";
                              String tempHql = query.toString().replace("$fieldvalues", "2").replace("$tenderCurrencyId", regex);
                              for (int k = 0; k < lstQueries.size(); k++) {
                                  if (lstQueries.get(k).matches(regex)) {
                                      indx = k;
                                      break;
                                  }
                              }
                              if (indx == 0) {
                                  lstQueries.add(tempHql.replace(regex, String.valueOf(lstCorrigendumDtls.get(j)[0])));
                              } else {
                                  tempHql = lstQueries.get(indx).replace(")", ",'" + lstCorrigendumDtls.get(j)[0] + "')");
                                  lstQueries.remove(indx);
                                  lstQueries.add(indx, tempHql);
                              }
                          } else if ("insert".equals(lstCorrigendumDtls.get(j)[2])) {
                              int indx = 0;
                              String regex = "[update TblTenderCurrency set isActive=1 where tenderCurrencyId in (]+['\\d',+]+?[)]+";
                              String tempHql = query.toString().replace("$fieldvalues", "1").replace("$tenderCurrencyId", regex);

                              for (int k = 0; k < lstQueries.size(); k++) {
                                  if (lstQueries.get(k).toString().matches(regex)) {
                                      indx = k;
                                      break;
                                  }
                              }
                              if (indx == 0) {
                                  lstQueries.add(tempHql.replace(regex, String.valueOf(lstCorrigendumDtls.get(j)[0])));
                              } else {
                                  tempHql = lstQueries.get(indx).toString().replace(")", ",'" + lstCorrigendumDtls.get(j)[0] + "')");
                                  lstQueries.remove(indx);
                                  lstQueries.add(indx, tempHql);
                              }
                          }
                      }             }
                  if (j == (lstCorrigendumDtls.size() - 1)) {
                      if (param.length() != 0) {
                          String finalHqlQuery = query.toString().replace("$fieldvalues", param.replace(param.lastIndexOf(","), param.lastIndexOf(",") + 1, EMPTY))
                        		  .replace("$tenderId", String.valueOf(objectId[0]));
                          param.delete(0, param.length());
                          lstQueries.add(finalHqlQuery);
                      }
                  }
              }
          }
          if(tblTender!=null)
          {
          	if(!tblTender.isEmpty() && tblTender.size()>0)
              {
              	queryParameter.put("tblTender",tblTender);	
              }	
          }
          if(isKeywordChange){
        	  officerService.updateCategoryToTender(objectId[0],objectId[1]);
          }else{
        	  officerService.deleteOldCategory(0l,0,objectId[1]);
          }
          return lstQueries;
      }

    
    /**
     * @param currencyNewList
     * @param objectId
     * @param corrigendumId
     * @param userDetailId
     * @throws Exception 
     */
   public void addTendeCurrencyOnCorrigendum(List<String> currencyNewList,int objectId,int corrigendumId,int userDetailId){
	   
	   TblTenderCurrency tblTenderCurrency;
       TblCorrigendumDetail tblCorrigendumDetail;
       List<TblCorrigendumDetail> tblCorrigendumDetailList = new ArrayList<TblCorrigendumDetail>();
         for (int i = 0; i < currencyNewList.size(); i++) {
       	  
        	 /*** Code to set TblTenderCurrency value and save **/
       	  	 tblTenderCurrency = new TblTenderCurrency();
             tblTenderCurrency.setTblTender(new TblTender(objectId));
             tblTenderCurrency.setTblCurrency(new TblCurrency(Integer.valueOf(currencyNewList.get(i).toString())));  
             tblTenderCurrency.setExchangeRate(new BigDecimal("0.0"));
             tblTenderCurrency.setIsDefault(0);
             tblTenderCurrency.setIsActive(0);
             commonDAO.saveOrUpdate(tblTenderCurrency);
             
             
             /*** Code to set TblCorrigendumDetail value and save **/
              tblCorrigendumDetail = new TblCorrigendumDetail();
              tblCorrigendumDetail.setTblCorrigendum(new TblCorrigendum(corrigendumId));
              tblCorrigendumDetail.setTblProcess(new TblProcess(2));// For TblTenderCurrency
              tblCorrigendumDetail.setObjectId(tblTenderCurrency.getTenderCurrencyId());
              tblCorrigendumDetail.setFieldName(EMPTY);
              tblCorrigendumDetail.setFieldLabel(EMPTY);
              tblCorrigendumDetail.setOldValue(EMPTY);
              tblCorrigendumDetail.setNewValue(EMPTY);
              tblCorrigendumDetail.setActionType(1);// For new insert
              tblCorrigendumDetail.setCreatedBy(userDetailId);
              tblCorrigendumDetailList.add(tblCorrigendumDetail);
         }
         	commonDAO.saveOrUpdateAll(tblCorrigendumDetailList);
   }
    
    
    
    
    /**
     * 
     * @param tenderId
     * @return 
     */
    public boolean deletePendingCorrigendum(int tenderId,int corrigendumId) {
        boolean flag = false;
        if (corrigendumId > 0) {
            Map<String, Object> var = new HashMap<String, Object>();
            var.put("corrigendumId", corrigendumId);
            String strCorrigendumDetailQuery = "delete from  TblCorrigendumDetail  where tblCorrigendum.corrigendumId=:corrigendumId";
            String strCorrigendumQuery = "delete from  TblCorrigendum  where corrigendumId=:corrigendumId";
            commonDAO.executeUpdate(strCorrigendumDetailQuery, var);
            commonDAO.executeUpdate(strCorrigendumQuery, var);
            deletePendingCurrencyByTenderId(tenderId);
            flag = true;
        }
        return flag;
    }
    /**
     * 
     * @param formId
     * @param userDetailId
     * @param tenderId 
     */
    public void insertFormDetailToCorrigendum(int formId, int userDetailId, int tenderId,int actionType) {
        TblProcess tblProcess = new TblProcess(4);
        int corrigendumId = getPendingCorrigendumId(tenderId);
        if (corrigendumId > 0) {
            TblCorrigendum tblCorrigendum = new TblCorrigendum(corrigendumId);

            TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();

            tblCorrigendumDetail.setActionType(actionType);
            tblCorrigendumDetail.setCreatedBy(userDetailId);
            tblCorrigendumDetail.setFieldLabel(EMPTY);
            tblCorrigendumDetail.setFieldName(EMPTY);
            tblCorrigendumDetail.setOldValue(EMPTY);
            tblCorrigendumDetail.setNewValue(EMPTY);
            tblCorrigendumDetail.setObjectId(formId);

            tblCorrigendumDetail.setTblProcess(tblProcess);
            tblCorrigendumDetail.setTblCorrigendum(tblCorrigendum);
            commonDAO.save(tblCorrigendumDetail);
        }
    }
 }
