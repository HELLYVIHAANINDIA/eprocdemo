
package com.eprocurement.etender.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.common.utility.SessionBean;
import com.eprocurement.etender.model.TblPurchaseorder;
import com.eprocurement.etender.services.ClarificationService;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.OfficerService;
import com.eprocurement.etender.services.QuotationService;
import com.eprocurement.etender.services.ReportService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;

@Controller
@RequestMapping("/etender")
public class QuotationController {

    @Autowired
    private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private TenderService tenderFormService;
    @Autowired
    private QuotationService poService;
    @Autowired
    private FormService biddingFormService;
    @Autowired
    private CommonService commonService; 
    @Autowired
    private OfficerService userService;
    @Autowired
    private ReportService reportService;
    @Value("#{projectProperties['purchaseOrderObjectId']}")
    private Integer purchaseOrderObjectId;
    @Value("#{etenderProperties['client_dateformate_hhmm']}")
    private String client_dateformate_hhmm;
	@Value("#{etenderProperties['sql_dateformate']}")
    private String sql_dateformate;
	@Value("#{projectProperties['mail.from']}")
    private String mailFrom;
	@Autowired
    private ClarificationService seekClarificationService;
	
	
    
    
    @RequestMapping(value = "/buyer/getcreatepurchaseorder/{tenderId}/{bidderIdRowId}", method = RequestMethod.GET)
    public String getcreatepruchaseorder(@PathVariable("tenderId") int tenderId,@PathVariable("bidderIdRowId") String bidderIdRowId, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            int itemRow = Integer.parseInt(bidderIdRowId.split("_")[2]);
            int tableId = Integer.parseInt(bidderIdRowId.split("_")[1]);
            int bidderId = Integer.parseInt(bidderIdRowId.split("_")[0]);
            Object[] bidderDtls = userService.getBiddderDetails(bidderId);
            boolean isItemWise = false;
            if(bidderDtls!=null) {
            	modelMap.addAttribute("bidderName", bidderDtls[1].toString());
            	modelMap.addAttribute("companyName", bidderDtls[2].toString());
            	
            }
            if(itemRow!=-1 && tableId!=-1 && bidderId !=-1){
            	isItemWise= true;
	            List<Object[]> itemDtls = reportService.getItemDetailsForPO(tenderId, tableId, itemRow);
	            if(itemDtls!=null && !itemDtls.isEmpty()){
	            	modelMap.addAttribute("ItemName", itemDtls.get(0)[1]);
	            }
            }
            modelMap.addAttribute("department",tenderCommonService.getDeptNameByTenderId(tenderId));
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("deptId", 1);
            modelMap.addAttribute("isItemWise", isItemWise);
            modelMap.addAttribute("objectId", purchaseOrderObjectId);
            modelMap.addAttribute("childId", bidderId);
            modelMap.addAttribute("subChildId", 0);
            modelMap.addAttribute("rowId",itemRow);
            modelMap.addAttribute("tableId",tableId);
            modelMap.addAttribute("otherSubChildId", 0);
            
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/CreatePurchaseOrder";
    }
    
    
    @RequestMapping(value = "/buyer/addpurchaseorder", method = RequestMethod.POST)
    public String addpurchaseorder( HttpServletRequest request, ModelMap modelMap,final RedirectAttributes redirectAttributes) {
    	StringBuilder redirect = new StringBuilder("");	
    	SessionBean sessionBean = (SessionBean) request.getSession().getAttribute("sessionObject");
    	if(sessionBean!=null){
        try {
        	int hdRowId = StringUtils.hasLength(request.getParameter("hdRowId")) ? Integer.parseInt(request.getParameter("hdRowId")) : 0;
        	int hdTableId = StringUtils.hasLength(request.getParameter("hdTableId")) ? Integer.parseInt(request.getParameter("hdTableId")) : 0;
        	String optType = StringUtils.hasLength(request.getParameter("optType")) ? request.getParameter("optType"): "";
        	String hdItemName = StringUtils.hasLength(request.getParameter("hdItemName")) ? request.getParameter("hdItemName"): "";
        	
        	String txtPoNum = StringUtils.hasLength(request.getParameter("txtPoNum")) ? request.getParameter("txtPoNum"): "";
        	int tenderId = StringUtils.hasLength(request.getParameter("tenderId")) ? Integer.parseInt(request.getParameter("tenderId")): 0;
        	int deptId = StringUtils.hasLength(request.getParameter("hdDeptId")) ? Integer.parseInt(request.getParameter("hdDeptId")): 0;
        	int bidderId = StringUtils.hasLength(request.getParameter("hdBidderId")) ? Integer.parseInt(request.getParameter("hdBidderId")): 0;
        	int poId = StringUtils.hasLength(request.getParameter("hdPoId")) ? Integer.parseInt(request.getParameter("hdPoId")): 0;
        	String txtBidderRef = StringUtils.hasLength(request.getParameter("txtBidderRef")) ? request.getParameter("txtBidderRef"): "";
        	String txtaBrifDetail = StringUtils.hasLength(request.getParameter("txtaBrifDetail")) ? request.getParameter("txtaBrifDetail"): "";
        	String txtaProjectDetail = StringUtils.hasLength(request.getParameter("txtaProjectDetail")) ? request.getParameter("txtaProjectDetail"): "";
        	String txtaConsigneeDetails = StringUtils.hasLength(request.getParameter("txtaConsigneeDetails")) ? request.getParameter("txtaConsigneeDetails"): "";
        	String txtDeliverySchedule = StringUtils.hasLength(request.getParameter("txtDeliverySchedule")) ? request.getParameter("txtDeliverySchedule"): "";
        	String txtaModeOfTransport = StringUtils.hasLength(request.getParameter("txtaModeOfTransport")) ? request.getParameter("txtaModeOfTransport"): "";
        	String txtaInspection = StringUtils.hasLength(request.getParameter("txtaInspection")) ? request.getParameter("txtaInspection"): "";
        	int txtContractValue = StringUtils.hasLength(request.getParameter("txtContractValue")) ? Integer.parseInt(request.getParameter("txtContractValue")): 0;
        	String txtPerformanceBank = StringUtils.hasLength(request.getParameter("txtPerformanceBank")) ? request.getParameter("txtPerformanceBank"): "";
        	String txtaPaymentDetail = StringUtils.hasLength(request.getParameter("txtaPaymentDetail")) ? request.getParameter("txtaPaymentDetail"): "";
        	String txtPayingAuthority = StringUtils.hasLength(request.getParameter("txtPayingAuthority")) ? request.getParameter("txtPayingAuthority"): "";
        	String txtaTechnicalSpecification = StringUtils.hasLength(request.getParameter("txtaTechnicalSpecification")) ? request.getParameter("txtaTechnicalSpecification"): "";
        	String txtaPoTermsAndCond = StringUtils.hasLength(request.getParameter("txtaPoTermsAndCond")) ? request.getParameter("txtaPoTermsAndCond"): "";
        	TblPurchaseorder purchaseorder = null;	
        	if(optType.equals("edit")) {
        		purchaseorder = poService.getPurchaseOrderById(poId);
        	}else {
        		purchaseorder = new TblPurchaseorder();
        		purchaseorder.setBidderid(bidderId);
        		purchaseorder.setTenderId(tenderId);
        	}
        	
        	purchaseorder.setItemDesc(hdItemName);
        	purchaseorder.setBidderref(txtBidderRef);
        	purchaseorder.setDeptid(sessionBean.getDeptId());
        	purchaseorder.setBrifdetail(txtaBrifDetail);
        	purchaseorder.setConsigneedetails(txtaConsigneeDetails);
        	purchaseorder.setContractvalue(txtContractValue);
        	purchaseorder.setDeliveryschedule(txtDeliverySchedule);
        	purchaseorder.setInspection(txtaInspection);
        	purchaseorder.setModeoftransport(txtaModeOfTransport);
        	purchaseorder.setPayingauthority(txtPayingAuthority);
        	purchaseorder.setPaymentdetail(txtaPaymentDetail);
        	purchaseorder.setPerformancebank(txtPerformanceBank);
        	purchaseorder.setPoamount(0);
        	purchaseorder.setPonumber(txtPoNum);
        	purchaseorder.setProjectdetail(txtaProjectDetail);
        	purchaseorder.setProjectestimation("");
        	purchaseorder.setPotermsandcond(txtaPoTermsAndCond);
        	purchaseorder.setCreatedOn(commonService.getServerDateTime());
        	purchaseorder.setTechnicalspecification(txtaTechnicalSpecification);
        	purchaseorder.setRowId(hdRowId);
        	purchaseorder.setTableId(hdTableId);
        	if(optType.equals("edit")) {
        		poService.addPurchaseOrder(purchaseorder,"edit");
        		redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_po_update_successfully");
        	}else {
        		poService.addPurchaseOrder(purchaseorder,"new");
        		redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_po_create_successfully");
        	}
        	redirect.append("redirect:/etender/buyer/getpurchaseorderdashboard/").append(tenderId).append("/").append(purchaseorder.getPoid());
        
        
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
    	}
        return redirect.toString();
    }
    
    
    @RequestMapping(value = "/buyer/getpurchaseorderdashboard/{tenderId}/{poId}", method = RequestMethod.GET)
    public String podashboard(@PathVariable("tenderId") int tenderId,@PathVariable("poId") int poId, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            TblPurchaseorder  purchaseorder = poService.getPurchaseOrderById(poId);
            Object[] bidderDtls = userService.getBiddderDetails(purchaseorder.getBidderid());
            if(bidderDtls!=null) {
            	modelMap.addAttribute("bidderName", bidderDtls[1].toString());
            	modelMap.addAttribute("companyName", bidderDtls[2].toString());
            	modelMap.addAttribute("bidderEmail", bidderDtls[0].toString());
            	modelMap.addAttribute("bidderPhone", bidderDtls[5].toString());
            }
            modelMap.addAttribute("department",tenderCommonService.getDeptNameByTenderId(tenderId));
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("purchaseorder", purchaseorder);
            modelMap.addAttribute("objectId", purchaseOrderObjectId);
            modelMap.addAttribute("createdOn",commonService.convertSqlToClientDate(client_dateformate_hhmm, purchaseorder.getCreatedOn()));
            modelMap.addAttribute("childId", poId);
            modelMap.addAttribute("subChildId", 0);
            modelMap.addAttribute("otherSubChildId", 0);
            modelMap.addAttribute("bidderId", purchaseorder.getBidderid());
            
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/PODashboard";
    }
    
    
    @RequestMapping(value = "/bidder/getpurchaseorderdashboardbidder/{tenderId}", method = RequestMethod.GET)
    public String podashboardBidder(@PathVariable("tenderId") int tenderId, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            modelMap.addAttribute("department",tenderCommonService.getDeptNameByTenderId(tenderId));
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("objectId", purchaseOrderObjectId);
            modelMap.addAttribute("subChildId", 0);
            modelMap.addAttribute("otherSubChildId", 0);
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/bidder/PODashboardBidder";
    }
    
    
    @RequestMapping(value = "/buyer/uploadpurchaseorderdoc/{tenderId}/{poId}", method = RequestMethod.GET)
    public String uploadpurchasedoc(@PathVariable("tenderId") int tenderId,@PathVariable("poId") int poId, HttpServletRequest request, ModelMap modelMap) {
        try {
            TblPurchaseorder purchaseorder = poService.getPurchaseOrderById(poId); 				
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("purchaseorder", purchaseorder);
            modelMap.addAttribute("objectId", purchaseOrderObjectId);
            modelMap.addAttribute("childId", poId);
            modelMap.addAttribute("subChildId", 0);
            modelMap.addAttribute("otherSubChildId", 0);
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/PODocuments";
    }
    
    
    @RequestMapping(value = "/buyer/geteditpurchaseorder/{tenderId}/{bidderId}/{poId}", method = RequestMethod.GET)
    public String getcreatepruchaseorder(@PathVariable("tenderId") int tenderId,@PathVariable("bidderId") int bidderId,@PathVariable("poId") int poId, HttpServletRequest request, ModelMap modelMap) {
        try {
        	    boolean isItemWise = false;
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            TblPurchaseorder purchaseorder = poService.getPurchaseOrderById(poId); 
            Object[] bidderDtls = userService.getBiddderDetails(bidderId);
            if(bidderDtls!=null) {
            	modelMap.addAttribute("bidderName", bidderDtls[1].toString());
            	modelMap.addAttribute("companyName", bidderDtls[2].toString());
            }
            modelMap.addAttribute("department",tenderCommonService.getDeptNameByTenderId(tenderId));
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("purchaseorder", purchaseorder);
            modelMap.addAttribute("objectId", purchaseOrderObjectId);
            modelMap.addAttribute("childId", bidderId);
            modelMap.addAttribute("subChildId", 0);
            modelMap.addAttribute("otherSubChildId", 0);
            modelMap.addAttribute("rowId",purchaseorder.getRowId());
            modelMap.addAttribute("tableId",purchaseorder.getTableId());
            modelMap.addAttribute("optType", "edit");
            
            
            if(purchaseorder.getRowId()!=-1 && purchaseorder.getTableId()!=-1){
            	isItemWise= true;
	            List<Object[]> itemDtls = reportService.getItemDetailsForPO(tenderId, purchaseorder.getTableId(), purchaseorder.getRowId());
	            if(itemDtls!=null && !itemDtls.isEmpty()){
	            	modelMap.addAttribute("ItemName", itemDtls.get(0)[1]);
	            }
            }
            modelMap.addAttribute("isItemWise", isItemWise);
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/CreatePurchaseOrder";
    }
    
    
    @RequestMapping(value = "/buyer/managepurchaseorder", method = RequestMethod.GET)
    public String managepurchaseorder(HttpServletRequest request, ModelMap modelMap) {
        try {
            
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/ManagePurchaseOrder";
    }
    
    @RequestMapping(value = "/buyer/publishpurchaseorder/{tenderId}/{bidderId}/{poId}", method = RequestMethod.GET)
    public String publishpurchaseorder(@PathVariable("tenderId") int tenderId,@PathVariable("bidderId") int bidderId,@PathVariable("poId") int poId,HttpServletRequest request, ModelMap modelMap,final RedirectAttributes redirectAttributes) {
        try {
            Object[] bidderDtls = userService.getBiddderDetails(bidderId);
            poService.publishPurchaseorder(poId);
            String bidderEmailId = "";
            if(bidderDtls!=null){
            	bidderEmailId=bidderDtls[0].toString();
            }
            try {
               String contentForBidder = "Dear User,This is to inform you that purchase order is issued to you for the following Tender:"+tenderId;
               String subject = " Purchase Order is issued for Tender ID:"+tenderId;
               userService.addMail(userService.setTblMailMessage(bidderEmailId,mailFrom, subject,contentForBidder,"Purchase order"));
            }catch (Exception e) {
            	exceptionHandlerService.writeLog(e);
            }
            
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_po_published_successfully");
        return "redirect:/etender/buyer/getpurchaseorderdashboard/"+tenderId+"/"+poId;
    }
    
    
    @RequestMapping(value = "/buyer/cancelpurchaseorder/{tenderId}/{bidderId}/{poId}", method = RequestMethod.GET)
    public String cancelpurchaseorder(@PathVariable("tenderId") int tenderId,@PathVariable("bidderId") int bidderId,@PathVariable("poId") int poId,HttpServletRequest request, ModelMap modelMap,final RedirectAttributes redirectAttributes) {
        try {
            Object[] bidderDtls = userService.getBiddderDetails(bidderId);
            poService.cancelPurchaseorder(poId);
            String bidderEmailId = "";
            if(bidderDtls!=null){
            	bidderEmailId=bidderDtls[0].toString();
            }
            try {
               String contentForBidder = "Dear User,This is to inform you that purchase order is cancelled for the following Tender:"+tenderId;
               String subject = " Purchase Order is cancelled for Tender ID:"+tenderId;
               userService.addMail(userService.setTblMailMessage(bidderEmailId,mailFrom, subject,contentForBidder,"Purchase order"));
            }catch (Exception e) {
            	exceptionHandlerService.writeLog(e);
            }
            
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        }
        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_po_cancel_successfully");
        return "redirect:/etender/buyer/getpurchaseorderdashboard/"+tenderId+"/"+poId;
    }
    
    
    
    @RequestMapping(value = "/buyer/viewpurchaseorder/{tenderId}/{bidderId}/{poId}", method = RequestMethod.GET)
    public String viewpruchaseorder(@PathVariable("tenderId") int tenderId,@PathVariable("bidderId") int bidderId,@PathVariable("poId") int poId, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            TblPurchaseorder purchaseorder = poService.getPurchaseOrderById(poId); 
            Object[] bidderDtls = userService.getBiddderDetails(bidderId);
            if(bidderDtls!=null) {
            	modelMap.addAttribute("bidderName", bidderDtls[1].toString());
            }
            modelMap.addAttribute("department",tenderCommonService.getDeptNameByTenderId(tenderId));
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("purchaseorder", purchaseorder);
            modelMap.addAttribute("objectId", purchaseOrderObjectId);
            modelMap.addAttribute("childId", bidderId);
            modelMap.addAttribute("subChildId", 0);
            modelMap.addAttribute("otherSubChildId", 0);
            modelMap.addAttribute("optType", "");
            
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/ViewPurchaseOrder";
    }
    
    
    @RequestMapping(value = "/bidder/getacknowledge/{tenderId}/{bidderId}/{poId}", method = RequestMethod.GET)
    public String getacknowledge(@PathVariable("tenderId") int tenderId,@PathVariable("bidderId") int bidderId,@PathVariable("poId") int poId, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            TblPurchaseorder purchaseorder = poService.getPurchaseOrderById(poId); 
            Object[] bidderDtls = userService.getBiddderDetails(bidderId);
            if(bidderDtls!=null) {
            	modelMap.addAttribute("bidderName", bidderDtls[1].toString());
            	modelMap.addAttribute("companyName", bidderDtls[2].toString());
            }
            modelMap.addAttribute("department",tenderCommonService.getDeptNameByTenderId(tenderId));
            modelMap.addAttribute("tenderId", tenderId);
            modelMap.addAttribute("purchaseorder", purchaseorder);
            modelMap.addAttribute("objectId", purchaseOrderObjectId);
            modelMap.addAttribute("childId", poId);
            modelMap.addAttribute("subChildId", 0);
            modelMap.addAttribute("otherSubChildId", 0);
            modelMap.addAttribute("optType", "acknowledge");
            modelMap.addAttribute("bidderIsApproved", 1);
            modelMap.addAttribute("bidderId", bidderId);
            
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/ViewPurchaseOrder";
    }
    
    @RequestMapping(value = "/bidder/acknowledgepurchaseorder", method = RequestMethod.POST)
    public String acknowledgepurchaseorder( HttpServletRequest request, ModelMap modelMap) {
    	StringBuilder redirect = new StringBuilder("");	
        try {
        	String optType = StringUtils.hasLength(request.getParameter("optType")) ? request.getParameter("optType"): "";
        	String remarks = StringUtils.hasLength(request.getParameter("remarks")) ? request.getParameter("remarks"): "";
        	int poId = StringUtils.hasLength(request.getParameter("hdPoId")) ? Integer.parseInt(request.getParameter("hdPoId")): 0;
        	int ackstatus = StringUtils.hasLength(request.getParameter("ackstatus")) ? Integer.parseInt(request.getParameter("ackstatus")): 0;
        	int tenderId = StringUtils.hasLength(request.getParameter("tenderId")) ? Integer.parseInt(request.getParameter("tenderId")): 0;
        	String hdCompanyName = StringUtils.hasLength(request.getParameter("hdCompanyName")) ? request.getParameter("hdCompanyName"): "";
        	int bidderId = StringUtils.hasLength(request.getParameter("bidderId")) ? Integer.parseInt(request.getParameter("bidderId")): 0;
        	String bidderEmailId = "";
        	Object[] bidderDtls = userService.getBiddderDetails(bidderId);
        	poService.acknowledgePurchaseOrder(poId, remarks,ackstatus);
        	if(bidderDtls!=null){
        		bidderEmailId=bidderDtls[0].toString();
        	}
        	Set<String> officerList = seekClarificationService.getTECofficerEmailIds(tenderId);
        	for (String emailId : officerList) {
        		try {
                    String contentForBidder = "Issued Purchase order is acknowledged by the "+hdCompanyName+" for the following Tender: "+tenderId;
                    String subject = " Purchase Order is acknowledge by "+hdCompanyName+" for Tender ID:"+tenderId;
                    userService.addMail(userService.setTblMailMessage(emailId,mailFrom, subject,contentForBidder,"Purchase order"));
                 }catch (Exception e) {
                	 e.printStackTrace();	
                 }
			}
        	redirect.append("redirect:/etender/bidder/biddingTenderDashboard/").append(tenderId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	
        }
        return redirect.toString();
    }
    
    
    
    
    
}
