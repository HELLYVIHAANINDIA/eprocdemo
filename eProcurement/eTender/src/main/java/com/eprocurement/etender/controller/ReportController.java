/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.eprocurement.etender.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.BidderBidBean;
import com.eprocurement.etender.databean.BiddingFormBean;
import com.eprocurement.etender.databean.BiddingFormCellBean;
import com.eprocurement.etender.databean.BiddingFormColumnBean;
import com.eprocurement.etender.databean.BiddingFormTableBean;
import com.eprocurement.etender.model.TblBidderdocument;
import com.eprocurement.etender.model.TblPurchaseorder;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderCellGrandTotal;
import com.eprocurement.etender.model.TblTenderEnvelope;
import com.eprocurement.etender.services.CommitteeService;
import com.eprocurement.etender.services.EProcureCreationService;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.QuotationService;
import com.eprocurement.etender.services.ReportService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;


@Controller
@RequestMapping("/etender")
public class ReportController {
    @Autowired
    private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private TenderService tenderService;
    @Autowired
    private FormService formService; 
    @Autowired
    private ReportService reportService;
    @Autowired
    private EProcureCreationService eventCreationService;
    @Autowired
    CommitteeService committeeService;
    @Autowired
    QuotationService quotationService;
    
    
    private static final String RESULTSET_1= "#result-set-1";
    private static final String RESULTSET_2= "#result-set-2";
    private static final String RESULTSET_3= "#result-set-3";
    private static final String RESULTSET_4= "#result-set-4";
    private static final String RESULTSET_5= "#result-set-5";
    private static final String RESULTSET_6= "#result-set-6";
    private static final String RESULTSET_7= "#result-set-7";
    private static final String RESULTSET_8= "#result-set-8";
    private static final String RESULTSET_12= "#result-set-12";
    private static final String RESULTSET_14="#result-set-14";
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/notloggedin";    
    private static final String TENDERID = "tenderId";
    
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
    
    
    @RequestMapping(value = {"/buyer/submitFormBidWeight/{tenderId}/{formId}"}, method = RequestMethod.POST)
    public ModelAndView submitFormBidWeight(@PathVariable(TENDERID) int tenderId,@PathVariable("formId") int formId,HttpServletRequest request,HttpSession session,RedirectAttributes redirectAttributes) {
        String page= REDIRECT_SESSION_EXPIRED;
        ModelAndView model = new ModelAndView(page);
        if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
        	String[] bidderId = request.getParameterValues("bidderId");
        	String[] weightVal = request.getParameterValues("weightVal");
        	if(bidderId != null && weightVal != null){
        		reportService.updateBidWeightage(bidderId,weightVal,tenderId,formId);
        		page = "redirect:/etender/buyer/gettabcontent/"+tenderId+"/2";
        		redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_weight_updated_success");
        		model.setViewName(page);
        	}
        }
        return model;
    }
    @RequestMapping(value = {"/buyer/weightageReportEnv/{tenderId}/{envelopeId}"}, method = RequestMethod.GET)
    public ModelAndView weightageReportEnv(@PathVariable(TENDERID) int tenderId,@PathVariable("envelopeId") int envelopeId,HttpServletRequest request,HttpSession session,RedirectAttributes redirectAttributes) {
        String page= REDIRECT_SESSION_EXPIRED;
        ModelAndView model = new ModelAndView(page);
        if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
        		try {
					List<Object[]> result = reportService.getTenderBidFormWithFormDetail(tenderId, envelopeId,0,"0");
					model.addObject("tblTender", tenderCommonService.getTenderById(tenderId));
					//model.addObject("lstCompanyFrmDtl", result);
					Map<String,List<Object[]>> bidderResultMap = new HashMap<String,List<Object[]>>();
					Map<String,List<String>> formNameMap = new HashMap<String, List<String>>();
					for(Object[] obj : result){
						String formId = obj[3].toString();
						if(bidderResultMap.containsKey(formId)){
							bidderResultMap.get(formId).add(obj);
						}else{
							List<Object[]> list = new ArrayList<Object[]>();
							list.add(obj);
							bidderResultMap.put(formId,list);
						}
						List<String> list = new ArrayList<String>();
						list.add(obj[8].toString());
						list.add(obj[9].toString());
						formNameMap.put(formId, list);
					}
					Map<Integer,Boolean> isBidderRejected  = committeeService.getRejectedBidderAppDtls(tenderId);
					model.addObject("isBidderRejected",isBidderRejected);
					model.addObject("formNameMap", formNameMap);
					model.addObject("bidderResultMap", bidderResultMap);
					model.addObject("tblTender", tenderCommonService.getTenderById(tenderId));
					TblTenderEnvelope tblTenderEnvelope = tenderService.getTblTenderEnvelope(tenderId,envelopeId);
					model.addObject("envelopeName", tenderCommonService.getEnvelopeNameById(tblTenderEnvelope.getTblEnvelope().getEnvId()));
	        		page = "/etender/common/WeightageReport";
	        		model.setViewName(page);
        		} catch (Exception e) {
					exceptionHandlerService.writeLog(e);
				}
        	}
        return model;
    }
    
    @RequestMapping(value = {"/buyer/tenderindividualreport/{tenderId}/{envelopeId}/{formId}/{operation}/{commiteeType}","/bidder/tenderindividualreport/{tenderId}/{envelopeId}/{formId}/{operation}/{commiteeType}"}, method = RequestMethod.GET)
    public String showTenderOpeningIndividualReport(@PathVariable(TENDERID) int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("formId") int formId,@PathVariable("operation") int operation, @PathVariable("commiteeType") int commiteeType, ModelMap modelMap, HttpServletRequest request,HttpSession session) {
        String page= REDIRECT_SESSION_EXPIRED;
        try {
            if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
            	SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                modelMap.addAttribute("userTypeId",sBean.getUserTypeId());
                tenderCommonService.tenderSummary(tenderId, modelMap);
                Map<String,List<Object[]>> outMap= reportService.getIndividualReportDetail(tenderId,envelopeId,formId);
                modelMap.addAttribute("operation",operation);
                if(request.getParameter("hdisPrintPriview")!=null){
                    modelMap.addAttribute("isPrintPriview",request.getParameter("hdisPrintPriview"));
                }
                TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
                modelMap.addAttribute("tblTender",tblTender);
                if(outMap != null && !outMap.isEmpty())
                {
                    if(outMap.get(RESULTSET_1) !=null) // Tender Form
                    {
                    	List<BiddingFormBean> lstFormDtl = new ArrayList<BiddingFormBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_1);
                    	
                    	 List<TblBidderdocument> lstTenderBidderDocs = tenderCommonService.getTblBidderdocument(tenderId,10);//need to create tables for document
                     	if (!lstTenderBidderDocs.isEmpty()) {
                             modelMap.addAttribute("isDocUploaded", false);
                             modelMap.addAttribute("lstTenderBidderDocs", lstTenderBidderDocs);
                         }
                     	
                    	for(Object[] obj : list){
                    		BiddingFormBean biddingFormBean = new BiddingFormBean();
                    		biddingFormBean.setFormId(Integer.parseInt(obj[0].toString()));
                    		biddingFormBean.setFormName(obj[1].toString());
                    		biddingFormBean.setFormHeader(obj[2].toString());
                    		biddingFormBean.setFormFooter(obj[3].toString());
                    		biddingFormBean.setNoOfTables(Integer.parseInt(obj[4].toString()));
                    		biddingFormBean.setIsMultipleFilling(Integer.parseInt(obj[5].toString()));
                    		biddingFormBean.setIsDocumentReq(Integer.parseInt(obj[6].toString()));
                    		biddingFormBean.setIsEncryptedDocument(Integer.parseInt(obj[7].toString()));
                    		biddingFormBean.setIsSecondary(Integer.parseInt(obj[8].toString()));
                    		biddingFormBean.setIsPriceBid(Integer.parseInt(obj[9].toString()));
                    		biddingFormBean.setSortOrder(Integer.parseInt(obj[10].toString()));
                    		biddingFormBean.setShowDocuments(Integer.parseInt(obj[11].toString()));
                    		biddingFormBean.setFormWeight(Double.parseDouble((obj[12] == null || obj[12].toString().equals("")) ? "0.0" : obj[12].toString()));
                    		lstFormDtl.add(biddingFormBean);
                    	}
                        modelMap.addAttribute("lstFormDtl",lstFormDtl);
                    }
                    if(outMap.get(RESULTSET_2) !=null) // Tender Table
                    {
                    	List<BiddingFormTableBean> lstFormTableDtl = new ArrayList<BiddingFormTableBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_2);
                    	for(Object[] obj : list){
                    		BiddingFormTableBean biddingFormTableBean = new BiddingFormTableBean();
                    		biddingFormTableBean.setFormId(Integer.parseInt(obj[0].toString()));
                    		biddingFormTableBean.setTableId(Integer.parseInt(obj[1].toString()));
                    		biddingFormTableBean.setTableName(obj[2].toString());
                    		biddingFormTableBean.setTableHeader(obj[3].toString());
                    		biddingFormTableBean.setTableFooter(obj[4].toString());
                    		biddingFormTableBean.setNoOfRows(Integer.parseInt(obj[5].toString()));
                    		biddingFormTableBean.setNoOfCols(Integer.parseInt(obj[6].toString()));
                    		biddingFormTableBean.setIsMultipleFilling(Integer.parseInt(obj[7].toString()));
                    		biddingFormTableBean.setHasGTRow(Integer.parseInt(obj[8].toString()));
                    		biddingFormTableBean.setSortOrder(Integer.parseInt(obj[9].toString()));
                    		lstFormTableDtl.add(biddingFormTableBean);
                    	}
                        modelMap.addAttribute("lstTableDtl",lstFormTableDtl);
                    }
                    if(outMap.get(RESULTSET_3) !=null) // Tender Column
                    {
                    	
                    	List<BiddingFormColumnBean> lstColumnDtl = new ArrayList<BiddingFormColumnBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_3);
                    	for(Object[] obj : list){
                    		BiddingFormColumnBean biddingFormColumnBean = new BiddingFormColumnBean();
                    		biddingFormColumnBean.setColumnId(Integer.parseInt(obj[0].toString()));
                    		biddingFormColumnBean.setTableid(Integer.parseInt(obj[1].toString()));
                    		biddingFormColumnBean.setColumnNo(Integer.parseInt(obj[2].toString()));
                    		biddingFormColumnBean.setColumntypeid(Integer.parseInt(obj[3].toString()));
                    		biddingFormColumnBean.setColumnHeader(obj[4].toString());
                    		biddingFormColumnBean.setFilledBy(Integer.parseInt(obj[5].toString()));
                    		biddingFormColumnBean.setIsShown(Integer.parseInt(obj[6].toString()));
                    		biddingFormColumnBean.setIsCurrConvReq(Integer.parseInt(obj[7].toString()));
                    		biddingFormColumnBean.setFormula(obj[8]!= null ? obj[8].toString() : "");
                    		biddingFormColumnBean.setFormSortOrder(Integer.parseInt(obj[9].toString()));
                    		biddingFormColumnBean.setSortOrder(Integer.parseInt(obj[10].toString()));
                    		biddingFormColumnBean.setColumnOrder(Integer.parseInt(obj[11].toString()));
                    		biddingFormColumnBean.setIsGTColumn(Integer.parseInt(obj[12].toString()));
                    		int isPricesummary = obj[13] != null && !obj[13].toString().isEmpty() ? Integer.parseInt(obj[13].toString()) : 0 ;
                    		biddingFormColumnBean.setIsPriceSummary(isPricesummary);
                    		lstColumnDtl.add(biddingFormColumnBean);
                    	}
                        modelMap.addAttribute("lstColumnDtl",lstColumnDtl);
                    }
                    if(outMap.get(RESULTSET_4) !=null) // Tender cell - Filled by Officer
                    {
                    	List<BiddingFormCellBean> lstCellDtl = new ArrayList<BiddingFormCellBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_4);
                    	for(Object[] obj : list){
                    		BiddingFormCellBean biddingFormCellBean = new BiddingFormCellBean();
                    		biddingFormCellBean.setCellId(Integer.parseInt(obj[0].toString()));
                    		biddingFormCellBean.setFormId(Integer.parseInt(obj[1].toString()));
                    		biddingFormCellBean.setTableId(Integer.parseInt(obj[2].toString()));
                    		biddingFormCellBean.setColumnId(Integer.parseInt(obj[3].toString()));
                    		biddingFormCellBean.setRowId(Integer.parseInt(obj[4].toString()));
                    		biddingFormCellBean.setCellValue(obj[5].toString());
                    		biddingFormCellBean.setCellNo(Integer.parseInt(obj[6].toString()));
                    		biddingFormCellBean.setDataType(Integer.parseInt(obj[7].toString()));
                    		biddingFormCellBean.setFormSortOrder(Integer.parseInt(obj[8].toString()));
                    		biddingFormCellBean.setFilledBy(Integer.parseInt(obj[9].toString()));
                    		biddingFormCellBean.setColumnSortOrder(Integer.parseInt(obj[10].toString()));
                    		lstCellDtl.add(biddingFormCellBean);
                    	}
                        modelMap.addAttribute("lstCellDtl",lstCellDtl);
                    }
                    if(outMap.get(RESULTSET_5) !=null) // Tender bidder 
                    {
                        modelMap.addAttribute("lstCompanyDtl",(List<Object[]>) outMap.get(RESULTSET_5) );
                    }
                    if(outMap.get(RESULTSET_6) !=null) // Tender bid 
                    {
                    	List<BidderBidBean> lstBidDtl = new ArrayList<BidderBidBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_6);
                    	for(Object[] obj : list){
                    		BidderBidBean bidderBidBean = new BidderBidBean();
                    		bidderBidBean.setBidId(Integer.parseInt(obj[0].toString()));
                    		bidderBidBean.setBidderId(Integer.parseInt(obj[1].toString()));
                    		bidderBidBean.setBidTableId(Integer.parseInt(obj[2].toString()));
                    		bidderBidBean.setFormId(Integer.parseInt(obj[3].toString()));
                    		bidderBidBean.setTableId(Integer.parseInt(obj[4].toString()));
                    		bidderBidBean.setRowId(Integer.parseInt(obj[5].toString()));
                    		bidderBidBean.setColumnId(Integer.parseInt(obj[6].toString()));
                    		bidderBidBean.setDataType(Integer.parseInt(obj[7].toString()));
                    		bidderBidBean.setCellId(Integer.parseInt(obj[8].toString()));
                    		bidderBidBean.setCellNo(Integer.parseInt(obj[9].toString()));
                    		bidderBidBean.setFilledby(Integer.parseInt(obj[11].toString()));
                                
//                                if(bidderBidBean.getFilledby()==2 || bidderBidBean.getFilledby()==3)
//                                {
//                                    bidderBidBean.setCellValue(encryptDecryptUtils.decrypt((String)obj[10],tblTender.getRandPass().substring(0, 16).getBytes()));
//                                }
//                                else
//                                { 
                                    bidderBidBean.setCellValue(obj[10].toString());
                               // }
                    		lstBidDtl.add(bidderBidBean);
                    	}
                        modelMap.addAttribute("lstBidDtl",lstBidDtl);
                        
                    }
                    if(outMap.get(RESULTSET_7) !=null) // Tender Form bidded multiple time 
                    {
                        modelMap.addAttribute("lstFormBid",(List<Object[]>) outMap.get(RESULTSET_7) );
                    }
                    
                    if(outMap.get(RESULTSET_8) !=null) // Tender Table bidded multiple time by add row
                    {
                        modelMap.addAttribute("lstTableBid",(List<Object[]>) outMap.get(RESULTSET_8) );
                    }   
                    
                    if(outMap.get(RESULTSET_12) !=null) // Tender Proxy column Details
                    {
                        modelMap.addAttribute("lstTenderProxyDtl",(List<Object[]>) outMap.get(RESULTSET_12) );
                    }
                    if(outMap.get(RESULTSET_14)!=null){
                        modelMap.addAttribute("lstBidderCurrency", (List<Object[]>) outMap.get(RESULTSET_14) );
                    }
                    List<Object[]> bidderList =  outMap.get(RESULTSET_5);
                    List<TblTenderCellGrandTotal> tblTenderCellGrandTotal = null ;
                    List<Integer> bidderIds = new ArrayList<Integer>();
                    if(bidderList!=null && !bidderList.isEmpty()){
	                    for(Object[] objList : bidderList){
	                    	bidderIds.add(Integer.parseInt(objList[1].toString()));
	                    }
                    }
                    if(bidderIds!=null && !bidderIds.isEmpty()){
                    	tblTenderCellGrandTotal = formService.getTblTenderCellGrandTotal(tenderId,bidderIds.toArray(),formId,false);
                    }
                    modelMap.addAttribute("TenderCellGrandTotalList",tblTenderCellGrandTotal);
                }
                page = "/etender/common/TenderOpeningIndividualReport";
                if(operation == 5){
					Map<Integer,Boolean> isBidderRejected  = committeeService.getRejectedBidderAppDtls(tenderId);
					modelMap.addAttribute("isBidderRejected",isBidderRejected);
                }
            }
            else
            {
                page =  REDIRECT_SESSION_EXPIRED;
            }
            if(operation == 5){
            	page = "/etender/common/addFormWeightageScore"; // for weightage evaluation.
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return page;
    }
    
    
    @RequestMapping(value = {"/buyer/tendercomparativereport/{tenderId}/{envelopeId}/{formId}/{operation}/{commiteeType}","/bidder/tendercomparativereport/{tenderId}/{envelopeId}/{formId}/{operation}/{commiteeType}"}, method = RequestMethod.GET)
    public String showTenderOpeningComparativeReport(@PathVariable(TENDERID) int tenderId,@PathVariable("envelopeId") int envelopeId,@PathVariable("formId") int formId, @PathVariable("operation") int operation, @PathVariable("commiteeType") int commiteeType, ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    	String page= REDIRECT_SESSION_EXPIRED;
        try {
        	if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
        		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                modelMap.addAttribute("userTypeId",sBean.getUserTypeId());
                tenderCommonService.tenderSummary(tenderId, modelMap);

                Map<String,List<Object[]>> outMap= reportService.getComparativeReportDetail(tenderId,envelopeId,formId);
                modelMap.addAttribute("operation",operation);
                if(request.getParameter("hdisPrintPriview")!=null)
                {
                    modelMap.addAttribute("isPrintPriview",request.getParameter("hdisPrintPriview"));
                }
                TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
                modelMap.addAttribute("tblTender",tblTender);
                
                if(outMap != null && !outMap.isEmpty()){
                    if(outMap.get(RESULTSET_1) !=null) {// Tender Form
                    	List<BiddingFormBean> lstFormDtl = new ArrayList<BiddingFormBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_1);
                    	for(Object[] obj : list){
                    		BiddingFormBean biddingFormBean = new BiddingFormBean();
                    		biddingFormBean.setFormId(Integer.parseInt(obj[0].toString()));
                    		biddingFormBean.setFormName(obj[1].toString());
                    		biddingFormBean.setFormHeader(obj[2].toString());
                    		biddingFormBean.setFormFooter(obj[3].toString());
                    		biddingFormBean.setNoOfTables(Integer.parseInt(obj[4].toString()));
                    		biddingFormBean.setIsMultipleFilling(Integer.parseInt(obj[5].toString()));
                    		biddingFormBean.setIsDocumentReq(Integer.parseInt(obj[6].toString()));
                    		biddingFormBean.setIsEncryptedDocument(Integer.parseInt(obj[7].toString()));
                    		biddingFormBean.setIsSecondary(Integer.parseInt(obj[8].toString()));
                    		biddingFormBean.setIsPriceBid(Integer.parseInt(obj[9].toString()));
                    		biddingFormBean.setSortOrder(Integer.parseInt(obj[10].toString()));
                    		biddingFormBean.setShowDocuments(Integer.parseInt(obj[11].toString()));
                    		lstFormDtl.add(biddingFormBean);
                    	}
                        modelMap.addAttribute("lstFormDtl",lstFormDtl);
                    
                    }
                    if(outMap.get(RESULTSET_2) !=null) // Tender Table
                    {
                    	List<BiddingFormTableBean> lstFormTableDtl = new ArrayList<BiddingFormTableBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_2);
                    	for(Object[] obj : list){
                    		BiddingFormTableBean biddingFormTableBean = new BiddingFormTableBean();
                    		biddingFormTableBean.setFormId(Integer.parseInt(obj[0].toString()));
                    		biddingFormTableBean.setTableId(Integer.parseInt(obj[1].toString()));
                    		biddingFormTableBean.setTableName(obj[2].toString());
                    		biddingFormTableBean.setTableHeader(obj[3].toString());
                    		biddingFormTableBean.setTableFooter(obj[4].toString());
                    		biddingFormTableBean.setNoOfRows(Integer.parseInt(obj[5].toString()));
                    		biddingFormTableBean.setNoOfCols(Integer.parseInt(obj[6].toString()));
                    		biddingFormTableBean.setIsMultipleFilling(Integer.parseInt(obj[7].toString()));
                    		biddingFormTableBean.setHasGTRow(Integer.parseInt(obj[8].toString()));
                    		biddingFormTableBean.setSortOrder(Integer.parseInt(obj[9].toString()));
                    		lstFormTableDtl.add(biddingFormTableBean);
                    	}
                        modelMap.addAttribute("lstTableDtl",lstFormTableDtl);
                    }
                    if(outMap.get(RESULTSET_3) !=null) // Tender Column
                    {
                    	List<BiddingFormColumnBean> lstColumnDtl = new ArrayList<BiddingFormColumnBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_3);
                    	for(Object[] obj : list){
                    		BiddingFormColumnBean biddingFormColumnBean = new BiddingFormColumnBean();
                    		biddingFormColumnBean.setColumnId(Integer.parseInt(obj[0].toString()));
                    		biddingFormColumnBean.setTableid(Integer.parseInt(obj[1].toString()));
                    		biddingFormColumnBean.setColumnNo(Integer.parseInt(obj[2].toString()));
                    		biddingFormColumnBean.setColumntypeid(Integer.parseInt(obj[3].toString()));
                    		biddingFormColumnBean.setColumnHeader(obj[4].toString());
                    		biddingFormColumnBean.setFilledBy(Integer.parseInt(obj[5].toString()));
                    		biddingFormColumnBean.setIsShown(Integer.parseInt(obj[6].toString()));
                    		biddingFormColumnBean.setIsCurrConvReq(Integer.parseInt(obj[7].toString()));
                    		biddingFormColumnBean.setFormula(obj[8]!= null ? obj[8].toString() : "");
                    		biddingFormColumnBean.setFormSortOrder(Integer.parseInt(obj[9].toString()));
                    		biddingFormColumnBean.setSortOrder(Integer.parseInt(obj[10].toString()));
                    		biddingFormColumnBean.setColumnOrder(Integer.parseInt(obj[11].toString()));
                    		biddingFormColumnBean.setIsGTColumn(Integer.parseInt(obj[12].toString()));
                    		lstColumnDtl.add(biddingFormColumnBean);
                    	}
                        modelMap.addAttribute("lstColumnDtl",lstColumnDtl);
                    }
                    if(outMap.get(RESULTSET_4) !=null) // Tender cell - Filled by Officer
                    {
                    	List<BiddingFormCellBean> lstCellDtl = new ArrayList<BiddingFormCellBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_4);
                    	for(Object[] obj : list){
                    		BiddingFormCellBean biddingFormCellBean = new BiddingFormCellBean();
                    		biddingFormCellBean.setCellId(Integer.parseInt(obj[0].toString()));
                    		biddingFormCellBean.setFormId(Integer.parseInt(obj[1].toString()));
                    		biddingFormCellBean.setTableId(Integer.parseInt(obj[2].toString()));
                    		biddingFormCellBean.setColumnId(Integer.parseInt(obj[3].toString()));
                    		biddingFormCellBean.setRowId(Integer.parseInt(obj[4].toString()));
                    		biddingFormCellBean.setCellValue(obj[5].toString());
                    		biddingFormCellBean.setCellNo(Integer.parseInt(obj[6].toString()));
                    		biddingFormCellBean.setDataType(Integer.parseInt(obj[7].toString()));
                    		biddingFormCellBean.setFormSortOrder(Integer.parseInt(obj[8].toString()));
                    		biddingFormCellBean.setFilledBy(Integer.parseInt(obj[9].toString()));
                    		biddingFormCellBean.setColumnSortOrder(Integer.parseInt(obj[10].toString()));
                    		lstCellDtl.add(biddingFormCellBean);
                    	}
                        modelMap.addAttribute("lstCellDtl",lstCellDtl);
                    }
                    if(outMap.get(RESULTSET_5) !=null) // Tender bidder 
                    {
                    	modelMap.addAttribute("lstCompanyDtl",(List<Object[]>) outMap.get(RESULTSET_5) );
                    }
                    if(outMap.get(RESULTSET_6) !=null) // Tender bid 
                    {
                    	Map<String,String> mapBidData = new HashMap<String, String>();
                    	List<BidderBidBean> lstBidDtl = new ArrayList<BidderBidBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_6);
                    	for(Object[] obj : list){
                    		BidderBidBean bidderBidBean = new BidderBidBean();
                    		bidderBidBean.setBidId(Integer.parseInt(obj[0].toString()));
                    		bidderBidBean.setBidderId(Integer.parseInt(obj[1].toString()));
                    		bidderBidBean.setBidTableId(Integer.parseInt(obj[2].toString()));
                    		bidderBidBean.setFormId(Integer.parseInt(obj[3].toString()));
                    		bidderBidBean.setTableId(Integer.parseInt(obj[4].toString()));
                    		bidderBidBean.setRowId(Integer.parseInt(obj[5].toString()));
                    		bidderBidBean.setColumnId(Integer.parseInt(obj[6].toString()));
                    		bidderBidBean.setDataType(Integer.parseInt(obj[7].toString()));
                    		bidderBidBean.setCellId(Integer.parseInt(obj[8].toString()));
                    		bidderBidBean.setCellNo(Integer.parseInt(obj[9].toString()));
                                bidderBidBean.setFilledby(Integer.parseInt(obj[11].toString()));
//                    		if(bidderBidBean.getFilledby()==2 || bidderBidBean.getFilledby()==3)
//                                {
//                                    bidderBidBean.setCellValue(encryptDecryptUtils.decrypt((String)obj[10],tblTender.getRandPass().substring(0, 16).getBytes()));
//                                }
//                                else
//                                {
                                    bidderBidBean.setCellValue(obj[10].toString());
                             //   }
//                    		
                    		mapBidData.put(bidderBidBean.getBidderId()+"_"+bidderBidBean.getTableId()+"_"+bidderBidBean.getColumnId()+"_"+bidderBidBean.getRowId(), bidderBidBean.getCellValue());
                    		lstBidDtl.add(bidderBidBean);
                    	}
                        modelMap.addAttribute("lstBidDtl",lstBidDtl);
                        modelMap.addAttribute("mapBidData",mapBidData);
                        
                    }
                    if(outMap.get(RESULTSET_7) !=null) // Tender Form bidded multiple time 
                    {
                    	modelMap.addAttribute("lstFormBid",(List<Object[]>) outMap.get(RESULTSET_7) );
                    
                    if(outMap.get(RESULTSET_8) !=null) // Tender Table bidded multiple time by add row
                    {
                    	 modelMap.addAttribute("lstTableBid",(List<Object[]>) outMap.get(RESULTSET_8) );
                    }   
                    
                    if(outMap.get(RESULTSET_12) !=null) // Tender Proxy column Details
                    {
                    	modelMap.addAttribute("lstTenderProxyDtl",(List<Object[]>) outMap.get(RESULTSET_12) );
                    }
                    if(outMap.get(RESULTSET_14)!=null){
                        modelMap.addAttribute("lstBidderCurrency",(List<Object[]>) outMap.get(RESULTSET_14));
                    }
                    List<Object[]> bidderList =  outMap.get(RESULTSET_5);
                    List<TblTenderCellGrandTotal> tblTenderCellGrandTotal = null ;
                    List<Integer> bidderIds = new ArrayList<Integer>();
                    if(bidderList!=null && !bidderList.isEmpty()){
	                    for(Object[] objList : bidderList){
	                    	bidderIds.add(Integer.parseInt(objList[1].toString()));
	                    }
                    }
                    if(bidderIds!=null && !bidderIds.isEmpty()){
                    	tblTenderCellGrandTotal = formService.getTblTenderCellGrandTotal(tenderId,bidderIds.toArray(),formId,false);
                    }
                    modelMap.addAttribute("TenderCellGrandTotalList",tblTenderCellGrandTotal);
                }
                page = "/etender/common/TenderOpeningComparativeReport";
            }
            else
            {
            	page =  REDIRECT_SESSION_EXPIRED;
            }
        }
    } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
    }
    return page;
    }
    @RequestMapping(value = {"/buyer/generatecustomizedreport"}, method={RequestMethod.POST,RequestMethod.GET})
    public String generateCustomizeReport(ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    	String page= REDIRECT_SESSION_EXPIRED;
    	int tenderId = 0;
    	int formId = 0;
    	int operation = 0;
    	int commiteeType = 0;
        try {
        	tenderId = Integer.parseInt(request.getParameter("hdTenderId"));
        	formId = Integer.parseInt(request.getParameter("hdFormId"));
        	operation = Integer.parseInt(request.getParameter("hdOperation"));
        	commiteeType = Integer.parseInt(request.getParameter("hdCommiteeType"));
        	if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
        		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                modelMap.addAttribute("userTypeId",sBean.getUserTypeId());
                modelMap.addAttribute("flag",2);
                tenderCommonService.tenderSummary(tenderId, modelMap);
                
                List<Object> strBidders = new ArrayList<Object>();
                List<Object> strRows = new ArrayList<Object>();
                List<Object> strColumns = new ArrayList<Object>();
                int rowCnt=0;
                if(request.getParameter("chkbidder") !=null)
                {
                    for(String str:request.getParameterValues("chkbidder"))
                    {
                        strBidders.add(str);
                    }
                }else if (request.getParameter("hdStrBidder")!=null){
                	strBidders.add(request.getParameter("hdStrBidder"));
                }
                modelMap.addAttribute("bidderIds",strBidders.toString());
                
                if(request.getParameter("chkrow") !=null)
                {
                    for(String str:request.getParameterValues("chkrow"))
                    {
                        strRows.add(str);
                        rowCnt++;
                    }
                } else if (request.getParameter("hdStrRow")!=null)
                {
                	strRows.add(request.getParameter("hdStrRow"));
                    rowCnt++;
                }
                modelMap.addAttribute("rowCnt",rowCnt);
                if(request.getParameter("chkcolumn") !=null)
                {
                    for(String str:request.getParameterValues("chkcolumn"))
                    {
                        strColumns.add(str);
                    }
                }else if (request.getParameter("hdStrColumn")!=null){
                    strColumns.add(request.getParameter("hdStrColumn"));
                }
                modelMap.addAttribute("columnIds",strColumns.toString());
                
                Map<String, List<Object[]>>  outMap= reportService.getCustomizeReportConfigDtl(tenderId,formId,strBidders,strColumns,strRows);
                if(outMap != null && !outMap.isEmpty()){
                    if(outMap.get(RESULTSET_1) !=null) // Form detail
                    {
                        modelMap.addAttribute("lstFormDtl", outMap.get(RESULTSET_1) );
                    }
                    if(outMap.get(RESULTSET_2) !=null) // Table detail
                    {
                        modelMap.addAttribute("lstTableDtl", outMap.get(RESULTSET_2) );
                    }
                    if(outMap.get(RESULTSET_3) !=null) // Tender Column Details
                    {
                    	System.out.println(outMap.get(RESULTSET_3).size()+"--------");
                        modelMap.addAttribute("lstColumnDtl", outMap.get(RESULTSET_3) );
                    }
                    if(outMap.get(RESULTSET_4) !=null) // Tender Row Details
                    {
                        modelMap.addAttribute("lstCellDtl", outMap.get(RESULTSET_4) );
                    }
                    if(outMap.get(RESULTSET_5) !=null) // Tender bidder 
                    {
                        modelMap.addAttribute("lstCompanyDtl",(List<Object[]>) outMap.get(RESULTSET_5) );
                    }
                    if(outMap.get(RESULTSET_6) !=null) // Tender bid 
                    {
                    	List<BidderBidBean> lstBidDtl = new ArrayList<BidderBidBean>();
                    	List<Object[]> list = outMap.get(RESULTSET_6);
                    	Map<String,String> mapBidData = new HashMap<String, String>();
                    	for(Object[] obj : list){
                    		BidderBidBean bidderBidBean = new BidderBidBean();
                    		bidderBidBean.setBidId(Integer.parseInt(obj[0].toString()));
                    		bidderBidBean.setBidderId(Integer.parseInt(obj[1].toString()));
                    		bidderBidBean.setBidTableId(Integer.parseInt(obj[2].toString()));
                    		bidderBidBean.setFormId(Integer.parseInt(obj[3].toString()));
                    		bidderBidBean.setTableId(Integer.parseInt(obj[4].toString()));
                    		bidderBidBean.setRowId(Integer.parseInt(obj[5].toString()));
                    		bidderBidBean.setColumnId(Integer.parseInt(obj[6].toString()));
                    		bidderBidBean.setDataType(Integer.parseInt(obj[7].toString()));
                    		bidderBidBean.setCellId(Integer.parseInt(obj[8].toString()));
                    		bidderBidBean.setCellNo(Integer.parseInt(obj[9].toString()));
                    		bidderBidBean.setCellValue(obj[10].toString());
                    		bidderBidBean.setFilledby(Integer.parseInt(obj[11].toString()));
                    		mapBidData.put(bidderBidBean.getBidderId()+"_"+bidderBidBean.getTableId()+"_"+bidderBidBean.getColumnId()+"_"+bidderBidBean.getRowId(), bidderBidBean.getCellValue());
                    		lstBidDtl.add(bidderBidBean);
                    	}
                    	modelMap.addAttribute("lstBidDtl",lstBidDtl);
                        modelMap.addAttribute("mapBidData",mapBidData);
                    }
                    if(outMap.get(RESULTSET_7) !=null) // Tender Form bidded multiple time 
                    {
                        modelMap.addAttribute("lstFormBid",(List<Object[]>) outMap.get(RESULTSET_7) );
                    }
                    
                    if(outMap.get(RESULTSET_8) !=null) // Tender Table bidded multiple time by add row
                    {
                        modelMap.addAttribute("lstTableBid",(List<Object[]>) outMap.get(RESULTSET_8) );
                    }   
                }
        	}
        	modelMap.addAttribute("commiteeType",commiteeType);
        	 page = "/etender/common/TenderCustomizeReport";
       } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return page;
    }
    @RequestMapping(value = {"/buyer/customizedreport/{tenderId}/{formId}/{operation}/{commiteeType}"}, method = RequestMethod.GET)
    public String showTenderCustomizedReport(@PathVariable(TENDERID) int tenderId,@PathVariable("formId") int formId,@PathVariable("operation") int operation, @PathVariable("commiteeType") int commiteeType, ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    	String page= REDIRECT_SESSION_EXPIRED;
        try {
        	if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
        		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                modelMap.addAttribute("userTypeId",sBean.getUserTypeId());
                tenderCommonService.tenderSummary(tenderId, modelMap);
                 modelMap.addAttribute("operation",operation);
                 modelMap.addAttribute("flag",1);
                if(request.getParameter("hdisPrintPriview")!=null)
                {
                    modelMap.addAttribute("isPrintPriview",request.getParameter("hdisPrintPriview"));
                }
                Map<String, List<Object[]>> outMap= reportService.getCustomizeReportConfigDtl(tenderId,formId,null,null,null);
                if(outMap != null && !outMap.isEmpty())
                {
                    if(outMap.get(RESULTSET_1) !=null) // Form detail
                    {
                        modelMap.addAttribute("lstFormDtl", outMap.get(RESULTSET_1) );
                    }
                    if(outMap.get(RESULTSET_2) !=null) // Table detail
                    {
                        modelMap.addAttribute("lstTableDtl", outMap.get(RESULTSET_2) );
                    }
                    if(outMap.get(RESULTSET_3) !=null) // Tender Column Details
                    {
                        modelMap.addAttribute("lstColumnDtl", outMap.get(RESULTSET_3) );
                    }
                    if(outMap.get(RESULTSET_4) !=null) // Tender Row Details
                    {
                        modelMap.addAttribute("lstRowDtl", outMap.get(RESULTSET_4) );
                    }
                    if(outMap.get(RESULTSET_5) !=null) // Bidder Details
                    {
                        modelMap.addAttribute("lstBidderDtl", outMap.get(RESULTSET_5) );
                    }
                }
                page = "/etender/common/TenderCustomizeReport";
            }
            else
            {
                page =  REDIRECT_SESSION_EXPIRED;
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return page;
    }
    @RequestMapping(value = {"/buyer/l1h1report/{tenderId}/{operation}/{commiteeType}/{formId}","/bidder/l1h1report/{tenderId}/{operation}/{commiteeType}/{formId}"}, method = RequestMethod.GET)
    public String showTenderLHReport(@PathVariable(TENDERID) int tenderId,@PathVariable("operation") int operation, @PathVariable("commiteeType") int commiteeType,@PathVariable("formId")int formId, ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    	String page= REDIRECT_SESSION_EXPIRED;
        try {
        	if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
        		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                modelMap.addAttribute("userTypeId",sBean.getUserTypeId());
//                tenderCommonService.tenderSummary(tenderId, modelMap);
                TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
                if(request.getParameter("hdisPrintPriview")!=null)
                {
                    modelMap.addAttribute("isPrintPriview",request.getParameter("hdisPrintPriview"));
                }
                Map<String, List<Object[]>> outMap= reportService.getL1H1ReportDetail(tenderId,tblTender.getBiddingVariant(),tblTender.getIsRebateApplicable(),tblTender.getIsItemwiseWinner(),formId);
                if(outMap != null && !outMap.isEmpty())
                {
                 if(tblTender.getIsItemwiseWinner() == 0){   
                    if(outMap.get(RESULTSET_1) !=null) // Bidder's Grand total Form Wise
                    {
                        modelMap.addAttribute("lstBidderFormDtl",outMap.get(RESULTSET_1) );
                    }
                 }else{//Item Wise
                	 if(outMap.get(RESULTSET_2) !=null) /* Getting TenderTable Details - Item wise*/
                     {
                         modelMap.addAttribute("lstTable",outMap.get(RESULTSET_2) );
                     }
                     if(outMap.get(RESULTSET_3) !=null) /* Get bidder's bid value */
                     {
                         modelMap.addAttribute("lstBidderBidDtl", outMap.get(RESULTSET_3) );
                     }
                     if(outMap.get(RESULTSET_4) !=null) /* Get bidder's value for rank*/
                     {
                         modelMap.addAttribute("lstBidderTotalDtl", outMap.get(RESULTSET_4) );
                     }
                 }
                    
                    modelMap.addAttribute("tblTender",tblTender );
                }
              
                page = "/etender/common/TenderL1H1Report";
            }
            else
            {
                page =  REDIRECT_SESSION_EXPIRED;
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return page;
    }
    
    @RequestMapping(value = {"/buyer/getUserListForDecryptBid/{tenderId}/{envelopeId}/{formId}","/buyer/getUserListForVerifyBid/{tenderId}/{envelopeId}/{formId}"}, method = RequestMethod.GET)
    public ModelAndView showUserListForDecryptBid(@PathVariable(TENDERID) int tenderId, @PathVariable("envelopeId") int envelopeId,@PathVariable("formId") int formId, ModelMap model, HttpSession httpSession,HttpServletRequest req,RedirectAttributes redirectAttributes) throws Exception
    {
    	String retVal=REDIRECT_SESSION_EXPIRED;
    	ModelAndView modelAndView =  new ModelAndView(retVal);
    	String redtMsg = "";
    	boolean bSucess = false;
    	if(req.getRequestURI().contains("getUserListForVerifyBid")){
    		redtMsg = "msg_verify_Bid";
    	}else if(req.getRequestURI().contains("getUserListForDecryptBid")){
    		redtMsg = "msg_decypt_Bid";
    	}
    	bSucess = reportService.vefifyNdecryptBid(tenderId,formId);
    	if(bSucess){
	    	retVal="redirect:/etender/buyer/gettabcontent/"+tenderId+"/1";
	    	redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), redtMsg);
	    	modelAndView = new ModelAndView(retVal);
    	}
        return modelAndView;
    
    }
    
    
    @RequestMapping(value = {"/buyer/tenderaward/{tenderId}/{operation}/{commiteeType}/{formId}","/bidder/tenderaward/{tenderId}/{operation}/{commiteeType}/{formId}"}, method = RequestMethod.GET)
    public String showTenderAward(@PathVariable(TENDERID) int tenderId,@PathVariable("operation") int operation, @PathVariable("commiteeType") int commiteeType,@PathVariable("formId")int formId, ModelMap modelMap, HttpServletRequest request,HttpSession session) {
    	String page= REDIRECT_SESSION_EXPIRED;
        try {
        	if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
        		SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
                modelMap.addAttribute("userTypeId",sBean.getUserTypeId());
//                tenderCommonService.tenderSummary(tenderId, modelMap);
                TblTender tblTender =  tenderCommonService.getTenderById(tenderId);
                if(request.getParameter("hdisPrintPriview")!=null)
                {
                    modelMap.addAttribute("isPrintPriview",request.getParameter("hdisPrintPriview"));
                }
                Map<String, List<Object[]>> outMap= reportService.getL1H1ReportDetail(tenderId,tblTender.getBiddingVariant(),tblTender.getIsRebateApplicable(),tblTender.getIsItemwiseWinner(),formId);
                if(outMap != null && !outMap.isEmpty())
                {
                 if(tblTender.getIsItemwiseWinner() == 0){   
                    if(outMap.get(RESULTSET_1) !=null) // Bidder's Grand total Form Wise
                    {
                        modelMap.addAttribute("lstBidderFormDtl",outMap.get(RESULTSET_1) );
                    }
                 }else{//Item Wise
                	 if(outMap.get(RESULTSET_2) !=null) /* Getting TenderTable Details - Item wise*/
                     {
                         modelMap.addAttribute("lstTable",outMap.get(RESULTSET_2) );
                     }
                     if(outMap.get(RESULTSET_3) !=null) /* Get bidder's bid value */
                     {
                         modelMap.addAttribute("lstBidderBidDtl", outMap.get(RESULTSET_3) );
                     }
                     if(outMap.get(RESULTSET_4) !=null) /* Get bidder's value for rank*/
                     {
                    	 Map<String,Integer> poList = new HashMap<String, Integer>();
                    	 List<TblPurchaseorder> tblPurchaseorders =  quotationService.getPurchaseOrderByTenderId(tenderId);
                    	 for (TblPurchaseorder tblPurchaseorder : tblPurchaseorders) {
                    		 if(tblPurchaseorder.getCstatus()!=2 && tblPurchaseorder.getIsAcknowledge()!=2){
							poList.put(tblPurchaseorder.getTableId()+"_"+tblPurchaseorder.getRowId(), 1);
                    		 }
						}
                         modelMap.addAttribute("lstBidderTotalDtl", outMap.get(RESULTSET_4) );
                         modelMap.addAttribute("poList", poList );
                     }
                 }
                    
                    modelMap.addAttribute("tblTender",tblTender );
                }
              
                page = "/etender/common/TenderAward";
            }
            else
            {
                page =  REDIRECT_SESSION_EXPIRED;
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return page;
    }
    
    @RequestMapping(value = "/Bid/loginReport/{tenderId}", method = RequestMethod.GET)
    public String loginReport(@PathVariable(TENDERID)Integer tenderId,ModelMap modelMap,HttpServletRequest request,HttpSession session)throws Exception {
    	String page= REDIRECT_SESSION_EXPIRED;
    	try {
        	if (session.getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null){
		        SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
		        modelMap.addAttribute("lstLoginReportBean",  formService.getLoginReport(tenderId,(int)sessionBean.getUserId()));
		        modelMap.addAttribute("tblTender", eventCreationService.getTenderMaster(tenderId));
		        modelMap.addAttribute("client_dateformate_hhmm", client_dateformate_hhmm);
		        page = "/eauction/loginReport"; 
        	}
            else {
                page =  REDIRECT_SESSION_EXPIRED;
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        }
        return page;
    }
    
}
