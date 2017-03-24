/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.services;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.daointerface.HibernateQueryDao;
import com.eprocurement.common.model.TblProcess;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.etender.databean.TenderCorrigendumDetailDtBean;
import com.eprocurement.etender.model.TblCorrigendum;
import com.eprocurement.etender.model.TblCorrigendumDetail;
import com.eprocurement.etender.model.TblCurrency;
import com.eprocurement.etender.model.TblEnvelope;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderCurrency;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.model.TblTenderForm;

/**
 *
 */
@Service
public class CorrigendumService {

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
    
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
    @Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
    @Value("#{etenderProperties['corrigendum_upload']}")
    private int corrigendumUpload;
    private  static final String OBJECTID = "objectId";
    

    /**
     * @param tblCorrigendum
     * @return
     * @throws Exception
     */
    public boolean createCorrigendum(TblCorrigendum tblCorrigendum) throws Exception {
//        tblCorrigendumDao.addTblCorrigendum(tblCorrigendum);
    	commonDAO.saveOrUpdate(tblCorrigendum);
        return true;
    }

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
        var.put("tenderId", tenderId);
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
    public List<TblCorrigendum> getCorrigendumByCorrigendumId(int corrigendumId) throws Exception {
        return commonDAO.findEntity(TblCorrigendum.class,"corrigendumId", Operation_enum.EQ, corrigendumId,"corrigendumId", Operation_enum.ORDERBY, Operation_enum.DESC);
    }
    /**
     * @param corrigendumId
     * @return
     * @throws Exception
     */
    public List<TblCorrigendumDetail> getCorrigendumDetailByTenderId(int corrigendumId) throws Exception {
        return commonDAO.findEntity(TblCorrigendumDetail.class,"tblCorrigendum.corrigendumId", Operation_enum.EQ, corrigendumId);
    }

    /**
     * Create for Bug: 20577	
     * @param corrigendumId
     * @return
     * @throws Exception
     */
    public List<TblCorrigendumDetail> getCorrigendumDetailWithProcessId(int corrigendumId) throws Exception {
    	 Map<String, Object> var = new HashMap<String, Object>();
         var.put("corrigendumId", corrigendumId);
         List<TblCorrigendumDetail> tblCorrigendumDetailList = new ArrayList<TblCorrigendumDetail>(); 
    	 List<Object[]> list= commonDAO.executeSelect("select actionType, corrigendumDetailId,createdBy,createdOn,fieldLabel,fieldName,newValue,objectId,oldValue,tblCorrigendumDetail.tblProcess.processId,tblCorrigendumDetail.tblCorrigendum.corrigendumId from TblCorrigendumDetail tblCorrigendumDetail where tblCorrigendumDetail.tblCorrigendum.corrigendumId=:corrigendumId", var);;
	    	 if(list != null && !list.isEmpty())
	    	 {
	    		 for(Object[] object : list){
	    		 TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();
	    		 tblCorrigendumDetail.setActionType(object[0] != null && !object[0].equals("") ? Integer.parseInt(object[0].toString()) : 0);
	    		 tblCorrigendumDetail.setCorrigendumDetailId(object[1] != null && !object[1].equals("") ? Integer.parseInt(object[1].toString()) : 0);
	    		 tblCorrigendumDetail.setCreatedBy(object[2] != null && !object[2].equals("") ? Integer.parseInt(object[2].toString()) : 0);
//	    		 tblCorrigendumDetail.setCreatedOn((Date) object[3]);
	    		 tblCorrigendumDetail.setFieldLabel(object[4] != null && !object[4].equals("") ? object[4].toString() : "");
	    		 tblCorrigendumDetail.setFieldName(object[5] != null && !object[5].equals("") ? object[5].toString() : "");
	    		 tblCorrigendumDetail.setNewValue(object[6] != null && !object[6].equals("") ? object[6].toString() : "");
	    		 tblCorrigendumDetail.setObjectId(object[7] != null && !object[7].equals("") ? Integer.parseInt(object[7].toString()) : 0);
	    		 tblCorrigendumDetail.setOldValue(object[8] != null && !object[8].equals("") ? object[8].toString() : "");
	    		 tblCorrigendumDetail.setTblProcess(new TblProcess(object[9] != null && !object[9].equals("") ? Integer.parseInt(object[9].toString()) : 0));
	    		 tblCorrigendumDetail.setTblCorrigendum(new TblCorrigendum(object[10] != null && !object[10].equals("") ? Integer.parseInt(object[10].toString()) : 0));
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
        String result = "";
        List<Object> list = null;
        Map<String, Object> var = new HashMap<String, Object>();
        List<TblTenderCurrency> lstTenderCurr = commonDAO.findEntity(TblTenderCurrency.class,"tblTender.tenderId", Operation_enum.EQ, tenderId, "tenderCurrencyId", Operation_enum.EQ, tenderCurrencyId);
        if (lstTenderCurr != null && lstTenderCurr.size() > 0) {           
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
                    if (corrigendumDetailst.get(i).getNewValue() != null && !corrigendumDetailst.get(i).getNewValue().equals("") && corrigendumDetailst.get(i).getNewValue().contains("::")) {
                        String newValue[] = corrigendumDetailst.get(i).getNewValue().split("::");
                        tenderCorrigendumDtBean.setNewValue(newValue[1]);
                    } else {
                        tenderCorrigendumDtBean.setNewValue(corrigendumDetailst.get(i).getNewValue());
                    }
                } else {
                    List<TblTenderCurrency> lstTenderCurr = commonDAO.findEntity(TblTenderCurrency.class,
                    		"tenderCurrencyId", Operation_enum.EQ, corrigendumDetailst.get(i).getObjectId());
                    if (lstTenderCurr != null) {
                        //tenderCorrigendumDtBean.setNewValue(String.valueOf(lstTenderCurr.get(0).getTblCurrency().getCurrencyId()));
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
        var.put("objectId", objectId);
        var.put("tender_corrigendum_pending", 0);
        List<Object> corrigendumIdList = commonDAO.executeSelect("select corrigendumId from TblCorrigendum where objectId=:objectId and cstatus=:tender_corrigendum_pending", var);
        if (corrigendumIdList != null && corrigendumIdList.size() > 0) {
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
                .append(" case when tblcorrigendumdetail.newValue like'%::%' then ")
                .append(" substring(tblcorrigendumdetail.newValue,locate('::',tblcorrigendumdetail.newValue)+2,length(tblcorrigendumdetail.newValue)) ")
                .append(" else tblcorrigendumdetail.newValue end")
                .append(" from TblCorrigendumDetail tblcorrigendumdetail ")
                .append(" inner join tblcorrigendumdetail.tblProcess tblprocess ")
                .append(" where tblcorrigendumdetail.tblCorrigendum.corrigendumId=:corrigendumId")
                .append(" order by tblcorrigendumdetail.tblProcess.processId,tblcorrigendumdetail.actionType");

        return commonDAO.executeSelect(query.toString(), var);
    }

    public boolean isFieldValueChangedCorrigendumDetail(int corrigendumId,String fieldName){
    	
    	boolean response = false;
    	StringBuilder query = new StringBuilder();
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("corrigendumId", corrigendumId);
        var.put("fieldName", fieldName);
        
        query.append("select tblcorrigendumdetail.objectId,tblcorrigendumdetail.fieldName,tblcorrigendumdetail.oldValue,tblcorrigendumdetail.newValue");
        query.append(" from TblCorrigendumDetail tblcorrigendumdetail ");
        query.append(" where tblcorrigendumdetail.tblCorrigendum.corrigendumId=:corrigendumId AND tblcorrigendumdetail.fieldName=:fieldName ");
        List<Object[]> list =  commonDAO.executeSelect(query.toString(), var);
        if(list.size() > 0){
        	String oldValue = list.get(0)[2].toString();
        	String newValue = list.get(0)[3].toString();
        	if(!oldValue.equals(newValue)){
        		response = true;
        	}
        }
        return response;
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
     * @param queries
     * @param tblCorrigendum
     * @param params
     * @return int
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public int executeCorrigendumDtlsQueries(List<String> queries, Map<String,Map<String,Object>> queryFields,TblCorrigendum tblCorrigendum, String keyWordTxt,Map<String,Object> paramValue, int... params) throws Exception {
        int cnt = 0;
        /** start publish committee **/
        /** end publish committee **/
        boolean isOpeningDate = false;
        if (queries != null && !queries.isEmpty()) {
            for (String query : queries) {
            	if(query.contains("update TblTender set"))
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
            	}
            	else
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
        if(isOpeningDate){
        	Map<String,Object> col = new HashMap<String, Object>();
        	col.put("tenderId", params[1]);
        	commonDAO.executeSqlUpdate("update Tbl_TenderEnvelope set openingDate=(select openingDate from tbl_tender where tenderId=:tenderId) where tenderId=:tenderId and openingDate <> '' and openingDate is not null ", col);
        }
       return cnt;
    }

    /**
     * @param tenderId
     * @return
     */
    public int deletePendingCurrencyByTenderId(int tenderId) {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        var.put("pending", 0);
        int cnt = commonDAO.executeUpdate("delete from TblTenderCurrency where isActive=:pending and tenderId=:tenderId", var);

        return cnt;
    }
  
    /**
     * @param userId
     * @param corrigendumId
     * @param formId
     * @throws Exception
     */
    public void cancelFormCorrigendumById(int userDetailId, int corrigendumId, int formId) throws Exception {
        if (corrigendumId != 0) {
            TblProcess tblProcess = new TblProcess(4);
            TblCorrigendum tblCorrigendum = new TblCorrigendum(corrigendumId);
            TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();
            tblCorrigendumDetail.setActionType(3);
            tblCorrigendumDetail.setCreatedBy(userDetailId);
            tblCorrigendumDetail.setFieldLabel("");
            tblCorrigendumDetail.setFieldName("");
            tblCorrigendumDetail.setOldValue("");
            tblCorrigendumDetail.setNewValue("");
            tblCorrigendumDetail.setObjectId(formId);
            tblCorrigendumDetail.setTblProcess(tblProcess);
            tblCorrigendumDetail.setTblCorrigendum(tblCorrigendum);
            commonDAO.save(tblCorrigendumDetail);
        }
    }

    /**
     * @param formId
     * @return
     * @throws Exception
     */
    public String getFormNameById(int formId) throws Exception {
        List<TblTenderForm> list = null;
        list = commonDAO.findEntity(TblTenderForm.class, "formId", Operation_enum.EQ, formId);
        return (list != null && !list.isEmpty()) ? list.get(0).getFormName() : null;
    }
    /**
     * 
     * @param envelopeId
     * @return
     * @throws Exception 
     */
    public String getEnvelopeNameById(int envelopeId) throws Exception {
        List<TblTenderEnvelope> list = null;
        list = commonDAO.findEntity(TblTenderEnvelope.class,"envelopeId", Operation_enum.EQ, envelopeId);
        return (list != null && !list.isEmpty()) ? list.get(0).getEnvelopeName() : null;
    }

    /**
     * @param tenderId
     * @return
     * @throws Exception
     */
    public int getApproveCorrigendumLegnthByTenderId(int tenderId) throws Exception {
        int result = 0;
        List<TblCorrigendum> list = null;
        list = commonDAO.findEntity(TblCorrigendum.class,OBJECTID, Operation_enum.EQ, tenderId, "cstatus", Operation_enum.EQ, 1);
        if (list != null) {
            result = list.size();
        }
        return result;
    }

    /**
     * @param tenderId
     * @return
     * @throws Exception
     */
    public int isIAgreeByTenderId(int tenderId) throws Exception {
        int result = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        List<Object> list = commonDAO.executeSelect("select bidConfirmationId from TblTenderBidConfirmation where tenderId=:tenderId", var);
        if (list != null) {
            result = list.size();
        }
        return result;
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
        tenderCurrencyVar.put("objectId", objectId);
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
        
        //Envelope
       // addCorrigendumEnvelop(objectId, envType, oldEnvList, userDetailId, formType, bidOpeningDate);/* CR #28151 - Need to restrict configuration of new envelopes through corrigendum*/
        
    }
    
    /**
     * @param currencyNewList
     * @param objectId
     * @param corrigendumId
     * @param userDetailId
     * @throws Exception 
     */
   public void addTendeCurrencyOnCorrigendum(List<String> currencyNewList,int objectId,int corrigendumId,int userDetailId){
	   
	   TblTenderCurrency tblTenderCurrency = null;
       TblCorrigendumDetail tblCorrigendumDetail = null;
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
              tblCorrigendumDetail.setFieldName("");
              tblCorrigendumDetail.setFieldLabel("");
              tblCorrigendumDetail.setOldValue("");
              tblCorrigendumDetail.setNewValue("");
              tblCorrigendumDetail.setActionType(1);// For new insert
              tblCorrigendumDetail.setCreatedBy(userDetailId);
              tblCorrigendumDetailList.add(tblCorrigendumDetail);
         }
         	commonDAO.saveOrUpdateAll(tblCorrigendumDetailList);
   }
    
    
    
    /**
     * 
     * @param tenderId
     * @param envType
     * @param oldEnvId
     * @param userDetailId
     * @param formType
     * @param openingDate
     * @throws Exception 
     */
    public void addCorrigendumEnvelop(int tenderId, int envType, List<Integer> oldEnvId, int userDetailId, String[] formType, String openingDate) throws Exception {
        TblTender tblTender = new TblTender(tenderId);
        int corrigendumId = getPendingCorrigendumId(tenderId);
        int counter = 0;
        if (removePendingEnvelopForCorrigendum(tenderId, corrigendumId, formType)) {
            if (formType != null) {
                for (int i = 0; i < formType.length; i++) {
                    if (!oldEnvId.contains(Integer.valueOf(formType[i]))) {
                        TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();
                        tblTenderEnvelope.setEnvelopeName(tenderCommonService.getEnvelopeNameById(Integer.valueOf(formType[i])));
                        tblTenderEnvelope.setTblTender(tblTender);
                        TblEnvelope tblEnvelope = new TblEnvelope();
                        tblEnvelope.setEnvId(Integer.valueOf(formType[i]));
                        if (envType == 1) {
                            tblTenderEnvelope.setOpeningDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm, openingDate));
                        }
                        tblTenderEnvelope.setNoOfFormsReq(0);
                        tblTenderEnvelope.setMinOpeningMember(0);
                        tblTenderEnvelope.setMinEvaluator(0);
                        tblTenderEnvelope.setIsOpened(0);
                        tblTenderEnvelope.setIsEvaluated(0);
                        tblTenderEnvelope.setCreatedBy(userDetailId);
                        tblTenderEnvelope.setCstatus(4);
                        tblTenderEnvelope.setTblEnvelope(tblEnvelope);
                        tblTenderEnvelope.setRemark("");
                        commonDAO.saveOrUpdate(tblTenderEnvelope);

                        TblProcess tblProcess = new TblProcess(3);
                        TblCorrigendum tblCorrigendum = new TblCorrigendum(corrigendumId);
                        TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();
                        tblCorrigendumDetail.setActionType(1);
                        tblCorrigendumDetail.setCreatedBy(userDetailId);
                        tblCorrigendumDetail.setFieldLabel("");
                        tblCorrigendumDetail.setFieldName("");
                        tblCorrigendumDetail.setOldValue("");
                        tblCorrigendumDetail.setNewValue("");
                        tblCorrigendumDetail.setObjectId(tblTenderEnvelope.getEnvelopeId());
                        tblCorrigendumDetail.setTblProcess(tblProcess);
                        tblCorrigendumDetail.setTblCorrigendum(tblCorrigendum);
                        commonDAO.saveOrUpdate(tblCorrigendumDetail);
                        counter++;
                    }
                }
                if (counter > 0) {
                    List<Integer> lstEnvelopeId = new ArrayList<Integer>();
                    lstEnvelopeId = eventCreationService.getEnvelopeIdList(tenderId);
                    for (int j = 0; j < lstEnvelopeId.size(); j++) {
                        eventCreationService.updateEnvelopeSortOrder(lstEnvelopeId.get(j), tblTender.getTenderId(), j + 1);
                    }
                }
            }
        }
    }
    /**
     * 
     * @param tenderId
     * @param corrigendumId
     * @param formType
     * @return 
     */
    public boolean removePendingEnvelopForCorrigendum(int tenderId, int corrigendumId, String[] formType) {
        StringBuilder strCorrigendumQuery = new StringBuilder();
        StringBuilder strQuery = new StringBuilder();
        List<Integer> envIds = new ArrayList<Integer>();
        if (formType != null) {
            for (int i = 0; i < formType.length; i++) {
                envIds.add(Integer.valueOf(formType[i]));
            }
        }

        Map<String, Object> parameters = new HashMap<String, Object>();

        parameters.put("tenderId", tenderId);
        parameters.put("cstatus", 4);
        if (envIds.size() > 0) {
            parameters.put("envIds", envIds);
        }
        strQuery.append("Delete from TblTenderEnvelope where tblTender.tenderId=:tenderId and cstatus = :cstatus");
        if (envIds.size() > 0) {
            strQuery.append(" and envId NOT IN (:envIds)");
        }
        hibernateQueryDao.updateDeleteNewQuery(strQuery.toString(), parameters);
        List<Integer> tenderIds = new ArrayList<Integer>();
        if (envIds.size() > 0) {
            Map<String, Object> var = new HashMap<String, Object>();
            var.put("tenderId", tenderId);
            var.put("envIds", envIds);
            List<Object> list = hibernateQueryDao.getSingleColQuery("select envelopeId from TblTenderEnvelope where tenderId=:tenderId and envId IN (:envIds)", var);

            if (list != null) {
                for (int i = 0; i < list.size(); i++) {
                    tenderIds.add(Integer.valueOf(list.get(i).toString()));
                }
            }
        }

        Map<String, Object> corrigendumParameters = new HashMap<String, Object>();

        corrigendumParameters.put("corrigendumId", corrigendumId);
        corrigendumParameters.put("processId", 3);
        if (tenderIds.size() > 0) {
            corrigendumParameters.put("tenderIds", tenderIds);
        }
        strCorrigendumQuery.append("Delete from TblCorrigendumDetail  where tblCorrigendum.corrigendumId=:corrigendumId and processId = :processId");
        if (tenderIds.size() > 0) {
            strCorrigendumQuery.append(" and objectId NOT IN (:tenderIds)");
        }
        hibernateQueryDao.updateDeleteNewQuery(strCorrigendumQuery.toString(), corrigendumParameters);
        return true;
    }
    /**
     * 
     * @param tenderId
     * @return 
     */
    public List<Object[]> getCorrigendumFormType(int tenderId) {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        String query = "select tblenvelope.envId,tblenvelope.lang1,tbltenderenvelope.envelopeId from TblEnvelope tblenvelope left join tblenvelope.tblTenderEnvelope tbltenderenvelope where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.cstatus in (0,1)";
        return hibernateQueryDao.createNewQuery(query, var);
    }
    /**
     * 
     * @param tenderId
     * @return 
     */
    public List<Object[]> getPendingCorrigendumFormType(int tenderId) {

        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        String query = "select tblenvelope.envId,tblenvelope.lang1,tbltenderenvelope.envelopeId from TblEnvelope tblenvelope left join tblenvelope.tblTenderEnvelope tbltenderenvelope where tbltenderenvelope.tblTender.tenderId=:tenderId and tbltenderenvelope.cstatus =4";
        return hibernateQueryDao.createNewQuery(query, var);
    }
    /**
     * 
     * @param tenderId 
     */
    public void deletePendingEnvelopByTenderId(int tenderId) {
        StringBuilder strQuery = new StringBuilder();
        Map<String, Object> parameters = new HashMap<String, Object>();

        parameters.put("tenderId", tenderId);
        parameters.put("cstatus", 4);
        List<Object> corrEnvlopeIds = hibernateQueryDao.singleColQuery("SELECT envelopeId FROM TblTenderEnvelope tblTenderEnvelope WHERE tblTenderEnvelope.tblTender.tenderId=:tenderId and cstatus=:cstatus", parameters);
        if(corrEnvlopeIds!=null && !corrEnvlopeIds.isEmpty()){
	        parameters = new HashMap<String, Object>();
	        parameters.put("envelopeId", corrEnvlopeIds);
	        strQuery.append(" DELETE FROM TblCommitteeEnvelope WHERE tblTenderEnvelope.envelopeId IN (:envelopeId)");
	        hibernateQueryDao.updateDeleteNewQuery(strQuery.toString(), parameters);
	        
	        strQuery.delete(0, strQuery.length());
	        strQuery.append(" DELETE FROM TblCommitteeUser WHERE childId IN (:envelopeId)");
	        hibernateQueryDao.updateDeleteNewQuery(strQuery.toString(), parameters);
        }
        
        strQuery.delete(0, strQuery.length());
        strQuery.append(" SELECT tblTenderForm.formId FROM TblRebateForm tblRebateForm");
        strQuery.append(" INNER JOIN tblRebateForm.tblTenderForm tblTenderForm");
        strQuery.append(" WHERE tblTenderForm.tblTender.tenderId=:tenderId AND tblTenderForm.cstatus=:cstatus");
        parameters = new HashMap<String, Object>();
        parameters.put("cstatus", 0);
        parameters.put("tenderId", tenderId);
        List<Object> rebateFormIds = hibernateQueryDao.singleColQuery(strQuery.toString(),parameters);
        if(rebateFormIds!=null && !rebateFormIds.isEmpty()){
	        parameters = new HashMap<String, Object>();
	        parameters.put("formId", rebateFormIds);
	        strQuery.delete(0, strQuery.length());
	        strQuery.append(" DELETE FROM TblRebateForm WHERE tblTenderForm.formId IN (:formId)");
	        hibernateQueryDao.updateDeleteNewQuery(strQuery.toString(), parameters);
        }
        strQuery.delete(0, strQuery.length());
        parameters = new HashMap<String, Object>();
        parameters.put("tenderId", tenderId);
        parameters.put("cstatus", 4);
        strQuery.append("Delete from TblTenderEnvelope where tblTender.tenderId=:tenderId and cstatus = :cstatus)");
        hibernateQueryDao.updateDeleteNewQuery(strQuery.toString(), parameters);
    }
    /**
     * 
     * @param corrigendumId 
     */
    public void deletePendingCorrigendumDocumentByTenderId(int corrigendumId) {
        StringBuilder docMappingQuery = new StringBuilder();
        StringBuilder docQuery = new StringBuilder();
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("corrigendumId", corrigendumId);
        parameters.put("linkId", corrigendumUpload);
        List<Object> officerDocMappingList = hibernateQueryDao.singleColQuery("select tblOfficerDocument.officerDocId from TblOfficerDocMapping where objectId=:corrigendumId and linkId=:linkId", parameters);
        docMappingQuery.append("Delete from TblOfficerDocMapping where objectId=:corrigendumId and linkId=:linkId)");
        hibernateQueryDao.updateDeleteNewQuery(docMappingQuery.toString(), parameters);
        for (int i = 0; i < officerDocMappingList.size(); i++) {
            Map<String, Object> officerDoc = new HashMap<String, Object>();
            officerDoc.put("officerDocId", officerDocMappingList.get(i));
            docQuery.append("Delete from TblOfficerDocument where officerDocId=:officerDocId");
            hibernateQueryDao.updateDeleteNewQuery(docQuery.toString(), officerDoc);
        }
    }
    /**
     * 
     * @param tenderId
     * @return 
     */
    public boolean deletePendingCorrigendum(int tenderId,int corrigendumId) {
        boolean flag = false;
        //int corrigendumId = getPendingCorrigendumId(tenderId);
        if (corrigendumId > 0) {
            Map<String, Object> var = new HashMap<String, Object>();
            var.put("corrigendumId", corrigendumId);
            String strCorrigendumDetailQuery = "delete from  TblCorrigendumDetail  where tblCorrigendum.corrigendumId=:corrigendumId";
            String strCorrigendumQuery = "delete from  TblCorrigendum  where corrigendumId=:corrigendumId";
            commonDAO.executeUpdate(strCorrigendumDetailQuery, var);
            commonDAO.executeUpdate(strCorrigendumQuery, var);
            deletePendingCurrencyByTenderId(tenderId);
            //deletePendingEnvelopByTenderId(tenderId); // we don't require it.
            //deletePendingCorrigendumDocumentByTenderId(corrigendumId); // we don't require it.
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
    public void insertCorrigendumNewForm(int formId, int userDetailId, int tenderId,int isBiddingFormPublishWithTender) {
        TblProcess tblProcess = new TblProcess(4);
        int corrigendumId = getPendingCorrigendumId(tenderId);
        if (corrigendumId > 0) {
            TblCorrigendum tblCorrigendum = new TblCorrigendum(corrigendumId);

            TblCorrigendumDetail tblCorrigendumDetail = new TblCorrigendumDetail();

            tblCorrigendumDetail.setActionType(1);
            tblCorrigendumDetail.setCreatedBy(userDetailId);
            tblCorrigendumDetail.setFieldLabel("");
            tblCorrigendumDetail.setFieldName("");
            tblCorrigendumDetail.setOldValue("");
            tblCorrigendumDetail.setNewValue("");
            tblCorrigendumDetail.setObjectId(formId);

            tblCorrigendumDetail.setTblProcess(tblProcess);
            tblCorrigendumDetail.setTblCorrigendum(tblCorrigendum);
            commonDAO.save(tblCorrigendumDetail);
        }
    }

    /**
     *
     * @param query
     * @param clientId
     * @return
     */
    public List<Object[]> generateListFmQuery(String query, int clientId) {
        query = query.replaceAll("\\+@LangId", "1");
        Map<String, Object> var = null;
        if (query.contains("@ClientId")) {
            var = new HashMap<String, Object>();
            var.put("clientId", clientId);
            query = query.replaceAll("@ClientId", ":clientId");
        }
        return hibernateQueryDao.createNewQuery(query, var);
    }

    /**
     * @param corrigendumId
     * @return String
     */
    public String getCorrigendumDtlKeywordTxt(int corrigendumId) {
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("corrigendumId", corrigendumId);
        String keyWordTxt = null;
        List<Object> lst = commonDAO.executeSelect("select newValue from TblCorrigendumDetail where tblCorrigendum.corrigendumId=:corrigendumId and fieldName='keywordText'", var);
        if (!lst.isEmpty()) {
            keyWordTxt = (String) lst.get(0);
        }
        return keyWordTxt;
    }

    public boolean isCorrigendumPublished(int tenderId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        count = hibernateQueryDao.countForNewQuery("TblCorrigendum tblcorrigendum ", "tblcorrigendum.corrigendumId ", "tblcorrigendum.objectId=:tenderId and  tblcorrigendum.cstatus=1", var);
        return count != 0;
    }
    /** This method is to check the corrigendum pending.

     * @param tenderId
     * @return
     * @throws Exception 
     */
    public boolean isCorrigendumPending(int tenderId) throws Exception {
        long count = 0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId", tenderId);
        count = hibernateQueryDao.countForNewQuery("TblCorrigendum tblcorrigendum ", "tblcorrigendum.corrigendumId ", "tblcorrigendum.objectId=:tenderId and  tblcorrigendum.cstatus=0", var);
        return count != 0;
    }

    public boolean isCanelCurrency(int currId, int tenderId) throws Exception {
        long count = 0;
        int tenderCurrencyId = 0;
        Map<String, Object> currencyVar = new HashMap<String, Object>();
        currencyVar.put("tenderId", tenderId);
        currencyVar.put("currencyId", currId);
        List<Object> lst = hibernateQueryDao.getSingleColQuery("select tenderCurrencyId from TblTenderCurrency where tenderId=:tenderId and currencyId=:currencyId and isActive=1 and isDefault=1", currencyVar);
        if (!lst.isEmpty()) {
            tenderCurrencyId = (Integer) lst.get(0);
        }
        if (tenderCurrencyId != 0) {
            Map<String, Object> var = new HashMap<String, Object>();
            var.put("tenderCurrencyId", tenderCurrencyId);
            count = hibernateQueryDao.countForNewQuery("TblCorrigendumDetail tblcorrigendumdetail ", "tblcorrigendumdetail.corrigendumDetailId ", "tblcorrigendumdetail.objectId=:tenderCurrencyId and tblcorrigendumdetail.actionType=3", var);
        }
        return count != 0;
    }
    
    /**
     * 
     * @param corrigendumId
     * @param formId
     */
    public void deleteFormEntryFromCorrigendum(int corrigendumId, int formId) {
		Map<String, Object> corrigendumParameters = new HashMap<String, Object>();
		corrigendumParameters.put("corrigendumId", corrigendumId);
		corrigendumParameters.put("formId", formId);
		hibernateQueryDao.updateDeleteNewQuery("delete from TblCorrigendumDetail tblCorrigendumDetail where tblCorrigendumDetail.tblCorrigendum.corrigendumId=:corrigendumId and objectId=:formId", corrigendumParameters);
	}
    /**This method is used for the update minMandForms with the original mandatory forms is organize form not configured.
     * @param tenderId
     * @param corrigendumId
     * @throws Exception 
     */
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
    public void updateMinMandatoryFormsIfnotOrganize(int tenderId,int corrigendumId) throws Exception{
       long flagCount=0;
       List<Object[]> list = null;
       Map<String, Object> var = new HashMap<String, Object>();
       //check if organize form configured.
       var = new HashMap<String, Object>();
       var.put("corrigendumId",corrigendumId);
       var.put("processId",3); //TblTenderEnvelope
       var.put("actionType",2); // update.
       flagCount=hibernateQueryDao.countForNewQuery("TblCorrigendumDetail tblcorrigendumdetail ", "tblcorrigendumdetail.corrigendumDetailId ", "tblcorrigendumdetail.tblCorrigendum.corrigendumId=:corrigendumId and tblcorrigendumdetail.tblProcess.processId=:processId and tblcorrigendumdetail.actionType=:actionType", var);
       if(flagCount==0){
            var = new HashMap<String, Object>();
            var.put("tenderId",tenderId);
            StringBuilder query = new StringBuilder();
            query.append("select COUNT(tbltenderform.formId),tbltenderform.tblTenderEnvelope.envelopeId from ");
            query.append(" TblTenderForm tbltenderform  where tbltenderform.isMandatory=1 and tbltenderform.tblTender.tenderId=:tenderId and tbltenderform.cstatus=1 ");
            query.append(" group by tbltenderform.tblTenderEnvelope.envelopeId");
            list = hibernateQueryDao.createNewQuery(query.toString(), var);
            if(list!=null && !list.isEmpty()){
                for (Object[] objects : list) {
                      var = new HashMap<String, Object>();
                      var.put("envelopeId",objects[1]);
                      var.put("minFormsReqForBidding",objects[0]);
                      hibernateQueryDao.updateDeleteNewQuery("update TblTenderEnvelope set minFormsReqForBidding=:minFormsReqForBidding where envelopeId=:envelopeId", var);
                }
            }
       }  
    }
    /** This method is used to get all mandatory forms by envelopeId

     * @param envelopeId
     * @param isMandatory
     * @return
     * @throws Exception 
     */
     public long getAllFormsMandatoryCountByEnvelopeId(int envelopeId,int isMandatory) throws Exception{    
    	long mandatoryCount=0;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("envelopeId",envelopeId);
        var.put("cstatus",1);
        if(isMandatory!=0){
            var.put("isMandatory",isMandatory);
        }
        mandatoryCount = hibernateQueryDao.countForNewQuery("TblTenderForm tblTenderForm", "tblTenderForm.formId", "tblTenderForm.tblTenderEnvelope.envelopeId=:envelopeId and tblTenderForm.cstatus=:cstatus"+(isMandatory!=0 ? " and tblTenderForm.isMandatory=:isMandatory" : ""), var);
        return mandatoryCount;
    }
     /** This method is to get corrigendumDetails by the tenderId.
 
      * @param tenderId
      * @return
      * @throws Exception 
      */
      public List<Object[]> getCorrigendumDetailsByTenderId(int tenderId) throws Exception{ 
    	List<Object> list = null;
        List<Object[]> list1 = null;
        Map<String, Object> var = new HashMap<String, Object>();
        var.put("tenderId",tenderId);
        StringBuilder query = new StringBuilder();
        query.append("select tblcorrigendum.corrigendumId from TblCorrigendum tblcorrigendum where tblcorrigendum.objectId=:tenderId and tblcorrigendum.cstatus=0");
        list = hibernateQueryDao.getSingleColQuery(query.toString(), var);
        if(list!=null && list.size()>0)
        {
            Object temp=list.get(0);
            var = new HashMap<String, Object>();
            var.put("objectId",tenderId);
            var.put("corrigendumId",Integer.parseInt(temp.toString()));
            query = new StringBuilder();
            query.append("select tblcorrigendumdetail.corrigendumDetailId,tblcorrigendumdetail.objectId,tblcorrigendumdetail.tblProcess.processId,tblcorrigendumdetail.actionType,");//3
            query.append("(select tbltenderform.tblTenderEnvelope.envelopeId from TblTenderForm tbltenderform where tbltenderform.formId=tblcorrigendumdetail.objectId)");//4
            query.append(" from TblCorrigendum tblcorrigendum ");
            query.append(" inner join  tblcorrigendum.tblCorrigendumDetail tblcorrigendumdetail ");
            query.append(" with tblcorrigendumdetail.tblProcess.processId=4 and tblcorrigendumdetail.actionType in (1,3) ");
            query.append(" where tblcorrigendum.objectId=:objectId and tblcorrigendumdetail.tblCorrigendum.corrigendumId=:corrigendumId");
            list1 = hibernateQueryDao.createNewQuery(query.toString(), var);
        }
        return list1;
    }
	
    /**
     * @param date
     * @return
     */
    private String convertDateToStringForCPPP(Date date)
    {
  	String reportDate=""; 
  	if(date!=null){
      	Format df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
      	reportDate = df.format(date);
      	reportDate = "'"+reportDate+"'";
  	}else{reportDate="null";}
  	return reportDate;	
    }
    
    /**
     * @param date
     * @return
   * @throws ParseException 
     */
    private String convertDateFormateToIstForCPPP(String date) throws ParseException
    {
  	  String reportedDate="";
  	  if(!date.equalsIgnoreCase("null")){
  		  date = date.replace("'", "").trim();
  		  DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  		  Date newDate = sdf.parse(date);
  		  sdf.setTimeZone(TimeZone.getTimeZone("GMT+5:30"));
      	  reportedDate="'"+sdf.format(newDate)+"'";
  	  }else{
  		  reportedDate="null";
  	  }
  	return reportedDate;	
    }
    
    private String replaceSpecialCharAndHtmlTags(String repHtmlSpeChar)
    {
    	org.jsoup.nodes.Document doc = Jsoup.parse(repHtmlSpeChar); 
    	String replaced =  doc.text().replaceAll("[^a-zA-Z0-9%&?=\\[\\]/():;,._\\s@#-]", " ");
    	return replaced;
    }
    /* used to get count whether bidding form change in corrigendum
     * @return
     * @throws Exception 
     */
    public boolean getPendingCorrigendumDetails(int tenderId,List<Integer> processId) throws Exception{ 
    	 List<Object[]> list = null;
    	 StringBuilder query = new StringBuilder();
    	 Map<String, Object> var = new HashMap<String, Object>();
    	 var = new HashMap<String, Object>();
         var.put("objectId",tenderId);
         var.put("processId",processId);
         query = new StringBuilder();
         query.append("SELECT tblcorrigendumdetail.corrigendumDetailId,tblcorrigendumdetail.objectId,tblcorrigendumdetail.tblProcess.processId,tblcorrigendumdetail.actionType");
         query.append(" FROM TblCorrigendum tblcorrigendum ");
         query.append(" INNER JOIN  tblcorrigendum.tblCorrigendumDetail tblcorrigendumdetail ");
         query.append(" WITH tblcorrigendumdetail.tblProcess.processId IN (:processId)");
         query.append(" WHERE tblcorrigendum.objectId=:objectId AND tblcorrigendum.cstatus=0");
         list = hibernateQueryDao.createNewQuery(query.toString(), var);
         return list!=null && !list.isEmpty() ? true : false;
    }
}
