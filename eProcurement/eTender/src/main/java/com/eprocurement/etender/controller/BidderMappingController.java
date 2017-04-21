
package com.eprocurement.etender.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eprocurement.common.services.CommonService;
import com.eprocurement.common.services.ExceptionHandlerService;
import com.eprocurement.common.utility.CommonKeywords;
import com.eprocurement.etender.databean.TenderMapBidderDataBean;
import com.eprocurement.etender.model.TblBidder;
import com.eprocurement.etender.model.TblTender;
import com.eprocurement.etender.model.TblTenderBidderMap;
import com.eprocurement.etender.model.TblUserLogin;
import com.eprocurement.etender.services.BidderMappingService;
import com.eprocurement.etender.services.FormService;
import com.eprocurement.etender.services.TenderCommonService;
import com.eprocurement.etender.services.TenderService;

@Controller
@RequestMapping("/etender")
public class BidderMappingController {

    @Autowired
    private ExceptionHandlerService exceptionHandlerService;
    @Autowired
    private TenderCommonService tenderCommonService;
    @Autowired
    private BidderMappingService eventBidderMapService;
    @Autowired
    private TenderService tenderFormService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private FormService biddingFormService;
    
    @RequestMapping(value = "/buyer/biddermapping/{tenderId}", method = RequestMethod.GET)
    public String bidderMapping(@PathVariable("tenderId") int tenderId, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            modelMap.addAttribute("lstMappedBidders", tenderCommonService.getTenderMappedBidderDetails(tenderId, 1));
            int tenderMode = (Integer) tenderCommonService.getTenderField(tenderId, "tenderMode");
            TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
            modelMap.addAttribute("isAuction",tblTender.getisAuction());
            modelMap.addAttribute("mappingType", tenderMode);
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        	
        }
        return "/etender/buyer/MapBidder";
    }

    /**
     *
     * @param txtSearchString
     * @param txtSearchOpt
     * @param txTenderId
     * @param txtRowId (Optional if MappingType=1)
     * @param txtMappingType (BidderMapping - 1,ItemwiseBidderMapping - 2, BidderwiseItemMapping - 3, UnMapBidderWithAllLine - 4)
     * @param txtCheckMappedBidder
     * @param request
     * @param modelMap
     * @return to view
     */
    @RequestMapping(value = "/buyer/searchunmappedbidder", method = RequestMethod.POST)
    public String retriveUnMappedBidder(@RequestBody String requestData,HttpServletRequest request, ModelMap modelMap) {
    	String txtSearchString = "";
    	int txtSearchOpt=0;
    	int txTenderId=0;
    	int txtMappingType=0;
    	int chkCategoryUser = 0;
       try {
    	   
    	   if(""!=requestData && requestData!=null) {
    		   txtSearchString=request.getParameter("txtSearchString");
    		   txtSearchOpt=Integer.parseInt(request.getParameter("txtSearchOpt"));
    		   txTenderId=Integer.parseInt(request.getParameter("hdTenderId"));
    		   txtMappingType=Integer.parseInt(request.getParameter("txtMappingType"));
    		   chkCategoryUser=Integer.parseInt(request.getParameter("chkCategoryUser"));

    	   }
        	if(txtSearchString.contains("%26")){
        		txtSearchString=txtSearchString.replaceAll("%26", "&");
        	}
        	if(txtSearchString.contains("%40")){
        		txtSearchString=txtSearchString.replaceAll("%40", "@");
        	}
            if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
                if (eventBidderMapService.isTenderBiddermapped(txTenderId, txtSearchString, txtMappingType,  0 ,0)) {
                    modelMap.addAttribute("isBidderMapped", true);
                }
                modelMap.addAttribute("lstUnmappedBidder", eventBidderMapService.getUnmappedBidder(txtSearchString, txTenderId, txtMappingType, txtSearchOpt, 0,chkCategoryUser));
                modelMap.addAttribute("mappingtype", txtMappingType);
            } else {
                modelMap.addAttribute("sessionExpired", true);
            }
        } catch (Exception e) {
            exceptionHandlerService.writeLog(e);
        } finally {
        }
        return "etender/buyer/MapBidderSearchResult";
    }

        /**
     *
     * @param tenderMapBidderDataBean
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/buyer/mapbidder", method = RequestMethod.POST)
    public String mapBidders(@ModelAttribute TenderMapBidderDataBean tenderMapBidderDataBean, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String redirect = "";
        try {
            if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
                List<TblTenderBidderMap> lstTenderBidderMap = new ArrayList<TblTenderBidderMap>();
                int tenderMode = (Integer) tenderCommonService.getTenderField(tenderMapBidderDataBean.getHdTenderId(), "tenderMode");
                boolean isValid = true;
                StringBuilder mappingPair = new StringBuilder();
                if (tenderMapBidderDataBean.getChkBidderId() != null && tenderMapBidderDataBean.getChkBidderId().length > 0) {
                    if (tenderMapBidderDataBean.getHdMappingType() == 2 || tenderMapBidderDataBean.getHdMappingType() == 3) {
                        if (tenderMode == 3 || tenderMode == 4) {
                            if (tenderMapBidderDataBean.getChkBidderId().length > 1 || eventBidderMapService.isSingleBidderMapped(tenderMapBidderDataBean.getHdTenderId())) {
                                redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), "msg_tender_err_biddermul_mapping_nt_allowed");
                                redirect ="redirect:/etender/buyer/biddermapping/"+tenderMapBidderDataBean.getHdTenderId();
                                isValid = false;
                            }
                        }
                        if (isValid) {
                            prepareMapBidderDTO(tenderMapBidderDataBean, lstTenderBidderMap,mappingPair, request, tenderMapBidderDataBean.getHdMappingType());
                                if (eventBidderMapService.addAllTenderBidderMap(lstTenderBidderMap, tenderMapBidderDataBean.getHdMappingType())) {
                                    redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_tender_biddersmapped_success");
                                    redirect ="redirect:/etender/buyer/biddermapping/"+tenderMapBidderDataBean.getHdTenderId();
                                } else {
                                	redirect ="redirect:/etender/buyer/biddermapping/"+tenderMapBidderDataBean.getHdTenderId();
                                    redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), CommonKeywords.ERROR_MSG_KEY.toString());
                                }
                        }
                    } 
                }
            }else {
            	redirect ="redirect:/notloggedin";
            }
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        }
        return redirect;
    }
    /**
     *
     * @param tenderMapBidderDataBean
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/buyer/removemappedbidder", method = RequestMethod.POST)
    public String removeMappedBidders(@ModelAttribute TenderMapBidderDataBean tenderMapBidderDataBean, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String redirect = "redirect:/notloggedin";
        try {
            if (request.getSession().getAttribute(CommonKeywords.SESSION_OBJ.toString()) != null) {
                StringBuilder objId = new StringBuilder();
                StringBuilder rejObjId = new StringBuilder();
                StringBuilder mapBddersIds=new StringBuilder();
                if (tenderMapBidderDataBean.getChkMapBidderId() != null && tenderMapBidderDataBean.getChkMapBidderId().length > 0) {
                    for (String chkMapBidderId : tenderMapBidderDataBean.getChkMapBidderId()) {
                        objId.append("'").append(chkMapBidderId.split("_")[2]).append("'");
                        objId.append(",");
                        if (tenderMapBidderDataBean.getHdMappingType()==2 || tenderMapBidderDataBean.getHdMappingType()==4){
//                        	if(tenderCommonService.isEventLive(tenderMapBidderDataBean.getHdTenderId())==1 && !tenderCommonService.isBidderAcceptTermsCondition(tenderMapBidderDataBean.getHdTenderId(), Integer.parseInt(chkMapBidderId.split("_")[3]))){
//                        	mapBddersIds.append("'").append(chkMapBidderId.split("_")[4]).append("'");
//                            mapBddersIds.append(",");
//                        	}else if(tenderCommonService.isEventLive(tenderMapBidderDataBean.getHdTenderId())!=1){
//                        		mapBddersIds.append("'").append(chkMapBidderId.split("_")[4]).append("'");
//                                mapBddersIds.append(",");
//                        	}else{
//                        		compSet.add(commonService.getField("TblCompany", "companyName", "companyId", Integer.parseInt(chkMapBidderId.split("_")[3].toString())));
//                        	}
//                        	if(tenderCommonService.isBidderAcceptTermsCondition(tenderMapBidderDataBean.getHdTenderId(), Integer.parseInt(chkMapBidderId.split("_")[3]))){
//                        		redirectAttributes.addFlashAttribute("bidderAcceptedTerms", "bidder_has_accepted_term_cond");
//                        	}
                        }else if(tenderMapBidderDataBean.getHdMappingType()==3){
//                        	if(tenderCommonService.isEventLive(tenderMapBidderDataBean.getHdTenderId())==1 && !tenderCommonService.isBidderAcceptTermsCondition(tenderMapBidderDataBean.getHdTenderId(), Integer.parseInt(chkMapBidderId.split("_")[3]))){
//                        	mapBddersIds.append("'").append(chkMapBidderId.split("_")[5]).append("'");
//                            mapBddersIds.append(",");
//                        	}else if(tenderCommonService.isEventLive(tenderMapBidderDataBean.getHdTenderId())!=1){
//                        		mapBddersIds.append("'").append(chkMapBidderId.split("_")[5]).append("'");
//                                mapBddersIds.append(",");
//                        	}else{
//                        		compSet.add(commonService.getField("TblCompany", "companyName", "companyId", Integer.parseInt(chkMapBidderId.split("_")[3].toString())));
//                        	}
//                        	if(tenderCommonService.isBidderAcceptTermsCondition(tenderMapBidderDataBean.getHdTenderId(), Integer.parseInt(chkMapBidderId.split("_")[3]))){
//                        		redirectAttributes.addFlashAttribute("bidderAcceptedTerms", "bidder_has_accepted_term_cond");
//                        	}
                        	
                        }
                    }

//                    List<Object> lstFinalSubmissionCompany = eventBidderMapService.getFinalSubmissionCompanyDtls(tenderMapBidderDataBean.getHdTenderId(),objId.toString().substring(0, objId.length() - 1));
                    List<Object> lstFinalSubmissionCompany =  null;
                    objId.delete(0, objId.length());
                    prepareUnMapBidderDTO(tenderMapBidderDataBean, request, lstFinalSubmissionCompany, objId, rejObjId, 0,redirectAttributes);
                    int delCount = eventBidderMapService.removeMappedBidders(objId.length() > 1 ? objId.toString().substring(0, objId.length() - 1) : "''",
                            tenderMapBidderDataBean.getHdMappingType(),mapBddersIds.length() > 1 ? mapBddersIds.toString().substring(0, mapBddersIds.length() - 1) : "''");
                    if (delCount > 0) {
                        redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_tender_bidderunmap_success");
                        redirect ="redirect:/etender/buyer/biddermapping/"+tenderMapBidderDataBean.getHdTenderId();
                    }
                }
            }
        } catch (Exception e) {
           return exceptionHandlerService.writeLog(e);
        } finally {
        }
        return redirect;
    }
    
    /**
     *
     * @param tenderId
     * @param isWorkFlow
     * @param request
     * @param modelMap
     * @return to view
     */
    @RequestMapping(value = "/buyer/viewmappedbidders/{tenderId}", method = RequestMethod.GET)
    public String viewMappedBidders(@PathVariable("tenderId") int tenderId, HttpServletRequest request, ModelMap modelMap) {
        try {
            tenderCommonService.tenderSummary(tenderId, new HashMap<String, Object>());
            Date submissionEndDate=(Date)modelMap.get("endDateOfsubmission");
            Date currentDate= commonService.getServerDateTime();
            if(submissionEndDate!=null){
            	modelMap.addAttribute("isTenderArchive", (currentDate.after(submissionEndDate)));
            }
            TblTender tblTender=biddingFormService.BiddingTypeFromTender(tenderId);
            modelMap.addAttribute("isAuction", tblTender.getisAuction());
            modelMap.addAttribute("lstMappedBidders", tenderCommonService.getTenderMappedBidderDetails(tenderId,1));
        } catch (Exception e) {
            return exceptionHandlerService.writeLog(e);
        } finally {
        }
        return "/etender/buyer/ViewMappedBidders";
    }

//    
//
//
//
    /**
    *
    * @param mapBidderDB
    * @param lstTenderBidderMap
    * @param lstTenderMapBidderHistory
    * @param lstItemBidderMap
    * @param mappingPair
    * @param request
    * @param params
    * @throws Exception
    */
   private void prepareMapBidderDTO(TenderMapBidderDataBean mapBidderDB, List<TblTenderBidderMap> lstTenderBidderMap,
           StringBuilder mappingPair, HttpServletRequest request, int... params) throws Exception {
       int userDetailId = 1;
       String ipAddress = request.getHeader("X-FORWARDED-FOR") != null ? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
       List<Object[]> mappedBidderLst = null;
       int bidderId=0;
       TblTenderBidderMap tblTenderBidderMap =null;
       mappedBidderLst = eventBidderMapService.getTenderBidderMap(mapBidderDB.getHdTenderId());
       for (String chkBidderId : mapBidderDB.getChkBidderId()) {
    	   if(bidderId!= Integer.parseInt(chkBidderId.split("_")[1])){ 
    	   tblTenderBidderMap = new TblTenderBidderMap();
    	   }
            boolean isNew = true;
           int mapBidderId = 0;
           if (params[0] == 1 || (mappedBidderLst == null && mappedBidderLst.isEmpty())) {
        	   tblTenderBidderMap.setTblTender(new TblTender(mapBidderDB.getHdTenderId()));
               tblTenderBidderMap.setTblUserLogin(new TblUserLogin(Integer.parseInt(chkBidderId.split("_")[0])));
               tblTenderBidderMap.setTblBidder(new TblBidder(Integer.parseInt(chkBidderId.split("_")[1])));
               tblTenderBidderMap.setIpAddress(ipAddress);
               tblTenderBidderMap.setCreatedBy(userDetailId);
               tblTenderBidderMap.setCreatedOn(new Date());
           } else {
               for (Object[] objects : mappedBidderLst) {
            	   if(Integer.parseInt(chkBidderId.split("_")[1]) == (Integer) objects[1]){
                       mapBidderId = (Integer) objects[1];
                       isNew = false;
                       break;
            	   }
               }
               if (isNew) {
                   tblTenderBidderMap.setTblTender(new TblTender(mapBidderDB.getHdTenderId()));
                   tblTenderBidderMap.setTblUserLogin(new TblUserLogin(Integer.parseInt(chkBidderId.split("_")[0])));
                   tblTenderBidderMap.setTblBidder(new TblBidder(Integer.parseInt(chkBidderId.split("_")[1])));
                   tblTenderBidderMap.setIpAddress(ipAddress);
                   tblTenderBidderMap.setCreatedBy(userDetailId);
                   tblTenderBidderMap.setCreatedOn(new Date());
               }
           }
           
           if (params[0] == 1) {
               mappingPair.append("(").append(chkBidderId.split("_")[1])
                       .append(")").append(",");
           }
           if (isNew) {
               if (lstTenderBidderMap != null && !lstTenderBidderMap.contains(tblTenderBidderMap)) {
                   lstTenderBidderMap.add(tblTenderBidderMap);
               }
           }
           bidderId=Integer.parseInt(chkBidderId.split("_")[1]);
       }
   }
   
   
   private void prepareUnMapBidderDTO(TenderMapBidderDataBean tenderMapBidderDataBean, HttpServletRequest request, List<Object> lstFinalSubmissionCompany, StringBuilder objId,
           StringBuilder rejObjId, int rowId,RedirectAttributes redirectAttributes) throws Exception {
       for (String chkMapBidderId : tenderMapBidderDataBean.getChkMapBidderId()) {
//           if (!lstFinalSubmissionCompany.isEmpty() && lstFinalSubmissionCompany.contains(Integer.parseInt(chkMapBidderId.split("_")[2]))) {
//               rejObjId.append("'").append(chkMapBidderId.split("_")[3]).append("'")
//                       .append(",");
//           } else {
//           	if(tenderCommonService.isEventLive(tenderMapBidderDataBean.getHdTenderId()) && !tenderCommonService.isBidderAcceptTermsCondition(tenderMapBidderDataBean.getHdTenderId(), Integer.parseInt(chkMapBidderId.split("_")[3]))){
//               objId.append("'").append(chkMapBidderId.split("_")[0]).append("'")
//                       .append(",");
//           	}else if(tenderCommonService.isEventLive(tenderMapBidderDataBean.getHdTenderId())){
           		 objId.append("'").append(chkMapBidderId.split("_")[2]).append("'")
                   .append(",");
//           	}
//       }
      }     
           
   }

   
   //      @RequestMapping(value="/buyer/sendbiddermail/{tenderId}/{isWorkFlow}/{userId}/{enc}",method= RequestMethod.GET)
//    public String sendBidderMail(@PathVariable("tenderId") int tenderId,@PathVariable("isWorkFlow") int isWorkFlow, @PathVariable("userId") int userId,HttpServletRequest request,RedirectAttributes redirectAttributes){
//            boolean isSuccess = false;
//        try {
//            int brdMode = 0;
//            auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), linkSendBidderMail, getSendBidderMail, tenderId, userId);
//            ClientBean clientBean = (ClientBean) request.getSession().getAttribute(CommonKeywords.CLIENT_OBJ.toString());
//            MessageConfigDatabean messageConfigDatabean = new MessageConfigDatabean();
//            messageConfigDatabean.setQueueName(queueName);
//            messageConfigDatabean.setTemplateId(Integer.parseInt(sendBidderMailTemplateId));
//            messageConfigDatabean.setUserId(userId);
//            messageConfigDatabean.setObjectId(tenderId);
//            messageConfigDatabean.setUrlStr(request.getRequestURL().toString());
//            messageConfigDatabean.setContextPath(request.getContextPath());
//            isSuccess = messageQueueService.sendMessage(messageConfigDatabean);
//            brdMode = (Integer) tenderCommonService.getTenderField(tenderId, "brdMode");
//            if(brdMode == 1) {
//                        			request.getRequestURL().toString (), request.getContextPath().toString(),false,clientBean.getTimeZoneAbbr(),userId );
//            }
//            if(isSuccess) {
//                redirectAttributes.addFlashAttribute(CommonKeywords.SUCCESS_MSG.toString(), "msg_mail_success");
//            } else {
//                redirectAttributes.addFlashAttribute(CommonKeywords.ERROR_MSG.toString(), CommonKeywords.ERROR_MSG_KEY.toString());
//            }
////            mailContentUtillity.dynamicMailGeneration(sendBidderMailTemplateId, String.valueOf(userId), String.valueOf(tenderId), null, "");
//        } catch (Exception ex) {
//            exceptionHandlerService.writeLog(ex);
//        } finally {
//            if(isSuccess) {
//                auditTrailService.makeAuditTrail(request.getAttribute(CommonKeywords.AUDIT_BEAN.toString()), linkSendBidderMail, postSendBidderMail, tenderId, userId);
//            }
//        }
//        return "redirect:/etender/buyer/viewmappedbidders/"+tenderId+"/"+isWorkFlow+encryptDecryptUtils.generateRedirect("etender/buyer/viewmappedbidders/"+tenderId+"/"+isWorkFlow, request);
//    }
       
}
