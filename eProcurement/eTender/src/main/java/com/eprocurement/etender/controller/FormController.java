
package com.eprocurement.etender.controller;

import static com.eprocurement.etender.services.FormService.checkRequestNull;
import static com.eprocurement.etender.services.FormService.convertInt;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonProcessingException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.daogeneric.Operation_enum;
import com.eprocurement.common.services.CommonDAO;
import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.EncrptDecryptUtils;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.databean.BiddingFormBean;
import com.eprocurement.etender.databean.BiddingFormColumnBean;
import com.eprocurement.etender.databean.BiddingFormTableBean;
import com.eprocurement.etender.databean.TenderDtBean;
import com.eprocurement.etender.enumeration.DataTypeEnum;
import com.eprocurement.etender.enumeration.UserEnum;
import com.eprocurement.etender.model.TblAuctionExtension;
import com.eprocurement.etender.model.TblAuctionStopResume;
import com.eprocurement.etender.model.TblBidDetail;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblCompany;
import com.eprocurement.etender.model.TblCurrency;
import com.eprocurement.etender.model.TblDepartment;
import com.eprocurement.etender.model.TblEnvelope;
import com.eprocurement.etender.model.TblItemSelection;
import com.eprocurement.etender.model.TblRebateDetail;
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
import com.eprocurement.etender.model.TblTenderGovColumn;
import com.eprocurement.etender.model.TblTenderRebate;
import com.eprocurement.etender.model.TblTenderTable;
import com.eprocurement.etender.services.BidderSubmissionService;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.OfficerService;
import com.eprocurement.etender.services.ReportService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;
import com.google.gson.Gson;
import java.math.RoundingMode;


@Controller
@RequestMapping("/eBid")
public class FormController {
    
    @Autowired
	FormService biddingFormService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private TenderService tenderFormService;
    @Autowired
    private BidderSubmissionService eventBidSubmissionService;
    @Autowired
    private ReportService tenderOpenService;
    @Autowired
    OfficerService userService;
    @Autowired
    ExceptionHandlerService exceptionHandlerService;
    @Autowired
    CommonDAO commonDAO;
    
    @Autowired
    EncrptDecryptUtils encrptDecryptUtils;
    String formulaCreated="0";
    String formulaDeleted="0";
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
    @Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
    @Value("#{etenderProperties['client_dateformate_hhmmss']}")
    private String client_dateformate_hhmmss;
    private static final String REDIRECT_SESSION_EXPIRED = "redirect:/notloggedin";
    private final static String XFORWARDEDFOR = "X-FORWARDED-FOR";
    private int decimalPoint = 5;
    /**
     * Redirect control to dynamic bidding form creation
     *
     * This method runs in linear time.
     *
     * @throws UnsupportedOperationException.
     * @return ModelAndView
     */
    @RequestMapping(value = "/Bid/createForm/{tenderId}", method = RequestMethod.GET)
    public ModelAndView createForm(@PathVariable("tenderId")String tenderId,HttpServletRequest request) throws Exception {
        
        String retVal = "redirect:/sessionexpired";
        ModelAndView modelAndView = null;
        try 
        {
            retVal = "/etender/Bid/BiddingForm";
            modelAndView = new ModelAndView(retVal);
            List<TblTenderEnvelope> lstEnvelope=biddingFormService.EnvelopeFromTenderId(tenderId);
            TblTender tblTender=new TblTender();
            tblTender=biddingFormService.BiddingTypeFromTender(Integer.parseInt(tenderId));
            modelAndView.addObject("tenderEnvelope",lstEnvelope);
            modelAndView.addObject("tenderId",tenderId);
            modelAndView.addObject("biddingType", tblTender.getBiddingType());
            modelAndView.addObject("isAuction",tblTender.getisAuction());
        } catch (Exception e) 
        {
            e.printStackTrace();
        }
        return modelAndView;

    }
    
     /**
     * insert table form,table columns and  tender rows  on submit and
     * redirect on view page
     *
     * 
     * @return String
     */
    @RequestMapping(value = "/Bid/saveForm", method = { RequestMethod.POST,RequestMethod.GET})
    public String addTender(@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response) throws Exception{  
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        int  tenderId=convertInt(checkRequestNull(request, "tenderId"));
        BiddingFormBean biddingFormBean=biddingFormService.setBiddingFormParameters(request);
       TblTenderForm tblTenderForm=biddingFormService.setBiddingFormParameterToTable(biddingFormBean);
       boolean status=biddingFormService.addBiddingFormDetails(tblTenderForm);
       
        BiddingFormColumnBean biddingFormColumnBean=new BiddingFormColumnBean();
        TblTenderColumn tblTenderColumn;
        TblTenderTable tblTenderTable;
        BiddingFormTableBean t;
        List <TblTenderTable> lstTblTenderTable=new ArrayList<TblTenderTable>();
        List <TblTenderColumn> lstTblTenderColumn=new ArrayList<TblTenderColumn>();
     
        HashMap hs=biddingFormService.setBiddingFormTableParameters(request);
        
        Set s=hs.entrySet();
        Iterator itrH=s.iterator();
         
        while(itrH.hasNext())
        {
            Map.Entry m= (Map.Entry) itrH.next();
            t=(BiddingFormTableBean)m.getKey();
            tblTenderTable=biddingFormService.setBiddingFormTableParameterToTable(t);
            tblTenderTable.setFormId(tblTenderForm.getFormId());
            
            lstTblTenderTable.add(tblTenderTable);
            List l1=(ArrayList)m.getValue();
            for(int i=0;i<l1.size();i++)
            {
                 BiddingFormColumnBean b1=(BiddingFormColumnBean)l1.get(i);
                 tblTenderColumn=biddingFormService.setBiddingFormColumnParameterToTable(b1);
                 tblTenderColumn.setTblTenderForm(tblTenderForm);
                 tblTenderColumn.setTblTenderTable(tblTenderTable);                
                 lstTblTenderColumn.add(tblTenderColumn);
            }
        }

        status=biddingFormService.addBiddingFormTableDetails(lstTblTenderTable);
        biddingFormService.updateTableCount(lstTblTenderTable);
        status=biddingFormService.addBiddingFormColumnDetails(lstTblTenderColumn);
        ////String redirect ="redirect:/eBid/Bid/TenderListing";
        //redirect = "etender/buyer/tenderDashboard/5";
	//		int tenderId=5;				
     //  StringBuil der retValue = new StringBuilder();
      // retValue.append("etender/buyer/tenderDashboard/").append(tenderId); 
      //  String retVal = "/etender/buyer/tenderListing";
       

	String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
    
		retVal="redirect:/eBid/Bid/FillBiddingForm/"+tenderId+"/"+tblTenderForm.getFormId();
        return retVal;
   
       // return retVal;
 
       //  return redirect;
        
    }

     /**
     * Display dynamic created Tender bidding form
     * redirect on view page
     *
     * @throws Exception
     * @return ModelAndView
     */
    
    @RequestMapping(value="/Bid/convertBidderBid/{tenderId}",method={RequestMethod.POST,RequestMethod.GET})
    public String ConvertBidderBid(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes)throws Exception
    {
       String retVal="";
        List<TblBidDetail> lstBidDetail=new ArrayList<TblBidDetail>();
        lstBidDetail=biddingFormService.getBidForConversion(tenderId);
        List<TblTenderBidDetail> lstTblTenderBidDetail=biddingFormService.getTenderBidDetailForBidConverstion(tenderId);
        TblTender tblTender=tenderCommonService.getTenderById(tenderId);
        List<Object[]> lst=tenderOpenService.getTenderCurrencyExchageRate(tenderId,null);
        List<TblTenderCellGrandTotal> lstTblTenderCellGrandTotal=new ArrayList<TblTenderCellGrandTotal>();
        lstTblTenderCellGrandTotal=biddingFormService.getGtCellValueForBidConversion(tenderId);
        
        List<TblTenderRebate> tblTenderRebateList = null;
        if(tblTender.getIsRebateApplicable() == 1){
      
        	tblTenderRebateList = tenderFormService.getTblTenderRebate(tenderId); 
        }
        BigDecimal bidVal = BigDecimal.ZERO;
        for(int j=0;j<lst.size();j++){
                for(int i=0;i<lstBidDetail.size();i++)
                {
                    TblBidDetail tblBidDetail=new TblBidDetail();
                    tblBidDetail=lstBidDetail.get(i);
                    TblCompany tblCompany=tblBidDetail.getTblCompany();
                    TblTenderColumn tblTenderColumn=tblBidDetail.getTblTenderColumn();
                    if((tblTenderColumn.getFilledBy()==3) || (tblTenderColumn.getIsCurrConvReq()==1 && tblTenderColumn.getFilledBy()==2))
                    {
                        if(tblCompany.getCompanyid().equals((Integer)lst.get(j)[2])){
                            float cellval=Float.parseFloat(tblBidDetail.getCellValue());
                            BigDecimal exchange=(BigDecimal)lst.get(j)[1];
                            bidVal=exchange.multiply(new BigDecimal(cellval)) ;
                            double roundOff= Math.round(bidVal.doubleValue() * 100.0)/100.0;
                            tblBidDetail.setCellValue(roundOff+"");
                            biddingFormService.updateBidConversion(tblBidDetail);
                        }
                    } 

                }
                for(int i=0;i<lstTblTenderBidDetail.size();i++){
                    TblTenderBidDetail tblTenderBidDetail=new TblTenderBidDetail();
                    tblTenderBidDetail=lstTblTenderBidDetail.get(i);
                    TblTenderCell tblTenderCell=new TblTenderCell();
                    tblTenderCell=tblTenderBidDetail.getTblTendercell();
                    TblTenderColumn tblTenderColumn=new TblTenderColumn();
                    tblTenderColumn=tblTenderCell.getTblTenderColumn();
                    TblTenderBidMatrix tblTenderBidMatrix=tblTenderBidDetail.getTblTenderbidmatrix();
                    TblTenderBid tblTenderBid=tblTenderBidMatrix.getTblTenderbid();
                    
                    if((tblTenderColumn.getFilledBy()==3)||(tblTenderColumn.getFilledBy()==2 && tblTenderColumn.getIsCurrConvReq()==1)){
                        if(tblTenderBid.getBidderid().equals((Integer)lst.get(j)[2])){
                            float cellVal=Float.parseFloat(tblTenderBidDetail.getCellvalue());
                            BigDecimal exchange=(BigDecimal)lst.get(j)[1];
                            bidVal=exchange.multiply(new BigDecimal(cellVal));
                            double roundOff= Math.round(bidVal.doubleValue() * 100.0)/100.0;
                            tblTenderBidDetail.setCellvalue(roundOff+"");
                            biddingFormService.updateTblTenderBidDetailForBidConversion(tblTenderBidDetail);
                        }
                    
                    }
                }
                
                for(int i=0;i<lstTblTenderCellGrandTotal.size();i++){
                    TblTenderCellGrandTotal tblTenderCellGrandTotal=new TblTenderCellGrandTotal();
                    tblTenderCellGrandTotal=lstTblTenderCellGrandTotal.get(i);
                    TblBidder tblBidder=tblTenderCellGrandTotal.getTblBidder();
                    if(tblBidder.getBidderId().equals((Integer)lst.get(j)[2])){
                        float cellVal=Float.parseFloat(tblTenderCellGrandTotal.getGTValue());
                        BigDecimal exchange=(BigDecimal)lst.get(j)[1];
                        bidVal=exchange.multiply(new BigDecimal(cellVal));
                        double roundOff= Math.round(bidVal.doubleValue() * 100.0)/100.0;
                        tblTenderCellGrandTotal.setGTValue(roundOff+"");
                        biddingFormService.updateTblTenderCellGrandTotalForBidConversion(tblTenderCellGrandTotal);
                    }
                }
                //rebate
                if(tblTenderRebateList!=null && !tblTenderRebateList.isEmpty()){
                    for(int i=0;i<tblTenderRebateList.size();i++){
                	TblTenderRebate tblTenderRebate=new TblTenderRebate();
                	tblTenderRebate = tblTenderRebateList.get(i);
                    TblBidder tblBidder= biddingFormService.getTblBidderCompanyId(tblTenderRebate.getTblCompany().getCompanyid());
                    if(tblBidder.getBidderId().equals((Integer)lst.get(j)[2])){
                        float cellVal=Float.parseFloat(tblTenderRebate.getRebateValue());
                        BigDecimal exchange=(BigDecimal)lst.get(j)[1];
                        bidVal=exchange.multiply(new BigDecimal(cellVal)).setScale(decimalPoint, BigDecimal.ROUND_CEILING) ;
                        double roundOff= Math.round(bidVal.doubleValue() * 100.0)/100.0;
                        tblTenderRebate.setRebateValue(roundOff+"");
                        biddingFormService.updateTblTenderRebateForBidConversion(tblTenderRebate);
                    }
                }
                }
         }
        biddingFormService.updateTblTenderForBidConversion(tenderId);
        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Bid Converted SuccessFully");
        retVal = "redirect:/etender/buyer/tenderDashboard/" + tenderId;
        return retVal;
    }
    
    @RequestMapping(value = "/Bid/FillBiddingForm/{tenderId}/{formId}", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView FillBiddingForm(@PathVariable("tenderId") Integer tenderId,@PathVariable("formId")String formId,@RequestParam Map<String,String> allRequestParams,HttpServletRequest request
            ,HttpServletResponse response , RedirectAttributes redirectAttributes) throws Exception{  
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
	        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
	        TblTenderForm tblTenderForm =  tenderFormService.getTenderFormById(Integer.parseInt(formId));
	        List<Object[]> lst =biddingFormService.ViewTenderForm(formId);
	        int userId = (int)sBean.getUserId();
	        TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
	        boolean fromBidder = sBean.getUserTypeId() == 1 ? false : true;
	        Map formStructure=biddingFormService.setView(lst,tblBidder!= null ? tblBidder.getTblCompany().getCompanyid() : 0,fromBidder,tblBidder!= null ? tblBidder.getBidderId() : 0);
	       
	        Map formFormulaWithColumn=biddingFormService.getFormulaPerColumn(formId);
	        
	        String res = new Gson().toJson(formStructure);
	        String retVal = "/etender/Bid/CreateBiddingFormStep2";
	      //   String retVal = "/etender/Bid/EditStep2"; //for try only
	        modelAndView = new ModelAndView(retVal);
	        modelAndView.addObject("formStructure",formStructure);
	        modelAndView.addObject("formFormulaWithColumn",formFormulaWithColumn);
	        modelAndView.addObject("getLastFormulaColumn",biddingFormService.getLastFormulaColumn(formFormulaWithColumn));
	        modelAndView.addObject("tenderId",tenderId);
	        modelAndView.addObject("sessionUserTypeId", sBean.getUserTypeId());
                modelAndView.addObject("FormBean",biddingFormService.getDocumentFormDetail(convertInt(formId)));
                modelAndView.addObject("tblTender", biddingFormService.BiddingTypeFromTender(tenderId));
        }
        
        return modelAndView;
    }
    @RequestMapping(value = "/Bid/assignWeightToForm/{tenderId}", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView assignWeightToForm(@PathVariable("tenderId")Integer tenderId,@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response) throws Exception{  
        ModelAndView modelAndView = new ModelAndView("/etender/Bid/assignWeightToForm");
        //Integer[] envType = new Integer[]{3,4,5};
        //Integer[] envType = null;//new Integer[]{3,4,5};
        List<Object[]> lst=biddingFormService.getFormForTender(tenderId);
        modelAndView.addObject("formList",lst);
        TblTender tblTender = tenderCommonService.getTenderById(tenderId);
        modelAndView.addObject("tblTender",tblTender);
        return modelAndView;
    }
    @RequestMapping(value = "/Bid/saveFormWeight/{tenderId}", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView saveFormWeight(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request, RedirectAttributes redirectAttributes) throws Exception{  
    	String retVal = "redirect:/etender/buyer/tenderDashboard/" + tenderId;
    	ModelAndView modelAndView = new ModelAndView(retVal);
    	String[] formIds = request.getParameterValues("formId");
    	String[] txtWeightage = request.getParameterValues("txtWeightage");
    	tenderCommonService.updateTblTenderFormWithWeight(formIds,txtWeightage);
    	redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_weitage_added_successfully");
    	return modelAndView;
    }
    
     /**
     * Display dynamic created Tender bidding form
     * redirect on view page
     *
     * @throws Exception
     * @return ModelAndView
     */
    @RequestMapping(value = "/Bid/viewForm/{tenderId}/{formId}/{bidId}/{fromView}", method = { RequestMethod.POST,RequestMethod.GET})
    public String ViewTenderForm(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("bidId")Integer bidId,@PathVariable("fromView")String fromView,@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response,ModelMap modelMap) throws Exception{
    	String viewName = REDIRECT_SESSION_EXPIRED;
        
        if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
                SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
//	        String res = new Gson().toJson(formStructure);
	        List<Object[]> lst = biddingFormService.ViewTenderForm(formId+"");
                
	        int userId = (int)sBean.getUserId();
	        TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
	        boolean fromBidder = sBean.getUserTypeId() == 1 ? false : true;
                modelMap.addAttribute("formStructure",biddingFormService.setView(lst,tblBidder!= null ? tblBidder.getTblCompany().getCompanyid() : 0,fromBidder,tblBidder!= null ? tblBidder.getBidderId() : 0));
                modelMap.addAttribute("FormBean",biddingFormService.getDocumentFormDetail(formId));
                modelMap.addAttribute("sessionUserTypeId", sBean.getUserTypeId());
                Map formFormulaWithColumn=biddingFormService.getFormula(formId);
                modelMap.addAttribute("formFormulaWithColumn",formFormulaWithColumn);
                modelMap.addAttribute("getLastFormulaColumn",biddingFormService.getLastFormulaColumn(formFormulaWithColumn));
                Map formulaMap=biddingFormService.GetFormulaColumns(formId);
                formulaMap.put("FormulaGrid",biddingFormService.GetFormulaGrid(formId));
                modelMap.addAttribute("formulaMap",formulaMap);
                TblTender tblTender=tenderCommonService.getTenderById(tenderId);
                modelMap.addAttribute("isAuction", tblTender.getisAuction());
                modelMap.addAttribute("tblTender",tblTender);
                List<Object[]> lstBidCurrency=biddingFormService.getBidderCurrencyDetailByTenderId(tenderId);
                String BidderCurrency="";
                String ExchangeRate="";
                if(lstBidCurrency != null && !lstBidCurrency.isEmpty())
                {
                    for(int i = 0; i < lstBidCurrency.size() ; i++)
                    {
                        int userId1 = Integer.parseInt(lstBidCurrency.get(i)[3].toString());
                        if((int)sBean.getUserId()== userId1)
                        {

                            BidderCurrency = (String) lstBidCurrency.get(i)[4];
                            ExchangeRate= lstBidCurrency.get(i)[1].toString();
                        }
                    }
                }
                modelMap.addAttribute("BidderCurrency", BidderCurrency);
                modelMap.addAttribute("ExchangeRate", ExchangeRate);
                List<Object[]> lst1=tenderCommonService.getCurrencyByTenderId(tenderId);
                String currncyName="";
                if (lst1 != null && !lst1.isEmpty()) {
                    for (int i = 0; i < lst1.size(); i++) {
                        if (lst1.get(i)[0] != null && lst1.get(i)[0].toString().trim().length() > 0) {
                            if (tblTender.getCurrencyId() == (Integer) lst1.get(i)[0]) {
                                currncyName = (String) lst1.get(i)[3];
                            }
                        }
                    }
                }
                modelMap.addAttribute("currncyName",currncyName);
                if(tblTender.getisAuction()==1)
                {
                    modelMap.addAttribute("auctionStartDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionStartDate()));
                    modelMap.addAttribute("auctionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionEndDate()));
                }
	        if(sBean.getUserTypeId() == 1){
                        viewName = "/etender/Bid/ViewBiddingForm";
	        }else if(sBean.getUserTypeId() == 2){
	        	List<Object[]> currencyList = null;
	        	int companyId = tblBidder.getTblCompany().getCompanyid();
                        String selectedCurrency = "";
                        boolean isRepeated = eventBidSubmissionService.isTenderIdRepeated(tenderId, tblBidder.getBidderId());
                        currencyList = eventBidSubmissionService.getCurrencies(tenderId,companyId,false);
                        if (tblTender.getBiddingType() == 2) {
                            if(isRepeated){
                	    selectedCurrency=eventBidSubmissionService.getCurrencies(tenderId, companyId, true).get(0)[1].toString();    //tenderFormService.getBidderCurrency(tenderId, companyId).get(0)[0].toString();
                            }
		        }else if(tblTender.getBiddingType() == 1) {
                            selectedCurrency = currencyList != null ? currencyList.get(0)[1].toString() : "";
                        }
	        	modelMap.put("listOfCurrency", currencyList);
	        	modelMap.put("isRepeated", isRepeated);
                        modelMap.put("selectedCurrency", selectedCurrency);
	        	modelMap.addAttribute("DataTypeEnum", DataTypeEnum.values());
		        modelMap.addAttribute("UserEnum", UserEnum.values());
                        viewName = "/etender/bidder/ViewBiddingForm";
                }
                String formViewArray[]=new String[fromView.split("_").length];
                formViewArray=fromView.split("_");
                if(formViewArray.length>1)
                {
                    modelMap.addAttribute("isFormLibrary", formViewArray[1]);
                    modelMap.addAttribute("FormLibrarytenderId",formViewArray[2]);
                }
                else
                {
                    modelMap.addAttribute("fromView", new Boolean(formViewArray[0]));
                }    
        }
        return viewName;
    }

     /**
     * Save the data filled by office or bidder. 
     * This call is also performed at the time of updation
     *
     * @throws Exception
     * @return ModelAndView
     */
    @RequestMapping(value = "/Bid/updateBiddingFormValue", method = { RequestMethod.POST,RequestMethod.GET})
    public String SaveBiddingFormValues(@RequestParam Map<String, String> allRequestParams, HttpServletRequest request
            , HttpServletResponse response,ModelMap modelMap, RedirectAttributes redirectAttributes) throws Exception {
    	String retVal = REDIRECT_SESSION_EXPIRED;
        if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
            SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
            int tenderId = request.getParameter("tenderId") != null ? Integer.parseInt(request.getParameter("tenderId")) : 0;
            int sessionUserTypeId = sBean.getUserTypeId();
            modelMap.addAttribute("sessionUserTypeId", sessionUserTypeId);

            // String redirect = "redirect:/eBid/Bid/FormListing";
            StringBuilder retValue = new StringBuilder();

            if (sessionUserTypeId == 1) {
                List<TblTenderCell> lstCell = biddingFormService.setJsonValueForBiddingForm(request);
                biddingFormService.addCell(lstCell);
                retVal = "redirect:/etender/buyer/tenderDashboard/" + tenderId;
                redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Form created successfully.");
            }
        }
        return retVal;
    }
    
    
    @RequestMapping(value = "/Bid/updateBiddingFormValueForEdit", method = {RequestMethod.POST, RequestMethod.GET})
    public String updateBiddingFormValues(@RequestParam Map<String, String> allRequestParams, HttpServletRequest request, HttpServletResponse response, ModelMap modelMap, RedirectAttributes redirectAttributes) throws Exception {
        String retVal = REDIRECT_SESSION_EXPIRED;
        if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
            SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
            int tenderId = request.getParameter("tenderId") != null ? Integer.parseInt(request.getParameter("tenderId")) : 0;
            int userId = (int) sBean.getUserId();
            int sessionUserTypeId = sBean.getUserTypeId();
            modelMap.addAttribute("sessionUserTypeId", sessionUserTypeId);
            TblTender tblTender = tenderCommonService.getTenderById(tenderId);
            int formId = 0;
            formId=request.getParameter("hdnFormId")!=null ? Integer.parseInt(request.getParameter("hdnFormId")) : 0;
            if (sessionUserTypeId == 1) {
                List<TblTenderCell> lstCell = biddingFormService.setJsonValueForEditBiddingForm(request);
                biddingFormService.addCell(lstCell);
                retVal = "redirect:/etender/buyer/tenderDashboard/" + tenderId;
                redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Form Updated successfully.");
            } else if (sessionUserTypeId == 2) {
                Float bidVal = Float.valueOf("0");
                String ValidationMsg=biddingFormService.validationForBidSubmission(tenderId, userId);
                TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
                int companyId = tblBidder.getTblCompany().getCompanyid();
                if (tblTender.getisAuction() == 1) {
                    if(ValidationMsg.equalsIgnoreCase("") || ValidationMsg.contains("Auction has been resumed,"))
                    {
                        String json = checkRequestNull(request, "txtJson");
                        
                        
                        String GTJson = checkRequestNull(request, "hdnGTColumnValue");
                        if (GTJson.contains("{")) {
                            JSONObject jobj = new JSONObject(GTJson);
                            Iterator itr = jobj.keys();
                            while (itr.hasNext()) {
                                JSONObject jsonObj = jobj.getJSONObject(itr.next().toString());
                                bidVal = Float.parseFloat(jsonObj.getString("GTValue"));
                                }
                            }
                            Integer countForExtension = 0;
                            if (tblTender.getallowsAutoExtension() == 1) {
                            if (TimeUnit.MINUTES.toMillis(tblTender.getextendTimeWhen()) >= getExtendTimeWhenBidReceivedinLastMinute(tblTender)) {
                                TblAuctionExtension tblAuctionExtension = new TblAuctionExtension();
                                tblAuctionExtension.setExtensionStartTime(tblTender.getAuctionEndDate());
                                Calendar date = Calendar.getInstance();
                                date.setTime(commonService.getServerDateTime());
                                Calendar dt = Calendar.getInstance();
                                dt.setTime(new Date(date.getTimeInMillis() + (TimeUnit.MINUTES.toMillis(tblTender.getextendTimeBy()))));
                                tblAuctionExtension.setExtensionEndTime(dt.getTime());
                                tblAuctionExtension.settblTender(new TblTender(tenderId));
                                tblTender.setAuctionEndDate(tblAuctionExtension.getExtensionEndTime());
                                if (tblTender.getautoExtensionMode() == 1) {
                                    countForExtension = biddingFormService.getExtensionCountByTenderId(tenderId);
                                    if (countForExtension < tblTender.getNoOfExtension()) {
                                        biddingFormService.InsretAuction(tblTender, new TblTenderEnvelope(), "Edit", new TblTenderCurrency(), new ArrayList<TblTenderCurrency>());
                                        biddingFormService.InsertAuctionExtension(tblAuctionExtension);
                                    }
                                } else {
                                    biddingFormService.InsretAuction(tblTender, new TblTenderEnvelope(), "Edit", new TblTenderCurrency(), new ArrayList<TblTenderCurrency>());
                                    biddingFormService.InsertAuctionExtension(tblAuctionExtension);
                                }
                            }//if Bid Received In When Last Extend Bid When Min
                        }//Auction Allows Auto Extention or not
                    }//Auction Validation
                }//if is auction
                String f = tenderCommonService.isSubmissionDateLapsed(tenderId, tblTender.getisAuction()).get(0).toString();
                if(tblTender.getisAuction()==1)
                {
                    f = "false";
                }
                if ("false".equalsIgnoreCase(f)) {
                    ValidationMsg="";
                    if (tblTender.getisAuction() == 1) {
                        ValidationMsg = biddingFormService.validationForBidSubmission(tenderId,userId);
                    }
                    
                        if (!eventBidSubmissionService.isFinalSubmissionDone(tenderId, companyId)) {
                            int bidId = request.getParameter("hdBidId") != null ? Integer.parseInt(request.getParameter("hdBidId")) : 0;
                            int cstatus = StringUtils.hasLength(request.getParameter("hdFormActionS")) ? Integer.parseInt(request.getParameter("hdFormActionS")) : 0;
                            boolean isSuccess = setBidderBid(userId, tenderId, request, companyId, bidId, cstatus);
                            Integer countForBid = biddingFormService.getBidCountByTenderId(tenderId);
                            if (!isSuccess) {
                                if (cstatus == 1) {
                                    redirectAttributes.addFlashAttribute("successMsg", "redirect_success_bid_drafted");
                                } else if (tblTender.getisAuction() == 1) {
                                    if (ValidationMsg.equalsIgnoreCase("") || ValidationMsg.contains("Auction has been resumed,")) {
                                        if (bidVal != 0)//check if bidder bid value is zero or not
                                        {
                                            if (countForBid == 0)//check if it is first bid or not
                                            {
                                                if (tblTender.getauctionMethod() == 1)//check if it is forward auction
                                                {
                                                    if (bidVal < tblTender.getstartPrice())//check if bid value is less than start price
                                                    {
                                                        redirectAttributes.addFlashAttribute("errorMsg", "redirect_bid_value_greater_than_start_price");
                                                    }
                                                    else 
                                                    {
                                                        float Last = 0;
                                                        if(tblTender.getisAcceptStartPrice()==1)
                                                        {
                                                            Last = tblTender.getstartPrice();
                                                        }
                                                        else
                                                        {
                                                            Last = tblTender.getstartPrice() + tblTender.getincrementDecrementValues();
                                                        }
                                                        while (Last < bidVal) {
                                                            Last = Last + tblTender.getincrementDecrementValues();
                                                        }
                                                       
                                                        if (tblTender.getisReservePriceConfigure() == 1)//check if auction has configure reserve price
                                                        {
                                                            if (bidVal > tblTender.getauctionReservePrice())//check if bid value is greater than reserve price
                                                            {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_error_for_reserve_price_forward");
                                                            } else if (bidVal != Last)//check if bid valid or not
                                                            {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_forward_auction");
                                                            }
                                                        }
                                                        else
                                                        {
                                                            if (bidVal != Last)//check if bid valid or not
                                                            {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_forward_auction");
                                                            }
                                                        }
                                                    }
                                                } 
                                                else if (tblTender.getauctionMethod() == 0)//check if it is reverse auction
                                                {
                                                    if (bidVal > tblTender.getstartPrice())//check if bid value is greater then start price
                                                    {
                                                        redirectAttributes.addFlashAttribute("errorMsg", "redirect_bid_value_lower_than_start_price");
                                                    } 
                                                    else 
                                                    {
                                                        float Last=0;
                                                        if(tblTender.getisAcceptStartPrice()==1)
                                                        {
                                                            Last = tblTender.getstartPrice();
                                                        }
                                                        else
                                                        {
                                                            Last = tblTender.getstartPrice() - tblTender.getincrementDecrementValues();
                                                        }
                                                        while (Last > bidVal) {
                                                            Last = Last - tblTender.getincrementDecrementValues();
                                                        }
                                                        if (tblTender.getisReservePriceConfigure() == 1)//check if auction has configure reserve price
                                                        {
                                                            if (bidVal < tblTender.getauctionReservePrice())//check if bid value is less then reserve price
                                                            {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_error_for_reserve_price_reverse");
                                                            } else if (bidVal != Last)//check bid is invalid for reverse auction
                                                            {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_reverse_auction");
                                                            }
                                                        }
                                                        else
                                                        {
                                                            if (bidVal != Last)//check if it valid for reverse auction
                                                            {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_reverse_auction");
                                                            }
                                                        }
                                                    }
                                                }
                                            } 
                                            else //for second bidder bid
                                            {
                                                Float LastBid = new Float(0);
                                                if (tblTender.getBiddingVariant() == 1)//Standard Auction
                                                {
                                                    LastBid = biddingFormService.getHighestBidByTenderId(tblTender).floatValue();
                                                    if (tblTender.getauctionMethod() == 1)//Forward Auction
                                                    {
                                                        Float Last = new Float(0);
                                                        if(LastBid == 0)
                                                        {
                                                            if(tblTender.getisAcceptStartPrice()==1)
                                                            {
                                                                Last = new Float(tblTender.getstartPrice()) ;
                                                            }
                                                            else
                                                            {
                                                                Last = new Float(tblTender.getstartPrice() + tblTender.getincrementDecrementValues());
                                                            }
                                                        }
                                                        else
                                                        {
                                                            Last = LastBid + tblTender.getincrementDecrementValues();
                                                        }
                                                        
                                                        while (Last < bidVal) {
                                                            Last = Last + tblTender.getincrementDecrementValues();
                                                        }
                                                        if (tblTender.getisReservePriceConfigure() == 1) {
                                                            if (bidVal > tblTender.getauctionReservePrice()) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_error_for_reserve_price_forward");
                                                            } else if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_forward_auction");
                                                            }
                                                        } 
                                                        else 
                                                        {
                                                            if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_forward_auction");
                                                            }
                                                        }
                                                    }
                                                    else if (tblTender.getauctionMethod() == 0)
                                                    {
                                                        Float Last = new Float(0);
                                                        if(LastBid == 0)
                                                        {
                                                            if(tblTender.getisAcceptStartPrice()==1)
                                                            {
                                                                Last = new Float(tblTender.getstartPrice());
                                                            }
                                                            else
                                                            {
                                                                Last = new Float(tblTender.getstartPrice()-tblTender.getincrementDecrementValues());
                                                            }
                                                        }
                                                        else
                                                        {
                                                            Last = LastBid - tblTender.getincrementDecrementValues();
                                                        }
                                                        while (Last > bidVal) {
                                                            Last = Last - tblTender.getincrementDecrementValues();
                                                        }
                                                        if (tblTender.getisReservePriceConfigure() == 1) {
                                                            if (bidVal < tblTender.getauctionReservePrice()) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_error_for_reserve_price_reverse");
                                                            } else if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_reverse_auction");
                                                            } 
                                                        } else
                                                        {
                                                            if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_reverse_auction");
                                                            }
                                                        }
                                                    }
                                                } 
                                                else if (tblTender.getBiddingVariant() == 0)//Rank Auction
                                                {
                                                    LastBid=biddingFormService.getLastBidByBidder(tblTender,userId);
                                                    
                                                    if (tblTender.getauctionMethod() == 1)//Forward Auction
                                                    {
                                                        Float Last = new Float(0);
                                                        if(LastBid == 0)
                                                        {
                                                            if(tblTender.getisAcceptStartPrice()==1)
                                                            {
                                                                Last=(float)tblTender.getstartPrice();
                                                            }
                                                            else
                                                            {
                                                                Last=(float)tblTender.getstartPrice()+tblTender.getincrementDecrementValues();
                                                            }
                                                        }
                                                        else
                                                        {
                                                            Last = LastBid + tblTender.getincrementDecrementValues();
                                                        }
                                                        while (Last < bidVal)
                                                        {
                                                            Last = Last + tblTender.getincrementDecrementValues();
                                                        }
                                                        if (tblTender.getisReservePriceConfigure() == 1) 
                                                        {
                                                            if (bidVal > tblTender.getauctionReservePrice()) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_error_for_reserve_price_forward");
                                                            } else if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_forward_auction");
                                                            }
                                                        } else
                                                        {
                                                            if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_forward_auction");
                                                            } 
                                                        }
                                                    } else if (tblTender.getauctionMethod() == 0) {
                                                        Float Last = new Float(0);
                                                            if(LastBid == 0)
                                                            {
                                                                if(tblTender.getisAcceptStartPrice()==1)
                                                                {
                                                                    Last=(float)tblTender.getstartPrice();
                                                                }
                                                                else
                                                                {
                                                                    Last=(float)tblTender.getstartPrice()-tblTender.getincrementDecrementValues();
                                                                }
                                                                
                                                            }
                                                            else{
                                                                Last = LastBid - tblTender.getincrementDecrementValues();
                                                            }
                                                        
                                                        while (Last > bidVal) {
                                                            Last = Last - tblTender.getincrementDecrementValues();
                                                        }
                                                        if (tblTender.getisReservePriceConfigure() == 1) {
                                                            if (bidVal < tblTender.getauctionReservePrice()) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_error_for_reserve_price_reverse");
                                                            } else if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_reverse_auction");
                                                            } 
                                                        } else
                                                        {
                                                            if (!bidVal.equals(Last)) {
                                                                redirectAttributes.addFlashAttribute("errorMsg", "redirect_invalid_for_reverse_auction");
                                                            } 
                                                        }
                                                    }
                                                }
                                            }
                                        }//bid val 0
                                    else{
                                            redirectAttributes.addFlashAttribute("errorMsg", "redirect_zero_value_not_allowed");
                                        }//bidVal 0 else
                                     }///validationMsg
                                
            /*auction if*/       } else {
                                    if (tblTender.getisAuction() == 0) {
                                        redirectAttributes.addFlashAttribute("successMsg", "redirect_error_bid_submission");
                                    }
                                    else
                                    {
                                        redirectAttributes.addFlashAttribute("successMsg", "redirect_error_auction_bid_submission");
                                    }
                                }
                            } else {
                                if(tblTender.getisAuction()==1)
                                {
                                    redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "redirect_success_bid_submission");
                                }
                                else
                                {
                                    if (bidId == 0) {
                                        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "redirect_success_bid_submission");
                                    }
                                    else
                                    {
                                        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "redirect_success_update_bid_submission");
                                    }        
                                }
                                
                            }
                        } else {
                            redirectAttributes.addFlashAttribute("errorMsg", "msg_final_submission_already_completed");
                        }
                   
                    
                } else {
                    if(tblTender.getisAuction()==0)
                    {
                        redirectAttributes.addFlashAttribute("errorMsg", "msg_submission_date_lapsed");
                    }
                }
                if (tblTender.getisAuction() == 1) {
                    
                        int bid = biddingFormService.getBidIdByTenderandBidderId(tenderId, tblBidder.getBidderId());
                        if (bid == 0) {
                            retVal = "redirect:/eBid/Bid/viewFormForEdit/" + tenderId + "/" + formId;
                        } 
                        else {
                            retVal = "redirect:/eBid/Bid/viewForm/" + tenderId + "/" + formId + "/" + bid + "/false";
                        }
                        modelMap.addAttribute("ValidationMsg", ValidationMsg);
                    
                } else {
                    retVal = "redirect:/etender/bidder/biddingtenderdashboardcontent/" + tenderId + "/" + 5;
                }
            }
        }
        return retVal;
    }
    private boolean setBidderBid(int userId,int tenderId, HttpServletRequest request,int companyId,int bidId,int cstatus) throws Exception{
        
    	String ipAddress = request.getHeader(XFORWARDEDFOR) != null ? request.getHeader(XFORWARDEDFOR) : request.getRemoteAddr();
    	 TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
    	String json = checkRequestNull(request, "txtJson");
    	TblTender tblTender = tenderCommonService.getTenderById(tenderId);
    	boolean success = false;
         TblTenderBidHistory tblTenderBidHistory=new TblTenderBidHistory();
        
         if(json.contains("{")){
    	JSONObject jobj = new JSONObject(json);
    	Iterator itr = jobj.keys() ,itr2;
    	int formId = 0;
    	String tableIdStr = "";
    	List<String> hdTableIds = new ArrayList<String>();
    	JSONObject jsonObjColumn,jsonObj ;
    	Map<String,String> bidStr = new HashMap<String, String>();
    	String k = "";
        Float bidVal=new Float("0");
        Float bidderVal=new Float("0");
        String GTJson=checkRequestNull(request,"hdnGTColumnValue");
        if(GTJson.contains("{"))
        {
            JSONObject GTjobj = new JSONObject(GTJson);
            Iterator GTitr = GTjobj.keys();
            while(GTitr.hasNext())
            {
                JSONObject GTjsonObj  = GTjobj.getJSONObject(GTitr.next().toString());
                bidVal=Float.parseFloat(GTjsonObj.getString("GTValue"));
            }
        }
        while(itr.hasNext())
        {
    		jsonObj  = jobj.getJSONObject(itr.next().toString());
            formId=Integer.parseInt(jsonObj.getString("FormId"));
            tableIdStr = jsonObj.getString("TableId");
            itr2 =jsonObj.getJSONObject("ColumnJsonval").keys();
            while(itr2.hasNext()){
            	k = itr2.next().toString();
            	jsonObjColumn = jsonObj.getJSONObject("ColumnJsonval").getJSONObject(k);
            	bidStr.put(k+jsonObjColumn.getString("cellId"), jsonObjColumn.getString("val")+"@@@"+jsonObjColumn.getString("row")+"@@@"+jsonObjColumn+"@@@"+jsonObjColumn.getString("key")+"@@@"+jsonObjColumn.getString("cellId")+"@@@"+jsonObjColumn.getString("filledBy")+"@@@"+jsonObjColumn.getString("colNo"));
                if(tblTender.getisAuction()==1)
                {
                    if(jsonObjColumn.getString("val").length()>0 && jsonObjColumn.getString("filledBy").equalsIgnoreCase("2"))
                    {
                        bidderVal=Float.parseFloat(jsonObjColumn.getString("val"));
                    }
                }
            }
            hdTableIds.add(tableIdStr);
        }
        TblTenderForm tblTenderForm =  tenderFormService.getTenderFormById(formId);
    	TblTenderBid tblTenderBid = null;
            if(bidId==0){
              tblTenderBid = new TblTenderBid();                
              tblTenderBid.setBidprice(BigDecimal.ZERO);
              tblTenderBid.setCreatedby(userId);
              tblTenderBid.setIpaddress(ipAddress);
              tblTenderBid.setTblCompany(new TblCompany(companyId));
              tblTenderBid.setTblTender(new TblTender(tenderId));
              tblTenderBid.setTblTenderenvelope(new TblTenderEnvelope(tblTenderForm.getTblTenderEnvelope().getEnvelopeId()));
              tblTenderBid.setTblTenderform(new TblTenderForm(formId));
              tblTenderBid.setBidderid(tblBidder.getBidderId());
              tblTenderBid.setCstatus(cstatus);//
     
          } 
            
    	  
    	  List<TblTenderBidMatrix> tblTenderBidMatrixs = new ArrayList<TblTenderBidMatrix>();
          List<TblRebateDetail> tblRebateDetails = new ArrayList<TblRebateDetail>();
          List<TblBidDetail> bidDetails = new ArrayList<TblBidDetail>();
          List<Integer> rowId = new ArrayList<Integer>();
          List<TblItemSelection> selections = new ArrayList<TblItemSelection>();
          
          
          int tableId = 0;
          boolean isValidBid = true;
          for(int t = 0 ; t <hdTableIds.size() ; t++){
        	  tableId = Integer.parseInt(hdTableIds.get(t));
              TblItemSelection itemSelection = new TblItemSelection();
              itemSelection.setCreatedBy(userId);
              itemSelection.setIsBidded(1);
              itemSelection.setIsSelected(1);
              itemSelection.setTblTenderTable(new TblTenderTable(tableId));
              itemSelection.setRowId(t+1);//remain
              itemSelection.setTblCompany(new TblCompany(companyId));
              itemSelection.setTblTender(new TblTender(tenderId));
              itemSelection.setTblTenderEnvelope(new TblTenderEnvelope(tblTenderForm.getTblTenderEnvelope().getEnvelopeId()));
              itemSelection.setTblTenderForm(new TblTenderForm(formId));
              itemSelection.setBidderId(tblBidder.getBidderId());
              selections.add(itemSelection);
              if(!bidStr.isEmpty()){
            	    JSONObject mainObj = new JSONObject();
            	  for (Map.Entry<String, String> entry : bidStr.entrySet()){
            	      String[] bidValue = entry.getValue().split("@@@");
            	      JSONObject obj = new JSONObject();
                      if(tblTender.getRandPass().length()==0)
                      {
                           obj.put("cellValue", encrptDecryptUtils.encrypt(bidValue[0],tblTender.getRandPass().getBytes()));
                      }
                      else
                      {
                          obj.put("cellValue", encrptDecryptUtils.encrypt(bidValue[0],tblTender.getRandPass().substring(0, 16).getBytes())); 
                      }
                     
                      JSONArray list = new JSONArray();
                      list.put(obj);
                      mainObj.put(bidValue[4]+"_"+bidValue[6], list);
                     

                              TblBidDetail tblbidDetail = new TblBidDetail();
                              tblbidDetail.setCellId(Integer.parseInt(bidValue[4]));//set columnId
                              tblbidDetail.setCellValue(encrptDecryptUtils.encrypt(bidValue[0],tblTender.getRandPass().substring(0, 16).getBytes()));
                              tblbidDetail.setTblCompany(new TblCompany(companyId));
                              tblbidDetail.setTblTenderForm(new TblTenderForm(formId));
                              tblbidDetail.setTblTenderColumn(new TblTenderColumn(Integer.parseInt(bidValue[3])));
                              bidDetails.add(tblbidDetail);
//            	      }
                  }

            	  TblTenderBidMatrix tblTenderBidMatrix = new TblTenderBidMatrix();
            	  
            	  tblTenderBidMatrix.setBidjson("["+mainObj.toString()+"]");
                  tblTenderBidMatrix.setEncryptedbid("["+mainObj.toString()+"]");
                  tblTenderBidMatrix.setTblTenderbid(tblTenderBid==null ? new TblTenderBid(bidId,cstatus,ipAddress) : tblTenderBid);
                  tblTenderBidMatrix.setTblTendertable(new TblTenderTable(tableId));
                  tblTenderBidMatrixs.add(tblTenderBidMatrix);
              }else{
            	  isValidBid = false;
              }

          }        
          
          /*
           * rebate start*/
          List<TblTenderCellGrandTotal> lstTblTenderCellGrandTotal=new ArrayList<TblTenderCellGrandTotal>();
          
          if(tblTender.getIsItemwiseWinner() == 0){//Grand Total case
		      	String jsonGTRebate = request.getParameter("hdnGTColumnValue");
				JSONObject jobjGT = new JSONObject(jsonGTRebate);
		    	Iterator itrGT = jobjGT.keys();
		    	JSONObject GTColumnObj = null;
				while(itrGT.hasNext()){
    			  GTColumnObj =jobjGT.getJSONObject(itrGT.next().toString());
    			  if(GTColumnObj!=null){
    				  TblTenderCellGrandTotal tblTenderCellGrandTotal = new TblTenderCellGrandTotal();
    		          tblTenderCellGrandTotal.setTblTenderTable(new TblTenderTable(Integer.parseInt(GTColumnObj.getString("TableId"))));
    		          tblTenderCellGrandTotal.setTblTenderColumn(new TblTenderColumn(Integer.parseInt(GTColumnObj.getString("colId"))));
    		          tblTenderCellGrandTotal.setTblTenderForm(new TblTenderForm(Integer.parseInt(GTColumnObj.getString("FormId"))));
    		          tblTenderCellGrandTotal.setTblTender(new TblTender(tenderId));
    		          tblTenderCellGrandTotal.setTblBidder(tblBidder);
    		          tblTenderCellGrandTotal.setGTValue(encrptDecryptUtils.encrypt(GTColumnObj.getString("GTValue"),tblTender.getRandPass().substring(0, 16).getBytes()));
    		          lstTblTenderCellGrandTotal.add(tblTenderCellGrandTotal);
    		        if(tblTender.getisAuction()==1)
                        {
                        tblTenderBidHistory=new TblTenderBidHistory();
                            tblTenderBidHistory.setBidValue(bidVal.toString());
                            tblTenderBidHistory.setTblBidder(new TblBidder(tblBidder.getBidderId()));
                            tblTenderBidHistory.setTblTender(new TblTender(tenderId));
                            tblTenderBidHistory.setIsAuction(1);
                            
                            tblTenderBidHistory.setBidDateTime(commonService.getServerDateTime());
                           
                        }
                      
    		          if(tblTender.getIsRebateApplicable() == 1){
        				TblRebateDetail rebateDetail = new TblRebateDetail();
        	              rebateDetail.setCellvalue(encrptDecryptUtils.encrypt(GTColumnObj.getString("GTValue"),tblTender.getRandPass().substring(0, 16).getBytes()));
        	              rebateDetail.setTendercolumn(new TblTenderColumn(Integer.parseInt(GTColumnObj.getString("colId"))));
        	              rebateDetail.setTblCompany(new TblCompany(companyId));
        	              rebateDetail.setTblTender(new TblTender(tenderId));
        	              rebateDetail.setCreatedby(userId);
        	              rebateDetail.setTblTenderbidmatrix(tblTenderBidMatrixs.get(tblTenderBidMatrixs.size()-1));
        	              tblRebateDetails.add(rebateDetail);
    		          }
    			  }
				}
          }
          
      String ValidationMsg="";
        if(tblTender.getisAuction()==1)//check it is Auction or not.
        {
             ValidationMsg = biddingFormService.validationForBidSubmission(tenderId,userId);
            if(ValidationMsg.equalsIgnoreCase("") || ValidationMsg.contains("Auction has been resumed,"))
            {
                    if(bidVal!=0)//check bid value is non zero or not
                    {
                        Integer countForBid=biddingFormService.getBidCountByTenderId(tenderId);
                        if(countForBid==0)//check it is first bid or not
                        {
                            
                            
                                if(tblTender.getauctionMethod()==1)//check Method is forward
                                {
                                    if(bidVal < tblTender.getstartPrice())
                                    {
                                        isValidBid=false;
                                    }
                                    else
                                    {
                                      float Last=0;
                                      if(tblTender.getisAcceptStartPrice()==1)
                                      {
                                           Last=tblTender.getstartPrice();
                                      }
                                      else
                                      {
                                           Last=tblTender.getstartPrice()+tblTender.getincrementDecrementValues();
                                      }
                                      
                                    while(Last<bidVal)
                                    {
                                        Last=Last+tblTender.getincrementDecrementValues();
                                    }
                                    if(tblTender.getisReservePriceConfigure()==1)
                                    {
                                        if(bidVal>tblTender.getauctionReservePrice())
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            if(bidVal!=Last)
                                            {
                                                isValidBid=false;
                                            }
                                            else
                                            {
                                                isValidBid=true;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if(bidVal!=Last)
                                        {
                                           isValidBid=false;
                                        }
                                        else
                                        {
                                            isValidBid=true;
                                        }
                                    }
                                    }
                                       
                                    
                                }
                                else
                                {
                                    if(bidVal > tblTender.getstartPrice() )
                                    {
                                        isValidBid=false;
                                    }
                                    else
                                    {
                                        float Last = 0;
                                        if(tblTender.getisAcceptStartPrice()==1)
                                        {
                                            Last=tblTender.getstartPrice();
                                        }
                                        else
                                        {
                                            Last=tblTender.getstartPrice()-tblTender.getincrementDecrementValues();
                                        }
                                        
                                    while(Last>bidVal)
                                    {
                                        Last=Last-tblTender.getincrementDecrementValues();
                                    }
                                    if(tblTender.getisReservePriceConfigure()==1)
                                    {
                                        if(bidVal<tblTender.getauctionReservePrice())
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            if(bidVal!=Last)
                                            {
                                                isValidBid=false;
                                            }
                                            else
                                            {

                                                isValidBid=true;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if(bidVal!=Last)
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {

                                            isValidBid=true;
                                        }
                                    }
                                    }
                                    
                                }
                            
                        }
                        else //if some one already submited bid for auction
                        {
                            Float LastBid= new Float(0);
                            //for Standard 1 and for Rank 0
                            if(tblTender.getBiddingVariant()==1)/*For Standard Auction*/
                            {
                                LastBid = biddingFormService.getHighestBidByTenderId(tblTender).floatValue();
                                if(tblTender.getauctionMethod()==1)//Forward
                                {
                                    Float Last=new Float(0);
                                    if(LastBid == 0)
                                    {
                                        if(tblTender.getisAcceptStartPrice()==1)
                                        {
                                            Last = new Float(tblTender.getstartPrice());
                                        }
                                        else
                                        {
                                            Last = new Float(tblTender.getstartPrice()+tblTender.getincrementDecrementValues());
                                        }
                                    }
                                    else
                                    {
                                        Last = LastBid+tblTender.getincrementDecrementValues();
                                    }
                                    while(Last<bidVal)
                                    {
                                        Last=Last+tblTender.getincrementDecrementValues();
                                    }
                                    if(tblTender.getisReservePriceConfigure()==1)
                                    {
                                        if(bidVal>tblTender.getauctionReservePrice())
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            if(!bidVal.equals(Last))
                                            {
                                                isValidBid=false;
                                            }
                                            else
                                            {
                                                isValidBid=true;
                                            }
                                            
                                        }
                                    }
                                    else
                                    {
                                        if(!bidVal.equals(Last))
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            isValidBid=true;
                                        }
                                    }
                                } 
                                else if(tblTender.getauctionMethod()==0)//Reverse
                                {
                                    Float Last=new Float(0);
                                    if(LastBid == 0)
                                    {
                                        if(tblTender.getisAcceptStartPrice()==1)
                                        {
                                            LastBid = new Float(tblTender.getstartPrice());
                                        }
                                        else
                                        {
                                            LastBid = new Float(tblTender.getstartPrice()-tblTender.getincrementDecrementValues());
                                        }
                                    }
                                    else
                                    {
                                       Last = LastBid-tblTender.getincrementDecrementValues();
                                    }
                                    while(Last>bidVal)
                                    {
                                        Last=Last-tblTender.getincrementDecrementValues();
                                    }
                                    if(tblTender.getisReservePriceConfigure()==1)
                                    {
                                        if(bidVal<tblTender.getauctionReservePrice())
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            if(!bidVal.equals(Last))
                                            {
                                               isValidBid=false;
                                            }
                                            else
                                            {
                                                isValidBid=true;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if(!bidVal.equals(Last))
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            isValidBid=true;
                                        }
                                    }
                                    
                                }
                            }
                            else if(tblTender.getBiddingVariant()==0)//Rank Auction
                            {
                                LastBid = biddingFormService.getLastBidByBidder(tblTender, userId);
                                if(tblTender.getauctionMethod()==1)//forward Auction
                                {
                                    Float Last= new Float(0);
                                    if(LastBid == 0)
                                    {
                                         if(tblTender.getisAcceptStartPrice()==1)
                                         {
                                             Last = new Float(tblTender.getstartPrice());
                                         }
                                         else
                                         {
                                             Last = new Float(tblTender.getstartPrice()+tblTender.getincrementDecrementValues());
                                         }
                                    }
                                    else
                                    {
                                        Last = LastBid+tblTender.getincrementDecrementValues();
                                    }
                                    while(Last<bidVal)
                                    {
                                        Last=Last+tblTender.getincrementDecrementValues();
                                    }
                                    if(tblTender.getisReservePriceConfigure()==1)
                                    {
                                        if(bidVal>tblTender.getauctionReservePrice())
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            if(!bidVal.equals(Last))
                                            {
                                               isValidBid=false;
                                            }
                                            else
                                            {
                                                isValidBid=true;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if(!bidVal.equals(Last))
                                        {
                                           isValidBid=false;
                                        }
                                        else
                                        {
                                            isValidBid=true;
                                        }
                                    }
                                }
                                else if(tblTender.getauctionMethod()==0)//Reverse Auction
                                {
                                    Float Last= new Float(0);
                                    if(LastBid == 0)
                                    {
                                        if(tblTender.getisAcceptStartPrice()==1)
                                        {
                                            Last =new Float(tblTender.getstartPrice());
                                        }
                                        else
                                        {
                                            Last = new Float(tblTender.getstartPrice()-tblTender.getincrementDecrementValues());
                                        }
                                    }
                                    else
                                    {
                                        Last = LastBid-tblTender.getincrementDecrementValues();
                                    }
                                    while(Last>bidVal)
                                    {
                                        Last=Last-tblTender.getincrementDecrementValues();
                                    }
                                    if(tblTender.getisReservePriceConfigure()==1)
                                    {
                                        if(bidVal<tblTender.getauctionReservePrice())
                                        {
                                            isValidBid=false;
                                        }
                                        else
                                        {
                                            if(!bidVal.equals(Last))
                                            {
                                               isValidBid=false;
                                            }
                                            else
                                            {
                                                isValidBid=true;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if(!bidVal.equals(Last))
                                        {
                                           isValidBid=false;
                                        }
                                        else
                                        {
                                            isValidBid=true;
                                        }
                                    }
                                }
                            }
                            
                        }//else close for second bid 
                    }//bidder value non zero if close
                    else
                    {
                        isValidBid=false;
                    }
            }
                
        }//is Auction
        
            
        /*Hemal end*/
                            
                            if(tblTender.getisAuction()==1)
                            {
                                if(isValidBid==true)
                                {
                                    tblTenderBidHistory.setIsValid(1);
                                }
                                else
                                {
                                    tblTenderBidHistory.setIsValid(0);
                                }
                                biddingFormService.InsertAuctionBidHistory(tblTenderBidHistory);
                            }
          success = isValidBid ? eventBidSubmissionService.addBidderBid(tblTenderBid, tblTenderBidMatrixs,bidDetails,selections,lstTblTenderCellGrandTotal) : false;
    	}
//          success = true;
    return success;
    }
   private long getExtendTimeWhenBidReceivedinLastMinute(TblTender tblTender)throws Exception
   {
        String diff = "";
        long timeDiff = Math.abs(tblTender.getAuctionEndDate().getTime() - commonService.getServerDateTime().getTime());       
        diff = String.format("%d",TimeUnit.MILLISECONDS.toMinutes(timeDiff));
        return timeDiff;
   }
    @RequestMapping(value = "/Bid/FormListing", method = RequestMethod.GET)
    public ModelAndView createEvent1(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("/etender/Bid/ViewBiddingFormList");
        return modelAndView;
    }
    
     @RequestMapping(value = "/Bid/TenderListing", method = RequestMethod.GET)
     public ModelAndView createEvent(HttpServletRequest request) {
         ModelAndView modelAndView = new ModelAndView("/etender/Bid/ViewTenderList");
         List<TblTender> lstTender = biddingFormService.TenderListing();
         modelAndView.addObject("tenderList", lstTender);
         return modelAndView;
    }
     
    @ResponseBody
    @RequestMapping(value = "/Bid/GetFormInfo/{tenderId}/{formId}", method = RequestMethod.GET ) 
     public ModelAndView GetFormData(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,HttpServletRequest request,ModelMap modelMap) throws Exception{
    	ModelAndView modelAndView = new ModelAndView("/etender/Bid/BiddingForm");
        // ModelAndView modelAndView = new ModelAndView("/etender/Bid/EditBiddingForm");
         List<Object[]> lst =biddingFormService.ViewTenderForm(formId.toString());
         if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
  	        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
  	      int userId = (int)sBean.getUserId();
		     TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
		     boolean fromBidder = sBean.getUserTypeId() == 1 ? false : true;
	        Map formStructure=biddingFormService.setView(lst,tblBidder!= null ? tblBidder.getTblCompany().getCompanyid() : 0,fromBidder,tblBidder!= null ? tblBidder.getBidderId() : 0);
        
       	TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
         String jsonResp = new Gson().toJson(formStructure);
         modelAndView = new ModelAndView("/etender/Bid/BiddingForm");
         modelAndView.addObject("tenderId",tenderId+"");
         modelAndView.addObject("formId",formId);
         modelAndView.addObject("operation","1"); //opearation=1 for edit
         modelAndView.addObject("StructureInfo", jsonResp.toString());
         modelAndView.addObject("Envlope",biddingFormService.getEnvlopeNameIdForEdit(formId+""));
         modelAndView.addObject("biddingType", tblTender.getBiddingType());
         modelAndView.addObject("tblTender",tenderCommonService.getTenderById(tenderId));
         List<TblTenderForm> tblTenderForm = biddingFormService.getFormById(formId);
         if(tblTenderForm != null && !tblTenderForm.isEmpty()){
             modelAndView.addObject("tblTenderForm",tblTenderForm.get(0));
         }
         }
         return modelAndView;
         
    } 
     @ResponseBody
     @RequestMapping(value="/Bid/validateFormulaColumn/{columnId}",method=RequestMethod.POST)
     public String validateFormulaColumn(@PathVariable("columnId")Integer columnId,HttpServletRequest request,HttpServletResponse response)throws Exception
     {
         return biddingFormService.validateFormulaColumn(columnId);
     }
     
     @ResponseBody
     @RequestMapping(value="/Bid/bidSubmissionValidationForAuction/{tenderId}",method=RequestMethod.GET)
     public String bidSubmissionValidation(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request,HttpServletResponse response)throws Exception
     {
         SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
         int userId = (int) sBean.getUserId();
         //System.out.println("biddingFormService.validationForBidSubmission(tenderCommonService.getTenderById(tenderId));::"+biddingFormService.validationForBidSubmission(tenderCommonService.getTenderById(tenderId)));
         return biddingFormService.validationForBidSubmission(tenderId,userId);
     }
     @ResponseBody
     @RequestMapping(value="/Bid/CurrentTimeAjax/{tenderId}",method=RequestMethod.GET)
     public String CurrentTimeAjax(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request,HttpServletResponse response)throws Exception
     {
        StringBuilder htmlResponse=new StringBuilder();
        try
        {
            Date dt=commonService.getServerDateTime();
            TblTender tblTender=tenderCommonService.getTenderById(tenderId);
            List<Object[]> lst=tenderCommonService.getCurrencyByTenderId(tenderId);
            String currncyName="";
            
            if (lst != null && !lst.isEmpty()) {
                for (int i = 0; i < lst.size(); i++) {
                    if (lst.get(i)[0] != null && lst.get(i)[0].toString().trim().length() > 0) {
                        if (tblTender.getCurrencyId() == (Integer) lst.get(i)[0]) {
                            currncyName = (String) lst.get(i)[3];
                        }
                    }
                }
            }
        String diff = "";   
        long timeDiff = Math.abs(commonService.convertStirngToUTCDate(sql_dateformate, commonService.convertSqlToClientDate(sql_dateformate, tblTender.getAuctionEndDate())).getTime() - dt.getTime());       
        diff = String.format("%d day(s) %d:%d:%d", TimeUnit.MILLISECONDS.toDays(timeDiff),TimeUnit.MILLISECONDS.toHours(timeDiff)-TimeUnit.DAYS.toHours(TimeUnit.MILLISECONDS.toDays(timeDiff)),TimeUnit.MILLISECONDS.toMinutes(timeDiff) - ( TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(timeDiff))),TimeUnit.MILLISECONDS.toSeconds(timeDiff) - ( TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(timeDiff))));
        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());  
        String BidderCurrency="";
        String ExchangeRate="";
        if(tblTender.getBiddingType()==2)
        {
                List<Object[]> lstBidCurrency=biddingFormService.getBidderCurrencyDetailByTenderId(tenderId);
                if(lstBidCurrency != null && !lstBidCurrency.isEmpty())
                {
                    for(int i = 0; i < lstBidCurrency.size() ; i++)
                    {
                        int userId = Integer.parseInt(lstBidCurrency.get(i)[3].toString());
                        if((int)sBean.getUserId()== userId)
                        {

                            BidderCurrency = (String) lstBidCurrency.get(i)[4];
                            ExchangeRate= lstBidCurrency.get(i)[1].toString();
                        }
                    }
                }
        }
        
        SimpleDateFormat sdf=new SimpleDateFormat(client_dateformate_hhmmss);
        
        htmlResponse.append("<div class='col-md-12'>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Auction Start Date :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                    htmlResponse.append(commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionStartDate()));
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Auction End Date :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                    htmlResponse.append(commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionEndDate()));
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
        htmlResponse.append("</div>");
        
        
        
        htmlResponse.append("<div class='col-md-12'>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Current Time :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right' id='divCurrentTime'>");
                htmlResponse.append(sdf.format(new Date()));
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
               htmlResponse.append("<div class='form_filed text-black text-right'>Remaining Time :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                if(dt.before(tblTender.getAuctionEndDate()))
                {
                    htmlResponse.append(diff);
                }
                else
                {
                    htmlResponse.append("Bidding Time Over.");
                }
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
        htmlResponse.append("</div>");
       
        htmlResponse.append("<div class='col-md-12'>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Start price :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                    if(tblTender.getBiddingType()==2)
                    {
                        htmlResponse.append(tblTender.getstartPrice()/Float.parseFloat(ExchangeRate));
                    }
                    else
                    {
                        htmlResponse.append(tblTender.getstartPrice());
                    }
                    
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
            if(tblTender.getauctionMethod()==1)
            {
                htmlResponse.append("<div class='form_filed text-black text-right'> Increment Value :</div>");
            }
            else
            {
                htmlResponse.append("<div class='form_filed text-black text-right'> Decrement Value :</div>");
            }
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                    if(tblTender.getBiddingType()==2)
                    {
                        htmlResponse.append(tblTender.getincrementDecrementValues()/Float.parseFloat(ExchangeRate));
                    }
                    else
                    {
                        htmlResponse.append(tblTender.getincrementDecrementValues());
                    }
                    
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
        htmlResponse.append("</div>");
        
            if(tblTender.getallowsAutoExtension()==1)
            {
                htmlResponse.append("<div class='col-md-12'>");
                    htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                        htmlResponse.append("<div class='form_filed text-black text-right'>Completed Extension :</div>");
                    htmlResponse.append("</div>");
                    htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                        htmlResponse.append("<div class='form_filed text-black text-right'>");
                        int count=biddingFormService.getExtensionCountByTenderId(tenderId);
                        if(tblTender.getautoExtensionMode()==1)
                        {
                          htmlResponse.append(count+"/"+tblTender.getNoOfExtension());
                        }
                        else
                        {
                            htmlResponse.append(count+"/Unlimited");
                        }
                        htmlResponse.append("</div>");
                    htmlResponse.append("</div>");
                    String remain="";
                    if(tblTender.getallowsAutoExtension()==1)
                    {
                        if(TimeUnit.MINUTES.toMillis(tblTender.getextendTimeWhen())>=getExtendTimeWhenBidReceivedinLastMinute(tblTender))
                        {
                            if(tblTender.getautoExtensionMode()==1)
                            {
                                if(count<tblTender.getNoOfExtension())
                                {
                                    remain= count+1+"";
                                }
                                else
                                {
                                    remain="No More Extension";
                                }
                            }
                            else
                            {
                                remain= count+1+"";
                            }
                        }
                    }
                if(!remain.equals(""))
                {
                    htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                       htmlResponse.append("<div class='form_filed text-black text-right'>Current Extension :</div>");
                    htmlResponse.append("</div>");
                    htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                       htmlResponse.append("<div class='form_filed text-black text-right'>"+remain+"</div>");
                    htmlResponse.append("</div>");
                }
                htmlResponse.append("</div>");
             }
        htmlResponse.append("<div class='col-md-12'>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Last Bid :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                Float LastBid=biddingFormService.getLastBidByBidder(tblTender, (int)sBean.getUserId());
                Double HighestBid=biddingFormService.getHighestBidByTenderId(tblTender);
               // SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
               if(LastBid == 0)
               {
                   htmlResponse.append("-");
                  
               }
               else
               {
                   if(tblTender.getBiddingType()==2)
                   {
                        htmlResponse.append(LastBid/Float.parseFloat(ExchangeRate));
                   }
                   else{
                        htmlResponse.append(LastBid);
                   }
                    
               }
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
            if(tblTender.getauctionMethod()==1)
            {
                htmlResponse.append("<div class='form_filed text-black text-right'>Highest Bid Amount :</div>");
            }
            else
            {
                htmlResponse.append("<div class='form_filed text-black text-right'>Lowest Bid Amount :</div>");
            }
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                if(HighestBid == 0)
                {
                    htmlResponse.append("-");
                }
                else
                {
                    if(tblTender.getBiddingType()==2)
                    {
                        htmlResponse.append(HighestBid/Float.parseFloat(ExchangeRate));
                    }
                    else
                    {
                        htmlResponse.append(HighestBid);
                    }
                     
                   
                }
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
        htmlResponse.append("</div>");
        htmlResponse.append("<div class='col-md-12'>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Next Possible Bid :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                Integer countForBid=biddingFormService.getBidCountByTenderId(tenderId);
                if(countForBid==0)
                {
                    if(tblTender.getauctionMethod()==1)
                    {
                        if(tblTender.getisReservePriceConfigure()==1)
                        {
                            if(tblTender.getstartPrice()<=tblTender.getauctionReservePrice())
                            {
                                if(tblTender.getisAcceptStartPrice()==1)
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append(tblTender.getstartPrice()/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(tblTender.getstartPrice());
                                    }
                                    
                                }
                                else
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append((tblTender.getstartPrice()+tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(tblTender.getstartPrice()+tblTender.getincrementDecrementValues());
                                    }
                                }
                                
                            }
                            else
                            {
                                htmlResponse.append("No Bid Accepted.");
                            }
                        }
                        else
                        {
                                if(tblTender.getisAcceptStartPrice()==1)
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append(tblTender.getstartPrice()/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(tblTender.getstartPrice());
                                    }
                                }
                                else
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append((tblTender.getstartPrice()+tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(tblTender.getstartPrice()+tblTender.getincrementDecrementValues());
                                    }
                                }
                        }
                    }
                    else
                    {
                        if(tblTender.getisReservePriceConfigure()==1)
                        {
                            if(tblTender.getstartPrice()>=tblTender.getauctionReservePrice())
                            {
                                if(tblTender.getisAcceptStartPrice()==1)
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append(tblTender.getstartPrice()/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(tblTender.getstartPrice());
                                    }
                                }
                                else
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append((tblTender.getstartPrice()-tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(tblTender.getstartPrice()-tblTender.getincrementDecrementValues());
                                    }
                                    
                                }
                               
                            }
                            else
                            {
                                htmlResponse.append("No Bid Accepted.");
                            }
                        }
                        else
                        {
                            if(tblTender.getisAcceptStartPrice()==1)
                            {
                                if(tblTender.getBiddingType()==2)
                                {
                                    htmlResponse.append(tblTender.getstartPrice()/Float.parseFloat(ExchangeRate));
                                }
                                else
                                {
                                    htmlResponse.append(tblTender.getstartPrice());
                                }
                                
                            }
                            else
                            {
                                if(tblTender.getBiddingType()==2)
                                {
                                    htmlResponse.append((tblTender.getstartPrice()-tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                }
                                else
                                {
                                    htmlResponse.append(tblTender.getstartPrice()-tblTender.getincrementDecrementValues());
                                }
                                
                            }
                        }
                    }
                }
                else
                {
                    if(tblTender.getauctionMethod()==1)
                    {
                        if(tblTender.getisReservePriceConfigure()==1)
                        {
                            if(tblTender.getBiddingVariant()==0)//Rank Auction
                            {
                                    if(LastBid==0)
                                    {
                                        if(tblTender.getisAcceptStartPrice()==1)
                                        {
                                            LastBid = new Float(tblTender.getstartPrice());
                                        }
                                        else
                                        {
                                            LastBid = new Float(tblTender.getstartPrice()+tblTender.getincrementDecrementValues());
                                        }
                                    }
                                    else
                                    {
                                        LastBid = new Float(LastBid+tblTender.getincrementDecrementValues());
                                    }
                                if(LastBid<=tblTender.getauctionReservePrice())
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append(LastBid/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(LastBid);
                                    }
                                    
                                }
                                else
                                {
                                    htmlResponse.append("No Bid Accepted.");
                                }
                            }
                            else //Standard Auction
                            {
                                if(HighestBid<=tblTender.getauctionReservePrice())
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append((HighestBid+tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(HighestBid+tblTender.getincrementDecrementValues());
                                    }
                                    
                                }
                                else
                                {
                                    htmlResponse.append("No Bid Accepted.");
                                }
                            }
                            
                        }
                        else
                        {
                            if(tblTender.getBiddingVariant()==0)//Rank Auction
                            {
                                if(LastBid==0)
                                {
                                    if(tblTender.getisAcceptStartPrice()==1)
                                    {
                                        if(tblTender.getBiddingType()==2)
                                        {
                                            htmlResponse.append(tblTender.getstartPrice()/Float.parseFloat(ExchangeRate));
                                        }
                                        else
                                        {
                                            htmlResponse.append(tblTender.getstartPrice());
                                        }
                                        
                                    }
                                    else{
                                        if(tblTender.getBiddingType()==2)
                                        {
                                            htmlResponse.append((tblTender.getstartPrice()+tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                        }
                                        else
                                        {
                                            htmlResponse.append(tblTender.getstartPrice()+tblTender.getincrementDecrementValues());
                                        }
                                        
                                    }
                                    
                                }
                                else
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append((LastBid+tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(LastBid+tblTender.getincrementDecrementValues());
                                    }
                                      
                                }
                            }
                            else //Standard Auction
                            {
                                if(tblTender.getBiddingType()==2)
                                {
                                    htmlResponse.append((HighestBid+tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                }
                                else
                                {
                                     htmlResponse.append(HighestBid+tblTender.getincrementDecrementValues());
                                }
                            }
                           
                        }
                    }
                    else
                    {
                        if(tblTender.getisReservePriceConfigure()==1)
                        {
                            if(tblTender.getBiddingVariant()==0)//Rank Auction
                            {
                                if(LastBid == 0)
                                    {
                                        if(tblTender.getisAcceptStartPrice()==1)
                                        {
                                            LastBid = new Float(tblTender.getstartPrice());
                                        }
                                        else{
                                            LastBid = new Float(tblTender.getstartPrice()-tblTender.getincrementDecrementValues());
                                        }
                                    }
                                    else
                                    {
                                        LastBid = new Float(LastBid-tblTender.getincrementDecrementValues());
                                    }
                                if(LastBid>=tblTender.getauctionReservePrice())
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append(LastBid/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(LastBid);
                                    }
                                    
                                }
                                else
                                {
                                    htmlResponse.append("No Bid Accepted.");
                                } 
                            }
                            else
                            {
                                 if(HighestBid>tblTender.getauctionReservePrice())
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append((HighestBid-tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(HighestBid-tblTender.getincrementDecrementValues());
                                    }
                                    
                                }
                                else
                                {
                                    htmlResponse.append("No Bid Accepted.");
                                }
                            }
                           
                        }
                        else
                        {
                            if(tblTender.getBiddingVariant()==0)//rank Auction
                            {
                                if(LastBid==0)
                                {
                                        if(tblTender.getisAcceptStartPrice()==1)
                                        {
                                            if(tblTender.getBiddingType()==2)
                                            {
                                                htmlResponse.append(tblTender.getstartPrice()/Float.parseFloat(ExchangeRate));
                                            }
                                            else
                                            {
                                                htmlResponse.append(tblTender.getstartPrice());
                                            }
                                        }
                                        else{
                                            if(tblTender.getBiddingType()==2)
                                            {
                                                htmlResponse.append((tblTender.getstartPrice()-tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                            }
                                            else
                                            {
                                                htmlResponse.append(tblTender.getstartPrice()-tblTender.getincrementDecrementValues());
                                            }
                                            
                                        }
                                }
                                else
                                {
                                    if(tblTender.getBiddingType()==2)
                                    {
                                        htmlResponse.append((LastBid-tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                    }
                                    else
                                    {
                                        htmlResponse.append(LastBid-tblTender.getincrementDecrementValues());
                                    }
                                    
                                }
                            }
                            else
                            {
                                if(tblTender.getBiddingType()==2)
                                {
                                    htmlResponse.append((HighestBid-tblTender.getincrementDecrementValues())/Float.parseFloat(ExchangeRate));
                                }
                                else
                                {
                                    htmlResponse.append(HighestBid-tblTender.getincrementDecrementValues());
                                }
                                
                            }
                            
                        }

                    }
                }
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
            /*1 For Standard auction And 0 For Rank auction*/
            if(tblTender.getBiddingVariant()==0)//For Rank Auction
            {
                  Integer rank=biddingFormService.getBidderRank(tblTender, (int)sBean.getUserId());
                if(rank>0)
                {
                    htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                        htmlResponse.append("<div class='form_filed text-black text-right'>Rank :</div>");
                    htmlResponse.append("</div>");
                    htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                        htmlResponse.append("<div class='form_filed text-black text-right'>");
                        htmlResponse.append(rank);
                        htmlResponse.append("</div>");
                    htmlResponse.append("</div>");
                }
             }
            
          
        htmlResponse.append("</div>");
        
        htmlResponse.append("<div class='col-md-12'>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Base Currency :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                htmlResponse.append(currncyName);
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
        htmlResponse.append("</div>");
        if(tblTender.getBiddingType()==2)
        {
        
        htmlResponse.append("<div class='col-md-12'>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Your Currency :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                htmlResponse.append(BidderCurrency);
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
        
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>Exchange Rate :</div>");
            htmlResponse.append("</div>");
            htmlResponse.append("<div class='col-sm-3 col-md-3'>");
                htmlResponse.append("<div class='form_filed text-black text-right'>");
                htmlResponse.append(ExchangeRate);
                htmlResponse.append("</div>");
            htmlResponse.append("</div>");
        
        htmlResponse.append("</div>");
        }
        }
        catch(Exception e)
        {
            htmlResponse.append("Error In Controller");
            e.printStackTrace();
        }
         return htmlResponse.toString();
     }
     
     @RequestMapping(value = "/Bid/GetFormInfoForTest/{tenderId}/{formId}/{flag}", method = RequestMethod.GET ) 
     public ModelAndView GetFormDataForTest(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("flag")Integer flag,HttpServletRequest request,ModelMap modelMap) throws Exception
     {
         
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
 	        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()); 
        List<Object[]> lst =biddingFormService.ViewTenderForm(formId+"");
        Map formulaMap=biddingFormService.GetFormulaColumns(formId);
        formulaMap.put("FormulaGrid",biddingFormService.GetFormulaGrid(formId));
        int userId = (int)sBean.getUserId();
	     TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
	     boolean fromBidder = sBean.getUserTypeId() == 1 ? false : true;
             Map formStructure=biddingFormService.setView(lst,tblBidder!= null ? tblBidder.getTblCompany().getCompanyid() : 0,fromBidder,tblBidder!= null ? tblBidder.getBidderId() : 0);
        String res = new Gson().toJson(formStructure);
        String retVal = "/etender/Bid/ViewBiddingForm";
        modelAndView = new ModelAndView(retVal);
        modelAndView.addObject("formStructure",formStructure);
        Map map=biddingFormService.getDocumentFormDetail(formId);
         Map formFormulaWithColumn=biddingFormService.getFormulaPerColumn(formId+"");
       
         modelAndView.addObject("formFormulaWithColumn",formFormulaWithColumn);
        modelAndView.addObject("getLastFormulaColumn",biddingFormService.getLastFormulaColumn(formFormulaWithColumn));
          modelAndView.addObject("opt","0");
        modelAndView.addObject("FormBean",map);
         
        modelAndView.addObject("tenderId",tenderId);    
        modelAndView.addObject("Back","Back");
        modelAndView.addObject("formulaMap",formulaMap);
        if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
	        SessionBean sBean1 = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());

        modelAndView.addObject("tenderId",tenderId);
        modelAndView.addObject("operation", "edit");
        TblTender tblTender1=biddingFormService.BiddingTypeFromTender(tenderId);
        modelAndView.addObject("isAuction",tblTender1.getisAuction());
                modelAndView.addObject("sessionUserTypeId", sBean1.getUserTypeId());
        modelAndView.addObject("tblTender",tenderCommonService.getTenderById(tenderId));
        }
        
         
    }
      
         return modelAndView;
     }
   
     @ResponseBody
    @RequestMapping(value = "/Bid/GetTableStructure/{formId}", method = RequestMethod.GET )
     public String GetTableStructure(@PathVariable("formId")Integer formId,HttpServletRequest request,ModelMap modelMap) throws Exception{
         Map tableStructure = (Map) biddingFormService.getTableStructure(formId);
         String jsonResp = new Gson().toJson(tableStructure);
      

         return jsonResp;
    } 
     
    @ResponseBody
    @RequestMapping(value = "/Bid/GetTableRows/{formId}", method = RequestMethod.GET )
     public String GetRows(@PathVariable("formId")Integer formId,HttpServletRequest request,ModelMap modelMap) throws JsonProcessingException,Exception{
    	if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
	        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
           
        List<Object[]> lst =biddingFormService.ViewTenderForm(formId.toString());
        
      //  HostnameVerifier hostnameVerifier = org.apache.http.conn.ssl.SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER;
        int userId = (int)sBean.getUserId();
	    TblBidder tblBidder = tenderCommonService.getTblBidderId(userId);
	    boolean fromBidder = sBean.getUserTypeId() == 1 ? false : true;
            Map formStructure=biddingFormService.setView(lst,tblBidder!= null ? tblBidder.getTblCompany().getCompanyid() : 0,fromBidder,tblBidder!= null ? tblBidder.getBidderId() : 0);
    	}
         return "";
    }  
     
     @RequestMapping(value = "/Bid/EditBiddingForm", method = RequestMethod.GET)
     public ModelAndView EditBiddingForm(HttpServletRequest request) {
                ModelAndView modelAndView = new ModelAndView("/etender/Bid/EditBiddingForm");
        return modelAndView;
    } 
     
     
    
     
     @RequestMapping(value = "/Bid/PublishBiddingForm/{tenderId}/{formId}", method = RequestMethod.GET)
    public String PublishBiddingForm(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId, HttpServletRequest request, HttpServletResponse response) throws Exception {

		 biddingFormService.publishForm(formId);
                 String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
		      
                return retVal;
    }
    
    @RequestMapping(value = "/Bid/GetFormulaColumns/{tenderId}/{formId}", method = RequestMethod.GET)
    public ModelAndView GetFormulaColumns(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId, HttpServletRequest request, HttpServletResponse response) throws Exception {
	      
        Map formulaMap=biddingFormService.GetFormulaColumns(formId);
        formulaMap.put("FormulaGrid",biddingFormService.GetFormulaGrid(formId));
        ModelAndView modelAndView = new ModelAndView("/etender/Bid/SetFormula");
        modelAndView.addObject("formulaMap",formulaMap);
        modelAndView.addObject("tenderId",tenderId);
        modelAndView.addObject("formulaCreated", formulaCreated);
        modelAndView.addObject("formulaDeleted", formulaDeleted);
        Map map=biddingFormService.getDocumentFormDetail(formId);
        modelAndView.addObject("FormBean",map);
        modelAndView.addObject("GrandTotalColumn",biddingFormService.getColumnsForGrandTotal(formId));
        modelAndView.addObject("ItemWiseWinner",biddingFormService.getTenderDetails(tenderId).getIsItemwiseWinner());
        modelAndView.addObject("isAuction",tenderCommonService.getTenderById(tenderId).getisAuction());
        formulaCreated="0";
        formulaDeleted="0";
        return modelAndView;

    }     
    @RequestMapping(value="/Bid/SaveGrandTotal",method=RequestMethod.GET)
    public String SaveGrandTotal(HttpServletRequest request,HttpServletResponse response , RedirectAttributes redirectAttributes)throws Exception
    {
     
       
        
        Integer formId=Integer.parseInt(request.getParameter("hdn_FormId"));
        Integer tenderId=Integer.parseInt(request.getParameter("tenderId"));
        String colIds[]=  request.getParameter("hdnColId")!=null?request.getParameter("hdnColId").split(","):"1".split(",");
        biddingFormService.SaveGrandTotal(colIds,formId,tenderId);
      
       
         String retVal="redirect:/etender/buyer/tenderDashboard/"+tenderId;
         redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Grand Total Saved successfully.");
  
        return retVal;
    }
    @RequestMapping(value = "/Bid/SaveFormula", method = RequestMethod.GET)
    public String SaveFormula( HttpServletRequest request, HttpServletResponse response
    , RedirectAttributes redirectAttributes) throws Exception {
        int status=biddingFormService.SaveFormula(request);
           formulaCreated="0";
        formulaDeleted="0";
        Integer tenderId= Integer.parseInt(request.getParameter("tenderId")!=null?request.getParameter("tenderId"):"1");
	
        String formId=request.getParameter("hdnFormId")!=null?request.getParameter("hdnFormId"):"1";
       
	 String retVal="redirect:/etender/buyer/tenderDashboard/"+tenderId;
         if(status==1)
            redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Formula Created successfully.");
         else if(status==0)
             redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "Formula already Created for this column."); 
         else if(status==2)
              redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Formula Updated successfully.."); 
          formulaCreated="1";
       
         return retVal;
       
    }  
    
    @RequestMapping(value = "/Bid/RemoveFormula/{tenderId}/{formId}/{form}", method = RequestMethod.GET)
    public String RemoveFormula(@PathVariable("tenderId")Integer tenderId, @PathVariable("formId")Integer formId,@PathVariable("form")Integer form,HttpServletRequest request, HttpServletResponse response
     , RedirectAttributes redirectAttributes) throws Exception {
        formulaCreated="0";
        formulaDeleted="0";
        biddingFormService.RemoveFormula(formId);
	   String retVal="redirect:/etender/buyer/tenderDashboard/"+tenderId;
         redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Formula deleted successfully.");
         
		        formulaDeleted="1";
       
                return retVal;
      
    }  
    @RequestMapping(value="/Bid/DeleteForm/{tenderId}/{formId}",method=RequestMethod.GET)
    public String DeleteForm(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception
    {
        
        biddingFormService.UpdateFormStatusForDelete(formId);
        List<TblTenderEnvelope> lstTblTenderEnvelope=biddingFormService.getMinimumFormCountForBidding(tenderId);
        biddingFormService.updateMinimumBiddingFormReqForBidding(lstTblTenderEnvelope);
        String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
         redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Form deleted successfully.");
         
        return retVal;
    }
    @RequestMapping(value="/Bid/saveFormDocument",method={RequestMethod.POST})
    public String saveFormDocument(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes)throws Exception
    {
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        ArrayList lstFormDocumentBean=biddingFormService.setDocumentFormParameters(request);
        String tenderId=request.getParameter("tenderId")!=null?request.getParameter("tenderId"):"1";
        String formId=request.getParameter("formId")!=null?request.getParameter("formId"):"1";
        boolean status=biddingFormService.addDocumentform(lstFormDocumentBean);
        String retVal = "redirect:/eBid/Bid/createFormDocument/"+tenderId+"/"+formId;
        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Document Checklist prepared successfully.");
       
        return retVal;
    }

    /*Update form Document*/
    @RequestMapping(value="/Bid/UpdateDocumentform",method={RequestMethod.POST})
    public String UpdateDocumentForm(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes)throws Exception
    {
         ModelAndView modelAndView = new ModelAndView("/eProcurement");
        String tenderId=request.getParameter("tenderId")!=null?request.getParameter("tenderId"):"1";
        String formId=request.getParameter("formId")!=null?request.getParameter("formId"):"1";
        String isMandatory=request.getParameter("isMandatory")!=null?request.getParameter("isMandatory"):"0";
       TblTenderDocument tblTenderDocument=new TblTenderDocument();
       tblTenderDocument.setDocumentId(Integer.parseInt(request.getParameter("documentId")));
       tblTenderDocument.setDocumentName(request.getParameter("documentName"));
       tblTenderDocument.setIsMandatory(Integer.parseInt(isMandatory));
       TblTender tblTender=new TblTender();
       tblTender.setTenderId(Integer.parseInt(tenderId));
       tblTenderDocument.setTblTender(tblTender);
       TblTenderForm tblTenderForm=new TblTenderForm();
       tblTenderForm.setFormId(Integer.parseInt(formId));
       tblTenderDocument.setTblTenderForm(tblTenderForm);
      boolean status=biddingFormService.UpdateDocumentForm(tblTenderDocument);
       String retVal = "redirect:/eBid/Bid/createFormDocument/"+tenderId+"/"+formId;
       redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Document Checklist updated successfully.");
        return retVal;
    }

    
    
    /*Save Evaluation Column :Hemal*/
        @RequestMapping(value="/Bid/saveEvaluationColumn",method={RequestMethod.POST})
    public String saveEvaluationColumnForm(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes)throws Exception
    {
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        ArrayList<TblTenderGovColumn> lstTblTenderGovColumns=biddingFormService.setJsonValueForEvaluationColumn(request);
        String tenderId=request.getParameter("tenderId")!=null?request.getParameter("tenderId"):"1";
        String formId=request.getParameter("formId")!=null?request.getParameter("formId"):"1";
        StringBuilder msg=new StringBuilder();
        boolean status=biddingFormService.addEvaluationColumn(lstTblTenderGovColumns);
        
        
        String retVal="redirect:/etender/buyer/tenderDashboard/"+tenderId;
         redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), biddingFormService.getEvaluationColumnName(lstTblTenderGovColumns));
      
        return retVal;
    }

    @RequestMapping(value="/Bid/UpdateEvaluationColumn",method={RequestMethod.POST})
    public String UpdateEvaluationColumn(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes)throws Exception
    {
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        String tenderId=request.getParameter("tenderId")!=null?request.getParameter("tenderId"):"1";
        String formId=request.getParameter("formId")!=null?request.getParameter("formId"):"1";
        TblTenderGovColumn tblTenderGovColumn=new TblTenderGovColumn();
        TblTenderColumn tblTenderColumn=new TblTenderColumn();
        tblTenderColumn.setColumnId(Integer.parseInt(request.getParameter("optEvaluationCol")));
        tblTenderGovColumn.setTblTenderColumn(tblTenderColumn);
        tblTenderGovColumn.setGovColumnId(Integer.parseInt(request.getParameter("govColumnId")));
        tblTenderGovColumn.setCellId(Integer.parseInt(request.getParameter("cellId")));
        tblTenderGovColumn.setColumnNo(Integer.parseInt(request.getParameter("ColumnNo")));
        tblTenderGovColumn.setIpAddress(request.getParameter("ipAdd"));
         TblTender tblTender=new TblTender();
        tblTender.setTenderId(Integer.parseInt(tenderId));
        TblTenderForm tblTenderForm=new TblTenderForm();
        tblTenderForm.setFormId(Integer.parseInt(formId));
        tblTenderGovColumn.setTblTender(tblTender);
        tblTenderGovColumn.setTblTenderForm(tblTenderForm);
        TblTenderTable tblTenderTable=new TblTenderTable();
        tblTenderTable.setTableId(Integer.parseInt(request.getParameter("tableId")));
        tblTenderGovColumn.setTblTenderTable(tblTenderTable);
        biddingFormService.UpdateEvaluationColumn(tblTenderGovColumn);
         String retVal="redirect:/etender/buyer/tenderDashboard/"+tenderId;
         redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Evalution column updated successfully.");
      
        return retVal;
    }
 
    @RequestMapping(value="/Bid/deleteFormDocument/{tenderId}/{formId}/{documentId}",method={RequestMethod.GET})
    public String deleteFormDocument(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,
            @PathVariable("documentId")Integer documentId,HttpServletRequest request, RedirectAttributes redirectAttributes)throws Exception
    {
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        TblTenderDocument tblTenderDocument=new TblTenderDocument();
        tblTenderDocument.setDocumentId(documentId);
        boolean status=biddingFormService.DeleteDocumentForm(tblTenderDocument);
        String retVal = "redirect:/eBid/Bid/createFormDocument/"+tenderId+"/"+formId;
        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Form document deleted successfully.");
        return retVal;
    }
    
    @RequestMapping(value = "/Bid/createFormDocument/{tenderId}/{formId}", method = RequestMethod.GET)
    public ModelAndView createFormDocument(@PathVariable("tenderId")Integer tenderId,
            @PathVariable("formId")Integer formId,HttpServletRequest request, RedirectAttributes redirectAttributes)throws UnsupportedOperationException{
        String retVal="redirect:/sessionexpired";
        ModelAndView modelAndView=null;
        try
        {
            retVal="/etender/Bid/BiddingFormDocument";
            modelAndView=new ModelAndView(retVal);
            modelAndView.addObject("tenderId",tenderId);
            modelAndView.addObject("formId", formId);
            Map map=biddingFormService.getDocumentFormDetail(formId);
            List<TblTenderDocument> lst=biddingFormService.getAllDocumentDetail(formId);
            modelAndView.addObject("DocumentGrid",lst);
            modelAndView.addObject("FormBean",map);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return modelAndView;

    }
/*get Evaluation Column*/
   @RequestMapping(value="/Bid/getEvaluationColumn/{tenderId}/{formId}",method=RequestMethod.GET)
    public ModelAndView getEvaluationColumn(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,HttpServletRequest request)throws UnsupportedOperationException{
        String retVal="redirect:/sessionexpired";
        ModelAndView modelAndView=null;
        try
        {
            retVal="/etender/Bid/SaveEvaluationColumn";
           modelAndView=new ModelAndView(retVal);
            modelAndView.addObject("tenderId",tenderId);
            modelAndView.addObject("formId", formId);
           Map mapEvaluationColumn=biddingFormService.getEvaluationColumn(formId,0);
           Map mapTblTenderForm=biddingFormService.getDocumentFormDetail(formId);
            modelAndView.addObject("EvaluationColumnMap",mapEvaluationColumn.get("EvaluationColumn"));
            modelAndView.addObject("tblTenderForm",mapTblTenderForm);
            List<TblTenderGovColumn> lstTblTenderGovColumn=biddingFormService.getAllEvaluationColumn(formId);
            modelAndView.addObject("GridData", lstTblTenderGovColumn);
          
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return modelAndView;
        //return modelAndView;
    }

    @RequestMapping(value="/Bid/EditDocumentForm/{tenderId}/{formId}/{documentId}",method=RequestMethod.GET)
    public ModelAndView EditDocumentForm(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("documentId")Integer documentId,HttpServletRequest request)throws Exception{
    String retVal="redirect:/sessionexpired";
        ModelAndView modelAndView=null;
        try
        {
            retVal="/etender/Bid/BiddingFormDocument";
            modelAndView=new ModelAndView(retVal);
            modelAndView.addObject("tenderId",tenderId);
            modelAndView.addObject("formId", formId);
            Map map=biddingFormService.getDocumentFormDetail(formId);
            List<TblTenderDocument> lst=biddingFormService.getAllDocumentDetail(formId);
            modelAndView.addObject("DocumentGrid",lst);
            modelAndView.addObject("FormBean",map);
            modelAndView.addObject("documentId", documentId);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return modelAndView;
    
    }

    @RequestMapping(value="/Bid/deleteEvaluationColumn/{tenderId}/{formId}/{govColumnId}/{cellId}/{columnNo}/{ipAddress}",method={RequestMethod.GET})
    public String deleteEvaluationColumn(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("govColumnId")Integer govColumnId,@PathVariable("cellId")Integer cellId
            ,@PathVariable("columnNo")Integer columnNo,@PathVariable("ipAddress")String ipAddress,HttpServletRequest request, RedirectAttributes redirectAttributes)throws Exception
    {
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        TblTenderGovColumn tblTenderGovColumn=new TblTenderGovColumn();
        tblTenderGovColumn.setGovColumnId(govColumnId);
        tblTenderGovColumn.setCellId(cellId);
        tblTenderGovColumn.setColumnNo(columnNo);
        tblTenderGovColumn.setIpAddress(ipAddress);
        boolean status=biddingFormService.DeleteEvaluationColumn(tblTenderGovColumn);
        String retVal = "redirect:/eBid/Bid/getEvaluationColumn/"+tenderId+"/"+formId;
        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Evalution column deleted successfully.");
        return retVal;
    }

    @RequestMapping(value="/Bid/EditEvaluationColumn/{tenderId}/{formId}/{govColumnId}/{operation}",method=RequestMethod.GET)
    public ModelAndView EditEvaluationColumn(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("govColumnId")Integer govColumnId,@PathVariable("operation")Integer operation,HttpServletRequest request)throws Exception
    {
        String retVal="redirect:/sessionexpired";
        ModelAndView modelAndView=null;
        try
        {
            retVal="/etender/Bid/SaveEvaluationColumn";
            modelAndView=new ModelAndView(retVal);
            modelAndView.addObject("tenderId",tenderId);
            modelAndView.addObject("formId", formId);
            Map mapEvaluationColumn=biddingFormService.getEvaluationColumn(formId,operation);
            Map mapTblTenderForm=biddingFormService.getDocumentFormDetail(formId);
            modelAndView.addObject("EvaluationColumnMap",mapEvaluationColumn.get("EvaluationColumn"));
            modelAndView.addObject("EvaluationAllColumn",biddingFormService.getEvaluationColumn(formId,1));
            modelAndView.addObject("tblTenderForm",mapTblTenderForm);
            List<TblTenderGovColumn> lstTblTenderGovColumn=biddingFormService.getAllEvaluationColumn(formId);
            modelAndView.addObject("GridData", lstTblTenderGovColumn);
            modelAndView.addObject("govColumnId",govColumnId);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return modelAndView;
    
    }
    
     @RequestMapping(value = "/Bid/EditFormStructure", method = { RequestMethod.POST,RequestMethod.GET})
    public String EditFormStructure(@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response) throws Exception{  
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        BiddingFormBean biddingFormBean=biddingFormService.setBiddingFormParameters(request);
        int  tenderId=convertInt(checkRequestNull(request, "hdnTenderId"));
        TblTenderForm tblTenderForm=biddingFormService.setBiddingFormParameterToTable(biddingFormBean);
        boolean status=biddingFormService.addBiddingFormDetails(tblTenderForm);
        	String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
		retVal="redirect:/eBid/Bid/FillBiddingForm/"+tenderId+"/"+tblTenderForm.getFormId();
        return retVal;
   
       
    }
    
    @RequestMapping(value = "/Bid/editForm", method = { RequestMethod.POST,RequestMethod.GET})
    public String editForm(@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response) throws Exception{  
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        int  tenderId=convertInt(checkRequestNull(request, "tenderId"));
       
          int formId=convertInt(checkRequestNull(request, "hdnFormId"));
     
        BiddingFormBean biddingFormBean=biddingFormService.setBiddingFormParameters(request);
       TblTenderForm tblTenderForm=biddingFormService.setBiddingFormParameterToTable(biddingFormBean);
      //updateform func
        biddingFormService.EditBiddingForm(tblTenderForm);
        //BiddingFormColumnBean biddingFormColumnBean=new BiddingFormColumnBean();
        TblTenderColumn tblTenderColumn;
        TblTenderTable tblTenderTable;
        BiddingFormTableBean t;
        List <TblTenderTable> lstTblTenderTable=new ArrayList<TblTenderTable>();
        List <TblTenderColumn> lstTblTenderColumn=new ArrayList<TblTenderColumn>();
     
        HashMap hs=biddingFormService.setBiddingFormTableParameters(request);
 
        Set s=hs.entrySet();
        Iterator itrH=s.iterator();
        while(itrH.hasNext())
        {
            Map.Entry m= (Map.Entry) itrH.next();
            t=(BiddingFormTableBean)m.getKey();
            tblTenderTable=biddingFormService.setBiddingFormTableParameterToTable(t);
            biddingFormService.editBiddingFormTable(tblTenderTable);
      
             
            lstTblTenderTable.add(tblTenderTable);
            List l1=(ArrayList)m.getValue();
            for(int i=0;i<l1.size();i++)
            {
                 BiddingFormColumnBean b1=(BiddingFormColumnBean)l1.get(i);
                 tblTenderColumn=biddingFormService.setBiddingFormColumnParameterToTable(b1);
                 tblTenderColumn.setTblTenderForm(tblTenderForm);
                 tblTenderColumn.setTblTenderTable(tblTenderTable);
                biddingFormService.editBiddingFormColumn(tblTenderColumn);
                lstTblTenderColumn.add(tblTenderColumn);
            }
        }
      String retVal = "redirect:/eBid/Bid/viewFormForEdit/"+tenderId+"/"+formId;
	
        return retVal;
       }
    
    @RequestMapping(value = "/Bid/deleteColumnFromBiddingForm/{tenderId}/{formId}/{tableId}/{columnId}", method = { RequestMethod.POST,RequestMethod.GET})
    public String deleteColumnFromBiddingForm(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("tableId")Integer tableId,@PathVariable("columnId")Integer columnId,@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) throws Exception{  
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        
     TblTenderColumn tblTenderColumn=new TblTenderColumn();
     tblTenderColumn.setColumnId(columnId);
     TblTenderForm tblTenderForm=new TblTenderForm();
     tblTenderForm.setFormId(formId);
     tblTenderColumn.setTblTenderForm(tblTenderForm);
     TblTenderTable tblTenderTable=new TblTenderTable();
     tblTenderTable.setTableId(tableId);
     tblTenderColumn.setTblTenderTable(tblTenderTable);
     String error=biddingFormService.DeleteBiddingFormColumn(tblTenderColumn);
     redirectAttributes.addFlashAttribute("errorMsg", error);
		        			
     String retVal = "redirect:/eBid/Bid/GetFormInfo/"+tenderId+"/"+formId;
    return retVal;
           
    }

    @RequestMapping(value = "/Bid/deleteTableFromBiddingForm/{tenderId}/{formId}/{tableId}", method = { RequestMethod.POST,RequestMethod.GET})
    public String deleteTableFromBiddingForm(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("tableId")Integer tableId,@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) throws Exception{  
        ModelAndView modelAndView = new ModelAndView("/eProcurement");
        
     TblTenderColumn tblTenderColumn=new TblTenderColumn();
     
     List<TblTenderColumn> tblTenderColumnList=biddingFormService.getTableColumn(tableId);
     int TableCount=biddingFormService.getTableCount(formId);
     if(TableCount<=1)
     {
         redirectAttributes.addFlashAttribute("errorMsg", "You can not delete table , One table is Mandatory in form");

     }
     else{
     int status=biddingFormService.TableDeletionCheck(tblTenderColumnList);
     
     if(status==0)
     {
   
         biddingFormService.deleteTable(tblTenderColumnList,tableId,formId);
          redirectAttributes.addFlashAttribute("errorMsg", "Table deleted successfully");
     }
     else
        redirectAttributes.addFlashAttribute("errorMsg", "You can not delete table , Table Column(s) might be used as formula/Gt Column/Evalution Column.");
 
     }	        			
     String retVal = "redirect:/eBid/Bid/GetFormInfo/"+tenderId+"/"+formId;
    return retVal;
           
    }

    
    @RequestMapping(value = "/Bid/viewFormForEdit/{tenderId}/{formId}", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView viewFormForEdit(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response) throws Exception{ModelAndView modelAndView = new ModelAndView("/eProcurement");
    
	    if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
	        SessionBean sBean = (SessionBean) request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString());
	        List<Object[]> lst =biddingFormService.ViewTenderForm(formId+"");
	        int userId = (int)sBean.getUserId();
	        int companyId = 0;
	        TblBidder tblBidder = null;
	        if(sBean.getUserTypeId() == 2){
	        	tblBidder = tenderCommonService.getTblBidderId(userId);
	        	companyId = tblBidder.getTblCompany().getCompanyid();	
	        }
		    
	        Map formStructure=biddingFormService.setView(lst,tblBidder!= null ? companyId : 0,false,tblBidder!= null ? tblBidder.getBidderId() : 0);
	        String res = new Gson().toJson(formStructure);
	        String retVal = "/etender/Bid/ViewBiddingForm";
	        modelAndView = new ModelAndView(retVal);
	        modelAndView.addObject("formStructure",formStructure);
	        Map map=biddingFormService.getDocumentFormDetail(formId);
	        Map formFormulaWithColumn=biddingFormService.getFormulaPerColumn(formId+"");
	       
	        modelAndView.addObject("formFormulaWithColumn",formFormulaWithColumn);
	        modelAndView.addObject("getLastFormulaColumn",biddingFormService.getLastFormulaColumn(formFormulaWithColumn));
	        modelAndView.addObject("fromView", false);
	        modelAndView.addObject("FormBean",map);
	        modelAndView.addObject("tenderId",tenderId);
	        modelAndView.addObject("operation", "edit");
	        
	        TblTender tblTender1=tenderCommonService.getTenderById(tenderId);
                modelAndView.addObject("tblTender",tblTender1);
	        modelAndView.addObject("isAuction",tblTender1.getisAuction());
                if(tblTender1.getisAuction()==1)
                {
                    modelAndView.addObject("auctionStartDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender1.getAuctionStartDate()));
                    modelAndView.addObject("auctionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender1.getAuctionEndDate()));
                }
            List<Object[]> lstBidCurrency=biddingFormService.getBidderCurrencyDetailByTenderId(tenderId);
        String BidderCurrency="";
        String ExchangeRate="";
        if(lstBidCurrency != null && !lstBidCurrency.isEmpty())
        {
            for(int i = 0; i < lstBidCurrency.size() ; i++)
            {
                int userId1 = Integer.parseInt(lstBidCurrency.get(i)[3].toString());
                if((int)sBean.getUserId()== userId1)
                {
                    
                    BidderCurrency = (String) lstBidCurrency.get(i)[4];
                    ExchangeRate= lstBidCurrency.get(i)[1].toString();
                }
            }
        }
        List<Object[]> lst1=tenderCommonService.getCurrencyByTenderId(tenderId);
            String currncyName="";
            
            if (lst1 != null && !lst1.isEmpty()) {
                for (int i = 0; i < lst1.size(); i++) {
                    if (lst1.get(i)[0] != null && lst1.get(i)[0].toString().trim().length() > 0) {
                        if (tblTender1.getCurrencyId() == (Integer) lst1.get(i)[0]) {
                            currncyName = (String) lst1.get(i)[3];
                        }
                    }
                }
            }
            modelAndView.addObject("currncyName",currncyName);
            modelAndView.addObject("BidderCurrency", BidderCurrency);
            modelAndView.addObject("ExchangeRate", ExchangeRate);
	    modelAndView.addObject("tblTender",tblTender1);
            
            
            
	            if(sBean.getUserTypeId() == 2){
	            	List<Object[]> currencyList = null;
	                String selectedCurrency = "";
	                boolean isRepeated = eventBidSubmissionService.isTenderIdRepeated(tenderId, tblBidder.getBidderId());
	                currencyList = eventBidSubmissionService.getCurrencies(tenderId,companyId,false);
	                if (tblTender1.getBiddingType() == 2) {
	                   if(isRepeated){
	                	   selectedCurrency=eventBidSubmissionService.getCurrencies(tenderId, companyId, true).get(0)[1].toString();    //tenderFormService.getBidderCurrency(tenderId, companyId).get(0)[0].toString();
	                   }
	                }else if(tblTender1.getBiddingType() == 1) {
	                	selectedCurrency = currencyList != null ? currencyList.get(0)[1].toString() : "";
	                }
	                modelAndView.addObject("listOfCurrency", currencyList);
	                modelAndView.addObject("isRepeated", isRepeated);
	                modelAndView.addObject("selectedCurrency", selectedCurrency);
	            }       
		        modelAndView.addObject("sessionUserTypeId", sBean.getUserTypeId());
                        
	    }
	    return modelAndView;
    }
    
     

    @RequestMapping(value = "/Bid/copyForm", method = { RequestMethod.POST,RequestMethod.GET})
    public String copyForm(@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) throws Exception{  
        ModelAndView modelAndView ;
        Map TenderFormDetails=new LinkedHashMap();
        int count=0;
    
        String formIds[]=  request.getParameter("hdnFormId")!=null?request.getParameter("hdnFormId").split(","):"1".split(",");
        String tenderId=   request.getParameter("tenderId")!=null?request.getParameter("tenderId"):"1";
        String envId=request.getParameter("TenderEnv")!=null?request.getParameter("TenderEnv"):"1";
           biddingFormService.copyForm(formIds, tenderId,envId,request);
            redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(),"Form copied successfully");
       
           String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
        return retVal;
        
    }
    
    @RequestMapping(value = "/Bid/getFormLibrary/{tenderId}", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView getFormLibrary(@PathVariable("tenderId")Integer tenderId,@RequestParam Map<String,String> allRequestParams,HttpServletRequest request,HttpServletResponse response) throws Exception{  
   
        ModelAndView modelAndView = new ModelAndView("/etender/Bid/FormLibrary");
        
        String formType="";
        String eventId="";
        String formId="";
        String refNo="";
        String formName="";
        String dept="";
        if(checkRequestNull(request, "btn").equalsIgnoreCase("search"))
        {
            formType=checkRequestNull(request, "FormType");
            eventId=checkRequestNull(request, "eventId");
            formId=checkRequestNull(request, "formId");
            refNo=checkRequestNull(request, "refNo");
            formName=checkRequestNull(request, "formName");
            dept=checkRequestNull(request, "dept");
        }
        TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
        List<TblTenderForm> lst=biddingFormService.FormLibrary(formType,eventId,formId,refNo,formName,dept,tblTender);
        
           
        modelAndView.addObject("formList",lst);
        modelAndView.addObject("deptList",biddingFormService.getDepartment());
        modelAndView.addObject("envelopeList",biddingFormService.getEnvelope());
        modelAndView.addObject("formEnvelope",biddingFormService.getFormEnvelope(tenderId));
        modelAndView.addObject("tenderId",tenderId);
        modelAndView.addObject("formType",formType);
        modelAndView.addObject("eventId",eventId);
        modelAndView.addObject("formId",formId);
        modelAndView.addObject("refNo",refNo);
        modelAndView.addObject("formName",formName);
        modelAndView.addObject("dept",dept);
        modelAndView.addObject("isAuction",tblTender.getisAuction());
        return modelAndView;
    }
    
   @RequestMapping(value="/Bid/getPriceSumaryColumn/{tenderId}/{formId}",method=RequestMethod.GET)
    public ModelAndView getPriceSumaryColumn(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,HttpServletRequest request)throws Exception
    {
        ModelAndView modelAndView = new ModelAndView("/etender/Bid/setPriceSummaryColumn");
        Map map=biddingFormService.getDocumentFormDetail(formId);
        Map Columnmap=biddingFormService.getIsGTColumn(formId);
        Map GridMap=biddingFormService.getGridForPriceSummary(formId);
        modelAndView.addObject("FormBean",map);
        modelAndView.addObject("PriceSummaryColumn",Columnmap);
        modelAndView.addObject("GridData", GridMap);
        return modelAndView;
    }
    @RequestMapping(value="/Bid/savePriceSummaryColumn",method={RequestMethod.POST})
    public String savePriceSummaryColumn(HttpServletRequest request, HttpServletResponse response)throws Exception
    {
        Integer formId=Integer.parseInt(request.getParameter("formId"));
        Integer tenderId=Integer.parseInt(request.getParameter("tenderId"));
        biddingFormService.updatePriceSummaryColumn(request);
        String retVal="redirect:/eBid/Bid/getPriceSumaryColumn/"+tenderId+"/"+formId;
       return retVal;
    }

    @RequestMapping(value="/Bid/EditPriceSummaryColumn/{tenderId}/{formId}/{columnId}/{tableId}",method=RequestMethod.GET)
    public ModelAndView EditPriceSummaryColumn(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("tableId")Integer tableId,@PathVariable("columnId")Integer columnId,HttpServletRequest request)throws Exception
    {
        ModelAndView modelAndView = new ModelAndView("/etender/Bid/setPriceSummaryColumn");
        Map map=biddingFormService.getDocumentFormDetail(formId);
        Map Columnmap=biddingFormService.getIsGTColumn(formId);
        Map GridMap=biddingFormService.getGridForPriceSummary(formId);
        modelAndView.addObject("FormBean",map);
        modelAndView.addObject("PriceSummaryColumn",Columnmap);
        modelAndView.addObject("GridData", GridMap);
        modelAndView.addObject("EditColumn",columnId);
        modelAndView.addObject("EditTable",tableId);
        return modelAndView;
    }

    @RequestMapping(value="/Bid/deletePriceSummaryColumn/{tenderId}/{formId}/{tableId}",method=RequestMethod.GET)
    public String deletePriceSummaryColumn(@PathVariable("tenderId")Integer tenderId,@PathVariable("formId")Integer formId,@PathVariable("tableId")Integer tableId,HttpServletRequest request)throws Exception
    {
        biddingFormService.deletePriceSummaryColumnForTable(tableId);
        String retVal="redirect:/eBid/Bid/getPriceSumaryColumn/"+tenderId+"/"+formId;
        return retVal;
    }	

    @RequestMapping(value="/Bid/UpdatePriceSummaryColumn",method={RequestMethod.POST})
    public String UpdatePriceSummaryColumn(HttpServletRequest request,HttpServletResponse response)throws Exception
    {
        Integer formId = Integer.parseInt(request.getParameter("formId"));
        Integer tenderId = Integer.parseInt(request.getParameter("tenderId"));
        Integer columnId = Integer.parseInt(request.getParameter("PriceSummaryColumnId"));
        Integer tableId = Integer.parseInt(request.getParameter("PriceSummaryTableId"));
        biddingFormService.priceSummaryColumnUpdate(tableId, columnId);
        String retVal = "redirect:/eBid/Bid/getPriceSumaryColumn/" + tenderId + "/" + formId;
        return retVal;
    }

     @ResponseBody
    @RequestMapping(value = "/Bid/checkForEnv/{formId}/{envId}", method = RequestMethod.GET ) 
     public String checkForEnv(@PathVariable("formId")Integer formId,@PathVariable("envId")Integer envId,HttpServletRequest request,ModelMap modelMap) throws Exception{
    	   int status=biddingFormService.checkEnvForCopyForm(formId,envId); 
         return status+"";
         
    } 
    
    @ResponseBody
    @RequestMapping(value = "/Bid/removeCellValue/{columnId}", method = RequestMethod.GET ) 
     public String removeCellValue(@PathVariable("columnId")Integer columnId,HttpServletRequest request,ModelMap modelMap) throws Exception{
    	    biddingFormService.removeCellValue(columnId); 
          return "1";
         
    } 
     
/******************************************************************************************************************************/
    /************************************Auction Method Start******************************************************************/
    @RequestMapping(value = "/Bid/createAuction/{tenderId}", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView createAuction(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request, ModelMap modelMap,HttpServletResponse response) throws Exception{  
        ModelAndView modelAndView = new ModelAndView();
         String retVal = "redirect:/sessionexpired";
           retVal = "/eauction/createAuctionForm";
        int indentId = StringUtils.hasLength(request.getParameter("hdIndentId")) ? Integer.parseInt(request.getParameter("hdIndentId")) : 0;
        List<Object[]> indentDataList = null;
        TblDepartment tblOfficerDepartment = null; 
             List<Object[]> tblProcurementNature = tenderCommonService.getProcurementNatureById(0);    
             SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
              List<Object[]> tblOfficerList = tenderCommonService.getOfficerById(0);
                List<Object[]> tblDepartmentList = tenderCommonService.getDepartmentById(0);
            if (sessionBean != null) {
            	Object[] officerDtls = userService.getOfficerDetailsByUserId((int)sessionBean.getUserId());
                /*if (request.getParameter("txtEventType") != null) {
                    eventTypeId = Integer.parseInt(request.getParameter("txtEventType"));
                }*/
                //clientId = 1;
                modelMap.addAttribute("eventName", "ENV");
                //TenderDtBean tenderDtBean;
                if(officerDtls!=null && tenderId==0) {
            		tblOfficerDepartment = userService.getDepartmentById((Integer)officerDtls[6]);
                }
            }
        if(tenderId==0)
        {
           
        try {
                if(tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
                    modelMap.addAttribute("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getGrandParentDeptId(), "0"));
                	modelMap.addAttribute("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
                	modelMap.addAttribute("parentDeptId",tblOfficerDepartment.getParentDeptId());
                    modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",userService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
                }else if(tblOfficerDepartment.getParentDeptId()!=0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
                    modelMap.addAttribute("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
                	modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("parentDeptId",tblOfficerDepartment.getParentDeptId());
                	modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",userService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
                	modelMap.addAttribute("parentDeptName",userService.getDepartmentById(tblOfficerDepartment.getParentDeptId()).getDeptName());
                        modelMap.addAttribute("subDeptName",userService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
                }else if(tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()==0) {
                   modelMap.addAttribute("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getDeptId(), "0"));
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",userService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
                	modelMap.addAttribute("parentDeptId",0);
                        modelMap.addAttribute("subDeptId",0);
                }
                modelMap.addAttribute("officerId",sessionBean.getOfficerId());
                Integer deptId = sessionBean.getGrandParentDeptId();
                if(sessionBean.getIsOrgenizationUser() == 1){
                	deptId = sessionBean.getDeptId();	
                }else if(deptId == 0){
                	deptId = sessionBean.getParentDeptId();
                }
                List<Object[]> tblCurrencyMapList = commonService.getCurrencyMapList(deptId);
                if(tblCurrencyMapList != null){
					Map<Integer,Integer> map = new HashMap<Integer, Integer>();
					for(Object[] obj : tblCurrencyMapList){
						map.put((Integer)obj[0], (Integer)obj[0]); //due to this we can direct check contains
					}
					modelMap.addAttribute("tblCurrencyMapList", map);
				}
                
                modelMap.addAttribute("tblOfficerList",tblOfficerList);
            	modelMap.addAttribute("tblDepartmentList",tblDepartmentList);
                modelMap.addAttribute("officerName",sessionBean.getFullName());
                List<Object[]> tblCurrencyList = commonService.getCurrencyList(0);
                modelMap.addAttribute("tblCurrencyList",tblCurrencyList);
                modelMap.addAttribute("tblProcurementNature",tblProcurementNature);
                modelAndView = new ModelAndView(retVal);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
            }
        }
        if(tenderId!=0)
        {
             TblTender tblTender=new TblTender();
                tblTender.setTenderId(tenderId);
            
    		List<TblTender> list = commonDAO.findEntity(TblTender.class, "tenderId",Operation_enum.EQ,tenderId);
    		tblTender = (TblTender)list.get(0);
                 tblOfficerDepartment = userService.getDepartmentById(tblTender.getDepartmentId());
    		boolean checkpricebid = false;
			List<Object[]> tenderEnvelopeList = tenderCommonService.getEnvelopeTypeByTenderId(tenderId);
			String currencyName = "";
			String envolopeName = "";
			if(tenderEnvelopeList != null && !tenderEnvelopeList.isEmpty()){
				for(Object[] obj : tenderEnvelopeList){
					if("4".equals(obj[2].toString()) || "5".equals(obj[2].toString())){
						checkpricebid = true;
					}
					envolopeName += obj[1].toString()+",";
				}
			}
			//List<Object[]> tenderCurrency= tenderCommonService.getCurrencyList(tblTender.getCurrencyId());
			
			String departmentName = ""; 
                        Integer departmentId=0;
			List<Object[]> tenderDepartment= tenderCommonService.getDepartmentById(tblTender.getDepartmentId());
			if(tenderDepartment != null && !tenderDepartment.isEmpty()){
				for(Object[] obj : tenderDepartment){
					departmentName += obj[1].toString()+",";
                                        departmentId=(Integer)obj[0];
				} 
			}
			String officerName = ""; 
			List<Object[]> tenderOfficer= tenderCommonService.getOfficerById(tblTender.getOfficerId());
			if(tenderOfficer != null && !tenderOfficer.isEmpty()){
				for(Object[] obj : tenderOfficer){
					officerName += obj[1].toString()+",";
				}
			}
                        List<Object[]> tenderCurrency= tenderCommonService.getCurrencyByTenderId(tenderId);
    				
                        modelAndView = new ModelAndView(retVal);
                       
                         List<Object[]> tblCurrencyList = commonService.getCurrencyList(0);
                         modelMap.addAttribute("tenderCurrency", tenderCurrency);
                         Integer deptId = sessionBean.getGrandParentDeptId();
                if(sessionBean.getIsOrgenizationUser() == 1){
                	deptId = sessionBean.getDeptId();	
                }
                List<Object[]> tblCurrencyMapList = commonService.getCurrencyMapList(deptId);
                if(tblCurrencyMapList != null){
					Map<Integer,Integer> map = new HashMap<Integer, Integer>();
					for(Object[] obj : tblCurrencyMapList){
						map.put((Integer)obj[0], (Integer)obj[0]); //due to this we can direct check contains
					}
					modelMap.addAttribute("tblCurrencyMapList", map);
				}
                modelMap.addAttribute("officerName",sessionBean.getFullName());
                        if(tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
                    modelMap.addAttribute("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getGrandParentDeptId(), "0"));
                	modelMap.addAttribute("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
                	modelMap.addAttribute("parentDeptId",tblOfficerDepartment.getParentDeptId());
                    modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",userService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
                }else if(tblOfficerDepartment.getParentDeptId()!=0 && tblOfficerDepartment.getGrandParentDeptId()!=0) {
                    modelMap.addAttribute("subDeptJson",getSubDeptListJson(tblOfficerDepartment.getParentDeptId(), "1"));
                	modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("parentDeptId",tblOfficerDepartment.getParentDeptId());
                	modelMap.addAttribute("subDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",userService.getDepartmentById(tblOfficerDepartment.getGrandParentDeptId()).getDeptName());
                	modelMap.addAttribute("parentDeptName",userService.getDepartmentById(tblOfficerDepartment.getParentDeptId()).getDeptName());
                        modelMap.addAttribute("subDeptName",userService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getGrandParentDeptId());
                }else if(tblOfficerDepartment.getParentDeptId()==0 && tblOfficerDepartment.getGrandParentDeptId()==0) {
                   modelMap.addAttribute("parentDeptJson",getSubDeptListJson(tblOfficerDepartment.getDeptId(), "0"));
                	modelMap.addAttribute("grandParentDeptId",tblOfficerDepartment.getDeptId());
                	modelMap.addAttribute("organization",userService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
                	modelMap.addAttribute("parentDeptId",0);
                        modelMap.addAttribute("subDeptId",0);
                }
                        modelMap.addAttribute("officerId",sessionBean.getOfficerId());
                        modelMap.addAttribute("tblCurrencyList",tblCurrencyList);
                        modelMap.addAttribute("tblProcurementNature",tblProcurementNature);
                        modelAndView.addObject("tblTender", tblTender);
                        modelAndView.addObject("DepartmentName", departmentName);
                        modelAndView.addObject("OfficerName",officerName);
                        modelAndView.addObject("EnveLopeName", envolopeName);
			modelAndView.addObject("Operation", "edit");
                        if(tblOfficerDepartment!=null)
                        {
                            if(tblOfficerDepartment.getDeptId()!=null)
                            {
                                if(userService.getDepartmentById(tblOfficerDepartment.getDeptId())!=null)
                                {
                                    if(userService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName()!=null)
                                    {
                                        modelMap.addAttribute("subDeptName",userService.getDepartmentById(tblOfficerDepartment.getDeptId()).getDeptName());
                                    }
                                }
                            }
                        }
                        modelAndView.addObject("auctionStartDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionStartDate()));
                        modelAndView.addObject("auctionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionEndDate()));
      
        }
        
        return modelAndView;
    }
    private String getSubDeptListJson(int parentDeptId,String deptLevel) {
    	String jsonStr = "";
	    StringBuilder json = new StringBuilder("[");
    	try {
				List<TblDepartment> tblDepartments = userService.getSubDepartments(parentDeptId,deptLevel);
				json.append("{\"value\":\"-1\",\"label\":\"Please select\"}").append(",");
				if(tblDepartments!=null && !tblDepartments.isEmpty()){
					for (TblDepartment tblDepartment : tblDepartments) {
						json.append("{\"value\":\""+tblDepartment.getDeptId()+"\",\"label\":\""+tblDepartment.getDeptName()+"\"}").append(",");
					}
				}
				jsonStr = json.toString().replaceAll(",$", "");
				jsonStr=jsonStr+"]";
			} catch (Exception ex) {
			     exceptionHandlerService.writeLog(ex);
			} finally {
		}
    	return jsonStr;
    }

@RequestMapping(value="/Bid/viewAuction/{tenderId}/{fromPublishTender}",method={RequestMethod.GET})
    public String viewAuction(@PathVariable("tenderId")Integer tenderId,@PathVariable("fromPublishTender")Integer fromPublishTender, ModelMap modelMap,HttpServletRequest request)throws Exception
    {
        
     String retVal = "redirect:/sessionexpired";
   
    	try{
        
        retVal = "/eauction/viewAuction";
        
        TblTender tblTender;
        SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
    	if(tenderId != null && tenderId != 0){
          
    		List<TblTender> list = commonDAO.findEntity(TblTender.class, "tenderId",Operation_enum.EQ,tenderId);
    		tblTender = list.get(0);
    		boolean checkpricebid = false;
			List<Object[]> tenderEnvelopeList = tenderCommonService.getEnvelopeTypeByTenderId(tenderId);
			String currencyName = "";
			String envolopeName = "";
			if(tenderEnvelopeList != null && !tenderEnvelopeList.isEmpty()){
				for(Object[] obj : tenderEnvelopeList){
					if("4".equals(obj[2].toString()) || "5".equals(obj[2].toString())){
						checkpricebid = true;
					}
					envolopeName += obj[1].toString()+",";
				}
			}
			//List<Object[]> tenderCurrency= tenderCommonService.getCurrencyList(tblTender.getCurrencyId());
			
			String departmentName = ""; 
			List<Object[]> tenderDepartment= tenderCommonService.getDepartmentById(tblTender.getDepartmentId());
			if(tenderDepartment != null && !tenderDepartment.isEmpty()){
				for(Object[] obj : tenderDepartment){
					departmentName += obj[1].toString()+",";
				} 
			}
			String officerName = ""; 
			List<Object[]> tenderOfficer= tenderCommonService.getOfficerById(tblTender.getOfficerId());
			if(tenderOfficer != null && !tenderOfficer.isEmpty()){
				for(Object[] obj : tenderOfficer){
					officerName += obj[1].toString()+",";
				}
			}
                        String BaseCurrency="";
                        String BidCurrency="";
                        List<Object[]> tblTenderCurrencys=tenderCommonService.getCurrencyByTenderId(tenderId);
                        if(tblTenderCurrencys != null && !tblTenderCurrencys.isEmpty()){
                            for(Object[] obj : tblTenderCurrencys){
                                if((Integer)obj[2]==1){
                                    BaseCurrency += obj[3].toString()+",";
                                }
                                else
                                {
                                    BidCurrency += obj[3].toString()+",";
                                }
                            }
                        }
                        modelMap.addAttribute("BaseCurrency", BaseCurrency);
                        modelMap.addAttribute("BidCurrency",BidCurrency);
        modelMap.addAttribute("tblTender", tblTender);
        
        modelMap.addAttribute("DepartmentName", departmentName);
        modelMap.addAttribute("OfficerName",officerName);
        modelMap.addAttribute("EnveLopeName", envolopeName);
        modelMap.addAttribute("fromPublishTender",fromPublishTender);
        modelMap.addAttribute("auctionStartDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionStartDate()));
        modelMap.addAttribute("auctionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionEndDate()));
        
        String procurementNature = ""; 
           if(tblTender.getContractTypeId()!=-1)
           {
		List<Object[]> tblProcurementNature= tenderCommonService.getProcurementNatureById(tblTender.getContractTypeId());
		if(tenderOfficer != null && !tblProcurementNature.isEmpty()){
			for(Object[] obj : tblProcurementNature){
                            
				procurementNature += obj[1].toString()+",";
                              
			}
		}
           }	
            
		modelMap.addAttribute("procurementNature",procurementNature);
                
                if(sessionBean != null){
    			modelMap.addAttribute("sessionUserTypeId", sessionBean.getUserTypeId());
    		}else{
    			modelMap.addAttribute("sessionUserTypeId", 2);
    		}
            
    	}
        }catch(Exception e){
    		exceptionHandlerService.writeLog(e);
    	}
        
        return retVal;
    }
    
    @RequestMapping(value="/Bid/addAuction",method={RequestMethod.GET,RequestMethod.POST})
    public String addAuction(HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes)throws Exception
    {
        String operation="";
        if(request.getParameter("opration")!=null)
              {
                  operation=request.getParameter("opration");
              }
              int userDetailId = commonService.getSessionUserId(request);
              TblTender tblTender=new TblTender();
              
               // tblTender.setDepartmentId(request.getParameter("selDepartment")!=null ? Integer.parseInt(request.getParameter("selDepartment")) : 0);
              int subDeptId=request.getParameter("subDept") !=null ? Integer.parseInt(request.getParameter("subDept")) : 0;
              int orgId=request.getParameter("organization") !=null ? Integer.parseInt(request.getParameter("organization")) : 0;
              int deptId=request.getParameter("selDepartment")!=null ? Integer.parseInt(request.getParameter("selDepartment")) : 0;
               if(subDeptId!=0 && orgId!=0)
               {
                   tblTender.setDepartmentId(subDeptId);
               }
               else if(orgId!=0 && deptId!=0 && subDeptId==0)
               {
                   tblTender.setDepartmentId(deptId);
               }
               else if(orgId!=0 && deptId==0 && subDeptId==0)
               {
                   tblTender.setDepartmentId(orgId);
               }
                if(request.getParameter("selDeptOfficial") != null && !"".equals(request.getParameter("selDeptOfficial")))
                {
                    tblTender.setOfficerId(Integer.parseInt(request.getParameter("selDeptOfficial")));
                }
                else
                {
                    tblTender.setOfficerId(0);
                }
              
              tblTender.setTenderNo(request.getParameter("txtAuctionNo"));
              tblTender.setTenderBrief(request.getParameter("txtBriefScope"));
              tblTender.setTenderDetail(request.getParameter("auctiondetails"));
              tblTender.setIsDocfeesApplicable(Integer.parseInt(request.getParameter("optDocFees")));
              if(tblTender.getIsDocfeesApplicable()==1)
              {
                tblTender.setDocumentFee(request.getParameter("txtDocFees"));
                tblTender.setDocFeePaymentAddress(request.getParameter("txtDocFeesPayableAt"));
              }
              else
              {
                tblTender.setDocumentFee("0");
                tblTender.setDocFeePaymentAddress(" ");
              }
              tblTender.setIsParticipationFeesBy(Integer.parseInt(request.getParameter("optPartFees")));
              if(tblTender.getIsParticipationFeesBy()==1)
              {
                tblTender.setParticipationFees(Integer.parseInt(request.getParameter("txtPartFees")));
                tblTender.setparticipationFeesPaymentAddress(request.getParameter("txtParticipationFeesPayableAt"));
              }
              else
              {
                tblTender.setParticipationFees(0);
                tblTender.setparticipationFeesPaymentAddress(" ");
              }
              tblTender.setProductLocation(request.getParameter("txtProductLoc"));
              tblTender.setContractTypeId(Integer.parseInt(request.getParameter("optTypeOfContract")));
              tblTender.setbiddingAccess(Integer.parseInt(request.getParameter("rdoBiddingAccess")));
              tblTender.setauctionMethod(Integer.parseInt(request.getParameter("rdoAuctionMethod")));
              tblTender.setBiddingVariant(Integer.parseInt(request.getParameter("rdoAuctionVariant")));//auction variant
              tblTender.setbidSubmissionfor(1);//for Grand Total
              tblTender.setstartPrice(Integer.parseInt(request.getParameter("txtStartPrice")));
              tblTender.setisReservePriceConfigure(Integer.parseInt(request.getParameter("rdoAddReservePrice")));
              tblTender.setisCreateNewForm(Integer.parseInt(request.getParameter("rdoBiddingForm")));
              if(request.getParameter("optWorkFlowRequire") != null && !request.getParameter("optWorkFlowRequire").equals("-1")){
            	  tblTender.setIsWorkflowRequired(Integer.parseInt(request.getParameter("optWorkFlowRequire")));
              }else{
            	  tblTender.setIsWorkflowRequired(0);
              }
              if(tblTender.getisReservePriceConfigure()==1)
              {
              tblTender.setauctionReservePrice(Integer.parseInt(request.getParameter("txtAuctionRevPrice")));
              }
              else
              {
                tblTender.setauctionReservePrice(0);  
              }
              tblTender.setincrementDecrementValues(Integer.parseInt(request.getParameter("txtIncrementDecrementVal")));
              tblTender.setBiddingType(Integer.parseInt(request.getParameter("rdobiddingType")));//global or domestic 
              if(operation.equals("Edit"))
              {
               tblTender.setTenderId(Integer.parseInt(request.getParameter("tenderId")));
              }
//              tblTender.setAuctionStartDate(ConvertInUTC(convertToDate(request.getParameter("txtAuctionStartDate"))));
//                tblTender.setAuctionEndDate(ConvertInUTC(convertToDate(request.getParameter("txtAuctionEndDate"))));
tblTender.setAuctionStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionStartDate")));
            tblTender.setAuctionEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionEndDate")));
                tblTender.setallowsAutoExtension(Integer.parseInt(request.getParameter("rdoAutoExtension")));
              if(tblTender.getallowsAutoExtension()==1)
              {
                  tblTender.setextendTimeWhen(Integer.parseInt(request.getParameter("txtExtendedTime")));
                  tblTender.setextendTimeBy(Integer.parseInt(request.getParameter("txtExtendedTimeBy")));
              tblTender.setautoExtensionMode(Integer.parseInt(request.getParameter("rdoAutoExtensionMode")));
              if(tblTender.getautoExtensionMode()==1)
              {
                  tblTender.setNoOfExtension(Integer.parseInt(request.getParameter("txtNoOfExtension")));
              }
              else
              {
                  tblTender.setNoOfExtension(0);
              }
              }
              else
              {
                   tblTender.setextendTimeWhen(0);
                  tblTender.setextendTimeBy(0);
              }
              
              tblTender.setDecimalValueUpto(Integer.parseInt(request.getParameter("optDecimalVal")));
              tblTender.setdisplayIPAddress(Integer.parseInt(request.getParameter("optIPAddress")));
              tblTender.setestimatedValue(Float.parseFloat(request.getParameter("txtEstimatedValue")));
              tblTender.setEMDRequired(Integer.parseInt(request.getParameter("optEMDReq")));
              if(tblTender.getEMDRequired()==1)
              {
                  tblTender.setEMDFees(Integer.parseInt(request.getParameter("txtEMDFees")));
                  tblTender.setEmdPaymentAddress(request.getParameter("txtEMDFeesPayableAt"));
              }
              else
              {
                  tblTender.setEMDFees(0);
                  tblTender.setEmdPaymentAddress(" ");
              }
              tblTender.setisAuction(1);
              tblTender.setisAcceptStartPrice(Integer.parseInt(request.getParameter("rdoAcceptStartPrice")));
              //tblTender.setDepartmentId(0);
              tblTender.setAutoResultSharing(Integer.parseInt(request.getParameter("optAutoResultSharing")));
              tblTender.setProcurementNatureId(0);
              tblTender.setEventTypeId(0);
              tblTender.setPOType(0);
              tblTender.setIsCentralizedTECRequired(0);
              tblTender.setIsCentralizedTOCRequired(0);
              tblTender.setAssignUserId(0);
              tblTender.setBrdMode(0);
              tblTender.setCorrigendumCount(0);
              tblTender.setCreatedBy(1);
              tblTender.setCreatedOn(convertToDate(getDate()));
              tblTender.setCreateRfxFromEvent(0);
              tblTender.setCstatus(0);
              tblTender.setDocFeePaymentMode(0);
              tblTender.setDownloadDocument(0);
              tblTender.setEmdPaymentMode(0);
              tblTender.setEncryptionLevel(0);
              tblTender.setEnvelopeType(4);
              tblTender.setEvaluationMode(0);
              tblTender.setForHomePage(0);
              tblTender.setIsBidWithdrawal(0);
              tblTender.setIsCertRequired(0);
              tblTender.setIsConsortiumAllowed(0);
              tblTender.setIsCreateAuction(1);
              tblTender.setIsDemoTender(0);
              tblTender.setIsDisplayClarificationDoc(0);
              tblTender.setIsDocumentFeeByBidder(0);
              tblTender.setIsEMDByBidder(0);
              tblTender.setIsEncDocumentOnly(0);
              tblTender.setIsEncodedName(0);
              tblTender.setIsEvaluationByCommittee(0);
                tblTender.setIsEvaluationRequired(0);
                tblTender.setIsFinalPriceSheetReq(0);
                tblTender.setIsFormConfirmationReq(0);
                tblTender.setIsItemSelectionPageRequired(0);
                tblTender.setIsItemwiseWinner(0);
                tblTender.setIsMandatoryDocument(0);
                tblTender.setIsNegotiationAllowed(0);
                tblTender.setIsOpeningByCommittee(0);
                tblTender.setIsPartialFillingAllowed(0);
                tblTender.setIsPastEvent(0);
                tblTender.setIsPreBidMeeting(0);
                tblTender.setIsProcessingFeeByBidder(0);
                tblTender.setIsProxyBid(0);
                tblTender.setIsQuestionAnswer(0);
                tblTender.setIsRebateForm(0);
                tblTender.setIsRebateApplicable(0);
                tblTender.setIsReEvaluationReq(0);
                tblTender.setIsRegistrationCharges(0);
                tblTender.setIsRevisePriceBid(0);
                tblTender.setIsReworkRequired(0);
                tblTender.setIsSecurityfeesApplicable(0);
                tblTender.setIsSORApplicable(0);
                tblTender.setIsSplitPOAllowed(0);
                tblTender.setIsSystemGeneratedTenderDoc(0);
                tblTender.setIsTwoStageEvaluation(0);
                tblTender.setIsTwoStageOpening(0);
                tblTender.setKeywordText(" ");
                tblTender.setMultiLevelEvaluationReq(0);

tblTender.setPreBidMode(0);
tblTender.setPrevEstimatedValue(BigDecimal.TEN);
tblTender.setRegistrationChargesMode(0);
tblTender.setAutoResultSharing(0);
tblTender.setSecFeePaymentMode(0);
tblTender.setShowBidderWiseForm(0);
tblTender.setShowBidDetail(0);
tblTender.setShowNoOfBidders(0);
tblTender.setShowResultOnHomePage(0);
tblTender.setSubmissionMode(0);
if(tblTender.getbiddingAccess()==1){
    tblTender.setTenderMode(1);
}
else
{
    tblTender.setTenderMode(2);
}
tblTender.setTenderResult(0);
tblTender.setTenderValue(BigDecimal.TEN);
tblTender.setUpdatedBy(1);
tblTender.setUpdatedOn(convertToDate(getDate()));
tblTender.setValidityPeriod("0");
tblTender.setWinningReportMode(0);
tblTender.setWorkflowTypeId(0);
tblTender.setFormContract(0);
tblTender.setIsWeightageEvaluationRequired(0);
tblTender.setWorkflowForBidOpening(0);
tblTender.setWorkflowForNegotiation(0);
tblTender.setDecryptorRequired(0);
//tblTender.setDocFeePaymentAddress(" ");
tblTender.setDocumentSubmission(" ");
tblTender.setKeywordText(" ");
tblTender.setPreBidAddress(" ");
tblTender.setRemark(" ");
tblTender.setSecFeePaymentAddress(" ");
tblTender.setEmdAmount(" ");
//tblTender.setEmdPaymentAddress(" ");
tblTender.setOtherProcurementNature(" ");
tblTender.setRegistrationCharges(" ");
tblTender.setSecurityFee(" ");
//tblTender.setPrequalification(" ");
tblTender.setDocumentEndDate(convertToDate(getDate()));
tblTender.setDocumentStartDate(convertToDate(getDate()));
tblTender.setOpeningDate(convertToDate(getDate()));
tblTender.setPreBidEndDate(convertToDate(getDate()));
tblTender.setPreBidStartDate(convertToDate(getDate()));
tblTender.setProjectDuration(" ");
tblTender.setPublishedBy(0);
tblTender.setPublishedOn(convertToDate(getDate()));
tblTender.setQuestionAnswerEndDate(convertToDate(getDate()));
tblTender.setQuestionAnswerStartDate(convertToDate(getDate()));
tblTender.setSorVariation(BigDecimal.ZERO);

tblTender.setSubmissionEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionStartDate")));
tblTender.setSubmissionStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionEndDate")));
tblTender.setWorkflowForTOC(0);
tblTender.setWorkflowForTEC(0);
tblTender.setCreatedBy(userDetailId);
tblTender.setCreatedOn(convertToDate(getDate()));
tblTender.setRandPass("This is a Key");
              tblTender.setCurrencyId(Integer.parseInt(request.getParameter("optBaseCurrency")));
              
              TblCurrency tblCurrency = new TblCurrency();
              tblCurrency.setCurrencyId(tblTender.getCurrencyId());
              TblTenderCurrency tblTenderCurrency = new TblTenderCurrency();
              tblTenderCurrency.setTblTender(tblTender);
              tblTenderCurrency.setIsDefault(1);
              tblTenderCurrency.setIsActive(1);
              tblTenderCurrency.setExchangeRate(BigDecimal.ONE);
              tblTenderCurrency.setTblCurrency(new TblCurrency(tblTender.getCurrencyId()));
              List<TblTenderCurrency> lstTblTenderCurrency=new ArrayList<TblTenderCurrency>();
              String currencyArr[]=null;
              if(request.getParameterValues("chkBidCurrency") != null){
            	  currencyArr=new String[request.getParameterValues("chkBidCurrency").length];
                  currencyArr=request.getParameterValues("chkBidCurrency");
              }
              if(currencyArr != null && tblTender.getBiddingType()==2){
                  for(int i=0;i<currencyArr.length;i++){
                      if(Integer.parseInt(currencyArr[i])!=tblTender.getCurrencyId()){
                            TblTenderCurrency tblTenderCurrency1=new TblTenderCurrency();
                            tblTenderCurrency1.setTblTender(tblTender);
                            tblTenderCurrency1.setIsDefault(0);
                            tblTenderCurrency1.setTblCurrency(new TblCurrency(Integer.parseInt(currencyArr[i])));
                            tblTenderCurrency1.setExchangeRate(new BigDecimal(Float.parseFloat(request.getParameter("txtExchangeRate_"+currencyArr[i]))));
                            tblTenderCurrency1.setIsActive(1);
                            lstTblTenderCurrency.add(tblTenderCurrency1);
                      }
                  }
              }
              System.out.println("Tender Currency List::"+lstTblTenderCurrency.toString());
              
                            TblTenderEnvelope tblTenderEnvelope = new TblTenderEnvelope();
                            tblTenderEnvelope.setEnvelopeName(tenderCommonService.getEnvelopeNameById(tblTender.getEnvelopeType()));
                            tblTenderEnvelope.setTblTender(tblTender);
                            TblEnvelope tblEnvelope = new TblEnvelope();
                            tblEnvelope.setEnvId(tblTender.getEnvelopeType());
                            if (tblTender.getEnvelopeType() == 2) {
                                tblTenderEnvelope.setOpeningDate(tblTender.getAuctionStartDate());
                            }
                            tblTenderEnvelope.setSortOrder(1);
                            tblTenderEnvelope.setNoOfFormsReq(0);
                            tblTenderEnvelope.setMinOpeningMember(0);
                            tblTenderEnvelope.setMinEvaluator(0);
                            tblTenderEnvelope.setIsOpened(0);
                            tblTenderEnvelope.setIsEvaluated(0);
                            tblTenderEnvelope.setCreatedBy(userDetailId);
                            tblTenderEnvelope.setCreatedOn(commonService.getServerDateTime());
                            tblTenderEnvelope.setCstatus(1);
                            tblTenderEnvelope.setTblEnvelope(tblEnvelope);
                            tblTenderEnvelope.setRemark("");
                            tblTenderEnvelope.setEnvelopeId(null);
              if(operation.equals("Edit"))
              {
                  biddingFormService.deletTenderCurrency(tblTender);
              }             
              tblTender=biddingFormService.InsretAuction(tblTender,tblTenderEnvelope,operation,tblTenderCurrency,lstTblTenderCurrency);
              String retVal = "redirect:/etender/buyer/tenderDashboard/"+tblTender.getTenderId();
             
              if(operation.equals("Edit"))
              {
                redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Auction Updated Successfully ");
              }
               else
               {
                //   retVal = "redirect:/etender/buyer/tendernitdocument/"+tblTender.getTenderId()+"/0";
                redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "Auction Created Successfully ");
               }
              return retVal;
    }
    /*auctionListing start*/
    @RequestMapping(value = "/Bid/auctionListing", method = RequestMethod.GET)
    public ModelAndView auctionListing(HttpServletRequest request) {
        String retVal = "/eauction/auctionListing";
        ModelAndView modelAndView = new ModelAndView(retVal);
        Map<String,Object> auctionCount = biddingFormService.getAuctionCount();
        modelAndView.addObject("auctionCount", auctionCount);
        return modelAndView;
    }
    @RequestMapping(value="/Bid/viewAuctionResult/{tenderId}",method=RequestMethod.GET)
    public ModelAndView viewAuctionResult(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request)throws Exception
    {
        String retval="eauction/stopResumeAuction";
        ModelAndView modelAndView=new ModelAndView(retval);
        TblTender tblTender;
        List<TblTender> list = commonDAO.findEntity(TblTender.class, "tenderId",Operation_enum.EQ,tenderId);
    	tblTender = list.get(0);
        boolean checkpricebid = false;
			List<Object[]> tenderEnvelopeList = tenderCommonService.getEnvelopeTypeByTenderId(tenderId);
			String currencyName = "";
			String envolopeName = "";
			if(tenderEnvelopeList != null && !tenderEnvelopeList.isEmpty()){
				for(Object[] obj : tenderEnvelopeList){
					if("4".equals(obj[2].toString()) || "5".equals(obj[2].toString())){
						checkpricebid = true;
					}
					envolopeName += obj[1].toString()+",";
				}
			}
			//List<Object[]> tenderCurrency= tenderCommonService.getCurrencyList(tblTender.getCurrencyId());
			
			String departmentName = ""; 
			List<Object[]> tenderDepartment= tenderCommonService.getDepartmentById(tblTender.getDepartmentId());
			if(tenderDepartment != null && !tenderDepartment.isEmpty()){
				for(Object[] obj : tenderDepartment){
					departmentName += obj[1].toString()+",";
				} 
			}
			String officerName = ""; 
			List<Object[]> tenderOfficer= tenderCommonService.getOfficerById(tblTender.getOfficerId());
			if(tenderOfficer != null && !tenderOfficer.isEmpty()){
				for(Object[] obj : tenderOfficer){
					officerName += obj[1].toString()+",";
				}
			}
                        modelAndView.addObject("tblTender", tblTender);
                        modelAndView.addObject("DepartmentName", departmentName);
                        modelAndView.addObject("OfficerName",officerName);
                        modelAndView.addObject("EnveLopeName", envolopeName);
                        modelAndView.addObject("auctionStartDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionStartDate()));
                        modelAndView.addObject("auctionEndDate", commonService.convertSqlToClientDate(client_dateformate_hhmm,tblTender.getAuctionEndDate()));
                        modelAndView.addObject("client_dateformate_hhmm",client_dateformate_hhmm);
			//modelAndView.addObject("fromPublishTender",fromPublishTender);
       // modelAndView.addObject("tblTender", tblTender);
        return modelAndView;
    }
    
    @RequestMapping(value="/Bid/stopResumeAuction",method=RequestMethod.POST)
    public String stopResumeAuction(HttpServletRequest request,HttpServletResponse response)throws Exception
    {
        Integer isAuctionStop=Integer.parseInt(request.getParameter("isAuctionStop"));
        
        Integer tenderId=Integer.parseInt(request.getParameter("tendreId"));
        TblAuctionStopResume tblAuctionStopResume=new TblAuctionStopResume();
        TblTender tblTender=new TblTender();
        tblTender=tenderCommonService.getTenderById(tenderId);
        tblTender.setTenderId(tenderId);
        tblTender.setIsAuctionStop(isAuctionStop);
        tblAuctionStopResume.setTblTender(tblTender);
        tblAuctionStopResume.setcreatedby(1);
        tblAuctionStopResume.setcreatedon(commonService.getServerDateTime());
        tblAuctionStopResume.setremark(request.getParameter("auctionstopremark"));
        if(isAuctionStop==0)
        {
            tblAuctionStopResume.setauctionstartdate(commonService.getServerDateTime());
            tblAuctionStopResume.setauctionenddate(commonService.convertStirngToUTCDate(client_dateformate_hhmm, request.getParameter("auctionEndDate")));
            tblAuctionStopResume.setstatus(1);
        }
        else
        {
            tblAuctionStopResume.setstatus(0);
            TblAuctionStopResume tblAuctionStop=biddingFormService.getLastAuctionStopId(tenderId);
            tblAuctionStop.setauctionenddate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionStartDate")));
            biddingFormService.updateLastAuctionStopEndDate(tblAuctionStop);
            tblAuctionStopResume.setauctionstartdate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionStartDate")));
            tblAuctionStopResume.setauctionenddate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionEndDate")));
            tblTender.setAuctionStartDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionStartDate")));
            tblTender.setAuctionEndDate(commonService.convertStirngToUTCDate(client_dateformate_hhmm,request.getParameter("txtAuctionEndDate")));
        }
       
        
        biddingFormService.addAuctionStopResume(tblAuctionStopResume);
        biddingFormService.StopAuction(tblTender);
        String retVal = "redirect:/etender/buyer/tenderDashboard/"+tenderId;
        return retVal;
    }
    
    @RequestMapping(value="/Bid/viewResult/{tenderId}",method=RequestMethod.GET)
    public ModelAndView viewAuctionResult(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request,HttpServletResponse response)throws Exception
    {
        String retVal="/eauction/viewResult";
        ModelAndView modelAndView=new ModelAndView(retVal);
        TblTender tblTender=tenderCommonService.getTenderById(tenderId);
        modelAndView.addObject("tblTender", tblTender);
        modelAndView.addObject("bidLst",biddingFormService.getBidsByTenderId(tblTender));
        return modelAndView;
    }

    public Date convertToDate(String str)throws Exception
     {
         DateFormat dateFormat;
         Date date;
         dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm",Locale.ENGLISH);
         date=dateFormat.parse(str);
         return date;
     }
    public Date convertToDate1(String str)throws Exception
     {
         DateFormat dateFormat;
         Date date;
         dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm",Locale.ENGLISH);
         date=dateFormat.parse(str);
         return date;
     }
     public  String getDate()throws Exception
    {
         DateFormat dateFormat;
         Date date;
        dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        date = new Date();
       // Date dt=dateFormat.parse(dateFormat.format(date));
        return dateFormat.format(date);
    }
     
    @ResponseBody
    @RequestMapping(value="/Bid/validateBiddingTime/{tenderId}",method={RequestMethod.GET})
    public String validateBiddingTime(@PathVariable("tenderId")Integer tenderId,HttpServletRequest request,ModelMap modelMap,HttpServletResponse response)throws Exception{
        String res="false";
        TblTender tblTender=tenderCommonService.getTenderById(tenderId);
        if(tblTender.getAuctionEndDate() != null && tblTender.getAuctionEndDate().before(commonService.getServerDateTime()))
        {
            res="false";
        }
        else
        {
            res="true";
        }
        response.setContentType("application/text");
        response.setHeader("Cache-Control", "no-store");
        return res;
    }
    public Date CurrentDateInUTC() throws Exception
    {
       /* SimpleDateFormat lv_formatter = new SimpleDateFormat(); 
        lv_formatter.setTimeZone(TimeZone.getTimeZone("UTC"));  
        Date dt=new Date(lv_formatter.format(new Date()));
        return dt;*/
    	return commonService.getServerDateTime();
    }
    public Date ConvertInUTC(Date dt)throws Exception
    {
       /* SimpleDateFormat lv_formatter = new SimpleDateFormat(); 
        lv_formatter.setTimeZone(TimeZone.getTimeZone("UTC"));  
        Date dt1=new Date(lv_formatter.format(dt));
        return dt1;*/
	    return commonService.convertDateToUTCDate(dt);
    }
    /************************************Auction Method End********************************************************************/
/******************************************************************************************************************************/
 

}
